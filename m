Return-Path: <linux-kernel+bounces-399897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1389C0600
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD974281F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502B20F5DE;
	Thu,  7 Nov 2024 12:41:19 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C420F5C5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983279; cv=none; b=GLCRmw4ohPmQBfp17AN7cDVTWSenupbC/uzN5EVBtscpxq42OK4KU6af3yQaP2x6PJ+Xk8Ul5ynZ88WniLP30URvQfa8dxUKcFrCtt8dhd2dPInozwh4T8b6kNYsVC8C9bE4OumlJwDckgR6VBgrg2ZqDEJYzW5NDgWyIFLAPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983279; c=relaxed/simple;
	bh=QD2aKbYWkppNcQBiFYZEp1NDfPFCDk8pL8FdCLACVyY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hq0Fc0LG9xlY/OpQcHkwW8Lpr4j47r8TCmaoaj12O2v6idoLZJ7VfGCXrYi99TCMEcQPdgzBu+JIAPXLaBLJTDSqGAzRMlgmmmEbOy465n6X6UY5Kna+nQLo/hrvXBDZf6s24aFGeiaEkuzG28ccF7r3ESADmwCMve5MxEt8x+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8BxPOJptSxneGE3AA--.43800S3;
	Thu, 07 Nov 2024 20:41:13 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxysFntSxngRNKAA--.4758S2;
	Thu, 07 Nov 2024 20:41:13 +0800 (CST)
Subject: Re: [PATCH] arch: loongarch: fix loongarch S3 WARNING
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241107032859.18276-1-zhaoqunqin@loongson.cn>
 <CAAhV-H5A144ubJ6WD68y7f6sN3j=g-eWVqZ6mhko9nzTgM=xYA@mail.gmail.com>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <8de897db-2331-4ab4-c739-f0008f8151b0@loongson.cn>
Date: Thu, 7 Nov 2024 20:39:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5A144ubJ6WD68y7f6sN3j=g-eWVqZ6mhko9nzTgM=xYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxysFntSxngRNKAA--.4758S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4DGF17Xw45JrWkJrWDAwc_yoWrGr15pr
	WjyF4jkrW8tryUWFsFy3WDZr1DXr45uFW8ZFWkG34UAw1xXr1ktF1UtF13W3W5Aws5AFW0
	vr1xtr1S9ayUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
	b18UUUUU=


在 2024/11/7 下午8:36, Huacai Chen 写道:
> Hi, Qunqin,
>
> At first, the subject should be "LoongArch: Fix warnings during S3 suspend".

Will fix,

Best regards.

>
> On Thu, Nov 7, 2024 at 11:29 AM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> The enable_gpe_wakeup() function may call the preempt_schedule_common()
>> function, resulting in a thread switch and causing the CPU to be in an
>> interrupt enable state after the enable_gpe_wakeup() function returns,
>> leading to the warning as follow. Calling enable_gap_wakeup() before
> Second, I think enable_gap_wakeup() should be enable_gpe_wakeup() here.
>
>> local_irq_disable() to fix this waring.
>>
>> [ C0] WARNING: ... at kernel/time/timekeeping.c:845 ktime_get+0xbc/0xc8
>> [ C0]         ...
>> [ C0] Call Trace:
>> [ C0] [<90000000002243b4>] show_stack+0x64/0x188
>> [ C0] [<900000000164673c>] dump_stack_lvl+0x60/0x88
>> [ C0] [<90000000002687e4>] __warn+0x8c/0x148
>> [ C0] [<90000000015e9978>] report_bug+0x1c0/0x2b0
>> [ C0] [<90000000016478e4>] do_bp+0x204/0x3b8
>> [ C0] [<90000000025b1924>] exception_handlers+0x1924/0x10000
>> [ C0] [<9000000000343bbc>] ktime_get+0xbc/0xc8
>> [ C0] [<9000000000354c08>] tick_sched_timer+0x30/0xb0
>> [ C0] [<90000000003408e0>] __hrtimer_run_queues+0x160/0x378
>> [ C0] [<9000000000341f14>] hrtimer_interrupt+0x144/0x388
>> [ C0] [<9000000000228348>] constant_timer_interrupt+0x38/0x48
>> [ C0] [<90000000002feba4>] __handle_irq_event_percpu+0x64/0x1e8
>> [ C0] [<90000000002fed48>] handle_irq_event_percpu+0x20/0x80
>> [ C0] [<9000000000306b9c>] handle_percpu_irq+0x5c/0x98
>> [ C0] [<90000000002fd4a0>] generic_handle_domain_irq+0x30/0x48
>> [ C0] [<9000000000d0c7b0>] handle_cpu_irq+0x70/0xa8
>> [ C0] [<9000000001646b30>] handle_loongarch_irq+0x30/0x48
>> [ C0] [<9000000001646bc8>] do_vint+0x80/0xe0
>> [ C0] [<90000000002aea1c>] finish_task_switch.isra.0+0x8c/0x2a8
>> [ C0] [<900000000164e34c>] __schedule+0x314/0xa48
>> [ C0] [<900000000164ead8>] schedule+0x58/0xf0
>> [ C0] [<9000000000294a2c>] worker_thread+0x224/0x498
>> [ C0] [<900000000029d2f0>] kthread+0xf8/0x108
>> [ C0] [<9000000000221f28>] ret_from_kernel_thread+0xc/0xa4
>> [ C0]
>> [ C0] ---[ end trace 0000000000000000 ]---
> Finally, I think you should enable some config options to produce such
> warnings? Because I haven't observed it.
>
>
> Huacai
>
>> And move enable_pci_wakeup() before local_irq_disable(), just in
>> case interrupt is enabled after the execution of enable_pci_wakeup()
>>
>> Fixes: 366bb35a8e48 ("LoongArch: Add suspend (ACPI S3) support")
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>>   arch/loongarch/power/suspend.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
>> index c9e594925..d0dc375b0 100644
>> --- a/arch/loongarch/power/suspend.c
>> +++ b/arch/loongarch/power/suspend.c
>> @@ -28,6 +28,13 @@ struct saved_registers {
>>   };
>>   static struct saved_registers saved_regs;
>>
>> +void arch_suspend_disable_irqs(void)
>> +{
>> +       enable_gpe_wakeup();
>> +       enable_pci_wakeup();
>> +       local_irq_disable();
>> +}
>> +
>>   void loongarch_common_suspend(void)
>>   {
>>          save_counter();
>> @@ -61,9 +68,6 @@ void loongarch_common_resume(void)
>>
>>   int loongarch_acpi_suspend(void)
>>   {
>> -       enable_gpe_wakeup();
>> -       enable_pci_wakeup();
>> -
>>          loongarch_common_suspend();
>>
>>          /* processor specific suspend */
>>
>> base-commit: 73adbd92f3223dc0c3506822b71c6b259d5d537b
>> --
>> 2.43.0
>>


