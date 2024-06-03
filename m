Return-Path: <linux-kernel+bounces-198622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36F8D7B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495741F216C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B7722F03;
	Mon,  3 Jun 2024 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Th/GCHfE"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B9182DA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394662; cv=none; b=u/9oJbp3H7QBGuTvJA2PsRkpUNELEC29JkGE3GqBMjo2+51lQbz4HpxtYZtz7HEo7a/fVo2yDpg4vUlH9LDotKbqHlkfNu4e0aukqU64o8e6N4yzzVF/V1Br8GtZ+4TQpIyyByK5GJuiWHC+hiH6reSrfiqJOxLjuv8fqo8+Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394662; c=relaxed/simple;
	bh=5QU6n6Fc8sM+CG4UdsGinL5uZmInSgrN4O1VOuovo7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LznykUSJSMVMRwCDN2J7a8zWAK8L/M1pySdvC3+p4OpYSgZB1r/4oL9weCHKNsYB6DkjTnCEObwJBqEDd5O2rm2wrfyv2IvyzQ0fAppTlnKa8Uz7j2pR7vegxuZSw99vi5JjBiIdJRGn5DI16tiFXQKcmcotYtOXY2MH+rRM9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Th/GCHfE; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717394657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAJn/Jtb/IU6mglsNtTOn+b7ZlaaeT7CsuHSdA2/NbQ=;
	b=Th/GCHfEXrsGLfvyxPZwtXH5pDG5jI+gNqOkuAgi6WgEbWaGMKlZyzo+WHqBx3Xgi/VY73
	6ae0Lb/yIW8ZJLAbyS6nqHdk/mgoCKcjs3wu5itDWaa289CPPNKl/DHkinouemD+8wYbpO
	5EphkgFc30BOvgnr5Dlo5TgUP3HfTTw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <4daef95a-4cb0-4292-9775-a0fe9993205f@linux.dev>
Date: Mon, 3 Jun 2024 14:03:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mm: zswap: use sg_set_folio() in
 zswap_{compress/decompress}()
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <20240524033819.1953587-2-yosryahmed@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240524033819.1953587-2-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/24 11:38, Yosry Ahmed wrote:
> sg_set_folio() is equivalent to sg_set_page() for order-0 folios, which
> are the only ones supported by zswap. Now zswap_decompress() can take in
> a folio directly.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a50e2986cd2fa..3693df96c81fe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -917,7 +917,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>  
>  	dst = acomp_ctx->buffer;
>  	sg_init_table(&input, 1);
> -	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
> +	sg_set_folio(&input, folio, PAGE_SIZE, 0);
>  
>  	/*
>  	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
> @@ -971,7 +971,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
>  	return comp_ret == 0 && alloc_ret == 0;
>  }
>  
> -static void zswap_decompress(struct zswap_entry *entry, struct page *page)
> +static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  {
>  	struct zpool *zpool = zswap_find_zpool(entry);
>  	struct scatterlist input, output;
> @@ -1000,7 +1000,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>  
>  	sg_init_one(&input, src, entry->length);
>  	sg_init_table(&output, 1);
> -	sg_set_page(&output, page, PAGE_SIZE, 0);
> +	sg_set_folio(&output, folio, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
>  	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
>  	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> @@ -1073,7 +1073,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  		return -ENOMEM;
>  	}
>  
> -	zswap_decompress(entry, &folio->page);
> +	zswap_decompress(entry, folio);
>  
>  	count_vm_event(ZSWPWB);
>  	if (entry->objcg)
> @@ -1580,7 +1580,7 @@ bool zswap_load(struct folio *folio)
>  		return false;
>  
>  	if (entry->length)
> -		zswap_decompress(entry, page);
> +		zswap_decompress(entry, folio);
>  	else {
>  		dst = kmap_local_page(page);
>  		zswap_fill_page(dst, entry->value);

