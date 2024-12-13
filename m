Return-Path: <linux-kernel+bounces-445065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B89F10A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F84188190F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1E1E2009;
	Fri, 13 Dec 2024 15:16:38 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B1B412E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102998; cv=none; b=hof4rAZ8BMQ1GbRypvY8jpavGYBssGi317rep3FJ7mUyW9LeJp7UgjE+PsdGtTbk36bOADqfRbFxbEkz8Fgvok53FSWcasmcqm1SZ4K3Q/aC3GLDellltT2KqwSOVoWCZHWESCpzo+7b5n81vPLJsgP/g/cQnvE4NQNKDVvNJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102998; c=relaxed/simple;
	bh=BMrJLr8iY4gnvutzVySKWdcXoXKyO2cz0p+07ZKUhbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhMROcZqPPSP++mytp0o3ruP4ShUQd7pa0kBpbrc/TzKprfLMprXO6j3IhKR2HsLA67i0IijqUK6cMZz2W21c7Mjk2TqZYcLEbpfPhEwo0Aku7LaeZ5FIJX0qQ2Qd/UF4OtuIWG7RzMGK0L9dGd6HJ1alcM88Fm1OkjagVkgqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d933736380so22923226d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102994; x=1734707794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQjBH7m6P0DsovRZ9n46T5HOryXg2GC8MD+lLeQRFrU=;
        b=YH8V3Tp6C/V1wMh9kjz1MbgElFJnreHepjgnsZ9WBN3n17+PRe6WHqEq2PJi0Ezn6v
         Ej0ueKW98JJTR2E70PcmPLcdaNdU3HW+6GIEQJEZxjZEfx1yyfmQoU8qE7eMN2ecgpap
         YIhIZZRKLm/mMqOlCORd78RkXGA17SDpXACSniDQSu93b73tmNVTMSMFsdY3CTk55MQY
         KmJH3sjS0bql2XT+aEDXyU4q1Kc7RPYMYlWJMDy0cRBd9NpdSxqzIomzxY1xi1mEsCNQ
         ewE/q0T/zkmd9gkn3uU/2r2c6hV/iJmOJTJ743qh7h/N0IJZapCkBKk4u4tP5JuvOS9N
         1zHg==
X-Forwarded-Encrypted: i=1; AJvYcCVkRLF1BRnl7PC8zcvARoxPIzMdKGmLXYuB0t/0Mwy6/yd8ZWBPdRn5sdDlnAkNRU39uwidMnBn7PjYo9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSlqLwsendeei+nut2KM/AAmFP1DQGSHoq/HNfDLiCqDyPsWk
	ouHLzUOfNG9Ud47ulqxCgCDEuuu5REt9es0tjIk9UX8sSyvcoRanpfh/FSuM
X-Gm-Gg: ASbGnctdhbXrXvthHM4LHPHJU2GB8KRTlaZVbUk+meVBaDzQmZWNTTV+iuLRr4mgbHZ
	69PD9jZ89SBh2VVp7RWdMdK22arpKIPP2UIUoxdy2jRe6VqstM0dOBIiVwPaWDqHXgkiZ2tu0CD
	z2aHQul7JK/B+vKEKG7XeTCRt2cXDmcRZ8sXtvmavqR2srvLtQaV3aM68VTdpjq2ekWaotVjKlu
	OpFbl0XbwAaOZJVTJiUS/xrjxk7Dxg9Va+vu0qttAw2i6KfyhyP0zlIddOOmcNjW6OgR5th2efU
	/GECmyqsJK1L862J5i/9vwA=
X-Google-Smtp-Source: AGHT+IF3DIhXPpSxd/XC+rLny+BcEdwbZAQVyOOGgcQgT4iaRe03i4hKBqqxT+sADArYV6lGgwaZXw==
X-Received: by 2002:a05:6214:2628:b0:6d8:8466:d205 with SMTP id 6a1803df08f44-6dc8ca3ef82mr54756166d6.6.1734102994097;
        Fri, 13 Dec 2024 07:16:34 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66eecbsm92678586d6.15.2024.12.13.07.16.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:16:33 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f1b54dc3so243379085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:16:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRmzPKSsOQmX/yqyImf45vKCsQN1epPcmPHge27Ng9VAIlL1fynQ6s1MTPrGTADTLh7hvQ7SfVaBmlRVw=@vger.kernel.org
X-Received: by 2002:a05:620a:4441:b0:7b6:f1b8:8a03 with SMTP id
 af79cd13be357-7b6fbf17969mr436286685a.36.1734102993530; Fri, 13 Dec 2024
 07:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026132014.73050-1-aford173@gmail.com> <20241026132014.73050-3-aford173@gmail.com>
 <CAMuHMdVx9zYw7ZpyH=d_rs==a+_jzi--Fax5cVe-8UW+RvRx+g@mail.gmail.com> <CAHCN7xJBv0jqiPWj3gOJBrK67BgSNsiX6cDg-Tau4A8D16HPUA@mail.gmail.com>
In-Reply-To: <CAHCN7xJBv0jqiPWj3gOJBrK67BgSNsiX6cDg-Tau4A8D16HPUA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Dec 2024 16:16:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUG7A10E2SZR6kHiQBrzp_OVvMSd7jxggaoU3B_6fZ+nQ@mail.gmail.com>
Message-ID: <CAMuHMdUG7A10E2SZR6kHiQBrzp_OVvMSd7jxggaoU3B_6fZ+nQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] phy: freescale: fsl-samsung-hdmi: Clean up
 fld_tg_code calculation
To: Adam Ford <aford173@gmail.com>
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

Hi Adam,

On Fri, Dec 13, 2024 at 3:57=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
> On Fri, Dec 13, 2024 at 8:13=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Sat, Oct 26, 2024 at 3:21=E2=80=AFPM Adam Ford <aford173@gmail.com> =
wrote:
> > > Currently, the calcuation for fld_tg_code is based on a lookup table,
> >
> > calculation (everywhere)
> >
> > > but there are gaps in the lookup table, and frequencies in these
> > > gaps may not properly use the correct divider.  Based on the descript=
ion
> > > of FLD_CK_DIV, the internal PLL frequency should be less than 50 MHz,
> > > so directly calcuate the value of FLD_CK_DIV from pixclk.
> > > This allow for proper calcuation of any pixel clock and eliminates a
> > > few gaps in the LUT.
> > >
> > > Since the value of the int_pllclk is in Hz, do the fixed-point
> > > math in Hz to achieve a more accurate value and reduces the complexit=
y
> > > of the caluation to 24MHz * (256 / int_pllclk).
> > >
> > > Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >
> > Thanks for your patch, which is now commit d567679f2b6a8bce ("phy:
> > freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation") in
> > next-20241209 and later.
> >
> > > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > @@ -331,25 +331,17 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(str=
uct fsl_samsung_hdmi_phy *phy,
> > >  {
> > >         u32 pclk =3D cfg->pixclk;
> > >         u32 fld_tg_code;
> > > -       u32 pclk_khz;
> > > -       u8 div =3D 1;
> > > -
> > > -       switch (cfg->pixclk) {
> > > -       case  22250000 ...  47500000:
> > > -               div =3D 1;
> > > -               break;
> > > -       case  50349650 ...  99000000:
> > > -               div =3D 2;
> > > -               break;
> > > -       case 100699300 ... 198000000:
> > > -               div =3D 4;
> > > -               break;
> > > -       case 205000000 ... 297000000:
> > > -               div =3D 8;
> > > -               break;
> > > +       u32 int_pllclk;
> > > +       u8 div;
> > > +
> > > +       /* Find int_pllclk speed */
> > > +       for (div =3D 0; div < 4; div++) {
> > > +               int_pllclk =3D pclk / (1 << div);
> > > +               if (int_pllclk < (50 * MHZ))
> > > +                       break;
> > >         }
> > >
> > > -       writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs +=
 PHY_REG(12));
> > > +       writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_RE=
G(12));
> >
> > This causes a build failure on m68k with gcc version 9.5.0 (Ubuntu
> > 9.5.0-1ubuntu1~22.04):
> >
> >   CC [M]  drivers/phy/freescale/phy-fsl-samsung-hdmi.o
> > In file included from ./arch/m68k/include/asm/io_mm.h:25,
> >                  from ./arch/m68k/include/asm/io.h:8,
> >                  from ./include/linux/io.h:14,
> >                  from ./include/linux/iopoll.h:14,
> >                  from drivers/phy/freescale/phy-fsl-samsung-hdmi.c:12:
> > In function =E2=80=98fsl_samsung_hdmi_phy_configure_pll_lock_det=E2=80=
=99,
> >     inlined from =E2=80=98fsl_samsung_hdmi_phy_configure=E2=80=99 at
> > drivers/phy/freescale/phy-fsl-samsung-hdmi.c:470:2:
> > ././include/linux/compiler_types.h:542:38: error: call to
> > =E2=80=98__compiletime_assert_147=E2=80=99 declared with attribute erro=
r: FIELD_PREP:
> > value too large for the field
> >   542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
> >       |                                      ^
> > ./arch/m68k/include/asm/raw_io.h:30:82: note: in definition of macro =
=E2=80=98out_8=E2=80=99
> >    30 | #define out_8(addr,b) (void)((*(__force volatile u8 *)
> > (unsigned long)(addr)) =3D (b))
> >       |
> >                   ^
> > drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:2: note: in expansion
> > of macro =E2=80=98writeb=E2=80=99
> >   344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG=
(12));
> >       |  ^~~~~~
> > ././include/linux/compiler_types.h:530:2: note: in expansion of macro
> > =E2=80=98__compiletime_assert=E2=80=99
> >   530 |  __compiletime_assert(condition, msg, prefix, suffix)
> >       |  ^~~~~~~~~~~~~~~~~~~~
> > ././include/linux/compiler_types.h:542:2: note: in expansion of macro
> > =E2=80=98_compiletime_assert=E2=80=99
> >   542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
> >       |  ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro
> > =E2=80=98compiletime_assert=E2=80=99
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),=
 msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > ./include/linux/bitfield.h:68:3: note: in expansion of macro =E2=80=98B=
UILD_BUG_ON_MSG=E2=80=99
> >    68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
> >       |   ^~~~~~~~~~~~~~~~
> > ./include/linux/bitfield.h:115:3: note: in expansion of macro =E2=80=98=
__BF_FIELD_CHECK=E2=80=99
> >   115 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
> >       |   ^~~~~~~~~~~~~~~~
> > drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:9: note: in expansion
> > of macro =E2=80=98FIELD_PREP=E2=80=99
> >   344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG=
(12));
> >       |         ^~~~~~~~~~
> >
> > As it builds fine on i386, I looked at the preprocessed source files,
> > but didn't see any differences that could explain this.
> >
> > I changed cross-compiler to gcc version 10.5.0 (Ubuntu 10.5.0-1ubuntu1~=
22.04),
> > and that fixed the issue on m68k.
> > I changed the native compiler to gcc-9, and the build started failing
> > on i386 and x86_64, too....
>
> I use the default compiler on Ubuntu 24.04.
> Do you think it's best that I just replace the FIELD_PREP  macro with
> manual code for that line?

I think let's wait and see...
Perhaps this (compiler bug?) can be worked around in the
FIELD_PREP() macro itself.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

