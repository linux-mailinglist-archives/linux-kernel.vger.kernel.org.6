Return-Path: <linux-kernel+bounces-439402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3E9EAEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0974D1888D72
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D99210F6D;
	Tue, 10 Dec 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxRGvEpu"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51B2153F7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828089; cv=none; b=BFPKPf2A2jK+bqJeG2MZGxx/A5xaEY+6Mk1CrmdPHGKo+EjI7apFHfgydoaU2PM0GzAYAfmebUH+RC+foRRTR3TQ+N1ISVXRG7tlevCqIKh42pIuyUwoK7//iwYLVxOJuBpieDyLgAJnLC70Zgrpro4glaQXqX5DNXm3e5GGhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828089; c=relaxed/simple;
	bh=smdNTw+vMDFHaR4IrLNgF/FN+FFxR5KWARqhFQRNng8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tprQH87Rd9jLp4ZWs3ht/tgjRaY3PzOuJMkUgA2UaN7Da0Lz0zpm25wd52FqAaI7/7Hn3PRiTP0IKXwMeKNHap6zoXnrgBcbDkyAckvpZi86cNV7u5IczpIY6pqT08u/fusV8r5wJpBLnYQb2yrLGuwyS2fOO6ksR8IZoDL2izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxRGvEpu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea8de14848so3353371a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828087; x=1734432887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTnZa6n/DE3ID57RWg7Mxn9pl+7nCgdulUS+gVS34eY=;
        b=jxRGvEpu4LBeCklThPL6djmj556XVLOZeDLPTDCaZdpI2pP5VIENtUynlTz8GcCiNt
         Sa0ofqdLiEJCuxgMQLjutuEEPznLVEsdp1rE9qjwtLMJLU5N8lula5rXJ79GSwvr2GX+
         FzKkoqjn+X2GQSb0XEvdZpJBHA0SGIEmNX9CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828087; x=1734432887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTnZa6n/DE3ID57RWg7Mxn9pl+7nCgdulUS+gVS34eY=;
        b=POmT5RyO9c2U1KpmSQwPKCHVXW2W8M97zDZvljMFXonFEU6dZBee24vasBrIWy71u8
         BgaSAoBTs38kDJ/1XRNUd7Vka2zvsLGjJuK+9ldofnA/cgo2C9nrv/WuwqLvAr9FVRTf
         6JfT8yl613WitbzvOQc/xL/Pdp86tHoOn8RotpU8fj/qN1lzbo+YxcnrOWWjK6Eckicq
         r48ktZRwUGgx9f8zK/xtcERjrap676KzpcO5oMmsQm70CrYikQ/cmThYdFYLiXxkC1m+
         2bnWwnfHAPgmQ9oMAG4F35YWFvyGVI5GMj2vm2x2D644eRCkv3mmIp3URnJZoD45OGYs
         jb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXScKx38S20MkiVkKWf5tLZHNz28mZ+JbUdJxYOZ2aca7SZwiVEiRhK8y9pZq165b36Bk7UG+bLfEW2mdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULTb/2se4Uxlg3kfUy4kbhkx97dZ5CwiIse1eB8IwYtEHysph
	XiEGDfIUxvMsUiWofkvyp0fePktoUDnXA8qr9K2IjyMlYbyesNe3rD9SqH1tYQ==
X-Gm-Gg: ASbGncvBH/nlooqyJNAqD12hArsB6OBzfqY1ViHdsgb5iIOxbAcyadWKQF3QzahTZ8c
	vFaEgxW0LUcD2MqBWKwGcUrWTMf24j42imshHzyzGnjU78wh9Ve9AEsPZ3FDjGIIwUvFcU1UWpH
	4NZz0+17ucMuwmq/lh37EMvXIA3Oct2e5e+286pOKaU6pIIWPkRQybl42O/hIUb43/+yUxzLpn5
	aHQWFh93OF75ZqlIGy5j8+OKRk4LrAX1Ny2wi18aBZhwHWj5ZW0tw8U
X-Google-Smtp-Source: AGHT+IGqA0mE3qai7JdNAnzJ9k3Kt0lR0L33eJet3ghDIIUHhAO2rfR5leTsMMFtRxiqpgC0YeFauw==
X-Received: by 2002:a05:6a20:1596:b0:1e1:ae68:d900 with SMTP id adf61e73a8af0-1e1b1b1bb34mr7365110637.22.1733828086890;
        Tue, 10 Dec 2024 02:54:46 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd4846418csm3871862a12.28.2024.12.10.02.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:46 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 5/6] zram: factor out ZRAM_HUGE write
Date: Tue, 10 Dec 2024 19:53:59 +0900
Message-ID: <20241210105420.1888790-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241210105420.1888790-1-senozhatsky@chromium.org>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram_write_page() handles: ZRAM_SAME pages (which was already
factored out) stores, regular page stores and ZRAM_HUGE pages
stores.

ZRAM_HUGE handling adds a significant amount of complexity.
Instead, we can handle ZRAM_HUGE in a separate function.  This
allows us to simplify zs_handle allocations slow-path, as it
now does not handle ZRAM_HUGE case.  ZRAM_HUGE zs_handle
allocation, on the other hand, can now drop __GFP_KSWAPD_RECLAIM
because we handle ZRAM_HUGE in preemptible context (outside of
local-lock scope).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 139 ++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 56 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 22c6ab363ae6..18263e4c208e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -132,6 +132,27 @@ static inline bool zram_allocated(struct zram *zram, u32 index)
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
+	return !zram->limit_pages || alloced_pages <= zram->limit_pages;
+}
+
 #if PAGE_SIZE != 4096
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
@@ -266,18 +287,6 @@ static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
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
@@ -1636,14 +1645,55 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 	return 0;
 }
 
+static int write_incompressible_page(struct zram *zram, struct page *page,
+				     u32 index)
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
 	unsigned int last_comp_len = 0;
-	void *src, *dst, *mem;
+	void *dst, *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 	bool same_filled;
@@ -1661,10 +1711,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
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
@@ -1673,13 +1723,16 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return ret;
 	}
 
-	if (comp_len >= huge_class_size)
-		comp_len = PAGE_SIZE;
-
 	if (last_comp_len && (last_comp_len != comp_len)) {
 		zs_free(zram->mem_pool, handle);
 		handle = -ENOMEM;
 	}
+
+	if (comp_len >= huge_class_size) {
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		return write_incompressible_page(zram, page, index);
+	}
+
 	/*
 	 * handle allocation has 2 paths:
 	 * a) fast path is executed with preemption disabled (for
@@ -1695,37 +1748,22 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
 
-		if (comp_len != PAGE_SIZE) {
-			last_comp_len = comp_len;
-			goto compress_again;
-		}
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
@@ -1733,30 +1771,19 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
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
 
 	/* Update stats */
 	atomic64_inc(&zram->stats.pages_stored);
+	atomic64_add(comp_len, &zram->stats.compr_data_size);
+
 	return ret;
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog


