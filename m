Return-Path: <linux-kernel+bounces-546143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05FA4F6E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84A97A4638
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6D1E5B98;
	Wed,  5 Mar 2025 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cifFrb0J"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC01D5159
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155119; cv=none; b=mKabpE4ADgUgJknk3e1U4FEfx/ACsl0k+JVU4JAJ9OpnXhCkkEuDTnEwaE6FUYOpb+AJyCWaHYiLSfX2/r+2ofhzs3nVcerVSxF3ucAFvJ2txstgmTInb+aSOG410Gs4M8mD6w7PUaotRe/T/iDapARsnEIj3gMuvOgz2xaaeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155119; c=relaxed/simple;
	bh=3vDhgAAJC9AGnwTh0lEEl6+JTyqM2vOXcT2aPBYg3M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8QFiZRBrixomKnoZ2H5smkYCq0+IVKO0+Pk7c+QnKBF0NQNLLf0LVGOSQF3Pd6x+wBYLk3snNHMV60zEKMSKtQUsZhYwe+6A4RO+7QOvTrSCeHFx/RpEHFKZIkMFTQC1RumIefrNC5/UVsmafiCljl2GhLuXpwmy7G2Lcxxwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cifFrb0J; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHSh+fRW+hK9gv2DRy9l80+ev7l5Ymp5fdm86lOdRKo=;
	b=cifFrb0JgHRG/57JZ+Mr7M1biLTy24E8MBJu0NSeL4yBba2WzMq9kV83VyVoa8v8fO66+K
	xYm4fDL+06wlMYNY2zJY/bfIQyNjq1a3UXkuU0ff/RacIWMgjkcl+bSYrX1S3zl27OPYWh
	KucFgxjj3j3khybeKNnjCvbaqXJ2d3c=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH mm-unstable 2/5] mm: zswap: Use object read/write APIs instead of object mapping APIs
Date: Wed,  5 Mar 2025 06:11:30 +0000
Message-ID: <20250305061134.4105762-3-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the new object read/write APIs instead of mapping APIs.

On compress side, zpool_obj_write() is more concise and provides exactly
what zswap needs to write the compressed object to the zpool, instead of
map->copy->unmap.

On the decompress side, zpool_obj_read_begin() is sleepable, which
allows avoiding the memcpy() for zsmalloc and slightly simplifying the
code by:
- Avoiding checking if the zpool driver is sleepable, reducing special
  cases and shrinking the huge comment.
- Having a single zpool_obj_read_end() call rather than multiple
  conditional zpool_unmap_handle() calls.

The !virt_addr_valid() case can be removed in the future if the crypto
API supports kmap addresses or by using kmap_to_page(), completely
eliminating the memcpy() path in zswap_decompress(). This a step toward
that. In that spirit, opportunistically make the comment more specific
about the kmap case instead of generic non-linear addresses. This is the
only case that needs to be handled in practice, and the generic comment
makes it seem like a bigger problem that it actually is.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---

Herbert, I think we can completely get rid of the memcpy() in
zswap_decompress() if we can pass a highmem address to sg and crypto. I
believe your new virtual address API may be used here for this?

---
 mm/zswap.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 10f2a16e75869..4c474b692828d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -930,7 +930,6 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle;
 	struct zpool *zpool;
-	char *buf;
 	gfp_t gfp;
 	u8 *dst;
 
@@ -972,10 +971,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	if (alloc_ret)
 		goto unlock;
 
-	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, dst, dlen);
-	zpool_unmap_handle(zpool, handle);
-
+	zpool_obj_write(zpool, handle, dst, dlen);
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -996,24 +992,22 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src;
+	u8 *src, *obj;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
-	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+	obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
+
 	/*
-	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
-	 * to do crypto_acomp_decompress() which might sleep. In such cases, we must
-	 * resort to copying the buffer to a temporary one.
-	 * Meanwhile, zpool_map_handle() might return a non-linearly mapped buffer,
-	 * such as a kmap address of high memory or even ever a vmap address.
-	 * However, sg_init_one is only equipped to handle linearly mapped low memory.
-	 * In such cases, we also must copy the buffer to a temporary and lowmem one.
+	 * zpool_obj_read_begin() might return a kmap address of highmem when
+	 * acomp_ctx->buffer is not used.  However, sg_init_one() does not
+	 * handle highmem addresses, so copy the object to acomp_ctx->buffer.
 	 */
-	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
-	    !virt_addr_valid(src)) {
-		memcpy(acomp_ctx->buffer, src, entry->length);
+	if (virt_addr_valid(obj)) {
+		src = obj;
+	} else {
+		WARN_ON_ONCE(obj == acomp_ctx->buffer);
+		memcpy(acomp_ctx->buffer, obj, entry->length);
 		src = acomp_ctx->buffer;
-		zpool_unmap_handle(zpool, entry->handle);
 	}
 
 	sg_init_one(&input, src, entry->length);
@@ -1023,8 +1017,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 
-	if (src != acomp_ctx->buffer)
-		zpool_unmap_handle(zpool, entry->handle);
+	zpool_obj_read_end(zpool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 }
 
-- 
2.48.1.711.g2feabab25a-goog


