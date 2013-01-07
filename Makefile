VERSION = $(shell tail .VERSION)
FILENAME = headtrackr-$(VERSION)
MINFILENAME = $(addsuffix -min.js, $(FILENAME))
YUICOMP ?= $(shell which yuicompressor)
$$ := $

all : clean cat minify

mebe :
	@echo $(FILENAME)

cat :
	@echo "Collecting..."
	@mkdir -p build
	@cd src;\
	cat license.js\
		main.js\
		ccv.js\
		cascade.js\
		whitebalance.js\
		smoother.js\
		camshift.js\
		facetrackr.js\
		ui.js\
		headposition.js\
		controllers.js > ../build/$(FILENAME).js
	@echo "Done!"

minify :: ./build/$(FILENAME).js
	@echo "Minifying..."
	@cd build; \
	cat ../src/license.js > $(MINFILENAME); \
	echo "\
" >> $(MINFILENAME); \
	$(YUICOMP) -v --charset utf-8 --line-break 80 $(FILENAME).js 2> output.txt 1>> $(MINFILENAME)
	@echo "Done!"

clean :
	@echo "Removing:"
	@rm -rfv build | xargs -I FILE echo " > FILE"
	@mkdir -p build

#Then minify and add license.js at the top afterwards.
