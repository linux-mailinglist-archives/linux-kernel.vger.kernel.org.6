Return-Path: <linux-kernel+bounces-379255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9DF9ADC15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231BE1F232E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FD318990D;
	Thu, 24 Oct 2024 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjEbpx7H"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5117A586;
	Thu, 24 Oct 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750913; cv=none; b=XVuzRyfsUIQ0rXz8BWQHavAfGXpCPPK8njEIGIDyzF8QzkwpDmlvgOWloYK+y9vX+4O9DhkPq7KwQrGEWBI00sFah8zJvdy8NSZJZLH77ed8P3c7Z8ZJDpzHxg4EcpA6U1RAKWt2JkpjprcmQe9wzWUIwJ6XEwCj+T8A1rCve2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750913; c=relaxed/simple;
	bh=EKDKKf3wq3TTOWCTBQrl2cBmw0r8AHV115LHR8xE3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6of+6lIa/MF97N9aGweZCbXi63aJlKb3zgiZgly+XgBWBPOVnzRNY2+PIvUdt1WuKrHSv8jM6pKR5d4PYSpkKZ4nbvydyJFE5kJTI+ksoD1ECk3QRjVNW9bupJczKhGAjnPf3dc9m8GRpe9ORekT3ALwkgBEk9wqJLC1XX7bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjEbpx7H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1175527a12.1;
        Wed, 23 Oct 2024 23:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750910; x=1730355710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOoHNQBSMYBy6k1di2QmdpB3YrUOvwhni6V9g57tS9s=;
        b=LjEbpx7Ho4tpHyxdNrgV4MpL7wtqTqqXn2omiYPVYXmjlZtaOjM56mfEAGb3zAl+83
         fB8k8d6NG0K8g4+XXcKS1avrgitVuvKp2xzNxmll1ZTiRTf3+O3AqaXWuXoR3abqMZwd
         WqvUtwtfubyDRzsJ5RUDa7SLC4EUraeJINIX7vX0bdrMUlPWFXKWWIAbnlVGFKdZ6tO2
         8H4K5IOmwwES8h5MCzhnrsvS84d4SFqFQSvNWzx9+asSWnPaA/2n+eq67wIXeEvYxb69
         ER4bDGqdTiQuOZFxW7kHDqPwkFhTUpPY3ExnxNuO/h07GmWW7u1t2cyo3lZLjAkgHfjs
         g6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750910; x=1730355710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOoHNQBSMYBy6k1di2QmdpB3YrUOvwhni6V9g57tS9s=;
        b=lPwALw8Je6re+Y3lix4qMboznzIcB2S1H+vHWcFjPHIWasXBZdWLxvKCBBzoFb5vaR
         QeOGZjRR9lK1P1Dh7kfUrt8bh6eeUWnQosL9249fhhsPWzEr00zAJtBx3eeAVYV2lKpL
         iLbDKurN/DGNzroz+TbmSuHsEdbivu9EiJJC4uPJWnwBRU74b/b1u6seQMeXl0Q6wD09
         P+AGjRQG2Tu264Yh3YROiPZ1RHnrkK2ozrGLZBCkhchwJhCvaN2PplTAmzr8Oj/6XAdO
         a1NOdlrtfXc5jw7TQJCD3hNsFKDQzNgnN7GcpIb2aMgaXHJXNmPIobnjaQdo5qBbvoKb
         jOew==
X-Forwarded-Encrypted: i=1; AJvYcCULn9ViREnMPBhurZxe380Ou9HCILtILGZ7KxudMWbaB1Z9fUAKUU4P/6r3IHskyDIGI+2dM32udWrN2uCZzJhIi6y+2A==@vger.kernel.org, AJvYcCX8gxVTyjciC7pOicY/+g/M++FFcXZ6oOm8ssyHkoEiib8uSdgmv4w09VVrLjO3sJcQ2vsZkt8b2hZ1NKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkzSBJdGBL9mrN4YUl+pCZzGDBGOvEvzDp58F4pPFlY1OR1H9j
	b30jHbxHB30sPhDDqDJQR4KnloVyshUKmWB+BeFvrmWAScf29yXI
X-Google-Smtp-Source: AGHT+IGoKKp07x5WG+lwddLv1PQizhj8BtU8Qr+Hz5w1tXMAcXssx31hMRLctI7HbV3pv1HlWS7MGQ==
X-Received: by 2002:a17:90a:fd04:b0:2e2:b719:d582 with SMTP id 98e67ed59e1d1-2e77e6405f5mr1671726a91.14.1729750909583;
        Wed, 23 Oct 2024 23:21:49 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfebad3sm2584172a91.55.2024.10.23.23.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:21:49 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 3/4] alienware-wmi: added platform profile support
Date: Thu, 24 Oct 2024 03:19:03 -0300
Message-ID: <20241024061901.34793-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024061547.33918-2-kuurtb@gmail.com>
References: <20241024061547.33918-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements platform profile support for Dell laptops with new WMAX thermal
interface, present on some Alienware X-Series, Alienware M-Series and
Dell's G-Series laptops. 

This implementation automatically detects available thermal profiles and
GMODE + Game Shift availability, which is a feature of G-Series laptops.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v7:
 - Method operations are now clearly listed as separate enums
 - wmax_thermal_modes are now listed without codes in order to support
   autodetection, as well as getting and setting thermal profiles
   cleanly through arrays
 - Added wmax_mode_to_platform_profile[]
 - Added struct wmax_u32_args to replace bit mask approach of
   constructing arguments for wmax methods
 - create_thermal_profile now autodetects available thermal codes
   through operation 0x03 of THERMAL_INFORMATION method. These are
   codes are stored in supported_thermal_profiles[]
 - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead of
   switch-case approach
 - thermal_profile_set now uses supported_thermal_profiles[] instead of
   switch-case approach
 - When gmode is autodetected, thermal_profile_set also sets Game Shift
   status accordingly
v6:
 - Fixed alignment on some function definitions
 - Fixed braces on if statment
 - Removed quirk thermal_ustt
 - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
 - Proper removal of thermal_profile
---
This refactor was done in order to autodetect available thermal modes
efficently through operation 0x03.

This new array approach exploits the fact that the first 4 bits of every
thermal code are consecutive from 0 to 9, however next 4 bits are not
consecutive (available thermal codes are documented in patch 4/4) so full
codes are dynamically probed based on rules found in is_wmax_thermal_code().
---
 drivers/platform/x86/dell/Kconfig         |   1 +
 drivers/platform/x86/dell/alienware-wmi.c | 282 ++++++++++++++++++++++
 2 files changed, 283 insertions(+)

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
index b27f3b64c..9ce6e794a 100644
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
 
@@ -25,6 +28,13 @@
 #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
 #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
 #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
+#define WMAX_METHOD_THERMAL_INFORMATION	0x14
+#define WMAX_METHOD_THERMAL_CONTROL	0x15
+#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
+
+#define WMAX_THERMAL_MODE_GMODE		0xAB
+
+#define WMAX_FAILURE_CODE		0xFFFFFFFF
 
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
@@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
 	WMAX_SUSPEND = 3,
 };
 
+enum WMAX_THERMAL_INFORMATION_OPERATIONS {
+	WMAX_OPERATION_LIST_IDS		= 0x03,
+	WMAX_OPERATION_CURRENT_PROFILE	= 0x0B,
+};
+
+enum WMAX_THERMAL_CONTROL_OPERATIONS {
+	WMAX_OPERATION_ACTIVATE_PROFILE	= 0x01,
+};
+
+enum WMAX_GAMESHIFT_STATUS_OPERATIONS {
+	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
+	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
+};
+
+enum WMAX_THERMAL_TABLES {
+	WMAX_THERMAL_TABLE_BASIC	= 0x90,
+	WMAX_THERMAL_TABLE_USTT		= 0xA0,
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
+static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
+	[THERMAL_MODE_USTT_BALANCED] = PLATFORM_PROFILE_BALANCED,
+	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE] = PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[THERMAL_MODE_USTT_COOL] = PLATFORM_PROFILE_COOL,
+	[THERMAL_MODE_USTT_QUIET] = PLATFORM_PROFILE_QUIET,
+	[THERMAL_MODE_USTT_PERFORMANCE] = PLATFORM_PROFILE_PERFORMANCE,
+	[THERMAL_MODE_USTT_LOW_POWER] = PLATFORM_PROFILE_LOW_POWER,
+	[THERMAL_MODE_BASIC_QUIET] = PLATFORM_PROFILE_QUIET,
+	[THERMAL_MODE_BASIC_BALANCED] = PLATFORM_PROFILE_BALANCED,
+	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE] = PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[THERMAL_MODE_BASIC_PERFORMANCE] = PLATFORM_PROFILE_PERFORMANCE,
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
@@ -64,6 +122,8 @@ static struct quirk_entry quirk_inspiron5675 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_unknown = {
@@ -71,6 +131,8 @@ static struct quirk_entry quirk_unknown = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r1_r2 = {
@@ -78,6 +140,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r3 = {
@@ -85,6 +149,8 @@ static struct quirk_entry quirk_x51_r3 = {
 	.hdmi_mux = 0,
 	.amplifier = 1,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm100 = {
@@ -92,6 +158,8 @@ static struct quirk_entry quirk_asm100 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm200 = {
@@ -99,6 +167,8 @@ static struct quirk_entry quirk_asm200 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 1,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm201 = {
@@ -106,6 +176,8 @@ static struct quirk_entry quirk_asm201 = {
 	.hdmi_mux = 1,
 	.amplifier = 1,
 	.deepslp = 1,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -214,10 +286,19 @@ struct wmax_led_args {
 	u8 state;
 } __packed;
 
+struct wmax_u32_args {
+	u8 operation;
+	u8 arg1;
+	u8 arg2;
+	u8 arg3;
+};
+
 static struct platform_device *platform_device;
 static struct device_attribute *zone_dev_attrs;
 static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
+static struct platform_profile_handler pp_handler;
+static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
 static struct platform_driver platform_driver = {
 	.driver = {
@@ -761,6 +842,198 @@ static int create_deepsleep(struct platform_device *dev)
 	return ret;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
+#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
+
+static bool is_wmax_thermal_code(u32 code)
+{
+	return ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC ||
+	       (code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT) &&
+	       (code & WMAX_THERMAL_MODE_MASK) < THERMAL_MODE_LAST;
+}
+
+static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = operation,
+		.arg1 = arg,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_INFORMATION,
+					out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (*out_data == WMAX_FAILURE_CODE)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int wmax_thermal_control(u8 operation, u8 arg)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = operation,
+		.arg1 = arg,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+	u32 out_data;
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL,
+					&out_data);
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
+static int wmax_gameshift_status(u8 operation, u32 *out_data)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = operation,
+		.arg1 = 0,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_GAME_SHIFT_STATUS,
+					out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (*out_data == WMAX_FAILURE_CODE)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int thermal_profile_get(struct platform_profile_handler *pprof,
+			       enum platform_profile_option *profile)
+{
+	u32 out_data;
+	int ret;
+
+	ret = wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
+				       0, &out_data);
+
+	if (ret < 0)
+		return ret;
+
+	if (!is_wmax_thermal_code(out_data))
+		return -ENODATA;
+
+	out_data &= WMAX_THERMAL_MODE_MASK;
+	*profile = wmax_mode_to_platform_profile[out_data];
+
+	return 0;
+}
+
+static int thermal_profile_set(struct platform_profile_handler *pprof,
+			       enum platform_profile_option profile)
+{
+	if (quirks->gmode == 1) {
+		u32 gmode_status;
+		int ret;
+
+		ret = wmax_gameshift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+					    &gmode_status);
+
+		if (ret < 0)
+			return ret;
+
+		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
+		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
+			ret = wmax_gameshift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
+						&gmode_status);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return wmax_thermal_control(WMAX_OPERATION_ACTIVATE_PROFILE,
+				    supported_thermal_profiles[profile]);
+}
+
+static int create_thermal_profile(void)
+{
+	u32 out_data;
+	u32 gmode_status;
+	enum wmax_thermal_mode mode;
+	enum platform_profile_option profile;
+	int ret;
+
+	for (u8 i = 0x2; i <= 0xD; i++) {
+		ret = wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
+					       i, &out_data);
+
+		if (ret == -EIO)
+			return 0;
+
+		if (ret == -EBADRQC)
+			break;
+
+		if (!is_wmax_thermal_code(out_data))
+			continue;
+
+		mode = out_data & WMAX_THERMAL_MODE_MASK;
+		profile = wmax_mode_to_platform_profile[mode];
+		supported_thermal_profiles[profile] = out_data;
+
+		set_bit(profile, pp_handler.choices);
+	}
+
+	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
+		return 0;
+
+	ret = wmax_gameshift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+				    &gmode_status);
+
+	if (!ret) {
+		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+			WMAX_THERMAL_MODE_GMODE;
+
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
+		quirks->gmode = 1;
+	}
+
+	pp_handler.profile_get = thermal_profile_get;
+	pp_handler.profile_set = thermal_profile_set;
+
+	ret = platform_profile_register(&pp_handler);
+	if (ret < 0)
+		return ret;
+
+	quirks->thermal = 1;
+
+	return 0;
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
@@ -808,6 +1081,12 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_deepsleep;
 	}
 
+	if (interface == WMAX && quirks == &quirk_unknown) {
+		ret = create_thermal_profile();
+		if (ret)
+			goto fail_prep_thermal_profile;
+	}
+
 	ret = alienware_zone_init(platform_device);
 	if (ret)
 		goto fail_prep_zones;
@@ -816,6 +1095,8 @@ static int __init alienware_wmi_init(void)
 
 fail_prep_zones:
 	alienware_zone_exit(platform_device);
+	remove_thermal_profile();
+fail_prep_thermal_profile:
 fail_prep_deepsleep:
 fail_prep_amplifier:
 fail_prep_hdmi:
@@ -835,6 +1116,7 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
+		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.47.0


