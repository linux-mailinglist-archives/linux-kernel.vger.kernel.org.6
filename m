Return-Path: <linux-kernel+bounces-300993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66695EB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3BB1F20FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B2136E01;
	Mon, 26 Aug 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SM85GEVR"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267375817
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659483; cv=none; b=Ns1dIUty20JDuzNLIlDjkkCW89dL/bMoDI2YqrcJ5RqQ5HR7Q68Oz9XavQNxcRgcnPnHlxOKAcQWWbEiO7MM1tyT/4VzeHRtSvoRl4DRWZtWuzvN0ZecdWcNUaY0p6Ghs7RKZtD6n0oODdOjzG0FRhlqGKELphTGep0/FwbOdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659483; c=relaxed/simple;
	bh=46/82Wsk3sgrgWzUVwUCOaY65rUnHUrv96xeBczoVlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qji5s5Vh3EvtHNNQ2IGiXywm4tIs+GwKf9AH5bbUwqlQ150aL9WD9kOp0v1ozcPJUlrhAkoAjRHyQH70n+6/YeG6ovEpBrS099PhTifn/n/+RUfN+Xr1h8I4VbmvCkonu7npHNzrX/GWX4WK6kcBIYjqcdPoXX4aGHIfy3GUJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SM85GEVR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDB761BF208;
	Mon, 26 Aug 2024 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724659473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AurFTrtp1smemYu9ihwDCUynli024FroYMUeOrMc90U=;
	b=SM85GEVRE3CtJNqzA1PYrBvQFq3wwh6N2Djf+FTXTBT/C299Z5LEfKgxidDsfaRoi3ZbxM
	QF4FfEDxijHbpHpD5UT342S3ARjQUenytbBBxN5NA1M2qpDSMz+Un+o58P77LJtdhC9fVq
	kGGXfrZWj1kiyWLt+xHfdJaPr3nczJ15gpgKQKet17E18D3h1zVBwzLZUQP8eQro/T6PKV
	kwNdp8Qn3+PQqi9/I4FccDRy2y6r8FWs+HnFqOrpvgr77ts0mjGrUYgjnDodJvGQy+Bvc1
	pC8nXq77cgdxg+18XS8H9yxN3GKabdTMwOxgNkSl8GEB75lYZU15TTP4FHno8w==
Date: Mon, 26 Aug 2024 10:04:30 +0200
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
Message-ID: <20240826100430.33194702@xps-13>
In-Reply-To: <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
	<20240823180426.056ac093@xps-13>
	<ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Fri, 23 Aug 2024 13:55:15 -0400:

> On Fri, Aug 23, 2024 at 06:04:26PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >
> > =20
> > >  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> > >  {
> > >  	enum i3c_addr_slot_status status;
> > > @@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus =
*bus, u8 start_addr)
> > >  	enum i3c_addr_slot_status status;
> > >  	u8 addr;
> > >
> > > +	/* try find an address, which have not pre-allocated by assigned-ad=
dress */ =20
> >
> > 	Try	to find			has   been
> >
> > pre-allocated?
> > =20
> > > +	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
> > > +		status =3D i3c_bus_get_addr_slot_status_ext(bus, addr);
> > > +		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> > > +			return addr;
> > > +	}
> > > +
> > > +	/* use pre-allocoated by assigned-address because such device was r=
emoved at bus*/ =20
> >
> > 	  Use      allocated
> >
> > pre-allocated or assigned?
> >
> > I guess the logic should be:
> > - try the assigned-address
> > - look for a free slot
> > - look for an already in use slot that must concern a disconnected
> >   device
> >
> > But the comments are not precise enough IMHO. Can you rephrase them? =20
>=20
> How about:
>=20
> Follow the steps below to obtain the I3C dynamic address:
>=20
> 1. Retrieve the assigned-address from the device tree (DT).

I guess here you mean that you try to pick that address, unless if
already in use on the bus, right?

> 2. Look for an available slot address.

"available address slot"?

> 3. Look for an address that is pre-reserved by another device with
> assigned-address in DT, but where the device is currently offline.

I don't think this part is precise enough. You don't look for addresses
"pre-reserved" but rather more for busy address slots, which might no
longer be in-use because the device is currently offline. The fact that
the slot might have been pre-reserved in the DT is a detail that may,
in some cases, not be true. And as far as I understand your changes,
you're not checking the DT addresses but rather more the addresses that
have been allocated live (which is anyway better, because i3c might
very well be used on a !OF platform).

Once we settle on a description, maybe this can be part of the kdoc for
the main function searching for the best dynamic address?

Thanks,
Miqu=C3=A8l

