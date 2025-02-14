Return-Path: <linux-kernel+bounces-514352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5399A355E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FF166C41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF63189912;
	Fri, 14 Feb 2025 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JVjwezGq"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164A18FDDA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508769; cv=none; b=VmbzF3O3r4mNhf88zIDvXuBWKomgoaIaX9JUrFjSnYF+qAiheAL9cWP2N2YaB0R3xaBWu8XHsBAeY1RRUJSATg6zh68GX4kj1OciJZy3xTGVCs2cOpnLJ9dJgivgVAKMeR7rrKPTzA/6Mj13o9Gc+FmrEL1uPEInA04ndn7SJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508769; c=relaxed/simple;
	bh=JlfGwux0kZAH8W/lbMsM+5fFpDTKJRZIPd5k4wFpEQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIrE2bFGWMLk/Ug89BKb0RnkIX0ohITKThYahnDQI3AiOgBe31jowwWSfI+E2a0bLd+Lj0tva8zEeadPW3jd+vZS05Rv6uJSQ3sdfa2Ujdvqv1BBwZxR5oAFYpIlNgo8WaTVrwSvCyt46GDKsLLvGaNV4gu3NMDKyy0MeynCHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JVjwezGq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f62cc4088so29707985ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508767; x=1740113567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bmpTeEVGC+rQQykpv7em5nfwUamOzB3Vnh8lKCRtbQ=;
        b=JVjwezGq+bzLtlIOIbiH6lZST02bfBjxDipjkk5GgMRBRLuE+klDrkexQw4HCxyq4K
         0wdKns5bKB8A0htOi6wWfQvZMSekcnFzkhjm4YdxXGQ9hCCdFrzzQ02wys2repRjVgfU
         mW5LG8kG50oSevg/LRH0EtPFCwh4RiSTmeG3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508767; x=1740113567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bmpTeEVGC+rQQykpv7em5nfwUamOzB3Vnh8lKCRtbQ=;
        b=OCGMOZT0n+0PLg1fN0nBUtQF3xXGZYIUY23Wu/mEdoL6FEDkMXjp+r7VLYGDlFui2D
         JLe0AjLlFoIVob6IubNTckiKMlSnIOSdZFWDslBCK2DuSocbQJ27IL1T6XDGFCLVwERU
         BklOWQ2XbnFatjlZEdmij9dsfseNpRB48c4Et9vDhHjg+cMkuyuv1Vc9OItxrS/3UvI4
         q6WoUjheSy13rADTzg1ELtnHR2lxqC8Mt5C73nrTF8NpNUim2ukucjYRkN9TpxvvjfY0
         yOlE16tsktkpXPE4wBCC2bO1ExD4yJh9jEHD0OiGw2OFvFfNlz6CiToT0M6Vb4UWEwcc
         YTRw==
X-Forwarded-Encrypted: i=1; AJvYcCWLTJJZ4kX1T1CtRZPu6LiAFf3SQ3dUjEbjwkKuZemS96JSO+hY90XqYllrxj2EQDYryYUkqnReHNW4u1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxzB5kcZpfarjH/6wuUavo3Gn9Qvm93Wyj5gLn7Mi14YcNLw5
	KMSR+s3LYNy4jpwA/bHNxE02RVdTxMgwFSLIN8IbFq25qmFJN4VeYOKWi5LKOXLdI1oc9zXiY0c
	=
X-Gm-Gg: ASbGncuMI0Py/0sE8vcrWhUN5m8yLAq99oTpF6THYHp6rL4tGwbSlYEcvjiw4oEvJ0B
	oFsd4g+xpxI5Ud71gqI0u0MChGww4NCpjJy+CiWaXzx6ejop82oRdAj7i/mtKEag+MdLzksvkDH
	+SyDxUshd8PRLODL1NnVa+fSR1rlVOTfR1bf781retkRmtFEo+joA1wC9uVqDyZhm1Rw0lthupC
	8EQo2NLLfv0VA/w1UXdDlSPz4wX4/E5y4DeKOUoHhCw6DYUI4JqulELqci0MqcTPJl7A26fCU/v
	G0q119BjadNR5GqOiw==
X-Google-Smtp-Source: AGHT+IGEF7Dn0tVy7rM1XTaKFMcH+A1xI++T8yz9kJ3lVrfR5w/GZH5hDQABoV3SVr2TB7FEUspOGQ==
X-Received: by 2002:a17:903:228b:b0:21f:6546:9af0 with SMTP id d9443c01a7336-220d216b686mr106732985ad.44.1739508766756;
        Thu, 13 Feb 2025 20:52:46 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d558fe3asm20666155ad.234.2025.02.13.20.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:46 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 05/17] zram: remove two-staged handle allocation
Date: Fri, 14 Feb 2025 13:50:17 +0900
Message-ID: <20250214045208.1388854-6-senozhatsky@chromium.org>
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
index cc4afa01b281..b6bb52c49990 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1766,11 +1766,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1784,7 +1784,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
@@ -1794,7 +1793,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (unlikely(ret)) {
 		zcomp_stream_put(zstrm);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
 		return ret;
 	}
 
@@ -1803,35 +1801,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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


