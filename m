Return-Path: <linux-kernel+bounces-354840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83B994334
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483BF1F22DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96181DF96E;
	Tue,  8 Oct 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JtcB8O/l"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178C18BC03
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377736; cv=none; b=mNLAOU40Xag2+UHmzXVM9w7DZNaoSHL8obJvA7eouZyb6TGtcCVD6j5lTzxo/6FS7Oymnm9Q0ow++eRS3VyKID61LRgRJy5Tb/AmWjpd4yZNpAkxzeH1kHw/Jb2utOfZnGoom/pf+8spOs8vxDtkuz+SB7A1rqQZbYNQTX6nq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377736; c=relaxed/simple;
	bh=dmkMffEeGWhREFpipHghIfPsN7DWC8TeziPMMD8P7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3aPqkRiK+FiWDBxrec6vqoQQmSdvmyP6MHLm5YawhYEM6UtddYA4AJtejkq6lXQ0iKgi4E0K5qp9GEdqdyrsewXlKt8/1f5+lC2fknaQz/01FWNnhr8/A71/3To/9DiHZL9eFUHkJWjtYaCnvtj9N6rSJGG2sPHae74uz2aaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JtcB8O/l; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56AF2FF80A;
	Tue,  8 Oct 2024 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728377725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2J2kZz9XVQBtjS6G6EvCariDJ3hTXnxYgwv1j+Fa0w=;
	b=JtcB8O/llg/5QP86K1t+19Ewr2z92DZa5seey/ztVjdg2NouCwZwjHasybz7L6F5piBgTe
	16Gjp173ZX06TfRVBifaOQ8I10L+pUjs4bO3r4DMuZ+o9ICSQkI+dsYCHV8+EWj0gItxBp
	MbXwj2DUdQn3FXTMulXteL6lGcNpeblGkKTD8u8yR4Jz1LMst/1SPYq+aePDnLBfQu/O3l
	oKre/abPfEt87jQkj9KP3iV1N5otY9242mOHoPyzqxOrgPe8w9UqM5suhgnZc5hxae+zPs
	HU0Q0t22JXXA6xfPhK2SX6zL8RnitH1mA6eoybSGGa8vU8bXaj52JuDjbzpeHw==
Date: Tue, 8 Oct 2024 10:55:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
Message-ID: <20241008105523.1647f2ca@xps-13>
In-Reply-To: <CAAyq3SaZKMqJrv7caVwO0+u+nk8JWZ8qTRHdUqQOfQhx9gBF7Q@mail.gmail.com>
References: <20240905055333.2363358-1-linchengming884@gmail.com>
	<20240905055333.2363358-2-linchengming884@gmail.com>
	<20241001114039.67bab21e@xps-13>
	<CAAyq3SbP4kSW47ZaT7V9ZzeHauj_EwfU5GPipZjNK6j69qm7Vw@mail.gmail.com>
	<20241007103331.55f37dcb@xps-13>
	<CAAyq3SaZKMqJrv7caVwO0+u+nk8JWZ8qTRHdUqQOfQhx9gBF7Q@mail.gmail.com>
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

linchengming884@gmail.com wrote on Tue, 8 Oct 2024 14:25:25 +0800:

> Hi Miquel,
>=20
> Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Cheng Ming,
> > =20
> > > > > @@ -325,7 +373,8 @@ static const struct spinand_info macronix_spi=
nand_table[] =3D {
> > > > >                                             &update_cache_variant=
s),
> > > > >                    SPINAND_HAS_QE_BIT,
> > > > >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > > > > -                                  mx35lf1ge4ab_ecc_get_status)),
> > > > > +                                  mx35lf1ge4ab_ecc_get_status),
> > > > > +                  SPINAND_FIXUPS(&read_retry_fixups)),
> > > > >       SPINAND_INFO("MX35UF1GE4AC",
> > > > >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY,=
 0x92, 0x01),
> > > > >                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1=
), =20
> > > >
> > > > I expect a patch targeting the core first, and then the changes in =
the
> > > > Macronix driver. =20
> > >
> > > Got it, so do you prefer that we switch to using flags instead? =20
> >
> > Not necessarily, did I?
> >
> > ...
> > =20
>=20
> Using a flag instead of fixups allows this patch to target the core first,
> and reduces changes in the Macronix driver.

Propose what ever you think is best. You can also look at how it is
done in raw NAND. But always include the core changes first, please.
It is not related to how you implement it.

>=20
> > > > >       const struct spinand_manufacturer *manufacturer;
> > > > >       void *priv;
> > > > > +     int read_retries; =20
> > > >
> > > > Any reason to keep this variable signed? =20
> > >
> > > No, we can simply change from int to u8. =20
> >
> > Just unsigned int is fine.
> > =20
>=20
> Sure, thanks!
>=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Thanks,
> Cheng Ming Lin


Thanks,
Miqu=C3=A8l

