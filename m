Return-Path: <linux-kernel+bounces-424318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8079DB2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79ED3164D89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420313BC18;
	Thu, 28 Nov 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FBEJCoKe"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E17C7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732777250; cv=none; b=ee7bXbNdVjTA6Pf43jtcA027RCZc0MffR8XYaU3vQ4eWGOKIC8m8c2OCJcrb6j8QXo+v2bLjMQvR3GuieD/PWRYlWfwFemQEp5/mGmCdk/zWF7M5Q7zlEWsZAr8+bnn7q53Qvmfl/uprpkjbjow2FOcw2V6IKR2vsZupZ8Sxmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732777250; c=relaxed/simple;
	bh=4BQyWmUlE6jvGCDCm6OQP0d8YyywfVKgmlgBZXB48dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glz9m5KofJk7cKleya2/P30Pt4sQ0saa2/nubSmVkD7QETwuGVugJwgLBriw18XsuYqFS8H/uf6hXzyTRnItnbVT1YvzaVycVx7m1QihgU8Q8GIb+mq7xNKIuAnndSST6klF/ROir9uZ+8dScZwYYhgXBBSibTvHxRtgxDbD8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FBEJCoKe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732777244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vc2qIi2ocm1k6X4UAMIiWJqBmJVTnENQ+z8246d3WSQ=;
	b=FBEJCoKeNBMioFawWTiB/dQdiDsxLKD2w48TOsbRVzR3gnI6n2sUWYwcnEiuk9dRiVI1lJ
	cGyLWt7w3HFmEH8c/Z1v9vOoYhD+uhp1yH7a1z6p5Hh2RXEX51PnOj64Q/kahfJhHtXqGu
	VigfYwcD5WssfN4qVcr0IRwS/uPfw9w=
Date: Thu, 28 Nov 2024 15:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for
 batching.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/11/28 06:53, Kanchana P Sridhar wrote:
> In order to set up zswap_store_pages() to enable a clean batching
> implementation in [1], this patch implements the following changes:
> 
> 1) Addition of zswap_alloc_entries() which will allocate zswap entries for
>     all pages in the specified range for the folio, upfront. If this fails,
>     we return an error status to zswap_store().
> 
> 2) Addition of zswap_compress_pages() that calls zswap_compress() for each
>     page, and returns false if any zswap_compress() fails, so
>     zswap_store_page() can cleanup resources allocated and return an error
>     status to zswap_store().
> 
> 3) A "store_pages_failed" label that is a catch-all for all failure points
>     in zswap_store_pages(). This facilitates cleaner error handling within
>     zswap_store_pages(), which will become important for IAA compress
>     batching in [1].
> 
> [1]: https://patchwork.kernel.org/project/linux-mm/list/?series=911935
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>   mm/zswap.c | 93 +++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 71 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b09d1023e775..db80c66e2205 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1409,9 +1409,56 @@ static void shrink_worker(struct work_struct *w)
>   * main API
>   **********************************/
>   
> +static bool zswap_compress_pages(struct page *pages[],
> +				 struct zswap_entry *entries[],
> +				 u8 nr_pages,
> +				 struct zswap_pool *pool)
> +{
> +	u8 i;
> +
> +	for (i = 0; i < nr_pages; ++i) {
> +		if (!zswap_compress(pages[i], entries[i], pool))
> +			return false;
> +	}
> +
> +	return true;
> +}

How about introducing a `zswap_compress_folio()` interface which
can be used by `zswap_store()`?
```
zswap_store()
	nr_pages = folio_nr_pages(folio)

	entries = zswap_alloc_entries(nr_pages)

	ret = zswap_compress_folio(folio, entries, pool)

	// store entries into xarray and LRU list
```

And this version `zswap_compress_folio()` is very simple for now:
```
zswap_compress_folio()
	nr_pages = folio_nr_pages(folio)

	for (index = 0; index < nr_pages; ++index) {
		struct page *page = folio_page(folio, index);

		if (!zswap_compress(page, &entries[index], pool))
			return false;
	}

	return true;
```
This can be easily extended to support your "batched" version.

Then the old `zswap_store_page()` could be removed.

The good point is simplicity, that we don't need to slice folio
into multiple batches, then repeat the common operations for each
batch, like preparing entries, storing into xarray and LRU list...

Thanks.

