Return-Path: <linux-kernel+bounces-423394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4149DA6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809E5B24868
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6A1F6687;
	Wed, 27 Nov 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="qoST56TE"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E61F6669;
	Wed, 27 Nov 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706544; cv=none; b=fmvVl7kxFdXx8iMwDFOfw4d1qfLDtdzZOQhhCwK6DUcqRZ3KWjarrGFfwgVnJui5eE9gxR08ZsiZMo5FDi7U+Bwnjr7WIKjkQ1OCRGIicWmosYda38XxNcAkkP5bICF6W5kJH5lK0qs1OA7y3m6lldBimhxq68HaZdWocrunzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706544; c=relaxed/simple;
	bh=zEiZUjACrQWfRSlapuLJEAUtutVYrw5ngRhobUVxnp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUXyEzsWzAjVVqsB3gasjce9g/WPnJW7Q2zkZBb1P4Hr5K6C/P1Ngc1q3gOWYXw8Kx8CnlJ1vLK2odCcWYXYt5zcTokgXuR/eSE7Biz09id5Dm0HO4cFrPbbLbFHaUPMA4zF6JQM7pGsgst/qQcwwpH18txnQHgMBNn/1jOVR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=qoST56TE; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e59944.dip0.t-ipconnect.de [217.229.153.68])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 33EB72FC0055;
	Wed, 27 Nov 2024 12:22:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1732706538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwMOKSGoqDu0hvAYoT2nYLalIygD0uZv7LQUmpMIyl0=;
	b=qoST56TEkYj5pEcgXAz3vMb5lDHc4f+oA+EwnsqOP/fz+6dT+w6re+H0RgppjjYM6FInU8
	iM3XZkBKpMAaGme85kXGOtz+4xvFXUAFbQsleFSRNrih9PuR6cc0HsqHARsKboCOsoXA29
	8LB6QfXVFho5hydXQd93iWBP1VwW++c=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [RFC PATCH 1/1] platform: x86: tuxi: Implement TUXEDO TUXI ACPI TFAN as thermal subsystem
Date: Wed, 27 Nov 2024 12:21:10 +0100
Message-ID: <20241127112141.42920-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127112141.42920-1-wse@tuxedocomputers.com>
References: <20241127112141.42920-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
ACPI interface which currently consists of the TFAN device. This has ACPI
functions to control the built in fans and monitor fan speeds and CPU and
GPU temprature.

This driver implements this TFAN device via the thermal subsystem to allow
userspace controlled, but hardware safe, custom fan curves.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/tuxedo/Kbuild            |   6 +
 drivers/platform/x86/tuxedo/nbxx/Kbuild       |   8 +
 drivers/platform/x86/tuxedo/nbxx/Kconfig      |   9 +
 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c  |  96 +++++++
 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h  |  84 ++++++
 .../x86/tuxedo/nbxx/acpi_tuxi_thermal.c       | 241 ++++++++++++++++++
 .../x86/tuxedo/nbxx/acpi_tuxi_thermal.h       |  14 +
 8 files changed, 461 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b1429470674..1562dcd7ad9a5 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
 
 # SEL
 obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
+
+# TUXEDO
+obj-y					+= tuxedo/
diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
new file mode 100644
index 0000000000000..16396a8923432
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+obj-y	+= nbxx/
diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild b/drivers/platform/x86/tuxedo/nbxx/Kbuild
new file mode 100644
index 0000000000000..aa4d6d66b785f
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+tuxedo_nbxx_acpi_tuxi-y			:= acpi_tuxi.o
+tuxedo_nbxx_acpi_tuxi-y			+= acpi_tuxi_thermal.o
+obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)	+= tuxedo_nbxx_acpi_tuxi.o
diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig b/drivers/platform/x86/tuxedo/nbxx/Kconfig
new file mode 100644
index 0000000000000..93f7f86e803da
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+config TUXEDO_NBXX_ACPI_TUXI
+	tristate "TUXEDO TUXI"
+	help
+	  TUXEDO TUXI driver
diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
new file mode 100644
index 0000000000000..6031cf731b449
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
+ */
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include "acpi_tuxi_thermal.h"
+
+#include "acpi_tuxi.h"
+
+static int eval_intparams(acpi_handle handle, acpi_string pathname,
+			  unsigned long long *params, u32 params_count,
+			  unsigned long long *retval)
+{
+	struct acpi_object_list arguments;
+	unsigned long long data;
+	acpi_status status;
+
+	pr_debug("Eval %s\n", pathname);
+
+	if (params_count > 0) {
+		pr_debug("Params:\n");
+
+		arguments.count = params_count;
+		arguments.pointer = kzalloc(
+			params_count * sizeof(*arguments.pointer), GFP_KERNEL);
+		for (int i = 0; i < params_count; ++i) {
+			pr_debug("%llu\n", params[i]);
+
+			arguments.pointer[i].type = ACPI_TYPE_INTEGER;
+			arguments.pointer[i].integer.value = params[i];
+		}
+		status = acpi_evaluate_integer(handle, pathname, &arguments,
+					       &data);
+		kfree(arguments.pointer);
+	} else {
+		status = acpi_evaluate_integer(handle, pathname, NULL, &data);
+	}
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	if (retval)
+		*retval = data;
+
+	pr_debug("RetVal: %llu\n", *retval);
+
+	return 0;
+}
+
+static int add(struct acpi_device *device) {
+	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
+	acpi_status status;
+
+	driver_data = devm_kzalloc(&device->dev, sizeof(*driver_data),
+				   GFP_KERNEL);
+	if (!driver_data)
+		return -ENOMEM;
+
+	// Find subdevices
+	status = acpi_get_handle(device->handle, "TFAN",
+				 &driver_data->tfan_handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	driver_data->eval_intparams = &eval_intparams;
+
+	dev_set_drvdata(&device->dev, driver_data);
+
+	return tuxedo_nbxx_acpi_tuxi_thermal_add_devices(device);
+}
+
+static void remove(struct acpi_device *device) {
+	tuxedo_nbxx_acpi_tuxi_thermal_remove_devices(device);
+}
+
+static const struct acpi_device_id acpi_device_ids[] = {
+	{"TUXI0000", 0},
+	{"", 0}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
+
+static struct acpi_driver acpi_driver = {
+	.name = "tuxedo_nbxx_acpi_tuxi",
+	.ids = acpi_device_ids,
+	.ops = {
+		.add = add,
+		.remove = remove,
+	},
+};
+
+module_acpi_driver(acpi_driver);
+
+MODULE_DESCRIPTION("TUXEDO TUXI");
+MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
new file mode 100644
index 0000000000000..7ffda8e0dd68a
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
+ */
+
+#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_H__
+#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_H__
+
+#include <linux/thermal.h>
+#include <linux/acpi.h>
+
+/*
+ * Set fan speed target
+ *
+ * Set a specific fan speed (needs manual mode)
+ *
+ * Arg0: Fan index
+ * Arg1: Fan speed as a fraction of maximum speed (0-255)
+ */
+#define TUXI_TFAN_METHOD_SET_FAN_SPEED		"SSPD"
+
+/*
+ * Get fan speed target
+ *
+ * Arg0: Fan index
+ * Returns: Current fan speed target a fraction of maximum speed (0-255)
+ */
+#define TUXI_TFAN_METHOD_GET_FAN_SPEED		"GSPD"
+
+/*
+ * Get fans count
+ *
+ * Returns: Number of individually controllable fans
+ */
+#define TUXI_TFAN_METHOD_GET_FAN_COUNT		"GCNT"
+
+/*
+ * Set fans mode
+ *
+ * Arg0: 0 = auto, 1 = manual
+ */
+#define TUXI_TFAN_METHOD_SET_FAN_MODE		"SMOD"
+
+/*
+ * Get fans mode
+ *
+ * Returns: 0 = auto, 1 = manual
+ */
+#define TUXI_TFAN_METHOD_GET_FAN_MODE		"GMOD"
+
+/*
+ * Get fan type/what the fan is pointed at
+ *
+ * Arg0: Fan index
+ * Returns: 0 = general, 1 = CPU, 2 = GPU
+ */
+#define TUXI_TFAN_METHOD_GET_FAN_TYPE		"GTYP"
+
+/*
+ * Get fan temperature/temperature of what the fan is pointed at
+ *
+ * Arg0: Fan index
+ * Returns: Temperature sensor value in 10ths of degrees kelvin
+ */
+#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE	"GTMP"
+
+/*
+ * Get actual fan speed in RPM
+ *
+ * Arg0: Fan index
+ * Returns: Speed sensor value in revolutions per minute
+ */
+#define TUXI_TFAN_METHOD_GET_FAN_RPM		"GRPM"
+
+struct tuxedo_nbxx_acpi_tuxi_driver_data_t {
+	acpi_handle tfan_handle;
+	int (*eval_intparams)(acpi_handle, acpi_string,
+				  unsigned long long *, u32,
+				  unsigned long long *);
+	struct thermal_zone_device **tzdevs;
+	size_t tzdevs_count;
+};
+
+#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_H__
diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c
new file mode 100644
index 0000000000000..557e3fac15779
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
+ */
+
+#include <linux/thermal.h>
+#include <linux/minmax.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/acpi.h>
+#include "acpi_tuxi.h"
+
+#include "acpi_tuxi_thermal.h"
+
+static struct thermal_trip tzdtrips[] = {
+	{
+		.type		= THERMAL_TRIP_ACTIVE,
+		.temperature	= 80000,
+		.hysteresis	= 5000,
+	},
+	{
+		.type		= THERMAL_TRIP_ACTIVE,
+		.temperature	= 90000,
+		.hysteresis	= 5000,
+	},
+	{
+		.type		= THERMAL_TRIP_HOT,
+		.temperature	= 100000,
+		.hysteresis	= 5000,
+	},
+	{
+		.type		= THERMAL_TRIP_CRITICAL,
+		.temperature	= 110000,
+	},
+};
+
+struct tz_devdata_t {
+	struct acpi_device *parent;
+	struct thermal_cooling_device *cdev;
+	size_t index;
+};
+
+static bool should_bind(struct thermal_zone_device *tzdev,
+			const struct thermal_trip __always_unused *trip,
+			struct thermal_cooling_device *cdev,
+			struct cooling_spec __always_unused *cspec)
+{
+	return cdev->devdata == tzdev;
+}
+
+static int get_temp(struct thermal_zone_device *tzdev, int *temp)
+{
+	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
+	struct tz_devdata_t *tz_devdata;
+	unsigned long long data;
+	int ret;
+
+	tz_devdata = thermal_zone_device_priv(tzdev);
+	driver_data = dev_get_drvdata(&tz_devdata->parent->dev);
+
+	unsigned long long params[] = { tz_devdata->index };
+	ret = driver_data->eval_intparams(driver_data->tfan_handle,
+					  TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
+					  params, ARRAY_SIZE(params), &data);
+	if (ret)
+		return ret;
+
+	*temp = data * 100 - 272000;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tzdops = {
+	.should_bind = should_bind,
+	.get_temp = get_temp,
+};
+
+static struct thermal_zone_params tzdparams = {
+	.governor_name = "user_space",
+};
+
+static int get_max_state(struct thermal_cooling_device __always_unused *cdev,
+		  unsigned long *state)
+{
+	*state = 255;
+
+	return 0;
+}
+
+static int get_cur_state(struct thermal_cooling_device *cdev,
+			 unsigned long *state)
+{
+	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
+	struct thermal_zone_device *tzdev;
+	struct tz_devdata_t *tz_devdata;
+	unsigned long long data;
+	int ret;
+
+	tzdev = cdev->devdata;
+	tz_devdata = thermal_zone_device_priv(tzdev);
+	driver_data = dev_get_drvdata(&tz_devdata->parent->dev);
+
+	unsigned long long params[] = { tz_devdata->index };
+	ret = driver_data->eval_intparams(driver_data->tfan_handle,
+					  TUXI_TFAN_METHOD_GET_FAN_SPEED,
+					  params, ARRAY_SIZE(params), &data);
+	if (ret)
+		return ret;
+
+	*state = data;
+
+	return 0;
+}
+
+static int set_cur_state(struct thermal_cooling_device *cdev,
+			 unsigned long state) {
+	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
+	struct thermal_zone_device *tzdev;
+	struct tz_devdata_t *tz_devdata;
+	unsigned long long data;
+	int ret;
+
+	tzdev = cdev->devdata;
+	tz_devdata = thermal_zone_device_priv(tzdev);
+	driver_data = dev_get_drvdata(&tz_devdata->parent->dev);
+
+	unsigned long long params[] = { tz_devdata->index, state };
+	ret = driver_data->eval_intparams(driver_data->tfan_handle,
+					  TUXI_TFAN_METHOD_SET_FAN_SPEED,
+					  params, ARRAY_SIZE(params), &data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct thermal_cooling_device_ops tcdops = {
+	.get_max_state = get_max_state,
+	.get_cur_state = get_cur_state,
+	.set_cur_state = set_cur_state,
+};
+
+int tuxedo_nbxx_acpi_tuxi_thermal_add_devices(struct acpi_device *parent)
+{
+	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
+	struct tz_devdata_t *tz_devdata;
+	struct thermal_zone_device **tzdevs;
+	unsigned long long data;
+	size_t tzdevs_count;
+	char *type;
+	int ret;
+
+	driver_data = dev_get_drvdata(&parent->dev);
+
+	ret = driver_data->eval_intparams(driver_data->tfan_handle,
+					  TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL,
+					  0, &data);
+	if (ret)
+		return ret;
+
+	tzdevs_count = data;
+	tzdevs = devm_kzalloc(&parent->dev, tzdevs_count * sizeof(*tzdevs),
+			      GFP_KERNEL);
+	if (!tzdevs)
+			return -ENOMEM;
+
+	driver_data->tzdevs = tzdevs;
+	driver_data->tzdevs_count = tzdevs_count;
+
+	for (size_t i = 0; i < tzdevs_count; ++i) {
+		tz_devdata = devm_kzalloc(&parent->dev, sizeof(*tz_devdata),
+					  GFP_KERNEL);
+		if (!tz_devdata)
+			return -ENOMEM;
+
+		tz_devdata->parent = parent;
+		tz_devdata->index = i;
+
+		unsigned long long params[] = { i };
+		ret = driver_data->eval_intparams(driver_data->tfan_handle,
+						  TUXI_TFAN_METHOD_GET_FAN_TYPE,
+						  params, ARRAY_SIZE(params),
+						  &data);
+		if (ret)
+			return ret;
+
+		switch(data) {
+		case 0:
+			type = "tuxedo_general";
+			break;
+		case 1:
+			type = "tuxedo_cpu";
+			break;
+		case 2:
+			type = "tuxedo_gpu";
+			break;
+		default:
+			return -EIO;
+		}
+
+		tzdevs[i] = thermal_zone_device_register_with_trips(
+			type, tzdtrips, ARRAY_SIZE(tzdtrips), tz_devdata, &tzdops,
+			&tzdparams, 1000, 1000);
+		if (IS_ERR(tzdevs[i]))
+			return PTR_ERR(tzdevs[i]);
+
+		tz_devdata->cdev = thermal_cooling_device_register(type,
+								   tzdevs[i],
+								   &tcdops);
+		if (IS_ERR(tz_devdata->cdev))
+			return PTR_ERR(tz_devdata->cdev);
+	}
+
+	unsigned long long params[] = { 1 };
+	driver_data->eval_intparams(driver_data->tfan_handle,
+				    TUXI_TFAN_METHOD_SET_FAN_MODE,
+				    params, ARRAY_SIZE(params), &data);
+
+	return 0;
+}
+
+void tuxedo_nbxx_acpi_tuxi_thermal_remove_devices(struct acpi_device *parent) {
+	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
+	struct tz_devdata_t *tz_devdata;
+	unsigned long long data;
+
+	driver_data = dev_get_drvdata(&parent->dev);
+
+	unsigned long long params[] = { 0 };
+	driver_data->eval_intparams(driver_data->tfan_handle,
+				    TUXI_TFAN_METHOD_SET_FAN_MODE,
+				    params, ARRAY_SIZE(params), &data);
+
+	for (int i = 0; i < driver_data->tzdevs_count; ++i) {
+		tz_devdata = thermal_zone_device_priv(driver_data->tzdevs[i]);
+
+		thermal_cooling_device_unregister(tz_devdata->cdev);
+		thermal_zone_device_unregister(driver_data->tzdevs[i]);
+	}
+}
diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h
new file mode 100644
index 0000000000000..2193fa6db0ea1
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
+ */
+
+#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_THERMAL_H__
+#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_THERMAL_H__
+
+#include <linux/acpi.h>
+
+int tuxedo_nbxx_acpi_tuxi_thermal_add_devices(struct acpi_device *parent);
+void tuxedo_nbxx_acpi_tuxi_thermal_remove_devices(struct acpi_device *parent);
+
+#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_THERMAL_H__
-- 
2.43.0


