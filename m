Return-Path: <linux-kernel+bounces-439244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A79EACAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC8D29606E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB02080C2;
	Tue, 10 Dec 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH4ZtqBP"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2D1DC9BA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823614; cv=none; b=DA6/gvGvwZzcKo/Am3FPWWlk4KhnNFqJDqEvTPutgHCU9CyjBgqs16lweuJU04Io/f3UK8Ho3KRFMMxyi/zPY9tliyclTaPSwtHIvYWB3ITbmf33IT67qig9fG6WEP5PieBrWuwDNbzkMzRpkDD/XPhGR4ropgwjCxbY2u9PPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823614; c=relaxed/simple;
	bh=U5CjvSU/lG/S/DU7I+Lm1n0fVR2lFtH1NSRTlp5kSIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2GIpt8+rxhSVwGpn09JnUvLLsSemrRQpYOwahWbj3/9jL/AXF+b6AKVpPAXQ+o9YCfIA9cVZiK7zkEV+wu3rLUcJxYP1OVT7q01spIKRV9wQzZem98YEtQJ4YUWg7mNrs9C56qVjwAis1xHqP6jmtHLY2OPvw5gjH3jm5XCcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gH4ZtqBP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4674c22c4afso157871cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733823611; x=1734428411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FDyzQaVBJmBdWgi+flPumHn5fgNwsPGMW4DJuw0nzM=;
        b=gH4ZtqBP1KAJFuYTvfhu2BY1cElqBWFJKU+83wONT4TIBWENLnce0POnCh0QTXedyi
         5/u88xts28MFNkJjVFX75q5JGUCU9Zhhbh3mJN2YcATZDhDN7tOuxUMv2o6C8ARm6RUh
         neZ1NwKpU8mOpmfBHDSYGs6RU/7tffE1xxvit8sZOr4+sxryvjtdM7DmZUxXBuLJS+5i
         mb5hSCMlL0FaL+bMxF4aXnid3y3ByPR0gWrGlhJeoAfP9ymATGXUOg7udX+rvw68VFGW
         mpNKfktFx3sAbGIfEH08zKGAjRi4TU6tS6geLjvSMogSDyT/J9/K6zMPfq2YAlfxF66o
         HA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823611; x=1734428411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FDyzQaVBJmBdWgi+flPumHn5fgNwsPGMW4DJuw0nzM=;
        b=IovsfbBS8rF7BAZhvoDkmqA7lOX/quNVP/IAcuJbJxYNUJpCsd2P02OxmiJgFuSNbq
         v+mXzzYQgUPYe67hHj0+NwSN802BD9KmlPFirojv28Ec5n6zQ3UxFHna6TBIn6hVgrdW
         ewvXlHB5tekMKz3Ut4AJzLJjl1aoZJssWDbw9uXNYbd87CN+eXA0BVpuzjKpH5Oflog4
         DpuUF/dh3SZSEc5miAywd+CxBcDs8OL6uAZPIZV2XKXWsGJviZf8vOIrAOepIO4eOBCX
         Lfvcp5G6mgANa5/57UJNVqkOo5Doy7dzJw52S08F3LqStIO8wyvIqu4lFn5DYHGU9YG6
         N+BA==
X-Gm-Message-State: AOJu0YylmkpA3XlWOYAE+ziR5VoJZqcKmcfoLxBW4Aq1ZFmYHn3QoKO4
	G8aKDrJimOJ0T40ENePON5J4dryilfzvcCUxgqh+A3y5qU5roUPorEvTwehWcKy3uxdJY/47X7y
	R3+g58h4w2WEFW4nSzRnByKQ6Tuw+y8TyL6Q8
X-Gm-Gg: ASbGnctRWbLjm+h1n8+gU+SPjhE3ZJ8SpV6hYc6Teu2IsAXXOx/dK1ideYMYok0FKAx
	QVEyWra+SZI7Yhdu7OwP2qXLB/goRFx1k0A==
X-Google-Smtp-Source: AGHT+IH7V4UKeLrvjNkOyGEOEUYHbY8QYbuKts1kktkzSbiMR6UVtyJWD2Q0aBvHWwJs5sF1JPgPGTYIeXHNZCK6L4o=
X-Received: by 2002:a05:622a:5186:b0:466:8a29:9de7 with SMTP id
 d75a77b69052e-46776158637mr3576401cf.12.1733823611360; Tue, 10 Dec 2024
 01:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202140604.422235-1-smostafa@google.com> <20241202140604.422235-2-smostafa@google.com>
 <20241209235804.GA14069@willie-the-truck>
In-Reply-To: <20241209235804.GA14069@willie-the-truck>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 10 Dec 2024 09:40:00 +0000
Message-ID: <CAFgf54peN1fGOpr4Q4eihRTYFi1prT3LaQvH-K5x5KO50gmacw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/io-pgtable-arm: Fix stage-2 concatenation
 with 16K
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:58=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Dec 02, 2024 at 02:06:03PM +0000, Mostafa Saleh wrote:
> > At the moment, io-pgtable-arm uses concatenation only if it is
> > possible at level 0, which misses a case where concatenation is
> > mandatory at level 1 according to R_SRKBC in Arm spec DDI0487 K.a.
> >
> > Also, that means concatenation can be used when not mandated,
> > contradicting the comment on the code. However, these cases can only
> > happen if the SMMUv3 driver is changed to use ias !=3D oas for stage-2.
> >
> > This patch re-writes the code to use concatenation only if mandatory,
> > fixing the missing case for level-1 and granule 16K with PA =3D 40 bits=
.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 45 +++++++++++++++++++++++++---------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index 6b9bb58a414f..0055876b3527 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -223,6 +223,33 @@ static inline int arm_lpae_max_entries(int i, stru=
ct arm_lpae_io_pgtable *data)
> >       return ptes_per_table - (i & (ptes_per_table - 1));
> >  }
> >
> > +/*
> > + * Check if concatenated PGDs are mandatory according to Arm DDI0487 (=
K.a)
> > + * 1) R_DXBSH: For 16KB, and 48-bit input size, use level 1 instead of=
 0.
> > + * 2) R_SRKBC: After de-ciphering the table for PA size and valid init=
ial lookup
> > + *   a) 40 bits PA size with 4K: use level 1 instead of level 0 (2 tab=
les for ias =3D oas)
> > + *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 t=
ables for ias =3D oas)
> > + *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tab=
les for ias =3D oas)
> > + *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 ta=
bles for ias =3D oas)
> > + */
> > +static inline bool arm_lpae_concat_mandatory(struct arm_lpae_io_pgtabl=
e *data)
> > +{
> > +     unsigned int ias =3D data->iop.cfg.ias;
> > +     unsigned int oas =3D data->iop.cfg.oas;
> > +
> > +     /* Covers 1  and 2.d */
> > +     if ((ARM_LPAE_GRANULE(data) =3D=3D SZ_16K) && (data->start_level =
=3D=3D 0))
> > +             return (oas =3D=3D 48) || (ias =3D 48);
>
> I'm guessing the second disjunct here should be:
>
>         (ias =3D=3D 48);
>

Ouch, my bad.

> I'll make that change when applying...
>
> Will

