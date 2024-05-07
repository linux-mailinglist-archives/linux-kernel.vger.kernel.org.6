Return-Path: <linux-kernel+bounces-170864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863578BDD12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7A8283A55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361813C90B;
	Tue,  7 May 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3rjnN1M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141164087C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070274; cv=none; b=uJyR548f/kPvmFwitJ8zvFBKRWJIaIUG3GEidzFnkcG1otD5IZYKVoCVIAYvDz3xEP2Ih7jtzJxmBEdHSVWojfBr0Wpyzmjzya4lj8WqoiegMniqpFOvipWam0XyO3Zy1QBXQnxNJlEVA6eSDA3/d7gr9qohnIGKoe+FPpMT/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070274; c=relaxed/simple;
	bh=AEiroOJEcqlaSQxENzCfxRMyjUBDAUA13Oe8IjZ53qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMfUlT5FuoSEQRylflRz4bFPdsQ1RMdAet3gDqJo3gegLqjeTJx5wALJ0bgcfzspsJ0O7TgEUAwMkRLlGbphnc070nArhF3OPWvWppwIzF/yYewBfiZkzPRUAdoh39mLnFkMz4VOP4858z47gWJsGWK8lWKG1o+uL3Sh5M2Tnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3rjnN1M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715070272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HSKL8q0ShgH8ZRlp1HLE1MPKkBs+ecfsyZFOJ7LvpJU=;
	b=M3rjnN1Md/ugJl7ibNi0TzedrhytcdBKIp1r8D39HTYqKKSUvh5g1U/xsA2FMqWh2NCnkB
	pZS0DoECjpFxdhRy/UO3RtKtZTEl5B2/iT7cfcdiodD0lOxbUtzz2RxB/y/PClNHlF5UsN
	PJr8FFZJyF+f/jevpze0XTfiVQxHWeM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-nW7f0d_0NFipnCO5W9EpXQ-1; Tue, 07 May 2024 04:24:28 -0400
X-MC-Unique: nW7f0d_0NFipnCO5W9EpXQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34f10f6b3aeso1339631f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715070267; x=1715675067;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSKL8q0ShgH8ZRlp1HLE1MPKkBs+ecfsyZFOJ7LvpJU=;
        b=blmzrD9r4bJ4LajsD6tQzOFSANx84erILT5hr/+vPzho+NuI7IMitQjVzpuOSUpMTA
         MtXM32CF5SWlHQsCi4+a6lYwOUbqJJgWPOZ1cHzWReP78LjiO6XbxsCQLZMTHvOZ2LN5
         uvONAAG4+i2m6agyAynIz4Ds9C6ANEdnEuQjs8YNBSLfDJn0OR8k4se8Pq5ABIJ3kY2h
         qTaYdxddwSyBv5czKRjl0TqawNMM9TjXcjjIIp5E7N4HkgVALL5AM8wff1GA7Pd2dqS4
         eFNv9f0uVlEiW433E+zkxmizGaikb9CkMFiW82Xbkd+2H5e/dE+Pk0olR4xhnK3749Kx
         r2/g==
X-Forwarded-Encrypted: i=1; AJvYcCWhOWMlnoy6Mpm9OTKFl/u8IZ7ayuLbaDvJeLB0RcjX0G5TM4txGweKUCip83TZPfAJBl2xnZaNdpBIJV014Ji1o8zJpzVwa7j1q8Y8
X-Gm-Message-State: AOJu0YxYLe1ta2vR2pqKUzUKxuqFHuHj2yMh/emb+kaeYg+1Fjh+KzzF
	fquD16m3+Ui4HWpclMytjiLD91oSaEMfUNHIuUohVLpEPjgsIwdTt6Cy+cfF9KBB4FzPv1ewiQu
	4J15VSeC8oexKDu+gr0ztyYEiFX+s3gLkOAnS8w6Xtp0TzyPYB/K2+cRYIY7rFA==
X-Received: by 2002:a05:6000:1379:b0:34d:7dee:649c with SMTP id q25-20020a056000137900b0034d7dee649cmr8937076wrz.13.1715070267084;
        Tue, 07 May 2024 01:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsMqps4edd2ixyksCzMo9pu+gDym/epF/c0h21k8iw5q5+3QPw8A5zL3gXs8eg8Ty0IHfyMA==
X-Received: by 2002:a05:6000:1379:b0:34d:7dee:649c with SMTP id q25-20020a056000137900b0034d7dee649cmr8937045wrz.13.1715070266532;
        Tue, 07 May 2024 01:24:26 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id cx8-20020a056000092800b0034e01a80176sm12401330wrb.114.2024.05.07.01.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 01:24:26 -0700 (PDT)
Message-ID: <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com>
Date: Tue, 7 May 2024 10:24:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in
 swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
 <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com>
 <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
 <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com>
 <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.05.24 00:58, Barry Song wrote:
> On Tue, May 7, 2024 at 1:16 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.05.24 14:58, Barry Song wrote:
>>> On Tue, May 7, 2024 at 12:38 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Tue, May 7, 2024 at 12:07 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 04.05.24 01:23, Barry Song wrote:
>>>>>> On Fri, May 3, 2024 at 6:50 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>
>>>>>>> On 03/05/2024 01:50, Barry Song wrote:
>>>>>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>>>>>>
>>>>>>>> When a large folio is found in the swapcache, the current implementation
>>>>>>>> requires calling do_swap_page() nr_pages times, resulting in nr_pages
>>>>>>>> page faults. This patch opts to map the entire large folio at once to
>>>>>>>> minimize page faults. Additionally, redundant checks and early exits
>>>>>>>> for ARM64 MTE restoring are removed.
>>>>>>>>
>>>>>>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>>>>>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>
>>>>>>> With the suggested changes below:
>>>>>>>
>>>>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>
>>>>>>>> ---
>>>>>>>>     mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----------
>>>>>>>>     1 file changed, 48 insertions(+), 12 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index 22e7c33cc747..940fdbe69fa1 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>          pte_t pte;
>>>>>>>>          vm_fault_t ret = 0;
>>>>>>>>          void *shadow = NULL;
>>>>>>>> +     int nr_pages = 1;
>>>>>>>> +     unsigned long page_idx = 0;
>>>>>>>> +     unsigned long address = vmf->address;
>>>>>>>> +     pte_t *ptep;
>>>>>>>
>>>>>>> nit: Personally I'd prefer all these to get initialised just before the "if
>>>>>>> (folio_test_large()..." block below. That way it is clear they are fresh (incase
>>>>>>> any logic between here and there makes an adjustment) and its clear that they
>>>>>>> are only to be used after that block (the compiler will warn if using an
>>>>>>> uninitialized value).
>>>>>>
>>>>>> right. I agree this will make the code more readable.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>          if (!pte_unmap_same(vmf))
>>>>>>>>                  goto out;
>>>>>>>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>                  goto out_nomap;
>>>>>>>>          }
>>>>>>>>
>>>>>>>> +     ptep = vmf->pte;
>>>>>>>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
>>>>>>>> +             int nr = folio_nr_pages(folio);
>>>>>>>> +             unsigned long idx = folio_page_idx(folio, page);
>>>>>>>> +             unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
>>>>>>>> +             unsigned long folio_end = folio_start + nr * PAGE_SIZE;
>>>>>>>> +             pte_t *folio_ptep;
>>>>>>>> +             pte_t folio_pte;
>>>>>>>> +
>>>>>>>> +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
>>>>>>>> +                     goto check_folio;
>>>>>>>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
>>>>>>>> +                     goto check_folio;
>>>>>>>> +
>>>>>>>> +             folio_ptep = vmf->pte - idx;
>>>>>>>> +             folio_pte = ptep_get(folio_ptep);
>>>>>>>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
>>>>>>>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>>>>>>>> +                     goto check_folio;
>>>>>>>> +
>>>>>>>> +             page_idx = idx;
>>>>>>>> +             address = folio_start;
>>>>>>>> +             ptep = folio_ptep;
>>>>>>>> +             nr_pages = nr;
>>>>>>>> +             entry = folio->swap;
>>>>>>>> +             page = &folio->page;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +check_folio:
>>>>>>>
>>>>>>> Is this still the correct label name, given the checks are now above the new
>>>>>>> block? Perhaps "one_page" or something like that?
>>>>>>
>>>>>> not quite sure about this, as the code after one_page can be multiple_pages.
>>>>>> On the other hand, it seems we are really checking folio after "check_folio"
>>>>>> :-)
>>>>>>
>>>>>>
>>>>>> BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
>>>>>> BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
>>>>>>
>>>>>> /*
>>>>>> * Check under PT lock (to protect against concurrent fork() sharing
>>>>>> * the swap entry concurrently) for certainly exclusive pages.
>>>>>> */
>>>>>> if (!folio_test_ksm(folio)) {
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>          /*
>>>>>>>>           * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>>>>>>>>           * must never point at an anonymous page in the swapcache that is
>>>>>>>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>           * We're already holding a reference on the page but haven't mapped it
>>>>>>>>           * yet.
>>>>>>>>           */
>>>>>>>> -     swap_free_nr(entry, 1);
>>>>>>>> +     swap_free_nr(entry, nr_pages);
>>>>>>>>          if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>>>>>>                  folio_free_swap(folio);
>>>>>>>>
>>>>>>>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>>>>>>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>>>>>>> +     folio_ref_add(folio, nr_pages - 1);
>>>>>>>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>>>>>>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>>>>>>>>          pte = mk_pte(page, vma->vm_page_prot);
>>>>>>>>
>>>>>>>>          /*
>>>>>>>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>           * exclusivity.
>>>>>>>>           */
>>>>>>>>          if (!folio_test_ksm(folio) &&
>>>>>>>> -         (exclusive || folio_ref_count(folio) == 1)) {
>>>>>>>> +         (exclusive || (folio_ref_count(folio) == nr_pages &&
>>>>>>>> +                        folio_nr_pages(folio) == nr_pages))) {
>>>>>>>
>>>>>>> I think in practice there is no change here? If nr_pages > 1 then the folio is
>>>>>>> in the swapcache, so there is an extra ref on it? I agree with the change for
>>>>>>> robustness sake. Just checking my understanding.
>>>>>>
>>>>>> This is the code showing we are reusing/(mkwrite) a folio either
>>>>>> 1. we meet a small folio and we are the only one hitting the small folio
>>>>>> 2. we meet a large folio and we are the only one hitting the large folio
>>>>>>
>>>>>> any corner cases besides the above two seems difficult. for example,
>>>>>>
>>>>>> while we hit a large folio in swapcache but if we can't entirely map it
>>>>>> (nr_pages==1) due to partial unmap, we will have folio_ref_count(folio)
>>>>>> == nr_pages == 1
>>>>>
>>>>> No, there would be other references from the swapcache and
>>>>> folio_ref_count(folio) > 1. See my other reply.
>>>>
>>>> right. can be clearer by:
>>>
>>> Wait, do we still need folio_nr_pages(folio) == nr_pages even if we use
>>> folio_ref_count(folio) == 1 and moving folio_ref_add(folio, nr_pages - 1)?
>>
>> I don't think that we will "need" it.
>>
>>>
>>> one case is that we have a large folio with 16 PTEs, and we unmap
>>> 15 swap PTE entries, thus we have only one swap entry left. Then
>>> we hit the large folio in swapcache.  but we have only one PTE thus we will
>>> map only one PTE. lacking folio_nr_pages(folio) == nr_pages, we reuse the
>>> large folio for one PTE. with it, do_wp_page() will migrate the large
>>> folio to a small one?
>>
>> We will set PAE bit and do_wp_page() will unconditionally reuse that page.
>>
>> Note that this is the same as if we had pte_swp_exclusive() set and
>> would have run into "exclusive=true" here.
>>
>> If we'd want a similar "optimization" as we have in
>> wp_can_reuse_anon_folio(), you'd want something like
>>
>> exclusive || (folio_ref_count(folio) == 1 &&
>>                (!folio_test_large(folio) || nr_pages > 1)
> 
> I feel like
> 
> A :   !folio_test_large(folio) || nr_pages > 1
> 
> equals
> 
> B:    folio_nr_pages(folio) == nr_pages
> 
> if folio is small,  folio_test_large(folio) is false, both A and B will be true;
> if folio is large, and we map the whole large folio, A will be true
> because of nr_pages > 1;
> B is also true;
> if folio is large, and we map single one PTE, A will be false;
> B is also false, because nr_pages == 1 but  folio_nr_pages(folio) > 1;
> 
> right?

Let's assume a single subpage of a large folio is no longer mapped. 
Then, we'd have:

nr_pages == folio_nr_pages(folio) - 1.

You could simply map+reuse most of the folio without COWing.

Once we support COW reuse of PTE-mapped THP we'd do the same. Here, it's 
just easy to detect that the folio is exclusive (folio_ref_count(folio) 
== 1 before mapping anything).

If you really want to mimic what do_wp_page() currently does, you should 
have:

exclusive || (folio_ref_count(folio) == 1 && !folio_test_large(folio))

Personally, I think we should keep it simple here and use:

exclusive || folio_ref_count(folio) == 1

IMHO, that's as clear as it gets.

-- 
Cheers,

David / dhildenb


