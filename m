Return-Path: <linux-kernel+bounces-521772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D8A3C21B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD68F3A2F86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357F1E0086;
	Wed, 19 Feb 2025 14:26:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E61DA4E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975210; cv=none; b=emgbhvarPKMDEukbKMzFIJw70uRY9B6GHaG9JS/HcMhNUrMOxwMj+htBxUexQ24x2sYe28ru2/0O3grsRLKAOnCPTy1kIHPn3tUmdMs0+Ban5+4kMjR/x735p+vmHvuglYsioPtkhgbz3XF1xFgjFg9qZgRw3SVdeijCE4Do9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975210; c=relaxed/simple;
	bh=FUcRJTr1npRgmQHUP4ZQJh6Rk/k7epdplMPjqYGkgBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF/2FoSqGK+arpd+2SKMxwZx7qfU9HfXO46wJxiayo4tb3sETVcH/cPV89X/QDL3lVpcsc0Ykrk/WRfVXYKF8/it+dRpfADq96pCqa4Ws4HpPZMjcINdH/kM4JuzCPoto3lq7l7zB0nrbEh/VHikqWS0H8KwRE3T3jKPT3Strpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CB4212FC;
	Wed, 19 Feb 2025 06:27:05 -0800 (PST)
Received: from [10.57.84.233] (unknown [10.57.84.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08CE03F59E;
	Wed, 19 Feb 2025 06:26:45 -0800 (PST)
Message-ID: <cf2b32a4-2217-4a31-b6d7-e60a9f4ef7dd@arm.com>
Date: Wed, 19 Feb 2025 14:26:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at arch/arm64/mm/mmu.c:185!
Content-Language: en-GB
To: Luiz Capitulino <luizcap@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: ardb@kernel.org
References: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
 <fe95f4c8-4b09-4d8e-99c9-987ddc2761e3@arm.com>
 <9f5600b3-6525-4045-ad1f-4408dfc9ce0f@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9f5600b3-6525-4045-ad1f-4408dfc9ce0f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/02/2025 14:16, Luiz Capitulino wrote:
> On 2025-02-19 03:41, Ryan Roberts wrote:
>> On 19/02/2025 02:27, Luiz Capitulino wrote:
>>> Hi,
>>>
>>> I'm getting the crash below with Linus tree commit
>>> 2408a807bfc3f738850ef5ad5e3fd59d66168996 on a Ampere Mt. Jade with two sockets
>>> (backtrace below).
>>
>> Thanks for the bug report, I'll take a look this morning, but I'm off work
>> tomorrow and Friday so if I can't figure it out before end of day I won't be
>> able to look again until Monday, unless someone can pick it up in the meantime.
> 
> No rush at all. Please, enjoy your time off :)

Afraid I've run out of time on this for today, so adding some details below. 
I'll come back to it next week unless someone else steps in.

> 
>> Anyway, is there a specific config you're compiling for? And what about kernel
>> command line args?
> 
> Config is attached. The kernel command-line is:
> 
> """
> ro crashkernel=1G-4G:406M,4G-64G:470M,64G-:726M rd.lvm.lv=cs_ampere-mtjade-
> altra-03/root rd.lvm.lv=cs_ampere-mtjade-altra-03/swap
> earlycon=pl011,mmio,0x100002600000
> """
> 
>> Is it 100% reproducible for you?
> 
> That is a good question. Right now it is (just tried again with latest Linus
> tree 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2). But I do have the recollection
> that I was able to boot a bad kernel a few times.
> 
> Btw, I'll try to bisect again and will also try to update the system's firmware
> just in case.
> 
>> How much RAM does your system have? (I have 2
>> socket Mt. Jade with 512G; I'll try to repro on that).
> 
> Mine is 512G, maybe we're lucky and it's the same system.
> 
>>> It happens very early during boot. Passing 'nokaslr' in the command-line works
>>> around the issue (ie. I can boot and use the system normally). Doesn't seem to
>>> happen with 6.13. I tried bisecting it but got nowhere...
>>>
>>> [    0.000000] ------------[ cut here ]------------
>>> [    0.000000] kernel BUG at arch/arm64/mm/mmu.c:185!
>>
>> This is:
>>
>> /*
>>   * After the PTE entry has been populated once, we
>>   * only allow updates to the permission attributes.
>>   */
>> BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(__ptep_get(ptep))));
>>
>> So we have a valid -> valid PTE transition where either the PFNs are changing,
>> we are trying to change permissions on a contiguous entry, we are trying to
>> transition from non-global to global, or we are trying to change other
>> explicitly disallowed bits.
>>
>>> [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>> [    0.000000] Modules linked in:
>>> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc3+ #8
>>> [    0.000000] pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [    0.000000] pc : alloc_init_cont_pte+0x20c/0x3d0
>>> [    0.000000] lr : alloc_init_cont_pte+0x204/0x3d0
>>> [    0.000000] sp : ffffb45836ec78b0
>>> [    0.000000] x29: ffffb45836ec7940 x28: ffff6fea00000000 x27: 0068000000000f07
>>> [    0.000000] x26: ffff6fea00200000 x25: 0000400000000000 x24: ffffffffff433000
>>> [    0.000000] x23: dfff800000000000 x22: 0000d01600000000 x21: 0068000000000f07
>>> [    0.000000] x20: ffff6fea00000000 x19: ffff6fea00010000 x18: 00000000ae5a3fb1
>>> [    0.000000] x17: 0000000000001114 x16: 00000000bfc60000 x15: 0000000000000200
>>> [    0.000000] x14: 0000000000000000 x13: 1ffff68b06dd8f1c x12: 00000000f1f1f1f1
>>> [    0.000000] x11: ffff768b06dd8f1c x10: ffffb45835a1ca38 x9 : 0000000000000000
>>> [    0.000000] x8 : 0000000041b58ab3 x7 : 0000000000000000 x6 : 0000000000000000
>>> [    0.000000] x5 : 006840000a861f07 x4 : 000000000000a861 x3 : 000000000000a861
>>> [    0.000000] x2 : 006840000a861f03 x1 : 0068400000000f07 x0 : 0000000000000000
>>> [    0.000000] Call trace:
>>> [    0.000000]  alloc_init_cont_pte+0x20c/0x3d0 (P)
>>> [    0.000000]  alloc_init_cont_pmd+0x20c/0x4d0
>>> [    0.000000]  alloc_init_pud+0x244/0x400
>>> [    0.000000]  create_kpti_ng_temp_pgd+0xf8/0x1c8
>>
>> This is an alias for __create_pgd_mapping_locked() so I suspect we are actually
>> in __map_memblock().
>>
>>> [    0.000000]  map_mem.constprop.0+0x1d8/0x3b8
>>> [    0.000000]  paging_init+0x98/0x330
>>> [    0.000000]  setup_arch+0xac/0x170
>>> [    0.000000]  start_kernel+0x74/0x3c8
>>> [    0.000000]  __primary_switched+0x8c/0xa0
>>> [    0.000000] Code: f9400301 97ffff64 72001c1f 54fffe21 (d4210000)
>>> [    0.000000] ---[ end trace 0000000000000000 ]---
>>> [    0.000000] Kernel panic - not syncing: Oops - BUG: Fatal exception
>>> [    0.000000] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal
>>> exception ]---
>>>
>>
>> So I guess either we are setting a PTE entry into a table for the first time,
>> where somehow the table has not been initially cleared (very unlikely) or we are
>> trying to update the permissions of an already mapped pte. In that latter case,
>> I think we should only be remapping the kernel image portion of the linear map.
>>
>> I can't see any obvious recent changes in this area. I'll see if I can repro and
>> poke around a bit more.
> 
> OK, maybe you'll be able to reproduce with the config I'm attaching.

I can reproduce _a_ panic, but it's different from the one you shared. I'm 
running defconfig on Ampere Altra with 2 sockets and 512G RAM. It appears to 
repro reliably as long as kaslr is enabled.

I tried reproduing on VM, but with no luck. I suspect there is something about 
the physical layout of memory that provokes the bug. I tried to force the memory 
layout to match Altra using kvmtool but it only supports a single physical 
region currently. And merging all the regions into 1 uber region is too big and 
the VMM fails. So I think we are stuck having to keep rebooting the bare metal.

The first warning is due to getting a PFN that's outside the bounds of supported 
PFNs:

Loading Linux 6.14.0-rc3-00012-g2408a807bfc3 ...                                
Loading initial ramdisk ...                                                     
EFI stub: Booting Linux Kernel...                                               
EFI stub: WARNING: Working around broken SetVirtualAddressMap()                 
EFI stub: Using DTB from configuration table                                    
EFI stub: Exiting boot services...                                              
[    0.000000] Booting Linux on physical CPU 0x0000120000 [0x413fd0c1]          
[    0.000000] Linux version 6.14.0-rc3-00012-g2408a807bfc3 (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT @1739817505                         
[    0.000000] KASLR enabled                                                    
[    0.000000] earlycon: pl11 at MMIO 0x0000100002600000 (options '')           
[    0.000000] printk: legacy bootconsole [pl11] enabled                        
[    0.000000] efi: EFI v2.7 by American Megatrends                             
[    0.000000] efi: ACPI 2.0=0xaf170000 SMBIOS 3.0=0xb2e6ff98 MEMATTR=0xa9568298 ESRT=0xa9659f98 RNG=0xaefb0018 MEMRESERVE=0xa9656918 
[    0.000000] random: crng init done                                           
[    0.000000] esrt: Reserving ESRT space from 0x00000000a9659f98 to 0x00000000a9659fd0.
[    0.000000] ACPI: Early table checksum verification disabled                 
[    0.000000] ACPI: RSDP 0x00000000AF170000 000024 (v02 Ampere)               
[    0.000000] ACPI: XSDT 0x00000000AF160000 0000D4 (v01 Ampere Altra    00000000 AMI  01000013)
[    0.000000] ACPI: FACP 0x00000000AF140000 000114 (v06 Ampere Altra    00000000 INTL 20190509)
[    0.000000] ACPI: DSDT 0x00000000AF0C0000 02F09A (v02 Ampere Jade     00000001 INTL 20200717)
[    0.000000] ACPI: FACS 0x00000000AF1D0000 000040
[    0.000000] ACPI: DBG2 0x00000000AF150000 00005C (v00 Ampere Altra    00000000 INTL 20190509)
[    0.000000] ACPI: GTDT 0x00000000AF130000 000110 (v03 Ampere Altra    00000000 INTL 20190509)
[    0.000000] ACPI: SSDT 0x00000000AF120000 00002D (v02 Ampere Altra    00000001 INTL 20190509)
[    0.000000] ACPI: BERT 0x00000000AF110000 000030 (v01 Ampere Altra    00000001 INTL 20200717)
[    0.000000] ACPI: EINJ 0x00000000AF100000 000150 (v01 Ampere Altra    00000001 INTL 20200717)
[    0.000000] ACPI: SDEI 0x00000000AF0F0000 000024 (v01 Ampere Altra    00000001 INTL 20200717)
[    0.000000] ACPI: SPMI 0x00000000AF0B0000 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: SPMI 0x00000000AF0A0000 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: SPMI 0x00000000AF090000 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: FIDT 0x00000000AF080000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SPCR 0x00000000AF070000 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000F)
[    0.000000] ACPI: PPTT 0x00000000AF050000 006E60 (v02 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: SLIT 0x00000000AF040000 000030 (v01 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: SRAT 0x00000000AF030000 000CF0 (v03 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: HEST 0x00000000AF020000 000878 (v01 Ampere Altra    00000001 ARM  00000099)
[    0.000000] ACPI: MCFG 0x00000000AF010000 0000DC (v01 Ampere Altra    00000001 AMP. 01000013)
[    0.000000] ACPI: IORT 0x00000000AF000000 000844 (v00 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: APIC 0x00000000AF060000 003354 (v05 Ampere Altra    00000003 AMI  01000013)
[    0.000000] ACPI: PCCT 0x00000000AEFF0000 000ABC (v02 Ampere Altra    00000003 AMP. 01000013)
[    0.000000] ACPI: WSMT 0x00000000AEFE0000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000AEFD0000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.000000] ACPI: SPCR: console: pl011,mmio32,0x100002600000,115200
[    0.000000] ACPI: Use ACPI SPCR as default console: Yes
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x88300000-0x883fffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x90000000-0xbfffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000000-0x8007fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x800c0000000-0x83fffffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x400000000000-0x4000bfffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x400100000000-0x403fffffffff]
[    0.000000] NUMA: Node 0 [mem 0x88300000-0x883fffff] + [mem 0x90000000-0xbfffffff] -> [mem 0x88300000-0xbfffffff]
[    0.000000] NUMA: Node 0 [mem 0x88300000-0xbfffffff] + [mem 0x80000000000-0x8007fffffff] -> [mem 0x88300000-0x8007fffffff]
[    0.000000] NUMA: Node 0 [mem 0x88300000-0x8007fffffff] + [mem 0x800c0000000-0x83fffffffff] -> [mem 0x88300000-0x83fffffffff]
[    0.000000] NUMA: Node 1 [mem 0x400000000000-0x4000bfffffff] + [mem 0x400100000000-0x403fffffffff] -> [mem 0x400000000000-0x403fffffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x83fffffd9c0-0x83fffffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x403fc00c19c0-0x403fc00c3fff]
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/sparse.c:142 sparse_init+0xbc/0x49c
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc3-00012-g2408a807bfc3 #1
[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : sparse_init+0xbc/0x49c
[    0.000000] lr : sparse_init+0xd8/0x49c
[    0.000000] sp : ffffadea4aac3c80
[    0.000000] x29: ffffadea4aac3c80 x28: 0000000000000000 x27: 0000000000000004
[    0.000000] x26: 00000000000107ff x25: ffffadea4b00cc00 x24: 0000000000002000
[    0.000000] x23: 0000000000020000 x22: 00000004000c0000 x21: 0000000000000001
[    0.000000] x20: 00000000b6780000 x19: 0000000400000000 x18: 0000000000000010
[    0.000000] x17: 0000000000000004 x16: 0000403fc00c4000 x15: 0000000000000001
[    0.000000] x14: 00000000c0000000 x13: 00000000000001b0 x12: 0000000000000014
[    0.000000] x11: ffffadea4ab61e80 x10: ffffadea4b004a58 x9 : ffffadea4b004c08
[    0.000000] x8 : 0000000400000000 x7 : 0000000000000012 x6 : 0000000000000013
[    0.000000] x5 : 00004000c0000000 x4 : ffffadea4aac3cf4 x3 : ffffadea4aac3d00
[    0.000000] x2 : ffffadea4aac3cf8 x1 : 00000000c0000000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  sparse_init+0xbc/0x49c (P)
[    0.000000]  bootmem_init+0x7c/0x1d8
[    0.000000]  setup_arch+0x26c/0x5f8
[    0.000000]  start_kernel+0x70/0x73c
[    0.000000]  __primary_switched+0x88/0x90
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000088300000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000403fffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000088300000-0x00000000883fffff]
[    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
[    0.000000]   node   0: [mem 0x0000000092000000-0x000000009277ffff]
[    0.000000]   node   0: [mem 0x0000000092780000-0x00000000aef6efff]
[    0.000000]   node   0: [mem 0x00000000aef6f000-0x00000000aef6ffff]
[    0.000000]   node   0: [mem 0x00000000aef70000-0x00000000af1cffff]
[    0.000000]   node   0: [mem 0x00000000af1d0000-0x00000000af1effff]
[    0.000000]   node   0: [mem 0x00000000af1f0000-0x00000000b0cfffff]
[    0.000000]   node   0: [mem 0x00000000b0d00000-0x00000000b79affff]
[    0.000000]   node   0: [mem 0x00000000b79b0000-0x00000000b7aeffff]
[    0.000000]   node   0: [mem 0x00000000b7af0000-0x00000000b7fdffff]
[    0.000000]   node   0: [mem 0x00000000b7fe0000-0x00000000b8068fff]
[    0.000000]   node   0: [mem 0x00000000b8069000-0x00000000b822efff]
[    0.000000]   node   0: [mem 0x00000000b822f000-0x00000000bfc3efff]
[    0.000000]   node   0: [mem 0x00000000bfc3f000-0x00000000bfc3ffff]
[    0.000000]   node   0: [mem 0x00000000bfc40000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x0000080000000000-0x000008007fffffff]
[    0.000000]   node   0: [mem 0x00000800c0000000-0x0000083fffffffff]
[    0.000000]   node   1: [mem 0x0000400000000000-0x00004000bfffffff]
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x04: level 0 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] [0000000000000008] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W          6.14.0-rc3-00012-g2408a807bfc3 #1
[    0.000000] Tainted: [W]=WARN
[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : subsection_map_init+0x9c/0xe4
[    0.000000] lr : free_area_init+0x374/0xebc
[    0.000000] sp : ffffadea4aac3bc0
[    0.000000] x29: ffffadea4aac3bc0 x28: 00000000a8a394dc x27: 00000000a0cc2000
[    0.000000] x26: 00000000000c0000 x25: 0000000400000000 x24: 0000000000008000
[    0.000000] x23: 0000000000002000 x22: ffffadea4b00cc00 x21: 0000000000000000
[    0.000000] x20: 0000000000080017 x19: 0000000000080000 x18: 0000000000000006
[    0.000000] x17: 0000000000000004 x16: 0000403fc00c4000 x15: ffffadea4aac3690
[    0.000000] x14: 0000000000000000 x13: ffffadea4aae3e48 x12: 000000000000012f
[    0.000000] x11: 0000000000000065 x10: ffffadea4ab3be48 x9 : ffffadea4aae3e48
[    0.000000] x8 : 00000000ffffefff x7 : ffffadea4ab3be48 x6 : 80000000fffff000
[    0.000000] x5 : 000000000000bff4 x4 : 0000000000000800 x3 : 0000000000000000
[    0.000000] x2 : 0000000000008000 x1 : 0000000000000000 x0 : 0000000000002000
[    0.000000] Call trace:
[    0.000000]  subsection_map_init+0x9c/0xe4 (P)
[    0.000000]  free_area_init+0x374/0xebc
[    0.000000]  bootmem_init+0x10c/0x1d8
[    0.000000]  setup_arch+0x26c/0x5f8
[    0.000000]  start_kernel+0x70/0x73c
[    0.000000]  __primary_switched+0x88/0x90
[    0.000000] Code: f8647863 8b010061 f100007f 9a831023 (f9400460) 
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Oops: Fatal exception
[    0.000000] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---




