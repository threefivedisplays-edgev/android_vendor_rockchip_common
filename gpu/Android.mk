LOCAL_PATH := $(call my-dir)
# $(info 'in MaliT860.mk')
# $(info TARGET_BOARD_PLATFORM_GPU:$(TARGET_BOARD_PLATFORM_GPU) )
# $(info TARGET_ARCH:$(TARGET_ARCH) )

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)), mali-t860)
include $(CLEAR_VARS)
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE := libGLES_mali
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MULTILIB := both
LOCAL_SRC_FILES_$(TARGET_ARCH) := MaliT860/lib/$(TARGET_ARCH)/libGLES_mali.so
LOCAL_SRC_FILES_$(TARGET_2ND_ARCH) := MaliT860/lib/$(TARGET_2ND_ARCH)/libGLES_mali.so
LOCAL_MODULE_PATH_32 := $(TARGET_OUT_VENDOR)/lib/egl
LOCAL_MODULE_PATH_64 := $(TARGET_OUT_VENDOR)/lib64/egl

# Create symlinks.
LOCAL_POST_INSTALL_CMD := \
	if [ -f $(LOCAL_MODULE_PATH_32)/libGLES_mali.so ];then cd $(TARGET_OUT_VENDOR)/lib; ln -sf egl/libGLES_mali.so libGLES_mali.so; cd -; fi; \
	if [ -f $(LOCAL_MODULE_PATH_64)/libGLES_mali.so ];then cd $(TARGET_OUT_VENDOR)/lib64; ln -sf egl/libGLES_mali.so libGLES_mali.so; cd -; fi; \
	mkdir -p $(TARGET_OUT_VENDOR)/lib/hw; cd $(TARGET_OUT_VENDOR)/lib/hw; ln -sf ../libGLES_mali.so vulkan.rk3399.so; cd -; \
	mkdir -p $(TARGET_OUT_VENDOR)/lib64/hw; cd $(TARGET_OUT_VENDOR)/lib64/hw; ln -sf ../libGLES_mali.so vulkan.rk3399.so; cd -; \
	cd $(TARGET_OUT_VENDOR)/lib64; \
	ln -sf egl/libGLES_mali.so libOpenCL.so.1.1; \
	ln -sf libOpenCL.so.1.1 libOpenCL.so.1; \
	ln -sf libOpenCL.so.1 libOpenCL.so; \
	cd -; \
	cd $(TARGET_OUT_VENDOR)/lib; \
	ln -sf egl/libGLES_mali.so libOpenCL.so.1.1; \
	ln -sf libOpenCL.so.1.1 libOpenCL.so.1; \
	ln -sf libOpenCL.so.1 libOpenCL.so; \
	cd -;

include $(BUILD_PREBUILT)
endif

# ---------- #

ifeq ($(strip $(TARGET_BOARD_PLATFORM_GPU)), mali-t760)
include $(CLEAR_VARS)
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE := libGLES_mali
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_SRC_FILES := MaliT760/lib/arm/rk3288/libGLES_mali.so
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/egl

# Create symlinks.
LOCAL_POST_INSTALL_CMD := \
	cd $(TARGET_OUT_VENDOR)/lib; \
	ln -sf egl/libGLES_mali.so libGLES_mali.so; \
	ln -sf egl/libGLES_mali.so libOpenCL.so.1.1; \
	ln -sf libOpenCL.so.1.1 libOpenCL.so.1; \
	ln -sf libOpenCL.so.1 libOpenCL.so; \
	ln -sf egl/libGLES_mali.so vulkan.rk3288.so; \
	rm egl/libGLES_mali.so; \
	cd -;
# .KP : "rm egl/libGLES_mali.so" : build 时, cp mali_so 到 vendor0/1, 总是在将 vendor/ 中的内容 cp 内容到 vendor0/1 "之前".
#			若这里不删除 vendor/ 中的 mali_so, 先前 cp 到 vendor1/ 中的 mali_so_for_3288w, 将被覆盖为 vendor/ 中的 mali_so_for_3288.

include $(BUILD_PREBUILT)
endif

# ---------- #

include $(LOCAL_PATH)/gpu_performance/Android.mk
