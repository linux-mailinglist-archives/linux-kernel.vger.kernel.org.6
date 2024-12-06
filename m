Return-Path: <linux-kernel+bounces-434916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F019E6CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5476188427A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33781FC0E1;
	Fri,  6 Dec 2024 11:07:49 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA51EE01B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483269; cv=none; b=lF+/m4koXTZ5W4O1rwmX8dznMg9uYbRGnIRPhZsjAiAURyjVxQJDFpDGDHCXEJhSnWGlQKr/Wk13iUw9K5SKAigPeWEIt5Rk8jVGsWOP0z9Pgp0R9Lzq7LjNsmDqZbTYa6AlgJ9r9SRSMtUhO3jDK1yhVnr6kZB2rQ7hZXBIXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483269; c=relaxed/simple;
	bh=F6EqjkS2oC/iLwIQyD7hG4MdSaBIqRN2v2g1OqMQOSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZznoR74xhCJQVr20Ye6TpTzJfr46uXiakotrJyAAJlnG3MkAoy6D/L7IELVfkDgPd+cYba9/BTkc5oFmh20Xnex2jHwli8nOGx8VcQoGFkbFz327BVb9gJrx/IFXO1dYhjrLfXKFcG1WNy5kLTZkBtLThnkmLkhK1o8SkJ4uUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C508240008;
	Fri,  6 Dec 2024 11:07:39 +0000 (UTC)
Message-ID: <b72203f9-33ea-4b20-b377-6e684109846e@ghiti.fr>
Date: Fri, 6 Dec 2024 12:07:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] riscv: mm: Fix alignment of
 phys_ram_base
Content-Language: en-US
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alexghiti@rivosinc.com, bjorn@rivosinc.com, lihangjing@bytedance.com,
 xieyongji@bytedance.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241203144954.91731-1-luxu.kernel@bytedance.com>
 <edba44ad-a4b6-473d-a175-142ea49add1c@ghiti.fr>
 <CAPYmKFtAAZkY-v7Oat4dXYnm6zCcReMnDdFo3qcqtqhj1wv8eg@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAPYmKFtAAZkY-v7Oat4dXYnm6zCcReMnDdFo3qcqtqhj1wv8eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Xu,

On 06/12/2024 04:11, Xu Lu wrote:
> Hi Alex,
>
> On Thu, Dec 5, 2024 at 10:34 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Xu,
>>
>> On 03/12/2024 15:49, Xu Lu wrote:
>>> This commit fixes the alignment of phys_ram_base in RISC-V.
>>>
>>> In sparse vmemmap model, the virtual address of vmemmap is calculated as:
>>> ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
>>> And the struct page's va can be calculated with an offset:
>>> (vmemmap + (pfn)).
>>>
>>> However, when initializing struct pages, kernel actually starts from the
>>> first page from the same section that phys_ram_base belongs to. If the
>>> first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
>>> we get an va below VMEMMAP_START when calculating va for it's struct page.
>>>
>>> For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
>>> first page in the same section is actually pfn 0x80000. During
>>> init_unavailable_range(), we will initialize struct page for pfn 0x80000
>>> with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
>>> below VMEMMAP_START as well as PCI_IO_END.
>>>
>>> This commit fixes this bug by aligning phys_ram_base with SECTION_SIZE.
>>>
>>> Fixes: c3bcc65d4d2e ("riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping")
>>> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
>>> ---
>>>    arch/riscv/mm/init.c | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 0e8c20adcd98..974cafa7c85e 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -33,6 +33,9 @@
>>>    #include <asm/pgtable.h>
>>>    #include <asm/sections.h>
>>>    #include <asm/soc.h>
>>> +#ifdef CONFIG_SPARSEMEM
>>> +#include <asm/sparsemem.h>
>>> +#endif
>>>    #include <asm/tlbflush.h>
>>>
>>>    #include "../kernel/head.h"
>>> @@ -59,6 +62,12 @@ EXPORT_SYMBOL(pgtable_l4_enabled);
>>>    EXPORT_SYMBOL(pgtable_l5_enabled);
>>>    #endif
>>>
>>> +#ifdef CONFIG_SPARSEMEM
>>> +#define RISCV_MEMSTART_ALIGN (1UL << SECTION_SIZE_BITS)
>>> +#else
>>> +#define RISCV_MEMSTART_ALIGN PMD_SIZE
>>> +#endif
>>> +
>>>    phys_addr_t phys_ram_base __ro_after_init;
>>>    EXPORT_SYMBOL(phys_ram_base);
>>>
>>> @@ -239,9 +248,13 @@ static void __init setup_bootmem(void)
>>>        /*
>>>         * Make sure we align the start of the memory on a PMD boundary so that
>>>         * at worst, we map the linear mapping with PMD mappings.
>>> +      *
>>> +      * Also, make sure we align the start of the memory on a SECTION boundary
>>> +      * when CONFIG_SPARSEMEM_VMEMMAP is enabled to ensure the correctness of
>>> +      * pfn_to_page().
>>>         */
>>>        if (!IS_ENABLED(CONFIG_XIP_KERNEL))
>>> -             phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
>>> +             phys_ram_base = round_down(memblock_start_of_DRAM(), RISCV_MEMSTART_ALIGN);
>>>
>>>        /*
>>>         * In 64-bit, any use of __va/__pa before this point is wrong as we
>>
>> That's a good catch indeed. But I'm wondering if it would be more
>> correct to fix the macro vmemmap instead of phys_ram_base since
>> phys_ram_base is supposed to hold the real base of the system memory,
>> which would be wrong with your patch. I mean something like that instead
>> (or similar, I haven't tested):
>>
>> #define vmemmap         ((struct page *)VMEMMAP_START -
>> (round_down(memblock_start_of_DRAM(), RISCV_MEMSTART_ALIGN) >> PAGE_SHIFT))
> Thanks for your comment.
>
> Good idea. I have thought about this. But I wasn't sure if it's OK to
> introduce extra calculation whenever pfn_to_page() and page_to_pfn()
> is called. So I referred to ARM which aligns memstart_addr with
> SECTION size too and then made a similar modification.
>
> If it is not appropriate to change the semantics of phys_ram_base, how
> about introducing a new variable vmemmap_start_addr and use it to
> calculate vmemmap:
>
> #define vmemmap         ((struct page *)VMEMMAP_START -
> (vmemmap_start_addr >> PAGE_SHIFT))


I agree, that's a good idea to introduce vmemmap_start_addr.

Thanks,

Alex


>
> Best Regards,
>
> Xu Lu
>
>> And the fixes tag should be:
>>
>> Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
>>
>> Thanks,
>>
>> Alex
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

