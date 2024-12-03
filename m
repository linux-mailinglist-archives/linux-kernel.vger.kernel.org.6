Return-Path: <linux-kernel+bounces-429979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF569E2A22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C583284DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D091FC0E0;
	Tue,  3 Dec 2024 17:58:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765C1DD0FF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248712; cv=none; b=sNy/1KoyRA0fAdTIdC9305ekfrUFwzlRJj1eVXUGgaEo6br2qGj20nNwQE2Re11Z5D4EgA2myH8EJ9GWUNWZnAFRyuA24dhjWh/l3dj1BKHcG0gIqu1VnDM9CTFphmuj5e/iT2CxYV54tDH/4to04HTSEYnAWQ7yge1o2OZB4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248712; c=relaxed/simple;
	bh=jtH2fJlVYpWNRRVi1QtuebYfdf2d4OegmjKMmaUCCU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zp2Lyztn3IjtbirDtfK+GJrstBpT+3xgmwM4j71PRQLoiXzIT5afoDaJqratmE+FDO0+MsIma5b/xnjGWgF+23NeguLJhx1D5ZHF784+DHMgnb/z7Io1dm1xuKGj/8l+5VkPJcFEhj+7o/G1vD/b4dKFACMBTLq43SqVF/xd3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIXAH-0006Sw-Kh; Tue, 03 Dec 2024 18:58:25 +0100
Message-ID: <3416531c050e5f6717e478eb7fd8fd6c30c21dd4.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: add optional reset support
From: Lucas Stach <l.stach@pengutronix.de>
To: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LENAIN Simon
 <simon.lenain@thalesgroup.com>,  BARBEAU Etienne
 <etienne.barbeau@thalesgroup.com>, LEJEUNE Sebastien
 <sebastien.lejeune@thalesgroup.com>
Date: Tue, 03 Dec 2024 18:58:24 +0100
In-Reply-To: <dc139d10a4184d289c9ffd1d308c0db1@thalesgroup.com>
References: <dc139d10a4184d289c9ffd1d308c0db1@thalesgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Philippe,

Am Freitag, dem 08.11.2024 um 14:00 +0000 schrieb LECOINTRE Philippe:
> Add optional reset support which is mentioned in vivante,gc.yaml to
> allow the driver to work on SoCs whose reset signal is asserted by defaul=
t
> Avoid enabling the interrupt until everything is ready
>=20
> Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
> Reviewed-by: Simon Lenain <simon.lenain@thalesgroup.com>
> ---
> v2:
> - Add missing include of irq.h
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 30 +++++++++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  2 ++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 7c7f97793ddd..3e0c5dd9f74b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2015-2018 Etnaviv Project
> + * Copyright (C) 2024 Thales
>   */
> =20
>  #include <linux/clk.h>
> @@ -8,11 +9,13 @@
>  #include <linux/delay.h>
>  #include <linux/dma-fence.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/irq.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/thermal.h>
> =20
>  #include "etnaviv_cmdbuf.h"
> @@ -1629,8 +1632,24 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_g=
pu *gpu)
>  	if (ret)
>  		goto disable_clk_core;
> =20
> +	/* 32 core clock cycles (slowest clock) required before deassertion. */
> +	/* 1 microsecond might match all implementations */
> +	usleep_range(1, 2);
> +
> +	ret =3D reset_control_deassert(gpu->rst);
> +	if (ret)
> +		goto disable_clk_shader;
> +
> +	/* 128 core clock cycles (slowest clock) required before any activity o=
n AHB. */
> +	/* 1 microsecond might match all implementations */
> +	usleep_range(1, 2);

Mashing the reset handling into the clock handling is a bad idea. The
clocks are en-/disabled during runtime PM handling. The etnaviv driver
is written in a way that the GPU does not necessarily need to be reset
during a runtime PM transition, which allow for faster startup times.

The reset handling should really be its own separate function and would
logically go into etnaviv_gpu_init() between the pm_runtime_get_sync()
and etnaviv_hw_identify().

> +
> +	enable_irq(gpu->irq);

Do you see any issues with the IRQ being enabled earlier? A GPU being
held in reset should not be able to trigger a IRQ.

> +
>  	return 0;
> =20
> +disable_clk_shader:
> +	clk_disable_unprepare(gpu->clk_shader);
>  disable_clk_core:
>  	clk_disable_unprepare(gpu->clk_core);
>  disable_clk_bus:
> @@ -1643,6 +1662,8 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gp=
u *gpu)
> =20
>  static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
>  {
> +	disable_irq(gpu->irq);
> +	reset_control_assert(gpu->rst);
>  	clk_disable_unprepare(gpu->clk_shader);
>  	clk_disable_unprepare(gpu->clk_core);
>  	clk_disable_unprepare(gpu->clk_bus);
> @@ -1876,6 +1897,9 @@ static int etnaviv_gpu_platform_probe(struct platfo=
rm_device *pdev)
>  	if (gpu->irq < 0)
>  		return gpu->irq;
> =20
> +	/* Avoid enabling the interrupt until everything is ready */
> +	irq_set_status_flags(gpu->irq, IRQ_NOAUTOEN);
> +
>  	err =3D devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
>  			       dev_name(gpu->dev), gpu);
>  	if (err) {
> @@ -1883,6 +1907,12 @@ static int etnaviv_gpu_platform_probe(struct platf=
orm_device *pdev)
>  		return err;
>  	}
> =20
> +	/* Get Reset: */
> +	gpu->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(gpu->rst))
> +		return dev_err_probe(dev, PTR_ERR(gpu->rst),
> +				     "failed to get reset\n");
> +
>  	/* Get Clocks: */
>  	gpu->clk_reg =3D devm_clk_get_optional(&pdev->dev, "reg");
>  	DBG("clk_reg: %p", gpu->clk_reg);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.h
> index 31322195b9e4..8c181191755e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2015-2018 Etnaviv Project
> + * Copyright (C) 2024 Thales

I don't think adding a single member here does warrant a Copyright
statement, in fact I would prefer them to not be touched at all.
Authorship of individual changes to the driver a clearly attributable
via the git history.

Regards,
Lucas
>   */
> =20
>  #ifndef __ETNAVIV_GPU_H__
> @@ -157,6 +158,7 @@ struct etnaviv_gpu {
>  	struct clk *clk_reg;
>  	struct clk *clk_core;
>  	struct clk *clk_shader;
> +	struct reset_control *rst;
> =20
>  	unsigned int freq_scale;
>  	unsigned int fe_waitcycles;


