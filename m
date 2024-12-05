Return-Path: <linux-kernel+bounces-433569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE249E59E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9531C163BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E02224AE0;
	Thu,  5 Dec 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="AecqWpFG"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC23222560
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413045; cv=none; b=Hbiu0OnoPKsrhJvJy9TZbg+RxVTz7pQS2iyw95GmN46mmMC98t8ssKt9eNPO4pZTEvgf6wqe2h2pcYoc1zK5sbldATT6sLnCUbbnkgnsGmaRwr8OGbhzNvai+jjNRNv795fPoyr+tM4YxezMvOC0bnXQv2LBrWDx17a4VQOvnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413045; c=relaxed/simple;
	bh=gEmoxYmjGVmPKVZnUdOndVWFvRpv2PDnwsBJ/5OLNnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qgs0QXKZ2BFV0OQ1fnCqn3WtBfpzRcZtHBrjuy1sL+4P+/+LJOI1CYscDA8KKZrcyCrRLh6x1G2hWAbZb2niLBViNPb1veRbtE5SntUfpQ7+MtI7q961rAg6EINvwLCEwgb84zin6Xm9jUshlRUv21QD5s/5SqF5R8tbD0Z56s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=AecqWpFG; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e398823d6aaso2397682276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733413041; x=1734017841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvnuwz6nzd9J+v7i/2glRxiW3BDpNySZESBXX3gw+HE=;
        b=AecqWpFG+64xrCGKDe2M2BaYsqvb7TI8q6eF24So2iRQrbFTJaTYIw2dr3VQ42aYkq
         3+KvaxKZ5C+1LFAF+ZUaV7/EZIZRutrZn52XiZFVdeHbAkz+fbHaCZ0eDjiBquujMkCQ
         WQ/mOi7iQ/xG7qGuI2oFAN/EXryAQhumD0RsWFjuZDYyY277+FNYFIB6NrXX1r6inVdl
         tA9geJ3loe+540T185g/kdpj2yhGUdZDxoj9IooGOM9cHtvDwCMMRwvZZdCuWtDcskxB
         qIMDyi7eK6xYsQvh1uAojgBXkSDp45febBp50EaQw5XL2LBVwpaDDqs9psoaEmpf/Ehq
         wJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413041; x=1734017841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cvnuwz6nzd9J+v7i/2glRxiW3BDpNySZESBXX3gw+HE=;
        b=g3rgo/U3nfy0hiqrx75McnSqg4SjpnDDVobNrY7wrgKnPCCEO2orf8ndiF5ZBEvcYF
         FnlYF+aYdrByo6aKhfkd7p0kZ7FTWVkDXd2ydxmBC+FicQ5Pqu644uIMyXhQHHdcKsuR
         yuKyyDWYZ9S1yKIg/zMI56e8GAWBVB6XBOckJsg0BLAwv7R0MEVE/THk90ZrB98vjlnM
         w4eNlWkb7q5zC93wEUr0BDbVQRja1ChdKBK6JqGDNaoajZXCaIH+6lVPkOMFNV9cDlus
         E4smLa480gczx4Gpt0r70b6j+9zeJvh4RCAeEaLWzP0oBoRHoO0sRvlauxcQcsdwwSh3
         9y3g==
X-Forwarded-Encrypted: i=1; AJvYcCV8f50WoqNMObFVYkgQtKj1ioiWs3095JpMIY9RCy3VcdOD6DcDkbML9iQiEmY0AvFFKcvj/1ShatSK2b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlvcwNJNDBLEX93fyu/H5LD0/sT6qKTGseEZ8gej5MvOWpRsj
	wqKJUTpKQt9Ii/fzic0xe2cpycPOYRJfSCimKLQ4Ksspz32RFsDEtFLDYLrw5pIEdFDSsfwGeen
	LPDnB/KZterMMAsgYZrhhz+pQNfMBn+mKDjCJGg==
X-Gm-Gg: ASbGncsPGdODGIVY9kOW6q8+7/wOECyQOrYJwe5z+n5BdFXAevMATuL6Ed9LPkGeBea
	7DEZ/dQz2k6x6/PpstID9TupzS2wN6R4=
X-Google-Smtp-Source: AGHT+IFpaAlwyFG/o3y6U8AoYyYaH4HrVsIRutKcp/sQ/k2hjoYuqd/E0RRbh99HY/5KNXQ6u6Of3iU8Fjlwm/TBpEE=
X-Received: by 2002:a05:6902:2387:b0:e38:8e02:1f15 with SMTP id
 3f1490d57ef6-e39f22ab27bmr3592909276.17.1733413041665; Thu, 05 Dec 2024
 07:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-media-imx290-imx462-v2-0-7e562cf191d8@raspberrypi.com>
 <20241120-media-imx290-imx462-v2-1-7e562cf191d8@raspberrypi.com> <4950196.GXAFRqVoOG@steina-w>
In-Reply-To: <4950196.GXAFRqVoOG@steina-w>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 5 Dec 2024 15:37:01 +0000
Message-ID: <CAPY8ntCeYOtBhEKCcygsT-aAHJ8rxo5qP0NdjE9DMJmHCxZzsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] media: i2c: imx290: Limit analogue gain according
 to module
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander

On Thu, 5 Dec 2024 at 15:22, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Dave,
>
> Am Mittwoch, 20. November 2024, 20:17:03 CET schrieb Dave Stevenson:
> > The imx327 only supports up to 29.4dB of analogue gain, vs
> > the imx290 going up to 30dB. Both are in 0.3dB steps.
>
> While I agree for 30dB on imx290, my (maybe outdated) Rev0.2 datasheet sa=
ys
> up to 27dB in 0.3dB steps.

For IMX327, I have revision E17Z06B93 2019/03/25.

The revision control section for Rev0.3 lists
Page 1: "Correction: Max analog gain 27dB - 29.4dB"
Page 74: "Correction: Max Gain 69dB -> 71.4dB"

The graph in "Gain Adjustment Function" (page 74) also shows values
above 27dB as being purely analogue gain. Certainly 0x62 is red for
analogue, which would be a gain of 29.4dB. The next dot is 0x64 (30dB)
and blue, so we have to trust the text for 0x63 being 29.4dB analogue
and 0.3dB digital gain.

So I'm happy that the limit is 29.4dB.

  Dave

> Despite that this change looks good.
>
> Best regards,
> Alexander
>
> > As we now have model specific config, fix this mismatch,
> > and delete the comment referencing it.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/media/i2c/imx290.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > index ee698c99001d..da654deb444a 100644
> > --- a/drivers/media/i2c/imx290.c
> > +++ b/drivers/media/i2c/imx290.c
> > @@ -176,6 +176,7 @@ struct imx290_model_info {
> >       enum imx290_colour_variant colour_variant;
> >       const struct cci_reg_sequence *init_regs;
> >       size_t init_regs_num;
> > +     unsigned int max_analog_gain;
> >       const char *name;
> >  };
> >
> > @@ -876,14 +877,10 @@ static int imx290_ctrl_init(struct imx290 *imx290=
)
> >        * up to 72.0dB (240) add further digital gain. Limit the range t=
o
> >        * analog gain only, support for digital gain can be added separa=
tely
> >        * if needed.
> > -      *
> > -      * The IMX327 and IMX462 are largely compatible with the IMX290, =
but
> > -      * have an analog gain range of 0.0dB to 29.4dB and 42dB of digit=
al
> > -      * gain. When support for those sensors gets added to the driver,=
 the
> > -      * gain control should be adjusted accordingly.
> >        */
> >       v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > -                       V4L2_CID_ANALOGUE_GAIN, 0, 100, 1, 0);
> > +                       V4L2_CID_ANALOGUE_GAIN, 0,
> > +                       imx290->model->max_analog_gain, 1, 0);
> >
> >       /*
> >        * Correct range will be determined through imx290_ctrl_update se=
tting
> > @@ -1441,18 +1438,21 @@ static const struct imx290_model_info imx290_mo=
dels[] =3D {
> >               .colour_variant =3D IMX290_VARIANT_COLOUR,
> >               .init_regs =3D imx290_global_init_settings_290,
> >               .init_regs_num =3D ARRAY_SIZE(imx290_global_init_settings=
_290),
> > +             .max_analog_gain =3D 100,
> >               .name =3D "imx290",
> >       },
> >       [IMX290_MODEL_IMX290LLR] =3D {
> >               .colour_variant =3D IMX290_VARIANT_MONO,
> >               .init_regs =3D imx290_global_init_settings_290,
> >               .init_regs_num =3D ARRAY_SIZE(imx290_global_init_settings=
_290),
> > +             .max_analog_gain =3D 100,
> >               .name =3D "imx290",
> >       },
> >       [IMX290_MODEL_IMX327LQR] =3D {
> >               .colour_variant =3D IMX290_VARIANT_COLOUR,
> >               .init_regs =3D imx290_global_init_settings_327,
> >               .init_regs_num =3D ARRAY_SIZE(imx290_global_init_settings=
_327),
> > +             .max_analog_gain =3D 98,
> >               .name =3D "imx327",
> >       },
> >  };
> >
> >
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

