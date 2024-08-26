Return-Path: <linux-kernel+bounces-301902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631B95F71D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D155A282917
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73687197558;
	Mon, 26 Aug 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sk7Ar+v6"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77753196D8F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690970; cv=none; b=gP7T5lHJVUJB8OKxetmYZTWDHxAThQ+OGWm3HamCFk/+CqwU3mET38bhgVgFjWYDGlxmBcGojQ8PgSN9ky1wAgpwarJt8j/mpyuhQGDRSiWySXkAkT/qMMFjIfWXvsOM8juyA62x/MX6RaMtSyJgzL8H/Az0L2h5hUOfDr9gyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690970; c=relaxed/simple;
	bh=9RSKHY8JbH28EoEm+lorkKgJk2cKAVL75gA4qL79VwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvuGgWZv3AXfVUMRFrlpSAOxNz0weH88z+fS1Y9bUOXFhaCRMAZIx9awBo+8tYSy53NBSRa1r748QkdSz4b2nxXFHj/REnarSOucjS++bGfH0OTL4kjdCqQOVQnLFI8tVVkPTP9fN6unnkoRf/nv8/yTBX12YdHD42KcQYmgPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sk7Ar+v6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E32371BF205;
	Mon, 26 Aug 2024 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724690965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xb7NN4dIVxALfBJ3uh32jtsuXIAT1jz8saqQJe2YaLw=;
	b=Sk7Ar+v6x2luniJW3LSxrLXYH0SxyKzHyH1rd9gMiU957GbEICPB3kJ6/MKs9PAolEqC3S
	CQ54J6ROyzNE+mvYQYZBKwvMV8uFPEhs24yWwM+0e5RO1OdLpyBEsl6kFRddtYMH4GkY6S
	/okZI6iCKxQRbdiAo5MDO2QOCbQKlEfD7oVcIH8CyQR1fmngx1dJ3CaVBr2Z/i77qiPits
	BS5Mt+i0Zxnz6iK2Y1fFuD6SZItsu2iEleQOCpw4lgDhJLiS4x/3vymH8Cs/ILbQsEnoGm
	jaLv1mGwWuupSpi2+AUE976/ayJB6HzAMouLb41E6cowPugcJuuP+hzMoOV96g==
Date: Mon, 26 Aug 2024 18:49:24 +0200
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
Message-ID: <20240826184924.53b48861@xps-13>
In-Reply-To: <Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
	<20240823180426.056ac093@xps-13>
	<ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
	<20240826100430.33194702@xps-13>
	<Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Mon, 26 Aug 2024 11:56:57 -0400:

> On Mon, Aug 26, 2024 at 10:04:30AM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >
> > Frank.li@nxp.com wrote on Fri, 23 Aug 2024 13:55:15 -0400:
> > =20
> > > On Fri, Aug 23, 2024 at 06:04:26PM +0200, Miquel Raynal wrote: =20
> > > > Hi Frank,
> > > >
> > > > =20
> > > > >  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 ad=
dr)
> > > > >  {
> > > > >  	enum i3c_addr_slot_status status;
> > > > > @@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_=
bus *bus, u8 start_addr)
> > > > >  	enum i3c_addr_slot_status status;
> > > > >  	u8 addr;
> > > > >
> > > > > +	/* try find an address, which have not pre-allocated by assigne=
d-address */ =20
> > > >
> > > > 	Try	to find			has   been
> > > >
> > > > pre-allocated?
> > > > =20
> > > > > +	for (addr =3D start_addr; addr < I3C_MAX_ADDR; addr++) {
> > > > > +		status =3D i3c_bus_get_addr_slot_status_ext(bus, addr);
> > > > > +		if (status =3D=3D I3C_ADDR_SLOT_FREE)
> > > > > +			return addr;
> > > > > +	}
> > > > > +
> > > > > +	/* use pre-allocoated by assigned-address because such device w=
as removed at bus*/ =20
> > > >
> > > > 	  Use      allocated
> > > >
> > > > pre-allocated or assigned?
> > > >
> > > > I guess the logic should be:
> > > > - try the assigned-address
> > > > - look for a free slot
> > > > - look for an already in use slot that must concern a disconnected
> > > >   device
> > > >
> > > > But the comments are not precise enough IMHO. Can you rephrase them=
? =20
> > >
> > > How about:
> > >
> > > Follow the steps below to obtain the I3C dynamic address:
> > >
> > > 1. Retrieve the assigned-address from the device tree (DT). =20
> >
> > I guess here you mean that you try to pick that address, unless if
> > already in use on the bus, right?
> > =20
>=20
> Sorry, It should be typo. See below
>=20
>=20
> > > 2. Look for an available slot address. =20
> >
> > "available address slot"?
> > =20
> > > 3. Look for an address that is pre-reserved by another device with
> > > assigned-address in DT, but where the device is currently offline. =20
> >
> > I don't think this part is precise enough. You don't look for addresses
> > "pre-reserved" but rather more for busy address slots, which might no
> > longer be in-use because the device is currently offline. The fact that
> > the slot might have been pre-reserved in the DT is a detail that may,
> > in some cases, not be true. And as far as I understand your changes,
> > you're not checking the DT addresses but rather more the addresses that
> > have been allocated live (which is anyway better, because i3c might
> > very well be used on a !OF platform).
> >
> > Once we settle on a description, maybe this can be part of the kdoc for
> > the main function searching for the best dynamic address? =20
>=20
> I am not sure I understand what's your means here. The current framework
> is
>=20
> 1. Get a free address first, the get more infromation from devices, like
> BCR, DCR ...
> 2. Check if it is old device, or dt node have assigned-address property.
> 3. if it is old device, switch to use old address (if old address is free)
> according to i3c spec. If dt pre-reserved address is free, switch to use
> dt pre-reserved address.
>=20
> To match 3's requirement as much as possible, when 1 return address, which
> should avoid return dt's assigned-address.
>=20
>=20
> /*
>  * I3C Framework Address Assignment Flow:

	 f	   a	   a	      f

>  * 1 Initial Address Assignment: Attempt to obtain a free address first,

     1.	       a       a

> then gather additional information such as PID, BCR, and DRCR
>  * 2 Address switch:

     2.

>        - 2a: Check if this target device is appeared before. Switch
> to use prevous address of this device.

	 the previous	for

>  *     - 2b: Check if this target device have assigned-address property i=
n dt,

				    has a preferred address based on
				    firmware data (DT). Switch to it if
				    it is the case and the address is
				    free.

Today it's the DT, maybe not tomorrow. You take these values from the
firmware on the board, that feels more generic than talking about a DT
property name.

> switch to this address if it is free.
>  *
> In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b, th=
is
> function should return an address that is not pre-reserved by any target
> device with an assigned address in the device tree (DT).

This does not make sense, if you want to optimize for 2b, why not
selecting the assigned-address property in the first place if it's
available? Also, I don't understand why you would care to specifically
*not* return an address that might be the default one for another
device in the first place. Changing to a free slot (if possible) not
reserved by another device might be done in 2b, which makes operation 1
much more simple, so you put all the complexity at the same time. Even
if you are proceeding with two devices asking the DAA at the same time,
the procedure should work in a way which does not impact the fact that
the second device will get its desired address if the first can take
another one.

> If no such address
> is available, it can return an address that was pre-reserved by a target
> device that is currently offline.

Thanks,
Miqu=C3=A8l

