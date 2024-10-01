Return-Path: <linux-kernel+bounces-346628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0743498C6E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6721F24CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02041BDAB5;
	Tue,  1 Oct 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OrJ4kNnT"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A451925B8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815291; cv=none; b=i2ESfwHUBvkHTGGx9958LZpMJWo3I7tAGaWejIQC8D7+51QXAc+ZxDzuSkusy7zZ+PZY21iGdq3YJOoa6SPS42o6trUJtl5sY78duw8i/9YVMWkFPWm6nB1CZV8gQrGgmGW4bj0Ka9rk0yb8CMXQiDsnk8xxK8sx4Yr0nZ1e84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815291; c=relaxed/simple;
	bh=7uwJ7Z6xNg/MR7ckamnTV3R+bjEdqe5k0I2oCzsE8i0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvsJ4mmQ4lk1EaSlvJNg5rDf1IWemglINUOFPNDKUfFrF/yAQxGov4WCHfwuaGc89e/Z6Bi326oaxLsOSpS557pSMHbFqQWcervYunDiQ2sgQmlfMesiWW2veFCPBIHjNgmggXauGd5xpITj3MO2dUA2UJn2tJphyZE44xt1NLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OrJ4kNnT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4970240003;
	Tue,  1 Oct 2024 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727815287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4r1gnU2kI48G4bH3UKFvm7M16h9YIxfYz+Z1dmrAag=;
	b=OrJ4kNnTXAhNGXy3lhQzUWOhRp6lCm0BKAPPWoG8vc6fq5sV/c3FhS2ZNGXHRtH0wNx2fJ
	pZKO43QCAxvpHbWX/hBUJsFY2vDZxLFVWUD8+c2BS5MZ73HzNuAt8n2H0Awr8kaz8Dch40
	q4Qrjv13IZyEBlPpplH0hNWlWQlulMgYTfjHHfL71voBO5O74NQifNMF6lElI/gk8CUg1F
	yB3sqC1yhswITXGyxh41HoX8k9aEHg1XkH74k725aypNBmbsVKCoBLgyhCA7uhRSqzTrxF
	xpadLLjq46czvMAL8+w7+SH7LV2V0If8FS6sn/Pj+69evtvrFs0C8RSkKgXQHQ==
Date: Tue, 1 Oct 2024 22:41:25 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 nicolas.ferre@microchip.com, richard@nod.at, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: of atmel_pmecc_destroy_user
Message-ID: <20241001224125.032b2a1b@xps-13>
In-Reply-To: <Zvxdfh3FobjpvcRb@gallifrey>
References: <ZvmIvRJCf6VhHvpo@gallifrey>
	<20240930090817.0a86e538@collabora.com>
	<Zvxdfh3FobjpvcRb@gallifrey>
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

Hi,

linux@treblig.org wrote on Tue, 1 Oct 2024 20:37:18 +0000:

> * Boris Brezillon (boris.brezillon@collabora.com) wrote:
> > Hi David,
> >=20
> > On Sun, 29 Sep 2024 17:05:01 +0000
> > "Dr. David Alan Gilbert" <linux@treblig.org> wrote:
> >  =20
> > > Hi Boris and co,
> > >   One of my scripts noticed that 'atmel_pmecc_destroy_user'
> > > isn't called anywhere; I was going to delete it, but hmm, I wonder
> > > if it's actually a missing call and leaking (in the unlikely case
> > > the device was ever removed).
> > >=20
> > > It was added by your:
> > >   commit f88fc122cc34c2545dec9562eaab121494e401ef
> > >   Author: Boris Brezillon <bbrezillon@kernel.org>
> > >   Date:   Thu Mar 16 09:02:40 2017 +0100
> > >=20
> > >     mtd: nand: Cleanup/rework the atmel_nand driver
> > >=20
> > > and I see the allocation in:
> > >      user =3D kzalloc(size, GFP_KERNEL);
> > >        in
> > >      nand->pmecc =3D atmel_pmecc_create_user(nc->pmecc, &req);
> > >        called in atmel_nand_pmecc_init
> > >          from atmel_nand_ecc_init
> > >            from atmel_hsmc_nand_ecc_init
> > > =20
> > > But I don't see any freeing.
> > >=20
> > > (I don't knowingly have hardware to test a fix, although I guess
> > > there's probably one somewhere....)
> > >=20
> > > Suggestions? =20
> >=20
> > There's definitely a leak. I haven't looked at NAND stuff for a while
> > though, so I'll let Miquel advise you on where
> > atmel_pmecc_destroy_user() should be called. =20
>=20
> I see Miquel has posted a fix.
>=20
> Thanks to both of you!

Looks like you've been too fast :) I was waiting for the lore
link to be available, so yes, I looked into it and decided to fix it
this way:

https://lore.kernel.org/linux-mtd/20241001203149.387655-1-miquel.raynal@boo=
tlin.com/T/#u

Thanks for the report,
Miqu=C3=A8l

