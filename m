Return-Path: <linux-kernel+bounces-396476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD69BCD9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B01D1F214ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14E1D63EE;
	Tue,  5 Nov 2024 13:15:00 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125E1D5AC8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812500; cv=none; b=KLhL8cdu1PjxzGHe++mv3PTxKh0NQ3boNa6/lU4QD4Ry5EPJB9Ezcp7T8GyxQenm4brYAYAO1GvjEYX8T6VD4GFQ19hOe2Bz5o3B1TyDR4wLiUCASe3S2SbRa1cA7y5YilvjivRnVmaHPuBAk/kkWwbMbJuK21ndBL9utPpcZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812500; c=relaxed/simple;
	bh=SOYhgOFm9wTu8bZXl913YmyDLtk1ZKi8Iaa9EOcWzFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPxIWXR2MeuGlpw1clcLmMwfWPLujEtHGA/up7KbuFWn0CQ/ntjA6d7t0CVwezvU2FLKlfT8OQYOj9CaYsjsXgU2josWFJ1LX+mDSVJ7aCvNX1hI2NUX7ExU9hPnqbtmM9z6+ZdmYn5vDLLZDUm5uP3jC01xNQzjyq6Ds+eg6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92541C0003;
	Tue,  5 Nov 2024 13:14:52 +0000 (UTC)
Message-ID: <d1a84096-9722-47f1-ad8e-671144a3d109@ghiti.fr>
Date: Tue, 5 Nov 2024 14:14:52 +0100
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
To: Chunyan Zhang <zhang.lyra@gmail.com>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn>
 <c4fbc62f-e398-1229-c1b1-7bab30e4460e@huawei.com>
 <CAAfSe-vDtJKeSeUgpeJM0ZQe4XKdKz_Rgz2TQkPb4giPBLsOdw@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAAfSe-vDtJKeSeUgpeJM0ZQe4XKdKz_Rgz2TQkPb4giPBLsOdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 30/08/2024 04:31, Chunyan Zhang wrote:
> Hi Jinjie,
>
> On Fri, 30 Aug 2024 at 09:31, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>
>> On 2024/8/30 9:11, Chunyan Zhang wrote:
>>> The PTE bit(9) is reserved for software, now used by DEVMAP,
>>> this patch reuse bit(9) for soft-dirty which is enabled only
>>> if !CONFIG_ARCH_HAS_PTE_DEVMAP, in other words, soft-dirty
>>> and devmap will be mutually exclusive on RISC-V.
>>>
>>> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
>>> available for swap PTEs on RISC-V systems.
>>>
>>> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
>>> ---
>>>   arch/riscv/Kconfig                    | 27 ++++++++++-
>>>   arch/riscv/include/asm/pgtable-bits.h | 12 +++++
>>>   arch/riscv/include/asm/pgtable.h      | 69 ++++++++++++++++++++++++++-
>>>   3 files changed, 106 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 0f3cd7c3a436..f1460fc01cd4 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -39,7 +39,6 @@ config RISCV
>>>        select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>>        select ARCH_HAS_PMEM_API
>>>        select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>>> -     select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>>>        select ARCH_HAS_PTE_SPECIAL
>>>        select ARCH_HAS_SET_DIRECT_MAP if MMU
>>>        select ARCH_HAS_SET_MEMORY if MMU
>>> @@ -948,6 +947,32 @@ config RANDOMIZE_BASE
>>>
>>>             If unsure, say N.
>>>
>>> +choice
>>> +     prompt "PET RSW Bit(9) used for"
>>> +     default RISCV_HAS_PTE_DEVMEP
>>> +     depends on MMU && 64BIT
>>> +     help
>>> +       RISC-V PTE bit(9) is reserved for software, and used by more than
>>> +       one kernel features which cannot be supported at the same time.
>>> +       So we have to select one for it.
>>> +
>>> +config RISCV_HAS_PTE_DEVMEP
>>> +     bool "DEVMAP mark"
>>> +     select ARCH_HAS_PTE_DEVMAP
>>> +     help
>>> +       The PTE bit(9) is used for DEVMAP mark. ZONE_DEVICE pages need DEVMAP
>>> +       PTEs support to function.
>>> +
>>> +       So if you want to use ZONE_DEVICE, select this.
>>> +
>>> +config RISCV_HAS_SOFT_DIRTY
>>> +     bool "soft dirty"
>>> +     select HAVE_ARCH_SOFT_DIRTY
>>> +     help
>>> +       The PTE bit(9) is used for soft-dirty tracking.
>>> +
>>> +endchoice
>>> +
>> Hi, ARCH_HAS_PTE_DEVMAP will be removed in following patch, I guess
>> riscv will too:
>>
>> https://lore.kernel.org/all/47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com/
> Thanks for sharing, I didn't notice this.
> It looks like we should remove PTE_DEVMAP first and then add soft
> dirty and uffd_wp.


I have not seen any progress in the removal of PTE_DEVMAP so I'd say we 
should keep going with your patchset and we can still remove devmap later.

Thanks,

Alex


>
> Thanks,
> Chunyan
>
>>>   endmenu # "Kernel features"
>>>
>>>   menu "Boot options"
>>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
>>> index 5bcc73430829..c6d51fe9fc6f 100644
>>> --- a/arch/riscv/include/asm/pgtable-bits.h
>>> +++ b/arch/riscv/include/asm/pgtable-bits.h
>>> @@ -26,6 +26,18 @@
>>>   #define _PAGE_DEVMAP 0
>>>   #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
>>>
>>> +#ifdef CONFIG_MEM_SOFT_DIRTY
>>> +#define _PAGE_SOFT_DIRTY     (1 << 9)    /* RSW: 0x2 for software dirty tracking */
>>> +/*
>>> + * BIT 4 is not involved into swap entry computation, so we
>>> + * can borrow it for swap page soft-dirty tracking.
>>> + */
>>> +#define _PAGE_SWP_SOFT_DIRTY _PAGE_USER
>>> +#else
>>> +#define _PAGE_SOFT_DIRTY     0
>>> +#define _PAGE_SWP_SOFT_DIRTY 0
>>> +#endif /* CONFIG_MEM_SOFT_DIRTY */
>>> +
>>>   #define _PAGE_TABLE     _PAGE_PRESENT
>>>
>>>   /*
>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>> index 089f3c9f56a3..d41507919ef2 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -428,7 +428,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
>>>
>>>   static inline pte_t pte_mkdirty(pte_t pte)
>>>   {
>>> -     return __pte(pte_val(pte) | _PAGE_DIRTY);
>>> +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>>>   }
>>>
>>>   static inline pte_t pte_mkclean(pte_t pte)
>>> @@ -461,6 +461,38 @@ static inline pte_t pte_mkhuge(pte_t pte)
>>>        return pte;
>>>   }
>>>
>>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>>> +static inline int pte_soft_dirty(pte_t pte)
>>> +{
>>> +     return pte_val(pte) & _PAGE_SOFT_DIRTY;
>>> +}
>>> +
>>> +static inline pte_t pte_mksoft_dirty(pte_t pte)
>>> +{
>>> +     return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
>>> +}
>>> +
>>> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
>>> +{
>>> +     return __pte(pte_val(pte) & ~(_PAGE_SOFT_DIRTY));
>>> +}
>>> +
>>> +static inline int pte_swp_soft_dirty(pte_t pte)
>>> +{
>>> +     return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
>>> +}
>>> +
>>> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
>>> +{
>>> +     return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
>>> +}
>>> +
>>> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
>>> +{
>>> +     return __pte(pte_val(pte) & ~(_PAGE_SWP_SOFT_DIRTY));
>>> +}
>>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
>>> +
>>>   #ifdef CONFIG_RISCV_ISA_SVNAPOT
>>>   #define pte_leaf_size(pte)   (pte_napot(pte) ?                               \
>>>                                        napot_cont_size(napot_cont_order(pte)) :\
>>> @@ -751,6 +783,40 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>>>        return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>>>   }
>>>
>>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>>> +static inline int pmd_soft_dirty(pmd_t pmd)
>>> +{
>>> +     return pte_soft_dirty(pmd_pte(pmd));
>>> +}
>>> +
>>> +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
>>> +{
>>> +     return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
>>> +}
>>> +
>>> +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
>>> +{
>>> +     return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
>>> +}
>>> +
>>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> +static inline int pmd_swp_soft_dirty(pmd_t pmd)
>>> +{
>>> +     return pte_swp_soft_dirty(pmd_pte(pmd));
>>> +}
>>> +
>>> +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
>>> +{
>>> +     return pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)));
>>> +}
>>> +
>>> +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
>>> +{
>>> +     return pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)));
>>> +}
>>> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
>>> +
>>>   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>>                                pmd_t *pmdp, pmd_t pmd)
>>>   {
>>> @@ -841,6 +907,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>>    * Format of swap PTE:
>>>    *   bit            0:       _PAGE_PRESENT (zero)
>>>    *   bit       1 to 3:       _PAGE_LEAF (zero)
>>> + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
>>>    *   bit            5:       _PAGE_PROT_NONE (zero)
>>>    *   bit            6:       exclusive marker
>>>    *   bits      7 to 11:      swap type
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

