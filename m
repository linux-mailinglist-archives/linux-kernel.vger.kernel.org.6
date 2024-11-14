Return-Path: <linux-kernel+bounces-409237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 872999C8965
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC340B23419
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6D1F8925;
	Thu, 14 Nov 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH1DkfDv"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAF1F8918
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585639; cv=none; b=EvRj/RIZzr7RIFYOseJmy+P37WFE2IwJizmcKx50NFKwdkg/O3/uONvHPetDS5eFbNsuZFeggO9Shht+X6hN7H0vli0MRgqKaYo0NuRIStVilP0eY9fHj17hKRTses1y2BQXz9bToUInX4okOcXqKstww70IzZ4mqw9BJ9Bpn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585639; c=relaxed/simple;
	bh=0t8JspNtTGci/w7XdfCsqbu4+RHVXRNvJH5Wk4xJIzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyfBjDrej5BJTaOhbxju3rKgU3S7W1e9JR9+dD+LjrW/0lK5J+L6UOpWPUW7ds/d4wKff4dt/DGZjX3PU5MPJcEhUhrlQaOPQ8BrOeJyTa+oORwWM/06/qcXcLfnl4GQnIQ3wwZtd87g7pjT1yaHV1mt/Nq3+an4Z5r8+/77z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH1DkfDv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so5205805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731585636; x=1732190436; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0t8JspNtTGci/w7XdfCsqbu4+RHVXRNvJH5Wk4xJIzU=;
        b=hH1DkfDvsXB1sh0S/FTonONj4TIOsMDIsg+NWT1LLqzc6Z7ni9TcO22fCbTgZ/kjB5
         2Ppebh/1LTw4+nSknBwbZpEB5D3tPi1ZrU2IL3/Swbxw8W8n4p5i9Lq1gPqM0VAukYpC
         mZ0iwGSe+cPB4EDOH+fdd4VxwXTgCU5jCOVJITyKBgkz5PSfHgGGGDke8DG37/Hhf45+
         cxJWRG/nx53vcZw9dcCuBbo9FKocJ4l0XCkdEX4Z2WTtLPdh8vXL3VXov19IaKg/PUVT
         QxtDmpRPPgTLAkW1La9sFm8l9qSgScHYWY0KOsQlxSYc4Ejc+fjZiSlsaoDK3KwgievU
         tNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585636; x=1732190436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0t8JspNtTGci/w7XdfCsqbu4+RHVXRNvJH5Wk4xJIzU=;
        b=ORcGWsJyxeXCrIykgwiNdoCsXjTen0S+CnkOFCpIsyWNTjWSmwCyVGwdQOtugRK/Jf
         1jIaGjWmQsfB1I2V1S4OYVS0IlFTqW0roriUxHLOuFI+5rC6hMJbzsJZShuPsffhPTgO
         WnsOewlVIVkf4trtp5/KeF0nlsI2aHJUO3CrxDe9jZ6y0OBKPgNenqvbA8wvoyZdR8M8
         mxSTF+BjYYMWngSfYQVu9B20uHX7p5aqPpJ3kyhdkOp7lM3EXXtv3vdLiQDpEpYN3O+9
         6epe+SxwYQz4wWBp3deHka2kAR8AsMi7L1VcRPESglBX5Vz7PKLuAzh3GfOh9oG6rXY/
         4bww==
X-Forwarded-Encrypted: i=1; AJvYcCVPq7+HwY00coBg1IRgM4ucwZRPhAl499XgQT0iKvVV5GULizRcIh61RGjHj+GVof6RqJIoXIRQrpmBYko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA0m/Q72t9i0Lwe4CNzfO61xKffVmPy4GQD1H2xmLM4smme4iu
	EwzhUGlvWvOvyMFKZaMmzYEMiC2vOzLq9slmP96iULMPPBdq25O13CDDqpwgiC3fxAPg
X-Google-Smtp-Source: AGHT+IHcmAcGnf17rQxzaoj51n8L/wWdzghjGjIgqW+R9+UvfdjzO2LxDceW6yk9UbZPfs/kVIaqag==
X-Received: by 2002:a05:600c:1c81:b0:431:518a:683b with SMTP id 5b1f17b1804b1-432da791401mr16257615e9.18.1731585635931;
        Thu, 14 Nov 2024 04:00:35 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28cad9sm21428345e9.32.2024.11.14.04.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:00:35 -0800 (PST)
Message-ID: <3793d7e573d57e895f179d7ba90f2b395e1ac135.camel@gmail.com>
Subject: Re: can/should a disabled irq become pending?
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron
	 <jic23@kernel.org>
Date: Thu, 14 Nov 2024 13:04:58 +0100
In-Reply-To: <5pcuve6oz7z5fammiu44e7nldu45gcupjh7vlape4k4ctzrvsf@lpaz2owcag7f>
References: 
	<io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
	 <87r07gmej2.ffs@tglx>
	 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
	 <87ldxnn6mp.ffs@tglx>
	 <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
	 <87servku9h.ffs@tglx>
	 <66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>
	 <5pcuve6oz7z5fammiu44e7nldu45gcupjh7vlape4k4ctzrvsf@lpaz2owcag7f>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 11:59 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Nov 14, 2024 at 08:49:34AM +0100, Nuno S=C3=A1 wrote:
> > On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote:
> > > On Wed, Nov 13 2024 at 11:34, Nuno S=C3=A1 wrote:
> > > > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:
> > > > > The interrupt does not get to the device handler even in the lazy
> > > > > disable case. Once the driver invoked disable_irq*() the low leve=
l
> > > > > flow
> > > > > handlers (edge, level ...) mask the interrupt line and marks the
> > > > > interrupt pending. enable_irq() retriggers the interrupt when the
> > > > > pending bit is set, except when the interrupt line is level trigg=
ered.
> > > >=20
> > > > There's something that I'm still trying to figure... For IRQ contro=
llers
> > > > that=C2=A0not
> > > > disable edge detection, can't we get the device handler called twic=
e if
> > > > we
> > > > don't set
> > > > unlazy?
> > > >=20
> > > > irq_enable() - > check_irq_resend()
> > > >=20
> > > > and then
> > > >=20
> > > > handle_edge_irq() raised by the controller
> > >=20
> > > You're right. We should have a flag which controls the replay
> > > requirements of an interrupt controller. So far it only skips for lev=
el
> > > triggered interrupts, but for those controllers it should skip for ed=
ge
> > > too. Something like IRQCHIP_NO_RESEND ...
>=20
> Agreed, if the irq gets pending while disabled in both hardware and
> software, that shouldn't result in two invokations. Is this an issue for
> level irqs only? For edge irqs this only happens with lazy disable and

Resending is already ignore for level...

> if two events happen. Hm, I guess in that case we still only want a singl=
e
> invokation of the irq handler?
>=20
> > > > Or is the core handling this somehow? I thought IRQS_REPLAY could b=
e
> > > > doing the trick but I'm not seeing how...
> > >=20
> > > IRQS_REPLAY is just internal state to avoid double replay.
> > >=20
> > > > > On controllers which suffer from the #2 problem UNLAZY should ind=
eed
> > > > > be
> > > > > ignored for edge type interrupts. That's something which the
> > > > > controller
> > > > > should signal via a irqchip flag and the core code can act upon i=
t and
> > > > > ignore UNLAZY for edge type interrupts.
> > > > >=20
> > > > > But that won't fix the problem at hand. Let's take a step back an=
d
> > > > > look
> > > > > at the larger picture whether this can be reliably "fixed" at all=
.
> > > > >=20
> > > >=20
> > > > Yeah, I'm still trying to figure when it's correct for a device to =
do
> > > > UNLAZY? If I'm
> > > > understanding things, devices that rely on disable_irq*() should se=
t
> > > > it?
> > >=20
> > > Not necessarily. In most cases devices are not re-raising interrupts
> > > before the previous one has been handled and acknowledged in the devi=
ce.
>=20
> Usage of UNLAZY should never affect correctness. It's "only" a
> performance optimisation which has a positive effect if it's expected
> that an irq event happens while it's masked.
>=20
> > > > Because problem #2 is something that needs to be handled at the
> > > > controller and core level if I got you right.
> > >=20
> > > Yes. We need a irqchip flag for that.
> > >=20
> > > > > > Ack. If there is no way to read back the line state and it's un=
known
> > > > > > if
> > > > > > the irq controller suffers from problem #2, the only way to sti=
ll
> > > > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only =
act
> > > > > > on
> > > > > > each 2nd irq; or ignore irqs based on timing. That doesn't soun=
d
> > > > > > very
> > > > > > robust though, so maybe the driver has to fall back on polling =
the
> > > > > > status register and not use irqs at all in that case.
> > > > >=20
> > > > > Actually ignoring the first interrupt after a SPI transfer and wa=
iting
> > > > > for the next conversion to raise the interrupt again should be ro=
bust
> > > > > enough. The ADC has to be in continous conversion mode for that
> > > > > obviously.
> > > > >=20
> > > > Might be the only sane option we have, Uwe? If we do this, we could=
 be
> > > > dropping valid samples but only with controllers that suffer from
> > > > #2.
> > >=20
> > > No. You have the same problem with the controllers which do not disab=
le
> > > the edge detection logic.
> > >=20
> > > The interrupt controller raises the interrupt on unmask (enable_irq()=
).
> > > Depending on timing the device handler might be invoked _before_ the
> > > sample is ready, no?
> >=20
> > For those controllers, I think it's almost always guaranteed that the f=
irst
> > IRQ
> > after enable is not really a valid sample. We'll always have some SPI
> > transfer
> > (that should latch an IRQ on the controller) before enable_irq().
>=20
> The first irq isn't a valid sample unless the driver is preempted
> between the spi transfer and the following enable_irq() such that the
> irq event triggered by the SPI transfer doesn't result in calling the
> irq handler before the sample is ready. I guess that's what you ruled

I guess that race we could prevent by disabling IRQs...

> out by saying "almost always"? I'd recommend to not rely on that. Chips
> become faster (and so conversion time shorter) which widens the race
> window and if you become unsynchronized and ignore every wrong second
> irq all samples become bogous.

Right now we set UNLAZY and that brings this difference in behavior dependi=
ng on
the IRQ controller we have. But if we remove that change and make sure ther=
e can
be no race between enable_irq() and the last spi_transfer, it should be saf=
e to
assume the first time we get in the handler is not for a valid sample. Not =
sure
synchronization could be an issue to the point where you ignore all samples=
. If
you ignore one IRQ, then the next one needs to be a valid sample (as there
should be no spi_transfer in between).=C2=A0But not sure if it can affect
performance...

I think right now, unless the IRQ controller suffers from #2, every time we=
 get
in the device handler after enable_irq() is not because of DRDY and having =
a
valid sample or not is pure luck.=20

>=20
> So I still think the extra GPIO read should be implemented (as I
> proposed in
> https://lore.kernel.org/linux-iio/20241028160748.489596-9-u.kleine-koenig=
@baylibre.com/
> )
> to guarantee reliable operation. If that isn't possible the only really
> robust way to operate is using polling.

My only issue with the gpio approach and your conversation with Thomas seem=
s to
prove it is that we're not guaranteed to be able to read the line. I guess =
your
reasoning is that if we can't do that for a platform, then don't give the g=
pio
in DT? But in that case, are we left with a device that might or might not =
work?

"Funny stuff"...

- Nuno S=C3=A1


