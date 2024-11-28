Return-Path: <linux-kernel+bounces-424330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0529DB321
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86202166854
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10117146A97;
	Thu, 28 Nov 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Xli4sk+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF11465BE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778572; cv=none; b=TSbXPfGp3yjP5LG0TobvQIZCGDVBwIP/kZOGEgT3fbCzb9EwTrLOg1NGc3cqVOOC93uIq2cUBbdckLxHAwuAy9CA+puCr2zU49Q1w6ve3+lS1kN1q+fC2RFdFjiog7DYUcm869U+xIifbZ5lle4paLEKfBNumw5SEiHwF8gjXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778572; c=relaxed/simple;
	bh=cYiMQFUepr/7HIOZlaZuHcLmID0r11UiHRyOy2FF3p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7Z2iqFGa/V6GAKByMRatZ8bafGhsiJiC/9fh9p6Idjfyyo5jYJh4hkJjET84EZPJFR8bZnADkgpTO53VmxOCMg1uCoa2C6BRQaTQTFVgn8ifI9wDgWLtpTBrcBOkhGsq1U74kBGQFM+k4dWFBXYMHlRPKmI7wbNEFRKLlSfIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Xli4sk+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a1833367so2806765e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732778566; x=1733383366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTVe6tHU+QUhSHuSARrd4RmERiwOyLRYV6vBOxjAC90=;
        b=2Xli4sk+dQsBcoYun7zctrHGSdpti2sSL63pWpIAirF8/1ro8FzO1gTljl5uTAKv1g
         +fli+PHXnsOw6Z9NieLCExQb5WU9vGxi0EoAOH2TWiuBFlnwN5bQ/mhUhxgH5Qh1DFcW
         gJtmTo1AJkBjhMa1zab8TbONAUOuchA3QWxgVozSmc/z7zjAdf3q9Dsv/HewWh/iyljV
         1n5vPybLuZkjwDUysvyMrMz2nQpqtvvdAC+ID401/qVT4VherE+i2UU3UCWdnWJuoxZ/
         LZ3RLNph4y0iLjHse2lUAwEuc5lrF1Upm6Ah4K8YEC1eebjdZWiK6qSC4qtoPErnMxsC
         rFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732778566; x=1733383366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTVe6tHU+QUhSHuSARrd4RmERiwOyLRYV6vBOxjAC90=;
        b=bB51Y4fQk2fvTP+xVMYFinO88crXWWltCIsmO19vVmBiB44FH1Caxs8jPJGdAziOv+
         KdxT7WZkCjbbVNnUND0HcPty/ADVHwiI3pObAt3bqTTWMxvJzfR0DWp0W4b5G46iPA6r
         XOEKZxo2Lfx0kb5cxUMyfa73rGl8ugovWKkNUi3ahuZPtg8OgNAynTFLCHRykNP0oGaG
         073/Y6TxD6OatxyKmjnxkn9RG5G2TAquLBGEx4a2cEXE3hVdBDLGpAvf4nYBj/zuGkUj
         J968nvW1GaB/ANIDb1IwU7uCKOMXEi1MpJVvWFLnvqgZnqOAKEUTasQnp+a6vRdLm/jS
         eDLQ==
X-Gm-Message-State: AOJu0Yy4Pbixn6ngICKEFhMDTnu7VaM6iOUK3r4n0UQtZjtpqaZkj2PO
	+Zn8wQ9OFidNtFLW1IVL/u7/vkxZESU+crYfXuxnl2kgxZVCUFoqKDj/UDhMGi0=
X-Gm-Gg: ASbGncuYLzbfJ41gzoNsztz4JVnovBKgzod9NoExlTocmipeqyjDBCCBxeNtKzI+1C+
	nPVpluAKuNxaqV9f8vKBOylEKDI59qdmbJ5LvIIN71xKWPuevP6UO9D58saOBHB0dRwLK2yl+Zc
	oZ0CRbhKfVw3F9pPGRBfVsi4Z1e8ACHf5ZzETCAmZlqRSmvsh5iepCOfLo3ZupYbsitnO0nr8V7
	CnSfrqkjEw1smTse1QSUwAn2NrM7eHUn1DvQK+6z4LxEmegyeCvTQ==
X-Google-Smtp-Source: AGHT+IEKSb7Ar28Nb1YZxg/V2OBSEtpXATH7MY0ZG2xhK4Gnc+17q6QjH/1fj2El41zQpkL+O6mIJg==
X-Received: by 2002:a05:600c:1d0f:b0:434:9fc8:63a7 with SMTP id 5b1f17b1804b1-434afb9539dmr16815245e9.1.1732778566286;
        Wed, 27 Nov 2024 23:22:46 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:d1f0:9fd7:467:6a80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d22d4sm43589655e9.27.2024.11.27.23.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 23:22:45 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pcmcia: Switch back to struct platform_driver::remove()
Date: Thu, 28 Nov 2024 08:22:35 +0100
Message-ID: <20241128072235.711764-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4826; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cYiMQFUepr/7HIOZlaZuHcLmID0r11UiHRyOy2FF3p4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhnQPKZss5TeFRenaRq5Ct/a7P/xU+Njv3sLmEFbds8UhN m9rjbZ1MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRCfzs//06c3P+Hbt/WH9L gM98x74/leUz/lmpSYjkPu225zBTndYz8bCvgY7ebtdP/8u3ccxwueMm9E0y1Op2qN6KjHc9d0V 21vt+CFcTqFLQPrP7/ae0r739x6cbhnAbyJUceXU2Jdc1hNsndekn1X+22uznhT65rflXuHRN/2 uRtVvulgerNW6tUmUv9rl1e4ZPlP7H/n8tMeuaRSf2Cp9nWXapd6O91mFDr5ig6OjNSxSjCy7PX r0rOizxMMub27Fsypy7vHfNrZCY7/S4/KzA50XV0jcd/IM2rk4K0+0wqeJpP1HmqvT5YvtLbdV5 bF5tzuxLT81ItS/VP3pCrPR3zLIW61mPOd/aL3m5YLkrAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/pcmcia to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

En passant make the alignment of the struct initializer in
electra_cf.c consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is based on todays next, feel free to drop changes that result in a
conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

The change isn't urgent (as there are still quite a few users of
.remove_new()) and merge window material.

Best regards
Uwe

 drivers/pcmcia/bcm63xx_pcmcia.c | 2 +-
 drivers/pcmcia/db1xxx_ss.c      | 2 +-
 drivers/pcmcia/electra_cf.c     | 4 ++--
 drivers/pcmcia/omap_cf.c        | 2 +-
 drivers/pcmcia/pxa2xx_base.c    | 2 +-
 drivers/pcmcia/sa1100_generic.c | 2 +-
 drivers/pcmcia/xxs1500_ss.c     | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 5bda3e6d43d8..695a24967474 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -453,7 +453,7 @@ static void bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
 
 struct platform_driver bcm63xx_pcmcia_driver = {
 	.probe	= bcm63xx_drv_pcmcia_probe,
-	.remove_new = bcm63xx_drv_pcmcia_remove,
+	.remove	= bcm63xx_drv_pcmcia_remove,
 	.driver	= {
 		.name	= "bcm63xx_pcmcia",
 	},
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 509713b9a502..85d2616061dd 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -592,7 +592,7 @@ static struct platform_driver db1x_pcmcia_socket_driver = {
 		.name	= "db1xxx_pcmcia",
 	},
 	.probe		= db1x_pcmcia_socket_probe,
-	.remove_new	= db1x_pcmcia_socket_remove,
+	.remove		= db1x_pcmcia_socket_remove,
 };
 
 module_platform_driver(db1x_pcmcia_socket_driver);
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 5ae826e54811..00c5aba50844 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -341,8 +341,8 @@ static struct platform_driver electra_cf_driver = {
 		.name = driver_name,
 		.of_match_table = electra_cf_match,
 	},
-	.probe	  = electra_cf_probe,
-	.remove_new = electra_cf_remove,
+	.probe = electra_cf_probe,
+	.remove = electra_cf_remove,
 };
 
 module_platform_driver(electra_cf_driver);
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 80137c7afe0d..f0ccf479f36e 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -306,7 +306,7 @@ static struct platform_driver omap_cf_driver = {
 	.driver = {
 		.name	= driver_name,
 	},
-	.remove_new	= __exit_p(omap_cf_remove),
+	.remove		= __exit_p(omap_cf_remove),
 };
 
 static int __init omap_cf_init(void)
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 457fb81b497a..370a8e16dc81 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -336,7 +336,7 @@ static const struct dev_pm_ops pxa2xx_drv_pcmcia_pm_ops = {
 
 static struct platform_driver pxa2xx_pcmcia_driver = {
 	.probe		= pxa2xx_drv_pcmcia_probe,
-	.remove_new	= pxa2xx_drv_pcmcia_remove,
+	.remove		= pxa2xx_drv_pcmcia_remove,
 	.driver		= {
 		.name	= "pxa2xx-pcmcia",
 		.pm	= &pxa2xx_drv_pcmcia_pm_ops,
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index ccb219c38761..7b5ac8fe811d 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -177,7 +177,7 @@ static struct platform_driver sa11x0_pcmcia_driver = {
 		.name		= "sa11x0-pcmcia",
 	},
 	.probe		= sa11x0_drv_pcmcia_probe,
-	.remove_new	= sa11x0_drv_pcmcia_remove,
+	.remove		= sa11x0_drv_pcmcia_remove,
 };
 
 /* sa11x0_pcmcia_init()
diff --git a/drivers/pcmcia/xxs1500_ss.c b/drivers/pcmcia/xxs1500_ss.c
index 2a93fbbd128d..f84dd5914a6b 100644
--- a/drivers/pcmcia/xxs1500_ss.c
+++ b/drivers/pcmcia/xxs1500_ss.c
@@ -316,7 +316,7 @@ static struct platform_driver xxs1500_pcmcia_socket_driver = {
 		.name	= "xxs1500_pcmcia",
 	},
 	.probe		= xxs1500_pcmcia_probe,
-	.remove_new	= xxs1500_pcmcia_remove,
+	.remove		= xxs1500_pcmcia_remove,
 };
 
 module_platform_driver(xxs1500_pcmcia_socket_driver);

base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.45.2


