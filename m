Return-Path: <linux-kernel+bounces-352773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EBE9923F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC1D282CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3A13698F;
	Mon,  7 Oct 2024 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOj6ldPu"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2103A8F0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280193; cv=none; b=MLIo+G/4A0W3q7F9oSZHA9mN1ow18aV+z2/2X1thX+S2Ok3l4h9HB4ouKvOWNxH2Oox7sxj11GLvzT2FLTsEVISaHi+MHAtsWC33HGdGIPTz+8UcpGTJXnYouLGwTOnakEYF/c2VtkfXkoJFzD9ogYVcVD0HxSdcmPZtXaO1uSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280193; c=relaxed/simple;
	bh=O0MlcsT6PfvtQi3Hf59FnSZP6XrfRBT2VXH1roHb7Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWcuqsJbKJy9q8cNr3TQI3M4pZsNjgV4Do2CRcSfWAK/NUKWu/vlCahtt+fpKk21kN2rmfZ8QpT3O0MRtvwUgE/OjuADfXUpmp2+anW6XibNnW3fRlGmb/DU1/7VgLrblFThav247EXY0aL2KMcQc1EEA4y+yChD4/yBmdvk+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOj6ldPu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71df2b0a2f7so1295648b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728280191; x=1728884991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d87Cv9A1beE4T0i6VaO2Hf7F5y42nFbt9JX+rRzqlwk=;
        b=UOj6ldPugXPFe+C3Fo5IK9zANaht46xA5gCqv/f2y/+f1TeOs4zg/6qDFFLqmbjq3+
         /eoeMekIjW9JxFADaASuqisJVi9tvz+0hvEJb3Q124BnL2NOOE1VqA50kOVgY5RB9gbI
         gy315lww/f6cN4TyA6Kgmz/JPOiFMd8zRO02T3Wa94aWw/Qv/XyK+UTG181huCtAAcqI
         j5bxFqvS9lYM2aMlaXOmgyv0PnSAN0Ygy24V53Kg3wcyLTRA/6biWpM3zP/xLVJH/JT/
         RlI6X9EhdEqDTXim2b0xTBVT8Jf0xDRZ+zRlYtYoe0Kt6AqF/YrMEhStxQtZLIN3BfG3
         Q00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728280191; x=1728884991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d87Cv9A1beE4T0i6VaO2Hf7F5y42nFbt9JX+rRzqlwk=;
        b=t2lkVu8ZfGCqENWw73XhgpmTbBjT16eqlqU3DZ8AasfRMIWT7npZbfRMQvLuEN6dpO
         zy7Xeq+X5fKhU/Ar5pRRgpkieSNDWbh3lqf8tCkyuQty0Su5+VYvJbJzuyA48yTBiyak
         G/q0bK3TSIF7YeeMzEqurAB064wnpNh0aXhDrss0g+H5A9LPZ5SHom8yeSTrj6AHbQv1
         tosx7mNpWtBsD715b1cDXIWWvLBb2K0Yk331DWO9A1WHXdLzKSzWw1tVqcx3sIyp6p+L
         MC/tBEiH8aJRbbMlUzk6z5huN+o//+LLcJyjcLkSYnIBo4vZ97LU3CcOVuQsmjTBzRD8
         GTRw==
X-Forwarded-Encrypted: i=1; AJvYcCX8/A6B575liR4BMXnX7yixwwvZwaBIex2ohC3vf2unj+0A2YidWtTkc7Rg2d7b4HJbIP5iOHFfDZm7RfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOtpk1TbkeCf8xDGqSZgIIrSD6AfIgvU8kLqRQZVBQX9dhdUg
	SqLqoz0XqQmGxEpitb8EsHMjDzjJ2R+X58JNF8qH4voHo8FlhETfG4XwuyBb7NABOOH6OFyv1TR
	KhOKSnQe4F8NB90JdQ8KEc7duINg=
X-Google-Smtp-Source: AGHT+IEWt1LneFsLZk9jRbQbuL5Ob+h7iT+zjsLpCU4ThggjcqB8cO+VePPePe9Ent57JVewuwryxeTWNa6iwa0wdys=
X-Received: by 2002:a05:6a20:c78c:b0:1cf:6953:2889 with SMTP id
 adf61e73a8af0-1d6dfa3b3e4mr13662674637.16.1728280190643; Sun, 06 Oct 2024
 22:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905055333.2363358-1-linchengming884@gmail.com>
 <20240905055333.2363358-2-linchengming884@gmail.com> <20241001114039.67bab21e@xps-13>
In-Reply-To: <20241001114039.67bab21e@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 7 Oct 2024 13:49:28 +0800
Message-ID: <CAAyq3SbP4kSW47ZaT7V9ZzeHauj_EwfU5GPipZjNK6j69qm7Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=
=881=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:40=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Cheng Ming,
>
> linchengming884@gmail.com wrote on Thu,  5 Sep 2024 13:53:32 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add fixups for support read retry:
> > - Initialize the NAND device maximum retry mode.
> > - Set feature on Special Read for Data Recovery register.
> >
> > The Special Read for Data Recovery operation is enabled by Set Feature
> > function.
> >
> > There are 5 modes for the user to recover the lost data.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/macronix.c | 79 ++++++++++++++++++++++++++-------
> >  include/linux/mtd/spinand.h     | 17 +++++++
> >  2 files changed, 81 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/mac=
ronix.c
> > index 3f9e9c572854..baca67ff1cd6 100644
> > --- a/drivers/mtd/nand/spi/macronix.c
> > +++ b/drivers/mtd/nand/spi/macronix.c
> > @@ -9,6 +9,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mtd/spinand.h>
> >
> > +#define MACRONIX_NUM_READ_RETRY_MODES 6
>
> You said 5 in the cover letter?

Since the original mode is labeled as default in our datasheet,
there are a total of six modes, including five additional modes
numbered from Mode 1 to Mode 5.

>
> > +#define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
>
> Both definitions should probably come...
>
> >  #define SPINAND_MFR_MACRONIX         0xC2
> >  #define MACRONIX_ECCSR_MASK          0x0F
>
> ...here

Sure, thanks for your advice.

>
> >
> > @@ -100,6 +102,38 @@ static int mx35lf1ge4ab_ecc_get_status(struct spin=
and_device *spinand,
> >       return -EINVAL;
> >  }
> >
> > +/**
> > + * macronix_spinand_init_read_retry - Initialize read_retries
> > + * @spinand: SPI NAND device
> > + *
> > + * Return: the number of read retry modes
> > + */
> > +static int macronix_spinand_init_read_retry(struct spinand_device *spi=
nand)
> > +{
> > +     return MACRONIX_NUM_READ_RETRY_MODES;
>
> Does not sound very useful as a function?
>
> > +}
> > +
> > +/**
> > + * macronix_spinand_setup_read_retry - Set the retry mode
> > + * @spinand: SPI NAND device
> > + * @retry_mode: Specify which retry mode to set
> > + *
> > + * Return: 0 on success, -error otherwise
>
>                         , a negative error code otherwise.
>
> > + */
> > +static int macronix_spinand_setup_read_retry(struct spinand_device *sp=
inand, u8 retry_mode)
> > +{
> > +     struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(MACRONIX_FEATURE_=
ADDR_READ_RETRY,
> > +                                                   spinand->scratchbuf=
);
> > +
> > +     *spinand->scratchbuf =3D retry_mode;
> > +     return spi_mem_exec_op(spinand->spimem, &op);
> > +}
> > +
> > +static const struct spi_nand_fixups read_retry_fixups =3D {
> > +     .init_read_retry =3D macronix_spinand_init_read_retry,
> > +     .setup_read_retry =3D macronix_spinand_setup_read_retry,
> > +};
> > +
>
> ...
>
> > @@ -325,7 +373,8 @@ static const struct spinand_info macronix_spinand_t=
able[] =3D {
> >                                             &update_cache_variants),
> >                    SPINAND_HAS_QE_BIT,
> >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > -                                  mx35lf1ge4ab_ecc_get_status)),
> > +                                  mx35lf1ge4ab_ecc_get_status),
> > +                  SPINAND_FIXUPS(&read_retry_fixups)),
> >       SPINAND_INFO("MX35UF1GE4AC",
> >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92,=
 0x01),
> >                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>
> I expect a patch targeting the core first, and then the changes in the
> Macronix driver.

Got it, so do you prefer that we switch to using flags instead?

>
> > diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> > index 5c19ead60499..e567d00a2805 100644
> > --- a/include/linux/mtd/spinand.h
> > +++ b/include/linux/mtd/spinand.h
> > @@ -354,6 +354,7 @@ struct spinand_info {
> >       } op_variants;
> >       int (*select_target)(struct spinand_device *spinand,
> >                            unsigned int target);
> > +     const struct spi_nand_fixups *fixups;
> >  };
> >
> >  #define SPINAND_ID(__method, ...)                                    \
> > @@ -379,6 +380,9 @@ struct spinand_info {
> >  #define SPINAND_SELECT_TARGET(__func)                                 =
       \
> >       .select_target =3D __func,
> >
> > +#define SPINAND_FIXUPS(__func)                                       \
> > +     .fixups =3D __func,
>
> I don't like the fixups naming. It feels like something is inherently
> wrong.
>
> > +
> >  #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,=
       \
> >                    __flags, ...)                                      \
> >       {                                                               \
> > @@ -398,6 +402,16 @@ struct spinand_dirmap {
> >       struct spi_mem_dirmap_desc *rdesc_ecc;
> >  };
> >
> > +/**
> > + * struct spi_nand_fixups - SPI NAND fixup hooks
> > + * @init_read_retry: initialize spinand->read_retries
> > + * @setup_read_retry: set the retry mode
> > + */
> > +struct spi_nand_fixups {
> > +     int (*init_read_retry)(struct spinand_device *spinand);
> > +     int (*setup_read_retry)(struct spinand_device *spinand, u8 retry_=
mode);
> > +};
> > +
> >  /**
> >   * struct spinand_device - SPI NAND device instance
> >   * @base: NAND device instance
> > @@ -423,6 +437,7 @@ struct spinand_dirmap {
> >   *           the stack
> >   * @manufacturer: SPI NAND manufacturer information
> >   * @priv: manufacturer private data
> > + * @read_retries: the number of read retry modes supported
> >   */
> >  struct spinand_device {
> >       struct nand_device base;
> > @@ -449,8 +464,10 @@ struct spinand_device {
> >       u8 *databuf;
> >       u8 *oobbuf;
> >       u8 *scratchbuf;
> > +     const struct spinand_info *info;
>
> This looks like a leftover.
>
> >       const struct spinand_manufacturer *manufacturer;
> >       void *priv;
> > +     int read_retries;
>
> Any reason to keep this variable signed?

No, we can simply change from int to u8.

>
> >  };
> >
> >  /**
>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

