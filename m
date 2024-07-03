Return-Path: <linux-kernel+bounces-238930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC392537F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15B1B215F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD54DA04;
	Wed,  3 Jul 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2qiIfiV"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD74776A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987005; cv=none; b=Ne4JD7K92m9+EZ7MpOOxGqaUL5RmftM7Wp6wGNlWaKtvbuL41IrqHb8L6OBy2fqqGNAOSCsy2H/YP381fqjFJXWvRPQASWMgw/nV475uQ+oUdgwc7d6CSkd8lGDa3duA8/wXxfFX04Q1hYpfcmFTRFwvVA8V93MkdFVAGMk5WjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987005; c=relaxed/simple;
	bh=oDfPl6Xvm45C5uvXW7Xq1upMrK+OYGgIEft2EYP2DbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDrSrvlg0Z3gB9hhM4sjYhZi9BunpT7BsJzJINH8HCFHU/zvyW1Gx/a+phVxGsa3BFoHFZOronCdZYMj8RlLstM17qBTvuyzSfuEMn0bY9fWD6TK1viwLLE8A7IhV09arak0FYAh7x+MITkbTluLWYJGJHHGSbLuKDt7vvRqlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2qiIfiV; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so20192625ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719987002; x=1720591802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c77AogHs5UjTLqFCfEnpEmIPWpc2YLbtORGmWy/mQxg=;
        b=h2qiIfiVZQlNB5fkFGM5urAGiaOJ6sNZSS2wE/L0+uFN8AIkTCXy7hzydUa0MThTLb
         Qn3Qif3uP6+OQhx8d1w8z2EWnPd4PkcxB91OhsL2P51IaV7JXIQSTHCe+DO1f4d18dHJ
         zLMGHaU9FhzGjx+/DzBM4ShY1XzCQkVl/zeiBnKyi/Jmge6/wxMY3XW9fmB0MAtr5mSc
         dd2J6pq1U33OSl3XhW0UxOsI99f4wOSxqe0wbJkiAybjUDuBoDouC+Z+9JjJwzESd5Fe
         tkVLycux3QvGOGoJjGP4MFyU4sPi7L8bvKyJQCo8IrXcNpA7GV9Vp7YA9/lyuJ/l8bNr
         aavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987002; x=1720591802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c77AogHs5UjTLqFCfEnpEmIPWpc2YLbtORGmWy/mQxg=;
        b=XKbUwdcEEx1ps7R+V2RBkyyPvkCpUjUyzTWqZwZAlGrNVbNQXuRHbyAstHAFzJskDF
         siPblOYDonE9qlexwDz/wzcbcOjF21eE7lnAK1tuEacLGph5EWmjpOyNK5JzUOMVPoB+
         BAaJJ0F+W2o2dEcxS2PdB5CH5KIlDz1WRqOXzrQh7UeqN+Jb9rhu9Lv9lpEdlLCwF2Pq
         /pY6aqfUk9iqnsqdt2GQ4/AFPnli/R56XEUlc33+QYZ/vJfSqJxjyLdHlb/wKYefdNs/
         9ibfGR3f6wp7qKEU2dJsgazCvslmihPCC2MbqYSZvOGjDcBDehqKZ/s8WCdOb5F2SR2s
         HZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxZiSnshaso6rW8wPEHiXhCYzYNWI3RmW0tx0qVo5gtDL1ABKKmNhYUlfmyN6Zc7mq08nFGxFoFqFWIYVA8N1y6uMOVV2aEIMU4K21
X-Gm-Message-State: AOJu0YzrzWVH1uyDXwf4cM453SKU2oSPPXPy+aG8uJQy2NDMB0QGt9UV
	Ycrv5xtrZLE+WM/qYKaRfScrpUCGf8x06hjHKvUnI2Vel/9rpwyklzG2AmZUe0udDEn/KPB2UrS
	32JQLiNzWj/doN4JTzilaeF7l96FIWw==
X-Google-Smtp-Source: AGHT+IGB5A1N2ooKOuOsbWeCU8/C2XUVNfg4LwM4m/9DUVssS7oMz+HHSwbfGzEL+dNkVJnm8P49bnw2kOnmce8JAn0=
X-Received: by 2002:a05:6e02:b41:b0:376:1fae:463a with SMTP id
 e9e14a558f8ab-37cd377b7eemr123963465ab.32.1719986999604; Tue, 02 Jul 2024
 23:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628085444.132714-1-linchengming884@gmail.com>
 <20240628085444.132714-2-linchengming884@gmail.com> <20240701114307.031005ce@xps-13>
In-Reply-To: <20240701114307.031005ce@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Wed, 3 Jul 2024 14:09:17 +0800
Message-ID: <CAAyq3SYt_PvaE3ZvhcXY9ijgEvLiwxByHWS=ryPrBbWFBfrkdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spinand: Support serial NAND for reading two
 bytes ID
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=88=
1=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> linchengming884@gmail.com wrote on Fri, 28 Jun 2024 16:54:43 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Adding the Device ID 2 on Macronix Serial Flash.
> >
> > When the number of flashes increases, we need to utilize
> > Device ID 2 to distinguish between different flashes.
> >
> > These flashes have been validated on Xilinx zynq-picozed
> > board which included Macronix SPI Host.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
>
> ...
>
> >       SPINAND_INFO("MX35UF1GE4AD",
> > -                  SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96)=
,
> > +                  SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96,=
 0x03),
> >                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> >                    NAND_ECCREQ(8, 512),
> >                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > @@ -289,7 +288,7 @@ static const struct spinand_info macronix_spinand_t=
able[] =3D {
> >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> >                                    mx35lf1ge4ab_ecc_get_status)),
> >       SPINAND_INFO("MX35UF1GE4AC",
> > -                  SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92)=
,
> > +                  SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92,=
 0x01),
> >                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> >                    NAND_ECCREQ(4, 512),
> >                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > @@ -298,7 +297,6 @@ static const struct spinand_info macronix_spinand_t=
able[] =3D {
> >                    SPINAND_HAS_QE_BIT,
> >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> >                                    mx35lf1ge4ab_ecc_get_status)),
> > -
>
> This is style, and if you care should be in another patch.

Okay, we currently have no plans to make this modification.

>
> >       SPINAND_INFO("MX31LF2GE4BC",
> >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e)=
,
> >                    NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> > @@ -309,7 +307,7 @@ static const struct spinand_info macronix_spinand_t=
able[] =3D {
> >                    SPINAND_HAS_QE_BIT,
> >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> >                                    mx35lf1ge4ab_ecc_get_status)),
> > -     SPINAND_INFO("MX3UF2GE4BC",
> > +     SPINAND_INFO("MX31UF2GE4BC",
>
> This is a fix that should have the right tags (stable/fixes) and be in
> another patch.
>
> Also, maybe you want this patch content to be backported. If it's the
> case, please add the necessary tags here as well.
>

Sure, we will separate this modification from this patch series.

> >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae)=
,
> >                    NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> >                    NAND_ECCREQ(8, 512),
>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Chengming

