Return-Path: <linux-kernel+bounces-352777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AACB992404
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C1A1C22354
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF22136672;
	Mon,  7 Oct 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJYaI3pW"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACC14A4C3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280434; cv=none; b=c6nDQVSdrYyTVGuTAG0NciPa9BFIO6O9lUgScXH5F2ttW6eRQ9xQMdNhJ/S3kgR5jqz0LXzHUKBWj854/oK2mLISEETxWIspUzbC2xFgO7U+N4JTGbO1aJIn2a3Ti7CSY2KvsMGAvIR75qWEOlUSN9774MuNKhSnMz6lt9YgSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280434; c=relaxed/simple;
	bh=OZQPc78vCItSaaQmETHXZPpeULsSZZDBeQmP4WSxNfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKqJHOm7D0pQ2rcoK03bXXrn6zZy8RUYZnObxDOe2I4pe92oATvu+wgssNn1pBAzioYTUQ5GA148ZMvoXdxzqsXzmkYhcZegCy2gVWT1RIbvqTDV8+x0kPov8hFdT1FAjlngL8q3fbk1Dkz7cbLgA/qWcehWfV36ZRTb6BkHAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJYaI3pW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e077a4b8c0so2797855a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 22:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728280432; x=1728885232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ36maaM61bVWfMkeU+vpfLVDn7NuLQ5YuAf/8r7CWY=;
        b=NJYaI3pW3S8yF89TF87yNshlgeXz5w3NrCRNbKYL26l0mpkrH1YchI7S9w1pk4qpxC
         r1WfQ3jFsJswL+irLeYSgL/6MNtFx+FocUfLlc6HA1Y7p0DTrDdIvITgI0ggZoxQ0QoV
         fctfQrWIGAH5Wj57t6XQfTAnV/WgkaG32CXtnTu2k0IDnt6lOLOjjiraGr0Ef8F8Ad/t
         2GDWz2oGT92mfq7vsWKN6vaG+BOh1KEyZcWcelRQd4Nbfn9z+BRPiA6OnuPCE9oJFbnV
         +Jm1mu/ja/5jQNA+tgkJF1orpz/kjJXj17CeHWtM7Ly6n9BpH+QrzymPoDSLGWXmzlmh
         zXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728280432; x=1728885232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ36maaM61bVWfMkeU+vpfLVDn7NuLQ5YuAf/8r7CWY=;
        b=P/tSrhE6m2ixqZMumRTz8olyOcmlMTCYkE4iJ1DrqSK4ryO6x7r7OLNHGw9FyMJ2pr
         mthpAZc39i3RxV3UrT2Q63wkq0uWI9FtgOFYWw+UeF6Wcu571mkhWrhTA2BV2emdT/CK
         XP+QZe/gcSjZzSDQdEfEsUW14GUfCijCv74kn/QBIyIWSnUAYjTuFmjcu5OCEjAKgSOO
         zXviK7y4GHdlgh5euhdrY/URqUJ3kVGsO6SiUPTstOOdpz8rT+wBHKBGntwLmq+G2Afz
         u9FK75wclN7B/QloxbB7PFZZ/7ttJrD22upI5g7fdUSqYmnr4WswR8TyV+lK54z9e+oc
         wNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe9y+4TKSJ6Hr0d3KEmWWnCmuSlXbNszY3ClteLHBmHPpAaCku9vcWxTE11/SlNbb6s/rp+8bXEMeQHaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLNrmE7VBRWNtOcfuBrIdQC6rPu7PxiH4sJN6gxazTlbj1G1K
	zFC+dvOx8ayQBxwCPy7hBp2pLwxG+3yO6egfs1WHfIzsfS3x+GJOPmbgEKPb7lr7Fz/y45un4sf
	dJSMZNt6lQhV86woN7uc9fq4BeqE=
X-Google-Smtp-Source: AGHT+IGCz+Jf3GxKJ8O2TlBj52jNeBIiKJfZfDjCJGtQIHzjg3udSmQA/AVTbMsyCuEpHc2EwWh5/psjbE2l+oDsXdc=
X-Received: by 2002:a17:90a:10d0:b0:2e0:855b:9b21 with SMTP id
 98e67ed59e1d1-2e1b38a3412mr20890076a91.8.1728280432184; Sun, 06 Oct 2024
 22:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905055333.2363358-1-linchengming884@gmail.com>
 <20240905055333.2363358-3-linchengming884@gmail.com> <20241001121724.5edbb64b@xps-13>
In-Reply-To: <20241001121724.5edbb64b@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 7 Oct 2024 13:53:29 +0800
Message-ID: <CAAyq3SZvr3RVUAfMOWQqCqDOyj9QfAmiSdUHwyt=tmrbNRFFOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nand: Add read retry support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=
=881=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Cheng Ming,
>
> linchengming884@gmail.com wrote on Thu,  5 Sep 2024 13:53:33 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > When the host ECC fails to correct the data error of NAND device,
> > there's a special read for data recovery method which host setups
> > for the next read retry mode and may recover the lost data by host
> > ECC again.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/core.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index e0b6715e5dfe..2f21ea926132 100644
> > --- a/drivers/mtd/nand/spi/core.c
> > +++ b/drivers/mtd/nand/spi/core.c
> > @@ -640,6 +640,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, l=
off_t from,
> >       struct nand_io_iter iter;
> >       bool disable_ecc =3D false;
> >       bool ecc_failed =3D false;
> > +     u8 retry_mode =3D 0;
> >       int ret =3D 0;
> >
> >       if (ops->mode =3D=3D MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
> > @@ -657,20 +658,45 @@ static int spinand_mtd_read(struct mtd_info *mtd,=
 loff_t from,
>
> This will no longer apply with continuous support added in. However
> please make this only in the non continuous path. I don't think it can
> fly in the other.

Thanks for your helpful suggestions.

>
> >               if (ret)
> >                       break;
> >
> > +read_retry:
> >               ret =3D spinand_read_page(spinand, &iter.req);
> >               if (ret < 0 && ret !=3D -EBADMSG)
> >                       break;
> >
> > -             if (ret =3D=3D -EBADMSG)
> > +             if (ret =3D=3D -EBADMSG && spinand->info->fixups) {
> > +                     if (spinand->read_retries && ((retry_mode + 1) < =
spinand->read_retries)) {
>
>                                                         ++retry_mode?
> > +                             retry_mode++;
>
> So this can be dropped.
>
> > +                             ret =3D spinand->info->fixups->setup_read=
_retry(spinand, retry_mode);
> > +                             if (ret < 0)
> > +                                     break;
>
> No, you need to set ecc_failed here.
>
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
> >                       max_bitflips =3D max_t(unsigned int, max_bitflips=
, ret);
> > +             }
> >
> >               ret =3D 0;
> >               ops->retlen +=3D iter.req.datalen;
> >               ops->oobretlen +=3D iter.req.ooblen;
> > +
> > +             /* Reset to retry mode 0*/
> > +             if (retry_mode) {
>
>                         retry_mode =3D 0;
>
> > +                     ret =3D spinand->info->fixups->setup_read_retry(s=
pinand, 0);
>
>                                                                         r=
etry_mode);
>
> > +                     if (ret < 0)
> > +                             break;
>
> this if clause is useless.
>
> > +                     retry_mode =3D 0;
>
> And then this can be dropped from here.
>
> > +             }
> >       }
> >
> > +
>
> Spurious line
>
> >       if (ops->stats) {
> >               ops->stats->uncorrectable_errors +=3D
> >                       mtd->ecc_stats.failed - old_stats.failed;
> > @@ -1095,6 +1121,9 @@ int spinand_match_and_init(struct spinand_device =
*spinand,
> >               spinand->flags =3D table[i].flags;
> >               spinand->id.len =3D 1 + table[i].devid.len;
> >               spinand->select_target =3D table[i].select_target;
> > +             spinand->info =3D info;
> > +             if (spinand->info->fixups && spinand->info->fixups->init_=
read_retry)
> > +                     spinand->read_retries =3D spinand->info->fixups->=
init_read_retry(spinand);
>
> Now I get you init. Ok, fine.
>
> >
> >               op =3D spinand_select_op_variant(spinand,
> >                                              info->op_variants.read_cac=
he);
>

Thank you for all your suggestions.
I will modify the patch according to your advice.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

