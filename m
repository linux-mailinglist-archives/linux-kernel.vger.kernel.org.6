Return-Path: <linux-kernel+bounces-519530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A1A39DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EBD7A588C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A12267F4C;
	Tue, 18 Feb 2025 13:30:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55D13C8F3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885452; cv=none; b=gqg5grtfIkqkcxjP4k6hDYoxNLx2C5DHCyrRTY+hHoQdMuhmfpuTuAx4t35PB5Xk0o4URFhEKVwhm7ZmmMB0dsa1/vsU9jZskKF1CvE31zFDxLxYaUhwQSqru4ODrE06vQdNH2Fbu/Chf8OWinPAgn3ptgI8w8ISzOTy32EPBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885452; c=relaxed/simple;
	bh=xHoEFsrUX4ZYAcuanQoYOQWYo35pcW4Y7Kb/gERHaT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxmydk+GojlNB0RwRbqBAla4O7hmJhYsWZm4s8Z8SDXnyDCZgBnEs43C4Ajxj094b6R9EzRVssxsnMafXuu2TSm7HJDNmIm6MR5ypRodfo7J/2fT2gJ+qJNgi2CnpZSNVr11iIJiKoMtXga630E3QkfDH60UUraKwK4qwrDZ8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5FDC4CEE8;
	Tue, 18 Feb 2025 13:30:51 +0000 (UTC)
Message-ID: <c5c4197c-dc19-430c-a9d4-262db63fc43d@linux-m68k.org>
Date: Tue, 18 Feb 2025 23:30:49 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: coldfire: Prevent spurious interrupts when masking
 IMR
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20250204-coldfire-spurious-irq-v1-1-b8f28855f690@yoseli.org>
 <CAMuHMdXkq57WjUPeg3kTsgi-YSw23qV-gK4gVxymOSKGGTDuQQ@mail.gmail.com>
 <770e02b6-d9c5-4a2c-8516-63e08bdc4358@yoseli.org>
 <CAMuHMdXtzGFr2iE7py2fQPMegJTnfKe_NtW25g=h+sohfEhmAA@mail.gmail.com>
 <f13b40d7-4a67-4de8-8d25-1a56be164dbe@yoseli.org>
 <32193858-3ca9-4192-a4cb-f35eea22819e@linux-m68k.org>
 <dc8de6db-b2d9-4cd1-9ee0-646045199c9b@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <dc8de6db-b2d9-4cd1-9ee0-646045199c9b@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi JM,

On 18/2/25 23:17, Jean-Michel Hautbois wrote:
> Hi Greg,
> 
> On 2/12/25 1:47 PM, Greg Ungerer wrote:
>> Hi JM,
>>
>> On 5/2/25 21:26, Jean-Michel Hautbois wrote:
>>> Hi Geert,
>>>
>>> On 05/02/2025 09:14, Geert Uytterhoeven wrote:
>>>> Hi Jean-Michel,
>>>>
>>>> On Wed, 5 Feb 2025 at 08:07, Jean-Michel Hautbois
>>>> <jeanmichel.hautbois@yoseli.org> wrote:
>>>>> On 04/02/2025 20:27, Geert Uytterhoeven wrote:
>>>>>> On Tue, 4 Feb 2025 at 19:38, Jean-Michel Hautbois
>>>>>> <jeanmichel.hautbois@yoseli.org> wrote:
>>>>>>> The ColdFire interrupt controller can generate spurious interrupts if an
>>>>>>> interrupt source is masked in the IMR while the CPU interrupt priority
>>>>>>> mask (SR[I]) is set lower than the interrupt level.
>>>>>>>
>>>>>>> The reference manual states:
>>>>>>>
>>>>>>> To avoid this situation for interrupts sources with levels 1-6, first
>>>>>>> write a higher level interrupt mask to the status register, before
>>>>>>> setting the mask in the IMR or the module’s interrupt mask register.
>>>>>>> After the mask is set, return the interrupt mask in the status register
>>>>>>> to its previous value.
>>>>>>>
>>>>>>> It can be tested like this:
>>>>>>> - Prepare a iperf3 server on the coldfire target (iperf3 -s -D)
>>>>>>> - Start a high priority cyclictest:
>>>>>>>       cyclictest --secaligned -m -p 99 -i 2500 -q
>>>>>>> - Start iperf3 -c $COLDFIRE_IP -t 0
>>>>>>>
>>>>>>> After a few seconds the dmesg may display:
>>>>>>> [   84.784301] irq 24, desc: dbc502da, depth: 1, count: 0, unhandled: 0
>>>>>>> [   84.784455] ->handle_irq():  0ba0aca3, handle_bad_irq+0x0/0x1e0
>>>>>>> [   84.784610] ->irq_data.chip(): c6779d4f, 0x41652544
>>>>>>> [   84.784719] ->action(): 00000000
>>>>>>> [   84.784770] unexpected IRQ trap at vector 18
>>>>>>>
>>>>>>> With this patch, I never saw it in a few hours testing.
>>>>>>>
>>>>>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>>>>>
>>>>>> Thanks for your patch!
>>>>>>
>>>>>>> --- a/arch/m68k/coldfire/intc-simr.c
>>>>>>> +++ b/arch/m68k/coldfire/intc-simr.c
>>>>>>> @@ -58,6 +58,14 @@ static inline unsigned int irq2ebit(unsigned int irq)
>>>>>>>
>>>>>>>    #endif
>>>>>>>
>>>>>>> +static inline void intc_irq_setlevel(unsigned long level)
>>>>>>> +{
>>>>>>> +       asm volatile ("move.w %0,%%sr"
>>>>>>> +                     : /* no outputs */
>>>>>>> +                     : "d" (0x2000 | ((level) << 8))
>>>>>>> +                     : "memory");
>>>>>>> +}
>>>>>>> +
>>>>>>>    /*
>>>>>>>     *     There maybe one, two or three interrupt control units, each has 64
>>>>>>>     *     interrupts. If there is no second or third unit then MCFINTC1_* or
>>>>>>> @@ -67,13 +75,17 @@ static inline unsigned int irq2ebit(unsigned int irq)
>>>>>>>    static void intc_irq_mask(struct irq_data *d)
>>>>>>>    {
>>>>>>>           unsigned int irq = d->irq - MCFINT_VECBASE;
>>>>>>> +       unsigned long flags = arch_local_save_flags();
>>>>>>>
>>>>>>> +       intc_irq_setlevel(7);
>>>>>>
>>>>>> Can't all of the above just be replaced by
>>>>>>
>>>>>>       unsigned long flags = arch_local_irq_save();
>>>>>
>>>>> The only change is the Supervisor bit in SR which is not changed in
>>>>> arch_local_irq_disable() while it is forced to 1 in my function (setting
>>>>> it to 0x2700 AFAICT).
>>
>> I would expect that it will always be set here - since we must be running
>> in kernel mode to be executing this code.
>>
>>
>>>>> But I can confirm I couldn't see the issue with this code, while using
>>>>> the existing arch_local_irq_save() it still appears (less frequently
>>>>> than without it at all, but still).
>>>>>
>>>>> Any suggestion :-) ?
>>>>
>>>> There are other differences: your version clears all other bits, incl.
>>>> condition codes and master/interrupt state.
>>
>> Clearing of the interrupt mask seems like it might be an important
>> difference here. I don't see any of the CCR bits having an effect here.
>>
>> It is surprising that the existing arch_local_irq_disable() code doesn't
>> satisfy the Reference Manual description of the spurious interrupt
>> problem. It is exactly raising the IRQ level to 7.
>>
>>
>>>> Can you save the flags above in a global, and print it in the
>>>> unexpected IRQ handler, to see which other bits are set when
>>>> it happens?
>>>
>>> An interesting side effect is... that only saving the flags makes it *a lot* harder to reproduce -_-.
>>> Which is coherent with a race condition though :p.
>>>
>>> Each time I got the message, the flags saved where 0x2711.
>>
>> Couple of further suggestions.
>>
>> It might be worth putting an actual comment in the code about the issue.
>> It will probably not be obvious in the future why this is needed here.
>> Just something brief about stopping spurious interrupts should be good enough.
> 
> Thanks for the modifications, it is indeed a better naming, and the comment might help future reviewers :-).
> 
> FWIW, I added the same in the intc_irq_unmask() because I think it might also occurs in this path. Dunno if it is needed or not (it is very hard to reproduce :-/).

Ok, yeah, good point.
My reading of that documentation indicates that it is the interrupt mask
setting that is the issue ("A spurious interrupt may occur if an interrupt
source is being masked in the interrupt controller mask register (IMR)".
That makes me think it should only be needed when setting the mask.
The unmask step is clearing it.


> Do you need a v2 with the patch you did below ?

Yes please.

Thanks
Greg


> JM
> 
>>
>> With a couple of tweaks to the code I could get tighter asm code generated.
>> I dunno, maybe it is not worth it.
>>
>> Regards
>> Greg
>>
>>
>>
>>
>> diff --git a/arch/m68k/coldfire/intc-simr.c b/arch/m68k/coldfire/intc- simr.c
>> index f7c2c41b3156..11deeb6f1048 100644
>> --- a/arch/m68k/coldfire/intc-simr.c
>> +++ b/arch/m68k/coldfire/intc-simr.c
>> @@ -58,6 +58,20 @@ static inline unsigned int irq2ebit(unsigned int irq)
>>
>>   #endif
>>
>> +/*
>> + * Avoid spurious interrupts by raising level before modifying mask.
>> + */
>> +static inline unsigned long intc_irq_save_and_mask(void)
>> +{
>> +       unsigned long flags;
>> +       asm volatile ("move.w %%sr,%0\n\t"
>> +                     "move.w %1,%%sr"
>> +                     : "=&d" (flags)
>> +                     : "d" (0x2700)
>> +                     : "memory");
>> +       return flags;
>> +}
>> +
>>   /*
>>    *     There maybe one, two or three interrupt control units, each has 64
>>    *     interrupts. If there is no second or third unit then MCFINTC1_* or
>> @@ -66,14 +80,20 @@ static inline unsigned int irq2ebit(unsigned int irq)
>>
>>   static void intc_irq_mask(struct irq_data *d)
>>   {
>> -       unsigned int irq = d->irq - MCFINT_VECBASE;
>> +       unsigned long flags;
>> +       unsigned int irq;
>>
>> +       flags = intc_irq_save_and_mask();
>> +
>> +       irq = d->irq - MCFINT_VECBASE;
>>          if (MCFINTC2_SIMR && (irq > 127))
>>                  __raw_writeb(irq - 128, MCFINTC2_SIMR);
>>          else if (MCFINTC1_SIMR && (irq > 63))
>>                  __raw_writeb(irq - 64, MCFINTC1_SIMR);
>>          else
>>                  __raw_writeb(irq, MCFINTC0_SIMR);
>> +
>> +       arch_local_irq_restore(flags);
>>   }
>>
>>   static void intc_irq_unmask(struct irq_data *d)
>>
>>
>>
> 


