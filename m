Return-Path: <linux-kernel+bounces-540877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECADA4B60C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B110916BFAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BDC18A6CF;
	Mon,  3 Mar 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFeHJA69"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EE1CDA3F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968701; cv=none; b=KSzLqCBEXo3hZcc0GxCgiMQ83uHGADLq6eXPraAFXbMncyWoWSdaTuxFbWgNfJUmuesOfrWf7KShf1I/3htxcUS/9uXK6vOfF3bDkQL+/wKc4jvou3nOEBnKdeixbJMbyqvw8L3RrmEGjJJzFYGJwZa7Me2CvpSYmZn65ZR5dsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968701; c=relaxed/simple;
	bh=OOj45A09pa0t1zyHCgNjU5kknK7w1UAoEzwsLl3drpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S67MFtBBSf+Sm3K/wU99Km6WX5LHCZr1iMS+5881t+0k3ztkvKtRprT0puH/KcAqsoxGHWE6bBUMjJFN4ss2W8o1wW8JcO+K+oJcZe6S1Z+dH37I3BfIfhhJI7uVWcITW5rCdYsTGzB19D91hWFRuwzIrHxk1iCiV9A+Zq1bwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QFeHJA69; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223959039f4so17316175ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968699; x=1741573499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qnIjXigJRpaB/eOXemhT39qobrTOIzhvUPCZvOaudo=;
        b=QFeHJA69EktCeOAb0jhzUEZq0IgEfASNeFglpnHMHzOtpDNomCUX9hJxXIkyuMASPs
         ypL4+geDLa8G/cT2XRHyCcDoK/+Z/w0Awb5Z52D7Sp6IXTF48xDBJeX/hG9hFyULdJTz
         4LQXOUfSvhvJMMvt2039bWTRdJ9RtcOpmOoPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968699; x=1741573499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qnIjXigJRpaB/eOXemhT39qobrTOIzhvUPCZvOaudo=;
        b=YYthZx+wa968nV91JKiOJuB4RdFYJJnuWSnvgFUkKz/qcp0Emh3kMhLuFyB7vraEYB
         oRXPc6PWexoRQ3uwwXTMt6o2sN6Qj+uMgxszd0EqhDl0WGGrPqxPvZOprC9T9yQ6IoP6
         bvo8e4MhKmIosiXGZF7xvrWvrPVltmJDqAbElft0tz0aW9yRtxgAoDp2yBMjzlsHyfoy
         IQHDIhMZzsdNWkCYwxYGVL6Lkq98IixSHcxbOCf7fufJrH+NZ+EWTfbEZ4D6inn9ak8w
         mIe0cAiN76VyvNqLOd3qexqGIXKe915Ow9phnicQ+FHS2EYYhw4xqTYGSPIP3jc4r4wB
         WNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC86yZ1qC2VfRtrzTxHuOTt51CW9nJk3M1PR6aMY84SOt/YsjVcJ9KDXVZDC8Gu6ata9FpcqHrxt2BTkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TQMz+W2rzNr5cNk/6ZuKhMTCiaBAPbmBavLo9pASQfP7z3CE
	Axhnq/WKLHAdbJDg43vz2AUaBKYTMrI7d4OtO703ggwfmt+HNGldJgaiM8qwiA==
X-Gm-Gg: ASbGnctN1m7UlE2QT1diZgNBR6/CH1CdhjBhTfu7cJn6TBuLuB4ZnfdAx3gmXI+Ya5t
	jazebt7KO9/4WCbfl+HOG10Ei1kGpmmAP0Iwfa15VNS9eehkHp+U0fMzHITgcBnMuGcEr4z/2/W
	h5fyIKio2RPUzYOlRMFcpnHWiU64XbZhK5QFYuMzyzuWHnGFyhBpQNq+gDLyRDyHataB/kPa7rW
	cKj7mhx36cAXttUBE/Bsbhr8EpXtQac3bzzv/3bRSwe+Zdvwzx8DFDn4PvUagFs4DLJqnGLCl+q
	EtxSv4d9EmsU+28sAXxPSmQqNEI9g7ZqCQLtth7IxbLbh6k=
X-Google-Smtp-Source: AGHT+IH2tyXRUFNLNEQKOHaFYFPbUYX5TokW3hDEBo4R90Yp1othTxhspagFYn7ka7w60KBXBXHJeA==
X-Received: by 2002:a05:6a00:1795:b0:736:3cc4:76db with SMTP id d2e1a72fcca58-7363cc4886amr7491350b3a.24.1740968698689;
        Sun, 02 Mar 2025 18:24:58 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73632e76e1dsm3701620b3a.89.2025.03.02.18.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:24:58 -0800 (PST)
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
Subject: [PATCH v10 05/19] zram: remove second stage of handle allocation
Date: Mon,  3 Mar 2025 11:03:14 +0900
Message-ID: <20250303022425.285971-6-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 39 +++++++----------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 93cedc60ac16..f043f35b17a4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1723,11 +1723,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1741,7 +1741,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
@@ -1751,7 +1750,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (unlikely(ret)) {
 		zcomp_stream_put(zstrm);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
 		return ret;
 	}
 
@@ -1760,35 +1758,12 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
+			   GFP_NOIO | __GFP_NOWARN |
+			   __GFP_HIGHMEM | __GFP_MOVABLE);
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
2.48.1.711.g2feabab25a-goog


