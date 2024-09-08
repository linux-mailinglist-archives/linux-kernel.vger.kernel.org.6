Return-Path: <linux-kernel+bounces-320112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3897064A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A872829ED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA615B125;
	Sun,  8 Sep 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbyS3Zit"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8215A86E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788715; cv=none; b=bD2FwAU9pTdaAjFx4JqCvq5Om2RQ2cTv1+vKvplslApVzj8eQYJjvZWr5kjMeD7GFmAtpIqMsCt6ejXP3jLvrc/HVZwdxCk+/5yp1qywwEziFOwUiK+7/mYpp2OK9s5S0BB2+1DqW30xYebuvHP+MaY6qqr03rIKnXjVsJ/i2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788715; c=relaxed/simple;
	bh=mhdZKgkDjjOXCYMTMQQZVLn9A6wMD1LMKqUwdV1elcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYFSj3r6Xis6oUGBqvNM/sGBmadEYrrNLl+M0vvJDOh8WgMApD6XFMwN3JRMg8aKFXWqyAG1Qs9n46ATnjR84IXFxwpxhEJh7LmbMTeHn15S35W38XL5FdHziwOVtSC8IAHu3o0yD38lCT1Wp9fnlfgqVhy04ZcjSgoxfmkgrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JbyS3Zit; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC6Iju8dIkyfpy9CDYJG0kJXm9WJsC4dOo5lTDlPg4g=;
	b=JbyS3ZitulW+NewFD4u6nKGUJ6mpepK0hTLF3j0ysTLG2gMvwSVg9d/saoeplK/mb2Gw6n
	CgUdW8k44qwGjb8mEhS5O4pfqARHQgo0pZu3zZyBxJ8PNZH5ll7mFDG4d9TbPVUNIYeUro
	cyxTi/pN1u/oQ7vj4mJMTwatn4SAgnQ=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 16/19] drm/etnaviv: Call etnaviv_gem_obj_add() in ernaviv_gem_new_private()
Date: Sun,  8 Sep 2024 17:43:54 +0800
Message-ID: <20240908094357.291862-17-sui.jingfeng@linux.dev>
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

The etnaviv_gem_obj_add() a common operation, the 'etnaviv_drm_private::
gem_list' is being used to record(track) all of the etnaviv GEM buffer
object created in this driver.

Once a etnaviv GEM buffer object has been allocated successfully, we
should add it into the global etnaviv_drm_private::gem_list'. Because
we need to free it and remove it free the list if the invoke of the
subsequent functions fail.

The only way that destroy etnaviv GEM buffer object is the implementation
of etnaviv_gem_free_object() function. The etnaviv_gem_free_object() first
remove the etnaviv GEM object from the list, then destroy its mapping and
finally free its memory footprint. Therefore, in order to corresponding
this, we add the freshly created etnaviv GEM buffer object immediately
after it was successfully created.

A benifit is that we only need to call etnaviv_gem_obj_add() once now,
since the ernaviv_gem_new_private() has been unified. Make the
etnaviv_gem_obj_add() static is a next nature thing.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 8 +++-----
 drivers/gpu/drm/etnaviv/etnaviv_gem.h       | 1 -
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 --
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 27e4a93c981c..ee799c02d0aa 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -584,7 +584,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 	kfree(etnaviv_obj);
 }
 
-void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
+static void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
 {
 	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
@@ -719,8 +719,6 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	 */
 	mapping_set_gfp_mask(obj->filp->f_mapping, priv->shm_gfp_mask);
 
-	etnaviv_gem_obj_add(dev, obj);
-
 	ret = drm_gem_handle_create(file, obj, handle);
 
 	/* drop reference from allocate - handle holds it now */
@@ -751,6 +749,8 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 		drm_gem_private_object_init(dev, obj, size);
 	}
 
+	etnaviv_gem_obj_add(dev, obj);
+
 	*res = to_etnaviv_bo(obj);
 
 	return 0;
@@ -849,8 +849,6 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, struct drm_file *file,
 	etnaviv_obj->userptr.mm = current->mm;
 	etnaviv_obj->userptr.ro = !(flags & ETNA_USERPTR_WRITE);
 
-	etnaviv_gem_obj_add(dev, &etnaviv_obj->base);
-
 	ret = drm_gem_handle_create(file, &etnaviv_obj->base, handle);
 
 	/* drop reference from allocate - handle holds it now */
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index b174a9e4cc48..8d8fc5b3a541 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -121,7 +121,6 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 			    bool shmem, const struct etnaviv_gem_ops *ops,
 			    struct etnaviv_gem_object **res);
 
-void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj);
 struct page **etnaviv_gem_get_pages(struct etnaviv_gem_object *obj);
 void etnaviv_gem_put_pages(struct etnaviv_gem_object *obj);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 64a858a0b0cf..04ee31461b8c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -127,8 +127,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
-	etnaviv_gem_obj_add(dev, &etnaviv_obj->base);
-
 	return &etnaviv_obj->base;
 
 fail:
-- 
2.43.0


