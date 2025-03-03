Return-Path: <linux-kernel+bounces-540882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B322BA4B611
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B944188FF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB91DE3C0;
	Mon,  3 Mar 2025 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NI7s5naV"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55671993B9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968725; cv=none; b=p2IN38JDFzqc3rDUH7rVUQteUh/0KrFVD/SpmlkOpJn9z9rKXbnrU+LHu/4T5njE0jKeG9f4RAkht1K7O/sAYdff8jAEUD7bIJotZu6jIg52KdJDFu8xE34j5RokGEaMmTQxYU0FkaiOk2MeLI2PAf5jlDhLuFHHOsAyprCWF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968725; c=relaxed/simple;
	bh=2ZpbQwE8lXjU9ojwoVL4iVfganER1zQltghI5w7rM7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHz7QWEWamdaeMM/Ux33o3INp5KG3mkbd/piBVr0+oDq9HgWDE0CA2SqpOiEr5E02CJaZK6LYM4DnLlTR9fjsUvjGWDLrjId2tZ4R7hCTwFNXBXV345DA3JN7gnzqhQEQ0wKwOFAtWZ8Ew4UKYJXgvnPPJ+08rphzJJIjRNllTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NI7s5naV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22356471820so59491915ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968723; x=1741573523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsfvfF6qJrjX8Yvxt2fgmxWzD/A8epAgFC3OUlbDf8w=;
        b=NI7s5naVbZK2QE4oUmiZKHjO/xm8txM+v4tJB+kVy/smMeQEKGsZBzkLxhNmDjPqhJ
         zuzWh/rxUp3efDOuKB33lb2ljAMM5KYdCm6dk/hQSSBU9RnnvJ4QGW3TGYQY9XVbCidM
         GBhetfLOxoHW5yZOAEFhneUTZJGPzS1D8u+0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968723; x=1741573523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsfvfF6qJrjX8Yvxt2fgmxWzD/A8epAgFC3OUlbDf8w=;
        b=Sndv2nDBBlHl9nSnGzvuvnY5PwkXoGznS3P+jRFnwW/IbMVpIq/EJA63KVOEakfD6z
         ky6yr39y9Wubhg/UOwR/ugr/kMrjzAQ6lUVEd3szCyTLQoLsEPz4kaZleeJ/u8Ek3e68
         gqmY3mBjSKSOOc+Tl3laqBi43dloHsYbH1Y5V1Rssj1WrMuo7dmYzEBZ1qUUcD+6PqGw
         TzQ1qjzhu58wooRt5M/s+6OWKp3yU4icxf7dOn0lpe5TZI9QoCc1RUKYMXfZy0FMOSnV
         PiwwQA6dfT7dN5mSY2HMvFP4lmt0fa4AhQdJX8IKVfiA8I8CUPx+jF+puWRarDmbhACI
         MfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV87UWl3NhnqebukseGtdOsH79M/xakzq90RISV7oqw3vLsMEVWzUb37iOR8mBa8F4ihdrzEhcPok1DrBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNUDH1kyGA2R9L/oGrPLaYj7/KPnzCkekGC0BjeCI4g8HOKDz
	VFNPQ+FjfgwKukatL6i0uQZArPXzBSDL9Jwm09wtC0EMQllnn4jvvmasjjU09w==
X-Gm-Gg: ASbGncvEYnrscL6INoO0mSDGoJ8sA058ihXZ6erCX9bBiwNzRPUPHQmGNAU0CW5x+Uv
	0k4u4sHSzLdteWgN7fXa5Cj78AsEWsAoJaqQJ1gLloEthN2QYjnlgD3vU65e9in198Q9EQqJPXw
	r9CqqLey+PftOrDPBBFx+tuQbpttFl+YSjvPWyeIN4jhU0RnsskxmiXWJ7Zl4qMD/aBNT6uTUDq
	Skr+LdJXg5WuXDkfTXIkzwTHM8lAm6xrKSyZpTzKk/W5MPFYFIl036l68AbulDde/lil1wrUgQb
	MiCiXSoh9/L8iK3Qibpa4Zm5U0qiqZRMtPbW/HzfKC6V4eU=
X-Google-Smtp-Source: AGHT+IESsySExdYFB+0EQ5FWR9mq2/h7S2JmgVfs+L+05mw3XKfkerymt3bltrTq9TH/mZJI9SEzSA==
X-Received: by 2002:a05:6a00:a11:b0:730:927c:d451 with SMTP id d2e1a72fcca58-734ac42ce9fmr14388946b3a.20.1740968722924;
        Sun, 02 Mar 2025 18:25:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7364ba1371asm1572928b3a.5.2025.03.02.18.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:22 -0800 (PST)
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
Subject: [PATCH v10 10/19] zram: rework recompression loop
Date: Mon,  3 Mar 2025 11:03:19 +0900
Message-ID: <20250303022425.285971-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
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
  successful recompression, otherwise the stream should
  always be NULL.

- do not count the number of recompressions
  Mark object as incompressible as soon as the algorithm
  with the highest priority failed to compress that object.

- count compression errors as resource usage
  Even if compression has failed, we still need to bump
  num_recomp_pages counter.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 54 +++++++++++++----------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6dee885bef9b..bb88b63d193b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1888,9 +1888,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	u32 num_recomps = 0;
 	void *src, *dst;
-	int ret;
+	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
 	if (!handle_old)
@@ -1933,7 +1932,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
 		ret = zcomp_compress(zram->comps[prio], zstrm,
@@ -1942,7 +1940,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 
 		if (ret) {
 			zcomp_stream_put(zstrm);
-			return ret;
+			zstrm = NULL;
+			break;
 		}
 
 		class_index_new = zs_lookup_class_index(zram->mem_pool,
@@ -1952,6 +1951,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zstrm);
+			zstrm = NULL;
 			continue;
 		}
 
@@ -1959,14 +1959,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -1976,38 +1968,32 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
+			       GFP_NOIO | __GFP_NOWARN |
+			       __GFP_HIGHMEM | __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zstrm);
 		return PTR_ERR((void *)handle_new);
-- 
2.48.1.711.g2feabab25a-goog


