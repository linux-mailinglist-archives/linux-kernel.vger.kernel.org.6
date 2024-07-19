Return-Path: <linux-kernel+bounces-257180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D793764E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB781C22524
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82084A3E;
	Fri, 19 Jul 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiII1Krt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E162576F;
	Fri, 19 Jul 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383227; cv=none; b=MEkFBcJn82EEtKeSN918KJKe4J1GryKbEfjcT8RqOtdM3cYNjCQ71TsbBd38Obc4urlwQz2P7A4N6rbD9bozcPpAbiLoY3KPcEQxM4nLujam2HjnAR+YKS1oYQY1raFZ8wlJMC3en92g+8Y2CIW/3uW/fB+Hpwzg8Ayo6y/ZeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383227; c=relaxed/simple;
	bh=42xBe+Swlh+eLTTqNr+KJ50s0K/CeNJaqP8MmZCyLWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUaUEx6BClM7rgr0TDG+T9aYb69VOq6cJz+tW2CKPDkB4ecbNH1PyNGlRYAXcfDevhfDk9bhpjp0JHZkC91SpBW5VhX6PNNOM5EP9GgsxtqDlD37Lhu+Fs89Ii4N5p9hUgp0EDSH0X3e6t1U+Iea8SRSYi+RIUg7i0Qp6Vr+qUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiII1Krt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso10799095e9.2;
        Fri, 19 Jul 2024 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721383223; x=1721988023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLCZepvpFKWrFfd4cxGj4noib2WZT1vMKWPfWN3PbCs=;
        b=AiII1KrtnaOQYcGBPb3uSqsk10i1TDbxpPCs4THNYrlbOcnYT+bXmeQ/zjK9bZKi9E
         hCkN3kUm8GF/b6srS1ZcVbqfN1ogGd3D9/6kUKcHlZfnocc6eKrQu5UCKy5gvV9K5QVE
         1v7AdVm/Tk4S7p7jv9Uv82+FsD8vYsMRpC23DdhGPqZr+61kBegzpjI6D4wuJzrkZlCz
         Tk8UIzrWTOk9mTiKGNN/9NxV4clBYTI389KEGw5cdeykZXrxiol7CGqf0yG2bN7aja0U
         Yx4xvjXqMteMFNqfyoQhczm8fKshuO1bREDvnle2jaFkvE197XuPWE2KFCYWwbKN0hmT
         N6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383223; x=1721988023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLCZepvpFKWrFfd4cxGj4noib2WZT1vMKWPfWN3PbCs=;
        b=j+KJAp4pwdYDi0Efb/D42bMLHudDVXmWZt5TcQrLqSPy6O2lZILst/QlGG2Z/tD0d0
         R/A6C8+XrReUQYcFMCo9JHEpWGuem4dA3xJUS3e9QYqBR7fXbpdJhIYc9Yr2ZrIyw2ZB
         qCfL3b78RyrL23RoaUIaTH3khailxbEhPP8BYcg8Az405DcKB7+wLhWI+yiwjTWCrWDC
         8FsKqgwBHSPDkUT9xbygWS9yf76++63TABiw1qi4O2a3ldTmTs5XDvu9r6LOJDhNL1V9
         SIuideNG2kenbfeDr7UgYTwCLg8SQWquF0UEPDT7cZCIo+CbJd6Khzvbd6v/b+gqAx+/
         ymNg==
X-Forwarded-Encrypted: i=1; AJvYcCVpz3UhjDRBJKNLeyHnmZoIggq8enzTrxu4/YZrHkHXNjiMZEASfT8reBKJ+1r+Kz9JwCXNAOZZ77ImBHlBeP6kSXsxrosM2d/zf+823y56akm4/VNwAxunoa7kw9+EFwcPAcij9Ex9DwujN/2wKuN8zw==
X-Gm-Message-State: AOJu0YxxxyAM1pLhRCkDKwHa2NRLZxBbzEzLxKx/fx6b4J7z5f6/mW7E
	k+B3oreThrl5e07tRo9Gkss1Pv+Gx0wK84Z+lNBap1Po1fsFGF24x/BukFxw
X-Google-Smtp-Source: AGHT+IHX/B+v1/NSqv+9ByIJLueXUr7k68a8sP846hDqEiXUEg+x+EOvlu/jbXk0ZO9bzXG2cjfinA==
X-Received: by 2002:adf:e747:0:b0:361:93d5:782f with SMTP id ffacd0b85a97d-368315edb23mr4175189f8f.9.1721383222867;
        Fri, 19 Jul 2024 03:00:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:ed72:2800:17de:b512:9f9e:464b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ec979sm1134359f8f.94.2024.07.19.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:00:21 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: mustafa.eskieksi@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Subject: [PATCH v4 1/2] HP: wmi: added support for 4 zone keyboard rgb
Date: Fri, 19 Jul 2024 10:59:45 +0100
Message-ID: <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
References: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver adds supports for 4 zone keyboard rgb on omen laptops
using the multicolor led api.

Tested on the HP Omen 15-en1001np.

Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
---
 drivers/platform/x86/hp/Kconfig  |   1 +
 drivers/platform/x86/hp/hp-wmi.c | 282 ++++++++++++++++++++++++++++++-
 2 files changed, 274 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
index 7fef4f12e498..6ce6d862ad05 100644
--- a/drivers/platform/x86/hp/Kconfig
+++ b/drivers/platform/x86/hp/Kconfig
@@ -40,6 +40,7 @@ config HP_WMI
 	depends on ACPI_WMI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
+	select LEDS_CLASS_MULTICOLOR
 	select INPUT_SPARSEKMAP
 	select ACPI_PLATFORM_PROFILE
 	select HWMON
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 5fa553023842..b349f8325b93 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -14,7 +14,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -24,6 +28,8 @@
 #include <linux/platform_profile.h>
 #include <linux/hwmon.h>
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/rfkill.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
@@ -44,6 +50,13 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
 
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
 
+#define FOURZONE_LIGHTING_SUPPORTED_BIT	0x01
+#define FOURZONE_LIGHTING_ON		228
+#define FOURZONE_LIGHTING_OFF		100
+
+#define FOURZONE_COLOR	GENMASK(7, 0)
+#define KBD_ZONE_COUNT	4
+
 /* DMI board names of devices that should use the omen specific path for
  * thermal profiles.
  * This was obtained by taking a look in the windows omen command center
@@ -143,18 +156,36 @@ enum hp_wmi_commandtype {
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
@@ -821,6 +852,86 @@ static struct attribute *hp_wmi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(hp_wmi);
 
+static const char * const fourzone_zone_names[KBD_ZONE_COUNT] = {
+	"hp:rgb:kbd_zoned_backlight-right",
+	"hp:rgb:kbd_zoned_backlight-middle",
+	"hp:rgb:kbd_zoned_backlight-left",
+	"hp:rgb:kbd_zoned_backlight-wasd"
+};
+
+struct hp_fourzone_led {
+	struct led_classdev_mc mc_led;
+	struct mc_subled subleds[3];
+	/*
+	 * This stores the last set brightness level to restore it on off->on toggle
+	 * by the FN-key combo.
+	 */
+	enum led_brightness brightness;
+};
+static struct hp_fourzone_led fourzone_leds[KBD_ZONE_COUNT];
+static struct mutex fourzone_mutex;
+
+static enum led_brightness fourzone_get_hw_brightness(void)
+{
+	u8 buff[4];
+
+	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_GET, HPWMI_FOURZONE, &buff,
+			     sizeof(buff), sizeof(buff));
+
+	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
+}
+
+static int fourzone_set_colors(void)
+{
+	int ret, i, j;
+	u8 buff[128];
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE, &buff,
+				   sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return -EINVAL;
+
+	for (i = 0; i < KBD_ZONE_COUNT; i++)
+		for (j = 0; j < 3; j++)
+			buff[25 + i * 3 + j] = fourzone_leds[i].subleds[j].brightness;
+
+	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE, &buff,
+				    sizeof(buff), sizeof(buff));
+}
+
+static void fourzone_set_state(void)
+{
+	enum led_brightness hw_brightness;
+	int i;
+
+	mutex_lock(&fourzone_mutex);
+
+	hw_brightness = fourzone_get_hw_brightness();
+
+	if (hw_brightness)
+		/* restore old brightness values */
+		for (i = 0; i < KBD_ZONE_COUNT; i++) {
+			fourzone_leds[i].mc_led.led_cdev.brightness = fourzone_leds[i].brightness;
+			led_mc_calc_color_components(&fourzone_leds[i].mc_led,
+						     fourzone_leds[i].brightness);
+		}
+	else
+		for (i = 0; i < KBD_ZONE_COUNT; i++) {
+			fourzone_leds[i].brightness = fourzone_leds[i].mc_led.led_cdev.brightness;
+			fourzone_leds[i].mc_led.led_cdev.brightness = LED_OFF;
+			led_mc_calc_color_components(&fourzone_leds[i].mc_led, LED_OFF);
+		}
+
+	fourzone_set_colors();
+
+	/* notify userspace about the change */
+	for (i = 0; i < KBD_ZONE_COUNT; i++)
+		led_classdev_notify_brightness_hw_changed(&fourzone_leds[i].mc_led.led_cdev,
+							  hw_brightness);
+
+	mutex_unlock(&fourzone_mutex);
+}
+
 static void hp_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -932,6 +1043,7 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_PROXIMITY_SENSOR:
 		break;
 	case HPWMI_BACKLIT_KB_BRIGHTNESS:
+		fourzone_set_state();
 		break;
 	case HPWMI_PEAKSHIFT_PERIOD:
 		break;
@@ -1505,6 +1617,155 @@ static int thermal_profile_setup(void)
 	return 0;
 }
 
+static void fourzone_set_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
+{
+	u8 buff[4] = { };
+	int i, zone = 0;
+	bool on = false;
+
+	for (i = 0; i < KBD_ZONE_COUNT; i++)
+		if (!strcmp(led_cdev->name, fourzone_zone_names[i]))
+			zone = i;
+
+	mutex_lock(&fourzone_mutex);
+
+	/* always update main and per color brightness values even when the backlight is off */
+	fourzone_leds[zone].mc_led.led_cdev.brightness = brightness;
+	led_mc_calc_color_components(&fourzone_leds[zone].mc_led, brightness);
+	fourzone_set_colors();
+
+	for (i = 0; i < KBD_ZONE_COUNT; i++)
+		if (fourzone_leds[i].mc_led.led_cdev.brightness)
+			on = true;
+
+	/*
+	 * This makes sure that when turning the kbd off with sw and back on with hw, there is a
+	 * zone with brightness != 0 to go back to
+	 */
+	if (on)
+		fourzone_leds[zone].brightness = brightness;
+
+	/* change the keyboard mode to off if all brightness values are set to 0 */
+	buff[0] = on ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF;
+	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_SET, HPWMI_FOURZONE, &buff, sizeof(buff), 0);
+
+	mutex_unlock(&fourzone_mutex);
+}
+
+static int fourzone_get_hw_colors(u32 *colors)
+{
+	u8 buff[128];
+	int ret, i;
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE, &buff,
+				   sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return -EINVAL;
+
+	for (i = 0; i < KBD_ZONE_COUNT; i++) {
+		colors[i * 3]     = FIELD_GET(FOURZONE_COLOR, buff[25 + i * 3]);
+		colors[i * 3 + 1] = FIELD_GET(FOURZONE_COLOR, buff[25 + i * 3 + 1]);
+		colors[i * 3 + 2] = FIELD_GET(FOURZONE_COLOR, buff[25 + i * 3 + 2]);
+	}
+
+	return 0;
+}
+
+static int __init fourzone_leds_init(struct platform_device *device)
+{
+	enum led_brightness hw_brightness;
+	u32 colors[KBD_ZONE_COUNT * 3];
+	int ret, i, j;
+
+	ret = fourzone_get_hw_colors(colors);
+	if (ret < 0)
+		return ret;
+
+	hw_brightness = fourzone_get_hw_brightness();
+
+	for (i = 0; i < KBD_ZONE_COUNT; i++) {
+		for (j = 0; j < 3; j++)
+			fourzone_leds[i].subleds[j] = (struct mc_subled) {
+				.color_index = j + 1,
+				.brightness = hw_brightness ? colors[i * 3 + j] : 0,
+				.intensity = colors[i * 3 + j],
+			};
+
+		fourzone_leds[i].mc_led = (struct led_classdev_mc) {
+			.led_cdev = {
+				.name = fourzone_zone_names[i],
+				.brightness = hw_brightness ? 255 : 0,
+				.max_brightness = 255,
+				.brightness_set = fourzone_set_brightness,
+				.color = LED_COLOR_ID_RGB,
+				.flags = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN,
+			},
+			.num_colors = 3,
+			.subled_info = fourzone_leds[i].subleds,
+		};
+
+		fourzone_leds[i].brightness = 255;
+
+		ret = devm_led_classdev_multicolor_register(&device->dev, &fourzone_leds[i].mc_led);
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
+	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM, &buff,
+				   sizeof(buff), sizeof(buff));
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
+	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE, &buff,
+				   sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return false;
+
+	return buff[0] & FOURZONE_LIGHTING_SUPPORTED_BIT;
+}
+
+static void fourzone_mutex_destroy(void *data)
+{
+	mutex_destroy((struct mutex *)data);
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
+	mutex_init(&fourzone_mutex);
+	if (devm_add_action_or_reset(&hp_wmi_platform_dev->dev, fourzone_mutex_destroy,
+				     &fourzone_mutex))
+		return -ENODEV;
+
+	/* register leds */
+	if (fourzone_leds_init(device) < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int hp_wmi_hwmon_init(void);
 
 static int __init hp_wmi_bios_setup(struct platform_device *device)
@@ -1534,6 +1795,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	/* setup 4 zone rgb, no problem on error */
+	fourzone_setup(device);
+
 	return 0;
 }
 
-- 
2.45.2


