Return-Path: <linux-kernel+bounces-263806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F593DAB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6EE283E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170A14D6EB;
	Fri, 26 Jul 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJVVBG93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A9149E1D;
	Fri, 26 Jul 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033554; cv=none; b=MK4ROTsjc57WLsN/lCqXv/JGs/GCCHiTc4G1LkH8CVf1zB1tqLTq2l0X5WbU/lquIowOgVcpFWX9Dju2MIh+AjteowYIBLWCXSvdQUpo4LGUdEGvvM5v9NgNBG7ILFaLDas7Rg5H+Bh54P/URPbh2GMuXBxFxLYScqtkFsuIeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033554; c=relaxed/simple;
	bh=tc4bb2Nm0/M0kPveLY1Vp6o9t8P48zNwwlZP+5YVO9I=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=vGrSUIYE7YHTskas1W+1r4zPM4/BNOfqn+wmcfEFqh/0L0lQyCb8zQk/osUuUGFvKD0gvd7Yd8Uy510rN7oFMuVK5jFOU7pjRRiKRJPfr9jcN/fpk8ADoOV/XVJAM3QehOylek59SgUBpMIKzy4UYftbIyqNCO2iPV76BGuailY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJVVBG93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F94CC32782;
	Fri, 26 Jul 2024 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722033553;
	bh=tc4bb2Nm0/M0kPveLY1Vp6o9t8P48zNwwlZP+5YVO9I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nJVVBG93nzOpL9Vm5/nkgPt/6E4jjb4gSShBSTSLr3V8/TcHJsWTEEW0LEPKSgT9R
	 j7Zz7goZex1DSDFkMH4zzqnCLEaUotykV2qMw43hEeEw2nXdYUOI2qreUFJvsiGmFQ
	 TKrqqqs9P5v9HWgDNMwGKfnTu/H3REWkuI+o/7gdbcRCqUn4RD4hjO8Icu0Pe/FntI
	 lLncLa4uwkPAp30waRdAlvYUxi8rBRf9i23ngLWaUjqaEomtQB5pvkH2slWf/MkCZh
	 cygqMt4k1itqCmcb3DecGpLUIZV25uFRV7qyGXI00/MERsHlA6LtPt8IzNp27bB836
	 SPwMBNtmDADzA==
Message-ID: <84b55412bc61cdcbbc4e051c88827c00.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240715110251.261844-3-heiko@sntech.de>
References: <20240715110251.261844-1-heiko@sntech.de> <20240715110251.261844-3-heiko@sntech.de>
Subject: Re: [PATCH v2 2/3] clk: add driver for voltage controlled oscillators
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Fri, 26 Jul 2024 15:39:11 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-07-15 04:02:50)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 4abe16c8ccdfe..ca7b7b7ddfd8d 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_COMMON_CLK_SI521XX)      +=3D clk-si521xx.o
>  obj-$(CONFIG_COMMON_CLK_VC3)           +=3D clk-versaclock3.o
>  obj-$(CONFIG_COMMON_CLK_VC5)           +=3D clk-versaclock5.o
>  obj-$(CONFIG_COMMON_CLK_VC7)           +=3D clk-versaclock7.o
> +obj-$(CONFIG_COMMON_CLK_VCO)           +=3D clk-vco.o

Wrong section. It's basically a common clk type.

>  obj-$(CONFIG_COMMON_CLK_WM831X)                +=3D clk-wm831x.o
>  obj-$(CONFIG_COMMON_CLK_XGENE)         +=3D clk-xgene.o
> =20
> diff --git a/drivers/clk/clk-vco.c b/drivers/clk/clk-vco.c
> new file mode 100644
> index 0000000000000..f7fe2bc627f36
> --- /dev/null
> +++ b/drivers/clk/clk-vco.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Heiko Stuebner <heiko@sntech.de>
> + *
> + * Generic voltage controlled oscillator
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +struct clk_vco {
> +       struct device *dev;
> +       struct clk_hw hw;
> +       u32 rate;
> +       struct regulator *supply;
> +       struct gpio_desc *enable_gpio;
> +};
> +
> +#define to_clk_vco(_hw) container_of(_hw, struct clk_vco, hw)
> +
> +static int clk_vco_prepare(struct clk_hw *hw)
> +{
> +       return regulator_enable(to_clk_vco(hw)->supply);
> +}
> +
> +static void clk_vco_unprepare(struct clk_hw *hw)
> +{
> +       regulator_disable(to_clk_vco(hw)->supply);
> +}
> +
> +static int clk_vco_enable(struct clk_hw *hw)
> +{
> +       gpiod_set_value(to_clk_vco(hw)->enable_gpio, 1);
> +       return 0;
> +}
> +
> +static void clk_vco_disable(struct clk_hw *hw)
> +{
> +       gpiod_set_value(to_clk_vco(hw)->enable_gpio, 0);
> +}

It looks similar to clk-gpio.c code, but not as complete because it
assumes gpios can't sleep. Please look into reusing that code somehow,
possibly exporting 'clk_gpio_gate_ops' and struct clk_gpio for use in
this new driver. It would be good to fold the sleepable gpio bit as well
somehow, maybe with a new function to get a device's gpiod along with
returning a const pointer to the clk_ops that can be copied and amended
with the regulator part.

> +
> +static unsigned long clk_vco_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long parent_rate)
> +{
> +       return to_clk_vco(hw)->rate;
> +}
> +
> +const struct clk_ops clk_vco_ops =3D {
> +       .prepare =3D clk_vco_prepare,
> +       .unprepare =3D clk_vco_unprepare,
> +       .enable =3D clk_vco_enable,
> +       .disable =3D clk_vco_disable,
> +       .recalc_rate =3D clk_vco_recalc_rate,
> +};
> +
> +static int clk_vco_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct clk_vco *clkgen;
> +       const char *clk_name;
> +       int ret;
> +
> +       clkgen =3D devm_kzalloc(dev, sizeof(*clkgen), GFP_KERNEL);
> +       if (!clkgen)
> +               return -ENOMEM;
> +
> +       clkgen->dev =3D dev;

Is this used outside of probe? Why stash it?

> +
> +       if (device_property_read_u32(dev, "clock-frequency", &clkgen->rat=
e))
> +               return dev_err_probe(dev, -EIO, "failed to get clock-freq=
uency");
> +
> +       ret =3D device_property_read_string(dev, "clock-output-names", &c=
lk_name);
> +       if (ret)
> +               clk_name =3D fwnode_get_name(dev->fwnode);
> +
> +       clkgen->supply =3D devm_regulator_get_optional(dev, "vdd");
> +       if (IS_ERR(clkgen->supply)) {
> +               if (PTR_ERR(clkgen->supply) !=3D -ENODEV)
> +                       return dev_err_probe(dev, PTR_ERR(clkgen->supply),
> +                                            "failed to get regulator\n");
> +               clkgen->supply =3D NULL;
> +       }
> +
> +       clkgen->enable_gpio =3D devm_gpiod_get_optional(dev, "enable",
> +                                                     GPIOD_OUT_LOW);
> +       if (IS_ERR(clkgen->enable_gpio))
> +               return dev_err_probe(dev, PTR_ERR(clkgen->enable_gpio),
> +                                    "failed to get gpio\n");
> +
> +       ret =3D gpiod_direction_output(clkgen->enable_gpio, 0);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to set gpio output=
");

Missing newline.

> +
> +       clkgen->hw.init =3D CLK_HW_INIT_NO_PARENT(clk_name, &clk_vco_ops,=
 0);
> +
> +       /* register the clock */
> +       ret =3D devm_clk_hw_register(dev, &clkgen->hw);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to register clock\n");
> +

