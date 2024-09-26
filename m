Return-Path: <linux-kernel+bounces-339882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E3986BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651DC1F22FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BBE1D554;
	Thu, 26 Sep 2024 04:18:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6B4C79
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727324292; cv=none; b=o6P8p2qwUV4s/a/EeYrL4C86HfJwT0sWRjWR23kxqU/d23SSVB+6C1rKSnJAfgIxJpg6WCcldX6qT4U5GK0hxzX6RBZXYgUj8Au/S/3RMa8/VbbQHWO/qVmnXKzHAHm8XBgHE30cCb+4BFnUDkNFsKa1CXObRma2jmVp/8H0K2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727324292; c=relaxed/simple;
	bh=0TjdrucShvr7QUbd5OwG9DXgoM0NPmZ8qTPdh6Q0qns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htVFQdLuvGQkpaLkIlpJwBPJgdby6sMHIZrHqwMoDuvV0DXamiEpupurntp0G8GALNguCFvLoNvpDyjbyr2Mklb+F+roNTGYnP39mdLC6I9yCpY9JVELUfHUpK5rDs1aCbDZT9YNcfwD2a4EzP8z+a/GnjcQUiz/idJ/P0CyfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C367615A1;
	Wed, 25 Sep 2024 21:18:36 -0700 (PDT)
Received: from [10.163.35.5] (unknown [10.163.35.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DF693F528;
	Wed, 25 Sep 2024 21:18:03 -0700 (PDT)
Message-ID: <97c9f027-0162-4093-a5d7-0dc561ea28c7@arm.com>
Date: Thu, 26 Sep 2024 09:48:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Move set_pxd_safe() helpers from generic to platform
To: linux-mm@kvack.org, akpm@linux-foundation.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 x86@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920053017.2514920-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240920053017.2514920-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/20/24 11:00, Anshuman Khandual wrote:
> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
> platforms, do not need to be in the common memory code. Otherwise they just
> unnecessarily make the common API more complicated. This moves the helpers
> from common code to platform instead.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 19 ++++++++++++++++
>  arch/x86/include/asm/pgtable.h   | 37 +++++++++++++++++++++++++++++++
>  include/linux/pgtable.h          | 38 --------------------------------
>  3 files changed, 56 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 089f3c9f56a3..39ca652c5ebe 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -957,6 +957,25 @@ void misc_mem_init(void);
>  extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
>  
> +/*
> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
> + * TLB flush will be required as a result of the "set". For example, use
> + * in scenarios where it is known ahead of time that the routine is
> + * setting non-present entries, or re-setting an existing entry to the
> + * same value. Otherwise, use the typical "set" helpers and flush the
> + * TLB.
> + */
> +#define set_p4d_safe(p4dp, p4d) \
> +({ \
> +	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
> +	set_p4d(p4dp, p4d); \
> +})
> +
> +#define set_pgd_safe(pgdp, pgd) \
> +({ \
> +	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
> +	set_pgd(pgdp, pgd); \
> +})
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_PGTABLE_H */
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e39311a89bf4..fefb52bb6b4d 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1701,6 +1701,43 @@ bool arch_is_platform_page(u64 paddr);
>  #define arch_is_platform_page arch_is_platform_page
>  #endif
>  
> +/*
> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
> + * TLB flush will be required as a result of the "set". For example, use
> + * in scenarios where it is known ahead of time that the routine is
> + * setting non-present entries, or re-setting an existing entry to the
> + * same value. Otherwise, use the typical "set" helpers and flush the
> + * TLB.
> + */
> +#define set_pte_safe(ptep, pte) \
> +({ \
> +	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> +	set_pte(ptep, pte); \
> +})
> +
> +#define set_pmd_safe(pmdp, pmd) \
> +({ \
> +	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
> +	set_pmd(pmdp, pmd); \
> +})
> +
> +#define set_pud_safe(pudp, pud) \
> +({ \
> +	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
> +	set_pud(pudp, pud); \
> +})
> +
> +#define set_p4d_safe(p4dp, p4d) \
> +({ \
> +	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
> +	set_p4d(p4dp, p4d); \
> +})
> +
> +#define set_pgd_safe(pgdp, pgd) \
> +({ \
> +	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
> +	set_pgd(pgdp, pgd); \
> +})
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_PGTABLE_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..0bf88e505aad 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1050,44 +1050,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>  }
>  #endif
>  
> -/*
> - * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
> - * TLB flush will be required as a result of the "set". For example, use
> - * in scenarios where it is known ahead of time that the routine is
> - * setting non-present entries, or re-setting an existing entry to the
> - * same value. Otherwise, use the typical "set" helpers and flush the
> - * TLB.
> - */
> -#define set_pte_safe(ptep, pte) \
> -({ \
> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> -	set_pte(ptep, pte); \
> -})
> -
> -#define set_pmd_safe(pmdp, pmd) \
> -({ \
> -	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
> -	set_pmd(pmdp, pmd); \
> -})
> -
> -#define set_pud_safe(pudp, pud) \
> -({ \
> -	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
> -	set_pud(pudp, pud); \
> -})
> -
> -#define set_p4d_safe(p4dp, p4d) \
> -({ \
> -	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
> -	set_p4d(p4dp, p4d); \
> -})
> -
> -#define set_pgd_safe(pgdp, pgd) \
> -({ \
> -	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
> -	set_pgd(pgdp, pgd); \
> -})
> -
>  #ifndef __HAVE_ARCH_DO_SWAP_PAGE
>  static inline void arch_do_swap_page_nr(struct mm_struct *mm,
>  				     struct vm_area_struct *vma,

Hello Dave/Palmer,

Unless there is still any more objection from x86 or riscv, could this
patch be pulled ?

- Anshuman

