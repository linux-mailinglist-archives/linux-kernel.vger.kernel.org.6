Return-Path: <linux-kernel+bounces-312008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561659690DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868B1B222EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0A519E982;
	Tue,  3 Sep 2024 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeiAQiby"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958578121B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326352; cv=none; b=CAvgsr0RRpAzjgaKVypGF9bXynPBRBcz/GhQnIBh1wywMvhEMIh/8r5AWORJ2UETrsqxyTag95kCPerEkIEd+MYfjthJTuOySpiEphrctUmuXIXfmEoYmcMgVVobYRMR4O79OiUpPACShutEhyJkMqaaoylq0LrVv/uWZ6KvV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326352; c=relaxed/simple;
	bh=MH5avLSamX0ucip7wRZjzu6xFtBo5gL7g0C+XTeoxx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIgJj31YzKr7rNddPHkMOI+awd99BRCpxwgYjcTwm3C1K81E/HeDnRnd99RjT3UsN+I6MdsyZjoR/P7hohc4+AqHNaIrS2xo2rP875IBpK8IKJvHsjTkt4I6KT7MICOK+aq0tlG7tvJK8EBSNdzvmJ8RHpUZxI2LE9visjg5hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeiAQiby; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd76b56e59so1597293a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725326350; x=1725931150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtf/Ee4Dft8BBuZx9uP5ZFryavcj7r6mlo07L0UCQIY=;
        b=aeiAQibyhdstcqJAEzGcluEfSFkOLz19QCqahTcat8dU8GKtgng6LUXO+HV18b1FUU
         MsnWkFFuz7KxiMqe6YiZhQFMfny3BKVzwFaHkG3vwTUyGwjS4mnIgE76hKg8846YNPgE
         k2Qy3+4X2wEpbpGQaTwP2pLuushcvWm22ypcnzP3++4Uiru2olRX2mhHbEwl0ibqJxH/
         3rkJBmKFdN4a4J8QOzBSQcJMVoam9lxd/z7+1MaZlGewwl0t2q1Ppp00qzs8/FKwBH5q
         w5JNkh6O+UBWKhNPSOXAkyIJhqUMClxCYXqPEt+fVIFcVJYxPe2U42isc3RMXVbE0Nf+
         0i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725326350; x=1725931150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wtf/Ee4Dft8BBuZx9uP5ZFryavcj7r6mlo07L0UCQIY=;
        b=gSMwQPzBmfWt8tnGaW+DpW+WcTPsbCtLXxH6WeHV3kOVVoYzrsgIIlw7HtmLohLx8f
         pMnS34QOQlp6nqi7vPrp+Aeqx6r4mHbAGcdQMps2iTCyjrpDzcInSbh1AMDVwuWAf0M1
         0hpsn+r9OQvVHqMfIXKRwq1umBJqtwPiXUSeSo8dCU1w0w7JIf/JChLvdjycm9G1qjW1
         nlo6cHXdchmUjiw510ffaIqbPXrIaWUg/jVnVzGZ+h6OJ7wDzkQYilo7zV78Ouf0NbsH
         4YeUMpjKdX1TAvi26fTs+AlsnbNedn26D767AXYJgMgrg7jmAba8E4gZOsNo+BFgPc3i
         Vqig==
X-Forwarded-Encrypted: i=1; AJvYcCXhQxoIOUIbVJ16PoDSTBkrVBegulMaB+bkOctB5jyufL3ahKZVw7OqjjmtNZITe94f4mPc7DYUQWxOvvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwniNOEIBX1bLLb3nyQ/NAZS+iVCfnphqhr/RE2+kDfUIkaUWgR
	tPRhzV9qfzUICKhKfd4nztnohhYnFS87u4ha5Ev3Wchboi3LhBux/SAnPvlFRmoP9PGMll6VvFw
	JBBO4IiNsKYrIriGl3oFNJiu7KyI=
X-Google-Smtp-Source: AGHT+IFYFe6coyn7vjRDqRbe/FCNHDg3Ss9+kQJeWWsci1b7/Ud58eA49PNyMcJH2d+tHrQr7woeOe3agXVslD/BGPM=
X-Received: by 2002:a17:90b:88b:b0:2d8:94d6:3499 with SMTP id
 98e67ed59e1d1-2d894d6356bmr9607797a91.37.1725326349613; Mon, 02 Sep 2024
 18:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830100310.1553675-1-linchengming884@gmail.com>
 <20240830100310.1553675-2-linchengming884@gmail.com> <20240830175504.746fb2ec@xps-13>
 <CAAyq3Sbta_p9WNOTEdCA7V=huPkeFFxUvxTqfzRJz0dsJMJBwg@mail.gmail.com> <20240902142853.5fff056a@xps-13>
In-Reply-To: <20240902142853.5fff056a@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 3 Sep 2024 09:16:58 +0800
Message-ID: <CAAyq3SYaK02yV=JOj5qdrJQbkt71n4E0CZ5KUkk5u5uG755-Mw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mtd: spinand: Add support for setting plane select bits
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=88=
2=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:28=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng,
>
> linchengming884@gmail.com wrote on Mon, 2 Sep 2024 16:42:55 +0800:
>
> > Hi Miquel,
> >
> > I accidentally sent the previous email before it was finished.
> >
> > Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=
=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:55=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > Hi ChengMing,
> > >
> > > linchengming884@gmail.com wrote on Fri, 30 Aug 2024 18:03:09 +0800:
> > >
> > > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > > >
> > > > Add two flags for inserting the Plane Select bit into the column
> > > > address during the write_to_cache and the read_from_cache operation=
.
> > > >
> > > > Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
> > >
> > > This flag has been renamed :)
> >
> > Thank you for the reminder. I will make the necessary changes.
> >
> > >
> > > > that require inserting the Plane Select bit into the column address
> > > > during the write_to_cache operation.
> > > >
> > > > Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flas=
h
> > > > that require inserting the Plane Select bit into the column address
> > > > during the read_from_cache operation.
> > > >
> > > > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > > > ---
> > > >  drivers/mtd/nand/spi/core.c | 6 ++++++
> > > >  include/linux/mtd/spinand.h | 2 ++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/cor=
e.c
> > > > index e0b6715e5dfe..e7b592cdbb4c 100644
> > > > --- a/drivers/mtd/nand/spi/core.c
> > > > +++ b/drivers/mtd/nand/spi/core.c
> > > > @@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct sp=
inand_device *spinand,
> > > >       else
> > > >               rdesc =3D spinand->dirmaps[req->pos.plane].rdesc_ecc;
> > > >
> > > > +     if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
> > > > +             column |=3D req->pos.plane << fls(nanddev_page_size(n=
and));
> > >
> > > Isn't there any better way to know what the bit position is?
> >
> > There are two other methods to determine the bit position:
> > - column |=3D res->pos.plane << fls(nand->memorg.pagesize)
> > - column |=3D wdesc->info.offset
>
> Ok, let's keep it is as-is for now.
>

Got it. I'll keep it as-is for now.

> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

