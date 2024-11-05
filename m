Return-Path: <linux-kernel+bounces-396482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E039BCDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C589B21DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0161D5CD7;
	Tue,  5 Nov 2024 13:24:52 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1B70837
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813092; cv=none; b=sRYspR4K1pfWgKIXCYN/pyKw8g4uCSU5SSLFz1lmr28Lv4yMw/koj8d9/BEBAlo3ynBV9dtdlQTB/TqrwTBQ17KkKmheAa3jBnH//eiQcbEwoVyFS+Zj64cIJdh9HtAxzeWz5CNIR8xvkcYrirGQ/Ny7fXiqbSWfds7Gu7r4B6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813092; c=relaxed/simple;
	bh=tv/qmii+vTLCTaQV924R9plUNp/ROddPGNoPQ1qO2Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCqG0mpWttykLLcFzwsntJwykoUbHSNCtvl/lVsHc/wFsWBoG+/jiS/44ccb519stEZIXR2Kgm9YcEh7SQ00jC3iqByhhuoPuQQNQRk1PVMZiRD+hjzOLNKNVidMkY4/63uO9qgyPhiMQX+oHTy01krzHWxUKpn/AkWIdT+i6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0AEEC0004;
	Tue,  5 Nov 2024 13:24:47 +0000 (UTC)
Message-ID: <4aceb7ac-08fa-486f-a4cc-0bca16968deb@ghiti.fr>
Date: Tue, 5 Nov 2024 14:24:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V4 3/3] riscv: mm: Add uffd write-protect support
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-4-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240830011101.3189522-4-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 30/08/2024 03:11, Chunyan Zhang wrote:
> Reuse PTE bit(9) to do uffd-wp tracking and make it mutually exclusive
> with soft-dirty and DEVMAP which all use this PTE bit.
>
> Additionally for tracking the uffd-wp state as a PTE swap bit,
> we use swap entry pte bit(4) which is also used by swap
> soft-dirty tracking.
>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   arch/riscv/Kconfig                    |  7 +++
>   arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
>   arch/riscv/include/asm/pgtable.h      | 66 ++++++++++++++++++++++++++-
>   3 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f1460fc01cd4..aa595a5ed4b8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -971,6 +971,13 @@ config RISCV_HAS_SOFT_DIRTY
>   	help
>   	  The PTE bit(9) is used for soft-dirty tracking.
>   
> +config RISCV_HAS_USERFAULTFD_WP
> +	bool "userfaultfd write protection"
> +	select HAVE_ARCH_USERFAULTFD_WP
> +	depends on USERFAULTFD
> +	help
> +	  The PTE bit(9) is used for userfaultfd write-protected
> +	  tracking.
>   endchoice
>   
>   endmenu # "Kernel features"
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index c6d51fe9fc6f..7de16141c049 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -38,6 +38,19 @@
>   #define _PAGE_SWP_SOFT_DIRTY	0
>   #endif /* CONFIG_MEM_SOFT_DIRTY */
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
>   #define _PAGE_TABLE     _PAGE_PRESENT
>   
>   /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index d41507919ef2..6ce4c9ba862a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -417,6 +417,38 @@ static inline pte_t pte_wrprotect(pte_t pte)
>   	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
>   }
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


Weird to wrprotect a swap entry here, given x86/arm64 don't do that, you 
should remove it.


> +
> +static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~(_PAGE_SWP_UFFD_WP));
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>   /* static inline pte_t pte_mkread(pte_t pte) */
>   
>   static inline pte_t pte_mkwrite_novma(pte_t pte)
> @@ -783,6 +815,38 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>   	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>   }
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
>   #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>   static inline int pmd_soft_dirty(pmd_t pmd)
>   {
> @@ -907,7 +971,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>    * Format of swap PTE:
>    *	bit            0:	_PAGE_PRESENT (zero)
>    *	bit       1 to 3:       _PAGE_LEAF (zero)
> - *	bit	       4:	_PAGE_SWP_SOFT_DIRTY
> + *	bit	       4:	_PAGE_SWP_SOFT_DIRTY or _PAGE_SWP_UFFD_WP
>    *	bit            5:	_PAGE_PROT_NONE (zero)
>    *	bit            6:	exclusive marker
>    *	bits      7 to 11:	swap type

