Return-Path: <linux-kernel+bounces-413929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9559D20AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF404280EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DF7192D82;
	Tue, 19 Nov 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TBUH2XkM"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90919AD8C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000883; cv=none; b=AeqMLCsSuFmw+AwHKmz5B72LdEUa31dpW0gHU6xWBX+Vfqe7xhf6GrIs0rV0j9hgpXRaRoYHgJTNB0vH88KiEg8mDCtXSGBVT/xcamcRSUkmoByfu2PuWQ4iOT1UfvqyXTf/p0Sqk+CsCN8X/Vik4ncl69CNr7b0deV0wICEhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000883; c=relaxed/simple;
	bh=3MMMG4XKz7n2fVohXU7Jz1go5CS4olMTQboAbPLW3a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMzA+Sopczdfoe93TBOCaJqxljXO3MfwIODtZISkwfQePhMpusWcpa7st1gC/rK2/BjOiOj2M8wQsYhc1f6v7PaFBW83zMYjBpod3bAg+EY0xi3Z1Gmsp8zfReaTlKEscFcSGXssSsxWcXFxxhWW0/3ln5RvxupPDA7Tr1vztWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TBUH2XkM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e91403950dso400730a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000881; x=1732605681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r1BPbKg6+Hwje1rl36AJwmpN6gJmRKCRsZyk3dr8tE=;
        b=TBUH2XkMF1z//EaHEZS1RoL/sj88JsrR6n1+h7BBh2D8zls7ms2SOIIsUuDMAyHXwe
         phCqT82mbc77HD2YFJOmgh4M63Frfec4dFtVP5/enmYSToxHwWRRkgvidbllYnRayJOB
         5mRkev5tbmgyaA4dBgib5LUygdG7BhJZtJ1RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000881; x=1732605681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r1BPbKg6+Hwje1rl36AJwmpN6gJmRKCRsZyk3dr8tE=;
        b=ERp23XZGxvlZUZER3I6SHRu/I6BWiTehOheeurwOeG1tzJOLylAv+/OosPy4+SpzYQ
         zUE1PM/bkxGXKHG0MT4eTbj6MfPGI64vbKpNpL1v6ma3OYQcoygKhI/wyjB81pt2gTrh
         S4BP894mEWIRA4OWcPpeuprYNRJhUBkFVLdQAsGZWkunsdxXZQuKxOW7RqD+FM4RoAzn
         +jWMujxuPt456ULW2SgEKdld+R72zviNVssDsUZ3nd5t6OuASYvQIYzpRNybk0W/zxC3
         YmmYwpWzAr8jN+3cJlJ6y9gf0t4V2glEBqqyQESjj5WASBPmn7bjC2HsMZ2skK16K864
         fafw==
X-Gm-Message-State: AOJu0Yw1QQa43DvA2Ii2mYYGXtH3v9b5J/DCk3N8Ba/qHKWu/gJH2iHi
	/hkXAIaYZx8h2gqxLAZXAjo3l7uwQJGNuVG7VYUlKYbe2eEo4qmSeysaVVE+KTj+YG2QI/QwwK4
	=
X-Google-Smtp-Source: AGHT+IGCzDUzZ9ZGQosjzl82UtKy4NubctNo+8zsr4rXK6+hylFusmKPLODB+qAGXXKd5SOAq7cN4g==
X-Received: by 2002:a17:90b:3c02:b0:2ea:5c01:c1a4 with SMTP id 98e67ed59e1d1-2ea5c01c3b2mr10362501a91.20.1732000880991;
        Mon, 18 Nov 2024 23:21:20 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ea024949a4sm8671620a91.11.2024.11.18.23.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:20 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 5/8] zram: factor out ZRAM_HUGE write
Date: Tue, 19 Nov 2024 16:20:43 +0900
Message-ID: <20241119072057.3440039-6-senozhatsky@chromium.org>
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
index f89af45237c9..9101fd0c670f 100644
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
@@ -1630,13 +1642,54 @@ static int zram_write_same_filled_page(struct zram *zram, unsigned long fill,
 	return 0;
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
 	bool same_filled;
@@ -1654,10 +1707,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
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
@@ -1666,8 +1719,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1683,66 +1739,40 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
2.47.0.371.ga323438b13-goog


