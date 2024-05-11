Return-Path: <linux-kernel+bounces-176464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36B8C304D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77992824C7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D953819;
	Sat, 11 May 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AZvm4/EH"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4745337E
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418326; cv=none; b=Mz7MNB/+mFaDW/n8XYqSMh5qKPP7v5KpBLOA90mp2OobAv3cXyYao1b22Dcjc1UqGCfXjMoujA7JzXCaYlQqPWveXIv0ym0Ax51tvFdtLxLPrIAtScTdBoqK0cTiPiFhrcoWVrlZEI0CSqD3xNNn6b152jSVHbdxM+1AMLt3SHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418326; c=relaxed/simple;
	bh=T9L6qMXMVqDYRgv0hmn/E39oempZVTVo4yyu6+dCn2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U03alwTWx829O8jSKbtLYrnORRk0UbYw5wq+jaaoNFvXdDVsf3oO61nPa0sPa41dxyA5HDl1TKtTKgvzjh7uDH7dGyvai4bH0jP1nSczTlxiW3RGrs//aDh4OHK13ebf4awfcWmmxXtmgiLI6M/kUXUT36/rd/RDkkKTlC6GQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AZvm4/EH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715418315;
	bh=T9L6qMXMVqDYRgv0hmn/E39oempZVTVo4yyu6+dCn2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AZvm4/EHwn5WbM2+typ7XY3u5jbwSjiAKghzK7M2iGK+mvTsjV57P/vXOzN6ZN1Q+
	 ABP4KJzp2tLdjssGszjEDDqbkwt8SaEbnQ6wZjPJvvRzMygf6QuZkrmB+65UXGWrxJ
	 6bAaLwFAkYvMahWHvv7vRV1jJvn5QnZhJoK2Y9zE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 11 May 2024 11:05:12 +0200
Subject: [PATCH v2 1/2] platform/chrome: cros_kbd_led_backlight: allow
 binding through mfd device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240511-cros_ec-kbd-led-framework-v2-1-b20c48109e46@weissschuh.net>
References: <20240511-cros_ec-kbd-led-framework-v2-0-b20c48109e46@weissschuh.net>
In-Reply-To: <20240511-cros_ec-kbd-led-framework-v2-0-b20c48109e46@weissschuh.net>
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715418315; l=2647;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=T9L6qMXMVqDYRgv0hmn/E39oempZVTVo4yyu6+dCn2A=;
 b=1yp1UlStIv22L2qaRcZer9F3Fku4K/glH+sIS5YWUCefKrw5BFJ6G664m6y0Pxu3FW31zqPcO
 P5/utQ+OLNeCse1DHYfQEuzuAPyeqyF3IpAhcvgFgCwcPV9Q+FH73bs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ChromeOS EC used in Framework laptops supports the standard CrOS EC
keyboard backlight protocol.
However the firmware on these laptops doesn't implement the ACPI ID
GOOG0002 that is recognized by cros_kbd_led_backlight and they also
don't use device tree.

Prepare the existing cros_kbd_led_backlight driver to be probed through
the CrOS EC mfd device which works without ACPI or OF support.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_kbd_led_backlight.c | 36 +++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index b83e4f328620..25efff191d62 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mfd/core.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -194,13 +195,46 @@ static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_
 
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
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm_mfd = {};
+
+#endif /* IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) */
+
+static int keyboard_led_is_mfd_device(struct platform_device *pdev)
+{
+	return IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) && mfd_get_cell(pdev);
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
 

-- 
2.45.0


