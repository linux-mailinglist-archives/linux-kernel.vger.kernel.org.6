Return-Path: <linux-kernel+bounces-269097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13507942D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735EB285F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3289F1AE84D;
	Wed, 31 Jul 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdwEEBDP"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BC1AC42F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426876; cv=none; b=MfiI7EKt7hS3zZL8e+8J7hQdlw8kzvIgkd0OTVXhdoZSwxIptY+GO6cBOnFZGynKvySgVDHCPa4ZR6Hfd+iICg2cu+bW5AqYBlQtj5r7eOh86/YcKAA0aPlYk1rjiXvazLNoSoJ2aUYuqgHAwWhnp1kfTHt71oulKdEUDFzB24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426876; c=relaxed/simple;
	bh=rjbZh0Q3rEwtUzUP5YeP00rs4ZGQ1DfaFGZNNesKrUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjHm3ybpc8kaAM1puIeNhsVAJwPR5ew/jWVhqnRI0qxop2CXGRf8AFc3l/+ug7Fjnr/2OgSzjZpaJxIksgSCQNooebVeLNPWSkOjh0+J/1uCGVIYeNUf1+MIdZWT6rGFZliWtFhvti06lccjMowCSMd7vRxNn7cFA3thFfj5LN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdwEEBDP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so8445494e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722426872; x=1723031672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tSzw1ZB1Nz5Tc2tcLBbnlYlKFmdCPO73C3dMrVaia0=;
        b=hdwEEBDPfFa8ykqWFCK6S1FN4eEqkejnUrw/Vi4PfXMFg1glpXDeWSOKcO7Kip76t1
         29cjNH1OHVp9tukrkAEcXX5s0YEjj/nWMbyenUKC57Vj6BVauC8XFRoa6FM4KUM9u0Wv
         nol5yBoAi27mAlRLwCcPmWCt6Ml/TokRYfqULyCRX6xIJ2GoCcdYGuQA7BMv/BTvSpIx
         8m2pNTf9g1isMA5+nwy9S3sJn8uRnBvv3phF2OMTruazY4wkBW2f5+5GSGmrYStXF86W
         Ok+LZ00kLDWlLTppJ8ifKqsrFuHRDtRmAovcGHx29SpWvM3IXJjDsSbdZUQAtbAfjLZk
         Q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722426872; x=1723031672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tSzw1ZB1Nz5Tc2tcLBbnlYlKFmdCPO73C3dMrVaia0=;
        b=GAah62wVn0rBxzrPB62MwT1xqUhv3OYtd+GxJLvuk+2HnTN+RIfsX8CFWvkXXaA1yG
         woJt5Ys2QpwlofwLDAvfJN2PB+qgQZsrWWy5Ytg/JcEUipHNO17ZBu3j3JrBIwEuktKc
         DR7ATfXSonCGicV6A+NBhciFFGO9zWy3AhfIL8JHKsTj2Hb1O7BJ1/HdRu/7uXl1VyWu
         9E+8Y0HIJAwcCiuUn4tKPHFRv0XXRMlmrnWaDewJeXdLp+AsndzfvRLAE9JIxGNan/kS
         odAp2h6J/jrI1WFujP2jHCPlLZ12KNexFpzkGbKt4cJxuU0ympMjroVSwG5f6j9upVvq
         joSA==
X-Forwarded-Encrypted: i=1; AJvYcCUavKAEBHFNndtPveie9zFbfE2vjjyLoiZXf5EAzExZpjfLTDpYD53Azgdv+7yrG6uTFbFoCVuXGuUtKNG126jWVpLXTiMe0U3dO8Cl
X-Gm-Message-State: AOJu0Yx80IrWeCfqioi5EBnEuW4jOaei+VpTwwEnzRTR1P+Hmn0aXwYY
	0lY94a34NyYjJ0O5ynluicQP2RR8IZMwa7/G+H2T2FQfZn5GuPKnkrIOg4h4+Nk=
X-Google-Smtp-Source: AGHT+IFDX5VOQq12CjYJKbH5TLCQZO1fSa3Id5idEuIEkUhLXxfFu0OdqK6fCnnHllm7jAiKoqzSlg==
X-Received: by 2002:a05:6512:32c7:b0:52e:943c:c61a with SMTP id 2adb3069b0e04-5309b2e0adbmr10958703e87.57.1722426872000;
        Wed, 31 Jul 2024 04:54:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc40e7sm2193549e87.39.2024.07.31.04.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:54:31 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:54:29 +0300
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
Message-ID: <vlnpy7abizzzh7sj5zrgakwyams3w6k7ee4kaagiw646atmnjf@xkimtr43d4hr>
References: <20240712093243.2108456-1-victor.liu@nxp.com>
 <20240712093243.2108456-7-victor.liu@nxp.com>
 <ib6brwxeai3wkgzglihfbqx7jakjslnftydbzo32xthijkd4u6@y4ebhgk5o3ec>
 <8071fdf8-6813-4707-8a9c-ad24f8b6a32f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8071fdf8-6813-4707-8a9c-ad24f8b6a32f@nxp.com>

On Tue, Jul 30, 2024 at 02:25:41PM GMT, Liu Ying wrote:
> On 07/28/2024, Dmitry Baryshkov wrote:
> > On Fri, Jul 12, 2024 at 05:32:33PM GMT, Liu Ying wrote:
> >> i.MX8qxp Display Controller display engine consists of all processing
> >> units that operate in a display clock domain.  Add minimal feature
> >> support with FrameGen and TCon so that the engine can output display
> >> timings.  The display engine driver as a master binds FrameGen and
> >> TCon drivers as components.  While at it, the display engine driver
> >> is a component to be bound with the upcoming DRM driver.
> > 
> > Generic question: why do you need so many small subdrivers? Are they
> 
> As we model processing units, interrupt controller, display engine
> and pixel engine as devices, relevant drivers are created to bind
> them.
> 
> Maxime insisted on splitting the main display controller(the overall
> IP) into separate devices.  Also, Rob asked me to document every
> processing units and the other sub-devices in v2.  So, splitting the
> controller is kinda accepted from both DT PoV and DRM PoV.

I went back to the previous series, where Maxime commented on the
"multiple devices glued together". With the split architecture it
becomes even more strange, because now you have a separate IRQ
controller which enumerates interrupts for all subdevices and then glues
them back.

If it was an actually split device, I'd have expected that each of
subdevices has interrupts going to the external controller, without the
glue controller. Or that the glue controller has a limited set of the
externally-generated interrupts that it further splits into per-block
IRQs.

Could you please point out the patches that describe and implement the
<&dc0_irqsteer> device?

> 
> > used to represent the flexibility of the pipeline? Can you instantiate
> 
> No. They are just used to bind the devices created from DT.
> 
> > these units directly from the de(?) driver and reference created
> > structures without the need to create subdevices?
> 
> Given the separated devices created from DT, I can't.

I'd allow Maxime to override me here, but I think that subblocks should
not be described in DT, unless that is required to describe
possible versatility in the display pipeline.

> >>
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >> v2:
> >> * Use OF alias id to get instance id.
> >> * Add dev member to struct dc_tc.
> >>
> >>  drivers/gpu/drm/imx/Kconfig     |   1 +
> >>  drivers/gpu/drm/imx/Makefile    |   1 +
> >>  drivers/gpu/drm/imx/dc/Kconfig  |   5 +
> >>  drivers/gpu/drm/imx/dc/Makefile |   5 +
> >>  drivers/gpu/drm/imx/dc/dc-de.c  | 151 +++++++++++++
> >>  drivers/gpu/drm/imx/dc/dc-de.h  |  62 ++++++
> >>  drivers/gpu/drm/imx/dc/dc-drv.c |  32 +++
> >>  drivers/gpu/drm/imx/dc/dc-drv.h |  24 +++
> >>  drivers/gpu/drm/imx/dc/dc-fg.c  | 366 ++++++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/imx/dc/dc-tc.c  | 137 ++++++++++++
> >>  10 files changed, 784 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/imx/dc/Kconfig
> >>  create mode 100644 drivers/gpu/drm/imx/dc/Makefile
> >>  create mode 100644 drivers/gpu/drm/imx/dc/dc-de.c
> >>  create mode 100644 drivers/gpu/drm/imx/dc/dc-de.h
> >>  create mode 100644 drivers/gpu/drm/imx/dc/dc-drv.c
> >>  create mode 100644 drivers/gpu/drm/imx/dc/dc-drv.h
> >>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fg.c
> >>  create mode 100644 drivers/gpu/drm/imx/dc/dc-tc.c
> >>
> >> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> >> index 03535a15dd8f..3e8c6edbc17c 100644
> >> --- a/drivers/gpu/drm/imx/Kconfig
> >> +++ b/drivers/gpu/drm/imx/Kconfig
> >> @@ -1,5 +1,6 @@
> >>  # SPDX-License-Identifier: GPL-2.0-only
> >>  
> >> +source "drivers/gpu/drm/imx/dc/Kconfig"
> >>  source "drivers/gpu/drm/imx/dcss/Kconfig"
> >>  source "drivers/gpu/drm/imx/ipuv3/Kconfig"
> >>  source "drivers/gpu/drm/imx/lcdc/Kconfig"
> >> diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
> >> index 86f38e7c7422..c7b317640d71 100644
> >> --- a/drivers/gpu/drm/imx/Makefile
> >> +++ b/drivers/gpu/drm/imx/Makefile
> >> @@ -1,5 +1,6 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  
> >> +obj-$(CONFIG_DRM_IMX8_DC) += dc/
> >>  obj-$(CONFIG_DRM_IMX_DCSS) += dcss/
> >>  obj-$(CONFIG_DRM_IMX) += ipuv3/
> >>  obj-$(CONFIG_DRM_IMX_LCDC) += lcdc/
> >> diff --git a/drivers/gpu/drm/imx/dc/Kconfig b/drivers/gpu/drm/imx/dc/Kconfig
> >> new file mode 100644
> >> index 000000000000..32d7471c49d0
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/imx/dc/Kconfig
> >> @@ -0,0 +1,5 @@
> >> +config DRM_IMX8_DC
> >> +	tristate "Freescale i.MX8 Display Controller Graphics"
> >> +	depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
> >> +	help
> >> +	  enable Freescale i.MX8 Display Controller(DC) graphics support
> >> diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
> >> new file mode 100644
> >> index 000000000000..56de82d53d4d
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/imx/dc/Makefile
> >> @@ -0,0 +1,5 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +imx8-dc-drm-objs := dc-de.o dc-drv.o dc-fg.o dc-tc.o
> >> +
> >> +obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
> >> diff --git a/drivers/gpu/drm/imx/dc/dc-de.c b/drivers/gpu/drm/imx/dc/dc-de.c
> >> new file mode 100644
> >> index 000000000000..2c8268b76b08
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/imx/dc/dc-de.c
> >> @@ -0,0 +1,151 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#include <linux/component.h>
> >> +#include <linux/container_of.h>
> >> +#include <linux/io.h>
> >> +#include <linux/mod_devicetable.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/pm.h>
> >> +#include <linux/pm_runtime.h>
> >> +
> >> +#include <drm/drm_managed.h>
> >> +
> >> +#include "dc-de.h"
> >> +#include "dc-drv.h"
> >> +
> >> +#define POLARITYCTRL		0xc
> >> +#define  POLEN_HIGH		BIT(2)
> >> +
> >> +struct dc_de_priv {
> >> +	struct dc_de engine;
> >> +	void __iomem *reg_top;
> >> +};
> >> +
> >> +static inline struct dc_de_priv *to_de_priv(struct dc_de *de)
> >> +{
> >> +	return container_of(de, struct dc_de_priv, engine);
> >> +}
> >> +
> >> +static inline void
> >> +dc_dec_write(struct dc_de *de, unsigned int offset, u32 value)
> >> +{
> >> +	struct dc_de_priv *priv = to_de_priv(de);
> >> +
> >> +	writel(value, priv->reg_top + offset);
> > 
> > Is there a point in this wrapper? Can you call writel directly? This
> 
> At least, it helps finding read/write ops upon interested devices through
> 'git grep'.

git grep writel also works.

> 
> Also, since we have dc_*_write_mask() helpers, it doesn't look too bad to
> have dc_*_read/write() helpers.

Please use regmap_update_bits instead of dc_*_write_mask.

> 
> > question generally applies to the driver. I see a lot of small functions
> > which can be inlined without losing the clarity.
> 
> Can you please point out typical ones?

dc_fg_enable_shden(), dc_fg_syncmode(), dc_dec_init()

To provide an example, this is the code from dc_crtc_atomic_enable().

	dc_fg_displaymode(dc_crtc->fg, FG_DM_SEC_ON_TOP);
	dc_fg_panic_displaymode(dc_crtc->fg, FG_DM_CONSTCOL);
	dc_fg_cfg_videomode(dc_crtc->fg, adj);

the FG parameters are fixed here. I'd expect a single call from dc_dcrtc
to dc_fg, which internally does all the settings. This removes a need to
export low-level details to other modules.

> 
> > 
> >> +}
> >> +
> >> +static void dc_dec_init(struct dc_de *de)
> >> +{
> >> +	dc_dec_write(de, POLARITYCTRL, POLEN_HIGH);
> >> +}
> >> +
> >> +static int dc_de_bind(struct device *dev, struct device *master, void *data)
> >> +{
> >> +	struct platform_device *pdev = to_platform_device(dev);
> >> +	struct dc_drm_device *dc_drm = data;
> >> +	struct dc_de_priv *priv;
> >> +	int ret;
> >> +
> >> +	priv = drmm_kzalloc(&dc_drm->base, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +
> >> +	priv->reg_top = devm_platform_ioremap_resource_byname(pdev, "top");
> >> +	if (IS_ERR(priv->reg_top))
> >> +		return PTR_ERR(priv->reg_top);
> >> +
> >> +	priv->engine.irq_shdld = platform_get_irq_byname(pdev, "shdload");
> >> +	if (priv->engine.irq_shdld < 0)
> >> +		return priv->engine.irq_shdld;
> >> +
> >> +	priv->engine.irq_framecomplete =
> >> +				platform_get_irq_byname(pdev, "framecomplete");
> >> +	if (priv->engine.irq_framecomplete < 0)
> >> +		return priv->engine.irq_framecomplete;
> >> +
> >> +	priv->engine.irq_seqcomplete =
> >> +				platform_get_irq_byname(pdev, "seqcomplete");
> >> +	if (priv->engine.irq_seqcomplete < 0)
> >> +		return priv->engine.irq_seqcomplete;
> >> +
> >> +	priv->engine.id = of_alias_get_id(dev->of_node, "dc0-display-engine");
> > 
> > Is this alias documented somewhere? Is it Acked by DT maintainers?
> 
> I see aliases nodes in about 10 .yaml files as examples.
> If needed, I can add them to examples.
> 
> Rob said "Ideally, no" to use alias in v1. However, IMHO, it is the only
> appropriate way to get instance id. In v1 review cycles, we've seen kinda
> 4 ways:
> 
> 1) fsl,dc-*-id DT property
>    Rejected by Krzystof.
> 
> 2) OF alias
> 
> 3) OF graph ports (Rob)
>    This doesn't directly get instance id but just tell the connections.
>    Since there are too many input/output options between some processing
>    units, I hope we don't end up using this approach, as I mentioned in v1.
>    It seems be difficult for display driver to handle those ports.   
> 
>    VC4 Hardware Video Scaler(HVS) is not using OF graph ports to tell the
>    connections to display controllers, either. See brcm,bcm2835-hvs.yaml.
>  
> 4) fsl,imx8qxp-dc-*{id} DT compatible string
>    It doesn't seem necessary to add the id information to compatible string.

For the similar issue we ended up hardcoding IO address / masks into the
driver. This is far from being optimal (and I'd like to get away from
it). If we were designing drm/msm from scratch now, we'd probably have used OF
graph port IDs.

> 
> > 
> >> +	if (priv->engine.id < 0) {
> >> +		dev_err(dev, "failed to get alias id: %d\n", priv->engine.id);
> >> +		return priv->engine.id;
> >> +	}
> >> +
> >> +	priv->engine.dev = dev;
> >> +
> >> +	dev_set_drvdata(dev, priv);
> >> +
> >> +	ret = devm_pm_runtime_enable(dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	dc_drm->de[priv->engine.id] = &priv->engine;
> >> +
> >> +	return 0;
> >> +}
> >> +
> > 
> 
> -- 
> Regards,
> Liu Ying
> 

-- 
With best wishes
Dmitry

