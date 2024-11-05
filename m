Return-Path: <linux-kernel+bounces-396237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7FC9BC9CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0C4283128
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED331D1738;
	Tue,  5 Nov 2024 09:58:57 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFC18BC37;
	Tue,  5 Nov 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800737; cv=none; b=TQL4GmJCq5Ijp9jqARKstMsakCzMtD6hoqYUBQNx++35AxQtCwNzK4aO5iqeghEPsfG9hva6Nvi/tC2k5Cyou4irxJjNJKeXci1XUUP8Jz5oQ8d+4YkYrBY0mGdzjeMMrD1LmuN9vaornpr1k0E+YjCs/dCTRi1iWjlfLc75Of8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800737; c=relaxed/simple;
	bh=rUo0NBXqrmI8U/Z5LRq7hBMwwk8BGXhCU/9jdvOYPJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ST4QzerMH66pFi7UOIFEHPgbCbtDZbpNpUP1b04+csMz7cJSvOiV81S+4cfaZiAScVdncGq8efFl106/9PKarpyo2YYlZPv4kCHMdJOvyQC751LXlO9wSPMA0Ooe14A/H/3FJfH9T4lUNK2LhZvG1QcdQVY0goqdnER70l8RIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F25DC0002;
	Tue,  5 Nov 2024 09:58:43 +0000 (UTC)
Message-ID: <6a62e26b-3c55-425c-813f-2f84b56c6951@ghiti.fr>
Date: Tue, 5 Nov 2024 10:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] riscv: mm: Deduplicate pgtable address conversion
 functions
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
 <20241102000843.1301099-4-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241102000843.1301099-4-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 02/11/2024 01:07, Samuel Holland wrote:
> Some functions were defined equivalently in both pgtable.h and
> pgtable-64.h. Keep only one definition, and move it to pgtable-64.h
> unless it is also used for Sv32. Note that while Sv32 uses only two
> levels of page tables, the kernel is not consistent with how they are
> folded. THP requires pfn_pmd()/pmd_pfn() and mm/init.c requires
> pfn_pgd()/pgd_pfn(), so for now both are provided.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/include/asm/pgtable-32.h |  4 ++++
>   arch/riscv/include/asm/pgtable-64.h | 28 ++++++++++++++--------------
>   arch/riscv/include/asm/pgtable.h    | 23 ++++-------------------
>   arch/riscv/mm/init.c                |  8 ++++----
>   arch/riscv/mm/kasan_init.c          |  8 ++++----
>   5 files changed, 30 insertions(+), 41 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index 00f3369570a8..23137347dc15 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -33,6 +33,10 @@
>   					  _PAGE_WRITE | _PAGE_EXEC |	\
>   					  _PAGE_USER | _PAGE_GLOBAL))
>   
> +#define pud_pfn(pud)				(pmd_pfn((pmd_t){ pud }))
> +#define p4d_pfn(p4d)				(pud_pfn((pud_t){ p4d }))


pud_pfn() and p4d_pfn() should not be used in 32-bit right? I think you 
can remove their definitions and simplify pgd_pfn().


> +#define pgd_pfn(pgd)				(p4d_pfn((p4d_t){ pgd }))
> +
>   static const __maybe_unused int pgtable_l4_enabled;
>   static const __maybe_unused int pgtable_l5_enabled;
>   
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 0897dd99ab8d..33e7ff049c4a 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -213,19 +213,20 @@ static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
>   	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
>   }
>   
> -static inline unsigned long _pud_pfn(pud_t pud)
> +#define pud_pfn pud_pfn
> +static inline unsigned long pud_pfn(pud_t pud)
>   {
>   	return __page_val_to_pfn(pud_val(pud));
>   }
>   
>   static inline pmd_t *pud_pgtable(pud_t pud)
>   {
> -	return (pmd_t *)pfn_to_virt(__page_val_to_pfn(pud_val(pud)));
> +	return (pmd_t *)pfn_to_virt(pud_pfn(pud));
>   }
>   
>   static inline struct page *pud_page(pud_t pud)
>   {
> -	return pfn_to_page(__page_val_to_pfn(pud_val(pud)));
> +	return pfn_to_page(pud_pfn(pud));
>   }
>   
>   #define mm_p4d_folded  mm_p4d_folded
> @@ -257,11 +258,6 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>   	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
>   }
>   
> -static inline unsigned long _pmd_pfn(pmd_t pmd)
> -{
> -	return __page_val_to_pfn(pmd_val(pmd));
> -}
> -
>   #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
>   
>   #define pmd_ERROR(e) \
> @@ -316,7 +312,7 @@ static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
>   	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
>   }
>   
> -static inline unsigned long _p4d_pfn(p4d_t p4d)
> +static inline unsigned long p4d_pfn(p4d_t p4d)
>   {
>   	return __page_val_to_pfn(p4d_val(p4d));
>   }
> @@ -324,7 +320,7 @@ static inline unsigned long _p4d_pfn(p4d_t p4d)
>   static inline pud_t *p4d_pgtable(p4d_t p4d)
>   {
>   	if (pgtable_l4_enabled)
> -		return (pud_t *)pfn_to_virt(__page_val_to_pfn(p4d_val(p4d)));
> +		return (pud_t *)pfn_to_virt(p4d_pfn(p4d));
>   
>   	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
>   }
> @@ -332,7 +328,7 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
>   
>   static inline struct page *p4d_page(p4d_t p4d)
>   {
> -	return pfn_to_page(__page_val_to_pfn(p4d_val(p4d)));
> +	return pfn_to_page(p4d_pfn(p4d));
>   }
>   
>   #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> @@ -378,10 +374,15 @@ static inline void pgd_clear(pgd_t *pgd)
>   		set_pgd(pgd, __pgd(0));
>   }
>   
> +static inline unsigned long pgd_pfn(pgd_t pgd)
> +{
> +	return __page_val_to_pfn(pgd_val(pgd));
> +}
> +
>   static inline p4d_t *pgd_pgtable(pgd_t pgd)
>   {
>   	if (pgtable_l5_enabled)
> -		return (p4d_t *)pfn_to_virt(__page_val_to_pfn(pgd_val(pgd)));
> +		return (p4d_t *)pfn_to_virt(pgd_pfn(pgd));
>   
>   	return (p4d_t *)p4d_pgtable((p4d_t) { pgd_val(pgd) });
>   }
> @@ -389,9 +390,8 @@ static inline p4d_t *pgd_pgtable(pgd_t pgd)
>   
>   static inline struct page *pgd_page(pgd_t pgd)
>   {
> -	return pfn_to_page(__page_val_to_pfn(pgd_val(pgd)));
> +	return pfn_to_page(pgd_pfn(pgd));
>   }
> -#define pgd_page(pgd)	pgd_page(pgd)
>   
>   #define p4d_index(addr) (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
>   
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index e79f15293492..3e0e1177107d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -258,19 +258,19 @@ static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
>   	return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
>   }
>   
> -static inline unsigned long _pgd_pfn(pgd_t pgd)
> +static inline unsigned long pmd_pfn(pmd_t pmd)
>   {
> -	return __page_val_to_pfn(pgd_val(pgd));
> +	return __page_val_to_pfn(pmd_val(pmd));
>   }
>   
>   static inline struct page *pmd_page(pmd_t pmd)
>   {
> -	return pfn_to_page(__page_val_to_pfn(pmd_val(pmd)));
> +	return pfn_to_page(pmd_pfn(pmd));
>   }
>   
>   static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>   {
> -	return (unsigned long)pfn_to_virt(__page_val_to_pfn(pmd_val(pmd)));
> +	return (unsigned long)pfn_to_virt(pmd_pfn(pmd));
>   }
>   
>   static inline pte_t pmd_pte(pmd_t pmd)
> @@ -673,21 +673,6 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>   	return __pmd(pmd_val(pmd) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
>   }
>   
> -#define __pmd_to_phys(pmd)  (__page_val_to_pfn(pmd_val(pmd)) << PAGE_SHIFT)
> -
> -static inline unsigned long pmd_pfn(pmd_t pmd)
> -{
> -	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
> -}
> -
> -#define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
> -
> -#define pud_pfn pud_pfn
> -static inline unsigned long pud_pfn(pud_t pud)
> -{
> -	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
> -}
> -
>   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>   {
>   	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0e8c20adcd98..7282b62b7e8d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -497,7 +497,7 @@ static void __meminit create_pmd_mapping(pmd_t *pmdp,
>   		ptep = pt_ops.get_pte_virt(pte_phys);
>   		memset(ptep, 0, PAGE_SIZE);
>   	} else {
> -		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
> +		pte_phys = PFN_PHYS(pmd_pfn(pmdp[pmd_idx]));
>   		ptep = pt_ops.get_pte_virt(pte_phys);
>   	}
>   
> @@ -599,7 +599,7 @@ static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t
>   		nextp = pt_ops.get_pmd_virt(next_phys);
>   		memset(nextp, 0, PAGE_SIZE);
>   	} else {
> -		next_phys = PFN_PHYS(_pud_pfn(pudp[pud_index]));
> +		next_phys = PFN_PHYS(pud_pfn(pudp[pud_index]));
>   		nextp = pt_ops.get_pmd_virt(next_phys);
>   	}
>   
> @@ -625,7 +625,7 @@ static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys_addr_t
>   		nextp = pt_ops.get_pud_virt(next_phys);
>   		memset(nextp, 0, PAGE_SIZE);
>   	} else {
> -		next_phys = PFN_PHYS(_p4d_pfn(p4dp[p4d_index]));
> +		next_phys = PFN_PHYS(p4d_pfn(p4dp[p4d_index]));
>   		nextp = pt_ops.get_pud_virt(next_phys);
>   	}
>   
> @@ -682,7 +682,7 @@ void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phy
>   		nextp = get_pgd_next_virt(next_phys);
>   		memset(nextp, 0, PAGE_SIZE);
>   	} else {
> -		next_phys = PFN_PHYS(_pgd_pfn(pgdp[pgd_idx]));
> +		next_phys = PFN_PHYS(pgd_pfn(pgdp[pgd_idx]));
>   		nextp = get_pgd_next_virt(next_phys);
>   	}
>   
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index c301c8d291d2..bac65e3268a4 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -171,7 +171,7 @@ static void __init kasan_early_clear_pud(p4d_t *p4dp,
>   	if (!pgtable_l4_enabled) {
>   		pudp = (pud_t *)p4dp;
>   	} else {
> -		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(p4dp_get(p4dp))));
> +		base_pud = pt_ops.get_pud_virt(pfn_to_phys(p4d_pfn(p4dp_get(p4dp))));
>   		pudp = base_pud + pud_index(vaddr);
>   	}
>   
> @@ -196,7 +196,7 @@ static void __init kasan_early_clear_p4d(pgd_t *pgdp,
>   	if (!pgtable_l5_enabled) {
>   		p4dp = (p4d_t *)pgdp;
>   	} else {
> -		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(pgdp_get(pgdp))));
> +		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(pgd_pfn(pgdp_get(pgdp))));
>   		p4dp = base_p4d + p4d_index(vaddr);
>   	}
>   
> @@ -242,7 +242,7 @@ static void __init kasan_early_populate_pud(p4d_t *p4dp,
>   	if (!pgtable_l4_enabled) {
>   		pudp = (pud_t *)p4dp;
>   	} else {
> -		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(p4dp_get(p4dp))));
> +		base_pud = pt_ops.get_pud_virt(pfn_to_phys(p4d_pfn(p4dp_get(p4dp))));
>   		pudp = base_pud + pud_index(vaddr);
>   	}
>   
> @@ -280,7 +280,7 @@ static void __init kasan_early_populate_p4d(pgd_t *pgdp,
>   	if (!pgtable_l5_enabled) {
>   		p4dp = (p4d_t *)pgdp;
>   	} else {
> -		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(pgdp_get(pgdp))));
> +		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(pgd_pfn(pgdp_get(pgdp))));
>   		p4dp = base_p4d + p4d_index(vaddr);
>   	}
>   


Otherwise, this is a nice cleanup, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


