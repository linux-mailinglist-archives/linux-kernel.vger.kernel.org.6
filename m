Return-Path: <linux-kernel+bounces-405264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D419C4F44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D357AB21CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF31209F33;
	Tue, 12 Nov 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Byuoqq"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C119EED4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395858; cv=none; b=Rj8zIJFHiCnCONET2yZ2foZ5av3JdESPhd+jkcOjro5ZS99CmHvOwIvREsZZjYzRu1bzpwj5ouAZo00oQ5X9rni/5sZ62wU/p6+Jag0zOW7B9888nYF/IRPdrYM+iZkGGwubN3Xtv1dltEnqRckerk7YpvDZPFmmO1Dmfu0fi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395858; c=relaxed/simple;
	bh=SdTSL3bPyeel70GQs8CTsyCqq5ROgc7uR7+832ivbvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXBo1uU0ISja/c8akOZwHKNiPgY6GOFsNCSCHvvvuVcQExZVWiEyYoftNdnWZr02OA7e+HCJ8A/PyyJqDSh9YFgtvwhz4OvZ3pHIFACIBWPbEUZTZvrwNM6pvY4QKZKiYB/g3De6D2NsMquQnLjJEiAMqo7WNMUO2m1C/ZwfUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1Byuoqq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f3f1849849so3630704a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731395856; x=1732000656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdTSL3bPyeel70GQs8CTsyCqq5ROgc7uR7+832ivbvc=;
        b=h1ByuoqqaCxIxVJmcuAsBU6ZO/aB9hKBAZdYG0V+5gPXJeckgpSsZCYZ3k5nLWcjoJ
         bVyRAlRBPcqqq2hjPSg5pWPVm+W/qGDKMP5z1lE/YyB4ccKFQQB3vM7CSleRQ9KoeKfs
         QtEDd7q0uCSb/wQGR62vOdGHGCA6eNP5a16j2PNpW7z436GU8OyluAB+YOqjriDeCc25
         7I5K4kYTAfWU3lET3WQxHbYivmMRmEdwqNW1ili5TnMOcC0oWwHqBh69lmH/ozxSXM/W
         vYCTxVf/BW6qVBvFGy+YVPhjTHcbUFTnj3tkQs102GvTJ79mem+6kfjTUz4Li1A3tHHm
         5lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731395856; x=1732000656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdTSL3bPyeel70GQs8CTsyCqq5ROgc7uR7+832ivbvc=;
        b=RZcYYEBqs1g1abF123bhQ3SXSTf0StiOYOoJEWFDrfBT8m0wuG9K4++ZY/j+A0mesP
         XYymPcDMT1kxi5WGP36VXTz5fbZsagQ4TXakQs79a+84JVDe2dMz7t8QJY6KXt9IvZ7/
         0g2iT3Wfx7DOTzzOLWv34AeTgDF7XZXwqK6pMToToYXxNJonanKSShghXH5urAnqNUmf
         bNwRuRwEaaLUFPiTc09bSNx0GPivq5Jcxhgq4G+n+d+E/VRsb/VZxg2pHsgFuBlCW2g+
         4y+18JXkOMajTILHgRyOlFWWCR069AHw1Q22nP2VetelEPfPWobLIGag2ZU31PKcblJy
         8Bog==
X-Forwarded-Encrypted: i=1; AJvYcCXmK9R/nCuu4VdgglmOU5v1Ax66MSlsByPXuVpEQYITpUZbKlUW0MEPSz5xq0gVlXLgdqKdG+Ek24I6sxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6AbUT/iqSmZyaG/LS9c6F+TN7LCLZ/rZe6lrUTgkq0uTYzny
	yxlfUMb65VyBqgLcpPvOZiHPjY2g3dXSRtbNKRIv7XJjxlfWpQNWdnThuKLr04w5tTM51VxvXqm
	Fn9hCnPo45GeWLvDMgxXkxef6zu+WWw==
X-Google-Smtp-Source: AGHT+IE+x+lmwr95Cl0SxyEOyPM7jDp+2bQ1c4PhkNzVRShJepB8ezs3sjWk6yOp7X1A5kUB3xiLrt7/re429NJ3bV4=
X-Received: by 2002:a05:6a20:914c:b0:1db:da3b:c45b with SMTP id
 adf61e73a8af0-1dc5f8ee5e4mr2373080637.17.1731395855859; Mon, 11 Nov 2024
 23:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107093016.151448-1-linchengming884@gmail.com>
 <437e9c87-fbae-4402-858c-ce6de0a992c7@linaro.org> <CAAyq3Sb-dmmF8YsOdTYxZqX8Wn4d=WiAXkS4bHp5FLn3S+ouXg@mail.gmail.com>
 <01160386-a65f-44b0-ac57-ad77754f01cc@linaro.org> <5a2c8f53-117f-4ffb-9f85-de1ae83ff835@linaro.org>
In-Reply-To: <5a2c8f53-117f-4ffb-9f85-de1ae83ff835@linaro.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 12 Nov 2024 15:16:46 +0800
Message-ID: <CAAyq3SbVkRmUbeuaf8_HMsdug+roRxvQjw9nanD5W5JDfOmpfw@mail.gmail.com>
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
12=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:06=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 11/12/24 6:45 AM, Tudor Ambarus wrote:
> >
> >
> > On 11/12/24 2:42 AM, Cheng Ming Lin wrote:
> >> Hi Tudor,
> >>
> >> Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B411=E6=
=9C=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:18=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>>
> >>>
> >>>
> >>> On 11/7/24 9:30 AM, Cheng Ming Lin wrote:
> >>>> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >>>>
> >>>> The default dummy cycle for Macronix SPI NOR flash in Octal Output
> >>>> Read Mode(1-1-8) is 20.
> >>>>
> >>>> Currently, the dummy buswidth is set according to the address bus wi=
dth.
> >>>> In the 1-1-8 mode, this means the dummy buswidth is 1. When converti=
ng
> >>>> dummy cycles to bytes, this results in 20 x 1 / 8 =3D 2 bytes, causi=
ng the
> >>>> host to read data 4 cycles too early.
> >>>>
> >>>> Since the protocol data buswidth is always greater than or equal to =
the
> >>>> address buswidth. Setting the dummy buswidth to match the data buswi=
dth
> >>>> increases the likelihood that the dummy cycle-to-byte conversion wil=
l be
> >>>> divisible, preventing the host from reading data prematurely.
> >>>
> >>> This is still very wrong and the `fix` is working just by chance.
> >>> Consider what happens when one requires 10 dummy cycles. BTW, does th=
is
> >>> fix a real problem, or it's just a theoretical fix?
> >>
> >> In 1-1-8 mode, setting the dummy buswidth to match the data
> >> buswidth ensures a dummy buswidth of 8, which can accommodate
> >> all types of dummy cycles.
> >>
> >> This patch resolves a significant issue in 1-1-8 mode, as described ab=
ove.
> >>
> >
> > shall we add a fixes tag then, and a cc to stable?
>
> I need a patch today if you want it integrated in the SPI NOR PR.
> Otherwise we'll queue one in the -rc phase.

Sure, so do I need to submit a second version of the patch
with the Fixes tag and cc it to stable?

Thanks,
Cheng Ming Lin

