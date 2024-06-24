Return-Path: <linux-kernel+bounces-227544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4479152FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D455B25DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036419D897;
	Mon, 24 Jun 2024 15:56:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946131D53C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244598; cv=none; b=ZomTOIkxiu6Gy0esQAarDq5w5rvYsBrOCLRGUIPCb7LuMw6tfXmpPzCJTZanTI+aUI51m/wzVnQvOshhAhWNNsfNaZT2ENMV1i8B2sI10U95eMpoqJ+JQSjYRDfoucBIeRLVyBeD3/v+jPI50pMUoSRXXakHU33rt3hR82DFG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244598; c=relaxed/simple;
	bh=d/AFlUAqrAU2fR0NGsWLjNwh4L4fTroS5qrZTIbZ2HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVvGdub2886gCP0Im5INfxtpIvK/9YSSbd/OI+VnoxmD0Hp+23eUsrAisATzg/mcHxd+F7WsAcJlTsMd3SL+wRqbYAJPORzie0+51rM9hoVUQmCGQkxm0LiK11zfgLR/q+zJXW65IDwiDi2mdxFTzAgP5ZwBqmPlhzM2cLUAtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3680DA7;
	Mon, 24 Jun 2024 08:57:00 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1F73F6A8;
	Mon, 24 Jun 2024 08:56:32 -0700 (PDT)
Message-ID: <8d57ed0d-fdd0-4fc6-b9f1-a6ac11ce93ce@arm.com>
Date: Mon, 24 Jun 2024 16:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/18] arm64/mm: Automatically fold contpte mappings
Content-Language: en-GB
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Yin, Fengwei" <fengwei.yin@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-19-ryan.roberts@arm.com>
 <1285eb59-fcc3-4db8-9dd9-e7c4d82b1be0@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1285eb59-fcc3-4db8-9dd9-e7c4d82b1be0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+ Baolin Wang and Yin Fengwei, who maybe able to help with this.


Hi Kefeng,

Thanks for the report!


On 24/06/2024 15:30, Kefeng Wang wrote:
> Hi Ryan,
> 
> A big regression on page-fault3("Separate file shared mapping page
> fault") testcase from will-it-scale on arm64, no issue on x86,
> 
> ./page_fault3_processes -t 128 -s 5

I see that this program is mkstmp'ing a file at "/tmp/willitscale.XXXXXX". Based
on your description, I'm inferring that /tmp is backed by ext4 with your large
folio patches enabled?

> 
> 1) large folio disabled on ext4:
>    92378735
> 2) large folio  enabled on ext4 +  CONTPTE enabled
>    16164943
> 3) large folio  enabled on ext4 +  CONTPTE disabled
>    80364074
> 4) large folio  enabled on ext4 +  CONTPTE enabled + large folio mapping enabled
> in finish_fault()[2]
>    299656874
> 
> We found *contpte_convert* consume lots of CPU(76%) in case 2), 

contpte_convert() is expensive and to be avoided; In this case I expect it is
repainting the PTEs with the PTE_CONT bit added in, and to do that it needs to
invalidate the tlb for the virtual range. The code is there to mop up user space
patterns where each page in a range is temporarily made RO, then later changed
back. In this case, we want to re-fold the contpte range once all pages have
been serviced in RO mode.

Of course this path is only intended as a fallback, and the more optimium
approach is to set_ptes() the whole folio in one go where possible - kind of
what you are doing below.

> and disparaged
> by following change[2], it is easy to understood the different between case 2)
> and case 4) since case 2) always map one page
> size, but always try to fold contpte mappings, which spend a lot of
> time. Case 4) is a workaround, any other better suggestion?

See below.

> 
> Thanks.
> 
> [1] https://github.com/antonblanchard/will-it-scale
> [2] enable large folio mapping in finish_fault()
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 00728ea95583..5623a8ce3a1e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4880,7 +4880,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>          * approach also applies to non-anonymous-shmem faults to avoid
>          * inflating the RSS of the process.
>          */
> -       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
> +       if (unlikely(userfaultfd_armed(vma))) {

The change to make finish_fault() handle multiple pages in one go are new; added
by Baolin Wang at [1]. That extra conditional that you have removed is there to
prevent RSS reporting bloat. See discussion that starts at [2].

Anyway, it was my vague understanding that the fault around mechanism
(do_fault_around()) would ensure that (by default) 64K worth of pages get mapped
together in a single set_ptes() call, via filemap_map_pages() ->
filemap_map_folio_range(). Looking at the code, I guess fault around only
applies to read faults. This test is doing a write fault.

I guess we need to do a change a bit like what you have done, but also taking
into account fault_around configuration?

[1]
https://lore.kernel.org/all/3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/linux-mm/13939ade-a99a-4075-8a26-9be7576b7e03@arm.com/


>                 nr_pages = 1;
>         } else if (nr_pages > 1) {
>                 pgoff_t idx = folio_page_idx(folio, page);
> 
> 
> On 2024/2/15 18:32, Ryan Roberts wrote:
>> There are situations where a change to a single PTE could cause the
>> contpte block in which it resides to become foldable (i.e. could be
>> repainted with the contiguous bit). Such situations arise, for example,
>> when user space temporarily changes protections, via mprotect, for
>> individual pages, such can be the case for certain garbage collectors.
>>
>> We would like to detect when such a PTE change occurs. However this can
>> be expensive due to the amount of checking required. Therefore only
>> perform the checks when an indiviual PTE is modified via mprotect
>> (ptep_modify_prot_commit() -> set_pte_at() -> set_ptes(nr=1)) and only
>> when we are setting the final PTE in a contpte-aligned block.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h | 26 +++++++++++++
>>   arch/arm64/mm/contpte.c          | 64 ++++++++++++++++++++++++++++++++
>>   2 files changed, 90 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 8310875133ff..401087e8a43d 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1185,6 +1185,8 @@ extern void ptep_modify_prot_commit(struct
>> vm_area_struct *vma,
>>    * where it is possible and makes sense to do so. The PTE_CONT bit is
>> considered
>>    * a private implementation detail of the public ptep API (see below).
>>    */
>> +extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, pte_t pte);
>>   extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>>                   pte_t *ptep, pte_t pte);
>>   extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>> @@ -1206,6 +1208,29 @@ extern int contpte_ptep_set_access_flags(struct
>> vm_area_struct *vma,
>>                   unsigned long addr, pte_t *ptep,
>>                   pte_t entry, int dirty);
>>   +static __always_inline void contpte_try_fold(struct mm_struct *mm,
>> +                unsigned long addr, pte_t *ptep, pte_t pte)
>> +{
>> +    /*
>> +     * Only bother trying if both the virtual and physical addresses are
>> +     * aligned and correspond to the last entry in a contig range. The core
>> +     * code mostly modifies ranges from low to high, so this is the likely
>> +     * the last modification in the contig range, so a good time to fold.
>> +     * We can't fold special mappings, because there is no associated folio.
>> +     */
>> +
>> +    const unsigned long contmask = CONT_PTES - 1;
>> +    bool valign = ((addr >> PAGE_SHIFT) & contmask) == contmask;
>> +
>> +    if (unlikely(valign)) {
>> +        bool palign = (pte_pfn(pte) & contmask) == contmask;
>> +
>> +        if (unlikely(palign &&
>> +            pte_valid(pte) && !pte_cont(pte) && !pte_special(pte)))
>> +            __contpte_try_fold(mm, addr, ptep, pte);
>> +    }
>> +}
>> +
>>   static __always_inline void contpte_try_unfold(struct mm_struct *mm,
>>                   unsigned long addr, pte_t *ptep, pte_t pte)
>>   {
>> @@ -1286,6 +1311,7 @@ static __always_inline void set_ptes(struct mm_struct
>> *mm, unsigned long addr,
>>       if (likely(nr == 1)) {
>>           contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>           __set_ptes(mm, addr, ptep, pte, 1);
>> +        contpte_try_fold(mm, addr, ptep, pte);
>>       } else {
>>           contpte_set_ptes(mm, addr, ptep, pte, nr);
>>       }
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index 50e0173dc5ee..16788f07716d 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -73,6 +73,70 @@ static void contpte_convert(struct mm_struct *mm, unsigned
>> long addr,
>>       __set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>>   }
>>   +void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>> +            pte_t *ptep, pte_t pte)
>> +{
>> +    /*
>> +     * We have already checked that the virtual and pysical addresses are
>> +     * correctly aligned for a contpte mapping in contpte_try_fold() so the
>> +     * remaining checks are to ensure that the contpte range is fully
>> +     * covered by a single folio, and ensure that all the ptes are valid
>> +     * with contiguous PFNs and matching prots. We ignore the state of the
>> +     * access and dirty bits for the purpose of deciding if its a contiguous
>> +     * range; the folding process will generate a single contpte entry which
>> +     * has a single access and dirty bit. Those 2 bits are the logical OR of
>> +     * their respective bits in the constituent pte entries. In order to
>> +     * ensure the contpte range is covered by a single folio, we must
>> +     * recover the folio from the pfn, but special mappings don't have a
>> +     * folio backing them. Fortunately contpte_try_fold() already checked
>> +     * that the pte is not special - we never try to fold special mappings.
>> +     * Note we can't use vm_normal_page() for this since we don't have the
>> +     * vma.
>> +     */
>> +
>> +    unsigned long folio_start, folio_end;
>> +    unsigned long cont_start, cont_end;
>> +    pte_t expected_pte, subpte;
>> +    struct folio *folio;
>> +    struct page *page;
>> +    unsigned long pfn;
>> +    pte_t *orig_ptep;
>> +    pgprot_t prot;
>> +
>> +    int i;
>> +
>> +    if (!mm_is_user(mm))
>> +        return;
>> +
>> +    page = pte_page(pte);
>> +    folio = page_folio(page);
>> +    folio_start = addr - (page - &folio->page) * PAGE_SIZE;
>> +    folio_end = folio_start + folio_nr_pages(folio) * PAGE_SIZE;
>> +    cont_start = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>> +    cont_end = cont_start + CONT_PTE_SIZE;
>> +
>> +    if (folio_start > cont_start || folio_end < cont_end)
>> +        return;
>> +
>> +    pfn = ALIGN_DOWN(pte_pfn(pte), CONT_PTES);
>> +    prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
>> +    expected_pte = pfn_pte(pfn, prot);
>> +    orig_ptep = ptep;
>> +    ptep = contpte_align_down(ptep);
>> +
>> +    for (i = 0; i < CONT_PTES; i++) {
>> +        subpte = pte_mkold(pte_mkclean(__ptep_get(ptep)));
>> +        if (!pte_same(subpte, expected_pte))
>> +            return;
>> +        expected_pte = pte_advance_pfn(expected_pte, 1);
>> +        ptep++;
>> +    }
>> +
>> +    pte = pte_mkcont(pte);
>> +    contpte_convert(mm, addr, orig_ptep, pte);
>> +}
>> +EXPORT_SYMBOL(__contpte_try_fold);
>> +
>>   void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>>               pte_t *ptep, pte_t pte)
>>   {


