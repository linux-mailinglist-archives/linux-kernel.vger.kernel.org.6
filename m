Return-Path: <linux-kernel+bounces-227632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431659154C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA041F214D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0019E7F6;
	Mon, 24 Jun 2024 16:49:11 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992219DFAC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247750; cv=none; b=nwy3j+APl5ESe4LF4GgOi747Kqq52F5ln3HGw7fh9j8eujZrJhT8jU+o+veHXNioUGULTwLQ8nFot50DDoBBbmV7uf/9MdKnUhL/mxBYcZdET73k/VcECVi6Nxz/N2KhBq2nyJhud5bmn8NiehJyLMj1ee3vjOQvb6TDufiOywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247750; c=relaxed/simple;
	bh=txYxgv9aexeouZAxX24HGD1xP9OlV5YGUI+xJKhlIUU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BWAusdRk7WiyPXM+rARE5b/3D//Bjx1EkICA/cZ8gJ2v4f933hnXX3SzGDVHEfb2sES2Q+WZGQKgeNNETQVnTv1dJZDOQm8GxB2CX3k2pJ5s5oMC7ck6qtWs+gkZXlUIBdXkoivl0X9gKAXAdF254UdaBuHnl/xnuA+PK+8MusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E59260004;
	Mon, 24 Jun 2024 16:49:02 +0000 (UTC)
Message-ID: <4011b34a-1b86-42c7-aaf6-3bd297149f06@ghiti.fr>
Date: Mon, 24 Jun 2024 18:49:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix linear mapping checks for non-contiguous
 memory regions
From: Alexandre Ghiti <alex@ghiti.fr>
To: Stuart Menefy <stuart.menefy@codasip.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 David McKay <david.mckay@codasip.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240622114217.2158495-1-stuart.menefy@codasip.com>
 <bdfbed9b-ea04-4415-8416-d6e9d0a643a3@ghiti.fr>
 <CALEZRWE4PD2zADF1sVj++XkUan14SfDdugjse695gPqSorLgag@mail.gmail.com>
 <9bd955f3-7dbf-4d2a-8d05-82eb41083371@ghiti.fr>
Content-Language: en-US
In-Reply-To: <9bd955f3-7dbf-4d2a-8d05-82eb41083371@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 24/06/2024 13:32, Alexandre Ghiti wrote:
> On 24/06/2024 13:20, Stuart Menefy wrote:
>> On Mon, Jun 24, 2024 at 8:29 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>
>>> On 22/06/2024 13:42, Stuart Menefy wrote:
>>>> The RISC-V kernel already has checks to ensure that memory which would
>>>> lie outside of the linear mapping is not used. However those checks
>>>> use memory_limit, which is used to implement the mem= kernel command
>>>> line option (to limit the total amount of memory, not its address
>>>> range). When memory is made up of two or more non-contiguous memory
>>>> banks this check is incorrect.
>>>>
>>>> Two changes are made here:
>>>>    - add a call in setup_bootmem() to memblock_cap_memory_range() 
>>>> which
>>>>      will cause any memory which falls outside the linear mapping 
>>>> to be
>>>>      removed from the memory regions.
>>>>    - remove the check in create_linear_mapping_page_table() which was
>>>>      intended to remove memory which is outside the liner mapping 
>>>> based
>>>>      on memory_limit, as it is no longer needed. Note a check for
>>>>      mapping more memory than memory_limit (to implement mem=) is
>>>>      unnecessary because of the existing call to
>>>>      memblock_enforce_memory_limit().
>>>>
>>>> This issue was seen when booting on a SV39 platform with two memory
>>>> banks:
>>>>     0x00,80000000 1GiB
>>>>     0x20,00000000 32GiB
>>>> This memory range is 158GiB from top to bottom, but the linear mapping
>>>> is limited to 128GiB, so the lower block of RAM will be mapped at
>>>> PAGE_OFFSET, and the upper block straddles the top of the linear
>>>> mapping.
>>>>
>>>> This causes the following Oops:
>>>> [    0.000000] Linux version 6.10.0-rc2-gd3b8dd5b51dd-dirty 
>>>> (stuart.menefy@codasip.com) (riscv64-codasip-linux-gcc (GCC) 
>>>> 13.2.0, GNU ld (GNU Binutils) 2.41.0.20231213) #20 SMP Sat Jun 22 
>>>> 11:34:22 BST 2024
>>>> [    0.000000] memblock_add: 
>>>> [0x0000000080000000-0x00000000bfffffff] 
>>>> early_init_dt_add_memory_arch+0x4a/0x52
>>>> [    0.000000] memblock_add: 
>>>> [0x0000002000000000-0x00000027ffffffff] 
>>>> early_init_dt_add_memory_arch+0x4a/0x52
>>>> ...
>>>> [    0.000000] memblock_alloc_try_nid: 23724 bytes align=0x8 nid=-1 
>>>> from=0x0000000000000000 max_addr=0x0000000000000000 
>>>> early_init_dt_alloc_memory_arch+0x1e/0x48
>>>> [    0.000000] memblock_reserve: 
>>>> [0x00000027ffff5350-0x00000027ffffaffb] 
>>>> memblock_alloc_range_nid+0xb8/0x132
>>>> [    0.000000] Unable to handle kernel paging request at virtual 
>>>> address fffffffe7fff5350
>>>> [    0.000000] Oops [#1]
>>>> [    0.000000] Modules linked in:
>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
>>>> 6.10.0-rc2-gd3b8dd5b51dd-dirty #20
>>>> [    0.000000] Hardware name: codasip,a70x (DT)
>>>> [    0.000000] epc : __memset+0x8c/0x104
>>>> [    0.000000]  ra : memblock_alloc_try_nid+0x74/0x84
>>>> [    0.000000] epc : ffffffff805e88c8 ra : ffffffff806148f6 sp : 
>>>> ffffffff80e03d50
>>>> [    0.000000]  gp : ffffffff80ec4158 tp : ffffffff80e0bec0 t0 : 
>>>> fffffffe7fff52f8
>>>> [    0.000000]  t1 : 00000027ffffb000 t2 : 5f6b636f6c626d65 s0 : 
>>>> ffffffff80e03d90
>>>> [    0.000000]  s1 : 0000000000005cac a0 : fffffffe7fff5350 a1 : 
>>>> 0000000000000000
>>>> [    0.000000]  a2 : 0000000000005cac a3 : fffffffe7fffaff8 a4 : 
>>>> 000000000000002c
>>>> [    0.000000]  a5 : ffffffff805e88c8 a6 : 0000000000005cac a7 : 
>>>> 0000000000000030
>>>> [    0.000000]  s2 : fffffffe7fff5350 s3 : ffffffffffffffff s4 : 
>>>> 0000000000000000
>>>> [    0.000000]  s5 : ffffffff8062347e s6 : 0000000000000000 s7 : 
>>>> 0000000000000001
>>>> [    0.000000]  s8 : 0000000000002000 s9 : 00000000800226d0 s10: 
>>>> 0000000000000000
>>>> [    0.000000]  s11: 0000000000000000 t3 : ffffffff8080a928 t4 : 
>>>> ffffffff8080a928
>>>> [    0.000000]  t5 : ffffffff8080a928 t6 : ffffffff8080a940
>>>> [    0.000000] status: 0000000200000100 badaddr: fffffffe7fff5350 
>>>> cause: 000000000000000f
>>>> [    0.000000] [<ffffffff805e88c8>] __memset+0x8c/0x104
>>>> [    0.000000] [<ffffffff8062349c>] 
>>>> early_init_dt_alloc_memory_arch+0x1e/0x48
>>>> [    0.000000] [<ffffffff8043e892>] __unflatten_device_tree+0x52/0x114
>>>> [    0.000000] [<ffffffff8062441e>] unflatten_device_tree+0x9e/0xb8
>>>> [    0.000000] [<ffffffff806046fe>] setup_arch+0xd4/0x5bc
>>>> [    0.000000] [<ffffffff806007aa>] start_kernel+0x76/0x81a
>>>> [    0.000000] Code: b823 02b2 bc23 02b2 b023 04b2 b423 04b2 b823 
>>>> 04b2 (bc23) 04b2
>>>> [    0.000000] ---[ end trace 0000000000000000 ]---
>>>> [    0.000000] Kernel panic - not syncing: Attempted to kill the 
>>>> idle task!
>>>> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to 
>>>> kill the idle task! ]---
>>>>
>>>> The problem is that memblock (unaware that some physical memory cannot
>>>> be used) has allocated memory from the top of memory but which is
>>>> outside the linear mapping region.
>>>>
>>>> Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
>>>> Fixes: c99127c45248 ("riscv: Make sure the linear mapping does not 
>>>> use the kernel mapping")
>>>> Reviewed-by: David McKay <david.mckay@codasip.com>
>>>>
>>>> ---
>>>>    arch/riscv/mm/init.c | 15 +++++++++++----
>>>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>>> index e3405e4b99af..7e25606f858a 100644
>>>> --- a/arch/riscv/mm/init.c
>>>> +++ b/arch/riscv/mm/init.c
>>>> @@ -233,8 +233,6 @@ static void __init setup_bootmem(void)
>>>>         */
>>>>        memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>>>>
>>>> -     phys_ram_end = memblock_end_of_DRAM();
>>>> -
>>>>        /*
>>>>         * Make sure we align the start of the memory on a PMD 
>>>> boundary so that
>>>>         * at worst, we map the linear mapping with PMD mappings.
>>>> @@ -249,6 +247,16 @@ static void __init setup_bootmem(void)
>>>>        if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
>>>>                kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
>>>>
>>>> +     /*
>>>> +      * The size of the linear page mapping may restrict the 
>>>> amount of
>>>> +      * usable RAM.
>>>> +      */
>>>> +     if (IS_ENABLED(CONFIG_64BIT)) {
>>>> +             max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
>>>
>>> This is only true for sv39 once the following patch lands
>>> https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivosinc.com/ 
>>>
>> Hi Alex
>>
>> I've seen this problem whether your patch has been applied or not.
>
>
> Sure, I just meant the use of KERN_VIRT_SIZE above, sorry it was not 
> clear.
>
>
>>
>>> Otherwise, sv39 is "weirdly" restricted to 124GB. You mention in the
>>> changelog that the linear mapping size is limited to 128GB, does that
>>> mean you tested your patch on top this one ^? If so, would you mind
>>> adding a Tested-by to it? Otherwise, would you mind testing on top 
>>> of it
>>> :) ?
>> I've tested in both cases, so I'll add a Tested-by.
>
>
> Thanks!
>
>
>>
>> Note that to actually use 128GiB on Sv39 systems yet another patch is
>> needed which I'll also post.
>
>
> Ok, I'm curious! But if indeed another patch is needed, then we need 
> to merge the 3 at the same time. I'll add this other patch to my fixes 
> branch.
>
> Thanks,
>
> Alex
>
>
>>
>>> I'll see with Palmer, but maybe we can't take both patches to -fixes.
>> All three patches address different issues, so I think it would be 
>> safe to
>> take them in any combination. However I understand the reluctance
>> when making changes in this area.
>>
>> Thanks
>>
>> Stuart
>>
>>
>>> You can add:
>>>
>>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>
>>> Thanks,
>>>
>>> Alex


Actually, this patch breaks KASAN on sv39:

[    0.000000] kernel BUG at arch/riscv/mm/kasan_init.c:393!
[    0.000000] Kernel BUG [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
6.10.0-rc5-defconfig_kasan_sparsemem_vmemmmap-g018bb5470bac #1
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : kasan_shallow_populate_pud+0xf2/0x228
[    0.000000]  ra : kasan_shallow_populate_pud+0x2a/0x228
[    0.000000] epc : ffffffff81c0d2bc ra : ffffffff81c0d1f4 sp : 
ffffffff82607c60
[    0.000000]  gp : ffffffff82a79548 tp : ffffffff82615740 t0 : 
ffffffd7fefed000
[    0.000000]  t1 : ffffffd7fefec000 t2 : 0000000000000000 s0 : 
ffffffff82607ce0
[    0.000000]  s1 : ffffffff82a85ef8 a0 : 000000005fbfb001 a1 : 
0000400000000000
[    0.000000]  a2 : 0000000000000000 a3 : dfffffff00000000 a4 : 
ffffffffffffffff
[    0.000000]  a5 : 0000000000000000 a6 : ffffffd7fefecfff a7 : 
1ffffffaffdfd9ff
[    0.000000]  s2 : fffffff800000000 s3 : fffffff800000000 s4 : 
fffffff7ffffffff
[    0.000000]  s5 : ffffffff8248ab80 s6 : 0000002000000000 s7 : 
000000003fffffff
[    0.000000]  s8 : ffffffff8248ab58 s9 : ffffffff8248ab88 s10: 
ffffffff8248b20c
[    0.000000]  s11: ffffffff8248b210 t3 : fffffff9ffdfda00 t4 : 
0000000000000200
[    0.000000]  t5 : 0000000000000000 t6 : ffffffff82ac35e0
[    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 
0000000000000003
[    0.000000] [<ffffffff81c0d2bc>] kasan_shallow_populate_pud+0xf2/0x228
[    0.000000] [<ffffffff81c0d1aa>] kasan_shallow_populate_p4d+0x108/0x128
[    0.000000] [<ffffffff81c0d082>] kasan_shallow_populate_pgd+0x15a/0x17a
[    0.000000] [<ffffffff81c0bf26>] kasan_init+0x178/0x384
[    0.000000] [<ffffffff81c060c0>] setup_arch+0x90/0x10a
[    0.000000] [<ffffffff81c005b0>] start_kernel+0x5e/0x340
[    0.000000] Code: 6a46 6aa6 6b06 7be2 7c42 7ca2 7d02 6de2 6109 8082 
(9002) 0e13
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception in interrupt
[    0.000000] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt ]---


I took a quick look and the issue is that KASAN is populating the kernel 
page table but falls onto an already populated PUD entry (which is a PGD 
entry on sv39) and then bugs since this should not happen.

@Stuart: Can you take a look? A simple defconfig + KASAN run on qemu 
with sv39 triggers the issue. I'm currently investigating another 
failure with rc5 and once finished I can take over/help if needed.

Thanks,

Alex


>>>
>>>
>>>> + memblock_cap_memory_range(phys_ram_base,
>>>> +                                       max_mapped_addr - 
>>>> phys_ram_base);
>>>> +     }
>>>> +
>>>>        /*
>>>>         * Reserve physical address space that would be mapped to 
>>>> virtual
>>>>         * addresses greater than (void *)(-PAGE_SIZE) because:
>>>> @@ -265,6 +273,7 @@ static void __init setup_bootmem(void)
>>>>                memblock_reserve(max_mapped_addr, 
>>>> (phys_addr_t)-max_mapped_addr);
>>>>        }
>>>>
>>>> +     phys_ram_end = memblock_end_of_DRAM();
>>>>        min_low_pfn = PFN_UP(phys_ram_base);
>>>>        max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
>>>>        high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
>>>> @@ -1289,8 +1298,6 @@ static void __init 
>>>> create_linear_mapping_page_table(void)
>>>>                if (start <= __pa(PAGE_OFFSET) &&
>>>>                    __pa(PAGE_OFFSET) < end)
>>>>                        start = __pa(PAGE_OFFSET);
>>>> -             if (end >= __pa(PAGE_OFFSET) + memory_limit)
>>>> -                     end = __pa(PAGE_OFFSET) + memory_limit;
>>>>
>>>>                create_linear_mapping_range(start, end, 0);
>>>>        }
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

