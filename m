Return-Path: <linux-kernel+bounces-569086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5EA69E60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D808A6CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B41EE7B7;
	Thu, 20 Mar 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Wu6Qf8iV"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBE1EB5CA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438422; cv=none; b=Hnl+WDFJVO27nqCROysaSLLxLjcsswpjegZOUYQYLczWabTtuIixa2YOAJhogudJZKMYw4bKhAxtQ5osHkBiydRJbKqn3VEOOgbGjMU6IKRwQ33KUVKOVFqiVBJKumxII2sTQri1r6i9lgMeWURkv9ejC/peWOeMhOSV0T8s2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438422; c=relaxed/simple;
	bh=9+E3bHTinanH1s8MUHJq6zltLim+XQs80eZWFRW6BT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlEoLqptDzLpI1333ikay9T0OpHb36dmzmf23HdxF3PoL4/VFgjDMG3gXzBqz5FAO93QuAyryLtcchzS3v0LPpWEWjD3WDyflUTHRKZFc5yIKXIcCe+kWMt94vxvIz7KCI7JtyMzQw3zbfYzUeEtSl+3LN8Hv0BUw0u6feavBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Wu6Qf8iV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5675dec99so43503285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742438418; x=1743043218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynOsaVOaQFi/AXKciHVqgKzlBWbrXAaLPm4MY50kwhM=;
        b=Wu6Qf8iVMXQZBSFN6PEWOTEju+q2oIPXcm7WjULUWivKYB7uXg9mkeHpoophlMJI81
         MmnnbISTpJ/kGYRrwzfEWJN/uiww4NEd+GwexxrbbuxcJ9lviGYdAEOAlxMaIt1Mb1G+
         2OOwImCSxjPKA/Hj4uYvRPtswYuv5aGZ850tHpKgtd4zqwLFj9wFutD4RAeKqFZiODDL
         mLocRsFyYOpdnwrpoAq4HZAqfNCtCUsu3wuwp0lfArcIdYNIilqj7LVcyT818PnaO3QM
         eyJ02v74C1kKMRQbEJRp1TvtP0VjzKAIVfjOuCHfm1eDewQJHKVX2EXZeAHWRlaJvlBf
         pm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742438418; x=1743043218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynOsaVOaQFi/AXKciHVqgKzlBWbrXAaLPm4MY50kwhM=;
        b=G+ZdcnCdgwL3Azo7c+OBOl2Q/xAPEWYg/gcWY0ZuSjxM8KWS19T8HcGoeeCh6oh2Gj
         EeWI0cs6LX5VeHCjZ4zbcenZ3jlp7so1dhKNnz7JvVGRshvsNHfCW+F9ZXwU8ZpD2clJ
         5M9AJQJoKoN9M+7DTPkjV3epIGeCKdqWy6+wl4yjOirMn50pJoNTyzgLueVTU+t+AeFQ
         o3ZiU/IwM5FayYND1tcAD4SUaTeDKBTVrR4P3Xev3PA0staIivFlHfirlWT7l3W2Q9BY
         Y3VgO9ts0y1ie182U7ntgn6/ZpwX392fSBe/o/uit6T1DsOmsPbe0A/aQnj1TCGUkha9
         qlwg==
X-Forwarded-Encrypted: i=1; AJvYcCVnZPJ3Fb3Lxf724Y0beirc0pSycuuRSu5I6Ed0gGHOp+KfJv2SeBGERX4gnO1svTuP5jGc3ygZTl9eGEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Gb4ayf82G0U/1KtOTtHXXAtz2G0OOy1O4WL7I0Ve4rvxwNTH
	isXt03acZOn1MllMRw/Rau1eYr9XiidN97U+xv1RLf9RrwCGzkypkJNtj0M55fI=
X-Gm-Gg: ASbGncsJUXJHOQl7wH51+pHI+Vk4u7Y/e573EcgwK4rUreE881fZ7YXIX5x1HKOvMly
	m8zEK4q1zQeDtzILgceQ3fEat8GjEMULE/WXxTxvd9Y2EGhc34Gni4D17YDUKiuuYtWt2PsR9Oy
	8faYHJ2+t26Wk7HdKNgcUFrGZbRTBvY0BiSVISliwCR6OdsyXKoJKFU5gD8R/kO2ArfVyw48NlB
	yGUYq+9pGw/MDBn39flpEqYYanbcqTb6fHc/50yN1Q5yK6K3i8e5U1oAhyd1/AiQcfQmZY/WNZN
	fWJCN8jSyJF78ChOiQ1iZsSq5zqqPzVb/+KKgCEEC+HnYhl6QHv1kGvpT2WTyJFm/Zck3HtKD1o
	Ua5QkyGy5oJc8KIJTHpwjIYyFMBTnFZqA
X-Google-Smtp-Source: AGHT+IEJ2UJXPT+t+NVQjQQQ9sNsL2zYu+8obd/VfE+eIaPnWjnFZH5iTp3YAslKxGWWLRPc5uywMA==
X-Received: by 2002:a05:620a:371a:b0:7c5:65ab:4ff5 with SMTP id af79cd13be357-7c5b0d07bcemr259941585a.45.1742438417993;
        Wed, 19 Mar 2025 19:40:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (249.60.48.34.bc.googleusercontent.com. [34.48.60.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd9fsm947815985a.4.2025.03.19.19.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:40:17 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: changyuanl@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	jgowans@amazon.com,
	jgg@nvidia.com
Subject: [RFC v1 2/3] luo: dev_liveupdate: Add device live update infrastructure
Date: Thu, 20 Mar 2025 02:40:10 +0000
Message-ID: <20250320024011.2995837-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subsystem within the driver core to enable keeping
devices alive during kernel live update. This infrastructure is
designed to be registered with and driven by a separate Live Update
Orchestrator, allowing the LUO's state machine to manage the save and
restore process of device state during a kernel transition.

The goal is to allow drivers and buses to participate in a coordinated
save and restore process orchestrated by a live update mechanism. By
saving device state before the kernel switch and restoring it
immediately after, the device can appear to remain continuously
operational from the perspective of the system and userspace.

components introduced:

- `struct dev_liveupdate`: Embedded in `struct device` to track the
  device's participation and state during a live update, including
  request status, preservation status, and dependency depth.

- `liveupdate()` callback: Added to `struct bus_type` and
  `struct device_driver`. This callback receives an enum
  `liveupdate_event` to manage device state at different stages of the
  live update process:
    - LIVEUPDATE_PREPARE: Save device state before the kernel switch.
    - LIVEUPDATE_REBOOT: Final actions just before the kernel jump.
    - LIVEUPDATE_FINISH: Clean-up after live update.
    - LIVEUPDATE_CANCEL: Clean up any saved state if the update is
      aborted.

- Sysfs attribute "liveupdate/requested": Added under each device
  directory, allowing user to request that a specific device to
  participate in live update. I.e. its state is to be preserved
  during the update.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/driver-api/index.rst      |   1 +
 Documentation/driver-api/liveupdate.rst |  23 +
 MAINTAINERS                             |   3 +
 drivers/base/Makefile                   |   1 +
 drivers/base/core.c                     |  25 +-
 drivers/base/dev_liveupdate.c           | 816 ++++++++++++++++++++++++
 include/linux/dev_liveupdate.h          | 109 ++++
 include/linux/device.h                  |   6 +
 include/linux/device/bus.h              |   4 +
 include/linux/device/driver.h           |   4 +
 10 files changed, 984 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/liveupdate.rst
 create mode 100644 drivers/base/dev_liveupdate.c
 create mode 100644 include/linux/dev_liveupdate.h

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 16e2c4ec3c01..70df19321f58 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -25,6 +25,7 @@ of interest to most developers working on device drivers.
    infrastructure
    ioctl
    pm/index
+   liveupdate
 
 Useful support libraries
 ========================
diff --git a/Documentation/driver-api/liveupdate.rst b/Documentation/driver-api/liveupdate.rst
new file mode 100644
index 000000000000..3afa6173a536
--- /dev/null
+++ b/Documentation/driver-api/liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Device Live Update
+==================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+dev_liveupdate
+==============
+.. kernel-doc:: drivers/base/dev_liveupdate.c
+   :doc: Device Live Update
+
+Public API
+==========
+.. kernel-doc:: include/linux/dev_liveupdate.h
+
+.. kernel-doc:: drivers/base/dev_liveupdate.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: drivers/base/dev_liveupdate.c
+   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index 32257bde9647..81f8c2881e60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13487,6 +13487,9 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
 F:	Documentation/admin-guide/liveupdate.rst
+F:	Documentation/driver-api/liveupdate.rst
+F:	drivers/base/dev_liveupdate.c
+F:	include/linux/dev_liveupdate.h
 F:	include/linux/liveupdate.h
 F:	kernel/Kconfig.liveupdate
 F:	kernel/liveupdate.c
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..58939921e5e1 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 obj-$(CONFIG_ACPI) += physical_location.o
+obj-$(CONFIG_LIVEUPDATE) += dev_liveupdate.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2fde698430df..21b5dfa0f70c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3151,6 +3151,7 @@ void device_initialize(struct device *dev)
 	dev->dma_coherent = dma_default_coherent;
 #endif
 	swiotlb_dev_init(dev);
+	dev_liveupdate_init(dev);
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
@@ -3627,6 +3628,7 @@ int device_add(struct device *dev)
 	if (error)
 		goto DPMError;
 	device_pm_add(dev);
+	dev_liveupdate_add_device(dev);
 
 	if (MAJOR(dev->devt)) {
 		error = device_create_file(dev, &dev_attr_dev);
@@ -4740,6 +4742,10 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	if (error)
 		goto out;
 
+	error = dev_liveupdate_sysfs_change_owner(dev, kuid, kgid);
+	if (error)
+		goto out;
+
 	/*
 	 * Change the owner of the symlink located in the class directory of
 	 * the device class associated with @dev which points to the actual
@@ -4810,14 +4816,17 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
+
+		if (!dev_liveupdate_preserved(dev)) {
+			if (dev->bus && dev->bus->shutdown) {
+				if (initcall_debug)
+					dev_info(dev, "shutdown\n");
+				dev->bus->shutdown(dev);
+			} else if (dev->driver && dev->driver->shutdown) {
+				if (initcall_debug)
+					dev_info(dev, "shutdown\n");
+				dev->driver->shutdown(dev);
+			}
 		}
 
 		device_unlock(dev);
diff --git a/drivers/base/dev_liveupdate.c b/drivers/base/dev_liveupdate.c
new file mode 100644
index 000000000000..7e961d2cd3b1
--- /dev/null
+++ b/drivers/base/dev_liveupdate.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Device Live Update
+ *
+ * Provides infrastructure for preserving device state across a system update.
+ *
+ * This subsystem allows drivers and buses to save and restore device state,
+ * enabling a seamless transition during a live update.
+ *
+ * The core idea is to identify a set of devices whose state needs to be
+ * preserved. For each such device, the associated driver and bus can implement
+ * callbacks to save the device's state before the update and restore it
+ * afterwards.
+ *
+ * Userspace can interact with this subsystem via sysfs attributes exposed
+ * under each device directory (e.g., ``/sys/devices/.../liveupdate/``).
+ * This directory contains the following attributes:
+ *
+ * ``requested``
+ *   A read-write attribute allowing userspace to control whether a device
+ *   should participate in the live update sequence. Writing "1" requests the
+ *   device and its ancestors (that support live update) be preserved.
+ *   Writing "0" requests the device be excluded. This attribute can only be
+ *   modified when LUO is in the ``normal`` state.
+ * ``preserved``
+ *   A read-only attribute indicating whether the device's state was
+ *   preserved during the ``prepare`` and ``reboot`` stages.
+ * ``reclaimed``
+ *   A read-only attribute indicating whether the device was successfully
+ *   re-attached and resumed operation in the new kernel after an update.
+ *   For example, a VM to which this device was passthrough has been resumed.
+ *
+ * By default, devices do not participate in the live update. Userspace can
+ * explicitly request participation by writing "1" to the ``requested`` file.
+ *
+ * The live update process typically involves the following stages,
+ * reflected in the ``liveupdate_event`` enum:
+ *
+ * ``LIVEUPDATE_PREPARE``
+ *   Prepare devices for the upcoming state transition. Drivers and buses should
+ *   save the necessary device state. Happens before blackouts.
+ * ``LIVEUPDATE_REBOOT``
+ *   A final notification before the system jumps to the new kernel. Called
+ *   during blackout from reboot() syscall.
+ * ``LIVEUPDATE_FINISH``
+ *   The system has completed a transition. Drivers and buses should have
+ *   already restored the previously saved state. Clean up, reset unreclaimed
+ *   devices.
+ * ``LIVEUPDATE_CANCEL``
+ *   Cancel the live update process. Drivers and buses should clean up any saved
+ *   state if necessary.
+ *
+ * Documentation/admin-guide/liveupdate.rst contains more details.
+ *
+ * The global state of the live update subsystem can be accessed and
+ * controlled via a separate sysfs interface (e.g., ``/sys/kernel/liveupdate/``)
+ * via Live Update Orchestrator.
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/dev_liveupdate.h>
+#include <linux/list_sort.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "base.h"
+
+static const char liveupdate_group_name[] = "liveupdate";
+
+/**
+ * is_liveupdate_possible() - Check if a device can participate in live update
+ * @dev: The device to check.
+ *
+ * This function verifies if the given device and all its ancestors (up to
+ * the root device or until a missing callback is found) are capable of
+ * participating in a live update.
+ *
+ * It checks for the presence of the ``liveupdate`` callback in the device's
+ * driver and bus, and performs the same check for all parent devices. If any
+ * device in the hierarchy (including the device itself)
+ * lacks a ``liveupdate`` callback in either its driver or bus, the function
+ * returns false.
+ *
+ * Return: True if the device and all its relevant ancestors have the
+ * liveupdate callback, false otherwise.
+ */
+static bool is_liveupdate_possible(struct device *dev)
+{
+	struct device *parent_dev;
+	bool is_possible = true;
+
+	dev = get_device(dev);
+	for (; ;) {
+		if (dev->driver) {
+			is_possible = !!dev->driver->liveupdate;
+			if (!is_possible) {
+				dev_warn(dev, "driver[%s] no liveupdate callback\n",
+					 dev->driver->name);
+				break;
+			}
+		}
+
+		if (dev->bus) {
+			is_possible = !!dev->bus->liveupdate;
+			if (!is_possible) {
+				dev_warn(dev, "bus[%s] no liveupdate callback\n",
+					 dev->bus->name);
+				break;
+			}
+		}
+
+		if (!dev->parent)
+			break;
+
+		parent_dev = get_device(dev->parent);
+		put_device(dev);
+		dev = parent_dev;
+	}
+	put_device(dev);
+
+	return is_possible;
+}
+
+/*
+ * dev->{driver, bus}->liveupdate->{prepare, reboot} callback
+ * Warn if liveupdate not present, this is an internal error, and should never
+ * be the case.
+ * return callback result, or 0 if callback is not implemented.
+ */
+#define DEV_LIVEUPDATE_RET_CALLBACK(_dev, _drv_or_bus, _func) ({	\
+	int rv = 0;							\
+									\
+	if ((_dev)->_drv_or_bus &&					\
+	    !WARN_ON(!(_dev)->_drv_or_bus->liveupdate) &&		\
+	    (_dev)->_drv_or_bus->liveupdate->_func) {			\
+		rv = (_dev)->_drv_or_bus->liveupdate->_func(_dev);	\
+	}								\
+	rv;								\
+})
+
+/*
+ * A void variant of the previous macro
+ * dev->{driver, bus}->liveupdate->{cancel, finish} callback
+ * Warn if liveupdate not present, this is an internal error, and should never
+ * be the case.
+ */
+#define DEV_LIVEUPDATE_CALLBACK(_dev, _drv_or_bus, _func) do {		\
+	if ((_dev)->_drv_or_bus &&					\
+	    !WARN_ON(!(_dev)->_drv_or_bus->liveupdate) &&		\
+	    (_dev)->_drv_or_bus->liveupdate->_func) {			\
+		(_dev)->_drv_or_bus->liveupdate->_func(_dev);		\
+	}								\
+} while (0)
+
+static ssize_t preserved_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_liveupdate_preserved(dev));
+}
+static DEVICE_ATTR_RO(preserved);
+
+static ssize_t reclaimed_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_liveupdate_reclaimed(dev));
+}
+static DEVICE_ATTR_RO(reclaimed);
+
+static ssize_t requested_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_liveupdate_requested(dev));
+}
+
+/**
+ * requested_store() - Store function for the ``requested`` sysfs attribute
+ * @dev: The device associated with the attribute.
+ * @attr: The device attribute structure.
+ * @buf: The buffer containing the value written by the user.
+ * @count: The number of bytes written.
+ *
+ * Allows userspace to request that a device be included in or excluded from
+ * the live update process. Writing "1" requests the device to be preserved
+ * during live update, and writing "0" requests it to be excluded.
+ *
+ * This function checks if the live update system is in the 'normal' state
+ * before allowing changes. It also verifies that the device supports
+ * live update before setting the requested state.
+ *
+ * Return: The number of bytes written on success, ``-EINVAL`` if the input is
+ * invalid or if the live update system is not in the 'normal' state, or
+ * ``-EAGAIN`` if the operation was interrupted.
+ */
+static ssize_t requested_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	long val;
+
+	if (kstrtol(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val != 1 && val != 0)
+		return -EINVAL;
+
+	/* if state does not change, ignore */
+	if (dev_liveupdate_requested(dev) == !!val)
+		return count;
+
+	if (liveupdate_read_state_enter_killable()) {
+		dev_warn(dev, "Changing requested state Canceled by user\n");
+		return -EAGAIN;
+	}
+
+	if (!liveupdate_state_normal()) {
+		dev_warn(dev, "Participation can be requested only in [normal] state\n");
+		liveupdate_read_state_exit();
+		return -EINVAL;
+	}
+
+	if (!val) {
+		dev_liveupdate_set_requested(dev, false);
+		list_del_init(&dev->lu.liveupdate_entry);
+		liveupdate_read_state_exit();
+		return count;
+	}
+
+	if (!is_liveupdate_possible(dev)) {
+		liveupdate_read_state_exit();
+		return -EINVAL;
+	}
+
+	dev_liveupdate_set_requested(dev, true);
+	liveupdate_read_state_exit();
+
+	return count;
+}
+static DEVICE_ATTR_RW(requested);
+
+static struct attribute *liveupdate_attrs[] = {
+	&dev_attr_preserved.attr,
+	&dev_attr_reclaimed.attr,
+	&dev_attr_requested.attr,
+	NULL,
+};
+
+static const struct attribute_group liveupdate_attr_group = {
+	.name	= liveupdate_group_name,
+	.attrs	= liveupdate_attrs,
+};
+
+static int dev_liveupdate_sysfs_add(struct device *dev)
+{
+	int rv;
+
+	rv = sysfs_create_group(&dev->kobj, &liveupdate_attr_group);
+
+	return rv;
+}
+
+static int dev_liveupdate_get_depth(struct device *current_dev)
+{
+	struct device *dev;
+	int depth = 0;
+
+	for (dev = current_dev; dev; dev = dev->parent)
+		depth++;
+
+	return depth;
+}
+
+/**
+ * LIST_HEAD(dev_liveupdate_preserve_list) - List of devices to preserve during
+ * live update
+ * @dev_liveupdate_preserve_list: This section is about this list.
+ *
+ * This list holds devices that need to have their state preserved across a
+ * live update. It is populated during the ``LIVEUPDATE_PREPARE`` stage by
+ * dev_liveupdate_build_preserve_list() with devices explicitly requested
+ * for live update and their ancestors. The list is sorted by device depth
+ * to ensure correct processing order: children before parents.
+ *
+ * Functions like __dev_liveupdate_reboot_prepare() iterate through this list
+ * to notify drivers and buses about the upcoming update or reboot.
+ * __dev_liveupdate_cancel() uses this list to perform cancellation.
+ * The list is cleared by dev_liveupdate_destroy_preserve_list() when it's
+ * no longer needed.
+ *
+ * The list is protected by ``luo_state_rwsem`` as it is used only during
+ * prepare and reboot callbacks when this lock is taken as writer.
+ */
+static LIST_HEAD(dev_liveupdate_preserve_list);
+
+/**
+ * __find_ancestors_and_depth() - Add a device and its ancestors to the preserve
+ * list
+ * @current_dev: The device to start with.
+ *
+ * This function adds the @current_dev and all its ancestors to the
+ * dev_liveupdate_preserve_list. It also calculates and sets the
+ * liveupdate_depth for each device added, relative to the @current_dev.
+ *
+ * The function iterates from @current_dev up to the root device. For each
+ * device in the path, if it's not already in the preserve list (checked via
+ * the liveupdate_depth field), it's added to the list, its depth is set,
+ * and a reference is taken using get_device() (unless it's the initial
+ * @current_dev, which already has a reference).
+ *
+ * The list to which the devices are added (dev_liveupdate_preserve_list) is
+ * expected to be sorted later.
+ */
+static void __find_ancestors_and_depth(struct device *current_dev)
+{
+	struct device *dev;
+	int depth = 0;
+
+	/*
+	 * If depth is set, it means this devices was already included as an
+	 * ancestor of another requested device.
+	 */
+	if (current_dev->lu.liveupdate_depth)
+		return;
+
+	depth = dev_liveupdate_get_depth(dev);
+
+	for (dev = current_dev; dev; dev = dev->parent) {
+		/*
+		 * This ancestor, and all above are already in the
+		 * dev_liveupdate_preserve_list
+		 */
+		if (dev->lu.liveupdate_depth)
+			break;
+
+		if (dev != current_dev)
+			get_device(dev);
+
+		/* Ancestor might be in the request_list */
+		list_del_init(&dev->lu.liveupdate_entry);
+		dev->lu.liveupdate_depth = depth;
+		list_add_tail(&dev->lu.liveupdate_entry,
+			      &dev_liveupdate_preserve_list);
+		depth--;
+	}
+}
+
+static int dev_depth_cmp(void *priv,
+			 const struct list_head *head_a,
+			 const struct list_head *head_b)
+{
+	struct device *dev_a, *dev_b;
+
+	dev_a = container_of(head_a, struct device, lu.liveupdate_entry);
+	dev_b = container_of(head_b, struct device, lu.liveupdate_entry);
+
+	if (dev_a->lu.liveupdate_depth > dev_b->lu.liveupdate_depth)
+		return -1;
+
+	if (dev_a->lu.liveupdate_depth < dev_b->lu.liveupdate_depth)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * dev_liveupdate_build_preserve_list() - Build a list of devices to preserve
+ *
+ * This function constructs a list ``dev_liveupdate_preserve_list`` of devices
+ * that require state preservation during a live update.
+ *
+ * It first iterates through all devices and identifies those for which a live
+ * update has been explicitly requested using dev_liveupdate_requested().
+ * These devices are added to a temporary list.
+ *
+ * Then, for each device in the temporary list, the function calls
+ * __find_ancestors_and_depth() to add the device and all its ancestors to the
+ * global ``dev_liveupdate_preserve_list`` and calculate their respective
+ * depths.
+ *
+ * Finally, the ``dev_liveupdate_preserve_list`` is sorted by device depth using
+ * dev_depth_cmp() to ensure a correct preservation order (e.g., children before
+ * parents). A reference count is maintained for each device added to the
+ * preserve list using get_device().
+ */
+static void dev_liveupdate_build_preserve_list(void)
+{
+	LIST_HEAD(request_list);
+	struct device *dev;
+
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_entry(dev, &devices_kset->list, kobj.entry) {
+		get_device(dev);
+		spin_unlock(&devices_kset->list_lock);
+		if (dev_liveupdate_requested(dev)) {
+			list_add_tail(&dev->lu.liveupdate_entry,
+				      &request_list);
+		} else {
+			put_device(dev);
+		}
+		spin_lock(&devices_kset->list_lock);
+	}
+	spin_unlock(&devices_kset->list_lock);
+
+	while (!list_empty(&request_list)) {
+		dev = list_first_entry(&request_list,
+				       struct device,
+				       lu.liveupdate_entry);
+		list_del_init(&dev->lu.liveupdate_entry);
+		__find_ancestors_and_depth(dev);
+	}
+
+	list_sort(NULL, &dev_liveupdate_preserve_list, dev_depth_cmp);
+}
+
+/**
+ * dev_liveupdate_destroy_preserve_list() - Destroy the live update preserve
+ * list
+ *
+ * This function iterates through the ``dev_liveupdate_preserve_list``, which
+ * contains devices ordered by depth, and performs cleanup for each device.
+ * For each device in the list, it:
+ *
+ * 1. Removes the device from the list and reinitializes its list head.
+ * 2. Resets the liveupdate_depth field to 0.
+ * 3. Calls put_device() to decrement the device's reference count.
+ *
+ * This function is typically called after the preserve list is no longer
+ * needed, such as after the reboot phase of a live update or during
+ * cancellation.
+ */
+static void dev_liveupdate_destroy_preserve_list(void)
+{
+	struct device *dev;
+
+	while (!list_empty(&dev_liveupdate_preserve_list)) {
+		dev = list_first_entry(&dev_liveupdate_preserve_list,
+				       struct device,
+				       lu.liveupdate_entry);
+		list_del_init(&dev->lu.liveupdate_entry);
+		dev->lu.liveupdate_depth = 0;
+		put_device(dev);
+	}
+}
+
+/**
+ * __dev_liveupdate_cancel() - Cancel live update for devices
+ * @dev: The device from which to start the cancellation (or NULL to cancel
+ * all).
+ *
+ * This function cancels the ongoing live update process for devices starting
+ * from the position just before the given @dev in the
+ * ``dev_liveupdate_preserve_list`` and proceeding backwards to the beginning of
+ * the list. If @dev is ``NULL``, the cancellation is performed for all devices
+ * in the list.
+ *
+ * It iterates through the relevant devices in reverse order, calling the
+ * ``LIVEUPDATE_CANCEL`` handler for each device's bus and driver (if
+ * available). After processing the devices, it clears the liveupdate_preserved
+ * flag for each device and finally destroys the
+ * ``dev_liveupdate_preserve_list``.
+ */
+static void __dev_liveupdate_cancel(struct device *dev)
+{
+	dev = list_prepare_entry(dev, &dev_liveupdate_preserve_list,
+				 lu.liveupdate_entry);
+
+	list_for_each_entry_continue_reverse(dev, &dev_liveupdate_preserve_list,
+					     lu.liveupdate_entry) {
+		DEV_LIVEUPDATE_CALLBACK(dev, bus, cancel);
+		DEV_LIVEUPDATE_CALLBACK(dev, driver, cancel);
+
+		dev->lu.liveupdate_preserved = false;
+	}
+
+	dev_liveupdate_destroy_preserve_list();
+}
+
+/**
+ * __dev_liveupdate_reboot_prepare() - Notify drivers and buses of a
+ * prepare/reboot event
+ * @event: The live update event, either ``LIVEUPDATE_PREPARE`` or
+ * ``LIVEUPDATE_REBOOT``.
+ *
+ * This function iterates through the list of devices to be preserved
+ * (``dev_liveupdate_preserve_list``) and calls the liveupdate() callback for
+ * the driver and bus of each device with the specified event.
+ *
+ * If a driver or bus  callback returns an error, a warning is logged,
+ * and the function attempts to cancel the live update for the remaining devices
+ * using __dev_liveupdate_cancel().
+ *
+ * Upon successful completion for a device, the ``liveupdate_preserved`` flag
+ * for that device is set to true.
+ *
+ * Return: 0 on success, or the error code from the failing driver/bus
+ * liveupdate->{prepare, reboot} callback.
+ */
+static int __dev_liveupdate_reboot_prepare(enum liveupdate_event event)
+{
+	struct device *dev;
+	int rv;
+
+	rv = 0;
+	list_for_each_entry(dev, &dev_liveupdate_preserve_list,
+			    lu.liveupdate_entry) {
+		if (event == LIVEUPDATE_PREPARE)
+			rv = DEV_LIVEUPDATE_RET_CALLBACK(dev, driver, prepare);
+		else
+			rv = DEV_LIVEUPDATE_RET_CALLBACK(dev, driver, reboot);
+
+		if (rv) {
+			dev_warn(dev, "driver live update failed\n");
+			goto err_cancel;
+		}
+
+		if (event == LIVEUPDATE_PREPARE)
+			rv = DEV_LIVEUPDATE_RET_CALLBACK(dev, bus, prepare);
+		else
+			rv = DEV_LIVEUPDATE_RET_CALLBACK(dev, bus, reboot);
+
+		if (rv) {
+			dev_warn(dev, "bus live update failed\n");
+			goto err_cancel_bus;
+		}
+
+		dev->lu.liveupdate_preserved = true;
+	}
+
+	return 0;
+
+err_cancel_bus:
+	DEV_LIVEUPDATE_CALLBACK(dev, driver, cancel);
+
+err_cancel:
+	__dev_liveupdate_cancel(dev);
+
+	return rv;
+}
+
+/**
+ * device_liveupdate_prepare() - Prepare devices for a live update
+ *
+ * This function is called as part of the ``LIVEUPDATE_PREPARE`` stage.
+ * It first calls dev_liveupdate_build_preserve_list() to construct a list
+ * of devices that need their state preserved during the update.
+ * Then, it calls the internal function __dev_liveupdate_reboot_prepare()
+ * with the ``LIVEUPDATE_PREPARE`` event to notify drivers and buses to prepare
+ * for the upcoming update.
+ *
+ * Return: The return value from __dev_liveupdate_reboot_prepare().
+ */
+static int device_liveupdate_prepare(void)
+{
+	dev_liveupdate_build_preserve_list();
+
+	return __dev_liveupdate_reboot_prepare(LIVEUPDATE_PREPARE);
+}
+
+/**
+ * device_liveupdate_reboot() - Prepare devices for the reboot stage of a live
+ * update
+ *
+ * This function is called as part of the ``LIVEUPDATE_REBOOT`` stage, from
+ * reboot() syscall. It calls the internal function
+ * __dev_liveupdate_reboot_prepare() with the LIVEUPDATE_REBOOT event to notify
+ * drivers and buses to perform any actions needed before the reboot.  If the
+ * reboot preparation is successful (returns 0), it then calls
+ * dev_liveupdate_destroy_preserve_list() to free the list of devices that was
+ * built during the prepare stage.
+ *
+ * Return: The return value from __dev_liveupdate_reboot_prepare().
+ */
+static int device_liveupdate_reboot(void)
+{
+	int rv;
+
+	rv = __dev_liveupdate_reboot_prepare(LIVEUPDATE_REBOOT);
+	if (!rv)
+		dev_liveupdate_destroy_preserve_list();
+
+	return rv;
+}
+
+/**
+ * device_liveupdate_finish() - Finalize the device live update process
+ *
+ * This function is called as part of the ``LIVEUPDATE_FINISH`` stage. It
+ * iterates through all registered devices, identifies devices that were
+ * preserved during the prepare phase, sorts them by depth.
+ *
+ * After sorting, the function iterates through the list. For each device, it
+ * logs a warning about unreclaimed device and call the
+ * ``{driver, bus}->liveupdate->finish()`` handler for ever device's driver and
+ * bus on the list. Finally, it resets the live update related fields in the
+ * device's ``dev_liveupdate`` structure, effectively removing it from the live
+ * update tracking.
+ *
+ * Note: this function must not fail.
+ *
+ * Return: Always returns 0.
+ */
+static int device_liveupdate_finish(void)
+{
+	LIST_HEAD(preserved_list);
+	struct device *dev;
+
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_entry(dev, &devices_kset->list, kobj.entry) {
+		get_device(dev);
+		spin_unlock(&devices_kset->list_lock);
+		if (!dev_liveupdate_preserved(dev)) {
+			put_device(dev);
+			spin_lock(&devices_kset->list_lock);
+			continue;
+		}
+
+		list_add_tail(&dev->lu.liveupdate_entry, &preserved_list);
+		dev->lu.liveupdate_depth = dev_liveupdate_get_depth(dev);
+		spin_lock(&devices_kset->list_lock);
+	}
+	spin_unlock(&devices_kset->list_lock);
+
+	list_sort(NULL, &preserved_list, dev_depth_cmp);
+
+	while (!list_empty(&preserved_list)) {
+		dev = list_first_entry(&preserved_list, struct device,
+				       lu.liveupdate_entry);
+
+		if (!dev_liveupdate_reclaimed(dev))
+			dev_warn(dev, "Device was not reclaimed during live update\n");
+
+		DEV_LIVEUPDATE_CALLBACK(dev, driver, finish);
+		DEV_LIVEUPDATE_CALLBACK(dev, bus, finish);
+
+		/* Reset live update fields to their default values */
+		list_del_init(&dev->lu.liveupdate_entry);
+		dev->lu.liveupdate_reclaimed = false;
+		dev->lu.liveupdate_preserved = false;
+		dev->lu.liveupdate_depth = 0;
+		put_device(dev);
+	}
+
+	return 0;
+}
+
+/**
+ * device_liveupdate_cancel() - Cancel the ongoing device live update process
+ *
+ * This function is called as part of the ``LIVEUPDATE_CANCEL`` stage. It
+ * initiates the cancellation of the live update process by calling the
+ * internal function __dev_liveupdate_cancel() with a NULL argument,
+ * indicating a global cancellation.
+ *
+ * Note: this function must not fail.
+ *
+ * Return: Always returns 0.
+ */
+static int device_liveupdate_cancel(void)
+{
+	__dev_liveupdate_cancel(NULL);
+
+	return 0;
+}
+
+LIVEUPDATE_DECLARE_NOTIFIER(device, LIVEUPDATE_CB_PRIO_WITH_DEVICES);
+
+/**
+ * dev_liveupdate_startup() - Register device live update notifier
+ *
+ * This function is called during the late initialization phase of the kernel.
+ * It registers a notifier for devices subsystem with live update orchestrator.
+ *
+ * If registration fails, a warning message is printed to the kernel log.
+ *
+ * Return: 0 on success (notifier registration is void, so only failure
+ * is explicitly handled).
+ */
+static int __init dev_liveupdate_startup(void)
+{
+	int rv;
+
+	rv = LIVEUPDATE_REGISTER_NOTIFIER(device);
+	if (rv) {
+		pr_warn("Failed to register devices with live update orchestrator [%d]\n",
+			rv);
+	}
+
+	return 0;
+}
+late_initcall(dev_liveupdate_startup);
+
+/* Public Interfaces */
+
+/**
+ * dev_liveupdate_init() - Initialize the dev_liveupdate structure
+ * @dev: Pointer to the dev_liveupdate structure to initialize.
+ *
+ * This function initializes the fields of the dev_liveupdate structure
+ * to their default states. The list head is initialized, and the
+ * boolean flags are cleared. The depth is initialized to 0.
+ */
+void dev_liveupdate_init(struct device *dev)
+{
+	INIT_LIST_HEAD(&dev->lu.liveupdate_entry);
+	dev->lu.liveupdate_requested = false;
+	dev->lu.liveupdate_preserved = false;
+	dev->lu.liveupdate_reclaimed = false;
+	dev->lu.liveupdate_depth = 0;
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_init);
+
+/**
+ * dev_liveupdate_add_device() - Add live update sysfs interface to a new device
+ * @dev: The device to add to the live update system.
+ *
+ * This function checks if live update functionality is enabled. If it is,
+ * it attempts to add the live update sysfs interface for the given device.
+ * If the sysfs group creation fails, a warning message is logged.
+ */
+void dev_liveupdate_add_device(struct device *dev)
+{
+	if (!liveupdate_enabled())
+		return;
+
+	if (dev_liveupdate_sysfs_add(dev))
+		dev_warn(dev, "Failed to create liveupdate sysfs group\n");
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_add_device);
+
+/**
+ * dev_liveupdate_sysfs_change_owner() - Change the owner of the liveupdate
+ * sysfs group
+ * @dev: The device whose liveupdate sysfs group owner is to be changed.
+ * @kuid: The user ID for the new owner.
+ * @kgid: The group ID for the new owner.
+ *
+ * This function changes the ownership of the sysfs attribute group associated
+ * with the live update interface for the given device. It uses the
+ * sysfs_group_change_owner() function to update the owner to the specified
+ * user ID (@kuid) and group ID (@kgid).
+ *
+ * Return: 0 on success, or a negative error code returned by
+ * sysfs_group_change_owner().
+ */
+int dev_liveupdate_sysfs_change_owner(struct device *dev,
+				      kuid_t kuid,
+				      kgid_t kgid)
+{
+	return sysfs_group_change_owner(&dev->kobj, &liveupdate_attr_group,
+					kuid, kgid);
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_sysfs_change_owner);
+
+/**
+ * dev_liveupdate_preserved() - Check if a device's live update state is
+ * preserved
+ * @dev: The device to check.
+ *
+ * Returns: true if the device's live update state has been preserved,
+ * false otherwise.
+ */
+bool dev_liveupdate_preserved(struct device *dev)
+{
+	return dev->lu.liveupdate_preserved;
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_preserved);
+
+/**
+ * dev_liveupdate_reclaimed() - Check if a device was reclaimed after live
+ * update
+ * @dev: The device to check.
+ *
+ * Returns: true if the device has been reclaimed, false otherwise.
+ */
+bool dev_liveupdate_reclaimed(struct device *dev)
+{
+	return dev->lu.liveupdate_reclaimed;
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_reclaimed);
+
+/**
+ * dev_liveupdate_requested() - Check if a live update has been requested for
+ * the device
+ * @dev: The device to check.
+ *
+ * Returns: true if a live update has been requested for the device (i.e.
+ * device and its ancestors are going to participate in live update), false
+ * otherwise.
+ */
+bool dev_liveupdate_requested(struct device *dev)
+{
+	return dev->lu.liveupdate_requested;
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_requested);
+
+/**
+ * dev_liveupdate_set_requested() - Set the live update requested state for a
+ * device
+ * @dev: The device to modify.
+ * @val: The boolean value to set the requested state to (true or false).
+ *
+ * Sets the ``liveupdate_requested`` flag for the given device to the
+ * specified value.
+ */
+void dev_liveupdate_set_requested(struct device *dev, bool val)
+{
+	dev->lu.liveupdate_requested = val;
+}
+EXPORT_SYMBOL_GPL(dev_liveupdate_set_requested);
diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupdate.h
new file mode 100644
index 000000000000..caf38e16ba91
--- /dev/null
+++ b/include/linux/dev_liveupdate.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef _LINUX_DEV_LIVEUPDATE_H
+#define _LINUX_DEV_LIVEUPDATE_H
+
+#include <linux/liveupdate.h>
+
+#ifdef CONFIG_LIVEUPDATE
+
+/**
+ * struct dev_liveupdate - Device state for live update operations
+ * @liveupdate_entry:     List head for linking the device into live update
+ *                        related lists (e.g., a list of devices participating
+ *                        in a live update sequence).
+ * @liveupdate_requested: Set if a live update has been requested for this
+ *                        device (i.e. device will participate in live update).
+ * @liveupdate_preserved: Set if the device's state has been successfully
+ *                        preserved during a live update prepare phase.
+ * @liveupdate_reclaimed: Set if resources or state associated with a
+ *                        previous live update attempt have been reclaimed.
+ *                        Device has been re-attached to previous work and
+ *                        resumed its operation.
+ * @liveupdate_depth:     The hierarchical depth of the device, used for
+ *                        ordering live update operations. Lower values
+ *                        indicate devices closer to the root.
+ *
+ * This structure holds the state information required for performing
+ * live update operations on a device. It is embedded within a struct device.
+ */
+struct dev_liveupdate {
+	struct list_head liveupdate_entry;
+	bool liveupdate_requested:1;
+	bool liveupdate_preserved:1;
+	bool liveupdate_reclaimed:1;
+	int liveupdate_depth:28;
+};
+
+/**
+ * struct dev_liveupdate_cbs - Live Update callback functions
+ * @prepare:     Prepare device for the upcoming state transition. Driver and
+ *               buse should save the necessary device state. Happens before
+ *               blackouts.
+ * @reboot:      A final notification before the system jumps to the new kernel.
+ *               Called during blackout from reboot() syscall.
+ * @finish:      The system has completed a transition. Drivers and buses should
+ *               have already restored the previously saved device state.
+ *               Clean-up any saved state or reset unreclaimed device.
+ * @cancel:      Cancel the live update process. Driver should clean
+ *               up any saved state if necessary.
+ *
+ * This structure is used by drivers and buses to hold the callback from LUO.
+ */
+struct dev_liveupdate_cbs {
+	int (*prepare)(struct device *dev);
+	int (*reboot)(struct device *dev);
+	void (*finish)(struct device *dev);
+	void (*cancel)(struct device *dev);
+};
+
+void dev_liveupdate_init(struct device *dev);
+void dev_liveupdate_add_device(struct device *dev);
+int dev_liveupdate_sysfs_change_owner(struct device *dev,
+				      kuid_t kuid,
+				      kgid_t kgid);
+
+bool dev_liveupdate_preserved(struct device *dev);
+bool dev_liveupdate_reclaimed(struct device *dev);
+bool dev_liveupdate_requested(struct device *dev);
+void dev_liveupdate_set_requested(struct device *dev, bool val);
+
+#else /* CONFIG_LIVEUPDATE */
+
+static inline void dev_liveupdate_init(struct devie *dev);
+static inline void dev_liveupdate_add_device(struct device *dev) { }
+
+static inline int dev_liveupdate_sysfs_change_owner(struct device *dev,
+						    kuid_t kuid,
+						    kgid_t kgid)
+{
+	return 0;
+}
+
+static inline bool dev_liveupdate_preserved(struct device *dev)
+{
+	return false;
+}
+
+static inline bool dev_liveupdate_reclaimed(struct device *dev)
+{
+	return false;
+}
+
+static inline bool dev_liveupdate_requested(struct device *dev)
+{
+	return false;
+}
+
+static inline void dev_liveupdate_set_requested(struct device *dev, bool val)
+{
+}
+
+static inline void dev_liveupdate_set_reclaimed(struct device *dev);
+
+#endif /* CONFIG_LIVEUPDATE */
+#endif /* _LINUX_DEV_LIVEUPDATE_H */
diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..0b8cdc10e002 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/dev_liveupdate.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/atomic.h>
@@ -663,6 +664,7 @@ struct device_physical_location {
  * @pm_domain:	Provide callbacks that are executed during system suspend,
  * 		hibernation, system resume and during runtime PM transitions
  * 		along with subsystem-level and driver-level callbacks.
+ * @lu:		Live update state.
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
@@ -758,6 +760,10 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_LIVEUPDATE
+	struct dev_liveupdate	lu;
+#endif
+
 #ifdef CONFIG_ENERGY_MODEL
 	struct em_perf_domain	*em_pd;
 #endif
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f5a56efd2bd6..d05f12187d34 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -17,6 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/klist.h>
 #include <linux/pm.h>
+#include <linux/dev_liveupdate.h>
 
 struct device_driver;
 struct fwnode_handle;
@@ -63,6 +64,8 @@ struct fwnode_handle;
  *			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
+ * @liveupdate:	Live update callbacks, notify bus of the live update state, and
+ *		allow preseve device across reboot.
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
  *
@@ -103,6 +106,7 @@ struct bus_type {
 	void (*dma_cleanup)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
+	const struct dev_liveupdate_cbs *liveupdate;
 
 	bool need_parent_lock;
 };
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index cd8e0f0a634b..01ade77061fc 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/device/bus.h>
 #include <linux/module.h>
+#include <linux/dev_liveupdate.h>
 
 /**
  * enum probe_type - device driver probe type to try
@@ -80,6 +81,8 @@ enum probe_type {
  *		it is bound to the driver.
  * @pm:		Power management operations of the device which matched
  *		this driver.
+ * @liveupdate:	Live update callbacks, notify device of the live
+ *		update state, and allow preseve device across reboot.
  * @coredump:	Called when sysfs entry is written to. The device driver
  *		is expected to call the dev_coredump API resulting in a
  *		uevent.
@@ -116,6 +119,7 @@ struct device_driver {
 	const struct attribute_group **dev_groups;
 
 	const struct dev_pm_ops *pm;
+	const struct dev_liveupdate_cbs *liveupdate;
 	void (*coredump) (struct device *dev);
 
 	struct driver_private *p;
-- 
2.49.0.395.g12beb8f557-goog


