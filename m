Return-Path: <linux-kernel+bounces-336821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDC798414B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6164284745
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AACC153801;
	Tue, 24 Sep 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jHzsXQye"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920815250F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168364; cv=none; b=iUhsjWOyW06g2x4bubTJ3cX7Ia39JTuGTQJpawMAqFSCuddmhgJ4gDCLXtqrlvWj8SR3OtSopu7RnR1niz6RXTnNCgUEi5kTZtrVSjGIsRGRUMkC9Q6RfzmYMo3ejl7vWrZSvZC+58zNZzQpDvAOlx5wJ/ecLYhvsUYGDDGHXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168364; c=relaxed/simple;
	bh=li0CwluXT8CCHkf7xG7TYilQic/Q0wTwG0wbRKTzNHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXRzfNejJy2FZJnXOpjVahYEoXrYRkPl5foc6ltuCffD7kvmS8FKceCVLiRw8VvSwpTZdSXN+3KcJ1J+1VuvgR6z3ejWRtdNEJOIJs7wxDWNDnTP6xw2JjTdC8oxbPYR/cVrtcuM65TJdIKH29V4kZrEeipcEo8ARW5FikB5ZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jHzsXQye; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db233cef22so4202444a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727168362; x=1727773162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSXX1w262DUfqPKLFb36PgSphjvIhfOKOam/+YmTh4c=;
        b=jHzsXQyedvP/B52xbCU7oxmI0vX3Pcq7MtfwMGdpmMj1L7y5cxVOFc4Wggm6RRkbyB
         dUBHZebTjEFcW5y8VOA1SVh85gCYUUWfQ/Y2oiBC6OSEWxQfJCzidmgrsCVkAngqJH0y
         x3L0wloxyaYux4Pm7yLYpDHm18enyAH3WYqe41q4gsEOkYzj5fi6Q9+pm6qvPjAv8jN9
         LuSJrIpB18fdk6cBwQEMpfkiWplG3u5+ASJitmzWF3GR3RIns3gCH7ICBTz302xZBWob
         ZnHvDKeyYZL1amfUkyEjpbi3a2hWP040/cwKLpsbKPytqw2rhrOJP9sCjJIB7PAdS8yE
         kItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168362; x=1727773162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSXX1w262DUfqPKLFb36PgSphjvIhfOKOam/+YmTh4c=;
        b=sBWoLTBVceTMr28pTIoE0WFBbSWVfXgUez4sb5WuufsL/Mied/ClHYQCYcJRRPQOzE
         9IeOOXPXUNezW/cPE/fy9z4ocGsbxe7dvfZH6WLu/Pm1r6qTyZw5Vz5rQ3ozlc42vYdt
         CtVPjv3oU0XAgUj5Eo3WGSY17GUEXqBp9keEoYMFbBk36cxxzv3DysUEhlBTTvCZBj9Y
         JJWaWWAq+gYg1jBedG3+3fAJF80HyXZvqkXETY0NQB8+FWWXvp+tYPJBR3TIcTPy9syA
         RSxc2/xM3mdUwE+4p8xjqrEOR+rV5jIt6ftCpLeZm+vjhliTdc1P+PKU8goecgyOOFaD
         rnuA==
X-Forwarded-Encrypted: i=1; AJvYcCWkXr7nA6xgWo4F9wNhok1rZhmERbnI3A7YMasOYylBK715yLNImGsASC6pZG+qUXRwy+76l2BTsKp042k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ADAfHhwdxMJkBMA4HN9tFWcF0LAItf6OrJCtO12jNIVYm4DD
	P2YmT8XwvWXOcFbYnW3pjYEmdSwjmd2+6F6pjYLxZ0vf9PqWVCKKy5IVvAqV1rY=
X-Google-Smtp-Source: AGHT+IE1grLlneC8F5bJqbHdrkAu/J8WVd5DCX3PtLGmQq2Cc85O00adu9GjKeXTn1BT6ShPfval7Q==
X-Received: by 2002:a17:90a:1f84:b0:2d8:8695:353 with SMTP id 98e67ed59e1d1-2dd7f75890amr15792593a91.41.1727168361821;
        Tue, 24 Sep 2024 01:59:21 -0700 (PDT)
Received: from [10.68.125.128] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058ee3cd8sm1007596a91.2.2024.09.24.01.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:59:21 -0700 (PDT)
Message-ID: <e9b08c12-8212-412f-9dbe-261b06367f6e@bytedance.com>
Date: Tue, 24 Sep 2024 16:57:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <07d975c50fe09c246e087303b39998430b1a66bd.1727148662.git.zhengqi.arch@bytedance.com>
 <79699B24-0D99-4051-91F3-5695D32D62AC@linux.dev>
 <2343da2e-f91f-4861-bb22-28f77db98c52@bytedance.com>
 <1D1872F1-7280-4F43-8213-A720C56B0646@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1D1872F1-7280-4F43-8213-A720C56B0646@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/24 16:52, Muchun Song wrote:
> 
> 
>> On Sep 24, 2024, at 15:29, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>
>>
>> On 2024/9/24 15:14, Muchun Song wrote:
>>>> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>> ﻿In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
>>>> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
>>>> this time, the pte_same() check is not performed after the PTL held. So we
>>>> should get pgt_pmd and do pmd_same() check after the ptl held.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>> mm/khugepaged.c | 14 +++++++++++---
>>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 6498721d4783a..8ab79c13d077f 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1605,7 +1605,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>     if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>>>>         pml = pmd_lock(mm, pmd);
>>>>
>>>> -    start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>>>> +    start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
>>>>     if (!start_pte)        /* mmap_lock + page lock should prevent this */
>>>>         goto abort;
>>>>     if (!pml)
>>>> @@ -1613,6 +1613,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>     else if (ptl != pml)
>>>>         spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>>
>>>> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
>>>> +        goto abort;
>>>> +
>>>>     /* step 2: clear page table and adjust rmap */
>>>>     for (i = 0, addr = haddr, pte = start_pte;
>>>>          i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>>>> @@ -1645,7 +1648,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>         nr_ptes++;
>>>>     }
>>>>
>>>> -    pte_unmap(start_pte);
>>>>     if (!pml)
>>>>         spin_unlock(ptl);
>>>>
>>>> @@ -1658,13 +1660,19 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>     /* step 4: remove empty page table */
>>>>     if (!pml) {
>>>>         pml = pmd_lock(mm, pmd);
>>>> -        if (ptl != pml)
>>>> +        if (ptl != pml) {
>>>>             spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>> +            if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
>>>> +                spin_unlock(pml);
>>>> +                goto abort;
>>> Drop the reference of folio and the mm counter twice at the label of abort and the step 3.
>>
>> My bad, should set nr_ptes to 0 and call flush_tlb_mm() here, right?
> 
> Or add a new label "out" just below the "abort". Then go to out.

For this way, we also need to call flush_tlb_mm() first, like the
following:

if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
	spin_unlock(pml);
	flush_tlb_mm(mm);
	goto out;
}

> 
>>
>>>> +            }
>>>> +        }
>>>>     }
>>>>     pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
>>>>     pmdp_get_lockless_sync();
>>>>     if (ptl != pml)
>>>>         spin_unlock(ptl);
>>>> +    pte_unmap(start_pte);
>>>>     spin_unlock(pml);
>>> Why not?
>>> pte_unmap_unlock(start_pte, ptl);
>>> if (pml != ptl)
>>>          spin_unlock(pml);
>>
>> Both are fine, will do.
>>
>> Thanks,
>> Qi
>>
>>>>
>>>>     mmu_notifier_invalidate_range_end(&range);
>>>> --
>>>> 2.20.1
> 
> 

