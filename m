Return-Path: <linux-kernel+bounces-535566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D5A474A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFCC188D06E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6641F5832;
	Thu, 27 Feb 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvQdBaIo"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700021F5830
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631021; cv=none; b=OKZiCfH/Lq3AELe2ig+67CxbzUFuL8IZ9JH3pqOMqCUhEf8ggeKJMwMGr3EQ6j4qHL1zURUrTCR70glgaRiX/GL1QUtNdrPPku4xKob3jDQHnZK1uHv2jqaThvwlcpg8p38chyizf2psuT0JLJ2hW7wV9QEb9M1tv39OZbOkwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631021; c=relaxed/simple;
	bh=nWo0kbrzIofdLaGq0AQCS3Ixn04Y92oVHz9liJwKC/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkyeuwjvgeD5OIbnbWoMC+s6Aktsagqp3KR5yt7dvWO7ZSAfVSt9PRBUL+QEM4bynDvnIRGAaSJtWhk3iB//Xko+ybYceQVPT7Zzx6lCcQPGitnz8ilJerC6hI8wiWaPYkltLuSg6EJUUBg5p74OI3f6DQD1Ef+W3HFS1412fF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DvQdBaIo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8f38febso8027685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631019; x=1741235819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be7BmKV5Rl+tSCSL+PenBDpRFLFJDOVjENq1jnQl0Z8=;
        b=DvQdBaIonyCPIMCOzJbQKWehdfqW7SA1KniYkpJxceOAxvLDQVZ/LM4oCLBWa3TYjT
         y4RCRmmHhSMnqmsFZGljG5EN1f7iOQY1c2Y90rtwixElCVVpQdEKeVTJivELm9a0eXX/
         YI2Kx/IpX1seuywD03glk/L1cCeoO/1yz+hDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631019; x=1741235819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be7BmKV5Rl+tSCSL+PenBDpRFLFJDOVjENq1jnQl0Z8=;
        b=bs+LWpRiDo2w8bcHUu+v4TtIiHdfpsxDexpwP1yIvqHwotxGu/FwxRRH95UpimfW8M
         VUG0Jtj7NanJIoT2eqEs26Mt/qNPSbQYaAFotEm5HWEDN8mPSbjg6v6G3UhV0MzIxqdk
         9f+NpXvPcTO9FeFiMeo8joHJqrPC0gmNO+jq0Yj3/7pBmDvqZs7pwLfa0E52fgBSfGEx
         xe4zCdjv+0Z1BmZqCFWazmQrgFIljCFz453l7c9Hsk5afyZWuk2WYwvF9zG9uGdN2XR6
         7p+JGi7zl8GqqfqJFsFjXUAwRgMjCj1IenyPjtESZaNTV9zvU1hHuESXco8oaEfD+j6y
         pW0A==
X-Forwarded-Encrypted: i=1; AJvYcCVMg6mRpakJyozA54Tah6kznC3HWS8Kh9JNVMazhGkEcqD5ViD3piZFsYL4CrUv6DVn5E1/qfdEQhCcgHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AK47Z6Qej75VEOwhyPQ+PltSh7tBzPwMf7eLkHVcTJHCCU8Y
	rerDcZxPqs2G5nl8qrLLz/xESwXoYA05o3xjkCMzHrf7Vi0WMBujBt5b++HFvA==
X-Gm-Gg: ASbGncv2bK7Gsxz6xw2d3jnBHLYXuIOvXe5ZY/4+1H6pQbrVC6O29YjeMsWj8y6X0LF
	MD4UHqT3mEhhI1oHeAPbGfUdfWR/RSTyOcTn0Oafhi8dwCxjaWxGJkaR2rtdOoKn9GNkJL94Y0k
	Xvu2a/rsthepNXRBTzIQIcsDoKCz+Nm6naH49sHh8e9/3GXaIQ3ZXB/46jOO9Sahwzc2Y6S6izc
	4Ur0E9dFx+KIEL2AxR79Xin7zelILCnSQ/lDV38ncyT5T4bjl3feD63A3doX2nV8cYXCKh4ZFD2
	IejtkEPUUkaEyLlnCcD2fhI0rSTx
X-Google-Smtp-Source: AGHT+IFJgaRFQVylaLj6I4IPqbcJ3f5L/ef1xGtQVqtC08AgMT8m0YWQWIDG6Ie7Da0oM3f1AlVfQQ==
X-Received: by 2002:a05:6a20:72a1:b0:1e1:ca27:89f0 with SMTP id adf61e73a8af0-1eef3daad8bmr44973568637.37.1740631018819;
        Wed, 26 Feb 2025 20:36:58 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a003eb70sm485399b3a.124.2025.02.26.20.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:36:58 -0800 (PST)
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
Subject: [PATCH v9 05/19] zram: remove second stage of handle allocation
Date: Thu, 27 Feb 2025 13:35:23 +0900
Message-ID: <20250227043618.88380-6-senozhatsky@chromium.org>
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
index 5f2c08337ba9..28aa1c437d83 100644
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
2.48.1.658.g4767266eb4-goog


