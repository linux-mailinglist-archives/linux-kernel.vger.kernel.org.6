Return-Path: <linux-kernel+bounces-297837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA01C95BE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBEB1C222DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C91D0DC1;
	Thu, 22 Aug 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2l+WZMJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25251D048E;
	Thu, 22 Aug 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351733; cv=none; b=PD3yyKAtjjRwXzN6PLoiGCcWgV1Q3olrmwIR7eCq0wxzCTKLbXEwWcxY6jTb5Zqjr8P1y0O7/JWtoKI+h5vGFH3ItLp1bT6Jh1jfXHAN7HOKMcGvjYyvrTUz+IZAB1AIq0tBiXpNEUOC2X56Ksn6rta7WbS2Q8u3/dUIOgwieFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351733; c=relaxed/simple;
	bh=slGPJ20OWadS8KCTZ6hGB3KKaoeEB/lcAd3nHYPee8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHiTlH6WO9COSf+lLxL2BXKiOLSRMXqvrF4hMFX6kkvQkiK9gI/JSK48DUJ6qasR7vHim41H4C2VbeWNwuY32GrXS4vEfbvoxrFLqNfou+j1ycy6RwuhnvGseFf3YVIi+2cP9BwYQNBjPLuTTTwPP8FXbGsgL+Hs0lAIzZ19w1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2l+WZMJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714226888dfso1073577b3a.1;
        Thu, 22 Aug 2024 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351731; x=1724956531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87GO7fdtzJKv+bl80IBW5M0mQvVzTAX004RskD1OfS4=;
        b=L2l+WZMJUXcKVTRF4D/ARwSTfwTWmn6DXSXEUux8SbD8KcGHtkack6iQi2lMw1o8kA
         IEaDRMycnBR+x0WApgAfcEEquNQ1+At+poIzMtELA7KyK8P63+hSjT2TgU8xZlcQj7Di
         CETVO4uThA/mCPg5nodaXgi7sOeHgVRW2TcDgdOpbM9dZ3MoVjkyGcZj8W9Xhk0idOUb
         D2znH5hf5Q5t9flxsIaEQcxpNwqWagedRbuLUVzfFI+K6v4FTlOHI/cb4rEa8aL8HNi7
         am5ji56Qxt77tn5umRAMSJwL62utgj+QYQjmNy6m5PTfFZoQkzu2KMM/r++ZNZmTZ8OK
         6CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351731; x=1724956531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87GO7fdtzJKv+bl80IBW5M0mQvVzTAX004RskD1OfS4=;
        b=FQhrxRUsrVRJ8FjFiCfIuCJKE+Dx6Mj0fx0l3C9Qa9ZY2zmrJj5n9HT4WZPNKe8qZG
         wyL/k+cqrnbAb+r2bnSGZCBL+BQMmjuGavkemS723OMQj6PWgy3f++vD4vf4QxXDjxWJ
         WFAwqMVVnolBaE/HYET8jJWgYhG+Gn2HaHKBET0MF4MFgYNtJxgPBd4G9qnhTyME9dFC
         3KavOxv63jpTmnTlI4+Y6SCF/HRZ06694RcNgodCnLcqwk/LXFxoCNwnQ17MXmFLupHa
         AqxVI6blEA6Gq4YrbxhoBxZ4IY7+mYnJvZfFoaXJmXshUE7A23HwqHR6qkR8FokPnF/Q
         m+rw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZIqLw9ttz0RCNS++wJejKuJcMcvEyn5Rj5BwxhzFcS6Z520KQ+n+ji+DdULVMKFoeaOW/XsahYvk1/Q=@vger.kernel.org, AJvYcCViXuFD7gO/Y0TgxNG5NZHdmjYkK4GG6IKSmqAv8fsER7ddKgeer7r0z3/CuwX6chqT4AIDqO3pzNQRo1n+@vger.kernel.org, AJvYcCVvbJAQIvsXTH+IfcpdqOkseoVqKBlNsUhMFWRofRHRqBGtVwRDjW5LNfKFJA59K1Oy+VRidXpxdMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaH0yQjtcoafE4ZStF96ey5tgvju3HPmP8MOBuDg1oqY9Mdr6v
	Tp6kJPYGpdncakL06U1YU9RzL0SbmdAjXYPkhZOoXfGqtOd5fID3WN6Ye0If
X-Google-Smtp-Source: AGHT+IHUb8d4iAM4J5VBnRzKr/VSmDPSS1wUrqIJjhLM1+ntCyIF/IvM09bm5fTMhKJNUayNABL/qA==
X-Received: by 2002:a05:6a21:e85:b0:1c4:9f31:ac8f with SMTP id adf61e73a8af0-1cad81447c0mr6499411637.37.1724351730970;
        Thu, 22 Aug 2024 11:35:30 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd0e3sm1691598a12.45.2024.08.22.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:35:30 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] Add support for multiple new devices.
Date: Thu, 22 Aug 2024 11:35:25 -0700
Message-ID: <20240822183525.27289-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822183525.27289-1-derekjohn.clark@gmail.com>
References: <20240822183525.27289-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the OrangePi NEO-01. It uses different registers for PWM
manual mode, set PWM, and read fan speed than previous devices. Valid PWM
input and duty cycle is 1-244, we scale this from 1-255 to maintain
compatibility with the existing interface.

Add OneXPlayer 2 series, OneXFly, and X1 series models. The 2/X1 series use
new registers for turbo button takeover and read fan speed. X1 has an Intel
variant so change the CPU detection at init to only check for the affected
devices. While at it, adjust formatting of some constants and reorder all
cases alphabetically for consistency. Rename OXP_OLD constants to OXP_MINI
for disambiguation. Update code comments for clarity.

Add support for AYANEO models 2S, AIR 1S, Flip series, GEEK 1S, and KUN.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Kevin Greenberg <kdgreenberg234@protonmail.com>
Tested-by: Joshua Tam <csinaction@pm.me>
Tested-by: Parth Menon <parthasarathymenon@gmail.com>
Tested-by: Philip Müller <philm@manjaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408160329.TLNbIwRC-lkp@intel.com/
---
 Documentation/hwmon/oxp-sensors.rst |  54 +++--
 drivers/hwmon/oxp-sensors.c         | 299 +++++++++++++++++++++++-----
 2 files changed, 290 insertions(+), 63 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 50618f064379..581c4dafbfa1 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -10,41 +10,59 @@ Authors:
 Description:
 ------------
 
-Handheld devices from One Netbook and Aya Neo provide fan readings and fan
-control through their embedded controllers.
+Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide fan
+readings and fan control through their embedded controllers.
 
-Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
-Neo devices. One X Player Intel boards could be supported if we could figure
-out the EC registers and values to write to since the EC layout and model is
-different. Aya Neo devices preceding the AIR may not be supportable as the EC
-model is different and do not appear to have manual control capabilities.
+Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
+handheld devices. AYANEO devices preceding the AIR and OneXPlayer devices
+preceding the Mini A07 are not supportable as the EC model is different
+and do not have manual control capabilities.
 
-Some models have a toggle for changing the behaviour of the "Turbo/Silent"
-button of the device. It will change the key event that it triggers with
-a flip of the `tt_toggle` attribute. See below for boards that support this
-function.
+Some OneXPlayer and AOKZOE models have a toggle for changing the behaviour
+of the "Turbo/Silent" button of the device. It will change the key event
+that it triggers with a flip of the `tt_toggle` attribute. See below for
+boards that support this function.
 
 Supported devices
 -----------------
 
 Currently the driver supports the following handhelds:
 
- - AOK ZOE A1
- - AOK ZOE A1 PRO
- - Aya Neo 2
- - Aya Neo AIR
- - Aya Neo AIR Plus (Mendocino)
- - Aya Neo AIR Pro
- - Aya Neo Geek
+ - AOKZOE A1
+ - AOKZOE A1 PRO
+ - AYANEO 2
+ - AYANEO 2S
+ - AYANEO AIR
+ - AYANEO AIR 1S
+ - AYANEO AIR Plus (Mendocino)
+ - AYANEO AIR Pro
+ - AYANEO Flip DS
+ - AYANEO Flip KB
+ - AYANEO Geek
+ - AYANEO Geek 1S
+ - AYANEO KUN
+ - OneXPlayer 2
+ - OneXPlayer 2 Pro
  - OneXPlayer AMD
  - OneXPlayer mini AMD
  - OneXPlayer mini AMD PRO
+ - OneXPlayer OneXFly
+ - OneXPlayer X1 A
+ - OneXPlayer X1 i
+ - OneXPlayer X1 mini
+ - OrangePi NEO-01
 
 "Turbo/Silent" button behaviour toggle is only supported on:
  - AOK ZOE A1
  - AOK ZOE A1 PRO
+ - OneXPlayer 2
+ - OneXPlayer 2 Pro
  - OneXPlayer mini AMD (only with updated alpha BIOS)
  - OneXPlayer mini AMD PRO
+ - OneXPlayer OneXFly
+ - OneXPlayer X1 A
+ - OneXPlayer X1 i
+ - OneXPlayer X1 mini
 
 Sysfs entries
 -------------
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 8d3b0f86cc57..b6d06370469d 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -1,18 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Platform driver for OneXPlayer, AOK ZOE, and Aya Neo Handhelds that expose
- * fan reading and control via hwmon sysfs.
+ * Platform driver for OneXPlayer, AOKZOE, AYANEO, and OrangePi Handhelds
+ * that expose fan reading and control via hwmon sysfs.
  *
  * Old OXP boards have the same DMI strings and they are told apart by
- * the boot cpu vendor (Intel/AMD). Currently only AMD boards are
- * supported but the code is made to be simple to add other handheld
- * boards in the future.
+ * the boot cpu vendor (Intel/AMD). Of these older models only AMD is
+ * supported.
+ *
  * Fan control is provided via pwm interface in the range [0-255].
  * Old AMD boards use [0-100] as range in the EC, the written value is
  * scaled to accommodate for that. Newer boards like the mini PRO and
- * AOK ZOE are not scaled but have the same EC layout.
+ * AOKZOE are not scaled but have the same EC layout. Newer models
+ * like the 2 and X1 are [0-184] and are scaled to 0-255. OrangePi
+ * are [1-244] and scaled to 0-255.
  *
  * Copyright (C) 2022 Joaquín I. Aramendía <samsagax@gmail.com>
+ * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
  */
 
 #include <linux/acpi.h>
@@ -43,32 +46,48 @@ enum oxp_board {
 	aok_zoe_a1 = 1,
 	aya_neo_2,
 	aya_neo_air,
+	aya_neo_air_1s,
 	aya_neo_air_plus_mendo,
 	aya_neo_air_pro,
+	aya_neo_flip,
 	aya_neo_geek,
+	aya_neo_kun,
+	orange_pi_neo,
+	oxp_2,
+	oxp_fly,
 	oxp_mini_amd,
 	oxp_mini_amd_a07,
 	oxp_mini_amd_pro,
+	oxp_x1,
 };
 
 static enum oxp_board board;
 
 /* Fan reading and PWM */
-#define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
-#define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
-#define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
+#define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
+#define OXP_2_SENSOR_FAN_REG           0x58 /* Fan reading is 2 registers long */
+#define OXP_SENSOR_PWM_ENABLE_REG      0x4A /* PWM enable is 1 register long */
+#define OXP_SENSOR_PWM_REG             0x4B /* PWM reading is 1 register long */
+#define PWM_MODE_AUTO                  0x00
+#define PWM_MODE_MANUAL                0x01
+
+/* OrangePi fan reading and PWM */
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
+#define OXP_TURBO_SWITCH_REG           0xF1 /* Mini Pro, OneXFly, AOKZOE */
+#define OXP_2_TURBO_SWITCH_REG         0xEB /* OXP2 and X1 */
+#define OXP_MINI_TURBO_SWITCH_REG      0x1E /* Mini AO7 */
+
+#define OXP_MINI_TURBO_TAKE_VAL        0x01 /* Mini AO7 */
+#define OXP_TURBO_TAKE_VAL             0x40 /* All other models */
 
-#define OXP_TURBO_SWITCH_REG		0xF1
-#define OXP_TURBO_TAKE_VAL		0x40
-#define OXP_TURBO_RETURN_VAL		0x00
+#define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
 
 static const struct dmi_system_id dmi_table[] = {
 	{
@@ -88,7 +107,7 @@ static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
+			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)aya_neo_2,
 	},
@@ -99,6 +118,13 @@ static const struct dmi_system_id dmi_table[] = {
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
@@ -116,10 +142,31 @@ static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK"),
+			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
+		},
+		.driver_data = (void *)aya_neo_flip,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
 		},
 		.driver_data = (void *)aya_neo_geek,
 	},
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
@@ -127,6 +174,20 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_mini_amd,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2"),
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
@@ -141,6 +202,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_mini_amd_pro,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
 	{},
 };
 
@@ -192,14 +260,20 @@ static int tt_toggle_enable(void)
 
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
+	case oxp_x1:
+		reg = OXP_2_TURBO_SWITCH_REG;
+		val = OXP_TURBO_TAKE_VAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -213,14 +287,20 @@ static int tt_toggle_disable(void)
 
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
+	case oxp_x1:
+		reg = OXP_2_TURBO_SWITCH_REG;
+		val = OXP_TURBO_RETURN_VAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -233,8 +313,11 @@ static umode_t tt_toggle_is_visible(struct kobject *kobj,
 {
 	switch (board) {
 	case aok_zoe_a1:
+	case oxp_2:
+	case oxp_fly:
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
+	case oxp_x1:
 		return attr->mode;
 	default:
 		break;
@@ -273,12 +356,17 @@ static ssize_t tt_toggle_show(struct device *dev,
 
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
+	case oxp_x1:
+		reg = OXP_2_TURBO_SWITCH_REG;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -295,12 +383,53 @@ static DEVICE_ATTR_RW(tt_toggle);
 /* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
-	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
+	switch (board) {
+	case orange_pi_neo:
+		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
+	case aok_zoe_a1:
+	case aya_neo_2:
+	case aya_neo_air:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_kun:
+	case oxp_2:
+	case oxp_fly:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+	case oxp_x1:
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
+	case aya_neo_air:
+	case aya_neo_air_1s:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_kun:
+	case oxp_2:
+	case oxp_fly:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+	case oxp_x1:
+		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
+	default:
+		return -EINVAL;
+	}
 }
 
 /* Callbacks for hwmon interface */
@@ -326,7 +455,29 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
-			return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
+			switch (board) {
+			case orange_pi_neo:
+				return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
+			case oxp_2:
+			case oxp_x1:
+				return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
+			case aok_zoe_a1:
+			case aya_neo_2:
+			case aya_neo_air:
+			case aya_neo_air_1s:
+			case aya_neo_air_plus_mendo:
+			case aya_neo_air_pro:
+			case aya_neo_flip:
+			case aya_neo_geek:
+			case aya_neo_kun:
+			case oxp_fly:
+			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
+			case oxp_mini_amd_pro:
+				return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
+			default:
+				break;
+			}
 		default:
 			break;
 		}
@@ -334,31 +485,74 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
+			case oxp_2:
+			case oxp_x1:
+				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+				if (ret)
+					return ret;
+				/* scale from range [0-184] */
+				*val = (*val * 255) / 184;
+				break;
 			case aya_neo_2:
 			case aya_neo_air:
+			case aya_neo_air_1s:
 			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
+			case aya_neo_flip:
 			case aya_neo_geek:
+			case aya_neo_kun:
 			case oxp_mini_amd:
 			case oxp_mini_amd_a07:
+				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+				if (ret)
+					return ret;
+				/* scale from range [0-100] */
 				*val = (*val * 255) / 100;
 				break;
-			case oxp_mini_amd_pro:
 			case aok_zoe_a1:
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
+			case aya_neo_air:
+			case aya_neo_air_1s:
+			case aya_neo_air_plus_mendo:
+			case aya_neo_air_pro:
+			case aya_neo_flip:
+			case aya_neo_geek:
+			case aya_neo_kun:
+			case oxp_2:
+			case oxp_fly:
+			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
+			case oxp_mini_amd_pro:
+			case oxp_x1:
+				return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
+			default:
+				break;
+			}
 		default:
 			break;
 		}
-		break;
 	default:
 		break;
 	}
@@ -381,21 +575,35 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			if (val < 0 || val > 255)
 				return -EINVAL;
 			switch (board) {
+			case orange_pi_neo:
+				/* scale to range [1-244] */
+				val = ((val - 1) * 243 / 254) + 1;
+				return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
+			case oxp_2:
+			case oxp_x1:
+				/* scale to range [0-184] */
+				val = (val * 184) / 255;
+				return write_to_ec(OXP_SENSOR_PWM_REG, val);
 			case aya_neo_2:
 			case aya_neo_air:
+			case aya_neo_air_1s:
 			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
+			case aya_neo_flip:
 			case aya_neo_geek:
+			case aya_neo_kun:
 			case oxp_mini_amd:
 			case oxp_mini_amd_a07:
+				/* scale to range [0-100] */
 				val = (val * 100) / 255;
-				break;
+				return write_to_ec(OXP_SENSOR_PWM_REG, val);
 			case aok_zoe_a1:
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
@@ -467,19 +675,20 @@ static int __init oxp_platform_init(void)
 {
 	const struct dmi_system_id *dmi_entry;
 
-	/*
-	 * Have to check for AMD processor here because DMI strings are the
-	 * same between Intel and AMD boards, the only way to tell them apart
-	 * is the CPU.
-	 * Intel boards seem to have different EC registers and values to
-	 * read/write.
-	 */
 	dmi_entry = dmi_first_match(dmi_table);
-	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (!dmi_entry)
 		return -ENODEV;
 
 	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
 
+	/*
+	 * Have to check for AMD processor here because DMI strings are the same
+	 * between Intel and AMD boards on older OneXPlayer devices, the only way
+	 * to tell them apart is the CPU. Old Intel boards have an unsupported EC.
+	 */
+	if (board == oxp_mini_amd && boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return -ENODEV;
+
 	oxp_platform_device =
 		platform_create_bundle(&oxp_platform_driver,
 				       oxp_platform_probe, NULL, 0, NULL, 0);
-- 
2.46.0


