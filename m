Return-Path: <linux-kernel+bounces-420625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502D9D7D78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2574928224C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404A18D625;
	Mon, 25 Nov 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QV3hNPeQ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41F18D65F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524655; cv=none; b=ZfUBonTB69Hh9Zi2kPwuePTppLQJ97n1coPXyC5G54ACwjGjXLl/Z/S9WQHAy9or/yQLUsYFLztcb6ZPObq8KGyu9ptkTmoGPfGzPKVlJfdgTMgTeQTTj4FEvf2oEeiFWstGC/hQHyoUfyHLdaXw4Xb01hj/C4mUD07dnZeuM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524655; c=relaxed/simple;
	bh=X+3L+NkQUn0bD9qjEmTCw3gK5EjUxNXw+XNnFSAnR+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm8EC1Dd+wOHsZAFLv01ZV+p66lxRg9nNw7iL/IIXDyqj0FVTgwSOGaMq6UEAcEovu0dZ9OWuuSz6UNJIqokjTWZOUTIhf9ryCnCJSbzwb1kxY2atCn1zwZSirbt55cAECcv+XdDoZhHSCOS2gxa/+GWVO/9GypuKDGSt3re/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QV3hNPeQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3824446d2bcso3729278f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732524650; x=1733129450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+3L+NkQUn0bD9qjEmTCw3gK5EjUxNXw+XNnFSAnR+o=;
        b=QV3hNPeQQ9HiqHX/nCE3TKAgoIgKZ9uR0tlNbXpLaIUaBlaOa3ZFKp75nxlvSnw/GZ
         IAgeyWRM5ktzoS15kZ1n0fGbgSBEodIR/4PVF1vO1DICcMZmFQiyjMWkIEbwuP0UxJeT
         OUcNuAeGUG7eadmH34gXIA5GCuHM3kdEDaS7Y6TtFpV+7/AQ0dQRDLG27Gpgx+ep0szn
         BZmRxfCBCWzWVBTfeJhgKLGZIZAH1akRaGoWWpd/xi16pb6/4S3eEzf/n7xLf9NfqUn5
         EqyocavgbF8+hHQgAKZoG3a9b5JQ+/+VhtsE5Ik4WA7s1b/s4ig7vNOXOqN+2+czairH
         Oyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524650; x=1733129450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+3L+NkQUn0bD9qjEmTCw3gK5EjUxNXw+XNnFSAnR+o=;
        b=BlFyxh9bVd5mPjreYmGaDZrGzOADqBfXxkYSPUgFeHF6Ya7VCKIR2stUFUcLWaTARd
         O+YumXFtBKvs6y038j3t8sYWfngHkc3BEPvbIFG9DKWCuTBi3t15QOYxi1SbKzENEtJ1
         GJkD1diCKrAoSiNU/H0m62qInbeib+DdSrxG4UjbDwAfz0I30UJR1KJ+z0Dn3TYc+gah
         2vJexAq9MCtqgD6xZmFV9QUx4+iHqNiBlaRX+fWR1OAXsB/FXOVUvgj3ng/ZXPiwYkZe
         tvj7BJvCbLQEI0T7mxs1d2bloIJ9SVHf64pf7/7WCl00mFmFVPmDQ1IBnuv0MVanOAWV
         7Gsw==
X-Forwarded-Encrypted: i=1; AJvYcCVCxWPIO29LODZ5ZvDgEgDBbgYFbd8DR9Ld2C1009tAyy2+wZEO7Wmw3XccLdXtEWUOpDEmCJf4dIAsLUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+Q6gBXK09lUYD48Chn4mTP3EcBIsuRwtFh4Hg5zhBRBA0bMK
	O1ITIQdoupkUhEX52glVq419QuVumsorVmbhTu0y+T7g4nO3nkRmndQc7eFk/M8haRI+GPBFgbX
	2
X-Gm-Gg: ASbGnctYibZ9+nVD+ASFXeDbOnZi0muDMTP3LRRhC9rSmyZBg5lXX9PCYnUYJifIMRp
	sgDwPeMqUdg8pQ4WaT9oP6wtscRj1sviOup6/CDihX9LpdU75nO3g4Or1WkpXD/FTdRsLNHTw0Q
	K9Q7JEUcnmHebTwviIGvfCpZUwRa9Ypfz3YRpBJmTT7hNPMHzwV8xQ3j2s4mo5qm+ub1D2VL4cv
	F9CxKGK0nOXhq8YEsIikCWHa4cOvI9L1lMPOmBXJDdSMaQbl3hogpuDs9GdnVSmHZivAflU8NNu
	DZLM
X-Google-Smtp-Source: AGHT+IHOdEfu6vx+83M9uSjiLHFiMgWcJLNzLBiAYo1+hy00mSK5fk3jIYVjjk4vhIrR+eItNZxmtg==
X-Received: by 2002:a5d:59ab:0:b0:382:450c:25e9 with SMTP id ffacd0b85a97d-38260b8ce0bmr12329939f8f.35.1732524649853;
        Mon, 25 Nov 2024 00:50:49 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbed99dsm9630266f8f.94.2024.11.25.00.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:50:49 -0800 (PST)
Date: Mon, 25 Nov 2024 09:50:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: can/should a disabled irq become pending?
Message-ID: <rm52vhttbf356nicbbwwy6c7qr7wpf3vjg2nvx7qyryij4mjf3@zdwk3yhxbdso>
References: <87r07gmej2.ffs@tglx>
 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
 <87ldxnn6mp.ffs@tglx>
 <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
 <87servku9h.ffs@tglx>
 <66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>
 <5pcuve6oz7z5fammiu44e7nldu45gcupjh7vlape4k4ctzrvsf@lpaz2owcag7f>
 <3793d7e573d57e895f179d7ba90f2b395e1ac135.camel@gmail.com>
 <20241123112834.095b217a@jic23-huawei>
 <4267c7155016cf917516957f47fae6a2d0c480ef.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3nidvxswd5ocggx"
Content-Disposition: inline
In-Reply-To: <4267c7155016cf917516957f47fae6a2d0c480ef.camel@gmail.com>


--i3nidvxswd5ocggx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can/should a disabled irq become pending?
MIME-Version: 1.0

Hello,

On Sun, Nov 24, 2024 at 02:18:27PM +0100, Nuno S=E1 wrote:
> On Sat, 2024-11-23 at 11:28 +0000, Jonathan Cameron wrote:
> > On Thu, 14 Nov 2024 13:04:58 +0100
> > Nuno S=E1 <noname.nuno@gmail.com> wrote:
> >=20
> > > On Thu, 2024-11-14 at 11:59 +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Nov 14, 2024 at 08:49:34AM +0100, Nuno S=E1 wrote:=A0=20
> > > > > On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote:=A0=20
> > > > > > On Wed, Nov 13 2024 at 11:34, Nuno S=E1 wrote:=A0=20
> > > > > > > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:=A0=
=20
> > > > > > > > The interrupt does not get to the device handler even in th=
e lazy
> > > > > > > > disable case. Once the driver invoked disable_irq*() the lo=
w level
> > > > > > > > flow
> > > > > > > > handlers (edge, level ...) mask the interrupt line and mark=
s the
> > > > > > > > interrupt pending. enable_irq() retriggers the interrupt wh=
en the
> > > > > > > > pending bit is set, except when the interrupt line is level=
 triggered.=A0
> > > > > > >=20
> > > > > > > There's something that I'm still trying to figure... For IRQ =
controllers
> > > > > > > that=A0not
> > > > > > > disable edge detection, can't we get the device handler calle=
d twice if
> > > > > > > we
> > > > > > > don't set
> > > > > > > unlazy?
> > > > > > >=20
> > > > > > > irq_enable() - > check_irq_resend()
> > > > > > >=20
> > > > > > > and then
> > > > > > >=20
> > > > > > > handle_edge_irq() raised by the controller=A0=20
> > > > > >=20
> > > > > > You're right. We should have a flag which controls the replay
> > > > > > requirements of an interrupt controller. So far it only skips f=
or level
> > > > > > triggered interrupts, but for those controllers it should skip =
for edge
> > > > > > too. Something like IRQCHIP_NO_RESEND ...=A0=20
> > > >=20
> > > > Agreed, if the irq gets pending while disabled in both hardware and
> > > > software, that shouldn't result in two invokations. Is this an issu=
e for
> > > > level irqs only? For edge irqs this only happens with lazy disable =
and=A0=20
> > >=20
> > > Resending is already ignore for level...
> > >=20
> > > > if two events happen. Hm, I guess in that case we still only want a=
 single
> > > > invokation of the irq handler?
> > > > =A0=20
> > > > > > > Or is the core handling this somehow? I thought IRQS_REPLAY c=
ould be
> > > > > > > doing the trick but I'm not seeing how...=A0=20
> > > > > >=20
> > > > > > IRQS_REPLAY is just internal state to avoid double replay.
> > > > > > =A0=20
> > > > > > > > On controllers which suffer from the #2 problem UNLAZY shou=
ld indeed
> > > > > > > > be
> > > > > > > > ignored for edge type interrupts. That's something which the
> > > > > > > > controller
> > > > > > > > should signal via a irqchip flag and the core code can act =
upon it and
> > > > > > > > ignore UNLAZY for edge type interrupts.
> > > > > > > >=20
> > > > > > > > But that won't fix the problem at hand. Let's take a step b=
ack and
> > > > > > > > look
> > > > > > > > at the larger picture whether this can be reliably "fixed" =
at all.
> > > > > > > > =A0=20
> > > > > > >=20
> > > > > > > Yeah, I'm still trying to figure when it's correct for a devi=
ce to do
> > > > > > > UNLAZY? If I'm
> > > > > > > understanding things, devices that rely on disable_irq*() sho=
uld set
> > > > > > > it?=A0=20
> > > > > >=20
> > > > > > Not necessarily. In most cases devices are not re-raising inter=
rupts
> > > > > > before the previous one has been handled and acknowledged in th=
e device.=A0=20
> > > >=20
> > > > Usage of UNLAZY should never affect correctness. It's "only" a
> > > > performance optimisation which has a positive effect if it's expect=
ed
> > > > that an irq event happens while it's masked.
> > > > =A0=20
> > > > > > > Because problem #2 is something that needs to be handled at t=
he
> > > > > > > controller and core level if I got you right.=A0=20
> > > > > >=20
> > > > > > Yes. We need a irqchip flag for that.
> > > > > > =A0=20
> > > > > > > > > Ack. If there is no way to read back the line state and i=
t's unknown
> > > > > > > > > if
> > > > > > > > > the irq controller suffers from problem #2, the only way =
to still
> > > > > > > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and=
 only act
> > > > > > > > > on
> > > > > > > > > each 2nd irq; or ignore irqs based on timing. That doesn'=
t sound
> > > > > > > > > very
> > > > > > > > > robust though, so maybe the driver has to fall back on po=
lling the
> > > > > > > > > status register and not use irqs at all in that case.=A0=
=20
> > > > > > > >=20
> > > > > > > > Actually ignoring the first interrupt after a SPI transfer =
and waiting
> > > > > > > > for the next conversion to raise the interrupt again should=
 be robust
> > > > > > > > enough. The ADC has to be in continous conversion mode for =
that
> > > > > > > > obviously.
> > > > > > > > =A0=20
> > > > > > > Might be the only sane option we have, Uwe? If we do this, we=
 could be
> > > > > > > dropping valid samples but only with controllers that suffer =
=66rom
> > > > > > > #2.=A0=20
> > > > > >=20
> > > > > > No. You have the same problem with the controllers which do not=
 disable
> > > > > > the edge detection logic.
> > > > > >=20
> > > > > > The interrupt controller raises the interrupt on unmask (enable=
_irq()).
> > > > > > Depending on timing the device handler might be invoked _before=
_ the
> > > > > > sample is ready, no?=A0=20
> > > > >=20
> > > > > For those controllers, I think it's almost always guaranteed that=
 the first
> > > > > IRQ
> > > > > after enable is not really a valid sample. We'll always have some=
 SPI
> > > > > transfer
> > > > > (that should latch an IRQ on the controller) before enable_irq().=
=A0=20
> > > >=20
> > > > The first irq isn't a valid sample unless the driver is preempted
> > > > between the spi transfer and the following enable_irq() such that t=
he
> > > > irq event triggered by the SPI transfer doesn't result in calling t=
he
> > > > irq handler before the sample is ready. I guess that's what you rul=
ed=A0=20
> > >=20
> > > I guess that race we could prevent by disabling IRQs...
> > >=20
> > > > out by saying "almost always"? I'd recommend to not rely on that. C=
hips
> > > > become faster (and so conversion time shorter) which widens the race
> > > > window and if you become unsynchronized and ignore every wrong seco=
nd
> > > > irq all samples become bogous.=A0=20
> > >=20
> > > Right now we set UNLAZY and that brings this difference in behavior d=
epending on
> > > the IRQ controller we have. But if we remove that change and make sur=
e there can
> > > be no race between enable_irq() and the last spi_transfer, it should =
be safe to
> > > assume the first time we get in the handler is not for a valid sample=
=2E Not sure
> > > synchronization could be an issue to the point where you ignore all s=
amples. If
> > > you ignore one IRQ, then the next one needs to be a valid sample (as =
there
> > > should be no spi_transfer in between).=A0But not sure if it can affect
> > > performance...
> >=20
> > I think it is overly optimistic to assume that an interrupt controller =
will
> > definitely catch both edges.=A0 IIRC some of them have an interesting a=
cknowledge
> > dance before they can see an other edge at all.

Plus there is also the (probably only theoretic) race condition in
combination with a controller suffering from #2 that the irq_enable()
only happens after the conversion was done. Then the irq would be
missed.

> > So it's also possible we only see one interrupt even though there were =
loads
> > from the spi transfer (which can also trigger multiple if slow enough)

Ack, so I think we all agree now that the rdy-gpio is needed for
reliable operation with irq. If that isn't available due to already
finalized hardware, the only option is polling.

> > > I think right now, unless the IRQ controller suffers from #2, every t=
ime we get
> > > in the device handler after enable_irq() is not because of DRDY and h=
aving a
> > > valid sample or not is pure luck.=20
> > >=20
> > > >=20
> > > > So I still think the extra GPIO read should be implemented (as I
> > > > proposed in
> > > > https://lore.kernel.org/linux-iio/20241028160748.489596-9-u.kleine-=
koenig@baylibre.com/
> > > > )
> > > > to guarantee reliable operation. If that isn't possible the only re=
ally
> > > > robust way to operate is using polling.=A0=20
> > >=20
> > > My only issue with the gpio approach and your conversation with Thoma=
s seems to
> > > prove it is that we're not guaranteed to be able to read the line. I =
guess your
> > > reasoning is that if we can't do that for a platform, then don't give=
 the gpio
> > > in DT? But in that case, are we left with a device that might or migh=
t not work?
> > Now we have some input from Thomas, I'm happier that we basically have =
no choice
> > for at least some controllers :(
>=20
> Agreed. I'm not opposing to the GPIO change (even though not perfect) sin=
ce it's
> better that what we have today and from this whole discussion, it also lo=
oks like
> there's not perfect solution anyways.

What is your concern that lets you say "not perfect"? Is it just that it
won't work on every hardware?
=20
> > I don't mind the GPIO being optional, but I don't want to break existin=
g boards
> > that happen to work (which your patch doesn't do, so fine there).
> > It probably makes sense to add quite a bit of documentation to the DT b=
inding
> > to provide some background though keeping it OS independent may be a li=
ttle fiddly.
> > Perhaps even strongly advise using a GPIO so that people describe it th=
at way
> > if their hardware does allow reading the status.=A0=20

Yeah, I also think that this should make it into the documentation
provided by ADI. I didn't check yet what currently is available, but if
there is an application note about how to add such a device to a custom
hardware design, adding a hint there would be nice, too.

> > I'm not sure, but does the flag Thomas suggested let us 'know' if we ca=
n get
> > away (subject to the race condition) with not having a GPIO?=A0 If it d=
oes
> > then we could have the driver fail to probe (or poll instead) for cases=
 where
> > we do need it for correctness (e.g. the RPI)

In the long run we won't get away without the GPIO if irq controllers
affected by #2 learn to refuse unlazy handling. I have no brilliant idea
here. If we don't question to fix the unlazy handling the best is
probably a warning during probe + checking the status register before
reading a sample? This would essentially mean busy polling on the spi
bus for the affected devices.

> > So in conclusion, some more docs in the dt-binding and I'm fine with yo=
ur series
> > Uwe.

I'll care for an updated series also to cope for the other feedback I
got.

> > Sounds like an additional changes to not do lazy on some controllers al=
so makes
> > sense.
>=20
> In theory, and from this discussion, it seems we should not be doing UNLA=
ZY in the
> library (it seems that it combination with some "broken" controllers, it =
"fixes" some
> issues) but at this point I'm afraid we could be breaking some users.

And also consider all the other drivers we don't know about that might
break in the same way. Might be worth checking the ones disabling lazy
disable when #2 is addressed.

Best regards
Uwe

--i3nidvxswd5ocggx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEOmUACgkQj4D7WH0S
/k5P2Af/SicOuzkM3RJnZmk1+pTLvBQQTf2awlBhm0b7q/hYwdF1BSXVvmZqXGfE
JqS31nuxeE5KURlxuBYE2NDSg+JxbD/WZXvSD6lfuSKdrU3y3Yyk611H/OtEbIea
ucPM3GiolMzLmm3CPQ+Wj6TZKAjR2ikbU8oUSyZgT3tWAAXe2256p5LwTYMfFr3A
PEhySeufFsN5AC6htcAMomuSkFrZGRZGeUNZ9XiV9Onnk5aQYl1yqKFOP2TS5/HQ
iyXnSjLUe8RxEfxJjFze8GrpRHMkP7WbL5GiavJeYaE6VW3EpcwQ6K3LPCiIdoqr
i+bsOEbDIBo+0KuibMzz1OC7sccmvQ==
=Osv2
-----END PGP SIGNATURE-----

--i3nidvxswd5ocggx--

