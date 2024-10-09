Return-Path: <linux-kernel+bounces-357476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB179971B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BB31F2A449
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D781E0DA8;
	Wed,  9 Oct 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UKKOTqgW"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAD1DFE0C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491359; cv=none; b=ppwOvuISg/g6NuneAXGmINefPpmkRMmfs2OxGNyqduL7WwbY7yM/6zsQClhgI7lzB8fjUYQvUpRmIDJ6wtgKIF7cCZHVPSFTByoNSX1V4QRpfmK8lrEHlGDq/OLGjDpMzGOK+aQbtB/Ocjf8zx3k8eC8/1TajZiTPXj6N/cYJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491359; c=relaxed/simple;
	bh=PDjCtEd65pLvqJqA4DGmEYQMfK1MTSAAaUijFern5sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7HeVMU1uWpwQbWvuy0drkXi97t2icTMiwgfZXpnzdAnGBRzEgW7VIPwendKWMTwCor2Gc4BCZ2SSfnQgxu58NN8WNCnWevkWAGiVYqzvjxQrM0xUAJWoy+BLd1FANkNe5mUIkYb9zNwcMN4li6GFTDyhmr0u+sdWpANQ3ATz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UKKOTqgW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431126967d6so7340335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728491354; x=1729096154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PaDjPkWaQG2wts5WRsXEAPUVwmnnHMybRjZYeJvsAEU=;
        b=UKKOTqgWbPmHsUB5r4mLnSsb7OOT6Oj2YxZa4kCAIA80REryytr3Ca+HqQk/DilXBR
         SbaounxR+gZqWLsi+nTQ8Jeb/ySsBRyWmLoTE+VNO/HLPhZvRvNTuEP0ge8w+VkDdOyH
         yKYriO049YqEQX4Olls83KohZZCEPWBAZ+tfqSOK5Spxgi/bPcm+VR9HISHoFlGJk/K5
         Hn3PDsYnJmdOUlkbXVihvfQysxZoBhTO4gc1mx1t5YwUEC1JG5N6rm01NOiEnKsSLU8k
         N98D+KgWg9fBEIVYjnncpHwZNix0FyA6rIXwt5yOnKeGtGd+jIe0s4NtuLL2Ionv4k2O
         dR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491354; x=1729096154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaDjPkWaQG2wts5WRsXEAPUVwmnnHMybRjZYeJvsAEU=;
        b=YUnzoVo0/sMdkXd+OUNolVTb3k5owqVMdMOmCOf9Ga2uu7DyvkGD6Ef9m7ysvYUX3K
         Y7QFonYCz+chrYrwVNIs1EIspr+J/El9WyXYJcjBLpYhhJtsYL0ExWjpABWmjTl1GFiC
         c4xCeL5XpN4To+lGJb8wnMNad6JPrP0kyUWkk2y+fUuDtjejxK3f+FkvDFG2mHHl3diI
         PvLBqtPh3WnydNiXiBN8It3t12lmWQxNGR0cVZOOsS5v/ieDp+zcG7MQTRBicdhJ/O+s
         feXTtAQWMBy1u0B1u500+jImq5AFzhaEwUkhYWcMWYmZcgInL7mRjaL0zDCnCo4XQWFM
         23QA==
X-Forwarded-Encrypted: i=1; AJvYcCU33vlJMj8s24Keg4tnHdCjO02qFfgCsPMRdcd37GFIjx1rwxruDim9V7tlfPosQAY1TbcOsVdu+GeG74A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/GahtjQiTC9hzcH9scdL3jOsUzTkliU1XzYLvKbMNn3h08UB
	IS6SDZtdk9ESyVrJzIXQnjb2bg4Qcnz2dOHdWgzJveXhdK7Y2BAWKkw5NoXoVQVwJBrM5xt/ffA
	H
X-Google-Smtp-Source: AGHT+IHOGSipqL/icOQsUozWU890KNhChVKqtfE51nl9eohpRfGEfBJrVYHA7bBsj+DgXJEf2+KSYA==
X-Received: by 2002:a05:600c:1ca7:b0:42c:be90:fa2f with SMTP id 5b1f17b1804b1-430d5aad152mr27110105e9.25.1728491354171;
        Wed, 09 Oct 2024 09:29:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ff96:3068:2ae4:3fe0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf45df4sm24795475e9.13.2024.10.09.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:29:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: mpc8xxx: use a helper variable to store the address of pdev->dev
Date: Wed,  9 Oct 2024 18:29:09 +0200
Message-ID: <20241009162910.33477-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Instead of repeatedly dereferencing pdev, just store the address of the
embedded struct device in a local variable and use it instead for
improved readability.

While at it: rearrange variable declarations.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mpc8xxx.c | 46 +++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 685ec31db409..30f36f94ba1b 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -300,14 +300,15 @@ static const struct of_device_id mpc8xxx_gpio_ids[] = {
 
 static int mpc8xxx_probe(struct platform_device *pdev)
 {
+	const struct mpc8xxx_gpio_devtype *devtype = NULL;
 	struct device_node *np = pdev->dev.of_node;
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
-	struct gpio_chip	*gc;
-	const struct mpc8xxx_gpio_devtype *devtype = NULL;
+	struct device *dev = &pdev->dev;
 	struct fwnode_handle *fwnode;
+	struct gpio_chip *gc;
 	int ret;
 
-	mpc8xxx_gc = devm_kzalloc(&pdev->dev, sizeof(*mpc8xxx_gc), GFP_KERNEL);
+	mpc8xxx_gc = devm_kzalloc(dev, sizeof(*mpc8xxx_gc), GFP_KERNEL);
 	if (!mpc8xxx_gc)
 		return -ENOMEM;
 
@@ -320,32 +321,28 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 		return PTR_ERR(mpc8xxx_gc->regs);
 
 	gc = &mpc8xxx_gc->gc;
-	gc->parent = &pdev->dev;
+	gc->parent = dev;
 
-	if (device_property_read_bool(&pdev->dev, "little-endian")) {
-		ret = bgpio_init(gc, &pdev->dev, 4,
-				 mpc8xxx_gc->regs + GPIO_DAT,
-				 NULL, NULL,
-				 mpc8xxx_gc->regs + GPIO_DIR, NULL,
-				 BGPIOF_BIG_ENDIAN);
+	if (device_property_read_bool(dev, "little-endian")) {
+		ret = bgpio_init(gc, dev, 4, mpc8xxx_gc->regs + GPIO_DAT,
+				 NULL, NULL, mpc8xxx_gc->regs + GPIO_DIR,
+				 NULL, BGPIOF_BIG_ENDIAN);
 		if (ret)
 			return ret;
-		dev_dbg(&pdev->dev, "GPIO registers are LITTLE endian\n");
+		dev_dbg(dev, "GPIO registers are LITTLE endian\n");
 	} else {
-		ret = bgpio_init(gc, &pdev->dev, 4,
-				 mpc8xxx_gc->regs + GPIO_DAT,
-				 NULL, NULL,
-				 mpc8xxx_gc->regs + GPIO_DIR, NULL,
-				 BGPIOF_BIG_ENDIAN
+		ret = bgpio_init(gc, dev, 4, mpc8xxx_gc->regs + GPIO_DAT,
+				 NULL, NULL, mpc8xxx_gc->regs + GPIO_DIR,
+				 NULL, BGPIOF_BIG_ENDIAN
 				 | BGPIOF_BIG_ENDIAN_BYTE_ORDER);
 		if (ret)
 			return ret;
-		dev_dbg(&pdev->dev, "GPIO registers are BIG endian\n");
+		dev_dbg(dev, "GPIO registers are BIG endian\n");
 	}
 
 	mpc8xxx_gc->direction_output = gc->direction_output;
 
-	devtype = device_get_match_data(&pdev->dev);
+	devtype = device_get_match_data(dev);
 	if (!devtype)
 		devtype = &mpc8xxx_gpio_devtype_default;
 
@@ -370,7 +367,7 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	 * associated input enable must be set (GPIOxGPIE[IEn]=1) to propagate
 	 * the port value to the GPIO Data Register.
 	 */
-	fwnode = dev_fwnode(&pdev->dev);
+	fwnode = dev_fwnode(dev);
 	if (of_device_is_compatible(np, "fsl,qoriq-gpio") ||
 	    of_device_is_compatible(np, "fsl,ls1028a-gpio") ||
 	    of_device_is_compatible(np, "fsl,ls1088a-gpio") ||
@@ -381,9 +378,9 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 			gc->read_reg(mpc8xxx_gc->regs + GPIO_DIR);
 	}
 
-	ret = devm_gpiochip_add_data(&pdev->dev, gc, mpc8xxx_gc);
+	ret = devm_gpiochip_add_data(dev, gc, mpc8xxx_gc);
 	if (ret) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"GPIO chip registration failed with status %d\n", ret);
 		return ret;
 	}
@@ -404,18 +401,17 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	gc->write_reg(mpc8xxx_gc->regs + GPIO_IER, 0xffffffff);
 	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR, 0);
 
-	ret = devm_request_irq(&pdev->dev, mpc8xxx_gc->irqn,
+	ret = devm_request_irq(dev, mpc8xxx_gc->irqn,
 			       mpc8xxx_gpio_irq_cascade,
 			       IRQF_NO_THREAD | IRQF_SHARED, "gpio-cascade",
 			       mpc8xxx_gc);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to devm_request_irq(%d), ret = %d\n",
+		dev_err(dev, "failed to devm_request_irq(%d), ret = %d\n",
 			mpc8xxx_gc->irqn, ret);
 		goto err;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
+	device_init_wakeup(dev, true);
 
 	return 0;
 err:
-- 
2.43.0


