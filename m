Return-Path: <linux-kernel+bounces-568287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF64A6932F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CCF887BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0D1CAA60;
	Wed, 19 Mar 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="FX5Die6z"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B31C5F25
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397407; cv=pass; b=UpY1u1IGgkRuWD1r/aDRVf0O7Wgu+Wl+606tP2q/MxuLPRDxqmeGlZxgXc0bwicNUzxU9H2VqAcBk57F9+BwKmWFNxmloByWQuTSrKoavCDHYOmavMLEH8eY+L7fio37OZXLApHfV3mmlFXFkvcKQOiRlQpjF7/NW446Hnd39nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397407; c=relaxed/simple;
	bh=HBohCKx0FbhP5j83/79svXU8nC3RV1v/71CelX64fWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CF5ZWMqiyB6utJfHwAD6br7Uvs1odT9dmbYaE1CoxnQsO9GBLNX0uJTDJqDczNwjUutcZamzESUqN2Z2y4GrJZrLazLapnbQanuk/zrUNC0J2qXHt2riFZNc6Vbq7qI0eDJV3g2yijj9sk/cx/uwc8Ss1V8Slknj5mJ7vT8fwic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=FX5Die6z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742397387; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ntFeWacIa8Pm5kBFyE9gDw3v520b38EyCPJz1PEWj1GHDtxq6c6tNkqBJL5A7cLFUZbZecXqTif0Ycp870+8YRyOLldFzLj7jqLbZJW/Wux4Uo1YlbkkdBCzMw0F61lNm9iyRKRLCZ2nb5AjuEE3UM8/vUcnrxLdUKH3svYRyn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742397387; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OoIHyEJ5O0a0xme8HtC057nmgMH3xihc2B6OzxWGjfE=; 
	b=JycvFkmuUFsnxqSUFtlLhzaP6YSc2jRsdiTwh1R0xCexdfJdzaNoyVUZoqjZJ+tQGtiNwJTojh4DE0Gldt5OdbU+5RIp4x9z13ZAWqzz7UxSbUgEwcvqX37SCvpRU4q4MDFJAC/26vKXBV0I/r6Wg+6FVZjDtTFH6jA/h5i2dHc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742397387;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OoIHyEJ5O0a0xme8HtC057nmgMH3xihc2B6OzxWGjfE=;
	b=FX5Die6z2YofTaMsB+hrV171mcc66RGPrTlMeiT5OKfVTZn8G0vvObF5YPDckoAv
	a0aoOxXcCEuzaT9Y++RUKhQGrd9otLAN9d9zy9UWYnqYX6Njh1W8M2+Bo3JjL//41Fc
	spYz9Vn8sy2Qkao6dlLIddEpcQ/1vbL8NyeVfk8Y=
Received: by mx.zohomail.com with SMTPS id 17423973850171005.418058365657;
	Wed, 19 Mar 2025 08:16:25 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/panthor: Display heap chunk entries in DebugFS GEMS file
Date: Wed, 19 Mar 2025 15:03:19 +0000
Message-ID: <20250319150953.1634322-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319150953.1634322-1-adrian.larumbe@collabora.com>
References: <20250319150953.1634322-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Expand the driver's DebugFS GEMS file to display entries for the heap
chunks' GEM objects, both those allocated at heap creation time through an
ioctl(), or in response to a tiler OOM event.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c  | 22 +++++++++++-----------
 drivers/gpu/drm/panthor/panthor_gem.h  |  2 ++
 drivers/gpu/drm/panthor/panthor_heap.c |  3 +++
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index f7eb413d88e7..252979473fdf 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -22,16 +22,6 @@ static void panthor_gem_debugfs_bo_init(struct panthor_gem_object *bo)
 	get_task_comm(bo->gems.creator.process_name, current->group_leader);
 }
 
-static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo)
-{
-	struct panthor_device *ptdev =  container_of(bo->base.base.dev,
-						     struct panthor_device, base);
-
-	mutex_lock(&ptdev->gems.lock);
-	list_add_tail(&bo->gems.node, &ptdev->gems.node);
-	mutex_unlock(&ptdev->gems.lock);
-}
-
 static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo)
 {
 	struct panthor_device *ptdev = container_of(bo->base.base.dev,
@@ -44,10 +34,20 @@ static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo)
 	list_del_init(&bo->gems.node);
 	mutex_unlock(&ptdev->gems.lock);
 }
+
+void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo)
+{
+	struct panthor_device *ptdev =  container_of(bo->base.base.dev,
+						     struct panthor_device, base);
+
+	mutex_lock(&ptdev->gems.lock);
+	list_add_tail(&bo->gems.node, &ptdev->gems.node);
+	mutex_unlock(&ptdev->gems.lock);
+}
 #else
 static void panthor_gem_debugfs_bo_init(struct panthor_gem_object *bo) {}
-static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo) {}
 static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo) {}
+void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo) {}
 #endif
 
 static void panthor_gem_free_object(struct drm_gem_object *obj)
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 7c896ec35801..e132f14bbef8 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -132,6 +132,8 @@ panthor_gem_create_with_handle(struct drm_file *file,
 void panthor_gem_bo_set_label(struct drm_gem_object *obj, const char *label);
 void panthor_gem_kernel_bo_set_label(struct panthor_kernel_bo *bo, const char *label);
 
+void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo);
+
 static inline u64
 panthor_kernel_bo_gpuva(struct panthor_kernel_bo *bo)
 {
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index db0285ce5812..73cf43eb4a7b 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -180,6 +180,9 @@ static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
 	heap->chunk_count++;
 	mutex_unlock(&heap->lock);
 
+	panthor_gem_kernel_bo_set_label(chunk->bo, "\"Tiler heap chunk\"");
+	panthor_gem_debugfs_bo_add(to_panthor_bo(chunk->bo->obj));
+
 	return 0;
 
 err_destroy_bo:
-- 
2.48.1


