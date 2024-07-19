Return-Path: <linux-kernel+bounces-256942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2819372D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEADB21373
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6122094;
	Fri, 19 Jul 2024 03:49:39 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D209171CC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721360978; cv=none; b=IulCCZSFrZ74Z5Gi/fWxIDaUUOQ9G/wduMOd/GEZYurPrI+TeE4NLBrQTt9FU8ErdF3WGw0Td7cjdftqlQh3OpgXm1gqyYlkUNIgKyUaM7NJ0e7Ko77FhaHTFjWNWuCq+2PVJceNkW3XFf9XxdZnQWvnpdMXja5QFOXmpU5soFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721360978; c=relaxed/simple;
	bh=EeAA+947xoJt7OtVpvCDohO8cKAsexaNghBeYJNFaOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJY5g9if8HBTsZQAbY2zssgkmFd4haf21BNTlv+BxotbrM5JWI0cJqpP3Cojv67x74DLwOPg464lW78EX+0jEd4pU9Iut8njYjFmqDK3uGscaAxsoB7IQneACm3DU+QlzBzZF+FET9TRtxXF4BpbL5Y5Hb9XP/Pp4aVDIqSb4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com; spf=pass smtp.mailfrom=nucleisys.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleisys.com
X-QQ-mid: bizesmtpsz14t1721360896t3lmiz
X-QQ-Originating-IP: Z0ccwN+BwHY2kB6Augb9H3fviBSDxsdKDUERkrxaEU8=
Received: from [192.168.40.154] ( [219.140.150.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Jul 2024 11:48:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9272277476389788832
Message-ID: <3E353A37618C5B38+950ce56b-9655-489b-8c3e-d9f47376d89f@nucleisys.com>
Date: Fri, 19 Jul 2024 11:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Only flush the mm icache when setting an exec pte
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: aou <aou@eecs.berkeley.edu>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, palmer <palmer@dabbelt.com>,
 "paul.walmsley" <paul.walmsley@sifive.com>, =?UTF-8?B?5pa55Y2O5ZCv?=
 <hqfang@nucleisys.com>
References: <tencent_7721F6B72F58AA6154DFBDFF@qq.com>
 <CAHVXubhkrDv3Fx1KH-jjjWjo-LGKBMabvafAPsDZeSpGMEt-gg@mail.gmail.com>
 <592DAA3973EEA52F+9b62c73a-cc43-498c-8afb-da2d43e56b5c@nucleisys.com>
 <CAHVXubhy6tfAEfTF=fsZ90UDc+_vnWurWpK4xDqciwptzuvg6A@mail.gmail.com>
 <C3FA50DD88E41384+a8e54b7c-d4ec-45c3-9fea-bedc44a4a6f6@nucleisys.com>
 <CAHVXubjRMSDuu3b2idnf1Gnt-cxqPeY-x4tSuyZu7z7ROUd7+w@mail.gmail.com>
 <ECE62011D10B286A+e1417154-789a-4f46-acdb-81d9a1e7be9c@nucleisys.com>
 <CAHVXubizTNixW9Ow53qfiQV7CqdoxkFiZXhyLJsfDiw_5mf54A@mail.gmail.com>
From: guibing <guibing@nucleisys.com>
In-Reply-To: <CAHVXubizTNixW9Ow53qfiQV7CqdoxkFiZXhyLJsfDiw_5mf54A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:nucleisys.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Hi Alex，

please refer to the comment 
https://github.com/riscv/riscv-isa-manual/issues/1544#issuecomment-2237352457

you can discuss it there.

thanks.


在 2024/7/17 23:49, Alexandre Ghiti 写道:
> Hi Guibing,
>
> On Wed, Jul 17, 2024 at 4:24 PM guibing <guibing@nucleisys.com> wrote:
>>> Which is immediately followed by: "To make a store to instruction
>>> memory visible to all RISC-V harts, the writing hart also has to
>>> execute a data FENCE before requesting that all remote RISC-V harts
>>> execute a FENCE.I.".
>>>
>>> Maybe you're just lacking a data fence on core0?
>> First,
>>
>> The Riscv spec does not specify how to implement fence instruction
>> specifically.
>>
>> Fence is just memory barrier in our hardware platform.
>>
>> linux source code also take fence instruction as barrier.
>>
>> https://github.com/riscv/riscv-isa-manual/issues/341#issuecomment-465474896
>> , from this issue, Aswaterman also thinks so.
>>
>> Second,
>>
>> core0 reads data from the sd card, but from linux source code, no
>> drivers perform core cache sync operations(by fence.i) after core
>> reading the data.
>>
>> whereas the core1/2/3 perform cache operation after paging fault.
>> set_ptes function may call flush_icache_pte to sync cache in linux
>> source code.
>>
>> Finally,
>>
>> Riscv spec describe the fence.i instruction as following:
>>
>>> The FENCE.I instruction is used to synchronize the instruction and
>>> data streams.
>>>
>>> RISC-V does not guarantee that stores to instruction memory will be
>>> made visible to instruction fetches on a RISC-V hart until that hart
>>> executes a FENCE.I instruction. A FENCE.I instruction ensures that a
>>> subsequent instruction fetch on a RISC-V hart will see any previous
>>> data stores already visible to the same RISC-V hart. FENCE.I does not
>>> ensure that other RISC-V harts' instruction fetches will observe the
>>> local hart’s stores in a multiprocessor system.
>>>
>>   From this description, fence.i instruction only applies to local
>> core,making instruction fetch can see any previous data stores on the
>> same core.
> Not on the same core, it is said: "A FENCE.I instruction ensures that
> a subsequent instruction fetch on a RISC-V hart will see any previous
> data stores already visible to the same RISC-V hart".
>
> In other words, any store that is in the dcache of core0 should be
> seen by the instruction fetcher of any other core right? Since any
> core should be able to see what is in the other core's dcache right
> (ie the dcaches are coherent)? If your instruction fetcher on the
> other cores does not see the data, a simple memory barrier on core0
> should make it visible, no need to flush the core0 dcache.
>
>>> To make a store to instruction memory visible to all RISC-V harts, the
>>> writing hart also has to execute a data FENCE before requesting that
>>> all remote RISC-V harts execute a FENCE.I."
>>   From this point of view, core0 should execute data fence then send
>> remote fence.i to other harts, but linux source code is not implemented
>> in accordance with riscv spec.
>>
>>   From a more general perspective, i think that flush_icache_pte function
>> should call flush_icache_all not flush_icache_mm.
>>
>> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
>>      {
>>      struct folio *folio = page_folio(pte_page(pte));
>>
>>      if (!test_bit(PG_dcache_clean, &folio->flags)) {
>> -           flush_icache_all();
>> +           flush_icache_mm(mm, false);
>>      set_bit(PG_dcache_clean, &folio->flags);
>>      }
>>      }
> I still think we should find the right place where we lack the memory
> barrier you need so that the other core's instruction fetcher actually
> sees the stores from core0. With that, this patch will be correct. Can
> you try to add some memory barriers somewhere where core0 reads the
> data from the sdcard and see if that works better? Can you point me to
> some code I can take a look at?
>
> Thanks,
>
> Alex
>
>> thanks for your reply.
>>
>> 在 2024/7/17 17:20, Alexandre Ghiti 写道:
>>> Hi Guibing,
>>>
>>> On Tue, Jul 16, 2024 at 4:31 PM guibing <guibing@nucleisys.com> wrote:
>>>> Hi Alex，
>>>>
>>>>    From RISC-V Unprivileged ISA Spec，or zifencei.adoc :
>>>>
>>>> FENCE.I does not ensure that other RISC-V harts’ instruction fetches
>>>> will observe the local hart’s stores in a multiprocessor system.
>>> Which is immediately followed by: "To make a store to instruction
>>> memory visible to all RISC-V harts, the writing hart also has to
>>> execute a data FENCE before requesting that all remote RISC-V harts
>>> execute a FENCE.I.".
>>>
>>> Maybe you're just lacking a data fence on core0?
>>>
>>>
>>>> thanks.
>>>>
>>>> 在 2024/7/16 20:51, Alexandre Ghiti 写道:
>>>>> Hi Guibing,
>>>>>
>>>>> First, sorry for the delay, I was out last week.
>>>>>
>>>>> On Wed, Jun 26, 2024 at 5:59 AM guibing <guibing@nucleisys.com> wrote:
>>>>>> Hi Alex,
>>>>>>
>>>>>> Sorry, yesterday I clicked the mouse by mistake to sent an empty email.
>>>>>>
>>>>>>> Is it a multithreaded application? You mean that if the application
>>>>>>> always runs on core1/2/3, you get an illegal instruction, but that
>>>>>>> does not happen when run on core0?
>>>>>> test_printf is not a multithread application, just output "hello world"
>>>>>> strings.
>>>>>>
>>>>>> #include <stdio.h>
>>>>>>
>>>>>> int main()
>>>>>> {
>>>>>>             printf("hello world!\n");
>>>>>>             return 0;
>>>>>> }
>>>>>>
>>>>>>     From testing results, illegal instruction always occur on core1/2/3, no
>>>>>> core0.
>>>>>>
>>>>>>> Did you check if the instruction in badaddr is different from the
>>>>>>> expected instruction? The image you provided is not available here,
>>>>>>> but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
>>>>>>> that correct?
>>>>>> this badaddr is same with the expected instruction, but i meet the
>>>>>> different.
>>>>>>
>>>>>> /mnt # ./test_printf
>>>>>> [   76.393222] test_printf[130]: unhandled signal 4 code 0x1 at
>>>>>> 0x0000000000019c82 in test_printf[10000+68000]
>>>>>> [   76.400427] CPU: 1 PID: 130 Comm: test_printf Not tainted 6.1.15 #6
>>>>>> [   76.406797] Hardware name: asrmicro,xlcpu-evb (DT)
>>>>>> [   76.411665] epc : 0000000000019c82 ra : 000000000001ca36 sp :
>>>>>> 0000003fc5969b00
>>>>>> [   76.418941]  gp : 000000000007e508 tp : 0000003f8faec780 t0 :
>>>>>> 000000000000003d
>>>>>> [   76.426244]  t1 : 0000002abe28cecc t2 : 0000002abe369d63 s0 :
>>>>>> 0000003fc5969d98
>>>>>> [   76.433524]  s1 : 0000000000082ab8 a0 : 0000003fc5969b00 a1 :
>>>>>> 0000000000000000
>>>>>> [   76.440835]  a2 : 00000000000001a0 a3 : 0000000001010101 a4 :
>>>>>> 0101010101010101
>>>>>> [   76.448108]  a5 : 0000003fc5969b00 a6 : 0000000000000040 a7 :
>>>>>> 00000000000000dd
>>>>>> [   76.455432]  s2 : 0000000000000001 s3 : 0000003fc5969d38 s4 :
>>>>>> 0000000000082a70
>>>>>> [   76.462695]  s5 : 0000000000000000 s6 : 0000000000010758 s7 :
>>>>>> 0000002abe371648
>>>>>> [   76.469995]  s8 : 0000000000000000 s9 : 0000000000000000 s10:
>>>>>> 0000002abe371670
>>>>>> [   76.477275]  s11: 0000000000000001 t3 : 0000003f8fb954cc t4 :
>>>>>> 0000000000000000
>>>>>> [   76.484576]  t5 : 00000000000003ff t6 : 0000000000000040
>>>>>> [   76.489948] status: 0000000200004020 badaddr: 00000000ffffffff cause:
>>>>>> 0000000000000002
>>>>>> Illegal instruction
>>>>>>
>>>>>>> No no, we try to introduce icache flushes whenever it is needed for such uarch.
>>>>>>>
>>>>>> core0 is responsible for reading data from sd cards to dcache and ddr.
>>>>>>
>>>>>> before core1/2/3 continue to execute the application, it only execute
>>>>>> fence.i instruction.
>>>>>>
>>>>>> in our riscv hardware , fence.i just flush dcache and invalidate icache
>>>>>> for local core.
>>>>>>
>>>>>> in this case, how core1/2/3 can get application instruction data from
>>>>>> the core0 dcache ?
>>>>> I don't understand this point ^: you mean that core1/2/3 can't access
>>>>> the data in the core0 dcache? And they go straight to main memory? To
>>>>> me, the cores dcaches should be coherent and then a fence.i on any
>>>>> core would sync the icache with the content of any dcache and that
>>>>> should not happen.
>>>>>
>>>>> To me, the patch is correct, but maybe I did not fully understand your
>>>>> issue. Don't hesitate to give more details.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Alex
>>>>>
>>>>>> i try to send remote fence.i to core0, iilegal instruction cannot
>>>>>> reproduced, it can work well.
>>>>>>
>>>>>> @@ -66,8 +66,11 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>>>>>>                      * messages are sent we still need to order this hart's
>>>>>> writes
>>>>>>                      * with flush_icache_deferred().
>>>>>>                      */
>>>>>> +              sbi_remote_fence_i(cpumask_of(0));
>>>>>>                     smp_mb();
>>>>>>             } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
>>>>>>                     sbi_remote_fence_i(&others);
>>>>>>             } else {
>>>>>>
>>>>>>
>>>>>> thank you for your reply! ：）
>>>>>>
>>>>>>
>>>>>> 在 2024/6/25 19:45, Alexandre Ghiti 写道:
>>>>>>> Hi Guibing,
>>>>>>>
>>>>>>> You sent your email in html, so it got rejected by the ML, make sure
>>>>>>> you reply in plain text mode :)
>>>>>>>
>>>>>>> On Tue, Jun 25, 2024 at 10:45 AM 桂兵 <guibing@nucleisys.com> wrote:
>>>>>>>> Hi alex，
>>>>>>>>
>>>>>>>> We have encountered a problem related to this patch and would like to ask for your advice, thank you in advance!
>>>>>>>>
>>>>>>>> Problem description:
>>>>>>>> When we use the v6.9 kernel, there is an illegal instruction problem when executing a statically linked application on an SD card, and this problem is not reproduced in v6.6/v6.1 kernel.
>>>>>>>> SD card driver uses PIO mode, and the SD card interrupt is bound to core0. If the system schedule the apllication to execute on core1, core2, or core3, it will report an illegal instruction, and if scheduled to execute on core0, it will be executed successfully.
>>>>>>> Is it a multithreaded application? You mean that if the application
>>>>>>> always runs on core1/2/3, you get an illegal instruction, but that
>>>>>>> does not happen when run on core0?
>>>>>>>
>>>>>>>> We track the source code, flush_icache_pte function patch leads to this issue on our riscv hardware.
>>>>>>>> If you merge this patch into the v6.1 kernel, the same problem can be reproduced in v6.1 kernel.
>>>>>>>> If using flush_icache_all() not flush_icache_mm in v6.9 kernel ; this issue can not be reproduced in v6.9 kernel.
>>>>>>>>
>>>>>>>> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
>>>>>>>>      {
>>>>>>>>      struct folio *folio = page_folio(pte_page(pte));
>>>>>>>>
>>>>>>>>      if (!test_bit(PG_dcache_clean, &folio->flags)) {
>>>>>>>> -           flush_icache_all();
>>>>>>>> +           flush_icache_mm(mm, false);
>>>>>>>>      set_bit(PG_dcache_clean, &folio->flags);
>>>>>>>>      }
>>>>>>>>      }
>>>>>>> Did you check if the instruction in badaddr is different from the
>>>>>>> expected instruction? The image you provided is not available here,
>>>>>>> but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
>>>>>>> that correct?
>>>>>>>
>>>>>>>> Our riscv cpu IP supports multi-core L1 dcache synchronization, but does not support multi-core L1 icache synchronization. iCache synchronization requires software maintenance.
>>>>>>>> Does the RISCV architecture kernel in future have mandatory requirements for multi-core iCache hardware consistency?
>>>>>>> No no, we try to introduce icache flushes whenever it is needed for such uarch.
>>>>>>>
>>>>>>>> Thank you for your reply!
>>>>>>>>
>>>>>>>>
>>>>>>>> Link：[PATCH] riscv: Only flush the mm icache when setting an exec pte - Alexandre Ghiti (kernel.org)
>>>>>>>>
>>>>>>>> ________________________________
>>>>>>>> 发自我的企业微信
>>>>>>>>
>>>>>>>>
>>>>>>> Thanks for the report,
>>>>>>>
>>>>>>> Alex
>>>>>>>

