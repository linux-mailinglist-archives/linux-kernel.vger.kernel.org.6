Return-Path: <linux-kernel+bounces-413932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE89D20AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249D028119A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE5197A7A;
	Tue, 19 Nov 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9VeORgj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF01B85D3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000893; cv=none; b=mUDp+/Gpmb2gMGalyHvkayLUT5Jl1PbJP6a4vM1jxqYjiAj0iEPtHiTa1NvQEtW6ZMOTbAe5QU4KV0fWtVbrkZqOvqZZMOrhf6+SGJpLtHYLq1ANRkf8bYXS7h6XlYsPpfk2T+W7rZxCN58b5m7HuBCqasv9kVW0gyRcaYPeDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000893; c=relaxed/simple;
	bh=4+bjv2d9eUx5fmy192m4VvtxaJyxp5nAXbZwhB5c9og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETCjkt6kPCkSyxiGSYvmuWu7Xp8iEIR7k2Pzd5DRyqQkIUxULnYGw8BiuH9kSdITTlwZ7cTZDXcyEWD4ggKTPn2ec/J7iy0Cokm+98K9gFAzUb7iJN0Q4u0y40d6MUiwzjkZ3TMbEyxysvCaqovkOupT9Ctx5snB1iLXNcQ3Uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f9VeORgj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf6eea3c0so5683055ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000891; x=1732605691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPgvnxddRnh+JN7AYAi4qB46AptriyxUI0Yn0oo8khA=;
        b=f9VeORgj+mNiV09v7JLZ2CvvpAVePcLIg2Ue6mAt0tw3b73+zH3AJRXqx0tzFt0Cwq
         QwBIIzFxIYtnw4/+UJI76KfYsdcp3ckLkevie6RKhbG+I9ilXoPP2h+5pv8YZq/AE4x/
         GId8PwoJy7X04G9xt9mC54RlHMAyhkBlB/kqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000891; x=1732605691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPgvnxddRnh+JN7AYAi4qB46AptriyxUI0Yn0oo8khA=;
        b=r3OHLAr1Q4NGDhIO17kYZGrDhrlN1/sWHPAetBeXa8OSvu8bSP8BKTi0bSKMpEHfU9
         nY4p0sM8doxXOKooLq0NRUyRsFcjMIP+3iKzY2mLTb50KrxNvDcZprQp6FOITU3NE0/6
         Llpl6k01Fz8AYUuR9Ng6WnfrKTBmrf3cYBjNQM8eERChjnQFG5G8AWk7GIdifdMjrM7v
         8F6bMH+2kx7FVJ+/Vd1+yEG7L3Z1cyS3pha89fM1M/YznGEqA6F8gATezLTFoDId23GA
         VaeJ88sBW/Y+MeTrCtKtRlGSC8S8Ond0isdwjRAQL/CAUskA27Bj3IqXW9JU+p4PZSa9
         oPXw==
X-Gm-Message-State: AOJu0YwD5qViSXdpQndl99kBEsbGGCQfABpMAtOSS0swe39DlOc5FiCp
	1Q/ZiKffYugpsxmreJSh+/sGL3qtlkwk/WU+2LXHeLIU2k3Dj+HRO9BYLETMyQ==
X-Google-Smtp-Source: AGHT+IG8enfxTdRo52pIptt7VuVfSVvJ5XWKTVi2HXnhOJ/BW+vLMlDZHkQDlv/qY3ZoJmRcAhpZeA==
X-Received: by 2002:a17:903:2452:b0:20b:8776:4902 with SMTP id d9443c01a7336-211d0ebf325mr231639695ad.38.1732000890802;
        Mon, 18 Nov 2024 23:21:30 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211d0f34f3bsm68221295ad.137.2024.11.18.23.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:30 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 8/8] zram: introduce multi-handle entries
Date: Tue, 19 Nov 2024 16:20:46 +0900
Message-ID: <20241119072057.3440039-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241119072057.3440039-1-senozhatsky@chromium.org>
References: <20241119072057.3440039-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 120 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |  15 ++++-
 2 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2b20afcfbb94..7e29e204fccf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -37,6 +37,17 @@
 
 #include "zram_drv.h"
 
+/*
+ * This determines sizes of the ZRAM_HUGE object split.  Currently we perform
+ * a 2-way split.  One part is stored in 2048 size-class and the other one is
+ * stored in the size-class above 2048.
+ *
+ * To store an object in a target size-class we need to sub zsmalloc
+ * handle size (which is added to every object by zsmalloc internally).
+ */
+#define ZRAM_MHANDLE_HEAD_LEN	((PAGE_SIZE) / 2 - ZS_HANDLE_SIZE)
+#define ZRAM_MHANDLE_TAIL_LEN	((PAGE_SIZE) - ZRAM_MHANDLE_HEAD_LEN)
+
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
 static DEFINE_MUTEX(zram_index_mutex);
@@ -93,6 +104,18 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
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
@@ -1479,8 +1502,6 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
  */
 static void zram_free_page(struct zram *zram, size_t index)
 {
-	unsigned long handle;
-
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = 0;
 #endif
@@ -1490,11 +1511,6 @@ static void zram_free_page(struct zram *zram, size_t index)
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
@@ -1511,11 +1527,26 @@ static void zram_free_page(struct zram *zram, size_t index)
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
@@ -1528,16 +1559,21 @@ static void zram_free_page(struct zram *zram, size_t index)
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
+	memcpy(dst, src, ZRAM_MHANDLE_HEAD_LEN);
+	zs_unmap_object(zram->mem_pool, handle->head);
+
+	src = zs_map_object(zram->mem_pool, handle->tail, ZS_MM_RO);
+	memcpy(dst + ZRAM_MHANDLE_HEAD_LEN, src, ZRAM_MHANDLE_TAIL_LEN);
+	zs_unmap_object(zram->mem_pool, handle->tail);
+
+	kunmap_local(dst);
 	return 0;
 }
 
@@ -1662,34 +1698,54 @@ static int zram_write_same_filled_page(struct zram *zram, unsigned long fill,
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
+	handle->head = zs_malloc(zram->mem_pool, ZRAM_MHANDLE_HEAD_LEN,
+				 GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
+	if (IS_ERR_VALUE(handle->head)) {
+		ret = PTR_ERR((void *)handle->head);
+		goto error;
+	}
+
+	handle->tail = zs_malloc(zram->mem_pool, ZRAM_MHANDLE_TAIL_LEN,
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
+	memcpy(dst, src, ZRAM_MHANDLE_HEAD_LEN);
+	zs_unmap_object(zram->mem_pool, handle->head);
+
+	dst = zs_map_object(zram->mem_pool, handle->tail, ZS_MM_WO);
+	memcpy(dst, src + ZRAM_MHANDLE_HEAD_LEN, ZRAM_MHANDLE_TAIL_LEN);
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
 
@@ -1699,6 +1755,14 @@ static int zram_write_incompressible_page(struct zram *zram, struct page *page,
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
2.47.0.371.ga323438b13-goog


