Return-Path: <linux-kernel+bounces-307895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7279654B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47831F22CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C224436E;
	Fri, 30 Aug 2024 01:31:09 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE001D1314
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981469; cv=none; b=mHuDWUXUystf1Sl4JqYG/2+k/bjZ08ISQRbtDvictmuWR6sMMQ0lbdtiUJkvNLyqJ1QCrkDG/hDY/Y5XAUnW5wjz+atNc6d56GH8m09hwIA3NvToyVeNhiiknERZzwpaRAMRBS38jZZ6fOze/UIEsCcEJjE2iJM9TZ1gF0evuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981469; c=relaxed/simple;
	bh=nOrU0w2tk/nbKvcY9p00QtGCH7sn8IGQDZJWmPugek4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CH3Yp8a8QbhxrFS3mCW1glvFVwoEQxAnKvGtWj15Z2g3vFCJhpF9/Y6mK4JRE1qlTT/vu9IvBRcuWBBdm4ieYv12UPZnRT7ZPHgdCrvh67Vref0FTpIdzcSZNFWwGh7GSS4pD1k6poO3uHRVY7a98Wa2A8wsczu+3B4c/DDtQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww0vq4hpgzyR5C;
	Fri, 30 Aug 2024 09:30:31 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BDC851800D1;
	Fri, 30 Aug 2024 09:31:03 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 09:31:03 +0800
Message-ID: <c4fbc62f-e398-1229-c1b1-7bab30e4460e@huawei.com>
Date: Fri, 30 Aug 2024 09:31:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RESEND PATCH V4 2/3] riscv: mm: Add soft-dirty page tracking
 support
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, Alexandre
 Ghiti <alex@ghiti.fr>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Chunyan
 Zhang <zhang.lyra@gmail.com>
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/30 9:11, Chunyan Zhang wrote:
> The PTE bit(9) is reserved for software, now used by DEVMAP,
> this patch reuse bit(9) for soft-dirty which is enabled only
> if !CONFIG_ARCH_HAS_PTE_DEVMAP, in other words, soft-dirty
> and devmap will be mutually exclusive on RISC-V.
> 
> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> available for swap PTEs on RISC-V systems.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig                    | 27 ++++++++++-
>  arch/riscv/include/asm/pgtable-bits.h | 12 +++++
>  arch/riscv/include/asm/pgtable.h      | 69 ++++++++++++++++++++++++++-
>  3 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..f1460fc01cd4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,7 +39,6 @@ config RISCV
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> -	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
>  	select ARCH_HAS_SET_MEMORY if MMU
> @@ -948,6 +947,32 @@ config RANDOMIZE_BASE
>  
>            If unsure, say N.
>  
> +choice
> +	prompt "PET RSW Bit(9) used for"
> +	default RISCV_HAS_PTE_DEVMEP
> +	depends on MMU && 64BIT
> +	help
> +	  RISC-V PTE bit(9) is reserved for software, and used by more than
> +	  one kernel features which cannot be supported at the same time.
> +	  So we have to select one for it.
> +
> +config RISCV_HAS_PTE_DEVMEP
> +	bool "DEVMAP mark"
> +	select ARCH_HAS_PTE_DEVMAP
> +	help
> +	  The PTE bit(9) is used for DEVMAP mark. ZONE_DEVICE pages need DEVMAP
> +	  PTEs support to function.
> +
> +	  So if you want to use ZONE_DEVICE, select this.
> +
> +config RISCV_HAS_SOFT_DIRTY
> +	bool "soft dirty"
> +	select HAVE_ARCH_SOFT_DIRTY
> +	help
> +	  The PTE bit(9) is used for soft-dirty tracking.
> +
> +endchoice
> +

Hi, ARCH_HAS_PTE_DEVMAP will be removed in following patch, I guess
riscv will too:

https://lore.kernel.org/all/47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com/

>  endmenu # "Kernel features"
>  
>  menu "Boot options"
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 5bcc73430829..c6d51fe9fc6f 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -26,6 +26,18 @@
>  #define _PAGE_DEVMAP	0
>  #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
>  
> +#ifdef CONFIG_MEM_SOFT_DIRTY
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
> +
>  #define _PAGE_TABLE     _PAGE_PRESENT
>  
>  /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 089f3c9f56a3..d41507919ef2 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -428,7 +428,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
>  
>  static inline pte_t pte_mkdirty(pte_t pte)
>  {
> -	return __pte(pte_val(pte) | _PAGE_DIRTY);
> +	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>  }
>  
>  static inline pte_t pte_mkclean(pte_t pte)
> @@ -461,6 +461,38 @@ static inline pte_t pte_mkhuge(pte_t pte)
>  	return pte;
>  }
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
>  #ifdef CONFIG_RISCV_ISA_SVNAPOT
>  #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
>  					napot_cont_size(napot_cont_order(pte)) :\
> @@ -751,6 +783,40 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>  }
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
>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  				pmd_t *pmdp, pmd_t pmd)
>  {
> @@ -841,6 +907,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>   * Format of swap PTE:
>   *	bit            0:	_PAGE_PRESENT (zero)
>   *	bit       1 to 3:       _PAGE_LEAF (zero)
> + *	bit	       4:	_PAGE_SWP_SOFT_DIRTY
>   *	bit            5:	_PAGE_PROT_NONE (zero)
>   *	bit            6:	exclusive marker
>   *	bits      7 to 11:	swap type

