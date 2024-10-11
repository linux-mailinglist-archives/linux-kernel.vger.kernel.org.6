Return-Path: <linux-kernel+bounces-360592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20E999CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE1D1C22B29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E020966A;
	Fri, 11 Oct 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTCu+jJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C64208997;
	Fri, 11 Oct 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629287; cv=none; b=SJ4iRk3HfbUE0cvh6FnI7jWyWWbaKG5ny33SvvIEeaVK70p5Fym4+OkshP+OjmsBwglF8gFxCGOIeou5uf1bumltNOOQJyFHCzCx3iIeyDZsvgxhpAlzaw2uOMkChE5aBXy8W8AsFp7usUToQsKFkhnSHT2pcgye/QmjBp3mcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629287; c=relaxed/simple;
	bh=roUlvYh8tk5VwX4xgLjM3LKEC9fdBEhoR+wg5elB3ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hexJaAxO90VE2AGWp9ARiPT/dZlPDR0EMlptcDPAP3XQG60xU5Ad0DtLrwgUEpjMoNlZIZcUVd3F3Z3FGhKAOopo658V3ofRbmZEmqejffWQ7yTtgGusnwBdEWH2FnOo7u1a5fXNEz6Btm3xkVzMiJjj2I9AK7L9XOlM06qhXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTCu+jJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3e1081804so1191769a12.3;
        Thu, 10 Oct 2024 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629285; x=1729234085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95SFpqoAUV6SFrATAs96UjJLFFMy1Jx1iNhCNqIgsls=;
        b=TyTCu+jJBYBu8kDgiLqzE9uMJuq8J5ojfgFaW3KmXpJXLcMVEg0kYvDxC7zHU6wywv
         whoSBLv8FGe7X8l+xFmrO6exYJ4Zrnbnc/cdII/poiJD3lsUhVfskaoPzB9PI/Y3i2y7
         Mek/rPO5LmL4wP9wPYy85GguGoFpSDBwSRTssnUBX90/bi+Pt+o+I0M3rIVpledeTEJO
         T7Ms2fwwwAGeSh5eNKId073caI8DHl4vphWR1npznVfrlYj1kRqPZm+cbYyDj2seSx8j
         8n6btkCHRJGPguvWTrSp+CvUkNeYOzA5BHo8DjXeTadkudy//vvL6EaXCmyDC1UoAo07
         cNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629285; x=1729234085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95SFpqoAUV6SFrATAs96UjJLFFMy1Jx1iNhCNqIgsls=;
        b=DpVkV3reZEOqqofU4XJ8D0pIjOGeA7nlV1/w9u9yXoc26MylgFuOCc47EAUTqAqDAm
         ukMLbdB2nFWXU/1ToGoLoTyCNwG/31naAXJk3zUs80JWotPFG1zVLTRxlYx2B18oOB9U
         wWZv6HkAVFgJ3V5npk/MYL/ODZ9NyYHjhMu1aWJM0r7dzvWLqYrGdffSj3hQhjIFO5xU
         7JOomWncHWbmAqdh+NGJk3Bb+7Jdq0rUfHdZ7iCVQEtccamSlNsZdbkOCyHsc3Gz2bio
         SSuKDSeooknHIx/Hg4avEUrlnPUJWE/nxjzDwzZwfiKFo76kU+PA1dKRPoUcxjO1Cmx+
         1Q0g==
X-Forwarded-Encrypted: i=1; AJvYcCVUV/7sZoUqEvhBgLe+518lDlflGpt55biF8BuQyrITzC+1iSONgSj1iGa7kmCUvpvad8/JJ7ArkcPmyea6UpxaWXx/Aw==@vger.kernel.org, AJvYcCWz2ab4/OWYeVd3qLX6mz9RvFGxBvqD0FKJjInOeFulLQAsKE1GTefXXwYSfE0tBsUc1qdDwI/qN2U9UVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Yit3W0djC115RSNvn3jO+6Qs93xKAAhlCAPYQCf5VhWxzT/A
	qaqNxDIp1Jb/Oy7iTFvPVtNbQPaZuV5d9hdmX6yhxx1pAH5CEBRs
X-Google-Smtp-Source: AGHT+IHvNSP0/Ctj7483/cRjWrkletoIDDnLAAtaPDJRRZLgkZWzpu0hH3DORufu7Ed3IuclLv2sPw==
X-Received: by 2002:a05:6a21:3983:b0:1d6:d0d3:c50c with SMTP id adf61e73a8af0-1d8bcfb27abmr2120411637.35.1728629284607;
        Thu, 10 Oct 2024 23:48:04 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a36417afsm4877614a91.0.2024.10.10.23.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:48:03 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 3/4] alienware-wmi: added platform profile support
Date: Fri, 11 Oct 2024 03:47:52 -0300
Message-ID: <20241011064751.306795-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011064336.305795-2-kuurtb@gmail.com>
References: <20241011064336.305795-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Kconfig         |   1 +
 drivers/platform/x86/dell/alienware-wmi.c | 236 ++++++++++++++++++++++
 2 files changed, 237 insertions(+)

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
index 8f7a8bfef..8af2ab7fe 100644
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
@@ -49,11 +58,27 @@ enum WMAX_CONTROL_STATES {
 	WMAX_SUSPEND = 3,
 };
 
+enum WMAX_THERMAL_PROFILE {
+	WMAX_THERMAL_QUIET = 0x96,
+	WMAX_THERMAL_BALANCED = 0x97,
+	WMAX_THERMAL_BALANCED_PERFORMANCE = 0x98,
+	WMAX_THERMAL_PERFORMANCE = 0x99,
+	WMAX_THERMAL_USTT_LOW_POWER = 0xA5,
+	WMAX_THERMAL_USTT_QUIET = 0xA3,
+	WMAX_THERMAL_USTT_BALANCED = 0xA0,
+	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE = 0xA1,
+	WMAX_THERMAL_USTT_PERFORMANCE = 0xA4,
+	WMAX_THERMAL_GMODE = 0xAB,
+};
+
 struct quirk_entry {
 	u8 num_zones;
 	u8 hdmi_mux;
 	u8 amplifier;
 	u8 deepslp;
+	u8 thermal;
+	u8 thermal_ustt;
+	u8 gmode;
 };
 
 static struct quirk_entry *quirks;
@@ -64,6 +89,9 @@ static struct quirk_entry quirk_inspiron5675 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_unknown = {
@@ -71,6 +99,9 @@ static struct quirk_entry quirk_unknown = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r1_r2 = {
@@ -78,6 +109,9 @@ static struct quirk_entry quirk_x51_r1_r2 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r3 = {
@@ -85,6 +119,9 @@ static struct quirk_entry quirk_x51_r3 = {
 	.hdmi_mux = 0,
 	.amplifier = 1,
 	.deepslp = 0,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm100 = {
@@ -92,6 +129,9 @@ static struct quirk_entry quirk_asm100 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm200 = {
@@ -99,6 +139,9 @@ static struct quirk_entry quirk_asm200 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 1,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm201 = {
@@ -106,6 +149,19 @@ static struct quirk_entry quirk_asm201 = {
 	.hdmi_mux = 1,
 	.amplifier = 1,
 	.deepslp = 1,
+	.thermal = 0,
+	.thermal_ustt = 0,
+	.gmode = 0,
+};
+
+static struct quirk_entry quirk_x15_r1 = {
+	.num_zones = 2,
+	.hdmi_mux = 0,
+	.amplifier = 0,
+	.deepslp = 0,
+	.thermal = 0,
+	.thermal_ustt = 1,
+	.gmode = 0,
 };
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -169,6 +225,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
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
@@ -218,6 +283,7 @@ static struct platform_device *platform_device;
 static struct device_attribute *zone_dev_attrs;
 static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
+static struct platform_profile_handler pp_handler;
 
 static struct platform_driver platform_driver = {
 	.driver = {
@@ -761,6 +827,168 @@ static int create_deepsleep(struct platform_device *dev)
 	return ret;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+#define WMAX_PROFILE_MASK	GENMASK(15, 8)
+#define WMAX_PROFILE_ACTIVATE	BIT(0)
+
+static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
+{
+	return FIELD_PREP(WMAX_PROFILE_MASK, prof) | WMAX_PROFILE_ACTIVATE;
+}
+
+static int thermal_profile_get(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile)
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
+				enum platform_profile_option profile)
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
+	if (quirks->thermal > 0)
+		pp_handler.profile_set = thermal_profile_set;
+	else {
+		pp_handler.profile_set = thermal_profile_set_ustt;
+		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
+	}
+
+	set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
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
@@ -808,6 +1036,12 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_deepsleep;
 	}
 
+	if (quirks->thermal > 0 || quirks->thermal_ustt > 0) {
+		ret = create_thermal_profile();
+		if (ret)
+			goto fail_prep_thermal_profile;
+	}
+
 	ret = alienware_zone_init(platform_device);
 	if (ret)
 		goto fail_prep_zones;
@@ -818,6 +1052,7 @@ static int __init alienware_wmi_init(void)
 	alienware_zone_exit(platform_device);
 fail_prep_deepsleep:
 fail_prep_amplifier:
+fail_prep_thermal_profile:
 fail_prep_hdmi:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -835,6 +1070,7 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
+		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.47.0


