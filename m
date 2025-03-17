Return-Path: <linux-kernel+bounces-563430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29AA641A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C492516DE70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B389219A8D;
	Mon, 17 Mar 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG1AFzek"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D59219A70;
	Mon, 17 Mar 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193249; cv=none; b=gxEcVZtn//X8l8kAfNp9MS4+urtCC1F+Su31WkZ5fXtUuYCDA2Ux65/ZeL6WEfnsMnPXVz7wNfXfgy0MAWq4yHFO/pqfYsEmgM5xMkVPVGfNLPZfie397xuqfoYSKzvX+ea+cPNh6yKh0DpeKXKLbp6rofnq0ggXL3J2huW1x60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193249; c=relaxed/simple;
	bh=QtJuuApcIxOnqq0q7ztcDfW6m82MqWlyJ0VShXMUOR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICCg9V3WKahF3/kfJhm/QvK/EC0hMZseBaSg0IRTZWvjP2cOiO39X2t/eoNyt6l6Dph+dKUKG3nnZYi6i3J50Dl9/P2in9e2SVThrDCEnjTVGiy7GTy+5dXC+MYFH+GFCH5810ykamHto+qLNlyCfKH6zdw8oTRTGPZxLGOJXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG1AFzek; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso2567807a91.1;
        Sun, 16 Mar 2025 23:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193247; x=1742798047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg3kUIYAZxHueF9SBco9xBAfkg5dY1set7XtTII34e0=;
        b=BG1AFzek+top/RcR+9FGcie0sQhVlPDphEbfZNu54FShIFgw1Vt1eqF4ilaL+3Zni2
         fOkYZQIN8jsnrafloF/4PGZeap9hSoyzupEp8EAL1Zkm7B3F+MWGzqsRxF2DX4aXsNqS
         5HoTIiGLl7sjeNVGJ8bww/TPJ0RDox6DFeik2Wqx/MQS4HjVkcXA4pjhQ6dR7n90cx/q
         x/wQOHaEKOE5jojGtkllnlL2jGMD6KaIXgcHAA73zuJwRJW7abZhITYeVS9fi90IQn4r
         tId2kuGHN0Mr+9Vjy9p4RRjxDN+IRBVRHDemxPzP4glCoUxjwwx5hxDoTVKC4CVajWwC
         A6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193247; x=1742798047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg3kUIYAZxHueF9SBco9xBAfkg5dY1set7XtTII34e0=;
        b=Uj/oSNGroqX1//XA8Enxo4739+3BrUaGOsrvZBpocKICr3A8gNkpYVZo8PSMEtOTWb
         zqexlnadJxJ689rjK2Tm6ro8DQMbb0g/lvdaZYwxuzuvrK9/Wpmzb1TQbGPs/FhanLzl
         yQGe55aR+7HHyubwlgcRk7ZqGzKi8Wj6mVNyTeRbqi8SwQWAKgpBm+RZ1ABuxruXMwsS
         q4/AnEkuCiY/ibXq2LmR92bDuo1L+XvI2qQpTOetE9+XItSqYaH/BXDmAznUGLIEaQWN
         bgYYQEr0WGGumkb7aRz8ri1GSG6h/kcIuo+meWlfBnuoSTvUIgmFLP8Jah0WIQCqI5Cp
         lafA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHVbmd1w541WVF/gbd315u8pi7ap9M3ouBXPY54UEZePXtgCratQvyAICtiYze78+AwAt8HlAWmc=@vger.kernel.org, AJvYcCUalZf6goonNI2oHTMJ83vdHUyy1VECfufOarVlWWmgpd/sZsRaxq9+bVKAMAmIFntRkElOid92ZLR1EVOSQFLGOBNmGg==@vger.kernel.org, AJvYcCWUBV9MAx02mzylfiXjZe7t2tke1cz8xTqzYz6aGUuYrvexzggvS3h4ag9QcNdCMRupt2dNR6Lq4XBtojWm@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFDAh+UvhejiMNY7tnUjUbfJfPVtnbj1ZFBMQUeia3sEkAUxU
	CfGGLZHO9+0OlCi20od/itFeHVbfbkn/pvVx1smLKMHP5iJbwuaS
X-Gm-Gg: ASbGnctpWrNWpyG7F9Ndzrp2d2EIlkEYnz5VpLlnVsODMazhFYvGh/97LkqgODCOn1w
	pySOR9e2G0OeAb3+iWP6Xyo7EzG16DsstFhfoqGCMfBPINJQlAkOZ+YmFW4CzTX7LD3eJn5BQPQ
	08D9ghigV7+Qv77YcKRjEcmc65KqqwJrKmw9QscPVvueWe3uCKGixDfAHU5NIFjOBNoKf9t52H1
	4Y17vd21Q3e7NzIMG2OQrTPjluTaUjy41JAJZNkzixulAa+Do6TZ0YtX3rn9teLDR3t1n6RB1tq
	1mF7p2ikplZ/SvPcq3Saonrrxj4lGSFL4xD3ql/rcc9Jrm0A/ulSNsJGrfcvJoz65KV99NHjkRq
	kgUwiARDfECI+C2fF6vmLP3CKa7by+tnDfKV9mEr0X9HVdLMFA3g9SA==
X-Google-Smtp-Source: AGHT+IGth3ldPd6INVG7H7hRFPdKq6PwvOCUmeBRF1tGAyGIXRjLDrM3zkhkK2KkNsqCZSYNUzIq7w==
X-Received: by 2002:a17:90b:264c:b0:2ff:5267:e7da with SMTP id 98e67ed59e1d1-3015211de7dmr12914921a91.3.1742193246548;
        Sun, 16 Mar 2025 23:34:06 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:34:06 -0700 (PDT)
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
Subject: [PATCH v4 4/6] platform/x86: Add Lenovo Capability Data 01 WMI Driver
Date: Sun, 16 Mar 2025 23:33:34 -0700
Message-ID: <20250317063337.352966-8-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317063337.352966-1-derekjohn.clark@gmail.com>
References: <20250317063337.352966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds lenovo-wmi-capdata01 driver which provides the
LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
enabled hardware. Provides an interface for querying if a given
attribute is supported by the hardware, as well as its default_value,
max_value, min_value, and step increment.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
 - Make driver data a private struct, remove references from Other Mode
   driver.
 - Don't cache data at device initialization. Instead, on component bind,
   cache the data on a member variable of the Other Mode driver data
   passed as a void pointer.
 - Add header file for capdata01 structs.
 - Add new struct to pass capdata01 array data and array length to Other
   Mode.
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
---
 MAINTAINERS                                 |   2 +
 drivers/platform/x86/Kconfig                |   4 +
 drivers/platform/x86/Makefile               |   1 +
 drivers/platform/x86/lenovo-wmi-capdata01.c | 136 ++++++++++++++++++++
 drivers/platform/x86/lenovo-wmi-capdata01.h |  29 +++++
 5 files changed, 172 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dde75922aaf..56ead241a053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 F:	Documentation/wmi/devices/lenovo-wmi-other.rst
+F:	drivers/platform/x86/lenovo-wmi-capdata01.c
+F:	drivers/platform/x86/lenovo-wmi-capdata01.h
 F:	drivers/platform/x86/lenovo-wmi-events.c
 F:	drivers/platform/x86/lenovo-wmi-events.h
 F:	drivers/platform/x86/lenovo-wmi-helpers.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 13b8f4ac5dc5..64663667f0cb 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -467,6 +467,10 @@ config LENOVO_WMI_HELPERS
 	tristate
 	depends on ACPI_WMI
 
+config LENOVO_WMI_DATA01
+	tristate
+	depends on ACPI_WMI
+
 config IDEAPAD_LAPTOP
 	tristate "Lenovo IdeaPad Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index fc039839286a..7a35c77221b7 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
 obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
 obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
+obj-$(CONFIG_LENOVO_WMI_DATA01)	+= lenovo-wmi-capdata01.o
 obj-$(CONFIG_LENOVO_WMI_EVENTS)	+= lenovo-wmi-events.o
 obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
 
diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/platform/x86/lenovo-wmi-capdata01.c
new file mode 100644
index 000000000000..b6876611ffd9
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface provides
+ * information on tunable attributes used by the "Other Mode" WMI interface,
+ * including if it is supported by the hardware, the default_value, max_value,
+ * min_value, and step increment.
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/component.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/gfp_types.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+#include "lenovo-wmi-capdata01.h"
+
+/* Interface GUIDs */
+#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
+
+struct lwmi_cd01_priv {
+	struct wmi_device *wdev;
+};
+
+/*
+ * lenovo_cd01_component_bind() - On master bind, caches all capability data on
+ * the master device.
+ * @cd01_dev: Pointer to the capability data 01 parent device.
+ * @om_dev: Pointer to the other mode parent device.
+ * @data: capdata01_list object pointer to return the capability data with.
+ *
+ * Returns: 0, or an error.
+ */
+static int lenovo_cd01_component_bind(struct device *cd01_dev,
+				      struct device *om_dev, void *data)
+{
+	struct lwmi_cd01_priv *priv = dev_get_drvdata(cd01_dev);
+	int count, idx;
+
+	if (!priv)
+		return -ENODEV;
+
+	count = wmidev_instance_count(priv->wdev);
+
+	if (count == 0)
+		return -EINVAL;
+
+	((struct cd01_list *)data)->count = count;
+	((struct cd01_list *)data)->data = devm_kmalloc_array(om_dev, count,
+							      sizeof(struct capdata01 *),
+							      GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (idx = 0; idx < count; idx++) {
+		union acpi_object *ret_obj __free(kfree) = NULL;
+
+		ret_obj = wmidev_block_query(priv->wdev, idx);
+		if (!ret_obj) {
+			((struct cd01_list *)data)->data[idx] = NULL;
+			continue;
+		}
+		if (ret_obj->type != ACPI_TYPE_BUFFER) {
+			((struct cd01_list *)data)->data[idx] = NULL;
+			continue;
+		}
+
+		if (ret_obj->buffer.length != sizeof(struct capdata01)) {
+			((struct cd01_list *)data)->data[idx] = NULL;
+			continue;
+		}
+
+		((struct cd01_list *)data)->data[idx] =
+			devm_kmemdup(om_dev, ret_obj->buffer.pointer,
+				     ret_obj->buffer.length, GFP_KERNEL);
+	}
+	return 0;
+}
+
+static const struct component_ops lenovo_cd01_component_ops = {
+	.bind = lenovo_cd01_component_bind,
+};
+
+static int lwmi_cd01_probe(struct wmi_device *wdev, const void *context)
+
+{
+	struct lwmi_cd01_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->wdev = wdev;
+	dev_set_drvdata(&wdev->dev, priv);
+
+	ret = component_add(&wdev->dev, &lenovo_cd01_component_ops);
+
+	return ret;
+}
+
+static void lwmi_cd01_remove(struct wmi_device *wdev)
+{
+	component_del(&wdev->dev, &lenovo_cd01_component_ops);
+}
+
+static const struct wmi_device_id lwmi_cd01_id_table[] = {
+	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
+	{}
+};
+
+static struct wmi_driver lwmi_cd01_driver = {
+	.driver = {
+		.name = "lenovo_wmi_cd01",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = lwmi_cd01_id_table,
+	.probe = lwmi_cd01_probe,
+	.remove = lwmi_cd01_remove,
+	.no_singleton = true,
+};
+
+int lwmi_cd01_match(struct device *dev, void *data)
+{
+	return dev->driver == &lwmi_cd01_driver.driver;
+}
+EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD01");
+
+module_wmi_driver(lwmi_cd01_driver);
+
+MODULE_DEVICE_TABLE(wmi, lwmi_cd01_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.h b/drivers/platform/x86/lenovo-wmi-capdata01.h
new file mode 100644
index 000000000000..c7067a8d0398
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-capdata01.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#ifndef _LENOVO_WMI_CAPDATA01_H_
+#define _LENOVO_WMI_CAPDATA01_H_
+
+#include <linux/device.h>
+#include <linux/types.h>
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
+struct cd01_list {
+	struct capdata01 **data;
+	int count;
+};
+
+int lwmi_cd01_match(struct device *dev, void *data);
+
+#endif /* !_LENOVO_WMI_CAPDATA01_H_ */
-- 
2.49.0


