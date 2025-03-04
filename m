Return-Path: <linux-kernel+bounces-544255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06BA4DF5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBCF1769F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636B2036FB;
	Tue,  4 Mar 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TchGrC0W"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D11FDA9E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095272; cv=none; b=TjJLfszd+gPGUhWvExlaTQ5CJR7+BpMI2pY4wWS/Q/EhzQjooka97T+XT+T3c2gqPTDmRilYZpEmlrFj1yA4QKNFTTrLIvvxSHa0A9AZqJiCszvcoUVc45ZLVHTO16hq9JToAhVPY3Yczw6bojor4Fe+0ROp+bjS6xC7rqJ8Ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095272; c=relaxed/simple;
	bh=/rCkizq4IRRloXDG42ITHhdHtwJv7jdVSCB3pANcMfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1lypMmG5k1qEmAPBYz6ylmy7FgJuxzufBlej798RzSNqp5aPU+tOv7mGJRnQquZzP1fNr/XAo+Aq6+2cjp5MjpJWRp24wARBSwISpQtUt+3Gl0YLC6WUZL8kicGqyOvz62572FsRqMFUdloYnipjXDuQwzhPBN9OuUCROVGoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TchGrC0W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so12387745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741095269; x=1741700069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPOgL4f8sfrIYPZQLvxv+Jdq+OKI+5ZA8zIqn7CnvPM=;
        b=TchGrC0WYP3uOuhD04nZFHA2iRkFMC6iRFWPRYOYEUZ58G+1hC5m/iyMhiOcufTAfT
         9miSjXRjez18x7FwS3Fa+9rdbFJ0ZXtFqAZwZgZ0xoNr50kmy8BisL5bSc1cN9YOxmQH
         hzVdemx9WxWz+w5FhnHj2txq2rWIxA8u5Dqeth+7OfvV9W93FMw6jPCTFFDekA2KNt2B
         EN16eKgUNkeH1F36eNBABfs4o9CoVfjIV1+/0K4T7sAjuCjfSHtomCFG4LzT7XXz1xlq
         NPdya173AZSrSfmaNdNl9tSP6CUJXC38FKFemYqdm3AgU0oEsKaMMdDt5d7+MUb5Jwqr
         Z1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095269; x=1741700069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPOgL4f8sfrIYPZQLvxv+Jdq+OKI+5ZA8zIqn7CnvPM=;
        b=eI5//pLFwpgntcHozE3PNPymVccpde7QJMYJVmpRLHNsFoLvch1bBVPdm/GRrvRrGu
         2JAi/HeprU7v3DW0AkQsXarCcJdvzSmshJNEIQlonRfS9MqgFbnOk4qE1BG77clabpWC
         OFuyIeqSqY0OZdyYvqbMF56SFDByO0D04XAQyF2iun/cdD8blcC9is2UsjywPb3MhSQT
         M3/GyTF9jWGoEfE/sH2CIQ//J8+eRMBdJLrMbWMdDsqGNkvJBBhZ2bqrhXrmFRe81QaP
         6ATRPZdfIAquef0JPwec8GJ8JdCz6mGdoEh+3UaECyEl2QxyuNLmD9ghrdRseYS/t4HJ
         Vy2g==
X-Gm-Message-State: AOJu0Yx7xHku0MoHy6VO9yxCgTNQFlO0siqlH+TVMiR/9xj2E5mnNwWM
	4w+U91Ery2eTM1hawxUkh2B8wQYx8fqI5uko7Zxu4k1RgLoRm6FBNFPG+TH4ocE=
X-Gm-Gg: ASbGncuKa6BMOI6gLEzcqcF+++HB/ia6YdwGALHBe6e1Q41jvJQjgU9w8j9AK5BIv1S
	zm1mk12F224+KPbl0KbTGl3dbTlXVIPlvybKQ/7/QxGziCfNnS2m/mQHx03JR05JIXuC2WBz1R9
	0QqtcW+7r20/L2KrK7tcqOmlmlRPOz/nNfm5UPYY5Jn2Tf4QgEzpoDMnnDywWUX2GZfCjcEkwgU
	3hoIImzv1TyPnfzyEfc/IKbYDj5zBy9xtrrkIDIHhYeL1PfFRsvK4hZTPAJ+gpidxvIuQqC8Epf
	8IpurkVkSfkopjmVe8Cqn2tc2NpZyTJGnKDn5bW2k5UG
X-Google-Smtp-Source: AGHT+IEfCoI/q/nFT7OiFsdhAXSL5yP73nINDD8ABijDCnNaZNn54lK6VcZ8bg8sbbjHczqHkHJQbA==
X-Received: by 2002:a05:600c:3551:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43bcae19446mr23622505e9.6.1741095268689;
        Tue, 04 Mar 2025 05:34:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6018:7257:350d:e85e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bce4313f7sm11803595e9.30.2025.03.04.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:34:28 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] clk: davinci: remove support for da830
Date: Tue,  4 Mar 2025 14:34:23 +0100
Message-ID: <20250304133423.100884-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This SoC has some leftover code all over the kernel but no boards are
supported anymore. Remove support for da830 from the davinci clock
driver. With it: remove the ifdefs around the data structures as the
da850 remains the only davinci SoC supported and the only user of this
driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/clk/davinci/Makefile    |   2 -
 drivers/clk/davinci/pll-da830.c |  71 -------------------
 drivers/clk/davinci/pll.c       |   9 ---
 drivers/clk/davinci/psc-da830.c | 118 --------------------------------
 drivers/clk/davinci/psc.c       |   8 ---
 drivers/clk/davinci/psc.h       |   7 +-
 include/linux/clk/davinci.h     |   6 --
 7 files changed, 1 insertion(+), 220 deletions(-)
 delete mode 100644 drivers/clk/davinci/pll-da830.c
 delete mode 100644 drivers/clk/davinci/psc-da830.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 5d0ae1ee72ec..f9d5c9a392e4 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -4,10 +4,8 @@ ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_DAVINCI_DA8XX)	+= da8xx-cfgchip.o
 
 obj-y += pll.o
-obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 
 obj-y += psc.o
-obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 endif
diff --git a/drivers/clk/davinci/pll-da830.c b/drivers/clk/davinci/pll-da830.c
deleted file mode 100644
index 0a0d06fb25fd..000000000000
--- a/drivers/clk/davinci/pll-da830.c
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PLL clock descriptions for TI DA830/OMAP-L137/AM17XX
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clkdev.h>
-#include <linux/clk/davinci.h>
-#include <linux/bitops.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include "pll.h"
-
-static const struct davinci_pll_clk_info da830_pll_info = {
-	.name = "pll0",
-	.pllm_mask = GENMASK(4, 0),
-	.pllm_min = 4,
-	.pllm_max = 32,
-	.pllout_min_rate = 300000000,
-	.pllout_max_rate = 600000000,
-	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
-};
-
-/*
- * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
- * meaning that we could change the divider as long as we keep the correct
- * ratio between all of the clocks, but we don't support that because there is
- * currently not a need for it.
- */
-
-SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV);
-SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0);
-SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV);
-SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0);
-SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_FIXED_DIV);
-SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0);
-
-int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	struct clk *clk;
-
-	davinci_pll_clk_register(dev, &da830_pll_info, "ref_clk", base, cfgchip);
-
-	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk2, base);
-	clk_register_clkdev(clk, "pll0_sysclk2", "da830-psc0");
-	clk_register_clkdev(clk, "pll0_sysclk2", "da830-psc1");
-
-	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk3, base);
-	clk_register_clkdev(clk, "pll0_sysclk3", "da830-psc0");
-
-	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk4, base);
-	clk_register_clkdev(clk, "pll0_sysclk4", "da830-psc0");
-	clk_register_clkdev(clk, "pll0_sysclk4", "da830-psc1");
-
-	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk5, base);
-	clk_register_clkdev(clk, "pll0_sysclk5", "da830-psc1");
-
-	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk6, base);
-	clk_register_clkdev(clk, "pll0_sysclk6", "da830-psc0");
-
-	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk7, base);
-
-	clk = davinci_pll_auxclk_register(dev, "pll0_auxclk", base);
-	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
-	clk_register_clkdev(clk, "timer0", NULL);
-	clk_register_clkdev(clk, NULL, "davinci-wdt");
-
-	return 0;
-}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 82727b1fc67a..6807a2efa93b 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -840,25 +840,16 @@ int of_davinci_pll_init(struct device *dev, struct device_node *node,
 }
 
 /* needed in early boot for clocksource/clockevent */
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 CLK_OF_DECLARE(da850_pll0, "ti,da850-pll0", of_da850_pll0_init);
-#endif
 
 static const struct of_device_id davinci_pll_of_match[] = {
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 	{ .compatible = "ti,da850-pll1", .data = of_da850_pll1_init },
-#endif
 	{ }
 };
 
 static const struct platform_device_id davinci_pll_id_table[] = {
-#ifdef CONFIG_ARCH_DAVINCI_DA830
-	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 	{ .name = "da850-pll0",  .driver_data = (kernel_ulong_t)da850_pll0_init  },
 	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
-#endif
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc-da830.c b/drivers/clk/davinci/psc-da830.c
deleted file mode 100644
index 6481337382a6..000000000000
--- a/drivers/clk/davinci/psc-da830.c
+++ /dev/null
@@ -1,118 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PSC clock descriptions for TI DA830/OMAP-L137/AM17XX
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "psc.h"
-
-LPSC_CLKDEV1(aemif_clkdev,	NULL,	"ti-aemif");
-LPSC_CLKDEV1(spi0_clkdev,	NULL,	"spi_davinci.0");
-LPSC_CLKDEV1(mmcsd_clkdev,	NULL,	"da830-mmc.0");
-LPSC_CLKDEV1(uart0_clkdev,	NULL,	"serial8250.0");
-
-static const struct davinci_lpsc_clk_info da830_psc0_info[] = {
-	LPSC(0,  0, tpcc,     pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(1,  0, tptc0,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(2,  0, tptc1,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(3,  0, aemif,    pll0_sysclk3, aemif_clkdev, LPSC_ALWAYS_ENABLED),
-	LPSC(4,  0, spi0,     pll0_sysclk2, spi0_clkdev,  0),
-	LPSC(5,  0, mmcsd,    pll0_sysclk2, mmcsd_clkdev, 0),
-	LPSC(6,  0, aintc,    pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(7,  0, arm_rom,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(8,  0, secu_mgr, pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(9,  0, uart0,    pll0_sysclk2, uart0_clkdev, 0),
-	LPSC(10, 0, scr0_ss,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(11, 0, scr1_ss,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(12, 0, scr2_ss,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(13, 0, pruss,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(14, 0, arm,      pll0_sysclk6, NULL,         LPSC_ALWAYS_ENABLED),
-	{ }
-};
-
-static int da830_psc0_init(struct device *dev, void __iomem *base)
-{
-	return davinci_psc_register_clocks(dev, da830_psc0_info, 16, base);
-}
-
-static struct clk_bulk_data da830_psc0_parent_clks[] = {
-	{ .id = "pll0_sysclk2" },
-	{ .id = "pll0_sysclk3" },
-	{ .id = "pll0_sysclk4" },
-	{ .id = "pll0_sysclk6" },
-};
-
-const struct davinci_psc_init_data da830_psc0_init_data = {
-	.parent_clks		= da830_psc0_parent_clks,
-	.num_parent_clks	= ARRAY_SIZE(da830_psc0_parent_clks),
-	.psc_init		= &da830_psc0_init,
-};
-
-LPSC_CLKDEV3(usb0_clkdev,	"fck",	"da830-usb-phy-clks",
-				NULL,	"musb-da8xx",
-				NULL,	"cppi41-dmaengine");
-LPSC_CLKDEV1(usb1_clkdev,	NULL,	"ohci-da8xx");
-/* REVISIT: gpio-davinci.c should be modified to drop con_id */
-LPSC_CLKDEV1(gpio_clkdev,	"gpio",	NULL);
-LPSC_CLKDEV2(emac_clkdev,	NULL,	"davinci_emac.1",
-				"fck",	"davinci_mdio.0");
-LPSC_CLKDEV1(mcasp0_clkdev,	NULL,	"davinci-mcasp.0");
-LPSC_CLKDEV1(mcasp1_clkdev,	NULL,	"davinci-mcasp.1");
-LPSC_CLKDEV1(mcasp2_clkdev,	NULL,	"davinci-mcasp.2");
-LPSC_CLKDEV1(spi1_clkdev,	NULL,	"spi_davinci.1");
-LPSC_CLKDEV1(i2c1_clkdev,	NULL,	"i2c_davinci.2");
-LPSC_CLKDEV1(uart1_clkdev,	NULL,	"serial8250.1");
-LPSC_CLKDEV1(uart2_clkdev,	NULL,	"serial8250.2");
-LPSC_CLKDEV1(lcdc_clkdev,	"fck",	"da8xx_lcdc.0");
-LPSC_CLKDEV2(pwm_clkdev,	"fck",	"ehrpwm.0",
-				"fck",	"ehrpwm.1");
-LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
-				"fck",	"ecap.1",
-				"fck",	"ecap.2");
-LPSC_CLKDEV2(eqep_clkdev,	NULL,	"eqep.0",
-				NULL,	"eqep.1");
-
-static const struct davinci_lpsc_clk_info da830_psc1_info[] = {
-	LPSC(1,  0, usb0,   pll0_sysclk2, usb0_clkdev,   0),
-	LPSC(2,  0, usb1,   pll0_sysclk4, usb1_clkdev,   0),
-	LPSC(3,  0, gpio,   pll0_sysclk4, gpio_clkdev,   0),
-	LPSC(5,  0, emac,   pll0_sysclk4, emac_clkdev,   0),
-	LPSC(6,  0, emif3,  pll0_sysclk5, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(7,  0, mcasp0, pll0_sysclk2, mcasp0_clkdev, 0),
-	LPSC(8,  0, mcasp1, pll0_sysclk2, mcasp1_clkdev, 0),
-	LPSC(9,  0, mcasp2, pll0_sysclk2, mcasp2_clkdev, 0),
-	LPSC(10, 0, spi1,   pll0_sysclk2, spi1_clkdev,   0),
-	LPSC(11, 0, i2c1,   pll0_sysclk4, i2c1_clkdev,   0),
-	LPSC(12, 0, uart1,  pll0_sysclk2, uart1_clkdev,  0),
-	LPSC(13, 0, uart2,  pll0_sysclk2, uart2_clkdev,  0),
-	LPSC(16, 0, lcdc,   pll0_sysclk2, lcdc_clkdev,   0),
-	LPSC(17, 0, pwm,    pll0_sysclk2, pwm_clkdev,    0),
-	LPSC(20, 0, ecap,   pll0_sysclk2, ecap_clkdev,   0),
-	LPSC(21, 0, eqep,   pll0_sysclk2, eqep_clkdev,   0),
-	{ }
-};
-
-static int da830_psc1_init(struct device *dev, void __iomem *base)
-{
-	return davinci_psc_register_clocks(dev, da830_psc1_info, 32, base);
-}
-
-static struct clk_bulk_data da830_psc1_parent_clks[] = {
-	{ .id = "pll0_sysclk2" },
-	{ .id = "pll0_sysclk4" },
-	{ .id = "pll0_sysclk5" },
-};
-
-const struct davinci_psc_init_data da830_psc1_init_data = {
-	.parent_clks		= da830_psc1_parent_clks,
-	.num_parent_clks	= ARRAY_SIZE(da830_psc1_parent_clks),
-	.psc_init		= &da830_psc1_init,
-};
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 355d1be0b5d8..b48322176c21 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -494,22 +494,14 @@ int of_davinci_psc_clk_init(struct device *dev,
 }
 
 static const struct of_device_id davinci_psc_of_match[] = {
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 	{ .compatible = "ti,da850-psc0", .data = &of_da850_psc0_init_data },
 	{ .compatible = "ti,da850-psc1", .data = &of_da850_psc1_init_data },
-#endif
 	{ }
 };
 
 static const struct platform_device_id davinci_psc_id_table[] = {
-#ifdef CONFIG_ARCH_DAVINCI_DA830
-	{ .name = "da830-psc0", .driver_data = (kernel_ulong_t)&da830_psc0_init_data },
-	{ .name = "da830-psc1", .driver_data = (kernel_ulong_t)&da830_psc1_init_data },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 	{ .name = "da850-psc0", .driver_data = (kernel_ulong_t)&da850_psc0_init_data },
 	{ .name = "da850-psc1", .driver_data = (kernel_ulong_t)&da850_psc1_init_data },
-#endif
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index bd23f6fd56df..742672843776 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -94,14 +94,9 @@ struct davinci_psc_init_data {
 	int (*psc_init)(struct device *dev, void __iomem *base);
 };
 
-#ifdef CONFIG_ARCH_DAVINCI_DA830
-extern const struct davinci_psc_init_data da830_psc0_init_data;
-extern const struct davinci_psc_init_data da830_psc1_init_data;
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 extern const struct davinci_psc_init_data da850_psc0_init_data;
 extern const struct davinci_psc_init_data da850_psc1_init_data;
 extern const struct davinci_psc_init_data of_da850_psc0_init_data;
 extern const struct davinci_psc_init_data of_da850_psc1_init_data;
-#endif
+
 #endif /* __CLK_DAVINCI_PSC_H__ */
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index e1d37451e03f..787a81116b00 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -12,12 +12,6 @@
 #include <linux/regmap.h>
 
 /* function for registering clocks in early boot */
-
-#ifdef CONFIG_ARCH_DAVINCI_DA830
-int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 int da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-#endif
 
 #endif /* __LINUX_CLK_DAVINCI_PLL_H___ */
-- 
2.45.2


