Return-Path: <linux-kernel+bounces-380864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E59AF712
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4741F2104F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5A61FCE;
	Fri, 25 Oct 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAuF5LbT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257B4C83;
	Fri, 25 Oct 2024 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820531; cv=none; b=DTytjDhM829g72G/Wq1ec/BX3IqqK3vCxEChbHBhjr5rNjLwJIwgxgc6fOvm7590t3486QBAuS0u3Xhnule80lIowAVqgC4vImzQwmsoyU8jXdPCe+aHpTkT70vvi0fuqfxv6o9mCkM6Zrz0a4Oiu+KcLC1e9LSMQ7owFXtEzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820531; c=relaxed/simple;
	bh=Nt2UofqbeCoUOjOMT1mCPMokNFFd5eY8FHruC3SJ/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9qUAqpXGcDQyn18/ws5NB57Z70kjmCWZYR10QE97PQLZqL/RRBxO7n10oVw8jtUvBpXl5H+ANfL61+E9IPvC09yodrnQeNq9xVvoQtH1HHO6P9I4pQGmFPj75WBCtfPKNP+VGYfESTbRxGGy9kag7JZHP8Cd25W+LIUyz6HKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAuF5LbT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c77459558so12323215ad.0;
        Thu, 24 Oct 2024 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729820528; x=1730425328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qziMnJMpD/TygSwhz9sRscUzDiGIdZ5DmiglzjD8i8=;
        b=fAuF5LbTsjdKif24w4RvzDzrCsdO9v8CjRwFrWNTfF3fls/q8hHZcOhTyKh+UAKw/T
         lPEfzZ9TOoDHjhVi8yvcnWBSMaH3MhXr9EvgrmSJlk4eaGw9m2+WBtuB9+QRuILU/RcO
         nvpMVzoobY93sMtn3+7NxORGJeDJ2/Rjco+PwA+JjedQUW4Z6w/UJANTaWnPnKHoL4pE
         B2avsDdl6J/RPagKQP1YSDNRAl+/E+xW2pb7sA7O1QLS1l3SLvr7IJ+k6dMs5kSeDQCV
         fxMtMbg7MdEC9UGUiDf7vYalT13wk2F2lv/rk+alDQLoRnH9xkUAUTQJ1LLwKPova6f9
         XHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820528; x=1730425328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qziMnJMpD/TygSwhz9sRscUzDiGIdZ5DmiglzjD8i8=;
        b=a96givPwxYegKx6r/HWSLQ51AZ49hkNOBqsauSZ39ZUqfrKDqwzDBoeVvXsgDahWoY
         xWEWYd8mInyueoz0s4sOmRW2PR+aV4vuMnoEG4BZZ24rUqr8n1Emd/6T0YK7/rG23kT2
         80gVhNs/Xy33t0uT1NTSxvYgrlFQHC1GLx3BPk4MYabwG48QuaM6LPjWkDnaezp+o1MV
         owemBy/LRKpxfz/pd6ggDKxL2+b2jCQ4hZJ+qKwF0sa/hW63OEMf3Esup58XWnM5dGVk
         hSce+YmKRw1ZGegurpdHpWL/3M10qGqmtpQFxnrAcJnSiH9wiZ7DpKcmL6iN4wDG1o6/
         Ud3w==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ7T0SD6pqhvBqMA5gZPqkKhNlybXCjcdQCiqqkVvt6Ybu7qzqBRZP25JkY0c6rcs8iOB/0hs2FB7Nfg=@vger.kernel.org, AJvYcCXnVOEOlUDstfoWNS5t19rvKNTRr8HN88d2gXKlaSn49wcFTebvVZZ1KXF3UO1r7hv29SOlu2AKl8UlToDTQDZxw8UUpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7l23LbsYun34CZQG93m45whiMDEFT5k+mCM4+2Yi7iQVwiU4e
	/Vkm+V+bSg752mbKqhbZQLfDyrnLJt4X2ENMIA4UrnTfUvAJyNDt
X-Google-Smtp-Source: AGHT+IERhJJ5yXtmU7/XkQC6TmXsoFn75ehFWnlqNJdIL7eUp+/qe0P+okTO4jN779wPz0ccNi8ADw==
X-Received: by 2002:a05:6a21:1349:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1d978badf29mr10408418637.36.1729820528126;
        Thu, 24 Oct 2024 18:42:08 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791dd81sm81636b3a.7.2024.10.24.18.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:42:07 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 3/4] alienware-wmi: added platform profile support
Date: Thu, 24 Oct 2024 22:41:26 -0300
Message-ID: <20241025014125.5290-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025013856.4729-2-kuurtb@gmail.com>
References: <20241025013856.4729-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements platform profile support for Dell laptops with new WMAX thermal
interface, present on some Alienware X-Series, Alienware M-Series and
Dell's G-Series laptops. This interface is suspected to be used by
Alienware Command Center (AWCC), which is not available for linux
systems, to manage thermal profiles.

This implementation makes use of three WMI methods, namely
THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which take
u32 as input and output arguments. Each method has a set of supported
operations specified in their respective enums.

Wrappers written for these methods support multiple operations.

THERMAL_CONTROL switches thermal modes through operation
ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtime
and matched against a list of known thermal codes:

Thermal Table "User Selectable Thermal Tables" (USTT):
	BALANCED			0xA0
	BALANCED_PERFORMANCE		0xA1
	COOL				0xA2
	QUIET				0xA3
	PERFORMANCE			0xA4
	LOW_POWER			0xA5

Thermal Table Basic:
	QUIET				0x96
	BALANCED			0x97
	BALANCED_PERFORMANCE		0x98
	PERFORMANCE			0x99

Devices are known to implement only one of these tables without mixing
their thermal codes.

The fact that the least significant digit of every thermal code is
consecutive of one another is exploited to efficiently match codes
through arrays.

Autodetection of available codes is done through operation LIST_IDS of
method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor ID,
GPU sensor ID and available thermal profile codes, *in that order*. As
number of fans and thermal codes is very model dependent, almost every
ID is scanned and matched based on conditions found on
is_wmax_thermal_code(). The known upper bound for the number of IDs is
13, corresponding to a device that have 4 fans, 2 sensors and 7 thermal
codes.

Additionally G-Series laptops have a key called G-key, which (with AWCC
proprietary driver) switches the thermal mode to an special mode named
GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift is a
mode the manufacturer claims, increases gaming performance.

GAME_SHIFT_STATUS method is used to mimic this behavior when selecting
PLATFORM_PROFILE_PERFORMANCE option.

All of these profiles are known to only change fan speed profiles,
although there are untested claims that some of them also change power
profiles.

Activating a thermal mode with method THERMAL_CONTROL may cause short
hangs. This is a known problem present on every platform.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v8:
 - Fixed alignment in wmax_mode_to_platform_profile[]
 - Quirk thermal and gmode changed from u8 -> bool
 - Autodetected quirk entries are not initialized
 - is_wmax_thermal_code refactored to increase readibility
 - is_wmax_thermal_code now covers all possibilities
 - Better commit message
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
 drivers/platform/x86/dell/Kconfig         |   1 +
 drivers/platform/x86/dell/alienware-wmi.c | 280 ++++++++++++++++++++++
 2 files changed, 281 insertions(+)

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
index b27f3b64c..898b37be7 100644
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
+	WMAX_OPERATION_LIST_IDS			= 0x03,
+	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
+};
+
+enum WMAX_THERMAL_CONTROL_OPERATIONS {
+	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
+};
+
+enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
+	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
+	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
+};
+
+enum WMAX_THERMAL_TABLES {
+	WMAX_THERMAL_TABLE_BASIC		= 0x90,
+	WMAX_THERMAL_TABLE_USTT			= 0xA0,
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
+	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
+	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
+	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
+	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
+	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
+	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
+	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
+	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
+};
+
 struct quirk_entry {
 	u8 num_zones;
 	u8 hdmi_mux;
 	u8 amplifier;
 	u8 deepslp;
+	bool thermal;	/* Autodetected. Do not initialize explicitly. */
+	bool gmode;	/* Autodetected. Do not initialize explicitly. */
 };
 
 static struct quirk_entry *quirks;
@@ -214,10 +272,19 @@ struct wmax_led_args {
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
@@ -761,6 +828,210 @@ static int create_deepsleep(struct platform_device *dev)
 	return ret;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
+#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
+#define WMAX_SENSOR_ID_MASK		BIT(8)
+
+static bool is_wmax_thermal_code(u32 code)
+{
+	if (code & WMAX_SENSOR_ID_MASK)
+		return false;
+
+	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
+		return false;
+
+	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC &&
+	    (code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_BASIC_BALANCED)
+		return true;
+
+	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT &&
+	    (code & WMAX_THERMAL_MODE_MASK) <= THERMAL_MODE_USTT_LOW_POWER)
+		return true;
+
+	return false;
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
+static int wmax_thermal_control(u8 profile)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = WMAX_OPERATION_ACTIVATE_PROFILE,
+		.arg1 = profile,
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
+static int wmax_game_shift_status(u8 operation, u32 *out_data)
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
+		ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+					     &gmode_status);
+
+		if (ret < 0)
+			return ret;
+
+		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
+		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
+			ret = wmax_game_shift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
+						     &gmode_status);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return wmax_thermal_control(supported_thermal_profiles[profile]);
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
+	ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+				     &gmode_status);
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
@@ -808,6 +1079,12 @@ static int __init alienware_wmi_init(void)
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
@@ -816,6 +1093,8 @@ static int __init alienware_wmi_init(void)
 
 fail_prep_zones:
 	alienware_zone_exit(platform_device);
+	remove_thermal_profile();
+fail_prep_thermal_profile:
 fail_prep_deepsleep:
 fail_prep_amplifier:
 fail_prep_hdmi:
@@ -835,6 +1114,7 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
+		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.47.0


