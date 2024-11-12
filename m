Return-Path: <linux-kernel+bounces-406635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF29C619F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DA1F236A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60D218D76;
	Tue, 12 Nov 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="goBfqk84";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8CNgxykw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9921833A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440143; cv=none; b=lxiLbmv6J2hWQRQhpH/M92IhjNYTLMqiluasIyLKM31kIvQHdZJeQ5Lw9b5ebvUKDo4IX87WR5d0VIn114Mp4STeZB4o6G6pizYeTWMQ835inkxi70O8cmmgSfZtdPsde74D97Aq8pgLofvUAtxF5vfzzMX5kfD6XAW80e24/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440143; c=relaxed/simple;
	bh=4oHI8lgD+cUMK9/qq+mZFDXmB3kyYSfeDzzqIx4C4aM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=lw5ZzBQfxN0oxwGfzCVOwOzCnHanu/4mRCNWiqmdXhrigYmoMxfrdx44Ux9sEikGSS8IL/7NjfCU7zNHtaNY7z2WxLDdupWz9hxV4fq6OrM1lbJB9qb5Og0Ek6DoXCXVQoNni33CNOBRbzdsmRIl4/ASE80xCr1KSb0MYujgTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=goBfqk84; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8CNgxykw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731440141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=L/L3wnFWyRbpTi4X1o/t9pe+BAkOWROyojOdJpMKogU=;
	b=goBfqk84FqDcypKWTVbcKmnWIn5Hi304VL1A4B41taYtujQaOcSbg1vWleIarQcfYgbbe0
	E7nGQVG6Ona8Aj54QzD45V6i1L4M5eRmPa48EYtYA3rVuSavuBqERi4oVd19+AB+/Kw7Al
	0xgdEr7EZQK23UCel9RMcsxwrLoLEcGhO6x6Cv+GwplHC7dgVnQa22QOeS7NlgHbbOrRaR
	4jzhYaE9mebjXvG/Mo3kxnKz+c5wHUI4xGqjg2YNYM2wJqva/vgOimwXpqSNrgMywxGX87
	45vaF499ak82t57uM1hoUmTJRHPMDKnsqiHyTIkq7+KhjIV/u0WsMaaRKNmW6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731440141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=L/L3wnFWyRbpTi4X1o/t9pe+BAkOWROyojOdJpMKogU=;
	b=8CNgxykwQ1PHy1geBCxV8mQb5osy5yuq0R0XsodoeIIaaQgYNYDl2lv9tntgUjyv54qCov
	gdfeIkroG3sWe0Dg==
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Nuno =?utf-8?Q?S=C3=A1?=
 <noname.nuno@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: can/should a disabled irq become pending?
In-Reply-To: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
Date: Tue, 12 Nov 2024 20:35:13 +0100
Message-ID: <87r07gmej2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe!

On Mon, Nov 11 2024 at 14:03, Uwe Kleine-K=C3=B6nig wrote:
> [This mail is about an issue identified in a thread on the linux-iio
> mailing list, but I guess you missed that because the Subject isn't
> "interesting".

Pretty much so :)

> The ad7124 ADC and a few cousins of it have the peculiarity to report
> their interrupt on the SPI MISO line. So while the SPI clock is toggling
> it behaves as MISO and after a transfer it's a falling edge irq
> signal.

Saves a pin and the fallout can be handled in software, or not :)

> So the driver masks the irq during SPI transfers (using irq_disable()).
> It also uses irq_set_status_flags(sigma_delta->irq_line,
> IRQ_DISABLE_UNLAZY);
>
> Now on some irq controllers (e.g. the rpi GPIO controller) the detection
> logic is off between calls to irq_disable() and irq_enable() and so on
> that platform calling irq_enable() makes the irq handler called only on
> a real irq, while for other irq controllers (e.g. the Altera GPIO
> controller) the SPI transfers make the irq pending and irq_enable()
> results in a call of the handler immediately (but very likely before the
> device actually asserted the interrupt).
>
> I think (but please correct me) that the latter behaviour has to be
> expected and the former is even broken as it might miss irq events.

The default lazy disabling of interrupts has two reasons:

    1) Avoid the potentially expensive mask/unmask operations for the
       common case where no interrupt comes in between mask() and
       unmask()

    2) Addressing the problem of edge interrupt controllers, which
       disable the edge detection logic when masked, which in turn
       causes interrupts to be lost.

IRQ_DISABLE_UNLAZY solves a different problem. See commit e9849777d0e2
("genirq: Add flag to force mask in disable_irq[_nosync]()") See the
full discussion at:

  https://lore.kernel.org/all/alpine.DEB.2.11.1510092348370.6097@nanos/T/#m=
08531ad84aa9a53c26f91fd55be60fad6b5607b9

> My conclusions from this are:

>  - the rpi GPIO controller should be fixed not to honor
>    IRQ_DISABLE_UNLAZY.

I don't think that there is something to fix which is specific to the
RPI GPIO controller. IRQ_DISABLE_UNLAZY is clearly defined and of course
it will cause the problem #2 for edge type interrupts on such chips.

Ignoring IRQ_DISABLE_UNLAZY might be the right thing to do for this
AD7*** use case, but is it universially correct?

It's probably correct to do so for edge type interrupts. For level type,
not so much.

>  - the ad7124 driver needs some additional logic to check the actual
>    line state in the irq handler to differentiate between "real" irqs
>    and spurious ones triggered by SPI transfers[1];
>
> [1] it can only check the level, not a passed edge, but that seems to
>     work in practise

Right, because once the pin is in /RDY mode again it stays low until the
next update happens.

But this requires that the chip is connected to a GPIO based interrupt
line. Non GPIO based interrupt controllers are not providing a line
state readback.

Thanks,

        tglx

