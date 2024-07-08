Return-Path: <linux-kernel+bounces-244941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D505092ABF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2C01F22FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB114F9E7;
	Mon,  8 Jul 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uehsCfh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426B1CAB1;
	Mon,  8 Jul 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477126; cv=none; b=J9sXpaMTsw1/NS9jCxGYQN5N9LXqKvIC5MD5+cSzBO/LQ2TpMifprH1VJvdXkWhdTk7sFLCzKDNACUq9c328UZl/R58DQ+4nb5QWRC128EtlXESyq6fcOSMJ3fK1oCEp8SIObWYrlqHB+KCDMwXPjNm2T8xUOUi4LMuEIB25Ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477126; c=relaxed/simple;
	bh=cU8H6Bif4LESAVrZggzoDOjewrXPpFQprPeYSGmE6rk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=g8cp0qqyREDo6NdZuOtIim76Kb30WBlGrTwdlWjbBAaEOrHhxEe14UTy/gvyVAq4xMb21j300VMV4HsKO492kcmj6lnh+olX3+EuU7Xql9IutRuyGvVFJ4sCSszvj7QHqeOkIAHXg29HpZLRxGpW/HXJZ4tboOM/KGGxFouBJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uehsCfh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0980BC116B1;
	Mon,  8 Jul 2024 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720477126;
	bh=cU8H6Bif4LESAVrZggzoDOjewrXPpFQprPeYSGmE6rk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uehsCfh6UfBo77U0FtaULfdGBO4IIJUUsXQFPEiyns6oY7m67Jw4VijgoOlcCm2NU
	 uKZStTPs2Rpq17fcaJnE0NaQoOFZY3zp9mlMzTywhJ8n/4JPzIeMRw0WMGPq2F+Pe1
	 0XDU1S+FmVHtD9G4cK9UvGtA6CJPfFnTtaizpdiNX5TqXiyGpjpD/JzW3ho7TQLZj0
	 mN0TxDFox76mxB9+DKDGluegcS9awx5G0nThr50Il21PXGH0uDQ3HvjLTVdKXg8evA
	 zvI0CGrGs2NSMMlnLJjXRWGsv2lc9wvQ4I1iC4iDv3D/12NT4pjsV+arZz9ZhYkWPl
	 Q3ZRhvlYPQ6mw==
Message-ID: <6c5d6c0730698969ef613ec9ec4aa14a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240617-ep93xx-v10-3-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me> <20240617-ep93xx-v10-3-662e640ed811@maquefel.me>
Subject: Re: [PATCH v10 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, nikita.shubin@maquefel.me
Date: Mon, 08 Jul 2024 15:18:43 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-06-17 02:36:37)
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> new file mode 100644
> index 000000000000..a0430a5ae4da
> --- /dev/null
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -0,0 +1,834 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
[...]
> +
> +static int ep93xx_clk_enable(struct clk_hw *hw)
> +{
> +       struct ep93xx_clk *clk =3D ep93xx_clk_from(hw);
> +       struct ep93xx_clk_priv *priv =3D ep93xx_priv_from(clk);
> +       u32 val;
> +
> +       guard(spinlock_irqsave)(&priv->lock);

I thought guard() was most important when there were multiple exit paths
from a function, but OK.

> +
[...]
> +
> +static int ep93xx_plls_init(struct ep93xx_clk_priv *priv)
> +{
> +       const char fclk_divisors[] =3D { 1, 2, 4, 8, 16, 1, 1, 1 };
> +       const char hclk_divisors[] =3D { 1, 2, 4, 5, 6, 8, 16, 32 };
[...]
> +       if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
> +               clk_pll2_rate =3D EP93XX_EXT_CLK_RATE;
> +       else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
> +               clk_pll2_rate =3D calc_pll_rate(EP93XX_EXT_CLK_RATE, valu=
e);
> +       else
> +               clk_pll2_rate =3D 0;
> +
> +       hw =3D devm_clk_hw_register_fixed_rate(dev, "pll2", "xtali", 0, c=
lk_pll2_rate);

Please use clk_parent_data for topology descriptions.

> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_PLL2] =3D hw;
> +
> +       return 0;
> +}
> +
> +static int ep93xx_clk_probe(struct auxiliary_device *adev,
> +                              const struct auxiliary_device_id *id)
> +{
> +       struct ep93xx_regmap_adev *rdev =3D to_ep93xx_regmap_adev(adev);
> +       struct clk_parent_data xtali =3D { .index =3D 0 };
> +       struct clk_parent_data ddiv_pdata[3] =3D { };
> +       unsigned int clk_spi_div, clk_usb_div;
> +       struct clk_parent_data pdata =3D {};
> +       struct device *dev =3D &adev->dev;
> +       struct ep93xx_clk_priv *priv;
> +       struct ep93xx_clk *clk;
> +       struct clk_hw *hw;
> +       unsigned int idx;
> +       int ret;
> +       u32 value;
> +
> +       priv =3D devm_kzalloc(dev, struct_size(priv, reg, 10), GFP_KERNEL=
);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->lock);
> +       priv->dev =3D dev;
> +       priv->aux_dev =3D rdev;
> +       priv->map =3D rdev->map;
> +       priv->base =3D rdev->base;
> +
> +       ret =3D ep93xx_plls_init(priv);
> +       if (ret)
> +               return ret;
> +
> +       regmap_read(priv->map, EP93XX_SYSCON_CLKSET2, &value);
> +       clk_usb_div =3D (value >> 28 & GENMASK(3, 0)) + 1;
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, "usb_clk", "pll2", =
0, 1, clk_usb_div);

This one can use clk_hw to reference pll2.

> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_USB] =3D hw;
> +
> +       ret =3D ep93xx_uart_clock_init(priv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ep93xx_dma_clock_init(priv);
> +       if (ret)
> +               return ret;
> +
> +       clk_spi_div =3D id->driver_data;
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, "ep93xx-spi.0", "xt=
ali",

Are these clk names trying to match device names?

> +                                              0, 1, clk_spi_div);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_SPI] =3D hw;
> +
> +       /* PWM clock */
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, "pwm_clk", "xtali",=
 0, 1, 1);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_PWM] =3D hw;
> +
> +       /* USB clock */
> +       hw =3D devm_clk_hw_register_gate(priv->dev, "ohci-platform", "usb=
_clk",
> +                                      0, priv->base + EP93XX_SYSCON_PWRC=
NT,
> +                                      EP93XX_SYSCON_PWRCNT_USH_EN, 0,
> +                                      &priv->lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +

