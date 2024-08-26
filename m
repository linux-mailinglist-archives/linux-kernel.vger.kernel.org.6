Return-Path: <linux-kernel+bounces-301237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657A95EE17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CDC28517E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CF14A62F;
	Mon, 26 Aug 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5wZ7sOp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC51487DC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666861; cv=none; b=CKih5n68jKrnOS7vpaeZBZpYJgrG7d32RcNTy4mmHSs2ZWoilPN2ycjMcwVzgy7EIO1vLfFGeV9ksuLMXZpKLRqDWGMHLq/jcnWZbMhHnIIGvCOrhHE4tMNR1/4CKEqjA1PZWlqWwDKKU2W6GeRG7LZoS09eJpaOT7ySq8DZzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666861; c=relaxed/simple;
	bh=uw0Pf+zldgzboru4goVYRFCRCYr8alqMpX4Y+JIze8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hsDrCC9yR6esZj+BaGe4/SwfVPw/88u4WfuxCSTo5d6OJURcF2OKEiqgzp+NlEcovEaDEVh8xor7ZBRfZ1IFXbp9ZOetHWAQIOdBG7qNeyJYNs6kcr/iIg8/ozFak3qKkxgaz5EMzf4+KsPRXr1AgHlWXCevYLl8HhO7/oJH1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z5wZ7sOp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso5130845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724666858; x=1725271658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4NvmLlxu/k307IUSr+vlW1RyZ9QbfRpgymkG5UhSlQ=;
        b=z5wZ7sOpzM6c5JiYAvpggG0Kw7i+4ssN/el+QuqwLedslwy6+Rqls4xf/5mKRBAdci
         srTTmsfxYb1ac9dPm1Hjgffhv+ZyEyyTgS+Vs75v+uI+cp0HuwdLM+F/mNszAKWxx6QP
         IdzhAAentsqXRT2mFnPSC7xsehoHfx6tWbU0Lr1n7XemQktFFuuJMX5zd0O3kcPJK+3u
         OsXewfdVdObeHBFyzVsbQ/nrVn8ZPiBnyMOazQK13sMlwZLwksOW4A8iwkHdg7q+xr2h
         8+01VJmZbPqd336BAVMDQzltBO1wfyddBzgd+2aAAoirhFpognlVMiV2nuqIrrYfPh0k
         xo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666858; x=1725271658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4NvmLlxu/k307IUSr+vlW1RyZ9QbfRpgymkG5UhSlQ=;
        b=nmYHnP5nlymg9EbxMWQRcQdh50eFFieAUiUvI7dQEHgquuCdEmfIsC5yzpbnDA1hn9
         k7pTjriqr//mSqRkehaGTjyGORtZb80CFnZmHjrS93wns3tP8rrm3f8OQZEwNWEwDMr5
         Ht0XhLCG+oGYwi3xWgoCLDSsaWA4f98EOQeorPgh18YRFFfDpdECZCzF1KysBQaQZdG9
         cB0/Enmsvq6fhybBtkc7U2cotm9iJkDPjWfEtmM5BvgPfIm35UC513dZEAR3JkeCF58u
         5VihM1yO+W3eZg8DMzOrAOzTsS2LAjHnjgmIWaW5kCrQ/QtV5cxjKE64a1e9XV1WYLdT
         uAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN3CrlatLE6Xt2QEWqruXnRtW7fMiwQxj248aToQSl6Qn35cQ7uoIIV8/jCMQIpX+xFNXzKn6YbNt3hOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLzVI3tc9PYibY8vBmLXPcTnBJVUf5J+ZjE/IL6DDSlq+nE3z
	2iMT1aLymb55SkHY4xTq+ntIStcjI9Alalir8gQ9qBfGL4EOCd3HWRMe97GahZE=
X-Google-Smtp-Source: AGHT+IFw9/YOcCZ4U7WA87IeV+RhOZP4bUxwWYn8Wb7oiTEYe4Ohe64MYDaPtt1DLAHFY/viNcl8kw==
X-Received: by 2002:a05:6000:402a:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-37311842d2amr3539393f8f.1.1724666858308;
        Mon, 26 Aug 2024 03:07:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110009sm10324821f8f.18.2024.08.26.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:07:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 Aug 2024 12:07:20 +0200
Subject: [PATCH 04/11] phy: hisilicon: usb2: Simplify with scoped for each
 OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-phy-of-node-scope-v1-4-5b4d82582644@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uw0Pf+zldgzboru4goVYRFCRCYr8alqMpX4Y+JIze8E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzFPb4sshkjU2CA9+XXXwCTRdCMdijvb6c9Og6
 nYQj7pay9CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsxT2wAKCRDBN2bmhouD
 13HXD/4pvENOHQUutqEqhtyXsdoTSjcrpUUfXLAHO6/21A1P+HQwDV6r4fVVRJN+4aUHynnlwXw
 GopDkMKpVV2abQ/lO5LqbUkMMvXi1M9o6QNEGnzu2scYkY+OVy4MT4Z2EK2zvjR5Fr6V9ICc7C6
 MoLxq+uREB5PWt23Z6GkcU86pc45o7ZiNHR9jwfwCXYRvJr/5mUkFXq08RZVzuHcMBtFiPxN5qL
 nif11Z04T3flhl4Zz+5zF7ciAB61V1d0DxFDBiMRVlgvBjpt2drTsYvNwlpdZMAeGYRTRUKqH36
 D5CFi+A3qFLoCpEKnu3mO2vhk9rwc3a9o5Mhf/wP6A8ivCt6hNJztUKLrbmhg4RNdZ0ME/e0R/+
 D2U0wc6Ig7cchhg3q0CSw9qsId2CBEnDjdxB3guCj0qCH4UkFrPwpfS7me8CQvi85Pb3Zd1VC9A
 Q347IbJLWq4RSEl2uNBC7eNv44Em7byvi6+84nUAjpG3ValeHjvjLwMs2db5G2ZmzAM2pCR1YfT
 pcdYwuwDicAdmXdNmDaQGWWdGisY6Ar6Ij3s09BWqqS6XfgG5sZ8O28puUNgcQvMc2MWoh0iXez
 GGTUDZrNnEJYSEa8sU3rRg3Xfy3NwR+S7QmmV/zP0ztj1PHnbRI3QzquMymUKGaJnm1Lxwa6K+y
 JtdTYdv9csoe90w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index c138cd4807d6..c843923252aa 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -138,7 +138,6 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct hisi_inno_phy_priv *priv;
 	struct phy_provider *provider;
-	struct device_node *child;
 	int i = 0;
 	int ret;
 
@@ -162,24 +161,20 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 
 	priv->type = (uintptr_t) of_device_get_match_data(dev);
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		struct reset_control *rst;
 		struct phy *phy;
 
 		rst = of_reset_control_get_exclusive(child, NULL);
-		if (IS_ERR(rst)) {
-			of_node_put(child);
+		if (IS_ERR(rst))
 			return PTR_ERR(rst);
-		}
 
 		priv->ports[i].utmi_rst = rst;
 		priv->ports[i].priv = priv;
 
 		phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
-		if (IS_ERR(phy)) {
-			of_node_put(child);
+		if (IS_ERR(phy))
 			return PTR_ERR(phy);
-		}
 
 		phy_set_bus_width(phy, 8);
 		phy_set_drvdata(phy, &priv->ports[i]);
@@ -187,7 +182,6 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 
 		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
-			of_node_put(child);
 			break;
 		}
 	}

-- 
2.43.0


