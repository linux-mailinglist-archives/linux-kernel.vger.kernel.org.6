Return-Path: <linux-kernel+bounces-412749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 908439D0F24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A617FB2E38F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBE19922F;
	Mon, 18 Nov 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3zpkexd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB91991B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925896; cv=none; b=h7uP5p6VC+IJubaaLQWwmDIjSYyrNF16Fzh5+IA0/UuTRaTIEKNIEcU/qMTYvWaWILYCKZ3XFdrNuiAvaotQlDjtxc+ZxphxNctckfrssArZGK0rLsjtDkHG3kSpaBhq63O/Ql/REByTsjvK+4olZQvH5extwH9cLX5i13GZ6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925896; c=relaxed/simple;
	bh=gUip9aJ2/OVtgELjoiXJFkzcAXqEnDZMqWYmRnkqFns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/H9wQxsb5yNJvL5qdOlq1sfI2VoP3d4yabxDe/Vwx+ggPdnQT82ZS0m+2/c4ltl3O5lBkWfzEbWggzPBx+286YNoDdHiCu4Bk9UED3Yp/WSvD/UtJTYgLjqgD8WFtuli6UInO+zAtse6dEyrMCr4FHRi5jw19z1Qq+f1eM9Nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U3zpkexd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so38739045ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925894; x=1732530694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3cWzzVgSnhEjQAJcgAKgDRaPSzxbgH2wfRRSRJOX8o=;
        b=U3zpkexdty4aoadogXm5/YdimFq6dPVk+M83oSB4cNk4bSsJTKqTq7FT3hG8nfawQa
         vihc8BUK9zVY1WQhJ9j8tZ8LQO1z6qh2KMRq7DcRDZlJHUHmnpj9RPYION8aq0nOp1EG
         yDVslqS+IpgXKn+Vy7UwbmnG/C3hS3jvf4EPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925894; x=1732530694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3cWzzVgSnhEjQAJcgAKgDRaPSzxbgH2wfRRSRJOX8o=;
        b=pdYIHbYZEy593zyZRDhs+QVYizR7kDkmhi7vRe7bdu+h5qe+tQ9AlgM/0ofRLIQ2aL
         TnKEkvKv0CViQeI8ZXFYiJydBx/yCGSXNQod5J0j4xoKhaaamV+xUP5g30TLAdFwl1AH
         BnQG9MKADmR9rkRAWOak0S79Gx49STQ0nI7LSOWRlMMEPd3eKJUPfJUV1Ghj4e5BU4yV
         Pc6IP9TTPx6TER8BPsJfzcyhMn62PZnixffLKYNUg3MnFyunvwc1JvenNXXVC4YkOykn
         v7e0orLRErzqJXdBGSUQ9jMqYDXXYqPipMDrXK/8PhCB1FqaYfm4574FE5lo9bUJhYQ9
         MHiw==
X-Gm-Message-State: AOJu0YxhSFENP/FofZq8S0Gs5O7Hq+4Cj6dKAqT0hxEfsD2/vDuqrJmV
	/i3DVMZqTn+HHRuioEWBAqllMGIHUL2+bt/L0p7F+Qyu7Vaudd5bNp0blBFelB+y1gSzpLGGKOg
	=
X-Google-Smtp-Source: AGHT+IEB47AXatuKfeg8+OsULsp5pHzqsd3xxAxQri9iX5MnEv/ga1c6gsUQSTrgSoAShO5PjtJhTA==
X-Received: by 2002:a17:902:f68c:b0:20c:ecca:432b with SMTP id d9443c01a7336-211d0ebc52amr173858025ad.35.1731925893927;
        Mon, 18 Nov 2024 02:31:33 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211d0f36e15sm54029875ad.116.2024.11.18.02.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:33 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 8/8] zram: introduce multi-handle entries
Date: Mon, 18 Nov 2024 19:30:39 +0900
Message-ID: <20241118103054.3191944-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241118103054.3191944-1-senozhatsky@chromium.org>
References: <20241118103054.3191944-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zsmalloc size-classes store more than one compressed object per
physical page, therefore internal fragmentation is expected and
quite common. Internal fragmentation is completely normal, once
the system gets low on memory zsmalloc attempts to defragment
its pool and release empty zspage-s. However, even this does not
guarantee 100% usage-ratio of pool memory due to the nature of
allocators.

ZRAM_HUGE objects, on the other hand, do not share physical pages
with another objects, because each such object is stored raw
(uncompressed) and occupies a whole physical page.

We, in fact, can get advantage of zsmalloc's internal fragmentation.
Instead of allocating a physical page for each huge object it is
possible to split such objects into smaller objects and store them
in regular size-classes, possibly using allocated but unused zspages'
space. Given that huge objects are stored raw, both write and read of
such objects require only memcpy() and don't need any extra temporary
storage / buffers.

Split ZRAM_HUGE objects into two 2048 objects are store those
parts in regular size-classes.  This now allocates and tracks
two zsmalloc handles for such entries.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 122 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |  15 ++++-
 2 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 745207597e23..997b9bbf74e9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -37,6 +37,16 @@
 
 #include "zram_drv.h"
 
+/*
+ * This determines sizes of the ZRAM_HUGE object split.  Currently we perform
+ * a 2-way split.  One part is soted in 2048 size-class and the other one is
+ * stored in the size-class above 2048.
+ *
+ * To store an object in a target size-class we need to subtrac zsmalloc
+ * handle size, which is added to each store objects.
+ */
+#define ZRAM_MULTI_HANDLE_HEAD_SZ	((PAGE_SIZE) / 2 - ZS_HANDLE_SIZE)
+
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
 static DEFINE_MUTEX(zram_index_mutex);
@@ -93,6 +103,18 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 	zram->table[index].handle = handle;
 }
 
+static struct zram_multi_handle *zram_get_multi_handle(struct zram *zram,
+						       u32 index)
+{
+	return zram->table[index].mhandle;
+}
+
+static void zram_set_multi_handle(struct zram *zram, u32 index,
+				  struct zram_multi_handle *mhandle)
+{
+	zram->table[index].mhandle = mhandle;
+}
+
 /* flag operations require table entry bit_spin_lock() being held */
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
@@ -1479,8 +1501,6 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
  */
 static void zram_free_page(struct zram *zram, size_t index)
 {
-	unsigned long handle;
-
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = 0;
 #endif
@@ -1490,11 +1510,6 @@ static void zram_free_page(struct zram *zram, size_t index)
 	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
 	zram_set_priority(zram, index, 0);
 
-	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
-		zram_clear_flag(zram, index, ZRAM_HUGE);
-		atomic64_dec(&zram->stats.huge_pages);
-	}
-
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
 		free_block_bdev(zram, zram_get_handle(zram, index));
@@ -1511,11 +1526,26 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
-	handle = zram_get_handle(zram, index);
-	if (!handle)
-		return;
+	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
+		struct zram_multi_handle *handle;
+
+		handle = zram_get_multi_handle(zram, index);
+		if (!handle)
+			return;
 
-	zs_free(zram->mem_pool, handle);
+		zs_free(zram->mem_pool, handle->head);
+		zs_free(zram->mem_pool, handle->tail);
+		kfree(handle);
+
+		zram_clear_flag(zram, index, ZRAM_HUGE);
+		atomic64_dec(&zram->stats.huge_pages);
+	} else {
+		unsigned long handle = zram_get_handle(zram, index);
+
+		if (!handle)
+			return;
+		zs_free(zram->mem_pool, handle);
+	}
 
 	atomic64_sub(zram_get_obj_size(zram, index),
 		     &zram->stats.compr_data_size);
@@ -1528,16 +1558,22 @@ static void zram_free_page(struct zram *zram, size_t index)
 static int read_incompressible_page(struct zram *zram, struct page *page,
 				    u32 index)
 {
-	unsigned long handle;
+	struct zram_multi_handle *handle;
 	void *src, *dst;
 
-	handle = zram_get_handle(zram, index);
-	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	handle = zram_get_multi_handle(zram, index);
 	dst = kmap_local_page(page);
-	copy_page(dst, src);
-	kunmap_local(dst);
-	zs_unmap_object(zram->mem_pool, handle);
 
+	src = zs_map_object(zram->mem_pool, handle->head, ZS_MM_RO);
+	memcpy(dst, src, ZRAM_MULTI_HANDLE_HEAD_SZ);
+	zs_unmap_object(zram->mem_pool, handle->head);
+
+	src = zs_map_object(zram->mem_pool, handle->tail, ZS_MM_RO);
+	memcpy(dst + ZRAM_MULTI_HANDLE_HEAD_SZ, src,
+	       PAGE_SIZE - ZRAM_MULTI_HANDLE_HEAD_SZ);
+	zs_unmap_object(zram->mem_pool, handle->tail);
+
+	kunmap_local(dst);
 	return 0;
 }
 
@@ -1648,34 +1684,56 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 static int zram_write_incompressible_page(struct zram *zram, struct page *page,
 					  u32 index)
 {
-	unsigned long handle;
+	struct zram_multi_handle *handle;
 	void *src, *dst;
+	int ret;
 
 	/*
 	 * This function is called from preemptible context so we don't need
 	 * to do optimistic and fallback to pessimistic handle allocation,
 	 * like we do for compressible pages.
 	 */
-	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
-			   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
-	if (IS_ERR_VALUE(handle))
-		return PTR_ERR((void *)handle);
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->head = zs_malloc(zram->mem_pool, ZRAM_MULTI_HANDLE_HEAD_SZ,
+				 GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
+	if (IS_ERR_VALUE(handle->head)) {
+		ret = PTR_ERR((void *)handle->head);
+		goto error;
+	}
+
+	handle->tail = zs_malloc(zram->mem_pool,
+				 PAGE_SIZE - ZRAM_MULTI_HANDLE_HEAD_SZ,
+				 GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
+	if (IS_ERR_VALUE(handle->tail)) {
+		ret = PTR_ERR((void *)handle->tail);
+		goto error;
+	}
 
 	if (!zram_can_store_page(zram)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
-		zs_free(zram->mem_pool, handle);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error;
 	}
 
-	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 	src = kmap_local_page(page);
-	memcpy(dst, src, PAGE_SIZE);
+
+	dst = zs_map_object(zram->mem_pool, handle->head, ZS_MM_WO);
+	memcpy(dst, src, ZRAM_MULTI_HANDLE_HEAD_SZ);
+	zs_unmap_object(zram->mem_pool, handle->head);
+
+	dst = zs_map_object(zram->mem_pool, handle->tail, ZS_MM_WO);
+	memcpy(dst, src + ZRAM_MULTI_HANDLE_HEAD_SZ,
+	       PAGE_SIZE - ZRAM_MULTI_HANDLE_HEAD_SZ);
+	zs_unmap_object(zram->mem_pool, handle->tail);
+
 	kunmap_local(src);
-	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
-	zram_set_handle(zram, index, handle);
+	zram_set_multi_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, PAGE_SIZE);
 	zram_slot_unlock(zram, index);
 
@@ -1685,6 +1743,14 @@ static int zram_write_incompressible_page(struct zram *zram, struct page *page,
 	atomic64_inc(&zram->stats.pages_stored);
 
 	return 0;
+
+error:
+	if (!IS_ERR_VALUE(handle->head))
+		zs_free(zram->mem_pool, handle->head);
+	if (!IS_ERR_VALUE(handle->tail))
+		zs_free(zram->mem_pool, handle->tail);
+	kfree(handle);
+	return ret;
 }
 
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index db78d7c01b9a..7bc7792c2fef 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -60,9 +60,22 @@ enum zram_pageflags {
 
 /*-- Data structures */
 
+/*
+ * Unlike regular zram table entries, ZRAM_HUGE entries are stored in zsmalloc
+ * as smaller objects in multiple locations (size-classes).  This keeps tracks
+ * of those locations.
+ */
+struct zram_multi_handle {
+	unsigned long head;
+	unsigned long tail;
+};
+
 /* Allocated for each disk page */
 struct zram_table_entry {
-	unsigned long handle;
+	union {
+		unsigned long handle;
+		struct zram_multi_handle *mhandle;
+	};
 	unsigned int flags;
 	spinlock_t lock;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-- 
2.47.0.338.g60cca15819-goog


