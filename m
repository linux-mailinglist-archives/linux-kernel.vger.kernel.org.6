Return-Path: <linux-kernel+bounces-402948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B89C2ED9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD5B214A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31619DF98;
	Sat,  9 Nov 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yEKzh4d8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD72556E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173931; cv=none; b=r61GPpSra4LNeTKIduVQDUR1DnE28pHgRlVzcSdYGHwsQ07q0x/JB+R1hzzFcESEOCzrwDpSFJZ6Hmyemd/DQQ+BzHvcDiu/afStlDUNY5uTazk1KVguFQ0tJ3mZ0RnpVb8bAaWTvL2Lr7XhHXxBL67t+DPbm5jCGTMBZN0kI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173931; c=relaxed/simple;
	bh=cG6BiYtnIMuGLSWrNCwmKIdIDqnFLnsIXWDiSYA+qS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fyjYwMDJQ2c4kbN+eav8/LmnPC9xZ33mAfsps83YOfjfqd+ffLHUKjHx6BpfMACNynhS7vgZnksasODWTdQujQvhQ8cJQK4lDWEjD5eLox2j5ybJ+037+Jka+wDoTgKxY0fCpk1zpB7xpiqgfUG23IGh8YGCAZPSrkRNf1igX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yEKzh4d8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso43215941fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 09:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731173926; x=1731778726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6rulw/lNtnEo0tBG6bWUBB2/E/vFFZuCKLNN5bGCYY=;
        b=yEKzh4d8VZDdT1nSk0Aaoakiv9MfRKj6Uxrgo/VGJkp51OuIbfJWpxZv5do3okr0B8
         Xewe7R3oCjCmYGAAPC2JBAf9h/Pdw6mww+P77+gWTGcr/fmEXcUv5HGMl7GzWG4q5rhb
         1dtbREspWV/bMLDKP4m+8+q2/5jhmFIM2PMhnmN8dNX/rnv8AKnSoZgIv48WfnwS4wxE
         U8Wv7u0WgUdeyHNlKOv2Mq988QoGn4nhrecQHIqjHB0jlHCS4ArqqVgJFKr5pf5fC95s
         SZH7XaXwk9YHIxGC8aFrSmPfpCu3X2WOcXYSKw/aWc+tPPpHs1odUGKaeB7AnleaTuMW
         g+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731173926; x=1731778726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6rulw/lNtnEo0tBG6bWUBB2/E/vFFZuCKLNN5bGCYY=;
        b=aEUfcupnkjxw5OiHn/nlbGcuKXie1odz9lfYv3ncP/hpJ2TyGJkzuHoKU65lLTYnNZ
         Uz9WddRHinouMUaT0kaYduLuvbWQXdy2DgjSsOn1WM5NHcEBMo2/+RWkgopYYjDR6Dy7
         Qpo6+iYzAf57hbzpLiiBH30H/uo8BhUv4XdRou5Y4tn3K9VNEv3NRH10tvpDPWl/SRed
         uKDkm+4uWzWz4L0yL4GaHFH36aZ+YFZlISmgEh4276ZuBhmVWSgbw/7DxY4PTKEuOL5g
         Oa5uWmhgjtfNEOGeU7w3F74eV+3G1nEsfcutTo/v59bLBICozAFogeVdUkQ4vFVP8NYN
         +6IA==
X-Forwarded-Encrypted: i=1; AJvYcCUqVQMwL0mfPsB3ZcbZZCAr57rkVNyfgiXX4Mka/XlDixdP55UU1/w6pyCtL2EFJwRV+XS04Bq+tu8x2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2N2sOO4R8tHdne/DOopfiW0bcMlC4KkQglYc916UWSZBx+Ix
	tDnlwnURizSIr9x/AKoUOrrPMsxkYaFYttplO6M7hSmRVrR/gcSHnPEBMOWbvHY=
X-Google-Smtp-Source: AGHT+IGatdJpXrZhMrODleVrBiUrsfVe/fWc6grf12yxYVJRTNJmQO4th+l4Bm+4iX6izejB8/b8WQ==
X-Received: by 2002:a2e:a995:0:b0:2fb:5206:1675 with SMTP id 38308e7fff4ca-2ff2028a9a5mr51218071fa.27.1731173925582;
        Sat, 09 Nov 2024 09:38:45 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc48f7sm383827966b.118.2024.11.09.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 09:38:45 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH] irqchip: Switch back to struct platform_driver::remove()
Date: Sat,  9 Nov 2024 18:38:27 +0100
Message-ID: <20241109173828.291172-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7905; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cG6BiYtnIMuGLSWrNCwmKIdIDqnFLnsIXWDiSYA+qS4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnL54UuShdHMKtznnRY/uU8T9C6uqh4s2Xw6Ogr gE8iTRWzpaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZy+eFAAKCRCPgPtYfRL+ Tq1qB/0TAMdLwf1xsB/y+fBhD7Fmxay3zicEHr4QUThMuVtJBkFu2Yd9l7iuOeA+yWKZ+8hctBe Pli4gRTBXIQpGUiEdKmefOLSGIT89PjCrkg3RNnUuzZphg+qknMMdFtdz4i/zpsT8DCC5NPg32V yKJWrc2hgRFLDSJmpurJLlR9fgO2/qSjzoV8jiosgsMYI3ocvbc9slQIBQB0QU5nqVtOJHgT9Kd wAyFUJA67lfYbAZ2WjHcYdyQR1hzfTXWofXRK2ptWKg78xWeii7ATGa2hDC1Gd7JKzSGKRbtMwF 22U4mh1wtvYVJgdUhdPYh8Rh1EXipN9kvqxx7RAgxw7qr5wD
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/irqchipto use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/irqchip. While I usually prefer
to do one logical change per patch, this seems to be overengineering
here as the individual changes are really trivial and shouldn't be much
in the way for stable backports. But I'll happily split the patch if you
prefer it split. Also if you object the indentation stuff, I can rework
that.

This is based on yesterday's next, if conflicts arise when you apply it
at some later time and don't want to resolve them, feel free to just
drop the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend.

Best regards
Uwe

 drivers/irqchip/irq-imgpdc.c              | 2 +-
 drivers/irqchip/irq-imx-intmux.c          | 2 +-
 drivers/irqchip/irq-imx-irqsteer.c        | 2 +-
 drivers/irqchip/irq-keystone.c            | 2 +-
 drivers/irqchip/irq-ls-scfg-msi.c         | 2 +-
 drivers/irqchip/irq-madera.c              | 2 +-
 drivers/irqchip/irq-mvebu-pic.c           | 2 +-
 drivers/irqchip/irq-pruss-intc.c          | 2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c | 2 +-
 drivers/irqchip/irq-renesas-irqc.c        | 2 +-
 drivers/irqchip/irq-renesas-rza1.c        | 2 +-
 drivers/irqchip/irq-ts4800.c              | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index b42ed68acfa6..85f80bac0961 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -479,7 +479,7 @@ static struct platform_driver pdc_intc_driver = {
 		.of_match_table	= pdc_intc_match,
 	},
 	.probe		= pdc_intc_probe,
-	.remove_new	= pdc_intc_remove,
+	.remove		= pdc_intc_remove,
 };
 
 static int __init pdc_intc_init(void)
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 511adfaeec82..787543d07565 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -361,6 +361,6 @@ static struct platform_driver imx_intmux_driver = {
 		.pm		= &imx_intmux_pm_ops,
 	},
 	.probe		= imx_intmux_probe,
-	.remove_new	= imx_intmux_remove,
+	.remove		= imx_intmux_remove,
 };
 builtin_platform_driver(imx_intmux_driver);
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 75a0e980ff35..b0e9788c0045 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -328,6 +328,6 @@ static struct platform_driver imx_irqsteer_driver = {
 		.pm		= &imx_irqsteer_pm_ops,
 	},
 	.probe		= imx_irqsteer_probe,
-	.remove_new	= imx_irqsteer_remove,
+	.remove		= imx_irqsteer_remove,
 };
 builtin_platform_driver(imx_irqsteer_driver);
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 30f1979fa124..808c781e2548 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -211,7 +211,7 @@ MODULE_DEVICE_TABLE(of, keystone_irq_dt_ids);
 
 static struct platform_driver keystone_irq_device_driver = {
 	.probe		= keystone_irq_probe,
-	.remove_new	= keystone_irq_remove,
+	.remove		= keystone_irq_remove,
 	.driver		= {
 		.name	= "keystone_irq",
 		.of_match_table	= of_match_ptr(keystone_irq_dt_ids),
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 1aef5c4d27c6..c0e1aafe468c 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -418,7 +418,7 @@ static struct platform_driver ls_scfg_msi_driver = {
 		.of_match_table	= ls_scfg_msi_id,
 	},
 	.probe		= ls_scfg_msi_probe,
-	.remove_new	= ls_scfg_msi_remove,
+	.remove		= ls_scfg_msi_remove,
 };
 
 module_platform_driver(ls_scfg_msi_driver);
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index acceb6e7fa95..b32982c11515 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -236,7 +236,7 @@ static void madera_irq_remove(struct platform_device *pdev)
 
 static struct platform_driver madera_irq_driver = {
 	.probe		= madera_irq_probe,
-	.remove_new	= madera_irq_remove,
+	.remove		= madera_irq_remove,
 	.driver = {
 		.name	= "madera-irq",
 		.pm	= &madera_irq_pm_ops,
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 08b0cc862adf..bd1e06e05a39 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -183,7 +183,7 @@ MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
 
 static struct platform_driver mvebu_pic_driver = {
 	.probe		= mvebu_pic_probe,
-	.remove_new	= mvebu_pic_remove,
+	.remove		= mvebu_pic_remove,
 	.driver = {
 		.name		= "mvebu-pic",
 		.of_match_table	= mvebu_pic_of_match,
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 060eb000e9d3..bee01980b463 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -648,7 +648,7 @@ static struct platform_driver pruss_intc_driver = {
 		.suppress_bind_attrs	= true,
 	},
 	.probe		= pruss_intc_probe,
-	.remove_new	= pruss_intc_remove,
+	.remove		= pruss_intc_remove,
 };
 module_platform_driver(pruss_intc_driver);
 
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 9ad37237ba95..954419f2460d 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -584,7 +584,7 @@ static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
 
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
-	.remove_new	= intc_irqpin_remove,
+	.remove		= intc_irqpin_remove,
 	.driver		= {
 		.name		= "renesas_intc_irqpin",
 		.of_match_table	= intc_irqpin_dt_ids,
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 76026e0b8e20..cbce8ffc7de4 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -247,7 +247,7 @@ MODULE_DEVICE_TABLE(of, irqc_dt_ids);
 
 static struct platform_driver irqc_device_driver = {
 	.probe		= irqc_probe,
-	.remove_new	= irqc_remove,
+	.remove		= irqc_remove,
 	.driver		= {
 		.name		= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index f05afe82db4d..d4e6a68889ec 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -259,7 +259,7 @@ MODULE_DEVICE_TABLE(of, rza1_irqc_dt_ids);
 
 static struct platform_driver rza1_irqc_device_driver = {
 	.probe		= rza1_irqc_probe,
-	.remove_new	= rza1_irqc_remove,
+	.remove		= rza1_irqc_remove,
 	.driver		= {
 		.name		= "renesas_rza1_irqc",
 		.of_match_table	= rza1_irqc_dt_ids,
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index b5dddb3c1568..cc219f28d317 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -154,7 +154,7 @@ MODULE_DEVICE_TABLE(of, ts4800_ic_of_match);
 
 static struct platform_driver ts4800_ic_driver = {
 	.probe		= ts4800_ic_probe,
-	.remove_new	= ts4800_ic_remove,
+	.remove		= ts4800_ic_remove,
 	.driver = {
 		.name		= "ts4800-irqc",
 		.of_match_table	= ts4800_ic_of_match,

base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
-- 
2.45.2


