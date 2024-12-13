Return-Path: <linux-kernel+bounces-444936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58269F0ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D5A16C81E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335D1E0B86;
	Fri, 13 Dec 2024 14:13:32 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C51E04BA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099212; cv=none; b=GsS0xtv9T98LvJIdtVR8H/X6JbqEl7St7os+yzayxMD9QA7LuGFpSUN8NeErA1jhzhoP4x637kQuQTks1CyZG7MsuRX2HMEsJZSZ7u1uZ+g1cSpPNy6djKuSgVn7NomTYvi3qQkQ160zHFMwfG7EyX7Jb3raOy8WTOQui5DpJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099212; c=relaxed/simple;
	bh=3W1he1wclmGdMP1YWtwaSCF6denb2KvzPPAmeLfLkJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR1mMf+5wJnTeLJY+5cshZw+XXhyD54n8tJ7wDNjhNCJ2+4uYVBQvh7xFtvZ8F9RGNDH7PH2Eghaqg58bgfykhKk73meTNhZbX9fhYk1HX0OvLy88AHzSGQA+6QuVaP7Tut+wM+7ZgdJL4gh+R7EzEmcbGxRWxEXzEoi/ASUAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so14749216d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099208; x=1734704008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35iE//JjwwJVa2lJd+7iAycrV7dSlJWEOt08EOLoAcU=;
        b=uEPLAcsMTMt/uWvlm9g/MMMSdWg2QMaMBKqJMXXO00p0N2HhPf6D/r/VFFcHEPbXns
         QEtycbeeyr602JZzmkHfGJBr2jN9sxYj/xXAE8wZwODr9u/T8R7oRCj2cLM5Vb0bpmsj
         ysbyUm4BweXjjeqH/uegU91/chsFK1Fy1RQhScQbkYBJJ2q7sbMF8QxA2LhK5Kcrh/ZQ
         nHQptY2wwPm12yDYTWne7neQ8Jm6+MKgixVsREFpuKMW0IfGj065LFGXNj58akRAAtOb
         jWQhtGlip/uhVkIu9z2FO9q0G1ApbiqjN+kW+SzJ7Jsmo5kaM5zXEuJNhsB5TYRScqxd
         2HAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWncYOJkuJpDP8Fg76jEhizspGglpy7Zbn3JM01ORoN49ePo4Z1aI7ivaLgeOJwZX7UOw8JpdoifzKhVf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjP4BsPwNUAxHQCNq2xPu55/OfNxJrNP1cNW1qKOb3Xwk+lCgY
	kIceSkebySt/pyYZ//NA4U4E4wIf5VbSXVBhgbSEfvIs3NZssnTYdckDdTIR
X-Gm-Gg: ASbGncv9l28Iq3bmnnpgwU20cIz90v4ioEdiaAviEhrpGehDL96BVj4ndLi20nU+FcY
	xKLd4fS+CKuaES9y3idJgX3lfgSIOU/QQNH0pZZwP4M/w1MPnvHMLJo0b/uCHDuhOkwzKE6ic3g
	ffzAcsZPslxDxgz1Z6r5OHkMdytOboQ4nQ1irU1WtcJNaNqLhl1RxQTYVETuac+z0QpBO2MDyau
	PW3biG4UWyxYNzWWWwZLqtq0u3S+H/zoor3zgDDsji7TcKjobYReav1VQ7Ub5EA0rBAI8Zw3fBc
	JHC3h4o3eZ0w2RMcnBORtuo=
X-Google-Smtp-Source: AGHT+IFx+EmNvD1FLXcTNEbqtpIeZrYXp+PescKjlJge5GQbDXFEcs/SWXoUnkwA9AFvDMgPv2KhTQ==
X-Received: by 2002:a05:6214:d49:b0:6d8:a5f7:f116 with SMTP id 6a1803df08f44-6dc9698ef15mr46453236d6.42.1734099207699;
        Fri, 13 Dec 2024 06:13:27 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da695ca3sm92613846d6.32.2024.12.13.06.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:13:27 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6fc5bf609so48025985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:13:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLB6fN7CToxK8qHaPHLhyxwRu25Klye41Om17z4NY08f9l5KMuh/S5yOhxrYCSgTbQAMBphabhVlRSJjo=@vger.kernel.org
X-Received: by 2002:a05:620a:1990:b0:7b6:d050:7210 with SMTP id
 af79cd13be357-7b6fbee7b25mr462900485a.15.1734099206681; Fri, 13 Dec 2024
 06:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026132014.73050-1-aford173@gmail.com> <20241026132014.73050-3-aford173@gmail.com>
In-Reply-To: <20241026132014.73050-3-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Dec 2024 15:13:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVx9zYw7ZpyH=d_rs==a+_jzi--Fax5cVe-8UW+RvRx+g@mail.gmail.com>
Message-ID: <CAMuHMdVx9zYw7ZpyH=d_rs==a+_jzi--Fax5cVe-8UW+RvRx+g@mail.gmail.com>
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

On Sat, Oct 26, 2024 at 3:21=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
> Currently, the calcuation for fld_tg_code is based on a lookup table,

calculation (everywhere)

> but there are gaps in the lookup table, and frequencies in these
> gaps may not properly use the correct divider.  Based on the description
> of FLD_CK_DIV, the internal PLL frequency should be less than 50 MHz,
> so directly calcuate the value of FLD_CK_DIV from pixclk.
> This allow for proper calcuation of any pixel clock and eliminates a
> few gaps in the LUT.
>
> Since the value of the int_pllclk is in Hz, do the fixed-point
> math in Hz to achieve a more accurate value and reduces the complexity
> of the caluation to 24MHz * (256 / int_pllclk).
>
> Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks for your patch, which is now commit d567679f2b6a8bce ("phy:
freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation") in
next-20241209 and later.

> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -331,25 +331,17 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct =
fsl_samsung_hdmi_phy *phy,
>  {
>         u32 pclk =3D cfg->pixclk;
>         u32 fld_tg_code;
> -       u32 pclk_khz;
> -       u8 div =3D 1;
> -
> -       switch (cfg->pixclk) {
> -       case  22250000 ...  47500000:
> -               div =3D 1;
> -               break;
> -       case  50349650 ...  99000000:
> -               div =3D 2;
> -               break;
> -       case 100699300 ... 198000000:
> -               div =3D 4;
> -               break;
> -       case 205000000 ... 297000000:
> -               div =3D 8;
> -               break;
> +       u32 int_pllclk;
> +       u8 div;
> +
> +       /* Find int_pllclk speed */
> +       for (div =3D 0; div < 4; div++) {
> +               int_pllclk =3D pclk / (1 << div);
> +               if (int_pllclk < (50 * MHZ))
> +                       break;
>         }
>
> -       writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY=
_REG(12));
> +       writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12=
));

This causes a build failure on m68k with gcc version 9.5.0 (Ubuntu
9.5.0-1ubuntu1~22.04):

  CC [M]  drivers/phy/freescale/phy-fsl-samsung-hdmi.o
In file included from ./arch/m68k/include/asm/io_mm.h:25,
                 from ./arch/m68k/include/asm/io.h:8,
                 from ./include/linux/io.h:14,
                 from ./include/linux/iopoll.h:14,
                 from drivers/phy/freescale/phy-fsl-samsung-hdmi.c:12:
In function =E2=80=98fsl_samsung_hdmi_phy_configure_pll_lock_det=E2=80=99,
    inlined from =E2=80=98fsl_samsung_hdmi_phy_configure=E2=80=99 at
drivers/phy/freescale/phy-fsl-samsung-hdmi.c:470:2:
././include/linux/compiler_types.h:542:38: error: call to
=E2=80=98__compiletime_assert_147=E2=80=99 declared with attribute error: F=
IELD_PREP:
value too large for the field
  542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |                                      ^
./arch/m68k/include/asm/raw_io.h:30:82: note: in definition of macro =E2=80=
=98out_8=E2=80=99
   30 | #define out_8(addr,b) (void)((*(__force volatile u8 *)
(unsigned long)(addr)) =3D (b))
      |
                  ^
drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:2: note: in expansion
of macro =E2=80=98writeb=E2=80=99
  344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12)=
);
      |  ^~~~~~
././include/linux/compiler_types.h:530:2: note: in expansion of macro
=E2=80=98__compiletime_assert=E2=80=99
  530 |  __compiletime_assert(condition, msg, prefix, suffix)
      |  ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:542:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:68:3: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON_MSG=E2=80=99
   68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
      |   ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:115:3: note: in expansion of macro =E2=80=98__BF=
_FIELD_CHECK=E2=80=99
  115 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      |   ^~~~~~~~~~~~~~~~
drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:9: note: in expansion
of macro =E2=80=98FIELD_PREP=E2=80=99
  344 |  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12)=
);
      |         ^~~~~~~~~~

As it builds fine on i386, I looked at the preprocessed source files,
but didn't see any differences that could explain this.

I changed cross-compiler to gcc version 10.5.0 (Ubuntu 10.5.0-1ubuntu1~22.0=
4),
and that fixed the issue on m68k.
I changed the native compiler to gcc-9, and the build started failing
on i386 and x86_64, too....

>
>         /*
>          * Calculation for the frequency lock detector target code (fld_t=
g_code)

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

