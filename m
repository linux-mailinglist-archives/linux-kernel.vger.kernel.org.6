Return-Path: <linux-kernel+bounces-525504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270BDA3F0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E731718CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845C209F35;
	Fri, 21 Feb 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lSmDuB/K"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1020896A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130775; cv=none; b=XAJfzO0ajc70o8xPKaAWAK+pL4T//fn7bBt50yPJK9E9G/wm7d/aEclXUHHzGeUEn/IFRVqLFnCliPqeiEFNIV6PpxcZ0MS5sfgEeZHbx3T6tBmTicpey9VorsliqDWbmVrAeG3PS9jo1UnRKkCkKZqAvhLKKuFybjp2gl9wQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130775; c=relaxed/simple;
	bh=he0JJ1tlAzKmHMaVFR336aPCxcQkLP9FrAuZmoitajg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDcYljfJz+kaBOaJ76nHPq9ARpgZSlNfdHvTT5GmzdnFDcGQN4/2i2jVc4/l9crsvclCHbCFzOjg9cb+KtlDTSnsgljPYHtnz1KlsoRYdHGQ9WfYuY9v2Um83twxJkITjkCiBZZRY6vJEKf/eTmQiArYQRv0PRXmaAsZe78CKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lSmDuB/K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f2339dcfdso32869635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130773; x=1740735573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooRAT30N+1IineDWVp9J6MTWf65J1t58JBJO7W1ETBg=;
        b=lSmDuB/KcrfIgeFrqI3zL1fKI2yxrnmqtPKa44iF7tA3VPN1Ui/bgEaENvwfv7T0Xv
         nCHy2UKChL/gVXxxm+E7EMtwmIw6VAdVd88c4M2E32Gnhb/txMvMHr/TllAlzjjDVK/e
         KBUEhXAFiE3N2SXtB5eZh+ZS8K7croTssp06g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130773; x=1740735573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooRAT30N+1IineDWVp9J6MTWf65J1t58JBJO7W1ETBg=;
        b=WM6zpQExFVcHKs/h7C8f7ZRh1neDWI/RBIWbxS4utipPiSkJHi9GzYWbsOsU8hegkD
         9ZbyDgjO1FUgtJdpWNAB7y2jIcWqyAt30vnl70YhgFdSewvBe211oe06mEhfbZ7TEf3u
         xQgIrOBIfeMhaLGeB/zIRjqnIV3iwHToif0eTkvNQDnpUjI++kgQHgoSuKJQgrSEVKIP
         itBnllz/NaLMUnydWutYjO/v6YN3daxsqdG/VN3A7kq2joWxLoDNsp3CJq9FqnfyYaVg
         jx0lt+Cp12HZZRX+NesPGpN0z8NgaBxaM4pmMBpocYidB0kvDqfJzye4A6xlkoq4PfOn
         4mdg==
X-Forwarded-Encrypted: i=1; AJvYcCWRUmLEwJL8UM1sSidIwfOvwWXGzm0HJTp15nKIUs993hXXgAC69mrWc+ZWhxNMQEdSr5TxVLgowtxnAQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4vUmWW8gAb2YBKG8RVosPLBr5mL15eVS00Yax/058IcC/OjO
	30oAtHDMhuhs86TTxFshE3hrMQnN5Vw7mY9uexgIAR4XzAEL3F9eFlwSbW6yIQ==
X-Gm-Gg: ASbGncvMwfKSZ8a/9qObqzlgPCBvwZJVNKheWzy3unxQ262Idc5Xv6QgM6E2vjdglGF
	npeoNAmHYkhyl/ek5V/FsgAwrX9ENUiHFVWvhX/Zd189tWPntjcsluc0uPGn3piOTlJZkUDtKgG
	VsN/mIG7/vGrZHZEQmmftNFvzZv90rjFH27JL6JjGtfLsewOfcdBRFfocon4E+Ct/nqvoK10Bbz
	y+AsaDIGNzykq1yiMFX3IeOBIh7VQNBCKt8DJI7eo/76sRbW25HJFNpm/16PnHFkLrFVdiO91ka
	Mm4X1QvjUxoj6Rbr0vnYml/V9LQ=
X-Google-Smtp-Source: AGHT+IGRF3A51Ju1CJymIu4QEKwvzsIx5m8/kDSMhapHrOeLOdsD4MZEno2i5dRKAI8Yq2xbHCHWYA==
X-Received: by 2002:a17:903:2311:b0:21f:5063:d3ca with SMTP id d9443c01a7336-2218c5575dbmr109218605ad.16.1740130773425;
        Fri, 21 Feb 2025 01:39:33 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242761538sm15686426b3a.139.2025.02.21.01.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:33 -0800 (PST)
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
Subject: [PATCH v7 09/17] zram: rework recompression loop
Date: Fri, 21 Feb 2025 18:38:02 +0900
Message-ID: <20250221093832.1949691-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
index a1880e621895..814e64f4ee38 100644
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


