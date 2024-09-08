Return-Path: <linux-kernel+bounces-320101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D297063F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252541F21735
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720514F9C9;
	Sun,  8 Sep 2024 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLc2V4mh"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012614884F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788677; cv=none; b=WFNDc8suPGfXHsUhBq7tPKnEJNgDBtrV5gFxOih6wA0gNABfLBwSrToRj+f4HxFoRmNjd1Ke7OLSPFzLG7h++yk3Hg1JEzaXXF2mIsV3nN8n1FgLygkIgAJGFReeUSEdF03CZng7osaXckRZvpARQM5uupB/7J5GP+zk/1fgK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788677; c=relaxed/simple;
	bh=K/yyHp2/a0dvegYHQrXjL9jRDxTkEZkIhPefwAtNmeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZvmCohUKfdiQbKYh2u45w7xJGWkeE0DhtvB81Y8h5t5rhEXCwuMZ2pRw+dED3X73+/cJ+ypHScIimAwRGNyR8wX8k7yEQjMAnDsgbgTcSkXQ6HDNrz3SlGdPduRS4uEfNzRDADbvxM9rNxuYmNq2Hhf/t7/HQsKIDVw1PyV3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLc2V4mh; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMLJEP3cPn7gZV+KxwBU5XxAHaAxUnTVIGUSaGa2724=;
	b=TLc2V4mheT3eGL3rfkw5cqffwhWt3wvES9NTYMq/SwVvleWpu6HkO5Hb7wFvAtaUUD6IfA
	P1zZCyLVTKElaJgWS/rU1vuc+5qLdP/oEGkfgZvp2KoIq0pZXtREFO7u2kYKwh9uX332+r
	Z/l6VbEPtfTfxfuB9hKO60lmg4F4LUg=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 06/19] drm/etnaviv: Prefer drm_device based drm_WARN_ON() over regular WARN_ON()
Date: Sun,  8 Sep 2024 17:43:44 +0800
Message-ID: <20240908094357.291862-7-sui.jingfeng@linux.dev>
In-Reply-To: <20240908094357.291862-1-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

drm_WARN_ON() acts like WARN_ON(), but with the key difference of
using device specific information so that we know from which device
the warning is originating from.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 9 +++++----
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 6 +++---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c       | 7 +++++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 55004fa9fabd..1fd2cff20ef4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -256,7 +256,7 @@ void etnaviv_gem_mapping_unreference(struct etnaviv_vram_mapping *mapping)
 	struct etnaviv_gem_object *etnaviv_obj = mapping->object;
 
 	mutex_lock(&etnaviv_obj->lock);
-	WARN_ON(mapping->use == 0);
+	drm_WARN_ON(etnaviv_obj->base.dev, mapping->use == 0);
 	mapping->use -= 1;
 	mutex_unlock(&etnaviv_obj->lock);
 
@@ -463,7 +463,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
 
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
 		/* fini without a prep is almost certainly a userspace error */
-		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
+		drm_WARN_ON(dev, etnaviv_obj->last_cpu_prep_op == 0);
 		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
 			etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
 		etnaviv_obj->last_cpu_prep_op = 0;
@@ -541,12 +541,13 @@ static const struct etnaviv_gem_ops etnaviv_gem_shmem_ops = {
 
 void etnaviv_gem_free_object(struct drm_gem_object *obj)
 {
+	struct drm_device *drm = obj->dev;
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 	struct etnaviv_drm_private *priv = obj->dev->dev_private;
 	struct etnaviv_vram_mapping *mapping, *tmp;
 
 	/* object should not be active */
-	WARN_ON(is_active(etnaviv_obj));
+	drm_WARN_ON(drm, is_active(etnaviv_obj));
 
 	mutex_lock(&priv->gem_lock);
 	list_del(&etnaviv_obj->gem_node);
@@ -556,7 +557,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 				 obj_node) {
 		struct etnaviv_iommu_context *context = mapping->context;
 
-		WARN_ON(mapping->use);
+		drm_WARN_ON(drm, mapping->use);
 
 		if (context)
 			etnaviv_iommu_unmap_gem(context, mapping);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 8f523cbee60a..0062d808d6a9 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -19,7 +19,7 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 	unsigned int npages = obj->size >> PAGE_SHIFT;
 
-	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
+	if (drm_WARN_ON(obj->dev, !etnaviv_obj->pages))  /* should have already pinned! */
 		return ERR_PTR(-EINVAL);
 
 	return drm_prime_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d0df5c53a829..4599dd995e11 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -686,7 +686,7 @@ static void etnaviv_gpu_start_fe_idleloop(struct etnaviv_gpu *gpu,
 	u16 prefetch;
 	u32 address;
 
-	WARN_ON(gpu->state != ETNA_GPU_STATE_INITIALIZED);
+	drm_WARN_ON(gpu->drm, gpu->state != ETNA_GPU_STATE_INITIALIZED);
 
 	/* setup the MMU */
 	etnaviv_iommu_restore(gpu, context);
@@ -734,8 +734,8 @@ static void etnaviv_gpu_setup_pulse_eater(struct etnaviv_gpu *gpu)
 
 static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 {
-	WARN_ON(!(gpu->state == ETNA_GPU_STATE_IDENTIFIED ||
-		  gpu->state == ETNA_GPU_STATE_RESET));
+	drm_WARN_ON(gpu->drm, !(gpu->state == ETNA_GPU_STATE_IDENTIFIED ||
+				gpu->state == ETNA_GPU_STATE_RESET));
 
 	if ((etnaviv_is_model_rev(gpu, 0x320, 0x5007) ||
 	     etnaviv_is_model_rev(gpu, 0x320, 0x5220)) &&
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 02d9408d41bc..ed6c42384856 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -138,9 +138,10 @@ static void etnaviv_iommu_remove_mapping(struct etnaviv_iommu_context *context,
 void etnaviv_iommu_reap_mapping(struct etnaviv_vram_mapping *mapping)
 {
 	struct etnaviv_iommu_context *context = mapping->context;
+	struct drm_device *drm = dev_get_drvdata(context->global->dev);
 
 	lockdep_assert_held(&context->lock);
-	WARN_ON(mapping->use);
+	drm_WARN_ON(drm, mapping->use);
 
 	etnaviv_iommu_remove_mapping(context, mapping);
 	etnaviv_iommu_context_put(mapping->context);
@@ -333,7 +334,9 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 void etnaviv_iommu_unmap_gem(struct etnaviv_iommu_context *context,
 	struct etnaviv_vram_mapping *mapping)
 {
-	WARN_ON(mapping->use);
+	struct drm_device *drm = dev_get_drvdata(context->global->dev);
+
+	drm_WARN_ON(drm, mapping->use);
 
 	mutex_lock(&context->lock);
 
-- 
2.43.0


