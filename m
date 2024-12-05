Return-Path: <linux-kernel+bounces-433734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED569E5C55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF1E188122F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48021D589;
	Thu,  5 Dec 2024 16:58:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2A165EFC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417885; cv=none; b=i1iTDvDupRF+BDQdZTVlmt6OjT979R+1P1SiG/ZPcke8RmNQ7cKG4PfKs/58yDg8HpsSmLE6/xlaJOAnnhJaVWwk2JYVXi5aa2wR6n5ZvYrv+pVT6Rap74LVP+VdyTBbxiN8BnBxVT+jT8jXetOpzWeulvk9Ik9c9L3gffTDqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417885; c=relaxed/simple;
	bh=nLwbfXLjh76KYCJDtwp4uUc70cyP9UgvAqfStI4uAWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHnAefeNuBcxgYHrEpoJqVe0iV2WtD317CShvHDhwagac1UHteNtVNX60pfyPK8A4PB+ZGY9+W+4Jk/bRRf4uZZ5sbHiJUDdFZYhfWa6wpvtpgzjJb6lin23UwfzNfeO4L/tvVjcA11ev8y3pK/kMRNiV9xzwglX1/e1cG0smdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJFAp-0005dz-GO; Thu, 05 Dec 2024 17:57:55 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJFAo-001r8T-11;
	Thu, 05 Dec 2024 17:57:55 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJFAp-000BbY-01;
	Thu, 05 Dec 2024 17:57:55 +0100
Message-ID: <737b2631320dad9dea71eb786a521d7a1d2100c5.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: add optional reset support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>, Lucas Stach
	 <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LENAIN Simon
 <simon.lenain@thalesgroup.com>,  BARBEAU Etienne
 <etienne.barbeau@thalesgroup.com>, LEJEUNE Sebastien
 <sebastien.lejeune@thalesgroup.com>
Date: Thu, 05 Dec 2024 17:57:54 +0100
In-Reply-To: <dc139d10a4184d289c9ffd1d308c0db1@thalesgroup.com>
References: <dc139d10a4184d289c9ffd1d308c0db1@thalesgroup.com>
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

On Fr, 2024-11-08 at 14:00 +0000, LECOINTRE Philippe wrote:
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
> +
> +	enable_irq(gpu->irq);
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

Please use devm_reset_control_get_optional_exclusive() directly.

regards
Philipp

