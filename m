Return-Path: <linux-kernel+bounces-440106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCF9EB8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C172281BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7251D8E09;
	Tue, 10 Dec 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ipkg0sXi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD086329
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853450; cv=none; b=TTOuZ1rTxVcSvT91MjOWp6y2LyjxM2EEIK7WexRtBSB2SPAIg9QbPxLbiDMBqdPwmIMLzBynkZKDxvdPth9LxhIGxtEUzXRfTmetB/RhY1bQU++2S17UGW3hm+Fnp9p9D0/HWAQOZDYgvtEwSF2W06S4ACXSKv6ZSJC5hUI30EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853450; c=relaxed/simple;
	bh=q7850sFx0AojKZfepV5IKTTvsWmrtq2q5B1CbYiisnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3G2xHg0ypawiriCmK1JH5vOGmmc6jcNc9E9mEh9BIAFL2H87BklG/zQZ0yzJBxAihdRhGHs+EP3ohMLeCeUfokuFLjehq9EEc7rXregIiDKANtkZgd+EvQTf/QoO1445PHnfOxCp+YcBfMPIxdMFtY8nU8kxiWhhGxMVZRswBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ipkg0sXi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43540bdb448so6802685e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733853446; x=1734458246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIHjMml9/i3NudYkhW0WMl6STQ3T0Tp/kjGEjO9vq9I=;
        b=ipkg0sXisKqWZnf4saPIOz24hfVn8PODk8HtfUwqO1CFOV8mViIDAIA8K/Tv3y7SNd
         R+MiHhGxneCcMNAoC/f0iTskevz4G2EOSIvXxr0zlwqp6njNG3PwGD62a6B8A/b2i7y1
         xRtRF5Hg/1ytDUJ0/mScOhN59vbtrVgQIvbC3yuc3n92pdCSUOIl8NSDYGmrF+Bu83SX
         YCMEvqMHA1jCG56HAweXCW1pBJ2UQOLm6M8VgjYFu0OFaKX440qSobWM7QJYjSkkQyIK
         7gXZBkbK8PNigIpL6BpTG6tz25vX/Okg0O9dlp4HHtM4AtwgpOay+mfEQrDm9VHJr7Ze
         GLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853446; x=1734458246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIHjMml9/i3NudYkhW0WMl6STQ3T0Tp/kjGEjO9vq9I=;
        b=ubSwyLmaZca8OtqUoNKrFTawrESqKwiYOarr+zXmNzBP+sf2z/oGxZcu5NAJk/cBIb
         Mxam6xERFPhpKAqQ1WS4wBC29yoNVHKj8ZL6vOjdNFtW47qD7njoeXhm59+ZqqmOvkHw
         znSc2HpQZh2NcMEmbZW8gtc5gnAeqQSTgR8IQJSDkixDA95eMMa6DNyfi9tGvW7rovLd
         I2ITkuqfF8yf7HiS8qY58nBWjfrgCKWRwpZI+g8izADIVGhi1X+ZOJJ4Ty2gek/2OjLa
         GvV8QlD2MeDD5k0zALEbozVxLw2URXsff8KmS8Jfw5vqqWbQbSg3WID312e6Xm5iTWuJ
         MqEQ==
X-Gm-Message-State: AOJu0Yxjso/6zlNskXMVdg0dwtPK0duUb05UAbd9naLB02bAuwGFvgoZ
	3Nn+Has9TWdlqRawZJDqbnfPIDMuzEkpghO/AevTp8UqxUrN++BTE8bIZfuHFvU=
X-Gm-Gg: ASbGnctBJOXG1CbXRk6+sjIEwTtxdSrlx/dAuqzgMKbLRWFBCnfGejh5CYyNIuJNF0h
	Mtkeb32GzX2yaJHM1KP7IrU1fDFCjYJHKM96FYUCX8ZUtjjHQlAEvX5dkM02Spdb0AqX8mYjDwC
	pTNSmf2WPQbSBX3wpFX5xPxgonAJLIbUQpQ2yA10mjsE+PgNmTfIb9wYRgzQEJ5Rm6v5Xil/xhn
	jGdwVbG9qtZkvOzGL/bQRY26x3QUso71QNJZGC7J82iC3wpUBO4Ng==
X-Google-Smtp-Source: AGHT+IHj8QobrzmEZEduyaYU3tAx4inoHt1dQaLHSZB+Hbt42qCHjutA5qEL9cLT3MYUv5BvjiY0cA==
X-Received: by 2002:a05:600c:5104:b0:434:a7b6:10e9 with SMTP id 5b1f17b1804b1-434fff55649mr53795855e9.17.1733853445973;
        Tue, 10 Dec 2024 09:57:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:4c2b:c454:658c:f771])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526ac03sm241103195e9.4.2024.12.10.09.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:57:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] clk: davinci: remove platform data struct
Date: Tue, 10 Dec 2024 18:57:23 +0100
Message-ID: <20241210175723.127594-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no board files using struct davinci_pll_platform_data anymore.
The structure itself is currently used to store a single pointer. Let's
remove the struct definition, the header and rework the driver to not
require the syscon regmap to be stored in probe().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/clk/davinci/pll.c                     | 33 +++----------------
 include/linux/platform_data/clk-davinci-pll.h | 21 ------------
 2 files changed, 4 insertions(+), 50 deletions(-)
 delete mode 100644 include/linux/platform_data/clk-davinci-pll.h

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 5bbbb3a66477..b284da602f8d 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
-#include <linux/platform_data/clk-davinci-pll.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -840,27 +839,6 @@ int of_davinci_pll_init(struct device *dev, struct device_node *node,
 	return 0;
 }
 
-static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct device *dev)
-{
-	struct davinci_pll_platform_data *pdata = dev_get_platdata(dev);
-
-	/*
-	 * Platform data is optional, so allocate a new struct if one was not
-	 * provided. For device tree, this will always be the case.
-	 */
-	if (!pdata)
-		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return NULL;
-
-	/* for device tree, we need to fill in the struct */
-	if (dev->of_node)
-		pdata->cfgchip =
-			syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
-
-	return pdata;
-}
-
 /* needed in early boot for clocksource/clockevent */
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 CLK_OF_DECLARE(da850_pll0, "ti,da850-pll0", of_da850_pll0_init);
@@ -890,8 +868,8 @@ typedef int (*davinci_pll_init)(struct device *dev, void __iomem *base,
 static int davinci_pll_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct davinci_pll_platform_data *pdata;
 	davinci_pll_init pll_init = NULL;
+	struct regmap *cfgchip;
 	void __iomem *base;
 
 	pll_init = device_get_match_data(dev);
@@ -903,17 +881,14 @@ static int davinci_pll_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pdata = davinci_pll_get_pdata(dev);
-	if (!pdata) {
-		dev_err(dev, "missing platform data\n");
-		return -EINVAL;
-	}
+	if (dev->of_node)
+		cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return pll_init(dev, base, pdata->cfgchip);
+	return pll_init(dev, base, cfgchip);
 }
 
 static struct platform_driver davinci_pll_driver = {
diff --git a/include/linux/platform_data/clk-davinci-pll.h b/include/linux/platform_data/clk-davinci-pll.h
deleted file mode 100644
index e55dab1d578b..000000000000
--- a/include/linux/platform_data/clk-davinci-pll.h
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PLL clock driver for TI Davinci SoCs
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#ifndef __LINUX_PLATFORM_DATA_CLK_DAVINCI_PLL_H__
-#define __LINUX_PLATFORM_DATA_CLK_DAVINCI_PLL_H__
-
-#include <linux/regmap.h>
-
-/**
- * davinci_pll_platform_data
- * @cfgchip: CFGCHIP syscon regmap
- */
-struct davinci_pll_platform_data {
-	struct regmap *cfgchip;
-};
-
-#endif /* __LINUX_PLATFORM_DATA_CLK_DAVINCI_PLL_H__ */
-- 
2.45.2


