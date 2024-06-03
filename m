Return-Path: <linux-kernel+bounces-198624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186C8D7B57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22B52815AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546722F03;
	Mon,  3 Jun 2024 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="poEldqWu"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DD182DA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394875; cv=none; b=X1BanqONgbl1HO1SYpLAVPLW/8RcbARJ0ZHWh+WxTdd1ntEC4Xir7F4Ir6x5ndlqH9RKS5Uipx3xxFtC5L+7aSMpchjdGdj8jLdlWpxxvIuRR4X8FOzKt1kx4/m7EZd0K8VclGb6+LkGyxI9CisvIYPUM8GJU7FCYkPngWn9nP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394875; c=relaxed/simple;
	bh=pJSZvYQmDGfAvDbPW/s/YHRBMTbJ2fkHfb8pb0gHMGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNw+NuQoAlz8zeANZITm0auLhj79HoNzIvo/y2vvPCWx3UG0iGbZU39/hguQXZ6a5knwqS8zjSAM1ZJBoM16QPNSizVHNiv/LTuzFgXkM4DUtYlVZbunlqE42TWThtGeb79jI9Swz2tTS0Ae14g50bcRjFAsWXzX835kSQkIfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=poEldqWu; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717394872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGrrOJrJBkBQe6EQRvR+Wm4pVmmlK5pjswzRASjAaAk=;
	b=poEldqWuC5AdILdualjDCyO0jcsQPwB2dNl4E+G+e95RhHOJsHOwh8KbCW1tVMXbpVfTVO
	XyXWqYAL3HqnVKEY5EeIjkPVSCbEQV9ihMf3yQsCEjxGv6m4hmdqCGmZ90/owkuqmiLCAh
	cb002kdDSZefBmj0wDmvSfA8odQllqo=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <85994845-1aad-4142-adb3-91aa231b5a7d@linux.dev>
Date: Mon, 3 Jun 2024 14:07:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] mm: zswap: make same_filled functions folio-friendly
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <20240524033819.1953587-4-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240524033819.1953587-4-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/24 11:38, Yosry Ahmed wrote:
> A variable name 'page' is used in zswap_is_folio_same_filled() and
> zswap_fill_page() to point at the kmapped data in a folio. Use 'data'
> instead to avoid confusion and stop it from showing up when searching
> for 'page' references in mm/zswap.c.
> 
> While we are at it, move the kmap/kunmap calls into zswap_fill_page(),
> make it take in a folio, and rename it to zswap_fill_folio().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index bac66991fb14e..b9b35ef86d9be 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1375,35 +1375,35 @@ static void shrink_worker(struct work_struct *w)
>  **********************************/
>  static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
>  {
> -	unsigned long *page;
> +	unsigned long *data;
>  	unsigned long val;
> -	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
>  	bool ret = false;
>  
> -	page = kmap_local_folio(folio, 0);
> -	val = page[0];
> +	data = kmap_local_folio(folio, 0);
> +	val = data[0];
>  
> -	if (val != page[last_pos])
> +	if (val != data[last_pos])
>  		goto out;
>  
>  	for (pos = 1; pos < last_pos; pos++) {
> -		if (val != page[pos])
> +		if (val != data[pos])
>  			goto out;
>  	}
>  
>  	*value = val;
>  	ret = true;
>  out:
> -	kunmap_local(page);
> +	kunmap_local(data);
>  	return ret;
>  }
>  
> -static void zswap_fill_page(void *ptr, unsigned long value)
> +static void zswap_fill_folio(struct folio *folio, unsigned long value)
>  {
> -	unsigned long *page;
> +	unsigned long *data = kmap_local_folio(folio, 0);
>  
> -	page = (unsigned long *)ptr;
> -	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> +	memset_l(data, value, PAGE_SIZE / sizeof(unsigned long));
> +	kunmap_local(data);
>  }
>  
>  /*********************************
> @@ -1554,7 +1554,6 @@ bool zswap_load(struct folio *folio)
>  	bool swapcache = folio_test_swapcache(folio);
>  	struct xarray *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry;
> -	u8 *dst;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  
> @@ -1580,11 +1579,8 @@ bool zswap_load(struct folio *folio)
>  
>  	if (entry->length)
>  		zswap_decompress(entry, folio);
> -	else {
> -		dst = kmap_local_folio(folio, 0);
> -		zswap_fill_page(dst, entry->value);
> -		kunmap_local(dst);
> -	}
> +	else
> +		zswap_fill_folio(folio, entry->value);
>  
>  	count_vm_event(ZSWPIN);
>  	if (entry->objcg)

