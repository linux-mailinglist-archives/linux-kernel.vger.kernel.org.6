Return-Path: <linux-kernel+bounces-168935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099678BBFED
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681161F21642
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CB79D2;
	Sun,  5 May 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ov8EUCRI"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B512747F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714902226; cv=none; b=YxDbfOlv4W38gwNYpnMqdNeSGU4oD053jzg/18OmXsdynk46u1tpYpdyKjk1eSE+5MhQ0bwsqclm7Px/kmsuq8HSiyADt+yTbi6xZtUjiEH8N1wXvs2Tsz5GzePPVpG/53fIEX4HjV5wqdO3OT7gOmejRpTcsaFosZjVbXGOW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714902226; c=relaxed/simple;
	bh=69zuOGDVoiA8YolUWTMHMK/ue23v46ozm7Zzhb88fmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ocdeA9eH1wQn4KOLPd+hc86bC3vmsKw0LzKcrsVwY5y/YN/8SjR0JBy2VY4cP7sRE+c88ItLuS8wnNILUx075vL7ZBuBT5LK4mK6djFEHxd77yD+gpkx41jRFemtqAKX9Bhg82z8kqXsigtthJeLMEsxg4e/gIkZUiyOC98mxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ov8EUCRI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714902214;
	bh=69zuOGDVoiA8YolUWTMHMK/ue23v46ozm7Zzhb88fmY=;
	h=From:Date:Subject:To:Cc:From;
	b=Ov8EUCRIUEwsCYlWlwhRXyRpDsev8MnJ/KWJl7xN4ZmK2DpjFdYKJzrUjAyXqTW4c
	 f4V9/xaX400fApwybWtB079lEZhSem/amg2SgY2X7m6Q13NrkcfVC3VaXK9qMnOPok
	 Aqy90ivgKlk7d5Bza5EdVkmMjSFfk4edev0aMxuk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 05 May 2024 11:41:13 +0200
Subject: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADhUN2YC/x3MWwqDMBBG4a3IPHcgphWrWyml6OS3HbxEJlAFc
 e8NffwezjkowRSJ2uIgw1eTxiWjvBQkn255gzVkk3f+5ipXsVhMLwiPfeAJgQfrZmzRRq7hcb+
 WvdSNUO5Xw6D7//14nucPDPQ5wWsAAAA=
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714902214; l=4055;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=69zuOGDVoiA8YolUWTMHMK/ue23v46ozm7Zzhb88fmY=;
 b=aOJ2dfaKSQlwO0RyMYkOmQsSBkyJsuBdOIG6zUFNlS7rYBQ3L4lz/G0pbGrmTgMHrFXv3B0cZ
 L4dNXdcWQM5D0iLxJdpEYkkho8vbx0+Bx1ZTYc7bQ7oALLiiYrwikkr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ChromeOS EC used in Framework laptops supports the standard cros
keyboard backlight protocol.
However the firmware on these laptops don't implement the ACPI ID
GOOG0002 that is recognized by cros_kbd_led_backlight and they also
don't use device tree.

Extend the cros_ec MFD device to also load cros_kbd_led_backlight
when the EC reports EC_FEATURE_PWM_KEYB.

Tested on a Framework 13 AMD, Bios 3.05.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This is based on
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

The helper keyboard_led_is_mfd_device is a bit iffy, but I couldn't find
a nicer way.

* driver_data from platform_device_id is overwritten by the mfd platform data
* Setting the driver_data in drivers/mfd/cros_ec_dev.c would expose the
  internals of cros_kbd_led_backlight
---
 drivers/mfd/cros_ec_dev.c                        |  9 ++++++
 drivers/platform/chrome/cros_kbd_led_backlight.c | 41 +++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a52d59cc2b1e..4444b361aeae 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -99,6 +99,10 @@ static const struct mfd_cell cros_ec_wdt_cells[] = {
 	{ .name = "cros-ec-wdt", }
 };
 
+static const struct mfd_cell cros_ec_keyboard_leds_cells[] = {
+	{ .name = "cros-keyboard-leds", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -125,6 +129,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_wdt_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
 	},
+	{
+		.id		= EC_FEATURE_PWM_KEYB,
+		.mfd_cells	= cros_ec_keyboard_leds_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_keyboard_leds_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index b83e4f328620..88dd3848e5da 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -194,13 +194,52 @@ static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_
 
 #endif /* IS_ENABLED(CONFIG_CROS_EC) */
 
+#if IS_ENABLED(CONFIG_MFD_CROS_EC_DEV)
+static int keyboard_led_init_ec_pwm_mfd(struct platform_device *pdev)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct keyboard_led *keyboard_led = platform_get_drvdata(pdev);
+
+	keyboard_led->ec = cros_ec;
+
+	return 0;
+}
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm_mfd = {
+	.init = keyboard_led_init_ec_pwm_mfd,
+	.brightness_set_blocking = keyboard_led_set_brightness_ec_pwm,
+	.brightness_get = keyboard_led_get_brightness_ec_pwm,
+	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
+};
+
+#else /* IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) */
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
+
+#endif /* IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) */
+
+static int keyboard_led_is_mfd_device(struct platform_device *pdev)
+{
+	if (!IS_ENABLED(CONFIG_MFD_CROS_EC_DEV))
+		return 0;
+
+	if (!pdev->dev.parent)
+		return 0;
+
+	return strcmp(pdev->dev.parent->driver->name, "cros-ec-dev") == 0;
+}
+
 static int keyboard_led_probe(struct platform_device *pdev)
 {
 	const struct keyboard_led_drvdata *drvdata;
 	struct keyboard_led *keyboard_led;
 	int error;
 
-	drvdata = device_get_match_data(&pdev->dev);
+	if (keyboard_led_is_mfd_device(pdev))
+		drvdata = &keyboard_led_drvdata_ec_pwm_mfd;
+	else
+		drvdata = device_get_match_data(&pdev->dev);
 	if (!drvdata)
 		return -EINVAL;
 

---
base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
change-id: 20240505-cros_ec-kbd-led-framework-7e2e831bc79c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


