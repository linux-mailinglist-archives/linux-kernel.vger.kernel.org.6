Return-Path: <linux-kernel+bounces-203785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D18FE076
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0930E1F25D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FBF13C83B;
	Thu,  6 Jun 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEjgNOM7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BBE13C826
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660912; cv=none; b=b70/OSjgE5ltfhwcYRMSKWNNBJxflPu52vu+iSYXatiBKVykM5DZ8ptxrW095DpG+XAIeV5VERdQFJjtKRqDRRNcxJJnrMXzKddsTr4UHcFxGig139246tM34+70iodKPuFY+XbdfFaR+o95uDVgVYUwA61ZgNb3EKS1Y95Q9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660912; c=relaxed/simple;
	bh=1FVuDaGKvdZOiE4dZVcv3MvUG0SqVVEezs072wOK99E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lARuXK0eubanDYpKmpflD9shyXT1ko8sdn+/z4LLVeOsUP+p38fSShJvTW4WFXIfNS+bIXmywMjckH11/QbvDEeGRKe6nSrGC7/v5/SeBvcaWtKq6F9ZywqUIwi4Q66M1IOUbjw4Uky+5r5DRoTsP1pkx2G+2YuGgQxUEqdc308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEjgNOM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717660909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nMExzi8c87gIOEs5fa/j9pMtxhHvpipliEdWtdRyn48=;
	b=HEjgNOM7HWFyiCEudsGaSiw+MtFUkYahOOTW2gk4jCCV/iBwGAzC4aGhvtJhDyfENqbHIn
	MmdHGnrDtRy02Isko4+EIKJA99qDaWzlfQ+NKBZ/P2MJlOvT2kvoTxIyC3Xlk3NRJRCoyK
	fTU1qUYf4+8uPrObWVFvkdxq+TMyWJA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-RIQmwBYnNvqy1JgAwKDuwA-1; Thu, 06 Jun 2024 04:01:47 -0400
X-MC-Unique: RIQmwBYnNvqy1JgAwKDuwA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b98e99f0eso421702e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660906; x=1718265706;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMExzi8c87gIOEs5fa/j9pMtxhHvpipliEdWtdRyn48=;
        b=MRdSViGc4fM7Zr3npxT3Rn5GAX8rKjNtfgjabaZaoKH/OQ+qZ0Ha1FuRe0V+2i0g33
         fG0o4i0j4VSGPj7kMFC5bBS7G90N1CYxkuq62qdgSiXP0L6QxPfmdonxs6GpnuYNbdac
         gEWInPE8CMhUd+J9HhE6unxFrK1OUjWIldaEcZQMD/1S2Z7iEX3EEWSHn8nV6knVt/X5
         wr+Wk2QvwhAvb6r24G15IKWWi5peDvIyts5d/Wv4ecPkIjT22PMBvVEyVRA9pVtF1Cf7
         nDmRp4jrGXpZcLljmwUItXhDZBF2Kz4Rf2/H2fOObgq8vT1HBpp1WxgCqCbOjFknvd20
         itDg==
X-Forwarded-Encrypted: i=1; AJvYcCXK5h3R/DohROyAeu+PwBo8IA4Vnl9THpGxpzKAgYCtvTafAOc53k/uRXP8rELqNZmdLwnNX4G8gyiEZiPav28ihMQTCDUr358P/+ni
X-Gm-Message-State: AOJu0Yzu/+F8XV/xj8Zk+u4uzUBvN4bonfr2kF0Yerv4aWegM89VEBAq
	euSFmRb9s2i0k50YdPH+E2y9IVNWljoqx2nekLX1XUCP9pGyYsH5umES2HV3wFyOD/91iP8y1ew
	2LdKccPQaRooQKllxwhNkVL2C/57mqeudksGZyBdWPoKNSSuZ0kZuFan35D4uMw==
X-Received: by 2002:a05:6512:e9f:b0:52b:51ad:13f with SMTP id 2adb3069b0e04-52bab4f3d2emr4058172e87.49.1717660905875;
        Thu, 06 Jun 2024 01:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0RetwHi8i2fTKc5G7BxQUQQUuTVGIC7UvL/5eRxyI2lb00Sfv+GuVohZvvDNH545p9evpvA==
X-Received: by 2002:a05:6512:e9f:b0:52b:51ad:13f with SMTP id 2adb3069b0e04-52bab4f3d2emr4058137e87.49.1717660905378;
        Thu, 06 Jun 2024 01:01:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc0a1csm844203f8f.90.2024.06.06.01.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:01:44 -0700 (PDT)
Message-ID: <758f7be7-c17e-46d1-879f-83340ec85749@redhat.com>
Date: Thu, 6 Jun 2024 10:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521040244.48760-1-ioworker0@gmail.com>
 <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com>
 <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com>
 <CAK1f24kKra71RSQdFOpQecU6+yMELC748irKUt54Kg64-P=4-A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24kKra71RSQdFOpQecU6+yMELC748irKUt54Kg64-P=4-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.06.24 05:55, Lance Yang wrote:
> On Wed, Jun 5, 2024 at 10:28 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.06.24 16:20, Lance Yang wrote:
>>> Hi David,
>>>
>>> On Wed, Jun 5, 2024 at 8:46 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 21.05.24 06:02, Lance Yang wrote:
>>>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
>>>>> folios, start the pagewalk first, then call split_huge_pmd_address() to
>>>>> split the folio.
>>>>>
>>>>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
>>>>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range during
>>>>> the page walk. It’s probably necessary to mlock this THP to prevent it from
>>>>> being picked up during page reclaim.
>>>>>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>> ---
>>>>
>>>> [...] again, sorry for the late review.
>>>
>>> No worries at all, thanks for taking time to review!
>>>
>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index ddffa30c79fb..08a93347f283 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>         if (flags & TTU_SYNC)
>>>>>                 pvmw.flags = PVMW_SYNC;
>>>>>
>>>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
>>>>> -             split_huge_pmd_address(vma, address, false, folio);
>>>>> -
>>>>>         /*
>>>>>          * For THP, we have to assume the worse case ie pmd for invalidation.
>>>>>          * For hugetlb, it could be much worse if we need to do pud
>>>>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>         mmu_notifier_invalidate_range_start(&range);
>>>>>
>>>>>         while (page_vma_mapped_walk(&pvmw)) {
>>>>> -             /* Unexpected PMD-mapped THP? */
>>>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>>>> -
>>>>>                 /*
>>>>>                  * If the folio is in an mlock()d vma, we must not swap it out.
>>>>>                  */
>>>>>                 if (!(flags & TTU_IGNORE_MLOCK) &&
>>>>>                     (vma->vm_flags & VM_LOCKED)) {
>>>>>                         /* Restore the mlock which got missed */
>>>>> -                     if (!folio_test_large(folio))
>>>>> +                     if (!folio_test_large(folio) ||
>>>>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>>>>>                                 mlock_vma_folio(folio, vma);
>>>>
>>>> Can you elaborate why you think this would be required? If we would have
>>>> performed the  split_huge_pmd_address() beforehand, we would still be
>>>> left with a large folio, no?
>>>
>>> Yep, there would still be a large folio, but it wouldn't be PMD-mapped.
>>>
>>> After Weifeng's series[1], the kernel supports mlock for PTE-mapped large
>>> folio, but there are a few scenarios where we don't mlock a large folio, such
>>> as when it crosses a VM_LOCKed VMA boundary.
>>>
>>>    -                     if (!folio_test_large(folio))
>>>    +                     if (!folio_test_large(folio) ||
>>>    +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>>>
>>> And this check is just future-proofing and likely unnecessary. If encountering a
>>> PMD-mapped THP missing the mlock for some reason, we can mlock this
>>> THP to prevent it from being picked up during page reclaim, since it is fully
>>> mapped and doesn't cross the VMA boundary, IIUC.
>>>
>>> What do you think?
>>> I would appreciate any suggestions regarding this check ;)
>>
>> Reading this patch only, I wonder if this change makes sense in the
>> context here.
> 
> Allow me to try explaining it again ;)
> 
>>
>> Before this patch, we would have PTE-mapped the PMD-mapped THP before
>> reaching this call and skipped it due to "!folio_test_large(folio)".
> 
> Yes, there is only a PTE-mapped THP when doing the "!folio_test_large(folio)"
> check, as we will first conditionally split the PMD via
> split_huge_pmd_address().
> 
>>
>> After this patch, we either
> 
> Things will change. We'll first do the "!folio_test_large(folio)" check, then
> conditionally split the PMD via split_huge_pmd_address().
> 
>>
>> a) PTE-remap the THP after this check, but retry and end-up here again,
>> whereby we would skip it due to "!folio_test_large(folio)".
> 
> Hmm...
> 
> IIUC, we will skip it after this check, stop the page walk, and not
> PTE-remap the THP.
> 
>>
>> b) Discard the PMD-mapped THP due to lazyfree directly. Can that
>> co-exist with mlock and what would be the problem here with mlock?
> 
> Before discarding a PMD-mapped THP as a whole, as patch #3 did,
> we also perform the "!folio_test_large(folio)" check. If the THP coexists
> with mlock, we will skip it, stop the page walk, and not discard it. IIUC.

But "!folio_test_large(folio)" would *skip* the THP and not consider it 
regarding mlock.

I'm probably missing something and should try current mm/mm-unstable 
with MADV_FREE + mlock() on a PMD-mapped THP.

> 
>>
>>
>> So if the check is required in this patch, we really have to understand
>> why. If not, we should better drop it from this patch.
> 
> I added the "!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD))" check
> in this patch just to future-proof mlock for a PMD-mapped THP missing
> the mlock, to prevent it from being picked up during page reclaim.
> 
> But is this really required? It seems like nothing should really be broken
> without this check.
> 
> Perhaps, we should drop it from this patch until we fully understand the
> reason for it. Could you get me some suggestions?

We should drop it from this patch, agreed. We might need it 
("!pvmw.pte") in patch #3, but I still have to understand if there 
really would be a problem.

-- 
Cheers,

David / dhildenb


