Return-Path: <linux-kernel+bounces-311325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A03968789
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5CD281772
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F5200108;
	Mon,  2 Sep 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kpfS69Z2"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0819E996
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280146; cv=none; b=XRcZZnEOpheY8+TnVvXsqvDJzCDzHYztjwM4nsQaUN6uEnP/pWr6pxC1eL440ElNjr9ThPBzkacd2DXpgIHhmTkyPQNrh+B8TVR78DJUr817p8VFwViwbtrf89dwXwREZ3pg2FIZnYMvO90ybYA90yz4Wcm0Irz9wgfbsmBwBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280146; c=relaxed/simple;
	bh=9q1kmcSWYGxbky2NAXn5eFd+ketKfs+U8FEZnXas1L0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed3u6c5bjS+69n+gbGPIYAC6JZJYiU84kDdCpt0Enfg5lyYgYeC6+6kBZbBkPbqiV6rMI1FpAAzwKereawj+QDIR0BC++dYlKVTtJ3P7WpF0923eZdvMOi6w2FIfmTwr3y3ODuB+whh9XdUi9P/mz3T3hM669tZHp0kCQjwCShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kpfS69Z2; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 844CD6000D;
	Mon,  2 Sep 2024 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725280136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bHLgPC9UcNLmBmxjD3JWZOBGlNzvtP7G+tkWxSr6cw=;
	b=kpfS69Z2MKp2rNQmnV05UEwL+5em9prQmKegSFNYIkmVlEZ4QNcA2xC4oLYOiKk/aWLpmg
	oMHf++ykE5xkdnkvRqzmfYRBCRvManeVrRqU/nRaUTR0K8F+6S3vnO7WZDcGDeEbSCJnsX
	P71dvOWQau5e24O47/gYlvDA/eKTxjJx9+buLl5vR69HC1fIjEm78zcgs++bZddvUP1vxw
	6Rdya358OfbwLuiUdOOXC5a2zMf8niBgmEia/5T2fTkanz6ZwGvD5tkxHZXQpQCDTxRu9C
	PX6+etLucv8G2uhq8/VbMsmaXBCKl10/LSlJHbU2i/zyy/3lkT5egZdRbQCrEA==
Date: Mon, 2 Sep 2024 14:28:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v5 1/2] mtd: spinand: Add support for setting plane
 select bits
Message-ID: <20240902142853.5fff056a@xps-13>
In-Reply-To: <CAAyq3Sbta_p9WNOTEdCA7V=huPkeFFxUvxTqfzRJz0dsJMJBwg@mail.gmail.com>
References: <20240830100310.1553675-1-linchengming884@gmail.com>
	<20240830100310.1553675-2-linchengming884@gmail.com>
	<20240830175504.746fb2ec@xps-13>
	<CAAyq3Sbta_p9WNOTEdCA7V=huPkeFFxUvxTqfzRJz0dsJMJBwg@mail.gmail.com>
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

Hi Cheng,

linchengming884@gmail.com wrote on Mon, 2 Sep 2024 16:42:55 +0800:

> Hi Miquel,
>=20
> I accidentally sent the previous email before it was finished.
>=20
> Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi ChengMing,
> >
> > linchengming884@gmail.com wrote on Fri, 30 Aug 2024 18:03:09 +0800:
> > =20
> > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > >
> > > Add two flags for inserting the Plane Select bit into the column
> > > address during the write_to_cache and the read_from_cache operation.
> > >
> > > Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash =20
> >
> > This flag has been renamed :) =20
>=20
> Thank you for the reminder. I will make the necessary changes.
>=20
> > =20
> > > that require inserting the Plane Select bit into the column address
> > > during the write_to_cache operation.
> > >
> > > Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> > > that require inserting the Plane Select bit into the column address
> > > during the read_from_cache operation.
> > >
> > > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > > ---
> > >  drivers/mtd/nand/spi/core.c | 6 ++++++
> > >  include/linux/mtd/spinand.h | 2 ++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > > index e0b6715e5dfe..e7b592cdbb4c 100644
> > > --- a/drivers/mtd/nand/spi/core.c
> > > +++ b/drivers/mtd/nand/spi/core.c
> > > @@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spin=
and_device *spinand,
> > >       else
> > >               rdesc =3D spinand->dirmaps[req->pos.plane].rdesc_ecc;
> > >
> > > +     if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
> > > +             column |=3D req->pos.plane << fls(nanddev_page_size(nan=
d)); =20
> >
> > Isn't there any better way to know what the bit position is? =20
>=20
> There are two other methods to determine the bit position:
> - column |=3D res->pos.plane << fls(nand->memorg.pagesize)
> - column |=3D wdesc->info.offset

Ok, let's keep it is as-is for now.

Thanks,
Miqu=C3=A8l

