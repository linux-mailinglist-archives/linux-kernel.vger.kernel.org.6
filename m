Return-Path: <linux-kernel+bounces-521792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1DA3C25D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43FD1889B33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684B1F30B2;
	Wed, 19 Feb 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdPqWNvx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E541EEA31
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976028; cv=none; b=Ss3oqaAEFZ8WcRWQULgjc3SUTar2ZgceDaTCI8oB6/m2MKcBIbGErgM2BXZkbDO7BKx9fpCOWNj5yObLXMmyQXJDe3fqNxFeufClEeh2420yau/jgYcEPgUQ8J9ZtyyeMjfpwtKV9tlq3Ya1rZOZf39DmnOSSmS5IBC8Md7zHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976028; c=relaxed/simple;
	bh=Ew+0tlUpW20XnrB5/6T3LSPKL8t4hwG8+KFEUlpokIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj1A8zu/a7CLESZwh6KybXNqlUSaEckwiuelvgcqzeIk1Pm0oRh65MxDfP38gWFjIIh9tqCkVUnkKSRd4wxCULAW2RtSrry1uy/7e433W/5iZ2vRJzAI5C+PhoW3oI/uvcFBHQy0ygpgoAwI8igKXy2OVxXpTjighNi6V/qJGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdPqWNvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739976024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92pqg+Pm0P/ngyCkCu6dcL3lu8yIxsqMvQsYoJFNx58=;
	b=cdPqWNvxQypc/u4+273ZaNP9gHnSLWLA53T39SIPpQzW/Q4k4fJO/69WAMIXqJ2yAPiQ1y
	TZzyOo4aHavgZSA6a/7741Ywig1GuMWkTiI8w9vp1Hiw43VvoTvWYjjw67t28KJpGvJ3Iv
	3Q56P8903gYt5ghqj0cOZuj4iWubIz0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-iV_2WGvbPkyu1o_w_sz9jg-1; Wed, 19 Feb 2025 09:40:21 -0500
X-MC-Unique: iV_2WGvbPkyu1o_w_sz9jg-1
X-Mimecast-MFC-AGG-ID: iV_2WGvbPkyu1o_w_sz9jg_1739976020
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e65d4d54b4so131894926d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976020; x=1740580820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92pqg+Pm0P/ngyCkCu6dcL3lu8yIxsqMvQsYoJFNx58=;
        b=bSUk56eaIMZmUbrEMGwPVZcr/bwuSj0VzL32t/gkJ1XEeLw57qLTVa78u2Vt7jOzAm
         Xb4sy04p2mjzNm1Y5nobax70qLzMAz0AwQvkLJtsucPgmhaVFX1Iq1KFRg9ktvQntt8C
         YFrCS92kC5Mi0da/nKSll5PHEBVUEygU+B8TzNSZy63roe1WfNt7Lv77cNJ0DUXS3wN5
         8b6tfo1xdQQWJ+XwYYDvk16EYjzEoWCVKmnxAFW3lQsdWrzMVJ9Su0YeFJjzWGuCTlOJ
         0gC3qaJXr2nw1quicDGq/S8GQGiNQf965RoHg0W4tltMuYnGUIaYssHEGBOZ7decwZ37
         wYqA==
X-Forwarded-Encrypted: i=1; AJvYcCUuAWAXdbxWJ9dCd2YOZJKXL16q7epGRc4Oq5ypLTkPGg16I6+F41u6CxqTV+X2BRe7+j0cj3JaULxS/yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/1uQs05yTQKO8XUopOG5STE/OScrvOOPd7RtUKalSFwM96aK
	fBJXmgnNEd3PS5sX/U5BW5V/XAAMC3qyoMaiO5uO3PnrrVuaG066NImTAXESHPbzcCpMUVn7KTE
	8/4FaJyD0Og3SuGzgfzoQEM3XOOFGKb+ixJyF0A2622jDEa/v56UyjbF1SI+vKQ==
X-Gm-Gg: ASbGncvev3cuttEIlgrpLiNWoXcQT0Skrta/JPqNZgX/QqW5RUrnFY0r5tGHmlnG7Qu
	mbfhm1sEDzts8079ONNPBzihOnJICMps8p2YHYeqU6k5OKhnc+s+H7wL+OqDrGql2KkaGylmJTd
	Z78Laa4WejOUC6x5Bu96tgCG8MPHpP9ys/1Yir4S9nuf8oTJOAJBt2ni74jsqbMiOHCffAcDcu0
	n8rGfPFEq6pKEVUaec4AAxt1ZcY9Eu10cgAOdGPUSbZmkrf3MTf7SX5ATIcCpcF4ovPHZV/Bi++
	E4xDVP60xf2wjprWhxU4pe0iQF0f6DJz6VcRnae/9CJJq7J8WH7HHOW9TByJPSwqHQ==
X-Received: by 2002:a05:6214:2123:b0:6e6:61a5:aa57 with SMTP id 6a1803df08f44-6e6974e9358mr69687086d6.14.1739976020163;
        Wed, 19 Feb 2025 06:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx7v6ZazYQtTypiVcuKX69fhYLvzT/9OfeI4Qf5Ak/M3+Odhrt2e4GrVCLP2V18lpRJDndrg==
X-Received: by 2002:a05:6214:2123:b0:6e6:61a5:aa57 with SMTP id 6a1803df08f44-6e6974e9358mr69686466d6.14.1739976019599;
        Wed, 19 Feb 2025 06:40:19 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-14-70-52-22-87.dsl.bell.ca. [70.52.22.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d786020sm74809406d6.46.2025.02.19.06.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:40:19 -0800 (PST)
Message-ID: <789c17e6-5ebc-4e37-93cd-19d24f148fd8@redhat.com>
Date: Wed, 19 Feb 2025 09:40:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at arch/arm64/mm/mmu.c:185!
To: Ryan Roberts <ryan.roberts@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org
Cc: ardb@kernel.org
References: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
 <fe95f4c8-4b09-4d8e-99c9-987ddc2761e3@arm.com>
 <9f5600b3-6525-4045-ad1f-4408dfc9ce0f@redhat.com>
 <cf2b32a4-2217-4a31-b6d7-e60a9f4ef7dd@arm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <cf2b32a4-2217-4a31-b6d7-e60a9f4ef7dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-19 09:26, Ryan Roberts wrote:
> On 19/02/2025 14:16, Luiz Capitulino wrote:
>> On 2025-02-19 03:41, Ryan Roberts wrote:
>>> On 19/02/2025 02:27, Luiz Capitulino wrote:
>>>> Hi,
>>>>
>>>> I'm getting the crash below with Linus tree commit
>>>> 2408a807bfc3f738850ef5ad5e3fd59d66168996 on a Ampere Mt. Jade with two sockets
>>>> (backtrace below).
>>>
>>> Thanks for the bug report, I'll take a look this morning, but I'm off work
>>> tomorrow and Friday so if I can't figure it out before end of day I won't be
>>> able to look again until Monday, unless someone can pick it up in the meantime.
>>
>> No rush at all. Please, enjoy your time off :)
> 
> Afraid I've run out of time on this for today, so adding some details below.
> I'll come back to it next week unless someone else steps in.
> 
>>
>>> Anyway, is there a specific config you're compiling for? And what about kernel
>>> command line args?
>>
>> Config is attached. The kernel command-line is:
>>
>> """
>> ro crashkernel=1G-4G:406M,4G-64G:470M,64G-:726M rd.lvm.lv=cs_ampere-mtjade-
>> altra-03/root rd.lvm.lv=cs_ampere-mtjade-altra-03/swap
>> earlycon=pl011,mmio,0x100002600000
>> """
>>
>>> Is it 100% reproducible for you?
>>
>> That is a good question. Right now it is (just tried again with latest Linus
>> tree 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2). But I do have the recollection
>> that I was able to boot a bad kernel a few times.
>>
>> Btw, I'll try to bisect again and will also try to update the system's firmware
>> just in case.
>>
>>> How much RAM does your system have? (I have 2
>>> socket Mt. Jade with 512G; I'll try to repro on that).
>>
>> Mine is 512G, maybe we're lucky and it's the same system.
>>
>>>> It happens very early during boot. Passing 'nokaslr' in the command-line works
>>>> around the issue (ie. I can boot and use the system normally). Doesn't seem to
>>>> happen with 6.13. I tried bisecting it but got nowhere...
>>>>
>>>> [    0.000000] ------------[ cut here ]------------
>>>> [    0.000000] kernel BUG at arch/arm64/mm/mmu.c:185!
>>>
>>> This is:
>>>
>>> /*
>>>    * After the PTE entry has been populated once, we
>>>    * only allow updates to the permission attributes.
>>>    */
>>> BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(__ptep_get(ptep))));
>>>
>>> So we have a valid -> valid PTE transition where either the PFNs are changing,
>>> we are trying to change permissions on a contiguous entry, we are trying to
>>> transition from non-global to global, or we are trying to change other
>>> explicitly disallowed bits.
>>>
>>>> [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>>> [    0.000000] Modules linked in:
>>>> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc3+ #8
>>>> [    0.000000] pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [    0.000000] pc : alloc_init_cont_pte+0x20c/0x3d0
>>>> [    0.000000] lr : alloc_init_cont_pte+0x204/0x3d0
>>>> [    0.000000] sp : ffffb45836ec78b0
>>>> [    0.000000] x29: ffffb45836ec7940 x28: ffff6fea00000000 x27: 0068000000000f07
>>>> [    0.000000] x26: ffff6fea00200000 x25: 0000400000000000 x24: ffffffffff433000
>>>> [    0.000000] x23: dfff800000000000 x22: 0000d01600000000 x21: 0068000000000f07
>>>> [    0.000000] x20: ffff6fea00000000 x19: ffff6fea00010000 x18: 00000000ae5a3fb1
>>>> [    0.000000] x17: 0000000000001114 x16: 00000000bfc60000 x15: 0000000000000200
>>>> [    0.000000] x14: 0000000000000000 x13: 1ffff68b06dd8f1c x12: 00000000f1f1f1f1
>>>> [    0.000000] x11: ffff768b06dd8f1c x10: ffffb45835a1ca38 x9 : 0000000000000000
>>>> [    0.000000] x8 : 0000000041b58ab3 x7 : 0000000000000000 x6 : 0000000000000000
>>>> [    0.000000] x5 : 006840000a861f07 x4 : 000000000000a861 x3 : 000000000000a861
>>>> [    0.000000] x2 : 006840000a861f03 x1 : 0068400000000f07 x0 : 0000000000000000
>>>> [    0.000000] Call trace:
>>>> [    0.000000]  alloc_init_cont_pte+0x20c/0x3d0 (P)
>>>> [    0.000000]  alloc_init_cont_pmd+0x20c/0x4d0
>>>> [    0.000000]  alloc_init_pud+0x244/0x400
>>>> [    0.000000]  create_kpti_ng_temp_pgd+0xf8/0x1c8
>>>
>>> This is an alias for __create_pgd_mapping_locked() so I suspect we are actually
>>> in __map_memblock().
>>>
>>>> [    0.000000]  map_mem.constprop.0+0x1d8/0x3b8
>>>> [    0.000000]  paging_init+0x98/0x330
>>>> [    0.000000]  setup_arch+0xac/0x170
>>>> [    0.000000]  start_kernel+0x74/0x3c8
>>>> [    0.000000]  __primary_switched+0x8c/0xa0
>>>> [    0.000000] Code: f9400301 97ffff64 72001c1f 54fffe21 (d4210000)
>>>> [    0.000000] ---[ end trace 0000000000000000 ]---
>>>> [    0.000000] Kernel panic - not syncing: Oops - BUG: Fatal exception
>>>> [    0.000000] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal
>>>> exception ]---
>>>>
>>>
>>> So I guess either we are setting a PTE entry into a table for the first time,
>>> where somehow the table has not been initially cleared (very unlikely) or we are
>>> trying to update the permissions of an already mapped pte. In that latter case,
>>> I think we should only be remapping the kernel image portion of the linear map.
>>>
>>> I can't see any obvious recent changes in this area. I'll see if I can repro and
>>> poke around a bit more.
>>
>> OK, maybe you'll be able to reproduce with the config I'm attaching.
> 
> I can reproduce _a_ panic, but it's different from the one you shared. I'm
> running defconfig on Ampere Altra with 2 sockets and 512G RAM. It appears to
> repro reliably as long as kaslr is enabled.

Well, after I pasted my kernel command-line to you I wondered why I didn't
have a console= option. So, I added console=ttyAMA0,115200n8 and it changed
the crash for me (see below).

> I tried reproduing on VM, but with no luck. I suspect there is something about
> the physical layout of memory that provokes the bug. I tried to force the memory
> layout to match Altra using kvmtool but it only supports a single physical
> region currently. And merging all the regions into 1 uber region is too big and
> the VMM fails. So I think we are stuck having to keep rebooting the bare metal.

Yes, I forgot to say that I've been using KVM guests for my kernel work on this
same system and I never saw this crash on those guests (they're NUMA guests).

Here's my new crash:

[    0.000000] Booting Linux on physical CPU 0x0000120000 [0x413fd0c1]
[    0.000000] Linux version 6.14.0-rc3-00060-g6537cfb395f3 (luizcap@ampere-mtjade-altra-03.khw.eng.rdu2.dc.redhat.com) (gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5), GNU ld version 2.35.2-60.el9) #1 SMP PREEMPT_DYNAMIC Wed Feb 19 08:39:20 EST 2025
[    0.000000] KASLR enabled
[    0.000000] earlycon: pl11 at MMIO 0x0000100002600000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI 2.0=0xbfc30000 TPMFinalLog=0xbfc60000 SMBIOS 3.0=0xb93dff98 MEMATTR=0xb8e3a018 ESRT=0xbb242298 TPMEventLog=0xb2da7518 RNG=0xb2dafe98 MEMRESERVE=0xb5482818
[    0.000000] random: crng init done
[    0.000000] esrt: Reserving ESRT space from 0x00000000bb242298 to 0x00000000bb2422f8.
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000BFC30000 000024 (v02 Ampere)
[    0.000000] ACPI: XSDT 0x00000000BB300000 0000E4 (v01 Ampere Altra    00000000 AMI  01000013)
[    0.000000] ACPI: FACP 0x00000000BB1A0000 000114 (v06 Ampere Altra    00000000 INTL 20190509)
[    0.000000] ACPI: DSDT 0x00000000BB0B0000 02F09A (v02 Ampere Jade     00000001 INTL 20200717)
[    0.000000] ACPI: FACS 0x00000000BFC50000 000040
[    0.000000] ACPI: DBG2 0x00000000BB1B0000 00005C (v00 Ampere Altra    00000000 INTL 20190509)
[    0.000000] ACPI: GTDT 0x00000000BB190000 000110 (v03 Ampere Altra    00000000 INTL 20190509)
[    0.000000] ACPI: SSDT 0x00000000BB180000 00002D (v02 Ampere Altra    00000001 INTL 20190509)
[    0.000000] ACPI: EINJ 0x00000000BB150000 000150 (v01 Ampere Altra    00000001 INTL 20200717)
[    0.000000] ACPI: SDEI 0x00000000BB140000 000024 (v01 Ampere Altra    00000001 INTL 20200717)
[    0.000000] ACPI: SPMI 0x00000000BB130000 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: SPMI 0x00000000BB120000 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: SPMI 0x00000000BB110000 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: FIDT 0x00000000BA5F0000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SPCR 0x00000000B8E10000 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000F)
[    0.000000] ACPI: TPM2 0x00000000B3050000 000064 (v04 ALASKA A M I    00000001 AMI  00000000)
[    0.000000] ACPI: PPTT 0x00000000B2F50000 006E60 (v02 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: SLIT 0x00000000B2F90000 000030 (v01 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: SRAT 0x00000000B2F40000 000CF0 (v03 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: HEST 0x00000000B2F30000 0008D8 (v01 Ampere Altra    00000001 ARM  00000099)
[    0.000000] ACPI: BERT 0x00000000BB160000 000030 (v01 Ampere Altra    00000001 INTL 20200717)
[    0.000000] ACPI: MCFG 0x00000000B2F20000 0000EC (v01 Ampere Altra    00000001 AMP. 01000013)
[    0.000000] ACPI: IORT 0x00000000B2F10000 000900 (v00 Ampere Altra    00000000 AMP. 01000013)
[    0.000000] ACPI: APIC 0x00000000B2F60000 003354 (v05 Ampere Altra    00000003 AMI  01000013)
[    0.000000] ACPI: PCCT 0x00000000B2E80000 000ABC (v02 Ampere Altra    00000003 AMP. 01000013)
[    0.000000] ACPI: FPDT 0x00000000B2E50000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.000000] ACPI: WSMT 0x00000000B8090000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: BGRT 0x00000000B8DB0000 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
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
[    0.000000] NODE_DATA(0) allocated [mem 0x83ffffe92c0-0x83fffffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x403fc00b22c0-0x403fc00c8fff]
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/sparse.c:142 memblocks_present+0x154/0x3f0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc3-00060-g6537cfb395f3 #1
[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : memblocks_present+0x154/0x3f0
[    0.000000] lr : memblocks_present+0x168/0x3f0
[    0.000000] sp : ffffd58845d17b30
[    0.000000] x29: ffffd58845d17c20 x28: 00000000c4b40000 x27: 0000000400000000
[    0.000000] x26: dfff800000000000 x25: 00000000001fffff x24: 00000004000c0000
[    0.000000] x23: 0000000000000001 x22: 0000000000000004 x21: ffffd58846cd81e0
[    0.000000] x20: 0000000000001078 x19: 000000000000020f x18: 0000000000000003
[    0.000000] x17: 0000000000000004 x16: 0000403fc00c9000 x15: 0000020000000000
[    0.000000] x14: 0000000000036d40 x13: 0000000100000000 x12: ffff6b7e97ffb258
[    0.000000] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[    0.000000] x8 : 0000000000000000 x7 : ffffd58846ca8424 x6 : 1ffffab108d95082
[    0.000000] x5 : 00000000000000de x4 : 1ffffab108ba2f7c x3 : 1ffffab108ba2f76
[    0.000000] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  memblocks_present+0x154/0x3f0 (P)
[    0.000000]  sparse_init+0x40/0x340
[    0.000000]  bootmem_init+0x134/0x360
[    0.000000]  setup_arch+0xc0/0x170
[    0.000000]  start_kernel+0x74/0x3c8
[    0.000000]  __primary_switched+0x8c/0xa0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000088300000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000403fffffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000088300000-0x00000000883fffff]
[    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ceffff]
[    0.000000]   node   0: [mem 0x0000000091cf0000-0x0000000091deffff]
[    0.000000]   node   0: [mem 0x0000000091df0000-0x0000000091ffffff]
[    0.000000]   node   0: [mem 0x0000000092000000-0x000000009277ffff]
[    0.000000]   node   0: [mem 0x0000000092780000-0x00000000b1085fff]
[    0.000000]   node   0: [mem 0x00000000b1086000-0x00000000b134ffff]
[    0.000000]   node   0: [mem 0x00000000b1350000-0x00000000b15effff]
[    0.000000]   node   0: [mem 0x00000000b15f0000-0x00000000b25fffff]
[    0.000000]   node   0: [mem 0x00000000b2600000-0x00000000b2e8ffff]
[    0.000000]   node   0: [mem 0x00000000b2e90000-0x00000000b2f0ffff]
[    0.000000]   node   0: [mem 0x00000000b2f10000-0x00000000b308ffff]
[    0.000000]   node   0: [mem 0x00000000b3090000-0x00000000b30effff]
[    0.000000]   node   0: [mem 0x00000000b30f0000-0x00000000b310ffff]
[    0.000000]   node   0: [mem 0x00000000b3110000-0x00000000b315ffff]
[    0.000000]   node   0: [mem 0x00000000b3160000-0x00000000b3d2ffff]
[    0.000000]   node   0: [mem 0x00000000b3d30000-0x00000000b3d3ffff]
[    0.000000]   node   0: [mem 0x00000000b3d40000-0x00000000b402ffff]
[    0.000000]   node   0: [mem 0x00000000b4030000-0x00000000b403ffff]
[    0.000000]   node   0: [mem 0x00000000b4040000-0x00000000b433ffff]
[    0.000000]   node   0: [mem 0x00000000b4340000-0x00000000b547ffff]
[    0.000000]   node   0: [mem 0x00000000b5480000-0x00000000b8e3ffff]
[    0.000000]   node   0: [mem 0x00000000b8e40000-0x00000000b8e4ffff]
[    0.000000]   node   0: [mem 0x00000000b8e50000-0x00000000b8feffff]
[    0.000000]   node   0: [mem 0x00000000b8ff0000-0x00000000b900ffff]
[    0.000000]   node   0: [mem 0x00000000b9010000-0x00000000b93affff]
[    0.000000]   node   0: [mem 0x00000000b93b0000-0x00000000b94fffff]
[    0.000000]   node   0: [mem 0x00000000b9500000-0x00000000b953ffff]
[    0.000000]   node   0: [mem 0x00000000b9540000-0x00000000b955ffff]
[    0.000000]   node   0: [mem 0x00000000b9560000-0x00000000b957ffff]
[    0.000000]   node   0: [mem 0x00000000b9580000-0x00000000ba5affff]
[    0.000000]   node   0: [mem 0x00000000ba5b0000-0x00000000ba64ffff]
[    0.000000]   node   0: [mem 0x00000000ba650000-0x00000000ba66ffff]
[    0.000000]   node   0: [mem 0x00000000ba670000-0x00000000ba85ffff]
[    0.000000]   node   0: [mem 0x00000000ba860000-0x00000000ba8cffff]
[    0.000000]   node   0: [mem 0x00000000ba8d0000-0x00000000ba99ffff]
[    0.000000]   node   0: [mem 0x00000000ba9a0000-0x00000000bab2ffff]
[    0.000000]   node   0: [mem 0x00000000bab30000-0x00000000bab7ffff]
[    0.000000]   node   0: [mem 0x00000000bab80000-0x00000000bac1ffff]
[    0.000000]   node   0: [mem 0x00000000bac20000-0x00000000bac6ffff]
[    0.000000]   node   0: [mem 0x00000000bac70000-0x00000000bad0ffff]
[    0.000000]   node   0: [mem 0x00000000bad10000-0x00000000bad9ffff]
[    0.000000]   node   0: [mem 0x00000000bada0000-0x00000000bae3ffff]
[    0.000000]   node   0: [mem 0x00000000bae40000-0x00000000bae4ffff]
[    0.000000]   node   0: [mem 0x00000000bae50000-0x00000000baf2ffff]
[    0.000000]   node   0: [mem 0x00000000baf30000-0x00000000baf7ffff]
[    0.000000]   node   0: [mem 0x00000000baf80000-0x00000000bb01ffff]
[    0.000000]   node   0: [mem 0x00000000bb020000-0x00000000bb0dffff]
[    0.000000]   node   0: [mem 0x00000000bb0e0000-0x00000000bb0effff]
[    0.000000]   node   0: [mem 0x00000000bb0f0000-0x00000000bb25ffff]
[    0.000000]   node   0: [mem 0x00000000bb260000-0x00000000bb28ffff]
[    0.000000]   node   0: [mem 0x00000000bb290000-0x00000000bb7affff]
[    0.000000]   node   0: [mem 0x00000000bb7b0000-0x00000000bb84ffff]
[    0.000000]   node   0: [mem 0x00000000bb850000-0x00000000bb8dffff]
[    0.000000]   node   0: [mem 0x00000000bb8e0000-0x00000000bb97ffff]
[    0.000000]   node   0: [mem 0x00000000bb980000-0x00000000bb99ffff]
[    0.000000]   node   0: [mem 0x00000000bb9a0000-0x00000000bb9bffff]
[    0.000000]   node   0: [mem 0x00000000bb9c0000-0x00000000bba0ffff]
[    0.000000]   node   0: [mem 0x00000000bba10000-0x00000000bde4ffff]
[    0.000000]   node   0: [mem 0x00000000bde50000-0x00000000bdebffff]
[    0.000000]   node   0: [mem 0x00000000bdec0000-0x00000000bf05ffff]
[    0.000000]   node   0: [mem 0x00000000bf060000-0x00000000bf0effff]
[    0.000000]   node   0: [mem 0x00000000bf0f0000-0x00000000bf1cffff]
[    0.000000]   node   0: [mem 0x00000000bf1d0000-0x00000000bf21ffff]
[    0.000000]   node   0: [mem 0x00000000bf220000-0x00000000bf2bffff]
[    0.000000]   node   0: [mem 0x00000000bf2c0000-0x00000000bf2dffff]
[    0.000000]   node   0: [mem 0x00000000bf2e0000-0x00000000bf2fffff]
[    0.000000]   node   0: [mem 0x00000000bf300000-0x00000000bfc2dfff]
[    0.000000]   node   0: [mem 0x00000000bfc2e000-0x00000000bfc2ffff]
[    0.000000]   node   0: [mem 0x00000000bfc30000-0x00000000bfc4ffff]
[    0.000000]   node   0: [mem 0x00000000bfc50000-0x00000000bfcbffff]
[    0.000000]   node   0: [mem 0x00000000bfcc0000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x0000080000000000-0x000008007fffffff]
[    0.000000]   node   0: [mem 0x00000800c0000000-0x0000083fffffffff]
[    0.000000]   node   1: [mem 0x0000400000000000-0x00004000bfffffff]
[    0.000000] Unable to handle kernel paging request at virtual address dfff800000000001
[    0.000000] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
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
[    0.000000] [dfff800000000001] address between user and kernel address ranges
[    0.000000] Internal error: Oops: 0000000096000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W          6.14.0-rc3-00060-g6537cfb395f3 #1
[    0.000000] Tainted: [W]=WARN
[    0.000000] pstate: 800000c9 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : subsection_map_init+0xb4/0x160
[    0.000000] lr : free_area_init+0x368/0xd08
[    0.000000] sp : ffffd58845d17a90
[    0.000000] x29: ffffd58845d17a90 x28: 00000000000c0000 x27: 0000000400000000
[    0.000000] x26: 0000000000080000 x25: ffffd58843f11d60 x24: ffffd58843f11920
[    0.000000] x23: 0000000000008000 x22: 0000000000080017 x21: dfff800000000000
[    0.000000] x20: 0000000000000000 x19: 0000000000008000 x18: 0000000000000003
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: ffff7ab108bb333d
[    0.000000] x11: 1ffffab108bb333c x10: ffff7ab108bb333c x9 : dfff800000000000
[    0.000000] x8 : 0000854ef744ccc4 x7 : ffffd58845d999e3 x6 : 0000000000000001
[    0.000000] x5 : ffffd58845d999e0 x4 : ffff7ab108bb333d x3 : 0000000000000000
[    0.000000] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000008
[    0.000000] Call trace:
[    0.000000]  subsection_map_init+0xb4/0x160 (P)
[    0.000000]  free_area_init+0x368/0xd08
[    0.000000]  bootmem_init+0x208/0x360
[    0.000000]  setup_arch+0xc0/0x170
[    0.000000]  start_kernel+0x74/0x3c8
[    0.000000]  __primary_switched+0x8c/0xa0
[    0.000000] Code: d37b1b40 8b000294 91002280 d343fc01 (38f56821)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Oops: Fatal exception
[    0.000000] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


