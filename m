Return-Path: <linux-kernel+bounces-412746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87099D0E95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E82818D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253F198A0D;
	Mon, 18 Nov 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OKxiDFRG"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F47198845
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925886; cv=none; b=D/3feC39ve0g1J6xAa1+9GQoE1IwdykMirwwdgwE7aWOa15+jsKC1zFIebUJaCqgch8G9yxdijdoJc3AkQf9+aLlkNCqXNtzERaAQgI5IbzUvetfDLtfnJv9ZBdYsoaWCmqetTxYBm+KHI48WKSTF67cSmzShmLnaWipHecW9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925886; c=relaxed/simple;
	bh=4qnAzf0A9GYx/UXMtDh029xq1MIEq1qKhYC5v8zrURM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+3Wcafwfi8Zy4ZgRjT41iiwQ1hM/jorpM9933YQOxr47i8kaRRKZquaJ0gC5A6fps+aHpRADf4Uu6A0ov3r1Kg/cfnHmq+qCprRm+Rgnmb7SAoS3OQzN8hIi677O2sG5hNFrtbbVVHTFepEPrhJp+aZiWmtHijMZlIAKjOdh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OKxiDFRG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so2964102a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925884; x=1732530684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyFU2BHIoGV0dtOXeqkkgnpAt0Qyo/99bFGxHgdr5lo=;
        b=OKxiDFRGR5rm9mDgB0A1faPudy2P1GUZbMVWgrOtFIEz0dzAcm1BYLLkYElhNPOCnO
         Gkq1KyAmEK+rP2I8ZjuoOCd3eW+JmNce48tOxX0UuRzPCTSpz1/WEj5bGoo6jKgINkwH
         p/TBN5u9n7alCzRpHSVE4lvPaBuvazUIRCZFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925884; x=1732530684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyFU2BHIoGV0dtOXeqkkgnpAt0Qyo/99bFGxHgdr5lo=;
        b=lN5FtZysufBo3limnvsJiAA7GJaYXXQTDlf8+Dyaa65lYhw1cnYp9DqqcCU7ACKvkQ
         eq5QbRTxn4RtvcNCt0CwGsS2SJO+HyIvRPZKyAfCus2bS3hvJkzz+ItilZnbPjOmyNKu
         NoanR7iOPYP8vtBvesVbmD5i/7URWyWue2YGJhbPKFz7nxIhGiS/7D44otpYhitDZYG3
         zgbCI2NKppDK4dKODL2RWNmDHEgSeNgv8uCD/Par2mRjL6VnlxjyswwliR6Aq4Ei8s89
         +E9mdGiuPK399aVIVo37m9xghxZl1KPwDG0zRBAiu8/m9bK9h4VVu8JB0W4lmrDIwpSh
         DqzQ==
X-Gm-Message-State: AOJu0YyVYug2zgO/Sh9zMLSTGFeTb89H1L5UfzFwpzFtug8mdgpVVZ9A
	lV6v22mIz7um9jxoMk0zZEnbRhtBzxUrWwLK/kwm6sL9QCVeBEyJNKe0oZY82deD3zL8pqJ2MpM
	=
X-Google-Smtp-Source: AGHT+IE/bDybxqpTkSZHBlnC8w5UhDkGvZcj3Hi/AAd2MwYPMGiJDBe7j3AJX2xvHHra4twLVoYmkg==
X-Received: by 2002:a05:6a21:339f:b0:1db:d869:9204 with SMTP id adf61e73a8af0-1dc90b28fbbmr17074348637.11.1731925883662;
        Mon, 18 Nov 2024 02:31:23 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f8c1c62ccfsm4802390a12.43.2024.11.18.02.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:23 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 5/8] zram: factor out ZRAM_HUGE write
Date: Mon, 18 Nov 2024 19:30:36 +0900
Message-ID: <20241118103054.3191944-6-senozhatsky@chromium.org>
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

zram_write_page() handles 3 different cases: ZRAM_SAME pages
(which was already simplified in previous patches) writes,
regular pages writes and ZRAM_HUGE pages writes.

ZRAM_HUGE handling adds a significant amount of complexity: all
those conditional src for copy_page(), etc., a conditional jump
backward for the fallback handle allocation and so on.  Instead,
we can handle ZRAM_HUGE in a separate function and remove quite
a bit of that complexity at a cost of minor code duplication
(basically, only zram stats updates).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 140 +++++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 55 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 76ff74a75125..55ffd0534470 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -132,6 +132,30 @@ static inline bool zram_allocated(struct zram *zram, u32 index)
 			zram_test_flag(zram, index, ZRAM_WB);
 }
 
+static inline void update_used_max(struct zram *zram, const unsigned long pages)
+{
+	unsigned long cur_max = atomic_long_read(&zram->stats.max_used_pages);
+
+	do {
+		if (cur_max >= pages)
+			return;
+	} while (!atomic_long_try_cmpxchg(&zram->stats.max_used_pages,
+					  &cur_max, pages));
+}
+
+static bool zram_can_store_page(struct zram *zram)
+{
+	unsigned long alloced_pages;
+
+	alloced_pages = zs_get_total_pages(zram->mem_pool);
+	update_used_max(zram, alloced_pages);
+
+	if (!zram->limit_pages)
+		return true;
+
+	return alloced_pages <= zram->limit_pages;
+}
+
 #if PAGE_SIZE != 4096
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
@@ -266,18 +290,6 @@ static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
 }
 #endif
 
-static inline void update_used_max(struct zram *zram,
-					const unsigned long pages)
-{
-	unsigned long cur_max = atomic_long_read(&zram->stats.max_used_pages);
-
-	do {
-		if (cur_max >= pages)
-			return;
-	} while (!atomic_long_try_cmpxchg(&zram->stats.max_used_pages,
-					  &cur_max, pages));
-}
-
 static inline void zram_fill_page(void *ptr, unsigned long len,
 					unsigned long value)
 {
@@ -1616,13 +1628,54 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	return zram_read_page(zram, bvec->bv_page, index, bio);
 }
 
+static int zram_write_incompressible_page(struct zram *zram, struct page *page,
+					  u32 index)
+{
+	unsigned long handle;
+	void *src, *dst;
+
+	/*
+	 * This function is called from preemptible context so we don't need
+	 * to do optimistic and fallback to pessimistic handle allocation,
+	 * like we do for compressible pages.
+	 */
+	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
+			   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
+	if (IS_ERR_VALUE(handle))
+		return PTR_ERR((void *)handle);
+
+	if (!zram_can_store_page(zram)) {
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zs_free(zram->mem_pool, handle);
+		return -ENOMEM;
+	}
+
+	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
+	src = kmap_local_page(page);
+	memcpy(dst, src, PAGE_SIZE);
+	kunmap_local(src);
+	zs_unmap_object(zram->mem_pool, handle);
+
+	zram_slot_lock(zram, index);
+	zram_set_flag(zram, index, ZRAM_HUGE);
+	zram_set_handle(zram, index, handle);
+	zram_set_obj_size(zram, index, PAGE_SIZE);
+	zram_slot_unlock(zram, index);
+
+	atomic64_add(PAGE_SIZE, &zram->stats.compr_data_size);
+	atomic64_inc(&zram->stats.huge_pages);
+	atomic64_inc(&zram->stats.huge_pages_since);
+	atomic64_inc(&zram->stats.pages_stored);
+
+	return 0;
+}
+
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
-	unsigned long alloced_pages;
 	unsigned long handle = -ENOMEM;
 	unsigned int comp_len = 0;
-	void *src, *dst, *mem;
+	void *dst, *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 
@@ -1643,10 +1696,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
-	src = kmap_local_page(page);
+	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
-			     src, &comp_len);
-	kunmap_local(src);
+			     mem, &comp_len);
+	kunmap_local(mem);
 
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
@@ -1655,8 +1708,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return ret;
 	}
 
-	if (comp_len >= huge_class_size)
-		comp_len = PAGE_SIZE;
+	if (comp_len >= huge_class_size) {
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		return zram_write_incompressible_page(zram, page, index);
+	}
+
 	/*
 	 * handle allocation has 2 paths:
 	 * a) fast path is executed with preemption disabled (for
@@ -1672,66 +1728,40 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	 */
 	if (IS_ERR_VALUE(handle))
 		handle = zs_malloc(zram->mem_pool, comp_len,
-				__GFP_KSWAPD_RECLAIM |
-				__GFP_NOWARN |
-				__GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				   __GFP_KSWAPD_RECLAIM |
+				   __GFP_NOWARN |
+				   __GFP_HIGHMEM |
+				   __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
-				GFP_NOIO | __GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
 		if (IS_ERR_VALUE(handle))
 			return PTR_ERR((void *)handle);
 
-		if (comp_len != PAGE_SIZE)
-			goto compress_again;
-		/*
-		 * If the page is not compressible, you need to acquire the
-		 * lock and execute the code below. The zcomp_stream_get()
-		 * call is needed to disable the cpu hotplug and grab the
-		 * zstrm buffer back. It is necessary that the dereferencing
-		 * of the zstrm variable below occurs correctly.
-		 */
-		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
+		goto compress_again;
 	}
 
-	alloced_pages = zs_get_total_pages(zram->mem_pool);
-	update_used_max(zram, alloced_pages);
-
-	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
+	if (!zram_can_store_page(zram)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
 
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
-
-	src = zstrm->buffer;
-	if (comp_len == PAGE_SIZE)
-		src = kmap_local_page(page);
-	memcpy(dst, src, comp_len);
-	if (comp_len == PAGE_SIZE)
-		kunmap_local(src);
-
+	memcpy(dst, zstrm->buffer, comp_len);
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
-	atomic64_add(comp_len, &zram->stats.compr_data_size);
 
 	zram_slot_lock(zram, index);
-	if (comp_len == PAGE_SIZE) {
-		zram_set_flag(zram, index, ZRAM_HUGE);
-		atomic64_inc(&zram->stats.huge_pages);
-		atomic64_inc(&zram->stats.huge_pages_since);
-	}
-
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
 
-	/* Update stats */
 	atomic64_inc(&zram->stats.pages_stored);
+	atomic64_add(comp_len, &zram->stats.compr_data_size);
+
 	return ret;
 }
 
-- 
2.47.0.338.g60cca15819-goog


