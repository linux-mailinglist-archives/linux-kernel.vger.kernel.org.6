Return-Path: <linux-kernel+bounces-300398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89E495E33C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E77A1F2167A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82513DB9B;
	Sun, 25 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HlaRxmPn"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEB14B09E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724588106; cv=none; b=aUH813ItTGUpKKTt6/GhDE+Vdr0m1FIbI+fUz+X41wBH6OJXYJf64eRKj9h+9V7PWaRBCgTdpt3BNdh5hsqyF1sB+WIEBlliurBcaQdPqtf555CkbQXgkXt3wXYrDK0AQns2MItzxN8/xh54q3drAFxtpCTJd95peUIfFDpDMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724588106; c=relaxed/simple;
	bh=rAbfKpG9q5CJPUoaX3QA35mLhN1M93kuNvKTdJ7mz7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/fIw8dV7jk96fhsF9VFaGlsOGqUwVKsHNt408PEXGNoN32Bx0tflZLm8cPNNJUT5LxJJoIt5on0Epa+cqGamJdtRJttq/LaLsdMih/JN+cZvh6AUGbuCAo93qXzI3x6nM+Vs+AWPe54SLwKwteKNZLUHriO5EhvDY4K7wSAGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HlaRxmPn; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724588101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KYBUuOZ77RsbonBNPjWaQa/LDzXOSCA+09B7u42eC7s=;
	b=HlaRxmPnRISY7Zfc3te2rd46fklNc828HXME+YpMd1Xjb6mYXl8Rwz/MgAY2wzZzviIH2u
	VHtN1Zf9DZP9TQi8QRRTfRk/oe3G47dVU2C4sVDSsX/SgqWVmTY+cr+pxoimQq6Aj+QipW
	I90Ff3nmsnTg5/iWseLsqY7eVwVQgK4=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/etnaviv: Fix missing mutex_destroy()
Date: Sun, 25 Aug 2024 20:14:52 +0800
Message-Id: <20240825121452.363342-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the calling of mutex_destroy() is ignored on error handling
code path. It is safe for now, since mutex_destroy() actually does
nothing in non-debug builds. But the mutex_destroy() is used to mark
the mutex uninitialized on debug builds, and any subsequent use of the
mutex is forbidden.

It also could lead to problems if mutex_destroy() gets extended, add
missing mutex_destroy() to eliminate potential concerns.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 3 +++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c    | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c    | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c    | 5 +++++
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c    | 2 +-
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
index 721d633aece9..1edc02022be4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
@@ -79,6 +79,9 @@ void etnaviv_cmdbuf_suballoc_destroy(struct etnaviv_cmdbuf_suballoc *suballoc)
 {
 	dma_free_wc(suballoc->dev, SUBALLOC_SIZE, suballoc->vaddr,
 		    suballoc->paddr);
+
+	mutex_destroy(&suballoc->lock);
+
 	kfree(suballoc);
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..7844cd961a29 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -564,6 +564,7 @@ static int etnaviv_bind(struct device *dev)
 out_destroy_suballoc:
 	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 out_free_priv:
+	mutex_destroy(&priv->gem_lock);
 	kfree(priv);
 out_put:
 	drm_dev_put(drm);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index fe665ca20c02..b68e3b235a7d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -515,6 +515,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 	etnaviv_obj->ops->release(etnaviv_obj);
 	drm_gem_object_release(obj);
 
+	mutex_destroy(&etnaviv_obj->lock);
 	kfree(etnaviv_obj);
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index af52922ff494..d6acc4c68102 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1929,8 +1929,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 static void etnaviv_gpu_platform_remove(struct platform_device *pdev)
 {
+	struct etnaviv_gpu *gpu = dev_get_drvdata(&pdev->dev);
+
 	component_del(&pdev->dev, &gpu_ops);
 	pm_runtime_disable(&pdev->dev);
+
+	mutex_destroy(&gpu->lock);
+	mutex_destroy(&gpu->sched_lock);
 }
 
 static int etnaviv_gpu_rpm_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index e3be16165c86..ed6c42384856 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -361,7 +361,7 @@ static void etnaviv_iommu_context_free(struct kref *kref)
 		container_of(kref, struct etnaviv_iommu_context, refcount);
 
 	etnaviv_cmdbuf_suballoc_unmap(context, &context->cmdbuf_mapping);
-
+	mutex_destroy(&context->lock);
 	context->global->ops->free(context);
 }
 void etnaviv_iommu_context_put(struct etnaviv_iommu_context *context)
-- 
2.34.1


