Return-Path: <linux-kernel+bounces-354886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA23994412
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DA6B247AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17590157465;
	Tue,  8 Oct 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OejKscWd"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69513B5B6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379208; cv=none; b=r77IPz4Fcn4RQEOoqMNBCY1Y/qSGuKHM3z2wjpOE7pPrznJ02zCWHMuBY48wHwihQsc4pFzRJpU2LDtiV7bN7opqNnOrtGqoDgto3jSxm5e78mJMm1U7cloA4aGw8TB9tTFAKeCt/XIbBrUwcxx6TgxMW6Es/rNe+RsVo5ntA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379208; c=relaxed/simple;
	bh=+1apTaFalfQd+LZad/rFLVME2ObluHV0xdr5n/kisqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xv8UMNDDJ90ms/jbWlrkZHJOu1cM+Rj/5X2u37r3nBOWccywrPvfwT7DJ0BN0q09kbigVIiV40TDzxG32t8KUIUmDBSOv5FHW40bUzY6VktaJV/9lD51lM1yA7sqJHEwYmBF4LsY7aXLBM9UwY30Wo+xK7VyWyWdmDxB+dguRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OejKscWd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3912911a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728379206; x=1728984006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrmdMSex1KBje39KnEqSABRjqAAs6DDZ2LNbXrU83Ac=;
        b=OejKscWduTGWwpIHWDdfUpEyXPKna1FPH6RLeQH4hcdJtUYZKfFkMw+63yfMUbXhow
         9PJPlQUZz9rL+dFTNr7b069O3FF2O/2b8Cn0oTHB71CiG7z7p/QHydOYbXWU8UrmoJrG
         rEY3Tsz5lTa8cPHmAPzj6xMbjEKBiE/bdCrN/kIDEL+RzQ6WylS4dg1JmDcOXKKG7lzW
         H0ndiSClobkAsct/pJgH7otKID2X+49x4AM/tdYx13e1f0VlF+JA1aYjHWdHs0Ec5Bok
         sQceILLCVAx/d+Y3a5Ty4kMSaxzrYg7EQCDJ0Mt70CPIYY7Z6Ypv7MAjc9rACHFiO8yJ
         HdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728379206; x=1728984006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrmdMSex1KBje39KnEqSABRjqAAs6DDZ2LNbXrU83Ac=;
        b=kSXjt2r6shs5cIwdvDzBwYlyDxYvkyPRegH+LSpsihMInLBYKWIy/kvnxMKfIeA0XP
         +y+jnmupVT6dqTDVAZAyIjbxXqIe0XeH9SNDRS3zx/day5PfNTvg/z4fpawp7dXdnnRH
         Y1lt4tTs/v2rBUd1tbeaHCbjhj+hLnha76xP1H4X8V676544D1fpfY0Q7ylA9rM8ZAvm
         GeHWyT8NEJtgowBNjrwN0QEnnDTmxvo/UWJRrcI0NBzLvJUIDpQp4ToGwwTfGozyGwYg
         luJj6EJzn2J0OLAHxPVwVmoGMQZsdjj+Sh3EWe4BgOfnwUCABWl+5V4ZK9LlC4YVSP/x
         W62w==
X-Forwarded-Encrypted: i=1; AJvYcCWp7fv9MCAO5T0q6nSR3hWJPhb8qzRGLuHD+0w1dlnla1HGPVpBLpVsIEj4RJE3Jg0wkaJnY3Dd/xJYZm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgyl/upUgQ6Q1xYuBHIaTv5nZIVVMy+qudF10TM3y/dVlQxmu
	sbjeWDHl/VuqzmZR57Viq0eCfwqZA0YPgl9796Bc0qVG6ow3iIX8pfd0xpkFP+HOeGaiP0kSg5H
	gHdqJYu98xJjUc0nKBpAOoUyD4dI=
X-Google-Smtp-Source: AGHT+IHbkrcEU7U04Uln5CeM3L2bwnIGinU3Vn8RCYcY9uAZyZ6pQVpfxiExYiAJXhYhCkB67Jxx8xbPkcq5tnHDUvo=
X-Received: by 2002:a17:90a:4a8c:b0:2e2:8f1e:f5ea with SMTP id
 98e67ed59e1d1-2e28f1efc06mr624055a91.1.1728379206453; Tue, 08 Oct 2024
 02:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905055333.2363358-1-linchengming884@gmail.com>
 <20240905055333.2363358-2-linchengming884@gmail.com> <20241001114039.67bab21e@xps-13>
 <CAAyq3SbP4kSW47ZaT7V9ZzeHauj_EwfU5GPipZjNK6j69qm7Vw@mail.gmail.com>
 <20241007103331.55f37dcb@xps-13> <CAAyq3SaZKMqJrv7caVwO0+u+nk8JWZ8qTRHdUqQOfQhx9gBF7Q@mail.gmail.com>
 <20241008105523.1647f2ca@xps-13>
In-Reply-To: <20241008105523.1647f2ca@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 8 Oct 2024 17:19:42 +0800
Message-ID: <CAAyq3SZv__sJhc5aQ7AUCYKpumu79hq=1ci-wekM9PgghM9zuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=
=888=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> linchengming884@gmail.com wrote on Tue, 8 Oct 2024 14:25:25 +0800:
>
> > Hi Miquel,
> >
> > Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B410=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:33=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > Hi Cheng Ming,
> > >
> > > > > > @@ -325,7 +373,8 @@ static const struct spinand_info macronix_s=
pinand_table[] =3D {
> > > > > >                                             &update_cache_varia=
nts),
> > > > > >                    SPINAND_HAS_QE_BIT,
> > > > > >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > > > > > -                                  mx35lf1ge4ab_ecc_get_status)=
),
> > > > > > +                                  mx35lf1ge4ab_ecc_get_status)=
,
> > > > > > +                  SPINAND_FIXUPS(&read_retry_fixups)),
> > > > > >       SPINAND_INFO("MX35UF1GE4AC",
> > > > > >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMM=
Y, 0x92, 0x01),
> > > > > >                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1,=
 1),
> > > > >
> > > > > I expect a patch targeting the core first, and then the changes i=
n the
> > > > > Macronix driver.
> > > >
> > > > Got it, so do you prefer that we switch to using flags instead?
> > >
> > > Not necessarily, did I?
> > >
> > > ...
> > >
> >
> > Using a flag instead of fixups allows this patch to target the core fir=
st,
> > and reduces changes in the Macronix driver.
>
> Propose what ever you think is best. You can also look at how it is
> done in raw NAND. But always include the core changes first, please.
> It is not related to how you implement it.
>

Thank you so much for your suggestion. I will ensure the core changes are
addressed first, as you mentioned. Also, I did refer to how it's done in ra=
w
NAND when working on this patch. I really appreciate your guidance and will
definitely keep your words in mind.

> >
> > > > > >       const struct spinand_manufacturer *manufacturer;
> > > > > >       void *priv;
> > > > > > +     int read_retries;
> > > > >
> > > > > Any reason to keep this variable signed?
> > > >
> > > > No, we can simply change from int to u8.
> > >
> > > Just unsigned int is fine.
> > >
> >
> > Sure, thanks!
> >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Thanks,
> > Cheng Ming Lin
>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

