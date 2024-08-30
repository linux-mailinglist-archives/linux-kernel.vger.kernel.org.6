Return-Path: <linux-kernel+bounces-307898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AC9654BF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B730C1C2158A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226DD42048;
	Fri, 30 Aug 2024 01:34:15 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F4175A6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981654; cv=none; b=iBTi0L8IUfaNFz0GVBEPJk9xgTUMKQVNUZXDUnvaQ/ERUmMhwJpa4rOW9iVVj4KvpJ/vefHIeUEsxCnLXKy5OoJoeX7uqnZSpb770UUEYe9RGRRJ3EaUZCdInpGwZusPLGSBMGoVBjTtcuDBtCIxj30b2H+Hrj2itsb6DFQLsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981654; c=relaxed/simple;
	bh=nF8/VzsIFv0V1VTfuX4AC1/VWxvlyjhfSA2Oxy3QEHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDLKd+j5aVxnXA0UoAcWg6/nytPPJEiN+sm3LNRvd/wiWkXVE8cX5wIpN6ugsR/rkzGr36TxLJ+VCxivLyqRklZpDEAv8P36SUCXLn0gRfPOFSV7Fcg6yAWerksc8U5uCCOgPrnetwbB6xZCjsN2CH6pl13YyNkFg0nHo8qzDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ww0zm0r92z1S9T8;
	Fri, 30 Aug 2024 09:33:56 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F851401E9;
	Fri, 30 Aug 2024 09:34:10 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 09:34:09 +0800
Message-ID: <3386ad7d-1834-3a81-d9b7-2aab2e8b48d0@huawei.com>
Date: Fri, 30 Aug 2024 09:34:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RESEND PATCH V4 3/3] riscv: mm: Add uffd write-protect support
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, Alexandre
 Ghiti <alex@ghiti.fr>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Chunyan
 Zhang <zhang.lyra@gmail.com>
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-4-zhangchunyan@iscas.ac.cn>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240830011101.3189522-4-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/30 9:11, Chunyan Zhang wrote:
> Reuse PTE bit(9) to do uffd-wp tracking and make it mutually exclusive
> with soft-dirty and DEVMAP which all use this PTE bit.
> 
> Additionally for tracking the uffd-wp state as a PTE swap bit,
> we use swap entry pte bit(4) which is also used by swap
> soft-dirty tracking.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

Hi, I have submitted a similar patch below before rebased on commit
216e04bf1e4d ("riscv: mm: Add support for ZONE_DEVICE")
has been removed:

https://lore.kernel.org/all/20240730095325.3540198-1-ruanjinjie@huawei.com/

> ---
>  arch/riscv/Kconfig                    |  7 +++
>  arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
>  arch/riscv/include/asm/pgtable.h      | 66 ++++++++++++++++++++++++++-
>  3 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f1460fc01cd4..aa595a5ed4b8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -971,6 +971,13 @@ config RISCV_HAS_SOFT_DIRTY
>  	help
>  	  The PTE bit(9) is used for soft-dirty tracking.
>  
> +config RISCV_HAS_USERFAULTFD_WP
> +	bool "userfaultfd write protection"
> +	select HAVE_ARCH_USERFAULTFD_WP
> +	depends on USERFAULTFD
> +	help
> +	  The PTE bit(9) is used for userfaultfd write-protected
> +	  tracking.
>  endchoice
>  
>  endmenu # "Kernel features"
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index c6d51fe9fc6f..7de16141c049 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -38,6 +38,19 @@
>  #define _PAGE_SWP_SOFT_DIRTY	0
>  #endif /* CONFIG_MEM_SOFT_DIRTY */
>  
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +/*
> + * CONFIG_HAVE_ARCH_USERFAULTFD_WP is mutually exclusive with
> + * HAVE_ARCH_SOFT_DIRTY so we can use the same bit for uffd-wp
> + * and soft-dirty tracking.
> + */
> +#define _PAGE_UFFD_WP		(1 << 9) /* RSW: 0x2 for uffd-wp tracking */
> +#define _PAGE_SWP_UFFD_WP	_PAGE_USER
> +#else
> +#define _PAGE_UFFD_WP		0
> +#define _PAGE_SWP_UFFD_WP	0
> +#endif
> +
>  #define _PAGE_TABLE     _PAGE_PRESENT
>  
>  /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index d41507919ef2..6ce4c9ba862a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -417,6 +417,38 @@ static inline pte_t pte_wrprotect(pte_t pte)
>  	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
>  }
>  
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static inline int pte_uffd_wp(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_UFFD_WP;
> +}
> +
> +static inline pte_t pte_mkuffd_wp(pte_t pte)
> +{
> +	return pte_wrprotect(__pte(pte_val(pte) | _PAGE_UFFD_WP));
> +}
> +
> +static inline pte_t pte_clear_uffd_wp(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_UFFD_WP));
> +}
> +
> +static inline int pte_swp_uffd_wp(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SWP_UFFD_WP;
> +}
> +
> +static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
> +{
> +	return pte_wrprotect(__pte(pte_val(pte) | _PAGE_SWP_UFFD_WP));
> +}
> +
> +static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_SWP_UFFD_WP));
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>  /* static inline pte_t pte_mkread(pte_t pte) */
>  
>  static inline pte_t pte_mkwrite_novma(pte_t pte)
> @@ -783,6 +815,38 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>  }
>  
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static inline int pmd_uffd_wp(pmd_t pmd)
> +{
> +	return pte_uffd_wp(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
> +{
> +	return pte_pmd(pte_mkuffd_wp(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
> +{
> +	return pte_pmd(pte_clear_uffd_wp(pmd_pte(pmd)));
> +}
> +
> +static inline int pmd_swp_uffd_wp(pmd_t pmd)
> +{
> +	return pte_swp_uffd_wp(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
> +{
> +	return pte_pmd(pte_swp_mkuffd_wp(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
> +{
> +	return pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)));
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>  static inline int pmd_soft_dirty(pmd_t pmd)
>  {
> @@ -907,7 +971,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>   * Format of swap PTE:
>   *	bit            0:	_PAGE_PRESENT (zero)
>   *	bit       1 to 3:       _PAGE_LEAF (zero)
> - *	bit	       4:	_PAGE_SWP_SOFT_DIRTY
> + *	bit	       4:	_PAGE_SWP_SOFT_DIRTY or _PAGE_SWP_UFFD_WP
>   *	bit            5:	_PAGE_PROT_NONE (zero)
>   *	bit            6:	exclusive marker
>   *	bits      7 to 11:	swap type

