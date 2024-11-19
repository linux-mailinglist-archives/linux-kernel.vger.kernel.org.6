Return-Path: <linux-kernel+bounces-414098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029149D22FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBEE1F2270F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7801B86DC;
	Tue, 19 Nov 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C0ME6Squ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DA45945
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010626; cv=none; b=lP5WasBsEapXKmtlnvK/DfKo/UT/fYth/doQsZn91hGgkdsxlr6CxRZ9k7GhsH1CvUzLstNkVK9SUcVEeY2zDV0D83i++k5QXIwu5a/32FIBGY4s5t9sPTzo9gooOasCdoNEdUrELplV/A5hZmSqISNndrIQwBxEHpejWJg/n5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010626; c=relaxed/simple;
	bh=N1BZlQcSySJbOrwnKwCn/YGiHWepcFhZuP+CAVdLSho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8XueEaob24FT9KK9Mfu9kYPfd7C64sgje/fiLf4nrwfIhc1e6n4mgfTKdSjJsul3vivwToqAa4fCdpC7t0E63vMO6N0BjkaxgnOqv2tVkDUGg7y/KI+KK2XbHOeJrDRjQHf4TvM2Nhvqe3zMvjtkSrhCtHYMdQLcKfPYqhCZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C0ME6Squ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21145812538so5084385ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732010624; x=1732615424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/gckH2swE3iy2J2B+UCv0TBAurGqUwksNzT/L3/BVc=;
        b=C0ME6Squy4+wFnWmkG77fN+ThutsZ6doSutpWg7cVMpAhm1Rsbf05nAaAXmZzGixqc
         mMKbnFWACe76JvNjLRP0PpWgKr+Ta8h0O0pFRfWpbTS+pWTTSzvnBVpYsJ+pe5rpNY7O
         lmGELMfb5qNsPgZZTy8Hnlfs+A7o5QRXrXLs3EHdJGYjqeNK942zzBeClLzITLJYysS9
         5E+WUApeL0e7Ss586AJeGM1uV3AKguQva73ax29HBqjUfJJUD0Fs+IsVhPjDUPQvVfii
         T0PDuDQJabxyQRajzb/WbP2USOiXOVFSc37uD+vS7WnTTN5yKsVsDqIOR1Y1rwjUx5B4
         PNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732010624; x=1732615424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/gckH2swE3iy2J2B+UCv0TBAurGqUwksNzT/L3/BVc=;
        b=QyB0J4mfHgRFa1zh+rPdFj6BY7P7y+JBEB6D0sbdxA03ASHJT6hD7EkJW/BTdvyu8Z
         UZu6w0xI274GiXfuMWp47oQqLYiIvIgWSKkt+9XT5AxLpnDxM4ldf/1ayTT/SGNTBQw/
         Z3XA5EsImTEpyCj6wdwnqttW3mlq/UcHKVtQPgQS+Mkmm3puE8Ti9N63Y4zYsIe9Fqy0
         PWlLcWoqlFXl6FfE1CSa+2tw8MLi7vrn7IXf/nLCko+xh9tFToZ4oMR9vfA2ZoVvo17d
         yd6OXfVt4z5x3TGkt+a24qqNjmBcVT5sUHkuoaLXSYwW1xD0KuoYVdPiLfMuKqRMWSTQ
         EO9A==
X-Forwarded-Encrypted: i=1; AJvYcCXR5Cr+cxYx69QeosDajTFze3ZuM+OgSbhV/NonWWfnwtPgy9tF4xyIEL80QPkFrXNpP2oXgFYUQTb1U64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hbF4iQQSoryGVawBrKN8/BjUKPw0r19ou+pHKqH2oo7CliG0
	3FmfAqlXnRtYkRjc1jVu0sRSP38YpKzRW9/0Bk7OOWeEDD+0Q8dLBOEIgp1eG+Y=
X-Google-Smtp-Source: AGHT+IFw7NMT+8aWA+giCJdZ35/mDE+PF7iPZm76phWNwrVsNKK9E2t5REXsrZ76O6Weqb1xVqV5sw==
X-Received: by 2002:a17:903:183:b0:20c:5b80:930f with SMTP id d9443c01a7336-211d0d4bda3mr207147225ad.12.1732010623811;
        Tue, 19 Nov 2024 02:03:43 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120e4373c5sm40862595ad.57.2024.11.19.02.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:03:43 -0800 (PST)
Message-ID: <99d3229a-17ce-4a41-ae11-ebfab138cf76@bytedance.com>
Date: Tue, 19 Nov 2024 18:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
 <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
 <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
 <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
 <f3adf382-d252-4007-b8ca-c557814cb5c8@bytedance.com>
 <4ee60b7b-a81e-4b94-96c9-52b1bd9d5061@redhat.com>
 <e2870a81-840a-4b33-b65b-318a4a526c26@bytedance.com>
 <332cbacb-cad3-4522-a74b-b5ad5efee4af@redhat.com>
 <d897a1d3-bf72-48f2-b4df-1f7acb3ac311@bytedance.com>
 <b5da4118-2b63-4383-8617-ac98d7e62c64@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b5da4118-2b63-4383-8617-ac98d7e62c64@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/19 17:55, David Hildenbrand wrote:
> On 18.11.24 12:13, Qi Zheng wrote:
>>
>>
>> On 2024/11/18 18:59, David Hildenbrand wrote:
>>> On 18.11.24 11:56, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2024/11/18 18:41, David Hildenbrand wrote:
>>>>> On 18.11.24 11:34, Qi Zheng wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/11/18 17:29, David Hildenbrand wrote:
>>>>>>> On 18.11.24 04:35, Qi Zheng wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/11/15 22:59, David Hildenbrand wrote:
>>>>>>>>> On 15.11.24 15:41, Qi Zheng wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>>>>>>>>> *nr_skip = nr;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> and then:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> zap_pte_range
>>>>>>>>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>>>>>>>>> &skip_nr,
>>>>>>>>>>>>>>                                rss, &force_flush, 
>>>>>>>>>>>>>> &force_break);
>>>>>>>>>>>>>>             if (can_reclaim_pt) {
>>>>>>>>>>>>>>                 none_nr += count_pte_none(pte, nr);
>>>>>>>>>>>>>>                 none_nr += nr_skip;
>>>>>>>>>>>>>>             }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Right?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes. I did not look closely at the patch that adds the
>>>>>>>>>>>>> counting of
>>>>>>>>>>>>
>>>>>>>>>>>> Got it.
>>>>>>>>>>>>
>>>>>>>>>>>>> pte_none though (to digest why it is required :) ).
>>>>>>>>>>>>
>>>>>>>>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>>>>>>>>> empty PTE page.
>>>>>>>>>>>
>>>>>>>>>>> Okay, so the problem is that "nr" would be "all processed
>>>>>>>>>>> entries" but
>>>>>>>>>>> there are cases where we "process an entry but not zap it".
>>>>>>>>>>>
>>>>>>>>>>> What you really only want to know is "was any entry not zapped",
>>>>>>>>>>> which
>>>>>>>>>>> could be a simple input boolean variable passed into
>>>>>>>>>>> do_zap_pte_range?
>>>>>>>>>>>
>>>>>>>>>>> Because as soon as any entry was processed but  no zapped, 
>>>>>>>>>>> you can
>>>>>>>>>>> immediately give up on reclaiming that table.
>>>>>>>>>>
>>>>>>>>>> Yes, we can set can_reclaim_pt to false when a !pte_none() 
>>>>>>>>>> entry is
>>>>>>>>>> found in count_pte_none().
>>>>>>>>>
>>>>>>>>> I'm not sure if well need cont_pte_none(), but I'll have to take a
>>>>>>>>> look
>>>>>>>>> at your new patch to see how this fits together with doing the
>>>>>>>>> pte_none
>>>>>>>>> detection+skipping in do_zap_pte_range().
>>>>>>>>>
>>>>>>>>> I was wondering if you cannot simply avoid the additional
>>>>>>>>> scanning and
>>>>>>>>> simply set "can_reclaim_pt" if you skip a zap.
>>>>>>>>
>>>>>>>> Maybe we can return the information whether the zap was skipped 
>>>>>>>> from
>>>>>>>> zap_present_ptes() and zap_nonpresent_ptes() through parameters
>>>>>>>> like I
>>>>>>>> did in [PATCH v1 3/7] and [PATCH v1 4/7].
>>>>>>>>
>>>>>>>> In theory, we can detect empty PTE pages in the following two ways:
>>>>>>>>
>>>>>>>> 1) If no zap is skipped, it means that all pte entries have been
>>>>>>>>         zap, and the PTE page must be empty.
>>>>>>>> 2) If all pte entries are detected to be none, then the PTE page is
>>>>>>>>         empty.
>>>>>>>>
>>>>>>>> In the error case, 1) may cause non-empty PTE pages to be reclaimed
>>>>>>>> (which is unacceptable), while the 2) will at most cause empty PTE
>>>>>>>> pages
>>>>>>>> to not be reclaimed.
>>>>>>>>
>>>>>>>> So the most reliable and efficient method may be:
>>>>>>>>
>>>>>>>> a. If there is a zap that is skipped, stop scanning and do not
>>>>>>>> reclaim
>>>>>>>>         the PTE page;
>>>>>>>> b. Otherwise, as now, detect the empty PTE page through
>>>>>>>> count_pte_none()
>>>>>>>
>>>>>>> Is there a need for count_pte_none() that I am missing?
>>>>>>
>>>>>> When any_skipped == false, at least add VM_BUG_ON() to recheck none
>>>>>> ptes.
>>>>>>
>>>>>>>
>>>>>>> Assume we have
>>>>>>>
>>>>>>> nr = do_zap_pte_range(&any_skipped)
>>>>>>>
>>>>>>>
>>>>>>> If "nr" is the number of processed entries (including 
>>>>>>> pte_none()), and
>>>>>>> "any_skipped" is set whenever we skipped to zap a !pte_none 
>>>>>>> entry, we
>>>>>>> can detect what we need, no?
>>>>>>>
>>>>>>> If any_skipped == false after the call, we now have "nr" pte_none()
>>>>>>> entries. -> We can continue trying to reclaim
>>>>>>
>>>>>> I prefer that "nr" should not include pte_none().
>>>>>>
>>>>>
>>>>> Why? do_zap_pte_range() should tell you how far to advance, nothing
>>>>> less, nothing more.
>>>>>
>>>>> Let's just keep it simple and avoid count_pte_none().
>>>>>
>>>>> I'm probably missing something important?
>>>>
>>>> As we discussed before, we should skip all consecutive none ptes,
>>>   > pte and addr are already incremented before returning.
>>>
>>> It's probably best to send the resulting patch so I can either
>>> understand why count_pte_none() is required or comment on how to get rid
>>> of it.
>>
>> Something like this:
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index bd9ebe0f4471f..e9bec3cd49d44 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1657,6 +1657,66 @@ static inline int zap_nonpresent_ptes(struct
>> mmu_gather *tlb,
>>           return nr;
>>    }
>>
>> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
>> +                                  struct vm_area_struct *vma, pte_t 
>> *pte,
>> +                                  unsigned long addr, unsigned long end,
>> +                                  struct zap_details *details, int *rss,
>> +                                  bool *force_flush, bool *force_break,
>> +                                  bool *any_skipped)
>> +{
>> +       pte_t ptent = ptep_get(pte);
>> +       int max_nr = (end - addr) / PAGE_SIZE;
> 
> I'd do here:
> 
>        int nr = 0;
> 
>> +
>> +       /* Skip all consecutive pte_none(). */
>> +       if (pte_none(ptent)) {
>> +
> 
> instead of the "int nr" here
> 
>> +               for (nr = 1; nr < max_nr; nr++) {
>> +                       ptent = ptep_get(pte + nr);
>> +                       if (!pte_none(ptent))
>> +                               break;
>> +               }
>> +               max_nr -= nr;
>> +               if (!max_nr)
>> +                       return 0;
>> +               pte += nr;
>> +               addr += nr * PAGE_SIZE;
>> +       }
>> +
>> +       if (pte_present(ptent))
>> +               return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
>> +                                       addr, details, rss, force_flush,
>> +                                       force_break, any_skipped);
> 
> and here:
> 
> if (pte_present(ptent))
>      nr += zap_present_ptes(...)
> else
>      nr += zap_nonpresent_ptes();
> return nr;
> 
> So you really return the number of processed items -- how much the 
> caller should advance.

Got it, please ignore my previous stupid considerations. ;)

> 
>> +
>> +       return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
>> +                                  details, rss, any_skipped);
>> +}
>> +
>> +static inline int count_pte_none(pte_t *pte, int nr)
>> +{
>> +       int none_nr = 0;
>> +
>> +       /*
>> +        * If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be
>> +        * re-installed, so we need to check pte_none() one by one.
>> +        * Otherwise, checking a single PTE in a batch is sufficient.
>> +        */
>> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
>> +       for (;;) {
>> +               if (pte_none(ptep_get(pte)))
>> +                       none_nr++;
>> +               if (--nr == 0)
>> +                       break;
>> +               pte++;
>> +       }
>> +#else
>> +       if (pte_none(ptep_get(pte)))
>> +               none_nr = nr;
>> +#endif
>> +       return none_nr;
>> +}
>> +
>> +
>>    static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                                   struct vm_area_struct *vma, pmd_t *pmd,
>>                                   unsigned long addr, unsigned long end,
>> @@ -1667,6 +1727,7 @@ static unsigned long zap_pte_range(struct
>> mmu_gather *tlb,
>>           int rss[NR_MM_COUNTERS];
>>           spinlock_t *ptl;
>>           pte_t *start_pte;
>> +       bool can_reclaim_pt;
>>           pte_t *pte;
>>           int nr;
>>
>> @@ -1679,28 +1740,22 @@ static unsigned long zap_pte_range(struct
>> mmu_gather *tlb,
>>           flush_tlb_batched_pending(mm);
>>           arch_enter_lazy_mmu_mode();
>>           do {
>> -               pte_t ptent = ptep_get(pte);
>> -               int max_nr;
>> -
>> -               nr = 1;
>> -               if (pte_none(ptent))
>> -                       continue;
>> +               bool any_skipped;
>>
>>                   if (need_resched())
>>                           break;
>>
>> -               max_nr = (end - addr) / PAGE_SIZE;
>> -               if (pte_present(ptent)) {
>> -                       nr = zap_present_ptes(tlb, vma, pte, ptent, 
>> max_nr,
>> -                                             addr, details, rss,
>> &force_flush,
>> -                                             &force_break);
>> -                       if (unlikely(force_break)) {
>> -                               addr += nr * PAGE_SIZE;
>> -                               break;
>> -                       }
>> -               } else {
>> -                       nr = zap_nonpresent_ptes(tlb, vma, pte, ptent,
>> max_nr,
>> -                                                addr, details, rss);
>> +               nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>> +                                     rss, &force_flush, &force_break,
>> +                                     &any_skipped);
>> +               if (can_reclaim_pt) {
>> +                       VM_BUG_ON(!any_skipped && count_pte_none(pte,
>> nr) == nr);
> 
> Okay, so this is really only for debugging then? So we can safely drop 
> that for now.
> 
> I assume it would make sense to check when reclaiming a page table with 
> CONFIG_DEBUG_VM, that the table is actually all-pte_none instead?

Ah, make sense. Will change to it in the next version.

> 
> (as a side note: no VM_BUG_ON, please :) )

Got it.

Thanks!

> 

