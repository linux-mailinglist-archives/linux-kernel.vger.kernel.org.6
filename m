Return-Path: <linux-kernel+bounces-176465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3018C304E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA302824E0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15753E33;
	Sat, 11 May 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gagA8n1H"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51153388
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418326; cv=none; b=h7ATr52ydzRLgYnbLe0NqBCAOMIA9W2W8Cz1y+xhhnXw6azNru0bQczQH2sV2lRUcGBl+ut23K9N5MNlXRK7rrPJAkMuoRXY5hF8v8ZFT0sWmjRIlOxns2ieUTM7d5KyGNFpaHM9Exz5I/rKY5MyJ9IUJuvWBWii4zpNSS+2dRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418326; c=relaxed/simple;
	bh=vHYkrX0iW7pZgmP4pEnBHnWb8ZZSaQ9/psNCVVPTmWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEFuJiC+eveF9g594AHrwLC7N4sUusgTYVTAdFtiRq0/ANO3pIgSOSDYFSgN5B5k3qsuSpg3KdYxs20QMPAsEvrrgyrUW7S385eLy0yMUUUREV3iI4x7FY/ZEIzWI+ySosbHWykMFWNPQEB3mMDaZ9tD0Pk7lal+kDDwaH4riA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gagA8n1H; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715418315;
	bh=vHYkrX0iW7pZgmP4pEnBHnWb8ZZSaQ9/psNCVVPTmWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gagA8n1HCIfZS1iLiQaqPAmBfFp+DOHZnS4wsjehj+XtlV3yUiD7H2596ju6c/fG8
	 34TAaeWW+pA+1+bIWZY4GeJ6jrLqSjJHfc0ZGuMlYZOgqUz5MlaCZxcA7fDoalNLp+
	 cIr7jdg6mJqucyTHBqxYIERkVJi51wSbjTGPm03M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 11 May 2024 11:05:13 +0200
Subject: [PATCH v2 2/2] mfd: cros_ec: Register keyboard backlight subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240511-cros_ec-kbd-led-framework-v2-2-b20c48109e46@weissschuh.net>
References: <20240511-cros_ec-kbd-led-framework-v2-0-b20c48109e46@weissschuh.net>
In-Reply-To: <20240511-cros_ec-kbd-led-framework-v2-0-b20c48109e46@weissschuh.net>
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715418315; l=1230;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vHYkrX0iW7pZgmP4pEnBHnWb8ZZSaQ9/psNCVVPTmWo=;
 b=uoQ16y0zTQ25aqJJdsHepudgd6DT5U/u7Dv6tWhxJ4suhC5aZSvg4i9Zc64H1JawB8HmTOyng
 h1XEAsNWP0fBYhi0HJ0kd/ABQxVp7L1uhWX2iuswSu7niVWsTqbSFCI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Load cros_kbd_led_backlight when the EC reports EC_FEATURE_PWM_KEYB.
This makes cros_kbd_led_backlight work on machines without specific
ACPI or OF support for the keyboard backlight.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

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

-- 
2.45.0


