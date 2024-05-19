Return-Path: <linux-kernel+bounces-183154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C618C9550
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF13D281C92
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C504501B;
	Sun, 19 May 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VbX3EKrj"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D384D59E
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137684; cv=none; b=R59XRfsKrLbXQOVxVWj/rxmXLV/ffba4ReNmslTS5TmfAJO9utsGEGxD9XmUBuj7Sf/bG32wlhIkMoBdI2eqdXWMGC+3jiM4cAVcnb3ZaUOrSs4CEvbjlni9gW1cHh8tSsOuuzLZqYu1zgXi6qdkGgp8fKkLpffCNYRbJjghMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137684; c=relaxed/simple;
	bh=wR1Emg5c1AEbhI0Kq+IKHKxn5JDqxreiWkqApwdFmSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdLlLkGYECi1KWRt64oP8rtGz8FTlbrXolw2eEiB5QzBcGm/HN/kuUegbt3Y43p5lTb5TftHv/U0gGRG9e0Uyh+oxm/AqQlgD54g3NSHkN8EkgJLvCxh7G4LiIuryZO37nHHAlh2xrWg6k8EpX8GNZuDZAS6l0d9wp3J+l1BFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VbX3EKrj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: l.stach@pengutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716137680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YtsLv1p6v4P1MxchPcntfjjhkynHWMpb0L7dfEcquM=;
	b=VbX3EKrjaOG7ZwnS1SiavbEPVj/M3ojTFP9zSfpO1gt39s+/LE9xIJvPB6g7AZEWoQ3xb/
	Qm4nYdqPISQJe00FXgyOPRHTYacBeU3tMhtdwpnjbUINSzYnfEzdXGUvzxuc854urpRaPZ
	vJ+rb2k3DRJUnik1wC/2ld4+HZjLFjc=
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
Subject: [etnaviv-next v14 2/8] drm/etnaviv: Add constructor and destructor for the etnaviv_drm_private structure
Date: Mon, 20 May 2024 00:53:15 +0800
Message-Id: <20240519165321.2123356-3-sui.jingfeng@linux.dev>
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

Because there are a lot of data members in the struct etnaviv_drm_private,
which are intended to be shared by all GPU cores. It can be lengthy and
daunting on error handling, the 'gem_lock' of struct etnaviv_drm_private
just be forgeten to destroy on driver leave.

Switch to use the dedicated helpers introduced, etnaviv_bind() and
etnaviv_unbind() gets simplified. Another potential benefit is that
we could put the struct drm_device into struct etnaviv_drm_private
in the future, which made them share the same life time.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 72 +++++++++++++++++----------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..22c78bc944c4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -41,6 +41,45 @@ static struct device_node *etnaviv_of_first_available_node(void)
 	return NULL;
 }
 
+static struct etnaviv_drm_private *etnaviv_alloc_private(struct device *dev)
+{
+	struct etnaviv_drm_private *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
+
+	mutex_init(&priv->gem_lock);
+	INIT_LIST_HEAD(&priv->gem_list);
+	priv->num_gpus = 0;
+	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(dev);
+	if (IS_ERR(priv->cmdbuf_suballoc)) {
+		kfree(priv);
+		dev_err(dev, "Failed to create cmdbuf suballocator\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return priv;
+}
+
+static void etnaviv_free_private(struct etnaviv_drm_private *priv)
+{
+	if (!priv)
+		return;
+
+	mutex_destroy(&priv->gem_lock);
+
+	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
+
+	xa_destroy(&priv->active_contexts);
+
+	kfree(priv);
+}
+
 static void load_gpu(struct drm_device *dev)
 {
 	struct etnaviv_drm_private *priv = dev->dev_private;
@@ -521,35 +560,21 @@ static int etnaviv_bind(struct device *dev)
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "failed to allocate private data\n");
-		ret = -ENOMEM;
+	priv = etnaviv_alloc_private(dev);
+	if (IS_ERR(priv)) {
+		ret = PTR_ERR(priv);
 		goto out_put;
 	}
+
 	drm->dev_private = priv;
 
 	dma_set_max_seg_size(dev, SZ_2G);
 
-	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
-
-	mutex_init(&priv->gem_lock);
-	INIT_LIST_HEAD(&priv->gem_list);
-	priv->num_gpus = 0;
-	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-
-	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
-	if (IS_ERR(priv->cmdbuf_suballoc)) {
-		dev_err(drm->dev, "Failed to create cmdbuf suballocator\n");
-		ret = PTR_ERR(priv->cmdbuf_suballoc);
-		goto out_free_priv;
-	}
-
 	dev_set_drvdata(dev, drm);
 
 	ret = component_bind_all(dev, drm);
 	if (ret < 0)
-		goto out_destroy_suballoc;
+		goto out_free_priv;
 
 	load_gpu(drm);
 
@@ -561,10 +586,8 @@ static int etnaviv_bind(struct device *dev)
 
 out_unbind:
 	component_unbind_all(dev, drm);
-out_destroy_suballoc:
-	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 out_free_priv:
-	kfree(priv);
+	etnaviv_free_private(priv);
 out_put:
 	drm_dev_put(drm);
 
@@ -580,12 +603,9 @@ static void etnaviv_unbind(struct device *dev)
 
 	component_unbind_all(dev, drm);
 
-	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
-
-	xa_destroy(&priv->active_contexts);
+	etnaviv_free_private(priv);
 
 	drm->dev_private = NULL;
-	kfree(priv);
 
 	drm_dev_put(drm);
 }
-- 
2.34.1


