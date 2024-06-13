Return-Path: <linux-kernel+bounces-212875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D617690676F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAAB1C209B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CB28F1;
	Thu, 13 Jun 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhOy++OD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974C13D63A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268498; cv=none; b=Wd5OqPFDHN0jVi775E9BQiJVFGjjZH6J1X3UecxgymsiZwFTGdE3qF26oey7qs9g+A3xXspMPRl/I3IUeiXs5rxvSTSZG5t+evLFeqS1pEnDCRJ31vYai7wVecnQhYDG/lCopvWpHHM2qs/19DzWHjFex6Ry9Dx6961JI+6upTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268498; c=relaxed/simple;
	bh=ATnkrX3I+rN+/powm9gLwQfQtVlQqHtF0Wg2L7nn0c4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o1p/UMlxK17WTuOS/ncHHSi2CNuLp+U3jAUNJO4j6kkgf2FFkBaEow+zzF8xRBeftANSbHu0DG5R+vCoALv6lxtcU6s+9fLgZvD6aRsnA5CB6HEVSJ53v+dmaggfNUggCg/gZe/ZGayWhgf0oNhYtZaEsZsh+2gpSWncE+M7jSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhOy++OD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718268494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LB5kBJlwv9yGIa6K4flsVtyzmzEBCGRZ5hcVrd8sfpQ=;
	b=FhOy++ODuUVEZbWU8pa3kgqchwcgiL+fpx1J2+vP7c5ILdx3hRFqy+DO4TvDZJRvtpXfoJ
	S7oppDGycRqGEvu/MCC4gBSx/JgcWlI5kBu5UKhVhXdPhfABfzQOTMrC1QQbVpqXMpUnlO
	sQu48JP42kb5Ipm84e1kKrxg/JhXkVI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-HwagAz1_MSmLY4v63Su3hg-1; Thu, 13 Jun 2024 04:47:00 -0400
X-MC-Unique: HwagAz1_MSmLY4v63Su3hg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f1f29ccefso457725f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268420; x=1718873220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LB5kBJlwv9yGIa6K4flsVtyzmzEBCGRZ5hcVrd8sfpQ=;
        b=JwQYqVnLvjclE6XfDLxzzbnq8g6ABdbD5tozgnDfOMydEKUy1us44jDUvxGz6uLmZc
         3eFniTGSDdQ8oHIqYvOMWh1IYzT8dNJ4azkbbywyREpHZdU2r1j4iuQ08dSeIb4bH56r
         U+G2KSCb1BXGJaKjsKAer5cD9Z06iSEHzMajTnrwHeA1loa9BIne/g907Ohg7P4Q7gCh
         Ic+eeFSEmJ36ALMJH8ftEw6jxSwf09PRoX6nFppAiUPEFus59F517uAZhoW5Wg8lVDMq
         w21/wW/eUEDs0hPmHialKqqx7rCda0hPoCj0cZI8VuZT978a8Nwv5KN3ekhu9SluivVN
         brUA==
X-Forwarded-Encrypted: i=1; AJvYcCXrWZWVjmhpo1y1g8ElEph/yFVPMPEEOxCKQU4Sz9bvSRIHGDyRt5watIUvOTLch1XGHb53ipJ5o+M0ZoxupWAgphZs59jfVqfxrjoM
X-Gm-Message-State: AOJu0Yx2t8bU6fS3lwdAGnHKVNUUJUgf2yhbxmEr+yOxtjmKGPI+rvVa
	hoOkAkquIzT/kiPZeyUkPT0/CWVh5123MlqAUNryCjDdY2I87e3+ILTMcQrIrrRS3OLMNxoGYhC
	VWDyAW1NYhBlke/7QV3IZ1O5fMiRYj/AKAgkT4uMxTiuJ3KVDsoQbq6btP3HBPA==
X-Received: by 2002:adf:fec7:0:b0:359:6f2a:3912 with SMTP id ffacd0b85a97d-35fdf79c5aamr2907634f8f.18.1718268419658;
        Thu, 13 Jun 2024 01:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs2FIeKMWxeWXFEkqMaP0wmq7102FpmjPwHnC+lwxmgJxqt9Ar0e/28Hmv0SfFXlDnP5SJYQ==
X-Received: by 2002:adf:fec7:0:b0:359:6f2a:3912 with SMTP id ffacd0b85a97d-35fdf79c5aamr2907614f8f.18.1718268419211;
        Thu, 13 Jun 2024 01:46:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607510340fsm1025881f8f.93.2024.06.13.01.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:46:58 -0700 (PDT)
Message-ID: <642feff4-fa0b-4c3b-a65d-b40926d28f2b@redhat.com>
Date: Thu, 13 Jun 2024 10:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
From: David Hildenbrand <david@redhat.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org,
 baolin.wang@linux.alibaba.com, fengwei.yin@intel.com,
 libang.li@antgroup.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maskray@google.com, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com,
 ryan.roberts@arm.com, shy828301@gmail.com, sj@kernel.org,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiehuan09@gmail.com, ziy@nvidia.com, zokeefe@google.com
References: <20240610120209.66311-1-ioworker0@gmail.com>
 <20240610120618.66520-1-ioworker0@gmail.com>
 <933c7339-2dbd-464b-b342-e4cff7ad75a3@redhat.com>
 <cdf64853-d81c-492f-ba1c-7124480ea292@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cdf64853-d81c-492f-ba1c-7124480ea292@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.24 10:45, David Hildenbrand wrote:
> On 13.06.24 10:34, David Hildenbrand wrote:
>> On 10.06.24 14:06, Lance Yang wrote:
>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
>>> folios, start the pagewalk first, then call split_huge_pmd_address() to
>>> split the folio.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>> ---
>>>     include/linux/huge_mm.h |  6 ++++++
>>>     mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
>>>     mm/rmap.c               | 21 +++++++++++++++------
>>>     3 files changed, 43 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 088d66a54643..4670c6ee118b 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -415,6 +415,9 @@ static inline bool thp_migration_supported(void)
>>>     	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>>>     }
>>>     
>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>> +			   pmd_t *pmd, bool freeze, struct folio *folio);
>>> +
>>>     #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>     
>>>     static inline bool folio_test_pmd_mappable(struct folio *folio)
>>> @@ -477,6 +480,9 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>     		unsigned long address, bool freeze, struct folio *folio) {}
>>>     static inline void split_huge_pmd_address(struct vm_area_struct *vma,
>>>     		unsigned long address, bool freeze, struct folio *folio) {}
>>> +static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
>>> +					 unsigned long address, pmd_t *pmd,
>>> +					 bool freeze, struct folio *folio) {}
>>>     
>>>     #define split_huge_pud(__vma, __pmd, __address)	\
>>>     	do { } while (0)
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index e6d26c2eb670..d2697cc8f9d4 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2581,6 +2581,27 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>     	pmd_populate(mm, pmd, pgtable);
>>>     }
>>>     
>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>> +			   pmd_t *pmd, bool freeze, struct folio *folio)
>>> +{
>>> +	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>> +	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>> +	VM_BUG_ON(freeze && !folio);
>>
>> Curious: could we actually end up here without a folio right now? That
>> would mean, that try_to_unmap_one() would be called with folio==NULL.
>>
>>> +
>>> +	/*
>>> +	 * When the caller requests to set up a migration entry, we
>>> +	 * require a folio to check the PMD against. Otherwise, there
>>> +	 * is a risk of replacing the wrong folio.
>>> +	 */
>>> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>> +	    is_pmd_migration_entry(*pmd)) {
>>> +		if (folio && folio != pmd_folio(*pmd))
>>> +			return;
>>> +		__split_huge_pmd_locked(vma, pmd, address, freeze);
>>> +	}
>>> +}
>>> +
>>>     void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>     		unsigned long address, bool freeze, struct folio *folio)
>>>     {
>>> @@ -2592,26 +2613,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>     				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
>>>     	mmu_notifier_invalidate_range_start(&range);
>>>     	ptl = pmd_lock(vma->vm_mm, pmd);
>>> -
>>> -	/*
>>> -	 * If caller asks to setup a migration entry, we need a folio to check
>>> -	 * pmd against. Otherwise we can end up replacing wrong folio.
>>> -	 */
>>> -	VM_BUG_ON(freeze && !folio);
>>> -	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>> -
>>> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>> -	    is_pmd_migration_entry(*pmd)) {
>>> -		/*
>>> -		 * It's safe to call pmd_page when folio is set because it's
>>> -		 * guaranteed that pmd is present.
>>> -		 */
>>> -		if (folio && folio != pmd_folio(*pmd))
>>> -			goto out;
>>> -		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
>>> -	}
>>> -
>>> -out:
>>> +	split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
>>>     	spin_unlock(ptl);
>>>     	mmu_notifier_invalidate_range_end(&range);
>>>     }
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index ddffa30c79fb..b77f88695588 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>     	if (flags & TTU_SYNC)
>>>     		pvmw.flags = PVMW_SYNC;
>>>     
>>> -	if (flags & TTU_SPLIT_HUGE_PMD)
>>> -		split_huge_pmd_address(vma, address, false, folio);
>>> -
>>>     	/*
>>>     	 * For THP, we have to assume the worse case ie pmd for invalidation.
>>>     	 * For hugetlb, it could be much worse if we need to do pud
>>> @@ -1668,9 +1665,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>     	mmu_notifier_invalidate_range_start(&range);
>>>     
>>>     	while (page_vma_mapped_walk(&pvmw)) {
>>> -		/* Unexpected PMD-mapped THP? */
>>> -		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>> -
>>>     		/*
>>>     		 * If the folio is in an mlock()d vma, we must not swap it out.
>>>     		 */
>>> @@ -1682,6 +1676,21 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>     			goto walk_done_err;
>>>     		}
>>>     
>>> +		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
>>> +			/*
>>> +			 * We temporarily have to drop the PTL and start once
>>> +			 * again from that now-PTE-mapped page table.
>>> +			 */
>>> +			split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
>>> +					      false, folio);
>>> +			flags &= ~TTU_SPLIT_HUGE_PMD;
>>> +			page_vma_mapped_walk_restart(&pvmw);
>>
>> If, for some reason, split_huge_pmd_locked() would fail, we would keep
>> looping and never hit the VM_BUG_ON_FOLIO() below. Maybe we'd want to
>> let split_huge_pmd_locked() return whether splitting succeeded, and
>> handle that case differently?
> 
> I assume it could fail if we race with concurrent split? Or isn't that
> possible?
> 

(I assume we hold the PTL, so such races should not be possible)

-- 
Cheers,

David / dhildenb


