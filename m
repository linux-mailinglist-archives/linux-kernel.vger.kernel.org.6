Return-Path: <linux-kernel+bounces-301239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED42395EE1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7955E28588F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435B1527AC;
	Mon, 26 Aug 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OotnMYjM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8414D290
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666864; cv=none; b=ICDbCFBghBXd58h6LbPIfG5zRlIBHcnzRUrjyqFbQ2drNRtfVejqj7IbBXjI5MoPiKWI2S6HnYtTKQBZegLhaoT2xanwTnh2cRK0t9P8FFuyZOZMXsYrivztl4oXPHMtTAG1DuJ6OHdA6qoPZwu4XEEJxAcadOowJd/n5Xa/e2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666864; c=relaxed/simple;
	bh=leD8tF3yHCNMBo9vM9LVLXB5PNba9al/SNWQPAQYPNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeDtGXsp0qWyDMWwY8J6G5s4FlYPCyniaA+oaxcOpF4BCAXgemP+vw7RtwMNfmT+1KnwNYjxef+2pvf+LOnAisyxqp6dxcOvkL7m+dlmq0h6F0MJ1vjmMks8L8HcjH+3iU2ZDw63l00bX8RC4p/jvOHSvJQJzxcM0Zx4FCmmpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OotnMYjM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso1816605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724666861; x=1725271661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASWJ1lNjHUuMpa6qAsr3Tj5tgry0xzTBJeveJBPNnU4=;
        b=OotnMYjMxwr8CExOKuofUkwzl4Roup2k+SG0bNIeufqfyqT7nweLg2pNl/VIexGgKM
         SzCc00BkH1LWhQ1HvA4B99eXcUHngrVga3TqA9p99VpRcPlsV06uhazmDsIWzsx1mOHe
         cVst/ZzpltApuSE1gAW9CUHMil2heUp6NGtywyaHlY+JRmh7W6IkpBsCu/PSdV9lr1Ld
         ZiVeD05sA9eZRHUs+Hm6xlo4i235IO6y0ZSoqZ5h96tW3WKsBJEG6lbrUN0LZRyriibk
         9lkX6h5BpzWnouDcmp8ZVBLs6K/N6kgkkIeLZqgnJu+7mxtH3OZO0I5wdavkD6AUl1iA
         LyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666861; x=1725271661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASWJ1lNjHUuMpa6qAsr3Tj5tgry0xzTBJeveJBPNnU4=;
        b=wSEW0j0Emk+qljnfEOJ43/muOSuAMDqmaoD4gA6hpimoCJHqFiDp3FHadp+NuRZ+Au
         hs0IGy92SKtoLHpCUUsg4GnlLoZ8IQQbgB0CN49ib2PZ7hbsJ7suR8t/Fgyg7Pv9DgB8
         SY9WS8NoQ5HLLurfczVIM34Bhy/HXPe7DEB8T61bUq/lRlgcUASCWWeLRmenkOzQK2f9
         F2OKuFShlVRqkeFNhVn9oZHw+tPEjzWtebMMwWvEVRIBI3LE3eQqqq2Jx28ukBpIX0jO
         4qQV73uhm+cCL/X//C/o+N/ENPv7g7kEQEilGMUp4jqcO3h8bKM8h+KtealGGzO4fqsT
         7qMg==
X-Forwarded-Encrypted: i=1; AJvYcCWKFgFiB+vX0CJJgSxBCdyWE+j95htK9Yy1HfbORo4WhJ5DaHR6dlJJGIwgttJtYUhn0WxpNhvAGgXNEvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSLPB19mM5ZcmTmv6AMCxTWKneZceBmVuPwB5s2ZeWLX+WiTz
	E/z/cYlMAAjCoXOjKttvlvpnYThKDwqSK1LMyojk5BDbV+VuMXS+HJ01FLvr+uR43XYOGeRVu75
	x
X-Google-Smtp-Source: AGHT+IGnpO6+krf9to/NrSDs8QxwhaBThYRXrUT2BYv5yO/i1nNfdR3qX52BrU7X1WNRyqqZ2hzEKw==
X-Received: by 2002:a05:600c:5104:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-42acca104f1mr43496065e9.5.1724666861335;
        Mon, 26 Aug 2024 03:07:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110009sm10324821f8f.18.2024.08.26.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:07:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 Aug 2024 12:07:22 +0200
Subject: [PATCH 06/11] phy: mediatek: xsphy: Simplify with scoped for each
 OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-phy-of-node-scope-v1-6-5b4d82582644@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2728;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=leD8tF3yHCNMBo9vM9LVLXB5PNba9al/SNWQPAQYPNY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzFPdbq398dEPwi9VsOu0ZYKL/TxY+EchqiwUv
 jtz4Z1F6wOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsxT3QAKCRDBN2bmhouD
 189TD/0QjWxZ8926h1MFxLw4xEdxSn6C7GFD7UWOUoHho2maLGHAP0d69x+ozFtJlztBohHkqbW
 kRJNDsp6wHEfcnBupn8tIBsDZbC/np6CT6l8qW64k9CaatbGcD95BsD5LuC31pzpc2WoGPir634
 eHuXAc3970XdG9x+sJYhyyS9ONcHPmJcdpPfbtGTzffmsUYWdcnK8iC51dhESPWiVyWfWWkGVy0
 ZxagVj/Y77BiwaPv3B0bMQDHjnEj6N7dhh/umLiwgY1pusksIG121C1vbM5R8kzYtunZVtemQ43
 uMldHhstgo4Ev3VynweUyowv4pAA0rkxxP8dT0bzB0fjubttMbnwlAB+K+MAppBWGDIepsgfK5H
 gPdIcCGNbt3ILpIrCRUcqz2Qpiluzlq5KTjQugyQMsnQYyUXg4KgbOJuWsmI3R4hCY4II4e7WOt
 eQiyP1d/13zdBKlf55/XR+G9EPieqO0UIQ+NgK7lFiD8fZtYJXKeg2E70iWo+YGSyHe+BlOKFVw
 jbt6ll62mrjY0N0sH3DKkrgdIAbmNJ4AdM4U6uX3FMYf43kEh+eS8SLmk7s5NaAUdZLazZpY7ME
 sOLGuytbfXbqflrjDXbwOmne4MXE6W5NI1XcgkZCed4ImXGKbfDdUMvVGEelI5QojoNJBOhf35q
 irWNDnlCOCWDxrA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/mediatek/phy-mtk-xsphy.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
index 064fd0941727..7c248f5cfca5 100644
--- a/drivers/phy/mediatek/phy-mtk-xsphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -432,12 +432,11 @@ static int mtk_xsphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child_np;
 	struct phy_provider *provider;
 	struct resource *glb_res;
 	struct mtk_xsphy *xsphy;
 	struct resource res;
-	int port, retval;
+	int port;
 
 	xsphy = devm_kzalloc(dev, sizeof(*xsphy), GFP_KERNEL);
 	if (!xsphy)
@@ -471,37 +470,34 @@ static int mtk_xsphy_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "mediatek,src-coef", &xsphy->src_coef);
 
 	port = 0;
-	for_each_child_of_node(np, child_np) {
+	for_each_child_of_node_scoped(np, child_np) {
 		struct xsphy_instance *inst;
 		struct phy *phy;
+		int retval;
 
 		inst = devm_kzalloc(dev, sizeof(*inst), GFP_KERNEL);
-		if (!inst) {
-			retval = -ENOMEM;
-			goto put_child;
-		}
+		if (!inst)
+			return -ENOMEM;
 
 		xsphy->phys[port] = inst;
 
 		phy = devm_phy_create(dev, child_np, &mtk_xsphy_ops);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create phy\n");
-			retval = PTR_ERR(phy);
-			goto put_child;
+			return PTR_ERR(phy);
 		}
 
 		retval = of_address_to_resource(child_np, 0, &res);
 		if (retval) {
 			dev_err(dev, "failed to get address resource(id-%d)\n",
 				port);
-			goto put_child;
+			return retval;
 		}
 
 		inst->port_base = devm_ioremap_resource(&phy->dev, &res);
 		if (IS_ERR(inst->port_base)) {
 			dev_err(dev, "failed to remap phy regs\n");
-			retval = PTR_ERR(inst->port_base);
-			goto put_child;
+			return PTR_ERR(inst->port_base);
 		}
 
 		inst->phy = phy;
@@ -512,17 +508,12 @@ static int mtk_xsphy_probe(struct platform_device *pdev)
 		inst->ref_clk = devm_clk_get(&phy->dev, "ref");
 		if (IS_ERR(inst->ref_clk)) {
 			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
-			retval = PTR_ERR(inst->ref_clk);
-			goto put_child;
+			return PTR_ERR(inst->ref_clk);
 		}
 	}
 
 	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
 	return PTR_ERR_OR_ZERO(provider);
-
-put_child:
-	of_node_put(child_np);
-	return retval;
 }
 
 static struct platform_driver mtk_xsphy_driver = {

-- 
2.43.0


