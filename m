Return-Path: <linux-kernel+bounces-510575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A084A31F06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73141883A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA91FF1B1;
	Wed, 12 Feb 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqwLlobW"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2D1FECCC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341970; cv=none; b=QmVnS91lmZbYgnFzWrL2d1WCGYMz2eFm/ct0807LdOdbodMUlXrBghx8DKPU9gwP1BAqMmhIQ+x1xA3EOKNnho+UFiPLgpVDGRy44uQQpoFebEJMT3h9OVyNaMaTC01BAYAazRksHWdint634NkPco1eZ27dSB2qGpgvJTgWtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341970; c=relaxed/simple;
	bh=Lr+Wmxc84QrcvanZk331Bl73+U3JT0S523UifFEoQ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxNo9qjmLuuQMj3XQZ953p9LBugqgkDe3222dspwqaR7lh4DwWQksoYcKu5sdqrawfL1+KAHgcNs6FVyEPO9r9dEwp0HWXimoVfG6vV0GzEuSqRcr1uCvffbcofzeoqj1XLCR8tG+0QRcO0UgfdN6IL/kh+Hj9ZgR9nPNZEGyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bqwLlobW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so5612285a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341968; x=1739946768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLnpAJqzl8agqjBt4hqeQuPEXwmT47X6Rb4B201CoRE=;
        b=bqwLlobW914QOjbIvfm/Eq9g0Bev0DRkWWH9vBF4K1toR38jU1kPXSMRUC+5WFoIOd
         VwuCvnTRAr+BJWotWzHd+NHC26FYbeKE1tI+DULst2o5zfoiIm0E4YX3iai5zWla+00B
         +Sll0LgFcN9q9Ev4ErpEFI4u7eChactQbjEvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341968; x=1739946768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLnpAJqzl8agqjBt4hqeQuPEXwmT47X6Rb4B201CoRE=;
        b=gIRVi1OA3j3xcMiweIctdr0Oq+itepEZxiYk+IOD/8rujDxPJBNBUIi9li8g8MCMZr
         PTmaAKL1/F4Ku7ogsiv/yI8QymrDkujoX/ixBZsfPw3ooZvtEyMgQr/Dm/ido8CqDdgO
         ybar628/j4cX6VOv5HUzyI7V0DwNLSbyaxECadgFUGPemd22ejFq8psdvngU0+g2uZbC
         Kn6D7qAudotILZ6m60F6TepvUriejWihm1mUSFxAnFcRG4rR75vxP+2xdDohHuSvHIV7
         Ocij1P3hxfJNgvyYK90xUNRC1sV+dfTpmStcOgZKrGHIwk+NQO9o+qDN6nKi3Xks9Ria
         XKgA==
X-Forwarded-Encrypted: i=1; AJvYcCWTRiLMxdFvj3Hli6/r4HZk+mSwy/J/0rK9erdkfvZpVnOQ0zBVUXrxdSz+Uhgd/4jWnV2O/+rouw5Qj1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEERYAEDzTwvKw+QuiZMq7QY/RYr1JmJ9tCbOb/80cN/HLDI2+
	hYjmQL3UvwquNKsUZm59mmTlX3P0VQ1kSYDDF7cW8ZDaqK36fB2CnEXXmvoOtg==
X-Gm-Gg: ASbGncvivmBSyWj7MMirTtb1nCWftLOLQb3Rp3HQQKQp0xLo2T6txaYF3UD+UoQORj1
	Wp/PMV6pFROjoGwAi5qlJ8z69y2g3cNRqlx4/yyHqDhKqSkXx7w5kpn00vuZJ+ErCEvzzbwf/FQ
	WkLWRM25YibhbGnFdftTpD3vIVSxDdkrI8JIsvq3QU9ykGplCGOum75l4eKlZjzoI912UWfh2Yr
	qrQ2h/PTvYNxX0mt/Id4KiX2mkj/iASOmywj7EWh9xeMaF1t/NRemfHxMBAmMsxU0cg0coVgTio
	iD/aAO1KFU8TGHIhxQ==
X-Google-Smtp-Source: AGHT+IHiT+N5GVxrJj2d7+UgbwxnPgo/4IOHt2XM/rWhD+WNLZnaiOqWIvo76vE7u+pn65YNGazKSQ==
X-Received: by 2002:a05:6a00:1798:b0:732:24ad:8e08 with SMTP id d2e1a72fcca58-7322c376a72mr3048146b3a.1.1739341967995;
        Tue, 11 Feb 2025 22:32:47 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73084e182cdsm5759136b3a.99.2025.02.11.22.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:47 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 09/18] zram: rework recompression loop
Date: Wed, 12 Feb 2025 15:27:07 +0900
Message-ID: <20250212063153.179231-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
index 31bdf5e0ff74..7c4c296181a8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1887,9 +1887,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	u32 num_recomps = 0;
 	void *src, *dst;
-	int ret;
+	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
 	if (!handle_old)
@@ -1932,7 +1931,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
 		ret = zcomp_compress(zram->comps[prio], zstrm,
@@ -1941,7 +1939,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 
 		if (ret) {
 			zcomp_stream_put(zstrm);
-			return ret;
+			zstrm = NULL;
+			break;
 		}
 
 		class_index_new = zs_lookup_class_index(zram->mem_pool,
@@ -1951,6 +1950,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zstrm);
+			zstrm = NULL;
 			continue;
 		}
 
@@ -1958,14 +1958,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -1975,38 +1967,31 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
2.48.1.502.g6dc24dfdaf-goog


