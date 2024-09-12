Return-Path: <linux-kernel+bounces-326161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F99976417
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A57286661
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84618FDD8;
	Thu, 12 Sep 2024 08:12:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBC3D7A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128744; cv=none; b=QSE0lPq6u+fiCa7YgTSE97mNswL3aWE47cgtEd/DEpl9WjZLFN4Bz6E/8Rk+MfH7EUX9wo1Dvnz6heCDAxppRl2zgimTFUoxDkPAnGQUklSjv4T+P85KWqsPNeo+sKAfc6a8HSQ/3HuwmLnbvCidUdLpHe5o64EyVV3O5RGejqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128744; c=relaxed/simple;
	bh=rx1lZjrrsnfE5l4zFYKgvKdwyMy72fvPFpZ2aEATKns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ufzny9vF6KT8Cnh3zrX9HtTm7kokdf94afkFo7Il1xB1zGQzEcvggQpDVjCW0FgjmauUygK9Gd1v/OMYsX8cKw9fjH7suYmNZZdfyAyXXo43o+fWXmeN2ne7LjdgGFQocay2tNK/1JPNkovALh5wzG57RMh00DRDUKFoU8+Vnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soew3-0006lH-8Z; Thu, 12 Sep 2024 10:12:15 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soew2-007Kw5-Hn; Thu, 12 Sep 2024 10:12:14 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soew2-0002SF-1X;
	Thu, 12 Sep 2024 10:12:14 +0200
Message-ID: <8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
Subject: Re: [PATCH v5 8/9] reset: amlogic: split the device core and
 platform probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 10:12:14 +0200
In-Reply-To: <20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
	 <20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
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

On Di, 2024-09-10 at 18:32 +0200, Jerome Brunet wrote:
> To prepare the addition of the auxiliary device support, split
> out the device coomon functions from the probe of the platform device.
>=20
> The device core function will be common to both the platform and auxiliar=
y
> driver.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/amlogic/Kconfig              |   7 +-
>  drivers/reset/amlogic/Makefile             |   1 +
>  drivers/reset/amlogic/reset-meson-common.c | 121 +++++++++++++++++++++++=
+++++
>  drivers/reset/amlogic/reset-meson.c        | 122 ++++-------------------=
------
>  drivers/reset/amlogic/reset-meson.h        |  24 ++++++
>  5 files changed, 167 insertions(+), 108 deletions(-)
>=20
> diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfi=
g
> index 532e6a4f7865..1d77987088f4 100644
> --- a/drivers/reset/amlogic/Kconfig
> +++ b/drivers/reset/amlogic/Kconfig
> @@ -1,10 +1,15 @@
> +config RESET_MESON_COMMON
> +	tristate
> +	select REGMAP
> +
>  config RESET_MESON
>  	tristate "Meson Reset Driver"
>  	depends on ARCH_MESON || COMPILE_TEST
>  	default ARCH_MESON
>  	select REGMAP_MMIO
> +	select RESET_MESON_COMMON
>  	help
> -	  This enables the reset driver for Amlogic Meson SoCs.
> +	  This enables the reset driver for Amlogic SoCs.
> =20
>  config RESET_MESON_AUDIO_ARB
>  	tristate "Meson Audio Memory Arbiter Reset Driver"
> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makef=
ile
> index 55509fc78513..74aaa2fb5e13 100644
> --- a/drivers/reset/amlogic/Makefile
> +++ b/drivers/reset/amlogic/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_RESET_MESON) +=3D reset-meson.o
> +obj-$(CONFIG_RESET_MESON_COMMON) +=3D reset-meson-common.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) +=3D reset-meson-audio-arb.o
> diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/reset/a=
mlogic/reset-meson-common.c
> new file mode 100644
> index 000000000000..d57544801ae9
> --- /dev/null
> +++ b/drivers/reset/amlogic/reset-meson-common.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Amlogic Meson Reset core functions
> + *
> + * Copyright (c) 2016-2024 BayLibre, SAS.
> + * Authors: Neil Armstrong <narmstrong@baylibre.com>
> + *          Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include "reset-meson.h"
> +
> +struct meson_reset {
> +	const struct meson_reset_param *param;
> +	struct reset_controller_dev rcdev;
> +	struct regmap *map;
> +};
> +
> +static void meson_reset_offset_and_bit(struct meson_reset *data,
> +				       unsigned long id,
> +				       unsigned int *offset,
> +				       unsigned int *bit)
> +{
> +	unsigned int stride =3D regmap_get_reg_stride(data->map);
> +
> +	*offset =3D (id / (stride * BITS_PER_BYTE)) * stride;
> +	*bit =3D id % (stride * BITS_PER_BYTE);
> +}
> +
> +static int meson_reset_reset(struct reset_controller_dev *rcdev,
> +			     unsigned long id)

checkpatch --strict complains about the alignment here.
I'll fix this up when applying, no need to resend.

regards
Philipp

