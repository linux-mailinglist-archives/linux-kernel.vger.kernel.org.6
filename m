Return-Path: <linux-kernel+bounces-449705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1879F550E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C6B16EF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6371FC7F0;
	Tue, 17 Dec 2024 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O3H5Kwqk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D681FC7E2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457320; cv=none; b=Bq+E7ObKFonIAK6NuMrcYbbPVx91hSk7qgWXTIY1eY5WGKeTX+Omtie9qnmAb4WX54ILl6GceUsFA51v1wkKzxpnkbTICuILhle+sYWcIZf1Yz8TUVW0OwvsHe0iq6zk8NepNzfxN/VoG+bklT9YOg6ZqpCKGctsKqpgLc7g5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457320; c=relaxed/simple;
	bh=Dtxyoi7doHBih2RE+tW4O4Zl3p0PlcEyWecU0LpLJks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPpsDKHH1KFw4sxNaBdcfyPolOfNP7uD63hsB3PcnaK5jKeHmCHKbznNtmWBIeGvsDBc1DO/dpYEcFfWLnOr59qSKyiZcNdAFq/U64jSJl1jbLT/9l0UoobuxYqLDIDsnh6kcMXqrnWcDELjWYN+VQYEj3UV4tBUbUSwEid3pQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O3H5Kwqk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283dedso54607445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734457317; x=1735062117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Osl1zSUTzkBPkmQO9nNp4iwBDW/vG7efr1iHu7KFxo=;
        b=O3H5KwqkRAecuiPxNnpxtluowBxy/jpJO5/K7+lWbZNVXkuAwxBriMahN9WMPDTISY
         7VtMnbKftDUC1YLCDcGpNa6D7fOQRgk7z/Ugn1tcqM18KEx9h/k51jXMIQ5/NQEUyBGh
         NB6Vf/YuUwWLizvUXMkTy6YGhfS10xrQtj/DcIrzZrI0TAcQ8RPz6FK1rqIpI83lD5qw
         sWs/EBC5OgRKZu1o2x62YS4fmPU3AZbqyhTxKvp/vpXuXTrJl6wY4PAZ20cmpR8Dm+xb
         0xFrQTSez4z2Vp/SF1QVFfIxwd04UkEAy8tKb9lfVnZmEXJNCIIPj3XvVGKEaYTR3Pl0
         ZXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457317; x=1735062117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Osl1zSUTzkBPkmQO9nNp4iwBDW/vG7efr1iHu7KFxo=;
        b=Q18QGOPPkgLFPoNVX2TKx5PsBBGWi1F8Cx1YmKltUne7es9PVDdE7tgupx81ZSHnZi
         B6lIUco0YQXeqjVzrVLMjS0PZxUYoIj+yRgjjJOpPWboSpSBbjrBukwDbKnOXyAL7IHt
         XP7p7qt3mbzAtfrWzDdHmW6uZJXCXcycjd3MPtGNPgRDQkvrppc5zQlEBnYNSPh7xz7E
         knQxFEv1Zni4BMxhG9Ma/z+vo2Jb8nuENXNZbvsjOP0b0KBs/ejwSUPNzgjXBQmD4AX/
         nedBJzP/yp7m/AbUuvakiutnPd8LAbg3wFxxgrTnAxZxI/xqhWDhE6RuSL70r1ypmJYn
         MUkg==
X-Gm-Message-State: AOJu0YwXSS9UGpc1UjVvsxSXWFm+2Kjdh3i9DLfe8WwQOiZJsIvNJMpV
	o1HxHqzoDDStqA4gw/CW9KtFoXaDNMKCs4zh1tTmkGZrFdppcaNCpePS5QNmuHk=
X-Gm-Gg: ASbGncsPJrRsZJABVr6jBFcW/QBKXlQyvqL2GCxEQ1vVaHQRlbnCsU9Xt7omhv4T1Y/
	5FdzVbD3yjpXD3lU5pWMuv0wNAcK11UWUqnoDR2pX7s7jr+tU4G6uZO1tdLr3wjD07iZfU9ONwc
	A46Qn1r2uhUnKKOcnpFmonYxq0D0o/BXPXt2fmnuHk9kNko+uJoYQrXIknhnl3vIZm11mxctG5m
	hh9kigp8++/eY3j2SkqeCmANt7QiSf3epHZ5PaB1yAN4Hl2QVgFG8w8
X-Google-Smtp-Source: AGHT+IGqntv26z6BFLoPHoUGTbiJyjSJJzeBVoYgwb8TZuHAEKq/qkNzfv4RfYGG8n/kAlz1Ay7MsQ==
X-Received: by 2002:a05:600c:34c2:b0:435:1b:65ee with SMTP id 5b1f17b1804b1-4362aa9dc5dmr142370185e9.24.1734457316712;
        Tue, 17 Dec 2024 09:41:56 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:4699:6189:1775:3ce7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801ac68sm11674749f8f.51.2024.12.17.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:41:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] clk: davinci: remove platform data struct
Date: Tue, 17 Dec 2024 18:41:54 +0100
Message-ID: <20241217174154.84441-1-brgl@bgdev.pl>
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
Changes in v2:
- fix using an uninitialized pointer
- lookup syscon uncoditionally to avoid an OF node check

 drivers/clk/davinci/pll.c                     | 32 ++-----------------
 include/linux/platform_data/clk-davinci-pll.h | 21 ------------
 2 files changed, 3 insertions(+), 50 deletions(-)
 delete mode 100644 include/linux/platform_data/clk-davinci-pll.h

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 5bbbb3a66477..82727b1fc67a 100644
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
@@ -903,17 +881,13 @@ static int davinci_pll_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pdata = davinci_pll_get_pdata(dev);
-	if (!pdata) {
-		dev_err(dev, "missing platform data\n");
-		return -EINVAL;
-	}
+	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
 
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


