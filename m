Return-Path: <linux-kernel+bounces-441142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AE9ECA44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B4E188BE33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D65211A13;
	Wed, 11 Dec 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="l5HKlv+Y"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F71EC4DF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912631; cv=none; b=nGGqRIVSS1f5h/W9dF4i0175owOFuFA99No94IV97nyAJKsVDcTAxolkQ24rIflQHRIiwl9oUEq/lLROJ2S60Rki8SFe3Neda9pViNw+14ajv4bDwuxr1VGgYm0W5H76FwR/q8SC11tc5qLGFl2y/LblCwufAavQkbs1Cajp/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912631; c=relaxed/simple;
	bh=gnKSCwyOAGPCAEWBe4y/CpbfgFG4Q/sT43EoaV7fA2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oelJko13eoVFPqIIQXrXp5FjrfYPXBHDx4wwqacgpCR4kVPdYrnpiwcbGlMQl6c1eKNPuJn394rtyLO1E+Ab5WRru6Bd92W+h87ylBgqTGPHE4P87I7q4Embvtq7Ef19wY/39hA3SRtGHBhCWroVs888b+xa9iqxu55LU2+YUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=l5HKlv+Y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38637614567so1932257f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733912626; x=1734517426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGdG+efFlKJMGy1hO60aHqPfOfKK+2Rh3T+XWLFQ1f4=;
        b=l5HKlv+YRQFlKCPtrGf0Z8jqvjRDBDWDOaKPrSi+FZY1hYUC+pSlVdaj8+WIqdAI1w
         feIOVjnSMHVD2q/f81NrYNn379XSDc/XPgGCyjd9QXRT5F1lx5J8E+pnLd/12R+TATQ7
         g3AccY70QkZCyC331u+73fQVCcZ5McblMe6TDB9IPGmwYynzIuJ+XFG4449r9IOo3KLP
         8s51nWqLUEiXNWsiRzgWwMJdLw2yGkBwgZYgcnCy9BQaaIaNTgB1fE9Jgj6N8hlqxUML
         +DPcI3VsJcKg6a1DrxvMJJDc9LShZWsCOuoFDS/ctexz3ruhMe6ZjTxh4+a4Uuv6M9wz
         A9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912626; x=1734517426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGdG+efFlKJMGy1hO60aHqPfOfKK+2Rh3T+XWLFQ1f4=;
        b=lFi1C4VJ6jjT6WAtuMY0XZK/1iFRvKEo8jOJQythMiuf5LdfcFK5cWt1mARFQ8I3QO
         F8loX5b2W6lEEfk5s6oYLvSqLOJMXHPRL5UWesTQgDJGENq0yQD/4auclUeOgHvwlwxt
         eK1R/RSdaVve8RCpg0KU0ecd/NydCq/X3D0H4OmnppV1XdNcQl2AHr9wiJty49E0CAS1
         WQvkDKDykIX+4aye8TcGQG/FiarlsY6kz13/0MPEkdsJowscBQwG+2QkgGPmmceRtdcb
         9g4RsbMDCE5TAowijZ8xldm51RG9+VoNMTTXgLr2pvc9Vwa51blc2X+6TSEhlUSjXh4P
         SJZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrtxzIcVxW+6+oaITZ2mrcu8xpy7lc3zprPK9zc/ovmmM1z0qbhNFCi1c454E4INQ3pZxLYEfDHl1+1Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrL7+c19DB92bhmM+Xq+J+JEwMlKf/MUEExlVHWm/MaN98xUZ
	HPVSCIgYl4GlG48RQq9thhVdlQAIZvLu/rG0xuTw72rnZwmKxrxMB28Fhw0i4mc=
X-Gm-Gg: ASbGncuY1MyxabJiBIjnoB+rkUl62h1lxCP2iTA3PiSaC6nNGsuJq4pXw1mIGR6FQT2
	I1FksW8zGOPpV1UD3wdVyiwqvx30wbXIYsCggbLVlqjVQWMiiOMddRZO1tpQ2g4fKe3lTwhYEN4
	Kvc/MxbMCmRBXY6csWQWyEA0NWpBwTp9ZbOfZ6DXkJUyi4hbDu+8YM41NkSCRMaiZpx21rtreyk
	VwIU1BOWKHHQ5iuNUfOklKew/WMpK2Syi47dbznhTOKLhUkJdB96Q==
X-Google-Smtp-Source: AGHT+IFJ4gCMtzEcx7g0aluwVjcSbC3OL+f83awbEbuLNysR22JVH3W4l1pkbCQc573vAFsmTdpvPg==
X-Received: by 2002:a5d:47ab:0:b0:382:31a1:8dc3 with SMTP id ffacd0b85a97d-3864cea566cmr2073298f8f.35.1733912626455;
        Wed, 11 Dec 2024 02:23:46 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d1b3:c106:bf71:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514da2sm935137f8f.66.2024.12.11.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:23:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] i2c: davinci: kill platform data
Date: Wed, 11 Dec 2024 11:23:35 +0100
Message-ID: <20241211102337.37956-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more board file users of this driver. The platform data
structure is only used internally. Two of the four fields it stores are
not used at all anymore. Pull the remainder into the driver data struct
and shrink code by removing parts that are now dead code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/i2c/busses/i2c-davinci.c          | 80 +++++------------------
 include/linux/platform_data/i2c-davinci.h | 26 --------
 2 files changed, 17 insertions(+), 89 deletions(-)
 delete mode 100644 include/linux/platform_data/i2c-davinci.h

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 71dc0a6688b7..4b499931fdfd 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -26,7 +26,6 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/platform_data/i2c-davinci.h>
 #include <linux/pm_runtime.h>
 
 /* ----- global defines ----------------------------------------------- */
@@ -117,6 +116,8 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
+#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
+
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -132,13 +133,10 @@ struct davinci_i2c_dev {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	struct davinci_i2c_platform_data *pdata;
-};
-
-/* default platform data to use if not supplied in the platform_device */
-static struct davinci_i2c_platform_data davinci_i2c_platform_data_default = {
-	.bus_freq	= 100,
-	.bus_delay	= 0,
+	/* standard bus frequency (kHz) */
+	unsigned int		bus_freq;
+	/* Chip has a ICPFUNC register */
+	bool			has_pfunc;
 };
 
 static inline void davinci_i2c_write_reg(struct davinci_i2c_dev *i2c_dev,
@@ -168,7 +166,6 @@ static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_dev,
 
 static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->pdata;
 	u16 psc;
 	u32 clk;
 	u32 d;
@@ -212,16 +209,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (of_node && of_device_is_compatible(of_node, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000));
+	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > pdata->bus_freq * 1000)
+	if (input_clock / (psc + 1) / clk > dev->bus_freq * 1000)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
 	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
 	 * to LOW ratio as 1 to 2 is more safe.
 	 */
-	if (pdata->bus_freq > 100)
+	if (dev->bus_freq > 100)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
@@ -255,8 +252,6 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
  */
 static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->pdata;
-
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(dev, 0);
 
@@ -274,8 +269,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq = %dkHz, bus_delay = %d\n",
-		pdata->bus_freq, pdata->bus_delay);
+	dev_dbg(dev->dev, "bus_freq = %dkHz\n", dev->bus_freq);
 
 
 	/* Take the I2C module out of reset: */
@@ -309,12 +303,6 @@ static void davinci_i2c_unprepare_recovery(struct i2c_adapter *adap)
 	i2c_davinci_init(dev);
 }
 
-static struct i2c_bus_recovery_info davinci_i2c_gpio_recovery_info = {
-	.recover_bus = i2c_generic_scl_recovery,
-	.prepare_recovery = davinci_i2c_prepare_recovery,
-	.unprepare_recovery = davinci_i2c_unprepare_recovery,
-};
-
 static void davinci_i2c_set_scl(struct i2c_adapter *adap, int val)
 {
 	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
@@ -414,7 +402,6 @@ static int
 i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 {
 	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
-	struct davinci_i2c_platform_data *pdata = dev->pdata;
 	u32 flag;
 	u16 w;
 	unsigned long time_left;
@@ -424,10 +411,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		return -EADDRNOTAVAIL;
 	}
 
-	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
-	if (pdata->bus_delay)
-		udelay(pdata->bus_delay);
-
 	/* set the target address */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
 
@@ -758,8 +741,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct i2c_bus_recovery_info *rinfo;
 	int r, irq;
+	u32 prop;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -773,29 +756,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
-	dev->pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, dev);
 
-	if (!dev->pdata && pdev->dev.of_node) {
-		u32 prop;
+	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
+	if (r)
+		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
 
-		dev->pdata = devm_kzalloc(&pdev->dev,
-			sizeof(struct davinci_i2c_platform_data), GFP_KERNEL);
-		if (!dev->pdata)
-			return -ENOMEM;
+	dev->bus_freq = prop / 1000;
 
-		memcpy(dev->pdata, &davinci_i2c_platform_data_default,
-			sizeof(struct davinci_i2c_platform_data));
-		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-			&prop))
-			dev->pdata->bus_freq = prop / 1000;
-
-		dev->pdata->has_pfunc =
-			of_property_read_bool(pdev->dev.of_node,
-					      "ti,has-pfunc");
-	} else if (!dev->pdata) {
-		dev->pdata = &davinci_i2c_platform_data_default;
-	}
+	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
@@ -843,23 +812,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = pdev->dev.of_node;
 
-	if (dev->pdata->has_pfunc)
+	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;
-	else if (dev->pdata->gpio_recovery) {
-		rinfo =  &davinci_i2c_gpio_recovery_info;
-		adap->bus_recovery_info = rinfo;
-		rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl",
-						  GPIOD_OUT_HIGH_OPEN_DRAIN);
-		if (IS_ERR(rinfo->scl_gpiod)) {
-			r = PTR_ERR(rinfo->scl_gpiod);
-			goto err_unuse_clocks;
-		}
-		rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
-		if (IS_ERR(rinfo->sda_gpiod)) {
-			r = PTR_ERR(rinfo->sda_gpiod);
-			goto err_unuse_clocks;
-		}
-	}
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
diff --git a/include/linux/platform_data/i2c-davinci.h b/include/linux/platform_data/i2c-davinci.h
deleted file mode 100644
index 98967df07468..000000000000
--- a/include/linux/platform_data/i2c-davinci.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * DaVinci I2C controller platform_device info
- *
- * Author: Vladimir Barinov, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
-*/
-
-#ifndef __ASM_ARCH_I2C_H
-#define __ASM_ARCH_I2C_H
-
-/* All frequencies are expressed in kHz */
-struct davinci_i2c_platform_data {
-	unsigned int	bus_freq;	/* standard bus frequency (kHz) */
-	unsigned int	bus_delay;	/* post-transaction delay (usec) */
-	bool		gpio_recovery;	/* Use GPIO recovery method */
-	bool		has_pfunc;	/* Chip has a ICPFUNC register */
-};
-
-/* for board setup code */
-void davinci_init_i2c(struct davinci_i2c_platform_data *);
-
-#endif /* __ASM_ARCH_I2C_H */
-- 
2.45.2


