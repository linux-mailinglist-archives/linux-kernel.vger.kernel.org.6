Return-Path: <linux-kernel+bounces-417792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4649D5926
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE91F224B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D68158848;
	Fri, 22 Nov 2024 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnrPIGb8"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4FD230987
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732254093; cv=none; b=LPlQUXoNH+JAUm7/hWjPdaEiDu4FRkwCeoMvEr1mBtvyD5/xsXNchOqvt2c3EDgDiBr+crfjm6XDf+VNdpBl8sbStq+Lx/FrAwR8l/cbjx0z1p/JcWQn0F8NKyb97vK0md25lbBxbqhtfLOk7uRGmvFmZzrE5EadYCwA1et93H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732254093; c=relaxed/simple;
	bh=YhukgqPa0lidX1eRWvWGHeJF9G8Hg0nDSas3lR0ceks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl2psr7gzRsuM/1w39Grs3yDr21H+iLzD6sjVg9Do/PpVTlkY/g/VSaxLRGlNG43/w2VAZHDJaa+nnZAohMJ0xJ89XmOKwLnr8aNmBxG3jHwX03AHWtnmriYb8p3kKzasRacYUrcLMbre+9L/xAigNcGjymKwR/JbXYYJYMWQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnrPIGb8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea78d164b3so1466982a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732254090; x=1732858890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRLhlT6BUPUcyfB1wAf+ZRvTDTQX7bRCFvxCdNEhT0g=;
        b=nnrPIGb8ThSnB2vRUjIEuxcYsHsOxpmoSBOduyW31PKkV2g1p3vTcUNaC4ldCYXy22
         jF8zmSmN/K/dDkuBzue7q4x4qABpHhqzMOFp2tIPmex3a6zGLctY4oh4O6p5FYlRw4mO
         2HusXVzC1a1D4VmN3rsrzfe3+dExevd6AYOkPXGUajTcC/uml1UxC4klKI4A5Wo3FwNk
         MmVk9CPc+AHcRjBKCA5Ha1iNTQl7RAJ2J/UkgJtYBKXwHUXIw3MkqKWgd9Bl67A4tisH
         tr16ZdB9pgPG/A1ls3LCJLBHryEZ7VyYmda43uynJWlFdrGaiE6/YZdyC0+ImScEEAam
         /RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732254090; x=1732858890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRLhlT6BUPUcyfB1wAf+ZRvTDTQX7bRCFvxCdNEhT0g=;
        b=U6YjWlpFJzvyZ2MrhsBQ2Zr7NMbMBmZkncjvLBIC4P4PTWl0ZAzSm+nH+0yTqtZS/1
         +fGQnAUPNJvK94KwBJ6AmqhX7lTJqFIIUgWNj4xBxi3FgOfZ1exU6h86WGUH2mC4w5Yl
         KEQbnX+gzssV6Lu62CCX/a9gzKhrLcnqDUWWazXMhr07THpUmCNh5BO58wpxpjHOag/L
         /UvgmPTKIIXsvmX30t8fjhGcopnLzK20uCXhYWjCk4gY9nmLL1yKKrB7ShvBdfADBZOk
         38czVrVSZJcRLusslQJQx4ay5Dx/Emb9nuXyxlZt+OlFZoe1tj7f3cD4ecAWh6B65P5l
         95yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXIBL+OvgldAJyph+0a4TIQMcZ0DVbPs0NaDpoW/Ni4hnfZLl3u6+D3nANdrnKTbs3l0wYR9KdwnewLwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/yIkGY7wvxQ4oK2UQiWhUUiTUGqQLikPd9iM7THQMuSiN/5u
	8eQMuwDiCj0hqYWVp3zPtUZ4DS7u+v0trXoHrUC/KToeXjtgDp9chgIhM7foniC0/pvi5LObrgR
	1KXPrZIUXILTHwmnSDlRV8+JAUwY=
X-Gm-Gg: ASbGnctE0QsjEw7VQvorKV1lVzu7TDXuc/QWxAX5N+ao44RqMqma38zK6PVCjn9NRoJ
	RIWGbaVHMdU0ZkF6kcd2H5I3SiLBd8Vs=
X-Google-Smtp-Source: AGHT+IEyVCzMcdMryX0lgYESYDrmU9kzmvBbRGqC+o+udh2wOqUaYHFru/zgP8Lgukz/1J57KURts0G6RadctvD7ZfE=
X-Received: by 2002:a17:90b:1b46:b0:2ea:5fed:4a2b with SMTP id
 98e67ed59e1d1-2eb0e2303e4mr2082476a91.15.1732254090490; Thu, 21 Nov 2024
 21:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114023528.181583-1-linchengming884@gmail.com>
 <20241114023528.181583-2-linchengming884@gmail.com> <87a5dw25pl.fsf@bootlin.com>
In-Reply-To: <87a5dw25pl.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 22 Nov 2024 13:39:08 +0800
Message-ID: <CAAyq3SYMh+DDB6Wzh623-0YcBXQ8UoQq4nK5+g5wmy4HyCY1uQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nand: Add read retry support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B411=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:31=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
>
> Hi Cheng Ming,
>
> On 14/11/2024 at 10:35:27 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > When the host ECC fails to correct the data error of NAND device,
> > there's a special read for data recovery method which host setups
>
> Here is a suggestion for rewording the second part of your commit log:
>
> ... which can be setup by the host for the next read. There are several
> retry levels that can be attempted until the lost data is recovered or
> definitely assumed lost.
>

Thank you for your suggestion. I will make adjustments based on it.

> > for the next read retry mode and may recover the lost data by host
> > ECC again.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
> >  include/linux/mtd/spinand.h | 14 ++++++++++++++
> >  2 files changed, 47 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index 4d76f9f71a0e..bd5339a308aa 100644
> > --- a/drivers/mtd/nand/spi/core.c
> > +++ b/drivers/mtd/nand/spi/core.c
> > @@ -672,10 +672,14 @@ static int spinand_mtd_regular_page_read(struct m=
td_info *mtd, loff_t from,
> >       struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> >       struct nand_device *nand =3D mtd_to_nanddev(mtd);
> >       struct nand_io_iter iter;
> > +     struct mtd_ecc_stats old_stats;
>
> Reverse christmas tree is nicer :)

Got it! I'll make the changes.

>
> >       bool disable_ecc =3D false;
> >       bool ecc_failed =3D false;
> > +     unsigned int retry_mode =3D 0;
> >       int ret;
> >
> > +     old_stats =3D mtd->ecc_stats;
> > +
> >       if (ops->mode =3D=3D MTD_OPS_RAW || !mtd->ooblayout)
> >               disable_ecc =3D true;
> >
> > @@ -687,18 +691,43 @@ static int spinand_mtd_regular_page_read(struct m=
td_info *mtd, loff_t from,
> >               if (ret)
> >                       break;
> >
> > +read_retry:
> >               ret =3D spinand_read_page(spinand, &iter.req);
> >               if (ret < 0 && ret !=3D -EBADMSG)
> >                       break;
> >
> > -             if (ret =3D=3D -EBADMSG)
> > +             if (ret =3D=3D -EBADMSG && spinand->set_read_retry) {
> > +                     if (spinand->read_retries && (++retry_mode < spin=
and->read_retries)) {
> > +                             ret =3D spinand->set_read_retry(spinand, =
retry_mode);
> > +                             if (ret < 0) {
> > +                                     ecc_failed =3D true;
> > +                                     break;
>
> What is this break gonna do? You're not in a loop. I don't think breaks
> have any effect on if blocks.

There's a nanddev_io_for_each_page iteration above, so the break
was intended to terminate that loop. However, I realized that break
should be replaced with return ret because if the set feature operation
fails, it should return the error.

>
> > +                             }
> > +
> > +                             /* Reset ecc_stats; retry */
> > +                             mtd->ecc_stats =3D old_stats;
> > +                             goto read_retry;
> > +                     } else {
> > +                             /* No more retry modes; real failure */
> > +                             ecc_failed =3D true;
> > +                     }
> > +             } else if (ret =3D=3D -EBADMSG) {
> >                       ecc_failed =3D true;
> > -             else
> > +             } else {
> >                       *max_bitflips =3D max_t(unsigned int, *max_bitfli=
ps, ret);
> > +             }
> >
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

