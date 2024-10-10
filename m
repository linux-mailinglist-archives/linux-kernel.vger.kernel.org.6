Return-Path: <linux-kernel+bounces-360039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5D9993C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F7D287DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23D1E132F;
	Thu, 10 Oct 2024 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NkLi2uF7"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51B1E102C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592610; cv=none; b=Avj3bHSsZ32Aax/4Me4cQWnPR5uq/U4SDAvJDrSRdZq8dC35jCPWu5UqNfWR3Pf3d6wbjj0n52DrS7pad5B3ZbgLfYhs9VZug/hfPv7OBw6PFqNN11eVOLbuZI36VlIh1FdIx508GIL6THVOuAKqNQi461bYRg5L54zY4qOYDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592610; c=relaxed/simple;
	bh=TV+GwrT98MC70ctk2YHveV921ACiYgEAXmbTrekOM1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kzj82iIcJ+jrMAkPWR1tZdqz1XGFSOz8cN71Gk/0nLfKD0e7Mnwe32QQnBF07fII7wyU2sfxmRQI9NdTbmDSno+jBrteDBttpTyt2+XfFlRktCltDV2KV44gHVo+tXGhqffuAVn1pbxfi01vPfQRUPXynbQvCs9dDSdKkqvxHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NkLi2uF7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so1616047a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728592606; x=1729197406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeiBE+v6zVEVp0pnWsNwo65Pjd2GvvYqTdOGsRl0afQ=;
        b=NkLi2uF7AGC7CkH0i4FZNecQMDAurXwfVQnHEPzXhVeIkQmmopTrw/sy3xxHFUYMHg
         X5ZCB4dlTw5V4+FQrLGMcrQgx07TJKAbCwkNDM+BU6DUE63w7RFgZB3ltuo3xjvOEaWY
         thSy0x1DYrh1kBIhTfdNpGghZUvL4nuO53h9IsZ/E8P+RGRieB8Zu/6BElIw2fA4AUbJ
         fKnoGEFQ4bvLqlr+1HF9IJmXQe0L8ngpr7gZWsiWpflnzDSzIKyMGHEfbFo7XkhOBue0
         S0jF7Ghci6U/W0nIqQYRxtkNKXmg3Xmst2n7YtqgXlUdayPDDhfQPcwuk8L6nQgnFMzk
         EzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592606; x=1729197406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeiBE+v6zVEVp0pnWsNwo65Pjd2GvvYqTdOGsRl0afQ=;
        b=JIyxF04jmRSZGLRpT4gCKy5kCXF4tLrnxRKjd+PWG9/VoXNI6FC+47zi24WJHmuLWu
         FipAHU1uul+FqZsJFAywRjPzM7M5VzVf9ZIqw+QZVCHWf4lgAnaJ3fpDaHiesYG+G/IE
         S3HSF2mRLuNmjMO3a0c2733WBEBwXZv3X3+IX10SaR+TKLU4h7iG8ryQzTcraIVj/qaJ
         F5nGJifQ5WyElP4CldG/Lcb83ccOC16tGkE3/t2zgPpnKsSzR8/UQvd/PC9Ljys6KQm5
         fz4Q6Ue4ssInd670XisLN5taCzjjSwLZR6jRrbdjFxWcGHSjaOwSbTyYzSlEoqNLVM/e
         Tliw==
X-Gm-Message-State: AOJu0Yx5GUtgepA0DTTzsQRKxe8FpznjFAJ8GfULucKVtyEOsWk6QEZV
	3eOBgnLHW9Bh6MAraJHbI3qJ7KyxeNQyTA7gNO1P2NkS4yW+HC9naKVzkrEpLio=
X-Google-Smtp-Source: AGHT+IEMKsH2LgZf8/J7vAAne/W+WdBjEefyfBwChXSTp0IMOtHb6W2Kfy3kwgiObfXTVfdvZif6ng==
X-Received: by 2002:a05:6402:13d5:b0:5c2:4cbe:ac33 with SMTP id 4fb4d7f45d1cf-5c948c7294fmr52314a12.2.1728592605715;
        Thu, 10 Oct 2024 13:36:45 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2309sm1218539a12.2.2024.10.10.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:36:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] power: Switch back to struct platform_driver::remove()
Date: Thu, 10 Oct 2024 22:36:24 +0200
Message-ID: <20241010203622.839625-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=20594; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=TV+GwrT98MC70ctk2YHveV921ACiYgEAXmbTrekOM1c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnCDrMJIY6aNd49wF1P4K4rVw8/Z7k4D/pSyMOT 2KQ96MrbQ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZwg6zAAKCRCPgPtYfRL+ TiVoCACF+bri2TYHXtlI2yyG2F2pQf4jROyTXohkdcIVlMwZmG+hInE59c8t7/7tzCrzuhhsjzt 1oZrxiMfCFncxVxSaEBuQ2IDcxpG+5Vh+BICsYJYzDaygj8F7Eoz3IN3CXskJ4urpwzojjKELHY KQIYoGTMNknmvpZso4sPhMyHSughS8SJ61MR7VdraOVqQ8mZAZEaFYRNCaz2AmQbp0zNXWH+kep Fu7OlrXcC0iZFYOf0RRCy9sHe4t8Ov05sl4Cxl7vlzQf3Yz/hVOPfoXJZZC92KP94jaCa6bQoT/ 8Dd9fVuQZ8fzwJSmMOY/IZC6jzQgnfZrAENUKKCgg2gWxEWo
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/power/ to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

While touching these files, make indention of the struct initializer
consistent in several files.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on todays's next, feel free to drop changes that result
in a conflict when you come around to apply this. I'll care for the
fallout at a later time then. (Having said that, if you use b4 am -3 and
git am -3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/power/reset/at91-poweroff.c       | 2 +-
 drivers/power/reset/at91-reset.c          | 2 +-
 drivers/power/reset/at91-sama5d2_shdwc.c  | 2 +-
 drivers/power/reset/ltc2952-poweroff.c    | 2 +-
 drivers/power/reset/qnap-poweroff.c       | 2 +-
 drivers/power/supply/ab8500_btemp.c       | 2 +-
 drivers/power/supply/ab8500_chargalg.c    | 2 +-
 drivers/power/supply/ab8500_charger.c     | 2 +-
 drivers/power/supply/ab8500_fg.c          | 2 +-
 drivers/power/supply/acer_a500_battery.c  | 2 +-
 drivers/power/supply/act8945a_charger.c   | 2 +-
 drivers/power/supply/charger-manager.c    | 2 +-
 drivers/power/supply/cpcap-battery.c      | 2 +-
 drivers/power/supply/cpcap-charger.c      | 2 +-
 drivers/power/supply/da9030_battery.c     | 2 +-
 drivers/power/supply/da9052-battery.c     | 2 +-
 drivers/power/supply/da9150-charger.c     | 2 +-
 drivers/power/supply/ipaq_micro_battery.c | 2 +-
 drivers/power/supply/isp1704_charger.c    | 2 +-
 drivers/power/supply/lp8788-charger.c     | 2 +-
 drivers/power/supply/max14577_charger.c   | 2 +-
 drivers/power/supply/max77650-charger.c   | 2 +-
 drivers/power/supply/max77693_charger.c   | 2 +-
 drivers/power/supply/max8925_power.c      | 2 +-
 drivers/power/supply/pcf50633-charger.c   | 2 +-
 drivers/power/supply/qcom_smbb.c          | 8 ++++----
 drivers/power/supply/sc2731_charger.c     | 2 +-
 drivers/power/supply/tps65090-charger.c   | 2 +-
 drivers/power/supply/tps65217_charger.c   | 2 +-
 drivers/power/supply/twl4030_charger.c    | 2 +-
 drivers/power/supply/wm831x_power.c       | 2 +-
 drivers/power/supply/wm8350_power.c       | 2 +-
 drivers/power/supply/wm97xx_battery.c     | 2 +-
 33 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 93eece027865..7bc779055cf3 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -223,7 +223,7 @@ MODULE_DEVICE_TABLE(of, at91_poweroff_of_match);
 
 static struct platform_driver at91_poweroff_driver = {
 	.probe = at91_poweroff_probe,
-	.remove_new = at91_poweroff_remove,
+	.remove = at91_poweroff_remove,
 	.driver = {
 		.name = "at91-poweroff",
 		.of_match_table = at91_poweroff_of_match,
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 16512654295f..036b18a1f90f 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -427,7 +427,7 @@ static void at91_reset_remove(struct platform_device *pdev)
 
 static struct platform_driver at91_reset_driver = {
 	.probe = at91_reset_probe,
-	.remove_new = at91_reset_remove,
+	.remove = at91_reset_remove,
 	.driver = {
 		.name = "at91-reset",
 		.of_match_table = at91_reset_of_match,
diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 959ce0dbe91d..edb0df86aff4 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -441,7 +441,7 @@ static void at91_shdwc_remove(struct platform_device *pdev)
 
 static struct platform_driver at91_shdwc_driver = {
 	.probe = at91_shdwc_probe,
-	.remove_new = at91_shdwc_remove,
+	.remove = at91_shdwc_remove,
 	.driver = {
 		.name = "at91-shdwc",
 		.of_match_table = at91_shdwc_of_match,
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fa25fbd53934..1a6fc8d38e20 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -305,7 +305,7 @@ MODULE_DEVICE_TABLE(of, of_ltc2952_poweroff_match);
 
 static struct platform_driver ltc2952_poweroff_driver = {
 	.probe = ltc2952_poweroff_probe,
-	.remove_new = ltc2952_poweroff_remove,
+	.remove = ltc2952_poweroff_remove,
 	.driver = {
 		.name = "ltc2952-poweroff",
 		.of_match_table = of_ltc2952_poweroff_match,
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index e0f2ff6b147c..f7d8fc935d51 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -118,7 +118,7 @@ static void qnap_power_off_remove(struct platform_device *pdev)
 
 static struct platform_driver qnap_power_off_driver = {
 	.probe	= qnap_power_off_probe,
-	.remove_new = qnap_power_off_remove,
+	.remove	= qnap_power_off_remove,
 	.driver	= {
 		.name	= "qnap_power_off",
 		.of_match_table = of_match_ptr(qnap_power_off_of_match_table),
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 56f136b2d071..d268dfe9350e 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -818,7 +818,7 @@ MODULE_DEVICE_TABLE(of, ab8500_btemp_match);
 
 struct platform_driver ab8500_btemp_driver = {
 	.probe = ab8500_btemp_probe,
-	.remove_new = ab8500_btemp_remove,
+	.remove = ab8500_btemp_remove,
 	.driver = {
 		.name = "ab8500-btemp",
 		.of_match_table = ab8500_btemp_match,
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 854491ad3ecd..14e1b448bd39 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1837,7 +1837,7 @@ static const struct of_device_id ab8500_chargalg_match[] = {
 
 struct platform_driver ab8500_chargalg_driver = {
 	.probe = ab8500_chargalg_probe,
-	.remove_new = ab8500_chargalg_remove,
+	.remove = ab8500_chargalg_remove,
 	.driver = {
 		.name = "ab8500_chargalg",
 		.of_match_table = ab8500_chargalg_match,
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 93181ebfb324..cece8d6753ac 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3711,7 +3711,7 @@ MODULE_DEVICE_TABLE(of, ab8500_charger_match);
 
 static struct platform_driver ab8500_charger_driver = {
 	.probe = ab8500_charger_probe,
-	.remove_new = ab8500_charger_remove,
+	.remove = ab8500_charger_remove,
 	.driver = {
 		.name = "ab8500-charger",
 		.of_match_table = ab8500_charger_match,
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index a71903b1bf78..78871a2143de 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3242,7 +3242,7 @@ MODULE_DEVICE_TABLE(of, ab8500_fg_match);
 
 struct platform_driver ab8500_fg_driver = {
 	.probe = ab8500_fg_probe,
-	.remove_new = ab8500_fg_remove,
+	.remove = ab8500_fg_remove,
 	.driver = {
 		.name = "ab8500-fg",
 		.of_match_table = ab8500_fg_match,
diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/supply/acer_a500_battery.c
index ef5c419b1b7f..857535d4967b 100644
--- a/drivers/power/supply/acer_a500_battery.c
+++ b/drivers/power/supply/acer_a500_battery.c
@@ -285,7 +285,7 @@ static struct platform_driver a500_battery_driver = {
 		.pm = &a500_battery_pm_ops,
 	},
 	.probe = a500_battery_probe,
-	.remove_new = a500_battery_remove,
+	.remove = a500_battery_remove,
 };
 module_platform_driver(a500_battery_driver);
 
diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 51122bfbf196..b2b82f97a471 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -651,7 +651,7 @@ static struct platform_driver act8945a_charger_driver = {
 		.name = "act8945a-charger",
 	},
 	.probe	= act8945a_charger_probe,
-	.remove_new = act8945a_charger_remove,
+	.remove	= act8945a_charger_remove,
 };
 module_platform_driver(act8945a_charger_driver);
 
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 96f0a7fbf105..3909a708888f 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1740,7 +1740,7 @@ static struct platform_driver charger_manager_driver = {
 		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
-	.remove_new = charger_manager_remove,
+	.remove = charger_manager_remove,
 	.id_table = charger_manager_id,
 };
 
diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 30ec76cdf34b..813037c00ded 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1169,7 +1169,7 @@ static struct platform_driver cpcap_battery_driver = {
 		.of_match_table = of_match_ptr(cpcap_battery_id_table),
 	},
 	.probe	= cpcap_battery_probe,
-	.remove_new = cpcap_battery_remove,
+	.remove	= cpcap_battery_remove,
 };
 module_platform_driver(cpcap_battery_driver);
 
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 91e7292d86bb..7781b45a67a7 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -969,7 +969,7 @@ static struct platform_driver cpcap_charger_driver = {
 		.of_match_table = cpcap_charger_id_table,
 	},
 	.shutdown = cpcap_charger_shutdown,
-	.remove_new = cpcap_charger_remove,
+	.remove = cpcap_charger_remove,
 };
 module_platform_driver(cpcap_charger_driver);
 
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 04e0f4162d42..efe7d286bae8 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -571,7 +571,7 @@ static struct platform_driver da903x_battery_driver = {
 		.name	= "da903x-battery",
 	},
 	.probe = da9030_battery_probe,
-	.remove_new = da9030_battery_remove,
+	.remove = da9030_battery_remove,
 };
 
 module_platform_driver(da903x_battery_driver);
diff --git a/drivers/power/supply/da9052-battery.c b/drivers/power/supply/da9052-battery.c
index 0d84c42c624e..6f17e2fa1a28 100644
--- a/drivers/power/supply/da9052-battery.c
+++ b/drivers/power/supply/da9052-battery.c
@@ -648,7 +648,7 @@ static void da9052_bat_remove(struct platform_device *pdev)
 
 static struct platform_driver da9052_bat_driver = {
 	.probe = da9052_bat_probe,
-	.remove_new = da9052_bat_remove,
+	.remove = da9052_bat_remove,
 	.driver = {
 		.name = "da9052-bat",
 	},
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index b13cecd84f58..27f36ef5b88d 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -636,7 +636,7 @@ static struct platform_driver da9150_charger_driver = {
 		.name = "da9150-charger",
 	},
 	.probe = da9150_charger_probe,
-	.remove_new = da9150_charger_remove,
+	.remove = da9150_charger_remove,
 };
 
 module_platform_driver(da9150_charger_driver);
diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index 66cc649f702a..7e0568a5353f 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -302,7 +302,7 @@ static struct platform_driver micro_batt_device_driver = {
 		.pm	= &micro_batt_dev_pm_ops,
 	},
 	.probe		= micro_batt_probe,
-	.remove_new	= micro_batt_remove,
+	.remove		= micro_batt_remove,
 };
 module_platform_driver(micro_batt_device_driver);
 
diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index 860d8614c98f..237912a92272 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -501,7 +501,7 @@ static struct platform_driver isp1704_charger_driver = {
 		.of_match_table = of_match_ptr(omap_isp1704_of_match),
 	},
 	.probe = isp1704_charger_probe,
-	.remove_new = isp1704_charger_remove,
+	.remove = isp1704_charger_remove,
 };
 
 module_platform_driver(isp1704_charger_driver);
diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 72b170b4ac46..f0a680c155c4 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -716,7 +716,7 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 
 static struct platform_driver lp8788_charger_driver = {
 	.probe = lp8788_charger_probe,
-	.remove_new = lp8788_charger_remove,
+	.remove = lp8788_charger_remove,
 	.driver = {
 		.name = LP8788_DEV_CHARGER,
 	},
diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index b28c04157709..1cef2f860b5f 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -634,7 +634,7 @@ static struct platform_driver max14577_charger_driver = {
 		.of_match_table = of_max14577_charger_dt_match,
 	},
 	.probe		= max14577_charger_probe,
-	.remove_new	= max14577_charger_remove,
+	.remove		= max14577_charger_remove,
 	.id_table	= max14577_charger_id,
 };
 module_platform_driver(max14577_charger_driver);
diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index 818e13c613e3..5f58c0c24b4d 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -364,7 +364,7 @@ static struct platform_driver max77650_charger_driver = {
 		.of_match_table = max77650_charger_of_match,
 	},
 	.probe = max77650_charger_probe,
-	.remove_new = max77650_charger_remove,
+	.remove = max77650_charger_remove,
 };
 module_platform_driver(max77650_charger_driver);
 
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 4caac142c428..cdea35c0d1de 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -798,7 +798,7 @@ static struct platform_driver max77693_charger_driver = {
 		.name	= "max77693-charger",
 	},
 	.probe		= max77693_charger_probe,
-	.remove_new	= max77693_charger_remove,
+	.remove		= max77693_charger_remove,
 	.id_table	= max77693_charger_id,
 };
 module_platform_driver(max77693_charger_driver);
diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/max8925_power.c
index 621a006d52a9..5d0ee5d3ca18 100644
--- a/drivers/power/supply/max8925_power.c
+++ b/drivers/power/supply/max8925_power.c
@@ -563,7 +563,7 @@ static void max8925_power_remove(struct platform_device *pdev)
 
 static struct platform_driver max8925_power_driver = {
 	.probe	= max8925_power_probe,
-	.remove_new = max8925_power_remove,
+	.remove	= max8925_power_remove,
 	.driver	= {
 		.name	= "max8925-power",
 	},
diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index 0e980522fee5..0136bc87b105 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -455,7 +455,7 @@ static struct platform_driver pcf50633_mbc_driver = {
 		.name = "pcf50633-mbc",
 	},
 	.probe = pcf50633_mbc_probe,
-	.remove_new = pcf50633_mbc_remove,
+	.remove = pcf50633_mbc_remove,
 };
 
 module_platform_driver(pcf50633_mbc_driver);
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index 4e57762e27ba..a79563f6ff7a 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -1017,10 +1017,10 @@ static const struct of_device_id smbb_charger_id_table[] = {
 MODULE_DEVICE_TABLE(of, smbb_charger_id_table);
 
 static struct platform_driver smbb_charger_driver = {
-	.probe	  = smbb_charger_probe,
-	.remove_new	 = smbb_charger_remove,
-	.driver	 = {
-		.name   = "qcom-smbb",
+	.probe = smbb_charger_probe,
+	.remove = smbb_charger_remove,
+	.driver = {
+		.name = "qcom-smbb",
 		.of_match_table = smbb_charger_id_table,
 	},
 };
diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index b3d8b1ca97da..50d5157af927 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -530,7 +530,7 @@ static struct platform_driver sc2731_charger_driver = {
 		.of_match_table = sc2731_charger_of_match,
 	},
 	.probe = sc2731_charger_probe,
-	.remove_new = sc2731_charger_remove,
+	.remove = sc2731_charger_remove,
 };
 
 module_platform_driver(sc2731_charger_driver);
diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index d41595764caa..d65193e410a6 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -343,7 +343,7 @@ static struct platform_driver tps65090_charger_driver = {
 		.of_match_table = of_tps65090_charger_match,
 	},
 	.probe	= tps65090_charger_probe,
-	.remove_new = tps65090_charger_remove,
+	.remove = tps65090_charger_remove,
 };
 module_platform_driver(tps65090_charger_driver);
 
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 2382749a2f53..6fff44e1ecac 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -269,7 +269,7 @@ MODULE_DEVICE_TABLE(of, tps65217_charger_match_table);
 
 static struct platform_driver tps65217_charger_driver = {
 	.probe	= tps65217_charger_probe,
-	.remove_new = tps65217_charger_remove,
+	.remove	= tps65217_charger_remove,
 	.driver	= {
 		.name	= "tps65217-charger",
 		.of_match_table = of_match_ptr(tps65217_charger_match_table),
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index f3f1a0862e93..9dcb5457bef4 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1133,7 +1133,7 @@ MODULE_DEVICE_TABLE(of, twl_bci_of_match);
 
 static struct platform_driver twl4030_bci_driver = {
 	.probe = twl4030_bci_probe,
-	.remove_new = twl4030_bci_remove,
+	.remove = twl4030_bci_remove,
 	.driver	= {
 		.name	= "twl4030_bci",
 		.of_match_table = of_match_ptr(twl_bci_of_match),
diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index d56e499ac59f..538055b29dec 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -720,7 +720,7 @@ static void wm831x_power_remove(struct platform_device *pdev)
 
 static struct platform_driver wm831x_power_driver = {
 	.probe = wm831x_power_probe,
-	.remove_new = wm831x_power_remove,
+	.remove = wm831x_power_remove,
 	.driver = {
 		.name = "wm831x-power",
 	},
diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index 3f79ab6f6abf..b0eb6e0ce8bc 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -577,7 +577,7 @@ static void wm8350_power_remove(struct platform_device *pdev)
 
 static struct platform_driver wm8350_power_driver = {
 	.probe = wm8350_power_probe,
-	.remove_new = wm8350_power_remove,
+	.remove = wm8350_power_remove,
 	.driver = {
 		.name = "wm8350-power",
 	},
diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index 1cc38d1437d9..b3b0c37a9dd2 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -265,7 +265,7 @@ static struct platform_driver wm97xx_bat_driver = {
 #endif
 	},
 	.probe		= wm97xx_bat_probe,
-	.remove_new	= wm97xx_bat_remove,
+	.remove		= wm97xx_bat_remove,
 };
 
 module_platform_driver(wm97xx_bat_driver);
-- 
2.45.2


