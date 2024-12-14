Return-Path: <linux-kernel+bounces-445876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343F9F1D05
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF43188D169
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B841422AB;
	Sat, 14 Dec 2024 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnArI9sX"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66560126C10;
	Sat, 14 Dec 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734157820; cv=none; b=ekQB9xh8MkiCNeMLV2f5JPWDFWJhs08i9l3kTRZUtQo8qxQMvJfpi4pn+9FNENRGodyS9OrjwaVS0O5bQtjBggX3eRapQt1kO4AYI3VB9Y25xY0Xirt6mSBdoc1JWxlpWYVFraCCZHHvS8azbAMI/VJtvwbh8K33GYdtjwsVMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734157820; c=relaxed/simple;
	bh=ADdPyPpCiXUVsD/OBnMYzHixrDkS5BuxYN+fUPpmaQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLpfgonnG/hKRIt8mxL/4wX9NSkL/hbSD3M4gIwc9aVzxUo9Xd3oIiUpCbOG3hv8CgEEOUggOEpqrTsmw3lvx0k3WOcigrWR7jr9RX0uT+VNddQwdp3JGcvH2tRWB+rLohYGVC0D2e6kSRBPZSvlMlWJ9ceV36zYAVi/AEhZt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnArI9sX; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f304ac59b9so1227671eaf.0;
        Fri, 13 Dec 2024 22:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734157817; x=1734762617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrI8qCQN85qm0XYiJc+jVTuy93Oh6KAdPLxuWkpi6aM=;
        b=mnArI9sXF21s8jeNPUIFiq5yEcYeF2o2KsOW0WYVX9luonFOsTAi+/wtiPfjj/HYgo
         GFvngdC5p6NQ/6zs6LSHVf8GF7WazPIauVtfW37Am2pfYLiYwiOsDwITVHhaJCI+9GoF
         pnunOl3vpy4mlQwQWdLV9JkjSa8sxCL98c7sl0+r4vi0CXBzpl0qVQywLZbU4ATVufaJ
         6yjoQE2Pbwbijdb8K47uDl7C80ldol+5ydtmEjfRlya+c+WS3qHSAnzqSvZt0gJMqpkb
         cf+tiife4z5VVhw2V1TwKAqXGiTiaYB2lEyDEtxh6CfgVeW7+osUbQK7WPbz/jAqgdPU
         CE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734157817; x=1734762617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrI8qCQN85qm0XYiJc+jVTuy93Oh6KAdPLxuWkpi6aM=;
        b=pNyAP/m3MpN3rZtWwi+oCn0D8KqM7bpxLyhfeAByD9lNWFlnP3YrvwJHuKBuYXhOpX
         GSIqsWmGBp9GEIvIJk1euCzG9QXUPt5vzAIA2Zmrmeuv6MId/EmzGZNZZ9G4nvdHdrBM
         Ag0Dj34Ft+BUD6+iILLsca+CO1xkBKLxE9yto8V/OcuyB9J+5+8GIH4WB6f6VR/2aRUg
         Kt4r4pfaLG0eFnky0z1E07p+3poUm1DqYI8g7xMlmZzj6+xlZIDN1iZCF2Q2XOjmsf9y
         vqbZAvPDHaw0rKHppcplko1cfnw9I9WK1GYptd6lJgar1G5/kXL108NAzqdrhakysNo2
         jaxA==
X-Forwarded-Encrypted: i=1; AJvYcCUYjRxyRg0VpGyiAXszUQsWVNVzwwtzS91TxE6lJRlbknJ5mdcobi5hzZWLz8jMXIX0S8u0WkkHdmdx@vger.kernel.org, AJvYcCV5K6ro48b1/mjPGWRYuVgWdV2LTYmLQejw/vYv0gg40UWHSfNu7zt7P/EcNiHv0zOjKVDNu3K8u+Zd@vger.kernel.org, AJvYcCW6izItSYk3FFI5VOJuE8RKFHUB/mwVtGURGzdKEsxhO6qVc9P7qL4ttose7jMg8txdqgNSzSfizi5lMALq@vger.kernel.org
X-Gm-Message-State: AOJu0YygygoOY4OZK+cyI9O0wZm55C/Us+uSknFRFT8DRFCO9DCQFwPA
	gbGTw4EzS0WP7RROUUTu8JCr6Y2Y/uoKVy0QWZRGgfx1YNnzpvcih7aGi5UtwOYjKThTuOXNZku
	3ztXP1Kg+8VqU3SIODW+l8pSC4Aw=
X-Gm-Gg: ASbGncvLKCMEnUAqW9VTzTUY5Tg7ARG+GR2JaTdpRn0JOAreznAKc21KYON4L9mrPWi
	VooKFXCYuHPaV8gZcq6tVAApLhCOECqWgOVPTDVdF6xhrw+0cTwh/eMeEFrje+FG4ZIL5SwVp
X-Google-Smtp-Source: AGHT+IEPJNPA+UMoRL6Nd8OnH+KQK573OcmBMtIxEoDNfscNNNsJvvjIErYdh1Oh7XBBo4k+5gmKzsFAb+yk48Ks7y8=
X-Received: by 2002:a05:6870:828a:b0:29e:255e:9540 with SMTP id
 586e51a60fabf-2a3aca46b43mr2859925fac.35.1734157817408; Fri, 13 Dec 2024
 22:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230505052110.67514-1-me@crly.cz> <20230505052110.67514-2-me@crly.cz>
In-Reply-To: <20230505052110.67514-2-me@crly.cz>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 13 Dec 2024 22:29:51 -0800
Message-ID: <CA+E=qVcSV7H4=-fT2FUdNd5sneCO0GsA-qKrvQxy8PF89knckw@mail.gmail.com>
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

On Thu, May 4, 2023 at 10:34=E2=80=AFPM Roman Beranek <me@crly.cz> wrote:
>
> TCON0's source clock can be fed from either PLL_MIPI, or PLL_VIDEO0(2X),
> however MIPI DSI output only seems to work when PLL_MIPI is selected and
> thus the choice must be hardcoded in.
>
> Currently, this driver can't propagate rate change from N-K-M clocks
> (such as PLL_MIPI) upwards. This prevents PLL_VIDEO0 from participating
> in setting of the TCON0 data clock rate, limiting the precision with
> which a target pixel clock can be matched.
>
> For outputs with fixed TCON0 divider, that is DSI and LVDS, the dotclock
> can deviate up to 8% off target.

Hi Roman,

I'm a bit late, but this patch breaks the LCD on Pine64 Pinebook. When
TCON0 parent is pll-mipi, the panel is blank and I get vblank timeouts.

With this patch reverted it works if I force pll-video-2x as a parent for T=
CON0.

So for me RGB output doesn't seem to work with PLL_MIPI, but works
only with PLL_VIDEO0_2X. Any ideas on how to fix it?

Regards,
Vasily



> Signed-off-by: Roman Beranek <me@crly.cz>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
> index 41519185600a..eb36f8f77d55 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -528,11 +528,18 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_p=
arents,
>                                  0x104, 0, 4, 24, 3, BIT(31),
>                                  CLK_SET_RATE_PARENT);
>
> +/*
> + * DSI output seems to work only when PLL_MIPI selected. Set it and prev=
ent
> + * the mux from reparenting.
> + */
> +#define SUN50I_A64_TCON0_CLK_REG       0x118
> +
>  static const char * const tcon0_parents[] =3D { "pll-mipi", "pll-video0-=
2x" };
>  static const u8 tcon0_table[] =3D { 0, 2, };
>  static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
>                                      tcon0_table, 0x118, 24, 3, BIT(31),
> -                                    CLK_SET_RATE_PARENT);
> +                                    CLK_SET_RATE_PARENT |
> +                                    CLK_SET_RATE_NO_REPARENT);
>
>  static const char * const tcon1_parents[] =3D { "pll-video0", "pll-video=
1" };
>  static const u8 tcon1_table[] =3D { 0, 2, };
> @@ -953,6 +960,11 @@ static int sun50i_a64_ccu_probe(struct platform_devi=
ce *pdev)
>
>         writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
>
> +       /* Set PLL MIPI as parent for TCON0 */
> +       val =3D readl(reg + SUN50I_A64_TCON0_CLK_REG);
> +       val &=3D ~GENMASK(26, 24);
> +       writel(val | (0 << 24), reg + SUN50I_A64_TCON0_CLK_REG);
> +
>         ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_des=
c);
>         if (ret)
>                 return ret;
> --
> 2.32.0 (Apple Git-132)
>
>

