Return-Path: <linux-kernel+bounces-564398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6543A65417
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAEA17024D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8024BC05;
	Mon, 17 Mar 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIHzBPPs"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3A24A067;
	Mon, 17 Mar 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222625; cv=none; b=fPahezG9UcM/0iE04bFGA0DgR/5qDTlSOIy4wT0wc2Kg7SOnIWoyPwXp94LEmBo+NIcopzlinezi1ZPex4K/I7mZEIqrPimgolcZPdjIa2f/JFinWNdoJWaZWPYdSgsqopitSPbSWcLYV8vsBdmW+HY8PR5c4cQwb+3wC7wVW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222625; c=relaxed/simple;
	bh=scHLMfjQeuz4T/HjBN4ZhUPoxcuhT+g/H5n+Ru0zf5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7BGxveBwhfTaNNiWIk58Xiw3/ggTzL3Fg5+6LyZaJuw4r5Dyy6hbVeOVTOghQ/u+r+roF+xELot2RM2OWtr1PcxuNYYSKZ662xXYxJgMgb9BYMzy/Vn2cNq+mxplDzPWfdFeNg5g7aIf4GunvYHlf+R77wUXsIjGmFgHA2e1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIHzBPPs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-226185948ffso17891635ad.0;
        Mon, 17 Mar 2025 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222622; x=1742827422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6WrkgLRJl8lUocm1cnTSBp25XPoazkPi4ONuRt/VwE=;
        b=YIHzBPPsxdPYMv9dGnQVm+tTL86BxRVD2VUVPiTaidqn3U0QTUsppy3BDoFoNoZBzc
         A1XJ6SpBTWp8kJJvdJwh87WiJ9NIAJW0E56ReR2nyJRZTSLL1fUbfNq08AtGH++4HPYQ
         dmIf0uduCe8ytzc6MKjtY5xZLYzDqAe9XZMUgHw+3T0Ff4SvBgAgQcuxR7pjuhgIARLs
         1Mv7oOYDE8YOjqcZ32yftiEazhe4iMsvDixjFleLTiNKTn18UL7IolgOQuBEAzx7899M
         m7Ql07FMvxhRgnqn77XZFjAoNNDP3rhYVZl8+z4ra+/CRqcu6AnCT2Cn7dt1kLTXd59P
         WP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222622; x=1742827422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6WrkgLRJl8lUocm1cnTSBp25XPoazkPi4ONuRt/VwE=;
        b=i1Hyb2Zkqh5FoGXFuCO4DYjR6SGYa+F4CIQOQECtilwjUVG/vwxoXFRUs61/7AyY+5
         u6vSDU1y7dSJRhbu83PgOEeDFS6c6lf4DlOSDAYUIIrEJ0EHB3q1+ydKPty+Ch7tbPhj
         L/a/8H4wm7pDrk3URE1eEDqvjg4ppo2CdJnEyAQPhhoWoB5OAISnpYE75MQTb/1FJaaV
         Y8okEEOS5LT7vgUq2kXr4Zxzk6CEokWl60jubV48syVjQuZ2sHNkZHR6EXOKCTvPo+nT
         qiDOZXoRZttnFzS/5jhjOOP+wZ6jLPHca1lybK2AAyRLhYC6mkxAexw8lRNptyno2sJp
         nCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUorX1MXSYm31AJkHwjT6VcS+/J0kzUqRiux6CEyR94FrcQ8R+6bmnJ/jUNkPUo6STXdHjNaiwEwVUKiseZd3fWshwwgg==@vger.kernel.org, AJvYcCVHdDFkD5CQVrzdeKgAlV3odWamEBCG7Q97Zqyw1SeTZBBHqLWAfxufaxv1vqnyYY+yF4MPQLue6bs=@vger.kernel.org, AJvYcCXhXfCcOBoKIIsjN2VmPc2ZLFwnKfejVKcEK6+Ec0k5SH+4UjQ3tBcAi4GEc9vtGMC439PRyipIelOnj0kf@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEDmMMNkKeWKvyYk9HJrM6fO52p6X/nFoztYrimas1O49SVLI
	6oEVfyv5QKPtArKkMK1kfXMaqITVYLn15Ig01jDXX6whB5cjhOoK
X-Gm-Gg: ASbGncsn9d7PEZ5UV8izPsSvaHAy4MBVqY6JrKtV/3/AeQCK8kF96MEaqP1y6Oix9n6
	1HhFp0Z+tw98LOr1EwPTVo21LF2DxlA6JCQ8go96sTr/+Cfnob6QcS3LP9zCEDdkxDz0wQBs59a
	3lFC4D705Vt2sEr6wwX7gqUTz1WdloWYw3euqWSLXzSckayqTnZKIFkWSjx5uCUSnTBUriaP0MD
	T62GSRBT1UkHoh5Agcjuly69zw6oS0ch7sgJ9oFT/8+G4aab5n0NbigA3TBodOZg/YAE0uPso3k
	Doya+ntG2MRfimi6Nk2zaT6QbMl8M/VqA9W3U6s=
X-Google-Smtp-Source: AGHT+IEt2swsYFQ3UDo6ekskZIpIP0dcGd4awRHhU6m3zQ4EmD8sRFrW6MpWYqYyNNMdpSjEBQYNNA==
X-Received: by 2002:a05:6a00:2e25:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7372238e7d9mr17866516b3a.8.1742222622460;
        Mon, 17 Mar 2025 07:43:42 -0700 (PDT)
Received: from terminus.lan1 ([2605:59c8:3484:ea20::914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e34sm7906797b3a.140.2025.03.17.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:43:42 -0700 (PDT)
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
Subject: [PATCH v4 6/6 RESEND] platform/x86: Add Lenovo Gamezone WMI Driver
Date: Mon, 17 Mar 2025 07:43:26 -0700
Message-ID: <20250317144326.5850-7-derekjohn.clark@gmail.com>
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

Adds lenovo-wmi-gamezone driver which provides the Lenovo Gamezone WMI
interface that comes on Lenovo "Gaming Series" hardware. Provides ACPI
platform profiles over WMI.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
- Add notifier blocks for the Events and Other Mode drivers.
- Remove notifier block chain head and all reference to Thermal Mode
  Event GUID.
- Add header for Gamezone specific structs and functions.
- Various fixes from review.
v3:
- Use notifier chain to report platform profile changes to any
  subscribed drivers.
- Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notifier
  chain.
- Adds support for Extreme Mode profile on supported hardware, as well
  as a DMI quirk table for some devices that report extreme mode version
  support but so not have it fully implemented.
- Update to include recent changes to platform-profile.
v2:
- Use devm_kmalloc to ensure driver can be instanced, remove global
  reference.
- Ensure reverse Christmas tree for all variable declarations.
- Remove extra whitespace.
- Use guard(mutex) in all mutex instances, global mutex.
- Use pr_fmt instead of adding the driver name to each pr_err.
- Remove noisy pr_info usage.
- Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
- Remove GZ_WMI symbol exporting.
---
 MAINTAINERS                                |   2 +
 drivers/platform/x86/Kconfig               |  13 +
 drivers/platform/x86/Makefile              |   1 +
 drivers/platform/x86/lenovo-wmi-gamezone.c | 380 +++++++++++++++++++++
 drivers/platform/x86/lenovo-wmi-gamezone.h |  18 +
 5 files changed, 414 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 87daee6075ad..0416afd997a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13168,6 +13168,8 @@ F:	drivers/platform/x86/lenovo-wmi-capdata01.c
 F:	drivers/platform/x86/lenovo-wmi-capdata01.h
 F:	drivers/platform/x86/lenovo-wmi-events.c
 F:	drivers/platform/x86/lenovo-wmi-events.h
+F:	drivers/platform/x86/lenovo-wmi-gamezone.c
+F:	drivers/platform/x86/lenovo-wmi-gamezone.h
 F:	drivers/platform/x86/lenovo-wmi-helpers.c
 F:	drivers/platform/x86/lenovo-wmi-helpers.h
 F:	drivers/platform/x86/lenovo-wmi-other.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index fc47604e37f7..ecf3246c8fda 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -467,6 +467,19 @@ config LENOVO_WMI_HELPERS
 	tristate
 	depends on ACPI_WMI
 
+config LENOVO_WMI_GAMEZONE
+	tristate "Lenovo GameZone WMI Driver"
+	depends on ACPI_WMI
+	select ACPI_PLATFORM_PROFILE
+	select LENOVO_WMI_EVENTS
+	select LENOVO_WMI_HELPERS
+	help
+	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
+	  platform-profile firmware interface to manage power usage.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called lenovo-wmi-gamezone.
+
 config LENOVO_WMI_DATA01
 	tristate
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c6ce3c8594b1..f3e64926a96b 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
 obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
 obj-$(CONFIG_LENOVO_WMI_DATA01)	+= lenovo-wmi-capdata01.o
 obj-$(CONFIG_LENOVO_WMI_EVENTS)	+= lenovo-wmi-events.o
+obj-$(CONFIG_LENOVO_WMI_GAMEZONE)	+= lenovo-wmi-gamezone.o
 obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
 obj-$(CONFIG_LENOVO_WMI_TUNING)	+= lenovo-wmi-other.o
 
diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c b/drivers/platform/x86/lenovo-wmi-gamezone.c
new file mode 100644
index 000000000000..9d453a836227
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo GameZone WMI interface driver. The GameZone WMI interface provides
+ * platform profile and fan curve settings for devices that fall under the
+ * "Gaming Series" of Lenovo Legion devices.
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ */
+
+#include <linux/dmi.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/platform_profile.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+
+#include "lenovo-wmi-events.h"
+#include "lenovo-wmi-gamezone.h"
+#include "lenovo-wmi-helpers.h"
+#include "lenovo-wmi-other.h"
+
+/* Interface GUIDs */
+#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
+
+/* Method IDs */
+#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
+#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
+#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
+
+static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
+
+struct lwmi_event_priv {
+	enum thermal_mode current_mode;
+	struct wmi_device *wdev;
+	bool extreme_supported;
+	struct device *ppdev; /*platform profile device */
+	struct notifier_block event_nb;
+	struct notifier_block mode_nb;
+};
+
+struct quirk_entry {
+	bool extreme_supported;
+};
+
+static struct quirk_entry quirk_no_extreme_bug = {
+	.extreme_supported = false,
+};
+
+/* Notifier Methods */
+/*
+ * lwmi_gz_mode_call() - Call method for lenovo-wmi-other notifier
+ * block call chain. For THERMAL_MODE_EVENT, returns current_mode
+ *
+ * @nb: The notifier_block registered to lenovo-wmi-other
+ * @cmd: The event triggered by lenovo-wmi-other
+ * @data: The data to be returned by the event.
+ *
+ * Returns: notifier_block status.
+ */
+static int lwmi_gz_mode_call(struct notifier_block *nb, unsigned long cmd,
+			     void *data)
+{
+	struct lwmi_event_priv *priv;
+
+	priv = container_of(nb, struct lwmi_event_priv, mode_nb);
+	if (!priv)
+		return NOTIFY_BAD;
+
+	switch (cmd) {
+	case THERMAL_MODE_EVENT:
+		*(enum thermal_mode *)data = priv->current_mode;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+/*
+ * lwmi_gz_event_call() - Call method for lenovo-wmi-events notifier
+ * block call chain. For THERMAL_MODE_EVENT, sets current_mode and
+ * notifies platform_profile of a change.
+ *
+ * @nb: The notifier_block registered to lenovo-wmi-events
+ * @cmd: The event triggered by lenovo-wmi-events
+ * @data: The data to be updated by the event.
+ *
+ * Returns: notifier_block status.
+ */
+static int lwmi_gz_event_call(struct notifier_block *nb, unsigned long cmd,
+			      void *data)
+{
+	struct lwmi_event_priv *priv;
+
+	priv = container_of(nb, struct lwmi_event_priv, event_nb);
+	if (!priv)
+		return NOTIFY_BAD;
+
+	switch (cmd) {
+	case THERMAL_MODE_EVENT:
+		priv->current_mode = *((enum thermal_mode *)data);
+		platform_profile_notify(&priv->wdev->dev);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+/* Platform Profile Methods & Setup */
+/*
+ * lwmi_gz_platform_profile_supported() - Gets the version of the WMI
+ * interface to determine the support level.
+ *
+ * @wdev: The Gamezone WMI device.
+ * @supported: Pointer to return the support level with.
+ *
+ * Returns: 0, or an error.
+ */
+static int lwmi_gz_platform_profile_supported(struct wmi_device *wdev,
+					      int *supported)
+{
+	return lwmi_dev_evaluate_method(wdev, 0x0, WMI_METHOD_ID_SMARTFAN_SUPP,
+					0, 0, supported);
+}
+
+/*
+ * lwmi_gz_thermal_mode_get() - Gets the currently set thermal mode from
+ * the Gamezone WMI interface.
+ *
+ * @wdev: The Gamezone WMI device.
+ * @mode: Pointer to return the thermal mode with.
+ *
+ * Returns: 0, or an error.
+ */
+static int lwmi_gz_thermal_mode_get(struct wmi_device *wdev,
+				    enum thermal_mode *mode)
+{
+	return lwmi_dev_evaluate_method(wdev, 0x0, WMI_METHOD_ID_SMARTFAN_GET,
+					0, 0, mode);
+}
+
+static int lwmi_gz_profile_get(struct device *dev,
+			       enum platform_profile_option *profile)
+{
+	struct lwmi_event_priv *priv = dev_get_drvdata(dev);
+	enum thermal_mode mode;
+	int ret;
+
+	ret = lwmi_gz_thermal_mode_get(priv->wdev, &mode);
+	if (ret)
+		return ret;
+
+	switch (mode) {
+	case SMARTFAN_MODE_QUIET:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	case SMARTFAN_MODE_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case SMARTFAN_MODE_PERFORMANCE:
+		if (priv->extreme_supported) {
+			*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
+			break;
+		}
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case SMARTFAN_MODE_EXTREME:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case SMARTFAN_MODE_CUSTOM:
+		*profile = PLATFORM_PROFILE_CUSTOM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	priv->current_mode = mode;
+
+	return 0;
+}
+
+static int lwmi_gz_profile_set(struct device *dev,
+			       enum platform_profile_option profile)
+{
+	struct lwmi_event_priv *priv = dev_get_drvdata(dev);
+	struct wmi_method_args_32 args;
+	enum thermal_mode mode;
+	int ret;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		mode = SMARTFAN_MODE_QUIET;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		mode = SMARTFAN_MODE_BALANCED;
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		mode = SMARTFAN_MODE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		if (priv->extreme_supported) {
+			mode = SMARTFAN_MODE_EXTREME;
+			break;
+		}
+		mode = SMARTFAN_MODE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_CUSTOM:
+		mode = SMARTFAN_MODE_CUSTOM;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	args.arg0 = mode;
+
+	ret = lwmi_dev_evaluate_method(priv->wdev, 0x0,
+				       WMI_METHOD_ID_SMARTFAN_SET,
+				       (unsigned char *)&args, sizeof(args),
+				       NULL);
+	if (ret)
+		return ret;
+
+	priv->current_mode = mode;
+
+	return 0;
+}
+
+static const struct dmi_system_id fwbug_list[] = {
+	{
+		.ident = "Legion Go 8APU1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
+	{
+		.ident = "Legion Go S 8ARP1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
+	{
+		.ident = "Legion Go S 8APU1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
+	{},
+
+};
+
+/*
+ * extreme_supported() - Evaluate if a device supports extreme thermal mode.
+ * For devices that have a profile_support_ver of 6 or greater a DMI check
+ * is done. Some devices report a version that supports extreme mode but
+ * have an incomplete entry in the BIOS. To ensure this cannot be set, they
+ * are quirked to prevent assignment.
+ *
+ * @profile_support_ver: Version of WMI interface provided by
+ * lwmi_gz_platform_profile_supported.
+ *
+ * Returns: bool
+ */
+static bool extreme_supported(int profile_support_ver)
+{
+	const struct dmi_system_id *dmi_id;
+	struct quirk_entry *quirks;
+
+	if (profile_support_ver < 6)
+		return false;
+
+	dmi_id = dmi_first_match(fwbug_list);
+	if (!dmi_id)
+		return true;
+
+	quirks = dmi_id->driver_data;
+	return quirks->extreme_supported;
+}
+
+static int lwmi_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	struct lwmi_event_priv *priv = drvdata;
+	int profile_support_ver;
+	int ret;
+
+	ret = lwmi_gz_platform_profile_supported(priv->wdev,
+						 &profile_support_ver);
+	if (ret)
+		return ret;
+
+	if (profile_support_ver < 1)
+		return -ENODEV;
+
+	priv->extreme_supported = extreme_supported(profile_support_ver);
+
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_CUSTOM, choices);
+
+	if (priv->extreme_supported)
+		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+
+	return 0;
+}
+
+static const struct platform_profile_ops lwmi_gz_platform_profile_ops = {
+	.probe = lwmi_platform_profile_probe,
+	.profile_get = lwmi_gz_profile_get,
+	.profile_set = lwmi_gz_profile_set,
+};
+
+/* Driver Methods */
+static int lwmi_gz_probe(struct wmi_device *wdev, const void *context)
+{
+	struct lwmi_event_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->event_nb.notifier_call = lwmi_gz_event_call;
+	ret = devm_lwmi_events_register_notifier(&wdev->dev, &priv->event_nb);
+	if (ret)
+		return ret;
+
+	priv->mode_nb.notifier_call = lwmi_gz_mode_call;
+	ret = devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_nb);
+	if (ret)
+		return ret;
+
+	priv->wdev = wdev;
+	dev_set_drvdata(&wdev->dev, priv);
+
+	priv->ppdev = platform_profile_register(&wdev->dev,
+						"lenovo-wmi-gamezone", priv,
+						&lwmi_gz_platform_profile_ops);
+
+	if (IS_ERR(priv->ppdev))
+		return -ENODEV;
+
+	ret = lwmi_gz_thermal_mode_get(wdev, &priv->current_mode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct wmi_device_id lwmi_gz_id_table[] = { { LENOVO_GAMEZONE_GUID,
+							   NULL },
+							 {} };
+
+static struct wmi_driver lwmi_gz_driver = {
+	.driver = {
+		.name = "lenovo_wmi_gamezone",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = lwmi_gz_id_table,
+	.probe = lwmi_gz_probe,
+	.no_singleton = true,
+};
+
+module_wmi_driver(lwmi_gz_driver);
+
+MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
+MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
+MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
+MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.h b/drivers/platform/x86/lenovo-wmi-gamezone.h
new file mode 100644
index 000000000000..ac536803160b
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-gamezone.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *
+ */
+
+#ifndef _LENOVO_WMI_GAMEZONE_H_
+#define _LENOVO_WMI_GAMEZONE_H_
+
+enum thermal_mode {
+	SMARTFAN_MODE_QUIET = 0x01,
+	SMARTFAN_MODE_BALANCED = 0x02,
+	SMARTFAN_MODE_PERFORMANCE = 0x03,
+	SMARTFAN_MODE_EXTREME = 0xE0, /* Ver 6+ */
+	SMARTFAN_MODE_CUSTOM = 0xFF,
+};
+
+#endif /* !_LENOVO_WMI_GAMEZONE_H_ */
-- 
2.49.0


