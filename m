Return-Path: <linux-kernel+bounces-243001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 401FF92900F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FB21F225D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9A1CAAF;
	Sat,  6 Jul 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNzjeYY9"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C541C2BD;
	Sat,  6 Jul 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232750; cv=none; b=KMlpzw6a9H5cNN97LYHiqLAJ0EFTWaOhChI8HmTDqpBkFL0enAc97lxmcRqFBWuP/VqKHMDi+rBxlli5c1Vsn+8IaHruPF9Oic4DmiDhidVVF7nEuW6rN3Lhz/S8eakM9hOjonOCauqaOUnRqcJ5Y8Wpy85OuKkIkeXVAFtVWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232750; c=relaxed/simple;
	bh=8Mms8FXw84NFJNBv07yLOBdviMs50aQRWtunn+75OXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ssp25sHnFx2k0Yi5Ah1qOnSV5WhFuZeAuNx1y5Z0edDu6SRJL5kUJ7ZWO6/en1MfsIYXiLtL5aRV/tP2XSfQQl2rNoUyNsxReHoyaNaKq2aW23o+yJHfN/aWiDs8HrnL+TV8iGfu7VX12x4h/Cu29MbR5nNhuhlNPSBz4bD54C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNzjeYY9; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f684b2a4c6so29834039f.1;
        Fri, 05 Jul 2024 19:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232748; x=1720837548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRoXdXns+v24A0oUujywQmDw48klACW/EhvT639iYLM=;
        b=DNzjeYY9C1Rr4q6170mQqy+VmUewGFXCMoMnVC+LvAFK/sivL3u0AVpNbQ7X8o3Qki
         jzpMfO6ib1mOHWiAjMnBRYvIo1XcEXSgDLn3Dx3riWbMYfRBwP9B+gwNddLiWEtxu1DL
         PCiuqiT05tE84r/R3qHQUUROcNdqqHUAWQn/QjPtLsde9jAJ6F5o+/tHGj7Wk66MhxJ/
         F/KgVsSN8CJbES8fhK3lKlsGztokEJW4wOqdYLd7OFhhwWddEHMevjocO3JJlbpV2hnP
         yVK542nePAf1LzFPO0zk2CP+g6HmobianWPpWYPzTU0sLM/MHs0UQi7qvPwaxwFHnO1Y
         ebcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232748; x=1720837548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRoXdXns+v24A0oUujywQmDw48klACW/EhvT639iYLM=;
        b=V24cQjHipq4jMeyIhxhVsQvqisf3Wu8voJWJuT/7RYmMG1abjFptaJqTt23NCAxQ/S
         ydwBivbRn39eZTkReCqsj/hK8u1n8frtchcTd7Jgl9+bkIItEVSkYPN3mIWB/1JDIVh3
         x02jVaATLQyNzMPctdtxdZBynrUm3r47ZI/3XgPC963l5Ot9E1nPcwHwSHy013i/aXaT
         hgoI2D3fYVCcRoxMg0X8kIEpilAkz21Qk80XWakmMZoxCXnsC5sIpp6L6ux/9XFvtCt7
         HKxVjHOXkPNH8rt2nsCuUBD7OITdUDIu8ZqI25FS+4YnVQfSjAP2EFs4eIpiaPe2r1JI
         mjJw==
X-Forwarded-Encrypted: i=1; AJvYcCXif2LBJWEmDeSPTTAXV7obqTIZwU0XMiRI7Y2IrBcwHWgA1upW/dlSgIm+VXfSuYT5rqeC8t5zRdOXMQQSf7x3eYdqFqwwCrabr3vKWm3bbWZE6p1zT1vz2KDU/UBSBKe/btVZes0J
X-Gm-Message-State: AOJu0YzofwgksXZ77CNM3/ykI3gKhd3wZ3WyyQFd4yJNhTK23A+N6GcV
	5/JGrZpxI6/N0deq67bJGunvokF/aRV1Jgzd+YZuSGw55LEl5BOW
X-Google-Smtp-Source: AGHT+IFFVMQYWzHMHiBIAC3NAK4i3uZWoGO71TLphZOCqV9oHXY+GLtfEill58Xv8awN8i0NB1YT5Q==
X-Received: by 2002:a05:6e02:20c2:b0:375:8a71:4cc1 with SMTP id e9e14a558f8ab-3839b285940mr70623885ab.32.1720232748356;
        Fri, 05 Jul 2024 19:25:48 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:47 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
Date: Sat,  6 Jul 2024 02:25:21 +0000
Message-ID: <20240706022523.1104080-6-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
References: <20240706022523.1104080-1-flintglass@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch allows zswap to accept incompressible pages and store them
into zpool if possible.

This change is required to achieve zero rejection on zswap_store(). With
proper amount of proactive shrinking, swapout can be buffered by zswap
without IO latency. Storing incompressible pages may seem costly, but it
can reduce latency. A rare incompressible page in a large batch of
compressive pages can delay the entire batch during swapping.

The memory overhead is negligible because the underlying zsmalloc
already accepts nearly incompressible pages. zsmalloc stores data close
to PAGE_SIZE to a dedicated page. Thus storing as-is saves decompression
cycles without allocation overhead. zswap itself has not rejected pages
in these cases.

To store the page as-is, use the compressed data size field `length` in
struct `zswap_entry`. The length == PAGE_SIZE indicates
incompressible data.

If a zpool backend does not support allocating PAGE_SIZE (zbud), the
behavior remains unchanged. The allocation failure reported by the zpool
blocks accepting the page as before.

Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 76691ca7b6a7..def0f948a4ab 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -186,6 +186,8 @@ static struct shrinker *zswap_shrinker;
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
  *          pool and lru are invalid and must be ignored.
+ *          If length is equal to PAGE_SIZE, the data stored in handle is
+ *          not compressed. The data must be copied to page as-is.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
  * value - value of the same-value filled pages which have same content
@@ -969,9 +971,23 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	 */
 	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
-	if (comp_ret)
+
+	/* coa_compress returns -EINVAL for errors including insufficient dlen */
+	if (comp_ret && comp_ret != -EINVAL)
 		goto unlock;
 
+	/*
+	 * If the data cannot be compressed well, store the data as-is.
+	 * Switching by a threshold at
+	 * PAGE_SIZE - (allocation granularity)
+	 * zbud and z3fold use 64B granularity.
+	 * zsmalloc stores >3632B in one page for 4K page arch.
+	 */
+	if (comp_ret || dlen > PAGE_SIZE - 64) {
+		/* we do not use compressed result anymore */
+		comp_ret = 0;
+		dlen = PAGE_SIZE;
+	}
 	zpool = zswap_find_zpool(entry);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
@@ -981,14 +997,20 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 		goto unlock;
 
 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, dst, dlen);
+
+	/* PAGE_SIZE indicates not compressed. */
+	if (dlen == PAGE_SIZE)
+		memcpy_from_folio(buf, folio, 0, PAGE_SIZE);
+	else
+		memcpy(buf, dst, dlen);
+
 	zpool_unmap_handle(zpool, handle);
 
 	entry->handle = handle;
 	entry->length = dlen;
 
 unlock:
-	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
+	if (alloc_ret == -ENOSPC)
 		zswap_reject_compress_poor++;
 	else if (comp_ret)
 		zswap_reject_compress_fail++;
@@ -1006,6 +1028,14 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
+	if (entry->length == PAGE_SIZE) {
+		/* the content is not compressed. copy back as-is.  */
+		src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+		memcpy_to_page(page, 0, src, entry->length);
+		zpool_unmap_handle(zpool, entry->handle);
+		return;
+	}
+
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
 
-- 
2.43.0


