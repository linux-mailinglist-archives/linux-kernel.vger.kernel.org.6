Return-Path: <linux-kernel+bounces-169771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F398BCD72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4749E1C21715
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC8143882;
	Mon,  6 May 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7TYG0Gk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238423D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997255; cv=none; b=BPZr+ucZOKGwdkOdyc//qH9QQyhMKsZ4V8+QnSEn5pHWzmoitGORkFrmn5Fm+nlyKbWn40I/hurqQ7TDyBXa9eQj87tOq1U0SUxZGZweiU7xBHxr0vK2CEDqVzr0k764I57rn/CG6to+g6gX43hTdrDj5HUnE24noLDyEQpfK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997255; c=relaxed/simple;
	bh=auvdy/gB7X+62hPzzS8iKsjPLaM3j9LG5Ji3kP3llkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5hGczkN55XpU1D3rW2qEUtR2J+9mBhqhT3TELIkCyXE0UVmHzc842tmAh78D/DjKVf8W6PZQxedk+vch2UQDkfIl8LcPM0jP150T50AWo9J6V49zoBw+VrUqXohqklYwgjj5BrL+qlxJop/a5SIeOorR3BOXUYJXUKgMAkX+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7TYG0Gk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714997253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TY1eYJnthJD1GGGBWiDhPpK4TMNZlEt7kuW4K/kggwU=;
	b=J7TYG0GkDNvGn1V+JAnQ0k6Cj+gxhrtQsYtY5RqUjFUIhIKsoDnWvqLySJBEisQipe9uHJ
	Az2jpr1aBcy9WguIw4AXxjrnmDTkdTLVhYunoLOhuYpb48GDf4ZBJJNumhlvgRgyn/hPnP
	taMKZIvZAF2AHNNMcG2r9ZDGBMeGy9I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Y_eaOX9qOsWO8e40U-dQGQ-1; Mon, 06 May 2024 08:07:31 -0400
X-MC-Unique: Y_eaOX9qOsWO8e40U-dQGQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-418f8271081so5312825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714997250; x=1715602050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TY1eYJnthJD1GGGBWiDhPpK4TMNZlEt7kuW4K/kggwU=;
        b=G+oKNuMTlEiXIHoFmlpbwjGYA5nDMpuve0XOa5I2F7MdmVzZqcTYJgT7wTpeuBvvDe
         kUIWrjvftbc9lG2FNFPSTScF0MXbe//AoNUoL6GILezS5MBhoOFuRDvWwmb8CzZYKgsc
         FBiUHKssUPPaQdBbGafZI/R1eiubJs9+pDLlHAfmf+KTDRhIAu8po9YrSqzdmva0X20q
         c/CUnVZH74ICMjiY3DUoUQ1PWg3chuPyVBXIGvVe6dF2E+txPaKV4EaLRHEXXqg7gGhG
         g+WMwfSJzzifb9KGFFQv2GXm5xZwGERPLPWdtPZupHWuoxFV0qR19ci1KDxuDTNtDvnV
         kCVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuCltpUB/7+oC710TS4KCBd9152MwsjHAUd9jzgy53+kVMFssw259oyoviXgzM19GtGtVxH5a5+cNyYDHxX5iH+uLZo28IiTy1cIlX
X-Gm-Message-State: AOJu0YzlFd0B+7D+PeGhLBe/f7EAPmjrX/bGKRljYMel6iUpNJJwngJn
	vDdm3uEyEw7pceIO6q7SHl3Ic1s7BvztpGBbHunI4QPXFfseyn1kNKwqpztMfHtGGs17aLrHjt2
	Y7B0J3HVJ7ibpc9Z6eSKuC37TeVVvvSIK4EgGSiH3RiQQ1kzEdkgSIbPK6f1pTA==
X-Received: by 2002:a05:600c:1552:b0:418:792d:f8b4 with SMTP id f18-20020a05600c155200b00418792df8b4mr9474300wmg.23.1714997250417;
        Mon, 06 May 2024 05:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExgojPVRb4DOPPSGw2hVekKGRtYpeb//CjafOFjzvVFKVzgMfqdhUoyMF4wdt5agMYY/J8eg==
X-Received: by 2002:a05:600c:1552:b0:418:792d:f8b4 with SMTP id f18-20020a05600c155200b00418792df8b4mr9474281wmg.23.1714997249921;
        Mon, 06 May 2024 05:07:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:bf00:182c:d606:87cf:6fea? (p200300cbc74bbf00182cd60687cf6fea.dip0.t-ipconnect.de. [2003:cb:c74b:bf00:182c:d606:87cf:6fea])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4d8c000000b0034e65b8b43fsm8552835wru.8.2024.05.06.05.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 05:07:29 -0700 (PDT)
Message-ID: <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com>
Date: Mon, 6 May 2024 14:07:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in
 swapcache
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
 <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.05.24 01:23, Barry Song wrote:
> On Fri, May 3, 2024 at 6:50 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 03/05/2024 01:50, Barry Song wrote:
>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>
>>> When a large folio is found in the swapcache, the current implementation
>>> requires calling do_swap_page() nr_pages times, resulting in nr_pages
>>> page faults. This patch opts to map the entire large folio at once to
>>> minimize page faults. Additionally, redundant checks and early exits
>>> for ARM64 MTE restoring are removed.
>>>
>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>
>> With the suggested changes below:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>>> ---
>>>   mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 48 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 22e7c33cc747..940fdbe69fa1 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>        pte_t pte;
>>>        vm_fault_t ret = 0;
>>>        void *shadow = NULL;
>>> +     int nr_pages = 1;
>>> +     unsigned long page_idx = 0;
>>> +     unsigned long address = vmf->address;
>>> +     pte_t *ptep;
>>
>> nit: Personally I'd prefer all these to get initialised just before the "if
>> (folio_test_large()..." block below. That way it is clear they are fresh (incase
>> any logic between here and there makes an adjustment) and its clear that they
>> are only to be used after that block (the compiler will warn if using an
>> uninitialized value).
> 
> right. I agree this will make the code more readable.
> 
>>
>>>
>>>        if (!pte_unmap_same(vmf))
>>>                goto out;
>>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>                goto out_nomap;
>>>        }
>>>
>>> +     ptep = vmf->pte;
>>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
>>> +             int nr = folio_nr_pages(folio);
>>> +             unsigned long idx = folio_page_idx(folio, page);
>>> +             unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
>>> +             unsigned long folio_end = folio_start + nr * PAGE_SIZE;
>>> +             pte_t *folio_ptep;
>>> +             pte_t folio_pte;
>>> +
>>> +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
>>> +                     goto check_folio;
>>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
>>> +                     goto check_folio;
>>> +
>>> +             folio_ptep = vmf->pte - idx;
>>> +             folio_pte = ptep_get(folio_ptep);
>>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
>>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>>> +                     goto check_folio;
>>> +
>>> +             page_idx = idx;
>>> +             address = folio_start;
>>> +             ptep = folio_ptep;
>>> +             nr_pages = nr;
>>> +             entry = folio->swap;
>>> +             page = &folio->page;
>>> +     }
>>> +
>>> +check_folio:
>>
>> Is this still the correct label name, given the checks are now above the new
>> block? Perhaps "one_page" or something like that?
> 
> not quite sure about this, as the code after one_page can be multiple_pages.
> On the other hand, it seems we are really checking folio after "check_folio"
> :-)
> 
> 
> BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
> BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> 
> /*
> * Check under PT lock (to protect against concurrent fork() sharing
> * the swap entry concurrently) for certainly exclusive pages.
> */
> if (!folio_test_ksm(folio)) {
> 
> 
>>
>>> +
>>>        /*
>>>         * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>>>         * must never point at an anonymous page in the swapcache that is
>>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>         * We're already holding a reference on the page but haven't mapped it
>>>         * yet.
>>>         */
>>> -     swap_free_nr(entry, 1);
>>> +     swap_free_nr(entry, nr_pages);
>>>        if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>                folio_free_swap(folio);
>>>
>>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>> +     folio_ref_add(folio, nr_pages - 1);
>>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>>>        pte = mk_pte(page, vma->vm_page_prot);
>>>
>>>        /*
>>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>         * exclusivity.
>>>         */
>>>        if (!folio_test_ksm(folio) &&
>>> -         (exclusive || folio_ref_count(folio) == 1)) {
>>> +         (exclusive || (folio_ref_count(folio) == nr_pages &&
>>> +                        folio_nr_pages(folio) == nr_pages))) {
>>
>> I think in practice there is no change here? If nr_pages > 1 then the folio is
>> in the swapcache, so there is an extra ref on it? I agree with the change for
>> robustness sake. Just checking my understanding.
> 
> This is the code showing we are reusing/(mkwrite) a folio either
> 1. we meet a small folio and we are the only one hitting the small folio
> 2. we meet a large folio and we are the only one hitting the large folio
> 
> any corner cases besides the above two seems difficult. for example,
> 
> while we hit a large folio in swapcache but if we can't entirely map it
> (nr_pages==1) due to partial unmap, we will have folio_ref_count(folio)
> == nr_pages == 1

No, there would be other references from the swapcache and 
folio_ref_count(folio) > 1. See my other reply.

-- 
Cheers,

David / dhildenb


