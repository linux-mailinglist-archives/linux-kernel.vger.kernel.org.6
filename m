Return-Path: <linux-kernel+bounces-248349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1192DBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422961C23A37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CB14A633;
	Wed, 10 Jul 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn0PZ35X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A753848E;
	Wed, 10 Jul 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651110; cv=none; b=GMmVUEgsZuwehZ1aXcLTwXYnO6iGKLBTcitpwOLu7LlWna6nUC85YgC4YDrQv18OJ51fcrt0sjTDkVqLeiGACevP/+x9zrKMZ4PRomh9Usrm9QQ3FD+SS/eKpHzUv1W6h860l5tJxrjyHpuGPajJie9xp+94S+iIjLrEwgDOwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651110; c=relaxed/simple;
	bh=Vt0wIR0866O2uh3dKPQRIDeiue0Wwto6R+OX4aFCPX0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fidPHkbjsH+/16Fsm6gJs5rnJp+EIAXLDN7p1rYXsb04O4GERKvi6cZfur00fP9G+0qwqwMT9DGK7setQpKyD0MSCu2lcfB7wexolcQ1grUzzsZa4fFGHHNbh5oYpZKFoKvgFZn/qtfLuBuhgky12VMhdSv2Ejy+Sh9G9e0Kx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn0PZ35X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA0DC32781;
	Wed, 10 Jul 2024 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720651109;
	bh=Vt0wIR0866O2uh3dKPQRIDeiue0Wwto6R+OX4aFCPX0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Xn0PZ35X3M19tLT9SsacAdNowfrkZtKkomjX+abFBgGyT42Vg+Lv1+p4Iw7JjMvO8
	 gqI8LtP0F1oyanIYu7QSszTciIxTB86CdLC3nxglZJSQjes3HaRpNKGiXPwWVazCmN
	 hBVeC8ogiUNW34dkbMkevXEfx9Dwg47yf8M9J9rVRTpiaX4/NYTCl2TbHF4mmuBosW
	 1jljNEgRZFywMOCwK6AUNvg0aod0w4U2ym706IZyqybrzhbY5XIk/XsCK/NkDG8ET0
	 NnoOD375rRWqRsVERre7UebEKd0Wa3ag3gZLA5xqBA42/Dt3Iw6bkAHWKAwJOwPNRu
	 2oFKCl1E4N7YQ==
Message-ID: <e670d28f96466654cbba155794650f65.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710162526.2341399-4-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com> <20240710162526.2341399-4-jbrunet@baylibre.com>
Subject: Re: [PATCH 3/8] reset: amlogic: split the device and platform probe
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 10 Jul 2024 15:38:26 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-07-10 09:25:12)
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 59126c9f194a..fec55321b52b 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -87,6 +87,27 @@ static const struct reset_control_ops meson_reset_ops =
=3D {
>         .deassert       =3D meson_reset_deassert,
>  };
> =20
> +static int meson_reset_probe(struct device *dev, struct regmap *map,
> +                            const struct meson_reset_param *param)
> +{
> +       unsigned int stride =3D regmap_get_reg_stride(map);
> +       struct meson_reset *data;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->param =3D param;
> +       data->map =3D map;
> +       data->rcdev.owner =3D dev->driver->owner;
> +       data->rcdev.nr_resets =3D param->reg_count * BITS_PER_BYTE
> +               * stride;

Nitpick: I'd just put this on the line above

> +       data->rcdev.ops =3D &meson_reset_ops;
> +       data->rcdev.of_node =3D dev->of_node;
> +
> +       return devm_reset_controller_register(dev, &data->rcdev);
> +}
> +
>  static const struct meson_reset_param meson8b_param =3D {
>         .reg_count      =3D 8,
>         .reset_offset   =3D 0x0,
> @@ -125,46 +146,38 @@ static const struct regmap_config regmap_config =3D=
 {
>         .reg_stride =3D 4,
>  };
> =20
> -static int meson_reset_probe(struct platform_device *pdev)
> +static int meson_reset_pltf_probe(struct platform_device *pdev)
>  {
> +
> +       const struct meson_reset_param *param;
>         struct device *dev =3D &pdev->dev;
> -       struct meson_reset *data;
> +       struct regmap *map;
>         void __iomem *base;
> =20
> -       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -       if (!data)
> -               return -ENOMEM;
> -
>         base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> =20
> -       data->param =3D of_device_get_match_data(dev);
> -       if (!data->param)
> +       param =3D of_device_get_match_data(dev);

Just use device_get_match_data()? I don't see any need to use DT
specific APIs.

> +       if (!param)
>                 return -ENODEV;
> =20
> -       data->map =3D devm_regmap_init_mmio(dev, base, &regmap_config);
> -       if (IS_ERR(data->map))
> -               return dev_err_probe(dev, PTR_ERR(data->map),
> +       map =3D devm_regmap_init_mmio(dev, base, &regmap_config);
> +       if (IS_ERR(map))
> +               return dev_err_probe(dev, PTR_ERR(map),
>                                      "can't init regmap mmio region\n");
>

