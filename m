Return-Path: <linux-kernel+bounces-300580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C716595E568
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D432B20D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5D1741C4;
	Sun, 25 Aug 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QblI4TTf"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121A1714C9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724620793; cv=none; b=t+SOkCm+T8jVuDHlW6QqqUdlghAxW1c1vmPAtxN+n2WQobQleOQJK/0DYYP7gGwVKc2crLY9M0NOVq2C0E9rxRlcUKiHoiJzkWMlctVok0hA/+xuJglEvkglgca5bZj1WHyMTawd/5dMIv1QOyLWdRSVNom+JZcvUyeAHuTwFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724620793; c=relaxed/simple;
	bh=lMPDa81MpIaIUs6xQN8hEL4XlLppQ/q04kvZUNAaocM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O8r7ogk+SD/kMYoISUA4wkGxz8utMKT+cLAKjo2RT6VPgklX4J5dtQH4A5UyL8012FxqlFUxCCpQB8RwgBL3r3/6nFh9EMFljwxXGEYRXNTlq0SH+Z9Yt4Ij37eaWqf/Zdq+lsr2NFShvpbmnfLv4xePxgPbyKCen5fDfQSUjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QblI4TTf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724620789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogar9z4VeZmACj/ASu3ikNYNZmFcsKAcCHFxO52WAEo=;
	b=QblI4TTfO9QDkkfg3tFSzDVrK/uv7gykV4VlKBCsVNodKnz8AuZD8cLpksKzDw3TSgTgNB
	QfqgQAtPRiJqMZnBfGvG1MYpytnnPFAo/ZlowVm3EZRHxumMPT6WiwjhecMaUIMSj7PDLt
	mOJV7tuYAhmXED/PxM023ElOCTgJmBo=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 2/2] drm/etnaviv: Export drm_gem_print_info() and use it
Date: Mon, 26 Aug 2024 05:19:29 +0800
Message-Id: <20240825211929.614631-3-sui.jingfeng@linux.dev>
In-Reply-To: <20240825211929.614631-1-sui.jingfeng@linux.dev>
References: <20240825211929.614631-1-sui.jingfeng@linux.dev>
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

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_gem.c             |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 11 ++++-------
 include/drm/drm_gem.h                 |  2 ++
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 9a688c95f34d..f2f446d46921 100644
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
2.34.1


