Return-Path: <linux-kernel+bounces-564394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17CDA6540E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D06189692B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A57248870;
	Mon, 17 Mar 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUv2lcav"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C2245019;
	Mon, 17 Mar 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222617; cv=none; b=kxWsEbgCuRVEcl2guSW970Jbg9FEUVdv4vQ2xAJo/1DEm1GgkaEVx1T6QQgg/arfE6fEZbf0B7ajvcF7uk0Oluu7eep+jysPcmaahV23YPbJIW6j3YSvh7H6Ifx3Vw7PXiHU+g5m+Rlu85VQzmF/OaqAEdj6RM1pXs07Npw8RvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222617; c=relaxed/simple;
	bh=y7uS2LgTYlS/plbwPtBW1UuH96DFrH2j13V/AvOhOlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDLRXbzoI009+QQh7cOFW7UAjZhvNAIA/6sMuwpVcEbRUYIRV1gvlsHUdlldWNSZRLOFqTqzzPQlDbQR0IA1s1gsMhxNADfzRSPTbm3JgiZI8NbYxBDUoNKQAhDcetxoLD5ukMrAbuVD91F9Xkr3C82g8UsUxR1StmDzwTL97Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUv2lcav; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2255003f4c6so75308895ad.0;
        Mon, 17 Mar 2025 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222615; x=1742827415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2x7FZV4OyGa9hp/8mTMSCLqQ8CtXKxRN5A1v+VR5Os=;
        b=FUv2lcavHSapVJqx/s2Bo+MEOgAK2fyU+UIU5/HXa6ReL3O0XCfHQJYDZxONc/3QSD
         CiApkhccf5gHeB2PUlcAYVkbOu3TQn8W8I/JNvF7/ruqER0ZWlbNolw3VGUDnT/eKc5t
         FE5pujYM/Br+g7a319zOlqQq8DVcByK48OHtJSsYjMLcJD0VD5C6EOo/kB+MbrZKryA5
         OalAlXALtYIqWAkGte6Ac6cNaA0z2UkR6eAxOOwQ1c1LZFS8NO3H4rVoBVIMXuo11uqf
         Q5qb/mNNduZWI9QBJYwbOdgYE4i3W+gGZcp3mb43qSL/eNdPIZ5TSNYi0Gij3v6aC8ZC
         BwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222615; x=1742827415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2x7FZV4OyGa9hp/8mTMSCLqQ8CtXKxRN5A1v+VR5Os=;
        b=tk9INXS/SYabjos9AF9dZUjWbfh9mPBYrhLa/SVPQ0PMNlccoM8jkbUT2bC6kFrZHE
         o3cJeBId4x2KpJR3Q+8dtt8anvzegEsh7GJQ0Z0WQAT0xb+O7AMdjtVbjRhljxQfQq8f
         mxeP3X1C8fPbmpojttvp3aa0O0eB8Gdq3EsL2uPnEr/KW4gzQGtllAFRNUwSSWMZ1IhZ
         8qgkkeGPNkDkpj2UlUAtZjIU1JzUc6VTrWUIyLGAQJ5keJrYr54KUBw9aRoeftresSOb
         EoC8P3Uq6nNI/uSbT6qWHc0KWA+v6Ci2JOemF7cXxgWrYKJmE83F1Q5bLZu/YSdRFDOV
         N0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcLnMJcmKI9pSurh+dh5CVFvquroPws0bgOHmaheqCBfw59xvz9w8FZnm7ccv9NWTjqvdn3s7bcF8=@vger.kernel.org, AJvYcCVTXgIH3NhHhGUO/lQiXvOf+VaxGeM98Nd5Luuc109EbEu4XAZNVl7LYRBMcvX3zlPkgRM3w39aXgxYe6cp@vger.kernel.org, AJvYcCXe4U1Kkx8vZF53gnZ1cCOIE2MGngU01kmJ0dtINOVGXwluzZHdyGfA8louMPWp95OYJoMiHRo+qHwgsCNKEVSKkS6xFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxibTzIZXAOjaY2rjyi+h1cp01JtzBoZYMC2bo/q6vxGFVELraj
	8rSIuss3lR6koIE3IxmP0FgmgtHSLAhunbvAgE07qbhaqCik+Pgj
X-Gm-Gg: ASbGncubJZtDB8SRt8UWGIdYHV6MtoSVaVH7p/l1Xki9hX9YFsN7Yd3kOTpxFnUrFgO
	sQpiCr5vqss+L1ZxuZTwrY13sPE0lEVZucN4TGZdQljgUiNQcNJCBDRa7xwTzVnmnADB+bcC3k5
	NYvsRYstKeXmNr8ociABuuTE1n2hdmiscvP/5CM1VV3zQkP0kF6rSx6h++bHJhJruTOU+QzkwKL
	egH9WZICDA6QlQ9quyYpaIWrlV3v24CXUXWwmZvlYF6Q/83dGDSntvlmSSkOMVyI/0w+b7o+bcB
	l4IDkiJXVr44EatFaigZkvSnMRLLzl4D2twA6KY=
X-Google-Smtp-Source: AGHT+IHLZK1uY2S20M9HQmPOd2PXBg60FUL3esLdCxJee8sf8BO1MpeTeLVX5NLUb38bi2u6R7hkwQ==
X-Received: by 2002:a17:902:d4cb:b0:223:402b:cce2 with SMTP id d9443c01a7336-225e0aeefcdmr129206655ad.33.1742222615395;
        Mon, 17 Mar 2025 07:43:35 -0700 (PDT)
Received: from terminus.lan1 ([2605:59c8:3484:ea20::914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e34sm7906797b3a.140.2025.03.17.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:43:35 -0700 (PDT)
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
Subject: [PATCH v4 2/6 RESEND] platform/x86: Add lenovo-wmi-helpers
Date: Mon, 17 Mar 2025 07:43:22 -0700
Message-ID: <20250317144326.5850-3-derekjohn.clark@gmail.com>
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

Adds documentation for all new lenovo-wmi drivers.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
 - Changed namespace to LENOVO_WMI_HELPERS from LENOVO_WMI.
 - Changed filenames to lenovo-wmi-helpers from lenovo-wmi.
 - Removed structs and functions implemented by other drivers.
---
 MAINTAINERS                               |  2 +
 drivers/platform/x86/Kconfig              |  4 ++
 drivers/platform/x86/Makefile             |  1 +
 drivers/platform/x86/lenovo-wmi-helpers.c | 64 +++++++++++++++++++++++
 drivers/platform/x86/lenovo-wmi-helpers.h | 24 +++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 675f4b26426d..3a370a18b806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 F:	Documentation/wmi/devices/lenovo-wmi-other.rst
+F:	drivers/platform/x86/lenovo-wmi-helpers.c
+F:	drivers/platform/x86/lenovo-wmi-helpers.h
 
 LENOVO WMI HOTKEY UTILITIES DRIVER
 M:	Jackie Dong <xy-jackie@139.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 43407e76476b..bece1ba61417 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -459,6 +459,10 @@ config IBM_RTL
 	 state = 0 (BIOS SMIs on)
 	 state = 1 (BIOS SMIs off)
 
+config LENOVO_WMI_HELPERS
+	tristate
+	depends on ACPI_WMI
+
 config IDEAPAD_LAPTOP
 	tristate "Lenovo IdeaPad Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 650dfbebb6c8..5a9f4e94f78b 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
 obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
 obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
+obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo-wmi-helpers.c b/drivers/platform/x86/lenovo-wmi-helpers.c
new file mode 100644
index 000000000000..36d553502223
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-helpers.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo Legion WMI helpers driver. The Lenovo Legion WMI interface is
+ * broken up into multiple GUID interfaces that require cross-references
+ * between GUID's for some functionality. The "Custom Method" interface is a
+ * legacy interface for managing and displaying CPU & GPU power and hwmon
+ * settings and readings. The "Other Mode" interface is a modern interface
+ * that replaces or extends the "Custom Method" interface methods. The
+ * "Gamezone" interface adds advanced features such as fan profiles and
+ * overclocking. The "Lighting" interface adds control of various status
+ * lights related to different hardware components. Each of these drivers
+ * uses a common procedure to get data fro the WMI interface, enumerated here.
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#include <linux/wmi.h>
+#include "lenovo-wmi-helpers.h"
+
+/*
+ * lwmi_dev_evaluate_method() - Helper function to call wmidev_evaluate_method
+ * for Lenovo WMI device method calls that return an ACPI integer.
+ * @wdev: Pointer to the WMI device to be called.
+ * @instance: Instance of the called method.
+ * @method_id: WMI Method ID for the method to be called.
+ * @buf: Buffer of all arguments for the given method_id.
+ * @size: Length of the buffer.
+ * @retval: Pointer for the return value to be assigned.
+ *
+ * Returns: 0, or an error.
+ */
+int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
+			     u32 method_id, unsigned char *buf, size_t size,
+			     u32 *retval)
+{
+	struct acpi_buffer input = { size, buf };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *ret_obj __free(kfree) = NULL;
+	acpi_status status;
+
+	status = wmidev_evaluate_method(wdev, instance, method_id, &input,
+					&output);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (retval) {
+		ret_obj = output.pointer;
+		if (!ret_obj)
+			return -ENODATA;
+
+		if (ret_obj->type != ACPI_TYPE_INTEGER)
+			return -ENXIO;
+
+		*retval = (u32)ret_obj->integer.value;
+	}
+	return 0;
+};
+EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_method, "LENOVO_WMI_HELPERS");
+
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-wmi-helpers.h b/drivers/platform/x86/lenovo-wmi-helpers.h
new file mode 100644
index 000000000000..7e0d7870790e
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-helpers.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+#include <linux/notifier.h>
+#include <linux/platform_profile.h>
+
+#ifndef _LENOVO_WMI_HELPERS_H_
+#define _LENOVO_WMI_HELPERS_H_
+
+#include <linux/types.h>
+#include <linux/wmi.h>
+
+struct wmi_method_args_32 {
+	u32 arg0;
+	u32 arg1;
+};
+
+int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
+			     u32 method_id, unsigned char *buf, size_t size,
+			     u32 *retval);
+
+#endif /* !_LENOVO_WMI_HELPERS_H_ */
-- 
2.49.0


