Return-Path: <linux-kernel+bounces-335697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4782497E948
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2261F21ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E11946CD;
	Mon, 23 Sep 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ZRWpPwx1"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CE1C36
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085815; cv=none; b=fKWoq1eaZpz2nNihkIpOg3CGWlYRxvV2R8FYSLMjWSWFUOSs65S9jle2291zZXRy4gURJeZa+DHhjT4Z/X0stmZLN1HVHXWTGzhJOHF3zEhp6KX4miFVNskid0SeVNJBdSZQhWQhJhEC42czgCrDhgsT7MmfmIIX6ZvYfFC0XgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085815; c=relaxed/simple;
	bh=07Z+zGbNbn+KAtDrmMC1J1FiEZrGCC13a3HoOl4nNvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUDsJDMlv5zgQoN+y3UtoENECvJA3HiYEEciqem9IsB4oOypUxEP7iahXykcjg9PnPgLT4rSigQt/5KIaqPutvlHxGGWuM9JKRXYocAYv1DcPBPOxzrB/AAydQs79acLDIm5RcRS9gtsmJiH1KH0710+HgO9fZMghEXdgJXUueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=ZRWpPwx1; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M4vBfdM0E+Q1Eqn0D2bifpyInvcBhY39m5Q1LBNvNiI=; b=ZRWpPwx15apUUlQepYIIJSHtdD
	X8nDeTPMqwoXUHxEIjHY1E908ND0DWfxNjbqmTRVb0rN4Z80y5jqu/WCZy1oN+2mRd7G42FxGqH4B
	bcONh82F6NIXyqTw2dD9yYM4hFV+pDMd6SpEGXg2xa7cb7N1267m9/nVtf+YaF1s7x0eXDhwYBcAa
	HnD9xHHg6rtecBYrpksR4mb2huHwju+FeTaZUykTLldykV/O6AH2yWJORlnFGfyLue7QL/oV1mGi3
	lQ8n2UGWzAPF8xz+PptuCI4CjjjW6GC3BvgP+OETSEBERI+OknKictpggopydZw5NuTjdx1ywH0PV
	YrYsdaYQ==;
Received: from [167.98.27.226] (helo=[10.35.6.157])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ssfe0-002GGl-P0; Mon, 23 Sep 2024 10:46:13 +0100
Message-ID: <575583c5-5a52-461b-944a-5e32bd4b627b@codethink.co.uk>
Date: Mon, 23 Sep 2024 10:46:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
To: Drew Fustini <drew@pdp7.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: dfustini@tenstorrent.com, Conor Dooley <conor@kernel.org>,
 vladimir.kondratiev@mobileye.com, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, akpm@linux-foundation.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <Zs5c3KJR41AUVyEv@x1>
 <mhng-ff7311d0-a1e2-4487-af68-130a7efb6040@palmer-ri-x1c9>
 <Zu12G+Px2E+d26aD@x1>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <Zu12G+Px2E+d26aD@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 20/09/2024 14:18, Drew Fustini wrote:
> On Fri, Sep 20, 2024 at 01:58:23AM -0700, Palmer Dabbelt wrote:
>> On Tue, 27 Aug 2024 16:10:20 PDT (-0700), dfustini@tenstorrent.com wrote:
>>> On Tue, Aug 27, 2024 at 02:36:11PM +0300, Vladimir Kondratiev wrote:
>>>> It is not necessary any RISCV platform has ZONE_DMA32.
>>>>
>>>> Example - if platform has no DRAM in [0..4G] region,
>>>> it will report failure like below each boot.
>>>>
>>>> [    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_KERNEL|GFP_DMA32), nodemask=(null),cpuset=/
>>>> [    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 #30
>>>> [    0.088864] Call Trace:
>>>> [    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24
>>>> [    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38
>>>> [    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74
>>>> [    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c
>>>> [    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176
>>>> [    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4
>>>> [    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8
>>>> [    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e
>>>> [    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c
>>>> [    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2
>>>> [    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274
>>>> [    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a
>>>> [    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c
>>>>
>>>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
>>>> ---
>>>>   arch/riscv/Kconfig | 2 +-
>>>>   mm/Kconfig         | 2 +-
>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index 0f3cd7c3a436..94a573112625 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -50,6 +50,7 @@ config RISCV
>>>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>>>   	select ARCH_HAS_UBSAN
>>>>   	select ARCH_HAS_VDSO_DATA
>>>> +	select ARCH_HAS_ZONE_DMA_SET if 64BIT
>>>>   	select ARCH_KEEP_MEMBLOCK if ACPI
>>>>   	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>>>>   	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>>>> @@ -200,7 +201,6 @@ config RISCV
>>>>   	select THREAD_INFO_IN_TASK
>>>>   	select TRACE_IRQFLAGS_SUPPORT
>>>>   	select UACCESS_MEMCPY if !MMU
>>>> -	select ZONE_DMA32 if 64BIT
>>>>
>>>>   config CLANG_SUPPORTS_DYNAMIC_FTRACE
>>>>   	def_bool CC_IS_CLANG
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index b72e7d040f78..97c85da98e89 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1032,7 +1032,7 @@ config ZONE_DMA
>>>>   config ZONE_DMA32
>>>>   	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
>>>>   	depends on !X86_32
>>>> -	default y if ARM64
>>>> +	default y if ARM64 || (RISCV && 64BIT)
>>>>
>>>>   config ZONE_DEVICE
>>>>   	bool "Device memory (pmem, HMM, etc...) hotplug support"
>>>> --
>>>> 2.37.3
>>>>
>>>
>>> Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>
>>>
>>> Thanks for sending this patch as I've also encountered that annoying
>>> error on systems with DRAM above 4GB.
>>>
>>> I tested this patch by changing the qemu virt machine to have DRAM
>>> starting at 2^32:
>>>
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index cef41c150aaf..3033a2560edb 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c
>>> @@ -87,7 +87,7 @@ static const MemMapEntry virt_memmap[] = {
>>>       [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
>>>       [VIRT_PCIE_ECAM] =    { 0x30000000,    0x10000000 },
>>>       [VIRT_PCIE_MMIO] =    { 0x40000000,    0x40000000 },
>>> -    [VIRT_DRAM] =         { 0x80000000,           0x0 },
>>> +    [VIRT_DRAM] =        { 0x100000000,           0x0 },
>>>   };
>>>
>>>   /* PCIe high mmio is fixed for RV32 */
>>
>> IIRC the ZONE_DMA32 stuff existed for some of the early SiFive systems,
>> where the expansion daughterboard's PCIe controller (via a Xilinx FPGA)
>> could only handle 32-bit DMA addreses.  I think there's a similar quirk in
>> the Microsemi PCIe controller on the PolarFire boards, but Conor would know
>> for sure.

The Fu740 SoC has a mirror of part of DRAM in 32bit space specifically
I think for PCIe where something may be attached via a PCIe-PCI bridge.

> I don't think this patch would affect those systems that need ZONE_DMA2.
> I believe it just makes it possible to disable it in the kernel config.
> The platform I'm working on has no memory below 4GB and all the PCIe
> devices that I care about are not 32-bit constrained. Therefore I just
> want to be able to turn it off in my .config.
> 
> Thanks,
> Drew

I tried this a while ago and IIRC you run into issues with DMA
allocations from certain drivers that expect this to exist.

With new platforms that don't have any memory in DMA32 space
this may become more common. I've already had to deal with this
for an internal dev project, and it ended up having a couple of
hacks into the allocation code to silence warnings/errors.

This of course may have been fixed, given this was last year.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

