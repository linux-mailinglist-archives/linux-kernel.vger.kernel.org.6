Return-Path: <linux-kernel+bounces-433565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358329E59E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A4716E322
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391A21C164;
	Thu,  5 Dec 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3PJp6TL"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75C21D59B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412934; cv=none; b=dQvmoRhPBPL2lKwX9iMixIwMNjTGUZDD1JCK1RMXmuOacsNOy/MXD2tYG+M4JX/gsZwVqjtR6TWJ6+qag5LohlOLLFvQ73u7uyG/nwP8jlEkWJSE5ztQbBBf0J3IXBdqpil2oeg/OGdRLMjmB8qxJFECViJVo5WEQmW+rGtl6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412934; c=relaxed/simple;
	bh=xph7y2aQvKYHnqX74qfi+4fnARQCwqV6ycEa8zJtOww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTrkdowgA5x/+8PdeWHfQnr1AUWHF+WgRMXIGV2aqmhW6agNNqBHw0DzBg+TTvO1ekM+BgomxhOuDvIF/39sIZ3pjZ+R8BXK+Sq/24CjzH4EE3e8xlg7LjSzEnYh0VveqecPnccTrRlhR4F72EwOgdfsBq0Fza/Vrx1jx3RJ4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3PJp6TL; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd37d06b-2310-2cc8-c19f-c9eb50798a67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733412927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKB227xy7BVGbG+BNK6VQ+7+nemA0W/zKfPUa9q4ApI=;
	b=D3PJp6TLUnEsf7g729wu0v7vWmNWiOB3AVpoW3TIRwPZl1IF5DV8Iby5rsgCSsninGq004
	wjxRuYN0PMyyrrAXRy5Du68onSOIeOatCtPLEsKDiN2Etx8yAlmAlzZU/BTXs0ELgxBi4G
	bbN9x17pzc1DVXAc6PehdknJpWUdJ0M=
Date: Thu, 5 Dec 2024 23:34:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/alloc_tag: fix vm_module_tags_populate's KASAN
 poisoning logic
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20241204075248.384215-1-hao.ge@linux.dev>
 <20241204083448.387862-1-hao.ge@linux.dev>
 <CAJuCfpF5Yo3Bz1OUy=rfd5-0DRZsWSRaekR3Y-f5TRatdXWkVQ@mail.gmail.com>
 <e5d6cb44-9a86-ee94-9210-d56acee483c4@linux.dev>
 <CAJuCfpFHEpFw61ZtqHzgYrpiHn1k86h2LwzZf+C4=sfpULY4TQ@mail.gmail.com>
 <6dab626e-acee-9f4e-c97b-7a225882edff@linux.dev>
 <b2f45c47-37e0-c9cf-27ee-68408b2b2d4c@linux.dev>
 <CAJuCfpF8ftPcd24y2L4C_37GDMC4iaDDh8SicwspwmVAkB=3fQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpF8ftPcd24y2L4C_37GDMC4iaDDh8SicwspwmVAkB=3fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Suren


On 12/5/24 22:48, Suren Baghdasaryan wrote:
> On Wed, Dec 4, 2024 at 7:20 PM Hao Ge <hao.ge@linux.dev> wrote:
>> Hi Suren
>>
>>
>> On 12/5/24 10:14, Hao Ge wrote:
>>> Hi Suren
>>>
>>>
>>> On 12/5/24 03:33, Suren Baghdasaryan wrote:
>>>> On Wed, Dec 4, 2024 at 7:08 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>> Hi Suren
>>>>>
>>>>>
>>>>> Thank you for your review.
>>>>>
>>>>>
>>>>> On 12/4/24 22:39, Suren Baghdasaryan wrote:
>>>>>> On Wed, Dec 4, 2024 at 12:35 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>>>
>>>>>>> After merge commit 233e89322cbe ("alloc_tag:
>>>>>>> fix module allocation tags populated area calculation"),
>>>>>>> We still encountered a KASAN bug.
>>>>>>>
>>>>>>> This is because we have only actually performed
>>>>>>> page allocation and address mapping here.
>>>>>>> we need to unpoisoned portions of underlying memory.
>>>>>>>
>>>>>>> Because we have a change in the size here,we need to
>>>>>>> re-annotate poisoned and unpoisoned portions of underlying memory
>>>>>>> according to the new size.
>>>>>>>
>>>>>>> Here is the log for KASAN:
>>>>>>>
>>>>>>> [    5.041171][    T1]
>>>>>>> ==================================================================
>>>>>>> [    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in
>>>>>>> move_module+0x2c0/0x708
>>>>>>> [    5.042723][    T1] Write of size 240 at addr ffff80007e510000
>>>>>>> by task systemd/1
>>>>>>> [    5.043412][    T1]
>>>>>>> [    5.043523][   T72] input: QEMU QEMU USB Tablet as
>>>>>>> /devices/pci0000:00/0000:00:01.1/0000:02:001
>>>>>>> [    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not
>>>>>>> tainted 6.13.0-rc1+ #28
>>>>>>> [    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine,
>>>>>>> BIOS 0.0.0 02/06/2015
>>>>>>> [    5.046328][    T1] Call trace:
>>>>>>> [    5.046670][    T1]  show_stack+0x20/0x38 (C)
>>>>>>> [    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
>>>>>>> [    5.047533][    T1]
>>>>>>> print_address_description.constprop.0+0x58/0x358
>>>>>>> [    5.048092][   T72] hid-generic 0003:0627:0001.0001:
>>>>>>> input,hidraw0: USB HID v0.01 Mouse [QEMU 0
>>>>>>> [    5.048126][    T1]  print_report+0xb0/0x280
>>>>>>> [    5.049682][    T1]  kasan_report+0xb8/0x108
>>>>>>> [    5.050170][    T1]  kasan_check_range+0xe8/0x190
>>>>>>> [    5.050685][    T1]  memcpy+0x58/0xa0
>>>>>>> [    5.051135][    T1]  move_module+0x2c0/0x708
>>>>>>> [    5.051586][    T1] layout_and_allocate.constprop.0+0x308/0x5b8
>>>>>>> [    5.052219][    T1]  load_module+0x134/0x16c8
>>>>>>> [    5.052671][    T1]  init_module_from_file+0xdc/0x138
>>>>>>> [    5.053193][    T1]  idempotent_init_module+0x344/0x600
>>>>>>> [    5.053742][    T1] __arm64_sys_finit_module+0xbc/0x150
>>>>>>> [    5.054289][    T1]  invoke_syscall+0xd4/0x258
>>>>>>> [    5.054749][    T1] el0_svc_common.constprop.0+0xb4/0x240
>>>>>>> [    5.055319][    T1]  do_el0_svc+0x48/0x68
>>>>>>> [    5.055743][    T1]  el0_svc+0x40/0xe0
>>>>>>> [    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
>>>>>>> [    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0
>>>>>>>
>>>>>>> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags
>>>>>>> populated area calculation")
>>>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>>> Thanks for the fix!
>>>>>>
>>>>>>> ---
>>>>>>> v2: Add comments to kasan_unpoison_vmalloc like other places.
>>>>>>>
>>>>>>> commit 233e89322cbe ("alloc_tag: fix module allocation
>>>>>>> tags populated area calculation") is currently in the
>>>>>>> mm-hotfixes-unstable branch, so this patch is
>>>>>>> developed based on the mm-hotfixes-unstable branch.
>>>>>>> ---
>>>>>>>     lib/alloc_tag.c | 13 +++++++++++++
>>>>>>>     1 file changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
>>>>>>> index 4ee6caa6d2da..f885b3f3af0e 100644
>>>>>>> --- a/lib/alloc_tag.c
>>>>>>> +++ b/lib/alloc_tag.c
>>>>>>> @@ -421,7 +421,20 @@ static int vm_module_tags_populate(void)
>>>>>>> __free_page(next_page[i]);
>>>>>>>                            return -ENOMEM;
>>>>>>>                    }
>>>>>>> +
>>>>>>> +               kasan_poison_vmalloc((void *)module_tags.start_addr,
>>>>>>> + vm_module_tags->nr_pages << PAGE_SHIFT);
>>>>>>> +
>>>>>>>                    vm_module_tags->nr_pages += nr;
>>>>>>> +
>>>>>>> +               /*
>>>>>>> +                * Mark the pages as accessible, now that they are
>>>>>>> mapped.
>>>>>>> +                * With hardware tag-based KASAN, marking is
>>>>>>> skipped for
>>>>>>> +                * non-VM_ALLOC mappings, see
>>>>>>> __kasan_unpoison_vmalloc().
>>>>>>> +                */
>>>>>>> +               kasan_unpoison_vmalloc((void
>>>>>>> *)module_tags.start_addr,
>>>>>>> + vm_module_tags->nr_pages << PAGE_SHIFT,
>>>>>>> + KASAN_VMALLOC_PROT_NORMAL);
>>>>>> Instead of poisoning [module_tags.start_addr,
>>>>>> vm_module_tags->nr_pages], incrementing vm_module_tags->nr_pages and
>>>>>> the unpoisoning [module_tags.start_addr, vm_module_tags->nr_pages]
>>>>>> could we simply poisons the additional area like this:
>>>>>>
>>>>>>                    kasan_unpoison_vmalloc((void
>>>>>> *)module_tags.start_addr +
>>>>>> (vm_module_tags->nr_pages << PAGE_SHIFT),
>>>>>>                                           nr << PAGE_SHIFT,
>>>>>> KASAN_VMALLOC_PROT_NORMAL);
>>>>>>                   vm_module_tags->nr_pages += nr;
>>>>>> ?
>>>>> I had considered making such modifications earlier.
>>>>>
>>>>> But considering the following situation,
>>>>>
>>>>> A module tags spans across the regions of [module_tags.start_addr,
>>>>> vm_module_tags->nr_pages] and [module_tags.start_addr +
>>>>> vm_module_tags->nr_pages, ...].
>>>>>
>>>>> It may result in false positives for out-of-bounds errors.
>>>> Sorry, maybe I'm missing something but I don't see why poisoning only
>>>> newly mapped area would lead to false positives. Could you please
>>>> clarify?
>>>
>>> Because KASAN may perceive the two as distinct address spaces, despite
>>> their addresses being contiguous.
>>>
>>> So, when a module tag spans across these two contiguous address
>>> spaces, KASAN may incorrectly consider it as an out-of-bounds access.
>>>
>>>
>>>> Also, if you do need to unpoison and then poison, using phys_end and
>>>> new_end would be better, like this:
>>>>
>>>> kasan_poison_vmalloc((void *)module_tags.start_addr,
>>>>                                         phys_end -
>>>> module_tags.start_addr)
>>>>
>>>> kasan_unpoison_vmalloc((void *)module_tags.start_addr,
>>>>                                             new_end -
>>>> module_tags.start_addr,
>>>> KASAN_VMALLOC_PROT_NORMAL);
>>> OK, the next version will include.
>> After verification and consideration, I have found that this
>> modification may still pose problems.
>>
>> Because we haven't ensured that  new_end is page-aligned,
>>
>> So, we've only made the region from||module_tags.start_addr
>> tonew_endaccessible.
> Correct and the area [module_tags.start_addr, new_end] is the one that
> should be considered valid/accessible. We fault-in a physical page
> that includes new_end and might cover some area after that address but
> accessing the addresses above new_end is technically out-of-bounds
> (there are no valid codetags there).
>
>> Using this example, in reality,end equals 0xffff80007e5100f0:
>>
>> Write of size 240 at addr ffff80007e510000 by task systemd/1
>>
>> When we access other memory within the same page as0xffff80007e5100f0,
>> KASAN warnings will also be issued due to the lack of unpoisoned
>> portions in that memory.
> Will you get a KASAN warning if you access memory below new_end?
> Warnings above that address I think should be considered as expected
> (even though we have a valid physical page there).
> Does that make sense?

Is that really the case?

Here is the log that has been updated to include the calculation new_end 
- module_tags.start_addr.

On my machine,module_tags.start_addr is equal to ffff80007e510000

and the size of the first module_tags is 240

So, because you only made the range|[module_tags.start_addr, 
new_end]|accessible, the same issue will arise again later on.

[    5.798918][  T258] BUG: KASAN: vmalloc-out-of-bounds in 
move_module+0x2c0/0x708
[    5.799622][  T258] Write of size 200 at addr ffff80007e5100f0 by 
task systemd-modules/258
[    5.800149][  T256] systemd-journald[256]: Collecting audit messages 
is disabled.
[    5.800296][  T258]
[    5.800301][  T258] CPU: 2 UID: 0 PID: 258 Comm: systemd-modules Not 
tainted 6.13.0-rc1+ #46
[    5.801727][   T10] input: QEMU QEMU USB Mouse as 
/devices/pci0000:00/0000:00:01.1/0000:02:00.3
[    5.801905][  T258] Hardware name: QEMU KVM Virtual Machine, BIOS 
0.0.0 02/06/2015
[    5.801911][  T258] Call trace:
[    5.804120][  T258]  show_stack+0x20/0x38 (C)
[    5.804512][  T258]  dump_stack_lvl+0x80/0xf8
[    5.804916][  T258] print_address_description.constprop.0+0x58/0x358
[    5.805276][   T10] hid-generic 0003:0627:0001.0003: input,hidraw2: 
USB HID v0.01 Mouse [QEMU 0
[    5.805501][  T258]  print_report+0xb0/0x280
[    5.807031][  T258]  kasan_report+0xb8/0x108
[    5.807415][  T258]  kasan_check_range+0xe8/0x190
[    5.807714][  T124] pcieport 0000:00:02.3: pciehp: Slot(0-11): No 
device found
[    5.807921][  T258]  memcpy+0x58/0xa0
[    5.807927][  T258]  move_module+0x2c0/0x708
[    5.809346][  T258] layout_and_allocate.constprop.0+0x308/0x5b8
[    5.809942][  T258]  load_module+0x134/0x16c8
[    5.810375][  T258]  init_module_from_file+0xdc/0x138
[    5.810870][  T258]  idempotent_init_module+0x344/0x600
[    5.811389][  T258]  __arm64_sys_finit_module+0xbc/0x150
[    5.811916][  T258]  invoke_syscall+0xd4/0x258
[    5.812362][  T258]  el0_svc_common.constprop.0+0xb4/0x240
[    5.812914][  T258]  do_el0_svc+0x48/0x68
[    5.813318][  T258]  el0_svc+0x40/0xe0
[    5.813698][  T258]  el0t_64_sync_handler+0x10c/0x138
[    5.814210][  T258]  el0t_64_sync+0x1ac/0x1b0[    5.798918][ T258] 
BUG: KASAN: vmalloc-out-of-bounds in move_module+0x2c0/0x708
[    5.799622][  T258] Write of size 200 at addr ffff80007e5100f0 by 
task systemd-modules/258
[    5.800149][  T256] systemd-journald[256]: Collecting audit messages 
is disabled.
[    5.800296][  T258]
[    5.800301][  T258] CPU: 2 UID: 0 PID: 258 Comm: systemd-modules Not 
tainted 6.13.0-rc1+ #46
[    5.801727][   T10] input: QEMU QEMU USB Mouse as 
/devices/pci0000:00/0000:00:01.1/0000:02:00.3
[    5.801905][  T258] Hardware name: QEMU KVM Virtual Machine, BIOS 
0.0.0 02/06/2015
[    5.801911][  T258] Call trace:
[    5.804120][  T258]  show_stack+0x20/0x38 (C)
[    5.804512][  T258]  dump_stack_lvl+0x80/0xf8
[    5.804916][  T258] print_address_description.constprop.0+0x58/0x358
[    5.805276][   T10] hid-generic 0003:0627:0001.0003: input,hidraw2: 
USB HID v0.01 Mouse [QEMU 0
[    5.805501][  T258]  print_report+0xb0/0x280
[    5.807031][  T258]  kasan_report+0xb8/0x108
[    5.807415][  T258]  kasan_check_range+0xe8/0x190
[    5.807714][  T124] pcieport 0000:00:02.3: pciehp: Slot(0-11): No 
device found
[    5.807921][  T258]  memcpy+0x58/0xa0
[    5.807927][  T258]  move_module+0x2c0/0x708
[    5.809346][  T258] layout_and_allocate.constprop.0+0x308/0x5b8
[    5.809942][  T258]  load_module+0x134/0x16c8
[    5.810375][  T258]  init_module_from_file+0xdc/0x138
[    5.810870][  T258]  idempotent_init_module+0x344/0x600
[    5.811389][  T258]  __arm64_sys_finit_module+0xbc/0x150
[    5.811916][  T258]  invoke_syscall+0xd4/0x258
[    5.812362][  T258]  el0_svc_common.constprop.0+0xb4/0x240
[    5.812914][  T258]  do_el0_svc+0x48/0x68
[    5.813318][  T258]  el0_svc+0x40/0xe0
[    5.813698][  T258]  el0t_64_sync_handler+0x10c/0x138
[    5.814210][  T258]  el0t_64_sync+0x1ac/0x1b0

>> Based on that, I would suggest sticking with the V2 version.
>>
>>
>> Thanks
>>
>> Best Regards
>>
>> Hao
>>
>>>
>>> Thanks
>>>
>>> Best regards
>>>
>>> Hao
>>>
>>>
>>>>>>>            }
>>>>>>>
>>>>>>>            return 0;
>>>>>>> --
>>>>>>> 2.25.1
>>>>>>>

