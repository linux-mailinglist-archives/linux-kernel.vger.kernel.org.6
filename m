Return-Path: <linux-kernel+bounces-198623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF428D7B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF901F21668
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581ED22F03;
	Mon,  3 Jun 2024 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N3qvT9O3"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB87182DA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394722; cv=none; b=XPZcrSkdOmnoPbOfpAZrQ8pl0PmDNiv0qaIrCwm9HzQ1+aUOggjAXTAAvs6Bc3pMF+HIItKF3pF8E42nGjokVf8he/xnWRotHv3NJ68FB24tyI570P7601sh7tjtyIgLFMV67D/ksEK9yhGiXCW9ALFYOWiqUzpWXB2hObZ4bII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394722; c=relaxed/simple;
	bh=mNx1tJB8Iq9cLj8jK81SW5hfzCD5WfcZqaoULGSZLoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC18/GLuV7X23QB/1vG7bzonswmQZ1Zv7WsM1r1Zoalb/QKpyVUk0mfpg4cm0fyOyhYPLSCL5ZVbyD504YDde7JukkX7Rr76VWP7orVAGNUdCgYB1BUTteuQsl39SHlDWrjzlTk+pYP8SB7hrFR8FrFzMJbMu/3NhfBvO7OfCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N3qvT9O3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717394717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjITebFei9QefCV+RvhEZenqRq68OjRdmGIxY4MFY+c=;
	b=N3qvT9O3g01gA6fkCJ0Jco/gbU1DJpiZ2Lwr8dnYR/0bF7Wtx3s5K6C3Peuy+mwHd3jjwB
	WMa4yvyb+iQ2h+UU8+ShaYnW5kiA/zb+oTRV+qUmRIPCBmmAhWXQE1VD5d8ROSjAWJZK9R
	go5AdJXpaXtrrT46+jpFHY045gmHDnw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <702b6eb1-0eb1-4f52-a709-b685a24c4c99@linux.dev>
Date: Mon, 3 Jun 2024 14:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] mm :zswap: use kmap_local_folio() in zswap_load()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <20240524033819.1953587-3-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240524033819.1953587-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/24 11:38, Yosry Ahmed wrote:
> Eliminate the last explicit 'struct page' reference in mm/zswap.c.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3693df96c81fe..bac66991fb14e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1551,7 +1551,6 @@ bool zswap_load(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
> -	struct page *page = &folio->page;
>  	bool swapcache = folio_test_swapcache(folio);
>  	struct xarray *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry;
> @@ -1582,7 +1581,7 @@ bool zswap_load(struct folio *folio)
>  	if (entry->length)
>  		zswap_decompress(entry, folio);
>  	else {
> -		dst = kmap_local_page(page);
> +		dst = kmap_local_folio(folio, 0);
>  		zswap_fill_page(dst, entry->value);
>  		kunmap_local(dst);
>  	}

