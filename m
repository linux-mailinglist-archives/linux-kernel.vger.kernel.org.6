Return-Path: <linux-kernel+bounces-311104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D806B9684EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0568B1C22B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746F1D47A8;
	Mon,  2 Sep 2024 10:37:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA1183CA1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273439; cv=none; b=TsOQJBfi7JhtLFW/q3yDadvGGRkaUNSn2xJokiQpNg7rI4B8fY6Oo3iJNx7P/ADm2os6mtZ3W1uI123+il+jvlLCL65Wkri8/ZkdLDaHmIFmPYhY/gPsuR3/VTLH5a2qUOXtZbEy8feY4JS6cD3MIAU1uho4+GP1nsdU/v40qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273439; c=relaxed/simple;
	bh=qqv56s6IX8QGAjFA2+kbILVTQRUpx+pk+b8vNmFiMn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFgdHu+PfiJau66FudWEZyvIdoh0Kfz87o9tjqMAfGyx18RdmkYbi6uyynd+zPLq+aK60aMeg2UunXNvapDkOYoOnKJ3LXCGiLp87l/LZrbEVShxUPJ70ruYrKjczf8FujRK+7D6WQNPEI/gLKpNM9J5nftwAmHUHyhmwgqlTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4Qo-0001vg-Lr; Mon, 02 Sep 2024 12:37:10 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4Qo-004smB-6C; Mon, 02 Sep 2024 12:37:10 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4Qo-000hQ3-0O;
	Mon, 02 Sep 2024 12:37:10 +0200
Message-ID: <8b15609fc6aa00b6bdf38234ccb0beb34e5a428b.camel@pengutronix.de>
Subject: Re: [PATCH v3 8/9] reset: amlogic: split the device core and
 platform probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org
Date: Mon, 02 Sep 2024 12:37:10 +0200
In-Reply-To: <20240808102742.4095904-9-jbrunet@baylibre.com>
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
	 <20240808102742.4095904-9-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-08-08 at 12:27 +0200, Jerome Brunet wrote:
> To prepare the addition of the auxiliary device support, split
> out the device core function from the probe of the platform device.
>=20
> The device core function will be common to both the platform and auxiliar=
y
> driver.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/amlogic/Kconfig                 |  10 +-
>  drivers/reset/amlogic/Makefile                |   3 +-
>  .../{reset-meson.c =3D> reset-meson-core.c}     | 101 +++---------------
>  drivers/reset/amlogic/reset-meson-pltf.c      |  92 ++++++++++++++++
>  drivers/reset/amlogic/reset-meson.h           |  24 +++++
>  5 files changed, 143 insertions(+), 87 deletions(-)
>  rename drivers/reset/amlogic/{reset-meson.c =3D> reset-meson-core.c} (51=
%)
>  create mode 100644 drivers/reset/amlogic/reset-meson-pltf.c
>  create mode 100644 drivers/reset/amlogic/reset-meson.h
>=20
> diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfi=
g
> index 7ed9cf50f038..04c7be0f3165 100644
> --- a/drivers/reset/amlogic/Kconfig
> +++ b/drivers/reset/amlogic/Kconfig
> @@ -1,9 +1,15 @@
> +config RESET_MESON_CORE
> +	tristate
> +	select REGMAP
> +
>  config RESET_MESON
> -	tristate "Meson Reset Driver"
> +	tristate "Meson Reset Platform Driver"

I think this change is unnecessary.

>  	depends on ARCH_MESON || COMPILE_TEST
>  	default ARCH_MESON
> +	select REGMAP_MMIO
> +	select RESET_MESON_CORE
>  	help
> -	  This enables the reset driver for Amlogic Meson SoCs.
> +	  This enables the reset platform driver for Amlogic SoCs.

and this as well.

> =20
>  config RESET_MESON_AUDIO_ARB
>  	tristate "Meson Audio Memory Arbiter Reset Driver"
> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makef=
ile
> index 55509fc78513..0f8f9121b566 100644
> --- a/drivers/reset/amlogic/Makefile
> +++ b/drivers/reset/amlogic/Makefile
> @@ -1,2 +1,3 @@
> -obj-$(CONFIG_RESET_MESON) +=3D reset-meson.o
> +obj-$(CONFIG_RESET_MESON) +=3D reset-meson-pltf.o
> +obj-$(CONFIG_RESET_MESON_CORE) +=3D reset-meson-core.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) +=3D reset-meson-audio-arb.o
> diff --git a/drivers/reset/amlogic/reset-meson.c b/drivers/reset/amlogic/=
reset-meson-core.c
> similarity index 51%
> rename from drivers/reset/amlogic/reset-meson.c
> rename to drivers/reset/amlogic/reset-meson-core.c
> index b16d9c32adb1..ea4fc562f7e6 100644
> --- a/drivers/reset/amlogic/reset-meson.c
> +++ b/drivers/reset/amlogic/reset-meson-core.c
> @@ -1,27 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  /*
> - * Amlogic Meson Reset Controller driver
> + * Amlogic Meson Reset core functions
>   *
> - * Copyright (c) 2016 BayLibre, SAS.
> - * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (c) 2024 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>   */
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/of.h>
> +
> +#include <linux/device.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
> -
> -struct meson_reset_param {
> -	unsigned int reset_num;
> -	unsigned int reset_offset;
> -	unsigned int level_offset;
> -	bool level_low_reset;
> -};
> +
> +#include "reset-meson.h"
> =20
>  struct meson_reset {
>  	const struct meson_reset_param *param;
> @@ -102,84 +92,27 @@ static const struct reset_control_ops meson_reset_op=
s =3D {
>  	.status		=3D meson_reset_status,
>  };
> =20
> -static const struct meson_reset_param meson8b_param =3D {
> -	.reset_num	=3D 256,
> -	.reset_offset	=3D 0x0,
> -	.level_offset	=3D 0x7c,
> -	.level_low_reset =3D true,
> -};
> -
> -static const struct meson_reset_param meson_a1_param =3D {
> -	.reset_num	=3D 96,
> -	.reset_offset	=3D 0x0,
> -	.level_offset	=3D 0x40,
> -	.level_low_reset =3D true,
> -};
> -
> -static const struct meson_reset_param meson_s4_param =3D {
> -	.reset_num	=3D 192,
> -	.reset_offset	=3D 0x0,
> -	.level_offset	=3D 0x40,
> -	.level_low_reset =3D true,
> -};
> -
> -static const struct of_device_id meson_reset_dt_ids[] =3D {
> -	 { .compatible =3D "amlogic,meson8b-reset",    .data =3D &meson8b_param=
},
> -	 { .compatible =3D "amlogic,meson-gxbb-reset", .data =3D &meson8b_param=
},
> -	 { .compatible =3D "amlogic,meson-axg-reset",  .data =3D &meson8b_param=
},
> -	 { .compatible =3D "amlogic,meson-a1-reset",   .data =3D &meson_a1_para=
m},
> -	 { .compatible =3D "amlogic,meson-s4-reset",   .data =3D &meson_s4_para=
m},
> -	 { .compatible =3D "amlogic,c3-reset",   .data =3D &meson_s4_param},
> -	 { /* sentinel */ },
> -};
> -MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
> -
> -static const struct regmap_config regmap_config =3D {
> -	.reg_bits   =3D 32,
> -	.val_bits   =3D 32,
> -	.reg_stride =3D 4,
> -};
> -
> -static int meson_reset_probe(struct platform_device *pdev)
> +int meson_reset_probe(struct device *dev, struct regmap *map,
> +		      const struct meson_reset_param *param)

I'd rename this to something other than *_probe, as this is not a
complete probe function to be used as a .probe callback anymore.
meson_reset_probe_common() or meson_reset_controller_register(), maybe?

>  {
> -	struct device *dev =3D &pdev->dev;
>  	struct meson_reset *data;
> -	void __iomem *base;
> =20
>  	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> =20
> -	base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> -
> -	data->param =3D device_get_match_data(dev);
> -	if (!data->param)
> -		return -ENODEV;
> -
> -	data->map =3D devm_regmap_init_mmio(dev, base, &regmap_config);
> -	if (IS_ERR(data->map))
> -		return dev_err_probe(dev, PTR_ERR(data->map),
> -				     "can't init regmap mmio region\n");
> -
> -	data->rcdev.owner =3D THIS_MODULE;
> -	data->rcdev.nr_resets =3D data->param->reset_num;
> +	data->param =3D param;
> +	data->map =3D map;
> +	data->rcdev.owner =3D dev->driver->owner;
> +	data->rcdev.nr_resets =3D param->reset_num;
>  	data->rcdev.ops =3D &meson_reset_ops;
>  	data->rcdev.of_node =3D dev->of_node;
> =20
>  	return devm_reset_controller_register(dev, &data->rcdev);
>  }
> +EXPORT_SYMBOL_NS_GPL(meson_reset_probe, MESON_RESET);
> =20
> -static struct platform_driver meson_reset_driver =3D {
> -	.probe	=3D meson_reset_probe,
> -	.driver =3D {
> -		.name		=3D "meson_reset",
> -		.of_match_table	=3D meson_reset_dt_ids,
> -	},
> -};
> -module_platform_driver(meson_reset_driver);
> -
> -MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
> +MODULE_DESCRIPTION("Amlogic Meson Reset Core function");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> -MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_IMPORT_NS(MESON_RESET);
> diff --git a/drivers/reset/amlogic/reset-meson-pltf.c b/drivers/reset/aml=
ogic/reset-meson-pltf.c
> new file mode 100644
> index 000000000000..97e933b4aa34
> --- /dev/null
> +++ b/drivers/reset/amlogic/reset-meson-pltf.c

I'd keep the reset-meson.c name for this file.

> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Amlogic Meson Reset platform driver

I thought "Amlogic Meson Reset Controller driver" was pretty
descriptive. Let's keep that.

> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include "reset-meson.h"
> +
> +static const struct meson_reset_param meson8b_param =3D {
> +	.reset_num	=3D 256,
> +	.reset_offset	=3D 0x0,
> +	.level_offset	=3D 0x7c,
> +	.level_low_reset =3D true,
> +};
> +
> +static const struct meson_reset_param meson_a1_param =3D {
> +	.reset_num	=3D 96,
> +	.reset_offset	=3D 0x0,
> +	.level_offset	=3D 0x40,
> +	.level_low_reset =3D true,
> +};
> +
> +static const struct meson_reset_param meson_s4_param =3D {
> +	.reset_num	=3D 192,
> +	.reset_offset	=3D 0x0,
> +	.level_offset	=3D 0x40,
> +	.level_low_reset =3D true,
> +};
> +
> +static const struct of_device_id meson_reset_dt_ids[] =3D {
> +	 { .compatible =3D "amlogic,meson8b-reset",    .data =3D &meson8b_param=
},
> +	 { .compatible =3D "amlogic,meson-gxbb-reset", .data =3D &meson8b_param=
},
> +	 { .compatible =3D "amlogic,meson-axg-reset",  .data =3D &meson8b_param=
},
> +	 { .compatible =3D "amlogic,meson-a1-reset",   .data =3D &meson_a1_para=
m},
> +	 { .compatible =3D "amlogic,meson-s4-reset",   .data =3D &meson_s4_para=
m},
> +	 { .compatible =3D "amlogic,c3-reset",   .data =3D &meson_s4_param},
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
> +
> +static const struct regmap_config regmap_config =3D {
> +	.reg_bits   =3D 32,
> +	.val_bits   =3D 32,
> +	.reg_stride =3D 4,
> +};
> +
> +static int meson_reset_pltf_probe(struct platform_device *pdev)

s/pltf_//

> +{
> +	const struct meson_reset_param *param;
> +	struct device *dev =3D &pdev->dev;
> +	struct regmap *map;
> +	void __iomem *base;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	param =3D device_get_match_data(dev);
> +	if (!param)
> +		return -ENODEV;
> +
> +	map =3D devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "can't init regmap mmio region\n");
> +
> +	return meson_reset_probe(dev, map, param);
> +}
> +
> +static struct platform_driver meson_reset_pltf_driver =3D {

s/pltf_//

> +	.probe	=3D meson_reset_pltf_probe,

s/pltf_//

> +	.driver =3D {
> +		.name		=3D "meson_reset",
> +		.of_match_table	=3D meson_reset_dt_ids,
> +	},
> +};
> +module_platform_driver(meson_reset_pltf_driver);

s/pltf_//

> +
> +MODULE_DESCRIPTION("Amlogic Meson Reset Platform Controller driver");

s/Platform //

> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS(MESON_RESET);
> diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/=
reset-meson.h
> new file mode 100644
> index 000000000000..c2e8a5cf2e46
> --- /dev/null
> +++ b/drivers/reset/amlogic/reset-meson.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Copyright (c) 2024 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#ifndef __MESON_RESET_CORE_H
> +#define __MESON_RESET_CORE_H
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +struct meson_reset_param {
> +	unsigned int reset_num;
> +	unsigned int reset_offset;
> +	unsigned int level_offset;
> +	bool level_low_reset;
> +};
> +
> +int meson_reset_probe(struct device *dev, struct regmap *map,
> +		      const struct meson_reset_param *param);
> +
> +#endif /* __MESON_RESET_CORE_H */

regards
Philipp

