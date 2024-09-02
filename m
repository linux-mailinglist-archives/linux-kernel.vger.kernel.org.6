Return-Path: <linux-kernel+bounces-311432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9BE968917
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E552844AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8E205E34;
	Mon,  2 Sep 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCzMc8jb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A619C540
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284712; cv=none; b=vAvLojvHgeV1J/ejTaGW6+YeknybKtMtCcaiB8JsZ1wwMRLvSwb8773Iw3FgkysK3WO3EgQzyMKs4JSmTriDPBB/Ikw9aviEoQu+Sw9bM0XoQLQiq6HmqCfIyicyhY6ukiID8lN8XhghJ/r+tG3tt2yvXAuWBrK9bRWLfDafV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284712; c=relaxed/simple;
	bh=t4VW64/Crv19eoxyGQeT10ipMKusTZaWES5II5Y/Rj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y619WXUb5prc9FnMst6CGkGHhrB3SArl1Em8XnbXAvmL4A6ppRMUfcemxLZHDWHgib6XTLnuP5wZkBUh0pHRn6CH3F30Go0K0THCvWYWzNl4HQ6bkAzG+od8a2O5ev9r8i7qwBdt81knznX54/+CA2bAKGPrYpsRiZaeP5zqjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCzMc8jb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725284709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ZFN+0AMoCPfI+siUhllz3LKr9lLXVkstMI9sDcoCsU=;
	b=fCzMc8jbQ0RuvHX4k5jzAxIrhp4otSAsalWt/KRgN9RpsRgPlUrOWLdPPAkPDC5QM0Rm3f
	2f+b7bnQsOuwkw44VoqgTJe1l4H0Tua33MHn00bDmkirNLLDzsCjnHMnQTST3/wCq1BLPw
	o7/Kyx89L7zWNHAF1Y/TAYgUuzs0y4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-K-3K3_vBPQGndJP8edwvKg-1; Mon, 02 Sep 2024 09:45:08 -0400
X-MC-Unique: K-3K3_vBPQGndJP8edwvKg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bac946976so40006105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284707; x=1725889507;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZFN+0AMoCPfI+siUhllz3LKr9lLXVkstMI9sDcoCsU=;
        b=I6Ja8tl4+zfJ+P4g38y8zagWoWKhZXnjEp4m4qk2Gh0k3fZMc7UvH8RvnqgGYFH3a9
         8+xCmHfurzOHEGf3FAqQxKAoWbkCH8FX8LOVPEmAO3TbyffOa+wGmCcXg7PTn6+QfIdw
         uGcR+/9IcnoES41AbiadW+/OPoX8MG6fae4TVX7jFcB7VC8zfb8FKrZ60knWALntDUL/
         H6EgayB6bdk3jMlUMx//+C47dh5LmDIwliL6ugWPlc6h2/QbJlvLeBLiLQtLujUY98mo
         S1CCU+Xuz53imPpTkgl07bDlmkz1b1OeqmHZ5p+odWpMqSavzkfwF0Jn0oCmTWcEx6aM
         1V8w==
X-Forwarded-Encrypted: i=1; AJvYcCUKNoprt33z4kUeDnzJY+f53PenxJWOZXDyo7I6vKPRE57PeSzE2eMsnuoNN61zojxjPC2Fu+lWwjjSQ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiiy7kZyqxfd9lfN1SHaFeYyVBuUkhBReegUGsYkTMhf54hi3Y
	D4gbTxvMAbqsmhtY40QTSXdRE1xf/PRyUlN4F/GNzcGxx3txLKh3sFvbIXLMM0EheejxRY5pKxU
	M4hokMbbWVpmaQR/vIMn9Y0z3ty2cms8Tza+0cZQ4d3DHGVLOop2LZ55tQD/TwA==
X-Received: by 2002:a05:600c:3104:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42bb27ba51bmr125551835e9.32.1725284706339;
        Mon, 02 Sep 2024 06:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd48kP6LsBQ03ga/EbXiNhV7bo2zWuxB+SgDc05RJCrVekjhrJzzR3OKbeRx/1dRb+PP7FwA==
X-Received: by 2002:a05:600c:3104:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42bb27ba51bmr125551205e9.32.1725284705372;
        Mon, 02 Sep 2024 06:45:05 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb1ebsm138607655e9.3.2024.09.02.06.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 06:45:04 -0700 (PDT)
Message-ID: <3b8994a6-cbe5-46be-86eb-b78198c31ef8@redhat.com>
Date: Mon, 2 Sep 2024 15:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
To: Rong Qianfeng <rongqianfeng@vivo.com>, vbabka@suse.cz,
 mgorman@techsingularity.net, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240902122445.11805-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240902122445.11805-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.24 14:24, Rong Qianfeng wrote:
> Reserved pages are basically non-lru pages. This kind of memory can't be
> used as migration sources and targets, skip it can bring some performance
> benefits.

Any numbers? :)

> 
> Because some drivers may also use PG_reserved, we just set PB_migrate_skip
> for those clustered reserved bootmem during memory initialization.
> 
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> ---
>   include/linux/pageblock-flags.h | 13 +++++++++++
>   mm/compaction.c                 | 40 +++++++++++++++++++++++++++++++++
>   mm/mm_init.c                    | 14 ++++++++++++
>   mm/page_alloc.c                 |  7 ++++++
>   4 files changed, 74 insertions(+)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index fc6b9c87cb0a..63c5b0c69c1a 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -86,6 +86,11 @@ void set_pfnblock_flags_mask(struct page *page,
>   	set_pfnblock_flags_mask(page, (1 << PB_migrate_skip),	\
>   			page_to_pfn(page),			\
>   			(1 << PB_migrate_skip))
> +
> +extern void set_pageblock_skip_range(unsigned long start_pfn,
> +				     unsigned long end_pfn);

two tabs indentation on the second line please. Applies to all others as 
well.

> +extern void clear_pageblock_skip_range(unsigned long start_pfn,
> +				       unsigned long end_pfn);
>   #else
>   static inline bool get_pageblock_skip(struct page *page)
>   {
> @@ -97,6 +102,14 @@ static inline void clear_pageblock_skip(struct page *page)
>   static inline void set_pageblock_skip(struct page *page)
>   {
>   }
> +static inline void set_pageblock_skip_range(unsigned long start_pfn,
> +					    unsigned long end_pfn)
> +{
> +}
> +static inline void clear_pageblock_skip_range(unsigned long start_pfn,
> +					      unsigned long end_pfn)
> +{
> +}

[...]

>   /*
>    * Compound pages of >= pageblock_order should consistently be skipped until
>    * released. It is always pointless to compact pages of such order (if they are
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 4ba5607aaf19..8b7dc8e00bf1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -768,6 +768,13 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
>   			__SetPageReserved(page);
>   		}
>   	}
> +
> +	/*
> +	 * Set PB_migrate_skip for reserved region. for cma memory
> +	 * and the memory released by free_reserved_area(), we will
> +	 * clear PB_migrate_skip when they are initialized.
> +	 */
> +	set_pageblock_skip_range(start_pfn, end_pfn);
>   }
>   
>   /* If zone is ZONE_MOVABLE but memory is mirrored, it is an overlapped init */
> @@ -2236,6 +2243,13 @@ void __init init_cma_reserved_pageblock(struct page *page)
>   		set_page_count(p, 0);
>   	} while (++p, --i);
>   
> +	/*
> +	 * We set the PB_migrate_skip in
> +	 * reserve_bootmem_region() for cma
> +	 * memory, clear it now.

You can fit this easily into less lines

> +	 */
> +	clear_pageblock_skip(page);
> +
>   	set_pageblock_migratetype(page, MIGRATE_CMA);
>   	set_page_refcounted(page);
>   	/* pages were reserved and not allocated */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b98f9bb28234..a7729dac0198 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5887,6 +5887,13 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>   	if (pages && s)
>   		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>   
> +	/*
> +	 * Clear PB_migrate_skip if the memory have released
> +	 * to the buddy system.
> +	 */

... after freeing the memory to the buddy."

And maybe

if (pages) {
	if (s)
		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
	clear_pageblock_skip_range(...)
}

> +	clear_pageblock_skip_range(page_to_pfn(virt_to_page(start)),
> +				   page_to_pfn(virt_to_page(end)));
> +

PHYS_PFN(virt_to_phys(start)) might look a bit nicer, not need to
get pages involved. virt_to_pfn might be even better(), but it's
not available on all archs I think.


What about free_reserved_page() ? There might be more, though 
(kimage_free_pages()). You have to take a look at all functions where we 
clear PageReserved.

-- 
Cheers,

David / dhildenb


