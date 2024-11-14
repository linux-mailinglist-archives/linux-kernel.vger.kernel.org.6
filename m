Return-Path: <linux-kernel+bounces-409166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCF9C8838
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F91C2821F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9D1F8193;
	Thu, 14 Nov 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k+AyQ+np"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87331F80DF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582003; cv=none; b=JIMmsmoFIVMbgVUMA9wa9hrLiJEhOgMx4BMQ9/049t98bEypaNNDUeFTtXfdHojQP+N4SXMWF9dldKBZKIfp2Y4Y9By/slTUf8hUqiCiGW7a/h4Rm7ra0yLfK7LStNZYZtHUzF0ZWeB+7z/KS+IEJSUEE6y6t8L5sCJNjH/zos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582003; c=relaxed/simple;
	bh=S2OBKgDb7EfsAm6DjlDRG7S8bE37dA1SJSZ57H/EeTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpSzMFpCASKAWvSCQOrCcPqE3IGSqnzlIaHjeoA/ZhixF0DagthyyGKtrQ45iWjSznxMET5rNPc6kM/1eibbuU15IZ03662n/hMW+fRtVw/qHcJTFxbkco80aJHhzrGskn2OIWb0/AeDgFsv0lhNbt0x3C5SLQs9xwnOqq70d9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k+AyQ+np; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43163667f0eso4407695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731581997; x=1732186797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2OBKgDb7EfsAm6DjlDRG7S8bE37dA1SJSZ57H/EeTM=;
        b=k+AyQ+npLOL+ox29IYnfQjzHRNDO0pBr8S/cDZuF6TQBOdDVleJcS2qD9xd2lhcOl1
         LVxXmMpqQSeE3tdVnU/1jlQ1E3AJusIp/zHiMTenbchR3k19n18PLnrmLHEugg96aVGz
         QkpagInZ/wv820Y9yvqAMNAPVDkVDBikq9Z7j5BtjUHFWoq/xPVB414b7Jmwnnu9QkQi
         lrHVUM58xHWyZ50Dg4x4c9yA2Q3IPwqssKvYbK8rCJjI7gqGJWWLWntQsuYq8e8uMblz
         uVjed5Ha83lzQO67GfFHbXGSWoq8KSw2Da8gSTBR/k88Trjrsi0AqsV8o8ldHrplrvWD
         lBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731581997; x=1732186797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2OBKgDb7EfsAm6DjlDRG7S8bE37dA1SJSZ57H/EeTM=;
        b=LtmX5iu+fq/vv3h2rY6ogieoh8z2AMI8aAVCyomEuY16cF8h2RsGr1dbfDIfBDMMN2
         otzzItVt516+F/3VTJ9NOB6aB1TgQp5PxwX+0w9g+tXfr1tQgV1pPj2O4DeiDi5AbV7u
         cL5aQIZRW9JH4kwPRASmzPSrp28eELqLLDwnI9wLTqOq3OJ1nMbNj514vi+dzAW2XkkS
         zN3ZEhcxFTDB2eymbE8f4zJemW/FRUX7wNLaItF7M1v56MGnj4Pe4+w1KlZTE1G1CISe
         o2aky1n3IERk1Jb5+srk1LcldJzBvrwknk1WBgV/ip8AVq4sxHCFwspBjir0YcdiC9SJ
         Zwkg==
X-Forwarded-Encrypted: i=1; AJvYcCXawTLPYHZrZTA6U0ElD3Fgv81RGSy+Klgcq8ZMzvttDo3R7BSsqMq+lBwMtbJHhHfia3fVYK18vl4D4BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8VW2T918r+aKxZhR+B6l/EmpyMf8elgiLpYG0rIcDbKe7kRl
	J8jfhrVFzfhQjKBpO2AY0Jee0YrHjjJAOZCVU4sreA5hS02sFc5MRbI5lN4n6oU=
X-Google-Smtp-Source: AGHT+IHwEX9v9Gg5Oa6ytsWWdQdh+Ua7wMoNjz22ZQGmHkh3Dgyu6BZ/p4HFgD5xuILqSAUtbK73Yg==
X-Received: by 2002:a05:600c:4f83:b0:432:7c08:d11e with SMTP id 5b1f17b1804b1-432da767b0amr12210595e9.1.1731581996664;
        Thu, 14 Nov 2024 02:59:56 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244924sm19767265e9.7.2024.11.14.02.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:59:56 -0800 (PST)
Date: Thu, 14 Nov 2024 11:59:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: can/should a disabled irq become pending?
Message-ID: <5pcuve6oz7z5fammiu44e7nldu45gcupjh7vlape4k4ctzrvsf@lpaz2owcag7f>
References: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
 <87r07gmej2.ffs@tglx>
 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
 <87ldxnn6mp.ffs@tglx>
 <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
 <87servku9h.ffs@tglx>
 <66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5ba4bemf3rucsjw"
Content-Disposition: inline
In-Reply-To: <66beb423f48bcc0173d51783fb3c4e1b7673fa36.camel@gmail.com>


--z5ba4bemf3rucsjw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can/should a disabled irq become pending?
MIME-Version: 1.0

Hello,

On Thu, Nov 14, 2024 at 08:49:34AM +0100, Nuno S=E1 wrote:
> On Wed, 2024-11-13 at 16:50 +0100, Thomas Gleixner wrote:
> > On Wed, Nov 13 2024 at 11:34, Nuno S=E1 wrote:
> > > On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:
> > > > The interrupt does not get to the device handler even in the lazy
> > > > disable case. Once the driver invoked disable_irq*() the low level =
flow
> > > > handlers (edge, level ...) mask the interrupt line and marks the
> > > > interrupt pending. enable_irq() retriggers the interrupt when the
> > > > pending bit is set, except when the interrupt line is level trigger=
ed.
> > >=20
> > > There's something that I'm still trying to figure... For IRQ controll=
ers
> > > that=A0not
> > > disable edge detection, can't we get the device handler called twice =
if we
> > > don't set
> > > unlazy?
> > >=20
> > > irq_enable() - > check_irq_resend()
> > >=20
> > > and then
> > >=20
> > > handle_edge_irq() raised by the controller
> >=20
> > You're right. We should have a flag which controls the replay
> > requirements of an interrupt controller. So far it only skips for level
> > triggered interrupts, but for those controllers it should skip for edge
> > too. Something like IRQCHIP_NO_RESEND ...

Agreed, if the irq gets pending while disabled in both hardware and
software, that shouldn't result in two invokations. Is this an issue for
level irqs only? For edge irqs this only happens with lazy disable and
if two events happen. Hm, I guess in that case we still only want a single
invokation of the irq handler?

> > > Or is the core handling this somehow? I thought IRQS_REPLAY could be
> > > doing the trick but I'm not seeing how...
> >=20
> > IRQS_REPLAY is just internal state to avoid double replay.
> >=20
> > > > On controllers which suffer from the #2 problem UNLAZY should indee=
d be
> > > > ignored for edge type interrupts. That's something which the contro=
ller
> > > > should signal via a irqchip flag and the core code can act upon it =
and
> > > > ignore UNLAZY for edge type interrupts.
> > > >=20
> > > > But that won't fix the problem at hand. Let's take a step back and =
look
> > > > at the larger picture whether this can be reliably "fixed" at all.
> > > >=20
> > >=20
> > > Yeah, I'm still trying to figure when it's correct for a device to do
> > > UNLAZY? If I'm
> > > understanding things, devices that rely on disable_irq*() should set
> > > it?
> >=20
> > Not necessarily. In most cases devices are not re-raising interrupts
> > before the previous one has been handled and acknowledged in the device.

Usage of UNLAZY should never affect correctness. It's "only" a
performance optimisation which has a positive effect if it's expected
that an irq event happens while it's masked.

> > > Because problem #2 is something that needs to be handled at the
> > > controller and core level if I got you right.
> >=20
> > Yes. We need a irqchip flag for that.
> >=20
> > > > > Ack. If there is no way to read back the line state and it's unkn=
own if
> > > > > the irq controller suffers from problem #2, the only way to still
> > > > > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only ac=
t on
> > > > > each 2nd irq; or ignore irqs based on timing. That doesn't sound =
very
> > > > > robust though, so maybe the driver has to fall back on polling the
> > > > > status register and not use irqs at all in that case.
> > > >=20
> > > > Actually ignoring the first interrupt after a SPI transfer and wait=
ing
> > > > for the next conversion to raise the interrupt again should be robu=
st
> > > > enough. The ADC has to be in continous conversion mode for that
> > > > obviously.
> > > >=20
> > > Might be the only sane option we have, Uwe? If we do this, we could be
> > > dropping valid samples but only with controllers that suffer from
> > > #2.
> >=20
> > No. You have the same problem with the controllers which do not disable
> > the edge detection logic.
> >=20
> > The interrupt controller raises the interrupt on unmask (enable_irq()).
> > Depending on timing the device handler might be invoked _before_ the
> > sample is ready, no?
>=20
> For those controllers, I think it's almost always guaranteed that the fir=
st IRQ
> after enable is not really a valid sample. We'll always have some SPI tra=
nsfer
> (that should latch an IRQ on the controller) before enable_irq().

The first irq isn't a valid sample unless the driver is preempted
between the spi transfer and the following enable_irq() such that the
irq event triggered by the SPI transfer doesn't result in calling the
irq handler before the sample is ready. I guess that's what you ruled
out by saying "almost always"? I'd recommend to not rely on that. Chips
become faster (and so conversion time shorter) which widens the race
window and if you become unsynchronized and ignore every wrong second
irq all samples become bogous.

So I still think the extra GPIO read should be implemented (as I
proposed in
https://lore.kernel.org/linux-iio/20241028160748.489596-9-u.kleine-koenig@b=
aylibre.com/)
to guarantee reliable operation. If that isn't possible the only really
robust way to operate is using polling.

Best regards
Uwe

--z5ba4bemf3rucsjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc12CgACgkQj4D7WH0S
/k5Zgwf/UOFl0RePQiCzCc/QItApNBmBxbRodvZ/hRCmaK4tBNebgEbgwmGUrAdR
rD71v5JDIl+NZX/95aK0GSqo42AZ3hAXPvjJVMbND4X584IVgYXcWv76XeA94l3M
9tpY0f376uEgIxH6ZZcvjf48f7ls5Ck0/UzKQ3W1RRwh0WOVD8Lj2PqIo9TlDTX3
k1cQUfKVso6LZYjpziM0q1Ilu/vETHRbCbDSOMGO+0MNIVtsGD2+0FHQDfVvCaq5
Cxh6daRLSQ3PeNzIfi9YH7Rei77s4K7SHlWX2NpPBFYVp/7jbX7Joek81Vg+dl9U
GrNqoaxLYl4YBCq8wvVzRDp6Y7vGEw==
=EDw1
-----END PGP SIGNATURE-----

--z5ba4bemf3rucsjw--

