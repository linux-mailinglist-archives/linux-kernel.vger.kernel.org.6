Return-Path: <linux-kernel+bounces-320105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B42970643
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D01CB21A43
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA0130E27;
	Sun,  8 Sep 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AQ3VbPk1"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D221531F3
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788692; cv=none; b=b52UHFYirS3dGoM8NvNJYm0XEcio6LHzQr8n6ZgVccJQCZ6zm3hkfCPYPfMqpzOSSiQKPRG6810HWEUbb+92sBhHmylNph4toy4UhoDWYWLDb4VJ62xVjiV9ggYHJLmpGKAqzQPUoi8PINmgp+6Ehsdj8se0mlzDoDU7Li5DN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788692; c=relaxed/simple;
	bh=3ulOiIF00rbSHvWgubnm5m/xjLQLx811mMF2pD8aOZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD3lQoQlP9Zd51jhK8HYyVsMHQnQKAi6Vhz+qbE5CXY1pzbSq1jWQyiAyO4sggp89JRqTHgoyTrZthC1JvxPIdnqJzmaMic3Y1Rz0rI6opl0HSk3jiaEpKJ8gZjU2PZI2YRsUfzK44JJ2nXiPICN9zevkk73pAFBIo+VU4pbQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AQ3VbPk1; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRE8e20DZbCAFcEmLz6G0AQULv+W2WjKTcnEGoRHY1Y=;
	b=AQ3VbPk1yS5KMG1rGqkNp9zLJ35ZYxQyOirZjVP9t5ZIxUQCTplcuxCOoN5fwuIHXw8Xnw
	NCriqGMtnR5rU9mTjyZgNTC6ksxSJA95Xy+ilbx4lSEx2lH035EShssC440ly/scI8bmij
	zBON3Uof9I4i61yGGq9KABWzFgyvfrg=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 10/19] drm/etnaviv: Embed struct drm_device into struct etnaviv_drm_private
Date: Sun,  8 Sep 2024 17:43:48 +0800
Message-ID: <20240908094357.291862-11-sui.jingfeng@linux.dev>
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

Both the instance of struct drm_device and the instance of struct
etnaviv_drm_private are intended to be shared by all GPU cores, both have
only one instance created across drm/etnaviv driver. After embedded in,
the whole structure can be allocated with devm_drm_dev_alloc(). And the
DRM device created is automatically put on driver detach, so we don't need
to call drm_dev_put() explicitly on driver leave. It's also eliminate the
need to use the .dev_private member, which is deprecated according to the
drm document. We can also use container_of() to retrieve pointer for the
containing structure.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 65 ++++++++------------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        |  7 +++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c        |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c        |  6 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c        |  4 +-
 6 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 809e5db85df4..32ec1b5452ba 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -41,14 +41,9 @@ static struct device_node *etnaviv_of_first_available_node(void)
 	return NULL;
 }
 
-static struct etnaviv_drm_private *etnaviv_alloc_private(struct device *dev)
+static int etnaviv_private_init(struct device *dev,
+				struct etnaviv_drm_private *priv)
 {
-	struct etnaviv_drm_private *priv;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return ERR_PTR(-ENOMEM);
-
 	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
 
 	mutex_init(&priv->gem_lock);
@@ -58,15 +53,14 @@ static struct etnaviv_drm_private *etnaviv_alloc_private(struct device *dev)
 
 	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(dev);
 	if (IS_ERR(priv->cmdbuf_suballoc)) {
-		kfree(priv);
 		dev_err(dev, "Failed to create cmdbuf suballocator\n");
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
-	return priv;
+	return 0;
 }
 
-static void etnaviv_free_private(struct etnaviv_drm_private *priv)
+static void etnaviv_private_fini(struct etnaviv_drm_private *priv)
 {
 	if (!priv)
 		return;
@@ -76,13 +70,11 @@ static void etnaviv_free_private(struct etnaviv_drm_private *priv)
 	xa_destroy(&priv->active_contexts);
 
 	mutex_destroy(&priv->gem_lock);
-
-	kfree(priv);
 }
 
 static void load_gpu(struct drm_device *dev)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	unsigned int i;
 
 	for (i = 0; i < ETNA_MAX_PIPES; i++) {
@@ -100,7 +92,7 @@ static void load_gpu(struct drm_device *dev)
 
 static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct etnaviv_file_private *ctx;
 	int ret, i;
 
@@ -143,7 +135,7 @@ static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 
 static void etnaviv_postclose(struct drm_device *dev, struct drm_file *file)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct etnaviv_file_private *ctx = file->driver_priv;
 	unsigned int i;
 
@@ -168,7 +160,7 @@ static void etnaviv_postclose(struct drm_device *dev, struct drm_file *file)
 #ifdef CONFIG_DEBUG_FS
 static int etnaviv_gem_show(struct drm_device *dev, struct seq_file *m)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 
 	etnaviv_gem_describe_objects(priv, m);
 
@@ -262,7 +254,7 @@ static int show_each_gpu(struct seq_file *m, void *arg)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct etnaviv_gpu *gpu;
 	int (*show)(struct etnaviv_gpu *gpu, struct seq_file *m) =
 			node->info_ent->data;
@@ -305,7 +297,7 @@ static void etnaviv_debugfs_init(struct drm_minor *minor)
 static int etnaviv_ioctl_get_param(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_etnaviv_param *args = data;
 	struct etnaviv_gpu *gpu;
 
@@ -398,7 +390,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
 	struct drm_etnaviv_wait_fence *args = data;
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_etnaviv_timespec *timeout = &args->timeout;
 	struct etnaviv_gpu *gpu;
 
@@ -446,7 +438,7 @@ static int etnaviv_ioctl_gem_userptr(struct drm_device *dev, void *data,
 static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 	struct drm_file *file)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_etnaviv_gem_wait *args = data;
 	struct drm_etnaviv_timespec *timeout = &args->timeout;
 	struct drm_gem_object *obj;
@@ -480,7 +472,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 static int etnaviv_ioctl_pm_query_dom(struct drm_device *dev, void *data,
 	struct drm_file *file)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_etnaviv_pm_domain *args = data;
 	struct etnaviv_gpu *gpu;
 
@@ -497,7 +489,7 @@ static int etnaviv_ioctl_pm_query_dom(struct drm_device *dev, void *data,
 static int etnaviv_ioctl_pm_query_sig(struct drm_device *dev, void *data,
 	struct drm_file *file)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_etnaviv_pm_signal *args = data;
 	struct etnaviv_gpu *gpu;
 
@@ -556,17 +548,14 @@ static int etnaviv_bind(struct device *dev)
 	struct drm_device *drm;
 	int ret;
 
-	drm = drm_dev_alloc(&etnaviv_drm_driver, dev);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
+	priv = devm_drm_dev_alloc(dev, &etnaviv_drm_driver,
+				  struct etnaviv_drm_private, drm);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
-	priv = etnaviv_alloc_private(dev);
-	if (IS_ERR(priv)) {
-		ret = PTR_ERR(priv);
-		goto out_put;
-	}
+	etnaviv_private_init(dev, priv);
 
-	drm->dev_private = priv;
+	drm = &priv->drm;
 
 	dma_set_max_seg_size(dev, SZ_2G);
 
@@ -587,9 +576,7 @@ static int etnaviv_bind(struct device *dev)
 out_unbind:
 	component_unbind_all(dev, drm);
 out_free_priv:
-	etnaviv_free_private(priv);
-out_put:
-	drm_dev_put(drm);
+	etnaviv_private_fini(priv);
 
 	return ret;
 }
@@ -597,17 +584,13 @@ static int etnaviv_bind(struct device *dev)
 static void etnaviv_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct etnaviv_drm_private *priv = drm->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(drm);
 
 	drm_dev_unregister(drm);
 
 	component_unbind_all(dev, drm);
 
-	etnaviv_free_private(priv);
-
-	drm->dev_private = NULL;
-
-	drm_dev_put(drm);
+	etnaviv_private_fini(priv);
 }
 
 static const struct component_master_ops etnaviv_master_ops = {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index c217b54b214c..e2a991160cb3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -35,6 +35,7 @@ struct etnaviv_file_private {
 };
 
 struct etnaviv_drm_private {
+	struct drm_device drm;
 	int num_gpus;
 	struct etnaviv_gpu *gpu[ETNA_MAX_PIPES];
 	gfp_t shm_gfp_mask;
@@ -50,6 +51,12 @@ struct etnaviv_drm_private {
 	struct list_head gem_list;
 };
 
+static inline struct etnaviv_drm_private *
+to_etnaviv_priv(struct drm_device *ddev)
+{
+	return container_of(ddev, struct etnaviv_drm_private, drm);
+}
+
 int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index b899aea64e22..39cfece67b90 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -587,7 +587,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 
 void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 
 	mutex_lock(&priv->gem_lock);
@@ -687,7 +687,7 @@ static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
 int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	u32 size, u32 flags, u32 *handle)
 {
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_gem_object *obj = NULL;
 	int ret;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 3c0a5c3e0e3d..b0ac0b5bd675 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -412,7 +412,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
 	struct etnaviv_file_private *ctx = file->driver_priv;
-	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct drm_etnaviv_gem_submit *args = data;
 	struct drm_etnaviv_gem_submit_reloc *relocs;
 	struct drm_etnaviv_gem_submit_pmr *pmrs;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index eca6a06e9ade..0c8e394b569c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -38,7 +38,7 @@ static const struct platform_device_id gpu_ids[] = {
 
 int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 {
-	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(gpu->drm);
 
 	switch (param) {
 	case ETNAVIV_PARAM_GPU_MODEL:
@@ -789,7 +789,7 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 {
-	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(gpu->drm);
 	dma_addr_t cmdbuf_paddr;
 	int ret, i;
 
@@ -1783,7 +1783,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	void *data)
 {
 	struct drm_device *drm = data;
-	struct etnaviv_drm_private *priv = drm->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(drm);
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
 	int ret;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index ed6c42384856..5be0bb6a3f02 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -493,7 +493,7 @@ void etnaviv_iommu_dump(struct etnaviv_iommu_context *context, void *buf)
 int etnaviv_iommu_global_init(struct etnaviv_gpu *gpu)
 {
 	enum etnaviv_iommu_version version = ETNAVIV_IOMMU_V1;
-	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(gpu->drm);
 	struct etnaviv_iommu_global *global;
 	struct device *dev = gpu->drm->dev;
 
@@ -553,7 +553,7 @@ int etnaviv_iommu_global_init(struct etnaviv_gpu *gpu)
 
 void etnaviv_iommu_global_fini(struct etnaviv_gpu *gpu)
 {
-	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(gpu->drm);
 	struct etnaviv_iommu_global *global = priv->mmu_global;
 
 	if (!global)
-- 
2.43.0


