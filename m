Return-Path: <linux-kernel+bounces-224479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB599122E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D82B22071
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C98172798;
	Fri, 21 Jun 2024 10:59:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFD171E7D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967578; cv=none; b=Pr9xx1WHP2hmnenCch6l5cM/jXnXk40gDGHkz+6c1D5Zv8XtpJsC3aqAh/SM8YRT3+N/Di3QFMj0FECsAurs5dQNRsybftdbpRBi/Bstz+4DQKDTLTTpAg4BwCB6FLoMoopsGxpoinn8ZX4WDSotCampcAFmdPC3WJ4eCcuHsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967578; c=relaxed/simple;
	bh=BL/ludkngyLoSQa2pwczoj2NPQmhYvrmLQnBYskP7Aw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+d/GNaUenXf8+hqrUEKQZDA74QJE5yL6FjwSC1UwVv8gY1r6yPrWaUYJjaqZjRnYYKnTGoWsrLZ9Dct/XAbncBDIImU0P3AengYzKVx3mlIdknaFy26Fg8YML2ZX/mLLFWGEFxF1RizEb/mC+gpS2UVroUbdZeDBLejBvdkL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKbz8-00044c-Va; Fri, 21 Jun 2024 12:59:14 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKbz8-003vGX-1Y; Fri, 21 Jun 2024 12:59:14 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKbz7-0007n2-36;
	Fri, 21 Jun 2024 12:59:13 +0200
Message-ID: <27ea1bf7de6f349426fcd7ddb056a1adfae47c73.camel@pengutronix.de>
Subject: Re: [PATCH v8 3/5] reset: imx8mp-audiomix: Add AudioMix Block
 Control reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, 
 peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org,  krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org,  s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, marex@denx.de,  linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 shengjiu.wang@gmail.com
Date: Fri, 21 Jun 2024 12:59:13 +0200
In-Reply-To: <1718350923-21392-4-git-send-email-shengjiu.wang@nxp.com>
References: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
	 <1718350923-21392-4-git-send-email-shengjiu.wang@nxp.com>
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

Hi,

On Fr, 2024-06-14 at 15:42 +0800, Shengjiu Wang wrote:
> Add support for the resets on i.MX8MP Audio Block Control module,
> which includes the EARC PHY software reset and EARC controller
> software reset. The reset controller is created using the auxiliary
> device framework and set up in the clock driver.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/reset/Kconfig                 |   8 ++
>  drivers/reset/Makefile                |   1 +
>  drivers/reset/reset-imx8mp-audiomix.c | 106 ++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/reset/reset-imx8mp-audiomix.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..b3c0e528d08c 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -91,6 +91,14 @@ config RESET_IMX7
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
> =20
> +config RESET_IMX8MP_AUDIOMIX
> +	tristate "i.MX8MP AudioMix Reset Driver"
> +	depends on CLK_IMX8MP

I'd like this to be made compile-testable without CLK_IMX8MP being
enabled.

> +	select AUXILIARY_BUS
> +	default CLK_IMX8MP
> +	help
> +	  This enables the reset controller driver for i.MX8MP AudioMix
> +
>  config RESET_INTEL_GW
>  	bool "Intel Reset Controller Driver"
>  	depends on X86 || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..a6796e83900b 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) +=3D reset-brcmstb-r=
escal.o
>  obj-$(CONFIG_RESET_GPIO) +=3D reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) +=3D reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) +=3D reset-imx7.o
> +obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) +=3D reset-imx8mp-audiomix.o
>  obj-$(CONFIG_RESET_INTEL_GW) +=3D reset-intel-gw.o
>  obj-$(CONFIG_RESET_K210) +=3D reset-k210.o
>  obj-$(CONFIG_RESET_LANTIQ) +=3D reset-lantiq.o
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-=
imx8mp-audiomix.c
> new file mode 100644
> index 000000000000..1fc984bc08c0
> --- /dev/null
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>

Still needed?

> +#include <linux/reset-controller.h>
> +
> +#define EARC			0x200
> +#define EARC_RESET_MASK		0x3
> +
> +struct imx8mp_audiomix_reset {
> +	struct reset_controller_dev rcdev;
> +	void __iomem *base;
> +};
> +
> +static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct res=
et_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct imx8mp_audiomix_reset, rcdev);
> +}
> +
> +static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcd=
ev,
> +					unsigned long id)
> +{
> +	struct imx8mp_audiomix_reset *priv =3D to_imx8mp_audiomix_reset(rcdev);
> +	void __iomem *reg_addr =3D priv->base;
> +	unsigned int mask, reg;
> +
> +	if (id >=3D fls(EARC_RESET_MASK))
> +		return -EINVAL;

This check is not required.

Since you have nr_resets set to fls(EARC_RESET_MASK), the same is
already checked in of_reset_simple_xlate, before a reset control is
even returned.

> +	mask =3D BIT(id);
> +	reg =3D readl(reg_addr + EARC);
> +	writel(reg & ~mask, reg_addr + EARC);

There are multiple (well, two) resets in this register, so it would be
good style to protect the read-modify-write cycle with a spinlock.

> +
> +	return 0;
> +}
> +
> +static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *r=
cdev,
> +					  unsigned long id)
> +{
> +	struct imx8mp_audiomix_reset *priv =3D to_imx8mp_audiomix_reset(rcdev);
> +	void __iomem *reg_addr =3D priv->base;
> +	unsigned int mask, reg;
> +
> +	if (id >=3D fls(EARC_RESET_MASK))
> +		return -EINVAL;
> +
> +	mask =3D BIT(id);
> +	reg =3D readl(reg_addr + EARC);
> +	writel(reg | mask, reg_addr + EARC);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops imx8mp_audiomix_reset_ops =3D {
> +	.assert   =3D imx8mp_audiomix_reset_assert,
> +	.deassert =3D imx8mp_audiomix_reset_deassert,
> +};
> +
> +static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> +				       const struct auxiliary_device_id *id)
> +{
> +	struct imx8mp_audiomix_reset *priv;
> +	struct device *dev =3D &adev->dev;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->rcdev.owner     =3D THIS_MODULE;
> +	priv->rcdev.nr_resets =3D fls(EARC_RESET_MASK);
> +	priv->rcdev.ops       =3D &imx8mp_audiomix_reset_ops;
> +	priv->rcdev.of_node   =3D dev->parent->of_node;
> +	priv->rcdev.dev	      =3D dev;
> +	priv->rcdev.of_reset_n_cells =3D 1;
> +	priv->base            =3D of_iomap(dev->parent->of_node, 0);

This is missing the corresponding iounmap().

I wonder why we map at all. If the parent driver already has iomem
mapped, can't it just pass that in, like JH7110 does?


regards
Philipp

