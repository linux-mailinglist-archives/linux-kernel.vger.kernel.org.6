Return-Path: <linux-kernel+bounces-526751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6BA402B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AF14228D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A7253B74;
	Fri, 21 Feb 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcyB45Zq"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE41254B18
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177059; cv=none; b=PGSaq8Yi27TEPXlvFVIPL39r2bwMWAmxW7IAilAB98qsseNZm8I9rJlILIEYqMKUpchaDLjQPnBbEHnaX59L8740WlkcqEVGqQ5iBkuSFpAMfkLgRUDQX/iJJYJk3QJ8y5/narRarHRQANM0PwCohSZxiPttIqpW+ry/8aIgu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177059; c=relaxed/simple;
	bh=VAxtUiD6VaoaEcK5Q9XLVLbHC0vVIMqByf6eR6DBo5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEi374OFbBMususiNObE2t381hYMPUhYqWGY7yQf0i/+SeRVeetbT/kLjgAwjsplugWkVSU/fr1YbTOdHWciKDdJZP9La1F2dX6IKFZsepKmUnRraHC+msfBWzpivdkwePHa9lNFTfEx0QeGGfQjC175g32MS20xIWqXZnSz21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mcyB45Zq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22101839807so56095715ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177057; x=1740781857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMiFPpRmjEuGJFug3yngS8shb+rlTOrw+KkttJGol4I=;
        b=mcyB45ZqbqekR0YR4TBEg4duvbUjT/X0tmVGrVTx2ej8duuBJOqWbuv11fNNSSyJNo
         fR4JKXgphgfIniMOzcmvI775IsD5ZFIT6LrXvdM9f7Hc8CosWGAafwBgNleEuF4SWI/9
         w5rhhndHgpl2WRKD0a9x0UvwAZajFO8w1Nfk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177057; x=1740781857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMiFPpRmjEuGJFug3yngS8shb+rlTOrw+KkttJGol4I=;
        b=fP2hfD8r35epN3nUguYgZFOxRIa9YhebCHM/RVo1h6gsH+k1cHxoSdOwOatdmW84q2
         KpxeleAX7vUqZfxUkJt77/1BmQOFKT+tFFbjeFdvc0kcUfoJlWqLoydmyKg//HFtqPZl
         OOeJuDXy3PkgovA0EfqWqYfKKut/JqeoPmoRSGhzXeze7wDunUX+4tD6Fu5zip1NEbxo
         LEwf1pZw2Oc7KozNenML3gUd8h0Ig040VZiDmHTXk0/GgXLBSvSQbsE4czgGCxQsqI6F
         gf9UB0CvszucILssBG9VP31QXMMpNcUvp6rvNo7NgpqOb1L6Quwgvew8nH9tfC11bCAt
         utmA==
X-Forwarded-Encrypted: i=1; AJvYcCU387QFCMCdMA6dDOdboWYsnfUWLEBPhKegtA4YD22AqrtZ1Q9h2jWoAZGA/DrP1qiv/5qNfdBwDWoXwt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5vC+/TIJE/kABcHKqJnkg9/gX8lSJwl5w0mC093grZjDd2/8
	oOUWwlC7abXTmGb1gs6bBOg836rBpM8DE/9TlQesXWhPBusg/oNbYe/yMz2T4VPXWu+vRSwx2tM
	=
X-Gm-Gg: ASbGnctmWPdKDQRYWd9aSHF0dMLE07L4eqMzI8UMGKbNbNOs5sR9ddu8idO44453nt8
	aXaLmJVbJAyTgTKtkYEhaSdzz1cnRcb9BEXlJwWerckbivLZABvDGCyykQAu1+qc7W9kit3B/cL
	nes+HvC685KOYQoWQ/G/3OSOX6N98kXMccLMJ/aYeYshcBcEELIl8iN8LXa/YePGqb04lP8jcYQ
	sMDh9tFOOyMyxl17As0zUncDjf8pumqboBdAEJd1fBUMKBCuhLLK/NgwkbZlck9pqR8a3gfMxX4
	8r5Y8mDimLD25hYWjJ+eHEHYT+c=
X-Google-Smtp-Source: AGHT+IEQrQ7GyEMKY0xC/QjOZMueeZal8jjrcZZyRbZ+PqQnVupxiIMR8/upUlsyn1jWc83rlKp/Qw==
X-Received: by 2002:a17:903:32c5:b0:21f:1096:7cb with SMTP id d9443c01a7336-2219ff50eecmr69781335ad.20.1740177057264;
        Fri, 21 Feb 2025 14:30:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349056sm142860655ad.22.2025.02.21.14.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:56 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v8 09/17] zram: rework recompression loop
Date: Sat, 22 Feb 2025 07:25:40 +0900
Message-ID: <20250221222958.2225035-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reworks recompression loop handling:

- set a rule that stream-put NULLs the stream pointer
  If the loop returns with a non-NULL stream then it's a
  successfull recompression, otherwise the stream should
  always be NULL.

- do not count the number of recompressions
  Mark object as incompressible as soon as the algorithm
  with the highest priority failed to compress that object.

- count compression errors as resource usage
  Even if compression has failed, we still need to bump
  num_recomp_pages counter.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 53 +++++++++++++----------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 92908495c904..b96be8576cbc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1892,9 +1892,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	u32 num_recomps = 0;
 	void *src, *dst;
-	int ret;
+	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
 	if (!handle_old)
@@ -1937,7 +1936,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
 		ret = zcomp_compress(zram->comps[prio], zstrm,
@@ -1946,7 +1944,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 
 		if (ret) {
 			zcomp_stream_put(zstrm);
-			return ret;
+			zstrm = NULL;
+			break;
 		}
 
 		class_index_new = zs_lookup_class_index(zram->mem_pool,
@@ -1956,6 +1955,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zstrm);
+			zstrm = NULL;
 			continue;
 		}
 
@@ -1963,14 +1963,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		break;
 	}
 
-	/*
-	 * We did not try to recompress, e.g. when we have only one
-	 * secondary algorithm and the page is already recompressed
-	 * using that algorithm
-	 */
-	if (!zstrm)
-		return 0;
-
 	/*
 	 * Decrement the limit (if set) on pages we can recompress, even
 	 * when current recompression was unsuccessful or did not compress
@@ -1980,38 +1972,31 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	if (*num_recomp_pages)
 		*num_recomp_pages -= 1;
 
-	if (class_index_new >= class_index_old) {
+	/* Compression error */
+	if (ret)
+		return ret;
+
+	if (!zstrm) {
 		/*
 		 * Secondary algorithms failed to re-compress the page
-		 * in a way that would save memory, mark the object as
-		 * incompressible so that we will not try to compress
-		 * it again.
+		 * in a way that would save memory.
 		 *
-		 * We need to make sure that all secondary algorithms have
-		 * failed, so we test if the number of recompressions matches
-		 * the number of active secondary algorithms.
+		 * Mark the object incompressible if the max-priority
+		 * algorithm couldn't re-compress it.
 		 */
-		if (num_recomps == zram->num_active_comps - 1)
-			zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+		if (prio < zram->num_active_comps)
+			return 0;
+		zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 		return 0;
 	}
 
-	/* Successful recompression but above threshold */
-	if (threshold && comp_len_new >= threshold)
-		return 0;
-
 	/*
-	 * No direct reclaim (slow path) for handle allocation and no
-	 * re-compression attempt (unlike in zram_write_bvec()) since
-	 * we already have stored that object in zsmalloc. If we cannot
-	 * alloc memory for recompressed object then we bail out and
-	 * simply keep the old (existing) object in zsmalloc.
+	 * We are holding per-CPU stream mutex and entry lock so better
+	 * avoid direct reclaim.  Allocation error is not fatal since
+	 * we still have the old object in the mem_pool.
 	 */
 	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
-			       __GFP_KSWAPD_RECLAIM |
-			       __GFP_NOWARN |
-			       __GFP_HIGHMEM |
-			       __GFP_MOVABLE);
+			       GFP_NOWAIT | __GFP_HIGHMEM | __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zstrm);
 		return PTR_ERR((void *)handle_new);
-- 
2.48.1.601.g30ceb7b040-goog


