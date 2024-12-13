Return-Path: <linux-kernel+bounces-445028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483FF9F1024
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B03188DE24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8F1E491B;
	Fri, 13 Dec 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSEfljT/"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FA1E25F8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101847; cv=none; b=FnvaGfnuWbDpzbTiCMm79A7NWeHZpeEOk+1JNrO+9ZTXF+dOedrj6gMCHStIxUdivolihT8ruHxmZmYvXq91P6NbQigprH4oPe6MTlwcheLlpoDysgSiFVRsU5pAtZXFIYIF9J0/qmGkKbdnFN0iXf+CgyxLxvg8K673NKl1vGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101847; c=relaxed/simple;
	bh=D1qiILc/Sa/I2viDPCtgcFhGzcKtXG4oori8NwNXTJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlVS0ruUl75Dj3ZJKnqv/DpoxSc39ioXJeycHA+dCf5mdIKh/aWdOfWYzQlIYqbV+viqpb/kV7sh7kdu3/GUbjPPkDRY3Cf+bnkKILhzirVViQ1ZgJdJNSgcMazAc8vVT0CegdtOdAavi5/CBJAL/f/7YMJT0IlEtM6kPW9U86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSEfljT/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso1430479a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101845; x=1734706645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSAUqBcs3hrEoqiEvd+1MHuwx0KU0yQERbqjEWvsGCI=;
        b=XSEfljT/SRzJ7SwFqNck/XEs7G/mhDLWLnJab1jmAOB8sPWKf49Mcvz3Yedv24LTfu
         XZh5ENbAJSwotIFpdlhXwztY2MAdqpltLRWb3t09yUl312BLS8IAXOSr3i2Jwm94nczp
         FFTk4xk361oyzNZ0igCSCvQkJ+GOIjmHepj6WP6xnjY99zOVRPRb6A2Kida02UgLWWAv
         YC4Jlv7exktNApyGPcaCvupraQpocIuNEooH4ghZf8MLjW3Xj6p6FfWIb+GESGpYBJyj
         X5ivZQrK8a3sKU6QZw5fQJk5dmrW+FfpZr5My5/+tWHb6PF8phDmH7cBHLK4NnwRwrhw
         1SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101845; x=1734706645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSAUqBcs3hrEoqiEvd+1MHuwx0KU0yQERbqjEWvsGCI=;
        b=hzRcx1JIkk5f/h4Uem47A5hr3esPWDhbpS+WG7Y2cHLWc4JEJkVpgUANj1L4vaXoch
         GrWhWCJsvGxEtYcWDZUuTms7jAu+IZVvzXuaRMolW8ZOEai1kvhIOWK4YNidkjNOm2N7
         IjY63qYTrYohLzOv+W1KrMtgUq5QAlVtkkGlQTczSwl7v7WI1M8oglzuCiQmevHbpQe3
         GZmNVz/kgedFBtrWtZSL84JZHyU37zisIKZTiGzl8GpJi65Y39T4WZJm+5vZy+Y0Cy67
         /WmjMwDnh/upVvhtB2UN/uRZK9tVIG6pivb25oS3JX2vLU97n9nVisotvJebEh4HYBLp
         LWog==
X-Forwarded-Encrypted: i=1; AJvYcCUGAykFjZQpDM2kNIB9UxszBabhMVRUZdPDXx6AmKbXbF/y2WI7mC/Ef8EzBY5PMC4bVpHV+uZQKrjiKxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOkA2nPlULKF/0MnmQQmBDg7pm2zU7bRqRFyHnUu++yXd/ysd
	iQI3HigUyok9OyNdVPRzJqY4bESjRA9wr0cP+E6MWtUvS4pKqZP7L1nnvWorJf81KdEZTfTbJNF
	my0JhVjsirJTV0orhLIsPfo//CCE=
X-Gm-Gg: ASbGncvBRFLXSMmU3m3kk5kL+8nycp3dhijhHV+lgzBnHloqnhnLr7hDK4ly5h7ptLM
	BtljLl890AqkiHdZCj8T42JwsetRf5fvPCFRNGg==
X-Google-Smtp-Source: AGHT+IHNGpPlVh1lnqxY3brXzVk13/rONRLR5RY8z01UQRxy4JyeEH9DyH7OH59As8yd6EByCgL95eg9p2oLBMQ1cUg=
X-Received: by 2002:a17:90b:1e43:b0:2ee:4b8f:a59c with SMTP id
 98e67ed59e1d1-2f28fd6a568mr3966032a91.22.1734101844443; Fri, 13 Dec 2024
 06:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026132014.73050-1-aford173@gmail.com> <20241026132014.73050-3-aford173@gmail.com>
 <CAMuHMdVx9zYw7ZpyH=d_rs==a+_jzi--Fax5cVe-8UW+RvRx+g@mail.gmail.com>
In-Reply-To: <CAMuHMdVx9zYw7ZpyH=d_rs==a+_jzi--Fax5cVe-8UW+RvRx+g@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 13 Dec 2024 08:57:12 -0600
Message-ID: <CAHCN7xJBv0jqiPWj3gOJBrK67BgSNsiX6cDg-Tau4A8D16HPUA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] phy: freescale: fsl-samsung-hdmi: Clean up
 fld_tg_code calculation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-phy@lists.infradead.org, aford@beaconembedded.com, sandor.yu@nxp.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 8:13=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Adam,
>
> On Sat, Oct 26, 2024 at 3:21=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> > Currently, the calcuation for fld_tg_code is based on a lookup table,
>
> calculation (everywhere)
>
> > but there are gaps in the lookup table, and frequencies in these
> > gaps may not properly use the correct divider.  Based on the descriptio=
n
> > of FLD_CK_DIV, the internal PLL frequency should be less than 50 MHz,
> > so directly calcuate the value of FLD_CK_DIV from pixclk.
> > This allow for proper calcuation of any pixel clock and eliminates a
> > few gaps in the LUT.
> >
> > Since the value of the int_pllclk is in Hz, do the fixed-point
> > math in Hz to achieve a more accurate value and reduces the complexity
> > of the caluation to 24MHz * (256 / int_pllclk).
> >
> > Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Thanks for your patch, which is now commit d567679f2b6a8bce ("phy:
> freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation") in
> next-20241209 and later.
>
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -331,25 +331,17 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struc=
t fsl_samsung_hdmi_phy *phy,
> >  {
> >         u32 pclk =3D cfg->pixclk;
> >         u32 fld_tg_code;
> > -       u32 pclk_khz;
> > -       u8 div =3D 1;
> > -
> > -       switch (cfg->pixclk) {
> > -       case  22250000 ...  47500000:
> > -               div =3D 1;
> > -               break;
> > -       case  50349650 ...  99000000:
> > -               div =3D 2;
> > -               break;
> > -       case 100699300 ... 198000000:
> > -               div =3D 4;
> > -               break;
> > -       case 205000000 ... 297000000:
> > -               div =3D 8;
> > -               break;
> > +       u32 int_pllclk;
> > +       u8 div;
> > +
> > +       /* Find int_pllclk speed */
> > +       for (div =3D 0; div < 4; div++) {
> > +               int_pllclk =3D pclk / (1 << div);
> > +               if (int_pllclk < (50 * MHZ))
> > +                       break;
> >         }
> >
> > -       writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + P=
HY_REG(12));
> > +       writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(=
12));
>
> This causes a build failure on m68k with gcc version 9.5.0 (Ubuntu
> 9.5.0-1ubuntu1~22.04):
>
>   CC [M]  drivers/phy/freescale/phy-fsl-samsung-hdmi.o
> In file included from ./arch/m68k/include/asm/io_mm.h:25,
>                  from ./arch/m68k/include/asm/io.h:8,
>                  from ./include/linux/io.h:14,
>                  from ./include/linux/iopoll.h:14,
>                  from drivers/phy/freescale/phy-fsl-samsung-hdmi.c:12:
> In function =E2=80=98fsl_samsung_hdmi_phy_configure_pll_lock_det=E2=80=99=
,
>     inlined from =E2=80=98fsl_samsung_hdmi_phy_configure=E2=80=99 at
> drivers/phy/freescale/phy-fsl-samsung-hdmi.c:470:2:
> ././include/linux/compiler_types.h:542:38: error: call to
> =E2=80=98__compiletime_assert_147=E2=80=99 declared with attribute error:=
 FIELD_PREP:
> value too large for the field
>   542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
>       |                                      ^
> ./arch/m68k/include/asm/raw_io.h:30:82: note: in definition of macro =E2=
=80=98out_8=E2=80=99
>    30 | #define out_8(addr,b) (void)((*(__force volatile u8 *)
> (unsigned long)(addr)) =3D (b))
>       |
>                   ^
> drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:2: note: in expansion
> of macro =E2=80=98writeb=E2=80=99
>   344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(1=
2));
>       |  ^~~~~~
> ././include/linux/compiler_types.h:530:2: note: in expansion of macro
> =E2=80=98__compiletime_assert=E2=80=99
>   530 |  __compiletime_assert(condition, msg, prefix, suffix)
>       |  ^~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:542:2: note: in expansion of macro
> =E2=80=98_compiletime_assert=E2=80=99
>   542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro
> =E2=80=98compiletime_assert=E2=80=99
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:68:3: note: in expansion of macro =E2=80=98BUI=
LD_BUG_ON_MSG=E2=80=99
>    68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>       |   ^~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:115:3: note: in expansion of macro =E2=80=98__=
BF_FIELD_CHECK=E2=80=99
>   115 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>       |   ^~~~~~~~~~~~~~~~
> drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:9: note: in expansion
> of macro =E2=80=98FIELD_PREP=E2=80=99
>   344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(1=
2));
>       |         ^~~~~~~~~~
>
> As it builds fine on i386, I looked at the preprocessed source files,
> but didn't see any differences that could explain this.
>
> I changed cross-compiler to gcc version 10.5.0 (Ubuntu 10.5.0-1ubuntu1~22=
.04),
> and that fixed the issue on m68k.
> I changed the native compiler to gcc-9, and the build started failing
> on i386 and x86_64, too....

I use the default compiler on Ubuntu 24.04.
Do you think it's best that I just replace the FIELD_PREP  macro with
manual code for that line?

adam
>
> >
> >         /*
> >          * Calculation for the frequency lock detector target code (fld=
_tg_code)
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

