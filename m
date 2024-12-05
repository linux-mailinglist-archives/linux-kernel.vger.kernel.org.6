Return-Path: <linux-kernel+bounces-432460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB279E4B76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037742840DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89C1D52B;
	Thu,  5 Dec 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqtzvl1F"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C518AFC;
	Thu,  5 Dec 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359624; cv=none; b=hkmXwURE99dDENdiQd5Z5ubCcmGOFJfnCLols8Rao8Sh/Psebbti0lwvnJQfGJzWGbjcqOT49A6uBFmiUJ9w5q55U4zJ3GzufJt7hZbDjG1YNrjDpUCoW0TKLsQKGSS2DSgm0mR6VhUS6Xi395tMa5HnoCI5qPhkh3WMYkAdz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359624; c=relaxed/simple;
	bh=f/JtU3JF65jK6/gj5A10+Cuk1lEzhI7uth+Fg/PmEs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROsdfyp4gOnC15lC7+t6eCUcHW02DOOBspQmNNPFG7IRh2nALKf1jRxdBe5frQ/FWMHxP2tsmJxhfPNFktdNMjcLhNU7bw10DaN7LHFv/F34fMS7uGC4lutiSxRiIrlgN++rCB6RbgJlGHK8tbagZTUTEr9kW81lvftliUSy/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqtzvl1F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215ac560292so3184655ad.2;
        Wed, 04 Dec 2024 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359622; x=1733964422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKxRbBSHgKqYHhuCZfgBL3y5hngQfwrEBg5igZSaFfw=;
        b=lqtzvl1Fpz8WBZTmkT9C7znbCj+YRRsYTg6Ksc1FylRmpOfw/ny5EJBuGRATJFiTie
         wDNxFvTAiUUiAn/IrVa7Z8+YnxTRHiCgMmzFfTZ90MyG1p2RfZI/OHaj8Qo7idBGkp10
         xIku0usBiau87uze9qfzNLGB3+wySyV6Q3mGtfsvdyRX4X4LeqN2dUbu39oI+c1E/5yp
         Fd9JEbrJ8q8GjkIGo1MohQZ2oYy9BnnHhDVeBzvNoymaydlY9HS79rPvmKr1wHaeFXJx
         30wOWRVbcONN3+geCjGsudvbwhylBq+YD1gu6eusOlX3RVNyPXhq0NP/VwJK4JfH95uU
         KNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359622; x=1733964422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKxRbBSHgKqYHhuCZfgBL3y5hngQfwrEBg5igZSaFfw=;
        b=bIX7QRGGNRqMqB/hmif58z86P8ouX3PEtJh5iTjmA1hIBx72AID9P5ZvjjJA34K8kK
         gN8ktIqWyWbw/X7D2ZGo/QMVfy8EwcrmxiJxzfQvtO/9g/8YRmlWBgoCHDs7FU97Fkid
         Eppv48RxMpj7HZgtxhwy036i5Y88BUeMSF4PCh43479VS2ZPYuobWUd19skZgfRkCjPy
         fd81bXUXVSEeKfTuHzbmalAZwTT+I5QuB7I00w/MMUqmGDcVxKpcmv8VCZGgPH9ISD/G
         WkSeVTDzCV2EnRyB5ML/mtAn6SKh+mGnMzAnPI/jxrQcRFiphclNASarBwg80s7ZDiPI
         TENg==
X-Forwarded-Encrypted: i=1; AJvYcCWRiYjQ9TLPsXolRgqS0j1+sfofYjpkDhRKycpzGOogdqvI/t35VopqpNDFaVsrxKJvmXsh365lTT7YSRc=@vger.kernel.org, AJvYcCWl2youZQklROwnN0dAZgvc+NJCVPi9JhxgPli7nr8KQ0HcQKe1n1wp4lIEZ3koqse46DvigfOA1V5E5Xnfp0XZEQhxTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaaT5xC9wHNubAyUGdq1k91R56PGUGoYueQL4wyRCtGKiXSho
	3QgScqb0+D82tzeTtWyqdqBN+cNszgXTxPt78PFAUExw8xf5KDl6
X-Gm-Gg: ASbGnculKehb3So/sWQLvHOs/AEtulcB/tbMR4BQ5iJVbn1w2GKuv/mP/1wOiavXMjq
	1pI3zCt1pwrW68qC2Lkn5jADaAPp2Yf4WKO+kcs64N08rboJJYaKJT5f+ZNXQkKUEWrBVbXMEGU
	zywc/94g1LL4tg10Uefkw1asJMi79m8mXN4bgtFL2tRFwGz/69uL87mu8VzvdfCl2ZEW37+0523
	8LUza4MAM5KQ0NZJuEkhLmYHu7GFVJfGJMss/badZvI8GpDujrdRMkNPIB/jhfCqeV0WfzBvpGN
	kFo7xKuBTyRbm9ApSeI=
X-Google-Smtp-Source: AGHT+IEyUud4NjROVIiI5WXUtGZHpnkJjWH1s0UNIURra4+F/VCn1y/NdO4jLnt7KFZZ50nHEWGTkw==
X-Received: by 2002:a17:902:e802:b0:215:6093:e383 with SMTP id d9443c01a7336-215bd0ce8ffmr101034055ad.27.1733359622420;
        Wed, 04 Dec 2024 16:47:02 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29eb38esm106048b3a.73.2024.12.04.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:47:02 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 18/21] platform-x86: Add header file for alienware-wmi
Date: Wed,  4 Dec 2024 21:46:48 -0300
Message-ID: <20241205004647.2186826-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to split the alienware-wmi module, add a header file for all
shared assets.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 106 ++-----------------
 drivers/platform/x86/dell/alienware-wmi.h | 119 ++++++++++++++++++++++
 2 files changed, 126 insertions(+), 99 deletions(-)
 create mode 100644 drivers/platform/x86/dell/alienware-wmi.h

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 7137995d5983..4165eb0d0bf5 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -16,19 +16,8 @@
 #include <linux/dmi.h>
 #include <linux/leds.h>
 #include <linux/wmi.h>
+#include "alienware-wmi.h"
 
-#define LEGACY_CONTROL_GUID		"A90597CE-A997-11DA-B012-B622A1EF5492"
-#define LEGACY_POWER_CONTROL_GUID	"A80593CE-A997-11DA-B012-B622A1EF5492"
-#define WMAX_CONTROL_GUID		"A70591CE-A997-11DA-B012-B622A1EF5492"
-
-#define WMAX_METHOD_HDMI_SOURCE		0x1
-#define WMAX_METHOD_HDMI_STATUS		0x2
-#define WMAX_METHOD_BRIGHTNESS		0x3
-#define WMAX_METHOD_ZONE_CONTROL	0x4
-#define WMAX_METHOD_HDMI_CABLE		0x5
-#define WMAX_METHOD_AMPLIFIER_CABLE	0x6
-#define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
-#define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
 #define WMAX_METHOD_THERMAL_INFORMATION	0x14
 #define WMAX_METHOD_THERMAL_CONTROL	0x15
 #define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
@@ -54,18 +43,6 @@ enum INTERFACE_FLAGS {
 	WMAX,
 };
 
-enum LEGACY_CONTROL_STATES {
-	LEGACY_RUNNING = 1,
-	LEGACY_BOOTING = 0,
-	LEGACY_SUSPEND = 3,
-};
-
-enum WMAX_CONTROL_STATES {
-	WMAX_RUNNING = 0xFF,
-	WMAX_BOOTING = 0,
-	WMAX_SUSPEND = 3,
-};
-
 enum WMAX_THERMAL_INFORMATION_OPERATIONS {
 	WMAX_OPERATION_SYS_DESCRIPTION		= 0x02,
 	WMAX_OPERATION_LIST_IDS			= 0x03,
@@ -86,20 +63,6 @@ enum WMAX_THERMAL_TABLES {
 	WMAX_THERMAL_TABLE_USTT			= 0xA0,
 };
 
-enum wmax_thermal_mode {
-	THERMAL_MODE_USTT_BALANCED,
-	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
-	THERMAL_MODE_USTT_COOL,
-	THERMAL_MODE_USTT_QUIET,
-	THERMAL_MODE_USTT_PERFORMANCE,
-	THERMAL_MODE_USTT_LOW_POWER,
-	THERMAL_MODE_BASIC_QUIET,
-	THERMAL_MODE_BASIC_BALANCED,
-	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
-	THERMAL_MODE_BASIC_PERFORMANCE,
-	THERMAL_MODE_LAST,
-};
-
 static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
 	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
 	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
@@ -369,33 +332,10 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 	{}
 };
 
-struct color_platform {
-	u8 blue;
-	u8 green;
-	u8 red;
-} __packed;
-
-struct wmax_brightness_args {
-	u32 led_mask;
-	u32 percentage;
-};
-
 struct wmax_basic_args {
 	u8 arg;
 };
 
-struct legacy_led_args {
-	struct color_platform colors;
-	u8 brightness;
-	u8 state;
-} __packed;
-
-struct wmax_led_args {
-	u32 led_mask;
-	struct color_platform colors;
-	u8 state;
-} __packed;
-
 struct wmax_u32_args {
 	u8 operation;
 	u8 arg1;
@@ -403,43 +343,11 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
-struct awcc_priv {
-	struct wmi_device *wdev;
-	struct platform_profile_handler pp_handler;
-	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
-	bool has_gmode;
-};
-
-struct alienfx_priv {
-	struct platform_device *pdev;
-	struct led_classdev global_led;
-	struct color_platform colors[4];
-	u8 global_brightness;
-	u8 lighting_control_state;
-};
-
-struct alienfx_ops {
-	int (*upd_led)(struct alienfx_priv *priv, struct wmi_device *wdev,
-		       u8 location);
-	int (*upd_brightness)(struct alienfx_priv *priv, struct wmi_device *wdev,
-			      u8 brightness);
-};
-
-struct alienfx_platdata {
-	struct wmi_device *wdev;
-	struct alienfx_ops ops;
-	u8 num_zones;
-	bool hdmi_mux;
-	bool amplifier;
-	bool deepslp;
-	u8 running_code;
-};
-
 static u8 interface;
 static struct wmi_driver *preferred_wmi_driver;
 
-static acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
-					 void *in_args, size_t in_size, u32 *out_data)
+acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
+				  void *in_args, size_t in_size, u32 *out_data)
 {
 	acpi_status ret;
 	union acpi_object *obj;
@@ -1071,7 +979,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 				    priv->supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
+int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
 {
 	struct awcc_priv *priv;
 	u32 out_data;
@@ -1130,7 +1038,7 @@ static int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
 	return platform_profile_register(&priv->pp_handler);
 }
 
-static void remove_thermal_profile(void)
+void remove_thermal_profile(void)
 {
 	platform_profile_remove();
 }
@@ -1180,7 +1088,7 @@ static struct platform_driver platform_driver = {
 	.probe = alienfx_probe,
 };
 
-static int alienfx_wmi_init(struct alienfx_platdata *pdata)
+int alienfx_wmi_init(struct alienfx_platdata *pdata)
 {
 	struct platform_device *pdev;
 
@@ -1192,7 +1100,7 @@ static int alienfx_wmi_init(struct alienfx_platdata *pdata)
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-static void alienfx_wmi_exit(struct wmi_device *wdev)
+void alienfx_wmi_exit(struct wmi_device *wdev)
 {
 	struct platform_device *pdev;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.h b/drivers/platform/x86/dell/alienware-wmi.h
new file mode 100644
index 000000000000..1c12b8e330e2
--- /dev/null
+++ b/drivers/platform/x86/dell/alienware-wmi.h
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Alienware AlienFX control
+ *
+ * Copyright (C) 2014 Dell Inc <Dell.Client.Kernel@dell.com>
+ */
+
+#ifndef _ALIENWARE_WMI_H_
+#define _ALIENWARE_WMI_H_
+
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/platform_profile.h>
+#include <linux/wmi.h>
+
+#define LEGACY_CONTROL_GUID		"A90597CE-A997-11DA-B012-B622A1EF5492"
+#define LEGACY_POWER_CONTROL_GUID	"A80593CE-A997-11DA-B012-B622A1EF5492"
+#define WMAX_CONTROL_GUID		"A70591CE-A997-11DA-B012-B622A1EF5492"
+
+#define WMAX_METHOD_HDMI_SOURCE		0x1
+#define WMAX_METHOD_HDMI_STATUS		0x2
+#define WMAX_METHOD_BRIGHTNESS		0x3
+#define WMAX_METHOD_ZONE_CONTROL	0x4
+#define WMAX_METHOD_HDMI_CABLE		0x5
+#define WMAX_METHOD_AMPLIFIER_CABLE	0x6
+#define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
+#define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
+
+enum LEGACY_CONTROL_STATES {
+	LEGACY_RUNNING = 1,
+	LEGACY_BOOTING = 0,
+	LEGACY_SUSPEND = 3,
+};
+
+enum WMAX_CONTROL_STATES {
+	WMAX_RUNNING = 0xFF,
+	WMAX_BOOTING = 0,
+	WMAX_SUSPEND = 3,
+};
+
+enum wmax_thermal_mode {
+	THERMAL_MODE_USTT_BALANCED,
+	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
+	THERMAL_MODE_USTT_COOL,
+	THERMAL_MODE_USTT_QUIET,
+	THERMAL_MODE_USTT_PERFORMANCE,
+	THERMAL_MODE_USTT_LOW_POWER,
+	THERMAL_MODE_BASIC_QUIET,
+	THERMAL_MODE_BASIC_BALANCED,
+	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
+	THERMAL_MODE_BASIC_PERFORMANCE,
+	THERMAL_MODE_LAST,
+};
+
+struct color_platform {
+	u8 blue;
+	u8 green;
+	u8 red;
+} __packed;
+
+struct legacy_led_args {
+	struct color_platform colors;
+	u8 brightness;
+	u8 state;
+} __packed;
+
+struct wmax_led_args {
+	u32 led_mask;
+	struct color_platform colors;
+	u8 state;
+} __packed;
+
+struct wmax_brightness_args {
+	u32 led_mask;
+	u32 percentage;
+};
+
+struct alienfx_priv {
+	struct platform_device *pdev;
+	struct led_classdev global_led;
+	struct color_platform colors[4];
+	u8 global_brightness;
+	u8 lighting_control_state;
+};
+
+struct alienfx_ops {
+	int (*upd_led)(struct alienfx_priv *priv, struct wmi_device *wdev,
+		       u8 location);
+	int (*upd_brightness)(struct alienfx_priv *priv, struct wmi_device *wdev,
+			      u8 brightness);
+};
+
+struct alienfx_platdata {
+	struct wmi_device *wdev;
+	struct alienfx_ops ops;
+	u8 num_zones;
+	bool hdmi_mux;
+	bool amplifier;
+	bool deepslp;
+	u8 running_code;
+};
+
+struct awcc_priv {
+	struct wmi_device *wdev;
+	bool has_gmode;
+	struct platform_profile_handler pp_handler;
+	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+};
+
+acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
+				  void *in_args, size_t in_size, u32 *out_data);
+
+int alienfx_wmi_init(struct alienfx_platdata *pdata);
+void alienfx_wmi_exit(struct wmi_device *wdev);
+
+int create_thermal_profile(struct wmi_device *wdev, bool has_gmode);
+void remove_thermal_profile(void);
+
+#endif
-- 
2.47.1


