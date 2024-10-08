Return-Path: <linux-kernel+bounces-354545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5CF993F19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DEB1F21C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ACF1D90CB;
	Tue,  8 Oct 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFgCdu7Q"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5A1D90C5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368751; cv=none; b=VrSfySpFLiRjH1kfZqIASfy8JClqgbqrMLLQR+o8OB8m2ez76WSmV5aPh23vWE0ycPT2eJtyw6krKYAvL4VCXfKQbPguyqHEhj4aZAc+PjFDNbbi13oajQ4em4LG+ohTSs3e2sbGt7rnxMYNkGqk+7dIsyaMUHqTgWDYEQVJZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368751; c=relaxed/simple;
	bh=hjPS55NQZyMsvcPXkpTwISvArPFGgf+fNRTF8yu9Tok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lmpb/7UUubL5j44hojP30RYvpnX7Y7WYf93GfvxCeOnhhvQ/ZAHRPU7M2gMsOzmi3frgCsEkEuBlwhOvLvrTV8eZxOFkJXQdqqPgA7LfrqgGOsVm/1Y17liGri3MPsqrMKkGSpX2os6tHwmrV8Xl48ScH2jP3McBpmbaDjR9Gyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFgCdu7Q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so4171926a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368749; x=1728973549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuwSf4Pm5FFZAaCJzdEmF7YF87t8Moz7TFWPmvQhC5Y=;
        b=mFgCdu7QUzjDSyMDcJBGRMcttTPJm6ZNe/MvfptiQih/GQtf43+4A1W59F6D2K0cu0
         fThQDBc5aIKLYHw+fTr8IhJM2vhHCF3wu0fzOqiHR6tVh3wlCSC3ynTmIgONK9ED02MY
         Pyeff0qADrg2K4MURQxmRg24Ddueq55rLtZlK4577rZdo9jEGChZiSVIbQKdsy1/QytD
         iGHg7REC93uowf+ynTrAp+8C7H8IIu/eFFRVXOASZDxOxZZfTpxEYWnw8WgWORZyynIm
         PPKs195Vpk0n5obhj0YVDoPCHPEjI82N4Jz4eQbB8B+ZvRPRnxZqBXArJiGfsapAD3df
         Ty8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368749; x=1728973549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuwSf4Pm5FFZAaCJzdEmF7YF87t8Moz7TFWPmvQhC5Y=;
        b=W6rD4LAG1xOGl5LJV/U/kVs2xzEHyATf7fPSpP0QALcIZV6CRL6SZhWwbxmAVIw+RW
         v7g0vwLaU6H5TpxW9VTsM2rv97fmUEQ6Fij0I3sC9DQlHtwt+DtzpnIi0NuknpivumuZ
         imbsu0oyz/uJ5hAXDAbgERa6DLIWECsbC6JzJEoU70JdD6MUtWVHUs8qmgZQ+/jVDB50
         jwbNtJe1k/jHEqf8l7txWLrgeDM7CPhCPrxTJGnB12Q9YdT5+FPOMuxTCDjWvJNOYGKo
         LVjuLcEr3CvFv/xz6v/KHuvrfUksiGfZSPkMZRNPYu4nC8hmcwrXZRKtAA9qpBdE+7Tu
         MTBw==
X-Forwarded-Encrypted: i=1; AJvYcCW70LHdg9eeM1yERzvYpAWNccoaYqCjKcXyqJ6AK/ucM9nHPVOIgCHH31LguDewmFmBjCBCS44Wq2DZKGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyArlZKyaI2VQ45/BC2RvWgyFHhLSOdvpBZJBjv6Gqw98lGFRnm
	9ENBHe3TtgUCo20lhZemYdSFt473JbOkeb8BAGyg48el3v8kumunELq4Gyl9UdwLyz8XxfnWCb/
	zBrQu89O7u+jOAn47HC4IsP0zWfI=
X-Google-Smtp-Source: AGHT+IHwEwmqX5mmkSC2ugb4+419q36YdI/qjVqNttyenpryWwP78K4OzRqBdhnwlYm7Wbk+o1S1XR1Vptx0aoewPzs=
X-Received: by 2002:a17:90b:4c12:b0:2da:82d4:c63c with SMTP id
 98e67ed59e1d1-2e27dd3c2c0mr3501356a91.4.1728368749477; Mon, 07 Oct 2024
 23:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905055333.2363358-1-linchengming884@gmail.com>
 <20240905055333.2363358-2-linchengming884@gmail.com> <20241001114039.67bab21e@xps-13>
 <CAAyq3SbP4kSW47ZaT7V9ZzeHauj_EwfU5GPipZjNK6j69qm7Vw@mail.gmail.com> <20241007103331.55f37dcb@xps-13>
In-Reply-To: <20241007103331.55f37dcb@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 8 Oct 2024 14:25:25 +0800
Message-ID: <CAAyq3SaZKMqJrv7caVwO0+u+nk8JWZ8qTRHdUqQOfQhx9gBF7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Cheng Ming,
>
> > > > @@ -325,7 +373,8 @@ static const struct spinand_info macronix_spina=
nd_table[] =3D {
> > > >                                             &update_cache_variants)=
,
> > > >                    SPINAND_HAS_QE_BIT,
> > > >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > > > -                                  mx35lf1ge4ab_ecc_get_status)),
> > > > +                                  mx35lf1ge4ab_ecc_get_status),
> > > > +                  SPINAND_FIXUPS(&read_retry_fixups)),
> > > >       SPINAND_INFO("MX35UF1GE4AC",
> > > >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0=
x92, 0x01),
> > > >                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> > >
> > > I expect a patch targeting the core first, and then the changes in th=
e
> > > Macronix driver.
> >
> > Got it, so do you prefer that we switch to using flags instead?
>
> Not necessarily, did I?
>
> ...
>

Using a flag instead of fixups allows this patch to target the core first,
and reduces changes in the Macronix driver.

> > > >       const struct spinand_manufacturer *manufacturer;
> > > >       void *priv;
> > > > +     int read_retries;
> > >
> > > Any reason to keep this variable signed?
> >
> > No, we can simply change from int to u8.
>
> Just unsigned int is fine.
>

Sure, thanks!

> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

