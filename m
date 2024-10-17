Return-Path: <linux-kernel+bounces-369408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BBA9A1CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D061F279CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37881CACF7;
	Thu, 17 Oct 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMV5XMHg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C53398B;
	Thu, 17 Oct 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152984; cv=none; b=iOU9jSrDDUAS+k7OZ04AG3UhVmhjoYHzBHp5MoGWs3A9hWnyp9He0v138N5DHQJQRau6M1L+Jo8dujF9CpxrZbEytw7g8NvxPrQOqBhH47M64gq0jvOF2i3GZ4O6H/3RPZgd/ZSbE3qvKMfI6/mYFUzOtOuziIF4mtJUFzjLsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152984; c=relaxed/simple;
	bh=BtWW25QWspbdzM9WoYRYC7Dp2CEImLAiYf2AQzWDhnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA6qj2+ouFl7MEmjqbDf5yqIDPkOp+YnQIScKgfZnkXO3oRW2J5GJBzaI0hUvRV5jd4Jrrl2ABX96BoRQtZHnMjPItg7WsEOO4uDY1dD/zV4LuY1rpEGWPNttUiBES7dNm6WYToJ5QpAvEiNUCSarr0f+b1viGuK24wLTTkw4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMV5XMHg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso470942a91.3;
        Thu, 17 Oct 2024 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152981; x=1729757781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJKKWSJtGTH+Zha/IDGEo1+HvKzQHeVOpKBCtqcEBl8=;
        b=nMV5XMHgzEBPTGCy5EelFgbQ+6np1mVFEz8wOgoL3ygFL15m3hM5ua09pobN3d3Laz
         1Ldojdxyeyt393TbpIecxENonL6HOdi9blGAnjph1GN8rKAfm8daPlE6idTC116u0T4f
         P+F/un78lgXQzvnERDqOq/ecH6bWZgcDb69PJViABDuA4XyBEbcz6UvlUJoX6bckzphG
         fu10q4T79GKgRwolPa48yc1Yis+AL6lOTmBgGBNvQm9cg/wf9Sz3ZPx3C0qlRixcLfaY
         mOe6EvLNb+auITreI7l2kdsNpcao9WbZXtIzP+jGWfHl7Cwv83INJkkEXL1qp16ARlyf
         SBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152981; x=1729757781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJKKWSJtGTH+Zha/IDGEo1+HvKzQHeVOpKBCtqcEBl8=;
        b=laisn4sfoZZtZIyFmxIgzczf/IOA1GCXYcpgqUDXtQgxzmkmCfbpey7h4Cac3uzPGv
         uvMfcYYJrUXIfJcaVh3rnqXKq35sfbLzv6ws9XP6g4mdeeJUPsUaWn/nlPkMVcKhiVtB
         DulWgd0ttCbomiNEgtgYhlzfNgcTbod7eQDUnrmkkGsj8T66/nnGMlQbWmrwJ3Qb/1X7
         +tTAHq3UTrOEPv+wT6M2kzRF17335VjPtHbVd7aLjvQS8Ixgid3hZkyi2z2ImA03GRwG
         rFqwcKYnSKepiTIgKlZVthwdM2EoX5XEfEJj4ETxTzaQpwfXfx0lh1VvqOvmi6sAdOtm
         0tKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/NMKvZ3wYYMYvRoY7z6eVa8so/dYstH4O1wTHG60aF53nQv6BNEYRg7V6TVqHmN33tApSJrBa2kOt8n0=@vger.kernel.org, AJvYcCXL3ecF18Vwxt4XCxjNov4wsnJx4ny+011Fh5dRcTTz2Rn2rZBUm/fi+Ivur1wExHpsH4qudIdvIZYHrrS+RW0mD+ws/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyokvVp1yomt/QTfSgVIzVNyBFAXbLgxmHJV3LXD8N0LmZTm6/i
	dTNo3tjKWgGHmUO4pq2gpONq6xV3gWNDPqqpKphkQvieeIxe19Xh
X-Google-Smtp-Source: AGHT+IGFpQ2iaN29rVbnMub9g2VbmqhDYvwsIoN3G5G0JqMVk4/fJHHnoTqBd0nTQIw+e+ObmRVdfg==
X-Received: by 2002:a17:90b:4c02:b0:2e2:bd4b:ac2c with SMTP id 98e67ed59e1d1-2e3ab8bcef5mr8325482a91.31.1729152981500;
        Thu, 17 Oct 2024 01:16:21 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f9913sm1343963a91.44.2024.10.17.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:16:21 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 3/5] alienware-wmi: added platform profile support
Date: Thu, 17 Oct 2024 05:15:25 -0300
Message-ID: <20241017081524.127072-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017081211.126214-2-kuurtb@gmail.com>
References: <20241017081211.126214-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements platform profile support for Dell laptops with new WMAX
thermal interface, present on some Alienware X-Series, Alienware
M-Series and Dell's G-Series laptops. 

This implementation supports three sets of thermal tables declared in
enum WMAX_THERMAL_TABLE and gmode, using quirks *thermal* and *gmode*
respectively. These sets are found in most Dell's devices that support
WMAX's thermal interface.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>

---
v6:
 - Fixed alignment on some function definitions
 - Fixed braces on if statment
 - Removed quirk thermal_ustt
 - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
 - Proper removal of thermal_profile
---
 drivers/platform/x86/dell/Kconfig         |   1 +
 drivers/platform/x86/dell/alienware-wmi.c | 251 ++++++++++++++++++++++
 2 files changed, 252 insertions(+)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 68a49788a..b06d634cd 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -21,6 +21,7 @@ config ALIENWARE_WMI
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
 	depends on ACPI_WMI
+	select ACPI_PLATFORM_PROFILE
 	help
 	 This is a driver for controlling Alienware BIOS driven
 	 features.  It exposes an interface for controlling the AlienFX
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index b27f3b64c..37a898273 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -8,8 +8,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/platform_profile.h>
 #include <linux/dmi.h>
 #include <linux/leds.h>
 
@@ -25,6 +28,12 @@
 #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
 #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
 #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
+#define WMAX_METHOD_THERMAL_INFORMATION	0x14
+#define WMAX_METHOD_THERMAL_CONTROL	0x15
+
+#define WMAX_ARG_GET_CURRENT_PROF	0x0B
+
+#define WMAX_FAILURE_CODE		0xFFFFFFFF
 
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
@@ -49,11 +58,33 @@ enum WMAX_CONTROL_STATES {
 	WMAX_SUSPEND = 3,
 };
 
+enum WMAX_THERMAL_TABLE {
+	WMAX_THERMAL_TABLE_SIMPLE	= 1,
+	WMAX_THERMAL_TABLE_USTT		= 2,
+	WMAX_THERMAL_TABLE_USTT_COOL	= 3,
+};
+
+enum WMAX_THERMAL_PROFILE {
+	WMAX_THERMAL_QUIET			= 0x96,
+	WMAX_THERMAL_BALANCED			= 0x97,
+	WMAX_THERMAL_BALANCED_PERFORMANCE	= 0x98,
+	WMAX_THERMAL_PERFORMANCE		= 0x99,
+	WMAX_THERMAL_USTT_LOW_POWER		= 0xA5,
+	WMAX_THERMAL_USTT_COOL			= 0xA2,
+	WMAX_THERMAL_USTT_QUIET			= 0xA3,
+	WMAX_THERMAL_USTT_BALANCED		= 0xA0,
+	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE	= 0xA1,
+	WMAX_THERMAL_USTT_PERFORMANCE		= 0xA4,
+	WMAX_THERMAL_GMODE			= 0xAB,
+};
+
 struct quirk_entry {
 	u8 num_zones;
 	u8 hdmi_mux;
 	u8 amplifier;
 	u8 deepslp;
+	u8 thermal;
+	u8 gmode;
 };
 
 static struct quirk_entry *quirks;
@@ -64,6 +95,8 @@ static struct quirk_entry quirk_inspiron5675 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_unknown = {
@@ -71,6 +104,8 @@ static struct quirk_entry quirk_unknown = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r1_r2 = {
@@ -78,6 +113,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r3 = {
@@ -85,6 +122,8 @@ static struct quirk_entry quirk_x51_r3 = {
 	.hdmi_mux = 0,
 	.amplifier = 1,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm100 = {
@@ -92,6 +131,8 @@ static struct quirk_entry quirk_asm100 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm200 = {
@@ -99,6 +140,8 @@ static struct quirk_entry quirk_asm200 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 1,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm201 = {
@@ -106,6 +149,17 @@ static struct quirk_entry quirk_asm201 = {
 	.hdmi_mux = 1,
 	.amplifier = 1,
 	.deepslp = 1,
+	.thermal = 0,
+	.gmode = 0,
+};
+
+static struct quirk_entry quirk_x15_r1 = {
+	.num_zones = 2,
+	.hdmi_mux = 0,
+	.amplifier = 0,
+	.deepslp = 0,
+	.thermal = WMAX_THERMAL_TABLE_USTT,
+	.gmode = 0,
 };
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -169,6 +223,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_asm201,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware x15 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
+		},
+		.driver_data = &quirk_x15_r1,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Dell Inc. Inspiron 5675",
@@ -218,6 +281,7 @@ static struct platform_device *platform_device;
 static struct device_attribute *zone_dev_attrs;
 static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
+static struct platform_profile_handler pp_handler;
 
 static struct platform_driver platform_driver = {
 	.driver = {
@@ -761,6 +825,184 @@ static int create_deepsleep(struct platform_device *dev)
 	return ret;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+#define WMAX_ARGUMENT_MASK	GENMASK(15, 8)
+#define WMAX_PROFILE_ACTIVATE	0x01
+
+static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
+{
+	return FIELD_PREP(WMAX_ARGUMENT_MASK, prof) | WMAX_PROFILE_ACTIVATE;
+}
+
+static int thermal_profile_get(struct platform_profile_handler *pprof,
+			       enum platform_profile_option *profile)
+{
+	acpi_status status;
+	u32 in_args = WMAX_ARG_GET_CURRENT_PROF;
+	u32 out_data;
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (out_data == WMAX_FAILURE_CODE)
+		return -EBADRQC;
+
+	switch (out_data) {
+	case WMAX_THERMAL_USTT_LOW_POWER:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	case WMAX_THERMAL_USTT_COOL:
+		*profile = PLATFORM_PROFILE_COOL;
+		break;
+	case WMAX_THERMAL_QUIET:
+	case WMAX_THERMAL_USTT_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	case WMAX_THERMAL_BALANCED:
+	case WMAX_THERMAL_USTT_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case WMAX_THERMAL_BALANCED_PERFORMANCE:
+	case WMAX_THERMAL_USTT_BALANCED_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
+		break;
+	case WMAX_THERMAL_GMODE:
+	case WMAX_THERMAL_PERFORMANCE:
+	case WMAX_THERMAL_USTT_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int thermal_profile_set(struct platform_profile_handler *pprof,
+			       enum platform_profile_option profile)
+{
+	acpi_status status;
+	u32 in_args;
+	u32 out_data;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_QUIET:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		if (quirks->gmode > 0)
+			in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
+		else
+			in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL, &out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (out_data == WMAX_FAILURE_CODE)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int thermal_profile_set_ustt(struct platform_profile_handler *pprof,
+				    enum platform_profile_option profile)
+{
+	acpi_status status;
+	u32 in_args;
+	u32 out_data;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_LOW_POWER);
+		break;
+	case PLATFORM_PROFILE_COOL:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_COOL);
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_QUIET);
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_BALANCED);
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_BALANCED_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		if (quirks->gmode > 0)
+			in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
+		else
+			in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_PERFORMANCE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL, &out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (out_data == WMAX_FAILURE_CODE)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int create_thermal_profile(void)
+{
+	pp_handler.profile_get = thermal_profile_get;
+
+	switch (quirks->thermal) {
+	case WMAX_THERMAL_TABLE_SIMPLE:
+		pp_handler.profile_set = thermal_profile_set;
+		break;
+	case WMAX_THERMAL_TABLE_USTT:
+		pp_handler.profile_set = thermal_profile_set_ustt;
+		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
+		break;
+	case WMAX_THERMAL_TABLE_USTT_COOL:
+		pp_handler.profile_set = thermal_profile_set_ustt;
+		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_COOL, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
+		break;
+	}
+
+	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
+
+	return platform_profile_register(&pp_handler);
+}
+
+static void remove_thermal_profile(void)
+{
+	if (quirks->thermal > 0)
+		platform_profile_remove();
+}
+
 static int __init alienware_wmi_init(void)
 {
 	int ret;
@@ -808,6 +1050,12 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_deepsleep;
 	}
 
+	if (quirks->thermal > 0) {
+		ret = create_thermal_profile();
+		if (ret)
+			goto fail_prep_thermal_profile;
+	}
+
 	ret = alienware_zone_init(platform_device);
 	if (ret)
 		goto fail_prep_zones;
@@ -816,6 +1064,8 @@ static int __init alienware_wmi_init(void)
 
 fail_prep_zones:
 	alienware_zone_exit(platform_device);
+	remove_thermal_profile();
+fail_prep_thermal_profile:
 fail_prep_deepsleep:
 fail_prep_amplifier:
 fail_prep_hdmi:
@@ -835,6 +1085,7 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
+		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.47.0


