Return-Path: <linux-kernel+bounces-287478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12845952834
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C391C21897
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F903A1C9;
	Thu, 15 Aug 2024 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXEQ5ZyZ"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5F37703;
	Thu, 15 Aug 2024 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691690; cv=none; b=Ho4iNbsR4KC3g47j/ltabi8VsFZQwdgJpDaOO3zg3DyBWr4q+EOCVxDyj5ecQOGLRPOUEjOL5ACBUqBoXImUXP2dOOYwFAEfNuxc+A66jTro6edqe1Gy6tgCcU0L9kIvybPg4beeTdC6OAqnmXUMlkf51JHQ9e7ahd6C1MTbu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691690; c=relaxed/simple;
	bh=R6g+Ne6tKZEepPkrotcjFNulVgKpPUDJ2M6tbOaT2Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qswpxtWxZxvArYVa5EC2lUjk/k30Q81zGDcmpT2gyrZoevxZjid4yu6CpW5VqWtj4nalAn91kzVv/vm/WW6r/dp1z1zynjMD7JnzvcgoPeltIrovtehc1kGOXhyNjBwMCaC7PX6uxPXptH0zGH6B/n8F/e+Zb96TgZj43mRxT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXEQ5ZyZ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db14339fb0so282605b6e.2;
        Wed, 14 Aug 2024 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723691688; x=1724296488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfDbyLA8UdMBR6T2PDdZLqlPdNQm8YejVqO/xb4RJJ0=;
        b=NXEQ5ZyZJIT2pUp0oOC4pEaHZapl448xlh5I+t0Vyk5Ix22P7LNOqNwcRpzXLUozLq
         ckT5EqtWIfPX+kNIKlSUz1Pgr9IRY2VNm73TbkIPOZmwvk0kPD1HXLVWpFwAmh6j9594
         uqNfu4H3fHUAzuPDaJB4+bfKRiEfXuwwbqGyjLXmtc0SPhjbUyq4gxM+QjLkwXINfgl6
         +YKF490OxTG/4DEyJSTIksu+vBtMknoljdMK71o0WBzu7Gj9gRpx43ary+1KJoNStLlX
         AkQA19MI5cqfau2EaxqDoqbRDCscM5OWXFvED7JZ6JPRnm09FMtUXDygFLnzTcIW+fZ7
         oUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723691688; x=1724296488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfDbyLA8UdMBR6T2PDdZLqlPdNQm8YejVqO/xb4RJJ0=;
        b=JL75C759GE+EudcvoHekFzsUvtG2DNAy153KpVa97VEEnc2SVH8TT8W1aioIziiDky
         xLgC3F/Br1i23XcPJsYU3v+UN4zWJSYfTe0zJB6Lv49ByLCGkfFBTiY6eDkuMVsyV+Au
         XE4zicodGfkHvLXv33RmlXCMC9G5IT3ExG+fYBxjHgH0/KlCvvkXDuz31mkTW2FcDRtL
         58IS0vmHrNZWIicVa7O0v/9dkVdwBafnAImiW+QmJbp+SEolj1r+e36Pt2tZI1SQ+jnP
         +8QnjxQqAWg0bwUE/cQoZexrZW3dOZytpqVrxgaFD1J4tzmAuWXt5AHOqWkK9vFtzFvn
         BjXg==
X-Forwarded-Encrypted: i=1; AJvYcCX7IDvWIH19LwrLKSpkEwsDzcZ3v6egCLMNMN2Nc5urL/mQgOJR57s80ZZddOviWNbHiRa2iznyiAcntivIWe/O/X/KqpHBIHUYB2lEulpBshIiYCSCWmsH5li6WNcyJqXyFnOb+rXRqqX8jZNg6bccBiaNO4jZjFCjKC76S4m0KiKxf88=
X-Gm-Message-State: AOJu0YwlsuAWUoYnLPYJP5uuklnDJqtTJeeSywO/I9SM+d5+Jh+NPgmq
	b2eNCYQ8DDS9lVwVG08/Jdr02juz2Nxppi8pNk6f0WcRfnKXsp6E
X-Google-Smtp-Source: AGHT+IGIlxisflVjQ0f2rKXiE9FR90CeP1hB0rdSjj35XHMxYDL1AGP2siQuPzT397cKAyVi7e9wSw==
X-Received: by 2002:a05:6808:e8b:b0:3db:1ca7:3618 with SMTP id 5614622812f47-3dd299148b5mr5954194b6e.23.1723691687616;
        Wed, 14 Aug 2024 20:14:47 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7c6b61a93aesm284684a12.17.2024.08.14.20.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:14:47 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (oxp-sensors) Add support for multiple new devices.
Date: Wed, 14 Aug 2024 20:12:41 -0700
Message-ID: <20240815031358.21027-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815031358.21027-1-derekjohn.clark@gmail.com>
References: <20240815031358.21027-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the OrangePi NEO-01. It uses different registers for PWM
manual mode, set PWM, and read fan speed than previous devices. Valid PWM
input and duty cycle is 1-244, we scale this from 1-255 to maintain
compatibility with the existing interface.

Add OneXPlayer 2 series and OneXFly models. The 2 series uses a new
register for turbo button takeover. While at it, adjust formatting of some
constants and reorders all cases alphabetically for consistency. Rename
OXP_OLD constants to OXP_MINI for disambiguation.

Adds support for AYANEO models 2S, AIR 1S, Flip DS, Flip KB, GEEK 1S, and
KUN.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst |  33 ++--
 drivers/hwmon/oxp-sensors.c         | 273 +++++++++++++++++++++++++---
 2 files changed, 267 insertions(+), 39 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 50618f064379..7b2a2b5d6e80 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -10,14 +10,12 @@ Authors:
 Description:
 ------------
 
-Handheld devices from One Netbook and Aya Neo provide fan readings and fan
+Handheld devices from OneNetbook and AYANEO provide fan readings and fan
 control through their embedded controllers.
 
-Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
-Neo devices. One X Player Intel boards could be supported if we could figure
-out the EC registers and values to write to since the EC layout and model is
-different. Aya Neo devices preceding the AIR may not be supportable as the EC
-model is different and do not appear to have manual control capabilities.
+Currently supports OneXPlayer AMD devices, AOKZOE, AYANEO, and OrangePi
+handheld devices. AYANEO devices preceding the AIR are not be supportable
+as the EC model is different and do not have manual control capabilities.
 
 Some models have a toggle for changing the behaviour of the "Turbo/Silent"
 button of the device. It will change the key event that it triggers with
@@ -31,20 +29,33 @@ Currently the driver supports the following handhelds:
 
  - AOK ZOE A1
  - AOK ZOE A1 PRO
- - Aya Neo 2
- - Aya Neo AIR
- - Aya Neo AIR Plus (Mendocino)
- - Aya Neo AIR Pro
- - Aya Neo Geek
+ - AYANEO 2
+ - AYANEO 2S
+ - AYANEO AIR
+ - AYANEO AIR 1S
+ - AYANEO AIR Plus (Mendocino)
+ - AYANEO AIR Pro
+ - AYANEO KUN
+ - AYANEO Geek
+ - AYANEO Geek 1S
+ - AYANEO Flip DS
+ - AYANEO Flip KB
+ - OneXPlayer 2
+ - OneXPlayer 2 Pro
  - OneXPlayer AMD
  - OneXPlayer mini AMD
  - OneXPlayer mini AMD PRO
+ - OneXPlayer OneXFly
+ - OrangePi NEO-01
 
 "Turbo/Silent" button behaviour toggle is only supported on:
  - AOK ZOE A1
  - AOK ZOE A1 PRO
+ - OneXPlayer 2
+ - OneXPlayer 2 Pro
  - OneXPlayer mini AMD (only with updated alpha BIOS)
  - OneXPlayer mini AMD PRO
+ - OneXPlayer OneXFly
 
 Sysfs entries
 -------------
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 8d3b0f86cc57..701d46fde943 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -42,10 +42,18 @@ static bool unlock_global_acpi_lock(void)
 enum oxp_board {
 	aok_zoe_a1 = 1,
 	aya_neo_2,
+	aya_neo_2s,
 	aya_neo_air,
+	aya_neo_air_1s,
 	aya_neo_air_plus_mendo,
 	aya_neo_air_pro,
+	aya_neo_flip,
 	aya_neo_geek,
+	aya_neo_geek_1s,
+	aya_neo_kun,
+	orange_pi_neo,
+	oxp_2,
+	oxp_fly,
 	oxp_mini_amd,
 	oxp_mini_amd_a07,
 	oxp_mini_amd_pro,
@@ -54,21 +62,29 @@ enum oxp_board {
 static enum oxp_board board;
 
 /* Fan reading and PWM */
-#define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
-#define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
-#define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
+#define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
+#define OXP_SENSOR_PWM_ENABLE_REG      0x4A /* PWM enable is 1 register long */
+#define OXP_SENSOR_PWM_REG             0x4B /* PWM reading is 1 register long */
+#define PWM_MODE_AUTO                  0x00
+#define PWM_MODE_MANUAL                0x01
+
+/* OrangePi fan eding and PWM */
+#define ORANGEPI_SENSOR_FAN_REG        0x78 /* Fan reading is 2 registers long */
+#define ORANGEPI_SENSOR_PWM_ENABLE_REG 0x40 /* PWM enable is 1 register long */
+#define ORANGEPI_SENSOR_PWM_REG        0x38 /* PWM reading is 1 register long */
 
 /* Turbo button takeover function
- * Older boards have different values and EC registers
+ * Different boards have different values and EC registers
  * for the same function
  */
-#define OXP_OLD_TURBO_SWITCH_REG	0x1E
-#define OXP_OLD_TURBO_TAKE_VAL		0x01
-#define OXP_OLD_TURBO_RETURN_VAL	0x00
+#define OXP_TURBO_SWITCH_REG           0xF1
+#define OXP_2_TURBO_SWITCH_REG         0xEB /* OXP2 and OXP2 Pro */
+#define OXP_MINI_TURBO_SWITCH_REG      0x1E /* Mini AO7 */
+
+#define OXP_TURBO_TAKE_VAL             0x40
+#define OXP_MINI_TURBO_TAKE_VAL        0x01
 
-#define OXP_TURBO_SWITCH_REG		0xF1
-#define OXP_TURBO_TAKE_VAL		0x40
-#define OXP_TURBO_RETURN_VAL		0x00
+#define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
 
 static const struct dmi_system_id dmi_table[] = {
 	{
@@ -92,6 +108,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aya_neo_2,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2S"),
+		},
+		.driver_data = (void *)aya_neo_2s,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
@@ -99,6 +122,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aya_neo_air,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
+		},
+		.driver_data = (void *)aya_neo_air_1s,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
@@ -113,6 +143,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aya_neo_air_pro,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
+		},
+		.driver_data = (void *)aya_neo_flip,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
@@ -120,6 +157,27 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aya_neo_geek,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK 1S"),
+		},
+		.driver_data = (void *)aya_neo_geek_1s,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)aya_neo_kun,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "OrangePi"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)orange_pi_neo,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
@@ -127,6 +185,34 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_mini_amd,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2 ARP23"),
+		},
+		.driver_data = (void *)oxp_2,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2 PRO ARP23P"),
+		},
+		.driver_data = (void *)oxp_2,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2 PRO ARP23P EVA-01"),
+		},
+		.driver_data = (void *)oxp_2,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
@@ -192,14 +278,19 @@ static int tt_toggle_enable(void)
 
 	switch (board) {
 	case oxp_mini_amd_a07:
-		reg = OXP_OLD_TURBO_SWITCH_REG;
-		val = OXP_OLD_TURBO_TAKE_VAL;
+		reg = OXP_MINI_TURBO_SWITCH_REG;
+		val = OXP_MINI_TURBO_TAKE_VAL;
 		break;
-	case oxp_mini_amd_pro:
 	case aok_zoe_a1:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
 		reg = OXP_TURBO_SWITCH_REG;
 		val = OXP_TURBO_TAKE_VAL;
 		break;
+	case oxp_2:
+		reg = OXP_2_TURBO_SWITCH_REG;
+		val = OXP_TURBO_TAKE_VAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -213,14 +304,19 @@ static int tt_toggle_disable(void)
 
 	switch (board) {
 	case oxp_mini_amd_a07:
-		reg = OXP_OLD_TURBO_SWITCH_REG;
-		val = OXP_OLD_TURBO_RETURN_VAL;
+		reg = OXP_MINI_TURBO_SWITCH_REG;
+		val = OXP_TURBO_RETURN_VAL;
 		break;
-	case oxp_mini_amd_pro:
 	case aok_zoe_a1:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
 		reg = OXP_TURBO_SWITCH_REG;
 		val = OXP_TURBO_RETURN_VAL;
 		break;
+	case oxp_2:
+		reg = OXP_2_TURBO_SWITCH_REG;
+		val = OXP_TURBO_RETURN_VAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -233,6 +329,8 @@ static umode_t tt_toggle_is_visible(struct kobject *kobj,
 {
 	switch (board) {
 	case aok_zoe_a1:
+	case oxp_2:
+	case oxp_fly:
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
 		return attr->mode;
@@ -273,12 +371,16 @@ static ssize_t tt_toggle_show(struct device *dev,
 
 	switch (board) {
 	case oxp_mini_amd_a07:
-		reg = OXP_OLD_TURBO_SWITCH_REG;
+		reg = OXP_MINI_TURBO_SWITCH_REG;
 		break;
-	case oxp_mini_amd_pro:
 	case aok_zoe_a1:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
 		reg = OXP_TURBO_SWITCH_REG;
 		break;
+	case oxp_2:
+		reg = OXP_2_TURBO_SWITCH_REG;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -295,12 +397,55 @@ static DEVICE_ATTR_RW(tt_toggle);
 /* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
-	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
+	switch (board) {
+	case orange_pi_neo:
+		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
+	case aok_zoe_a1:
+	case aya_neo_2:
+	case aya_neo_2s:
+	case aya_neo_air:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_geek_1s:
+	case aya_neo_kun:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+	case oxp_2:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
+		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int oxp_pwm_disable(void)
 {
-	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x00);
+	switch (board) {
+	case orange_pi_neo:
+		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
+	case aok_zoe_a1:
+	case aya_neo_2:
+	case aya_neo_2s:
+	case aya_neo_air:
+	case aya_neo_air_1s:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_geek_1s:
+	case aya_neo_kun:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+	case oxp_2:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
+		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
+	default:
+		return -EINVAL;
+	}
 }
 
 /* Callbacks for hwmon interface */
@@ -326,7 +471,29 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
-			return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
+			switch (board) {
+			case orange_pi_neo:
+				return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
+			case aok_zoe_a1:
+			case aya_neo_2:
+			case aya_neo_2s:
+			case aya_neo_air:
+			case aya_neo_air_1s:
+			case aya_neo_air_plus_mendo:
+			case aya_neo_air_pro:
+			case aya_neo_flip:
+			case aya_neo_geek:
+			case aya_neo_geek_1s:
+			case aya_neo_kun:
+			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
+			case oxp_2:
+			case oxp_fly:
+			case oxp_mini_amd_pro:
+				return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
+			default:
+				break;
+			}
 		default:
 			break;
 		}
@@ -334,27 +501,66 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
-			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
-			if (ret)
-				return ret;
 			switch (board) {
+			case orange_pi_neo:
+				ret = read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
+				if (ret)
+					return ret;
+				/* scale from range [1-244] */
+				*val = ((*val - 1) * 254 / 243) + 1;
+				break;
 			case aya_neo_2:
+			case aya_neo_2s:
 			case aya_neo_air:
+			case aya_neo_air_1s:
 			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
+			case aya_neo_flip:
 			case aya_neo_geek:
+			case aya_neo_geek_1s:
+			case aya_neo_kun:
 			case oxp_mini_amd:
 			case oxp_mini_amd_a07:
+				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+				if (ret)
+					return ret;
 				*val = (*val * 255) / 100;
 				break;
-			case oxp_mini_amd_pro:
 			case aok_zoe_a1:
+			case oxp_2:
+			case oxp_fly:
+			case oxp_mini_amd_pro:
 			default:
+				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+				if (ret)
+					return ret;
 				break;
 			}
 			return 0;
 		case hwmon_pwm_enable:
-			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
+			switch (board) {
+			case orange_pi_neo:
+				return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
+			case aok_zoe_a1:
+			case aya_neo_2:
+			case aya_neo_2s:
+			case aya_neo_air:
+			case aya_neo_air_1s:
+			case aya_neo_air_plus_mendo:
+			case aya_neo_air_pro:
+			case aya_neo_flip:
+			case aya_neo_geek:
+			case aya_neo_geek_1s:
+			case aya_neo_kun:
+			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
+			case oxp_2:
+			case oxp_fly:
+			case oxp_mini_amd_pro:
+				return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
+			default:
+				break;
+			}
 		default:
 			break;
 		}
@@ -381,21 +587,32 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			if (val < 0 || val > 255)
 				return -EINVAL;
 			switch (board) {
+			case orange_pi_neo:
+				/* scale to range [1-244] */
+				val = ((val - 1) * 243 / 254) + 1;
+				return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
 			case aya_neo_2:
+			case aya_neo_2s:
 			case aya_neo_air:
+			case aya_neo_air_1s:
 			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
+			case aya_neo_flip:
 			case aya_neo_geek:
+			case aya_neo_geek_1s:
+			case aya_neo_kun:
 			case oxp_mini_amd:
 			case oxp_mini_amd_a07:
 				val = (val * 100) / 255;
-				break;
+				return write_to_ec(OXP_SENSOR_PWM_REG, val);
 			case aok_zoe_a1:
+			case oxp_2:
+			case oxp_fly:
 			case oxp_mini_amd_pro:
+				return write_to_ec(OXP_SENSOR_PWM_REG, val);
 			default:
 				break;
 			}
-			return write_to_ec(OXP_SENSOR_PWM_REG, val);
 		default:
 			break;
 		}
-- 
2.46.0


