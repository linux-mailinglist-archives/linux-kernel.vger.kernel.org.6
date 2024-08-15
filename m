Return-Path: <linux-kernel+bounces-288279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C695384B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AB81C21021
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265DA1B4C31;
	Thu, 15 Aug 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCJ9erS/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601017C9BD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739640; cv=none; b=Qu/pHQFVGW86XC7T6f3ANwJygxlVNdHpYcGPHna0EfiasDM/MjBBizCpO/fSmg0fS4xOosVeUmcT4pFiOlRKlnjZAJjAd2yCkFsGhwN6UFMSkiIm4odJpCRX2eCPSNMlYhdO2GedDMvn2ptGT7yrPgMYPw7/ZQZBag4YO7B5D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739640; c=relaxed/simple;
	bh=s59WCNUQoeBf1NON8B/6nAotJ/UBColck+cfa4N6oGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGUOxDRGkl4pOt1yWJ+MlRhIeGpwDmRQvXufGSFtPizoc0aspJgGVuM2YJi1J+BkZOoIWUL0dNZckbczeP2WDxY1WsipQhFyZuxZ9ughgifhCtvi12G3kVfI1BBXaj1M3pSMx0iNf+mmYAzinOzk7avQVf+LyLf8cweFXTuqGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCJ9erS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723739637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XmYDkvG//zntOyTnKna7R//x2Uja+cBArQdmeYe4uiM=;
	b=bCJ9erS/Ia1o4q8ZrukD/m7WQ+DixreLPOT5ehLb+WmbVNBs7J4n6egP9rq4Q+3/Ot0r8C
	G3U8y0hTPvXJsK/TZCjcY+qikOG2NwP0SI9YN+EwkGUl0hat/L2nGa0fUSm9rmQ4pIJgNQ
	PoWW+MB/RiSR8t09BmS1pGNSK/j/HPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-zR0rifi1MuO5cX18H06BIA-1; Thu, 15 Aug 2024 12:33:53 -0400
X-MC-Unique: zR0rifi1MuO5cX18H06BIA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37193ed09b2so25365f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739633; x=1724344433;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XmYDkvG//zntOyTnKna7R//x2Uja+cBArQdmeYe4uiM=;
        b=s5cK853OE/w+/y+MGpoxzKvjl+QKnB2Pnb4YhMG4o5mmPtTeSt89ODxSz7Jx4Ucvg6
         2gLysHp+vypwLEb8b6u8zLvfq6697z0P4leD4FNeAD0CfAyxuWgrM4KLJwGfinzkGKX4
         j1tHR/90Io3KZrcDJURArOdXiX79uSKejpbS7d8cSa5GNQ2JLfJ65Qff2aMb+jiAS+9+
         e91bcIhIJFKzrennzHKX+AUHgo13XgQo3BmLrEtWGFJ5EgpAosLeYcGOjbjQRAHWhY6A
         4RgMwSOx1X+WoZm7/UU4ehKfKSx6dpLBe7d7jm/l8jk/xWb1MutmDHjamKieFte8YWl4
         XgAA==
X-Forwarded-Encrypted: i=1; AJvYcCWCoSGWL4IftD1SjDkxZQUPw76M3tkd8mlYgyTWlejib5FQ3ldeRuvz4svqdXNfnfpCJo9LoBb47CoKWla3sA3vPrv0m4QuhuounwHc
X-Gm-Message-State: AOJu0Yx9fYTSRMUuYJCshjTjr3caoAqSgPOBABEVCvlArT8zJ9wsJUDV
	QGIR+O9HfA73V/JrQm4aATO7/++Jd0cat2hU8QPPNPGUQeMBHghDjTyL+2rgCep+xZ8PQdZnkdz
	7kvj8TTYV4ryW1tPxLHuuk/Jc3b7ReE9s6gi+soPOif93srw3GGmoodz70FyPIA==
X-Received: by 2002:adf:f64f:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-37186b8625bmr2602377f8f.3.1723739632711;
        Thu, 15 Aug 2024 09:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt8iv0fpgohYyegONj9vovgeYN0JZYqYviF5kfSBjY/6Gtx9cGxaC54ARjSLhrzq/90x6UIA==
X-Received: by 2002:adf:f64f:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-37186b8625bmr2602336f8f.3.1723739632176;
        Thu, 15 Aug 2024 09:33:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6d00:aebb:127d:2c1a:7f3a? (p200300cbc7176d00aebb127d2c1a7f3a.dip0.t-ipconnect.de. [2003:cb:c717:6d00:aebb:127d:2c1a:7f3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896df5sm1902097f8f.69.2024.08.15.09.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:33:51 -0700 (PDT)
Message-ID: <ee0bae67-17b8-4807-a9b2-9a08df00987a@redhat.com>
Date: Thu, 15 Aug 2024 18:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240813120328.1275952-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.24 14:02, Usama Arif wrote:
> Currently folio->_deferred_list is used to keep track of
> partially_mapped folios that are going to be split under memory
> pressure. In the next patch, all THPs that are faulted in and collapsed
> by khugepaged are also going to be tracked using _deferred_list.
> 
> This patch introduces a pageflag to be able to distinguish between
> partially mapped folios and others in the deferred_list at split time in
> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> possible to distinguish between partially mapped folios and others in
> deferred_split_scan.
> 
> Eventhough it introduces an extra flag to track if the folio is
> partially mapped, there is no functional change intended with this
> patch and the flag is not useful in this patch itself, it will
> become useful in the next patch when _deferred_list has non partially
> mapped folios.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   include/linux/huge_mm.h    |  4 ++--
>   include/linux/page-flags.h |  3 +++
>   mm/huge_memory.c           | 21 +++++++++++++--------
>   mm/hugetlb.c               |  1 +
>   mm/internal.h              |  4 +++-
>   mm/memcontrol.c            |  3 ++-
>   mm/migrate.c               |  3 ++-
>   mm/page_alloc.c            |  5 +++--
>   mm/rmap.c                  |  3 ++-
>   mm/vmscan.c                |  3 ++-
>   10 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4c32058cacfe..969f11f360d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
>   {
>   	return split_huge_page_to_list_to_order(page, NULL, 0);
>   }
> -void deferred_split_folio(struct folio *folio);
> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>   
>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>   		unsigned long address, bool freeze, struct folio *folio);
> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page)
>   {
>   	return 0;
>   }
> -static inline void deferred_split_folio(struct folio *folio) {}
> +static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>   #define split_huge_pmd(__vma, __pmd, __address)	\
>   	do { } while (0)
>   
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a0a29bd092f8..cecc1bad7910 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -182,6 +182,7 @@ enum pageflags {
>   	/* At least one page in this folio has the hwpoison flag set */
>   	PG_has_hwpoisoned = PG_active,
>   	PG_large_rmappable = PG_workingset, /* anon or file-backed */
> +	PG_partially_mapped, /* was identified to be partially mapped */
>   };
>   
>   #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
> @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *page)
>   	ClearPageHead(page);
>   }
>   FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>   #else
>   FOLIO_FLAG_FALSE(large_rmappable)
> +FOLIO_FLAG_FALSE(partially_mapped)
>   #endif
>   
>   #define PG_head_mask ((1UL << PG_head))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6df0e9f4f56c..c024ab0f745c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   			 * page_deferred_list.
>   			 */
>   			list_del_init(&folio->_deferred_list);
> +			folio_clear_partially_mapped(folio);
>   		}
>   		spin_unlock(&ds_queue->split_queue_lock);
>   		if (mapping) {
> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio *folio)
>   	if (!list_empty(&folio->_deferred_list)) {
>   		ds_queue->split_queue_len--;
>   		list_del_init(&folio->_deferred_list);
> +		folio_clear_partially_mapped(folio);
>   	}
>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>   }
>   
> -void deferred_split_folio(struct folio *folio)
> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>   {
	/* We lost race with folio_put() */>   		 
list_del_init(&folio->_deferred_list);
> +			folio_clear_partially_mapped(folio);
>   			ds_queue->split_queue_len--;
>   		}
>   		if (!--sc->nr_to_scan)
> @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   next:
>   		folio_put(folio);
>   	}
> -
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>   	list_splice_tail(&list, &ds_queue->split_queue);
>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1fdd9eab240c..2ae2d9a18e40 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>   		free_gigantic_folio(folio, huge_page_order(h));
>   	} else {
>   		INIT_LIST_HEAD(&folio->_deferred_list);
> +		folio_clear_partially_mapped(folio);
>   		folio_put(folio);
>   	}
>   }
> diff --git a/mm/internal.h b/mm/internal.h
> index 52f7fc4e8ac3..d64546b8d377 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
>   	atomic_set(&folio->_entire_mapcount, -1);
>   	atomic_set(&folio->_nr_pages_mapped, 0);
>   	atomic_set(&folio->_pincount, 0);
> -	if (order > 1)
> +	if (order > 1) {
>   		INIT_LIST_HEAD(&folio->_deferred_list);
> +		folio_clear_partially_mapped(folio);

Can we use the non-atomic version here?

-- 
Cheers,

David / dhildenb


