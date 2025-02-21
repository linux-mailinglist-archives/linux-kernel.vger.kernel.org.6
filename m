Return-Path: <linux-kernel+bounces-526747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902DA402AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F7542269F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF59254B1F;
	Fri, 21 Feb 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qp3O5agB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E36255E24
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177037; cv=none; b=dEyrPiqThMQXJyJDeA2gSIrDn9GNKVrVl5LS5f58b78bZsLkwspVolCYzVviOWLVKsnY/rg58G/XBT9yfp3ZIB0CuX5Ue1uDyz9XHJ2xOgJLAc1/LVQcMjfy2zzJhpuAevPJvWtd2AUbIs0fCD4Te1I0cbCNEASi7NWD3W4X2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177037; c=relaxed/simple;
	bh=hSk6vypDLVWgS72l3quJDjXIQFYMujgOSyJsLWJt3Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsPzwThG4+V40Pa3cVjtbZUNpw9KEXVIX0edQstUQDeYL6t8z00RLZUKbly2ALjuCgXEnLlftpPVFqJubZYUVc/CG9qSs87az/nCHRo6L57NbZFkH5rJ6ChAR9DDInmMri6eCnFR727Enz/KM8E+DSxOOnQtKVmhzfgRHa44pjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qp3O5agB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e6028214so59825065ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177035; x=1740781835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGMz8miVpZuxydZjLRlixJe565Cxqs6XaHLZ0PLT/Cw=;
        b=Qp3O5agBFItAd1ttiBwbQ0Btv1aOptCSc4Tr6D72mPj3ochkRdqfpzJ9kgeHc1uOD2
         MlJnMvxru4jMt0HCkZy6KOGABFjMjD/+hZKuyBdHbm5eH+yRQvA7f3yLZhqoDYSt3qax
         bvXnnkkq13xH1x2iIgDt8XtyL95hMFfXC2Y+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177035; x=1740781835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGMz8miVpZuxydZjLRlixJe565Cxqs6XaHLZ0PLT/Cw=;
        b=wq2Rrm/yP2E6yrQimjLqqZMP1RgqdWB1qmHnRgdP/nABky5t+eLMR4UExq9pcfDG31
         ElmvMu+6KEqCw0DdFp7364GSXEPcZQYWM9jMcDdccwWa6dOjEaNVo/QTyoRVM0mSQjQ/
         vu8N4o0mugR6PQQCpIBoQ55wi309cAIBub3UOFMSxrAL9ztb+fElOQIW8IzEZeKCL+AD
         ce3MZWDdl0cTpUxvWkDWyeCmPDtpplJDW4MMV1LJOCXl/RvNWlw8iHTQWuUFrTi/46lA
         whr3ELyjflY+VIOhGQT4hS7dWVFIxAUaqJGEuPcG4jMy5ZmPHmhTwzVJ4V19ujtwp9/g
         ba5A==
X-Forwarded-Encrypted: i=1; AJvYcCXuaVna3cynZljtHSGT3wSTZY79N8lALmxIWhw+0d/Sb3XeBae2Zcorl0Wg0d+q+QsZtC/Xoz6kS3DTDWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwWYVVserdlGAd9TJW4AKVgrSjJTjdrEdKc6XIeIzB4eWmcV/
	lrwYsrejfN0F36nh15VAKIuAJT7a6m+Vtab0jdb7AUhF8RYw52gwxc/Zv9Arrg==
X-Gm-Gg: ASbGnctRJ6PPaCgDJatHYLYcD+MLE/AJ/Q9NkUKQPkSIbbYUGgBVYvjPjws55zl74DL
	73ZyfCH8wPkWxDC8RBBAub06Cdd1qjHe/rLwYo962CRBtMatrKnOcE6TQ9uC2PNFA+KBlj2cW7w
	uAZvaCPgrJw1q13oR8XB4DveU6kl7gTZSMzid1qqg8HUDmJSaQiAnDeTEpZmesSGMxd2qOVT1C0
	bHm2eVIqjCY1JvTG9tE+iXOi2G7oUYrwXFC6MF2/DFjQcWWRF2Y73EbV1rDwh3tEkg124yROKS5
	CL+18+2YDWsQPFYkAGmhc6Yk4k0=
X-Google-Smtp-Source: AGHT+IHL8w233VXHSZOeZO8XETvndpBr3OMmgSLQskKaw+oSbhIFchdvDqKDGu9+zeJWRzKLmmc+Yw==
X-Received: by 2002:a17:903:2288:b0:221:331:1d46 with SMTP id d9443c01a7336-2219ff8278fmr73678355ad.2.1740177034842;
        Fri, 21 Feb 2025 14:30:34 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556fc57sm140834015ad.194.2025.02.21.14.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:34 -0800 (PST)
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
Subject: [PATCH v8 05/17] zram: remove second stage of handle allocation
Date: Sat, 22 Feb 2025 07:25:36 +0900
Message-ID: <20250221222958.2225035-6-senozhatsky@chromium.org>
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

Previously zram write() was atomic which required us to pass
__GFP_KSWAPD_RECLAIM to zsmalloc handle allocation on a fast
path and attempt a slow path allocation (with recompression)
if the fast path failed.

Since we are not in atomic context anymore we can permit
direct reclaim during handle allocation, and hence can have
a single allocation path.  There is no slow path anymore so
we don't unlock per-CPU stream (and don't lose compressed
data) which means that there is no need to do recompression
now (which should reduce CPU and battery usage).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 38 ++++++-----------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c7bc0c9f3f2f..4ccc1a1a8f20 100644
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


