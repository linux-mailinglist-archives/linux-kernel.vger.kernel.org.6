Return-Path: <linux-kernel+bounces-398175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F09BE6E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D2D1F280D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830CB1DF25B;
	Wed,  6 Nov 2024 12:08:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7E1DE3B8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894881; cv=none; b=iSm4bs0Rqk7gE5H9qW3M+I2iBCNyiEHmc9dZQL+o/EjY6u+747P8Am6uTFlnQb62OcH9wQY01iludepL2w9mYjnk4KiO419hdBFv2yxaMWxJkJmNjFt31xI8tyFS0WNbCgyW8WkBD+HON0ewrBSJlEq+xzl6m3iYv/CUZ4dKMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894881; c=relaxed/simple;
	bh=8ZGc1rWCj31AYBeG4gqEbu/2d2WWKvicGYXq95kXseg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mm6YIjRqGDWVMzNosJ9bWZ8hATUwXbHRTUAHkeDm6+WUDHfZ2/K9/DKXqb+8chr2uyGRacy7XxCiWv/QB/PNVGaa/UQFhmdVcXb/NQmLrhYG1yCTwhz1Kjzo+kZuSdHE/Kw/DHu4k7+JgF55WUhoeKhilsFV6RNWe3WHkt/801A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAB551063;
	Wed,  6 Nov 2024 04:08:27 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74AF03F6A8;
	Wed,  6 Nov 2024 04:07:56 -0800 (PST)
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH] drm/panthor: Lock XArray when getting entries for heap and VM
Date: Wed,  6 Nov 2024 12:07:48 +0000
Message-ID: <20241106120748.290697-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to cac075706f29 ("drm/panthor: Fix race when converting
group handle to group object") we need to use the XArray's internal
locking when retrieving a pointer from there for heap and vm.

Reported-by: Jann Horn <jannh@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++--
 drivers/gpu/drm/panthor/panthor_mmu.c  |  2 ++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 3796a9eb22af2..fe0bcb6837f74 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -351,6 +351,17 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 	return ret;
 }
 
+static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
+{
+	struct panthor_heap *heap;
+
+	xa_lock(&pool->xa);
+	heap = xa_load(&pool->xa, id);
+	xa_unlock(&pool->va);
+
+	return heap;
+}
+
 /**
  * panthor_heap_return_chunk() - Return an unused heap chunk
  * @pool: The pool this heap belongs to.
@@ -375,7 +386,7 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
 		return -EINVAL;
 
 	down_read(&pool->lock);
-	heap = xa_load(&pool->xa, heap_id);
+	heap = panthor_heap_from_id(pool, heap_id);
 	if (!heap) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -438,7 +449,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 		return -EINVAL;
 
 	down_read(&pool->lock);
-	heap = xa_load(&pool->xa, heap_id);
+	heap = panthor_heap_from_id(pool, heap_id);
 	if (!heap) {
 		ret = -EINVAL;
 		goto out_unlock;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 8ca85526491e6..8b5cda9d21768 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
 {
 	struct panthor_vm *vm;
 
+	xa_lock(&pool->xa);
 	vm = panthor_vm_get(xa_load(&pool->xa, handle));
+	xa_unlock(&pool->va);
 
 	return vm;
 }
-- 
2.47.0


