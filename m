Return-Path: <linux-kernel+bounces-264196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B447F93E015
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18CC1C21091
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525F1850B0;
	Sat, 27 Jul 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qm1gZCAw"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E11850B4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722096698; cv=none; b=WRoS8CR3qDOALEir6vsSpmS0UXvzC5pZjO/q/by0l5RP+HuhrYee7lGX5UJu4NF4Ns1OR3FIdqozzH5HJgaelPtBmDnzlcLP08ddP4ScGIBDMQVsLfxx3ZkVHusLHvwDtMc5FDBU6jwpRAEuzf6mP2CKrJsmOpvPIg1jts/ciZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722096698; c=relaxed/simple;
	bh=EsBhvQlOZK7H48/dvn9boK4pxLvMBa1HsD15rOYYEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdgGtSo8Ms34pffgYBuv4m6FlmmJajIgMLgbXszHiBp4zQ9PKfRo+H1f9yzoNsMwDlxxmBTs89qGHoFZaCSh1N4vVMjEkeVfZaW2B3DBP6Ns7T/eLy/BD5+PyI+2hykbDEJTaGdq2FA0bWIKH9TVOA+ym5SxXGc7oI24NejBFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qm1gZCAw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f032cb782dso23933771fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722096694; x=1722701494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBusllycXeOxRmMQscoyIs5AgPJe93SHCpBqt0L+kPU=;
        b=Qm1gZCAwG1+YvYM2F9t8LGJxmjauTzTqC3atj8JSqusHMg07yC0VDDyr4i09JeEBED
         0LImvS912knWx9g6DkvEdbX06jf9ojdWdafBhi/3t4g+ztXzEY8LPxsFa9tn5KNebuds
         r2TxwooNYUNd2OrmxGnJgy6ue96jwN66Oip5jWr5/pTj/kRtPPuK/0nwfVC2oiG6v1nI
         GrHGG9MJn8Ji6oH7vvGakY+6BlsCqH5qYZcETB+CNg0C3HorgFxdWI0xy6AP6EM+nvxm
         4hKFCCRhZzg/gvyVYN5v7M7WH43QPdc6+nb5NYSyjFTxjeydb/OQ1UcbuAmb1yOqZE6B
         PKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722096694; x=1722701494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBusllycXeOxRmMQscoyIs5AgPJe93SHCpBqt0L+kPU=;
        b=lbhPipVyaMJ5USnXInfjkSGnOhqpA+2JUrTNJvE0yUFtGisNpMwXIwkgs4vSfwv1A+
         9UsbWC534OHu0Bt+Y4apLk7NnBjOcFUprV+WZPGuDmPHFY4/jV/BhH2MoeqLNHh+91oI
         6LxrXo0wx8l4RRbwcjYnZrrnYnDVXbPdHkvjPdNtrp28d+FanqVRvVp1sYixf1QObFs4
         tHviVsu5YJUqPYVY4BP66vOW/oCVDxFEFwTsIw6Yvu0VNagBj1l8QQKGmpNYzTrHdxH3
         N4xfmUuii9o6GxyYI+6s+gz95p8vFUmSAbnAgiSsjpYRUoFx+YtjX2bF5Y83xft/R8LE
         LBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFd6HcKcnIBQ77T3RovtAuEMqfRehXLZjFGe3Da45AnIM2OgYIXZkmFpCRNFiKfsn0gym0Lk1M3fhGG5QDRtDbYhGZvIS8bLxaU8e9
X-Gm-Message-State: AOJu0YyGFJFsmIrj/lKKRM4gtqje2DUNN2Mc3MJ6FgVxkVs8m/v1eh1N
	rOqPgQl25YtK6W51cR1z0oH2JpxOP9D9H6X7WUw3pVrwN2UQBcslye2PG0lK3SY=
X-Google-Smtp-Source: AGHT+IGE/jZAAc2Nvw2MwerHR0yM2Y7j8htLQh1i+XFzPdpbP2zrSjL7bEwU58lE0zhsp1lfp1yK8Q==
X-Received: by 2002:a2e:b710:0:b0:2ef:2c86:4d43 with SMTP id 38308e7fff4ca-2f12edf9e66mr19092791fa.3.1722096694188;
        Sat, 27 Jul 2024 09:11:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d074b19sm7153491fa.110.2024.07.27.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:11:33 -0700 (PDT)
Date: Sat, 27 Jul 2024 19:11:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, p.zabel@pengutronix.de, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org, 
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, 
	frank.li@nxp.com
Subject: Re: [PATCH v2 06/16] drm/imx: Add i.MX8qxp Display Controller
 display engine
Message-ID: <ib6brwxeai3wkgzglihfbqx7jakjslnftydbzo32xthijkd4u6@y4ebhgk5o3ec>
References: <20240712093243.2108456-1-victor.liu@nxp.com>
 <20240712093243.2108456-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712093243.2108456-7-victor.liu@nxp.com>

On Fri, Jul 12, 2024 at 05:32:33PM GMT, Liu Ying wrote:
> i.MX8qxp Display Controller display engine consists of all processing
> units that operate in a display clock domain.  Add minimal feature
> support with FrameGen and TCon so that the engine can output display
> timings.  The display engine driver as a master binds FrameGen and
> TCon drivers as components.  While at it, the display engine driver
> is a component to be bound with the upcoming DRM driver.

Generic question: why do you need so many small subdrivers? Are they
used to represent the flexibility of the pipeline? Can you instantiate
these units directly from the de(?) driver and reference created
structures without the need to create subdevices?

> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2:
> * Use OF alias id to get instance id.
> * Add dev member to struct dc_tc.
> 
>  drivers/gpu/drm/imx/Kconfig     |   1 +
>  drivers/gpu/drm/imx/Makefile    |   1 +
>  drivers/gpu/drm/imx/dc/Kconfig  |   5 +
>  drivers/gpu/drm/imx/dc/Makefile |   5 +
>  drivers/gpu/drm/imx/dc/dc-de.c  | 151 +++++++++++++
>  drivers/gpu/drm/imx/dc/dc-de.h  |  62 ++++++
>  drivers/gpu/drm/imx/dc/dc-drv.c |  32 +++
>  drivers/gpu/drm/imx/dc/dc-drv.h |  24 +++
>  drivers/gpu/drm/imx/dc/dc-fg.c  | 366 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-tc.c  | 137 ++++++++++++
>  10 files changed, 784 insertions(+)
>  create mode 100644 drivers/gpu/drm/imx/dc/Kconfig
>  create mode 100644 drivers/gpu/drm/imx/dc/Makefile
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-de.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-de.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-drv.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-drv.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fg.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-tc.c
> 
> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> index 03535a15dd8f..3e8c6edbc17c 100644
> --- a/drivers/gpu/drm/imx/Kconfig
> +++ b/drivers/gpu/drm/imx/Kconfig
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> +source "drivers/gpu/drm/imx/dc/Kconfig"
>  source "drivers/gpu/drm/imx/dcss/Kconfig"
>  source "drivers/gpu/drm/imx/ipuv3/Kconfig"
>  source "drivers/gpu/drm/imx/lcdc/Kconfig"
> diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
> index 86f38e7c7422..c7b317640d71 100644
> --- a/drivers/gpu/drm/imx/Makefile
> +++ b/drivers/gpu/drm/imx/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +obj-$(CONFIG_DRM_IMX8_DC) += dc/
>  obj-$(CONFIG_DRM_IMX_DCSS) += dcss/
>  obj-$(CONFIG_DRM_IMX) += ipuv3/
>  obj-$(CONFIG_DRM_IMX_LCDC) += lcdc/
> diff --git a/drivers/gpu/drm/imx/dc/Kconfig b/drivers/gpu/drm/imx/dc/Kconfig
> new file mode 100644
> index 000000000000..32d7471c49d0
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/Kconfig
> @@ -0,0 +1,5 @@
> +config DRM_IMX8_DC
> +	tristate "Freescale i.MX8 Display Controller Graphics"
> +	depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
> +	help
> +	  enable Freescale i.MX8 Display Controller(DC) graphics support
> diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
> new file mode 100644
> index 000000000000..56de82d53d4d
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +imx8-dc-drm-objs := dc-de.o dc-drv.o dc-fg.o dc-tc.o
> +
> +obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
> diff --git a/drivers/gpu/drm/imx/dc/dc-de.c b/drivers/gpu/drm/imx/dc/dc-de.c
> new file mode 100644
> index 000000000000..2c8268b76b08
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-de.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/component.h>
> +#include <linux/container_of.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <drm/drm_managed.h>
> +
> +#include "dc-de.h"
> +#include "dc-drv.h"
> +
> +#define POLARITYCTRL		0xc
> +#define  POLEN_HIGH		BIT(2)
> +
> +struct dc_de_priv {
> +	struct dc_de engine;
> +	void __iomem *reg_top;
> +};
> +
> +static inline struct dc_de_priv *to_de_priv(struct dc_de *de)
> +{
> +	return container_of(de, struct dc_de_priv, engine);
> +}
> +
> +static inline void
> +dc_dec_write(struct dc_de *de, unsigned int offset, u32 value)
> +{
> +	struct dc_de_priv *priv = to_de_priv(de);
> +
> +	writel(value, priv->reg_top + offset);

Is there a point in this wrapper? Can you call writel directly? This
question generally applies to the driver. I see a lot of small functions
which can be inlined without losing the clarity.

> +}
> +
> +static void dc_dec_init(struct dc_de *de)
> +{
> +	dc_dec_write(de, POLARITYCTRL, POLEN_HIGH);
> +}
> +
> +static int dc_de_bind(struct device *dev, struct device *master, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct dc_drm_device *dc_drm = data;
> +	struct dc_de_priv *priv;
> +	int ret;
> +
> +	priv = drmm_kzalloc(&dc_drm->base, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->reg_top = devm_platform_ioremap_resource_byname(pdev, "top");
> +	if (IS_ERR(priv->reg_top))
> +		return PTR_ERR(priv->reg_top);
> +
> +	priv->engine.irq_shdld = platform_get_irq_byname(pdev, "shdload");
> +	if (priv->engine.irq_shdld < 0)
> +		return priv->engine.irq_shdld;
> +
> +	priv->engine.irq_framecomplete =
> +				platform_get_irq_byname(pdev, "framecomplete");
> +	if (priv->engine.irq_framecomplete < 0)
> +		return priv->engine.irq_framecomplete;
> +
> +	priv->engine.irq_seqcomplete =
> +				platform_get_irq_byname(pdev, "seqcomplete");
> +	if (priv->engine.irq_seqcomplete < 0)
> +		return priv->engine.irq_seqcomplete;
> +
> +	priv->engine.id = of_alias_get_id(dev->of_node, "dc0-display-engine");

Is this alias documented somewhere? Is it Acked by DT maintainers?

> +	if (priv->engine.id < 0) {
> +		dev_err(dev, "failed to get alias id: %d\n", priv->engine.id);
> +		return priv->engine.id;
> +	}
> +
> +	priv->engine.dev = dev;
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	dc_drm->de[priv->engine.id] = &priv->engine;
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

