Return-Path: <linux-kernel+bounces-420657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A39D8029
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5773C165278
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1C18FDCE;
	Mon, 25 Nov 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjhehdiL"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BB18FC72
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525420; cv=none; b=KnDr0B6SuApZy2LUqvwo/XdM7PGg4vIqXhXaRoUDM0oQoE3JZCEA6PMzrSWk9iN8Mu2nXlmCEEk8nsg/smEMD9P7OaEL8j7W8ljMaBmYgUnqVBes3jaMyRpgB8HsY/Hgzwf6gfpjba86Tlc7gRoJLuYNBFQD+Q+YRlMsAtjrNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525420; c=relaxed/simple;
	bh=w11cKVN1kz6wP9zd9Icxh4uLUjnz/n7Slicr7Cb6ajw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nwMs9s23ohlJ6cpGmm8PaWt12oEh8Dc0p20kfIrbxQg98d5LD3BhZCO5YfzOYXLn8tUssap385MLFWmqovYcdX8uId5eEP/7NlEMd0aAWehhfn8deHmu05PltUtP4eatglI5r2xfTuJ7WAbc1r+Aqqqe+ae7dluDrseZGGCHxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjhehdiL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a044dce2so6835765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732525417; x=1733130217; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w11cKVN1kz6wP9zd9Icxh4uLUjnz/n7Slicr7Cb6ajw=;
        b=YjhehdiLO79PV0vOvK0uKCgqC9AX60tdMAB6TebcrAlyRhRtwhZsQYGs+PDWOkqz4X
         GYsEFl2Z77kOa6b/hdPqnBSP+FJfvqbNCu4snJ2PxhMVEwOA5melmd2gQl8M7pcS3jVV
         ZNWqsQEtaqQ/TFGr8kPivpLZ4EiOtwt3m8imb8l6ine22OiLipySOUJrlFCuK1vhe82B
         kHC1qmJDYvxeFM/X+Z9yXK0lTsEkZAcB+vJlSK0a+I+U3i1/ZvPS4sdpTSz22lofiw4j
         5GTMI2v/kKMS1/x/XBKBzBzs+Jqe+RxcvuZFfchu6UE0QEmpZLOuy5NEFEQi9SYhC/TB
         +afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525417; x=1733130217;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w11cKVN1kz6wP9zd9Icxh4uLUjnz/n7Slicr7Cb6ajw=;
        b=LiaU9B8HOnTaAtvGyreLHJBt8+JrtCM/p461dVEKfOiWQIjjY8YISpPjDa2ltETEJz
         ZGsvLx/XKT/1BZ4PuLbQ4I99KdquVjtjz3IsD7n0M8bGb9j3Fni5QjsrAK7ki01yjjHW
         41v2joEykoy4c9Pgi5C3xZVoMxiJlLPN4N0I6PYiDvw9i5WXItGwaKv9a59pSd5TSbLG
         nAge10mouglH9cGLaXfCspHnYMnBmS3cCNPvgjZKpYBeO+8uv6HkGX9zmt+nzli66iwP
         16kTsGD9f5054ZQQv5Szk0v2dVIsepaLJ1+Uy3TpEB7UaCnn26WaIbk9ieMG0OaB9oKZ
         DxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjhhECOZStabKgaBCCytSA0NLuLCn3nHACDCgwLCjLPDWbRnMQCNWDG225EcnzL1QOFG9fCEKTYo+/Y8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFTP5Os5l3YeheAEtrKMWj6ZA9prS93vBMrzqdlQYVjY7ybEE
	3D6Uuv64/H0DE+u98S/ytTxo5zoEog76XcB9hsV9DJnvEspsWEGF
X-Gm-Gg: ASbGncsPM/HcEW5jY+B/+NVt3uMXHhSGPNYdJs6+0V/lKhdCM6/DypRJukvJTVKgjBR
	ql//8hnvyR9+MXB9lMlpYH7bfZFmB+tEn4dAhgMNKp9X+KBgg1QtoSY8cPIHEeqwYFQ3SvZKDjH
	kaAKRpPpG+/bSd1jxNeM80ook0vWI7ACrj348REkWByXfT6uraYRzh47Yjcgb4nkC3OzcGnZtNJ
	aA4xfhpvleS7s53t3EbNcRVA6+u6wH9uODOU358z1s5zfTZUsE0fwpLMH1H8PlzCYc7Ld+WRoX7
	whOHINIamk1sZdKpd9UZteW/pydG3LH8MOKsDqg1BKfnS1u7oYS7rA2ltLZfye5NhTj9WqAHrCx
	MxAf2WAA=
X-Google-Smtp-Source: AGHT+IFkCrg6aaa4qn2FRK6a/edDWiqZo2COpb0ARkwQA52MUIvBLxS2ejJPQNoYCr/6q0L9B2vZ6Q==
X-Received: by 2002:a05:600c:4712:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-433ce48f8bamr109544665e9.22.1732525416567;
        Mon, 25 Nov 2024 01:03:36 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349eeb375fsm36258755e9.3.2024.11.25.01.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 01:03:36 -0800 (PST)
Message-ID: <d8b985a830b3cd0a01607740966c11a40c0a696d.camel@gmail.com>
Subject: Re: can/should a disabled irq become pending?
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, 	linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 2024 10:08:02 +0100
In-Reply-To: <rm52vhttbf356nicbbwwy6c7qr7wpf3vjg2nvx7qyryij4mjf3@zdwk3yhxbdso>
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
	 <rm52vhttbf356nicbbwwy6c7qr7wpf3vjg2nvx7qyryij4mjf3@zdwk3yhxbdso>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-25 at 09:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Nov 24, 2024 at 02:18:27PM +0100, Nuno S=C3=A1 wrote:
> > On Sat, 2024-11-23 at 11:28 +0000, Jonathan Cameron wrote:
> > > On Thu, 14 Nov 2024 13:04:58 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >=20
> > > > On Thu, 2024-11-14 at 11:59 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > On Thu, Nov 14, 2024 at 08:49:34AM +0100, Nuno S=C3=A1 wrote:=C2=
=A0=20
> > > > > > On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote:=C2=A0=
=20
> > > > > > > On Wed, Nov 13 2024 at 11:34, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > > > > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:=
=C2=A0=20
> > > > > > > > > The interrupt does not get to the device handler even in =
the
> > > > > > > > > lazy
> > > > > > > > > disable case. Once the driver invoked disable_irq*() the =
low
> > > > > > > > > level
> > > > > > > > > flow
> > > > > > > > > handlers (edge, level ...) mask the interrupt line and ma=
rks
> > > > > > > > > the
> > > > > > > > > interrupt pending. enable_irq() retriggers the interrupt =
when
> > > > > > > > > the
> > > > > > > > > pending bit is set, except when the interrupt line is lev=
el
> > > > > > > > > triggered.=C2=A0
> > > > > > > >=20
> > > > > > > > There's something that I'm still trying to figure... For IR=
Q
> > > > > > > > controllers
> > > > > > > > that=C2=A0not
> > > > > > > > disable edge detection, can't we get the device handler cal=
led
> > > > > > > > twice if
> > > > > > > > we
> > > > > > > > don't set
> > > > > > > > unlazy?
> > > > > > > >=20
> > > > > > > > irq_enable() - > check_irq_resend()
> > > > > > > >=20
> > > > > > > > and then
> > > > > > > >=20
> > > > > > > > handle_edge_irq() raised by the controller=C2=A0=20
> > > > > > >=20
> > > > > > > You're right. We should have a flag which controls the replay
> > > > > > > requirements of an interrupt controller. So far it only skips=
 for
> > > > > > > level
> > > > > > > triggered interrupts, but for those controllers it should ski=
p for
> > > > > > > edge
> > > > > > > too. Something like IRQCHIP_NO_RESEND ...=C2=A0=20
> > > > >=20
> > > > > Agreed, if the irq gets pending while disabled in both hardware a=
nd
> > > > > software, that shouldn't result in two invokations. Is this an is=
sue
> > > > > for
> > > > > level irqs only? For edge irqs this only happens with lazy disabl=
e
> > > > > and=C2=A0=20
> > > >=20
> > > > Resending is already ignore for level...
> > > >=20
> > > > > if two events happen. Hm, I guess in that case we still only want=
 a
> > > > > single
> > > > > invokation of the irq handler?
> > > > > =C2=A0=20
> > > > > > > > Or is the core handling this somehow? I thought IRQS_REPLAY
> > > > > > > > could be
> > > > > > > > doing the trick but I'm not seeing how...=C2=A0=20
> > > > > > >=20
> > > > > > > IRQS_REPLAY is just internal state to avoid double replay.
> > > > > > > =C2=A0=20
> > > > > > > > > On controllers which suffer from the #2 problem UNLAZY sh=
ould
> > > > > > > > > indeed
> > > > > > > > > be
> > > > > > > > > ignored for edge type interrupts. That's something which =
the
> > > > > > > > > controller
> > > > > > > > > should signal via a irqchip flag and the core code can ac=
t
> > > > > > > > > upon it and
> > > > > > > > > ignore UNLAZY for edge type interrupts.
> > > > > > > > >=20
> > > > > > > > > But that won't fix the problem at hand. Let's take a step=
 back
> > > > > > > > > and
> > > > > > > > > look
> > > > > > > > > at the larger picture whether this can be reliably "fixed=
" at
> > > > > > > > > all.
> > > > > > > > > =C2=A0=20
> > > > > > > >=20
> > > > > > > > Yeah, I'm still trying to figure when it's correct for a de=
vice
> > > > > > > > to do
> > > > > > > > UNLAZY? If I'm
> > > > > > > > understanding things, devices that rely on disable_irq*() s=
hould
> > > > > > > > set
> > > > > > > > it?=C2=A0=20
> > > > > > >=20
> > > > > > > Not necessarily. In most cases devices are not re-raising
> > > > > > > interrupts
> > > > > > > before the previous one has been handled and acknowledged in =
the
> > > > > > > device.=C2=A0=20
> > > > >=20
> > > > > Usage of UNLAZY should never affect correctness. It's "only" a
> > > > > performance optimisation which has a positive effect if it's expe=
cted
> > > > > that an irq event happens while it's masked.
> > > > > =C2=A0=20
> > > > > > > > Because problem #2 is something that needs to be handled at=
 the
> > > > > > > > controller and core level if I got you right.=C2=A0=20
> > > > > > >=20
> > > > > > > Yes. We need a irqchip flag for that.
> > > > > > > =C2=A0=20
> > > > > > > > > > Ack. If there is no way to read back the line state and=
 it's
> > > > > > > > > > unknown
> > > > > > > > > > if
> > > > > > > > > > the irq controller suffers from problem #2, the only wa=
y to
> > > > > > > > > > still
> > > > > > > > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY a=
nd
> > > > > > > > > > only act
> > > > > > > > > > on
> > > > > > > > > > each 2nd irq; or ignore irqs based on timing. That does=
n't
> > > > > > > > > > sound
> > > > > > > > > > very
> > > > > > > > > > robust though, so maybe the driver has to fall back on
> > > > > > > > > > polling the
> > > > > > > > > > status register and not use irqs at all in that case.=
=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > Actually ignoring the first interrupt after a SPI transfe=
r and
> > > > > > > > > waiting
> > > > > > > > > for the next conversion to raise the interrupt again shou=
ld be
> > > > > > > > > robust
> > > > > > > > > enough. The ADC has to be in continous conversion mode fo=
r
> > > > > > > > > that
> > > > > > > > > obviously.
> > > > > > > > > =C2=A0=20
> > > > > > > > Might be the only sane option we have, Uwe? If we do this, =
we
> > > > > > > > could be
> > > > > > > > dropping valid samples but only with controllers that suffe=
r
> > > > > > > > from
> > > > > > > > #2.=C2=A0=20
> > > > > > >=20
> > > > > > > No. You have the same problem with the controllers which do n=
ot
> > > > > > > disable
> > > > > > > the edge detection logic.
> > > > > > >=20
> > > > > > > The interrupt controller raises the interrupt on unmask
> > > > > > > (enable_irq()).
> > > > > > > Depending on timing the device handler might be invoked _befo=
re_
> > > > > > > the
> > > > > > > sample is ready, no?=C2=A0=20
> > > > > >=20
> > > > > > For those controllers, I think it's almost always guaranteed th=
at
> > > > > > the first
> > > > > > IRQ
> > > > > > after enable is not really a valid sample. We'll always have so=
me
> > > > > > SPI
> > > > > > transfer
> > > > > > (that should latch an IRQ on the controller) before enable_irq(=
).=C2=A0=20
> > > > >=20
> > > > > The first irq isn't a valid sample unless the driver is preempted
> > > > > between the spi transfer and the following enable_irq() such that=
 the
> > > > > irq event triggered by the SPI transfer doesn't result in calling=
 the
> > > > > irq handler before the sample is ready. I guess that's what you r=
uled=C2=A0
> > > >=20
> > > > I guess that race we could prevent by disabling IRQs...
> > > >=20
> > > > > out by saying "almost always"? I'd recommend to not rely on that.
> > > > > Chips
> > > > > become faster (and so conversion time shorter) which widens the r=
ace
> > > > > window and if you become unsynchronized and ignore every wrong se=
cond
> > > > > irq all samples become bogous.=C2=A0=20
> > > >=20
> > > > Right now we set UNLAZY and that brings this difference in behavior
> > > > depending on
> > > > the IRQ controller we have. But if we remove that change and make s=
ure
> > > > there can
> > > > be no race between enable_irq() and the last spi_transfer, it shoul=
d be
> > > > safe to
> > > > assume the first time we get in the handler is not for a valid samp=
le.
> > > > Not sure
> > > > synchronization could be an issue to the point where you ignore all
> > > > samples. If
> > > > you ignore one IRQ, then the next one needs to be a valid sample (a=
s
> > > > there
> > > > should be no spi_transfer in between).=C2=A0But not sure if it can =
affect
> > > > performance...
> > >=20
> > > I think it is overly optimistic to assume that an interrupt controlle=
r
> > > will
> > > definitely catch both edges.=C2=A0 IIRC some of them have an interest=
ing
> > > acknowledge
> > > dance before they can see an other edge at all.
>=20
> Plus there is also the (probably only theoretic) race condition in
> combination with a controller suffering from #2 that the irq_enable()
> only happens after the conversion was done. Then the irq would be
> missed.
>=20
> > > So it's also possible we only see one interrupt even though there wer=
e
> > > loads
> > > from the spi transfer (which can also trigger multiple if slow enough=
)
>=20
> Ack, so I think we all agree now that the rdy-gpio is needed for
> reliable operation with irq. If that isn't available due to already
> finalized hardware, the only option is polling.
>=20
> > > > I think right now, unless the IRQ controller suffers from #2, every=
 time
> > > > we get
> > > > in the device handler after enable_irq() is not because of DRDY and
> > > > having a
> > > > valid sample or not is pure luck.=20
> > > >=20
> > > > >=20
> > > > > So I still think the extra GPIO read should be implemented (as I
> > > > > proposed in
> > > > > https://lore.kernel.org/linux-iio/20241028160748.489596-9-u.klein=
e-koenig@baylibre.com/
> > > > > )
> > > > > to guarantee reliable operation. If that isn't possible the only
> > > > > really
> > > > > robust way to operate is using polling.=C2=A0=20
> > > >=20
> > > > My only issue with the gpio approach and your conversation with Tho=
mas
> > > > seems to
> > > > prove it is that we're not guaranteed to be able to read the line. =
I
> > > > guess your
> > > > reasoning is that if we can't do that for a platform, then don't gi=
ve
> > > > the gpio
> > > > in DT? But in that case, are we left with a device that might or mi=
ght
> > > > not work?
> > > Now we have some input from Thomas, I'm happier that we basically hav=
e no
> > > choice
> > > for at least some controllers :(
> >=20
> > Agreed. I'm not opposing to the GPIO change (even though not perfect) s=
ince
> > it's
> > better that what we have today and from this whole discussion, it also =
looks
> > like
> > there's not perfect solution anyways.
>=20
> What is your concern that lets you say "not perfect"? Is it just that it
> won't work on every hardware?

Pretty much :)...

- Nuno S=C3=A1


