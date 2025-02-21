Return-Path: <linux-kernel+bounces-525493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE0A3F09B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E325C176FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0E6205507;
	Fri, 21 Feb 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IvqTspUP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE832054EB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130753; cv=none; b=lGNrA+RvYLzxWng5FXuj7tnH8rgROTP2NiWmzC2wKkXlkt/t+0jieBpuO8G421kkLPJjUc2WxFo6nbGE086f9v1AHEbwr08ChpSi+PrlsRHaRvCqdEp10zMVq2jtTCOSB3m4nfF98Bqkn/9HkopFYueCA3hr5uqFLdsPfzG+IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130753; c=relaxed/simple;
	bh=YNxl44SVgFTxhmVX0z+tp2pbKpo9Qn15mQunNlHOXpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXjlm2/y1TmhnRZ2jpJL8jaRWDlXuxKcEHJAQz81SROV8sjwzS+VqG1xKsTjxllmg0dEnYGUBklXpGF59CCWFp8fLxtPq1+lj0FgCk87z2eAo5fiQA7eAdk/0WPQGXKphryiW5LpUrhYbp3iLE7Vx/YpOzqOVdZBk4b+qKKWTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IvqTspUP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so39322255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130751; x=1740735551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owpeQWEBy2AJNnuQaGP0HmEMVbn5ZGw0EqTWg3icB+A=;
        b=IvqTspUPoAnpWBblZTIZAhNEKdsHFq5zyViuubXH4/hQZg8CDj4rD3i973VklK0PjM
         NhBgkrvrSiBEMD0ABhr12eBOlaze8IgPbqA+6KCPcUuZXVBiQ22+2nbtK3Twa8uvQn2L
         rgZ4B0qcZWoyQYsvYK3olnT3HdNYo8FoPVaV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130751; x=1740735551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owpeQWEBy2AJNnuQaGP0HmEMVbn5ZGw0EqTWg3icB+A=;
        b=wcWR4rBOn2S80VX2wuXHduuQRfXBxLHfHka4WEFBfol18rp81hLRiRi6HKlBwkIt6l
         zVFRWWGkgGQmNihZu09Fpxg1Rnp8VBMYgiSIk90dB2If+Fo0S/GKqPz+Nc4SdUiVAF2u
         akax883Qy4ALbLOFZOjETFBwyb/7gd3QLkXRstK+kfGBGcrNAUVxRbd7JuY1X6lAnoLj
         SIpJtViCYwVPBKqe1ajCaUelSqs1HZ9Noe1qKVzZlDszYB5vbbwaoAyHTmAVL+GO1hXO
         csP0R8hkNhzkZGWD551DY4Q+s5r1iGoTo4niHa6ByUsAlHAW2pErXi2zkcYP8MBj+ZbJ
         vDoA==
X-Forwarded-Encrypted: i=1; AJvYcCVla4J0Yh/v6/Yej0Og3yyK9byFAnl7jlQdGsTH8usi9jF0220jZGmTusKR6sbfcS++CWiRTjLrK9rAvzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46NTrMHz1hhDb2Sda7G1JGeAUu27nDDj1SaROg/vlsGmtqxMh
	zck6vhPvOrGw07IVOutIWhn6ncuZS2eaH4K2DL+AbDrfe14CQukAt4WTjAmk4A==
X-Gm-Gg: ASbGncvTxrkG5At/Kgn7H/s3P0v4iqFD31evrngQZm0cmaSHRohASqwOiZd3rDhXPMU
	LrbQNfjKb43gPHEuLLT+kUorAkpSNG41KS6ZZhqLZCDVHXOnsU8di5rPlBqnrxDaVc2Ba2jASXy
	G1vew1QGXYJkm8mh9WVJ8QIJVrHtMxHRccc5tpD4qHsAM1i9HmzGej7+UxOsd0dYOAFB1G9KzZt
	nucaEbiHncwgWX9JLRkuQOSScsya/NsCDisLLkiVvVepocCwHLibCfJgjQUM9B0hK5Ob426L30q
	vL2SReLQhfi8Lt3d0+83t7fmq/E=
X-Google-Smtp-Source: AGHT+IEr9op50ypLXHrxjr4hZ7IvQcDqM446lcCXIuVBN0RImmgqBI3rJCeE1hqij4hU017n9SwtSg==
X-Received: by 2002:a17:903:2309:b0:220:eaaf:f6ec with SMTP id d9443c01a7336-221a0ec9501mr37135415ad.5.1740130751439;
        Fri, 21 Feb 2025 01:39:11 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5367e97sm132666595ad.61.2025.02.21.01.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:11 -0800 (PST)
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
Subject: [PATCH v7 05/17] zram: remove two-staged handle allocation
Date: Fri, 21 Feb 2025 18:37:58 +0900
Message-ID: <20250221093832.1949691-6-senozhatsky@chromium.org>
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

Previously zram write() was atomic which required us to pass
__GFP_KSWAPD_RECLAIM to zsmalloc handle allocation on a fast
path and attempt a slow path allocation (with recompression)
when the fast path failed.

Since it's not atomic anymore we can permit direct reclaim
during allocation, and remove fast allocation path and, also,
drop the recompression path (which should reduce CPU/battery
usage).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 38 ++++++-----------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d3b70aae2660..b805a3661101 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1729,11 +1729,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
-	unsigned long handle = -ENOMEM;
-	unsigned int comp_len = 0;
+	unsigned long handle;
+	unsigned int comp_len;
 	void *dst, *mem;
 	struct zcomp_strm *zstrm;
-	unsigned long element = 0;
+	unsigned long element;
 	bool same_filled;
 
 	/* First, free memory allocated to this slot (if any) */
@@ -1747,7 +1747,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
@@ -1757,7 +1756,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (unlikely(ret)) {
 		zcomp_stream_put(zstrm);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
 		return ret;
 	}
 
@@ -1766,35 +1764,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return write_incompressible_page(zram, page, index);
 	}
 
-	/*
-	 * handle allocation has 2 paths:
-	 * a) fast path is executed with preemption disabled (for
-	 *  per-cpu streams) and has __GFP_DIRECT_RECLAIM bit clear,
-	 *  since we can't sleep;
-	 * b) slow path enables preemption and attempts to allocate
-	 *  the page with __GFP_DIRECT_RECLAIM bit set. we have to
-	 *  put per-cpu compression stream and, thus, to re-do
-	 *  the compression once handle is allocated.
-	 *
-	 * if we have a 'non-null' handle here then we are coming
-	 * from the slow path and handle has already been allocated.
-	 */
-	if (IS_ERR_VALUE(handle))
-		handle = zs_malloc(zram->mem_pool, comp_len,
-				   __GFP_KSWAPD_RECLAIM |
-				   __GFP_NOWARN |
-				   __GFP_HIGHMEM |
-				   __GFP_MOVABLE);
+	handle = zs_malloc(zram->mem_pool, comp_len,
+			   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
 		zcomp_stream_put(zstrm);
-		atomic64_inc(&zram->stats.writestall);
-		handle = zs_malloc(zram->mem_pool, comp_len,
-				   GFP_NOIO | __GFP_HIGHMEM |
-				   __GFP_MOVABLE);
-		if (IS_ERR_VALUE(handle))
-			return PTR_ERR((void *)handle);
-
-		goto compress_again;
+		return PTR_ERR((void *)handle);
 	}
 
 	if (!zram_can_store_page(zram)) {
-- 
2.48.1.601.g30ceb7b040-goog


