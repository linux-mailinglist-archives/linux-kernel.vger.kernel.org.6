Return-Path: <linux-kernel+bounces-195137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3668D4817
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EC8B26757
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09199183973;
	Thu, 30 May 2024 09:06:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED9183972
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059980; cv=none; b=od4mkZ3f1e58zxF/PlYXYUQuLYX/WHukmUiEZCe0R+wqAVQI+NQN5I3TOUETd9K3+u5XxVtAgAl8lcK6sYrrPcDNZ+bUzGuYZ/2CDNzam7a/CRWQKNbFwpill01EGBuaYBMmHH7zp3lGoUQZJiCcuxIbFbE3DRMwX4UZUlGfs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059980; c=relaxed/simple;
	bh=j879v3knqvytxXz7DWl2Ufn9Fu7PF9YwKCUZ0eX9xBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/Oa75yQaln/oc6zOJasm8ljvT0ZP2nPm6uiTMxDejGgXzUiaxsO7KedKzuv+FGdYu6MLNNhAMv5HwZLIyX39NoPwYDqsJ9Xesa6fp9+Nm6FZvWRx8COmo/3k81nTN4na2J/Xu8rQFaEd7gbRelLVezGcTVTk+mAeSDp1KBx82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sCbjS-0000lO-Kl; Thu, 30 May 2024 11:05:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sCbjS-003ZoP-5V; Thu, 30 May 2024 11:05:58 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sCbjS-0003T0-0D;
	Thu, 30 May 2024 11:05:58 +0200
Date: Thu, 30 May 2024 11:05:58 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: p.zabel@pengutronix.de, abelvesa@kernel.org, peng.fan@nxp.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v6 3/5] reset: imx-aux: Add i.MX auxiliary reset driver
Message-ID: <20240530090558.53reobf2zea22oi2@pengutronix.de>
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
 <1717036278-3515-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717036278-3515-4-git-send-email-shengjiu.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 24-05-30, Shengjiu Wang wrote:
> Add support for the resets on i.MX8MP Audio Block Control module,
> which includes the EARC PHY software reset and EARC controller
> software reset. The reset controller is created using the auxiliary
> device framework and set up in the clock driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/reset/Kconfig         |   8 ++
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-imx-aux.c | 217 ++++++++++++++++++++++++++++++++++
			    ^
You make use of the auxiliary bus but this isn't a aux driver, it's the
i.MX8MP EARC reset driver. According the TRM only the EARC reset bits
are covered by the AUDIOMIX blk-ctrl.

>  3 files changed, 226 insertions(+)
>  create mode 100644 drivers/reset/reset-imx-aux.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..38fdf05b326b 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -91,6 +91,14 @@ config RESET_IMX7
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
>  
> +config RESET_IMX_AUX
> +	tristate "i.MX Auxiliary Reset Driver"
			^
              Same applies here

> +	depends on CLK_IMX8MP
> +	select AUXILIARY_BUS
> +	default CLK_IMX8MP
> +	help
> +	  This enables the auxiliary reset controller driver for i.MX.
> +
>  config RESET_INTEL_GW
>  	bool "Intel Reset Controller Driver"
>  	depends on X86 || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..f078da14c327 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
>  obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> +obj-$(CONFIG_RESET_IMX_AUX) += reset-imx-aux.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>  obj-$(CONFIG_RESET_K210) += reset-k210.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> diff --git a/drivers/reset/reset-imx-aux.c b/drivers/reset/reset-imx-aux.c
> new file mode 100644
> index 000000000000..61c353abc84e
> --- /dev/null
> +++ b/drivers/reset/reset-imx-aux.c
> @@ -0,0 +1,217 @@
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
> +#include <linux/reset-controller.h>
> +
> +/*
> + * The reset does not support the feature and corresponding
> + * values are not valid
> + */
> +#define ASSERT_NONE     BIT(0)
> +#define DEASSERT_NONE   BIT(1)
> +#define STATUS_NONE     BIT(2)
> +
> +/* When set this function is activated by setting(vs clearing) this bit */
> +#define ASSERT_SET      BIT(3)
> +#define DEASSERT_SET    BIT(4)
> +#define STATUS_SET      BIT(5)
> +
> +/* The following are the inverse of the above and are added for consistency */
> +#define ASSERT_CLEAR    (0 << 3)
> +#define DEASSERT_CLEAR  (0 << 4)
> +#define STATUS_CLEAR    (0 << 5)
> +
> +/**
> + * struct imx_reset_ctrl - reset control structure
> + * @assert_offset: reset assert control register offset
> + * @assert_bit: reset assert bit in the reset assert control register
> + * @deassert_offset: reset deassert control register offset
> + * @deassert_bit: reset deassert bit in the reset deassert control register
> + * @status_offset: reset status register offset
> + * @status_bit: reset status bit in the reset status register
> + * @flags: reset flag indicating how the (de)assert and status are handled
> + */
> +struct imx_reset_ctrl {
> +	u32 assert_offset;
> +	u32 assert_bit;
> +	u32 deassert_offset;
> +	u32 deassert_bit;
> +	u32 status_offset;
> +	u32 status_bit;
> +	u32 flags;
> +};

Why do we make it this compicated for an simple EARC module reset? I
understand that you want to provide a generic driver which can be
re-used but there is actual no other user and may will get no other user
in the future too. Therefore I would like to keep it simple at the
begin and adapt the code on-demand.

Regards,
  Marco

> +struct imx_reset_data {
> +	const struct imx_reset_ctrl *rst_ctrl;
> +	size_t rst_ctrl_num;
> +};
> +
> +struct imx_aux_reset_priv {
> +	struct reset_controller_dev rcdev;
> +	void __iomem *base;
> +	const struct imx_reset_data *data;
> +};
> +
> +static int imx_aux_reset_assert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> +					struct imx_aux_reset_priv, rcdev);
> +	const struct imx_reset_data *data = priv->data;
> +	void __iomem *reg_addr = priv->base;
> +	const struct imx_reset_ctrl *ctrl;
> +	unsigned int mask, value, reg;
> +
> +	if (id >= data->rst_ctrl_num)
> +		return -EINVAL;
> +
> +	ctrl = &data->rst_ctrl[id];
> +
> +	/* assert not supported for this reset */
> +	if (ctrl->flags & ASSERT_NONE)
> +		return -EOPNOTSUPP;
> +
> +	mask = BIT(ctrl->assert_bit);
> +	value = (ctrl->flags & ASSERT_SET) ? mask : 0x0;
> +
> +	reg = readl(reg_addr + ctrl->assert_offset);
> +	writel(reg | value, reg_addr + ctrl->assert_offset);
> +
> +	return 0;
> +}
> +
> +static int imx_aux_reset_deassert(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> +					struct imx_aux_reset_priv, rcdev);
> +	const struct imx_reset_data *data = priv->data;
> +	void __iomem *reg_addr = priv->base;
> +	const struct imx_reset_ctrl *ctrl;
> +	unsigned int mask, value, reg;
> +
> +	if (id >= data->rst_ctrl_num)
> +		return -EINVAL;
> +
> +	ctrl = &data->rst_ctrl[id];
> +
> +	/* deassert not supported for this reset */
> +	if (ctrl->flags & DEASSERT_NONE)
> +		return -EOPNOTSUPP;
> +
> +	mask = BIT(ctrl->deassert_bit);
> +	value = (ctrl->flags & DEASSERT_SET) ? mask : 0x0;
> +
> +	reg = readl(reg_addr + ctrl->deassert_offset);
> +	writel(reg | value, reg_addr + ctrl->deassert_offset);
> +
> +	return 0;
> +}
> +
> +static int imx_aux_reset_status(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> +					struct imx_aux_reset_priv, rcdev);
> +	const struct imx_reset_data *data = priv->data;
> +	void __iomem *reg_addr = priv->base;
> +	const struct imx_reset_ctrl *ctrl;
> +	unsigned int reset_state;
> +
> +	if (id >= data->rst_ctrl_num)
> +		return -EINVAL;
> +
> +	ctrl = &data->rst_ctrl[id];
> +
> +	/* status not supported for this reset */
> +	if (ctrl->flags & STATUS_NONE)
> +		return -EOPNOTSUPP;
> +
> +	reset_state = readl(reg_addr + ctrl->status_offset);
> +
> +	return !(reset_state & BIT(ctrl->status_bit)) ==
> +		!(ctrl->flags & STATUS_SET);
> +}
> +
> +static const struct reset_control_ops imx_aux_reset_ops = {
> +	.assert   = imx_aux_reset_assert,
> +	.deassert = imx_aux_reset_deassert,
> +	.status	  = imx_aux_reset_status,
> +};
> +
> +static int imx_aux_reset_probe(struct auxiliary_device *adev,
> +			       const struct auxiliary_device_id *id)
> +{
> +	struct imx_reset_data *data = (struct imx_reset_data *)(id->driver_data);
> +	struct imx_aux_reset_priv *priv;
> +	struct device *dev = &adev->dev;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->rcdev.owner     = THIS_MODULE;
> +	priv->rcdev.nr_resets = data->rst_ctrl_num;
> +	priv->rcdev.ops       = &imx_aux_reset_ops;
> +	priv->rcdev.of_node   = dev->parent->of_node;
> +	priv->rcdev.dev	      = dev;
> +	priv->rcdev.of_reset_n_cells = 1;
> +	priv->base            = of_iomap(dev->parent->of_node, 0);
> +	priv->data            = data;
> +
> +	return devm_reset_controller_register(dev, &priv->rcdev);
> +}
> +
> +#define EARC  0x200
> +
> +static const struct imx_reset_ctrl imx8mp_audiomix_rst_ctrl[] = {
> +	{
> +		.assert_offset = EARC,
> +		.assert_bit = 0,
> +		.deassert_offset = EARC,
> +		.deassert_bit = 0,
> +		.flags  = ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE,
> +	},
> +	{
> +		.assert_offset = EARC,
> +		.assert_bit = 1,
> +		.deassert_offset = EARC,
> +		.deassert_bit = 1,
> +		.flags  = ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE,
> +	},
> +};
> +
> +static const struct imx_reset_data imx8mp_audiomix_rst_data = {
> +	.rst_ctrl = imx8mp_audiomix_rst_ctrl,
> +	.rst_ctrl_num = ARRAY_SIZE(imx8mp_audiomix_rst_ctrl),
> +};
> +
> +static const struct auxiliary_device_id imx_aux_reset_ids[] = {
> +	{
> +		.name = "clk_imx8mp_audiomix.reset",
> +		.driver_data = (kernel_ulong_t)&imx8mp_audiomix_rst_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, imx_aux_reset_ids);
> +
> +static struct auxiliary_driver imx_aux_reset_driver = {
> +	.probe		= imx_aux_reset_probe,
> +	.id_table	= imx_aux_reset_ids,
> +};
> +
> +module_auxiliary_driver(imx_aux_reset_driver);
> +
> +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> +MODULE_DESCRIPTION("Freescale i.MX auxiliary reset driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
> 
> 

