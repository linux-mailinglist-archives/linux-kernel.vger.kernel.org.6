Return-Path: <linux-kernel+bounces-371022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6A9A3546
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E941C23B69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BBE18132F;
	Fri, 18 Oct 2024 06:23:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACD173326
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232628; cv=none; b=uI/U1eZgvjWPwBkMRarE2fdIfHAqGAVRO4sH4IT4ZjMPbrJOfU99gxxJyJ9tCNmXxDKoWrCs7S/TBvwkSm1LTtOPwJFZqXpv68qHQvLxLtRvjLGfnGXZfMPYr5EVFVgp8hWZAxaoXXTRNGHd+6ouehWs7wUZR3xaSa/9PMC63Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232628; c=relaxed/simple;
	bh=te1Ei0pSdS7pCOEI54u+uq2va7D7QsDeord9+Fb9wMY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lWmRN7c032NQMk6EgAZcOWeMVHyDodIrFNVridmKl1Q84gT5+0Rl/ZfhgVwEsMyh/AJxE43Kmx8v5A0ZE08ng9vlD9liZ16SZ3JvoPK+8H4khSvDAbaSRWF1aMosy+D5dlcSx+aV/wHbEO+HAsWzUsW3HAncgGwGBdJzZDEaglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxFOnu_hFnzmsjAA--.52683S3;
	Fri, 18 Oct 2024 14:23:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxSebi_hFn8IEvAA--.29158S3;
	Fri, 18 Oct 2024 14:23:33 +0800 (CST)
Subject: Re: [PATCH v2 1/3] LoongArch: Set initial pte entry with PAGE_GLOBAL
 for kernel space
To: Huacai Chen <chenhuacai@kernel.org>, wuruiyang@loongson.cn
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20241014035855.1119220-1-maobibo@loongson.cn>
 <20241014035855.1119220-2-maobibo@loongson.cn>
 <CAAhV-H5QkULWp6fciR1Lnds0r00fUdrmj86K_wBuxd0D=RkaXQ@mail.gmail.com>
 <f3089991-fd49-8d55-9ede-62ab1555c9fa@loongson.cn>
 <CAAhV-H7yX6qinPL5E5tmNVpJk_xdKqFaSicUYy2k8NGM1owucw@mail.gmail.com>
 <a4c6b89e-4ffe-4486-4ccd-7ebc28734f6f@loongson.cn>
 <CAAhV-H6FkJZwa-pALUhucrU5OXxsHg+ByM+4NN0wPQgOJTqOXA@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <5f76ede6-e8be-c7a9-f957-479afa2fb828@loongson.cn>
Date: Fri, 18 Oct 2024 14:23:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6FkJZwa-pALUhucrU5OXxsHg+ByM+4NN0wPQgOJTqOXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSebi_hFn8IEvAA--.29158S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3try8Xr4fAF45Wr1DZFWUAwc_yoWkAw1Upr
	yDCF1kAF4UXr1UJwsFqw1jqrnrtwn7KF4IgF17Gr15AFnFqFnrJr1UJry5uF18J3yUG3W0
	vr1rKw13WF1UJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
	UUU



On 2024/10/18 下午12:23, Huacai Chen wrote:
> On Fri, Oct 18, 2024 at 12:16 PM maobibo <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2024/10/18 下午12:11, Huacai Chen wrote:
>>> On Fri, Oct 18, 2024 at 11:44 AM maobibo <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/10/18 上午11:14, Huacai Chen wrote:
>>>>> Hi, Bibo,
>>>>>
>>>>> I applied this patch but drop the part of arch/loongarch/mm/kasan_init.c:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/commit/?h=loongarch-next&id=15832255e84494853f543b4c70ced50afc403067
>>>>>
>>>>> Because kernel_pte_init() should operate on page-table pages, not on
>>>>> data pages. You have already handle page-table page in
>>>>> mm/kasan/init.c, and if we don't drop the modification on data pages
>>>>> in arch/loongarch/mm/kasan_init.c, the kernel fail to boot if KASAN is
>>>>> enabled.
>>>>>
>>>> static inline void set_pte(pte_t *ptep, pte_t pteval)
>>>>     {
>>>>           WRITE_ONCE(*ptep, pteval);
>>>> -
>>>> -       if (pte_val(pteval) & _PAGE_GLOBAL) {
>>>> -               pte_t *buddy = ptep_buddy(ptep);
>>>> -               /*
>>>> -                * Make sure the buddy is global too (if it's !none,
>>>> -                * it better already be global)
>>>> -                */
>>>> -               if (pte_none(ptep_get(buddy))) {
>>>> -#ifdef CONFIG_SMP
>>>> -                       /*
>>>> -                        * For SMP, multiple CPUs can race, so we need
>>>> -                        * to do this atomically.
>>>> -                        */
>>>> -                       __asm__ __volatile__(
>>>> -                       __AMOR "$zero, %[global], %[buddy] \n"
>>>> -                       : [buddy] "+ZB" (buddy->pte)
>>>> -                       : [global] "r" (_PAGE_GLOBAL)
>>>> -                       : "memory");
>>>> -
>>>> -                       DBAR(0b11000); /* o_wrw = 0b11000 */
>>>> -#else /* !CONFIG_SMP */
>>>> -                       WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(buddy)) | _PAGE_GLOBAL));
>>>> -#endif /* CONFIG_SMP */
>>>> -               }
>>>> -       }
>>>> +       DBAR(0b11000); /* o_wrw = 0b11000 */
>>>>     }
>>>>
>>>> No, please hold on. This issue exists about twenty years, Do we need be
>>>> in such a hurry now?
>>>>
>>>> why is DBAR(0b11000) added in set_pte()?
>>> It exists before, not added by this patch. The reason is explained in
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.12-rc3&id=f93f67d06b1023313ef1662eac490e29c025c030
>> why speculative accesses may cause spurious page fault in kernel space
>> with PTE enabled?  speculative accesses exists anywhere, it does not
>> cause spurious page fault.
> Confirmed by Ruiyang Wu, and even if DBAR(0b11000) is wrong, that
> means another patch's mistake, not this one. This one just keeps the
> old behavior.
> +CC Ruiyang Wu here.
Also from Ruiyang Wu, the information is that speculative accesses may 
insert stale TLB, however no page fault exception.

So adding barrier in set_pte() does not prevent speculative accesses. 
And you write patch here, however do not know the actual reason?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.12-rc3&id=f93f67d06b1023313ef1662eac490e29c025c030

Bibo Mao
> 
> Huacai
> 
>>
>> Obvious you do not it and you write wrong patch.
>>
>>>
>>> Huacai
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>> Huacai
>>>>>
>>>>> On Mon, Oct 14, 2024 at 11:59 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> Unlike general architectures, there are two pages in one TLB entry
>>>>>> on LoongArch system. For kernel space, it requires both two pte
>>>>>> entries with PAGE_GLOBAL bit set, else HW treats it as non-global
>>>>>> tlb, there will be potential problems if tlb entry for kernel space
>>>>>> is not global. Such as fail to flush kernel tlb with function
>>>>>> local_flush_tlb_kernel_range() which only flush tlb with global bit.
>>>>>>
>>>>>> With function kernel_pte_init() added, it can be used to init pte
>>>>>> table when it is created for kernel address space, and the default
>>>>>> initial pte value is PAGE_GLOBAL rather than zero at beginning.
>>>>>>
>>>>>> Kernel address space areas includes fixmap, percpu, vmalloc, kasan
>>>>>> and vmemmap areas set default pte entry with PAGE_GLOBAL set.
>>>>>>
>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>> ---
>>>>>>     arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
>>>>>>     arch/loongarch/include/asm/pgtable.h |  1 +
>>>>>>     arch/loongarch/mm/init.c             |  4 +++-
>>>>>>     arch/loongarch/mm/kasan_init.c       |  4 +++-
>>>>>>     arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++++++++++
>>>>>>     include/linux/mm.h                   |  1 +
>>>>>>     mm/kasan/init.c                      |  8 +++++++-
>>>>>>     mm/sparse-vmemmap.c                  |  5 +++++
>>>>>>     8 files changed, 55 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
>>>>>> index 4e2d6b7ca2ee..b2698c03dc2c 100644
>>>>>> --- a/arch/loongarch/include/asm/pgalloc.h
>>>>>> +++ b/arch/loongarch/include/asm/pgalloc.h
>>>>>> @@ -10,8 +10,21 @@
>>>>>>
>>>>>>     #define __HAVE_ARCH_PMD_ALLOC_ONE
>>>>>>     #define __HAVE_ARCH_PUD_ALLOC_ONE
>>>>>> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
>>>>>>     #include <asm-generic/pgalloc.h>
>>>>>>
>>>>>> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>>>>> +{
>>>>>> +       pte_t *pte;
>>>>>> +
>>>>>> +       pte = (pte_t *) __get_free_page(GFP_KERNEL);
>>>>>> +       if (!pte)
>>>>>> +               return NULL;
>>>>>> +
>>>>>> +       kernel_pte_init(pte);
>>>>>> +       return pte;
>>>>>> +}
>>>>>> +
>>>>>>     static inline void pmd_populate_kernel(struct mm_struct *mm,
>>>>>>                                           pmd_t *pmd, pte_t *pte)
>>>>>>     {
>>>>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>>>>>> index 9965f52ef65b..22e3a8f96213 100644
>>>>>> --- a/arch/loongarch/include/asm/pgtable.h
>>>>>> +++ b/arch/loongarch/include/asm/pgtable.h
>>>>>> @@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pm
>>>>>>     extern void pgd_init(void *addr);
>>>>>>     extern void pud_init(void *addr);
>>>>>>     extern void pmd_init(void *addr);
>>>>>> +extern void kernel_pte_init(void *addr);
>>>>>>
>>>>>>     /*
>>>>>>      * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
>>>>>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
>>>>>> index 8a87a482c8f4..9f26e933a8a3 100644
>>>>>> --- a/arch/loongarch/mm/init.c
>>>>>> +++ b/arch/loongarch/mm/init.c
>>>>>> @@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
>>>>>>            if (!pmd_present(pmdp_get(pmd))) {
>>>>>>                    pte_t *pte;
>>>>>>
>>>>>> -               pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>>>>>> +               pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>>>>>>                    if (!pte)
>>>>>>                            panic("%s: Failed to allocate memory\n", __func__);
>>>>>> +
>>>>>> +               kernel_pte_init(pte);
>>>>>>                    pmd_populate_kernel(&init_mm, pmd, pte);
>>>>>>            }
>>>>>>
>>>>>> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
>>>>>> index 427d6b1aec09..34988573b0d5 100644
>>>>>> --- a/arch/loongarch/mm/kasan_init.c
>>>>>> +++ b/arch/loongarch/mm/kasan_init.c
>>>>>> @@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
>>>>>>                    phys_addr_t page_phys = early ?
>>>>>>                                            __pa_symbol(kasan_early_shadow_page)
>>>>>>                                                  : kasan_alloc_zeroed_page(node);
>>>>>> +               if (!early)
>>>>>> +                       kernel_pte_init(__va(page_phys));
>>>>>>                    next = addr + PAGE_SIZE;
>>>>>>                    set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
>>>>>>            } while (ptep++, addr = next, addr != end && __pte_none(early, ptep_get(ptep)));
>>>>>> @@ -287,7 +289,7 @@ void __init kasan_init(void)
>>>>>>                    set_pte(&kasan_early_shadow_pte[i],
>>>>>>                            pfn_pte(__phys_to_pfn(__pa_symbol(kasan_early_shadow_page)), PAGE_KERNEL_RO));
>>>>>>
>>>>>> -       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>>>>>> +       kernel_pte_init(kasan_early_shadow_page);
>>>>>>            csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_CSR_PGDH);
>>>>>>            local_flush_tlb_all();
>>>>>>
>>>>>> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
>>>>>> index eb6a29b491a7..228ffc1db0a3 100644
>>>>>> --- a/arch/loongarch/mm/pgtable.c
>>>>>> +++ b/arch/loongarch/mm/pgtable.c
>>>>>> @@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(pgd_alloc);
>>>>>>
>>>>>> +void kernel_pte_init(void *addr)
>>>>>> +{
>>>>>> +       unsigned long *p, *end;
>>>>>> +       unsigned long entry;
>>>>>> +
>>>>>> +       entry = (unsigned long)_PAGE_GLOBAL;
>>>>>> +       p = (unsigned long *)addr;
>>>>>> +       end = p + PTRS_PER_PTE;
>>>>>> +
>>>>>> +       do {
>>>>>> +               p[0] = entry;
>>>>>> +               p[1] = entry;
>>>>>> +               p[2] = entry;
>>>>>> +               p[3] = entry;
>>>>>> +               p[4] = entry;
>>>>>> +               p += 8;
>>>>>> +               p[-3] = entry;
>>>>>> +               p[-2] = entry;
>>>>>> +               p[-1] = entry;
>>>>>> +       } while (p != end);
>>>>>> +}
>>>>>> +
>>>>>>     void pgd_init(void *addr)
>>>>>>     {
>>>>>>            unsigned long *p, *end;
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index ecf63d2b0582..6909fe059a2c 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -3818,6 +3818,7 @@ void *sparse_buffer_alloc(unsigned long size);
>>>>>>     struct page * __populate_section_memmap(unsigned long pfn,
>>>>>>                    unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>>>>>>                    struct dev_pagemap *pgmap);
>>>>>> +void kernel_pte_init(void *addr);
>>>>>>     void pmd_init(void *addr);
>>>>>>     void pud_init(void *addr);
>>>>>>     pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
>>>>>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>>>>>> index 89895f38f722..ac607c306292 100644
>>>>>> --- a/mm/kasan/init.c
>>>>>> +++ b/mm/kasan/init.c
>>>>>> @@ -106,6 +106,10 @@ static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
>>>>>>            }
>>>>>>     }
>>>>>>
>>>>>> +void __weak __meminit kernel_pte_init(void *addr)
>>>>>> +{
>>>>>> +}
>>>>>> +
>>>>>>     static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
>>>>>>                                    unsigned long end)
>>>>>>     {
>>>>>> @@ -126,8 +130,10 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
>>>>>>
>>>>>>                            if (slab_is_available())
>>>>>>                                    p = pte_alloc_one_kernel(&init_mm);
>>>>>> -                       else
>>>>>> +                       else {
>>>>>>                                    p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>>>>>> +                               kernel_pte_init(p);
>>>>>> +                       }
>>>>>>                            if (!p)
>>>>>>                                    return -ENOMEM;
>>>>>>
>>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>>>> index edcc7a6b0f6f..c0388b2e959d 100644
>>>>>> --- a/mm/sparse-vmemmap.c
>>>>>> +++ b/mm/sparse-vmemmap.c
>>>>>> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
>>>>>>            return p;
>>>>>>     }
>>>>>>
>>>>>> +void __weak __meminit kernel_pte_init(void *addr)
>>>>>> +{
>>>>>> +}
>>>>>> +
>>>>>>     pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>>>>>>     {
>>>>>>            pmd_t *pmd = pmd_offset(pud, addr);
>>>>>> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>>>>>>                    void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>>>>>>                    if (!p)
>>>>>>                            return NULL;
>>>>>> +               kernel_pte_init(p);
>>>>>>                    pmd_populate_kernel(&init_mm, pmd, p);
>>>>>>            }
>>>>>>            return pmd;
>>>>>> --
>>>>>> 2.39.3
>>>>>>
>>>>
>>>>
>>
>>


