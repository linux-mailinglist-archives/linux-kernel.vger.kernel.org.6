Return-Path: <linux-kernel+bounces-183159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56618C955C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63129280E02
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FE45BE4;
	Sun, 19 May 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVpdhXYz"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA24F5EC
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137747; cv=none; b=lHb6apiqp0TlJSBSKp+Y6/ew1ep2n29AYHNhAfx0/ux6ftrM1agMXmYFR6zJ7JLFCaG2sUTRFtrjNdB92BBkGO2E+MkOHsiPa+92Jm5CgooXjZHI4DBYD3Za6YzKMUmfXTg4XpHBLbCI+mqHsRQs2RkTt/4MF5izXrCzPqZTDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137747; c=relaxed/simple;
	bh=hm59Au1r1mM30f5gqdiuaWkIu4F5pPhFgp+s8SKe0+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRBs4+eHB2XAkd/cHSx7WR9UPkXlFWbk1qIHVEtz4u6O7Wv68zTf3+i+TLIUpy4eOPzvgtfN53Pb2tXjJXhb+BrvBsZ8GeM3CNhnpciD2dgfDAyyLD4MJ3M+UNKS6abmROYOI/KT+W79Z1zlkxfDEgKD8jjCoOzLQkpbRpg1qI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVpdhXYz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: l.stach@pengutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716137744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFYuWykwL1U4iv85dPQQK/TFC0Vjyb1IATiwN/iE76Q=;
	b=cVpdhXYzbGvg9D3LY2MmiBLKPrGIEy/mf3TWS3BAPUz9HMPI8ILszrEsLY5Rp0HacuSaIn
	bMdWGQWdg7IWkfT/5oziJ+hhzycV7sQjLFC1obPYqGaHf0h543ME/N7rVVQ7dBbP5D0rEV
	IM1M9zkwbTWclhbIqGujBrA8psHb7xA=
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
Subject: [etnaviv-next v14 6/8] drm/etnaviv: Replace the '&pdev->dev' with 'dev'
Date: Mon, 20 May 2024 00:53:19 +0800
Message-Id: <20240519165321.2123356-7-sui.jingfeng@linux.dev>
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

In the etnaviv_pdev_probe(), etnaviv_gpu_platform_probe() function, the
value of '&pdev->dev' has been cached to the 'dev' local auto variable.
But part of callers use 'dev' as argument, while the rest use '&pdev->dev'.

To keep it consistent, use 'dev' uniformly.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 986fd68b489a..863faac2ea19 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -614,7 +614,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!of_device_is_available(core_node))
 				continue;
 
-			drm_of_component_match_add(&pdev->dev, &match,
+			drm_of_component_match_add(dev, &match,
 						   component_compare_of, core_node);
 		}
 	} else {
@@ -637,9 +637,9 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 * bit to make sure we are allocating the command buffers and
 	 * TLBs in the lower 4 GiB address space.
 	 */
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(40)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		dev_dbg(&pdev->dev, "No suitable DMA available\n");
+	if (dma_set_mask(dev, DMA_BIT_MASK(40)) ||
+	    dma_set_coherent_mask(dev, DMA_BIT_MASK(32))) {
+		dev_dbg(dev, "No suitable DMA available\n");
 		return -ENODEV;
 	}
 
@@ -650,7 +650,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 */
 	first_node = etnaviv_of_first_available_node();
 	if (first_node) {
-		of_dma_configure(&pdev->dev, first_node, true);
+		of_dma_configure(dev, first_node, true);
 		of_node_put(first_node);
 	}
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index aa15682f94db..3a14e187388a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1891,7 +1891,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->dev = &pdev->dev;
+	gpu->dev = dev;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->sched_lock);
 
@@ -1905,8 +1905,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (gpu->irq < 0)
 		return gpu->irq;
 
-	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
-			       dev_name(gpu->dev), gpu);
+	err = devm_request_irq(dev, gpu->irq, irq_handler, 0,
+			       dev_name(dev), gpu);
 	if (err) {
 		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
 		return err;
@@ -1925,13 +1925,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	 * autosuspend delay is rather arbitary: no measurements have
 	 * yet been performed to determine an appropriate value.
 	 */
-	pm_runtime_use_autosuspend(gpu->dev);
-	pm_runtime_set_autosuspend_delay(gpu->dev, 200);
-	pm_runtime_enable(gpu->dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_enable(dev);
 
-	err = component_add(&pdev->dev, &gpu_ops);
+	err = component_add(dev, &gpu_ops);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register component: %d\n", err);
+		dev_err(dev, "failed to register component: %d\n", err);
 		return err;
 	}
 
-- 
2.34.1


