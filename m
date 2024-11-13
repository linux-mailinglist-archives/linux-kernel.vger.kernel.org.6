Return-Path: <linux-kernel+bounces-407398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF149C6CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11E4281AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E11FDFBC;
	Wed, 13 Nov 2024 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGearXhb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238391FDFB6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494107; cv=none; b=TnKQrd098qFJc8vbln8TwpdSSPN/LqQ+GWBgfOdH/cRpHWdud54rfN6F4a6LlloCq7kGas5Owue5/YiwjufXWEOe3g8Y+r/7PuY7OL5ZISe5EOXuguBZ84GSLVnrSCnZ2Y6PU40/RTlDWC7UAHCLms22PVsuni7ziqOeAIfRtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494107; c=relaxed/simple;
	bh=dmejQqweeyMbU4Egm0VGQedcf8gY/OzOvyH/RVUea8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9i9b0WSTB+nW2kXCuY2jL55ZNKFagpEtIaNfHyalGqUg6q/KAteCJM17WK7XH9Jm1xvIY0q4maBnUCTcihzfTg8J5aOLvaDudLyF0RZRgx84PoRUr1pdlbE6C9Jn0Yy/evJVZuISoXZ7DQniauJRcIkPqYf65VTgAeLdwiyuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGearXhb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso56375485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731494103; x=1732098903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmejQqweeyMbU4Egm0VGQedcf8gY/OzOvyH/RVUea8Q=;
        b=XGearXhbRrAxfe1xc2SLxkVw/WQvOGZKG5JazaPovPVqW3WWJI8JxyHChpi+OzJhEW
         /aTv3HWzRZvtOMLf38GJXRhZmlPCS6b6toZHckEoe5LCz4BKbYZdwSurujItI7o1DqvY
         NzkJixexO/LyJT9KkMI9m8qRH5q4T+Rk+3CxmkrIQo2+UH2+cTPYrs00yNY8f9x6OSVv
         9IEh5swdLOB/FUvz2hhOUHceuCZfCYm6GHtcaiOwRzG0sPLSzYE2LPCGtq8wvjhxD1Fq
         9tw10yArwvaxuJ20TRYbArF2GPxTiI74y9lbuSckxdccyMOXKmIc1Y2beHzcxFWSOIKh
         la4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494103; x=1732098903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmejQqweeyMbU4Egm0VGQedcf8gY/OzOvyH/RVUea8Q=;
        b=ggx04iCM5KGDVHMIj5UIwBHrRrJD8ZeVtai+iFYkK+25I/+6Nk7zngwDFlCNDCqdtZ
         mtXdywTt77rSawzRQsrxoC+QCsZc2Lee0MyyY6zTvNIREFuaI3lqBevjlnPFW41kYnh9
         vFFppEYuCeLZ3obRhpZbvWyfR4CHxqK+EvKcxN9UZQTngfs/+TXOS37n1CXS6AUkZnHp
         XRZcUgMbVinR+icGMa+tVJm0daMxn8rtn5EMvax7gQLnb2VljwlIpeteiw8arPxRHwRv
         yxbak533QaY1kQk9gHgZ+CnvsoSfn7YDBnrkNW16L57XbpL+eYeJnQ6YSyAhkiDIxYZr
         4QHw==
X-Gm-Message-State: AOJu0YyJ9IzjkvQ+6SRSPZaDoosVWVB3dHPbmEMAcBzolsbMikY0Sy68
	W59mQPoKmODJnYDQpEM2JW8VaZJ4uM54+o7vyxOT3Wiq+iBLjZax
X-Google-Smtp-Source: AGHT+IFsKe0FdrGUiTcoIVzUGxRv/wT6DLfUbQR9i0ocPgo/hfTbXXxRq85MFlSjhMy+Anm7S8U70w==
X-Received: by 2002:a05:6000:799:b0:37d:4744:9d1d with SMTP id ffacd0b85a97d-3820df6777cmr1631319f8f.35.1731494103071;
        Wed, 13 Nov 2024 02:35:03 -0800 (PST)
Received: from ?IPv6:2001:a61:35ec:1c01:114d:4569:f0fc:9190? ([2001:a61:35ec:1c01:114d:4569:f0fc:9190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05f89sm17877633f8f.98.2024.11.13.02.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:35:02 -0800 (PST)
Message-ID: <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
Subject: Re: can/should a disabled irq become pending?
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date: Wed, 13 Nov 2024 11:34:57 +0100
In-Reply-To: <87ldxnn6mp.ffs@tglx>
References: 
	<io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
	 <87r07gmej2.ffs@tglx>
	 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
	 <87ldxnn6mp.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Thomas,

On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:
> Uwe!
>=20
> On Tue, Nov 12 2024 at 23:08, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Nov 12, 2024 at 08:35:13PM +0100, Thomas Gleixner wrote:
> > > IRQ_DISABLE_UNLAZY solves a different problem. See commit e9849777d0e=
2
> > > ("genirq: Add flag to force mask in disable_irq[_nosync]()") See the
> > > full discussion at:
> > >=20
> > > =C2=A0
> > > https://lore.kernel.org/all/alpine.DEB.2.11.1510092348370.6097@nanos/=
T/#m08531ad84aa9a53c26f91fd55be60fad6b5607b9
> >=20
> > I found that thread already before. I didn't understand the
> > motivation/problem fixed there though as the thread start is missing on
> > lore. I guess the problem was "taking each interrupt twice" as mentione=
d
> > in the commit log, but I don't grokk that either. What means "taken"?
> > The controller's irq routine called; or the driver's handler? Or
> > something in hardware? I don't see something being done twice.
>=20
> The problem on that particular hardware is that disabling interrupts at
> the device level is not working. That's discussed somewhere in the
> thread. The device seems to always raise an interrupt during the
> disabled time. So with lazy disable this will invoke the corresponding
> low level flow handler which sees 'disabled' and masks it.
>=20
> On enable the interrupt is unmasked and retriggered. That double
> handling costs quite some performance.
>=20
> > If I understand correctly, IRQ_DISABLE_UNLAZY is only an optimisation,
> > but isn't supposed to affect correctness.
>=20
> That's correct.
>=20
> > > > My conclusions from this are:
> > >=20
> > > > =C2=A0- the rpi GPIO controller should be fixed not to honor
> > > > =C2=A0=C2=A0 IRQ_DISABLE_UNLAZY.
> > >=20
> > > I don't think that there is something to fix which is specific to the
> > > RPI GPIO controller. IRQ_DISABLE_UNLAZY is clearly defined and of cou=
rse
> > > it will cause the problem #2 for edge type interrupts on such chips.
> >=20
> > So a driver making use of IRQ_DISABLE_UNLAZY must know itself if the
> > irq is provided by such a problematic controller?
>=20
> What I meant is that this is a problem which affects all interrupt chips
> which disable the edge detection logic on mask().
>=20
> > > Ignoring IRQ_DISABLE_UNLAZY might be the right thing to do for this
> > > AD7*** use case, but is it universially correct?
> >=20
> > If the device driver is agnostic to which irq controller is used (which
> > it should be) it must be prepared to handle an irq that triggered while
> > it was masked.
>=20
> The interrupt does not get to the device handler even in the lazy
> disable case. Once the driver invoked disable_irq*() the low level flow
> handlers (edge, level ...) mask the interrupt line and marks the
> interrupt pending. enable_irq() retriggers the interrupt when the
> pending bit is set, except when the interrupt line is level triggered.

There's something that I'm still trying to figure... For IRQ controllers th=
at=C2=A0not
disable edge detection, can't we get the device handler called twice if we =
don't set
unlazy?

irq_enable() - > check_irq_resend()

and then

handle_edge_irq() raised by the controller

Or is the core handling this somehow? I thought IRQS_REPLAY could be doing =
the trick
but I'm not seeing how...

>=20
> > > It's probably correct to do so for edge type interrupts. For level ty=
pe,
> > > not so much.
> >=20
> > I'm missing a few details here to follow. E.g. is a level irq supposed
> > to become pending when the irq line gets only shortly active while the
> > irq is masked or while irqs are disabled globally?
>=20
> Level type interrupts are not transient by definition. They stay
> asserted until the driver acknowledged them in the device. That's why
> level triggered interrupts are excluded from retrigger. The hardware
> takes care of that already. So UNLAZY just works for level triggered
> interrupts.
>=20
> On controllers which suffer from the #2 problem UNLAZY should indeed be
> ignored for edge type interrupts. That's something which the controller
> should signal via a irqchip flag and the core code can act upon it and
> ignore UNLAZY for edge type interrupts.
>=20
> But that won't fix the problem at hand. Let's take a step back and look
> at the larger picture whether this can be reliably "fixed" at all.
>=20

Yeah, I'm still trying to figure when it's correct for a device to do UNLAZ=
Y? If I'm
understanding things, devices that rely on disable_irq*() should set it? Be=
cause
problem #2 is something that needs to be handled at the controller and core=
 level if
I got you right.

> The lazy disable case:
>=20
> =C2=A0=C2=A0 disable_irq();
>=20
> =C2=A0=C2=A0 // After this point the drivers interrupt handler is not lon=
ger
> =C2=A0=C2=A0 // invoked. An eventually raised interrupt causes the line t=
o
> =C2=A0=C2=A0 // be masked and the interrupt is marked pending.
> =C2=A0=C2=A0=20
> =C2=A0=C2=A0 do_spi_transfer();=C2=A0=C2=A0 // Triggers interrupt because=
 of stupid hardware
>=20
> =C2=A0=C2=A0 enable_irq();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // I=
nterrupt is retriggered in software
>=20
> =C2=A0=C2=A0 device_handler()
>=20
> The UNLAZY case where the interrupt controller does not disable edge
> detection is not really different:
>=20
> =C2=A0=C2=A0 disable_irq();
>=20
> =C2=A0=C2=A0 // After this point the drivers interrupt handler is not lon=
ger
> =C2=A0=C2=A0 // invoked. The line is masked
> =C2=A0=C2=A0=20
> =C2=A0=C2=A0 do_spi_transfer();=C2=A0=C2=A0 // Triggers interrupt because=
 of stupid hardware
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // which=
 is marked pending in the interrupt controller
>=20
> =C2=A0=C2=A0 enable_irq();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // I=
nterrupt is raised by the interrupt controller
>=20
> =C2=A0=C2=A0 device_handler()
>=20
> In both cases the device handler is up the creek without a paddle
> because it cannot tell whether this is a real data ready interrupt or
> just the artifact of the SPI transfer.
>=20
> The UNLAZY case where the interrupt controller disables edge
> detection suffers from a different problem:
>=20
> =C2=A0=C2=A0 disable_irq();
>=20
> =C2=A0=C2=A0 // After this point the drivers interrupt handler is not lon=
ger
> =C2=A0=C2=A0 // invoked. The line is masked
> =C2=A0=C2=A0=20
> =C2=A0=C2=A0 do_spi_transfer();=C2=A0=C2=A0 // Triggers interrupt because=
 of stupid hardware
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // which=
 is ignored by the interrupt controller
>=20
> =C2=A0=C2=A0 enable_irq();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // R=
aces against data ready interrupt
>=20
> If enable_irq() is invoked _after_ the device triggered the data ready
> interrupt, then the interrupt is lost.

And this had the side effect for things to work with such controllers. See =
[1]. That
was affecting "single shot" conversions rather than IIO buffering (continuo=
us mode)
where the pending IRQ was firing right after enable_irq() causing a complet=
ion to be
signaled and then not reading a valid sample.

I see now that was a bandaid and not a proper fix and won't work with all
controllers.
 =20
>=20
> IOW, there is no reliable software solution for this problem unless you
> have a microcontroller where you have finegrained control over all of
> this.
>=20
> The proper way to handle this for a general purpose CPU/OS is to gate off
> the interrupt line in hardware when there is a SPI transfer in progress:
>=20
> =C2=A0=C2=A0=C2=A0 /RDY ---|>o---|&&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |&&------ CPU interrupt pin (raising edge)
> =C2=A0=C2=A0=C2=A0 /CS=C2=A0 ---------|&&
>=20
> > > > =C2=A0- the ad7124 driver needs some additional logic to check the =
actual
> > > > =C2=A0=C2=A0 line state in the irq handler to differentiate between=
 "real" irqs
> > > > =C2=A0=C2=A0 and spurious ones triggered by SPI transfers[1];
> >=20
> > Do you agree that this is necessary? I created a patch for that and
> > Jonathan had some doubts this is a valid approach.
>=20
> Something needs to be done obviously.
>=20
> > > > [1] it can only check the level, not a passed edge, but that seems =
to
> > > > =C2=A0=C2=A0=C2=A0 work in practise
> > >=20
> > > Right, because once the pin is in /RDY mode again it stays low until =
the
> > > next update happens.
> > >=20
> > > But this requires that the chip is connected to a GPIO based interrup=
t
> > > line. Non GPIO based interrupt controllers are not providing a line
> > > state readback.
> >=20
> > Ack. If there is no way to read back the line state and it's unknown if
> > the irq controller suffers from problem #2, the only way to still
> > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only act on
> > each 2nd irq; or ignore irqs based on timing. That doesn't sound very
> > robust though, so maybe the driver has to fall back on polling the
> > status register and not use irqs at all in that case.
>=20
> Actually ignoring the first interrupt after a SPI transfer and waiting
> for the next conversion to raise the interrupt again should be robust
> enough. The ADC has to be in continous conversion mode for that
> obviously.
>=20

Might be the only sane option we have, Uwe? If we do this, we could be drop=
ping valid
samples but only with controllers that suffer from #2. And in that case, we=
 can loose
samples anyways due to the irq_enable() race.

[1]: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax=
.com/

Thanks for all the clarifications!
- Nuno S=C3=A1
>=20

