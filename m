Return-Path: <linux-kernel+bounces-355847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4819957EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F76B1F27655
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A38C21502C;
	Tue,  8 Oct 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTW/ZDJb"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164A215003;
	Tue,  8 Oct 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417273; cv=none; b=KgLfw7J0phsbb9yVe33MKv7VXqFGmTSyOHDv24kKuj7p+3yd9IYsRdKxyHoDFdgcOXF2ucpPvqFIjzuwIUOB2El8X9WZTaRZ1ovd2V1rFGbPCD6fdwwgmSgjpgmCz1WvursCk91cL/bKveBXDnyFcUfrNAJgDPwgmUFwFnCm2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417273; c=relaxed/simple;
	bh=IOPWXwyVTHtGv0Pt9rzgQAS8jQ32O9lRVdzR9a8kHQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2tGR5T6neB+qhr/lo7liw1Q3foJRJ+jmjgjosHCH6gZASXC2Ie13L7zyvE/SMppD5CnqZV2r/ePTBxQvxOzsHaDr1MPZTdQKz6QJ6MGP8R380koCqqNm48/STeMZLbrpumBNjF4Cso8BJH5Nc6tOLx6kT/NAx2MeSdSEeLRPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTW/ZDJb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so4443218a91.2;
        Tue, 08 Oct 2024 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728417271; x=1729022071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKFOxWTZB3gDwU1tSyYxwo5WVBBbD0qnN+dc9is7c3k=;
        b=KTW/ZDJbGTH/KqfZUx9kH+VSSWLX21WaAgHeSAYdImmyHHDDHm/ma3c8NziEbbrMhO
         Y9OEMW4aEYa++jYOaKQoo82R9RKiLyPVRqnpu4qkK9xfiPDV2MXC6GpsX89AsjXx/fm/
         hNIk3urT9Rp2CNNsMCUXlidAmT2zbDTS6szO1UGNz47yNkB/4Iqx31XXEP/nvcHGkTUA
         HDK3N1+17nuf3cFAPTm2VMfGRwKQqC0PSsU+AIMdp5O/J73VC4vatywdTi4RpSU+QuZL
         XfFrrh4thL2UWWeyS3/tZ/8ML/52N5bez7hkylN5xGgubsVk7h0zJ07EhFDJ8N1Ha9kZ
         iZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417271; x=1729022071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKFOxWTZB3gDwU1tSyYxwo5WVBBbD0qnN+dc9is7c3k=;
        b=dJjqKcK2OlVxEouXoULkKRT9fZxgpVvKPSTs+ynhUQzz7sDuDqjrsWhYIpmT8uYQKz
         c5Gv3ep4xiAzwNyDO6CIkzQVjyetxvlihJ86zSFppDWU8zjPw0SgQmTFfv6JvyUbr0AD
         F7vGyY9E6lYbI3nw5ojhS/GB3B0DAfOYOeZl5IPArj+ZoNSn7v2OBameTpTV0Egz5kv4
         XvNV3YrKhVHFdyR/cRmTzAWaN62aznn9FguQo2db3F7FwA/rr7iNnpmfbZSUH5FLkZp1
         FEj96dkiIqjwkpgehz/8Aya6w7aDl9pBd46cn7yVLU4SvX+qXxmDR8MIrhTnMxJGigJY
         094A==
X-Forwarded-Encrypted: i=1; AJvYcCW35mf59mvoh9mRyk3OBmTZaZQdGi0Keey8oYBhVX39SY8DgbHA3v/TYMTi42Ha06lUnVO5ZtZ7d//O3wWCEvHWkvv/Eg==@vger.kernel.org, AJvYcCWrzijVihMQ0oEXU0wQztyEn6nyHFX+NROsUaUm5btPtFuf0bz3voPu5V3DLCi6kSbUV/kNtDUEhiIRYP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9hxfkOnsLrppCr1d2jsLdKU4lW7s5zGWst/rXOhfOaifik+n
	5fxzmWpeiZ4FYLhiLtjXGNk/AkvhnUbbnuwMKSl1r+peBFyXiCG7
X-Google-Smtp-Source: AGHT+IGWfsWUUZkuTuHoI/5KOXqVlqHaVlYAlcY95UGns8+s2S4VnVYQAs1q7J6AqC9ss5gDNH2BdQ==
X-Received: by 2002:a17:90a:17ea:b0:2e2:99df:96f5 with SMTP id 98e67ed59e1d1-2e2a2577206mr66411a91.35.1728417270903;
        Tue, 08 Oct 2024 12:54:30 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b12e245sm8057665a91.52.2024.10.08.12.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:54:30 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH] alienware-wmi: Dell AWCC platform_profile support
Date: Tue,  8 Oct 2024 16:37:48 -0300
Message-ID: <20241008193746.35318-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007093324.49631-3-kuurtb@gmail.com>
References: <20241007093324.49631-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds platform_profile support for Dell devices which implement
User Selectable Thermal Tables (USTT) that are meant to be controlled by
Alienware Command Center (AWCC). These devices may include newer Alienware
M-Series, Alienware X-Series and Dell's G-Series. This patch, was tested
by me on an Alienware x15 R1.

It is suspected that Alienware Command Center manages thermal profiles
through the WMI interface, specifically through a device with identifier
\_SB_.AMW1.WMAX. This device was reverse engineered and the relevant
functionality is documented here [1]. This driver interacts with this
WMI device and thus is able to mimic AWCC's thermal profiles functionality
through the platform_profile API. In consequence the user would be able
to set and retrieve thermal profiles, which are just fan speed profiles.

This driver was heavily inspired on inspur_platform_profile, special
thanks.

Notes:
 - Performance (FullSpeed) profile is a special profile which has it's own
   entry in the Firmware Settings of the Alienware x15 R1. It also changes
   the color of the F1 key. I suspect this behavior would be replicated in
   other X-Series or M-Series laptops.
 - G-Mode is a profile documented on [1] which mimics the behavior of
   FullSpeed mode but it does not have an entry on the Firmware Settings of
   the Alienware x15 R1, this may correspond to the G-Mode functionality on
   G-Series laptops (activated by a special button) but I cannot test it. I
   did not include this code in the driver as G-Mode causes unexpected
   behavior on X-Series laptops.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>

---
v3:
 - Removed extra empty line
 - 0x0B named WMAX_ARG_GET_CURRENT_PROF
 - Removed casts to the same type on functions added in this patch
 - Thermal profile to WMAX argument is now an static function and makes
   use of in-built kernel macros
 - Platform profile is now removed only if it was created first
 - create_platform_profile is now create_thermal_profile to avoid
   confusion
 - profile_get and profile_set functions renamed too to match the above
v2:
 - Moved functionality to alienware-wmi driver
 - Added thermal and gmode quirks to add support based on dmi match
 - Performance profile is now GMODE for devices that support it
 - alienware_wmax_command now is insize agnostic to support new thermal
   methods
---
 drivers/platform/x86/dell/Kconfig         |   1 +
 drivers/platform/x86/dell/alienware-wmi.c | 238 ++++++++++++++++++++--
 2 files changed, 226 insertions(+), 13 deletions(-)

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
index f5ee62ce1..e3ef4b10b 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/platform_profile.h>
 #include <linux/dmi.h>
 #include <linux/leds.h>
 
@@ -25,6 +26,10 @@
 #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
 #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
 #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
+#define WMAX_METHOD_THERMAL_INFORMATION	0x14
+#define WMAX_METHOD_THERMAL_CONTROL	0x15
+
+#define WMAX_ARG_GET_CURRENT_PROF	0x0B
 
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
@@ -49,11 +54,22 @@ enum WMAX_CONTROL_STATES {
 	WMAX_SUSPEND = 3,
 };
 
+enum WMAX_THERMAL_PROFILE {
+	WMAX_THERMAL_QUIET = 0xA3,
+	WMAX_THERMAL_BALANCED = 0xA0,
+	WMAX_THERMAL_BALANCED_PERFORMANCE = 0xA1,
+	WMAX_THERMAL_PERFORMANCE = 0xA4,
+	WMAX_THERMAL_GMODE = 0xAB,
+	WMAX_THERMAL_LOW_POWER	= 0xA5,
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
@@ -64,6 +80,8 @@ static struct quirk_entry quirk_inspiron5675 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_unknown = {
@@ -71,6 +89,8 @@ static struct quirk_entry quirk_unknown = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r1_r2 = {
@@ -78,6 +98,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r3 = {
@@ -85,6 +107,8 @@ static struct quirk_entry quirk_x51_r3 = {
 	.hdmi_mux = 0,
 	.amplifier = 1,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm100 = {
@@ -92,6 +116,8 @@ static struct quirk_entry quirk_asm100 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm200 = {
@@ -99,6 +125,8 @@ static struct quirk_entry quirk_asm200 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 1,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm201 = {
@@ -106,6 +134,17 @@ static struct quirk_entry quirk_asm201 = {
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
+	.thermal = 1,
+	.gmode = 0,
 };
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -169,6 +208,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		     },
 	 .driver_data = &quirk_asm201,
 	 },
+	 {
+	 .callback = dmi_matched,
+	 .ident = "Alienware x15 R1",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
+		    },
+	 .driver_data = &quirk_x15_r1,
+	},
 	 {
 	 .callback = dmi_matched,
 	 .ident = "Dell Inc. Inspiron 5675",
@@ -218,6 +266,7 @@ static struct platform_device *platform_device;
 static struct device_attribute *zone_dev_attrs;
 static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
+static struct platform_profile_handler pp_handler;
 
 static struct platform_driver platform_driver = {
 	.driver = {
@@ -500,7 +549,7 @@ static void alienware_zone_exit(struct platform_device *dev)
 	kfree(zone_attrs);
 }
 
-static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
+static acpi_status alienware_wmax_command(void *in_args, size_t insize,
 					  u32 command, int *out_data)
 {
 	acpi_status status;
@@ -508,7 +557,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
 	struct acpi_buffer input;
 	struct acpi_buffer output;
 
-	input.length = (acpi_size) sizeof(*in_args);
+	input.length = (acpi_size) insize;
 	input.pointer = in_args;
 	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
@@ -541,8 +590,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
-				   (u32 *) &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_CABLE, (u32 *) &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -562,8 +611,8 @@ static ssize_t show_hdmi_source(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
-				   (u32 *) &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_STATUS, (u32 *) &out_data);
 
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
@@ -589,7 +638,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 		args.arg = 3;
 	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_HDMI_SOURCE, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
@@ -642,8 +692,8 @@ static ssize_t show_amplifier_status(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
-				   (u32 *) &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_AMPLIFIER_CABLE, (u32 *) &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -694,8 +744,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
-					(u32 *) &out_data);
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_DEEP_SLEEP_STATUS, (u32 *) &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
@@ -723,8 +773,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
 		args.arg = 2;
 	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
-					NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
@@ -760,6 +810,160 @@ static int create_deepsleep(struct platform_device *dev)
 	return ret;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+#define PROFILE_MASK		GENMASK(15,8)
+#define PROFILE_ACTIVATE	BIT(0)
+
+static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
+{
+	return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
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
+		return -EOPNOTSUPP;
+
+	if (out_data == 0xFFFFFFFF)
+		return -EBADRQC;
+
+	switch (out_data) {
+	case WMAX_THERMAL_LOW_POWER:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	case WMAX_THERMAL_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	case WMAX_THERMAL_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case WMAX_THERMAL_BALANCED_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
+		break;
+	case WMAX_THERMAL_PERFORMANCE:
+	case WMAX_THERMAL_GMODE:
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
+	case PLATFORM_PROFILE_LOW_POWER:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
+		break;
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
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL, &out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EOPNOTSUPP;
+
+	if (out_data == 0xFFFFFFFF)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int gmode_thermal_profile_set(struct platform_profile_handler *pprof,
+				     enum platform_profile_option profile)
+{
+	acpi_status status;
+	u32 in_args;
+	u32 out_data;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
+		break;
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
+		in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL, &out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EOPNOTSUPP;
+
+	if (out_data == 0xFFFFFFFF)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int create_thermal_profile(void)
+{
+	pp_handler.profile_get = thermal_profile_get;
+
+	if (quirks->gmode > 0)
+		pp_handler.profile_set = gmode_thermal_profile_set;
+	else
+		pp_handler.profile_set = thermal_profile_set;
+
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
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
@@ -807,6 +1011,12 @@ static int __init alienware_wmi_init(void)
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
@@ -817,6 +1027,7 @@ static int __init alienware_wmi_init(void)
 	alienware_zone_exit(platform_device);
 fail_prep_deepsleep:
 fail_prep_amplifier:
+fail_prep_thermal_profile:
 fail_prep_hdmi:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -834,6 +1045,7 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
+		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.46.2


