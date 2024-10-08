Return-Path: <linux-kernel+bounces-354488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE9993E2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8EB2867F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD123139587;
	Tue,  8 Oct 2024 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXkglbKV"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519D23A6;
	Tue,  8 Oct 2024 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363964; cv=none; b=iu/SNsHdrwbWTanUb5KsaYuEf8vxFasvsUTj4sm8Lt9efNSVfkyL6SFSEt2E4QlR1JRd8FksKoiVVccz9E/3901OrEQit9m/TU0LynLtohy6VtUWo6t4HEjefhAZtUdpL0IjKYLmOwiEZTdJK+/Xpx2V/vk/oEq0rEFQOX+CTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363964; c=relaxed/simple;
	bh=6rCf3LpSw3nAiFLyzgyl/m45xH7/fF0tPgVe1VqwGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgY4oEw2gXjFHBt+BW6km40AkFuyhjIYGF2rk2IdTeBfqDY3RXk47WY8r9IXKiqx1FSQvb6kW+1wBatqRCEw4M6AGmWJnaqjOPonNhIHfkCmuWpXMVLJZHxjr4cYIv0JqhEu2zcFK/5KEMMlqZeXK1DysZh52ncMooS0rgAxHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXkglbKV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so1504937a12.1;
        Mon, 07 Oct 2024 22:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728363962; x=1728968762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs0vtPCwjQn6rNMZpPH2IWj8m+aFbwLafQtn97O1Pds=;
        b=QXkglbKVn9LZfBb/SbZ+KiO08d6T0h9ZQNwoGJrTDZz/cfrWpEFXi0MwHIIFDe0VIw
         Zbs8S0Rhh7IiA4C3eP4/1PnZ+8dBiijkozwvBy9UCwIS4IJhVg6Z7//Txfwh8zwP+3oT
         EgnwIvMn4HpoSwCHQYm+dt1q4024DtxOTPXkN1X2QgtPGnrgn33uIHw8blUOCIRSR4Qi
         1nGUL3LxlWw0NDsJWzVLIdeMxXiP6ZcBtg51Hq5VKhP82HCLbuAHK3NZk2BitNH3jrDN
         vbczPxnxqf9DybGLTNLBTOxDdLUtHkH20Y6v498jNQ4GZVRmjDlBErEN+Z3QXUFfxhmE
         kBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728363962; x=1728968762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs0vtPCwjQn6rNMZpPH2IWj8m+aFbwLafQtn97O1Pds=;
        b=e5Yh29Lyf/Cr4KbgmUq9DokeHAyCyd3vl6yeb9AN7llB2VWV2bKv8t1xPKRnb7bEEt
         uOEyP2N/VI0zSY2J65YI78MiKkt30+LqKgJqC3RcOqRrbjM33ZdVE2kdRhwz53JIJqoX
         /ptRuTJHBiJGRVG7YzjsW/c7JVO6tj++OnqKIbB34K2ZOPQpNAzwiotoucksNoqwtiQ1
         rwg9bEyHqjHDs/rJn9rlsSU24WiZHq6ZYXMmVKj2iQXXLwb1dVfpL1iCWIfaWTldm4CJ
         GZASt7be2h9SLi2VokBtSfx7gyB/UF4zrgZ8wRzUrAW6XMWiCyDrZhnkJcg1jGGuxHLr
         4CmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOaObuzASk6OKcnzyDVWIlqfEzuiSAeU6CO0ePycR4rrzWIGFNeSo56I+VtCy0whKi9as5MeNbyIqO6sQ=@vger.kernel.org, AJvYcCUYHuV2zznc2or/q0AiFu0IfqSRtR+/9dfCcEGnQVqJFDJid3uxZKmtwS/f4oQJz3nhTDJNB6C4+lxhCZB/cw6wvAOdYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bS3xddFN2dLx1lW+bmdeClseHUaE3AZ7Kwte9NZf//sJerSy
	sugPGnwKIIMhpzyKuzlGjz1NL/NLezGRbyqiV3dICqKlBslIzmA8
X-Google-Smtp-Source: AGHT+IGHskScTOxPaK0y3iodKmIXEMvp+a2agH/zvai0N01spKFAKRK62R+zyZ0ssjKYG24TjnzrGQ==
X-Received: by 2002:a17:90b:4a10:b0:2e0:a77e:8305 with SMTP id 98e67ed59e1d1-2e1e6391d38mr17309201a91.39.1728363962163;
        Mon, 07 Oct 2024 22:06:02 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7177esm6482617a91.3.2024.10.07.22.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:06:01 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v2] alienware-wmi: Dell AWCC platform_profile support
Date: Tue,  8 Oct 2024 01:42:39 -0300
Message-ID: <20241008044237.55146-3-kuurtb@gmail.com>
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

---
v2:
 - Moved functionality to alienware-wmi driver
 - Added thermal and gmode quirks to add support based on dmi match
 - Performance profile is now GMODE for devices that support it
 - alienware_wmax_command now is insize agnostic to support new thermal
   methods
---
 drivers/platform/x86/dell/Kconfig         |   1 +
 drivers/platform/x86/dell/alienware-wmi.c | 214 ++++++++++++++++++++--
 2 files changed, 202 insertions(+), 13 deletions(-)

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
index f5ee62ce1..47abb533c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/platform_profile.h>
 #include <linux/dmi.h>
 #include <linux/leds.h>
 
@@ -25,6 +26,15 @@
 #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
 #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
 #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
+#define WMAX_METHOD_THERMAL_INFORMATION	0x14
+#define WMAX_METHOD_THERMAL_CONTROL	0x15
+
+#define WMAX_THERMAL_QUIET			0xA3
+#define WMAX_THERMAL_BALANCED			0xA0
+#define WMAX_THERMAL_BALANCED_PERFORMANCE	0xA1
+#define WMAX_THERMAL_PERFORMANCE		0xA4
+#define WMAX_THERMAL_GMODE			0xAB
+#define WMAX_THERMAL_LOW_POWER			0xA5
 
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
@@ -54,6 +64,8 @@ struct quirk_entry {
 	u8 hdmi_mux;
 	u8 amplifier;
 	u8 deepslp;
+	u8 thermal;
+	u8 gmode;
 };
 
 static struct quirk_entry *quirks;
@@ -64,6 +76,8 @@ static struct quirk_entry quirk_inspiron5675 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_unknown = {
@@ -71,6 +85,8 @@ static struct quirk_entry quirk_unknown = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r1_r2 = {
@@ -78,6 +94,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_x51_r3 = {
@@ -85,6 +103,8 @@ static struct quirk_entry quirk_x51_r3 = {
 	.hdmi_mux = 0,
 	.amplifier = 1,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm100 = {
@@ -92,6 +112,8 @@ static struct quirk_entry quirk_asm100 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 0,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm200 = {
@@ -99,6 +121,8 @@ static struct quirk_entry quirk_asm200 = {
 	.hdmi_mux = 1,
 	.amplifier = 0,
 	.deepslp = 1,
+	.thermal = 0,
+	.gmode = 0,
 };
 
 static struct quirk_entry quirk_asm201 = {
@@ -106,6 +130,17 @@ static struct quirk_entry quirk_asm201 = {
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
@@ -169,6 +204,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
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
@@ -218,6 +262,7 @@ static struct platform_device *platform_device;
 static struct device_attribute *zone_dev_attrs;
 static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
+static struct platform_profile_handler pp_handler;
 
 static struct platform_driver platform_driver = {
 	.driver = {
@@ -500,7 +545,7 @@ static void alienware_zone_exit(struct platform_device *dev)
 	kfree(zone_attrs);
 }
 
-static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
+static acpi_status alienware_wmax_command(void *in_args, size_t insize,
 					  u32 command, int *out_data)
 {
 	acpi_status status;
@@ -508,7 +553,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
 	struct acpi_buffer input;
 	struct acpi_buffer output;
 
-	input.length = (acpi_size) sizeof(*in_args);
+	input.length = (acpi_size) insize;
 	input.pointer = in_args;
 	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
@@ -541,8 +586,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
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
@@ -562,8 +607,8 @@ static ssize_t show_hdmi_source(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
-				   (u32 *) &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_STATUS, (u32 *) &out_data);
 
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
@@ -589,7 +634,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 		args.arg = 3;
 	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_HDMI_SOURCE, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
@@ -642,8 +688,8 @@ static ssize_t show_amplifier_status(struct device *dev,
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
@@ -694,8 +740,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
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
@@ -723,8 +769,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
 		args.arg = 2;
 	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
-					NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
@@ -760,6 +806,140 @@ static int create_deepsleep(struct platform_device *dev)
 	return ret;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+
+static int platform_profile_get(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile)
+{
+	acpi_status status;
+	u32 in_args = 0x0B;
+	u32 out_data;
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_INFORMATION, (u32 *) &out_data);
+
+	if (ACPI_FAILURE(status) || out_data < 0)
+		return -EOPNOTSUPP;
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
+#define SET_MASK(prof) ((prof << 8) | 1)
+
+static int platform_profile_set(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile)
+{
+	acpi_status status;
+	u32 in_args;
+	u32 out_data;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		in_args = SET_MASK(WMAX_THERMAL_LOW_POWER);
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		in_args = SET_MASK(WMAX_THERMAL_QUIET);
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		in_args = SET_MASK(WMAX_THERMAL_BALANCED);
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		in_args = SET_MASK(WMAX_THERMAL_BALANCED_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		in_args = SET_MASK(WMAX_THERMAL_PERFORMANCE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL, (u32 *) &out_data);
+
+	if (ACPI_FAILURE(status) || out_data < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int gmode_platform_profile_set(struct platform_profile_handler *pprof,
+				      enum platform_profile_option profile)
+{
+	acpi_status status;
+	u32 in_args;
+	u32 out_data;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		in_args = SET_MASK(WMAX_THERMAL_LOW_POWER);
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		in_args = SET_MASK(WMAX_THERMAL_QUIET);
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		in_args = SET_MASK(WMAX_THERMAL_BALANCED);
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		in_args = SET_MASK(WMAX_THERMAL_BALANCED_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		in_args = SET_MASK(WMAX_THERMAL_GMODE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_CONTROL, (u32 *) &out_data);
+
+	if (ACPI_FAILURE(status) || out_data < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int create_platform_profile(void)
+{
+	pp_handler.profile_get = platform_profile_get;
+
+	if (quirks->gmode > 0)
+		pp_handler.profile_set = gmode_platform_profile_set;
+	else
+		pp_handler.profile_set = platform_profile_set;
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
 static int __init alienware_wmi_init(void)
 {
 	int ret;
@@ -807,6 +987,12 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_deepsleep;
 	}
 
+	if (quirks->thermal > 0) {
+		ret = create_platform_profile();
+		if (ret)
+			goto fail_prep_thermal_profile;
+	}
+
 	ret = alienware_zone_init(platform_device);
 	if (ret)
 		goto fail_prep_zones;
@@ -817,6 +1003,7 @@ static int __init alienware_wmi_init(void)
 	alienware_zone_exit(platform_device);
 fail_prep_deepsleep:
 fail_prep_amplifier:
+fail_prep_thermal_profile:
 fail_prep_hdmi:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -836,6 +1023,7 @@ static void __exit alienware_wmi_exit(void)
 		remove_hdmi(platform_device);
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
+		platform_profile_remove();
 	}
 }
 
-- 
2.46.2


