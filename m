Return-Path: <linux-kernel+bounces-301242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F282995EE23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C29D28625B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13002155736;
	Mon, 26 Aug 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnsZYYY/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D360154BE0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666869; cv=none; b=i80yG1cDAEr8/C3iZH3pRmC5g/EasIydI9kC4CUwxShsN7RyEGRyP9YP3O28m5bFdfo43W6uf9PgMmHtHSn8UkdfeRa/xYU0pr/zACDHznMJ/hdArosSVUwhEJMUGM1ccLbXnonU8fvrRYNvYPQcJjf1AnxZf5fK8fCfhhfH+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666869; c=relaxed/simple;
	bh=wdcz8XiBcDZ4nb0AOyZykqRBbhQuQooZzPq8xpdRV9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZ4hy2cXQQeA00XKJjVZWNtDNR3R8l+Nat8JwtOHSZHNNnYoFbbziJKERU89JEnEjgZ9+d3b+fcl6Wya3sVpeL4PufZHyfoUFgJo5c/kXii4AII4uJeD3lOpNGXMvx47f9nhMZsmyyNsYw+uPHb/x41zIrixQtdwc8YgTfRbc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnsZYYY/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42808a69a93so6291135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724666866; x=1725271666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBeiEf9X8N6xSFq/Sd6Q+1/33k4A8r9mRuaNtrYrkSQ=;
        b=WnsZYYY/Nt1ml2E2u62yGJcakbuNjyJiyvDk82hwyu/66Eimg/X9tbI+iDqeh9YEM8
         yI5/N7vfKgha+Y07qcV5zzP/YMEEl5Q+VIydiOkAzmvunxyEXC0H6MTUQ3fQKOZm/r+h
         THlCMMs838Et0rocLuBXiyuGeawxQY/8dZ4NWXiIcXWkE+eE53XN6l1rHOfoCfcgd1sm
         zPZoSohd3vgvfcifL40JlOa8hLUCvfC52D1OD8JlXiHhDxl3T8hx8P2KiGVWh3wtoHPh
         I1XT3o5tCJ4JhjQmev8YBYwUyjKeSVmaRU82u2ufu3rzcehRozVzOZPtSLOPxbmevZcQ
         A8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666866; x=1725271666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBeiEf9X8N6xSFq/Sd6Q+1/33k4A8r9mRuaNtrYrkSQ=;
        b=u2a+VqCHXeiRGVude006Du3ASuIRqXU2CVEuoetGaRYxTlO98yUrMA1gwB/CC/ll1B
         3vCy2xNqzSYTBQHaSQXuC/Yx0C2F98XaKmJanwklt4HCO89OrOrMqxjuCKCk49NwLEb5
         qYaQdMDtEvlIfC56ytrlNvr9I7hltmyssZaHNq5C/MZpWxhD5LqtsZEzaAb0knPbkn9V
         DvANdAK9n0ybGCXuwQhxu24N0L3k+J7GLi/dfL12IiBoSDkgGkOyZmcKtY+zxb0Qk2Lf
         b0Y9rFrYShhEJITlztronaQunCBQvO7bJTJjU4TgB69vcAk6bbX1m5gwmlNDRNQZL8DM
         pH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgyHVEJJw2IDnngRSYsiRWWDkm+tO3D4i+JLwogg+KgAGiW0oyxM6ttWZgQKg1j0LMVjk64iG/ewoqnjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJg556lzJedooXR70q4QLoLEC2MiNNclyawupXIfR4r3fgbTu
	A+kmam26lP6TOLB2ZgDVccZ/gdS8H78nf5DRwakJJbAYkmYSpaIlz+HnZf1V7Wg=
X-Google-Smtp-Source: AGHT+IGok8paLmSnpgAD267hn+gsKafIUp4M7EbxL8F3BzEx2cfwlqJfUxJ4Ip76g3TR7Pw0QL7lUQ==
X-Received: by 2002:a05:6000:178a:b0:368:4c5:1b5a with SMTP id ffacd0b85a97d-373118e9be9mr3513537f8f.9.1724666865829;
        Mon, 26 Aug 2024 03:07:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110009sm10324821f8f.18.2024.08.26.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:07:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 Aug 2024 12:07:25 +0200
Subject: [PATCH 09/11] phy: ti: gmii-sel: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-phy-of-node-scope-v1-9-5b4d82582644@linaro.org>
References: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
In-Reply-To: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wdcz8XiBcDZ4nb0AOyZykqRBbhQuQooZzPq8xpdRV9Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzFPg7XFF/j171N1twJsIMBg7OuBUTIrml6/H3
 z9mJ585yGaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsxT4AAKCRDBN2bmhouD
 15gsD/9NG7meHEPdkGDSA1PRkg5U5KXHnzxvUKotKxcO1clvqIkAji/rh3oNkqiVL+FPmrussrg
 hDEha6daxxni20jY+Ps+KDwx8AEJx/V43b0u9zIz8mznDtIJP+QV+w65ItVJMER4EL4qFrrvNoa
 84PAeHCNHzZ+yLYNMU5OHdd34ujA4aj3PG1RmhcTGHROblTW5Yo0X0FN5K2CUyqsQTWmOCftmC7
 na/onL30T6APTuiL8MM7nxnifJQiejwoEAMCmuMShcfMxb2TSizTQDE2ngzW7k+rEaYYmvxTliS
 6BjwvzLXMtXfGYPkqEo0sBTfKvF7BTjGkNO+bSqwqwCzgOFCUnw9amfi9dPWX3UnNeShsLOHEcg
 sehqouSfwTMyQlfK76x8h8hFGbP40KlZv2HZbHnEoXKZQ/qU6KCcHaHIoOzA5FMDpZ68Zjotu2W
 LTAeT5wfYwqcq0V+eOWZ2mERiuw5ZQfK7eqE5m4pb5Zqgnker6X9zm/EPSrE4Ai7O5VgE6jz8hs
 zYAfE7cvePsM2H0lwtG6C2nwx042tFYgGfFNNXp2ElpjYOLV1LXedhq1TruxTPXlOs/uEYVsp8L
 cD1t44/kop1FGB241wS/jpWalj3dDyx7/aXSoWpydH0n5RKrHxtztgp0t7fp3xgqmOhC+4234Lf
 /t4rWoyAgjN2j9Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to avoid dmesg flood on actual defer.  This makes
the code also simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index b30bf740e2e0..103b266fec77 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -468,11 +468,9 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	priv->regmap = syscon_node_to_regmap(node->parent);
 	if (IS_ERR(priv->regmap)) {
 		priv->regmap = device_node_to_regmap(node);
-		if (IS_ERR(priv->regmap)) {
-			ret = PTR_ERR(priv->regmap);
-			dev_err(dev, "Failed to get syscon %d\n", ret);
-			return ret;
-		}
+		if (IS_ERR(priv->regmap))
+			return dev_err_probe(dev, PTR_ERR(priv->regmap),
+					     "Failed to get syscon\n");
 		priv->no_offset = true;
 	}
 
@@ -485,11 +483,9 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	priv->phy_provider =
 		devm_of_phy_provider_register(dev,
 					      phy_gmii_sel_of_xlate);
-	if (IS_ERR(priv->phy_provider)) {
-		ret = PTR_ERR(priv->phy_provider);
-		dev_err(dev, "Failed to create phy provider %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->phy_provider))
+		return dev_err_probe(dev, PTR_ERR(priv->phy_provider),
+				     "Failed to create phy provider\n");
 
 	return 0;
 }

-- 
2.43.0


