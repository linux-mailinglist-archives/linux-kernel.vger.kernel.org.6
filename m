Return-Path: <linux-kernel+bounces-422093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5D9D947A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7099161E66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110331B87C2;
	Tue, 26 Nov 2024 09:29:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2E1B413C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613393; cv=none; b=PgPageRdqZMkqbON6uYHfpIdln8kwV30jvce+P4oJf75hAEQ7lApT9Prwz1U3Xe7W74iupDZoNFDeQaTT5QYhjG3z3YV9v/pSw8g0JFQO3ovDZIDwgvLn1PM9DiOYTPSKFqi/UD8JnpRTwalBNG4IPK8ZYJJ8JaonE6x/cHudfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613393; c=relaxed/simple;
	bh=+TV9OkllNR5xS/4pW/hZcS8f9O/25pyCeKXiGLdXnfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8JC0w7abqLUFHYErPoozRWGrNR8lPmZDtJGD/idAZhW4zrLOvCwS/5f89C5UwM/FOC3vjcCXwXo6EyGga/7AKbPSuYjXtTujMAe1RVKCwiwW/oz225ND33EzEvARgpt/ARZDksrt926XdpsNaMLhzlpXw/2WjQ/2auYzApC7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFrsv-0007BB-JZ; Tue, 26 Nov 2024 10:29:29 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFrst-000E0I-18;
	Tue, 26 Nov 2024 10:29:28 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFrsu-0001mR-09;
	Tue, 26 Nov 2024 10:29:28 +0100
Message-ID: <74d4fc4c6f08fde2d6759633cb2280ecb18cbd91.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] drm/imagination: add reset control support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Parthiban Nallathambi <parthiban@linumiz.com>, Frank Binns
 <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 26 Nov 2024 10:29:27 +0100
In-Reply-To: <20241125-pvr-reset-v1-2-b437b8052948@linumiz.com>
References: <20241125-pvr-reset-v1-0-b437b8052948@linumiz.com>
	 <20241125-pvr-reset-v1-2-b437b8052948@linumiz.com>
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

On Mo, 2024-11-25 at 22:07 +0530, Parthiban Nallathambi wrote:
> On some platforms like Allwinner A133 with GE8300 includes
> reset control from reset control unit. Add reset control
> optionally from the devicetree.
>=20
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.h |  8 ++++++++
>  drivers/gpu/drm/imagination/pvr_drv.c    |  5 +++++
>  drivers/gpu/drm/imagination/pvr_power.c  | 16 +++++++++++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/i=
magination/pvr_device.h
> index 6d0dfacb677b..21ec7dd64415 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.h
> +++ b/drivers/gpu/drm/imagination/pvr_device.h
> @@ -23,6 +23,7 @@
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/mutex.h>
> +#include <linux/reset.h>
>  #include <linux/spinlock_types.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
> @@ -131,6 +132,13 @@ struct pvr_device {
>  	 */
>  	struct clk *mem_clk;
> =20
> +	/**
> +	 * @reset: Optional reset control
> +	 *
> +	 * This may be used on some platforms to reset the GPU module/IP.
> +	 */
> +	struct reset_control *reset;
> +
>  	/** @irq: IRQ number. */
>  	int irq;
> =20
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index fb17196e05f4..d9b918410ea9 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/xarray.h>
> =20
>  /**
> @@ -1427,6 +1428,10 @@ pvr_probe(struct platform_device *plat_dev)
>  	pm_runtime_use_autosuspend(&plat_dev->dev);
>  	pvr_watchdog_init(pvr_dev);
> =20
> +	pvr_dev->reset =3D devm_reset_control_get_optional_exclusive(&plat_dev-=
>dev, "ahb");
> +	if (PTR_ERR(pvr_dev->reset) =3D=3D -EPROBE_DEFER)
> +		return PTR_ERR(pvr_dev->reset);

	pvr_dev->reset =3D devm_reset_control_get_optional_exclusive(&plat_dev->de=
v, "ahb");
	if (IS_ERR(pvr_dev->reset))
		return PTR_ERR(pvr_dev->reset);

Please don't ignore errors. devm_reset_control_get_optional_exclusive()
returns NULL if the "ahb" reset control isn't specified in the device
tree, and the reset_control_assert/deassert() functions accept that as
a non-existing reset, see [1].

[1] https://docs.kernel.org/driver-api/reset.html#optional-resets

> +
>  	err =3D pvr_device_init(pvr_dev);
>  	if (err)
>  		goto err_watchdog_fini;
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index ba7816fd28ec..a24ed85f36c7 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -15,6 +15,7 @@
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> @@ -252,6 +253,9 @@ pvr_power_device_suspend(struct device *dev)
>  	clk_disable_unprepare(pvr_dev->sys_clk);
>  	clk_disable_unprepare(pvr_dev->core_clk);
> =20
> +	if (!IS_ERR(pvr_dev->reset))
> +		reset_control_assert(pvr_dev->reset);

	reset_control_assert(pvr_dev->reset);

This just returns 0 if pvr_dev->reset =3D=3D NULL.

> +
>  err_drm_dev_exit:
>  	drm_dev_exit(idx);
> =20
> @@ -270,9 +274,15 @@ pvr_power_device_resume(struct device *dev)
>  	if (!drm_dev_enter(drm_dev, &idx))
>  		return -EIO;
> =20
> +	if (!IS_ERR(pvr_dev->reset)) {
> +		err =3D reset_control_reset(pvr_dev->reset);
> +		if (err)
> +			goto err_drm_dev_exit;
> +	}

	err =3D reset_control_reset(pvr_dev->reset);
	if (err)
		goto err_drm_dev_exit;

> +
>  	err =3D clk_prepare_enable(pvr_dev->core_clk);
>  	if (err)
> -		goto err_drm_dev_exit;
> +		goto err_reset_exit;
> =20
>  	err =3D clk_prepare_enable(pvr_dev->sys_clk);
>  	if (err)
> @@ -301,6 +311,10 @@ pvr_power_device_resume(struct device *dev)
>  err_core_clk_disable:
>  	clk_disable_unprepare(pvr_dev->core_clk);
> =20
> +err_reset_exit:
> +	if (!IS_ERR(pvr_dev->reset))
> +		reset_control_assert(pvr_dev->reset);

err_reset_exit:
	reset_control_assert(pvr_dev->reset);

> +
>  err_drm_dev_exit:
>  	drm_dev_exit(idx);
> =20
>=20

regards
Philipp

