Return-Path: <linux-kernel+bounces-229989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD1917708
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3176F283C44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8E12FF76;
	Wed, 26 Jun 2024 03:59:34 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A046AB8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374373; cv=none; b=Nte6L92uFxeN8iUpbXOED7+gE81T5vacWGb4waKlGDAcww3pgyKdjcbh8Y5tFwParIJSoRrIpStl+pXonidxYyeKlCeCq9XxsmRqTPLXc96YiYSskz/ksGNCSnkb953DEJVfUOcHw6RGsWAlTfxWQEU0xVClQ947DSkBGQAmgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374373; c=relaxed/simple;
	bh=/8zvrQAT4vwMTb/N8nsQMWv0t9ILMdddNZeTHbLfYWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT1v3Pbt0XHhTJRPi+ZPtre4kepAonSRQN8xAo53142N+/F6iTicE03/oaIpz/AbtjnoqnoLvLesJKIWNQeO3Z4l6SocoIK5Pxy3izxKwCQI4CuEi4PwtZn5X/WPeNWkuCM4R7nUx4BRt9jj2JTemY3siFKq+3UFxGZMXAYdwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com; spf=pass smtp.mailfrom=nucleisys.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleisys.com
X-QQ-mid: bizesmtpsz2t1719374311tyzh3sa
X-QQ-Originating-IP: 9P9No3aCcFZc6U89Hfs7Rg+yqAwGEtRbGRfPKpBIulI=
Received: from [192.168.40.154] ( [59.173.29.70])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jun 2024 11:58:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6982004245298506315
Message-ID: <592DAA3973EEA52F+9b62c73a-cc43-498c-8afb-da2d43e56b5c@nucleisys.com>
Date: Wed, 26 Jun 2024 11:58:29 +0800
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
From: guibing <guibing@nucleisys.com>
In-Reply-To: <CAHVXubhkrDv3Fx1KH-jjjWjo-LGKBMabvafAPsDZeSpGMEt-gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:nucleisys.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Hi Alex,

Sorry, yesterday I clicked the mouse by mistake to sent an empty email.

> Is it a multithreaded application? You mean that if the application
> always runs on core1/2/3, you get an illegal instruction, but that
> does not happen when run on core0?
test_printf is not a multithread application, just output "hello world" 
strings.

#include <stdio.h>

int main()
{
         printf("hello world!\n");
         return 0;
}

 From testing results, illegal instruction always occur on core1/2/3, no 
core0.

> Did you check if the instruction in badaddr is different from the
> expected instruction? The image you provided is not available here,
> but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
> that correct?
this badaddr is same with the expected instruction, but i meet the 
different.

/mnt # ./test_printf
[   76.393222] test_printf[130]: unhandled signal 4 code 0x1 at 
0x0000000000019c82 in test_printf[10000+68000]
[   76.400427] CPU: 1 PID: 130 Comm: test_printf Not tainted 6.1.15 #6
[   76.406797] Hardware name: asrmicro,xlcpu-evb (DT)
[   76.411665] epc : 0000000000019c82 ra : 000000000001ca36 sp : 
0000003fc5969b00
[   76.418941]  gp : 000000000007e508 tp : 0000003f8faec780 t0 : 
000000000000003d
[   76.426244]  t1 : 0000002abe28cecc t2 : 0000002abe369d63 s0 : 
0000003fc5969d98
[   76.433524]  s1 : 0000000000082ab8 a0 : 0000003fc5969b00 a1 : 
0000000000000000
[   76.440835]  a2 : 00000000000001a0 a3 : 0000000001010101 a4 : 
0101010101010101
[   76.448108]  a5 : 0000003fc5969b00 a6 : 0000000000000040 a7 : 
00000000000000dd
[   76.455432]  s2 : 0000000000000001 s3 : 0000003fc5969d38 s4 : 
0000000000082a70
[   76.462695]  s5 : 0000000000000000 s6 : 0000000000010758 s7 : 
0000002abe371648
[   76.469995]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 
0000002abe371670
[   76.477275]  s11: 0000000000000001 t3 : 0000003f8fb954cc t4 : 
0000000000000000
[   76.484576]  t5 : 00000000000003ff t6 : 0000000000000040
[   76.489948] status: 0000000200004020 badaddr: 00000000ffffffff cause: 
0000000000000002
Illegal instruction

> No no, we try to introduce icache flushes whenever it is needed for such uarch.
>
core0 is responsible for reading data from sd cards to dcache and ddr.

before core1/2/3 continue to execute the application, it only execute 
fence.i instruction.

in our riscv hardware , fence.i just flush dcache and invalidate icache 
for local core.

in this case, how core1/2/3 can get application instruction data from 
the core0 dcache ?

i try to send remote fence.i to core0, iilegal instruction cannot 
reproduced, it can work well.

@@ -66,8 +66,11 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
                  * messages are sent we still need to order this hart's 
writes
                  * with flush_icache_deferred().
                  */
+              sbi_remote_fence_i(cpumask_of(0));
                 smp_mb();
         } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
                 sbi_remote_fence_i(&others);
         } else {


thank you for your reply! ：）


在 2024/6/25 19:45, Alexandre Ghiti 写道:
> Hi Guibing,
>
> You sent your email in html, so it got rejected by the ML, make sure
> you reply in plain text mode :)
>
> On Tue, Jun 25, 2024 at 10:45 AM 桂兵 <guibing@nucleisys.com> wrote:
>> Hi alex，
>>
>> We have encountered a problem related to this patch and would like to ask for your advice, thank you in advance!
>>
>> Problem description:
>> When we use the v6.9 kernel, there is an illegal instruction problem when executing a statically linked application on an SD card, and this problem is not reproduced in v6.6/v6.1 kernel.
>> SD card driver uses PIO mode, and the SD card interrupt is bound to core0. If the system schedule the apllication to execute on core1, core2, or core3, it will report an illegal instruction, and if scheduled to execute on core0, it will be executed successfully.
> Is it a multithreaded application? You mean that if the application
> always runs on core1/2/3, you get an illegal instruction, but that
> does not happen when run on core0?
>
>> We track the source code, flush_icache_pte function patch leads to this issue on our riscv hardware.
>> If you merge this patch into the v6.1 kernel, the same problem can be reproduced in v6.1 kernel.
>> If using flush_icache_all() not flush_icache_mm in v6.9 kernel ; this issue can not be reproduced in v6.9 kernel.
>>
>> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
>>   {
>>   struct folio *folio = page_folio(pte_page(pte));
>>
>>   if (!test_bit(PG_dcache_clean, &folio->flags)) {
>> -           flush_icache_all();
>> +           flush_icache_mm(mm, false);
>>   set_bit(PG_dcache_clean, &folio->flags);
>>   }
>>   }
> Did you check if the instruction in badaddr is different from the
> expected instruction? The image you provided is not available here,
> but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
> that correct?
>
>>
>> Our riscv cpu IP supports multi-core L1 dcache synchronization, but does not support multi-core L1 icache synchronization. iCache synchronization requires software maintenance.
>> Does the RISCV architecture kernel in future have mandatory requirements for multi-core iCache hardware consistency?
> No no, we try to introduce icache flushes whenever it is needed for such uarch.
>
>> Thank you for your reply!
>>
>>
>> Link：[PATCH] riscv: Only flush the mm icache when setting an exec pte - Alexandre Ghiti (kernel.org)
>>
>> ________________________________
>> 发自我的企业微信
>>
>>
> Thanks for the report,
>
> Alex
>


