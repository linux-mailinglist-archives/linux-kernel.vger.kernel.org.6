Return-Path: <linux-kernel+bounces-564395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A414A6540A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA453B4EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E624502C;
	Mon, 17 Mar 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjs8B6PE"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F224886D;
	Mon, 17 Mar 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222619; cv=none; b=OtCmbZZm9B3ZDfBIXZjk69LOk4KyjXGYGxZ2n8/GkJjimEehUyM7sjrbQczZGdN0LW72Ez/zkXuGw/HXXtevQZbUKv4mshc4Rae6ZsPJriZIzw1DsycCQlPNFwXjy7xSOy4fN+Vee7HbBDHYy7ZK6CV6LOXnO+7pNhfo35r+WtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222619; c=relaxed/simple;
	bh=KgiKPY1et3L31Ex3WiDa3YGM/BuIGMmENVw5pJgedpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1dJohVT4TJsD66BjdmZ2Hj4Ryd9+k+PsMtRHiHNVI0B85u3sgqA5q1BOfu20DQFyr+FP+RIW5/14m4wPCSWdGLHZhiLer1d8X92A+VqE79umyH1FbcjZAO3wBnnpN1qDOFF3CS81q0RUkAhbsRoUX/H4qNCsVIgciMNNt0f4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjs8B6PE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso53990855ad.0;
        Mon, 17 Mar 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222617; x=1742827417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAaxM7h2XIfL3QF5kjrKx1uZwv8q2oTQ36iUldCvr4Q=;
        b=gjs8B6PEedCN2Omr86Qs4oCpLrlCFKO5VNhyZqa2p1/i+aSva4bhlXrcvOghComX8d
         kopwRA3EjOUXv6GRVMlqeuYemOqRKEnHP14cRy5yEsAmZTqVUxwSg3WQcO0QPUumbmAW
         h/JvFwDbZiyZyC/uiQ9PfXhB4w1eHuRel5igu4h9W8J0qOU6KoZdYVDOmIA4AgmpLiKY
         kgOSDdJMdfCzt+wehcoWJHlIkrh4k81e6f9RABc7k93ZlX1HmbLBPh4kFOYv1ULkaIWJ
         TkzP/ogLbSgEijexQz319ijXML/GZg+vSxAlyyKrvXHj3oLgoFPdgWAsLIUpTfvo/EBl
         Xvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222617; x=1742827417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAaxM7h2XIfL3QF5kjrKx1uZwv8q2oTQ36iUldCvr4Q=;
        b=guLzUdm5q8JAnLtDcrd+76FvD50MbsDfskLKzSv5agIsI+q8gcwKg3RGY1VdpFl24g
         Iow9Y37XnAkdyXYat3JeXlWFacYtHpsNLhCWJ9jZ2zyJBa9WqmJ31HvMUIWYcqp1ZStO
         CqaXaW6yNZgV/y56lZLkFCigbXk/wwBKuDg/0lXNJgGVfj8QOv1nlyjz4+xLxpI1Ttnl
         bywGGat6aozpyeQrxJrUa0m3kSynuiYjToHkTnPJ762Bqfj1kGvOG9e+W8GgAiPvg46X
         RwiWMZhuCR9ElgBZrip9R8c5XHp6/4qCtcGKUtj+q5RgJcnkkHZpYMGqg+g8TvOn9ovY
         JB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5sue2qG1887Pxss4U997x0+wG0PFfyinedG6SfA2CvJszGl2ihzAV6ibhPwqAUNVQZkUAFpOVG1goyunL@vger.kernel.org, AJvYcCUgB+cWVexR9sJmo6NMSBocLj+Q+XiJUbW801wFDChHh9G34ebNr8QQNwbcCXUJiI11z8Z/BU5tUenLO+T6byJ4v33ioA==@vger.kernel.org, AJvYcCV38JlnHbl9fwRI3T4FPBLTeV1ZyHK1SxTikuZJKQExhtx6Ql/bfToJCEVr1CsH54eymLUDHFF0Eew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTm3OLmjB+QOCWPcjUFfXEEyUVbgxjtOuBRw20f/aEVxh1mZN/
	0eKk/DhQYhG6pANR7KX5PVoxAlDpKM40n7V6WnFFa2ESuIj85u76
X-Gm-Gg: ASbGncus+cOniw7u4t62YK/A2ykYQ+UszFTXejQziqPzs8iresdjoOlgUplkPrTZRuv
	/iKEiWW3kFvDziIiQlydlM0Y4WU1NdejzEgdXPib+Xe6KMMn/U3iV8/n3NQotzbs5+9lXWmgyo4
	t9fgkSMPgLRCkls3+P3XbTfrZMW1bmJY9i7ISaD4DNQBPloWWRAzgA9tZJXMOA98qv6FD04anPo
	xeSFvcFk43JvKIw5uz51CtUKoS9O+Gdymo2dVA7qN2cfMoB0Y+zqvon1L+BanPkcNpwHg296ELg
	tUaUEReUw75ZZHEYOE1pH9TiQuE1jKNc7I53vhDIX7aHB9aJDA==
X-Google-Smtp-Source: AGHT+IFL3XVVCxXWmTS4kdOiDBPIWARhbhFMKf7kO63Ttcq9KjbzVBDTNjLbuuLgywtGXC2vmWrhuQ==
X-Received: by 2002:a05:6a00:99c:b0:736:491b:5370 with SMTP id d2e1a72fcca58-73722e333d4mr16328052b3a.10.1742222617316;
        Mon, 17 Mar 2025 07:43:37 -0700 (PDT)
Received: from terminus.lan1 ([2605:59c8:3484:ea20::914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e34sm7906797b3a.140.2025.03.17.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:43:36 -0700 (PDT)
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
Subject: [PATCH v4 3/6 RESEND] platform/x86: Add Lenovo WMI Events Driver
Date: Mon, 17 Mar 2025 07:43:23 -0700
Message-ID: <20250317144326.5850-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317144326.5850-1-derekjohn.clark@gmail.com>
References: <20250317144326.5850-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds lenovo-wmi-events driver. The events driver is designed as a
general entrypoint for all Lenovo WMI Events. It acts as a notification
chain head that will process event data and pass it on to registered
drivers so they can react to the events.

Currently only the Gamezone interface Thermal Mode Event GUID is
implemented in this driver. It is documented in the Gamezone
documentation.

Suggested-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
 - Remove the Thermal Mode Event GUID from Gamezone and add this driver.
---
 MAINTAINERS                              |   2 +
 drivers/platform/x86/Kconfig             |   4 +
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/lenovo-wmi-events.c | 132 +++++++++++++++++++++++
 drivers/platform/x86/lenovo-wmi-events.h |  21 ++++
 5 files changed, 160 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-events.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-events.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a370a18b806..6dde75922aaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 F:	Documentation/wmi/devices/lenovo-wmi-other.rst
+F:	drivers/platform/x86/lenovo-wmi-events.c
+F:	drivers/platform/x86/lenovo-wmi-events.h
 F:	drivers/platform/x86/lenovo-wmi-helpers.c
 F:	drivers/platform/x86/lenovo-wmi-helpers.h
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bece1ba61417..13b8f4ac5dc5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -459,6 +459,10 @@ config IBM_RTL
 	 state = 0 (BIOS SMIs on)
 	 state = 1 (BIOS SMIs off)
 
+config LENOVO_WMI_EVENTS
+	tristate
+	depends on ACPI_WMI
+
 config LENOVO_WMI_HELPERS
 	tristate
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5a9f4e94f78b..fc039839286a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
 obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
 obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
+obj-$(CONFIG_LENOVO_WMI_EVENTS)	+= lenovo-wmi-events.o
 obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
 
 # Intel
diff --git a/drivers/platform/x86/lenovo-wmi-events.c b/drivers/platform/x86/lenovo-wmi-events.c
new file mode 100644
index 000000000000..3ea0face3c0d
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-events.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo WMI Events driver. Lenovo WMI interfaces provide various
+ * hardware triggered events that many drivers need to have propagated.
+ * This driver provides a uniform entrypoint for these events so that
+ * any driver that needs to respond to these events can subscribe to a
+ * notifier chain.
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ */
+
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+#include "lenovo-wmi-events.h"
+
+/* Interface GUIDs */
+#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
+
+#define LENOVO_WMI_EVENT_DEVICE(guid, type)                        \
+	.guid_string = (guid), .context = &(enum lwmi_events_type) \
+	{                                                          \
+		type                                               \
+	}
+
+static BLOCKING_NOTIFIER_HEAD(events_chain_head);
+
+struct lwmi_events_priv {
+	struct wmi_device *wdev;
+	enum lwmi_events_type type;
+};
+
+/* Notifier Methods */
+int lwmi_events_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&events_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(lwmi_events_register_notifier, "LENOVO_WMI_EVENTS");
+
+int lwmi_events_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&events_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(lwmi_events_unregister_notifier, "LENOVO_WMI_EVENTS");
+
+static void devm_lwmi_events_unregister_notifier(void *data)
+{
+	struct notifier_block *nb = data;
+
+	lwmi_events_unregister_notifier(nb);
+}
+
+int devm_lwmi_events_register_notifier(struct device *dev,
+				       struct notifier_block *nb)
+{
+	int ret;
+
+	ret = lwmi_events_register_notifier(nb);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(dev,
+				devm_lwmi_events_unregister_notifier, nb);
+}
+EXPORT_SYMBOL_NS_GPL(devm_lwmi_events_register_notifier, "LENOVO_WMI_EVENTS");
+
+/* Driver Methods */
+static void lwmi_events_notify(struct wmi_device *wdev, union acpi_object *obj)
+{
+	struct lwmi_events_priv *priv = dev_get_drvdata(&wdev->dev);
+	int sel_prof;
+	int ret;
+
+	switch (priv->type) {
+	case THERMAL_MODE_EVENT:
+		if (obj->type != ACPI_TYPE_INTEGER)
+			return;
+
+		sel_prof = obj->integer.value;
+		ret = blocking_notifier_call_chain(&events_chain_head,
+						   THERMAL_MODE_EVENT, &sel_prof);
+		if (ret == NOTIFY_BAD)
+			dev_err(&wdev->dev,
+				"Failed to send notification to call chain for WMI Events\n");
+		break;
+	default:
+		return;
+	}
+}
+
+static int lwmi_events_probe(struct wmi_device *wdev, const void *context)
+{
+	struct lwmi_events_priv *priv;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (!context)
+		return -EINVAL;
+
+	priv->wdev = wdev;
+	priv->type = *(enum lwmi_events_type *)context;
+
+	dev_set_drvdata(&wdev->dev, priv);
+	return 0;
+}
+
+static const struct wmi_device_id lwmi_events_id_table[] = {
+	{ LENOVO_WMI_EVENT_DEVICE(THERMAL_MODE_EVENT_GUID,
+				  THERMAL_MODE_EVENT) },
+	{}
+};
+
+static struct wmi_driver lwmi_events_driver = {
+	.driver = {
+		.name = "lenovo_wmi_events",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = lwmi_events_id_table,
+	.probe = lwmi_events_probe,
+	.notify = lwmi_events_notify,
+	.no_singleton = true,
+};
+
+module_wmi_driver(lwmi_events_driver);
+
+MODULE_DEVICE_TABLE(wmi, lwmi_events_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo WMI Events Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-wmi-events.h b/drivers/platform/x86/lenovo-wmi-events.h
new file mode 100644
index 000000000000..a3fa934eaa10
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-events.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ */
+
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+#ifndef _LENOVO_WMI_EVENTS_H_
+#define _LENOVO_WMI_EVENTS_H_
+
+enum lwmi_events_type {
+	THERMAL_MODE_EVENT = 1,
+};
+
+int lwmi_events_register_notifier(struct notifier_block *nb);
+int lwmi_events_unregister_notifier(struct notifier_block *nb);
+int devm_lwmi_events_register_notifier(struct device *dev,
+				       struct notifier_block *nb);
+
+#endif /* !_LENOVO_WMI_EVENTS_H_ */
-- 
2.49.0


