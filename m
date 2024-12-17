Return-Path: <linux-kernel+bounces-450049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191539F5A22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6749C16EA50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB91F9EA4;
	Tue, 17 Dec 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc/33SQl"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8861FA175;
	Tue, 17 Dec 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476817; cv=none; b=RtLJtRBoU2qzBHc7VSMZt6DIekfF+RWWhAtWN1zCkfvSP4bvqw9MKVmntWd4a/xAUsyUS6IqSBw3AtIMCKNMpP3OSqT9J3cu7MmSkvswuq3HG0IhEtDStHs9uC6CGt07gs9OuTK6bA2nXE18wsZCzXJ5Wf/sqVqUpsAtRIR0HHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476817; c=relaxed/simple;
	bh=abrfkDuWW90vA95lRpi0UFGLzUqmfwepIJJJevEw0S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT84rTAgDA2a7/NKAQ2VzUxENc55XaOQtgN/paBJjTnZWmmE8dB9Lsj5FC2ekhlBTkSFgJnZoooGDO6puIrOHlxDmqpd8Cx2jnEs7IhJ7EJ/3U9+rboGYL/fv3KD7HyiagPfBIRCxtkDVnRCOnSeC2mKG+fpyfzxChMp0eC8EvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc/33SQl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21634338cfdso70374065ad.2;
        Tue, 17 Dec 2024 15:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734476814; x=1735081614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsQu8HIz6xMO8V+YSzxzwAAfKMkfbbEr8zyelq58VUk=;
        b=Zc/33SQlTpTO6jVXULxB1Kk3dmS5llRevvKct0DSimwlzVJbC/xRAA9zEW7WhSov7E
         XVvrqhZZWg7kRnIh7JkPqZ5nV1Mg+MAlTP69fZ0CuuNo6BrmdILPFkTTO4okFT1pTmP8
         5q6pKJQLr61ljLTRghVZzV4lSMOUlzb5Xq8mi79wIc3W+UiIwOvwFr1kmjN1v7M8Fjwh
         0yc/xeAsH+COkXABtHEMxudpY9fsC8ZKe73V2DE/YBsPzMSMhyha/MT2UY3Bi17kb08s
         j9GIKLIe7y/+cROqp5Zmyadm/PW6jcTmT3NYjudwpf50TmxGzCWoAkfWbNcSUhvNdUsE
         YNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476814; x=1735081614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsQu8HIz6xMO8V+YSzxzwAAfKMkfbbEr8zyelq58VUk=;
        b=KozTUHUoUiGy8kKq306UCWPgiBwqxBOn9KJ8QbA/lj8bcSkv6GXlmO7K0STJVT4+eq
         335DsiiuT29I89ufeH/drVtKqxJfR/oSfO4AYHJez78WDfC0iacA068VMQYaOTLgs8BF
         Irm3RiCMSaVm6jm29twya4ALXIK9AYXaKgs9o8biWUjpF/G4RfHDa5HlVy7FRBkSg3ED
         RW08oowICMwH4SiV0BjJFjBn70c9hSIsUpmuUnJpSNH0MVrL9wy4zONhG0TZba1BBfDH
         x3cXaqYyG1XMge/kN91XP4YtVg3mH6n+r2rTE/1dkj990F9pBTRXCjJIwPIJOnbOpEN1
         wFgA==
X-Forwarded-Encrypted: i=1; AJvYcCUBpDY+Wm2WYc5XKshBxirAGWEKmi3bq5UNPtNuDfIvfzlpbnyBvqO87AgpJQ+1KhmN5/BGF9bhcLQ=@vger.kernel.org, AJvYcCUIHPwgZZISRyIdvUBZ0nT3h55V6tJMLMXOtb3gCjPearcpPIy9ez7igUJ7vlSHOgCDaOKhdAeyldBujiYmj2d6eDJGJw==@vger.kernel.org, AJvYcCXbnuZB9B1JPiZ2vaBc9g19eH61Fev65hQqmlIhngf4hQ/5P1mI9qd5Gb+blhR6gqG5cXr2z+NyxNIOdoMW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eILql1Cp8C8Smrgs2/dpdBAZCrLapCXPEaGj4DtPOSamIVHj
	LNC5H5aUA9mdatcVuHK25545d66hXGcsknnoGqwxDj2x+YyP/NrR
X-Gm-Gg: ASbGncvPdTy2QCJ2y7g7dnYjWJkpLojJYMlKXVUQGDrx1y9KP+xw06TeMeeOG4+9A6S
	UPIgCsqEYLB+QanHs5y0M+kD0cYIs+06RX07kYNJ1jCKGB9rs4mfMzpNpEX8Y0LAi+IOzYyccZV
	hwzijbNm8nSMyggEulS02TlW3lc8ce/IYNkGyQeeNgMSXbpo58Mk8bytTGWdoAsuc/vraRUJRVX
	HfNzClzzmdpewARSUQBlgY2WfTtHJZi/+WVI9MSC8TjwwMBRqDgFL5oFZ2FxogIwPQlDY/02KI1
	v9HS1e1D8h56flN+g3kpFQxz7lxseOWvo8vvAt9buHB6w0sYlhcgBqM=
X-Google-Smtp-Source: AGHT+IGEHhm50jvPrKXnppE9dICPxVL9TIEog8tr3zWRJ7yWmsQEa3hRLNBY6Zx/7DiQMiGjJSqS5Q==
X-Received: by 2002:a17:903:2287:b0:216:7ee9:21ff with SMTP id d9443c01a7336-218d727da66mr7665425ad.49.1734476813662;
        Tue, 17 Dec 2024 15:06:53 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db58cdsm64536765ad.38.2024.12.17.15.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:06:53 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>,
	Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] platform/x86: Add lenovo-legion-wmi drivers
Date: Tue, 17 Dec 2024 15:06:45 -0800
Message-ID: <20241217230645.15027-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217230645.15027-1-derekjohn.clark@gmail.com>
References: <20241217230645.15027-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds lenovo-legion-wmi.h which provides templates and some method
implementations used by the lenovo-legion-wmi driver series.

Adds lenovo-legion-wmi-gamezone.c which provides a driver for the Lenovo
GameZone WMI interface that comes on Lenovo "Gaming Series" hardware.
Provides ACPI platform profiles over WMI.

Adds lenovo-legion-wmi-other.c which provides a driver for the Lenovo
"Other Method" WMI interface that comes on some Lenovo hardware.
Provides a firmware-attributes class which enables the use of tunable
knobs for SPL, SPPT, and FPPT.

Adds lenovo-legion-wmi-capdata01.c which provides a driver for the
LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Method"
enabled hardware. Provides an interface for querying if a given
attribute is supported by the hardware, as well as its default_value,
max_value, min_value, and step increment.

Adds lenovo-legion-wmi.rst describing the available drivers and their
function.

Updates Kconfig, Makefile, and MAINTAINERS to include the new drivers.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 .../wmi/devices/lenovo-legion-wmi.rst         |  79 ++++
 MAINTAINERS                                   |   9 +
 drivers/platform/x86/Kconfig                  |  35 ++
 drivers/platform/x86/Makefile                 |  21 +-
 .../x86/lenovo-legion-wmi-capdata01.c         | 103 +++++
 .../platform/x86/lenovo-legion-wmi-gamezone.c | 233 +++++++++++
 .../platform/x86/lenovo-legion-wmi-other.c    | 377 ++++++++++++++++++
 drivers/platform/x86/lenovo-legion-wmi.h      | 271 +++++++++++++
 8 files changed, 1119 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/wmi/devices/lenovo-legion-wmi.rst
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi-other.c
 create mode 100644 drivers/platform/x86/lenovo-legion-wmi.h

diff --git a/Documentation/wmi/devices/lenovo-legion-wmi.rst b/Documentation/wmi/devices/lenovo-legion-wmi.rst
new file mode 100644
index 000000000000..37b09c82c980
--- /dev/null
+++ b/Documentation/wmi/devices/lenovo-legion-wmi.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+======================================================
+Lenovo Legion WMI Interface Driver (lenovo-legion-wmi)
+======================================================
+
+Introduction
+============
+The Lenovo Legion WMI interface is broken up into multiple GUID interfaces that
+require cross-references between GUID's for some functionality. The "Custom
+Mode" interface is a legacy interface for managing and displaying CPU & GPU
+power and hwmon settings and readings. The "Other Mode" interface is a modern
+interface that replaces "Custom Mode" interface methods. The "GameZone"
+interface adds advanced features such as fan profiles and overclocking. The
+"Lighting" interface adds control of various status lights related to different
+hardware components.
+
+Each of these interfaces has a different data structure associated with it that
+provide detailed information about each attribute provided by the interface.
+These data structs are retrieved from an additional WMI device data block GUID:
+ - The "Custom Mode" interface uses LENOVO_CAPABILITY_DATA_00
+ - The "Other Mode" interface uses LENOVO_CAPABILITY_DATA_01
+ - The "Lighting" interface uses LENOVO_CAPABILITY_DATA_02
+
+.. note::
+   Currently only the "Gamezone", "Other Mode", and LENOVO_CAPABILITY_DATA_01
+   interfaces are implemented by this driver.
+
+
+GameZone
+--------
+The GameZone WMI interface provides ACPI platform profile and fan curve
+settings for devices that fall under the "Gaming Series" of Lenovo Legion
+devices.
+
+The following platform profiles are supported:
+ - quiet
+ - balanced
+ - performance
+ - custom
+
+Custom Profile
+~~~~~~~~~~~~~~
+The custom profile is enabled but is not user selectable. This setting
+represents a hardware mode on Lenovo Legion devices that enables user
+modifications to Package Power Tracking settings. When an attribute exposed
+by the "Other Mode" WMI Interface is modified, the GameZone driver will switch
+to this profile automatically.
+
+
+Other Mode
+----------
+The Other Mode WMI interface uses the fw_attributes class to expose various
+WMI functions provided by the interface in the sysfs. This enables CPU and GPU
+power limit tuning as well as various other attributes for devices that fall
+under the "Gaming Series" of Lenovo Legion devices. Each attribute exposed by
+the "Other Method" interface has corresponding LENOVO_CAPABILITY_DATA_01 pages
+that allow the driver to probe details about the attribute. Each attibute has
+multiple pages, one for each of the platform profiles managed by the "GameZone"
+interface, so it must be probed prior to returning the current_value. For
+read-only properties, only the "Custom" profile values are reported to ensure
+any userspace applications reading them have accurate tunable value ranges.
+Attributes are exposed in sysfs under the following path:
+/sys/class/firmware-attributes/lenovo-legion-wmi/attributes
+
+Supported Attibutes
+~~~~~~~~~~~~~~~~~~~
+The following attributes are supported:
+ - ppt_pl1_spl: Platform Profile Tracking Sustained Power Limit
+ - ppt_pl2_sppt: Platform Profile Tracking Slow Package Power Tracking
+ - ppt_pl3_fppt: Platform Profile Tracking Fast Package Power Tracking
+
+Each attribute has the following properties:
+ - current_value
+ - default_value
+ - display_name
+ - max_value
+ - min_value
+ - scalar_increment
+ - type
diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..67f7b588aa36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13034,6 +13034,15 @@ S:	Maintained
 W:	http://legousb.sourceforge.net/
 F:	drivers/usb/misc/legousbtower.c
 
+LENOVO LEGION WMI driver
+M:	Derek J. Clark <derekjohn.clark@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/lenovo-legion-wmi-capdata01.c
+F:	drivers/platform/x86/lenovo-legion-wmi-gamezone.c
+F:	drivers/platform/x86/lenovo-legion-wmi-other.c
+F:	drivers/platform/x86/lenovo-legion-wmi.h
+
 LETSKETCH HID TABLET DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0258dd879d64..a51a1a2fe7ba 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -459,6 +459,41 @@ config IBM_RTL
 	 state = 0 (BIOS SMIs on)
 	 state = 1 (BIOS SMIs off)
 
+config LEGION_GAMEZONE_WMI
+	tristate "Lenovo Legion GameZone WMI Driver"
+	depends on ACPI_WMI
+	select ACPI_PLATFORM_PROFILE
+	help
+	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
+	  platform-profile firmware interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called lenovo_legion_wmi_gamezone.
+
+config LEGION_DATA_01_WMI
+	tristate "Lenovo Legion WMI capability Data 01 Driver"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you have a WMI aware Lenovo Legion device in the "Gaming Series"
+	  line of hardware. This interface is a dependency for exposing tunable power
+	  settings.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called lenovo_legion_wmi_capdata01.
+
+config LEGION_OTHER_WMI
+	tristate "Lenovo Legion Other Method WMI Driver"
+	depends on LEGION_GAMEZONE_WMI
+	depends on LEGION_DATA_01_WMI
+	select FW_ATTR_CLASS
+	help
+	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
+	  firmware_attributes API to control various tunable settings typically exposed by
+	  Lenovo software in Windows.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called lenovo_legion_wmi_other.
+
 config IDEAPAD_LAPTOP
 	tristate "Lenovo IdeaPad Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b142947067..838ee568c3f9 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -59,15 +59,18 @@ obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)	+= hp/
 obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
 
 # IBM Thinkpad and Lenovo
-obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
-obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
-obj-$(CONFIG_LENOVO_YMC)	+= lenovo-ymc.o
-obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
-obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
-obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
-obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
-obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
-obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
+obj-$(CONFIG_IBM_RTL)			+= ibm_rtl.o
+obj-$(CONFIG_IDEAPAD_LAPTOP)		+= ideapad-laptop.o
+obj-$(CONFIG_LENOVO_YMC)		+= lenovo-ymc.o
+obj-$(CONFIG_SENSORS_HDAPS)		+= hdaps.o
+obj-$(CONFIG_THINKPAD_ACPI)		+= thinkpad_acpi.o
+obj-$(CONFIG_THINKPAD_LMI)		+= think-lmi.o
+obj-$(CONFIG_YOGABOOK)			+= lenovo-yogabook.o
+obj-$(CONFIG_YT2_1380)			+= lenovo-yoga-tab2-pro-1380-fastcharger.o
+obj-$(CONFIG_LENOVO_WMI_CAMERA)		+= lenovo-wmi-camera.o
+obj-$(CONFIG_LEGION_GAMEZONE_WMI)	+= lenovo-legion-wmi-gamezone.o
+obj-$(CONFIG_LEGION_DATA_01_WMI)	+= lenovo-legion-wmi-capdata01.o
+obj-$(CONFIG_LEGION_OTHER_WMI)		+= lenovo-legion-wmi-other.o
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo-legion-wmi-capdata01.c b/drivers/platform/x86/lenovo-legion-wmi-capdata01.c
new file mode 100644
index 000000000000..99f4f35b7176
--- /dev/null
+++ b/drivers/platform/x86/lenovo-legion-wmi-capdata01.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface provides
+ * information on tunable attributes used by the "Other Method" WMI interface,
+ * including if it is supported by the hardware, the default_value, max_value,
+ * min_value, and step increment.
+ *
+ * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#include "lenovo-legion-wmi.h"
+
+#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
+
+static const struct wmi_device_id capdata_01_wmi_id_table[] = {
+	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
+	{}
+};
+
+static struct capdata_wmi cd01_wmi = {
+	.mutex = __MUTEX_INITIALIZER(cd01_wmi.mutex)
+};
+
+int capdata_01_wmi_get(struct om_attribute_id attr_id,
+		       struct capability_data_01 *cap_data)
+{
+	union acpi_object *ret_obj;
+	int count;
+	int instance_id;
+	u32 attribute_id = *(int *)&attr_id;
+
+	mutex_lock(&cd01_wmi.mutex);
+	count = wmidev_instance_count(drvdata.cd01_wmi->wdev);
+	mutex_unlock(&cd01_wmi.mutex);
+	for (instance_id = 0; instance_id < count; instance_id++) {
+		mutex_lock(&cd01_wmi.mutex);
+		ret_obj =
+			wmidev_block_query(drvdata.cd01_wmi->wdev, instance_id);
+		mutex_unlock(&cd01_wmi.mutex);
+		if (!ret_obj) {
+			pr_err("lenovo_legion_wmi_capdata_01: block query failed\n");
+			continue;
+		}
+
+		if (ret_obj->type != ACPI_TYPE_BUFFER) {
+			pr_err("lenovo_legion_wmi_capdata_01: block query returned type: %u\n",
+			       ret_obj->type);
+			kfree(ret_obj);
+			continue;
+		}
+
+		if (ret_obj->buffer.length != sizeof(*cap_data)) {
+			pr_err("lenovo_legion_wmi_capdata_01: bad buffer length, %d\n",
+			       ret_obj->buffer.length);
+			kfree(ret_obj);
+			continue;
+		}
+
+		memcpy(cap_data, ret_obj->buffer.pointer,
+		       ret_obj->buffer.length);
+		kfree(ret_obj);
+
+		if (cap_data->id != attribute_id)
+			continue;
+		break;
+	}
+	if (cap_data->id == 0) {
+		pr_err("lenovo_legion_wmi_capdata_01: Failed to get capability data.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(capdata_01_wmi_get, "CAPDATA_WMI");
+
+/* Driver Setup */
+static int capdata_01_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	cd01_wmi.wdev = wdev;
+	drvdata.cd01_wmi = &cd01_wmi;
+	pr_info("lenovo_legion_wmi_capdata_01: Added Lenovo Capability Data 01 WMI interface.\n");
+
+	return 0;
+}
+
+static void capdata_01_wmi_remove(struct wmi_device *wdev)
+{
+	pr_info("lenovo_legion_wmi_capdata_01: Removed Lenovo Capability Data 01 WMI interface.\n");
+}
+
+static struct wmi_driver capdata_01_wmi_driver = {
+	.driver = { .name = "capdata_01_wmi" },
+	.id_table = capdata_01_wmi_id_table,
+	.probe = capdata_01_wmi_probe,
+	.remove = capdata_01_wmi_remove,
+};
+
+module_wmi_driver(capdata_01_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, capdata_01_wmi_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-legion-wmi-gamezone.c b/drivers/platform/x86/lenovo-legion-wmi-gamezone.c
new file mode 100644
index 000000000000..2f976dc0e367
--- /dev/null
+++ b/drivers/platform/x86/lenovo-legion-wmi-gamezone.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo GameZone WMI interface driver. The GameZone WMI interface provides
+ * platform profile and fan curve settings for devices that fall under the
+ * "Gaming Series" of Lenovo Legion devices.
+ *
+ * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#include "lenovo-legion-wmi.h"
+
+#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
+
+/* Method IDs */
+#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
+#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
+#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
+
+static const struct wmi_device_id gamezone_wmi_id_table[] = {
+	{ LENOVO_GAMEZONE_GUID, NULL }, /* LENOVO_GAMEZONE_DATA */
+	{}
+};
+
+static struct gamezone_wmi gz_wmi = {
+	.mutex = __MUTEX_INITIALIZER(gz_wmi.mutex)
+};
+
+/* Platform Profile Methods */
+static int
+gamezone_wmi_platform_profile_supported(struct platform_profile_handler *pprof,
+					int *supported)
+{
+	int ret;
+
+	mutex_lock(&gz_wmi.mutex);
+	ret = lenovo_legion_evaluate_method_1(drvdata.gz_wmi->wdev, 0x0,
+					      WMI_METHOD_ID_SMARTFAN_SUPP, 0,
+					      supported);
+	mutex_unlock(&gz_wmi.mutex);
+	return ret;
+}
+
+int gamezone_wmi_fan_profile_get(struct platform_profile_handler *pprof,
+				 int *sel_prof)
+{
+	int ret;
+	int supported;
+
+	gamezone_wmi_platform_profile_supported(&drvdata.gz_wmi->pprof,
+						&supported);
+	if (!supported) {
+		pr_err("lenovo_legion_wmi_gamezone: Platform profiles are not supported by this device.\n");
+		return -EOPNOTSUPP;
+	}
+	mutex_lock(&gz_wmi.mutex);
+	ret = lenovo_legion_evaluate_method_1(drvdata.gz_wmi->wdev, 0x0,
+					      WMI_METHOD_ID_SMARTFAN_GET, 0,
+					      sel_prof);
+	mutex_unlock(&gz_wmi.mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(gamezone_wmi_fan_profile_get, "GZ_WMI");
+
+static int
+gamezone_wmi_platform_profile_get(struct platform_profile_handler *pprof,
+				  enum platform_profile_option *profile)
+{
+	int sel_prof;
+	int err;
+
+	err = gamezone_wmi_fan_profile_get(pprof, &sel_prof);
+	if (err)
+		return err;
+
+	switch (sel_prof) {
+	case SMARTFAN_MODE_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	case SMARTFAN_MODE_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case SMARTFAN_MODE_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case SMARTFAN_MODE_CUSTOM:
+		*profile = PLATFORM_PROFILE_CUSTOM;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	drvdata.gz_wmi->current_profile = *profile;
+
+	return 0;
+}
+
+int gamezone_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+				      enum platform_profile_option profile)
+{
+	int ret;
+	int sel_prof;
+	int supported;
+
+	gamezone_wmi_platform_profile_supported(&drvdata.gz_wmi->pprof,
+						&supported);
+	if (!supported) {
+		pr_err("lenovo_legion_wmi_gamezone: Platform profiles are not supported by this device.\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (profile) {
+	case PLATFORM_PROFILE_QUIET:
+		sel_prof = SMARTFAN_MODE_QUIET;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		sel_prof = SMARTFAN_MODE_BALANCED;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		sel_prof = SMARTFAN_MODE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_CUSTOM:
+		sel_prof = SMARTFAN_MODE_CUSTOM;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&gz_wmi.mutex);
+	ret = lenovo_legion_evaluate_method_1(drvdata.gz_wmi->wdev, 0x0,
+					      WMI_METHOD_ID_SMARTFAN_SET,
+					      sel_prof, NULL);
+	mutex_unlock(&gz_wmi.mutex);
+
+	if (ret) {
+		pr_err("lenovo_legion_wmi_gamezone: Failed to set platform profile.\n");
+		return ret;
+	}
+
+	drvdata.gz_wmi->current_profile = profile;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(gamezone_wmi_platform_profile_set, "GZ_WMI");
+
+/* Driver Setup */
+static int platform_profile_setup(struct gamezone_wmi *gz_wmi)
+{
+	int err;
+	int supported;
+
+	gamezone_wmi_platform_profile_supported(&gz_wmi->pprof, &supported);
+
+	gz_wmi->platform_profile_support = supported;
+
+	if (!supported) {
+		pr_warn("lenovo_legion_wmi_gamezone: Platform profiles are not supported by this device.\n");
+		return -EOPNOTSUPP;
+	}
+
+	gz_wmi->pprof.profile_get = gamezone_wmi_platform_profile_get;
+	gz_wmi->pprof.profile_set = gamezone_wmi_platform_profile_set;
+
+	set_bit(PLATFORM_PROFILE_QUIET, gz_wmi->pprof.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, gz_wmi->pprof.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, gz_wmi->pprof.choices);
+	set_bit(PLATFORM_PROFILE_CUSTOM, gz_wmi->pprof.choices);
+
+	err = gamezone_wmi_platform_profile_get(&gz_wmi->pprof,
+						&gz_wmi->current_profile);
+	if (err) {
+		pr_err("lenovo_legion_wmi_gamezone: Failed to get current platform profile: %d\n",
+		       err);
+		return err;
+	}
+
+	err = platform_profile_register(&gz_wmi->pprof);
+	if (err) {
+		pr_err("lenovo_legion_wmi_gamezone: Failed to register platform profile support: %d\n",
+		       err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int gamezone_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	int err;
+
+	gz_wmi.wdev = wdev;
+	drvdata.gz_wmi = &gz_wmi;
+
+	err = platform_profile_setup(&gz_wmi);
+	if (err) {
+		pr_err("lenovo_legion_wmi_gamezone: Failed to add platform profile: %d\n",
+		       err);
+		kfree(&gz_wmi);
+		return err;
+	}
+
+	pr_info("lenovo_legion_wmi_gamezone: Added platform profile support.\n");
+	return 0;
+}
+
+static void gamezone_wmi_remove(struct wmi_device *wdev)
+{
+	int err;
+
+	mutex_lock(&gz_wmi.mutex);
+	err = platform_profile_remove(&drvdata.gz_wmi->pprof);
+	mutex_unlock(&gz_wmi.mutex);
+
+	if (err) {
+		pr_err("lenovo_legion_wmi_gamezone: Failed to remove platform profile: %d\n",
+		       err);
+	} else {
+		pr_info("lenovo_legion_wmi_gamezone: Removed platform profile support.\n");
+	}
+}
+
+static struct wmi_driver gamezone_wmi_driver = {
+	.driver = { .name = "gamezone_wmi" },
+	.id_table = gamezone_wmi_id_table,
+	.probe = gamezone_wmi_probe,
+	.remove = gamezone_wmi_remove,
+};
+
+module_wmi_driver(gamezone_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, gamezone_wmi_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-legion-wmi-other.c b/drivers/platform/x86/lenovo-legion-wmi-other.c
new file mode 100644
index 000000000000..c09c1848eda7
--- /dev/null
+++ b/drivers/platform/x86/lenovo-legion-wmi-other.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo Legion Other Method driver. This driver uses the fw_attributes
+ * class to expose the various WMI functions provided by the "Other Method" WMI
+ * interface. This enables CPU and GPU power limit as well as various other
+ * attributes for devices that fall under the "Gaming Series" of Lenovo Legion
+ * devices. Each attribute exposed by the "Other Method"" interface has a
+ * corresponding LENOVO_CAPABILITY_DATA_01 struct that allows the driver to
+ * probe details about the attribute such as set/get support, step, min, max,
+ * and default value. Each attibute has multiple pages, one for each of the
+ * fan profiles managed by the GameZone interface, so it must be probed prior
+ * to returning the current_value.
+ *
+ * These attributes typically don't fit anywhere else in the sysfs and are set
+ * in Windows using one of Lenovo's multiple user applications.
+ *
+ * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#include "lenovo-legion-wmi.h"
+#include "firmware_attributes_class.h"
+
+#define LENOVO_OTHER_METHOD_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
+
+/* Device IDs */
+#define WMI_DEVICE_ID_CPU 0x01
+
+/* WMI_DEVICE_ID_CPU feature IDs */
+#define WMI_FEATURE_ID_CPU_SPPT 0x01 /* Short Term Power Limit */
+#define WMI_FEATURE_ID_CPU_SPL 0x02 /* Peak Power Limit */
+#define WMI_FEATURE_ID_CPU_FPPT 0x03 /* Long Term Power Limit */
+
+/* Method IDs */
+#define WMI_METHOD_ID_VALUE_GET 17 /* Other Method Getter */
+#define WMI_METHOD_ID_VALUE_SET 18 /* Other Method Setter */
+
+static const struct wmi_device_id other_method_wmi_id_table[] = {
+	{ LENOVO_OTHER_METHOD_GUID, NULL },
+	{}
+};
+
+/* Tunable Attributes */
+struct ll_tunables {
+	u32 ppt_pl1_spl;
+	u32 ppt_pl2_sppt;
+	u32 ppt_pl3_fppt;
+};
+
+static const struct class *fw_attr_class;
+
+static struct other_method_wmi om_wmi = {
+	.mutex = __MUTEX_INITIALIZER(om_wmi.mutex)
+};
+
+struct capdata_01_attr_group {
+	const struct attribute_group *attr_group;
+};
+
+/* Simple attribute creation */
+
+/*
+ * att_current_value_store() - Set the current value of the given attribute
+ * @kobj: Pointer to the driver object.
+ * @kobj_attribute: Pointer to the attribute calling this function.
+ * @buf: The buffer to read from, this is parsed to `int` type.
+ * @count: Required by sysfs attribute macros, pass in from the callee attr.
+ * @store_value: Pointer to where the parsed value should be stored.
+ * @device_id: The WMI function Device ID to use.
+ * @feature_id: The WMI function Feature ID to use.
+ *
+ * This function is intended to be generic so it can be called from any
+ * attribute's "current_value_store" which works only with integers. The
+ * integer to be sent to the WMI method is range checked and an error returned
+ * if out of range.
+ *
+ * If the value is valid and WMI is success, then the sysfs attribute is
+ * notified.
+ *
+ * Returns: Either count, or an error.
+ */
+ssize_t attr_current_value_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count, u32 *store_value, u8 device_id,
+				 u8 feature_id)
+{
+	struct capability_data_01 cap_data;
+	enum platform_profile_option cust_prof;
+	int err;
+	int sel_prof;
+	u32 value;
+	struct wmi_device *wdev = drvdata.om_wmi->wdev;
+
+	err = gamezone_wmi_fan_profile_get(&drvdata.gz_wmi->pprof, &sel_prof);
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Error getting gamezone fan profile.\n");
+		return -EIO;
+	}
+
+	/* Switch to custom profile if not currently on it. */
+	if (sel_prof != SMARTFAN_MODE_CUSTOM) {
+		pr_warn("lenovo_legion_wmi_other: Device must be in CUSTOM profile to set tunables.");
+		cust_prof = PLATFORM_PROFILE_CUSTOM;
+		sel_prof = SMARTFAN_MODE_CUSTOM;
+		err = gamezone_wmi_platform_profile_set(&drvdata.gz_wmi->pprof,
+							cust_prof);
+		if (err) {
+			pr_err("lenovo_legion_wmi_other: Error setting gamezone fan profile.\n");
+			return -EIO;
+		}
+	}
+
+	err = kstrtouint(buf, 10, &value);
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Error converting value to int.\n");
+		return -EIO;
+	}
+
+	/* Construct the attribute id */
+	struct om_attribute_id attr_id = { sel_prof << 8, feature_id,
+					   device_id };
+
+	/* Get min/max from LENOVO_CAPABILITY_DATA_01 */
+	err = capdata_01_wmi_get(attr_id, &cap_data);
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Failed to get capability data.\n");
+		return -EIO;
+	}
+	if (cap_data.capability < 1) {
+		pr_err("lenovo_legion_wmi_other: Capability not supported.\n");
+		return -EPERM;
+	}
+
+	if (value < cap_data.min_value || value > cap_data.max_value) {
+		pr_warn("lenovo_legion_wmi_other: Value %d is not between %d and %d.\n",
+			value, cap_data.min_value, cap_data.max_value);
+		return -EINVAL;
+	}
+
+	mutex_lock(&om_wmi.mutex);
+	err = lenovo_legion_evaluate_method_2(wdev, 0x0,
+					      WMI_METHOD_ID_VALUE_SET,
+					      *(int *)&attr_id, value, NULL);
+	mutex_unlock(&om_wmi.mutex);
+
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Error setting attribute");
+		return err;
+	}
+
+	if (store_value)
+		*store_value = value;
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+	return count;
+}
+
+/*
+ * attr_current_value_show() - Get the current value of the given attribute
+ * @kobj: Pointer to the driver object.
+ * @kobj_attribute: Pointer to the attribute calling this function.
+ * @buf: The buffer to write to.
+ * @retval: Pointer to returned data.
+ * @device_id: The WMI function Device ID to use.
+ * @feature_id: The WMI function Feature ID to use.
+ *
+ * This function is intended to be generic so it can be called from any "_show"
+ * attribute which works only with integers.
+ *
+ * If the WMI is success, then the sysfs attribute is notified.
+ *
+ * Returns: Either count, or an error.
+ */
+ssize_t attr_current_value_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf,
+				u8 device_id, u8 feature_id)
+{
+	int sel_prof; /* Current fan profile mode */
+	int err;
+	int retval;
+	struct wmi_device *wdev = drvdata.om_wmi->wdev;
+
+	err = gamezone_wmi_fan_profile_get(&drvdata.gz_wmi->pprof, &sel_prof);
+
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Error getting gamezone fan profile.\n");
+		return err;
+	}
+
+	// Construct the WMI attribute id from the given args.
+	struct om_attribute_id attribute_id = { sel_prof << 8, feature_id,
+						device_id };
+
+	mutex_lock(&om_wmi.mutex);
+	err = lenovo_legion_evaluate_method_1(wdev, 0x0,
+					      WMI_METHOD_ID_VALUE_GET,
+					      *(int *)&attribute_id, &retval);
+	mutex_unlock(&om_wmi.mutex);
+
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Error getting attribute");
+		return err;
+	}
+
+	return sysfs_emit(buf, "%u\n", retval);
+}
+
+/**
+ * attr_capdata_01_show() - Get the value of the specified attribute property
+ * from LENOVO_CAPABILITY_DATA_01.
+ * @kobj: Pointer to the driver object.
+ * @kobj_attribute: Pointer to the attribute calling this function.
+ * @buf: The buffer to write to.
+ * @retval: Pointer to returned data.
+ * @device_id: The WMI functions Device ID to use.
+ * @feature_id: The WMI functions Feature ID to use.
+ * @prop: The property of this attribute to be read.
+ *
+ * This function is intended to be generic so it can be called from any "_show"
+ * attribute which works only with integers.
+ *
+ * If the WMI is success, then the sysfs attribute is notified.
+ *
+ * Returns: Either count, or an error.
+ */
+ssize_t attr_capdata_01_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf, u8 device_id, u8 feature_id,
+			     enum attribute_property prop)
+{
+	struct capability_data_01 cap_data;
+	int err;
+	int retval;
+	int sel_prof = SMARTFAN_MODE_CUSTOM; /* Only show CUSTOM mode values */
+
+	// Construct the WMI attribute id from the given args.
+	struct om_attribute_id attribute_id = { sel_prof << 8, feature_id,
+						device_id };
+
+	err = capdata_01_wmi_get(attribute_id, &cap_data);
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Failed to get capability data.\n");
+		return -EIO;
+	}
+
+	switch (prop) {
+	case DEFAULT_VAL:
+		retval = cap_data.default_value;
+		break;
+	case MAX_VAL:
+		retval = cap_data.max_value;
+		break;
+	case MIN_VAL:
+		retval = cap_data.min_value;
+		break;
+	case STEP_VAL:
+		retval = cap_data.step;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return sysfs_emit(buf, "%u\n", retval);
+}
+
+ATTR_GROUP_LL_TUNABLE_CAP01(ppt_pl1_spl, "ppt_pl1_spl", WMI_DEVICE_ID_CPU,
+			    WMI_FEATURE_ID_CPU_SPL,
+			    "Set the CPU sustained power limit");
+ATTR_GROUP_LL_TUNABLE_CAP01(ppt_pl2_sppt, "ppt_pl2_sppt", WMI_DEVICE_ID_CPU,
+			    WMI_FEATURE_ID_CPU_SPPT,
+			    "Set the CPU slow package power tracking limit");
+ATTR_GROUP_LL_TUNABLE_CAP01(ppt_pl3_fppt, "ppt_pl3_fppt", WMI_DEVICE_ID_CPU,
+			    WMI_FEATURE_ID_CPU_FPPT,
+			    "Set the CPU fast package power tracking limit");
+
+static const struct capdata_01_attr_group capdata_01_attr_groups[] = {
+	{ &ppt_pl1_spl_attr_group },
+	{ &ppt_pl2_sppt_attr_group },
+	{ &ppt_pl3_fppt_attr_group },
+	{},
+};
+
+static int other_method_fw_attr_add(void)
+{
+	int err, i;
+
+	err = fw_attributes_class_get(&fw_attr_class);
+	if (err) {
+		pr_err("lenovo_legion_wmi_other: Failed to get firmware_attributes_class.\n");
+		return err;
+	}
+
+	om_wmi.fw_attr_dev = device_create(fw_attr_class, NULL, MKDEV(0, 0),
+					   NULL, "%s", DRIVER_NAME);
+	if (IS_ERR(om_wmi.fw_attr_dev)) {
+		pr_err("lenovo_legion_wmi_other: Failed to create firmware_attributes_class device.\n");
+		err = PTR_ERR(om_wmi.fw_attr_dev);
+		goto fail_class_get;
+	}
+
+	om_wmi.fw_attr_kset = kset_create_and_add("attributes", NULL,
+						  &om_wmi.fw_attr_dev->kobj);
+	if (!om_wmi.fw_attr_kset) {
+		pr_err("lenovo_legion_wmi_other: Failed to create firmware_attributes_class kset.\n");
+		err = -ENOMEM;
+		goto err_destroy_classdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(capdata_01_attr_groups) - 1; i++) {
+		err = sysfs_create_group(&om_wmi.fw_attr_kset->kobj,
+					 capdata_01_attr_groups[i].attr_group);
+		if (err) {
+			pr_err("lenovo_legion_wmi_other: Failed to create sysfs-group for %s\n",
+			       capdata_01_attr_groups[i].attr_group->name);
+			goto err_remove_groups;
+		}
+	}
+
+	return 0;
+
+err_remove_groups:
+	while (--i >= 0) {
+		sysfs_remove_group(&om_wmi.fw_attr_kset->kobj,
+				   capdata_01_attr_groups[i].attr_group);
+	}
+err_destroy_classdev:
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+fail_class_get:
+	fw_attributes_class_put();
+	return err;
+}
+
+/* Driver Setup */
+static int other_method_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	int err;
+
+	om_wmi.wdev = wdev;
+	drvdata.om_wmi = &om_wmi;
+	om_wmi.ll_tunables = kzalloc(sizeof(*om_wmi.ll_tunables), GFP_KERNEL);
+	if (!om_wmi.ll_tunables)
+		return -ENOMEM;
+
+	err = other_method_fw_attr_add();
+	if (err)
+		return err;
+	pr_info("lenovo_legion_wmi_other: Firmware attributes added.\n");
+
+	return 0;
+}
+
+static void other_method_wmi_remove(struct wmi_device *wdev)
+{
+	mutex_lock(&om_wmi.mutex);
+
+	kset_unregister(om_wmi.fw_attr_kset);
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+	fw_attributes_class_put();
+
+	mutex_unlock(&om_wmi.mutex);
+
+	pr_info("lenovo_legion_wmi_other: Firmware attributes removed.\n");
+}
+
+static struct wmi_driver other_method_wmi_driver = {
+	.driver = { .name = "other_method_wmi" },
+	.id_table = other_method_wmi_id_table,
+	.probe = other_method_wmi_probe,
+	.remove = other_method_wmi_remove,
+};
+
+module_wmi_driver(other_method_wmi_driver);
+
+MODULE_IMPORT_NS("GZ_WMI");
+MODULE_IMPORT_NS("CAPDATA_WMI");
+MODULE_DEVICE_TABLE(wmi, other_method_wmi_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo Legion Other Method Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-legion-wmi.h b/drivers/platform/x86/lenovo-legion-wmi.h
new file mode 100644
index 000000000000..65baa728f29e
--- /dev/null
+++ b/drivers/platform/x86/lenovo-legion-wmi.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface is
+ * broken up into multiple GUID interfaces that require cross-references
+ * between GUID's for some functionality. The "Custom Mode" interface is a
+ * legacy interface for managing and displaying CPU & GPU power and hwmon
+ * settings and readings. The "Other Mode" interface is a modern interface
+ * that replaces or extends the "Custom Mode" interface methods. The "GameZone"
+ * interface adds advanced features such as fan profiles and overclocking.
+ * The "Lighting" interface adds control of various status lights related to
+ * different hardware components. "Custom Mode" uses LENOVO_CAPABILITY_DATA_00
+ * struct for capability information, "Other Mode" uses
+ * LENOVO_CAPABILITY_DATA_01 struct for capability information, and "Lighting"
+ * uses LENOVO_CAPABILITY_DATA_02 struct for capability information.
+ *
+ * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#ifndef _LENOVO_LEGION_WMI_H_
+#define _LENOVO_LEGION_WMI_H_
+
+#include <linux/mutex.h>
+#include <linux/platform_profile.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+
+#define DRIVER_NAME "lenovo-legion-wmi"
+
+/* Platform Profile Modes */
+#define SMARTFAN_MODE_QUIET 0x01
+#define SMARTFAN_MODE_BALANCED 0x02
+#define SMARTFAN_MODE_PERFORMANCE 0x03
+#define SMARTFAN_MODE_CUSTOM 0xFF
+
+struct gamezone_wmi {
+	struct wmi_device *wdev;
+	enum platform_profile_option current_profile;
+	struct platform_profile_handler pprof;
+	bool platform_profile_support;
+	struct mutex mutex; /* Ensure single operation on WMI device */
+};
+
+struct other_method_wmi {
+	struct wmi_device *wdev;
+	struct device *fw_attr_dev;
+	struct kset *fw_attr_kset;
+	struct ll_tunables *ll_tunables;
+	struct mutex mutex; /* Ensure single operation on WMI device */
+};
+
+struct capdata_wmi {
+	struct wmi_device *wdev;
+	struct mutex mutex; /* Ensure single operation on WMI device */
+};
+
+struct ll_drvdata {
+	struct other_method_wmi *om_wmi; /* Other method GUID device */
+	struct gamezone_wmi *gz_wmi; /* Gamezone GUID device */
+	struct capdata_wmi *cd01_wmi; /* Capability Data 01 GUID device */
+} drvdata;
+
+struct wmi_method_args {
+	u32 arg0;
+	u32 arg1;
+};
+
+struct om_attribute_id {
+	u32 mode_id : 16; /* Fan profile */
+	u32 feature_id : 8; /* Attribute (SPL/SPPT/...) */
+	u32 device_id : 8; /* CPU/GPU */
+} __packed;
+
+enum attribute_property {
+	DEFAULT_VAL = 0,
+	MAX_VAL,
+	MIN_VAL,
+	STEP_VAL,
+	SUPPORTED,
+};
+
+struct capability_data_01 {
+	u32 id;
+	u32 capability;
+	u32 default_value;
+	u32 step;
+	u32 min_value;
+	u32 max_value;
+};
+
+static int lenovo_legion_evaluate_method(struct wmi_device *wdev, u8 instance,
+					 u32 method_id, struct acpi_buffer *in,
+					 struct acpi_buffer *out)
+{
+	acpi_status status;
+
+	status = wmidev_evaluate_method(wdev, instance, method_id, in, out);
+
+	if (ACPI_FAILURE(status)) {
+		pr_err("lenovo_legion_wmi: wmidev_evaluate_method failed for method_id %u instance %u.\n",
+		       method_id, instance);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int lenovo_legion_evaluate_method_2(struct wmi_device *wdev, u8 instance,
+				    u32 method_id, u32 arg0, u32 arg1,
+				    u32 *retval);
+
+int lenovo_legion_evaluate_method_2(struct wmi_device *wdev, u8 instance,
+				    u32 method_id, u32 arg0, u32 arg1,
+				    u32 *retval)
+{
+	int ret;
+	u32 temp_val;
+	struct wmi_method_args args = { arg0, arg1 };
+	struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *ret_obj = NULL;
+
+	ret = lenovo_legion_evaluate_method(wdev, instance, method_id, &input,
+					    &output);
+
+	if (ret) {
+		pr_err("lenovo_legion_wmi: Attempt to get method_id %u value failed with error: %u\n",
+		       method_id, ret);
+		return ret;
+	}
+
+	if (retval) {
+		ret_obj = (union acpi_object *)output.pointer;
+		if (ret_obj && ret_obj->type == ACPI_TYPE_INTEGER)
+			temp_val = (u32)ret_obj->integer.value;
+
+		*retval = temp_val;
+	}
+
+	kfree(ret_obj);
+
+	return 0;
+}
+
+int lenovo_legion_evaluate_method_1(struct wmi_device *wdev, u8 instance,
+				    u32 method_id, u32 arg0, u32 *retval);
+
+int lenovo_legion_evaluate_method_1(struct wmi_device *wdev, u8 instance,
+				    u32 method_id, u32 arg0, u32 *retval)
+{
+	return lenovo_legion_evaluate_method_2(wdev, instance, method_id, arg0,
+					       0, retval);
+}
+
+int capdata_01_wmi_get(struct om_attribute_id attr_id,
+		       struct capability_data_01 *cap_data);
+
+int gamezone_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+				      enum platform_profile_option sel_prof);
+
+int gamezone_wmi_fan_profile_get(struct platform_profile_handler *pprof,
+				 int *sel_prof);
+
+/* current_value */
+ssize_t attr_current_value_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count, u32 *store_value, u8 device_id,
+				 u8 feature_id);
+
+ssize_t attr_current_value_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf,
+				u8 device_id, u8 feature_id);
+
+/* LENOVO_CAPABILITY_DATA_01 */
+ssize_t attr_capdata_01_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf, u8 device_id, u8 feature_id,
+			     enum attribute_property prop);
+
+ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+		      char *buf);
+
+ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+		      char *buf)
+{
+	return sysfs_emit(buf, "integer\n");
+}
+
+#define __LL_ATTR_RO(_func, _name)                                    \
+	{                                                             \
+		.attr = { .name = __stringify(_name), .mode = 0444 }, \
+		.show = _func##_##_name##_show,                       \
+	}
+
+#define __LL_ATTR_RO_AS(_name, _show)                                 \
+	{                                                             \
+		.attr = { .name = __stringify(_name), .mode = 0444 }, \
+		.show = _show,                                        \
+	}
+
+#define __LL_ATTR_RW(_func, _name) \
+	__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
+
+/* Shows a formatted static variable */
+#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)                         \
+	static ssize_t _attrname##_##_prop##_show(                            \
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{                                                                     \
+		return sysfs_emit(buf, _fmt, _val);                           \
+	}                                                                     \
+	static struct kobj_attribute attr_##_attrname##_##_prop =             \
+		__LL_ATTR_RO(_attrname, _prop)
+
+/* Attribute current_value show/store */
+#define __LL_TUNABLE_RW_CAP01(_attrname, _dev_id, _feat_id)                   \
+	static ssize_t _attrname##_current_value_store(                       \
+		struct kobject *kobj, struct kobj_attribute *attr,            \
+		const char *buf, size_t count)                                \
+	{                                                                     \
+		return attr_current_value_store(                              \
+			kobj, attr, buf, count,                               \
+			&om_wmi.ll_tunables->_attrname, _dev_id, _feat_id);   \
+	}                                                                     \
+	static ssize_t _attrname##_current_value_show(                        \
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{                                                                     \
+		return attr_current_value_show(kobj, attr, buf, _dev_id,      \
+					       _feat_id);                     \
+	}                                                                     \
+	static struct kobj_attribute attr_##_attrname##_current_value =       \
+		__LL_ATTR_RW(_attrname, current_value)
+
+/* Attribute property show only */
+#define __LL_TUNABLE_RO_CAP01(_prop, _attrname, _dev_id, _feat_id, _prop_type) \
+	static ssize_t _attrname##_##_prop##_show(                             \
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)  \
+	{                                                                      \
+		return attr_capdata_01_show(kobj, attr, buf, _dev_id,          \
+					    _feat_id, _prop_type);             \
+	}                                                                      \
+	static struct kobj_attribute attr_##_attrname##_##_prop =              \
+		__LL_ATTR_RO(_attrname, _prop)
+
+#define ATTR_GROUP_LL_TUNABLE_CAP01(_attrname, _fsname, _dev_id, _feat_id,    \
+				    _dispname)                                \
+	__LL_TUNABLE_RW_CAP01(_attrname, _dev_id, _feat_id);                  \
+	__LL_TUNABLE_RO_CAP01(default_value, _attrname, _dev_id, _feat_id,    \
+			      DEFAULT_VAL);                                   \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);          \
+	__LL_TUNABLE_RO_CAP01(max_value, _attrname, _dev_id, _feat_id,        \
+			      MAX_VAL);                                       \
+	__LL_TUNABLE_RO_CAP01(min_value, _attrname, _dev_id, _feat_id,        \
+			      MIN_VAL);                                       \
+	__LL_TUNABLE_RO_CAP01(scalar_increment, _attrname, _dev_id, _feat_id, \
+			      STEP_VAL);                                      \
+	static struct kobj_attribute attr_##_attrname##_type =                \
+		__LL_ATTR_RO_AS(type, int_type_show);                         \
+	static struct attribute *_attrname##_attrs[] = {                      \
+		&attr_##_attrname##_current_value.attr,                       \
+		&attr_##_attrname##_default_value.attr,                       \
+		&attr_##_attrname##_display_name.attr,                        \
+		&attr_##_attrname##_max_value.attr,                           \
+		&attr_##_attrname##_min_value.attr,                           \
+		&attr_##_attrname##_scalar_increment.attr,                    \
+		&attr_##_attrname##_type.attr,                                \
+		NULL,                                                         \
+	};                                                                    \
+	static const struct attribute_group _attrname##_attr_group = {        \
+		.name = _fsname, .attrs = _attrname##_attrs                   \
+	}
+
+#endif /* !_LENOVO_LEGION_WMI_H_ */
-- 
2.47.0


