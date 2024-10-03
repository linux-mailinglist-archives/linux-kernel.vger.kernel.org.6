Return-Path: <linux-kernel+bounces-348762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0995E98EB97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E2B28370F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA613B293;
	Thu,  3 Oct 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MP5sqVuW"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410E126C04
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944166; cv=none; b=d8lZ5nuYrs7+JGfA90tBfwEOL1aG4/d6K7CrhYL5Oic44nwHFeGOC4nvLra3Ya96kINnnkGEOqO84AQkR4WKm7NCbyiJlaV+mitPhCQlgdOwxW7D6KHXOBi9/u7unSYkyjEeOHsWRujpibTU0BLGZ+SOLFCqVjqL9AZJtZmZ8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944166; c=relaxed/simple;
	bh=BfLWmUgYePR849tcGNArXhsjHUNm4htol44xcySJV4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZX6F1JWkPfbCa9USDLnlB5ae1xkw8J5aCz+sGdEEQabF5mdeq7HUnfi0gAnTj4LrT/nQbBEMJ4hdH/Mjw8ldA1TPAnrwdv2dCCGIZdEfqh9In+gJw99Uf72DJYxqvuxYieoAEFZiYBP2GQCdExDxo7rCTI5SJW32j1o9rPzlFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MP5sqVuW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 857571BF23C;
	Thu,  3 Oct 2024 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWhKgAh29eCDmjxeIkKTW4yOpIcC1z2EdppPQVN5/bE=;
	b=MP5sqVuWNKaLvWYs4nA+uCRPmFOaMMFU4cMPQ0+jbkUp/FrmNYJ52d/VRj/usReH9aggB5
	wXVgnsR4sAv4tco9VvaSYZCBJclUouTWb89teW04zqF76yv1nIiOBhY8FvauUB6QqfaIoi
	Hc+CvR9XsVWlEqSPT6D9s4+CeoD1wEhGwsBFS+3aJmUAfW3NAGUNponqvcOTXtvc+dUz4U
	wak+jbVjTFW9+tsPiulQgdN33iqpbt8DnHuzlrHCrKrC2MUQYA/g4/L0dUQKgk4HHH0jOO
	w9E8ydk0zjaADsx67qQ+gN0/OwrdY8YQ8AUu9dD1HYRthYpzwnqoJ4yZ5oswXw==
Date: Thu, 3 Oct 2024 10:29:21 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_INIT
Message-ID: <20241003102921.771b2bc1@xps-13>
In-Reply-To: <Zv15UjD9yvJb43MF@lizhi-Precision-Tower-5810>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
	<20241001-i3c_dts_assign-v1-2-6ba83dc15eb8@nxp.com>
	<20241002094944.5c0c83c8@xps-13>
	<Zv15UjD9yvJb43MF@lizhi-Precision-Tower-5810>
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

> > >
> > > -static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 ad=
dr,
> > > -					 enum i3c_addr_slot_status status)
> > > +static enum i3c_addr_slot_status
> > > +i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> > > +{
> > > +	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_=
STATUS_MASK;
> > > +}
> > > +
> > > +static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u=
16 addr,
> > > +					      enum i3c_addr_slot_status status, int mask)
> > >  {
> > >  	int bitpos =3D addr * I3C_ADDR_SLOT_STATUS_BITS;
> > >  	unsigned long *ptr;
> > > @@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct=
 i3c_bus *bus, u16 addr,
> > >  		return;
> > >
> > >  	ptr =3D bus->addrslots + (bitpos / BITS_PER_LONG);
> > > -	*ptr &=3D ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
> > > -						(bitpos % BITS_PER_LONG));
> > > +	*ptr &=3D ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
> > >  	*ptr |=3D (unsigned long)status << (bitpos % BITS_PER_LONG);
> > >  }
> > >
> > > +static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 ad=
dr,
> > > +					 enum i3c_addr_slot_status status)
> > > +{
> > > +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_=
STATUS_MASK);
> > > +}
> > > +
> > > +static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u1=
6 addr,
> > > +					     enum i3c_addr_slot_status status)
> > > +{
> > > +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_=
EXT_STATUS_MASK);
> > > +} =20
> >
> > Can we drop this helper and instead modify the
> > i3c_bus_set_addr_slot_status() prototype to get the mask from its
> > parameters? =20
>=20
> git grep "i3c_bus_set_addr_slot_status(" drivers/i3c/ | wc
>=20
> There are 18 places need be modified without this helper function.
> are you sue what you want?
>=20
> Maybe drop i3c_bus_set_addr_slot_status_ext() is good idea by direct use
> i3c_bus_set_addr_slot_status_mask().

Ok fine for _mask.

Thanks,
Miqu=C3=A8l

