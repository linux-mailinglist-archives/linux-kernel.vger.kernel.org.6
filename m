Return-Path: <linux-kernel+bounces-320099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA77970633
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B801F21E10
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6214D446;
	Sun,  8 Sep 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hg8p6HW5"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9D13BC39
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788670; cv=none; b=Bok4ON7jA+do/PgYRt6ewciVYbQDgTsHn4dVJuzkxkt7WiKy3rlitEU8+JcW55cI6rU2Vs42NF+hEwikdDt6IgkipLSxZqfisiSjU64sZsXxA7YHVQMRL50ZHxnUTCWwHY7QYUu3bEKQ3a6vqWiB9j/3k8KDV0hf+HoQ414FmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788670; c=relaxed/simple;
	bh=CsYeF6dWxk5pi/crckmAjxGFUereM+Mu+M5ywmdWOiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4nUFDzlCh90WiycSdwjTCyS+1rR1ih/3XdCptYqilfRtEm1kVxzwbMYalaVBDmYuAiqNeRZ5Lsn13yuZ2S449vtpco1DG5qMLcvw8FfYsNXSOkbHcrZeQuKaJGhlnzwDXqCGVXIAzVmoQK2sG75Hy1Stq8TCNpZZFC8tmT3rFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hg8p6HW5; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8+bRUeYLN+duimZn4wCTyDb7WIhvWyv4ivpIGwW0Es=;
	b=Hg8p6HW5by4RU16hr7kOgk3V0dePpc6+VwJt4kz/pc+ViK6JLIcpuH+oomitAsb3N47R19
	d4AiNFUybLDk8gUL1NhhqXIcCjZZsRph2Y3k0N6eENqlskQD5hknCSBd9vFhV9NfTG5S5Q
	tmWsOZGiheg+hvRzJPcG1XZpDHWPDnU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 04/19] drm/etnaviv: Make etnaviv_gem_prime_vmap() a static function
Date: Sun,  8 Sep 2024 17:43:42 +0800
Message-ID: <20240908094357.291862-5-sui.jingfeng@linux.dev>
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

The etnaviv_gem_prime_vmap() function has no caller in the
etnaviv_gem_prime.c file, move it into etnaviv_gem.c file.
While at it, rename it as etnaviv_gem_object_vmap(), since
it is a intermidiate layer function, it has no direct relation
ship with the PRIME. The etnaviv_gem_prime.c file already has
etnaviv_gem_prime_vmap_impl() as the implementation to vmap
a imported GEM buffer object.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  1 -
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 16 +++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 12 ------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 2eb2ff13f6e8..c217b54b214c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -55,7 +55,6 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset);
 struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj);
-int etnaviv_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 	struct dma_buf_attachment *attach, struct sg_table *sg);
 int etnaviv_gem_prime_pin(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index fad23494d08e..85d4e7c87a6a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -6,6 +6,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_prime.h>
 #include <linux/dma-mapping.h>
+#include <linux/iosys-map.h>
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
@@ -340,6 +341,19 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 	return etnaviv_obj->vaddr;
 }
 
+static int etnaviv_gem_object_vmap(struct drm_gem_object *obj,
+				   struct iosys_map *map)
+{
+	void *vaddr;
+
+	vaddr = etnaviv_gem_vmap(obj);
+	if (!vaddr)
+		return -ENOMEM;
+	iosys_map_set_vaddr(map, vaddr);
+
+	return 0;
+}
+
 void etnaviv_gem_vunmap(struct drm_gem_object *obj)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
@@ -595,7 +609,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
 	.pin = etnaviv_gem_prime_pin,
 	.unpin = etnaviv_gem_prime_unpin,
 	.get_sg_table = etnaviv_gem_prime_get_sg_table,
-	.vmap = etnaviv_gem_prime_vmap,
+	.vmap = etnaviv_gem_object_vmap,
 	.vunmap = etnaviv_gem_object_vunmap,
 	.mmap = etnaviv_gem_mmap,
 	.vm_ops = &vm_ops,
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index bea50d720450..8f523cbee60a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -25,18 +25,6 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	return drm_prime_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
 }
 
-int etnaviv_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
-{
-	void *vaddr;
-
-	vaddr = etnaviv_gem_vmap(obj);
-	if (!vaddr)
-		return -ENOMEM;
-	iosys_map_set_vaddr(map, vaddr);
-
-	return 0;
-}
-
 int etnaviv_gem_prime_pin(struct drm_gem_object *obj)
 {
 	if (!obj->import_attach) {
-- 
2.43.0


