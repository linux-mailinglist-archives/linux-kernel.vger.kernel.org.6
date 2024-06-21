Return-Path: <linux-kernel+bounces-224507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFB91234A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B891F23843
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D759175552;
	Fri, 21 Jun 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BfiRKsZ7"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66717334D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969001; cv=none; b=ie5EJDSj8DCoEa0n75HFXuXeITY3OWP2Hk2Hpg2qlWwl++DWB4Oy51xVFahnJ8p7bMqJQAK4MCq0mEu3YTa3v0Px4RWvIaG5xS2ZobbSbYbgHznNnchJ6g43KaAs4/q6mr0BlUkeY9l1ETgkxX+PRPJcb92xlZ9wqcZ6kRUCAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969001; c=relaxed/simple;
	bh=EXsxLarD5ClXmWdFfNRjLR3Hci/j/5hO4n+XcVx0/wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4Kr/49PF1i8mhMEPL+PRDlaPENkhpKLuCYAZZ5xb5ElVB3cAL8Pj7GgNBfgACf7XFDFSm/DaTX+4ObnxhAsxrixnuJh1QzyUi7BFg53oAR9z89Ecr3TTUnyzyG2uNWknX7k/dAjhgpzKGFHGEAxyfJvUsD6ZZ8ZVY7GccHturg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BfiRKsZ7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f09eaf420so213664966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718968998; x=1719573798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3H2/xCH1KL76lyoZfUUQjrHXfexHfpjVXcG8XkXUMg=;
        b=BfiRKsZ7646iBbo5YNk1ABykSnJESmMWEvX9syDp2CtaoO6B12SxngOJQirCqrDepX
         nDwSsUv4sQcwdhKMT+PkQPWBo6M2fC9pQrH2HNxuxv6V7bX1aD2y5a235dTAD9nGmP6G
         VBv8bS9LjruW/or+/tgM/ncJie6Bm/M8JbvKHJF4EoIAKd+bHmvxxd53yJob0HwLjFJ+
         xRPQe37aUSGGOd/SQlEWEAr9wKqH01BDc5q6ni5Cl6Q5IEa7Apmn77elNYwengeH+F8v
         OvFbYf5xwl8JA0Ht3jpdF4wmmgA9oKCtfLcVtdU9tltJ0toSAOttYUrC8zzEtJF4Nx3S
         R3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968998; x=1719573798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3H2/xCH1KL76lyoZfUUQjrHXfexHfpjVXcG8XkXUMg=;
        b=hDO6nMePJg1Lu/jEtw5gOVNZZp48HIc2A0c6w57KZ2Q2XkgaeujMSboN0NHu1FPCE0
         LpnpSHN2ZYnaNQ19wKlFDpFMcE6tRivJ/PuohY0l69tfcTlO5r0gRh2G8K8XL0BF7HjK
         wr0lvGMGgRZF5a09/sLOz9Rv3SGFyQjLkxWGXgiEIQJwT7HJwP5F4piiBehYvDhLzKb7
         79eEQ1hFCkziXZ58T+JmumhNHPx4fdstlAw/y7ExAci15Syv+vudeVIcS2Et2pou7239
         uIKCxBynP7EqRwurBBOHyu3/m5gvPV0UtBJuV2MCx3tG5VwnCnjJGlwrSuKw9NEFpeNl
         PNiA==
X-Forwarded-Encrypted: i=1; AJvYcCXi5YiL5ss3gXYGEGI4n1N1KNcic9a6mfJPnOACoLj/6fGQBkbVmuluZ9e9YgLkExqKYe/OySUvRu/UlR09Kg84oR9av/QIuaB3cVJO
X-Gm-Message-State: AOJu0YyMufuLsJEIs0svmskkQXE7ZPSaEyR1RadgCptNuKH2XCeMsLh5
	s9NcIYPTmvroJSsijpuW6IInZE344PCJdvt1HM08JW4e96LLh4zFAsNKzuODvEM=
X-Google-Smtp-Source: AGHT+IHNpJHjpYpjeVnsPvIvzyTvzFCXudzr8z4xB/fYWqy08HAHxV8RgGkWHWAPI9itD5sx9QL7iA==
X-Received: by 2002:a17:907:a802:b0:a6f:bae8:f84a with SMTP id a640c23a62f3a-a6fbae8f920mr456177666b.20.1718968997999;
        Fri, 21 Jun 2024 04:23:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fd0838345sm64498466b.99.2024.06.21.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:23:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 02/12] i2c: riic: Use temporary variable for struct device
Date: Fri, 21 Jun 2024 14:22:53 +0300
Message-Id: <20240621112303.1607621-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112303.1607621-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240621112303.1607621-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use a temporary variable for the struct device pointers to avoid
dereferencing.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 53 ++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index f608b1838cad..c08c988f50c7 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -131,11 +131,12 @@ static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 set, u
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct riic_dev *riic = i2c_get_adapdata(adap);
+	struct device *dev = adap->dev.parent;
 	unsigned long time_left;
 	int i;
 	u8 start_bit;
 
-	pm_runtime_get_sync(adap->dev.parent);
+	pm_runtime_get_sync(dev);
 
 	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
 		riic->err = -EBUSY;
@@ -168,7 +169,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
  out:
-	pm_runtime_put(adap->dev.parent);
+	pm_runtime_put(dev);
 
 	return riic->err ?: num;
 }
@@ -303,11 +304,12 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	int ret = 0;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
+	struct device *dev = riic->adapter.dev.parent;
 
-	pm_runtime_get_sync(riic->adapter.dev.parent);
+	pm_runtime_get_sync(dev);
 
 	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
-		dev_err(&riic->adapter.dev,
+		dev_err(dev,
 			"unsupported bus speed (%dHz). %d max\n",
 			t->bus_freq_hz, I2C_MAX_FAST_MODE_FREQ);
 		ret = -EINVAL;
@@ -347,7 +349,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	}
 
 	if (brl > (0x1F + 3)) {
-		dev_err(&riic->adapter.dev, "invalid speed (%lu). Too slow.\n",
+		dev_err(dev, "invalid speed (%lu). Too slow.\n",
 			(unsigned long)t->bus_freq_hz);
 		ret = -EINVAL;
 		goto out;
@@ -396,7 +398,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
 out:
-	pm_runtime_put(riic->adapter.dev.parent);
+	pm_runtime_put(dev);
 	return ret;
 }
 
@@ -415,13 +417,14 @@ static void riic_reset_control_assert(void *data)
 
 static int riic_i2c_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct riic_dev *riic;
 	struct i2c_adapter *adap;
 	struct i2c_timings i2c_t;
 	struct reset_control *rstc;
 	int i, ret;
 
-	riic = devm_kzalloc(&pdev->dev, sizeof(*riic), GFP_KERNEL);
+	riic = devm_kzalloc(dev, sizeof(*riic), GFP_KERNEL);
 	if (!riic)
 		return -ENOMEM;
 
@@ -429,22 +432,22 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(riic->base))
 		return PTR_ERR(riic->base);
 
-	riic->clk = devm_clk_get(&pdev->dev, NULL);
+	riic->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(riic->clk)) {
-		dev_err(&pdev->dev, "missing controller clock");
+		dev_err(dev, "missing controller clock");
 		return PTR_ERR(riic->clk);
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(rstc))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
+		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Error: missing reset ctrl\n");
 
 	ret = reset_control_deassert(rstc);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&pdev->dev, riic_reset_control_assert, rstc);
+	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, rstc);
 	if (ret)
 		return ret;
 
@@ -453,29 +456,29 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		ret = devm_request_irq(&pdev->dev, ret, riic_irqs[i].isr,
+		ret = devm_request_irq(dev, ret, riic_irqs[i].isr,
 				       0, riic_irqs[i].name, riic);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request irq %s\n", riic_irqs[i].name);
+			dev_err(dev, "failed to request irq %s\n", riic_irqs[i].name);
 			return ret;
 		}
 	}
 
-	riic->info = of_device_get_match_data(&pdev->dev);
+	riic->info = of_device_get_match_data(dev);
 
 	adap = &riic->adapter;
 	i2c_set_adapdata(adap, riic);
 	strscpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->algo = &riic_algo;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->dev.parent = dev;
+	adap->dev.of_node = dev->of_node;
 
 	init_completion(&riic->msg_done);
 
-	i2c_parse_fw_timings(&pdev->dev, &i2c_t, true);
+	i2c_parse_fw_timings(dev, &i2c_t, true);
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = riic_init_hw(riic, &i2c_t);
 	if (ret)
@@ -487,24 +490,24 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, riic);
 
-	dev_info(&pdev->dev, "registered with %dHz bus speed\n",
-		 i2c_t.bus_freq_hz);
+	dev_info(dev, "registered with %dHz bus speed\n", i2c_t.bus_freq_hz);
 	return 0;
 
 out:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
 static void riic_i2c_remove(struct platform_device *pdev)
 {
 	struct riic_dev *riic = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 	riic_writeb(riic, 0, RIIC_ICIER);
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 	i2c_del_adapter(&riic->adapter);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 }
 
 static const struct riic_of_data riic_rz_a_info = {
-- 
2.39.2


