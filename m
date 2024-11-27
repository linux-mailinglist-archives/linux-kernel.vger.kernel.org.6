Return-Path: <linux-kernel+bounces-423219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539869DA480
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BC9283128
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D87191F79;
	Wed, 27 Nov 2024 09:10:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B31917F0;
	Wed, 27 Nov 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698645; cv=none; b=I3G5TIp6TqCggTMcPzhtIVkpEj2AM9ZEfJVwQlfCBUtSac9gVAZ4F5pRl8My9NILi7EogHKmcELz2w4qJw7BDQuL6RULGaPj2nFg8fA+UK0O8r3QQtIHRmLYMQHBX5NvjOz2rh1Cw+4zHigfNxX+MD2fuqcSb5soFfjdJox7LpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698645; c=relaxed/simple;
	bh=cILoJznEakS0xNgdjT3evu4plynf+BdBXLdjjw9AWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7ajnjJJOqXCZLoPmrBqGSz9Mme7Ta3J5i/wHYr5Lr96/KCMMM1CtyzrNNxCB5POFWxC/Ok2wAAKgIeF6D/2KTCRwUB69OQXkiFac4ut1rr3Qzb8GXBG9lrzKj1YbvESmyDiBCE1MoA2FL/OwIQm1VQpVFRIwCe63bhBqci/dAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B1FC4CECC;
	Wed, 27 Nov 2024 09:10:44 +0000 (UTC)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH] extcon: Switch back to struct platform_driver::remove()
Date: Wed, 27 Nov 2024 10:10:36 +0100
Message-ID: <20241127091036.444330-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5936; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=HiJ/B4IqM+rtiSxxWBmvwXK8XCoFKN73GWiVFlpTVi8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRuIMwh04I1vIABkUihVEaJ3Wy7+eZeSSicbSa PdQU+ciauaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0biDAAKCRCPgPtYfRL+ TilZCACjIMygkN6dpbwYNqk0Yq0kEb8n000WKi88V6vryVSqCnBGNDibb7Q5Ah83cc89iHLKcyT iRvU9JBV6p97+9AueWD4cxDbuGKXWGLgdyxcKihxq4Zp2RVHffWTlZjafBJOv2RyXRuRvjJUQkL FhKkLuQr1vJHuPJ7wG+M6YoIngQ5oeSPoQJXkNw88TvvOyGWL6JGDZEq/PBuF9dmqZBEaeTOXw5 yGSZsu/vcSyzPz+qbzCGHkDo6+XD8il3+b6o2Yw7++yU1P0/fVjD+/Tbcc7belPRpfV+KBNpuyn b486u7X6srPfsgYiXkoeFRC1+GlvNMLCYl3XpyInDnYTLEPr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@kernel.org>

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/extcon to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

En passant make the alignment of the struct initializer in
extcon-usbc-cros-ec.c consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on today's next, feel free to drop changes that result in a
conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Best regards
Uwe

 drivers/extcon/extcon-adc-jack.c     | 2 +-
 drivers/extcon/extcon-intel-cht-wc.c | 2 +-
 drivers/extcon/extcon-intel-mrfld.c  | 2 +-
 drivers/extcon/extcon-max3355.c      | 2 +-
 drivers/extcon/extcon-max77843.c     | 2 +-
 drivers/extcon/extcon-rtk-type-c.c   | 2 +-
 drivers/extcon/extcon-usb-gpio.c     | 2 +-
 drivers/extcon/extcon-usbc-cros-ec.c | 6 +++---
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index 125016da7fde..46c40d85c2ac 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -196,7 +196,7 @@ static SIMPLE_DEV_PM_OPS(adc_jack_pm_ops,
 
 static struct platform_driver adc_jack_driver = {
 	.probe          = adc_jack_probe,
-	.remove_new     = adc_jack_remove,
+	.remove         = adc_jack_remove,
 	.driver         = {
 		.name   = "adc-jack",
 		.pm = &adc_jack_pm_ops,
diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 93552dc3c895..8131a3d7d562 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -627,7 +627,7 @@ MODULE_DEVICE_TABLE(platform, cht_wc_extcon_table);
 
 static struct platform_driver cht_wc_extcon_driver = {
 	.probe = cht_wc_extcon_probe,
-	.remove_new = cht_wc_extcon_remove,
+	.remove = cht_wc_extcon_remove,
 	.id_table = cht_wc_extcon_table,
 	.driver = {
 		.name = "cht_wcove_pwrsrc",
diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
index a1f737f13d49..9219f4328d70 100644
--- a/drivers/extcon/extcon-intel-mrfld.c
+++ b/drivers/extcon/extcon-intel-mrfld.c
@@ -275,7 +275,7 @@ static struct platform_driver mrfld_extcon_driver = {
 		.name	= "mrfld_bcove_pwrsrc",
 	},
 	.probe		= mrfld_extcon_probe,
-	.remove_new	= mrfld_extcon_remove,
+	.remove		= mrfld_extcon_remove,
 	.id_table	= mrfld_extcon_id_table,
 };
 module_platform_driver(mrfld_extcon_driver);
diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
index e62ce7a8d131..b2ee4ff8b04d 100644
--- a/drivers/extcon/extcon-max3355.c
+++ b/drivers/extcon/extcon-max3355.c
@@ -127,7 +127,7 @@ MODULE_DEVICE_TABLE(of, max3355_match_table);
 
 static struct platform_driver max3355_driver = {
 	.probe		= max3355_probe,
-	.remove_new	= max3355_remove,
+	.remove		= max3355_remove,
 	.driver		= {
 		.name	= "extcon-max3355",
 		.of_match_table = max3355_match_table,
diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 9849e3b8327e..2ae9f7f1a67f 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -956,7 +956,7 @@ static struct platform_driver max77843_muic_driver = {
 		.of_match_table = of_max77843_muic_dt_match,
 	},
 	.probe		= max77843_muic_probe,
-	.remove_new	= max77843_muic_remove,
+	.remove		= max77843_muic_remove,
 	.id_table	= max77843_muic_id,
 };
 
diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 19a01e663733..bdc2b7b3a246 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -1778,7 +1778,7 @@ static const struct dev_pm_ops extcon_rtk_type_c_pm_ops = {
 
 static struct platform_driver extcon_rtk_type_c_driver = {
 	.probe		= extcon_rtk_type_c_probe,
-	.remove_new	= extcon_rtk_type_c_remove,
+	.remove		= extcon_rtk_type_c_remove,
 	.driver		= {
 		.name	= "extcon-rtk-type_c",
 		.of_match_table = extcon_rtk_type_c_match,
diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index 9b61eb99b7dc..5e8ad21ad206 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -279,7 +279,7 @@ MODULE_DEVICE_TABLE(platform, usb_extcon_platform_ids);
 
 static struct platform_driver usb_extcon_driver = {
 	.probe		= usb_extcon_probe,
-	.remove_new	= usb_extcon_remove,
+	.remove		= usb_extcon_remove,
 	.driver		= {
 		.name	= "extcon-usb-gpio",
 		.pm	= &usb_extcon_pm_ops,
diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 805a47230689..529ac5898e38 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -525,12 +525,12 @@ MODULE_DEVICE_TABLE(of, extcon_cros_ec_of_match);
 
 static struct platform_driver extcon_cros_ec_driver = {
 	.driver = {
-		.name  = "extcon-usbc-cros-ec",
+		.name = "extcon-usbc-cros-ec",
 		.of_match_table = of_match_ptr(extcon_cros_ec_of_match),
 		.pm = DEV_PM_OPS,
 	},
-	.remove_new = extcon_cros_ec_remove,
-	.probe   = extcon_cros_ec_probe,
+	.remove = extcon_cros_ec_remove,
+	.probe = extcon_cros_ec_probe,
 };
 
 module_platform_driver(extcon_cros_ec_driver);

base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
-- 
2.45.2


