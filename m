Return-Path: <linux-kernel+bounces-510879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E518CA3231D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454E81885E12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B2205E14;
	Wed, 12 Feb 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxS+Gvn4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C62066C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354638; cv=none; b=D0F+3OfJzyvvykk4dCQV/gA7jsv05tLlEBwMQVvbnW8j+kbRgpHJOsxNjSI6ofIuOWvLIh0cbxQqrG+n8hoGEN9GWxNqnaukBaxvd1UNFC4qLqevJ9VU+gkQr+UUs/yzz9H7nr6L5p9zZr0QqxN/wkRBIEhgZtzpnfu2doBmYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354638; c=relaxed/simple;
	bh=1cjb2aP77LOhllPMpFeKWhkPEcp7ZSa5c1x1KTklu2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYtrjtX3Yo2Jshyfzxc1SPbrS4TCf/5rLzcLTzkeW78tX6BSGVv/WgCXARhiVUf9e0t5SzpbLuNJwRW25p7iqY2LAIyf9HpXV2KVY32P8IxDPSEc5UX842683tatQi7vVTByYGphcLvqn0BJsCYwqIZw0eGxdeRwBLNYVGeS/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxS+Gvn4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739354634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XhcLq7P4Ch3DQ7dn4Jx+o/CtEDt+sdWbj2x/uM/C/sw=;
	b=RxS+Gvn4Gy/O12HI4A0IFXLcSRcCiXNK/H0BilByNgOt+DLiYwQ8p4sj03KHwvFm3o5ysx
	qnKPjO8DDCAsjuomN5dNvWIz0Ha9kukcDrdRECAtopUYCSuhgKviT4g8rQsL3MPFUfZlL2
	is35XjTJ9Hu/puPfRrzKxG0jT9M64DM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-rBelanrTPZugTttXs_O2zg-1; Wed, 12 Feb 2025 05:03:53 -0500
X-MC-Unique: rBelanrTPZugTttXs_O2zg-1
X-Mimecast-MFC-AGG-ID: rBelanrTPZugTttXs_O2zg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dbdc2926eso580123f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354632; x=1739959432;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XhcLq7P4Ch3DQ7dn4Jx+o/CtEDt+sdWbj2x/uM/C/sw=;
        b=UWz+n8nzdw5GgCmHOJQpfYNDlk2UCIbgRsfFNSQarVA10YiJiXUuW8PZqeMoAVdeLt
         KXdAqQ8QRXBmUr9AZqsiP5w4FhK3tJCatsBvxdNUAx/yN0IVA5j2rAsUPCN7Cv/L+6dk
         OLoQLPQn9kpMfAIwBcHfUWcSZygUciXjOeqHs0mK4rzDXQCe7pkO+INSM+/FgymIE6Zb
         WQIUbA26s7xrHgCRJ7seo5pIJL+hESDUkIzowVatEO1nGDIbv7Q/MgwTMK8wqCYCuPM7
         6jzvzUazPg8dQFIAOt1bzwhyPezC9OQ60xSJVqCemR0YsSo4/d/5I4rsT4dypqRDYpH2
         PktQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNzyeLvXzA7v+1bm8jI6X+AKIGJ4ByL42OvaE+aZW4f48o+Jy6q0aufU7ZDc7SJa7KkPjbSOMZGUH/49g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAljh36/bS2uwY+OT8wND7bMwQi9lPFDVGTZPOybPKS+JJwlzG
	hHQGtAx6xsc/ciNeqwNvxh3rmYHQOe/SGnwUY7VFoa0Zwb+jiozqMADxraKBPoyxFDz8vKnyhwD
	xdGOpLTCFS7rBd9yRs2DZZqtiYHrbk8/aSe3AdinVUIE6eyH595twQ8N+JRX8lQ==
X-Gm-Gg: ASbGncs98vAHWbZIC7JAX+qDXSFW7BWCfyTQUO7CodYXx5gzq91iTEJg7Y7tPuUIYXf
	7rwDQBcDte7x5XPI2ZG1XuX7IghyT1EmbFet/mSy47ky+erMWVVhMo2g7CsCpxlANT5ipNY2Le0
	B8Gqzw1DQ3cQZLUCxXErLwxVaVrPkN/mbPDXauMC/LRQS6Q9LKW2/jm3niJdmIY1qdgpKv+Qgdd
	EL62H4a56KdNEL5HwWUp4OxVG7+zdCFWCd94E973OHVz1+gr4PPZjcl7hgyVEcA82SFERlOy0I/
	iutxTODoO4fEqh50pAc6WZhC4U05OHsQMhhV1+drwgcE0eVt27ArxQ8Mb5RnudeZmbWVfHF6VdZ
	7o52xHNl4HKO6boz5ifXVb8gmgPS/bw==
X-Received: by 2002:a05:6000:1545:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-38dea259d2emr2048299f8f.7.1739354631654;
        Wed, 12 Feb 2025 02:03:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxHugYw/Iqt4sZwd2Za9Fpbi+YkAs0W8EwjLNYkgkhaittEQxLCt4uAmlk3fQTkjKrZQJcTQ==
X-Received: by 2002:a05:6000:1545:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-38dea259d2emr2048255f8f.7.1739354631180;
        Wed, 12 Feb 2025 02:03:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a? (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de. [2003:cb:c70c:a600:1e3e:c75:d269:867a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38e0e7abd1csm1148405f8f.43.2025.02.12.02.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:03:50 -0800 (PST)
Message-ID: <76537454-272b-4fbb-b073-5387bbaaf28d@redhat.com>
Date: Wed, 12 Feb 2025 11:03:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/3] mm/filemap: add mempolicy support to the
 filemap layer
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-2-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250210063227.41125-2-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.02.25 07:32, Shivank Garg wrote:
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> Add NUMA mempolicy support to the filemap allocation path by introducing
> new APIs that take a mempolicy argument:
> - filemap_grab_folio_mpol()
> - filemap_alloc_folio_mpol()
> - __filemap_get_folio_mpol()
> 
> These APIs allow callers to specify a NUMA policy during page cache
> allocations, enabling fine-grained control over memory placement. This is
> particularly needed by KVM when using guest-memfd memory backends, where
> the guest memory needs to be allocated according to the NUMA policy
> specified by VMM.
> 

shmem handles this using custom shmem_alloc_folio()->folio_alloc_mpol().

I'm curious, is there

(1) A way to make shmem also use this new API?
(2) Handle it in guest_memfd manually, like shmem does?

> The existing non-mempolicy APIs remain unchanged and continue to use the
> default allocation behavior.
> 
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   include/linux/pagemap.h | 40 ++++++++++++++++++++++++++++++++++++++++
>   mm/filemap.c            | 30 +++++++++++++++++++++++++-----
>   2 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 47bfc6b1b632..4ae7fa63cb26 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -662,15 +662,25 @@ static inline void *detach_page_private(struct page *page)
>   
>   #ifdef CONFIG_NUMA
>   struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
> +struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
> +						struct mempolicy *mpol);

Two tabs indent on second parameter line, please.

>   #else
>   static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>   {
>   	return folio_alloc_noprof(gfp, order);
>   }
> +static inline struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp,
> +						unsigned int order,
> +						struct mempolicy *mpol)
> +{
> +	return filemap_alloc_folio_noprof(gfp, order);
> +}

Dito.

>   #endif
>   
>   #define filemap_alloc_folio(...)				\
>   	alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
> +#define filemap_alloc_folio_mpol(...)				\
> +	alloc_hooks(filemap_alloc_folio_mpol_noprof(__VA_ARGS__))
>   
>   static inline struct page *__page_cache_alloc(gfp_t gfp)
>   {
> @@ -762,6 +772,8 @@ static inline fgf_t fgf_set_order(size_t size)
>   void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
>   struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>   		fgf_t fgp_flags, gfp_t gfp);
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
> +		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol);
>   struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>   		fgf_t fgp_flags, gfp_t gfp);
>   
> @@ -820,6 +832,34 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
>   			mapping_gfp_mask(mapping));
>   }
>   
> +/**
> + * filemap_grab_folio_mpol - grab a folio from the page cache
> + * @mapping: The address space to search
> + * @index: The page index
> + * @mpol: The mempolicy to apply

"The mempolicy to apply when allocating a new folio." ?

> + *
> + * Same as filemap_grab_folio(), except that it allocates the folio using
> + * given memory policy.
> + *
> + * Return: A found or created folio. ERR_PTR(-ENOMEM) if no folio is found
> + * and failed to create a folio.
> + */
> +#ifdef CONFIG_NUMA
> +static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
> +					pgoff_t index, struct mempolicy *mpol)
> +{
> +	return __filemap_get_folio_mpol(mapping, index,
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +			mapping_gfp_mask(mapping), mpol);
> +}
> +#else
> +static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
> +					pgoff_t index, struct mempolicy *mpol)
> +{
> +	return filemap_grab_folio(mapping, index);
> +}
> +#endif /* CONFIG_NUMA */
> +
>   /**
>    * find_get_page - find and get a page reference
>    * @mapping: the address_space to search
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 804d7365680c..c5ea32702774 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1001,8 +1001,13 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>   EXPORT_SYMBOL_GPL(filemap_add_folio);
>   
>   #ifdef CONFIG_NUMA
> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
> +			struct mempolicy *mpol)
>   {
> +	if (mpol)
> +		return folio_alloc_mpol_noprof(gfp, order, mpol,
> +				NO_INTERLEAVE_INDEX, numa_node_id());
> +

This should go below the variable declaration. (and indentation on 
second parameter line should align with the first parameter)

>   	int n;
>   	struct folio *folio;
>   
> @@ -1018,6 +1023,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>   	}
>   	return folio_alloc_noprof(gfp, order);
>   }
> +EXPORT_SYMBOL(filemap_alloc_folio_mpol_noprof);
> +
> +struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +{
> +	return filemap_alloc_folio_mpol_noprof(gfp, order, NULL);
> +}
>   EXPORT_SYMBOL(filemap_alloc_folio_noprof);
>   #endif
>   
> @@ -1881,11 +1892,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>   }
>   
>   /**
> - * __filemap_get_folio - Find and get a reference to a folio.
> + * __filemap_get_folio_mpol - Find and get a reference to a folio.
>    * @mapping: The address_space to search.
>    * @index: The page index.
>    * @fgp_flags: %FGP flags modify how the folio is returned.
>    * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
> + * @mpol: The mempolicy to apply.

"The mempolicy to apply when allocating a new folio." ?

>    *
>    * Looks up the page cache entry at @mapping & @index.
>    *
> @@ -1896,8 +1908,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>    *
>    * Return: The found folio or an ERR_PTR() otherwise.
>    */
> -struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> -		fgf_t fgp_flags, gfp_t gfp)
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
> +		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
>   {
>   	struct folio *folio;
>   
> @@ -1967,7 +1979,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>   			err = -ENOMEM;
>   			if (order > min_order)
>   				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -			folio = filemap_alloc_folio(alloc_gfp, order);
> +			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
>   			if (!folio)
>   				continue;
>   
> @@ -2003,6 +2015,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>   		folio_clear_dropbehind(folio);
>   	return folio;
>   }
> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
> +
> +struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> +		fgf_t fgp_flags, gfp_t gfp)
> +{
> +	return __filemap_get_folio_mpol(mapping, index,
> +			fgp_flags, gfp, NULL);
> +}
>   EXPORT_SYMBOL(__filemap_get_folio);
>   
>   static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,


For guest_memfd, where pages are un-movable and un-swappable, the memory 
policy will never change later.

shmem seems to handle the swap-in case, because it keeps care of 
allocating pages in that case itself.

For ordinary pagecache pages (movable), page migration would likely not 
be aware of the specified mpol; I assume the same applies to shmem?

alloc_migration_target() seems to prefer the current nid (nid = 
folio_nid(src)), but apart from that, does not lookup any mempolicy.

compaction likely handles this by comapcting within a node/zone.

Maybe migration to the right target node on misplacement is handled on a 
higher level lagter (numa hinting faults -> migrate_misplaced_folio). 
Likely at least for anon memory, not sure about unmapped shmem.


-- 
Cheers,

David / dhildenb


