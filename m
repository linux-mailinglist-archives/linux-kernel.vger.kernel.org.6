Return-Path: <linux-kernel+bounces-312978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD0969E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E5282D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0F1CA6B8;
	Tue,  3 Sep 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Omt6/9d8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CA1CA687
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368448; cv=none; b=TXJ5bRvRQIxodFXN6ScuglfXi+r1EO+jS3lFeZqYkQIekbet5AKn82iskBCkMxamJJY+0wVi8vOGBeHI2Cazv10JfuI2Ri89QVHqZ5MOVeZEDJ6IqYB35poCgVqlWUW9l4Ph6Av8XOzsS/jTw1BwY1/vBg+8k3V4QVxcWsAyw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368448; c=relaxed/simple;
	bh=+NMomSN5qzFQVRflmMClhfQIT7tuVrzOW9N5nigKAz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGtDHnCbbKhDcbnlerF3BypSfiSleBKPfVv+j7eddKrNWiVV2Zl2OwIGXOUyFC2VNbLpZcCyV2A2xxiJ3ORxGsPhq6dAmXKHSi+8yY07UngdXtXkX3D5KQDeBgeUZU0zOKgaldmUOef/RTug7RU15lBfooavtlZacu2Qti4FUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Omt6/9d8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E70CE240003;
	Tue,  3 Sep 2024 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725368442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkuUmV3lialxWeUM5Ad2YOHupRRB0gDWocBubLJ/teE=;
	b=Omt6/9d8bLVXbWm5GYCR83XbWNyFyUWf1oGygw5GqH93JIVxN11ZJT0BTQ2cHzVbmVkSF/
	9ZBxlgU/wBcZ1zjW+LlxZTnvpJ+GWCmoIgzTzUdt3JJwGyYATr5L5BB6Wr/hjt8FADZ4x+
	HmSL8b+bvqh7UHt8wCf/+g4UHkzSRENG9kOJeLZXLPIrZtjtcJifn2hThAmYNhEYifXycH
	ZQMCvGihIpTCOpug9/CetC70ojtAkljrd45tMQ8ekpQFbDaKf77rNni0PS2XmIEXap4BFU
	hXFfVPBuUS7UEMxNg2m2LRlA0yOMoqU4e+a+pyAqt5+HSTCyhFj4LYrGRwptZg==
Date: Tue, 3 Sep 2024 15:00:38 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 03/11] i3c: master: Extend address status bit to 4
 and add I3C_ADDR_SLOT_EXT_INIT
Message-ID: <20240903150038.3f224ec9@xps-13>
In-Reply-To: <ZtYCA9cYywmUaJSQ@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
	<20240823180426.056ac093@xps-13>
	<ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
	<20240826100430.33194702@xps-13>
	<Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
	<20240826184924.53b48861@xps-13>
	<ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
	<20240902161250.26846654@xps-13>
	<ZtYCA9cYywmUaJSQ@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.li@nxp.com wrote on Mon, 2 Sep 2024 14:20:51 -0400:

> On Mon, Sep 02, 2024 at 04:12:50PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> > =20
> > > > > switch to this address if it is free.
> > > > >  *
> > > > > In step 1, i3c_bus_get_free_addr() is called. To optimize for ste=
p 2b, this
> > > > > function should return an address that is not pre-reserved by any=
 target
> > > > > device with an assigned address in the device tree (DT). =20
> > > >
> > > > This does not make sense, if you want to optimize for 2b, why not
> > > > selecting the assigned-address property in the first place if it's
> > > > available? =20
> > >
> > > This is my first idea. But I gived up this way.
> > >
> > > Select an assigned-address here will involve a big change in i3c fram=
ework.
> > > There are no PID information in i3c_master_get_free_addr().
> > >
> > > In DAA flow:
> > > - SVC is get PID first, the get_free_addr(). This case, we can use PI=
D to
> > > get dt assigned address.(if change/add API)
> > > - But HCI, it is difference, hci_cmd_v2_daa(), get_free_addr() firstl=
y then
> > > send out DAA command. So no PID information when call get_free_addr().
> > >
> > > To cover both case, return a *real* free address here is simplest sol=
ution. =20
> >
> > But this is a limitation of the HCI driver? So why not addressing this
> > in the HCI driver instead? It would greatly simplify the core logic
> > which becomes complex for wrong reasons. =20
>=20
> It is reasonable requirement to reduce stall SCL time. After get PID, SCL
> have to stall low to wait for software get dynamtic address, I3C spec all=
ow
> relative long time for this, but still better if hardware can send out PID
> and dynamatic address together withoug stall SCL low. Pre-alloc adddress =
is
> good method if consider this.

I don't think it is worth the trouble, given the complexity of all
the changes. I prefer to simplify a bit the software and keep it
readable than gaining few us with SCL low. In this case you also spend
more time on the configuration I guess, so is it better than keeping
SCL low (it will be low for some time anyway).

> > > >  Also, I don't understand why you would care to specifically
> > > > *not* return an address that might be the default one for another
> > > > device in the first place. =20
> > >
> > > If devices A (want adddress 0xA), device B (want address 0xB), if both
> > > device send hot join at the same time. device B's PID less than devic=
e A,
> > >
> > > Device B will be found firstly, call get_free_addr(), 0xA will be ret=
urn
> > > if no this patch.
> > >
> > > Device A, call try_get_freeaddr() to get 0xB.
> > >
> > > So Devcie B will be assign to 0xA, and Device A will be assign to add=
ress 0xB.
> > >
> > > After do_daa command, framework will add device B and device A into i=
3c bus.
> > >
> > > When framework try to add device B to i3c bus, framework will try swi=
tch
> > > device B's address to 0xB from 0xA, but it will be fail because 0xB a=
lready
> > > assigned to device A. =20
> >
> > Well, okay, but that's exactly the situation that will happen if these
> > devices are not described in your DT. I guess it's expected that a
> > device not described in your DT can be connected, thanks to the
> > hot-join feature. In this case you cannot know what is this device
> > preferred address and you might end-up in the exact same situation. =20
>=20
> If not descript in DT, it means that any dynmatic address can be assigned.

That's the point of view of the host. But a device might be "critical"
and expect a low address, but the host not being aware. This is the
same situation as your A and B conflict example.

> > May I question the need for preferred addresses at all? Is this even
> > part of the spec? What is the use-case? =20
>=20
> It is implements detail. I3C spec said lower dynamtic address have high I=
BI
> priority. Spec just said assign lower dynamtic address if want to higher
> IBI prioerity. Using DT assign-address just is one implement method.

Thanks for all the information, for me the HCI driver must be modified
to retrieve the PID before assigning the dynamic address.

Thanks,
Miqu=C3=A8l

