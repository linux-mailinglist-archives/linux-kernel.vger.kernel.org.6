Return-Path: <linux-kernel+bounces-514356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB968A355E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2683AC910
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D0F18B484;
	Fri, 14 Feb 2025 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vd3FEwaw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DA17B401
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508791; cv=none; b=l6K63yShkIXqroXPtqiTbdHCt4bdTF5agpBL3rMQU4ljQIIH3fZy+1VVUHSfOoQ1r6pO1nwHN0agqEKZbm2TfC2iRBixNA0aMswRVaxqYnLK7H2LqY/IEQAbEols1Xk0WSQ7Pf6FfHJZOIdmfL6FH9u1+w+LBOPZ5PZImdu+eLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508791; c=relaxed/simple;
	bh=tsClRihFgcoC34SqlnjNg7NJPY67B75g233Q8v+7jwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBt2vpbsk+bss3dbOWJUZQ6luLpEfxz4hFUXExoCrVHg+hw6x63BQsgkFfDS5IK6DQnbd35yRLqGXhJb40rIuSTQej9ke61lBBtw+rsJxqyfRa8x788SHxflvYJbYaH6uTjxgb1aj7UHXjLi41SBIFPY2g2t7RIOT6uVsKdFJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vd3FEwaw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220bff984a0so28940265ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508788; x=1740113588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/xbb64LFlIEuFMcJ/r7e+VdeaEJuKPUYJ75LZ96nQ8=;
        b=Vd3FEwawGLB2Yn2cgGsE2acKNu9IL3VEbu51BUN8uuM9foH/+Nst9n6DrUYE6i+hUa
         uS7t6XzcKuKHFyfPJ2g2PbXSbg+7iuglvOfSHurYYoPKSsn59spe8chFCTiuZvMYcjBe
         pqGoTTTGWr4uQkUb7EzH3ulNkFiKNmE0uXCvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508788; x=1740113588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/xbb64LFlIEuFMcJ/r7e+VdeaEJuKPUYJ75LZ96nQ8=;
        b=jyWQ1l4zTEJINhbA5Uxk8iL4ZFsOvovYG3G67+PBPMeCUu1sbRI0vgXo1XUlvy/2X4
         bCSdw9LT5H9secwUq+v8VI6/vtfjWRCre7kpeGIcLBiFAybM8BnG0UtlYZyZmpL7wkV1
         NSu5PTjKc5BwtWrBwYFQHIENr3HOlAAQz16f3O+ahdW3uqjTPsGY6wD/OhcBEgopRuJ3
         nSOTnyili695U22qGlfNBQZwn/hKq01PDTuQ2iLMiFBn7k4UYu+jrgCfhOhfYguxzJie
         jrB9WKlTQGLoivyWXRCj6Yaky8EpW7byuuNNVY/dUU/YkY2yt6X6fi4MZqjVWteK+I51
         y68A==
X-Forwarded-Encrypted: i=1; AJvYcCUrkdIROs4LJFnR8ChZ+tQVE1VOHCzcntqzT+w564rAYvFdIZ6rYldEpDNQKNWbLOlm7ezI5SE8rAjzE1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkF84zCex/k2dFUjp2ll2CDSE3xgLEqSBY86rZTuR9EXdnj7c5
	36IhXZXSHvoPRHEnYsojSxiV0mBkX7pN7bCmkd9gnLHFk+6eXOz1Mlm+Ggv7jA==
X-Gm-Gg: ASbGnctNqaZ/m5/xU2DopaLkC/mLa3RH+NcXDpL3Oiei7uDUEHRH0VElBfb24G1tKph
	X0j0XDaticg8qM74eh6uG8SFIiNRNvtCGAErrjo7Hn/7gv15fGxhNcs1iFtZL44HF2n2K1dP4JJ
	Q0OUHJi2BTge6AD4vkwCcj4IdDrKRA4VxVXlErJ0O1cA8I1y7mxBXs4vaMN9BZFafC9y+IX1r99
	uN4FZ3gTk1qLhM6AlEBur1Xc9L62famcVeYYPZkI59nZ4lEjjKoYUqMzXKoVDtj2/l66nEgeGtW
	iO5oXHUUVMXapepEQw==
X-Google-Smtp-Source: AGHT+IH47sqL4VstyP3CQTqYF0OisImdj6UBrruloe47Ytl0rlHucdtsjUQ25uJQt/qj5N2jpQbI3w==
X-Received: by 2002:a17:902:dad2:b0:21f:baa:80c1 with SMTP id d9443c01a7336-220d2364ac7mr109012865ad.53.1739508788597;
        Thu, 13 Feb 2025 20:53:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556e15esm21001265ad.190.2025.02.13.20.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:08 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 09/17] zram: rework recompression loop
Date: Fri, 14 Feb 2025 13:50:21 +0900
Message-ID: <20250214045208.1388854-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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
index 5f8e963bd513..2e46ea542ecd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1929,9 +1929,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	u32 num_recomps = 0;
 	void *src, *dst;
-	int ret;
+	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
 	if (!handle_old)
@@ -1974,7 +1973,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
 		ret = zcomp_compress(zram->comps[prio], zstrm,
@@ -1983,7 +1981,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 
 		if (ret) {
 			zcomp_stream_put(zstrm);
-			return ret;
+			zstrm = NULL;
+			break;
 		}
 
 		class_index_new = zs_lookup_class_index(zram->mem_pool,
@@ -1993,6 +1992,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zstrm);
+			zstrm = NULL;
 			continue;
 		}
 
@@ -2000,14 +2000,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -2017,38 +2009,31 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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


