Return-Path: <linux-kernel+bounces-308342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E3965A89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EC2B23EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685016A95A;
	Fri, 30 Aug 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlwd7KLv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D18170A30
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007072; cv=none; b=UgEYtNgV1LIND/ANmZPrHr5RgjqF8zgUwVcroXW1/aisvIEG2WcuOahVtCnx05tADuMbzv0H7yjC5m9VrpN8B5jCSuBS2udwo7oOE2aRCgmyuzBNKkY7YEBTYcqEX0tX4LUDghFAKTMBC5lUIpCoobwNlcTbxsyVyfAt+0AyoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007072; c=relaxed/simple;
	bh=bA03tVgjjkBQc0Ocppyy+k1GcT3maG2X+uu8Jv1txVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQbrtVaNsy8KVk4uZOj3oto1KyHYJM0jTLHT3A29v3v4gII8loOywZTbtifq6EcVisrb0vwXygTzLsNAcIqGoKSxaXR0iuUps3EdgUb0qtvC7ooClwFqhE2WZSXBahMUfABLy1lxt9m4ESbZlQiinh22YzpYw3d3ldfzTqYwRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlwd7KLv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714302e7285so1358343b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725007070; x=1725611870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+Vo4SFaxBp6TviPv9XIPO+2SC03XabOidYaoFKJEWU=;
        b=jlwd7KLvk2RvnlcQWaWorA34WqmqlosIpsD/5gJFmj0zU6g6LZ+jvuVEbkiE64D+ce
         3My094wcQogOL9g/eygACihHNsAuZNr89wffdv/uba7COWP0EvBgCbQXEngAJojYmn8k
         k030qN8xsL9NbetjPeKcXeFW3yH/o9nPjUzzUk2NqQlOJ7KXCyW/AYhwjKAVlUyG9ymk
         f6IzJHFpDY54hmL+wDee2QXhgih84yr50q+7vwNxdEE6umdaqj2BW2FZhURScAHfhB8O
         H9zB0s9YQig8FPNR/OF+7MT26WdFJHaALCVrhy7UorEz5HNrhLn0euVQW9qbN9lZka1H
         PQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007070; x=1725611870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+Vo4SFaxBp6TviPv9XIPO+2SC03XabOidYaoFKJEWU=;
        b=Wlxf8z3pFBKokg9jPD5+BuAOSkI+k5mJGeP4LoHZEvUWnCqK8etmcDX+b8zIdmlbVh
         k/hikTGX5z8Z0HE0dQI7i3W0U71UnN4u/icoIS1biE54bxAmic0ws2LVh0HvzAZ4hWMw
         MOypjyiP+2k1YM5qPu96dRzc4ZP6z0hBBAb9fVUgGApSkj/N8FW1PhZCh3/4plFEk13a
         BWpQg20nvIrhwmei9yLgKKickOJ5k8XSdzeYkfVY/UVrNtBhKnGS9KR6/lPPYhAUcRoM
         Un/tFrmdzHebXkE+HyzcpofmwkhziLRvPcGxZK6sYuG/7i4JMH7cwUlDalQBCYELHuAM
         VTOA==
X-Forwarded-Encrypted: i=1; AJvYcCVBE+ujjadqtFfQEPbnwzTYrFSj4B2MTYTk7pHymNKKbp1TtnsRcHXZ9lYawwwjO7zVSxZnMmU/RiErWxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8bKXGcWU2dRLvkO8pPBrATBZ97vftlO4D/9Hp4ICJK2PXRAz
	SLHoEzolSuON/xflxC7DDUPw4P250dkadb4w4Q0/9oakre+eyWsVsdIDkQ3bKQkv6AJteNqclJI
	lCNTkFkdb367GcxYtKpPpLJseEyQ=
X-Google-Smtp-Source: AGHT+IHyiOiuICn2agzHUF+aPU+pV7UPEDvVDbnDr9SRm6D47qPQOApSDem2YZXVTRin+j6HFciyHk76YolfUOwND+Q=
X-Received: by 2002:a05:6a20:e196:b0:1be:c4bb:6f31 with SMTP id
 adf61e73a8af0-1cce1011dd6mr6217049637.18.1725007070309; Fri, 30 Aug 2024
 01:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829032517.1517198-1-linchengming884@gmail.com>
 <20240829032517.1517198-3-linchengming884@gmail.com> <20240830092303.00ca7cc6@xps-13>
In-Reply-To: <20240830092303.00ca7cc6@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 30 Aug 2024 16:35:44 +0800
Message-ID: <CAAyq3SZge=9BzFUOmLy35bfQguoU4xRrOp3pQH=sfi2=vFnqtw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mtd: spinand: macronix: Use the flag in Macronix driver
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=88=
30=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi ChengMing,
>
> linchengming884@gmail.com wrote on Thu, 29 Aug 2024 11:25:17 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Macronix serial NAND flash with a two-plane structure requires
> > insertion of the Plane Select bit into the column address during
> > the write_to_cache operation.
> >
> > Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
> > the Plane Select bit into the column address is required during
> > the read_from_cache operation.
> >
>
> PATH 1 is fine except the commit title, let me explain. Once applied in
> the kernel tree, there is no cover letter anymore. So both titles would
> be "Add support for the flag" and "Use the flag...", which is really
> missing the important information as we don't know what this flag is
> for. Furthermore, the fact that we decided to use a flag is an
> implementation detail, what is important is the feature: setting the
> plane select bit.
>
> Can you please change the first commit title to:
>
> mtd: spinand: Add support for setting plane select bits
>
> and for the second, something like:
>
> mtd: spinand: macronix: Flag parts needing explicit plane select
>

Sure, I will update the commit titles as suggested.

> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/mac=
ronix.c
> > index 3f9e9c572854..f17cd4a6f4d0 100644
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
> > +                  SPINAND_HAS_READ_PLANE_SELECT_BIT,
>
> And I know this is not what the normal coding style would ask for, but
> I would prefer to have the two plane select bits on the same line if
> possible, otherwise on two independent lines, so either:
>
>                 QE_BIT |
>                 PP_SELECT_BIT | READ SELECT_BIT,
>
> or otherwise:
>
>                 QE_BIT |
>                 PP_SELECT_BIT |
>                 READ SELECT_BIT,
>
> And finally, could we name the former
>
>                 SPINAND_HAS_PROG_PLANE_SELECT_BIT
>
> ? Because "PP" sounds a little bit too cryptic.
>

No problem. I will adjust the formatting to have the two plane select bits =
on
separate lines and also rename it to SPINAND_HAS_PROG_PLANE_SELECT_BIT
to avoid any confusion.

> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

