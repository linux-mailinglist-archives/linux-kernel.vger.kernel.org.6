Return-Path: <linux-kernel+bounces-449043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE49F48F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C6216AA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FA1E32B7;
	Tue, 17 Dec 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtlxTy7e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84E1D5CFD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431587; cv=none; b=ZVBt3M7QeG8IVN3DzxJ9Koeayp/5Gw+XZCm1Z7qzL+Ug+6ceHrhwRvwZUYhN9sY33lyWIfOwb4+rzBGPMK5fplZT55VbE1A3Ru51bfXVt+MeaCNxC7wCmM7vjC5PWrqkQuPzvh0pGNUFd/D1xOTURIzTi8LKykyqQrMkL7vJdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431587; c=relaxed/simple;
	bh=y71j7Wfd6fGZlM4+vtHrAA3OA8C/rrT97uB97nnCyk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeH15f3LSctjEsyvYTWQjLwVlKhohA8vb0hBXCXLePcqCkAt6HsRNo0WNTg4fSbkPHQ1f+XOatqZBdREqnxpBGKsBZzVJma4Am6SZlg+uIHWbciwMnE914qbOsRQ9SQlEjD1+8oPvDXjnCW/8y9NjyssEAE/nB5q63U+qBP00k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtlxTy7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734431584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hu0ZW6DKfG5MibSTlrGsBUsZ/vzNPiWzbgr/vRIaKD4=;
	b=HtlxTy7eG61wlqv90Zbj2BjHx8wRHadJAJnzJL7bJe8T5UBHzOSsMsuJeOlIvof42zhN//
	x03Pv/bP6mDwaRnnNey05IQMaE7c1cLnk8k03PpJMVOL+R3FxwngDQ6EjEOxjZoduGLXJM
	+N/AV51An5Kd5FmdAQSxj0qZs9X9z+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ZSy6iaa0OL2CMs6ReY2WZg-1; Tue, 17 Dec 2024 05:33:02 -0500
X-MC-Unique: ZSy6iaa0OL2CMs6ReY2WZg-1
X-Mimecast-MFC-AGG-ID: ZSy6iaa0OL2CMs6ReY2WZg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so28711425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431582; x=1735036382;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hu0ZW6DKfG5MibSTlrGsBUsZ/vzNPiWzbgr/vRIaKD4=;
        b=KGnn/wGUMN8j8dmewgl7o6StasuYmLWjwoeTWFXSl1iV8PNuanZpTA1kDxB26ToUmr
         YlelGdhZ5wTaX5kSvaDyhmFKxJ2T2D8+E4pq3nA/pF8My4glmkEt9eN8GZDu+2X5x1eJ
         akYqCqf582xmxRA41XrN/EBvqBcaqAQkEbcjI3BJzj6c7QFyMan5ONBpt/bDninsibDe
         2uFn2Wjz8pyYJxjjUIPB/svfNvotwWOuXr1aUCbr4ln3R6ikDoTOgG9jAfaS/tt3SU+p
         OaSpX7UjNXWIaj1Xu3G/TDsH3kpkDVQpKXhT+bbeG56JnXNW2ypg06uB604pj1iR36po
         lsTg==
X-Forwarded-Encrypted: i=1; AJvYcCUCvaw8riyq3+lCv4SEpmV0Rvze+jSR7lfKX+RYiQHjJmj1SUNUbQseATgbgVlM8oVCpxuh32aGilRrX+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9PGjBnsKCuNyY3G0EU3qZOJ76sWwHMDKr2GIyFv4JoTHTp7I
	USMJvsN4dahuUaL7ZveAG5w4dR5q9mjqZT5wqJwgxv9jinKjjjGn/5M8u1xtLc53ApWLGeM7U3g
	hdeRvy/DbW1n/H/r6dfP/j7Y8Vm1CjxuAIIGNNQD8Teisg8qsz0FRK3eaduQiBA==
X-Gm-Gg: ASbGnctS6tB6yWLz65UMRZ7MSCj7R+MgLSE9s+yxDujQFrBvL0hEjSJDfUdCYwNDoqB
	cqQiyaydFVeLbHk5hUf7GsUGsOQICUFyfdibpPHgFjLDGTP96zkcFrsOiN6tbkwNqvjW9MtbhiF
	59rCSMm1jQyjhmR7eMZ+N9SJnKVct7T+EzhikMd3bjWrADs0P00X3cEbSJfyoTi3Iy90pbz4x1I
	iBxu8x2JgvzhqurhU+TTtqZkCKDrRS+X43HQPDsesxrQFwn57JVWkhaLT4DOEAGE+iDTuhmlA+9
	Q/JXT5oTQ1gE7qk=
X-Received: by 2002:a05:600c:3d0f:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-4362aa34d42mr142981505e9.4.1734431581601;
        Tue, 17 Dec 2024 02:33:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp8cxaHK9um9cztBnBI61MwYd+lYt0Z5UGgS6T9YAGVV9UbkL/E0jc3m6rCPGDZki5SgJt3g==
X-Received: by 2002:a05:600c:3d0f:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-4362aa34d42mr142981235e9.4.1734431581164;
        Tue, 17 Dec 2024 02:33:01 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363601574bsm112434495e9.7.2024.12.17.02.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:33:00 -0800 (PST)
Message-ID: <0368f4f2-cb0f-4633-a86d-5c3f75839b4e@redhat.com>
Date: Tue, 17 Dec 2024 11:32:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] khugepaged: Introduce vma_collapse_anon_folio()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-10-dev.jain@arm.com>
 <2215dd8e-233a-427b-b15c-a2ffbce8f46d@redhat.com>
 <28013908-65d8-462e-b975-cd0f63d226b1@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <28013908-65d8-462e-b975-cd0f63d226b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.12.24 11:07, Dev Jain wrote:
> 
> On 16/12/24 10:36 pm, David Hildenbrand wrote:
>> On 16.12.24 17:51, Dev Jain wrote:
>>> In contrast to PMD-collapse, we do not need to operate on two levels
>>> of pagetable
>>> simultaneously. Therefore, downgrade the mmap lock from write to read
>>> mode. Still
>>> take the anon_vma lock in exclusive mode so as to not waste time in
>>> the rmap path,
>>> which is anyways going to fail since the PTEs are going to be
>>> changed. Under the PTL,
>>> copy page contents, clear the PTEs, remove folio pins, and (try to)
>>> unmap the
>>> old folios. Set the PTEs to the new folio using the set_ptes() API.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>> Note: I have been trying hard to get rid of the locks in here: we
>>> still are
>>> taking the PTL around the page copying; dropping the PTL and taking
>>> it after
>>> the copying should lead to a deadlock, for example:
>>> khugepaged                        madvise(MADV_COLD)
>>> folio_lock()                        lock(ptl)
>>> lock(ptl)                        folio_lock()
>>>
>>> We can create a locked folio list, altogether drop both the locks,
>>> take the PTL,
>>> do everything which __collapse_huge_page_isolate() does *except* the
>>> isolation and
>>> again try locking folios, but then it will reduce efficiency of
>>> khugepaged
>>> and almost looks like a forced solution :)
>>> Please note the following discussion if anyone is interested:
>>> https://lore.kernel.org/all/66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com/
>>>
>>> (Apologies for not CCing the mailing list from the start)
>>>
>>>    mm/khugepaged.c | 108 ++++++++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 87 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 88beebef773e..8040b130e677 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -714,24 +714,28 @@ static void
>>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>>                            struct vm_area_struct *vma,
>>>                            unsigned long address,
>>>                            spinlock_t *ptl,
>>> -                        struct list_head *compound_pagelist)
>>> +                        struct list_head *compound_pagelist, int order)
>>>    {
>>>        struct folio *src, *tmp;
>>>        pte_t *_pte;
>>>        pte_t pteval;
>>>    -    for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>>> +    for (_pte = pte; _pte < pte + (1UL << order);
>>>             _pte++, address += PAGE_SIZE) {
>>>            pteval = ptep_get(_pte);
>>>            if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>                add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>>>                if (is_zero_pfn(pte_pfn(pteval))) {
>>> -                /*
>>> -                 * ptl mostly unnecessary.
>>> -                 */
>>> -                spin_lock(ptl);
>>> -                ptep_clear(vma->vm_mm, address, _pte);
>>> -                spin_unlock(ptl);
>>> +                if (order == HPAGE_PMD_ORDER) {
>>> +                    /*
>>> +                    * ptl mostly unnecessary.
>>> +                    */
>>> +                    spin_lock(ptl);
>>> +                    ptep_clear(vma->vm_mm, address, _pte);
>>> +                    spin_unlock(ptl);
>>> +                } else {
>>> +                    ptep_clear(vma->vm_mm, address, _pte);
>>> +                }
>>>                    ksm_might_unmap_zero_page(vma->vm_mm, pteval);
>>>                }
>>>            } else {
>>> @@ -740,15 +744,20 @@ static void
>>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>>                src = page_folio(src_page);
>>>                if (!folio_test_large(src))
>>>                    release_pte_folio(src);
>>> -            /*
>>> -             * ptl mostly unnecessary, but preempt has to
>>> -             * be disabled to update the per-cpu stats
>>> -             * inside folio_remove_rmap_pte().
>>> -             */
>>> -            spin_lock(ptl);
>>> -            ptep_clear(vma->vm_mm, address, _pte);
>>> -            folio_remove_rmap_pte(src, src_page, vma);
>>> -            spin_unlock(ptl);
>>> +            if (order == HPAGE_PMD_ORDER) {
>>> +                /*
>>> +                * ptl mostly unnecessary, but preempt has to
>>> +                * be disabled to update the per-cpu stats
>>> +                * inside folio_remove_rmap_pte().
>>> +                */
>>> +                spin_lock(ptl);
>>> +                ptep_clear(vma->vm_mm, address, _pte);
>>
>>
>>
>>
>>> + folio_remove_rmap_pte(src, src_page, vma);
>>> +                spin_unlock(ptl);
>>> +            } else {
>>> +                ptep_clear(vma->vm_mm, address, _pte);
>>> +                folio_remove_rmap_pte(src, src_page, vma);
>>> +            }
>>
>> As I've talked to Nico about this code recently ... :)
>>
>> Are you clearing the PTE after the copy succeeded? If so, where is the
>> TLB flush?
>>
>> How do you sync against concurrent write acess + GUP-fast?
>>
>>
>> The sequence really must be: (1) clear PTE/PMD + flush TLB (2) check
>> if there are unexpected page references (e.g., GUP) if so back off (3)
>> copy page content (4) set updated PTE/PMD.
> 
> Thanks...we need to ensure GUP-fast does not write when we are copying
> contents, so (2) will ensure that GUP-fast will see the cleared PTE and
> back-off.

Yes, and of course, that also the CPU cannot concurrently still modify 
the page content while/after you copy the page content, but before you 
unmap+flush.

>>
>> To Nico, I suggested doing it simple initially, and still clear the
>> high-level PMD entry + flush under mmap write lock, then re-map the
>> PTE table after modifying the page table. It's not as efficient, but
>> "harder to get wrong".
>>
>> Maybe that's already happening, but I stumbled over this clearing
>> logic in __collapse_huge_page_copy_succeeded(), so I'm curious.
> 
> No, I am not even touching the PMD. I guess the sequence you described
> should work? I just need to reverse the copying and PTE clearing order
> to implement this sequence.

That would work, but you really have to hold the PTL for the whole 
period: from when you temporarily clear PTEs +_ flush the TLB, when you 
copy, until you re-insert the updated ones.

When having to back-off (restore original PTEs), or for copying, you'll 
likely need access to the original PTEs, which were already cleared. So 
likely you need a temporary copy of the original PTEs somehow.

That's why temporarily clearing the PMD und mmap write lock is easier to 
implement, at the cost of requiring the mmap lock in write mode like PMD 
collapse.

-- 
Cheers,

David / dhildenb


