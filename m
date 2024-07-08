Return-Path: <linux-kernel+bounces-243831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494EE929B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCA61F2158C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2549A79FD;
	Mon,  8 Jul 2024 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qg1/u6X4"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4F812
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720411008; cv=none; b=T1WoEIobPCKwWiIrGlp2EVcaZrSUhGapCZjQS3QCeVXsNlor3KUMV5OnI92r2OyCjck4TwiGLugSkzCDamr1L0Nn5ly2f6BjrxBBZ9S3YouMRqqUsBB0bJ1UVaYoz0d+skS8yUUcJPDCbYeEiBtyuLvTODbQyhP+OSQdp8xb+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720411008; c=relaxed/simple;
	bh=vEQbSgPYq2DBjTK76wJZ0pKQJNOuGfNqk8J5sPOv+iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STyIFyV/VtetzX21+GsEkOkWl+kQ29ex0ocidYAsrgrKfgwnzWZDSl6S3HmTFowZ5/JrBjfyH+1wwRNGt4BVNAvZs/U+zJQ1l6c9neMcouqGYnG0V5BLz+tdys/CqjyHXCX98xA+dM76L1JjZMOK++MxnOZwm+R3LzNeK/2JwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qg1/u6X4; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: flintglass@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720411002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMeQrMxGWVYsF20LSONjNqLwKGL28dK2ApGBEXzkprM=;
	b=Qg1/u6X4IdGaKlHKepPOog6I0xmBNRaojBWKFv9BYYNHNniFuv+RPNgBBmhBz6YxmIPM5/
	TCW8mW7P8qQ14iQC81G7mUmfxKL34EkFds9UkjNhONtT0qFCg/VLUdic4dinAWT4oYud50
	KzcNjS3eXJyOEvvN6YJcUivaD7nb1Q0=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <0afc769e-241a-404e-b2c9-a6a27bdd3c72@linux.dev>
Date: Mon, 8 Jul 2024 11:56:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Takero Funaki <flintglass@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240706022523.1104080-6-flintglass@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/6 10:25, Takero Funaki wrote:
> This patch allows zswap to accept incompressible pages and store them
> into zpool if possible.
> 
> This change is required to achieve zero rejection on zswap_store(). With
> proper amount of proactive shrinking, swapout can be buffered by zswap
> without IO latency. Storing incompressible pages may seem costly, but it
> can reduce latency. A rare incompressible page in a large batch of
> compressive pages can delay the entire batch during swapping.
> 
> The memory overhead is negligible because the underlying zsmalloc
> already accepts nearly incompressible pages. zsmalloc stores data close
> to PAGE_SIZE to a dedicated page. Thus storing as-is saves decompression
> cycles without allocation overhead. zswap itself has not rejected pages
> in these cases.
> 
> To store the page as-is, use the compressed data size field `length` in
> struct `zswap_entry`. The length == PAGE_SIZE indicates
> incompressible data.
> 
> If a zpool backend does not support allocating PAGE_SIZE (zbud), the
> behavior remains unchanged. The allocation failure reported by the zpool
> blocks accepting the page as before.
> 
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>   mm/zswap.c | 36 +++++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 76691ca7b6a7..def0f948a4ab 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -186,6 +186,8 @@ static struct shrinker *zswap_shrinker;
>    * length - the length in bytes of the compressed page data.  Needed during
>    *          decompression. For a same value filled page length is 0, and both
>    *          pool and lru are invalid and must be ignored.
> + *          If length is equal to PAGE_SIZE, the data stored in handle is
> + *          not compressed. The data must be copied to page as-is.
>    * pool - the zswap_pool the entry's data is in
>    * handle - zpool allocation handle that stores the compressed page data
>    * value - value of the same-value filled pages which have same content
> @@ -969,9 +971,23 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>   	 */
>   	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
>   	dlen = acomp_ctx->req->dlen;
> -	if (comp_ret)
> +
> +	/* coa_compress returns -EINVAL for errors including insufficient dlen */
> +	if (comp_ret && comp_ret != -EINVAL)
>   		goto unlock;

Seems we don't need to care about? "comp_ret" is useless anymore.

Just:

if (comp_ret || dlen > PAGE_SIZE - 64)
	dlen = PAGE_SIZE;

And remove the checkings of comp_ret at the end.

>   
> +	/*
> +	 * If the data cannot be compressed well, store the data as-is.
> +	 * Switching by a threshold at
> +	 * PAGE_SIZE - (allocation granularity)
> +	 * zbud and z3fold use 64B granularity.
> +	 * zsmalloc stores >3632B in one page for 4K page arch.
> +	 */
> +	if (comp_ret || dlen > PAGE_SIZE - 64) {
> +		/* we do not use compressed result anymore */
> +		comp_ret = 0;
> +		dlen = PAGE_SIZE;
> +	}
>   	zpool = zswap_find_zpool(entry);
>   	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>   	if (zpool_malloc_support_movable(zpool))
> @@ -981,14 +997,20 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>   		goto unlock;
>   
>   	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> -	memcpy(buf, dst, dlen);
> +
> +	/* PAGE_SIZE indicates not compressed. */
> +	if (dlen == PAGE_SIZE)
> +		memcpy_from_folio(buf, folio, 0, PAGE_SIZE);

We actually don't need to hold mutex if we are just copying folio.

Thanks.

> +	else
> +		memcpy(buf, dst, dlen);
> +
>   	zpool_unmap_handle(zpool, handle);
>   
>   	entry->handle = handle;
>   	entry->length = dlen;
>   
>   unlock:
> -	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
> +	if (alloc_ret == -ENOSPC)
>   		zswap_reject_compress_poor++;
>   	else if (comp_ret)
>   		zswap_reject_compress_fail++;
> @@ -1006,6 +1028,14 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>   	struct crypto_acomp_ctx *acomp_ctx;
>   	u8 *src;
>   
> +	if (entry->length == PAGE_SIZE) {
> +		/* the content is not compressed. copy back as-is.  */
> +		src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +		memcpy_to_page(page, 0, src, entry->length);
> +		zpool_unmap_handle(zpool, entry->handle);
> +		return;
> +	}
> +
>   	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>   	mutex_lock(&acomp_ctx->mutex);
>   

