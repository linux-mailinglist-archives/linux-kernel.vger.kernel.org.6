Return-Path: <linux-kernel+bounces-320097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A15970624
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F6A28291C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A714B96D;
	Sun,  8 Sep 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOyFPiJ5"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68C1422B1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788662; cv=none; b=Ok7vW9Q6vWmRal6Jlz4oK0UpSWCiqKIY4r7LcripxOCF86QluO/V3ny6ARQ6NULtAUTID0fuPDg0xVJTdrAe6YCEGX0+akgT2GCjr0mr7Ph6icfX4P7w0fIrGcyurVnm4oh4pE7VF45nSXQUG+wIbDfZupzIyAaCjYtKoe/YX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788662; c=relaxed/simple;
	bh=KG2FE15vha8sk8N5r17aurvJRPfYLFmQ9reZGjJP1xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TggI1pFgqP/8v72IBO0PVoB8PvXtkZK8eK2EOlVQT+fXR0HEX+zWlfTU8kOJHSJu+gk6L52UG/Fhjk3+2qfGeGXqqPYHH2fUdhKPdTSobmb2CznEslCgjnIsNW+fB0poTAOCmKSRhXp086klixs+Mjb7JUi99lN/Pmffz3r4hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOyFPiJ5; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RcPWyabfuABUYsNHHZ6PMoliYgmVyqBgeC1D6O8C5Q=;
	b=EOyFPiJ5ymhox6QaGq59jr24sqM6ybWvlt6+Wt8DXf8U9mks4TwtOkCj3uZoGtQiu5fXin
	RDk1T0d8SiVVog24ulFOBz6i3FWQf14U1MC/GcE5kfezdrLSENolx8FEi+R7SCrgR2HnKQ
	R/G4uajbi9MZlvWKOQhC17Z6xSLpjDg=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 02/19] drm/etnaviv: Export drm_gem_print_info() and use it
Date: Sun,  8 Sep 2024 17:43:40 +0800
Message-ID: <20240908094357.291862-3-sui.jingfeng@linux.dev>
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

This will make the newly implemented etnaviv_gem_object_funcs::print_info
get in use, which improves code sharing and simplifies debugfs. Achieve
better humen readability for debug log.

Use container_of_const() if 'struct etnaviv_gem_object *etnaviv_obj' is a
constant pointer.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_gem.c             |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 13 +++++--------
 include/drm/drm_gem.h                 |  2 ++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index d4bbc5d109c8..9c5c971c1b23 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1160,6 +1160,7 @@ void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
 	if (obj->funcs->print_info)
 		obj->funcs->print_info(p, indent, obj);
 }
+EXPORT_SYMBOL(drm_gem_print_info);
 
 int drm_gem_pin_locked(struct drm_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 543d881585b3..6bdf72cd9e85 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015-2018 Etnaviv Project
  */
 
+#include <drm/drm_gem.h>
 #include <drm/drm_prime.h>
 #include <linux/dma-mapping.h>
 #include <linux/shmem_fs.h>
@@ -432,15 +433,11 @@ int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
 #ifdef CONFIG_DEBUG_FS
 static void etnaviv_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
 {
-	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
+	struct drm_printer p = drm_seq_file_printer(m);
 	struct dma_resv *robj = obj->resv;
-	unsigned long off = drm_vma_node_start(&obj->vma_node);
 	int r;
 
-	seq_printf(m, "%08x: %c %2d (%2d) %08lx %p %zd\n",
-			etnaviv_obj->flags, is_active(etnaviv_obj) ? 'A' : 'I',
-			obj->name, kref_read(&obj->refcount),
-			off, etnaviv_obj->vaddr, obj->size);
+	drm_gem_print_info(&p, 1, obj);
 
 	r = dma_resv_lock(robj, NULL);
 	if (r)
@@ -461,7 +458,7 @@ void etnaviv_gem_describe_objects(struct etnaviv_drm_private *priv,
 	list_for_each_entry(etnaviv_obj, &priv->gem_list, gem_node) {
 		struct drm_gem_object *obj = &etnaviv_obj->base;
 
-		seq_puts(m, "   ");
+		seq_printf(m, "obj[%d]:\n", count);
 		etnaviv_gem_describe(obj, m);
 		count++;
 		size += obj->size;
@@ -556,7 +553,7 @@ static void etnaviv_gem_object_info(struct drm_printer *p,
 {
 	const struct etnaviv_gem_object *etnaviv_obj;
 
-	etnaviv_obj = container_of(obj, struct etnaviv_gem_object, base);
+	etnaviv_obj = container_of_const(obj, struct etnaviv_gem_object, base);
 
 	drm_printf_indent(p, indent, "caching mode=%s\n",
 			  etnaviv_gem_obj_caching_info(etnaviv_obj->flags));
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index bae4865b2101..0791566fab53 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -480,6 +480,8 @@ void drm_gem_vm_close(struct vm_area_struct *vma);
 int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 		     struct vm_area_struct *vma);
 int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
+			const struct drm_gem_object *obj);
 
 /**
  * drm_gem_object_get - acquire a GEM buffer object reference
-- 
2.43.0


