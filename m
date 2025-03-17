Return-Path: <linux-kernel+bounces-563425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C35A6419A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A751890660
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1421A451;
	Mon, 17 Mar 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4/XMUOC"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AE219A75;
	Mon, 17 Mar 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193242; cv=none; b=RawwVkeaMkKL3KgtrpviLe0Hp8MEagdWV2ieVGhzJ31uE0V5cUDE/asjkr549btu3iDv0C9eCoTa0TJAF3XUWbka0A8uCRIMyFhFjzu6jtbU3dVtYC1RqT0YLxDQ3I+FNRQ5rx3x8bHGaB1i5fyrXgq59km91IOWSwBGsSO7/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193242; c=relaxed/simple;
	bh=KgiKPY1et3L31Ex3WiDa3YGM/BuIGMmENVw5pJgedpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcXhTV0iT2yJv0fRvuLbOj4lu8DK8Ai02VaeG9Sb2917N+zdmh35kyyFWUZGUxDymPrZ8mGesGDR8zVchpHaplZI47bwCq8ZPQjUtHgk2X4Dk6TlumtOB4BJbOz5XuWDKgs/CQLbNe3hhTaUmJK9Fzp/I9xvadErZKCp+0lAY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4/XMUOC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso2204633a91.3;
        Sun, 16 Mar 2025 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193240; x=1742798040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAaxM7h2XIfL3QF5kjrKx1uZwv8q2oTQ36iUldCvr4Q=;
        b=V4/XMUOCi1wz27rhDyfJYIUU59RKWuCZ8U1ai7LHKuJl2JuPv9brx8Pm3CHlvfxqYy
         DTwn/8HUW+1gU9q/Ix7QphhUXYE4b33GU0hrUx3KEypoPgGLgBClWdexHYrfrPC/Vqg6
         wcJO1vhihQePkY8azDHNuooovxnpsxwQRTFAa/pUadPbwnKNO5BnE8jvT/8s+RZG8PTM
         9a8C38q7iE8wA8Ri64Cd//yoYy++C88gWqp5vLMoPGaFvyDW09YIr/vRn8g6jHumgqpk
         lT0ZbWR/nJ5zzlgHxZ86c7Ur7N7YKKZEI68v8IJjMFbTxtxI/kzDcMxH4K9F5j5m+CPh
         w0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193240; x=1742798040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAaxM7h2XIfL3QF5kjrKx1uZwv8q2oTQ36iUldCvr4Q=;
        b=J7HudIG65Xk+HbR0HhEUbyiTTFJEiw66q4Kp/0Yc9pwJeRBz6hPpHAjSZ5J5NrGWDQ
         UGmEqL5gN7kJY44Mk3gBxvZGLgsXHctjfM38hGPc+1if6NLc1Ic5OV7guKXQ5+72z0Dm
         7bZ6ETfuNmRlE3FnIK7kdOcUt942KZ19y0UCB7dgbEavc/diop1TLWK4NHsXz7U59QQe
         yQtsFxMv9Vl2eHZ3VE1CHFWCxVfCX5R4j+umKuUc43OlIpl/wpimGl5qKVOM0fAOEd4l
         DvqVmYZ7AAw6H5qfTWoIUmuNAEw4LpjeYb6hpLm+1b3PjFLB2IHkVsx4pMszkxWo1Ctg
         10Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVGOzwJEF/Rolc3qZxIQjyCHNRpzfSWcFOg4Yjj+DUmOZ+jmK9ZTw6+LrEGddNKD9JH12Aa+sZSU444FRvU/hdYl77npw==@vger.kernel.org, AJvYcCW8JXVn0lPuhptnw66Fp9hl5mFtT32qJUKaRC3j6w19p9PWf9NjZk18QNyGvq//UcviOGNBTr7rY5qmA3PJ@vger.kernel.org, AJvYcCXa+2VEuDcnbF+wcx6fzSxKerfSmA9D0MrG6r6BpGTVVIieMB3hHnxMzE3h6qefAPX0YzHZWUd082g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+Qc8ZmxugrbYHpx99LYCy5qd6K/lilP5fvOBo9VRp6mvHVpP
	uiaL0R5sK466IVf9cmIE9h2xT+GrSkg0RaTYXQTM1sNqv0K6KBG7Ln2Fn6aRg1o=
X-Gm-Gg: ASbGnctJ7i8gll/vamJMV+WtO4xX7mh5p6RS+PEaYCPhZL7awvC43FQ3l80t2fySQH7
	w4TYsjVs7lIHgioIw3A//bfgS3cC5H3ozWhIF9ynpdBsUHmCYVI2be7cskJadjspCdvw7zunS7z
	oyThHKi5Ui/pX22JLrOMvGHm6neOMRqpOPEH1JRYOgaKQUE6X0rT8E9SCD44i3m1jPKbPKh5mtb
	a/1k+0yYFm4L/FXtQUpsG2nPFDskM+vpn45JcvvrhfHhfr0B92WmePnDFDxbwWnQcfaEeXx6NsZ
	Os5l6zVQ2lOlKEDWzwXjIoYseWU7fJUIfBa1NA5/LVX7oabTjIVhQrlu6c5DBARVcpc01A1y1yI
	i3eewHoDtnLi+rlXKpZBtEIv3ebpXsM5lrO3fajlNEZk=
X-Google-Smtp-Source: AGHT+IG4QBX+tGPO442IKKVzvF/Drz3cUj/i2K8eYZGCO+7fFSUy6vupN3fPK0iAt58bgba1r75iGQ==
X-Received: by 2002:a17:90b:2752:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-30151aedbdbmr16386297a91.0.1742193239969;
        Sun, 16 Mar 2025 23:33:59 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:33:59 -0700 (PDT)
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
Subject: [PATCH v4 1/4] platform/x86: Add Lenovo WMI Events Driver
Date: Sun, 16 Mar 2025 23:33:29 -0700
Message-ID: <20250317063337.352966-3-derekjohn.clark@gmail.com>
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


