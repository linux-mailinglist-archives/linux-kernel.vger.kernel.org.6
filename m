Return-Path: <linux-kernel+bounces-226783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC069143B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C732C1F218C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1E3FE46;
	Mon, 24 Jun 2024 07:29:57 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2B2CCD0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214196; cv=none; b=D8z3tcAxotR6/A//jR5NpcM86R+R0aCYUiHVLDyGXq1XJANcgsWDrh58emkS29L2wCkrHFS7UuzUAVO1TNF/9AOl7rYjenx+dzKsSbOs4lGzRtdTbT6SHkzXJ8lsSAENgTNjorL0lDwhgZKMLiHgVvAcIgGu7TzzWvJmGwgGidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214196; c=relaxed/simple;
	bh=evkBV8NXfR+H8RduX1LcA7oWIUQWIVjeNUaMsa9digA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXeRpCRiuxXOfvFKmOSiLxXNW55AJOAREQ2aYJtffBfFHQlJ8mfFh0L3dfF/cKX+lhRNAdsdSHPiTdKhY6AJ0m0Zp+Tm+Q8QzVm8gvX9F5VIsWeo46NJwEThe/QpskSxpB/MPqfdjEMEvDPscIDj90Bs85uMLD/JX9kN2QAjIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCE1C1C0009;
	Mon, 24 Jun 2024 07:29:42 +0000 (UTC)
Message-ID: <bdfbed9b-ea04-4415-8416-d6e9d0a643a3@ghiti.fr>
Date: Mon, 24 Jun 2024 09:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix linear mapping checks for non-contiguous
 memory regions
Content-Language: en-US
To: Stuart Menefy <stuart.menefy@codasip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: David McKay <david.mckay@codasip.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240622114217.2158495-1-stuart.menefy@codasip.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240622114217.2158495-1-stuart.menefy@codasip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 22/06/2024 13:42, Stuart Menefy wrote:
> The RISC-V kernel already has checks to ensure that memory which would
> lie outside of the linear mapping is not used. However those checks
> use memory_limit, which is used to implement the mem= kernel command
> line option (to limit the total amount of memory, not its address
> range). When memory is made up of two or more non-contiguous memory
> banks this check is incorrect.
>
> Two changes are made here:
>   - add a call in setup_bootmem() to memblock_cap_memory_range() which
>     will cause any memory which falls outside the linear mapping to be
>     removed from the memory regions.
>   - remove the check in create_linear_mapping_page_table() which was
>     intended to remove memory which is outside the liner mapping based
>     on memory_limit, as it is no longer needed. Note a check for
>     mapping more memory than memory_limit (to implement mem=) is
>     unnecessary because of the existing call to
>     memblock_enforce_memory_limit().
>
> This issue was seen when booting on a SV39 platform with two memory
> banks:
>    0x00,80000000 1GiB
>    0x20,00000000 32GiB
> This memory range is 158GiB from top to bottom, but the linear mapping
> is limited to 128GiB, so the lower block of RAM will be mapped at
> PAGE_OFFSET, and the upper block straddles the top of the linear
> mapping.
>
> This causes the following Oops:
> [    0.000000] Linux version 6.10.0-rc2-gd3b8dd5b51dd-dirty (stuart.menefy@codasip.com) (riscv64-codasip-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41.0.20231213) #20 SMP Sat Jun 22 11:34:22 BST 2024
> [    0.000000] memblock_add: [0x0000000080000000-0x00000000bfffffff] early_init_dt_add_memory_arch+0x4a/0x52
> [    0.000000] memblock_add: [0x0000002000000000-0x00000027ffffffff] early_init_dt_add_memory_arch+0x4a/0x52
> ...
> [    0.000000] memblock_alloc_try_nid: 23724 bytes align=0x8 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 early_init_dt_alloc_memory_arch+0x1e/0x48
> [    0.000000] memblock_reserve: [0x00000027ffff5350-0x00000027ffffaffb] memblock_alloc_range_nid+0xb8/0x132
> [    0.000000] Unable to handle kernel paging request at virtual address fffffffe7fff5350
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc2-gd3b8dd5b51dd-dirty #20
> [    0.000000] Hardware name: codasip,a70x (DT)
> [    0.000000] epc : __memset+0x8c/0x104
> [    0.000000]  ra : memblock_alloc_try_nid+0x74/0x84
> [    0.000000] epc : ffffffff805e88c8 ra : ffffffff806148f6 sp : ffffffff80e03d50
> [    0.000000]  gp : ffffffff80ec4158 tp : ffffffff80e0bec0 t0 : fffffffe7fff52f8
> [    0.000000]  t1 : 00000027ffffb000 t2 : 5f6b636f6c626d65 s0 : ffffffff80e03d90
> [    0.000000]  s1 : 0000000000005cac a0 : fffffffe7fff5350 a1 : 0000000000000000
> [    0.000000]  a2 : 0000000000005cac a3 : fffffffe7fffaff8 a4 : 000000000000002c
> [    0.000000]  a5 : ffffffff805e88c8 a6 : 0000000000005cac a7 : 0000000000000030
> [    0.000000]  s2 : fffffffe7fff5350 s3 : ffffffffffffffff s4 : 0000000000000000
> [    0.000000]  s5 : ffffffff8062347e s6 : 0000000000000000 s7 : 0000000000000001
> [    0.000000]  s8 : 0000000000002000 s9 : 00000000800226d0 s10: 0000000000000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff8080a928 t4 : ffffffff8080a928
> [    0.000000]  t5 : ffffffff8080a928 t6 : ffffffff8080a940
> [    0.000000] status: 0000000200000100 badaddr: fffffffe7fff5350 cause: 000000000000000f
> [    0.000000] [<ffffffff805e88c8>] __memset+0x8c/0x104
> [    0.000000] [<ffffffff8062349c>] early_init_dt_alloc_memory_arch+0x1e/0x48
> [    0.000000] [<ffffffff8043e892>] __unflatten_device_tree+0x52/0x114
> [    0.000000] [<ffffffff8062441e>] unflatten_device_tree+0x9e/0xb8
> [    0.000000] [<ffffffff806046fe>] setup_arch+0xd4/0x5bc
> [    0.000000] [<ffffffff806007aa>] start_kernel+0x76/0x81a
> [    0.000000] Code: b823 02b2 bc23 02b2 b023 04b2 b423 04b2 b823 04b2 (bc23) 04b2
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> The problem is that memblock (unaware that some physical memory cannot
> be used) has allocated memory from the top of memory but which is
> outside the linear mapping region.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
> Fixes: c99127c45248 ("riscv: Make sure the linear mapping does not use the kernel mapping")
> Reviewed-by: David McKay <david.mckay@codasip.com>
>
> ---
>   arch/riscv/mm/init.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e3405e4b99af..7e25606f858a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -233,8 +233,6 @@ static void __init setup_bootmem(void)
>   	 */
>   	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>   
> -	phys_ram_end = memblock_end_of_DRAM();
> -
>   	/*
>   	 * Make sure we align the start of the memory on a PMD boundary so that
>   	 * at worst, we map the linear mapping with PMD mappings.
> @@ -249,6 +247,16 @@ static void __init setup_bootmem(void)
>   	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
>   		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
>   
> +	/*
> +	 * The size of the linear page mapping may restrict the amount of
> +	 * usable RAM.
> +	 */
> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;


This is only true for sv39 once the following patch lands 
https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivosinc.com/

Otherwise, sv39 is "weirdly" restricted to 124GB. You mention in the 
changelog that the linear mapping size is limited to 128GB, does that 
mean you tested your patch on top this one ^? If so, would you mind 
adding a Tested-by to it? Otherwise, would you mind testing on top of it 
:) ?

I'll see with Palmer, but maybe we can't take both patches to -fixes.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


> +		memblock_cap_memory_range(phys_ram_base,
> +					  max_mapped_addr - phys_ram_base);
> +	}
> +
>   	/*
>   	 * Reserve physical address space that would be mapped to virtual
>   	 * addresses greater than (void *)(-PAGE_SIZE) because:
> @@ -265,6 +273,7 @@ static void __init setup_bootmem(void)
>   		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
>   	}
>   
> +	phys_ram_end = memblock_end_of_DRAM();
>   	min_low_pfn = PFN_UP(phys_ram_base);
>   	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
>   	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
> @@ -1289,8 +1298,6 @@ static void __init create_linear_mapping_page_table(void)
>   		if (start <= __pa(PAGE_OFFSET) &&
>   		    __pa(PAGE_OFFSET) < end)
>   			start = __pa(PAGE_OFFSET);
> -		if (end >= __pa(PAGE_OFFSET) + memory_limit)
> -			end = __pa(PAGE_OFFSET) + memory_limit;
>   
>   		create_linear_mapping_range(start, end, 0);
>   	}

