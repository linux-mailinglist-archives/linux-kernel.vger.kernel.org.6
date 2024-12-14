Return-Path: <linux-kernel+bounces-445891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A479F1D28
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA3A7A054A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5915383B;
	Sat, 14 Dec 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXuEST1r"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7C5C96;
	Sat, 14 Dec 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734161526; cv=none; b=dwhSEpzs6ZP24hncNTfRuURPMSBu5sw8boU0NC2+KsPdbwF1U01V/W+pclvTBTBg/4nCR4V1/iJ2HDY9QtkNX1CgGRXcCmeg85WNjx4QXVVleg9xpuewmlI12vD3RVA8IkCdLvDjQm5KevtGjDQkPVjlXLFO7z/iPxfDTlMDoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734161526; c=relaxed/simple;
	bh=Lg6wNxdsLLY5Lp8a+X6uEKzwizIMd2JY0ZlX0WhbW8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb2qk3GfHJRREAPSD6EY9tLTJCgdg3EzImNXKEuRpBO4DFhqYWDvMxI8mLpyOnNFXAtifCdH3F+GSOQSAgRtuAV6DSDvW+TJYf7nR6X2xQDwmFBptZwqO005uy7FQ0Kxh0Egx4euWeIPf605jMbjch4Od0Y0FNpO54shqGh3sMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXuEST1r; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f2c34ae517so1023612eaf.1;
        Fri, 13 Dec 2024 23:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734161524; x=1734766324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wooyMz6V69rOWgXVqv8x+ga9QCy693idFla4iIf30yA=;
        b=DXuEST1rvtcZjDbSFOw+Eno1bYp5iig65lMN+Jc7ZwtvNjEGFT6EyeVk3CyEWQw3t1
         EY+peRGkJizgVtdKCnlwwBqzL3FjGDIQUIGQAXcZ+wM/bCZbEyzlnGCFQ+IDBTlqslqz
         5hsOnPZvT7GyTrVSt49oKpmEF1Ts7P3HnTJgEJuX5jd5qN3ebXG+h+GZIpUKbSAe2p+1
         ukO72RsbRDCO6kcrJDl+nmeAsqRN1qrfZJbjVGxTZexoohnXV04Xo62YlGE7ihguzPxY
         WntQPDjduy1BBbvAdl9JlO/LtbPOUUGBYIlL0UZfONN5X1yNwWI2qlcb88L0cJ56A98z
         YfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734161524; x=1734766324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wooyMz6V69rOWgXVqv8x+ga9QCy693idFla4iIf30yA=;
        b=mSkyYXfWg1ktYiXidF2Lh1csWqqhSMNRENfkfxrLb87ftxNmkpnBD9tqWqst56fT1w
         5MPzYnp+Yk3+K2BUfgp0tOVJFnQ0n8pRgrYs9KjbzM6mAncB2p1LWhamqOuD34ysnLEZ
         jZy+9vuh9KUdmy4gtoa9Afo2lUbJ3iHUMApwbIyaGrVydu8954dUlOPG2Bn/4KAleDD3
         Gmqz2IUfjyXCu63d/oqL85i3A1U5QFnVZxN8TwkbLZcivGU13tzZR3FDxCRPS7CImzyO
         6p5R/910SYCdzKHbU77U4Ed9NNaRJa6rpiMw747HE31AT2o1LpDtTocGTiwSAn/Mo3dk
         lHhg==
X-Forwarded-Encrypted: i=1; AJvYcCUknhMwpd81csJJzP3ij/3V3nh/VWubCKjVaDNgKXuKE2BfK3VJ4BMxNQN5LqTzMXjTUp/CR1VC9ewz@vger.kernel.org, AJvYcCVBzjgnostdOrr8vpVvNhjBUWRbLXH2U44Kcx0keKveZ+Oc8YdUj5nScvBd0f2LiIuejt7CRC/hxtSN5eRv@vger.kernel.org, AJvYcCVtof9UpkLaClHCfJAr4vbwfdX+k4wOUaDZwvU4H+rAZqHGt3OUhOGhsiLcbaoxUjXsgOdrCM0+/Iqn@vger.kernel.org
X-Gm-Message-State: AOJu0YyPn5BvCtcug/qIKFhuYMgtcqTaDk3U16I7Tc/hNXvBqtKAcYiH
	HxzTn+R5K3EOIdffEPB/0QCwPxpbfk7VBRRj03fVa26n8fhWKsvTAopjNXoH8DEOUBU68V7Qb5T
	YlLdQLzO2qyrJ7ElXkthMBDUzwJ8=
X-Gm-Gg: ASbGncs/W1+chOYL+TWTdGJ8K8b8L6D40npzH18R9MmTTucrHTvxH4RHZv2hQENXxO5
	V/Xs2jK3pUiOrFNTesZC6NHym5dekE/ii/Zdxc25opXs0v1W+uDyzVx4weHSq0G5aBJ49zJk5
X-Google-Smtp-Source: AGHT+IGmFywcjc7izrlDXgnkzLIqMiL0MnGMAOEArWH0D15iqh0keA0TjPRq8hM4SyuuwLNun7DH3X+llzzdV2xoAhI=
X-Received: by 2002:a05:6870:7011:b0:29e:3d0b:834 with SMTP id
 586e51a60fabf-2a3ac614135mr3251697fac.5.1734161524360; Fri, 13 Dec 2024
 23:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230505052110.67514-1-me@crly.cz> <20230505052110.67514-2-me@crly.cz>
 <CA+E=qVcSV7H4=-fT2FUdNd5sneCO0GsA-qKrvQxy8PF89knckw@mail.gmail.com>
In-Reply-To: <CA+E=qVcSV7H4=-fT2FUdNd5sneCO0GsA-qKrvQxy8PF89knckw@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 13 Dec 2024 23:31:38 -0800
Message-ID: <CA+E=qVeroOt_L-r--K7uYrS+039x-BtgciVqoez5CmOtmYyqVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux
To: Roman Beranek <me@crly.cz>
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Oltmanns <frank@oltmanns.dev>, 
	Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:29=E2=80=AFPM Vasily Khoruzhick <anarsoul@gmail.=
com> wrote:
>
> On Thu, May 4, 2023 at 10:34=E2=80=AFPM Roman Beranek <me@crly.cz> wrote:
> >
> > TCON0's source clock can be fed from either PLL_MIPI, or PLL_VIDEO0(2X)=
,
> > however MIPI DSI output only seems to work when PLL_MIPI is selected an=
d
> > thus the choice must be hardcoded in.
> >
> > Currently, this driver can't propagate rate change from N-K-M clocks
> > (such as PLL_MIPI) upwards. This prevents PLL_VIDEO0 from participating
> > in setting of the TCON0 data clock rate, limiting the precision with
> > which a target pixel clock can be matched.
> >
> > For outputs with fixed TCON0 divider, that is DSI and LVDS, the dotcloc=
k
> > can deviate up to 8% off target.
>
> Hi Roman,
>
> I'm a bit late, but this patch breaks the LCD on Pine64 Pinebook. When
> TCON0 parent is pll-mipi, the panel is blank and I get vblank timeouts.
>
> With this patch reverted it works if I force pll-video-2x as a parent for=
 TCON0.

And changing TCON0 parent in runtime by poking CCU registers also
fixes the issue (even though pll-video-2x is *much* slower than
pll-mipi), i.e. if I do "devmem2 0x01c20118 w 0x82000000" the picture
appears on the screen.

> So for me RGB output doesn't seem to work with PLL_MIPI, but works
> only with PLL_VIDEO0_2X. Any ideas on how to fix it?
>
> Regards,
> Vasily
>
>
>
> > Signed-off-by: Roman Beranek <me@crly.cz>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-=
ng/ccu-sun50i-a64.c
> > index 41519185600a..eb36f8f77d55 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > @@ -528,11 +528,18 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de=
_parents,
> >                                  0x104, 0, 4, 24, 3, BIT(31),
> >                                  CLK_SET_RATE_PARENT);
> >
> > +/*
> > + * DSI output seems to work only when PLL_MIPI selected. Set it and pr=
event
> > + * the mux from reparenting.
> > + */
> > +#define SUN50I_A64_TCON0_CLK_REG       0x118
> > +
> >  static const char * const tcon0_parents[] =3D { "pll-mipi", "pll-video=
0-2x" };
> >  static const u8 tcon0_table[] =3D { 0, 2, };
> >  static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents=
,
> >                                      tcon0_table, 0x118, 24, 3, BIT(31)=
,
> > -                                    CLK_SET_RATE_PARENT);
> > +                                    CLK_SET_RATE_PARENT |
> > +                                    CLK_SET_RATE_NO_REPARENT);
> >
> >  static const char * const tcon1_parents[] =3D { "pll-video0", "pll-vid=
eo1" };
> >  static const u8 tcon1_table[] =3D { 0, 2, };
> > @@ -953,6 +960,11 @@ static int sun50i_a64_ccu_probe(struct platform_de=
vice *pdev)
> >
> >         writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
> >
> > +       /* Set PLL MIPI as parent for TCON0 */
> > +       val =3D readl(reg + SUN50I_A64_TCON0_CLK_REG);
> > +       val &=3D ~GENMASK(26, 24);
> > +       writel(val | (0 << 24), reg + SUN50I_A64_TCON0_CLK_REG);
> > +
> >         ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_d=
esc);
> >         if (ret)
> >                 return ret;
> > --
> > 2.32.0 (Apple Git-132)
> >
> >

