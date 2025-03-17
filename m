Return-Path: <linux-kernel+bounces-563427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7CA641A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A8016CE58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145B21ABD0;
	Mon, 17 Mar 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M94XWJF5"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E221A459;
	Mon, 17 Mar 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193245; cv=none; b=Z/HXjqHdIgASZzrq3He8/zB0uCy9G6GSRXaHdsUTqVzIZDduhwD0QYjtUiihtp+eMmFNwi2I9WCRQVPRJ+C6vCzSzdh5rfbzT32xzraB/sJSIwJZBSksNEFwwIvcfhPb60+dclFlDrqFxZ+BW4sNfehIYqRGvz7cgToIW2aZCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193245; c=relaxed/simple;
	bh=y7uS2LgTYlS/plbwPtBW1UuH96DFrH2j13V/AvOhOlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN9OtKGeDrvQc+Th5Em575otzbMS6TlAbVHNj7LJRj3tFEG7Wq0BFJcrt1gvIxkpVAwNOY1aB3LbsvdU1gsPv9AilGwh6AZ8pIrIHozFgbK2ezm9W611Vg0UZBq/QjRklKXUojhHAE/UcpMuP7IuYEOMP1vy223JC64rp+OnGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M94XWJF5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30185d00446so637034a91.0;
        Sun, 16 Mar 2025 23:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193243; x=1742798043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2x7FZV4OyGa9hp/8mTMSCLqQ8CtXKxRN5A1v+VR5Os=;
        b=M94XWJF53US9NZLA50UIqXFWbXF8XAU3fEDYF4Kd+nkjRXo3jM+KjGywapcjcJnnTR
         yg268WvXVWC0Yfj6NKCI0TGcDU+2CSPe5QM4npXK6S27lv7TqYIrUArtJz3pBW9gwqTA
         CBARgB0axc9CHDiP4JtquAIpgir0K38OhKkMN5UM6G//SYGSyYUpNG9DDbHjpprck6P/
         WZaegaa2kB8XLAUuVX1IwDtS+jLkOeHChidJy9zIsLv/Qr7q03Y6lJoReE8q1Xaw7HuD
         qFdZMQ4EjO9iti0EhaDRMfkBKqIJMJ88/HBwCrW+aDPZRkSZQTTluua9Btg9r/eXYx5F
         lPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193243; x=1742798043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2x7FZV4OyGa9hp/8mTMSCLqQ8CtXKxRN5A1v+VR5Os=;
        b=r8uxFSrOYcf31sJX3/OeOlVLnGTLgQEaSYCCSAPkx4ZtanpipV4bq/SkdAmpuPGPNW
         P7aF/1UcDUtYudpaw2PKzWdfsbfgpwsk4CmsXiZ1txAk0QPGs5/TnRxbwq51hBDbLc79
         Q+zwLcJoOJA6wGKi3cq0OHtkEkPENrjgzRLQ12UUJqJ16bn8002XspBiKw9c1dCU2ZgT
         +Dey3A8oP3qBrI+C0GIwAOVaFr8NzOO0/lsBih/iqoBiLvxwDoUdi2kC7Nea1TBUm93c
         hPynipaJREuHVI/I90hQL+Gz5EdC6eqi/RKIyqtTvsCFL+umwJ4jdUUpMNLHNHPGGLwU
         rjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW3mfxus9lAqkd7fzJEGKIursJhPRZiiAPgRN6IglZoXHp/PdUzBXwoYzfDw597VfU1qlu01fHTLs=@vger.kernel.org, AJvYcCW2UIGV1pEYlDTjpBvb6lW1yzUI/u/gx7nosBEt0tuhdjuZ0615AtKTdM+fyXnDXDHkBP9YTKOS5a5w4MkO@vger.kernel.org, AJvYcCWPIkyzHCAJID0BRcLJAiMVEG6xR8j62dwHHjJyImqxRDzrpTBUq6BR6CHLw8X2EK8x8+ZslrLp3QFdd0ZfiqhrJsn0ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhToNmz1x2AS0cL3+Q5yHAD2zZB5eTrk4HraFiFwkY6osUpgFw
	nEjRPWg6KCE9iSQHC6LotxUVrQOldhXNdPWAAUIgEXHvR79L3OUK
X-Gm-Gg: ASbGncsWT1jk93YJrCwh4yeBQb5huqpwRICouGt1ENNxPZWPDRm+gxeBB34+R2ON/pt
	q/72by7yTV8WFX3bj4WeFsg5Uh3oRW78lKnGVQCEvSDhV4/BWWxWG1CYyEWwlS55Rd0L70Kq44I
	i17WdewVQqz1UQpUkbW2OD4K7SYc+ln1jiUKycy83cKjnuwuyEYWpn+pkQi+F3X3zU3wkvp5VZU
	ODTcPr8Z4IW373KkphYBrgJjh2ALNk2G5satSGnIBcgNacO0Kd110KLmA8X74CbJQqlhx1QvXHf
	1C/Q9VGiRpiYQL1QsHmkWQh8EEkAiqvFFBUFYLKmE5oUOVD962BXyEPuL3q/z+9O+SCsrwYPtGr
	fIfrKgFuaccS6zjgJhBxW6xhS9+HI1rl1jTrVVoM8TV8=
X-Google-Smtp-Source: AGHT+IHRTLgYsplRHi/sI4VHcwUBuB/vVTzS/3kjmXaRqew/IxQ4hA9HqAFoia08Eym4934LTyoCYw==
X-Received: by 2002:a17:90b:3804:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-30135f4cf2bmr20023358a91.13.1742193242630;
        Sun, 16 Mar 2025 23:34:02 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm5186555a91.28.2025.03.16.23.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:34:02 -0700 (PDT)
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
Subject: [PATCH v4 2/6] platform/x86: Add lenovo-wmi-helpers
Date: Sun, 16 Mar 2025 23:33:31 -0700
Message-ID: <20250317063337.352966-5-derekjohn.clark@gmail.com>
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


