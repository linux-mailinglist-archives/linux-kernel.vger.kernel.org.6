Return-Path: <linux-kernel+bounces-170832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6E8BDCA4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439322860B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B013BC39;
	Tue,  7 May 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M00XljaE"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49613C3C0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067952; cv=none; b=bEqcF/TKH1Ud6UC+rOiruE7rCdNkyrsg4mdlJWDGzlHwes+8iqmpGfwWuEs817jYAhUdb5DKwxvvSWn6ruuzyKtSfnCedg1H2XlWL2zQmDQvvfJyMkfIe/9Vh3O3e/3Wdddq7XSZaZFIZSd8+1nBoX+ETtkEN2mKsNQPzlSU+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067952; c=relaxed/simple;
	bh=AxHL9xg+mFC6sPc7w09Awd3HmVldm43BtK2rfpIjzAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSPEQ2SOWnhXz9V1jsG/jr4QLl6QBQn4DvrPqL28xuLMSzOWWnfRMd+XcY0vzmAH1uYh0+ZV5lV0bowTFcwrViOmoNX1W7jFwNqsNNNM79FrZXQ8K7C6KzMHwGjxuDKc5Az/o3XYks1qW4g0fM43Q5VVK3xcMdQ4hPXo+pxUv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M00XljaE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADE29C0003;
	Tue,  7 May 2024 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715067942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1uefqDLk/fsECxmCZwtq2WLO2NPd1F1ghvyIHDig/M=;
	b=M00XljaEOXxbAQmAVgHUGBQNUTKDAQnYHvs5ieaX/Bbrm9QQv/xpZ+WYNaPQkcz/q4LW5t
	BmPZlrlsV67keHukDm2p6WDeQoA7qfMpjNA1bKU/w9jalEVdaRUzdocIIxvyg73zT1e+Nn
	RBljTJvWyy4CV0hJrOjI92L4b5qyEJetfUCLDgpYUiATqFHJcJXzVcwQXjwWCd7zY3y4LR
	95KepSm2c5BxRCJ9suMOZ6O42LyauPD4/f0QCJW+Ad/RRZoF7i7ldtzJktwRbYaFf6FYCW
	Qs6qEc+LVphaXnP4ibBfcokO3CPQvycRyIZgplF4+NUDZPUqa3fWEqiNijrfpA==
Date: Tue, 7 May 2024 09:45:38 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Message-ID: <20240507094538.745fb5a9@xps-13>
In-Reply-To: <ZjnUXtWGR3cmtYB0@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
	<20240506160508.6c60d50f@xps-13>
	<20240506175106.2ab7c844@xps-13>
	<ZjnUXtWGR3cmtYB0@pengutronix.de>
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

Hi Sascha,

s.hauer@pengutronix.de wrote on Tue, 7 May 2024 09:12:30 +0200:

> On Mon, May 06, 2024 at 05:51:06PM +0200, Miquel Raynal wrote:
> > Hi Miquel,
> >=20
> > miquel.raynal@bootlin.com wrote on Mon, 6 May 2024 16:05:08 +0200:
> >  =20
> > > Hi Sascha,
> > >=20
> > > s.hauer@pengutronix.de wrote on Wed, 17 Apr 2024 09:13:30 +0200:
> > >  =20
> > > > To support software ECC we still need the driver provided read_oob,
> > > > read_page_raw and write_page_raw ops, so set them unconditionally
> > > > no matter which engine_type we use. The OOB layout on the other hand
> > > > represents the layout the i.MX ECC hardware uses, so set this only
> > > > when NAND_ECC_ENGINE_TYPE_ON_HOST is in use.
> > > >=20
> > > > With these changes the driver can be used with software BCH ECC whi=
ch
> > > > is useful for NAND chips that require a stronger ECC than the i.MX
> > > > hardware supports.
> > > >=20
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/mtd/nand/raw/mxc_nand.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw=
/mxc_nand.c
> > > > index fc70c65dea268..f44c130dca18d 100644
> > > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > > @@ -1394,15 +1394,16 @@ static int mxcnd_attach_chip(struct nand_ch=
ip *chip)
> > > >  	chip->ecc.bytes =3D host->devtype_data->eccbytes;
> > > >  	host->eccsize =3D host->devtype_data->eccsize;
> > > >  	chip->ecc.size =3D 512;
> > > > -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> > > > +
> > > > +	chip->ecc.read_oob =3D mxc_nand_read_oob;
> > > > +	chip->ecc.read_page_raw =3D mxc_nand_read_page_raw;
> > > > +	chip->ecc.write_page_raw =3D mxc_nand_write_page_raw; =20
> >=20
> > A second thought on this. Maybe you should consider keeping these for
> > on-host operations only.
> >=20
> > The read/write_page_raw operations are supposed to detangle the data
> > organization to show a proper [all data][all oob] organization to the
> > user. =20
>=20
> Let me take one step back. The organisation in the raw NAND is like this
> when using hardware ECC:
>=20
> [512b data0][16b oob0][512b data1][16b oob1][512b data2][16b oob2][512b d=
ata3][16b oob3]
>=20
> For a standard 2k+64b NAND. The read/write_page_raw operations detangle
> this and present the data to the user like this:
>=20
> [2048b data][64b OOB]
>=20
> Is this the correct behaviour or should that be changed?

I believe so, yes.

> (Side note: The GPMI NAND driver behaves differently here. It has the
> same interleaved organisation on the chip and also presents the same
> interleaved organisation to the user when using read_page_raw)

I'd say the GPMI driver is wrong?

> With my current approach for software ECC the same layout is used on the
> NAND chip. It would interleave the data with the OOB on the NAND chip
> and, since using the same read/write_page_raw operations, also presents
> [2048b data][64b OOB] to the user.

No need, I believe the only reason for interleaving is that your
hardware ECC engine works like that (writes the ECC bytes slightly
after each chunk of data). So if you don't use on-host hardware ECC,
you don't need to deal with this data layout.

> This works fine currently, but means that NAND_CMD_RNDOUT can't be used.
> Using NAND_CMD_RNDOUT to position the cursor at offset 512b for example
> doesn't give you the second subpage, but instead oob0. Positioning the
> cursor at offset 2048 doesn't give you the start of OOB, but some
> position in the middle of data3.
>=20
> Ok, NAND_CMD_RNDOUT can't be used for hardware ECC and there's no way
> around it. For software ECC we could change the organisation in the chip
> to be [2048b data][64b oob]. With that NAND_CMD_RNDOUT then could be
> used with software ECC.
>=20
> You say that NAND_CMD_RNDOUT is a basic command that is supported by all
> controllers, and yes, it is also supported with the mxc_nand controller.
> You just can't control how many bytes are transferred between the NAND
> chip and the controller. When using NAND_CMD_RNDOUT to read a few bytes
> at a certain page offset we'll end up reading 512 bytes discarding most
> of it. For the next ECC block we would move the cursor forward using
> another NAND_CMD_RNDOUT command, again read 512 bytes and discard most
> it (altough the desired data would have been in the first read already).

I'm not sure the controller limitations are so bad in this case. The
core helpers (using the same example) will ask for:
- 512b at offset 0
- 512b at offset 512...
- and finally 64b at offset 2048.
In practice it does not look like a huge drawback? I don't understand
in which case so much data would be read and then discarded?

> So I think NAND_CMD_RNDOUT should really be avoided for this controller,
> eventhough we might be able to support it.

I also mentioned the monolithic accessors which try to avoid these
random column changes. You probably want to check them out, they might
just avoid the need for NAND_CMD_RNDOUT by forcing full page accesses
directly. The reason why they were introduced is not exactly our
current use case, but it feels like they might be handy.

658beb663960 ("mtd: rawnand: Expose monolithic read/write_page_raw() helper=
s")
0e7f4b64ea46 ("mtd: rawnand: Allow controllers to overload soft ECC hooks")

Thanks,
Miqu=C3=A8l

