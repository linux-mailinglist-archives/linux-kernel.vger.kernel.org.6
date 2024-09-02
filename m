Return-Path: <linux-kernel+bounces-310865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C196822F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA203B22442
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDC176AC3;
	Mon,  2 Sep 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvKXWP2g"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B8185E64
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266388; cv=none; b=WJ6GfEucmuycV4dXuwlQTA+vaMe2sKP+A6zYb1AVlwSzWluX+w87kx0Dh6e/UkmfHAP5OgqNCfiuklV0XVb8qxXwX3r5wNMpeKX+Zfpzu4FAnwMcUIonmhY5g28NSK8KJ94lXnYipdnohMmzOnyaaZiuOVg/6PZjE4/5ctUNtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266388; c=relaxed/simple;
	bh=qtNBS7NrPwYaEQgh3nXbloo6N6cSYGYfF5RIDu5Aiks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKByx1HotJPFQQJozjNTVqRnCfpknIYWcMiClSTze+byNYfvu37mN2cEP1xvInA3AMrrllhLgtzLPiKHBRrJDbT+KGi/35pBqHI9VR5IPLjwhQogqkXvPZE79PH9W4cS/8YCE1A1bxhj7ndDj5keRJCk1k57QPogy1e16NDr6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvKXWP2g; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7176645e51bso25054b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725266386; x=1725871186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2hoLnYFfOGemlntb3egVQrjUR4/SgapZuQTT6xekaI=;
        b=GvKXWP2gZHApiS/p7Q75aMEba6xyTX11Bf2PdbsdA+Z45fWQYk0nBAJr7NzvnUP3yH
         3mpe7ofx0EYYWKdbo40Oo15mkSvkiVlQxLyU8Qo9fO1IaJGet5LMC+mjGq6G0jx2fgjV
         lS3isJreBlfXQTX5wNKXJQf2N40sIfMbihDDajLr+8Vu9FlXm4yiljA7amduRPOJagYR
         mnlM3nXyfy53gmkM6CWCpMtFxwVBo9rRALJAQecFpzoiUoVu5YU/Vf9Vz86MIdP2IbKA
         64CiMe1fgQ/KJdoJdLnmQntgyMvfIpGLHbiYRv1qTcWqP8QnHenEGj+uEfzosPLpHm3U
         8eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266386; x=1725871186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2hoLnYFfOGemlntb3egVQrjUR4/SgapZuQTT6xekaI=;
        b=WrnKYO2TxhEdpNOWs91wxRzREhp3B9sgcWBqUk9mRrOFNrLn0uAbKkfvzZqID7i0sr
         olsFimxKQpxTj2/anooOhGdfaKvUEhT0pbb6sAD+EbJMlhjWnCvBgCga99AMVyojhjU5
         KhfP2AlOpjmWDklO2ScipQN3Kr9Q9S8SjTwcinyb8YDOsUWXkxUneK1ghP7mq8udpodb
         lilA4u6dMonzz6ZrocORB4NZ3/1yj6qyl4Bd2B/cXqO1m8qWH+P+xa06VQW8HcQSFEGB
         Q9qYpU/FzKhUauwtpa6iJ4evwv2P0hXzOe4nOoBWmGOgQIKMSSReuOIPLUvsW/aZwtNr
         7GEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFiiBDaa20zeNShnvTl1n+3pRCVCSK8hO2jni+BlvrGarUH78z+yqU1ZbxxbOcV4+O6BUEEWOAkPUgGo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojXwP5+ZENY+YVhp3JtEmybVY0wBcZDVq2KVAoILO316B2oLS
	ghMaHnxObBbizjxFtD0P4RxyyFxXJPdJCn3ohW2f37IYi/bn0jthGXpSK8sEZD/SgIwWTK4jKVD
	/EJhhXiE7+8xcw+IoCz0X9qe66ww=
X-Google-Smtp-Source: AGHT+IEN7wSn9ANmj1DN/9TmftBVOHUgtX5aXOzJ9LLRdFRLj0WzAGG51HYdLYFjdnXPPigqRrBQZzf7D09ezk0LfLY=
X-Received: by 2002:a05:6a20:9f09:b0:1ca:2789:c3ad with SMTP id
 adf61e73a8af0-1cce1003843mr15325036637.4.1725266385820; Mon, 02 Sep 2024
 01:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830100310.1553675-1-linchengming884@gmail.com>
 <20240830100310.1553675-2-linchengming884@gmail.com> <20240830175504.746fb2ec@xps-13>
In-Reply-To: <20240830175504.746fb2ec@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 2 Sep 2024 16:37:35 +0800
Message-ID: <CAAyq3SY=o_UGwddEhD9O6EGoEhrEf8YZ61PwBP2cduL+bt0BgA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mtd: spinand: Add support for setting plane select bits
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=88=
30=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:55=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi ChengMing,
>
> linchengming884@gmail.com wrote on Fri, 30 Aug 2024 18:03:09 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add two flags for inserting the Plane Select bit into the column
> > address during the write_to_cache and the read_from_cache operation.
> >
> > Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
>
> This flag has been renamed :)

Thank you for the reminder. I will make the necessary changes.

>
> > that require inserting the Plane Select bit into the column address
> > during the write_to_cache operation.
> >
> > Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> > that require inserting the Plane Select bit into the column address
> > during the read_from_cache operation.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/core.c | 6 ++++++
> >  include/linux/mtd/spinand.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index e0b6715e5dfe..e7b592cdbb4c 100644
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
>
> Isn't there any better way to know what the bit position is?

There are two other methods to determine the bit position:
- column |=3D

>
> Thanks,
> Miqu=C3=A8l

