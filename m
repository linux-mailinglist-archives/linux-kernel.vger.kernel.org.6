Return-Path: <linux-kernel+bounces-170094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24318BD1CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA04284BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12515572E;
	Mon,  6 May 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DMxsEuxP"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208F1552F4
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010673; cv=none; b=KCJY6FgB16A47TI43shR73Sokib3Uj0peGzW5u2gPOIEa/nOb7NSR4MZxDZSiynxO6To0/NTljZyN2CkqVlQaTZuUwSc+nBw8iW2f0UtiTLhlubbeU1B4DTUkR4SphctVecjzqv/JBU2Xfqj5U80LynRiwJPUDm4EEvWwR1zSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010673; c=relaxed/simple;
	bh=GMFcXlvdHlwN61woQJwvISQwU5cuAkI+j96JuCieE8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTFIvAvYqlNkv/fRCdLwQEJE84jvZ5AE3vYjJVhz5jCUBQt200YM/dl66S3q1NBsh6PwePqqShkTfT+XOJefprLYlCMoMr2KwGMLC2mYHE/trTn8wwe+wQahZK5CXXOlnNh9dw838epj7GfccVYJb2wI3M+TvzhQGhD6LDPPQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DMxsEuxP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67238240004;
	Mon,  6 May 2024 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715010668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+wTVg9eOKsGtIWDYqk4CtYV7Tl016exC8KiZRLJoqE=;
	b=DMxsEuxPJV+g6UtG+YRF085ccKcoCV9LqOJQaiQdVRIkEPTFaqNFe0kyDd4bPCdSSFtchG
	vNb0dC8m1UQ1A5AzO7NZoLVL4hQFIo66foSZkBiHS4oDip3EiSgcoDpifv5bhaXO5PWjQd
	3/fwWeOSR6/uksRPEgXMgyThettoGd8FsbcZR/2vouiGB55LwfJPmsQCROa7pxbeNTEnPq
	L0jxv2kdIQSiZ+20vIb9pxjyI4wf2eiharJlf3lJjWD9DB4qcTGtc5uEL2zOokUwGorKKX
	baE/tGQwBL1xKdnrRXyIbuPajYd/1y8ZdLkx56k6FoP/0qmvuIeS/+xPpT/ycg==
Date: Mon, 6 May 2024 17:51:06 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Message-ID: <20240506175106.2ab7c844@xps-13>
In-Reply-To: <20240506160508.6c60d50f@xps-13>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
	<20240506160508.6c60d50f@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Miquel,

miquel.raynal@bootlin.com wrote on Mon, 6 May 2024 16:05:08 +0200:

> Hi Sascha,
>=20
> s.hauer@pengutronix.de wrote on Wed, 17 Apr 2024 09:13:30 +0200:
>=20
> > To support software ECC we still need the driver provided read_oob,
> > read_page_raw and write_page_raw ops, so set them unconditionally
> > no matter which engine_type we use. The OOB layout on the other hand
> > represents the layout the i.MX ECC hardware uses, so set this only
> > when NAND_ECC_ENGINE_TYPE_ON_HOST is in use.
> >=20
> > With these changes the driver can be used with software BCH ECC which
> > is useful for NAND chips that require a stronger ECC than the i.MX
> > hardware supports.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mtd/nand/raw/mxc_nand.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc=
_nand.c
> > index fc70c65dea268..f44c130dca18d 100644
> > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > @@ -1394,15 +1394,16 @@ static int mxcnd_attach_chip(struct nand_chip *=
chip)
> >  	chip->ecc.bytes =3D host->devtype_data->eccbytes;
> >  	host->eccsize =3D host->devtype_data->eccsize;
> >  	chip->ecc.size =3D 512;
> > -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> > +
> > +	chip->ecc.read_oob =3D mxc_nand_read_oob;
> > +	chip->ecc.read_page_raw =3D mxc_nand_read_page_raw;
> > +	chip->ecc.write_page_raw =3D mxc_nand_write_page_raw;

A second thought on this. Maybe you should consider keeping these for
on-host operations only.

The read/write_page_raw operations are supposed to detangle the data
organization to show a proper [all data][all oob] organization to the
user. But of course if the data is stored differently when using
software ECC, you'll expect the implementation to be different (and the
core provides such helpers, even though in your case they use RNDOUT
which is not yet supported).

> > =20
> >  	switch (chip->ecc.engine_type) {
> >  	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> > +		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> >  		chip->ecc.read_page =3D mxc_nand_read_page;
> > -		chip->ecc.read_page_raw =3D mxc_nand_read_page_raw;
> > -		chip->ecc.read_oob =3D mxc_nand_read_oob;
> >  		chip->ecc.write_page =3D mxc_nand_write_page_ecc;
> > -		chip->ecc.write_page_raw =3D mxc_nand_write_page_raw;
> >  		chip->ecc.write_oob =3D mxc_nand_write_oob;
> >  		break; =20
>=20
> You also need to disable the ECC engine by default (and then you're
> free to use the raw page helpers).
>=20
> I thought patch 4 was needed for this patch to work, do you confirm?
> Otherwise with the little change requested I might also merge this one.
>=20
> Thanks, Miqu=C3=A8l


