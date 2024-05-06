Return-Path: <linux-kernel+bounces-170187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3007A8BD302
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAAB281183
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DF4156C52;
	Mon,  6 May 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CJAbdoPD"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3B1E4A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013675; cv=none; b=TmbO/U4Ijw1kVm/mWVtknJoe72ImIVHmeUbVnpJkZB530rj4y+b3v/ohqy4mN6z1ABPFfTYnAcWaUJmRkCbFLpumyfxIBVuz3CY7ZfOjTncihwkC4+2yHGAwHHVR8+lrDOtIw/04DjClM0B6JwN/06Iy4vICkLCwSAy76HjcALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013675; c=relaxed/simple;
	bh=oK+E6vXfyi/vU9C5XUHVKEipAX1dNyD5yGALJ5Fdxrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A79JVUEIsVbPf1TBtB7fmExIbIW0fJgaXXGynEl9K+SL20NSY5gPVVTW4puJNXSBKcasBAPvSOHQg67+87t/zL8EeNUiTuga6RL225O7FT0T0+5H8LW7o+8NeKxmlfc+LaBrqkiBB5AUHou6QLnYTePFOwC0dUvQnLRZ93pofSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CJAbdoPD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4920FC0005;
	Mon,  6 May 2024 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715013671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95DyyLCYjvNYQJy/L4zTs68mFkL2/zy4z81jpqc7buI=;
	b=CJAbdoPD6OnCoHUPeVV638sEAwjvCZJmeQnOlxOuTyhLhx/Zuhhiol0xQb77hFA7yxhhk9
	9OIz/RV6efkbttDjlRZn19KaIkMRjhaD1a+Pilm4FgjUTNWWL5uOBbGAfXdoGrpyh7fB6p
	ZuevYQHBVDKTgq1OPYa06RPuadNJG96wTZJ6uFDl34UJoHHm94XlX9paUzq+b71EynMdho
	8TyULlRI82BbHoVV8STmQ9kwA/E90kDPMTDKQh52rcTAx0RbaEI9fCioDYIBrn9eEYoqhn
	3rUuhYVViGAUTwl+0dLfgBK6/3kPn4ag0pszqUMw9kyLQulLZwtGCTk/PaUXgw==
Date: Mon, 6 May 2024 18:41:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: mxc_nand: disable subpage reads
Message-ID: <20240506184108.7b1b344d@xps-13>
In-Reply-To: <ZiZBsjtDDhDe7x8f@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
	<ZiDCKGlG4MZ23Tqo@pengutronix.de>
	<20240418113244.6e535d3f@xps-13>
	<ZiEHUz3wicDJscGP@pengutronix.de>
	<20240419114507.5d25d8cd@xps-13>
	<ZiZBsjtDDhDe7x8f@pengutronix.de>
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

s.hauer@pengutronix.de wrote on Mon, 22 Apr 2024 12:53:38 +0200:

> On Fri, Apr 19, 2024 at 11:46:57AM +0200, Miquel Raynal wrote:
> > Hi Sascha,
> >=20
> > s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 13:43:15 +0200:
> >  =20
> > > On Thu, Apr 18, 2024 at 11:32:44AM +0200, Miquel Raynal wrote: =20
> > > > Hi Sascha,
> > > >=20
> > > > s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 08:48:08 +0200:
> > > >    =20
> > > > > On Wed, Apr 17, 2024 at 09:13:31AM +0200, Sascha Hauer wrote:   =
=20
> > > > > > The NAND core enabled subpage reads when a largepage NAND is us=
ed with
> > > > > > SOFT_ECC. The i.MX NAND controller doesn't support subpage read=
s, so
> > > > > > clear the flag again.
> > > > > >=20
> > > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > ---
> > > > > >  drivers/mtd/nand/raw/mxc_nand.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand=
/raw/mxc_nand.c
> > > > > > index f44c130dca18d..19b46210bd194 100644
> > > > > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > > > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > > > > @@ -1667,6 +1667,8 @@ static int mxcnd_probe(struct platform_de=
vice *pdev)
> > > > > >  	if (err)
> > > > > >  		goto escan;
> > > > > > =20
> > > > > > +	this->options &=3D ~NAND_SUBPAGE_READ;
> > > > > > +     =20
> > > > >=20
> > > > > Nah, it doesn't work like this. It turns out the BBT is read using
> > > > > subpage reads before we can disable them here.
> > > > >
> > > > > This is the code in nand_scan_tail() we stumble upon:
> > > > >=20
> > > > > 	/* Large page NAND with SOFT_ECC should support subpage reads */
> > > > > 	switch (ecc->engine_type) {
> > > > > 	case NAND_ECC_ENGINE_TYPE_SOFT:
> > > > > 		if (chip->page_shift > 9)
> > > > > 			chip->options |=3D NAND_SUBPAGE_READ;
> > > > > 		break;
> > > > >=20
> > > > > 	default:
> > > > > 		break;
> > > > > 	}
> > > > >=20
> > > > > So the code assumes subpage reads are ok when SOFT_ECC is in use,=
 which
> > > > > in my case is not true. I guess some drivers depend on the
> > > > > NAND_SUBPAGE_READ bit magically be set, so simply removing this c=
ode is
> > > > > likely not an option.  Any ideas what to do?   =20
> > > >=20
> > > > Can you elaborate why subpage reads are not an option in your
> > > > situation? While subpage writes depend on chip capabilities, reads
> > > > however should always work: it's just the controller selecting the
> > > > column where to start and then reading less data than it could from=
 the
> > > > NAND cache. It's a very basic NAND controller feature, and I rememb=
er
> > > > this was working on eg. an i.MX27.   =20
> > >=20
> > > On the i.MX27 reading a full 2k page means triggering one read operat=
ion
> > > per 512 bytes in the NAND controller, so it would be possible to read
> > > subpages by triggering only one read operation instead of four in a r=
ow.
> > >=20
> > > The newer SoCs like i.MX25 always read a full page with a single read
> > > operation. We could likely read subpages by temporarily configuring t=
he
> > > controller for a 512b page size NAND.
> > >=20
> > > I just realized the real problem comes with reading the OOB data. With
> > > software BCH the NAND layer hardcodes the read_subpage hook to
> > > nand_read_subpage() which uses nand_change_read_column_op() to read t=
he
> > > OOB data. This uses NAND_CMD_RNDOUT and I have now idea if/how this c=
an
> > > be implemented in the i.MX NAND driver. Right now the controller inde=
ed
> > > reads some data and then the SRAM buffer really contains part of the
> > > desired OOB data, but also part of the user data. =20
> >=20
> > NAND_CMD_RNDOUT is impossible to avoid, =20
>=20
> Apparently it has been possible until now. NAND_CMD_RNDOUT has never
> been used with this driver and it also doesn't work like expected.
>=20
> One problem is that the read_page_raw() and write_page_raw() are not
> implemented like supposed by the NAND layer. The i.MX NAND controller
> uses a syndrome type ECC layout, meaning that the user data and OOB data
> is interleaved, so the raw r/w functions should normally pass/expect the
> page data in interleaved format. Unfortunately the raw functions are not
> implemented like that, instead they detangle the data themselves. This
> also means that setting the cursor using NAND_CMD_RNDOUT will not put
> the cursor at a meaningful place, as the raw functions are not really
> exect/return the raw page data.
>=20
> This could be fixed, but the raw operations are also exposed to
> userspace, so fixing these would mean that we might break some userspace
> applications.

As answered to patch 3/4 I believe you need other raw page helpers for
the software ECC path, just because the existing functions are tight to
the on-host ECC logic and do what they are expected to do (I believe).

Creating another set of raw page helpers should be straightforward to
do if that's really needed (mainly for performance purposes, but we're
not yet there). Using the core helpers should work, the only thing is
supporting properly the NAND_CMD_RNDOUT path, which should be possible
at a rather low cost, it really is a very very basic command, I know no
controller without this feature, even old ones.

> The other point is that with using software BCH ecc the NAND layer
> requests me to read 7 bytes at offset 0x824. This can't be really
> implemented in the i.MX NAND driver. It only allows us to read a full
> 512 byte subpage, so whenever the NAND layer requests me to read a few
> bytes the controller will always transfer 512 bytes from which I then
> ignore most of it (and possibly trigger another 512 bytes transfer when
> reading the ECC for the next subpage).

If you manage to get the NAND_CMD_RNDOUT op working I believe you'll be
tempted to use memcpy32_fromio() with just a slightly rounded up length.

> I think these issues can all be handled somehow, but this comes at a
> rather high price, both in effort and the risk of breaking userspace.
> It would be far easier to tell the NAND layer not to do subpage reads.

I understand it may feel like that but that is likely not the right
approach. I just think about another possibility: using monolithic
reads if the controller is too constrained this way you might end up
avoiding the RNDOUT command (might require a bit of tweaking in the
core, I no longer remember exactly).

Good luck, I really appreciate this effort.
Miqu=C3=A8l

