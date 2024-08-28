Return-Path: <linux-kernel+bounces-304628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BAA9622E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E022D1F21917
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC20158A04;
	Wed, 28 Aug 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaFOZSr9"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D895B67A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835826; cv=none; b=U5DT9TuQ0qednESKjTRBwomeA40xfRBAL/uC1e3aeGA2AWZMdFKK4iFKQBU+vPR2l7l+Z2IkAhOrQ8zNvfMGUDdR1w4t4IL/Wp6kjWkx1wbW+J2FF/IoGwI/lkdtnjfPgAOfYjh9UOr4y7C7NHW8a11Y2K/OJ/KdEL9i0mJw0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835826; c=relaxed/simple;
	bh=Fh21zN38awdSiHMUzeHXCSVSPwBzRBSn8K5g8Tf3qQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr0AJ3gBEXlnHX6wNrVVkL7xYoME4iT9dnjohbJyLnyST7mSkyVtRQHh11ih08YN1Nd0D7cD8yv+sk1gNGDo+LlNk4iCmh/tXI36t/MjYizV9n82HXLbrDXRUoIKf/tOLFTWzhxzyhxtGz/jhgiCC5quvyOYMcMGE79L4pBHPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaFOZSr9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso4998211a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724835824; x=1725440624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i94WsKk6MedQ8JayPsW/OLsnb+/nfJjq4thy0b3EO/E=;
        b=KaFOZSr98HtpifpzCtUEmtbkmYXt5fPUVfowTc1qtB8TA3TaVTSGTYsCGA0QdujdvR
         cf1gym9eQRC/zys6M12Bg5SUEaw/cDOV0jpflYkas2Duw4rSIFV2LnmC87vfPwXOCvi+
         PYEdkxiI74QsRfhlVbRo83QxBPnJShOsJpz8OwquoSrDBEfkBa/gAVaB+dI3eRLD7LDy
         wKyYkFO3a6DbkMS0Xwrz6zqh2k/pc5Wsok/qulDjJdqKQ7SzQYl/PDyZARtEqxv0bukq
         dbHwW04NyWwlkoovnMMntpk6se5aSXhGSYjRVnObik4e2LBygTIQGrQjydmLYxC2YLYw
         SNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724835824; x=1725440624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i94WsKk6MedQ8JayPsW/OLsnb+/nfJjq4thy0b3EO/E=;
        b=H0kppWZCFLZ7d6qHiLlX0IINh0Pv03IxK6fiG4kVFLknnreEyetapwNHgt4rcc9VHP
         tZ67CeVaak+5zfefGCkHzKbbCDyFIKvIVNJNiJdCl+A/FRE6ytmmv7LGoMJeze0+Js2i
         rx4tcrdTuK/JoVlGfwfpi23UrAo79U97MWhryNC5XpGbnblCcz86BnAmEVnKrWGxNnCA
         Yegf4g41iTltWDG1CxIb2qcQrB8LJOLO6EoIjo1Dgn3Lc7e0JiyLu48JMqaFinORJe/w
         Aqp6sxx9vmDQMufA6UKB5cNmuv4Vj80kj0QxjGMoZ39EQe51we8m09faVFeuoCohxyCN
         h1kA==
X-Forwarded-Encrypted: i=1; AJvYcCXNKrOVRBVfDXEE7dRw01C4E3CbeLSfjR9iutkyT7tZobVoPf4MQYx5R/NMemDVymxfoEvGKQF75VWLZB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/w7iq3Z3UJ7VdRqhY6M0VBHKaHNjK2wmGI2U3bV7MxgCtbl4S
	RUqupMLejGAgAwAHSIO0QOn6G6NaHbDsxjxCEIzZdwV+lvPs3ielNkd3ev5wQrBXyWAOR14P8J1
	Mm+7R76RaDDd1BQzN3L+bbXzwP50Yo3s7
X-Google-Smtp-Source: AGHT+IG8iEu6p8uDrVQT0s7Hud8PluofYnn0fsVVn49eDz7N1cecDbzVmTiH8gkamvBhZlH41DmEqh+wfO3QLKofAtM=
X-Received: by 2002:a17:90a:c696:b0:2d3:9137:2375 with SMTP id
 98e67ed59e1d1-2d646bcd374mr16789705a91.4.1724835824188; Wed, 28 Aug 2024
 02:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828062131.1491580-1-linchengming884@gmail.com>
 <20240828062131.1491580-2-linchengming884@gmail.com> <20240828094728.583dc7c5@xps-13>
In-Reply-To: <20240828094728.583dc7c5@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Wed, 28 Aug 2024 17:01:41 +0800
Message-ID: <CAAyq3SbLATwXbDN6icx44cm8-PX+DrUvq2xiYor7bLn4wmfVrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mtd: spinand: Add flags for the Plane Select bit
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=88=
28=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng,
>
> linchengming884@gmail.com wrote on Wed, 28 Aug 2024 14:21:31 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add support for Macronix serial NAND flash with a two-plane structure.
> >
> > Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
> > that require inserting the Plane Select bit into the column address
> > during the write_to_cache operation.
> >
> > Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> > that require inserting the Plane Select bit into the column address
> > during the read_from_cache operation.
> >
> > Macronix serial NAND flash with a two-plane structure requires insertio=
n
> > of the Plane Select bit into the column address during the write_to_cac=
he
> > operation.
> >
> > Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of the
> > Plane Select bit into the column address is required during the
> > read_from_cache operation.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/core.c     |  6 ++++++
> >  drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
> >  include/linux/mtd/spinand.h     |  2 ++
> >  3 files changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index e0b6715e5dfe..49f2d66c3a9c 100644
> > --- a/drivers/mtd/nand/spi/core.c
> > +++ b/drivers/mtd/nand/spi/core.c
> > @@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinan=
d_device *spinand,
> >       else
> >               rdesc =3D spinand->dirmaps[req->pos.plane].rdesc_ecc;
> >
> > +     if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
> > +             column |=3D req->pos.plane << fls(nanddev_page_size(nand)=
);
> > +
> >       while (nbytes) {
> >               ret =3D spi_mem_dirmap_read(rdesc, column, nbytes, buf);
> >               if (ret < 0)
> > @@ -460,6 +463,9 @@ static int spinand_write_to_cache_op(struct spinand=
_device *spinand,
> >       else
> >               wdesc =3D spinand->dirmaps[req->pos.plane].wdesc_ecc;
> >
> > +     if (spinand->flags & SPINAND_HAS_PP_PLANE_SELECT_BIT)
> > +             column |=3D req->pos.plane << fls(nanddev_page_size(nand)=
);
>
> Please separate the core changes and the macronix changes.
> 1. Add support for the flag in the core (and the include)
> 2. Use the flag in Macronix driver.
>

Sure, I will separate them in the next version.

> > +
> >       while (nbytes) {
> >               ret =3D spi_mem_dirmap_write(wdesc, column, nbytes, buf);
> >               if (ret < 0)
> > diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/mac=
ronix.c
> > index 3f9e9c572854..a531cc8121ff 100644
> > --- a/drivers/mtd/nand/spi/macronix.c
> > +++ b/drivers/mtd/nand/spi/macronix.c
> > @@ -118,7 +118,8 @@ static const struct spinand_info macronix_spinand_t=
able[] =3D {
> >                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >                                             &write_cache_variants,
> >                                             &update_cache_variants),
> > -                  SPINAND_HAS_QE_BIT,
> > +                  SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT=
 |
> > +                      SPINAND_HAS_READ_PLANE_SELECT_BIT,
>
> Alignment:           ^
>

Thanks for pointing that out; I'll take care of it.

>
>
> ...
>
> > @@ -263,7 +266,7 @@ static const struct spinand_info macronix_spinand_t=
able[] =3D {
> >                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >                                             &write_cache_variants,
> >                                             &update_cache_variants),
> > -                  SPINAND_HAS_QE_BIT,
> > +                  SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT=
,
> >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> >                                    mx35lf1ge4ab_ecc_get_status)),
> >       SPINAND_INFO("MX35UF2G24AD-Z4I8",
> > diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> > index 5c19ead60499..cec451e7c71c 100644
> > --- a/include/linux/mtd/spinand.h
> > +++ b/include/linux/mtd/spinand.h
> > @@ -312,6 +312,8 @@ struct spinand_ecc_info {
> >
> >  #define SPINAND_HAS_QE_BIT           BIT(0)
> >  #define SPINAND_HAS_CR_FEAT_BIT              BIT(1)
> > +#define SPINAND_HAS_PP_PLANE_SELECT_BIT              BIT(2)
> > +#define SPINAND_HAS_READ_PLANE_SELECT_BIT            BIT(3)
>
> Do you think we can have the PP plane select bit without the read plane
> select bit? I'd use a single flag for now.

Macronix serial NAND flash with a two-plane structure always requires
the insertion of the Plane Select bit in the write_to_cache function. Howev=
er,
only the MX35{U,F}2G14AC and MX35LF2GE4AB require the insertion of the
Plane Select bit in the read_from_cache function.

However, I have observed that for flash requiring the insertion of the
Plane Select
bit during the read_from_cache operation, the ECC strength is 4.

Can we use the ECC strength in conjunction with the
SPINAND_HAS_PP_PLANE_SELECT_BIT flag to determine
whether the Plane Select bit needs to be inserted during the
read_from_cache operation?

This method cannot guarantee that a new flash witha two-plane
structure requiring the insertion of the Plane Select bit will have
an ECC strength of 4.

Based on the above points, I think we need to use two separate flags
to handle these requirements effectively.

>
> >
> >  /**
> >   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine =
structure
>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

