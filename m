Return-Path: <linux-kernel+bounces-252431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A09312F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBB51F210C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5D31891D6;
	Mon, 15 Jul 2024 11:21:28 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200D1891BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042488; cv=none; b=CCaGvWZmgPhxNd3kHkgxOKQR2Ngsseh8O5iMOxhvFyocr7JvQXlMM7lK8Ag4i9bdjTse2eCUEN5nF/CVzbXMIIbNwQXWNURyxlZnwikTkjuC/AdGaeM53MIf7tRwXNcEtvqiA//0idtdPDbf0/zzoVYsSJkvg61h4wne9CrFuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042488; c=relaxed/simple;
	bh=l2yMsUc/L6fiq3OcerytTMkejC1ARfeLHWVsLeNRdVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKatiPZCYtsx71zx6a4qDLDzS+nlHhDIlvW/FYPKq/M8Wn0NXWuocMil/GBboVui6owSaQ9AfQbaPXKTReJc6lU55F2jvT5/aL0rPbLC0Q76O1QETRT34C0c9ycOuXord8y04eqKVGaEzndfAzTsuGlzkq1DKJYt0r8m3xZG3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AFA760003;
	Mon, 15 Jul 2024 11:21:11 +0000 (UTC)
Message-ID: <9bf70f7c-5deb-4fce-b7c1-ec70d78cb5db@ghiti.fr>
Date: Mon, 15 Jul 2024 13:21:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/mm: Add soft-dirty page tracking support
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240710033004.3923527-1-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240710033004.3923527-1-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 10/07/2024 05:30, Chunyan Zhang wrote:
> The PTE bit (9) is reserved for software, so we can use it for
> soft-dirty tracking. This patch adds its standard handlers for
> PTE, PMD, and swap entry.


Unfortunately, ZONE_DEVICE has just used this last bit and should be 
merged in 6.11.

I'm currently discussing internally how we can get 2 other PTE bits from 
RVI in order to have the same number of available bits as x86 and arm64. 
I guess that for now, if we really have a usecase for softdirty (and I 
think we do with CRIU), we'll have to make ZONE_DEVICE and softdirty 
mutually exclusive.


>
> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> available for swap PTEs on RISC-V systems.
>
> This patch has been tested with the kselftest mm suite in which
> soft-dirty and madv_populate run and pass, and no regressions
> are observed in any of the other tests.


Did you give CRIU a try?

Thanks,

Alex


>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   arch/riscv/Kconfig                    |  1 +
>   arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
>   arch/riscv/include/asm/pgtable.h      | 65 ++++++++++++++++++++++++++-
>   3 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..2e3ad2925a6b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -118,6 +118,7 @@ config RISCV
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>   	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>   	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_SOFT_DIRTY
>   	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>   	select HAVE_ARCH_TRACEHOOK
>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 179bd4afece4..bab48f5fd1e2 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -19,6 +19,19 @@
>   #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>   
>   #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> +
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
>   #define _PAGE_TABLE     _PAGE_PRESENT
>   
>   /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index aad8b8ca51f1..46f512f52580 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -408,7 +408,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
>   
>   static inline pte_t pte_mkdirty(pte_t pte)
>   {
> -	return __pte(pte_val(pte) | _PAGE_DIRTY);
> +	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>   }
>   
>   static inline pte_t pte_mkclean(pte_t pte)
> @@ -436,6 +436,36 @@ static inline pte_t pte_mkhuge(pte_t pte)
>   	return pte;
>   }
>   
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
> +
>   #ifdef CONFIG_RISCV_ISA_SVNAPOT
>   #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
>   					napot_cont_size(napot_cont_order(pte)) :\
> @@ -721,6 +751,38 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>   	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
>   }
>   
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
> +
>   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>   				pmd_t *pmdp, pmd_t pmd)
>   {
> @@ -811,6 +873,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>    * Format of swap PTE:
>    *	bit            0:	_PAGE_PRESENT (zero)
>    *	bit       1 to 3:       _PAGE_LEAF (zero)
> + *	bit            4:	_PAGE_SWP_SOFT_DIRTY
>    *	bit            5:	_PAGE_PROT_NONE (zero)
>    *	bit            6:	exclusive marker
>    *	bits      7 to 11:	swap type

