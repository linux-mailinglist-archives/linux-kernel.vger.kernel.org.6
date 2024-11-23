Return-Path: <linux-kernel+bounces-419040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1919D68DA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F85116141F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608CF18A6A1;
	Sat, 23 Nov 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7je3LAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B316DEB4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732361322; cv=none; b=O2EQS70s3QN3bb9peTqqEdEKnUpa2i13pVcItGGw6+xbYseUC1f95FUgTWRaGTUU8Ru2Ol3BEaQR1RmW8DyNSMMSCVA8Efdl0BKa7X+JBVT+iHMst4inNYFqVg6Y4hOV6fgMvscpWwzLworDIvhjgEqwEKHW8qCWFraRDk4/9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732361322; c=relaxed/simple;
	bh=dP4Vy1J4ZVSnmG1JSkLC6NAyzg96/e0M2CAMiLRG10U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buMxOfimEXto54yLWlKbictvgR+HPyIQVTSgkszXmmkZTboMUjHb6ABuakb90CIngxIfLNnVJbu5+nRehkemqfUvfaiOWhU7NyjzdndnNiLJLmtrNihmtWRFYy3HOsDVLkQ15MbkReSRB7MsBx58Ogbe0Y5QIT7R9c10r+u8peY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7je3LAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E3C4CECD;
	Sat, 23 Nov 2024 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732361321;
	bh=dP4Vy1J4ZVSnmG1JSkLC6NAyzg96/e0M2CAMiLRG10U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C7je3LAKonNAYj24StDVPraebptVdbwarTaIjLhG5bJY6dzvcFYV6Az6P3/EdL14V
	 MIAEWg+pN1sh5RdaSi2q9bayKPkBiU0RKMf2wHIqO64XyTMk7FRs6h9EnSIEFmdAMI
	 PvHd/RL7jNcuJA51wuvVUvrIgem7G4l6gFFS7fZwEw+P/dEkzYyba9sVH7d1QJTCT4
	 y4ckFl/m8xRsJN+I5L2nWgJ58b1kl/fbeDWSni1DuyIH3jp/yR7PDYaAP35Z2X7d4W
	 fSFUxsdy+0+1neQAaA4mA8n4smt7BVUdgFxXbm2R+E/GckTGOZ7hMZj0brgUedOk4x
	 /Q3o5nqtAIhWA==
Date: Sat, 23 Nov 2024 11:28:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: can/should a disabled irq become pending?
Message-ID: <20241123112834.095b217a@jic23-huawei>
In-Reply-To: <3793d7e573d57e895f179d7ba90f2b395e1ac135.camel@gmail.com>
References: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
	<87r07gmej2.ffs@tglx>
	<nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
	<87ldxnn6mp.ffs@tglx>
	<c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
	<87servku9h.ffs@tglx>
	<66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>
	<5pcuve6oz7z5fammiu44e7nldu45gcupjh7vlape4k4ctzrvsf@lpaz2owcag7f>
	<3793d7e573d57e895f179d7ba90f2b395e1ac135.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2024 13:04:58 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-11-14 at 11:59 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Thu, Nov 14, 2024 at 08:49:34AM +0100, Nuno S=C3=A1 wrote: =20
> > > On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote: =20
> > > > On Wed, Nov 13 2024 at 11:34, Nuno S=C3=A1 wrote: =20
> > > > > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote: =20
> > > > > > The interrupt does not get to the device handler even in the la=
zy
> > > > > > disable case. Once the driver invoked disable_irq*() the low le=
vel
> > > > > > flow
> > > > > > handlers (edge, level ...) mask the interrupt line and marks the
> > > > > > interrupt pending. enable_irq() retriggers the interrupt when t=
he
> > > > > > pending bit is set, except when the interrupt line is level tri=
ggered. =20
> > > > >=20
> > > > > There's something that I'm still trying to figure... For IRQ cont=
rollers
> > > > > that=C2=A0not
> > > > > disable edge detection, can't we get the device handler called tw=
ice if
> > > > > we
> > > > > don't set
> > > > > unlazy?
> > > > >=20
> > > > > irq_enable() - > check_irq_resend()
> > > > >=20
> > > > > and then
> > > > >=20
> > > > > handle_edge_irq() raised by the controller =20
> > > >=20
> > > > You're right. We should have a flag which controls the replay
> > > > requirements of an interrupt controller. So far it only skips for l=
evel
> > > > triggered interrupts, but for those controllers it should skip for =
edge
> > > > too. Something like IRQCHIP_NO_RESEND ... =20
> >=20
> > Agreed, if the irq gets pending while disabled in both hardware and
> > software, that shouldn't result in two invokations. Is this an issue for
> > level irqs only? For edge irqs this only happens with lazy disable and =
=20
>=20
> Resending is already ignore for level...
>=20
> > if two events happen. Hm, I guess in that case we still only want a sin=
gle
> > invokation of the irq handler?
> >  =20
> > > > > Or is the core handling this somehow? I thought IRQS_REPLAY could=
 be
> > > > > doing the trick but I'm not seeing how... =20
> > > >=20
> > > > IRQS_REPLAY is just internal state to avoid double replay.
> > > >  =20
> > > > > > On controllers which suffer from the #2 problem UNLAZY should i=
ndeed
> > > > > > be
> > > > > > ignored for edge type interrupts. That's something which the
> > > > > > controller
> > > > > > should signal via a irqchip flag and the core code can act upon=
 it and
> > > > > > ignore UNLAZY for edge type interrupts.
> > > > > >=20
> > > > > > But that won't fix the problem at hand. Let's take a step back =
and
> > > > > > look
> > > > > > at the larger picture whether this can be reliably "fixed" at a=
ll.
> > > > > >  =20
> > > > >=20
> > > > > Yeah, I'm still trying to figure when it's correct for a device t=
o do
> > > > > UNLAZY? If I'm
> > > > > understanding things, devices that rely on disable_irq*() should =
set
> > > > > it? =20
> > > >=20
> > > > Not necessarily. In most cases devices are not re-raising interrupts
> > > > before the previous one has been handled and acknowledged in the de=
vice. =20
> >=20
> > Usage of UNLAZY should never affect correctness. It's "only" a
> > performance optimisation which has a positive effect if it's expected
> > that an irq event happens while it's masked.
> >  =20
> > > > > Because problem #2 is something that needs to be handled at the
> > > > > controller and core level if I got you right. =20
> > > >=20
> > > > Yes. We need a irqchip flag for that.
> > > >  =20
> > > > > > > Ack. If there is no way to read back the line state and it's =
unknown
> > > > > > > if
> > > > > > > the irq controller suffers from problem #2, the only way to s=
till
> > > > > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and onl=
y act
> > > > > > > on
> > > > > > > each 2nd irq; or ignore irqs based on timing. That doesn't so=
und
> > > > > > > very
> > > > > > > robust though, so maybe the driver has to fall back on pollin=
g the
> > > > > > > status register and not use irqs at all in that case. =20
> > > > > >=20
> > > > > > Actually ignoring the first interrupt after a SPI transfer and =
waiting
> > > > > > for the next conversion to raise the interrupt again should be =
robust
> > > > > > enough. The ADC has to be in continous conversion mode for that
> > > > > > obviously.
> > > > > >  =20
> > > > > Might be the only sane option we have, Uwe? If we do this, we cou=
ld be
> > > > > dropping valid samples but only with controllers that suffer from
> > > > > #2. =20
> > > >=20
> > > > No. You have the same problem with the controllers which do not dis=
able
> > > > the edge detection logic.
> > > >=20
> > > > The interrupt controller raises the interrupt on unmask (enable_irq=
()).
> > > > Depending on timing the device handler might be invoked _before_ the
> > > > sample is ready, no? =20
> > >=20
> > > For those controllers, I think it's almost always guaranteed that the=
 first
> > > IRQ
> > > after enable is not really a valid sample. We'll always have some SPI
> > > transfer
> > > (that should latch an IRQ on the controller) before enable_irq(). =20
> >=20
> > The first irq isn't a valid sample unless the driver is preempted
> > between the spi transfer and the following enable_irq() such that the
> > irq event triggered by the SPI transfer doesn't result in calling the
> > irq handler before the sample is ready. I guess that's what you ruled =
=20
>=20
> I guess that race we could prevent by disabling IRQs...
>=20
> > out by saying "almost always"? I'd recommend to not rely on that. Chips
> > become faster (and so conversion time shorter) which widens the race
> > window and if you become unsynchronized and ignore every wrong second
> > irq all samples become bogous. =20
>=20
> Right now we set UNLAZY and that brings this difference in behavior depen=
ding on
> the IRQ controller we have. But if we remove that change and make sure th=
ere can
> be no race between enable_irq() and the last spi_transfer, it should be s=
afe to
> assume the first time we get in the handler is not for a valid sample. No=
t sure
> synchronization could be an issue to the point where you ignore all sampl=
es. If
> you ignore one IRQ, then the next one needs to be a valid sample (as there
> should be no spi_transfer in between).=C2=A0But not sure if it can affect
> performance...

I think it is overly optimistic to assume that an interrupt controller will
definitely catch both edges.  IIRC some of them have an interesting acknowl=
edge
dance before they can see an other edge at all.

So it's also possible we only see one interrupt even though there were loads
from the spi transfer (which can also trigger multiple if slow enough)

>=20
> I think right now, unless the IRQ controller suffers from #2, every time =
we get
> in the device handler after enable_irq() is not because of DRDY and havin=
g a
> valid sample or not is pure luck.=20
>=20
> >=20
> > So I still think the extra GPIO read should be implemented (as I
> > proposed in
> > https://lore.kernel.org/linux-iio/20241028160748.489596-9-u.kleine-koen=
ig@baylibre.com/
> > )
> > to guarantee reliable operation. If that isn't possible the only really
> > robust way to operate is using polling. =20
>=20
> My only issue with the gpio approach and your conversation with Thomas se=
ems to
> prove it is that we're not guaranteed to be able to read the line. I gues=
s your
> reasoning is that if we can't do that for a platform, then don't give the=
 gpio
> in DT? But in that case, are we left with a device that might or might no=
t work?
Now we have some input from Thomas, I'm happier that we basically have no c=
hoice
for at least some controllers :(

I don't mind the GPIO being optional, but I don't want to break existing bo=
ards
that happen to work (which your patch doesn't do, so fine there).
It probably makes sense to add quite a bit of documentation to the DT bindi=
ng
to provide some background though keeping it OS independent may be a little=
 fiddly.
Perhaps even strongly advise using a GPIO so that people describe it that w=
ay
if their hardware does allow reading the status. =20

I'm not sure, but does the flag Thomas suggested let us 'know' if we can get
away (subject to the race condition) with not having a GPIO?  If it does
then we could have the driver fail to probe (or poll instead) for cases whe=
re
we do need it for correctness (e.g. the RPI)

So in conclusion, some more docs in the dt-binding and I'm fine with your s=
eries Uwe.
Sounds like an additional changes to not do lazy on some controllers also m=
akes
sense.

Jonathan

>=20
> "Funny stuff"...
>=20
> - Nuno S=C3=A1
>=20


