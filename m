Return-Path: <linux-kernel+bounces-401201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740889C1720
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75EAB232F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419EA1D2F54;
	Fri,  8 Nov 2024 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FjlgQJ+S"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4F1E0DE2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051533; cv=none; b=ZjN64oFrWFgAwyg18QriXDZiUoFCXzC1Xw3joQx5VCWQab2hwqu4uSzkKvCRcnZxx2XwryvSatd8LrwHtEK7Fvso/i/fMpyegSwSWncE7SIW9A+NmZsm8bdMWzutoY3lttLTcSKJ2LoVkQXikGz7drVmUyAa/EDXRprSgO77QTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051533; c=relaxed/simple;
	bh=fhiV2B/i42rcXx0gV5deWy6qvjlJvMGk4HDwmFyljno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptafVcQQuOVWFQeqwlAGf83lBaKanO14vV3J0Ahuhqw2b77VzEoZg5o6X3aZruhi4kEpCDmeE3IraB+UYgOrkCDX9wdRD4v1FqfQwVrLffOfFMn5JbdpvHbcjaFrwOu9Hr8ivlmW9EUA5oOPnlpjBSiEsNLKLWwFUrL7gGVqNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FjlgQJ+S; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723f37dd76cso1847166b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731051530; x=1731656330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mu6NYk5h6l9e4x73wJ0Oq7+ktjt603TFHhfxu3JPm2w=;
        b=FjlgQJ+SVG/P3l9LC1HBamWmbTWRnYN0nBURZwkbjBGk/j8bQ7vC8Aka3XYJlRsifl
         QbveSmc0FOis4f3AZUSsocUwogEVYhV4yQzbV/Kj0DSyAIqP8Oy14hTgX5ffLWHV28gS
         t7GuC6kGDM5cZkSmqgDHp7Bs46mjR7hyyHh8xhoaeP1YIKvwLTBnzwBcucCGCGrB5P1G
         1/9MoernE8bgmNCC9SkwsJuv+WR8BdcOV87uExuEcgX5A78Kyllua93Wt6923WCDWVNd
         Vc/6RUxn9LxahSrV5hi2HfQE3EV4AOGlkXEW9b/LGE1Rdk7w4PLkXiAjRJTXay9WEMom
         +b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731051530; x=1731656330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mu6NYk5h6l9e4x73wJ0Oq7+ktjt603TFHhfxu3JPm2w=;
        b=UYP9pkdijMi2yeFEivf32IDMQCoYRz00pUUhgJ5P0Ykjo8BAUviZXxH9pw0q8AWFNv
         pr0hQ4i4E/KMiwdEgk2XWfHzHj5iBJNXrnv9CDItTQ/XuMWuDA5hrD4QYl9IQdWiTUjN
         AykIFU3abQv3Xk6Qke81CtMz5jmvc5U14MRHKqcEUOWchnb3Fd4pATq76uVqIwto6+J5
         R2QTrZtQu/othhVXnt+oW/msmwR36PegxCccpPwJag97I4E/xiz+oz4fafBedznIECPO
         W1t49v5HMGLoXyFB+8D9VqrifXCoe+WviB+BDK2ZKAITS5WE6VTG1JpmaCH8H6IsW4MG
         hRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6lQsIi4dheG3DnBY/1VCaLOD8VcuWtQhS4QZYs4PUEI+I38e38g0ynczicF/6mttkKpcaSy59A+Hb7yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ljghn1meJQog4YXF7rK1HUmRcQ+fx4CY0/5L2g9lPFa+fqZP
	sNAVbiE9LtXszC4RrZ33VTzQOU/MDjW6AnE/VVbkjrLdzgvLRqWGnkyJUbxqWo0=
X-Google-Smtp-Source: AGHT+IEMuiK4oRALWDBrVch+hPLKui8J9k1Rw8yVjg/V/fJA5pCZyDIryCWFFbqE8aW1H8eSGsevHw==
X-Received: by 2002:a05:6a20:72ab:b0:1db:d8fe:9d4 with SMTP id adf61e73a8af0-1dc229a6b5dmr2373750637.16.1731051530278;
        Thu, 07 Nov 2024 23:38:50 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c50sm3077427b3a.60.2024.11.07.23.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 23:38:49 -0800 (PST)
Message-ID: <e308363a-0c1e-421f-a35e-5bb750992554@bytedance.com>
Date: Fri, 8 Nov 2024 15:38:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] x86: mm: free page table pages by RCU instead of
 semi RCU
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0XhKnr3uVODu+iihRi4XwLupy=YX8BHa==1Y-ZvrmKjg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez0XhKnr3uVODu+iihRi4XwLupy=YX8BHa==1Y-ZvrmKjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jann,

On 2024/11/8 06:39, Jann Horn wrote:
> +x86 MM maintainers - x86@kernel.org was already cc'ed, but I don't
> know if that is enough for them to see it, and I haven't seen them
> comment on this series yet; I think you need an ack from them for this
> change.

Yes, thanks to Jann for cc-ing x86 MM maintainers, and look forward to
their feedback!

> 
> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, the page table pages
>> will be freed by semi RCU, that is:
>>
>>   - batch table freeing: asynchronous free by RCU
>>   - single table freeing: IPI + synchronous free
>>
>> In this way, the page table can be lockless traversed by disabling IRQ in
>> paths such as fast GUP. But this is not enough to free the empty PTE page
>> table pages in paths other that munmap and exit_mmap path, because IPI
>> cannot be synchronized with rcu_read_lock() in pte_offset_map{_lock}().
>>
>> In preparation for supporting empty PTE page table pages reclaimation,
>> let single table also be freed by RCU like batch table freeing. Then we
>> can also use pte_offset_map() etc to prevent PTE page from being freed.
> 
> I applied your series locally and followed the page table freeing path
> that the reclaim feature would use on x86-64. Looks like it goes like
> this with the series applied:

Yes.

> 
> free_pte
>    pte_free_tlb
>      __pte_free_tlb
>        ___pte_free_tlb
>          paravirt_tlb_remove_table
>            tlb_remove_table [!CONFIG_PARAVIRT, Xen PV, Hyper-V, KVM]
>              [no-free-memory slowpath:]
>                tlb_table_invalidate
>                tlb_remove_table_one
>                  tlb_remove_table_sync_one [does IPI for GUP-fast]

		   ^
		   It seems that this step can be ommitted when
		   CONFIG_PT_RECLAIM is enabled, because GUP-fast will
		   disable IRQ, which can also serve as the RCU critical
		   section.

>                  __tlb_remove_table_one [frees via RCU]
>              [fastpath:]
>                tlb_table_flush
>                  tlb_remove_table_free [frees via RCU]
>            native_tlb_remove_table [CONFIG_PARAVIRT on native]
>              tlb_remove_table [see above]
> 
> Basically, the only remaining case in which
> paravirt_tlb_remove_table() does not use tlb_remove_table() with RCU
> delay is !CONFIG_PARAVIRT && !CONFIG_PT_RECLAIM. Given that
> CONFIG_PT_RECLAIM is defined as "default y" when supported, I guess
> that means X86's direct page table freeing path will almost never be
> used? If it stays that way and the X86 folks don't see a performance
> impact from using RCU to free tables on munmap() / process exit, I
> guess we might want to get rid of the direct page table freeing path
> on x86 at some point to simplify things...

In theory, using RCU to asynchronously free PTE pages should make
munmap() / process exit path faster. I can try to grab some data.

> 
> (That simplification might also help prepare for Intel Remote Action
> Request, if that is a thing people want...)

If so, even better!

> 
>> Like pte_free_defer(), we can also safely use ptdesc->pt_rcu_head to free
>> the page table pages:
>>
>>   - The pt_rcu_head is unioned with pt_list and pmd_huge_pte.
>>
>>   - For pt_list, it is used to manage the PGD page in x86. Fortunately
>>     tlb_remove_table() will not be used for free PGD pages, so it is safe
>>     to use pt_rcu_head.
>>
>>   - For pmd_huge_pte, we will do zap_deposited_table() before freeing the
>>     PMD page, so it is also safe.
> 
> Please also update the comments on "struct ptdesc" accordingly.

OK, will do.

> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/x86/include/asm/tlb.h | 19 +++++++++++++++++++
>>   arch/x86/kernel/paravirt.c |  7 +++++++
>>   arch/x86/mm/pgtable.c      | 10 +++++++++-
>>   mm/mmu_gather.c            |  9 ++++++++-
>>   4 files changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>> index 580636cdc257b..e223b53a8b190 100644
>> --- a/arch/x86/include/asm/tlb.h
>> +++ b/arch/x86/include/asm/tlb.h
>> @@ -34,4 +34,23 @@ static inline void __tlb_remove_table(void *table)
>>          free_page_and_swap_cache(table);
>>   }
>>
>> +#ifdef CONFIG_PT_RECLAIM
>> +static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
>> +{
>> +       struct page *page;
>> +
>> +       page = container_of(head, struct page, rcu_head);
>> +       free_page_and_swap_cache(page);
>> +}
> 
> Why free_page_and_swap_cache()? Page tables shouldn't have swap cache,
> so I think something like put_page() would do the job.

Ah, I just did the same thing as __tlb_remove_table(). But I also
have the same doubt as you, why does __tlb_remove_table() need to
call free_page_and_swap_cache() instead of put_page().

Thanks,
Qi

> 
>> +static inline void __tlb_remove_table_one(void *table)
>> +{
>> +       struct page *page;
>> +
>> +       page = table;
>> +       call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
>> +}
>> +#define __tlb_remove_table_one __tlb_remove_table_one
>> +#endif /* CONFIG_PT_RECLAIM */
>> +
>>   #endif /* _ASM_X86_TLB_H */
>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>> index fec3815335558..89688921ea62e 100644
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -59,10 +59,17 @@ void __init native_pv_lock_init(void)
>>                  static_branch_enable(&virt_spin_lock_key);
>>   }
>>
>> +#ifndef CONFIG_PT_RECLAIM
>>   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
>>   {
>>          tlb_remove_page(tlb, table);
>>   }
>> +#else
>> +static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
>> +{
>> +       tlb_remove_table(tlb, table);
>> +}
>> +#endif
>>
>>   struct static_key paravirt_steal_enabled;
>>   struct static_key paravirt_steal_rq_enabled;
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 5745a354a241c..69a357b15974a 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -19,12 +19,20 @@ EXPORT_SYMBOL(physical_mask);
>>   #endif
>>
>>   #ifndef CONFIG_PARAVIRT
>> +#ifndef CONFIG_PT_RECLAIM
>>   static inline
>>   void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
>>   {
>>          tlb_remove_page(tlb, table);
>>   }
>> -#endif
>> +#else
>> +static inline
>> +void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
>> +{
>> +       tlb_remove_table(tlb, table);
>> +}
>> +#endif /* !CONFIG_PT_RECLAIM */
>> +#endif /* !CONFIG_PARAVIRT */
>>
>>   gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
>>
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 99b3e9408aa0f..d948479ca09e6 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -311,10 +311,17 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
>>          }
>>   }
>>
>> +#ifndef __tlb_remove_table_one
>> +static inline void __tlb_remove_table_one(void *table)
>> +{
>> +       __tlb_remove_table(table);
>> +}
>> +#endif
>> +
>>   static void tlb_remove_table_one(void *table)
>>   {
>>          tlb_remove_table_sync_one();
>> -       __tlb_remove_table(table);
>> +       __tlb_remove_table_one(table);
>>   }
>>
>>   static void tlb_table_flush(struct mmu_gather *tlb)
>> --
>> 2.20.1
>>

