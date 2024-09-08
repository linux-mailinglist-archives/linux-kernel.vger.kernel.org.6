Return-Path: <linux-kernel+bounces-320111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A93970649
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B49282A3F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383F14D432;
	Sun,  8 Sep 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c7frMs6o"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414E1581EA
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788712; cv=none; b=dsj2fATeySiATGhz8Wn1mV5ac3q8gLRnK8FV/s4kuluWLOBeJ91OYO+7MKtqGp4vbegfuQ82G/r30xoqNLFOuifoMpmjlZLgOvi0j0mxy5rruDmaLvrZH2pmFsmKSiHRW4V+MBxg/wziEv89zoSguUs4Qj9BWjUAm+z4JdRj0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788712; c=relaxed/simple;
	bh=vuUi4j1y5hReQugQyO0sElTYYEndnjA/fAIlXAAPiCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLtZu6H0404BSaSmP00UTIylARFRjhpzngxtD2ic44bF4H1taa7p5czzdeTFm5AoucnnpaKhHXlYJmVKI47DohciGLKqxwmHt85sSd8sYwnnLmo8EgiwAr5BxXl5G2h9+lXaZYHZ4jjupoZI8Sy5MimyGFArmxAYO3Vh8zS668M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c7frMs6o; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9vnlv8ASleXaOIgr3QjoTFJAHyOgr/prPxvxoVqxKQ=;
	b=c7frMs6oo+hCa4BjXHxxZlXGxi3F/d+F/q+KPpzDrIoiDsGdqheZ3VlG4GJ3o8gO+ZBpKz
	2zD9sqSKhVA/bfgqO6U9TRc4wZhbLteM7P06TtFSIYeDqc1N2arRqOU0GH4rJgWeEAjx2N
	gh7ohmSQZYZhukQyKHWQVmFX/XR0Mqk=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 15/19] drm/etnaviv: Make more use of the etnaviv_gem_new_private() function
Date: Sun,  8 Sep 2024 17:43:53 +0800
Message-ID: <20240908094357.291862-16-sui.jingfeng@linux.dev>
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

Add the 'bool shmem' as the 4th argument of etnaviv_gem_new_private(),
then call etnaviv_gem_new_handle() to allocate the etnaviv_gem_object
instance for us.

A small benefit is to reduce code duplication across different etnaviv
GEM buffer objects. This allow us to reuse etnaviv_gem_new_private()
everywhere, increasing code reusage.

We also should call drm_gem_private_object_fini() to uninitialize an
already allocated GEM object when it initialized failed. Now
etnaviv_gem_new_private() handle this trouble for us, the upper caller
can just use it, no need to worry about error handling anymore.

if true, the drm_gem_object_init() will allocate backing storage for us,
then this is a shmem buffer object. if false, we have to implement driver
specific backing storage.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 28 +++++++++++++--------
 drivers/gpu/drm/etnaviv/etnaviv_gem.h       |  4 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  2 +-
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 3732288ff530..27e4a93c981c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -697,21 +697,20 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	u32 size, u32 flags, u32 *handle)
 {
 	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
-	struct drm_gem_object *obj = NULL;
+	struct etnaviv_gem_object *etnaviv_obj;
+	struct drm_gem_object *obj;
 	int ret;
 
 	size = PAGE_ALIGN(size);
 
-	ret = etnaviv_gem_new_impl(dev, flags, &etnaviv_gem_shmem_ops, &obj);
+	ret = etnaviv_gem_new_private(dev, size, flags, true,
+				      &etnaviv_gem_shmem_ops, &etnaviv_obj);
 	if (ret)
 		goto fail;
 
-	lockdep_set_class(&to_etnaviv_bo(obj)->lock, &etnaviv_shm_lock_class);
-
-	ret = drm_gem_object_init(dev, obj, size);
-	if (ret)
-		goto fail;
+	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_shm_lock_class);
 
+	obj = &etnaviv_obj->base;
 	/*
 	 * Our buffers are kept pinned, so allocating them from the MOVABLE
 	 * zone is a really bad idea, and conflicts with CMA. See comments
@@ -732,7 +731,8 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 }
 
 int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
-	const struct etnaviv_gem_ops *ops, struct etnaviv_gem_object **res)
+			    bool shmem, const struct etnaviv_gem_ops *ops,
+			    struct etnaviv_gem_object **res)
 {
 	struct drm_gem_object *obj;
 	int ret;
@@ -741,7 +741,15 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 	if (ret)
 		return ret;
 
-	drm_gem_private_object_init(dev, obj, size);
+	if (shmem) {
+		ret = drm_gem_object_init(dev, obj, size);
+		if (ret) {
+			drm_gem_private_object_fini(obj);
+			return ret;
+		}
+	} else {
+		drm_gem_private_object_init(dev, obj, size);
+	}
 
 	*res = to_etnaviv_bo(obj);
 
@@ -830,7 +838,7 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, struct drm_file *file,
 	struct etnaviv_gem_object *etnaviv_obj;
 	int ret;
 
-	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_CACHED,
+	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_CACHED, false,
 				      &etnaviv_gem_userptr_ops, &etnaviv_obj);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index f2ac64d8e90b..b174a9e4cc48 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -118,7 +118,9 @@ void etnaviv_submit_put(struct etnaviv_gem_submit * submit);
 int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
 	struct drm_etnaviv_timespec *timeout);
 int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
-	const struct etnaviv_gem_ops *ops, struct etnaviv_gem_object **res);
+			    bool shmem, const struct etnaviv_gem_ops *ops,
+			    struct etnaviv_gem_object **res);
+
 void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj);
 struct page **etnaviv_gem_get_pages(struct etnaviv_gem_object *obj);
 void etnaviv_gem_put_pages(struct etnaviv_gem_object *obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 0062d808d6a9..64a858a0b0cf 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -107,7 +107,7 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 	size_t size = PAGE_ALIGN(attach->dmabuf->size);
 	int ret, npages;
 
-	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
+	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC, false,
 				      &etnaviv_gem_prime_ops, &etnaviv_obj);
 	if (ret < 0)
 		return ERR_PTR(ret);
-- 
2.43.0


