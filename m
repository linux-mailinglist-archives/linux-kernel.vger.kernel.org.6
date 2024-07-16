Return-Path: <linux-kernel+bounces-253790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114A932706
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069562830B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964419AD6A;
	Tue, 16 Jul 2024 13:00:54 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8471420B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134854; cv=none; b=EO0PN/SNXXoj3LgiSXDGjNC9jgCLj2VV4Zi3iP1F9zsw1j0d0H2obnFfIchlGz27i512PulgrrAuLGgT3ANa6xdWg5ZCOobW2MSsTPeJMn575Fv4GNN5L3jWsjc1h/UaIR7d5X2CzgQLtoouwMoscwFsUVx8lK7TxhiP+D9fUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134854; c=relaxed/simple;
	bh=ovl5SQw4Z4rxZvdejcVf5J2UO0tSAxZXxqEmpLjPYBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfpsVyRCY01oAWrPrWKyeIxnbROW0ck5cprp9CMGHs1adcT2KtsJzXM5DZYU0bv2fsqsm/V9Iu6lPsjG5ZIFAwIRiUkYWlRbVHM96pJ1/eC8QFME2vsKNK3ECzOa4G2XMRjAMALvaZbipxsqUkJz/SxZwVA4sf7YrX1L4iH14fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D73B7C0003;
	Tue, 16 Jul 2024 13:00:39 +0000 (UTC)
Message-ID: <cab9dc95-c40c-4c4e-a91d-5698cbd5b4d2@ghiti.fr>
Date: Tue, 16 Jul 2024 15:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/mm: Add soft-dirty page tracking support
Content-Language: en-US
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20240710033004.3923527-1-zhangchunyan@iscas.ac.cn>
 <9bf70f7c-5deb-4fce-b7c1-ec70d78cb5db@ghiti.fr>
 <CAAfSe-vhhVvP5Sa9bGGSw4ZQvexqUrjdTFjJL-4gLn0jsuk0ew@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAAfSe-vhhVvP5Sa9bGGSw4ZQvexqUrjdTFjJL-4gLn0jsuk0ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 16/07/2024 04:16, Chunyan Zhang wrote:
> Hi Alex,
>
> On Mon, 15 Jul 2024 at 19:21, Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Chunyan,
>>
>> On 10/07/2024 05:30, Chunyan Zhang wrote:
>>> The PTE bit (9) is reserved for software, so we can use it for
>>> soft-dirty tracking. This patch adds its standard handlers for
>>> PTE, PMD, and swap entry.
>>
>> Unfortunately, ZONE_DEVICE has just used this last bit and should be
>> merged in 6.11.
> Yes, I read the patch just now.
>
>> I'm currently discussing internally how we can get 2 other PTE bits from
>> RVI in order to have the same number of available bits as x86 and arm64.
> Yes I noticed that PTE bits reserved for software are too limited on RISC-V.
>
> Besides softdirty, we probably can support uffd write-protect on
> RISC-V if we will have two PTE bits for use.


Indeed, softdirty and uffd-wp will use two PTE bits.


>
>> I guess that for now, if we really have a usecase for softdirty (and I
>> think we do with CRIU), we'll have to make ZONE_DEVICE and soft-dirty
>> mutually exclusive.
> Yes, I also learned that CRIU uses soft-dirty.
>
>>> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
>>> available for swap PTEs on RISC-V systems.
>>>
>>> This patch has been tested with the kselftest mm suite in which
>>> soft-dirty and madv_populate run and pass, and no regressions
>>> are observed in any of the other tests.
>>
>> Did you give CRIU a try?
> I haven't tried CRIU, actually I found soft-dirty was missing on
> RISC-V by the way of running mm selftest cases.


Since CRIU is the main user (?) of softdirty, it would be really nice if 
you can test it :)


>
> I can cook a new patch to implement soft-dirty and ZONE_DEVICE share
> the PTE bit(9), and make both features mutually exclusive if this
> solution is accepted.


I agree with this solution, let's implement both softdirty and uffd-wp 
by sharing the last PTE bit that ZONE_DEVICE stole. At least it will 
allow people to play with them.

Do you intend to work on uffd-wp? This is on my todo list, so up to you.


>
> Or not to add soft-dirty until we have more other PTE bits that can be
> used for software.
>
> I'm open to listen to suggestions.
>
> Thanks,
> Chunyan


Thanks,

Alex


>
>> Thanks,
>>
>> Alex
>>
>>
>>> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
>>> ---
>>>    arch/riscv/Kconfig                    |  1 +
>>>    arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
>>>    arch/riscv/include/asm/pgtable.h      | 65 ++++++++++++++++++++++++++-
>>>    3 files changed, 78 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index b94176e25be1..2e3ad2925a6b 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -118,6 +118,7 @@ config RISCV
>>>        select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>>>        select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>>>        select HAVE_ARCH_SECCOMP_FILTER
>>> +     select HAVE_ARCH_SOFT_DIRTY
>>>        select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>>        select HAVE_ARCH_TRACEHOOK
>>>        select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
>>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
>>> index 179bd4afece4..bab48f5fd1e2 100644
>>> --- a/arch/riscv/include/asm/pgtable-bits.h
>>> +++ b/arch/riscv/include/asm/pgtable-bits.h
>>> @@ -19,6 +19,19 @@
>>>    #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>>>
>>>    #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
>>> +
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
>>>    #define _PAGE_TABLE     _PAGE_PRESENT
>>>
>>>    /*
>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>> index aad8b8ca51f1..46f512f52580 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -408,7 +408,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
>>>
>>>    static inline pte_t pte_mkdirty(pte_t pte)
>>>    {
>>> -     return __pte(pte_val(pte) | _PAGE_DIRTY);
>>> +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>>>    }
>>>
>>>    static inline pte_t pte_mkclean(pte_t pte)
>>> @@ -436,6 +436,36 @@ static inline pte_t pte_mkhuge(pte_t pte)
>>>        return pte;
>>>    }
>>>
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
>>> +
>>>    #ifdef CONFIG_RISCV_ISA_SVNAPOT
>>>    #define pte_leaf_size(pte)  (pte_napot(pte) ?                               \
>>>                                        napot_cont_size(napot_cont_order(pte)) :\
>>> @@ -721,6 +751,38 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>>>        return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
>>>    }
>>>
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
>>> +
>>>    static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>>                                pmd_t *pmdp, pmd_t pmd)
>>>    {
>>> @@ -811,6 +873,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>>     * Format of swap PTE:
>>>     *  bit            0:       _PAGE_PRESENT (zero)
>>>     *  bit       1 to 3:       _PAGE_LEAF (zero)
>>> + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
>>>     *  bit            5:       _PAGE_PROT_NONE (zero)
>>>     *  bit            6:       exclusive marker
>>>     *  bits      7 to 11:      swap type
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

