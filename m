Return-Path: <linux-kernel+bounces-304744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3196243B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDB21C218E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88F16A934;
	Wed, 28 Aug 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzBjHDHN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B91547F2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839313; cv=none; b=L4LtKuckB1mXxwZOXnbjDhrgOLipdb6nmblOpWhHDNvYCroby9uUZyrmMVfXsNYLNdoseC95yzXPCv3Ei5EDk1BeqbNMg0c4CpzxColDvDZjR2Obo5xp5F6UpoQgFr+yIfcbPiSTBo5oylfVDzXYr9sPTSGLLRTv0+Ve4f7xy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839313; c=relaxed/simple;
	bh=G8GlawP3FSgjKy9MlLfGeTIrLyGU4VQc2PNrqf1Pn7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvuUo8Vf1cW2SDV77gpQGmuFH8jMNnXbfK9d4scnNh4wbJg4b8Qi+vNENxj3CuA1K7rEd4m6Cq/sk2PPKSvI369C3EVEOByHeVj0lFYPUVuAUYXrJGbc+OPf/ezgkx25aytN3RRwNMCDj1nHLdrqpMwhbbOXJJs2bkoG5uILKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzBjHDHN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714186ce2f2so5086238b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724839311; x=1725444111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTY/Og4VQMLH0YC5+kxfePDsZ5hXWXQ3Xo9cBmBQwt8=;
        b=PzBjHDHNcGK+jNizDlBTnfgSHF5omCMg7zpP9X6wNjLL4dKIm7zjvzHUSW5Cdi2Sc8
         Pxq5KpmqrU6HDePLXwK4I971FmhdbdgoP9cmufE2evpd5r39Itg8UfaYdNXKwQSdcvWK
         4IsuZFcfYBFBrVMGtmxjZYj7C8XnSWwl2gSf/3RdeMZw3R/R015jAhJG6leEZcBRx5ml
         otsoVxIAK3ZrWZUT54l8KbhlVuX2tWP5ccDST9KXkHjJEAZ//FhZzWqfucWa6SHUgCc5
         j+JrL6RvZNeywfgkO53/PKBPTe8MoiIdDwrbc7aHHeJWgDdndToI+8rBn6NGgz0xo4KS
         FZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839311; x=1725444111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTY/Og4VQMLH0YC5+kxfePDsZ5hXWXQ3Xo9cBmBQwt8=;
        b=SJs8BLogDBArTXKzp9LDE3TDF64SG3LyqRQ1gq33AbrKh+oYZvBq13t3NrELmgQ4dT
         piIMvB2BRB8t6kzHQ25F5aq/I61N6WZBkUaN60HeDnN4atWM301M2Pk/lFdk917J5NFZ
         nV/ss4GLBOdDpSxQ9MzB5+NotEAb54B6cwgUApXnCkEdw6obOI946imLns+xKNlXT1Lz
         c9kGtXSVAPJg4Y+xKJdpkcjKJd1UQmkcUAd6LUOVJsJ8i5k96gkWwtKceF2b55dRwdSD
         gyxt8bUWIBjtQ/TzTEYEI380wKOj6rMenZhQhevdLcjDzBmVLLKiLCLW/VL2bJC/v2/R
         XaNg==
X-Forwarded-Encrypted: i=1; AJvYcCX7DdV5kJhtM6547Cb0ej60nDbqWjS0Upjszz+g1UviOVXjg/qfNpna76xAVPhtZO1gV3SXvwbhveM4IUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOjlzUMPhg/uEjbHhTuXsrgnuChZSRiqrl7T9XtdLd8biGLqV
	DAz8MQd3gHU+MRIIKq4gcyrRiaBezqZREv4cGWaQnBqOdfjbpZaRTj241gg26k6G5jZL/4jSefa
	tq/MtkSveURDFPq4j5qxu3x0zpvg=
X-Google-Smtp-Source: AGHT+IEo3imk3467gY5+oMGywhmrGKPDfE4sOhkF04SPsjQLb6STHoAUwEBLz1qdy7R2d7fA4YxzWANSz7urAVS65Ig=
X-Received: by 2002:a17:90b:1e06:b0:2d3:d95a:36dd with SMTP id
 98e67ed59e1d1-2d646b8fb12mr16331092a91.8.1724839311013; Wed, 28 Aug 2024
 03:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828062131.1491580-1-linchengming884@gmail.com>
 <20240828062131.1491580-2-linchengming884@gmail.com> <20240828094728.583dc7c5@xps-13>
 <CAAyq3SbLATwXbDN6icx44cm8-PX+DrUvq2xiYor7bLn4wmfVrw@mail.gmail.com> <20240828115224.28ab48dc@xps-13>
In-Reply-To: <20240828115224.28ab48dc@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Wed, 28 Aug 2024 17:59:47 +0800
Message-ID: <CAAyq3SZdyjzOQLZuttfFuygOFr++nq_oAss=g-dBCRLKROA3wA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mtd: spinand: Add flags for the Plane Select bit
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=88=
28=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:52=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng,
>
> > > > @@ -263,7 +266,7 @@ static const struct spinand_info macronix_spina=
nd_table[] =3D {
> > > >                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > > >                                             &write_cache_variants,
> > > >                                             &update_cache_variants)=
,
> > > > -                  SPINAND_HAS_QE_BIT,
> > > > +                  SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT=
_BIT,
> > > >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > > >                                    mx35lf1ge4ab_ecc_get_status)),
> > > >       SPINAND_INFO("MX35UF2G24AD-Z4I8",
> > > > diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinan=
d.h
> > > > index 5c19ead60499..cec451e7c71c 100644
> > > > --- a/include/linux/mtd/spinand.h
> > > > +++ b/include/linux/mtd/spinand.h
> > > > @@ -312,6 +312,8 @@ struct spinand_ecc_info {
> > > >
> > > >  #define SPINAND_HAS_QE_BIT           BIT(0)
> > > >  #define SPINAND_HAS_CR_FEAT_BIT              BIT(1)
> > > > +#define SPINAND_HAS_PP_PLANE_SELECT_BIT              BIT(2)
> > > > +#define SPINAND_HAS_READ_PLANE_SELECT_BIT            BIT(3)
> > >
> > > Do you think we can have the PP plane select bit without the read pla=
ne
> > > select bit? I'd use a single flag for now.
> >
> > Macronix serial NAND flash with a two-plane structure always requires
> > the insertion of the Plane Select bit in the write_to_cache function. H=
owever,
> > only the MX35{U,F}2G14AC and MX35LF2GE4AB require the insertion of the
> > Plane Select bit in the read_from_cache function.
> >
> > However, I have observed that for flash requiring the insertion of the
> > Plane Select
> > bit during the read_from_cache operation, the ECC strength is 4.
> >
> > Can we use the ECC strength in conjunction with the
> > SPINAND_HAS_PP_PLANE_SELECT_BIT flag to determine
> > whether the Plane Select bit needs to be inserted during the
> > read_from_cache operation?
> >
> > This method cannot guarantee that a new flash witha two-plane
> > structure requiring the insertion of the Plane Select bit will have
> > an ECC strength of 4.
> >
> > Based on the above points, I think we need to use two separate flags
> > to handle these requirements effectively.
>
> Indeed, please use two flags.

No problem, thanks!

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

