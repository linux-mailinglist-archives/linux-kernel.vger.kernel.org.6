Return-Path: <linux-kernel+bounces-408834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B189C841D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8F51F22DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7C41EF09F;
	Thu, 14 Nov 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJCD2+9B"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF81E9080
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570315; cv=none; b=Gtg6iJgs/qAwrAIzZ77VHfRY4CsmqxxDtbYFh7TJEyXz8LULcRPCdGkdqSqkzC8QTCj1AeawpURekQa16/dH4kw8z3kq0UL+4kXfolldcmupBomZqhgAa7G/iOqyMpFPkemnwSm1QyedCmpsjczAraUA7TaXxXv2/rPPC1tOOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570315; c=relaxed/simple;
	bh=uEIiSiT6MVvfxPz2XPGu2GD0xwRCZ3nAWNCTUt1MAmk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbluTbTWQvAox4UB/JwFGbasUyCpuQgr0OnR/Y/gDwqpEM7ZqShqCnojevsPSPv6S1nkdwqJfZU1i/7MeXRM9+LtboJlQiqRkpykJzoMkBzYD53wGJgMy3URfV7h/1/RKYFFU3jVAsIsl+1K+oLRQ4eeKAAcmoxVzNYGoH61+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJCD2+9B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314b316495so2904315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731570312; x=1732175112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEIiSiT6MVvfxPz2XPGu2GD0xwRCZ3nAWNCTUt1MAmk=;
        b=bJCD2+9BZEqGkry9pefU5yJf+Erx5PePj92fduDmjWC8OhKKX4tOtwyow6sm0hEOa0
         BE7W2Xus/o1erDNb/JvoYaKNXlAJkigZI4FMCe8otZWVcd/jpAui7WVy3/2G0SSHc0CH
         ASbwCadq7oE7N2HHNHT/aQKd9XqgGTaCOGVnMKevxwy8giJGokQpL8VITt3ZilUfn/p7
         JH+s6CBkEMyrHrk+GlEwUoMudcaOqRzl/zSu4Pn7SzqPf0wfmqneT1JDPlDeRoXOi7Vi
         HVYYVro5RbCpibyj+DHITKSJodkzJCaicOOJR8ZFVuRoDyGzcGN1Fin14blKGAbjoyyU
         1dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731570312; x=1732175112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEIiSiT6MVvfxPz2XPGu2GD0xwRCZ3nAWNCTUt1MAmk=;
        b=qibAGr14i2pd7oqUgOmLhuroPk1l5IjqzIl/V13+VX5FlQU9/Ajlk9MJuMBKi/9Qfu
         eLxodLHAXBNFPHwP47lb9NTkkAtosccsNutnMLor25sdWpVYfLNhyGk2VdYkAyduLjbQ
         3U4JLbCxUw3I9AbEj3PjfmA65pAsh3AKFvlKlhApaHCU4scWrTpHU8n/ij2si0hOQaA9
         Wj3mTq6mYYKoi5mcaDO87JrCBr2bEcRZ7dl1CXuJ1hwAZ+ODf82CJx0vvfflkUQOUD3C
         0BlB+YqJCY/gKs/yA3Ih5SvPR20Z2oGfRJzZub64jrWueE+LroAh0z9s4YPoKo8aXO84
         BuBQ==
X-Gm-Message-State: AOJu0YwDwnJLgNHLhjijBkrpBXdDzb66ga1229VhKc/TFUtSWdRUE8gY
	4N1t31/Q43Opy/yQaqND6hexBkBtnGV0jUucJEwwfm5CFqiNlnU/
X-Google-Smtp-Source: AGHT+IGPTlNHqMZqPDvm0bdoT2aFPVZEFTvnVfJQ3xOHkQwWI1e6abOVgjX1CVc7FhN97N/zH6trJg==
X-Received: by 2002:a05:6000:1446:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-3820df5c096mr5025433f8f.10.1731570311828;
        Wed, 13 Nov 2024 23:45:11 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad945sm697889f8f.29.2024.11.13.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:45:11 -0800 (PST)
Message-ID: <66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>
Subject: Re: can/should a disabled irq become pending?
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date: Thu, 14 Nov 2024 08:49:34 +0100
In-Reply-To: <87servku9h.ffs@tglx>
References: 
	<io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
	 <87r07gmej2.ffs@tglx>
	 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
	 <87ldxnn6mp.ffs@tglx>
	 <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
	 <87servku9h.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote:
> On Wed, Nov 13 2024 at 11:34, Nuno S=C3=A1 wrote:
> > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:
> > > The interrupt does not get to the device handler even in the lazy
> > > disable case. Once the driver invoked disable_irq*() the low level fl=
ow
> > > handlers (edge, level ...) mask the interrupt line and marks the
> > > interrupt pending. enable_irq() retriggers the interrupt when the
> > > pending bit is set, except when the interrupt line is level triggered=
.
> >=20
> > There's something that I'm still trying to figure... For IRQ controller=
s
> > that=C2=A0not
> > disable edge detection, can't we get the device handler called twice if=
 we
> > don't set
> > unlazy?
> >=20
> > irq_enable() - > check_irq_resend()
> >=20
> > and then
> >=20
> > handle_edge_irq() raised by the controller
>=20
> You're right. We should have a flag which controls the replay
> requirements of an interrupt controller. So far it only skips for level
> triggered interrupts, but for those controllers it should skip for edge
> too. Something like IRQCHIP_NO_RESEND ...
>=20
> > Or is the core handling this somehow? I thought IRQS_REPLAY could be
> > doing the trick but I'm not seeing how...
>=20
> IRQS_REPLAY is just internal state to avoid double replay.
>=20
> > > On controllers which suffer from the #2 problem UNLAZY should indeed =
be
> > > ignored for edge type interrupts. That's something which the controll=
er
> > > should signal via a irqchip flag and the core code can act upon it an=
d
> > > ignore UNLAZY for edge type interrupts.
> > >=20
> > > But that won't fix the problem at hand. Let's take a step back and lo=
ok
> > > at the larger picture whether this can be reliably "fixed" at all.
> > >=20
> >=20
> > Yeah, I'm still trying to figure when it's correct for a device to do
> > UNLAZY? If I'm
> > understanding things, devices that rely on disable_irq*() should set
> > it?
>=20
> Not necessarily. In most cases devices are not re-raising interrupts
> before the previous one has been handled and acknowledged in the device.
>=20
> > Because problem #2 is something that needs to be handled at the
> > controller and core level if I got you right.
>=20
> Yes. We need a irqchip flag for that.
>=20
> > > > Ack. If there is no way to read back the line state and it's unknow=
n if
> > > > the irq controller suffers from problem #2, the only way to still
> > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only act =
on
> > > > each 2nd irq; or ignore irqs based on timing. That doesn't sound ve=
ry
> > > > robust though, so maybe the driver has to fall back on polling the
> > > > status register and not use irqs at all in that case.
> > >=20
> > > Actually ignoring the first interrupt after a SPI transfer and waitin=
g
> > > for the next conversion to raise the interrupt again should be robust
> > > enough. The ADC has to be in continous conversion mode for that
> > > obviously.
> > >=20
> > Might be the only sane option we have, Uwe? If we do this, we could be
> > dropping valid samples but only with controllers that suffer from
> > #2.
>=20
> No. You have the same problem with the controllers which do not disable
> the edge detection logic.
>=20
> The interrupt controller raises the interrupt on unmask (enable_irq()).
> Depending on timing the device handler might be invoked _before_ the
> sample is ready, no?
>=20

For those controllers, I think it's almost always guaranteed that the first=
 IRQ
after enable is not really a valid sample. We'll always have some SPI trans=
fer
(that should latch an IRQ on the controller) before enable_irq().

- Nuno S=C3=A1


