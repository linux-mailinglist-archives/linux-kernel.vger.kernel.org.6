Return-Path: <linux-kernel+bounces-169769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F68BCD6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ED41F23BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFE14388C;
	Mon,  6 May 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp1GK1yR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D084FB3
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997154; cv=none; b=dRRfPu3ZI9oYts45tdtJlq8FBKb0ZtATiFvZwUQ/yy5rO8EVg9CuiyGinYoUY0I8zbRCjGZJ8zwPolawiMxav1AoFlmWTsqGLkYHnU+Sv7N+shBUzJikaO+ZWjQ1NUBUwTIzEsOqlZBg4YLatBBf9UnLFDUj2gwG3sjnK23mLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997154; c=relaxed/simple;
	bh=LXQPAX4zNMntm9eUBK0qskNYb5UEjcnyYGUlxtYdPak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in8jGV3P4en/eduest9A3NmEGn3yTlRq/jzTxVkLsHqSAfiJXz9/zwGW6/mOZsIO9F/8LGk8KdwOPkUTJ6hER0ZUzme0D5X05RaqWQUP0mDIAg03ZLQU2FkYuUTiZKowvBUQrJpf5lZOAopbRsO1FTOeONVEJcYDwjnkCW4T4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gp1GK1yR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714997152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8XIDyFu08fqqBoEXKux+sXTliBatxnauCxzuoFzkuME=;
	b=gp1GK1yR+74foOUQwaUhfiqGdZkGZEg6BpHqvG78r1PsjiJGcgFa7puMeXwuERwwt0gdij
	Gafra3+YsY08KoinknyX7FoqhivS/DFtuYQzvweCUhwSaZrNsa3OYIoBhp88ZoPcJtdxli
	YBICCGbq++DQRqNJTImvrXJP9YYKMxY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-8DQm43KANDy4KwNF4dzvyw-1; Mon, 06 May 2024 08:05:51 -0400
X-MC-Unique: 8DQm43KANDy4KwNF4dzvyw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34da8f1bf7cso1553299f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714997150; x=1715601950;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XIDyFu08fqqBoEXKux+sXTliBatxnauCxzuoFzkuME=;
        b=Q+/NeRyP0ShUTXDlsUNHn4wLc5uwiSQgMTxvGesWX0xtTKB2JzhcUBhkAI5Bo+eaaJ
         dw87rPqj/xWfetc2m0g5+RFyWo8kI97ig6BHjqn2CzdfEOXgRC2aioJKpXpUvipKbiDH
         TEf094GgpXDijaFFkqh6dkCgXm7x8x9Ho3/FC+OIBe3SRfDimtzuiZNookBue/drMRbV
         NcK2hntmgm4VagWbKw2aD+S+2Bb8B6bXXSzFdk/QgoL49ctqMGwOHFEUAPeT3HZePXH0
         ERHgNaf63hWSUA7SD/LAh0B+Dmweqh9qi3HN/1NXV9zHbeqetjFLELzSY4sV1JQNJwcE
         AZng==
X-Forwarded-Encrypted: i=1; AJvYcCX0QLZv5NT/6E1Idj3Md1FFuhlWBUz26J1aT1jdMMbwR+W9oQeXVSGGVILFc7ix+K/KOtX/czR/ADI5TgO5x3lvA49KV8Fa7BBEF48K
X-Gm-Message-State: AOJu0Yz0eezrd+RrYw093udFB0zxLP8cW0joZxkZpWs/ctucgbMf6Xgs
	lTV6pbIEEHR4dmecoG9cRJ3jey8FqJP7f4m8Y8qZ+An113t3nfkgB9REwYdkjIIGOVvZ5pcIBoc
	w6ojFdEXopr6MBvZYDy6B+6V4Lgy7G8jUhclibENzLEcoACzsehFaTvNnle76xw==
X-Received: by 2002:a5d:5483:0:b0:34a:35c7:22a3 with SMTP id h3-20020a5d5483000000b0034a35c722a3mr8724300wrv.20.1714997149724;
        Mon, 06 May 2024 05:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEupqLDiKF29fxNYCqjiJmsiowgP4Wno8hy8vuOYtmYTHRTzOKLrWz92sWu2uf/exvCmPnXcw==
X-Received: by 2002:a5d:5483:0:b0:34a:35c7:22a3 with SMTP id h3-20020a5d5483000000b0034a35c722a3mr8724279wrv.20.1714997149193;
        Mon, 06 May 2024 05:05:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:bf00:182c:d606:87cf:6fea? (p200300cbc74bbf00182cd60687cf6fea.dip0.t-ipconnect.de. [2003:cb:c74b:bf00:182c:d606:87cf:6fea])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0041be9cb540esm15770955wmo.18.2024.05.06.05.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 05:05:48 -0700 (PDT)
Message-ID: <0226a6f7-26ac-48b0-932d-1b7201cde1d7@redhat.com>
Date: Mon, 6 May 2024 14:05:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in
 swapcache
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-7-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240503005023.174597-7-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 02:50, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> When a large folio is found in the swapcache, the current implementation
> requires calling do_swap_page() nr_pages times, resulting in nr_pages
> page faults. This patch opts to map the entire large folio at once to
> minimize page faults. Additionally, redundant checks and early exits
> for ARM64 MTE restoring are removed.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 22e7c33cc747..940fdbe69fa1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	pte_t pte;
>   	vm_fault_t ret = 0;
>   	void *shadow = NULL;
> +	int nr_pages = 1;
> +	unsigned long page_idx = 0;
> +	unsigned long address = vmf->address;
> +	pte_t *ptep;
>   
>   	if (!pte_unmap_same(vmf))
>   		goto out;
> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		goto out_nomap;
>   	}
>   
> +	ptep = vmf->pte;
> +	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> +		int nr = folio_nr_pages(folio);
> +		unsigned long idx = folio_page_idx(folio, page);
> +		unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
> +		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
> +		pte_t *folio_ptep;
> +		pte_t folio_pte;
> +
> +		if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
> +			goto check_folio;
> +		if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
> +			goto check_folio;
> +
> +		folio_ptep = vmf->pte - idx;
> +		folio_pte = ptep_get(folio_ptep);
> +		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
> +		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
> +			goto check_folio;
> +
> +		page_idx = idx;
> +		address = folio_start;
> +		ptep = folio_ptep;
> +		nr_pages = nr;
> +		entry = folio->swap;
> +		page = &folio->page;
> +	}
> +
> +check_folio:
> +
>   	/*
>   	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>   	 * must never point at an anonymous page in the swapcache that is
> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	 * We're already holding a reference on the page but haven't mapped it
>   	 * yet.
>   	 */
> -	swap_free_nr(entry, 1);
> +	swap_free_nr(entry, nr_pages);
>   	if (should_try_to_free_swap(folio, vma, vmf->flags))
>   		folio_free_swap(folio);
>   
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +	folio_ref_add(folio, nr_pages - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>   	pte = mk_pte(page, vma->vm_page_prot);
>   
>   	/*
> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	 * exclusivity.
>   	 */
>   	if (!folio_test_ksm(folio) &&
> -	    (exclusive || folio_ref_count(folio) == 1)) {
> +	    (exclusive || (folio_ref_count(folio) == nr_pages &&
> +			   folio_nr_pages(folio) == nr_pages))) {
>   		if (vmf->flags & FAULT_FLAG_WRITE) {
>   			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>   			vmf->flags &= ~FAULT_FLAG_WRITE;

I fail to convince myself that this change is correct, and if it is 
correct, it's confusing (I think there is a dependency on 
folio_free_swap() having been called and succeeding, such that we don't 
have a folio that is in the swapcache at this point).

Why can't we move the folio_ref_add() after this check and just leave 
the check as it is?

"folio_ref_count(folio) == 1" is as clear as it gets: we hold the single 
reference, so we can do with this thing whatever we want: it's certainly 
exclusive. No swapcache, no other people mapping it.


-- 
Cheers,

David / dhildenb


