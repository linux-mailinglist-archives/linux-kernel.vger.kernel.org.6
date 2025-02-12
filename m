Return-Path: <linux-kernel+bounces-510571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57540A31EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872F51887C18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA711FC114;
	Wed, 12 Feb 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OSdPdUJ2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D51FF7C8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341950; cv=none; b=CH5Q3holIk7dFcwde4IKO1bVHL6KKFzph51P9PrQ2NukUDl0fy/AEZjy0LDFgpjPAtp+Q0ZHlGZ6nD595fJFl4DSeYVY+5L5BJm2RODTJaLcow9B/apyQwmf5K70J2lnwHlV652wqwNQfTAM/3vsvAgntfFnyO0XqnRF0o1KGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341950; c=relaxed/simple;
	bh=NU4ULCQ2BpSp4FDI53G1gJZDMlupH3u9ZyEy7/VHAdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikdmvhSNAQ2KURPrU+9hKuz8mrhleA5rjkuP102tnqPq11RAHlSrx64uZIaEyBBWzJ5ExbLt/JxqC+Rk8HSX50iRrqmwXhhDSBcf+eU0LBpaLaOU2DWDN9mGZmXmGZbL1PsgGmDtueev4Utrc8TWtsn7I5aMrbfP385W7t51fSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OSdPdUJ2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f0444b478so90877465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341948; x=1739946748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEMWhAClB1d5xqcLAEaUS1zNcFLgRU1myRFnr10zi+A=;
        b=OSdPdUJ2CFCyjT2Vrra0/zQRJKcxYsOshDV+gpdt9jvz5WcYJ0CGpf43vVlr7LDNPt
         ETRZ/uAbdj/6qTubF1AZg00GpemvsQNUCwkoqmNQawvkAeofua39nLhDLJLydxAj0/Pr
         RCyQnJAt6WZuZ3I0MW+ichPVX/FL0bkFDWU+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341948; x=1739946748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEMWhAClB1d5xqcLAEaUS1zNcFLgRU1myRFnr10zi+A=;
        b=n5xJHCp95zd0cdr5HIIbzzbv7t2YFXrGPJmeIsjqK2HF15n58TGNPZxiyVSBE/YqL8
         hbieCsSWKZ9Lk6Wfd2a3ACxyNMRuw2zI4PQmGVCYuqOXVtybuXyqCcj6U1Z+7Q1smZx9
         AyEobQFOkLb0PiSH+YKZeRXpvCQLXmc6uNB5/bIuK6QnfcnI/XNNgQsJsXlhDMR9xPMY
         R0xxIui7TRBaf2vsKitjhOovuBH7LimQwQJgWdqHmrenIjG4qq/aRaT2v2e67D5EsPuI
         5YrRO+w43t7F+9t1iU0ayh6z12etQ4xbo5i2ArYNXuXlIFSBg7SqY8Bthiel72ltPda6
         rEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy/mrIElbyexcEXomPb6c40AF6rRG1UEC9VigXizF6+i3W6FjztnlvYDpgqk4VX1oXqOWw5nCAb9N7haU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCD183piDflnJhyWl3PqK9QW5iBJH47U9RgufLWoDAWcto+MM
	D5AE9xSV56YkZYQEZF/gdMcT18GrNcU5kRLlHb6UEgSw7sgBwhk08iiex3H/ZA==
X-Gm-Gg: ASbGncvMW5MV74msfo+q3HF8abzdA/XvqkiH/b/ijRwr5Vf/0wReDj8xSYBmy19IUmG
	W3qRICPRWE9STja28MSsePqOf2iRIy7QlTjrMBRZ3yuYnyFqEhBW1chHhhv6ubYuJ2kdyQ/twjY
	byg7w83JmIFOXmTEcV47WulZbWvfOgY1FpFxbi0DlgLmZzpmrYZixSh9eXI1znihlZJsY12IzUk
	pPJEORiCibwoushgW6+JiNQAUNnnIFywn5j4v6JGRM/MoRbgjMBhUh5C5Hc/2GzRFuxcqu2PtFb
	7eyPKXiWBG9+DFUdJg==
X-Google-Smtp-Source: AGHT+IFA+EnqkupBVK3/MEPCQX2ZjyTTOUvx22Z0kt6I03ZDDZCylIMnWUqaHODE62jxmfspsUlwkQ==
X-Received: by 2002:a05:6a00:804:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7322c43107bmr3332267b3a.18.1739341948039;
        Tue, 11 Feb 2025 22:32:28 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-730862e72a4sm5749487b3a.103.2025.02.11.22.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:27 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 05/18] zram: remove two-staged handle allocation
Date: Wed, 12 Feb 2025 15:27:03 +0900
Message-ID: <20250212063153.179231-6-senozhatsky@chromium.org>
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
index e0e64b2610d6..6384c61c03bf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1724,11 +1724,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1742,7 +1742,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
@@ -1752,7 +1751,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (unlikely(ret)) {
 		zcomp_stream_put(zstrm);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
 		return ret;
 	}
 
@@ -1761,35 +1759,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
2.48.1.502.g6dc24dfdaf-goog


