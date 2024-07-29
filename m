Return-Path: <linux-kernel+bounces-265293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6F93EF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84896282FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5412D747;
	Mon, 29 Jul 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c00erIRm"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40B1EB2C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239825; cv=none; b=AbYThKkCUIxOSYJKXl5hJqWh7qPK+O5BvCGR4xS1pop89G8NdI05sCNwwzgGtMFwCog4oXgVSkWOfe42cU8jHijaFmKw+6tutipl5wCXA6p7Qk/JxXlEYdIh/r6IxKuGoh0hL68hHc7VNPu/86osDmeJ3TE4SsEHIG//Yo/+sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239825; c=relaxed/simple;
	bh=jo4bZZ+pdhW8omGTp1z972/lrX6miG0aoGZUN1fYhfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWXax+gFJA+bEdhvpQPsT86T6eXyK5df0cVCkMJ8V4nzyloTZYbynfSEKQ0nzkTEmgoKlIVdkFocJO78hTvyITVPmqbWGT7ArEBWfXOwVmAVxo+D4DDGib9Z13o6+j4EHwUk2R6EVnqv6CJa8IbBfqzLv1jH12oF0v0fGvkL31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c00erIRm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-76b3c938153so210493a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722239822; x=1722844622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3wfki45IHznha7QobB3MdtHXTqchjTEez4Ly6yQ4WE=;
        b=c00erIRmzCACqEcQ3CXuHeWhzAk6sIVMeuv9tpwB/9dP/LWkt0bLdWA5gGj9FRlFOG
         SNWBTUzyHBsHZODiEubP4/BPcf+dXQb0KfWAUsOBVA1J/gpfxFc8pdlruqS68bMPl410
         y5TP+O6DB8vXK/faQc0fpPmJuovQKToilNzbDxcXJbMhgaymcUkB6o9g2u7l/f1yK3u1
         B+uC3urL1egBRbAEKcXaQiw5a+Gh/PvjUVCTGgKktyXQZUKlvbK2Gxp7UeMq9XXEyRWF
         PmzDD/24FuckGuUwKmnTbmNAmoXPPa3I9TecUJ9tDDeb3/uqVss0CtBxGLMnxVh65G+l
         4pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239822; x=1722844622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3wfki45IHznha7QobB3MdtHXTqchjTEez4Ly6yQ4WE=;
        b=AkGz3VaQNrAg/6Ta55rtAlt/tUB29jpcIk6MFqOPGy0FdTm7er52y4WKx1R68MWD/N
         PP9aZdyR6yf7kBf8EVPb6F72Cg43d0X0Vn/4aGNGQ0drJrUqWRKlJqTg0XNJX5qboOv/
         dzi78PwBd/mEuPxNB1YWuDDn86jGVPGRLvn03X30DEHH91/Lx5qRcdBnecYc4a+TOgcJ
         p0W7c4TSX8wk89oEadUa4b1UosFjPqojxV8sbGyFuDSfhNTxRkRTzzXG2aEYpCRWq5Pe
         nr49hJEL5oBi9Ran/yP3GvuHYmdkyO/db8XGi0hlfLIMPFir7RQLpKdJ7Q3L3Ovw4/9e
         MWeg==
X-Gm-Message-State: AOJu0Yz0Z5iqBKXM7WA2Djion6511J+i+V32Ryc7gb0EmXIVfKxU+gG8
	6JVEYAfC5jTY0N5PBNpvF0Ui5PrME3ugl9OvVRWuTDnUUQxrA8R73HJt3On2RYs=
X-Google-Smtp-Source: AGHT+IGe0lJSXq0Vh5OHsO4Tqomt8qIJFlqbE1F0RWa3l62BQCbxWuuvCVwPlATb9n6C8GSnyp3sLQ==
X-Received: by 2002:a05:6a00:6f4f:b0:70d:25f1:c086 with SMTP id d2e1a72fcca58-70eac7f5ff3mr8578118b3a.0.1722239821921;
        Mon, 29 Jul 2024 00:57:01 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72b7easm6309789b3a.89.2024.07.29.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 00:57:01 -0700 (PDT)
Message-ID: <fe50cde6-dc9f-49b0-9a9a-0d07fb643617@bytedance.com>
Date: Mon, 29 Jul 2024 15:56:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm: turn USE_SPLIT_PTE_PTLOCKS /
 USE_SPLIT_PTE_PTLOCKS into Kconfig options
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Russell King <linux@armlinux.org.uk>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Juergen Gross
 <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20240726150728.3159964-1-david@redhat.com>
 <20240726150728.3159964-2-david@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240726150728.3159964-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/26 23:07, David Hildenbrand wrote:
> Let's clean that up a bit and prepare for depending on
> CONFIG_SPLIT_PMD_PTLOCKS in other Kconfig options.
> 
> More cleanups would be reasonable (like the arch-specific "depends on"
> for CONFIG_SPLIT_PTE_PTLOCKS), but we'll leave that for another day.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/arm/mm/fault-armv.c      |  6 +++---
>   arch/x86/xen/mmu_pv.c         |  7 ++++---
>   include/linux/mm.h            |  8 ++++----
>   include/linux/mm_types.h      |  2 +-
>   include/linux/mm_types_task.h |  3 ---
>   kernel/fork.c                 |  4 ++--
>   mm/Kconfig                    | 18 +++++++++++-------
>   mm/memory.c                   |  2 +-
>   8 files changed, 26 insertions(+), 24 deletions(-)

That's great. Thanks!

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index 2286c2ea60ec4..831793cd6ff94 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -61,7 +61,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   	return ret;
>   }
>   
> -#if USE_SPLIT_PTE_PTLOCKS
> +#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>   /*
>    * If we are using split PTE locks, then we need to take the page
>    * lock here.  Otherwise we are using shared mm->page_table_lock
> @@ -80,10 +80,10 @@ static inline void do_pte_unlock(spinlock_t *ptl)
>   {
>   	spin_unlock(ptl);
>   }
> -#else /* !USE_SPLIT_PTE_PTLOCKS */
> +#else /* !defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>   static inline void do_pte_lock(spinlock_t *ptl) {}
>   static inline void do_pte_unlock(spinlock_t *ptl) {}
> -#endif /* USE_SPLIT_PTE_PTLOCKS */
> +#endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>   
>   static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   	unsigned long pfn)
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index f1ce39d6d32cb..f4a316894bbb4 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -665,7 +665,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
>   {
>   	spinlock_t *ptl = NULL;
>   
> -#if USE_SPLIT_PTE_PTLOCKS
> +#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>   	ptl = ptlock_ptr(page_ptdesc(page));
>   	spin_lock_nest_lock(ptl, &mm->page_table_lock);
>   #endif
> @@ -1553,7 +1553,8 @@ static inline void xen_alloc_ptpage(struct mm_struct *mm, unsigned long pfn,
>   
>   		__set_pfn_prot(pfn, PAGE_KERNEL_RO);
>   
> -		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS && !pinned)
> +		if (level == PT_PTE && IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS) &&
> +		    !pinned)
>   			__pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);
>   
>   		xen_mc_issue(XEN_LAZY_MMU);
> @@ -1581,7 +1582,7 @@ static inline void xen_release_ptpage(unsigned long pfn, unsigned level)
>   	if (pinned) {
>   		xen_mc_batch();
>   
> -		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
> +		if (level == PT_PTE && IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS))
>   			__pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, pfn);
>   
>   		__set_pfn_prot(pfn, PAGE_KERNEL);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0472a5090b180..dff43101572ec 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2843,7 +2843,7 @@ static inline void pagetable_free(struct ptdesc *pt)
>   	__free_pages(page, compound_order(page));
>   }
>   
> -#if USE_SPLIT_PTE_PTLOCKS
> +#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>   #if ALLOC_SPLIT_PTLOCKS
>   void __init ptlock_cache_init(void);
>   bool ptlock_alloc(struct ptdesc *ptdesc);
> @@ -2895,7 +2895,7 @@ static inline bool ptlock_init(struct ptdesc *ptdesc)
>   	return true;
>   }
>   
> -#else	/* !USE_SPLIT_PTE_PTLOCKS */
> +#else	/* !defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>   /*
>    * We use mm->page_table_lock to guard all pagetable pages of the mm.
>    */
> @@ -2906,7 +2906,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>   static inline void ptlock_cache_init(void) {}
>   static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>   static inline void ptlock_free(struct ptdesc *ptdesc) {}
> -#endif /* USE_SPLIT_PTE_PTLOCKS */
> +#endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>   
>   static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>   {
> @@ -2966,7 +2966,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>   	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
>   		NULL: pte_offset_kernel(pmd, address))
>   
> -#if USE_SPLIT_PMD_PTLOCKS
> +#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
>   
>   static inline struct page *pmd_pgtable_page(pmd_t *pmd)
>   {
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4854249792545..165c58b12ccc9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -947,7 +947,7 @@ struct mm_struct {
>   #ifdef CONFIG_MMU_NOTIFIER
>   		struct mmu_notifier_subscriptions *notifier_subscriptions;
>   #endif
> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
>   		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
>   #endif
>   #ifdef CONFIG_NUMA_BALANCING
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> index a2f6179b672b8..bff5706b76e14 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -16,9 +16,6 @@
>   #include <asm/tlbbatch.h>
>   #endif
>   
> -#define USE_SPLIT_PTE_PTLOCKS	(NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
> -#define USE_SPLIT_PMD_PTLOCKS	(USE_SPLIT_PTE_PTLOCKS && \
> -		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
>   #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
>   
>   /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index a8362c26ebcb0..216ce9ba4f4e6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -832,7 +832,7 @@ static void check_mm(struct mm_struct *mm)
>   		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
>   				mm_pgtables_bytes(mm));
>   
> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
>   	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
>   #endif
>   }
> @@ -1276,7 +1276,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	RCU_INIT_POINTER(mm->exe_file, NULL);
>   	mmu_notifier_subscriptions_init(mm);
>   	init_tlb_flush_pending(mm);
> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
>   	mm->pmd_huge_pte = NULL;
>   #endif
>   	mm_init_uprobes_state(mm);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b72e7d040f789..7b716ac802726 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -585,17 +585,21 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>   # at the same time (e.g. copy_page_range()).
>   # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
>   #
> -config SPLIT_PTLOCK_CPUS
> -	int
> -	default "999999" if !MMU
> -	default "999999" if ARM && !CPU_CACHE_VIPT
> -	default "999999" if PARISC && !PA20
> -	default "999999" if SPARC32
> -	default "4"
> +config SPLIT_PTE_PTLOCKS
> +	def_bool y
> +	depends on MMU
> +	depends on NR_CPUS >= 4
> +	depends on !ARM || CPU_CACHE_VIPT
> +	depends on !PARISC || PA20
> +	depends on !SPARC32
>   
>   config ARCH_ENABLE_SPLIT_PMD_PTLOCK
>   	bool
>   
> +config SPLIT_PMD_PTLOCKS
> +	def_bool y
> +	depends on SPLIT_PTE_PTLOCKS && ARCH_ENABLE_SPLIT_PMD_PTLOCK
> +
>   #
>   # support for memory balloon
>   config MEMORY_BALLOON
> diff --git a/mm/memory.c b/mm/memory.c
> index 833d2cad6eb29..714589582fe15 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6559,7 +6559,7 @@ long copy_folio_from_user(struct folio *dst_folio,
>   }
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>   
> -#if USE_SPLIT_PTE_PTLOCKS && ALLOC_SPLIT_PTLOCKS
> +#if defined(CONFIG_SPLIT_PTE_PTLOCKS) && ALLOC_SPLIT_PTLOCKS
>   
>   static struct kmem_cache *page_ptl_cachep;
>   

