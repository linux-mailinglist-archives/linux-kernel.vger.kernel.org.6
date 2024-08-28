Return-Path: <linux-kernel+bounces-305529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF2C963001
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0571C24BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE41AB504;
	Wed, 28 Aug 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvG5hgj0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAC189520;
	Wed, 28 Aug 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869854; cv=none; b=j2JvFtOrEmomkcgfhYTG/ClPfjCzf+S06YDSURtMdUqOVA4Yxn57QDuYLtTq5RWSYcIzAcW1oYtIdHv0FTjHOYy++iTCxZAFgjGpsUCZdcMPqR7wHvDXWSDwMu1SUgQPszWsNwrlbJd1rPMdP8PraTRk8pESRO6/5TH6Ho7U/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869854; c=relaxed/simple;
	bh=gm5wNgQPq8zaVU7WuCxl/FdzOHpdZQaZpErO5w9GDQM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lDDfuqh0F7HTyhV66QVFWU3vHCbPbeUV2d8sH+ZexI13tcyobNk6TtyMRrUIBLfE2yFIOTrYTKwI8DY/0RNgN4oFoIWI8n+d4MBSXJdgyYhBa1o8usX7Tn8w0EsJeUI4t377htpHJPVWKvEOz5JFSdHjxGOlB1ozfOzbXt/0Inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvG5hgj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CFEC4CEC0;
	Wed, 28 Aug 2024 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869854;
	bh=gm5wNgQPq8zaVU7WuCxl/FdzOHpdZQaZpErO5w9GDQM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MvG5hgj0NmlYgc1Sij1LzfvqO6t7R1LgrCmV86zeZytuUxASd4oabSkCHo2Egn8om
	 QxH23Drc+3JEHYkKGGMhkydBAop5+DydNF37PdRcBkexev+IX0Fj7hxdpv0WuNAgaw
	 krV40gE6FWVNh0bDpMPqUWOmtHfHRY/7U0lF7CZQhOlRSSTyI1kepawtXtXXslHV5T
	 amINvbq/7aOOBah1N0RSYeoKBk8EWPArYZh7H2929jWbUJspuk+V+cIUJSMWR+W1yS
	 2wPWce9I/FX8fhDXbi0z7QudtnqvSAQ0kxFCbvv4bmdrNi3E/rh5SzgHPn0r4Urzql
	 0C7hUMRYpMZUA==
Message-ID: <9b92b5f03632e8793253ba75fc00f6e3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240828101503.1478491-5-heiko@sntech.de>
References: <20240828101503.1478491-1-heiko@sntech.de> <20240828101503.1478491-5-heiko@sntech.de>
Subject: Re: [PATCH v3 4/5] clk: clk-gpio: add driver for gated-fixed-clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 28 Aug 2024 11:30:51 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-08-28 03:15:02)
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index cda362a2eca0..8bcdef340b4c 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -239,3 +240,184 @@ static struct platform_driver gpio_clk_driver =3D {
>         },
>  };
>  builtin_platform_driver(gpio_clk_driver);
> +
> +/**
> + * DOC: gated fixed clock, controlled with a gpio output and a regulator
> + * Traits of this clock:
> + * prepare - clk_prepare and clk_unprepare are function & control regula=
tor
> + *           optionally a gpio that can sleep
> + * enable - clk_enable and clk_disable are functional & control gpio
> + * rate - rate is fixed and set on clock generation

Maybe 'clock registration'

> + * parent - fixed clock is a root clock and has no parent.

Not sure why this one gets the period while other lines above don't.

> + */
> +
> +/**
> + * struct clk_gate_fixed - gated-fixed-clock
> + *
> + * clk_gpio:   instance of clk_gpio for gate-gpio
> + * supply:     supply regulator
> + * rate:       fixed rate
> + */
> +struct clk_gated_fixed {
> +       struct clk_gpio clk_gpio;
> +       struct regulator *supply;
> +       u32 rate;

unsigned long rate to match the CCF type please.

> +};
> +
> +#define to_clk_gated_fixed(_clk_gpio) container_of(_clk_gpio, struct clk=
_gated_fixed, clk_gpio)
> +
> +static unsigned long clk_gated_fixed_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rat=
e)
> +{
> +       return to_clk_gated_fixed(to_clk_gpio(hw))->rate;
> +}
> +
> +static int clk_gated_fixed_prepare(struct clk_hw *hw)
> +{
> +       struct clk_gated_fixed *clk =3D to_clk_gated_fixed(to_clk_gpio(hw=
));
> +
> +       if (!clk->supply)
> +               return 0;
> +
> +       return regulator_enable(clk->supply);
> +}
> +
> +static void clk_gated_fixed_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_gated_fixed *clk =3D to_clk_gated_fixed(to_clk_gpio(hw=
));
> +
> +       if (!clk->supply)
> +               return;
> +
> +       regulator_disable(clk->supply);
> +}
> +
> +static int clk_gated_fixed_is_prepared(struct clk_hw *hw)
> +{
> +       struct clk_gated_fixed *clk =3D to_clk_gated_fixed(to_clk_gpio(hw=
));
> +
> +       if (!clk->supply)
> +               return true;
> +
> +       return regulator_is_enabled(clk->supply);
> +}
> +
> +/*
> + * Fixed gated clock with non-sleeping gpio.
> + *
> + * Prepare operation turns on the supply regulator
> + * and the enable operation switches the enable-gpio.
> + */
> +const struct clk_ops clk_gated_fixed_ops =3D {

static

> +       .prepare =3D clk_gated_fixed_prepare,
> +       .unprepare =3D clk_gated_fixed_unprepare,
> +       .is_prepared =3D clk_gated_fixed_is_prepared,
> +       .enable =3D clk_gpio_gate_enable,
> +       .disable =3D clk_gpio_gate_disable,
> +       .is_enabled =3D clk_gpio_gate_is_enabled,
> +       .recalc_rate =3D clk_gated_fixed_recalc_rate,
> +};
> +
> +static int clk_sleeping_gated_fixed_prepare(struct clk_hw *hw)
> +{
> +       int ret;
> +
> +       ret =3D clk_gated_fixed_prepare(hw);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_sleeping_gpio_gate_prepare(hw);
> +       if (ret)
> +               clk_gated_fixed_unprepare(hw);
> +
> +       return ret;
> +}
> +
> +static void clk_sleeping_gated_fixed_unprepare(struct clk_hw *hw)
> +{
> +       clk_gated_fixed_unprepare(hw);
> +       clk_sleeping_gpio_gate_unprepare(hw);
> +}
> +
> +/*
> + * Fixed gated clock with non-sleeping gpio.
> + *
> + * Enabling the supply regulator and switching the enable-gpio happens
> + * both in the prepare step.
> + * is_prepared only needs to check the gpio state, as toggling the
> + * gpio is the last step when preparing.
> + */
> +const struct clk_ops clk_sleeping_gated_fixed_ops =3D {

static

> +       .prepare =3D clk_sleeping_gated_fixed_prepare,
> +       .unprepare =3D clk_sleeping_gated_fixed_unprepare,
> +       .is_prepared =3D clk_sleeping_gpio_gate_is_prepared,
> +       .recalc_rate =3D clk_gated_fixed_recalc_rate,
> +};
> +
> +static int clk_gated_fixed_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct clk_gated_fixed *clk;
> +       const struct clk_ops *ops;
> +       const char *clk_name;
> +       int ret;
> +
> +       clk =3D devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> +       if (!clk)
> +               return -ENOMEM;
> +
> +       if (device_property_read_u32(dev, "clock-frequency", &clk->rate))

Why not return the error code?

> +               return dev_err_probe(dev, -EIO, "failed to get clock-freq=
uency");

Missing newline on printk.

> +
> +       ret =3D device_property_read_string(dev, "clock-output-names", &c=
lk_name);
> +       if (ret)
> +               clk_name =3D fwnode_get_name(dev->fwnode);
> +
> +       clk->supply =3D devm_regulator_get_optional(dev, "vdd");
> +       if (IS_ERR(clk->supply)) {
> +               if (PTR_ERR(clk->supply) !=3D -ENODEV)
> +                       return dev_err_probe(dev, PTR_ERR(clk->supply),
> +                                            "failed to get regulator\n");
> +               clk->supply =3D NULL;
> +       }
> +
> +       clk->clk_gpio.gpiod =3D devm_gpiod_get_optional(dev, "enable",
> +                                                     GPIOD_OUT_LOW);
> +       if (IS_ERR(clk->clk_gpio.gpiod))
> +               return dev_err_probe(dev, PTR_ERR(clk->clk_gpio.gpiod),
> +                                    "failed to get gpio\n");
> +
> +       if (gpiod_cansleep(clk->clk_gpio.gpiod))
> +               ops =3D &clk_sleeping_gated_fixed_ops;
> +       else
> +               ops =3D &clk_gated_fixed_ops;
> +
> +       clk->clk_gpio.hw.init =3D CLK_HW_INIT_NO_PARENT(clk_name, ops, 0);
> +
> +       /* register the clock */
> +       ret =3D devm_clk_hw_register(dev, &clk->clk_gpio.hw);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to register clock\n");
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +                                         &clk->clk_gpio.hw);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to register clock provider\n=
");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id gated_fixed_clk_match_table[] =3D {
> +       { .compatible =3D "gated-fixed-clock" },

Add a sentinel.

> +};
> +
> +static struct platform_driver gated_fixed_clk_driver =3D {
> +       .probe          =3D clk_gated_fixed_probe,
> +       .driver         =3D {
> +               .name   =3D "gated-fixed-clk",
> +               .of_match_table =3D gated_fixed_clk_match_table,
> +       },
> +};
> +builtin_platform_driver(gated_fixed_clk_driver);

The comment above builtin_platform_driver says "Each driver may only use
this macro once". Seems that we need to expand the macro.

