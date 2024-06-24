Return-Path: <linux-kernel+bounces-226927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD19145DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D34B244FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D712FF8C;
	Mon, 24 Jun 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEdHZbZS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F069953
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219968; cv=none; b=qcxVrrg5PKcqu9QHhRJbqRTntDW22e1GnyHwuqjbPYbTxPmeUnTNHtrC/utzDPiDfI+Hwt4HSu4vkd/Oi153jzQNNTId7F9b+PFyS5sbH7PCTMILb+YrMuccoS8H6RrZcbOzJ/xC54IHRQRhzAfQgT2wYWYjSvIDvLqvA4mWq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219968; c=relaxed/simple;
	bh=ZN5+orVrGT6zdLrz7ZrhzJFWY4wX858lkwUU4kdguWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krnJTggqgOPFUl3T1EUceL4ug7o37x8GqP+KFJB3DK6dpaRewGOaxRp+OW7cHSX5FqtA+GXHFHEawwG1yvktS9JJSA9qOB1Cu3x4poOWc7gVNCoJ+dyl4KzozzRdqGf5LH1+9TuULIvR4+7QSgdnUWVebJOen1fyGNdlAWS0J5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEdHZbZS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdf9f934fso1566197e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719219964; x=1719824764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kew+Lkgg2/C1wK/ceEvlEA0LvihR0nCkMCFEGGDYFH0=;
        b=iEdHZbZSA3WiwTas4mK9BNdL9m0hXbMfYbternoysTlTMvBi5zi9odUOaVi0hI5Pet
         /5Uo2CcRORPeP3F2zjKvALd8mPbfQvZdIbjUwn0BAwpezaYgyy+UgNoF0Lo6jCsSA450
         H866KlIqCCkN3py2ngJqfGvgLOfU2l1IoZnqelTXFmI8J8VHkcgSYZcT+h6MAUq2V/tD
         gT94+Ts6sioFw7RLtw4NnZ/2qy3OYmE/2Snfy2ZZx1h0H48XkiNEo9kjlPr5CsPiCKxC
         gbKx+AJJJaRN8beeHMZsNVmdMw0VrsveAuNbLYx6suTdSX/38R7ktuEySNqKW8huXBCK
         xfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219964; x=1719824764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kew+Lkgg2/C1wK/ceEvlEA0LvihR0nCkMCFEGGDYFH0=;
        b=EXXzR7+Q4+RMNRno175lFrGulxnLW5xw47dfl5lHvDENIRSLmujJVH8tkGj5tdxLFX
         LT0Th2YK15Jw4mH1QGPJMwpOBr3KhzdjPbyXktZ1f9OekBSYDx/2IRlr/euv09M9qH15
         7P+Vwjrx+d0MQU0iSMYvu+mCTm4lqC/AIs63TK8RBrrVcoCk4VM5uBmslbyPvDhBUrMO
         m6qG5++KoL22Tht4OE6nKh+Kw/zunTPmqfBxPyNlTvv7NkGNhwG4ZR24/9y/HyNA60WQ
         s3G9bPMXOsm28/2RB/Qbjkl+4H25wjHsgNJp/8jwWHoVgFnMNqyl+0iGCFbKmKKqkCDs
         Y47Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNUr7jbKSuvXazlbZvI9j3PvygOyQjfD5eTod3fGxY86A40sGN5qXO8jmlrAdPMTlEddv/LmIrm/9HJRGo8gKzLsofkJ7y9xCprlQ0
X-Gm-Message-State: AOJu0Yx27bz4bHWsDB9gXWqQF5Ks8VQ8bJ+Ty8pO68YN/k/T5OzvjKjG
	IiYLNBynGlCXQX4ZuimfVr9qxEuVqCPCP2neebENCDAE7P9Dq7CG7xZnXsmQbQM=
X-Google-Smtp-Source: AGHT+IFLK18mj5o7O9bzNwh+9imco/emBa0iy/WB+YbshssFsZ8QxRrWGYZrnIism3ewt/VuyDJvAA==
X-Received: by 2002:a05:6512:b8b:b0:52c:e312:2082 with SMTP id 2adb3069b0e04-52ce3122186mr2621375e87.54.1719219964284;
        Mon, 24 Jun 2024 02:06:04 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6af9sm9494370f8f.73.2024.06.24.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:06:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:06:02 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: p.zabel@pengutronix.de, abelvesa@kernel.org, peng.fan@nxp.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v9] reset: imx8mp-audiomix: Add AudioMix Block Control
 reset driver
Message-ID: <Znk2+uYj4JpbP+z+@linaro.org>
References: <1719200345-32006-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719200345-32006-1-git-send-email-shengjiu.wang@nxp.com>

On 24-06-24 11:39:05, Shengjiu Wang wrote:
> Add support for the resets on i.MX8MP Audio Block Control module,
> which includes the EARC PHY software reset and EARC controller
> software reset. The reset controller is created using the auxiliary
> device framework and set up in the clock driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> changes in v9:
> - only send this commits because others have been applied
> - remove depends on in config
> - add spin lock
> - call iounmmap()
> 
> changes in v8:
> https://lore.kernel.org/linux-arm-kernel/27ea1bf7de6f349426fcd7ddb056a1adfae47c73.camel@pengutronix.de/T/
> 
>  drivers/reset/Kconfig                 |   7 ++
>  drivers/reset/Makefile                |   1 +
>  drivers/reset/reset-imx8mp-audiomix.c | 128 ++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/reset/reset-imx8mp-audiomix.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..509f70e5c4c0 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -91,6 +91,13 @@ config RESET_IMX7
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
>  
> +config RESET_IMX8MP_AUDIOMIX
> +	tristate "i.MX8MP AudioMix Reset Driver"
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
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
>  obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> +obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>  obj-$(CONFIG_RESET_K210) += reset-k210.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> new file mode 100644
> index 000000000000..6e3f3069f727
> --- /dev/null
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -0,0 +1,128 @@
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
> +#include <linux/reset-controller.h>
> +
> +#define EARC			0x200
> +#define EARC_RESET_MASK		0x3
> +
> +struct imx8mp_audiomix_reset {
> +	struct reset_controller_dev rcdev;
> +	spinlock_t lock; /* protect register read-modify-write cycle */
> +	void __iomem *base;
> +};
> +
> +static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct imx8mp_audiomix_reset, rcdev);
> +}
> +
> +static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> +					unsigned long id)
> +{
> +	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> +	void __iomem *reg_addr = priv->base;
> +	unsigned int mask, reg;
> +	unsigned long flags;
> +
> +	mask = BIT(id);
> +	spin_lock_irqsave(&priv->lock, flags);
> +	reg = readl(reg_addr + EARC);
> +	writel(reg & ~mask, reg_addr + EARC);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
> +					  unsigned long id)
> +{
> +	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> +	void __iomem *reg_addr = priv->base;
> +	unsigned int mask, reg;
> +	unsigned long flags;
> +
> +	mask = BIT(id);
> +	spin_lock_irqsave(&priv->lock, flags);
> +	reg = readl(reg_addr + EARC);
> +	writel(reg | mask, reg_addr + EARC);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
> +	.assert   = imx8mp_audiomix_reset_assert,
> +	.deassert = imx8mp_audiomix_reset_deassert,
> +};
> +
> +static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> +				       const struct auxiliary_device_id *id)
> +{
> +	struct imx8mp_audiomix_reset *priv;
> +	struct device *dev = &adev->dev;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&priv->lock);
> +
> +	priv->rcdev.owner     = THIS_MODULE;
> +	priv->rcdev.nr_resets = fls(EARC_RESET_MASK);
> +	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
> +	priv->rcdev.of_node   = dev->parent->of_node;
> +	priv->rcdev.dev	      = dev;
> +	priv->rcdev.of_reset_n_cells = 1;
> +	priv->base            = of_iomap(dev->parent->of_node, 0);
> +	if (!priv->base)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	ret = devm_reset_controller_register(dev, &priv->rcdev);
> +	if (ret)
> +		goto out_unmap;
> +
> +	return 0;
> +
> +out_unmap:
> +	iounmap(priv->base);
> +	return ret;
> +}
> +
> +static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
> +{
> +	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
> +
> +	iounmap(priv->base);
> +}
> +
> +static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> +	{
> +		.name = "clk_imx8mp_audiomix.reset",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
> +
> +static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
> +	.probe		= imx8mp_audiomix_reset_probe,
> +	.remove		= imx8mp_audiomix_reset_remove,
> +	.id_table	= imx8mp_audiomix_reset_ids,
> +};
> +
> +module_auxiliary_driver(imx8mp_audiomix_reset_driver);
> +
> +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> +MODULE_DESCRIPTION("Freescale i.MX8MP Audio Block Controller reset driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

