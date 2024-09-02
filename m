Return-Path: <linux-kernel+bounces-311467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAA968990
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6BC1F2394D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DB19F112;
	Mon,  2 Sep 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k2/ET4i0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6A19F10A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286381; cv=none; b=XXx6VlwuewUkh0Uywo3S9w5O3ge8r1ce8hbMvw1y85P/BHiXfTXhaSBkvUgZGjOPsNFwhHstzxJn+9BbceVXI1tREqr9nr6KFknho/LSuo887nhj+l9WYQWxo8F4sYhQ0yC1194CD3jg7V55fk8G5yZxe0m1MTVN7WhpcoQh6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286381; c=relaxed/simple;
	bh=cpZ4PauVNGJbbui1qSdGNxfiCpqK77JPhmc8S9jtHHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3Rn8SMbXm5X8iDx5c8/E+60Ox516qV/7SwRWwkDFmWrenvhAPLtO5FppDoPjH13CC1SfR/ZkOF1t3gj/PWnJsyJIY2cT1exTbHkdNPxcot800n6F+bD7gz1DLTKlwV4lhWG1Bu8I0W84pLs76D6xghkI+FPSanV6KTVK60joLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k2/ET4i0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 360B81BF207;
	Mon,  2 Sep 2024 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725286372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvLaVZYHS2Z2KXkZwLboI7ehC7Fzmd1852PHzQQaI5o=;
	b=k2/ET4i0A3B6iDQpwx+ds6uQQh84yuzBHXQjFRDKYqOMgPeR8E+RM6xy2LUV/UxhugbY6P
	Qah1Lk3GBQ/v5BitRFMhim/F0qcod+paiqnb7E/eIXLDeUdWaKgcC+ncD/WWnGK7Cjg49X
	KDwO7XuAfwVjYUGjpk+5aHqOdt2LXoS+EcF5D9xjcFEFsFqppGvY0/9ncMHmG7Z1LzSpdT
	XoUnwG5AWDEbJjkL614YuIoedZT+XoksJhrfkc/TpXbAWMYJMok0LdkbiZ1sA/YUys5wHG
	dlMSwEvZ8rqHKLdR2c8M0/Fx//zvlswCzJgfIuiYXvdwabJ1JRW48irwkviG9Q==
Date: Mon, 2 Sep 2024 16:12:50 +0200
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
Message-ID: <20240902161250.26846654@xps-13>
In-Reply-To: <ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
	<20240823180426.056ac093@xps-13>
	<ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
	<20240826100430.33194702@xps-13>
	<Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
	<20240826184924.53b48861@xps-13>
	<ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
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
 =20
> > > switch to this address if it is free.
> > >  *
> > > In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b=
, this
> > > function should return an address that is not pre-reserved by any tar=
get
> > > device with an assigned address in the device tree (DT). =20
> >
> > This does not make sense, if you want to optimize for 2b, why not
> > selecting the assigned-address property in the first place if it's
> > available? =20
>=20
> This is my first idea. But I gived up this way.
>=20
> Select an assigned-address here will involve a big change in i3c framewor=
k.
> There are no PID information in i3c_master_get_free_addr().
>=20
> In DAA flow:
> - SVC is get PID first, the get_free_addr(). This case, we can use PID to
> get dt assigned address.(if change/add API)
> - But HCI, it is difference, hci_cmd_v2_daa(), get_free_addr() firstly th=
en
> send out DAA command. So no PID information when call get_free_addr().
>=20
> To cover both case, return a *real* free address here is simplest solutio=
n.

But this is a limitation of the HCI driver? So why not addressing this
in the HCI driver instead? It would greatly simplify the core logic
which becomes complex for wrong reasons.

> >  Also, I don't understand why you would care to specifically
> > *not* return an address that might be the default one for another
> > device in the first place. =20
>=20
> If devices A (want adddress 0xA), device B (want address 0xB), if both
> device send hot join at the same time. device B's PID less than device A,
>=20
> Device B will be found firstly, call get_free_addr(), 0xA will be return
> if no this patch.
>=20
> Device A, call try_get_freeaddr() to get 0xB.
>=20
> So Devcie B will be assign to 0xA, and Device A will be assign to address=
 0xB.
>=20
> After do_daa command, framework will add device B and device A into i3c b=
us.
>=20
> When framework try to add device B to i3c bus, framework will try switch
> device B's address to 0xB from 0xA, but it will be fail because 0xB alrea=
dy
> assigned to device A.

Well, okay, but that's exactly the situation that will happen if these
devices are not described in your DT. I guess it's expected that a
device not described in your DT can be connected, thanks to the
hot-join feature. In this case you cannot know what is this device
preferred address and you might end-up in the exact same situation.

May I question the need for preferred addresses at all? Is this even
part of the spec? What is the use-case?

Thanks,
Miqu=C3=A8l

