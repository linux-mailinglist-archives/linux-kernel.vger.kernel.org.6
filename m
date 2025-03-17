Return-Path: <linux-kernel+bounces-563426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A5A6419D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1E316D9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00321ABB1;
	Mon, 17 Mar 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk2ILcxR"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E721A424;
	Mon, 17 Mar 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193243; cv=none; b=X88rDBA3ifQJGIvaHKm6ae32AWbQSbPkyxeaKeGkiEunJoSHd9YgJMOX8//7iZ3f1WFM58flNOvgToGlfVTJS3+LymaMfWp1m1aRhKudoVPX/yZBnnOdas1wzJrEGiv6axLOYnznPUvG6Glo59foU8Ue58J94iTlrz/Clfir+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193243; c=relaxed/simple;
	bh=QtJuuApcIxOnqq0q7ztcDfW6m82MqWlyJ0VShXMUOR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWxBKENJC6yPOQ9GR2dcE7dsahHCUuRyODzMEyUC6kNfbNCbBAeFcBqNhf0CXuRLSb0cHcvp1vxB9f/kHSsg24Knev9ykzQ1lo/TsgHRI2Qe5a4WiOq5LQozyxZXRi9TRlKYkJHCZ0jB68n9mMsU7o68SqsqGp5Tw7zdH7lM4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk2ILcxR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so3388774a91.3;
        Sun, 16 Mar 2025 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193241; x=1742798041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg3kUIYAZxHueF9SBco9xBAfkg5dY1set7XtTII34e0=;
        b=Vk2ILcxRtga3gfyIzJ/EH4u5yrLsw6ZEjpAZQSxAGU9nauewv/6/iFZjv2mVeTows1
         rhV8PHG0inSuinU+a6FD/2HMLZm1WqEDx8vN/1J6w0CT34uASRoaSiB9alvez+Y+seMR
         ZUjgo0MieqKFZrewf29cun4EjI9ArTTVyxvW6NYqQWDzJ31fytvRoDpST2hUYCQ58Xcg
         8oxiN2u7fnaFYnxaDA54x3G91p/BvTlcgip/7x7R8fhlEmbChqZRsJJI3DWsALgbvWSf
         3sgY+Uu+z92xIln4JAr6Z/8OBOoVaq+LQxtlOJuSfCykA8yDxmKJ52sUc0hJB8Wc7Dhw
         0zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193241; x=1742798041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg3kUIYAZxHueF9SBco9xBAfkg5dY1set7XtTII34e0=;
        b=MDJH/QX0jwfw3cv1SroPqVHAJdn2nYRybunmgjwuG+zg9KiUTAyCxHdugTmIvs4EG+
         07ay8wfXfYN7f1dJOiu/Xkg1MXOeXan1rWjmlkTYYD3BwYcimxURuoCHhoVun0blwnki
         Tfi5NtOhyM951Q2H9rTeSsNJzbPAIKfeREUrAN+LAlDYEpQwJE0kCBPZG9t3KtlHJzba
         AStLtWbONDUb7x9Bqa95+iLvd2jAbEFein0tDXGZVEpuWqByBW1ndBiudiNBuETdyQ/X
         7FGwZC8GOYiQwBvfAhH2whM/+F/DYPvS2drikaKO1S/SROVXASFhOD+GblIhY29VMW+f
         Mmew==
X-Forwarded-Encrypted: i=1; AJvYcCValampmLuyOfAezFdTJKV/qtEVraIxTWAxmeuRjZ9vwwHxgJsORBF1xwNEgalORUrSRrTvbDJtuYePFOjX@vger.kernel.org, AJvYcCViKiGg/QNKk6/UwgtWpavEjZjDDakw0bJ7HgdGyR3vo2qkWtgxrk39zgXkb9OxI7iE3Fi7BaJPuV9bdO9acFgimUx5jQ==@vger.kernel.org, AJvYcCWD3+ufU4T2Xwn+oP4mENT23IqxEveVwkQp+IwZkrbIu9J6tyiM/o0DoYhefLEF2xtbR5x70VydH88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaT4qKA+jG/Ss9LV6960owl/2DT6mCfu/02naVAft6VMa+MAR
	kmAKC1JixspFWi7TG/MqgIcS+KfsxzE20bY/xIdwQwj910bcEnsn
X-Gm-Gg: ASbGncsKnxw8F1BGXf+Q2At83Dk9JMlTAmB97HJiPl4VRi6yG1FgdqUkhQSW5zbYitK
	DFYoxWV84opJhtPk/BxzTBMnUt+ikW2LpyczG/8XiLaCAy9/DCVn80uxezdjYDl3tueFuyXu+M+
	REj5fjCOw4aXp2UGU2SBhg1OFBfKqWTWYkh4ZL/IS5FL+RheAo/w41AEi+NLd1fI4bVBzymtXxG
	dPaOCVJW+ibRP6sxP43uWyzYW2Qya3MYerufXRzsum/U4BZhpGddkb6fN9ma+0CUu8VaAaeX1tp
	Km/yx89ZJWEH5d0Zu2YKa3sBkZunILXRXyMymvW8vlzoEWhZZqNWsbTvtJ4w5uoIt6mhSwzxhrB
	CxO5O/3KxpNM/llz6/25lZFH9PwHO+H2ZN5DokLR7K8KNJS8NMMa/+Q==
X-Google-Smtp-Source: AGHT+IGfx0gol1Jl5nAIqn7x0EsJqxsKJH+ctm2D792o3MdKDujOkZ1RtprV1ca8NchQmdIV5sxKmw==
X-Received: by 2002:a17:90a:fc4c:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-30151cc9323mr12804556a91.19.1742193241300;
        Sun, 16 Mar 2025 23:34:01 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:34:01 -0700 (PDT)
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
Subject: [PATCH v4 2/4] platform/x86: Add Lenovo Capability Data 01 WMI Driver
Date: Sun, 16 Mar 2025 23:33:30 -0700
Message-ID: <20250317063337.352966-4-derekjohn.clark@gmail.com>
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


