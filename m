Return-Path: <linux-kernel+bounces-320098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D497062C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123EC1C20F53
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C49142624;
	Sun,  8 Sep 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l7A0K9AS"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28E13B28D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788668; cv=none; b=iV6swgKLTH0o5rROlpZNJEDStMK6zjdafrCiVW7etMY/xw4taTixWQRbTlik0e4+RhSfWqynIx/RvHes6As2ordmzzRqXLpXcFwYPcXHJBrzWZNwntb+Qf/X3SFmnwi/rw7Cfc4qS4yawm85/h1Uke/uLbvFuMQ68MJ23Lbwc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788668; c=relaxed/simple;
	bh=81UeiXGll0WfvUQrjfkmi8NEoMeJCmh75D8ogfAHA7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYb+rroXVo5C80Y7VQwND5GFNVyPqp4JZZoFpvsWoIj2XEs/3J0ek70thQtzNqWV1A3FN8XBigsf9r+FJXoXWaacmD2ZYPXmtxQOGSDSNOMLgtNmi+P408xZw2KnT1GGTffKWxnm9vdkNu2NARZhE3J2iki3Y4bpucakV+A2Pqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l7A0K9AS; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8HrP3vJQ3Z2agF7CFE3rOrow17VaFyduWBq2e2tNKw=;
	b=l7A0K9ASjDVcHwX6VwiQ1GhtDYj5u9Ur2JOW8Yc4wrkKyM1JceKMf6O0MvVS3gsODgiIk1
	291mflfGx+XYhM13G788fqSs2BVozRTqxx6U57HMXixIHXStSEXiADVyjoGlIfbnP4b0yC
	L27r15XETBHm/StH+xP9RDfsHMQi3S0=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 03/19] drm/etnaviv: Implement drm_gem_object_funcs::vunmap()
Date: Sun,  8 Sep 2024 17:43:41 +0800
Message-ID: <20240908094357.291862-4-sui.jingfeng@linux.dev>
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

The vunmap() can be used to release virtual mapping obtained by vmap(),
While the vmap() is used to make a long duration mapping of multiple
physical pages into a contiguous virtual space.

Make the implementation-specific vunmap() operation untangled with the
etnaviv_gem_xxx_release() function. As then, the etnaviv_gem_xxx_release()
only need to responsible for the release page works.

The etnaviv_gem_vunmap() is added for driver internal usa case, where no
DRM GEM framework is involved.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 38 ++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h       |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 13 ++++---
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index b3eb1662e90c..2eb2ff13f6e8 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -61,6 +61,7 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 int etnaviv_gem_prime_pin(struct drm_gem_object *obj);
 void etnaviv_gem_prime_unpin(struct drm_gem_object *obj);
 void *etnaviv_gem_vmap(struct drm_gem_object *obj);
+void etnaviv_gem_vunmap(struct drm_gem_object *obj);
 int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
 		struct drm_etnaviv_timespec *timeout);
 int etnaviv_gem_cpu_fini(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 6bdf72cd9e85..fad23494d08e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -340,6 +340,25 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 	return etnaviv_obj->vaddr;
 }
 
+void etnaviv_gem_vunmap(struct drm_gem_object *obj)
+{
+	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
+
+	if (!etnaviv_obj->vaddr)
+		return;
+
+	mutex_lock(&etnaviv_obj->lock);
+	etnaviv_obj->ops->vunmap(etnaviv_obj);
+	etnaviv_obj->vaddr = NULL;
+	mutex_unlock(&etnaviv_obj->lock);
+}
+
+static void etnaviv_gem_object_vunmap(struct drm_gem_object *obj,
+				      struct iosys_map *map)
+{
+	etnaviv_gem_vunmap(obj);
+}
+
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
@@ -471,14 +490,21 @@ void etnaviv_gem_describe_objects(struct etnaviv_drm_private *priv,
 
 static void etnaviv_gem_shmem_release(struct etnaviv_gem_object *etnaviv_obj)
 {
-	vunmap(etnaviv_obj->vaddr);
 	put_pages(etnaviv_obj);
 }
 
+static void etnaviv_gem_shmem_vunmap(struct etnaviv_gem_object *etnaviv_obj)
+{
+	lockdep_assert_held(&etnaviv_obj->lock);
+
+	vunmap(etnaviv_obj->vaddr);
+}
+
 static const struct etnaviv_gem_ops etnaviv_gem_shmem_ops = {
 	.get_pages = etnaviv_gem_shmem_get_pages,
 	.release = etnaviv_gem_shmem_release,
 	.vmap = etnaviv_gem_vmap_impl,
+	.vunmap = etnaviv_gem_shmem_vunmap,
 	.mmap = etnaviv_gem_mmap_obj,
 };
 
@@ -508,6 +534,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 		kfree(mapping);
 	}
 
+	etnaviv_obj->ops->vunmap(etnaviv_obj);
 	etnaviv_obj->ops->release(etnaviv_obj);
 	drm_gem_object_release(obj);
 
@@ -569,6 +596,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
 	.unpin = etnaviv_gem_prime_unpin,
 	.get_sg_table = etnaviv_gem_prime_get_sg_table,
 	.vmap = etnaviv_gem_prime_vmap,
+	.vunmap = etnaviv_gem_object_vunmap,
 	.mmap = etnaviv_gem_mmap,
 	.vm_ops = &vm_ops,
 };
@@ -723,6 +751,13 @@ static void etnaviv_gem_userptr_release(struct etnaviv_gem_object *etnaviv_obj)
 	}
 }
 
+static void etnaviv_gem_userptr_vunmap(struct etnaviv_gem_object *etnaviv_obj)
+{
+	lockdep_assert_held(&etnaviv_obj->lock);
+
+	vunmap(etnaviv_obj->vaddr);
+}
+
 static int etnaviv_gem_userptr_mmap_obj(struct etnaviv_gem_object *etnaviv_obj,
 		struct vm_area_struct *vma)
 {
@@ -733,6 +768,7 @@ static const struct etnaviv_gem_ops etnaviv_gem_userptr_ops = {
 	.get_pages = etnaviv_gem_userptr_get_pages,
 	.release = etnaviv_gem_userptr_release,
 	.vmap = etnaviv_gem_vmap_impl,
+	.vunmap = etnaviv_gem_userptr_vunmap,
 	.mmap = etnaviv_gem_userptr_mmap_obj,
 };
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index 3f8fe19a77cc..d4965de3007c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -65,6 +65,7 @@ struct etnaviv_gem_ops {
 	int (*get_pages)(struct etnaviv_gem_object *);
 	void (*release)(struct etnaviv_gem_object *);
 	void *(*vmap)(struct etnaviv_gem_object *);
+	void (*vunmap)(struct etnaviv_gem_object *);
 	int (*mmap)(struct etnaviv_gem_object *, struct vm_area_struct *);
 };
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 6b98200068e4..bea50d720450 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -62,11 +62,6 @@ void etnaviv_gem_prime_unpin(struct drm_gem_object *obj)
 
 static void etnaviv_gem_prime_release(struct etnaviv_gem_object *etnaviv_obj)
 {
-	struct iosys_map map = IOSYS_MAP_INIT_VADDR(etnaviv_obj->vaddr);
-
-	if (etnaviv_obj->vaddr)
-		dma_buf_vunmap_unlocked(etnaviv_obj->base.import_attach->dmabuf, &map);
-
 	/* Don't drop the pages for imported dmabuf, as they are not
 	 * ours, just free the array we allocated:
 	 */
@@ -88,6 +83,13 @@ static void *etnaviv_gem_prime_vmap_impl(struct etnaviv_gem_object *etnaviv_obj)
 	return map.vaddr;
 }
 
+static void etnaviv_gem_prime_vunmap(struct etnaviv_gem_object *etnaviv_obj)
+{
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(etnaviv_obj->vaddr);
+
+	dma_buf_vunmap_unlocked(etnaviv_obj->base.import_attach->dmabuf, &map);
+}
+
 static int etnaviv_gem_prime_mmap_obj(struct etnaviv_gem_object *etnaviv_obj,
 		struct vm_area_struct *vma)
 {
@@ -106,6 +108,7 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
 	/* .get_pages should never be called */
 	.release = etnaviv_gem_prime_release,
 	.vmap = etnaviv_gem_prime_vmap_impl,
+	.vunmap = etnaviv_gem_prime_vunmap,
 	.mmap = etnaviv_gem_prime_mmap_obj,
 };
 
-- 
2.43.0


