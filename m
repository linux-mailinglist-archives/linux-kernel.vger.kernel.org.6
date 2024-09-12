Return-Path: <linux-kernel+bounces-326253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D616F976589
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005B51C22CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181719C562;
	Thu, 12 Sep 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YI6Vk+Ed"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123819341C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133332; cv=none; b=os7ohvqYGWSwzwCw5I1YMeQcnQzdWraPo0A5/lBQPOXrrDIzWK5L9R4TkBDaENYxkYDLpix+VkcgrSlLSFQGAme/E8GF6RllWJSdvDU/6PFl6ml/mW6/AqF25oE0xD3vL/bvtTwUMTq4CD7f8cvv6NbC/yMods9WOvy9ZpkKuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133332; c=relaxed/simple;
	bh=sGyIRHAypyAUl6UvKA4XVq0w6dwejBVYI8RBbJI9u30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEFIh/OyNbQau6/KBcXzDzbfXB1EeyclToNNAPTX1/O/MM+Y0t5jnvdNVoM3Hg3dTUQhlcmd/jugGg7w2quus3/plLKvZqHWw9g64xsE80SRXZuTrzRWlB0myQFevwZYf4XoLUZTH189XXZhtr0dzKNqtAiCKKpOBsj9lccyrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YI6Vk+Ed; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so502261a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726133330; x=1726738130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AT65D6caxyi8O3IqF5sxmWB5t+zqhreFVtKjeFFurB0=;
        b=YI6Vk+Ed6HJ6pLzZU9J+reczBCgBvdCkR1e1cuiPN+L2d9yUGgyhW0s9oT9tVnW3im
         mmcN1hHu5S0mrXv1uRnSP2FN2OkDqlVaK7IDcWD36CwZlgM4dIRbXyqAJyN39XW/J0w8
         lVqohr6OhmThOyAafq1PvvVV5mcfU84/CoYQ7lSFv/FD9KWJOVgWx+etLmLvLN74RXtv
         yRveLEdIujSTslqvjLKqDC1uU+2GKl69YSsB90CPSNl7p+DCLlUc14azZXGxkD1eV/CH
         +6EdJWSHuA/+1N95+jUdB0TfFlko7Ic3AC8gzcZVmRfjf4ovvCiOXsWOzvQerjoBteF2
         X/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133330; x=1726738130;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT65D6caxyi8O3IqF5sxmWB5t+zqhreFVtKjeFFurB0=;
        b=YAZngxqFVOACyT80/8QbqR6by+x5rwqEAsUoYY2mRSSHWGn75Lr4jYzcztNe4XOBVM
         61TW0y99OwXgc7IRWwViV+7Drai+umQNLhO09MPiqCLPVL53vXn74arViOwd/hQ0u312
         7NGrnbcBaFClb1fQGmQzwWG/bQ1U5b7opDyyZrJ+hu++06SlkdENpbBcrZc/z71ydaTz
         zBCddtGKWnDwj8ktS6T/XxgFbEtwSs77EyiHPRpbb5a6F3TGQfT+JsaWpeKBYboMsPAL
         uyssVnDyVU7ubrxtr1bxCVqqjHm/yuNlZCcxDaeCWblhTVgBA1Scu6CyQgsvkY7o9xiC
         SVkA==
X-Gm-Message-State: AOJu0YxTR01kdtl2dP5neilXlSQN0j6t4FR1/fR+2+j5Xc2nHVQe37hr
	N1/PukyuaqxMCwAVbexr6Ma/JbJgV2CujqNXkqPr512LHXT4ckzqeE+f77wqY2c=
X-Google-Smtp-Source: AGHT+IHMs1K6hiu4sOIMjo3eAvDnYqfsQOfMfhz6f9zTLJFmGbbptxphUXzZIvkiw21YhPx9o9GhKg==
X-Received: by 2002:a17:90a:684c:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2db9ffefa37mr2370711a91.24.1726133330037;
        Thu, 12 Sep 2024 02:28:50 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c0672sm9995203a91.22.2024.09.12.02.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 02:28:49 -0700 (PDT)
Message-ID: <da59b028-b472-4ac1-b893-2f17496fb384@bytedance.com>
Date: Thu, 12 Sep 2024 17:28:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
To: Muchun Song <muchun.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Hildenbrand <david@redhat.com>, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-2-zhengqi.arch@bytedance.com>
 <d02fe02d-a6c7-4157-bb7d-3fe235f21237@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <d02fe02d-a6c7-4157-bb7d-3fe235f21237@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Muchun,

On 2024/9/6 15:20, Muchun Song wrote:
> 
> 
> On 2024/9/4 16:40, Qi Zheng wrote:
>> Currently, the usage of pte_offset_map_nolock() can be divided into the
>> following two cases:
>>
>> 1) After acquiring PTL, only read-only operations are performed on the 
>> PTE
>>     page. In this case, the RCU lock in pte_offset_map_nolock() will 
>> ensure
>>     that the PTE page will not be freed, and there is no need to worry
>>     about whether the pmd entry is modified.
>>
>> 2) After acquiring PTL, the pte or pmd entries may be modified. At this
>>     time, we need to ensure that the pmd entry has not been modified
>>     concurrently.
>>
>> To more clearing distinguish between these two cases, this commit
>> introduces two new helper functions to replace pte_offset_map_nolock().
>> For 1), just rename it to pte_offset_map_ro_nolock(). For 2), in addition
>> to changing the name to pte_offset_map_rw_nolock(), it also outputs the
>> pmdval when successful. It is applicable for may-write cases where any
>> modification operations to the page table may happen after the
>> corresponding spinlock is held afterwards. But the users should make sure
>> the page table is stable like checking pte_same() or checking pmd_same()
>> by using the output pmdval before performing the write operations.
>>
>> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
>> will be read-only/read-write protected.
>>
>> Subsequent commits will convert pte_offset_map_nolock() into the above
>> two functions one by one, and finally completely delete it.
>>
>> Signed-off-by: Qi Zheng<zhengqi.arch@bytedance.com>
>> ---
>>   Documentation/mm/split_page_table_lock.rst |  7 +++
>>   include/linux/mm.h                         |  5 +++
>>   mm/pgtable-generic.c                       | 50 ++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
>> diff --git a/Documentation/mm/split_page_table_lock.rst 
>> b/Documentation/mm/split_page_table_lock.rst
>> index e4f6972eb6c04..08d0e706a32db 100644
>> --- a/Documentation/mm/split_page_table_lock.rst
>> +++ b/Documentation/mm/split_page_table_lock.rst
>> @@ -19,6 +19,13 @@ There are helpers to lock/unlock a table and other 
>> accessor functions:
>>    - pte_offset_map_nolock()
>>       maps PTE, returns pointer to PTE with pointer to its PTE table
>>       lock (not taken), or returns NULL if no PTE table;
>> + - pte_offset_map_ro_nolock()
>> +    maps PTE, returns pointer to PTE with pointer to its PTE table
>> +    lock (not taken), or returns NULL if no PTE table;
>> + - pte_offset_map_rw_nolock()
>> +    maps PTE, returns pointer to PTE with pointer to its PTE table
>> +    lock (not taken) and the value of its pmd entry, or returns NULL
>> +    if no PTE table;
>>    - pte_offset_map()
>>       maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
>>    - pte_unmap()
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index a7c74a840249a..1fde9242231c9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3006,6 +3006,11 @@ static inline pte_t *pte_offset_map_lock(struct 
>> mm_struct *mm, pmd_t *pmd,
>>   pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>>               unsigned long addr, spinlock_t **ptlp);
>> +pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
>> +                unsigned long addr, spinlock_t **ptlp);
>> +pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>> +                unsigned long addr, pmd_t *pmdvalp,
>> +                spinlock_t **ptlp);
>>   #define pte_unmap_unlock(pte, ptl)    do {        \
>>       spin_unlock(ptl);                \
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index a78a4adf711ac..262b7065a5a2e 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -317,6 +317,33 @@ pte_t *pte_offset_map_nolock(struct mm_struct 
>> *mm, pmd_t *pmd,
>>       return pte;
>>   }
>> +pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
>> +                unsigned long addr, spinlock_t **ptlp)
>> +{
>> +    pmd_t pmdval;
>> +    pte_t *pte;
>> +
>> +    pte = __pte_offset_map(pmd, addr, &pmdval);
>> +    if (likely(pte))
>> +        *ptlp = pte_lockptr(mm, &pmdval);
>> +    return pte;
>> +}
>> +
>> +pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>> +                unsigned long addr, pmd_t *pmdvalp,
>> +                spinlock_t **ptlp)
>> +{
>> +    pmd_t pmdval;
>> +    pte_t *pte;
>> +
>> +    VM_WARN_ON_ONCE(!pmdvalp);
>> +    pte = __pte_offset_map(pmd, addr, &pmdval);
>> +    if (likely(pte))
>> +        *ptlp = pte_lockptr(mm, &pmdval);
>> +    *pmdvalp = pmdval;
>> +    return pte;
>> +}
>> +
>>   /*
>>    * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal 
>> implementation
>>    * __pte_offset_map_lock() below, is usually called with the pmd 
>> pointer for
>> @@ -356,6 +383,29 @@ pte_t *pte_offset_map_nolock(struct mm_struct 
>> *mm, pmd_t *pmd,
>>    * recheck *pmd once the lock is taken; in practice, no callsite 
>> needs that -
>>    * either the mmap_lock for write, or pte_same() check on contents, 
>> is enough.
>>    *
>> + * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like 
>> pte_offset_map();
>> + * but when successful, it also outputs a pointer to the spinlock in 
>> ptlp - as
>> + * pte_offset_map_lock() does, but in this case without locking it.  
>> This helps
>> + * the caller to avoid a later pte_lockptr(mm, *pmd), which might by 
>> that time
>> + * act on a changed *pmd: pte_offset_map_ro_nolock() provides the 
>> correct spinlock
>> + * pointer for the page table that it returns. Even after grabbing 
>> the spinlock,
>> + * we might be looking either at a page table that is still mapped or 
>> one that
>> + * was unmapped and is about to get freed. But for R/O access this is 
>> sufficient.
>> + * So it is only applicable for read-only cases where any 
>> modification operations
>> + * to the page table are not allowed even if the corresponding 
>> spinlock is held
>> + * afterwards.
>> + *
>> + * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is 
>> like
>> + * pte_offset_map_ro_nolock(); but when successful, it also outputs 
>> the pdmval.
>> + * It is applicable for may-write cases where any modification 
>> operations to the
>> + * page table may happen after the corresponding spinlock is held 
>> afterwards.
>> + * But the users should make sure the page table is stable like 
>> checking pte_same()
>> + * or checking pmd_same() by using the output pmdval before 
>> performing the write
>> + * operations.
> 
> Now, we have two options to make sure the stability of PTE for users
> of pte_offset_map_rw_nolock(), in order to ease this operation, how
> about proposing a new helper (or two, one for pmd_same, another for
> pte_same) like pte_lock_stability (I am not good at naming, maybe
> you can) which helps users 1) hold the PTL and 2) check if the PTE is
> stable and 3) return true if the PTE stable, otherwise return false.

I've been trying to do this these days, but I found it was not very
convenient.

I introduced the following helpers:

#define __PTE_STABILITY(lock)						\
bool __pte_stability_##lock(pmd_t *pmd, pmd_t *orig_pmd, pte_t *pte,	\
			    pte_t *orig_pte, spinlock_t *ptlp)		\
{									\
	pte_spin_##lock(ptlp);						\
	if (orig_pte) {							\
		VM_WARN_ON_ONCE(pte_none(*orig_pte));			\
		return pte_same(*orig_pte, ptep_get(pte));		\
	}								\
	if (orig_pmd) {							\
		VM_WARN_ON_ONCE(pmd_none(*orig_pmd));			\
		return pmd_same(*orig_pmd, pmdp_get_lockless(pmd));	\
	}								\
	VM_WARN_ON_ONCE(1);						\
	return false;							\
}
__PTE_STABILITY(lock)
__PTE_STABILITY(lock_nested)

static inline bool pte_stability_lock(pmd_t *pmd, pmd_t *orig_pmd, pte_t 
*pte,
				      pte_t *orig_pte, spinlock_t *ptlp)
	__acquires(ptlp)
{
	return __pte_stability_lock(pmd, orig_pmd, pte, orig_pte, ptlp);
}

#ifdef CONFIG_SPLIT_PTE_PTLOCKS
static inline bool pte_stability_lock_nested(pmd_t *pmd, pmd_t *orig_pmd,
                                              pte_t *pte, pte_t *orig_pte,
                                              spinlock_t *ptlp)
         __acquires(ptlp)
{
         return __pte_stability_lock_nested(pmd, orig_pmd, pte, 
orig_pte, ptlp);
}

static inline void pte_stability_unlock_nested(spinlock_t *ptlp)
	__releases(ptlp)
{
	spin_unlock(ptlp);
}
#else
static inline bool pte_stability_lock_nested(pmd_t *pmd, pmd_t *orig_pmd,
                                              pte_t *pte, pte_t *orig_pte,
                                              spinlock_t *ptlp)
{
         return true;
}
static inline void pte_stability_unlock_nested(spinlock_t *ptlp)
{
}
#endif /* CONFIG_SPLIT_PTE_PTLOCKS */

and try to use them with pte_offset_map_rw_nolock() in the following
functions:

1. collapse_pte_mapped_thp
2. handle_pte_fault
3. map_pte
4. move_pages_pte
5. walk_pte_range

For 1, 2 and 3, the conversion is relatively simple, but 2 actually
already does a pte_same() check, so it does not reduce the amount of
code much.

For 4, the pte_same() checks have already been done, and it is not
easy to convert double_pt_lock() to use pte_stability_lock{_nested}().

For 5, it calls spin_trylock(), we should introduce another
pte_stability_trylock() helper for it, but it feels unnecessary.

There are not many places where pte_offset_map_rw_nolock() is called,
and some places have already done pte_same() checks, so maybe open
code is enough and there is no need to introduce more helper function.

Thanks,
Qi

> 
> Muchun,
> Thanks.
> 
>> + *
>> + * Note: "RO" / "RW" expresses the intended semantics, not that the 
>> *kmap* will
>> + * be read-only/read-write protected.
>> + *
>>    * Note that free_pgtables(), used after unmapping detached vmas, or 
>> when
>>    * exiting the whole mm, does not take page table lock before 
>> freeing a page
>>    * table, and may not use RCU at all: "outsiders" like khugepaged 
>> should avoid
> 

