Return-Path: <linux-kernel+bounces-382604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86719B10F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798A51F210CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4DC21E603;
	Fri, 25 Oct 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RMf1+1cU"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589121B869
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889067; cv=none; b=o0nLbzR0YsmG+5eeou6TxEth9Uk+HqnLb9J6yWBYnTiAwXub5ZiZ6X+Y+amOyYwDf3ylFuJuDso4oovMkhBbC3psnaf2WWkcqACNVRc07Q/tX2+GHbJ6asvD8c+u+yFEnyVi724nBonYSwiZzIAqetIQu9n/zK7dFKkH5aKp5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889067; c=relaxed/simple;
	bh=1lo+2ZAWIVTEzvTgK6f3rEjm39eSxI9TvPWMmnp0I9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFDjzwdDaiFGiZ3C1MCm3aXgSbP8psq66kltSNqBMN1JrCXyVGBe8bOApyiSIlxw20xG1Ot4bPQHMeo+/jXhNK9Ga/VYR04MWSHN1l/DymrIWr+94IZJcr5THG9cbrVEkafTaFhG7ABsUhmlypTVslFjWTTqY2LuY8Qdp5F3Ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RMf1+1cU; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729889062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eq6rCpBAPmzmyxJglOaWNSiBf8ToRPx9PYPV/1RZ4g=;
	b=RMf1+1cUzaAn7JLUa/8/psmRY+Z1jlrGLLsBvMdFK0dgZne5gxZWRpNg4QbaYKIgaarx4O
	pEmqUhjhmwd7obKJTR6jQBYn82Ky73sO2FO7vyiXYVRe0cYEWoL4kD7QZgVbpYCRyE9fJI
	GxMHVIps7t0GYwTK5l7ExPmfbCAASMo=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v2 1/2] drm/etnaviv: Record GPU visible size of GEM BO separately
Date: Sat, 26 Oct 2024 04:43:54 +0800
Message-Id: <20241025204355.595805-2-sui.jingfeng@linux.dev>
In-Reply-To: <20241025204355.595805-1-sui.jingfeng@linux.dev>
References: <20241025204355.595805-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The GPU visible size of a GEM BO is not necessarily PAGE_SIZE aligned,
which happens when CPU page size is not equal to GPU page size. Extra
precious resources such as GPU page tables and GPU TLBs may being paid
because of this but never get used.

Track the size of GPU visible part of GEM BO separately, ensure no
GPUVA range wasting by aligning that size to GPU page size.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 11 +++++------
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  5 +++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5c0c9d4e3be1..fabcaa3b9b25 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -543,7 +543,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
 	.vm_ops = &vm_ops,
 };
 
-static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
+static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
 	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
 {
 	struct etnaviv_gem_object *etnaviv_obj;
@@ -570,6 +570,7 @@ static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
 	if (!etnaviv_obj)
 		return -ENOMEM;
 
+	etnaviv_obj->size = ALIGN(size, SZ_4K);
 	etnaviv_obj->flags = flags;
 	etnaviv_obj->ops = ops;
 
@@ -590,15 +591,13 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	struct drm_gem_object *obj = NULL;
 	int ret;
 
-	size = PAGE_ALIGN(size);
-
-	ret = etnaviv_gem_new_impl(dev, flags, &etnaviv_gem_shmem_ops, &obj);
+	ret = etnaviv_gem_new_impl(dev, size, flags, &etnaviv_gem_shmem_ops, &obj);
 	if (ret)
 		goto fail;
 
 	lockdep_set_class(&to_etnaviv_bo(obj)->lock, &etnaviv_shm_lock_class);
 
-	ret = drm_gem_object_init(dev, obj, size);
+	ret = drm_gem_object_init(dev, obj, PAGE_ALIGN(size));
 	if (ret)
 		goto fail;
 
@@ -627,7 +626,7 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 	struct drm_gem_object *obj;
 	int ret;
 
-	ret = etnaviv_gem_new_impl(dev, flags, ops, &obj);
+	ret = etnaviv_gem_new_impl(dev, size, flags, ops, &obj);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index a42d260cac2c..687555aae807 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -36,6 +36,11 @@ struct etnaviv_gem_object {
 	const struct etnaviv_gem_ops *ops;
 	struct mutex lock;
 
+	/*
+	 * The actual size that is visible to the GPU, not necessarily
+	 * PAGE_SIZE aligned, but should be aligned to GPU page size.
+	 */
+	u32 size;
 	u32 flags;
 
 	struct list_head gem_node;
-- 
2.34.1


