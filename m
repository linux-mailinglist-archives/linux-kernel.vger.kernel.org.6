Return-Path: <linux-kernel+bounces-362017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B699AFFC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E26C1C2187F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A30DF49;
	Sat, 12 Oct 2024 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPbnkRSC"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593CDDAB;
	Sat, 12 Oct 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698595; cv=none; b=Npip1t9PH0JxKIt7Jb43+8p09rJ0RhM1/dcbEUvkIDoJyuzzgWSW4PlpsPYNt3eiPio7nqbzR3ONmbXydtnl3YwZDNATOIBWtwk8ki6lISpxoKxZVYIhjbc6rX72ZhgWTSTe6He5khGQvFXXx70mXR+PcF8CviJoqARprJJ7baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698595; c=relaxed/simple;
	bh=lWz8Z5uX6RChaZLi+ypEaFiUBvVBw5nE6aP+D0ICjUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yas6zS4WWK7KjH88e8lr5qlF0XQ+E9/gyEL/fVgpgEJxRZ1sXcsi+1ENdMFh6JTno7o2KJFYR6wA5X1vqrlEIIUOcPqMSvRDoGRJC+bp4sQKc7M6xhVKC7lfwfwpNUPplkwayMJ3j44cbFR84152SMGDrTM1zlQa/46KNuirgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPbnkRSC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b93887decso24223735ad.3;
        Fri, 11 Oct 2024 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728698592; x=1729303392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGBbpSyDzxvkBFLRkjuldRmz7eKj2V2RMU8AliydPwI=;
        b=DPbnkRSCS1DdU+lMccZZC3cpNk04AyEe1UYChB0rcMHe9o1PE59A9D24D2Mx73EAnO
         hZj4hfs94DNyB9855YHp9GhXZqoaeJV2AH/sTbV5hMPP3WJEDR7/AN5csJ9KNWDjCdQo
         Fy+JRaUuOHNx6VFmpQE4pR3z75/FjLnwO6Qni5RXSZEO20XRXAowATt0NDuhPKmN3dsd
         Z0PaJM5BtmTPXatd4rCX4E8c2uwgoGpBPkf4qvBCRcPOEEQqIXpk/cv38eEVvNKgc6i3
         ifv57rbUnfZuleOcp+vaHWgp4HYn91XgGjDw+6a3WAXu6Y4KwGn+KPRVgWJAAFxI3p94
         1CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728698592; x=1729303392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGBbpSyDzxvkBFLRkjuldRmz7eKj2V2RMU8AliydPwI=;
        b=p4ibBwx3M2fk5W0WrzJY82Ewn1IihUJm5VXrOpL23AIa6y3D5EaR2VgysQW0ou0snB
         htDAQlIBL34uu2w8om4TsATEa2VOD1uXxc6xKZmS9Rnvkz/KHegw//8JYtf6M5g85pjG
         ELhmWE594Rbh8XgHfcxrbsZQzTCZr59A8fvhOELJMuiS823Gf1RhFGw+i0c5KeEAByxh
         aCV0eo/QfvcWvJXiZ3ViHg0SjXSRLswASqfC6kofPIiM/sb8aRNn9S3ABmthl/rYdXOJ
         yLWLgGvAjWYCPi0ewxfRF5qjt31/5dZILbsJ7Am9Z6IiEHHTyZIpIXdH6+ARmSGUq2SS
         ibpw==
X-Forwarded-Encrypted: i=1; AJvYcCUcKCK/v8z7S7pSD7W4OZnwqLmdQOOJHshQFnMyH4gLFWadd/hBr9SDzXB2bCAqd6nKSgdCLsU/EM32k1g=@vger.kernel.org, AJvYcCVF2QYtcElNdGiJdmo167i5Y4U/PZGJzqFpnKOthtUg5HQC3yvFvzypJGXrJGFaJny3X/ifYjKW4CR9N5wT5+W2Y711fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaHF0zoaNM+hNqs86iXtkmV1laXA/zFtsiYFkA3j9zFm8wTsU
	FkHmKCP/jUvG5a1tjVmU1udlAuO7hGujq+c7FvLITgJkqapkE4Yc
X-Google-Smtp-Source: AGHT+IFMxWHbmLU7a3tivX7UPYNLb4QUOYFWmlnmbDOwVNbVicfxO7Um2fK4aplLM22ds3BwMwI2jw==
X-Received: by 2002:a17:902:e548:b0:20c:a7db:97bc with SMTP id d9443c01a7336-20cbb183517mr27396825ad.12.1728698592456;
        Fri, 11 Oct 2024 19:03:12 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e09eb1fsm259397a12.67.2024.10.11.19.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 19:03:11 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 3/4] alienware-wmi: added platform profile support
Date: Fri, 11 Oct 2024 23:02:38 -0300
Message-ID: <20241012020237.20057-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241012015849.19036-3-kuurtb@gmail.com>
References: <20241012015849.19036-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements platform profile support for Dell laptops with new WMAX
thermal interface, present on some Alienware X-Series, Alienware
M-Series and Dell's G-Series laptops. This implementation supports two
sets of thermal profile codes, namely *thermal* and *thermal_ustt*, plus
additional quirk *gmode* for Dell's G-Series laptops.

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
index b27f3b64c..6e30e9376 100644
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


