Return-Path: <linux-kernel+bounces-286279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B3951909
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB57282CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F91B32C9;
	Wed, 14 Aug 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHVw+Xcx"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F51B29CD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631780; cv=none; b=FBx+f7fl5Z4nnJxFtyPv0WD9efdHIvmEB0b0ceOjHU+KKNdHNaxs+m1r61X77B3vA8M3L89hWyGhYZfKkGFX81LzmyH6h7gxRk33xM86Eo6ZckizCqjUnDGF7Qv79xJgg2mPL1FfNIkzvOfJQVNxZLy9hNneMHhkDnp8D7bhURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631780; c=relaxed/simple;
	bh=ol6ZTXC6dPx1NNnToQYOXH4GwET4WoJKZEvGBAAyChA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9AfR+/TERAAc4jdJ+lNSRUQDJWAjMw0S6RiJLaDG/Y41/IpNjpgtm+FqnqIKFsNGUhm3HLwsUjAKuklVuNfvu+BZkvNEAE1JAqdc2/hDKMHdvDS4OXTiCeWRnAxmQSIZPZDOUhUSJascm82ZAOo5YhZ2vgiWz7vHHsCW14+3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHVw+Xcx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281faefea9so47651625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631777; x=1724236577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCsVD5Gw0XMLJtG9b25d0pMLRHt/Ggpq8ks2EPhWn3E=;
        b=OHVw+XcxLxLT++qHGGL4NfKLxqV69LhFYaxRVer98ARwFZ9xFKYY6CYFcCkx636QSC
         lbs0CGohaJvIO7MT8pktWQTZGaRXHu+3BnglV1u+q+zEo8GETqc4WI1iyvcD6LbPv5qg
         zd9aoTXtac9o83cn5jb6+tfq41ExaouewJjEg9G+LC1sJn6UAw8SEYgfB6zPX+cZ8t2y
         y0KhdbjaFnG/rWVGapQQfaxRCMhyZfazD+G/uzu46IG8p5tx1pdvygo+QTzFF65FEMxA
         2PiGFgNYo8RuclcQhOz76ZGcGAq7grT5QOoU4u9cBxXxkcbOedIqTcA+drrt8Jl6gpBz
         1pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631777; x=1724236577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCsVD5Gw0XMLJtG9b25d0pMLRHt/Ggpq8ks2EPhWn3E=;
        b=e8f/ZjVR50DMsbHtb4C9pgiNe+Q5vX/NUahAMhGSM7g3yHCYsqbfRlQ6UaU+bix27e
         bQ3t2U+keiqzOsdbIEnL4+rQwEwAkV+E8pag3ChbbhqA3Xp/8rJ6I1TknULcXnYJYJDs
         JAVblExHlNoY0bsC7V91gpSprkRyv8BDDGCtQzMLdOLM4KG8uuifSOiFgImYcrnk4wVd
         mYldLnc2h0xSPjt+dnQSOk/ONqlYN+FDwoX6XzG+7HqFNb6x0jr4x5k1/iSQBzeLnToD
         EjhHwS9KDtzRAZJxNzo9j7jQEOXO1ygl2PpWe7Cr92BLSoEQegbQdnuKRSYcJPmqF7pY
         WB7g==
X-Forwarded-Encrypted: i=1; AJvYcCX9wSsm2acE95j7vp+jxEx/R4x4INzGc+9mWSV2OJ55wTcIrdcb/hTrZIr6IC0wZSIWhN2fqUwgTsF33m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvV14EYuHm2iEC7+nmwLohAp1znIq5ahEDkhgQEBWMgoU3slJn
	h6GWrGlofZMMG+E+o+0BbNrNinQ5dDvbY6KlRBP5CkvZEl8oz8Q3+d+7usFfqKw=
X-Google-Smtp-Source: AGHT+IGcxmywyTO2gvy35KOCttJ+ZJhhBQ2L4GtnK9UfIj5G8nLkgiKFU1tAu9Ts0iBIJ00/ObFPsA==
X-Received: by 2002:a05:600c:1c93:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-429dd25f517mr15394135e9.26.1723631777491;
        Wed, 14 Aug 2024 03:36:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3dd4dsm15501835e9.29.2024.08.14.03.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:36:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 12:35:47 +0200
Subject: [PATCH 11/11] usb: dwc3: xilinx: simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-usb-v1-11-95481b9682bc@linaro.org>
References: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ol6ZTXC6dPx1NNnToQYOXH4GwET4WoJKZEvGBAAyChA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvIiI0pC7cGWUcMPtTN5Rj4I9ue4DwVHlIBTOR
 FZKTmMNbuyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZryIiAAKCRDBN2bmhouD
 1/31D/4lelP2Ou1IyK4wZSB1Osrpv5THjLFKzvWenV3V5pHokmwuau5AJypaMbC2qkYkpr/mo1g
 WN0nuAtUFwUL57BPiqPpDYXrg9FDydmfDejUCaamjp+u6b6rJNrdNrP77XKpl27yBUP6koL22tH
 a6tGDDWdza5ocxOQu1Dkd44EM7uKDO6m9V7sUfhg1u8fZCL6wVLh/ZkYVSlSWB0/JEG4xOpDPvS
 mz5OYP4ExBLwy1UHPMjxsoWG6fo66yASdJ7oQJeBwrhLwxDiId88883oH7rgXiF7hlQJ/LDe5zp
 CrtGSn+DMV2F+41SmyuXRZgscfeVqGyxFMHVmSd5QqVFxNQVKkzBS6RKCPZNmQjSK7g2Mr65lFL
 jZMlm95cOlybp4FnequD5MWQr0616bw2DTxDKOTnJ9jVRQhM49dfkKoivW1YSxhXVzXXnjiIXGN
 v9Rz+OTnO/57SoVX5fOhI7z+C5FyYSyJA0mjZ5RqPVV3bjp5m/7SjWSzwckXidcwpGWswyahE1q
 tfLywc0KMgHHQLePAVq6LyQ98L48G+hcIo5X3KY0HeAeOnOTm8F4imWVj5ffkZ6FJzKu0V2Gi+l
 wwwYkgm/+wqTvNYRpLWfoUetlqZqSO8w0wLbAEUV5j/BFk6XqTnLhXiw6E0VI9viRD6fSFhT2Qr
 KEl4SJzQy/0HuFQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make the error paths a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index b7613a106da6..eb535733ce91 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -285,11 +285,8 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		dev_err_probe(dev, ret, "failed to map registers\n");
-		return ret;
-	}
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs), "failed to map registers\n");
 
 	match = of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
 

-- 
2.43.0


