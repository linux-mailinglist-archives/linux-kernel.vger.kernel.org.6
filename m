Return-Path: <linux-kernel+bounces-183153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213768C954F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85BC281B61
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B784501B;
	Sun, 19 May 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mg4FV1ap"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB04D5AA
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137660; cv=none; b=do8qdkmQNBxH8CsAAMGNWQ7uHSwRycpfq6/kf7HL9hgtEmNRXRBKS9FqrGS5lLUTck/iuGuUGFLGi2XGvI52cJyoNf4pbeaFptcUHwUwVPG8+Tjex6nFBPTmiIAsr/AGlL1z6sXOHDPdIsiB/gLchDwfdbCoksJH5DpD6Pd6AC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137660; c=relaxed/simple;
	bh=KAZWXjSYnci4BObhDy2HkSBCKA1IgWkN/tPI5FVl+No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUMjF1/Pa07Lj1sm0FZQ8mw7P+GIa2tHFczTHMvLytFzonnHp/nJaz3jt5qmP+tvgohSR+tMMLV01skkdpFCIFdX0pBYk9OO9PT1MDgrxvKV72YIxlfVCRjPPFyFRkVW7BPUOW1qPqCwOmWsBD4J7h+HqPRe/Ilv1OMoXrcD1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mg4FV1ap; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: l.stach@pengutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716137656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ExoUU6tg2//RjoBtky2xb+vLzbkleyPn1j+Bsv6Tuk=;
	b=mg4FV1apy8t47+hpavdd5Q1kazzq+igCK6S05akf/Cm4t66MAFlaTLF8ShzwLgJQQJ0m5V
	gdEBmfhafgCBset/I+ASIghJVZfD0POgwx5f3iR7SQ8zUhDSMjiDozb85Xy/WRFDLECTZW
	LWvjnlPEJ0LrGWhhNBRccgRRK24hBoY=
X-Envelope-To: linux+etnaviv@armlinux.org.uk
X-Envelope-To: christian.gmeiner@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: etnaviv@lists.freedesktop.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	linux-kernel@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v14 1/8] drm/etnaviv: Add a dedicated helper function to get various clocks
Date: Mon, 20 May 2024 00:53:14 +0800
Message-Id: <20240519165321.2123356-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240519165321.2123356-1-sui.jingfeng@linux.dev>
References: <20240519165321.2123356-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the current implementation is DT-based, this only works when the
host platform has the DT support. The problem is that some host platforms
does not provide DT-based clocks drivers, as a result, the driver rage
quit.

PLL hardwares are typically provided by the host platform, which is part
of the entire clock tree. The PLL hardware provide clock pulse to the GPU
core, but it's not belong to the GPU corei itself. PLL registers can be
manipulated directly by the device driver. Hence, it may need dedicated
clock driver.

Add a the etnaviv_gpu_clk_get() function to group similar code blocks,
which make it easier to call this function on the platform where it works.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 53 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d84d73c197fc..e0c36f564fa6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1605,6 +1605,35 @@ static irqreturn_t irq_handler(int irq, void *data)
 	return ret;
 }
 
+static int etnaviv_gpu_clk_get(struct etnaviv_gpu *gpu)
+{
+	struct device *dev = gpu->dev;
+
+	gpu->clk_reg = devm_clk_get_optional(dev, "reg");
+	DBG("clk_reg: %p", gpu->clk_reg);
+	if (IS_ERR(gpu->clk_reg))
+		return PTR_ERR(gpu->clk_reg);
+
+	gpu->clk_bus = devm_clk_get_optional(dev, "bus");
+	DBG("clk_bus: %p", gpu->clk_bus);
+	if (IS_ERR(gpu->clk_bus))
+		return PTR_ERR(gpu->clk_bus);
+
+	gpu->clk_core = devm_clk_get(dev, "core");
+	DBG("clk_core: %p", gpu->clk_core);
+	if (IS_ERR(gpu->clk_core))
+		return PTR_ERR(gpu->clk_core);
+	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
+
+	gpu->clk_shader = devm_clk_get_optional(dev, "shader");
+	DBG("clk_shader: %p", gpu->clk_shader);
+	if (IS_ERR(gpu->clk_shader))
+		return PTR_ERR(gpu->clk_shader);
+	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
+
+	return 0;
+}
+
 static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 {
 	int ret;
@@ -1880,27 +1909,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get Clocks: */
-	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
-	DBG("clk_reg: %p", gpu->clk_reg);
-	if (IS_ERR(gpu->clk_reg))
-		return PTR_ERR(gpu->clk_reg);
-
-	gpu->clk_bus = devm_clk_get_optional(&pdev->dev, "bus");
-	DBG("clk_bus: %p", gpu->clk_bus);
-	if (IS_ERR(gpu->clk_bus))
-		return PTR_ERR(gpu->clk_bus);
-
-	gpu->clk_core = devm_clk_get(&pdev->dev, "core");
-	DBG("clk_core: %p", gpu->clk_core);
-	if (IS_ERR(gpu->clk_core))
-		return PTR_ERR(gpu->clk_core);
-	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
-
-	gpu->clk_shader = devm_clk_get_optional(&pdev->dev, "shader");
-	DBG("clk_shader: %p", gpu->clk_shader);
-	if (IS_ERR(gpu->clk_shader))
-		return PTR_ERR(gpu->clk_shader);
-	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
+	err = etnaviv_gpu_clk_get(gpu);
+	if (err)
+		return err;
 
 	/* TODO: figure out max mapped size */
 	dev_set_drvdata(dev, gpu);
-- 
2.34.1


