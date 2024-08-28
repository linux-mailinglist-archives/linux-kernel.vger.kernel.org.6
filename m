Return-Path: <linux-kernel+bounces-304727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B031B9623FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C38C1F254BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE1167D98;
	Wed, 28 Aug 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WCCCHr80"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619921459FD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838750; cv=none; b=EYZWi+Zlf/EEQ7lqy8BeKwNx1eEjPeyFnkKKIVBKFypwPZ81Sxx/pqgWsyzyMQaxqsLdxuVwBobAT/cUteUtl9w3fyIgYQYMgbQ07oFvZS8f0a9sPNGfMMJNm/xAJildcR/NvkvyofV9zbXC2V+RCnPuxzSppxse3tS3OwvpnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838750; c=relaxed/simple;
	bh=QIaQDG9KVimVMA2Dq2HRDH4zeM5m1/Y5Yk//xqhSOKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o311pQfA3rM9IuDHI+8/tIX1YHl/y/qfywl9XVf14YT9o+B1w9PeykN4s22UPHZ5mI8pazxUa4OVsxcJyQX/uAoCijD88MlIhE6b2gBUJkOHUpfr54coQsMx7SZNT6qRixROl4X4GO2Gcr09rbHTaZ3XZf9SgxVzXDxknfiJFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WCCCHr80; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27DA0FF806;
	Wed, 28 Aug 2024 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724838746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u93DZQ9YeSbzTH4K9ljvJcKN9DOBT6o0pFa3uLJlLhw=;
	b=WCCCHr80HxgXEZxVZI66LCQ1CAvz+9AQL1DYY2AcytB/qULF83X6H7FoNuXdCtIay5dTD4
	M3CiBqbMwnIEkseNlg/U36EK3VqFEj9bf5nWV7EbFIAmAoYmtdWc4qfE5GuFnpE4KwTfxW
	NH0UUEi2ReTGrFZNk+VNoHf78nY7koPO2pSHOmM+x2tXES9SzjviI6YPd46lMtbekIN28w
	PzjTWPkvwz7LC0AFCNOIJ6Yidw1NzyfJTEZyhDNQEXmWkqTgqfbXUHAOz3l8jQ+HZ4K+vs
	rwm5Vwq7KmKCDm1dqv1Xp+xdybD8q618vj3X/I1YsIn3KSNZF/sZv9Qoy+uU3g==
Date: Wed, 28 Aug 2024 11:52:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v3 1/1] mtd: spinand: Add flags for the Plane Select bit
Message-ID: <20240828115224.28ab48dc@xps-13>
In-Reply-To: <CAAyq3SbLATwXbDN6icx44cm8-PX+DrUvq2xiYor7bLn4wmfVrw@mail.gmail.com>
References: <20240828062131.1491580-1-linchengming884@gmail.com>
	<20240828062131.1491580-2-linchengming884@gmail.com>
	<20240828094728.583dc7c5@xps-13>
	<CAAyq3SbLATwXbDN6icx44cm8-PX+DrUvq2xiYor7bLn4wmfVrw@mail.gmail.com>
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

> > > @@ -263,7 +266,7 @@ static const struct spinand_info macronix_spinand=
_table[] =3D {
> > >                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > >                                             &write_cache_variants,
> > >                                             &update_cache_variants),
> > > -                  SPINAND_HAS_QE_BIT,
> > > +                  SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_B=
IT,
> > >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > >                                    mx35lf1ge4ab_ecc_get_status)),
> > >       SPINAND_INFO("MX35UF2G24AD-Z4I8",
> > > diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> > > index 5c19ead60499..cec451e7c71c 100644
> > > --- a/include/linux/mtd/spinand.h
> > > +++ b/include/linux/mtd/spinand.h
> > > @@ -312,6 +312,8 @@ struct spinand_ecc_info {
> > >
> > >  #define SPINAND_HAS_QE_BIT           BIT(0)
> > >  #define SPINAND_HAS_CR_FEAT_BIT              BIT(1)
> > > +#define SPINAND_HAS_PP_PLANE_SELECT_BIT              BIT(2)
> > > +#define SPINAND_HAS_READ_PLANE_SELECT_BIT            BIT(3) =20
> >
> > Do you think we can have the PP plane select bit without the read plane
> > select bit? I'd use a single flag for now. =20
>=20
> Macronix serial NAND flash with a two-plane structure always requires
> the insertion of the Plane Select bit in the write_to_cache function. How=
ever,
> only the MX35{U,F}2G14AC and MX35LF2GE4AB require the insertion of the
> Plane Select bit in the read_from_cache function.
>=20
> However, I have observed that for flash requiring the insertion of the
> Plane Select
> bit during the read_from_cache operation, the ECC strength is 4.
>=20
> Can we use the ECC strength in conjunction with the
> SPINAND_HAS_PP_PLANE_SELECT_BIT flag to determine
> whether the Plane Select bit needs to be inserted during the
> read_from_cache operation?
>=20
> This method cannot guarantee that a new flash witha two-plane
> structure requiring the insertion of the Plane Select bit will have
> an ECC strength of 4.
>=20
> Based on the above points, I think we need to use two separate flags
> to handle these requirements effectively.

Indeed, please use two flags.

Thanks,
Miqu=C3=A8l

