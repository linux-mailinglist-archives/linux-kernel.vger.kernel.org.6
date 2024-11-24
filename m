Return-Path: <linux-kernel+bounces-419650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B399D7042
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAB028130F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F81ACDE8;
	Sun, 24 Nov 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqrsVQjP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7819DF66
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732454312; cv=none; b=dO9C+/PFmSwPDAbulQ6atK1pLIJ0MrQHHisJb1sCINacs/wURIe4L/CCtaO4ULzshI/6UZq+3DPmQjrBbhgDhRMeDLvjtsbfPuEjPB/unnIv0Ro/2aNzK6rw2bagMXcQoQka2VtZL4DFrAWolTA8qj+6gzDRh1kx9phYKwiIVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732454312; c=relaxed/simple;
	bh=NcPbKVHZkCcr9Ja0BEnlwJy6vPMEWVbLTVBPyoYxQ44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pN7YYDkY06N2uVS1kFnAM4NgDYjoZD+PD0HPfEaA3islRH1k6TdCIjbaDrJ0XsysrO7KWqQvfzcqvIsFa+PvaIv6HJppNJLc0ssFJ/Dgo4W9k9jKbZlWCxvX5nHnP6qczTZ8T98vmk004mHkPKW/JIELIIe8ad3+mvZOKPhfQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqrsVQjP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so33053745e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732454308; x=1733059108; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NcPbKVHZkCcr9Ja0BEnlwJy6vPMEWVbLTVBPyoYxQ44=;
        b=AqrsVQjPSRHmJ/KCFZFLpvAgWZoqQTcp7rJNJy9oUiwfMIoKo8At0460Oq1Su7/T5d
         +33uCWGU0yp6DFjpGMMSiIW82MiFCyLRN567corjzDwA9OMaht1mmfJ+aD5qwQNzUbwh
         bURqCymh/D8JNM3HQ5xI3K5R20hPKCiuNJPxDioK1m6Airh+VphksT00Ru6Daa3rOGcq
         DiWZMgbIMxLISkpmYh8jvtxqL9MMIhUzCPxwjnBz+6jwR563XXYKRBvdxmyPBA2bOwoc
         0sQo9q5kK0Wcsy5mhgEG2a1m6wzLWwTOIOSHzipCmHhtDf4xIPVLyHz0TS7H+OfbmJo9
         RtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732454308; x=1733059108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcPbKVHZkCcr9Ja0BEnlwJy6vPMEWVbLTVBPyoYxQ44=;
        b=rf8dIuoSstOPN+bNi+hJpYIJvW87mWDu1Cxhchvd65XafQs6h8d0+84ZcbLnuRMWqw
         PXW43LPwZwpZGVBZfqR5/+XU4njLkExVbH6B4oTweasZ7teLdmNp5aM5QV3+MTQDsBP+
         Z3yA/w/Yv9nT7xHKVI4GhYBx/9o0sz8FkACPmk7pe960RqgvFsJIGnyaydWMlkNR2Vja
         O1wLJWxaVq7GviPQOkuxQ0SE5U+1RY94P9ITIR7HV/u3HQn43oj5ai8hewUHBHx17y//
         Ok4SYvALmppuaJL5XvXpSoDVGjBYMEjStBL1O4WJFD05C8rWsIllNCcZY1x8KX0up4uP
         Y6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWEJz4My8hD9SXVmRRBfQ3bnf437aJkUYj+vHlZDq8EKnVsj+iENg3Z8XIX7zoAgHPvIzW/wSNJkVhDADg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy37nRFSMOz7ffBEkKWiraIibiv4ZYgmoWTL1qCVX+huxOXpMm
	1h9YGQnopcmALyjF/UZCrw3KzKmhY/juFFRxOgFXNtV6y5r5qsCG6s7o9WxyepxFUA==
X-Gm-Gg: ASbGnctckaxEFnsgQD124Ab1ayufOOLzNXrs/4j3vCp29N3Ec0C22C5HgUNHWRnyx1L
	5x2OMV336ch83z3fp4oe88R7lzIgy68mw7J13LWAUYsL0Y2uCGWUp2w+8nsZDZvyZYy1keZouxF
	mSeh7EF48GsQokBkJD47vjNwzUSxwHHAadJvOuPBGPIXL2a3X96BN+nQj++rCSNrOdL7fNJlHJS
	YMEhtgIJJ3loauoFrF9o4XsYskYi4DynemyjiG8kv6W5kt3BIYqcVMa4dW8L1CSoi+oYC3As9Mo
	XJQ+PKOYK4CDiWsBPAwMujen
X-Google-Smtp-Source: AGHT+IFp0mACqWk3ggxMTvRCxvvE4dB/tfZO941f5sII9B0tZl5sIWT1azXCDg3Qm8dQOovBACeEYQ==
X-Received: by 2002:a05:600c:46c8:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-433ce39b925mr86136425e9.0.1732454308226;
        Sun, 24 Nov 2024 05:18:28 -0800 (PST)
Received: from ?IPv6:2001:a61:356e:be01:4914:b1c1:bc1c:d4fc? ([2001:a61:356e:be01:4914:b1c1:bc1c:d4fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f9eca01sm1115735e9.29.2024.11.24.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 05:18:27 -0800 (PST)
Message-ID: <4267c7155016cf917516957f47fae6a2d0c480ef.camel@gmail.com>
Subject: Re: can/should a disabled irq become pending?
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Date: Sun, 24 Nov 2024 14:18:27 +0100
In-Reply-To: <20241123112834.095b217a@jic23-huawei>
References: 
	<io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
	 <87r07gmej2.ffs@tglx>
	 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
	 <87ldxnn6mp.ffs@tglx>
	 <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
	 <87servku9h.ffs@tglx>
	 <66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>
	 <5pcuve6oz7z5fammiu44e7nldu45gcupjh7vlape4k4ctzrvsf@lpaz2owcag7f>
	 <3793d7e573d57e895f179d7ba90f2b395e1ac135.camel@gmail.com>
	 <20241123112834.095b217a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-11-23 at 11:28 +0000, Jonathan Cameron wrote:
> On Thu, 14 Nov 2024 13:04:58 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2024-11-14 at 11:59 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > On Thu, Nov 14, 2024 at 08:49:34AM +0100, Nuno S=C3=A1 wrote:=C2=A0=
=20
> > > > On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote:=C2=A0=20
> > > > > On Wed, Nov 13 2024 at 11:34, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:=C2=A0=
=20
> > > > > > > The interrupt does not get to the device handler even in the =
lazy
> > > > > > > disable case. Once the driver invoked disable_irq*() the low =
level
> > > > > > > flow
> > > > > > > handlers (edge, level ...) mask the interrupt line and marks =
the
> > > > > > > interrupt pending. enable_irq() retriggers the interrupt when=
 the
> > > > > > > pending bit is set, except when the interrupt line is level t=
riggered.=C2=A0
> > > > > >=20
> > > > > > There's something that I'm still trying to figure... For IRQ co=
ntrollers
> > > > > > that=C2=A0not
> > > > > > disable edge detection, can't we get the device handler called =
twice if
> > > > > > we
> > > > > > don't set
> > > > > > unlazy?
> > > > > >=20
> > > > > > irq_enable() - > check_irq_resend()
> > > > > >=20
> > > > > > and then
> > > > > >=20
> > > > > > handle_edge_irq() raised by the controller=C2=A0=20
> > > > >=20
> > > > > You're right. We should have a flag which controls the replay
> > > > > requirements of an interrupt controller. So far it only skips for=
 level
> > > > > triggered interrupts, but for those controllers it should skip fo=
r edge
> > > > > too. Something like IRQCHIP_NO_RESEND ...=C2=A0=20
> > >=20
> > > Agreed, if the irq gets pending while disabled in both hardware and
> > > software, that shouldn't result in two invokations. Is this an issue =
for
> > > level irqs only? For edge irqs this only happens with lazy disable an=
d=C2=A0=20
> >=20
> > Resending is already ignore for level...
> >=20
> > > if two events happen. Hm, I guess in that case we still only want a s=
ingle
> > > invokation of the irq handler?
> > > =C2=A0=20
> > > > > > Or is the core handling this somehow? I thought IRQS_REPLAY cou=
ld be
> > > > > > doing the trick but I'm not seeing how...=C2=A0=20
> > > > >=20
> > > > > IRQS_REPLAY is just internal state to avoid double replay.
> > > > > =C2=A0=20
> > > > > > > On controllers which suffer from the #2 problem UNLAZY should=
 indeed
> > > > > > > be
> > > > > > > ignored for edge type interrupts. That's something which the
> > > > > > > controller
> > > > > > > should signal via a irqchip flag and the core code can act up=
on it and
> > > > > > > ignore UNLAZY for edge type interrupts.
> > > > > > >=20
> > > > > > > But that won't fix the problem at hand. Let's take a step bac=
k and
> > > > > > > look
> > > > > > > at the larger picture whether this can be reliably "fixed" at=
 all.
> > > > > > > =C2=A0=20
> > > > > >=20
> > > > > > Yeah, I'm still trying to figure when it's correct for a device=
 to do
> > > > > > UNLAZY? If I'm
> > > > > > understanding things, devices that rely on disable_irq*() shoul=
d set
> > > > > > it?=C2=A0=20
> > > > >=20
> > > > > Not necessarily. In most cases devices are not re-raising interru=
pts
> > > > > before the previous one has been handled and acknowledged in the =
device.=C2=A0=20
> > >=20
> > > Usage of UNLAZY should never affect correctness. It's "only" a
> > > performance optimisation which has a positive effect if it's expected
> > > that an irq event happens while it's masked.
> > > =C2=A0=20
> > > > > > Because problem #2 is something that needs to be handled at the
> > > > > > controller and core level if I got you right.=C2=A0=20
> > > > >=20
> > > > > Yes. We need a irqchip flag for that.
> > > > > =C2=A0=20
> > > > > > > > Ack. If there is no way to read back the line state and it'=
s unknown
> > > > > > > > if
> > > > > > > > the irq controller suffers from problem #2, the only way to=
 still
> > > > > > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and o=
nly act
> > > > > > > > on
> > > > > > > > each 2nd irq; or ignore irqs based on timing. That doesn't =
sound
> > > > > > > > very
> > > > > > > > robust though, so maybe the driver has to fall back on poll=
ing the
> > > > > > > > status register and not use irqs at all in that case.=C2=A0=
=20
> > > > > > >=20
> > > > > > > Actually ignoring the first interrupt after a SPI transfer an=
d waiting
> > > > > > > for the next conversion to raise the interrupt again should b=
e robust
> > > > > > > enough. The ADC has to be in continous conversion mode for th=
at
> > > > > > > obviously.
> > > > > > > =C2=A0=20
> > > > > > Might be the only sane option we have, Uwe? If we do this, we c=
ould be
> > > > > > dropping valid samples but only with controllers that suffer fr=
om
> > > > > > #2.=C2=A0=20
> > > > >=20
> > > > > No. You have the same problem with the controllers which do not d=
isable
> > > > > the edge detection logic.
> > > > >=20
> > > > > The interrupt controller raises the interrupt on unmask (enable_i=
rq()).
> > > > > Depending on timing the device handler might be invoked _before_ =
the
> > > > > sample is ready, no?=C2=A0=20
> > > >=20
> > > > For those controllers, I think it's almost always guaranteed that t=
he first
> > > > IRQ
> > > > after enable is not really a valid sample. We'll always have some S=
PI
> > > > transfer
> > > > (that should latch an IRQ on the controller) before enable_irq().=
=C2=A0=20
> > >=20
> > > The first irq isn't a valid sample unless the driver is preempted
> > > between the spi transfer and the following enable_irq() such that the
> > > irq event triggered by the SPI transfer doesn't result in calling the
> > > irq handler before the sample is ready. I guess that's what you ruled=
=C2=A0=20
> >=20
> > I guess that race we could prevent by disabling IRQs...
> >=20
> > > out by saying "almost always"? I'd recommend to not rely on that. Chi=
ps
> > > become faster (and so conversion time shorter) which widens the race
> > > window and if you become unsynchronized and ignore every wrong second
> > > irq all samples become bogous.=C2=A0=20
> >=20
> > Right now we set UNLAZY and that brings this difference in behavior dep=
ending on
> > the IRQ controller we have. But if we remove that change and make sure =
there can
> > be no race between enable_irq() and the last spi_transfer, it should be=
 safe to
> > assume the first time we get in the handler is not for a valid sample. =
Not sure
> > synchronization could be an issue to the point where you ignore all sam=
ples. If
> > you ignore one IRQ, then the next one needs to be a valid sample (as th=
ere
> > should be no spi_transfer in between).=C2=A0But not sure if it can affe=
ct
> > performance...
>=20
> I think it is overly optimistic to assume that an interrupt controller wi=
ll
> definitely catch both edges.=C2=A0 IIRC some of them have an interesting =
acknowledge
> dance before they can see an other edge at all.
>=20
> So it's also possible we only see one interrupt even though there were lo=
ads
> from the spi transfer (which can also trigger multiple if slow enough)
>=20
> >=20
> > I think right now, unless the IRQ controller suffers from #2, every tim=
e we get
> > in the device handler after enable_irq() is not because of DRDY and hav=
ing a
> > valid sample or not is pure luck.=20
> >=20
> > >=20
> > > So I still think the extra GPIO read should be implemented (as I
> > > proposed in
> > > https://lore.kernel.org/linux-iio/20241028160748.489596-9-u.kleine-ko=
enig@baylibre.com/
> > > )
> > > to guarantee reliable operation. If that isn't possible the only real=
ly
> > > robust way to operate is using polling.=C2=A0=20
> >=20
> > My only issue with the gpio approach and your conversation with Thomas =
seems to
> > prove it is that we're not guaranteed to be able to read the line. I gu=
ess your
> > reasoning is that if we can't do that for a platform, then don't give t=
he gpio
> > in DT? But in that case, are we left with a device that might or might =
not work?
> Now we have some input from Thomas, I'm happier that we basically have no=
 choice
> for at least some controllers :(

Agreed. I'm not opposing to the GPIO change (even though not perfect) since=
 it's
better that what we have today and from this whole discussion, it also look=
s like
there's not perfect solution anyways.

>=20
> I don't mind the GPIO being optional, but I don't want to break existing =
boards
> that happen to work (which your patch doesn't do, so fine there).
> It probably makes sense to add quite a bit of documentation to the DT bin=
ding
> to provide some background though keeping it OS independent may be a litt=
le fiddly.
> Perhaps even strongly advise using a GPIO so that people describe it that=
 way
> if their hardware does allow reading the status.=C2=A0=20
>=20
> I'm not sure, but does the flag Thomas suggested let us 'know' if we can =
get
> away (subject to the race condition) with not having a GPIO?=C2=A0 If it =
does
> then we could have the driver fail to probe (or poll instead) for cases w=
here
> we do need it for correctness (e.g. the RPI)
>=20

Don't think so. IIUC, the flag would be something that controllers that can=
not do
edge detection logic when masked would pass to the core so that the UNLAZY =
flag would
be ignored,.

> So in conclusion, some more docs in the dt-binding and I'm fine with your=
 series
> Uwe.
> Sounds like an additional changes to not do lazy on some controllers also=
 makes
> sense.
>=20

In theory, and from this discussion, it seems we should not be doing UNLAZY=
 in the
library (it seems that it combination with some "broken" controllers, it "f=
ixes" some
issues) but at this point I'm afraid we could be breaking some users.

- Nuno S=C3=A1


