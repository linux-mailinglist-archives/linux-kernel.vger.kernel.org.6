Return-Path: <linux-kernel+bounces-407049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B069C67E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB66B24848
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF715CD58;
	Wed, 13 Nov 2024 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbcfsLCG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/4PCnsWq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E894514F135
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731469219; cv=none; b=m5iLJMK899nWGe0ksHeT3X8ghaCaZ4a1EbXqxrButVFyg2et0TEKDCB7Jgxh+tHgPDevDtac0YJYlorQJVI2mQ+rolLSBz7WSwhTiyTAtiPeGqWpm1SL1GnFc9AEg5DXbwdhSENi1l1GM5uYwN8izsfiir44ZAaxWWxM8OrVW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731469219; c=relaxed/simple;
	bh=cCw75c1qDdutqTU50UaEpLrZsygDUKHCsJNRQp2OPHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ITSc5yeoRDG8F0XfRVGplJdSvIoQwlHcbN9A33eSBQsiK0ggz6UPVFf3rkFKQXNpiGPRDknNiKzG4QgQd77Db8rGGrHI2hVVfBilQq8bs8VPqdVHpCCAlO19Khd6v3Xueg9ER1Z9xH0XJ9+8ZDItPjWhDGyVyyFL2jhR8lZmyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbcfsLCG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/4PCnsWq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731469216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjokc7aLWHZ2S2zddSc/0sEw6ueuTBnayvLQIFn2mu0=;
	b=XbcfsLCGd0t9A+9bWImV+2cTQgAEaFHaD0YRkaZxiaHIrKTPTxBT9zx2y3hQNvbHDFXppd
	6YniBHbKVR0YkytAIeAN1bFgsmNl5yb8KCeuph//8JTjJOhKroMGW2qTNoxazCHtj2luY7
	vWhbSw+3026dsYK0aDjN5/57rXxyrgjF1LbtxAUhJm1mwNylAbQlvqZuj7JbxBSKCaBHwi
	dWyPa4lPzYy8OAFE1XAnzfM3JlQJOVvcj2GDt1TpSeyJyAk1HaBPh/KtTRYM6nq57MDjqL
	3NTbwmT69AitSv2ij5mzijtSRc11U3gAxv9Rxo5feprqAML0GyPODuhiMJMJqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731469216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjokc7aLWHZ2S2zddSc/0sEw6ueuTBnayvLQIFn2mu0=;
	b=/4PCnsWqbquoxlkEew5JlxaXRgPBJb9bEyePR2+Nodtw2Srzhdcbjcf+TT0MXe0lcm6Wk4
	1yebZ1otCrdDj/Bw==
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Nuno =?utf-8?Q?S=C3=A1?=
 <noname.nuno@gmail.com>, Jonathan
 Cameron <jic23@kernel.org>
Subject: Re: can/should a disabled irq become pending?
In-Reply-To: <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
References: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
 <87r07gmej2.ffs@tglx>
 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
Date: Wed, 13 Nov 2024 04:40:30 +0100
Message-ID: <87ldxnn6mp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe!

On Tue, Nov 12 2024 at 23:08, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Nov 12, 2024 at 08:35:13PM +0100, Thomas Gleixner wrote:
>> IRQ_DISABLE_UNLAZY solves a different problem. See commit e9849777d0e2
>> ("genirq: Add flag to force mask in disable_irq[_nosync]()") See the
>> full discussion at:
>>=20
>>   https://lore.kernel.org/all/alpine.DEB.2.11.1510092348370.6097@nanos/T=
/#m08531ad84aa9a53c26f91fd55be60fad6b5607b9
>
> I found that thread already before. I didn't understand the
> motivation/problem fixed there though as the thread start is missing on
> lore. I guess the problem was "taking each interrupt twice" as mentioned
> in the commit log, but I don't grokk that either. What means "taken"?
> The controller's irq routine called; or the driver's handler? Or
> something in hardware? I don't see something being done twice.

The problem on that particular hardware is that disabling interrupts at
the device level is not working. That's discussed somewhere in the
thread. The device seems to always raise an interrupt during the
disabled time. So with lazy disable this will invoke the corresponding
low level flow handler which sees 'disabled' and masks it.

On enable the interrupt is unmasked and retriggered. That double
handling costs quite some performance.

> If I understand correctly, IRQ_DISABLE_UNLAZY is only an optimisation,
> but isn't supposed to affect correctness.

That's correct.

>> > My conclusions from this are:
>>=20
>> >  - the rpi GPIO controller should be fixed not to honor
>> >    IRQ_DISABLE_UNLAZY.
>>=20
>> I don't think that there is something to fix which is specific to the
>> RPI GPIO controller. IRQ_DISABLE_UNLAZY is clearly defined and of course
>> it will cause the problem #2 for edge type interrupts on such chips.
>
> So a driver making use of IRQ_DISABLE_UNLAZY must know itself if the
> irq is provided by such a problematic controller?

What I meant is that this is a problem which affects all interrupt chips
which disable the edge detection logic on mask().

>> Ignoring IRQ_DISABLE_UNLAZY might be the right thing to do for this
>> AD7*** use case, but is it universially correct?
>
> If the device driver is agnostic to which irq controller is used (which
> it should be) it must be prepared to handle an irq that triggered while
> it was masked.

The interrupt does not get to the device handler even in the lazy
disable case. Once the driver invoked disable_irq*() the low level flow
handlers (edge, level ...) mask the interrupt line and marks the
interrupt pending. enable_irq() retriggers the interrupt when the
pending bit is set, except when the interrupt line is level triggered.

>> It's probably correct to do so for edge type interrupts. For level type,
>> not so much.
>
> I'm missing a few details here to follow. E.g. is a level irq supposed
> to become pending when the irq line gets only shortly active while the
> irq is masked or while irqs are disabled globally?

Level type interrupts are not transient by definition. They stay
asserted until the driver acknowledged them in the device. That's why
level triggered interrupts are excluded from retrigger. The hardware
takes care of that already. So UNLAZY just works for level triggered
interrupts.

On controllers which suffer from the #2 problem UNLAZY should indeed be
ignored for edge type interrupts. That's something which the controller
should signal via a irqchip flag and the core code can act upon it and
ignore UNLAZY for edge type interrupts.

But that won't fix the problem at hand. Let's take a step back and look
at the larger picture whether this can be reliably "fixed" at all.

The lazy disable case:

   disable_irq();

   // After this point the drivers interrupt handler is not longer
   // invoked. An eventually raised interrupt causes the line to
   // be masked and the interrupt is marked pending.
=20=20=20
   do_spi_transfer();   // Triggers interrupt because of stupid hardware

   enable_irq();        // Interrupt is retriggered in software

   device_handler()

The UNLAZY case where the interrupt controller does not disable edge
detection is not really different:

   disable_irq();

   // After this point the drivers interrupt handler is not longer
   // invoked. The line is masked
=20=20=20
   do_spi_transfer();   // Triggers interrupt because of stupid hardware
                        // which is marked pending in the interrupt control=
ler

   enable_irq();        // Interrupt is raised by the interrupt controller

   device_handler()

In both cases the device handler is up the creek without a paddle
because it cannot tell whether this is a real data ready interrupt or
just the artifact of the SPI transfer.

The UNLAZY case where the interrupt controller disables edge
detection suffers from a different problem:

   disable_irq();

   // After this point the drivers interrupt handler is not longer
   // invoked. The line is masked
=20=20=20
   do_spi_transfer();   // Triggers interrupt because of stupid hardware
                        // which is ignored by the interrupt controller

   enable_irq();        // Races against data ready interrupt

If enable_irq() is invoked _after_ the device triggered the data ready
interrupt, then the interrupt is lost.

IOW, there is no reliable software solution for this problem unless you
have a microcontroller where you have finegrained control over all of
this.

The proper way to handle this for a general purpose CPU/OS is to gate off
the interrupt line in hardware when there is a SPI transfer in progress:

    /RDY ---|>o---|&&
                  |&&------ CPU interrupt pin (raising edge)
    /CS  ---------|&&

>> >  - the ad7124 driver needs some additional logic to check the actual
>> >    line state in the irq handler to differentiate between "real" irqs
>> >    and spurious ones triggered by SPI transfers[1];
>
> Do you agree that this is necessary? I created a patch for that and
> Jonathan had some doubts this is a valid approach.

Something needs to be done obviously.

>> > [1] it can only check the level, not a passed edge, but that seems to
>> >     work in practise
>>=20
>> Right, because once the pin is in /RDY mode again it stays low until the
>> next update happens.
>>=20
>> But this requires that the chip is connected to a GPIO based interrupt
>> line. Non GPIO based interrupt controllers are not providing a line
>> state readback.
>
> Ack. If there is no way to read back the line state and it's unknown if
> the irq controller suffers from problem #2, the only way to still
> benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only act on
> each 2nd irq; or ignore irqs based on timing. That doesn't sound very
> robust though, so maybe the driver has to fall back on polling the
> status register and not use irqs at all in that case.

Actually ignoring the first interrupt after a SPI transfer and waiting
for the next conversion to raise the interrupt again should be robust
enough. The ADC has to be in continous conversion mode for that
obviously.

> It's even unknown to me if all GPIO controller support reading the line
> if they operate in irq mode.

Probably not.

Thanks,

        tglx

