Return-Path: <linux-kernel+bounces-396473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C69BCD97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674A71C21FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E81D6190;
	Tue,  5 Nov 2024 13:13:24 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1B1D5ADD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812404; cv=none; b=ObHictjWVxAeOEeWnx84SLtd+s1AI0RyjJVamOAlsXfL85eP3BagiPRvjqGXG3+N8Vfueq22/7ZvDN8m9QgxMl6q0xDEnTKu/wWx8WiFAtPzGm4ynJoTUm93c5xE9KXz1Zadyme4A0uXTQKHV8jdnBlLOscxJ0bMslW0N5AYfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812404; c=relaxed/simple;
	bh=tSLKGSs81G3FilAWaxD6jAgMYzlMXKr1GqTtalZeqVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZJvPY/jZtAKHq2Z64iIzNFixwMa+5oqHxsTDO/uPq1TSPDW8IbUrclvXapzq5gsQHFHx020VSFq81wNvPebQyQ3M/r+vqzv2pR8jO0/x0SXzNVN0tQPpQdaroMzt4V/C+p7+qiN8g/aW4NGat4Yz7Wmdou2KKzBLq/NwrxhzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB8D320004;
	Tue,  5 Nov 2024 13:13:17 +0000 (UTC)
Message-ID: <97898777-8129-4ce9-8ae4-9d4bbc2a5a26@ghiti.fr>
Date: Tue, 5 Nov 2024 14:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V4 2/3] riscv: mm: Add soft-dirty page tracking
 support
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 30/08/2024 03:11, Chunyan Zhang wrote:
> The PTE bit(9) is reserved for software, now used by DEVMAP,
> this patch reuse bit(9) for soft-dirty which is enabled only


s/reuse/reuses


> if !CONFIG_ARCH_HAS_PTE_DEVMAP, in other words, soft-dirty
> and devmap will be mutually exclusive on RISC-V.
>
> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> available for swap PTEs on RISC-V systems.
>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   arch/riscv/Kconfig                    | 27 ++++++++++-
>   arch/riscv/include/asm/pgtable-bits.h | 12 +++++
>   arch/riscv/include/asm/pgtable.h      | 69 ++++++++++++++++++++++++++-
>   3 files changed, 106 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..f1460fc01cd4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,7 +39,6 @@ config RISCV
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PMEM_API
>   	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> -	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_SET_DIRECT_MAP if MMU
>   	select ARCH_HAS_SET_MEMORY if MMU
> @@ -948,6 +947,32 @@ config RANDOMIZE_BASE
>   
>             If unsure, say N.
>   
> +choice
> +	prompt "PET RSW Bit(9) used for"


I would say: "PTE RSW bit(9) usage"


> +	default RISCV_HAS_PTE_DEVMEP


s/DEVMEP/DEVMAP


> +	depends on MMU && 64BIT
> +	help
> +	  RISC-V PTE bit(9) is reserved for software, and used by more than
> +	  one kernel features which cannot be supported at the same time.


s/features/feature


> +	  So we have to select one for it.
> +
> +config RISCV_HAS_PTE_DEVMEP
> +	bool "DEVMAP mark"


I would say simply "devmap"


> +	select ARCH_HAS_PTE_DEVMAP
> +	help
> +	  The PTE bit(9) is used for DEVMAP mark. ZONE_DEVICE pages need DEVMAP


"is used for devmap...pages need devmap"


> +	  PTEs support to function.
> +
> +	  So if you want to use ZONE_DEVICE, select this.
> +
> +config RISCV_HAS_SOFT_DIRTY
> +	bool "soft dirty"


s/soft dirty/soft-dirty


> +	select HAVE_ARCH_SOFT_DIRTY
> +	help
> +	  The PTE bit(9) is used for soft-dirty tracking.
> +
> +endchoice
> +
>   endmenu # "Kernel features"
>   
>   menu "Boot options"
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 5bcc73430829..c6d51fe9fc6f 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -26,6 +26,18 @@
>   #define _PAGE_DEVMAP	0
>   #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
>   
> +#ifdef CONFIG_MEM_SOFT_DIRTY


For consistency with CONFIG_ARCH_HAS_PTE_DEVMAP, I would use 
CONFIG_HAVE_ARCH_SOFT_DIRTY


> +#define _PAGE_SOFT_DIRTY	(1 << 9)    /* RSW: 0x2 for software dirty tracking */
> +/*
> + * BIT 4 is not involved into swap entry computation, so we
> + * can borrow it for swap page soft-dirty tracking.
> + */
> +#define _PAGE_SWP_SOFT_DIRTY	_PAGE_USER
> +#else
> +#define _PAGE_SOFT_DIRTY	0
> +#define _PAGE_SWP_SOFT_DIRTY	0
> +#endif /* CONFIG_MEM_SOFT_DIRTY */


Same here.


> +
>   #define _PAGE_TABLE     _PAGE_PRESENT
>   
>   /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 089f3c9f56a3..d41507919ef2 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -428,7 +428,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
>   
>   static inline pte_t pte_mkdirty(pte_t pte)
>   {
> -	return __pte(pte_val(pte) | _PAGE_DIRTY);
> +	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>   }
>   
>   static inline pte_t pte_mkclean(pte_t pte)
> @@ -461,6 +461,38 @@ static inline pte_t pte_mkhuge(pte_t pte)
>   	return pte;
>   }
>   
> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> +static inline int pte_soft_dirty(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SOFT_DIRTY;
> +}
> +
> +static inline pte_t pte_mksoft_dirty(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
> +}
> +
> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_SOFT_DIRTY));
> +}
> +
> +static inline int pte_swp_soft_dirty(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
> +}
> +
> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
> +}
> +
> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_SWP_SOFT_DIRTY));
> +}
> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
> +
>   #ifdef CONFIG_RISCV_ISA_SVNAPOT
>   #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
>   					napot_cont_size(napot_cont_order(pte)) :\
> @@ -751,6 +783,40 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>   	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>   }
>   
> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> +static inline int pmd_soft_dirty(pmd_t pmd)
> +{
> +	return pte_soft_dirty(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> +{
> +	return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> +{
> +	return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> +}
> +
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> +{
> +	return pte_swp_soft_dirty(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> +{
> +	return pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> +{
> +	return pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)));
> +}
> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
> +
>   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>   				pmd_t *pmdp, pmd_t pmd)
>   {
> @@ -841,6 +907,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>    * Format of swap PTE:
>    *	bit            0:	_PAGE_PRESENT (zero)
>    *	bit       1 to 3:       _PAGE_LEAF (zero)
> + *	bit	       4:	_PAGE_SWP_SOFT_DIRTY
>    *	bit            5:	_PAGE_PROT_NONE (zero)
>    *	bit            6:	exclusive marker
>    *	bits      7 to 11:	swap type


Apart from the minor things above, the rest looks good so you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


