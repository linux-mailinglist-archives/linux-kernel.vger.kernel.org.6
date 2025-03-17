Return-Path: <linux-kernel+bounces-563429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C754BA641A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86947A5D15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808021B18A;
	Mon, 17 Mar 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+fzXS1V"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009921ABCB;
	Mon, 17 Mar 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193247; cv=none; b=Suhxex6JByTHqregnXDwQQoSJlhpeAAFjkzj9XJ/TnlI4CQDnicjC66G/XXF4613GCI3ziTlFX0ZylCv/EprmhwOYzA7jjYgoFHSf5get9zW0+cgXiZvsf0EONUBnJcVT0sjMj+tH/i02T3btTsWjK+1sgSLLhm53sPk1jI6Rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193247; c=relaxed/simple;
	bh=KgiKPY1et3L31Ex3WiDa3YGM/BuIGMmENVw5pJgedpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHtp54nQECS7BDu4fojJ3txlTWnhzRvO8TnZCHIADkz8hXqVTC+hKqkyPc/6F/I236B9zOkQVA0W1DKTdf0bwq4bz7waphuU/iP+iTWiM+Y9a+KDyA1miZWrI2gtQouQFGXTZHfUZH4knYJRJE8XbRDEGPlQZ96FCaPX14JHV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+fzXS1V; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso1837330a91.1;
        Sun, 16 Mar 2025 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193245; x=1742798045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAaxM7h2XIfL3QF5kjrKx1uZwv8q2oTQ36iUldCvr4Q=;
        b=d+fzXS1VTjvXXeL/Jy+EqRf8gWZq2S9hMZuSS6wAW9VWfpRDKYWHg+rhR7fCRyHN1E
         2A6rZmggO2JKuYDLwG/IAYhRK7E41Qg3bRRfiKUowJbtKd6p5zWFfvKhpJhOwi+w+cBp
         7YEF9qEbn66LnWjAREzJeCAOowELrN/zpzAHcES3YYnG00Yr9N4eA843ksxBzt3WoBuE
         8fCyb9WZpKk1zdI8B9+LAd+h5PYcRnLT4bAoNtxjIkMaZH+G8myaVrrkFyF/30ikJYzS
         MawKPGNi+ZNmePYdsH+pdJaKgqqqSILyM7x1JN8lQiRoj4WIcEoris5LRvcDAXZ0ukzl
         +Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193245; x=1742798045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAaxM7h2XIfL3QF5kjrKx1uZwv8q2oTQ36iUldCvr4Q=;
        b=VVUf8tl/cWBQcLAdsi5q08Q/BxHrlV2tXwPgUZDHIQtiMofZKzd9XNvbTdKObkHj36
         lLCH/Z9O+USjkQyTjw6cFGXB0rwlabo9tH/dAXBMqJslHkezKjp4CkYoxH1Mb3oWeDc8
         9pcotSwmmyju1IVwzneU1BcW8I0pa+tPGtVZTbbeOdcgRCfwF/pit0lhFKRJHjlJBcnd
         96+k5JwOKfY0UYiOlpEqA32ukrnGmjCxbBwmwjZ2IQGVc4K0GWfivANWCdZYjKPJQAK3
         QJCUW1Ye7afvaMn7yTpAQjwvM7HCnPLJVYyfbFpQtPlU541kzH5fFPqRXy/ACmL05vhY
         36Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV9l3YN0uvHjQBqDDdebAWJUky+8BUaOgjpuRXe4LAFxT6pO5SW3AInw0hkphjp37J8BBbgrezypvU8Z1z+@vger.kernel.org, AJvYcCVOVFAbz2JX6eT8CtBWDba+Z3wMMi1L+w7bb6v/rpzCFYNY/neiERW3Qjz2QJcE92t+g6wMcp6S5Uc=@vger.kernel.org, AJvYcCWGR3ygdwit7k6FAwWmAKRfJT3v+7l+9r3i1u6NBmTSLck8sO1SlIol7CkvXKZZLlClA7xkSKnmlk695pedfIohOVOjpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmjO3sbcMuzBLIpjqASpPDjrSFzpKvTRqB6ZDEqFmTy/Iyovj
	/eowoXRnGi3d7bE34Iifg2eUq2Tb1fjI3j71S64X8HbmX23kq22n
X-Gm-Gg: ASbGncvxiIK4xQhguFW8QHZ5Yp2jSE4GfHI0rgRpeqimhkgepK8VZcBg0qYK7eK+8wd
	2IdWvbKx3f13QKvxtb+jEp5WMIkK+ZLRVuJ/nrgDv7vREx2LdSOwt/L70BIs9YK5Nit6WwNpHkn
	NNi/36ybykAAA0zNChUcwL8AYaUbWuldT2U6GGfY2CUvyB+2oD8Jd+5H5UE/vTffq/bPnR9BRYP
	Sjr3PjqimnIPhj7PsvIVffguMMbacg3MDk1Wjjw2o+63WH7835X7QE3CqFH5Uev4fdQxVmwhImY
	HnZo1BwYvNreCWVSVBmGmwUwVs53wAw5oD37J5JtYlUMFodVWjiNBRwuuWIY2vHj1L9q7WpYVH7
	8LCEjCG0cIVs+jmsIUpdzxJbbHAKK4wm4rMJ9V29GT2M=
X-Google-Smtp-Source: AGHT+IG+ClIaPaW5PWE1pfCmAjhBZ/BTfDyb9OWmoHZxgJVGHvtjD/DT/t+2PzWDPCI272fPs3GYxw==
X-Received: by 2002:a17:90b:3d50:b0:2fa:13d9:39c with SMTP id 98e67ed59e1d1-30151ce324fmr16596707a91.14.1742193245287;
        Sun, 16 Mar 2025 23:34:05 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:34:05 -0700 (PDT)
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
Subject: [PATCH v4 3/6] platform/x86: Add Lenovo WMI Events Driver
Date: Sun, 16 Mar 2025 23:33:33 -0700
Message-ID: <20250317063337.352966-7-derekjohn.clark@gmail.com>
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


