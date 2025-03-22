Return-Path: <linux-kernel+bounces-572658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414DA6CCBC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992643A7A60
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B98238170;
	Sat, 22 Mar 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="LUe+QSKk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03F235358
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679000; cv=pass; b=L35RPWrjXHC3GpdaWL15ec2PRkAY7GtEVtOC/9m6+8SedivtbbKFgqvMhK0si3R3hGTb/ktQ9u4Qr3y1Mw4hkyWfj3WvJJBkTuhehzleSAgTOt7Xdtj7Av56foavkGJsV5rgEpUO4yykUHKaT+PsOKgoeN1kRrEqx6BCDICRiOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679000; c=relaxed/simple;
	bh=GS67kKBf634hmTGJ8ztFY9umk+N2v9dsFfywBljebJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9TOLVKjNIo8h7TlEf4JxchhLtjeboQbzDwe4kTxUEZtVZ3bxyMVPjAvwf6+r/MzLor2TQBLzMgaOGoAsKbO7+K/2A7g3YMRz5w+0PGytDRxF8d1mJ3ekrm8eRPj1m8sYXRTzXcVYEIespcO7RRCKyNFfgBMPTqcU+n4f+8GCdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=LUe+QSKk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742678973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=edhGsgPmgntLYCFaQiqxGvBfQx7WnUBG2hldBgS3YznZI31TszLQzqEcfsecU6rVae+ppjhzsntO6MS4TscJhmB1aZlYsm0OH6UDYU49iFu2KypgVDAJ51Yn7bkbgKedq1LMsrASPdr3MK8vNnr2h5IB0l3DqWeoBrOdokETwbA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742678973; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1dcY8k5g4fF0UWLqOc8Uf+7VkNlVV5V21QJxksyUkCk=; 
	b=HPWbDWGZAGu0hMs6wjzV9EboKn6rdj/FBZ6zLGvfo6IO7VBWxXdzaNDcn2n6DER7LGkw0IsTLgBMW7gDPa7g2J6D8dKIBEjdnsTJ4Ugg57/SIS+g0acRhIupO/AaEzV5tUlew2fr2uFJGSlcoK8gAOBl35FoOopYKKuHGnywzyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742678973;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1dcY8k5g4fF0UWLqOc8Uf+7VkNlVV5V21QJxksyUkCk=;
	b=LUe+QSKk2nUd75NePop6N2yuJp2ThVLy5PNQ9afWa+727iFm7A0Usxw1bgFKR/vY
	rdrLIiOMhc6CTqaWJTBWEGRk8GhEZ2rI6q0b1n2M6yDOzxFbkbOf2GlHx/6j3Vr4MZo
	9bncoUC5FOvuMdQ3nY4b5ShhAsT1frnW1MP8tIys=
Received: by mx.zohomail.com with SMTPS id 1742678972553562.2070710536797;
	Sat, 22 Mar 2025 14:29:32 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v20 07/10] drm/shmem-helper: Add and use pages_pin_count
Date: Sun, 23 Mar 2025 00:26:05 +0300
Message-ID: <20250322212608.40511-8-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add separate pages_pin_count for tracking of whether drm-shmem pages are
moveable or not. With the addition of memory shrinker support to drm-shmem,
the pages_use_count will no longer determine whether pages are hard-pinned
in memory, but whether pages exist and are soft-pinned (and could be swapped
out). The pages_pin_count > 1 will hard-pin pages in memory.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 16 +++++++++++++++-
 include/drm/drm_gem_shmem_helper.h     | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 277e792a0c5c..d338b36f4eaa 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -177,6 +177,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 			drm_gem_shmem_put_pages_locked(shmem);
 
 		drm_WARN_ON(obj->dev, shmem->pages_use_count);
+		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
 
 		dma_resv_unlock(shmem->base.resv);
 	}
@@ -257,7 +258,12 @@ int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(shmem->base.dev, drm_gem_is_imported(&shmem->base));
 
+	if (refcount_inc_not_zero(&shmem->pages_pin_count))
+		return 0;
+
 	ret = drm_gem_shmem_get_pages_locked(shmem);
+	if (!ret)
+		refcount_set(&shmem->pages_pin_count, 1);
 
 	return ret;
 }
@@ -267,7 +273,8 @@ void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
 {
 	dma_resv_assert_held(shmem->base.resv);
 
-	drm_gem_shmem_put_pages_locked(shmem);
+	if (refcount_dec_and_test(&shmem->pages_pin_count))
+		drm_gem_shmem_put_pages_locked(shmem);
 }
 EXPORT_SYMBOL(drm_gem_shmem_unpin_locked);
 
@@ -288,6 +295,9 @@ int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
 
+	if (refcount_inc_not_zero(&shmem->pages_pin_count))
+		return 0;
+
 	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
 	if (ret)
 		return ret;
@@ -311,6 +321,9 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
 
+	if (refcount_dec_not_one(&shmem->pages_pin_count))
+		return;
+
 	dma_resv_lock(shmem->base.resv, NULL);
 	drm_gem_shmem_unpin_locked(shmem);
 	dma_resv_unlock(shmem->base.resv);
@@ -660,6 +673,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 	if (drm_gem_is_imported(&shmem->base))
 		return;
 
+	drm_printf_indent(p, indent, "pages_pin_count=%u\n", refcount_read(&shmem->pages_pin_count));
 	drm_printf_indent(p, indent, "pages_use_count=%u\n", shmem->pages_use_count);
 	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 0609e336479d..d411215fe494 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -39,6 +39,17 @@ struct drm_gem_shmem_object {
 	 */
 	unsigned int pages_use_count;
 
+	/**
+	 * @pages_pin_count:
+	 *
+	 * Reference count on the pinned pages table.
+	 *
+	 * Pages are hard-pinned and reside in memory if count
+	 * greater than zero. Otherwise, when count is zero, the pages are
+	 * allowed to be evicted and purged by memory shrinker.
+	 */
+	refcount_t pages_pin_count;
+
 	/**
 	 * @madv: State for madvise
 	 *
-- 
2.49.0


