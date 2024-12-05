Return-Path: <linux-kernel+bounces-432533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B749E4C99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4771881799
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573F1865E3;
	Thu,  5 Dec 2024 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WWJsiaaA"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D132F22
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368862; cv=none; b=lO/u2GIuAsayenqFPxkZ9yv283rnSTUSDt6lYxEkxmU+iXFMaPuo0oV5uCRfHUb1nnII4hk5hwRQH4ZhAaIf8ssEqwCItxsfbO66s4afUIheIAoKnj8AIkC1R9ZWs+UpJMBZHPHoG/W7qPlv2Qv6Jbb5CidpqQjpgFX/J7fppiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368862; c=relaxed/simple;
	bh=NsjxCfxPSTRbPCj7fvvwD/dJnN4I67xjRn4TYMrwK6I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GMtoZY/szi9eWKYg5xUaPxlrvyUPB4QDq4NuEhG/FL68KXQ3KszYRF5kIYqZOjZ0+jtt0SIyDAivWMaGodKfK+/CcUc5h+4NpNoLRJUxko6J4vqpYgdB1zcUdXkA/TXveAx8QYlLgD2OcEfVkve9p0s1+XCLA9xiZrLy/eZLW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WWJsiaaA; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2f45c47-37e0-c9cf-27ee-68408b2b2d4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733368855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qr8GW4K1UBAkugl9lZa9Mb7MVz0SqMO1J50BVo3IvyQ=;
	b=WWJsiaaAFpnmoAwUvNReeccXaYx7s5xc0g1YbwGRCzpJBL48U5qttJsNwkdM8P6LlOxZj9
	WLVurcZhOqFrAyFP+faIziVJN/Dhp+/dxVlYOHX9jsErEBRcHOztqW+axrWXRrZ+CmIyLF
	4SzPOj7/r+XjABfHg2PpVkWTkuOL94w=
Date: Thu, 5 Dec 2024 11:20:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/alloc_tag: fix vm_module_tags_populate's KASAN
 poisoning logic
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20241204075248.384215-1-hao.ge@linux.dev>
 <20241204083448.387862-1-hao.ge@linux.dev>
 <CAJuCfpF5Yo3Bz1OUy=rfd5-0DRZsWSRaekR3Y-f5TRatdXWkVQ@mail.gmail.com>
 <e5d6cb44-9a86-ee94-9210-d56acee483c4@linux.dev>
 <CAJuCfpFHEpFw61ZtqHzgYrpiHn1k86h2LwzZf+C4=sfpULY4TQ@mail.gmail.com>
 <6dab626e-acee-9f4e-c97b-7a225882edff@linux.dev>
In-Reply-To: <6dab626e-acee-9f4e-c97b-7a225882edff@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Suren


On 12/5/24 10:14, Hao Ge wrote:
> Hi Suren
>
>
> On 12/5/24 03:33, Suren Baghdasaryan wrote:
>> On Wed, Dec 4, 2024 at 7:08 AM Hao Ge <hao.ge@linux.dev> wrote:
>>> Hi Suren
>>>
>>>
>>> Thank you for your review.
>>>
>>>
>>> On 12/4/24 22:39, Suren Baghdasaryan wrote:
>>>> On Wed, Dec 4, 2024 at 12:35 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>
>>>>> After merge commit 233e89322cbe ("alloc_tag:
>>>>> fix module allocation tags populated area calculation"),
>>>>> We still encountered a KASAN bug.
>>>>>
>>>>> This is because we have only actually performed
>>>>> page allocation and address mapping here.
>>>>> we need to unpoisoned portions of underlying memory.
>>>>>
>>>>> Because we have a change in the size here,we need to
>>>>> re-annotate poisoned and unpoisoned portions of underlying memory
>>>>> according to the new size.
>>>>>
>>>>> Here is the log for KASAN:
>>>>>
>>>>> [    5.041171][    T1] 
>>>>> ==================================================================
>>>>> [    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in 
>>>>> move_module+0x2c0/0x708
>>>>> [    5.042723][    T1] Write of size 240 at addr ffff80007e510000 
>>>>> by task systemd/1
>>>>> [    5.043412][    T1]
>>>>> [    5.043523][   T72] input: QEMU QEMU USB Tablet as 
>>>>> /devices/pci0000:00/0000:00:01.1/0000:02:001
>>>>> [    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not 
>>>>> tainted 6.13.0-rc1+ #28
>>>>> [    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine, 
>>>>> BIOS 0.0.0 02/06/2015
>>>>> [    5.046328][    T1] Call trace:
>>>>> [    5.046670][    T1]  show_stack+0x20/0x38 (C)
>>>>> [    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
>>>>> [    5.047533][    T1] 
>>>>> print_address_description.constprop.0+0x58/0x358
>>>>> [    5.048092][   T72] hid-generic 0003:0627:0001.0001: 
>>>>> input,hidraw0: USB HID v0.01 Mouse [QEMU 0
>>>>> [    5.048126][    T1]  print_report+0xb0/0x280
>>>>> [    5.049682][    T1]  kasan_report+0xb8/0x108
>>>>> [    5.050170][    T1]  kasan_check_range+0xe8/0x190
>>>>> [    5.050685][    T1]  memcpy+0x58/0xa0
>>>>> [    5.051135][    T1]  move_module+0x2c0/0x708
>>>>> [    5.051586][    T1] layout_and_allocate.constprop.0+0x308/0x5b8
>>>>> [    5.052219][    T1]  load_module+0x134/0x16c8
>>>>> [    5.052671][    T1]  init_module_from_file+0xdc/0x138
>>>>> [    5.053193][    T1]  idempotent_init_module+0x344/0x600
>>>>> [    5.053742][    T1] __arm64_sys_finit_module+0xbc/0x150
>>>>> [    5.054289][    T1]  invoke_syscall+0xd4/0x258
>>>>> [    5.054749][    T1] el0_svc_common.constprop.0+0xb4/0x240
>>>>> [    5.055319][    T1]  do_el0_svc+0x48/0x68
>>>>> [    5.055743][    T1]  el0_svc+0x40/0xe0
>>>>> [    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
>>>>> [    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0
>>>>>
>>>>> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags 
>>>>> populated area calculation")
>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>> Thanks for the fix!
>>>>
>>>>> ---
>>>>> v2: Add comments to kasan_unpoison_vmalloc like other places.
>>>>>
>>>>> commit 233e89322cbe ("alloc_tag: fix module allocation
>>>>> tags populated area calculation") is currently in the
>>>>> mm-hotfixes-unstable branch, so this patch is
>>>>> developed based on the mm-hotfixes-unstable branch.
>>>>> ---
>>>>>    lib/alloc_tag.c | 13 +++++++++++++
>>>>>    1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
>>>>> index 4ee6caa6d2da..f885b3f3af0e 100644
>>>>> --- a/lib/alloc_tag.c
>>>>> +++ b/lib/alloc_tag.c
>>>>> @@ -421,7 +421,20 @@ static int vm_module_tags_populate(void)
>>>>> __free_page(next_page[i]);
>>>>>                           return -ENOMEM;
>>>>>                   }
>>>>> +
>>>>> +               kasan_poison_vmalloc((void *)module_tags.start_addr,
>>>>> + vm_module_tags->nr_pages << PAGE_SHIFT);
>>>>> +
>>>>>                   vm_module_tags->nr_pages += nr;
>>>>> +
>>>>> +               /*
>>>>> +                * Mark the pages as accessible, now that they are 
>>>>> mapped.
>>>>> +                * With hardware tag-based KASAN, marking is 
>>>>> skipped for
>>>>> +                * non-VM_ALLOC mappings, see 
>>>>> __kasan_unpoison_vmalloc().
>>>>> +                */
>>>>> +               kasan_unpoison_vmalloc((void 
>>>>> *)module_tags.start_addr,
>>>>> + vm_module_tags->nr_pages << PAGE_SHIFT,
>>>>> + KASAN_VMALLOC_PROT_NORMAL);
>>>> Instead of poisoning [module_tags.start_addr,
>>>> vm_module_tags->nr_pages], incrementing vm_module_tags->nr_pages and
>>>> the unpoisoning [module_tags.start_addr, vm_module_tags->nr_pages]
>>>> could we simply poisons the additional area like this:
>>>>
>>>>                   kasan_unpoison_vmalloc((void 
>>>> *)module_tags.start_addr +
>>>> (vm_module_tags->nr_pages << PAGE_SHIFT),
>>>>                                          nr << PAGE_SHIFT,
>>>> KASAN_VMALLOC_PROT_NORMAL);
>>>>                  vm_module_tags->nr_pages += nr;
>>>> ?
>>>
>>> I had considered making such modifications earlier.
>>>
>>> But considering the following situation,
>>>
>>> A module tags spans across the regions of [module_tags.start_addr,
>>> vm_module_tags->nr_pages] and [module_tags.start_addr +
>>> vm_module_tags->nr_pages, ...].
>>>
>>> It may result in false positives for out-of-bounds errors.
>> Sorry, maybe I'm missing something but I don't see why poisoning only
>> newly mapped area would lead to false positives. Could you please
>> clarify?
>
>
> Because KASAN may perceive the two as distinct address spaces, despite 
> their addresses being contiguous.
>
> So, when a module tag spans across these two contiguous address 
> spaces, KASAN may incorrectly consider it as an out-of-bounds access.
>
>
>> Also, if you do need to unpoison and then poison, using phys_end and
>> new_end would be better, like this:
>>
>> kasan_poison_vmalloc((void *)module_tags.start_addr,
>>                                        phys_end - 
>> module_tags.start_addr)
>>
>> kasan_unpoison_vmalloc((void *)module_tags.start_addr,
>>                                            new_end - 
>> module_tags.start_addr,
>> KASAN_VMALLOC_PROT_NORMAL);
>
> OK, the next version will include.

After verification and consideration, I have found that this 
modification may still pose problems.

Because we haven't ensured that  new_end is page-aligned,

So, we've only made the region from||module_tags.start_addr 
tonew_endaccessible.

Using this example, in reality,end equals 0xffff80007e5100f0:

Write of size 240 at addr ffff80007e510000 by task systemd/1

When we access other memory within the same page as0xffff80007e5100f0, 
KASAN warnings will also be issued due to the lack of unpoisoned 
portions in that memory.

Based on that, I would suggest sticking with the V2 version.


Thanks

Best Regards

Hao

>
>
> Thanks
>
> Best regards
>
> Hao
>
>
>>>
>>>>>           }
>>>>>
>>>>>           return 0;
>>>>> -- 
>>>>> 2.25.1
>>>>>

