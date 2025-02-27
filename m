Return-Path: <linux-kernel+bounces-535572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F700A474B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF19418889CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74351EFF93;
	Thu, 27 Feb 2025 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgiFKCQR"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B61EFF8C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631048; cv=none; b=IQnb4wXq2d5VaxppRz54iV8zYpN2d93MSvGJGlX5eaOSP1Rb1iDOXNOO6aVjrEzJKwi8c25bretNl+V9mIzO66QsqzGf1pfZoMqhwI8TrSQlxYfKUeR8rp6NHICVpfxLjD2AGDNJljeQVIDdIYgoIL8jB7W8cFOtR0YAk+WLSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631048; c=relaxed/simple;
	bh=RbjHDFkBxI4MbG7AG709nKXLWzCsfOvUs7CLTbEYEqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3pAZ+AAjBZI6H5FmTXoQCh3Se6EpD7ZXHIQvBwHk1GVfA2I4xsSwHPbK8AIsvZ/Z6p5CaArwpfcyM5aasa4YQ2WQAO7zGnvPu71w0rvJy4dtpYvMvFZL8MZSwbm3/0OjNhRy6cl+6oruxZrZlXROYEiJxBwXw51dmfJvXo7ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dgiFKCQR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2232b12cd36so6314605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631046; x=1741235846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6NLD2jL1GvsoHkQKXZoOwiQJj4KiHrs9duVpBtevTk=;
        b=dgiFKCQRklITU+lt0I72oSIqhuBPxXLD/0Uo10sl5n3bffizQBvyl05pQ0DYiBRP6X
         GkfKSVWWHSzkFtsLnzodGcmJGXZNVoo9cavxy//Z2Pokuu0G3oWO8MLUX8HEGSmhtyPF
         HJrIgcgHpjJ0iy7Uk2HJD8W5ALAV/qLqO3wwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631046; x=1741235846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6NLD2jL1GvsoHkQKXZoOwiQJj4KiHrs9duVpBtevTk=;
        b=A3qHh8HGMUPv0NWOp8BJWk7C3NC99+ON8/y4O1hgQx0crK0LKKTE7ks3Gg4bvu855n
         Tv48zjDJlYD/teI1YUJ+34zA1WznPtDhsgefiuVVXIL4cxP4Y8145AieAMyKWm1gVBOt
         OZOKlQQPNzXf6kI+nWMcPT1x7SzZ3DJMSUX3NlyGLS5juwK9BeLtCsg1hqGt3foKm7j0
         PT3IC13Kh2zzKSfJxcOf8EEG+hiT7aJUbL27kMoWsaNLl+sqiN/ZKK6o5fPAi6Ggdyor
         S1J1yqGI3iUjHqwacOJVg8QJqXQHgUtbcvI7jRIumtwMbJHl1FHP+EaEjztysXIZszxp
         gKhw==
X-Forwarded-Encrypted: i=1; AJvYcCXlMs7f9hAN6RD3WWBqxA3zoyFJtNZmgX3OKvVE1Da7uDTHE+9+YieVlkGKYBuMDr7z4kFWHYYiGjeJch0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0gz423/x8UVVMj2ahpSC8AcfiGfxF+OxwG8Rf5mhc+cqRCA4
	hq1przAJuy375dM4zVRnkI71uNTlis0da2d8tzryNiVdVLQLoTs/SUk80bA+xg==
X-Gm-Gg: ASbGncvT9mc9I05Re9+CpnVFsjiZNM6dzLh/Hqok5YOqWK+dSPV7zfkxe9RWf5Q4HTV
	l/m+hGL4EO7RaDn3r2NsCzCb3j4jOV5lSV/eH7XAEUD+nfLrKKHnWp0wSS/J2DPHA3iTOkrjcZ0
	6Ns7AHBcImv+1doqrUSXgISs57W3ehnCMAYf6S24vy24Hfls1p1HkbdH9tzhP7wcAPEHv6K1c8w
	pq1bLR7OGdryVJOyw7XRsAZAzNOZQaUvcH0HzyGuqaMkh+RYIAsol8Jqd4jiohYTYgM4B6n/MU3
	IMnecWYHAafl+LnXVULV/0kPI364
X-Google-Smtp-Source: AGHT+IE7XcAdc9vNrlMBc7Oz2yCA4ADvv2oX4w4TjS94Lh2tcodEasjQb7dK+y4SdRXQWBQQi/bf9w==
X-Received: by 2002:a17:903:22cd:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-2232009991bmr68248845ad.18.1740631045980;
        Wed, 26 Feb 2025 20:37:25 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fa918sm5062645ad.69.2025.02.26.20.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:25 -0800 (PST)
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
Subject: [PATCH v9 10/19] zram: rework recompression loop
Date: Thu, 27 Feb 2025 13:35:28 +0900
Message-ID: <20250227043618.88380-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
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
index 3a23dfed9542..6755ca90f737 100644
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
2.48.1.658.g4767266eb4-goog


