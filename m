Return-Path: <linux-kernel+bounces-405082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEEA9C4CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001AD1F2355B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DDD205132;
	Tue, 12 Nov 2024 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9fkiQgb"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E220493F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379420; cv=none; b=Wbl4+bWwvMuwx5JjNtkty7JxvHaZO0RgQxyCay/7LTB9svCeVgxN7O0d7ZsjocDNayu1QfVduqmxXkF/Ga9THytS1BNsF5SE3z5VfpUCk0Ap80sb/E8/WL0z88zcBXkeFVlIjsbwtdlE//T6wfuDKQvn8zfL+9WEYmJgvSbTJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379420; c=relaxed/simple;
	bh=skSfte/78ajqYr+F8jFfJDTnC3LawguMzdb5MEv4Rzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqgKPwXV5vNwgSLtMdIPw2PMJIZsK1pyRCx+f/Ba6R5fNwIw3W9hJ7q1xK/kzHOf3wb7pfRg5J9A7fH14KswGKUxbYFG5rE/L0NEmzVXxaaJFE6HTuSRDAi97Amy7Hp6NGDIF1WL7maMReOUZVwJZGE0QlHyD4uvnnnJE0ZXCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9fkiQgb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f3f184985bso3570625a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731379418; x=1731984218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58HKZs6IxMCCiB8RgB9LRVMDoMM+3vjsIIgnWANOYyM=;
        b=K9fkiQgbnPn4xnobFDvUxrZgsvhNH3fZn1SGDeXSaYiOl5Zi3/2CBltQck5ha8Eapc
         mlMgxmGz+0WagOhvcXgnnRPMup/SomURm5ikaDmA3N8J1bEeOD5IzLbesXmw88eIMTX0
         dBNvOThPUIxrv9Me6V/T0SZQKecsZHF+wp/eWhSogCJECTQuPzSlwLWO4PIv0R0ouUK2
         W9lAVSvJgHuCM2exJhXU4mGSyRMyAjsy1WEOhNrfU6VP++dGO0n3HXbp/En/kmjdZ+4T
         AB+6p0kcdLtlOv3PKDZvL5xnlG7TQ+OsKe1euh3wKd35tBeRkHn1MIbtBGgDQ37jzXOx
         NhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731379418; x=1731984218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58HKZs6IxMCCiB8RgB9LRVMDoMM+3vjsIIgnWANOYyM=;
        b=GajcD525FJ6ugS48q8J9mWVtAns5a6HQtMNc/npNjNqF5r6nbqqnQVplDeHMuXVFNg
         QTkdbB3TFz+xhZn5pS4KBEETlSjRmJbRzzSeSFPIUysWDshwSUMb+k/Ng9b3okuAGAcJ
         hDxh+Gyfmzh0Y7GkqvoAeH8CB8LRTilANZOqxGmmNauaAEY47No8F6zqJpMG/sxL+dXP
         o+8iyXMzl0tV2Uq5z2OT0155UZJ8LqNGPgbjScx+cFDM98S6GPX92Jd+ef2rLp2h3f6m
         0ga5GdPXeTm91SBZT4HjeHKojlrdRUK1E94vd39ZZUFWZcJD4sSqxREJYrDxfFgIxxzZ
         KhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvqghehBoeqIPeJbLW9MHPFkZIaBGr5QkkYIe4wh0D1+6E0Zte+ozd5rOsSD57B8hiBs22WkSZTVAIFgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmTFFlrzq2hrcB0yT6KtX6MgrpCZbcXxZC7wyHQgkzwjVmEkk
	+icZdQnRkvOeXDn/IuZrHZ9ECHVEcS6H4tfc+7OHJAFc9oyotWkF7GOzq0DIryJs7qFMDjY34iq
	TlQVZCO0YXOQrLZ0WqMBPeiQ4D3A=
X-Google-Smtp-Source: AGHT+IEJVZUzY8qyAjbOnvu/DUz+noMenYc+uIjGnwh3b4ux21PGoCUxqQJ7eZp0LAfSNcpJFSdlgF5nbzfNL0A6nrA=
X-Received: by 2002:a17:90b:2b45:b0:2e2:b3f8:b549 with SMTP id
 98e67ed59e1d1-2e9b178155bmr18298969a91.23.1731379418504; Mon, 11 Nov 2024
 18:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107093016.151448-1-linchengming884@gmail.com> <437e9c87-fbae-4402-858c-ce6de0a992c7@linaro.org>
In-Reply-To: <437e9c87-fbae-4402-858c-ce6de0a992c7@linaro.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 12 Nov 2024 10:42:48 +0800
Message-ID: <CAAyq3Sb-dmmF8YsOdTYxZqX8Wn4d=WiAXkS4bHp5FLn3S+ouXg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: core: replace dummy buswidth from addr to data
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=88=
11=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:18=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 11/7/24 9:30 AM, Cheng Ming Lin wrote:
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > The default dummy cycle for Macronix SPI NOR flash in Octal Output
> > Read Mode(1-1-8) is 20.
> >
> > Currently, the dummy buswidth is set according to the address bus width=
.
> > In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
> > dummy cycles to bytes, this results in 20 x 1 / 8 =3D 2 bytes, causing =
the
> > host to read data 4 cycles too early.
> >
> > Since the protocol data buswidth is always greater than or equal to the
> > address buswidth. Setting the dummy buswidth to match the data buswidth
> > increases the likelihood that the dummy cycle-to-byte conversion will b=
e
> > divisible, preventing the host from reading data prematurely.
>
> This is still very wrong and the `fix` is working just by chance.
> Consider what happens when one requires 10 dummy cycles. BTW, does this
> fix a real problem, or it's just a theoretical fix?

In 1-1-8 mode, setting the dummy buswidth to match the data
buswidth ensures a dummy buswidth of 8, which can accommodate
all types of dummy cycles.

This patch resolves a significant issue in 1-1-8 mode, as described above.

>
> I don't like that we're chasing our tails here. The fix is to pass
> directly cycles instead of bytes and update MTD and SPI to use cycles. I
> had an attempt to fix this in the past, but I can't allocate time to
> respin. Are you interested in taking over and fixing MTD and SPI?
>

I understand your concerns and agree with your approach. However,
this fix may require some time to implement, and we're currently facing
this issue with a pressing need for resolution. If I can allocate time in
the near feature, I'd be interested in taking on the work to address this
for both MTD and SPI.

> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/spi-nor/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index f9c189ed7353..c7aceaa8a43f 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *no=
r,
> >               op->addr.buswidth =3D spi_nor_get_protocol_addr_nbits(pro=
to);
> >
> >       if (op->dummy.nbytes)
> > -             op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(pr=
oto);
> > +             op->dummy.buswidth =3D spi_nor_get_protocol_data_nbits(pr=
oto);
> >
> >       if (op->data.nbytes)
> >               op->data.buswidth =3D spi_nor_get_protocol_data_nbits(pro=
to);

