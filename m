Return-Path: <linux-kernel+bounces-569284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF4A6A0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16501896A24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296420ADF9;
	Thu, 20 Mar 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn8SJWi/"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB81E7C23;
	Thu, 20 Mar 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458162; cv=none; b=pF9745capocyfrZCeexTz8cxftYjyf8+AR8xlTQxXSE+4Z6IshP40AaKKaXr78E39a66Utp8Ks/e9TGnpVZeOwJZzeu3QS0w6+afPtdTTY+gk2VmUnG1G6YZ12Nt0eKrXrk5itsf2DgkeK+ZVu+K1J+EJRFTnA9r8gPeKCM8i4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458162; c=relaxed/simple;
	bh=7t/a/Ly3hmCKLq1v1+pm18l9G64r40/O1xdAmdKsOK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AZhJxSDacRGK8KjT47CTVw+EHdU0YIBfJmfo9YL7Qn/pA4UWN/ScQbFOkdu7/IVvreytvimPqnTWMpGXpLkWesZmXvUgHz57CA4NajXREdheqecwHhubD1uAEZ8HRPErfgQ9kg/kqfCswUlDi9+0Y3qFvHJeBwdRRNbl+nktbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn8SJWi/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3bf231660so75498485a.0;
        Thu, 20 Mar 2025 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458158; x=1743062958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4raPk+cocovze9r6ddO9c4dvYPC72uKQbHu5G6zIJMo=;
        b=Jn8SJWi/JU+/PTmxmNgeX1lVM2+7BMa8F0gibS9ypQK6ackUk3v7Lv8+/PdQ5tYkDE
         uOorkfDA29tloswwODf7eSRMje3wNNMePtqDmmV2wfwoj4SzSldnrNjTPKC33mOLu0Y8
         sUHj57iqPpRU5P+BW6qVbBOpnRDQb7VX//hI1xnMsjsbFmWxroIK2eTpU39z9xWywLXR
         K3R6tIVfpvLfBU9twT3ESSqxYi/VVd2VdCAwxp5cUecLqe+/ceNpZ3H+fnXdtVCmNW94
         hS0Q6Nlh8ouvYTzhc26ycAHdjo/2nN0Ipgjvpe3Ya0Vvg8iqnTBvkERJsSeXL5/3ehiK
         O65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458158; x=1743062958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4raPk+cocovze9r6ddO9c4dvYPC72uKQbHu5G6zIJMo=;
        b=Wx4tU/WVMbsqQ2J+uGACoen9pRWtNgkpj43aD57onwoRy+uXNrmQEM0PMgfFYbc/eA
         4JsMhWqknGwC56NusgfB+rn7C1ZziiDh88jJH/brZtn57CjfkmBs7CLb9G28WkJs5r22
         ciptKO2TTsHrJzUZl4KA7ziSn2Sz2mDFOFoXDD/STTqfqT5yCpopHr1Ua5OXNt0ZUz4J
         OYmC++94iChz+wrdbYb05/cGbm9xtrP2zWMkKZNFydvFNV5olWuc2Y6OgUi2BbJ/2BB6
         3qMfgH62yTlHV5Xa14rughoTQ5ZxZX7PkBtNg7Ytq+t36ERSQzMrpTVfkEOGpjMjbKpH
         L7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVmvL724RRAt0KD4Tl+yqOPRHRmJpAGCs+WseHlnC0LXSNrST4qAVNqs1SgFtHLgd58BhLZvWK/qcHB5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OoMZkSk1v1mmcWOC4D5R0Yeuf1DqJgWSLh8ENwP+WRdEe5rd
	EGF7CPmQQ0yGja3M0uroqMTHLidee4061NLOcTHgAc3WlZQRoAVrMZ4RnkRZI3M=
X-Gm-Gg: ASbGncuHMhd82HG9CFP4U698CGc4miaMXmlrhfB+KgnrMIV0yY5K+yX5lacZ/38cX3L
	za4aVnXs5357DLHSUwqiwQMXezwUYGHT9E/qUBCv117PVDXsdFlixCgy1UcafH/7EJ0gFMU/YLf
	emDanq7rn+AibjhHz+z5L8O8oWaBm4XjusxVpgG6ds38Xn76ktNd0R1GLklouefzy6faF6QKi8z
	c/MjMYPKKfkquadq+bWw4h5NPkT+D+zg+M0fn8MDnRC1zviqxtChf33ZJLbhWO9zZ2rc7eMosxL
	a5DxRzYOMpTYwSZ1P5tWBGIrh5eaErFN6QD+SIUk/Kwr17CfyyRERrvXJVLQR4fD6sY=
X-Google-Smtp-Source: AGHT+IGtRUBJAHskctrOiUWZ4nXkmJtE4cciC7zNUgP8RL3c7ICb6HYu03UV2YGF9kVBXqk/uWk2ZQ==
X-Received: by 2002:a05:620a:1aa0:b0:7c5:4caa:21a4 with SMTP id af79cd13be357-7c5a84bcf7bmr786863285a.55.1742458158219;
        Thu, 20 Mar 2025 01:09:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:4958:2802:9201:7d93:4881:2257:9364])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d72b62sm978729885a.86.2025.03.20.01.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:09:17 -0700 (PDT)
From: Shanmukh Iyer <shanmukh.iyer@gmail.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
Subject: [PATCH] Documentation: Fixed typos and grammar
Date: Thu, 20 Mar 2025 04:09:09 -0400
Message-Id: <20250320080909.115396-1-shanmukh.iyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shanmukh Iyer <shanmukh.iyer@polymtl.ca>

Signed-off-by: Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
---
 Documentation/arch/x86/cpuinfo.rst                          | 2 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml          | 2 +-
 Documentation/devicetree/bindings/trivial-devices.yaml      | 2 +-
 Documentation/devicetree/bindings/writing-schema.rst        | 2 +-
 Documentation/gpu/amdgpu/display/programming-model-dcn.rst  | 2 +-
 Documentation/gpu/amdgpu/process-isolation.rst              | 2 +-
 Documentation/hid/intel-thc-hid.rst                         | 6 +++---
 Documentation/mm/hwpoison.rst                               | 2 +-
 Documentation/power/suspend-and-cpuhotplug.rst              | 2 +-
 Documentation/sound/cards/emu-mixer.rst                     | 2 +-
 Documentation/sound/soc/machine.rst                         | 2 +-
 Documentation/trace/fprobe.rst                              | 2 +-
 Documentation/userspace-api/iommufd.rst                     | 4 ++--
 .../userspace-api/media/v4l/vidioc-subdev-g-routing.rst     | 2 +-
 Documentation/userspace-api/sysfs-platform_profile.rst      | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 6ef426a52cdc..37ec1b9793eb 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -12,7 +12,7 @@ represents an ill-fated attempt from long time ago to put feature flags
 in an easy to find place for userspace.
 
 However, the amount of feature flags is growing by the CPU generation,
-leading to unparseable and unwieldy /proc/cpuinfo.
+leading to unparsable and unwieldy /proc/cpuinfo.
 
 What is more, those feature flags do not even need to be in that file
 because userspace doesn't care about them - glibc et al already use
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 19bb1f324183..f28de8cd983a 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -160,7 +160,7 @@ properties:
       SOCTHERM hardware will assert the thermal trigger signal to the Power
       Management IC, which can be configured to reset or shutdown the device.
       It is an array of pairs where each pair represents a tsensor ID followed
-      by a temperature in milli Celcius. In the absence of this property the
+      by a temperature in milli Celsius. In the absence of this property the
       critical trip point will be used for thermtrip temperature.
 
       Note:
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8..b016722fa907 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -149,7 +149,7 @@ properties:
           - injoinic,ip5306
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
-            # Intel common redudant power supply crps185
+            # Intel common redundant power supply crps185
           - intel,crps185
             # Intersil ISL29028 Ambient Light and Proximity Sensor
           - isil,isl29028
diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index eb8ced400c7e..9a1080610397 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -53,7 +53,7 @@ description
   The default without any indicators is flowed, plain scalar style where single
   line breaks and leading whitespace are stripped. Paragraphs are delimited by
   blank lines (i.e. double line break). This style cannot contain ": " in it as
-  it will be interpretted as a key. Any " #" sequence will be interpretted as
+  it will be interpreted as a key. Any " #" sequence will be interpreted as
   a comment. There's other restrictions on characters as well. Most
   restrictions are on what the first character can be.
 
diff --git a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
index c1b48d49fb0b..bc7de97a746f 100644
--- a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
+++ b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
@@ -100,7 +100,7 @@ represents the connected display.
    For historical reasons, we used the name `dc_link`, which gives the
    wrong impression that this abstraction only deals with physical connections
    that the developer can easily manipulate. However, this also covers
-   conections like eDP or cases where the output is connected to other devices.
+   connections like eDP or cases where the output is connected to other devices.
 
 There are two structs that are not represented in the diagram since they were
 elaborated in the DCN overview page  (check the DCN block diagram :ref:`Display
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation/gpu/amdgpu/process-isolation.rst
index 6b6d70e357a7..c1297a9e4d09 100644
--- a/Documentation/gpu/amdgpu/process-isolation.rst
+++ b/Documentation/gpu/amdgpu/process-isolation.rst
@@ -26,7 +26,7 @@ Example of enabling enforce isolation on a GPU with multiple partitions:
     $ cat /sys/class/drm/card0/device/enforce_isolation
     1 0 1 0
 
-The output indicates that enforce isolation is enabled on zeroth and second parition and disabled on first and fourth parition.
+The output indicates that enforce isolation is enabled on zeroth and second partition and disabled on first and fourth partition.
 
 For devices with a single partition or those that do not support partitions, there will be only one element:
 
diff --git a/Documentation/hid/intel-thc-hid.rst b/Documentation/hid/intel-thc-hid.rst
index 6c417205ac6a..5e0dc51c8d20 100644
--- a/Documentation/hid/intel-thc-hid.rst
+++ b/Documentation/hid/intel-thc-hid.rst
@@ -182,7 +182,7 @@ value and use PIO write (by setting SubIP write opcode) to do a write operation.
 
 THC also includes two GPIO pins, one for interrupt and the other for device reset control.
 
-Interrupt line can be configured to either level triggerred or edge triggerred by setting MMIO
+Interrupt line can be configured to either level triggered or edge triggered by setting MMIO
 Control register.
 
 Reset line is controlled by BIOS (or EFI) through ACPI _RST method, driver needs to call this
@@ -302,9 +302,9 @@ waiting for interrupt ready then read out the data from system memory.
 3.3.2 Software DMA channel
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-THC supports a software triggerred RxDMA mode to read the touch data from touch IC. This SW RxDMA
+THC supports a software triggered RxDMA mode to read the touch data from touch IC. This SW RxDMA
 is the 3rd THC RxDMA engine with the similar functionalities as the existing two RxDMAs, the only
-difference is this SW RxDMA is triggerred by software, and RxDMA2 is triggerred by external Touch IC
+difference is this SW RxDMA is triggered by software, and RxDMA2 is triggered by external Touch IC
 interrupt. It gives a flexiblity to software driver to use RxDMA read Touch IC data in any time.
 
 Before software starts a SW RxDMA, it shall stop the 1st and 2nd RxDMA, clear PRD read/write pointer
diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
index 483b72aa7c11..dd02fae484dc 100644
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -17,7 +17,7 @@ To quote the overview comment::
 	hardware as being corrupted usually due to a 2bit ECC memory or cache
 	failure.
 
-	This focusses on pages detected as corrupted in the background.
+	This focuses on pages detected as corrupted in the background.
 	When the current CPU tries to consume corruption the currently
 	running process can just be killed directly instead. This implies
 	that if the error cannot be handled for some reason it's safe to
diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index ebedb6c75db9..641d09a6546b 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -13,7 +13,7 @@ infrastructure uses it internally? And where do they share common code?
 
 Well, a picture is worth a thousand words... So ASCII art follows :-)
 
-[This depicts the current design in the kernel, and focusses only on the
+[This depicts the current design in the kernel, and focuses only on the
 interactions involving the freezer and CPU hotplug and also tries to explain
 the locking involved. It outlines the notifications involved as well.
 But please note that here, only the call paths are illustrated, with the aim
diff --git a/Documentation/sound/cards/emu-mixer.rst b/Documentation/sound/cards/emu-mixer.rst
index d87a6338d3d8..edcedada4c96 100644
--- a/Documentation/sound/cards/emu-mixer.rst
+++ b/Documentation/sound/cards/emu-mixer.rst
@@ -66,7 +66,7 @@ FX-bus
 
 name='Clock Source',index=0
 ---------------------------
-This control allows switching the word clock between interally generated
+This control allows switching the word clock between internally generated
 44.1 or 48 kHz, or a number of external sources.
 
 Note: the sources for the 1616 CardBus card are unclear. Please report your
diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/machine.rst
index 9db132bc0070..94c69a3e26ca 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -75,7 +75,7 @@ In the above struct, dai’s are registered using names but you can pass
 either dai name or device tree node but not both. Also, names used here
 for cpu/codec/platform dais should be globally unique.
 
-Additionaly below example macro can be used to register cpu, codec and
+Additionally the below example macro can be used to register cpu, codec and
 platform dai::
 
   SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 71cd40472d36..d632073408d6 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -118,7 +118,7 @@ will be cancelled.
 @fregs
         This is the `ftrace_regs` data structure at the entry and exit. This
         includes the function parameters, or the return values. So user can
-        access thos values via appropriate `ftrace_regs_*` APIs.
+        access those values via appropriate `ftrace_regs_*` APIs.
 
 @entry_data
         This is a local storage to share the data between entry and exit handlers.
diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..67abc845dbfe 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -43,7 +43,7 @@ Following IOMMUFD objects are exposed to userspace:
 
 - IOMMUFD_OBJ_HWPT_PAGING, representing an actual hardware I/O page table
   (i.e. a single struct iommu_domain) managed by the iommu driver. "PAGING"
-  primarly indicates this type of HWPT should be linked to an IOAS. It also
+  primarily indicates this type of HWPT should be linked to an IOAS. It also
   indicates that it is backed by an iommu_domain with __IOMMU_DOMAIN_PAGING
   feature flag. This can be either an UNMANAGED stage-1 domain for a device
   running in the user space, or a nesting parent stage-2 domain for mappings
@@ -69,7 +69,7 @@ Following IOMMUFD objects are exposed to userspace:
 
   * Security namespace for guest owned ID, e.g. guest-controlled cache tags
   * Non-device-affiliated event reporting, e.g. invalidation queue errors
-  * Access to a sharable nesting parent pagetable across physical IOMMUs
+  * Access to a shareable nesting parent pagetable across physical IOMMUs
   * Virtualization of various platforms IDs, e.g. RIDs and others
   * Delivery of paravirtualized invalidation
   * Direct assigned invalidation queues
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
index 1cf795480602..6932e923c13d 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
@@ -67,7 +67,7 @@ subdevice routing table. This may be smaller or larger than the value of
 drivers may adjust the requested routing table.
 
 The kernel can return a ``num_routes`` value larger than ``len_routes`` from
-both ioctls. This indicates thare are more routes in the routing table than fits
+both ioctls. This indicates that there are more routes in the routing table than fit
 the ``routes`` array. In this case, the ``routes`` array is filled by the kernel
 with the first ``len_routes`` entries of the subdevice routing table. This is
 not considered to be an error, and the ioctl call succeeds. If the applications
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 7f013356118a..e6878ea82fda 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -44,7 +44,7 @@ added. Drivers which wish to introduce new profile names must:
 "Custom" profile support
 ========================
 The platform_profile class also supports profiles advertising a "custom"
-profile. This is intended to be set by drivers when the setttings in the
+profile. This is intended to be set by drivers when the settings in the
 driver have been modified in a way that a standard profile doesn't represent
 the current state.
 
-- 
2.34.1


