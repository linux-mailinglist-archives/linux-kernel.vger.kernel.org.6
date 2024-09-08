Return-Path: <linux-kernel+bounces-320100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44897063A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2310A1F220B9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789D914E2DE;
	Sun,  8 Sep 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aYft2ie4"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C514884E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788674; cv=none; b=svk8ibUEJUCQyhmNqhh0u14oXk5a2/hQes9bFIES3GIV6OYiVFxs4cMgYr9sni1bypAWj0WpxoWhYa9BXWilMNQoBvZB+AIgV1st/19FkO33qAWZnACO+nq8KNzucXnGXF7WbyzlCmmfK+XwqH/fvmJrcT61e4DTaQ2QfyHg6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788674; c=relaxed/simple;
	bh=8udDBEs/QMJEGiGDbQGzwMgHVgJniZfGX4VYK9PUK7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuP0Dx8xEhpgEj+X42psDaNZHYTDQDmoNfayJQ0CZls2qgH0Ea4rzFWiHCGYuwgmJ6gz0JcIXWjYdm9AhiC1y5kbvP5rgLqzzEjjY3kdfd2hYoUY8ZBI77+gUCSVOimNvcy3ivz6M91FS3Oc8spAnyDfTBcu1PeNskm622MpvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aYft2ie4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3i0Qkav+uGheS0I6+IVKOcBuz/JMJb9z/Pxg/0ZYF0=;
	b=aYft2ie4Ojp5cuHgcCRMmTH+yy7GPxmjH0KBjNFz9DbSnppcH+WXEPtsccJshQoG8Q6GWK
	/kMJuU4JHUy+CLo/z7xoVxaXexNiNo4cc5W588SkvZhHGzN9f8zsoUqvnYAYfFaOaTe9Px
	2snFKYverFv/Ds63RTjt6W6ZcU+rbkY=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 05/19] drm/etnaviv: Add contructor and destructor for etnaviv_gem_get_mapping structure
Date: Sun,  8 Sep 2024 17:43:43 +0800
Message-ID: <20240908094357.291862-6-sui.jingfeng@linux.dev>
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

Because this make the code more easier to understand, When GPU access the
VRAM, it will allocate a new mapping to use if there don't have one.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 40 +++++++++++++++++++--------
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  6 ++++
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 85d4e7c87a6a..55004fa9fabd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -227,6 +227,30 @@ etnaviv_gem_get_vram_mapping(struct etnaviv_gem_object *obj,
 	return NULL;
 }
 
+static struct etnaviv_vram_mapping *
+etnaviv_gem_vram_mapping_new(struct etnaviv_gem_object *etnaviv_obj)
+{
+	struct etnaviv_vram_mapping *mapping;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping)
+		return NULL;
+
+	INIT_LIST_HEAD(&mapping->scan_node);
+	mapping->object = etnaviv_obj;
+	mapping->use = 1;
+
+	list_add_tail(&mapping->obj_node, &etnaviv_obj->vram_list);
+
+	return mapping;
+}
+
+static void etnaviv_gem_vram_mapping_destroy(struct etnaviv_vram_mapping *mapping)
+{
+	list_del(&mapping->obj_node);
+	kfree(mapping);
+}
+
 void etnaviv_gem_mapping_unreference(struct etnaviv_vram_mapping *mapping)
 {
 	struct etnaviv_gem_object *etnaviv_obj = mapping->object;
@@ -289,27 +313,20 @@ struct etnaviv_vram_mapping *etnaviv_gem_mapping_get(
 	 */
 	mapping = etnaviv_gem_get_vram_mapping(etnaviv_obj, NULL);
 	if (!mapping) {
-		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+		mapping = etnaviv_gem_vram_mapping_new(etnaviv_obj);
 		if (!mapping) {
 			ret = -ENOMEM;
 			goto out;
 		}
-
-		INIT_LIST_HEAD(&mapping->scan_node);
-		mapping->object = etnaviv_obj;
 	} else {
-		list_del(&mapping->obj_node);
+		mapping->use = 1;
 	}
 
-	mapping->use = 1;
-
 	ret = etnaviv_iommu_map_gem(mmu_context, etnaviv_obj,
 				    mmu_context->global->memory_base,
 				    mapping, va);
 	if (ret < 0)
-		kfree(mapping);
-	else
-		list_add_tail(&mapping->obj_node, &etnaviv_obj->vram_list);
+		etnaviv_gem_vram_mapping_destroy(mapping);
 
 out:
 	mutex_unlock(&etnaviv_obj->lock);
@@ -544,8 +561,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 		if (context)
 			etnaviv_iommu_unmap_gem(context, mapping);
 
-		list_del(&mapping->obj_node);
-		kfree(mapping);
+		etnaviv_gem_vram_mapping_destroy(mapping);
 	}
 
 	etnaviv_obj->ops->vunmap(etnaviv_obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index d4965de3007c..f2ac64d8e90b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -31,6 +31,12 @@ struct etnaviv_vram_mapping {
 	u32 iova;
 };
 
+static inline struct etnaviv_vram_mapping *
+to_etnaviv_vram_mapping(struct drm_mm_node *vram)
+{
+	return container_of(vram, struct etnaviv_vram_mapping, vram_node);
+}
+
 struct etnaviv_gem_object {
 	struct drm_gem_object base;
 	const struct etnaviv_gem_ops *ops;
-- 
2.43.0


