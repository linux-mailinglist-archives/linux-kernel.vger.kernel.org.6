Return-Path: <linux-kernel+bounces-243683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0A929937
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C4D2814E3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984F6D1B4;
	Sun,  7 Jul 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrrG6vPQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179F376E0;
	Sun,  7 Jul 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720374989; cv=none; b=bsDVut9l8V+3YaNWhRhXysyDoaH0MVa/q4TaZcg71OWdVGkHOPWuTkFbvpnidzSFqSVR7fvlrU5l+TJB/YofyzUwLq+4MTKT9u/FAfFq3IRKYY8mQlMqL/mEK9KOfMRja2xeKIo3FqSJSjqOMAwIvfYTA2qKAyPFkZcPg6CQ+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720374989; c=relaxed/simple;
	bh=ewWpnXjirUiS2aDEeJua0X/ZF8NmbZB3lh2CKSyl4so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msJdjo4dnO+zlnMeSnnNoNWXw18zRP+NAV+6lxER+uOPq5mo6b5IWwsgctliR0M0E/ySMCqtd5NBUPoUt2hRBAeg+gCbnO/riH0LieG0uoJwvixJCbAiJUTK+QfGTgw/T8iiYutQmo1NG1E0nEuZZghm/ejaZXB49jgLW77c7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrrG6vPQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so27444825e9.2;
        Sun, 07 Jul 2024 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720374986; x=1720979786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAMUnCXuNCKOobFXOCeUddLBCZN7j4rnZb00uQMMV4E=;
        b=OrrG6vPQBxuUkVAD2tkG5e94c5io7I4CeOipPSIHlGSZnWOWjTWMLtI7MR/yKVuvda
         rKTTmqBZWNofIo6/ZDmlQ83PUMm6XW2IuTujuTjq9T3rZoHy++ikf3uPBlF1j5OdEeXH
         KeIVj/yDR1m7NHtjvq0TKoW4HtO67AnJ+Ib6Q7lmVuDEkTxRBfEhVV3fczmh8u9ewFvQ
         js9and4DX7dzT16wQXgqxAHniPw+8r0n+ytgbD/IFFgJFylaJuw/PdeLCdzKhjHYSg1Y
         l9IC/BZl0YhTH+maj1Bj6nLYPAXEMKQ/hgxDkr/M/lWcDrG+PwY8r6l4cKYUWfRZ5cxc
         9Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720374986; x=1720979786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAMUnCXuNCKOobFXOCeUddLBCZN7j4rnZb00uQMMV4E=;
        b=w9mo0CORxhm0O+DMEB42Aovwr9MVcOPYl+kw2y5pzual54pa5slC77To7S+gMdWaFg
         GKT1+z2LZR9/Gbd/6+xmUdxfu/VH6SIkwRUQoli/SdKTsAVeRuD4C+fInRjj8/KhXEW5
         mMXvfqBJ0VJ5NVXdNtb0gVI8KazFENe6ankVoOp9i2tp54er5GkFxDn2O073slGn18t9
         sKQWWkRjX28Df1SSLMC3n6tANbN21TtzNy9zzggIGZ6R5TuPxfLMH7mhnCwVJobtNE4m
         RSw33WZ2KuuIrXh/11s+xiTFMCAqCvx2YR11vfWz7CRxuUgHLbpPiuBagBthN4lHJab9
         FyrA==
X-Forwarded-Encrypted: i=1; AJvYcCVnI40iEXHCuvX3y5uSu57czVcBxZ9PNUNNa6SCxw2473y/6V5PXg29I4hMkcVSgSPGNEMlC050ok6KRShamfqnkx65+9kjCHWMQKWa
X-Gm-Message-State: AOJu0YyS/VsZQigXPw8hQL/WX7Gz+1Q1GVVnx2twdu6b57OL2pZy8S1n
	03Ia7VYEq2buB4Ej10Mfr8S035vbKIOVJsQnzIyB7/Lom/tGoeFRkzPR8A==
X-Google-Smtp-Source: AGHT+IEuQ6t6pXpdavTDPEkcKKiERUiuXQRNVoKVd1S6JG0U+ZGk1+xwC6bUe+x0OqcAYqe6YZ+FUA==
X-Received: by 2002:a05:600c:54eb:b0:426:5269:982c with SMTP id 5b1f17b1804b1-426526999bfmr60254715e9.28.1720374986031;
        Sun, 07 Jul 2024 10:56:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:ed72:2800:17de:b512:9f9e:464b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28355csm135562825e9.43.2024.07.07.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 10:56:24 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	carlosmiguelferreira.2003@gmail.com
Subject: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
Date: Sun,  7 Jul 2024 18:54:54 +0100
Message-ID: <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707175613.27529-1-carlosmiguelferreira.2003@gmail.com>
References: <20240707175613.27529-1-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver adds supports for 4 zone keyboard rgb on omen laptops
and maps the wmi backlight toggle event to KEY_KBDILLUMTOGGLE.
For the backlight, it uses the multicolor led api.

Tested on the HP Omen 15-en1001np.

Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
---
Changes in v3:
 - Moved to the multicolor led api
 - Mapped the wmi backlight toggle event to KEY_KBDILLUMTOGGLE
 - Some other minor changes
Changes in v2:
 - Rearranged code to remove forward declarations
 - Changed from sprintf() to sysfs_emit()
 - Fixed some identation and coding style problems
 - Switched from manual bit manipulation to GENMASK(x, y) + FIELD_PREP(XX, )
 - #define'ed magic constants
---
 drivers/platform/x86/hp/hp-wmi.c | 248 +++++++++++++++++++++++++++++--
 1 file changed, 239 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 5fa553023842..5eae47961f76 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -14,6 +14,8 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -24,6 +26,7 @@
 #include <linux/platform_profile.h>
 #include <linux/hwmon.h>
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/rfkill.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
@@ -44,6 +47,14 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
 
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
 
+#define FOURZONE_LIGHTING_SUPPORTED_BIT	0x01
+#define FOURZONE_LIGHTING_ON		228
+#define FOURZONE_LIGHTING_OFF		100
+
+#define FOURZONE_COLOR_R		GENMASK(23, 16)
+#define FOURZONE_COLOR_G		GENMASK(15, 8)
+#define FOURZONE_COLOR_B		GENMASK(7, 0)
+
 /* DMI board names of devices that should use the omen specific path for
  * thermal profiles.
  * This was obtained by taking a look in the windows omen command center
@@ -143,18 +154,36 @@ enum hp_wmi_commandtype {
 };
 
 enum hp_wmi_gm_commandtype {
-	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
-	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
-	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
-	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
-	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
+	HPWMI_FAN_SPEED_GET_QUERY	= 0x11,
+	HPWMI_SET_PERFORMANCE_MODE	= 0x1A,
+	HPWMI_FAN_SPEED_MAX_GET_QUERY	= 0x26,
+	HPWMI_FAN_SPEED_MAX_SET_QUERY	= 0x27,
+	HPWMI_GET_SYSTEM_DESIGN_DATA	= 0x28,
+	HPWMI_GET_KEYBOARD_TYPE		= 0x2B,
+};
+
+enum hp_wmi_fourzone_commandtype {
+	HPWMI_SUPPORTS_LIGHTNING	= 0x01,
+	HPWMI_FOURZONE_COLOR_GET	= 0x02,
+	HPWMI_FOURZONE_COLOR_SET	= 0x03,
+	HPWMI_LED_BRIGHTNESS_GET	= 0x04,
+	HPWMI_LED_BRIGHTNESS_SET	= 0x05,
+};
+
+enum hp_wmi_keyboardtype {
+	HPWMI_KEYBOARD_INVALID        = 0x00,
+	HPWMI_KEYBOARD_NORMAL         = 0x01,
+	HPWMI_KEYBOARD_WITH_NUMPAD    = 0x02,
+	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
+	HPWMI_KEYBOARD_RGB	      = 0x04,
 };
 
 enum hp_wmi_command {
-	HPWMI_READ	= 0x01,
-	HPWMI_WRITE	= 0x02,
-	HPWMI_ODM	= 0x03,
-	HPWMI_GM	= 0x20008,
+	HPWMI_READ     = 0x01,
+	HPWMI_WRITE    = 0x02,
+	HPWMI_ODM      = 0x03,
+	HPWMI_GM       = 0x20008,
+	HPWMI_FOURZONE = 0x20009,
 };
 
 enum hp_wmi_hardware_mask {
@@ -265,6 +294,7 @@ static struct platform_device *hp_wmi_platform_dev;
 static struct platform_profile_handler platform_profile_handler;
 static bool platform_profile_support;
 static bool zero_insize_support;
+static bool fourzone_lightning_support;
 
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
@@ -821,6 +851,40 @@ static struct attribute *hp_wmi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(hp_wmi);
 
+static const char * const fourzone_zone_names[4] = {
+	"hp:rgb:kbd_zoned_backlight-right",
+	"hp:rgb:kbd_zoned_backlight-middle",
+	"hp:rgb:kbd_zoned_backlight-left",
+	"hp:rgb:kbd_zoned_backlight-wasd"
+};
+
+struct hp_fourzone_leds {
+	struct led_classdev_mc leds[4];
+	struct mc_subled subleds[4];
+	u32 color_cache[4];
+};
+static struct hp_fourzone_leds fourzone_leds;
+
+static enum led_brightness get_fourzone_brightness(struct led_classdev *led_cdev)
+{
+	u8 buff[4];
+
+	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_GET, HPWMI_FOURZONE,
+		&buff, sizeof(buff), sizeof(buff));
+
+	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
+}
+
+static void fourzone_update_brightness(void)
+{
+	unsigned int br;
+
+	/* synchronize the brightness level on all zones */
+	br = get_fourzone_brightness(NULL);
+	for (size_t i = 0; i < 4; i++)
+		fourzone_leds.leds[i].led_cdev.brightness = br;
+}
+
 static void hp_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -932,6 +996,14 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_PROXIMITY_SENSOR:
 		break;
 	case HPWMI_BACKLIT_KB_BRIGHTNESS:
+		if (fourzone_lightning_support) {
+			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
+			input_sync(hp_wmi_input_dev);
+			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
+			input_sync(hp_wmi_input_dev);
+
+			fourzone_update_brightness();
+		}
 		break;
 	case HPWMI_PEAKSHIFT_PERIOD:
 		break;
@@ -1505,6 +1577,154 @@ static int thermal_profile_setup(void)
 	return 0;
 }
 
+static int fourzone_set_colors(u32 color, size_t zone)
+{
+	u8 buff[128];
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
+		&buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return -EINVAL;
+
+	buff[25 + zone * 3]     = FIELD_GET(FOURZONE_COLOR_R, color);
+	buff[25 + zone * 3 + 1] = FIELD_GET(FOURZONE_COLOR_G, color);
+	buff[25 + zone * 3 + 2] = FIELD_GET(FOURZONE_COLOR_B, color);
+
+	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
+		&buff, sizeof(buff), sizeof(buff));
+}
+
+static int fourzone_get_colors(u32 *colors)
+{
+	u8 buff[128];
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
+		&buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return -EINVAL;
+
+	for (int i = 0; i < 4; i++) {
+		colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
+			  | FIELD_PREP(FOURZONE_COLOR_G, buff[25 + i * 3 + 1])
+			  | FIELD_PREP(FOURZONE_COLOR_B, buff[25 + i * 3 + 2]);
+	}
+
+	return 0;
+}
+
+static void set_fourzone_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
+{
+	size_t zone;
+
+	for (size_t i = 0; i < 4; i++)
+		if (strcmp(led_cdev->name, fourzone_zone_names[i]) == 0)
+			zone = i;
+
+	if (fourzone_leds.leds[zone].subled_info->intensity == fourzone_leds.color_cache[zone]) {
+		u8 buff[4] = {
+			brightness == LED_ON ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF,
+			0, 0, 0
+		};
+
+		hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_SET, HPWMI_FOURZONE, &buff,
+			sizeof(buff), 0);
+
+		fourzone_update_brightness();
+	} else {
+		fourzone_set_colors(fourzone_leds.leds[zone].subled_info->intensity, zone);
+		fourzone_leds.color_cache[zone] = fourzone_leds.leds[zone].subled_info->intensity;
+	}
+}
+
+static int __init fourzone_leds_init(struct platform_device *device)
+{
+	enum led_brightness brightness;
+	u32 colors[4];
+	int ret;
+
+	ret = fourzone_get_colors(colors);
+	if (ret < 0)
+		return ret;
+
+	memcpy(fourzone_leds.color_cache, colors, sizeof(colors));
+
+	brightness = get_fourzone_brightness(NULL);
+
+	for (size_t i = 0; i < 4; i++) {
+		fourzone_leds.subleds[i] = (struct mc_subled) {
+			.color_index = LED_COLOR_ID_RGB,
+			.brightness = 1,
+			.intensity = colors[i]
+		};
+
+		fourzone_leds.leds[i] = (struct led_classdev_mc) {
+			.led_cdev = {
+				.name = fourzone_zone_names[i],
+				.brightness = brightness,
+				.max_brightness = 1,
+				.brightness_set = set_fourzone_brightness,
+				.brightness_get = get_fourzone_brightness,
+				.color = LED_COLOR_ID_RGB,
+				.flags = LED_BRIGHT_HW_CHANGED
+			},
+			.num_colors = 1,
+			.subled_info = &fourzone_leds.subleds[i]
+		};
+
+		ret = devm_led_classdev_multicolor_register(&device->dev, &fourzone_leds.leds[i]);
+		if (ret)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
+{
+	u8 buff[128];
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
+		&buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return HPWMI_KEYBOARD_INVALID;
+
+	/* the first byte in the response represents the keyboard type */
+	return (enum hp_wmi_keyboardtype)(buff[0] + 1);
+}
+
+static bool fourzone_supports_lighting(void)
+{
+	u8 buff[128];
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
+		&buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return false;
+
+	return buff[0] & FOURZONE_LIGHTING_SUPPORTED_BIT;
+}
+
+static int fourzone_setup(struct platform_device *device)
+{
+	if (!fourzone_supports_lighting())
+		return -ENODEV;
+
+	if (fourzone_get_keyboard_type() != HPWMI_KEYBOARD_WITHOUT_NUMPAD)
+		return -ENODEV;
+
+	/* register leds */
+	if (fourzone_leds_init(device) < 0)
+		return -ENODEV;
+
+	input_set_capability(hp_wmi_input_dev, KE_KEY, KEY_KBDILLUMTOGGLE);
+
+	return 0;
+}
+
 static int hp_wmi_hwmon_init(void);
 
 static int __init hp_wmi_bios_setup(struct platform_device *device)
@@ -1534,6 +1754,10 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	/* setup 4 zone rgb */
+	if (!fourzone_setup(device))
+		fourzone_lightning_support = true;
+
 	return 0;
 }
 
@@ -1561,6 +1785,12 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 
 	if (platform_profile_support)
 		platform_profile_remove();
+
+	if (fourzone_lightning_support)
+		for (size_t i = 0; i < 4; i++) {
+			devm_led_classdev_multicolor_unregister(&device->dev,
+				&fourzone_leds.leds[i]);
+		}
 }
 
 static int hp_wmi_resume_handler(struct device *device)
-- 
2.45.2


