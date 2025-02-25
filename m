Return-Path: <linux-kernel+bounces-532575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73101A44F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC91689D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432DB19DFA2;
	Tue, 25 Feb 2025 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0wnrHl4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856C213E71;
	Tue, 25 Feb 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520865; cv=none; b=MijO9rzUmEq07MRtXb4PqnUVN7T8j1fZegQvIu8yQ/OrewRKwgRYg0G9rr/d0X9irzBZ//PNxgfKr/42gaNzg7P2RqyfjkVnuoieq/XEALrnGb5W/K+0PoOWbWjpN4nG8REnM0osyE4t48evhjjUuMYfd2q0Mj6t0lVdtGcjXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520865; c=relaxed/simple;
	bh=0ohKyiHeUnWLo4t+bwTpZU53hcgGcF1n7nOwHd6jGx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUlC0UdYLCa0vJmcBSIZPEIEgQcU+1DO2DEZV1a3WNjctsP5QH0DZQ/Yc119iFC08S5j6qWX8nGALDoc+zY/epOZGWhhHbKLW1dRZoVbAQRvP+KRWW4GMj432fEjP3oO6JOd6p2PyhGgWkLq3BxlAHLR3wezN7mvTbdVwGuF1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0wnrHl4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221050f3f00so139685935ad.2;
        Tue, 25 Feb 2025 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520863; x=1741125663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbfElIS/OfppmRAJwL8J8XnWcD9jZJ+jmout7v0/MhU=;
        b=a0wnrHl4f10y8XLiPiXTZ+xe3d+O4lifimioLIxv/o6zqRhunmrvQYbgNZFhU03VMY
         csbOm+7F1lCkcQgXjngZFFQTh7B1Mg/qigeqRXoa2BNAtEaYIuGhhdE72pMaiIyyOEqO
         6U25WzXAW/iwp7ZuyUunf7qsdVoy1En0C0GDXtceqUpF8R4hmmRSaB1aaaDUzIe0XdAT
         jwHTEKHyUOa8A7Wou1ZvZuJ/4DKCFlsNjjgHznVqw8iErs2zXm6XwL4eyHLKrP/VLZno
         33ZJhw9Sg9nBhQj90db+C4mvk5ieN6llssKG6qMUxrbYL6bJLzgxIC6Ak/EdUquw4Voo
         B/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520863; x=1741125663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbfElIS/OfppmRAJwL8J8XnWcD9jZJ+jmout7v0/MhU=;
        b=LLhqnvCZVGCRY3Eg18pKeo3Sl72WECoz9addkPKi39p8G6KlCye6/LAzTn/WB0cZa6
         K9u6g7O6So+NKGiizCVCaZTKWBo/Jru6HoppNBQvGTStM5zQqk/6lG3I7OKwguHhVyoj
         zQXC2OXDCxdU7EOe6bF5zZVr/sqBFn/MIOjspJHaFh/94vAYulaYvaeuxJXBuqeZPB5U
         4EOq3NaclajIK3v/EoVZhmxMiLNCZcI7BGd50AJ5Z2WC6LoDRUEYq7d+yr1xvTJsKr8D
         nQ5heW/I1cTv6I86iIsUA7l7bKEbtmYBartKOFqvjASJvob5VyuLL8/S67lasnkxYoCi
         lUFA==
X-Forwarded-Encrypted: i=1; AJvYcCUsobwjCrC6xFYZS8fy4442hIYKEeyyYJ4eTlXMEqqdQrNUI0jBRnkpgXFyenj/G34iKvccWSuEgx7wgv/6@vger.kernel.org, AJvYcCVkd1QPFXgYo/n9XSmHJFapbGVRWanJBxl6QvQ/5XgDwiST17HJRMQWthJ6lpxa6lwLn5ELSANthZj17f/gKq1DFGMjYA==@vger.kernel.org, AJvYcCWluizy1KcMQziDj6laC5E8r18nRjjOb/izgGFOkHIVJgzIOtyD97RJDwqBUHIhTdrEMNGr/ZKYMJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywauwwxgz5u/Azc1hmzsX2yc81CDWmhrwpt6yeGjBbmIEdR/0gH
	Vj8NOjPR+HUDPAr2qMbnecIWFcmZZqxyI8SOeN/8jIo83xxbblLf
X-Gm-Gg: ASbGncvAWoy1LJnsBp3vS/JR7/4YdeIsGo22KnORpyCcHI1I3VvenGvIwglJIoSa8Ax
	bg8VEcVP4AJadKlfBOdycvyVaSyBPkRNNmEe4OdJNkwiGVrIMNbssD0HJRQojrko1t9I+GbXqhl
	D59QI3Q8A8lAn3EqmQuCqwdkA8PIBkcSwZmNKrq/A0O3V+t664/3HFfNql9Bl1+MH8B83ij0+Vv
	yzMMfrFiEfmXodbhNdOUAwrg/KQ9UlvmFdoHHnIz3Z08IcNNkhWicN7/osWVe/9r4rVZIGCSQK/
	1ujl3JTAdrItono4ejhxxioIwwfZMgD++id+06LbYpCcrFGOJ2MPHTAtq8mLw8nhR1EVf0c9mtU
	8xxbqWOC1D60HGb0J/N+luy9u
X-Google-Smtp-Source: AGHT+IH0cam5xu4pPnpjz/1Cf1EydOtBa1ogwwcIIWyeqhm8UBJU/HNcNuKGH+DhLkRJnMXn2xW7LA==
X-Received: by 2002:a05:6a00:a26:b0:730:8a0a:9ef8 with SMTP id d2e1a72fcca58-734791ab253mr8109116b3a.22.1740520862775;
        Tue, 25 Feb 2025 14:01:02 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f912fsm2114122b3a.61.2025.02.25.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:01:02 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>,
	Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] platform/x86: Add Lenovo Capability Data 01 WMI Driver
Date: Tue, 25 Feb 2025 13:59:54 -0800
Message-ID: <20250225220037.16073-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225220037.16073-1-derekjohn.clark@gmail.com>
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds lenovo-wmi-capdata01.c which provides a driver for the
LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
enabled hardware. Provides an interface for querying if a given
attribute is supported by the hardware, as well as its default_value,
max_value, min_value, and step increment.
v3:
- Add as component to lenovo-wmi-other driver.
v2:
- Use devm_kmalloc to ensure driver can be instanced, remove global
  reference.
- Ensure reverse Christmas tree for all variable declarations.
- Remove extra whitespace.
- Use guard(mutex) in all mutex instances, global mutex.
- Use pr_fmt instead of adding the driver name to each pr_err.
- Remove noisy pr_info usage.
- Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv.
- Use list to get the lenovo_wmi_cd01_priv instance in
  lenovo_wmi_capdata01_get as none of the data provided by the macros
  that will use it can pass a member of the struct for use in
  container_of.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 MAINTAINERS                                 |   1 +
 drivers/platform/x86/Kconfig                |   5 +
 drivers/platform/x86/Makefile               |   1 +
 drivers/platform/x86/lenovo-wmi-capdata01.c | 140 ++++++++++++++++++++
 drivers/platform/x86/lenovo-wmi.h           |  19 +++
 5 files changed, 166 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf7f4fce1a25..f6d3e79e50ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13157,6 +13157,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 F:	Documentation/wmi/devices/lenovo-wmi-other.rst
+F:	drivers/platform/x86/lenovo-wmi-capdata01.c
 F:	drivers/platform/x86/lenovo-wmi-gamezone.c
 F:	drivers/platform/x86/lenovo-wmi.c
 F:	drivers/platform/x86/lenovo-wmi.h
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 875822e6bd65..56336dc3c2d0 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -475,6 +475,11 @@ config LENOVO_WMI_GAMEZONE
 	  To compile this driver as a module, choose M here: the module will
 	  be called lenovo-wmi-gamezone.
 
+config LENOVO_WMI_DATA01
+	tristate
+	depends on ACPI_WMI
+	select LENOVO_WMI
+
 config IDEAPAD_LAPTOP
 	tristate "Lenovo IdeaPad Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4a7b2d14eb82..be9031bea090 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
 obj-$(CONFIG_LENOVO_WMI)	+= lenovo-wmi.o
 obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
 obj-$(CONFIG_LENOVO_WMI_GAMEZONE)	+= lenovo-wmi-gamezone.o
+obj-$(CONFIG_LENOVO_WMI_DATA01)	+= lenovo-wmi-capdata01.o
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/platform/x86/lenovo-wmi-capdata01.c
new file mode 100644
index 000000000000..0fe156d5d770
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface provides
+ * information on tunable attributes used by the "Other Mode" WMI interface,
+ * including if it is supported by the hardware, the default_value, max_value,
+ * min_value, and step increment.
+ *
+ * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/component.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/gfp_types.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+#include "lenovo-wmi.h"
+
+/* Interface GUIDs */
+#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
+
+static int lenovo_cd01_component_bind(struct device *cd01_dev,
+				      struct device *om_dev, void *data)
+{
+	struct lenovo_wmi_cd01 *cd01 = dev_get_drvdata(cd01_dev);
+	struct lenovo_wmi_om *om = dev_get_drvdata(om_dev);
+
+	om->cd01 = cd01;
+	return 0;
+}
+
+static void lenovo_cd01_component_unbind(struct device *cd01_dev,
+					 struct device *om_dev, void *data)
+
+{
+	struct wmi_device *om_wdev =
+		container_of(om_dev, struct wmi_device, dev);
+	struct lenovo_wmi_om *om =
+		container_of(&om_wdev, struct lenovo_wmi_om, wdev);
+
+	om->cd01 = NULL;
+}
+
+static const struct component_ops lenovo_cd01_component_ops = {
+	.bind = lenovo_cd01_component_bind,
+	.unbind = lenovo_cd01_component_unbind,
+};
+
+static int lenovo_wmi_cd01_setup(struct lenovo_wmi_cd01 *cd01)
+{
+	size_t cd_size = sizeof(struct capdata01);
+	int count, idx;
+
+	count = wmidev_instance_count(cd01->wdev);
+
+	cd01->capdata = devm_kmalloc_array(&cd01->wdev->dev, (size_t)count,
+					   sizeof(*cd01->capdata), GFP_KERNEL);
+	if (!cd01->capdata)
+		return -ENOMEM;
+
+	cd01->instance_count = count;
+
+	for (idx = 0; idx < count; idx++) {
+		union acpi_object *ret_obj __free(kfree) = NULL;
+		struct capdata01 *cap_ptr =
+			devm_kmalloc(&cd01->wdev->dev, cd_size, GFP_KERNEL);
+		ret_obj = wmidev_block_query(cd01->wdev, idx);
+		if (!ret_obj)
+			continue;
+
+		if (ret_obj->type != ACPI_TYPE_BUFFER)
+			continue;
+
+		if (ret_obj->buffer.length != cd_size)
+			continue;
+
+		memcpy(cap_ptr, ret_obj->buffer.pointer,
+		       ret_obj->buffer.length);
+		cd01->capdata[idx] = cap_ptr;
+	}
+	return 0;
+}
+
+static int lenovo_wmi_cd01_probe(struct wmi_device *wdev, const void *context)
+
+{
+	struct lenovo_wmi_cd01 *cd01;
+	int ret;
+
+	cd01 = devm_kzalloc(&wdev->dev, sizeof(*cd01), GFP_KERNEL);
+	if (!cd01)
+		return -ENOMEM;
+
+	cd01->wdev = wdev;
+
+	ret = lenovo_wmi_cd01_setup(cd01);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&wdev->dev, cd01);
+
+	ret = component_add(&wdev->dev, &lenovo_cd01_component_ops);
+
+	return ret;
+}
+
+static void lenovo_wmi_cd01_remove(struct wmi_device *wdev)
+{
+	component_del(&wdev->dev, &lenovo_cd01_component_ops);
+}
+
+static const struct wmi_device_id lenovo_wmi_cd01_id_table[] = {
+	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
+	{}
+};
+
+static struct wmi_driver lenovo_wmi_cd01_driver = {
+	.driver = {
+		.name = "lenovo_wmi_cd01",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = lenovo_wmi_cd01_id_table,
+	.probe = lenovo_wmi_cd01_probe,
+	.remove = lenovo_wmi_cd01_remove,
+	.no_singleton = true,
+};
+
+int lenovo_wmi_cd01_match(struct device *dev, void *data)
+{
+	return dev->driver == &lenovo_wmi_cd01_driver.driver;
+}
+EXPORT_SYMBOL_GPL(lenovo_wmi_cd01_match);
+
+module_wmi_driver(lenovo_wmi_cd01_driver);
+
+MODULE_DEVICE_TABLE(wmi, lenovo_wmi_cd01_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/lenovo-wmi.h
index 113928b4fc0f..07fa67ed89d6 100644
--- a/drivers/platform/x86/lenovo-wmi.h
+++ b/drivers/platform/x86/lenovo-wmi.h
@@ -45,6 +45,22 @@ enum lenovo_wmi_action {
 	THERMAL_MODE_EVENT = 1,
 };
 
+/* capdata01 structs */
+struct lenovo_wmi_cd01 {
+	struct capdata01 **capdata;
+	struct wmi_device *wdev;
+	int instance_count;
+};
+
+struct capdata01 {
+	u32 id;
+	u32 supported;
+	u32 default_value;
+	u32 step;
+	u32 min_value;
+	u32 max_value;
+};
+
 /* wmidev_evaluate_method helper functions */
 int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instance,
 				    u32 method_id, u32 arg0, u32 arg1,
@@ -52,6 +68,9 @@ int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instance,
 int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instance,
 				    u32 method_id, u32 arg0, u32 *retval);
 
+/* lenovo_wmi_cd01_driver match function */
+int lenovo_wmi_cd01_match(struct device *dev, void *data);
+
 /* lenovo_wmi_gz_driver notifier functions */
 int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned long action,
 				enum platform_profile_option *profile);
-- 
2.48.1


