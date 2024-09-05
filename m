Return-Path: <linux-kernel+bounces-316434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2096CF8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE611F25BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79118D64C;
	Thu,  5 Sep 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AoY7GNRq"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA653612D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518515; cv=none; b=b1QBDdP6aje/doFf2JP9t2872TidDOOksONszCiSwLYtJeitpIKDkxIWPB8v/qSBJShP7NDlAG1Q33Z1Q00XWBGYSnhtMqBLPoo1NHhnwZW7ONb+OZQnXbbHZ0noYadcKBQCs3RN6JUDCG9hbv6v3hNPn1DQvJ8pka4/y5er5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518515; c=relaxed/simple;
	bh=lG7n72LVe0AL4lEfxJYgPmV2DYOoI4Yma3rYRIkIClk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxOgB1V/ZSwevB09zIHI3An+uR8Wc9RzOO6KUpWscWE3PGg+ljXJqunCpDlGBPD/4PU40eo5MQ0bRYVL8hfoIm11EZJHF5ARH/6Pqkwyyn2PIhtBViqdCqMOoCK+mKxRgSmQigCYNe/wZSKh6GgoqjJf5sY1GtIE9w85kXn7ci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AoY7GNRq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2021c08b95cso12738725ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725518513; x=1726123313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WamOeSbvE69odMjKoDapuHUBM0CdYmc1m7bY1qxzMEU=;
        b=AoY7GNRqYjY/EJRToVgncMHUh3BNVhP4Gkq4uUi0BeI/OeXdVWTsUSX7dry39LuKXW
         c//t+gI++Sx/3YR9E2VdRYT99hNiu2rRfCrLa2BGSfU819vLJobykjE06yrl4i9ldNXA
         1mgcxhJ80HjUwOCisNjT8JirzlEg7XdeQONQCAqdvFkyou3xvChfShY5XT8phHPdChfd
         wLDWJf+q5dX8TP2k+rll0NiMEVbrZkqmu792OLJcGKYiGOAgpcdckRfKCi1J9Ws6Hk+T
         xXBnOvCVUR1Cuvaaj6zD8RfUt4SjMkJ5TgQAwrtn1Fd+JQYc+gDv5Uo3Nz0y38qgPXJR
         /5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725518513; x=1726123313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WamOeSbvE69odMjKoDapuHUBM0CdYmc1m7bY1qxzMEU=;
        b=g5n1/AQF+A6NfnOjrglQdJ/3n7HPGyyr3q6CvQCU9clBBMoN9Y1djEIMbTC9qxicLF
         6Za/yWJU9KZJTzlR3Q9TUmtzHOeE4lU8hwGwW7n1MO1Lzy0Bd7GywSLYM2qYNzD4Evet
         TE46QJT6WFydRPZrLxvcS9zO62qgS5jeoMvX64VjC5NlFKwkDzIVKA3cZhDb53s0XVLC
         p5nRNwpxm75ar0Ma4Ddb1WMx9HHRFqrQJ3aHKodo93NGHxdwmfMDgaX1L5FyiEL4hpr8
         ytncRG4SwECHeBPqWNtn2dWYTYd1W91oTFMq94CzrWQKaynHWwwlG0UhT3eP3dLNJ74A
         ErNw==
X-Forwarded-Encrypted: i=1; AJvYcCVNtukvc+OyZp5v82QdO1Q8nV0Zah+EGpnYOg61ZhUEyy6DDRnrcWV0wm+NVT4U6JeI9BKzrTGwRrRQrHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWFOLW7HOKUAUeLuzbfj+VMhWzDS9uvruqH6qs8pV5DorsqE+
	370kb1A/crapu4IyQfubXe5vqh1zABg6qTTiR3dIYJ5WmVOg/iWsecMGW9W0x8U=
X-Google-Smtp-Source: AGHT+IHktKrTh8PvuJAL8kCtov7hkYGbJWjTkWNvKOOeXCvnLHj3NgWJCdo2tCrZ/l2NqbI1yVxHFQ==
X-Received: by 2002:a17:903:41ca:b0:205:9112:6c2d with SMTP id d9443c01a7336-206b7d0021cmr84941475ad.5.1725518512930;
        Wed, 04 Sep 2024 23:41:52 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea37cc2sm22663425ad.160.2024.09.04.23.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 23:41:52 -0700 (PDT)
Message-ID: <7f22c46c-2119-4de6-9d58-efcab05b5751@bytedance.com>
Date: Thu, 5 Sep 2024 14:41:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>, Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, christophe.leroy2@cs-soprasteria.com,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <c377dab2bf55950e6155ea051aba3887ed5a2773.1724310149.git.zhengqi.arch@bytedance.com>
 <24be821f-a95f-47f1-879a-c392a79072cc@linux.dev>
 <cd137540-ae01-46a1-93d2-062bc21b827c@bytedance.com>
 <05955456-8743-448A-B7A4-BC45FABEA628@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <05955456-8743-448A-B7A4-BC45FABEA628@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/5 14:32, Muchun Song wrote:
> 
> 
>> On Aug 30, 2024, at 14:54, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>
>>
>> On 2024/8/29 16:10, Muchun Song wrote:
>>> On 2024/8/22 15:13, Qi Zheng wrote:
>>>> In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
>>>> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
>>>> this time, the write lock of mmap_lock is not held, and the pte_same()
>>>> check is not performed after the PTL held. So we should get pgt_pmd and do
>>>> pmd_same() check after the ptl held.
>>>>
>>>> For the case where the ptl is released first and then the pml is acquired,
>>>> the PTE page may have been freed, so we must do pmd_same() check before
>>>> reacquiring the ptl.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>   mm/khugepaged.c | 16 +++++++++++++++-
>>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 53bfa7f4b7f82..15d3f7f3c65f2 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1604,7 +1604,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>       if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>>>>           pml = pmd_lock(mm, pmd);
>>>> -    start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>>>> +    start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
>>>>       if (!start_pte)        /* mmap_lock + page lock should prevent this */
>>>>           goto abort;
>>>>       if (!pml)
>>>> @@ -1612,6 +1612,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>       else if (ptl != pml)
>>>>           spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
>>>> +        goto abort;
>>>> +
>>>>       /* step 2: clear page table and adjust rmap */
>>>>       for (i = 0, addr = haddr, pte = start_pte;
>>>>            i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>>>> @@ -1657,6 +1660,16 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>       /* step 4: remove empty page table */
>>>>       if (!pml) {
>>>>           pml = pmd_lock(mm, pmd);
>>>> +        /*
>>>> +         * We called pte_unmap() and release the ptl before acquiring
>>>> +         * the pml, which means we left the RCU critical section, so the
>>>> +         * PTE page may have been freed, so we must do pmd_same() check
>>>> +         * before reacquiring the ptl.
>>>> +         */
>>>> +        if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
>>>> +            spin_unlock(pml);
>>>> +            goto pmd_change;
>>> Seems we forget to flush TLB since we've cleared some pte entry?
>>
>> See comment above the ptep_clear():
>>
>> /*
>> * Must clear entry, or a racing truncate may re-remove it.
>> * TLB flush can be left until pmdp_collapse_flush() does it.
>> * PTE dirty? Shmem page is already dirty; file is read-only.
>> */
>>
>> The TLB flush was handed over to pmdp_collapse_flush(). If a
> 
> But you skipped pmdp_collapse_flush().

I skip it only in !pmd_same() case, at which time it must be cleared
by other thread, which will be responsible for flushing TLB:

CPU 0				CPU 1
				pmd_clear
				spin_unlock
				flushing tlb
spin_lock
if (!pmd_same)	
	goto pmd_change;
pmdp_collapse_flush

Did I miss something?

> 
>> concurrent thread free the PTE page at this time, the TLB will
>> also be flushed after pmd_clear().
>>
>>>> +        }
>>>>           if (ptl != pml)
>>>>               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>>       }
>>>> @@ -1688,6 +1701,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>           pte_unmap_unlock(start_pte, ptl);
>>>>       if (pml && pml != ptl)
>>>>           spin_unlock(pml);
>>>> +pmd_change:
>>>>       if (notified)
>>>>           mmu_notifier_invalidate_range_end(&range);
>>>>   drop_folio:
> 

