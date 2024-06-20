Return-Path: <linux-kernel+bounces-222184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AF90FDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BD1F25574
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A877945026;
	Thu, 20 Jun 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxZX6U0n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447691803A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869584; cv=none; b=qNdcHSFQ5zFr5H6zG3rztVtnMwYDCg9go5cOttWsgu7nUvqplYS/tE9HKfzfIckdLF6CkWFjOfoW4iw58Nj70zt2jt7uqW7t0ArRFs1bpD3LUnQDDAWpS5dEmO1nXPnzF5f2u1V6XadL3/ujMWJO8UJtBVMizryiV3sY6k9p7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869584; c=relaxed/simple;
	bh=VdqXwM713mZ0bZVn9/ejy4DJlJTeIxistLIDr9vm+sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQEDvM3KLY9R3e2BNtWBILISgsTUDzpvgar7QRmh62V1GQg+6O8u13/llFktSMXbOp0R550GMH3kUIsxq3Xmak4cFHGnLmC6pDx6BaElXILhINQvB9NgD1a1e1Iiq+ZUb93eN+qv5WhBH4WqO096Oex3mTOeoZ2i+xDDEkm4jY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxZX6U0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718869582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sx0c3J3POpSIOfrWSRK9QnsXZHV2ebmGDTqhVB4KN5c=;
	b=LxZX6U0nVgtSzGRlqTycat5iZup00PUDKQhVjd+gurxEoAYFJdJQXV0VqS7knxpR6jKsmE
	Xe4K7qMegFsdt0IpXRjpqxB//HmOBmm7SekQMOrjMChMc7+ld+9YAL0xxcvIbHQ5JEnt2b
	RmistQDxomeQSVO1zpPDab/u3kGJI6s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Pk010Uk_MyWvDvoK52kXOw-1; Thu, 20 Jun 2024 03:46:20 -0400
X-MC-Unique: Pk010Uk_MyWvDvoK52kXOw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4210d151c5bso4963725e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869579; x=1719474379;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sx0c3J3POpSIOfrWSRK9QnsXZHV2ebmGDTqhVB4KN5c=;
        b=HjJiu/c3hYKSC47T2NnVwN4C7MOXfJGD3ixTdZB28ZnBYY6Q8yOAX7Bq5wn9z/s6rk
         El1pQLVVN2iPxXZjD2i9F0RnMYkxKziC83oPBBUu2LbsrL0jIrg7GAnqhh5JmJ1SBYar
         5UEGQHD+L/RMb2ZwH3xmsdAbIs6reFLImOgkeuGXrOa6O6Mo+QwINWILhaavqpaa0iMo
         SkXq5h2dhmZ2me3pqahtZPTk5MqJAaO4VhiLm9rgqm4PGD0r6MdptEwuPDAcGQesMY6I
         BdInx0a63FnSouq1IFIEUkdpdTdnhyPPWvfjSwy//881ZhKZo0XndGEFJblv+msegQIp
         cuOg==
X-Forwarded-Encrypted: i=1; AJvYcCUC0HKXVGs59uDVp4eWIbdR+dXztwXEm3DhdBnbBHzxK8SfeDNbAj+huElayrc8/msrPWs5chQ5xQaPAVKD7Rvttqa8IRDf4gka4zA8
X-Gm-Message-State: AOJu0YzWpQSr/oR2r3FJvYaoWoNnu3LWATec37FirJKG06I/5Ek7PwjQ
	BgN99yBZqT7ABljgCHMTa9Jlnt1UDYJvU7DH1NVz95w/YYpzGSQA4FL/j0VoD9JoK4o3aaNIPnS
	T0fBVOT0J/Mrl4uuV7jJxcxm7fKjENVfAFRqNJkBbvWhbtG4N8pIcOwKbUe85zw==
X-Received: by 2002:a05:600c:5107:b0:424:760d:75bd with SMTP id 5b1f17b1804b1-424760d775cmr30541275e9.4.1718869579636;
        Thu, 20 Jun 2024 00:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2mb6eOHDmA3/2fQgXx7tO6lDjbXqLNP6m7VYBhRvPYytt/Dqq1PnEr3TQDoGYeJACgcixsg==
X-Received: by 2002:a05:600c:5107:b0:424:760d:75bd with SMTP id 5b1f17b1804b1-424760d775cmr30541045e9.4.1718869579230;
        Thu, 20 Jun 2024 00:46:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-363e849375asm2914254f8f.107.2024.06.20.00.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 00:46:18 -0700 (PDT)
Message-ID: <f9cb01c2-967f-406c-9304-5e31a82b6b0f@redhat.com>
Date: Thu, 20 Jun 2024 09:46:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if
 folio_test_anon(folio)==false
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
 yuzhao@google.com, Shuai Yuan <yuanshuai@oppo.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
 <20240617231137.80726-3-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240617231137.80726-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.06.24 01:11, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> For the !folio_test_anon(folio) case, we can now invoke folio_add_new_anon_rmap()
> with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This action will
> suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() while initiating
> the process of bringing up mTHP swapin.
> 
>   static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>                   struct page *page, int nr_pages, struct vm_area_struct *vma,
>                   unsigned long address, rmap_t flags, enum rmap_level level)
>   {
>           ...
>           if (unlikely(!folio_test_anon(folio))) {
>                   VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>                                    level != RMAP_LEVEL_PMD, folio);
>           }
>           ...
>   }
> 
> It also improves the code’s readability. Currently, all new anonymous
> folios calling folio_add_anon_rmap_ptes() are order-0. This ensures
> that new folios cannot be partially exclusive; they are either entirely
> exclusive or entirely shared.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Shuai Yuan <yuanshuai@oppo.com>
> ---
>   mm/memory.c   |  8 ++++++++
>   mm/swapfile.c | 13 +++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f24ecdafe05..620654c13b2f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4339,6 +4339,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (unlikely(folio != swapcache && swapcache)) {
>   		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>   		folio_add_lru_vma(folio, vma);
> +	} else if (!folio_test_anon(folio)) {
> +		/*
> +		 * We currently only expect small !anon folios, for which we now
> +		 * that they are either fully exclusive or fully shared. If we
> +		 * ever get large folios here, we have to be careful.
> +		 */
> +		VM_WARN_ON_ONCE(folio_test_large(folio));
> +		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>   	} else {
>   		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
>   					rmap_flags);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ae1d2700f6a3..69efa1a57087 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1908,8 +1908,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>   		VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
>   		if (pte_swp_exclusive(old_pte))
>   			rmap_flags |= RMAP_EXCLUSIVE;
> -
> -		folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
> +		/*
> +		 * We currently only expect small !anon folios, for which we now that
> +		 * they are either fully exclusive or fully shared. If we ever get
> +		 * large folios here, we have to be careful.
> +		 */
> +		if (!folio_test_anon(folio)) {
> +			VM_WARN_ON_ONCE(folio_test_large(folio));

(comment applies to both cases)

Thinking about Hugh's comment, we should likely add here:

VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);

[the check we are removing from __folio_add_anon_rmap()]

and document for folio_add_new_anon_rmap() in patch #1, that when 
dealing with folios that might be mapped concurrently by others, the 
folio lock must be held.

> +			folio_add_new_anon_rmap(folio, vma, addr, rmap_flags);
> +		} else {
> +			folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
> +		}
>   	} else { /* ksm created a completely new copy */
>   		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
>   		folio_add_lru_vma(folio, vma);

-- 
Cheers,

David / dhildenb


