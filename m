Return-Path: <linux-kernel+bounces-561960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E0A6194D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2DB3AB8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB720468F;
	Fri, 14 Mar 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1wVNbwK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3182A8D0;
	Fri, 14 Mar 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976464; cv=none; b=SVi26ea7O5bV7XAZw7HmOCKHWWgRIcLCPtUKFnfsbXUuFYfvu4dtJKRziVhAVzEFgbXWYccnxUJk/R9ABkLzqpeTVBTMxNOkX+r86yOpzfEa8txDNNBVXIvqi1BZOxNc4vI2ukcPEM9Nsq1sqRwxuk2jGSrlYaTSQfLP4SpiYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976464; c=relaxed/simple;
	bh=kl2X8mVwSaZH4P+oC1wMNXj/evjiX1wGJ3tMBcCpssU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0l5siCqUDgi3L0AYCO9Pcgy700mwjCpKHIADrMfB80R4DoxDEdUfvK0Y+mb6wLSfygpccnnJt3KXmK9g4oXDeTtkgpIrUc66XHydgjsncnWZ1UGQBqELnnMpf2Yzzp6YV52lUJnXgfPPAMc/2pbozgnYX3huSUOmPTariNBa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1wVNbwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB48C4CEE3;
	Fri, 14 Mar 2025 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741976464;
	bh=kl2X8mVwSaZH4P+oC1wMNXj/evjiX1wGJ3tMBcCpssU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1wVNbwKbDzm3i2OHiUkdhMC2cbWxtIPNWUQYV9lrxpezJqu7/HcWGVSBkBHgv48N
	 h+BdVTb3qNZMfrDpcM3B4GZ/PhumzL62IDZidEjyswRZCpH2TfYb31PUyXpr3wT7yY
	 USIdnYdZ0h+c0sB/4qMNrorcGKWJUs0IJ3GZAQIhAy/YdIoEGX3IHc5/sTg9g8F78W
	 rI2IIP5+93xW68HrYA/Sl2+m6OSHtXcW6+9gLZ6OmF40AudM8wVzRSALKjgjMPAvOi
	 /7AkeQFVPNQkFJhs0h9XNEqOYZAyRlkufGEHwC2oukZrkODksegJdB9AqZLVZ1aLOK
	 bBAuiJCUSEr7w==
Date: Fri, 14 Mar 2025 19:21:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Anusha Srivatsa <asrivats@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Dmitry Baryshkov <lumag@kernel.org>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 00/11] drm/bridge: add devm_drm_bridge_alloc() with
 bridge refcount
Message-ID: <20250314-daft-woodoo-cheetah-e029c5@houat>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mifitjekzidylpjw"
Content-Disposition: inline
In-Reply-To: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>


--mifitjekzidylpjw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 00/11] drm/bridge: add devm_drm_bridge_alloc() with
 bridge refcount
MIME-Version: 1.0

Hi,

On Fri, Mar 14, 2025 at 11:31:13AM +0100, Luca Ceresoli wrote:
> This series improves the way DRM bridges are allocated and initialized and
> makes them reference-counted. The goal of reference counting is to avoid
> use-after-free by drivers which got a pointer to a bridge and keep it
> stored and used even after the bridge has been deallocated.
>=20
> The overall goal is supporting Linux devices with a DRM pipeline whose
> final components can be hot-plugged and hot-unplugged, including one or
> more bridges. For more details see the big picture [0].
>=20
> DRM bridge drivers will have to be adapted to the new API, which is pretty
> simple for most cases. Refcounting will have to be adopted on the two
> sides: all functions returning a bridge pointer and all code obtaining su=
ch
> a pointer. This series has just an overview of some of those conversions,
> because for now the main goal is to agree on the API.
>=20
> Series layout:
>=20
>  1. Add the new API and refcounting:
>=20
>     drm/bridge: add devm_drm_bridge_alloc()
>     drm/bridge: add support for refcounting
>=20
>  2. get/put the reference in basic operations in the bridge core:
>=20
>     drm/bridge: get/put the bridge reference in drm_bridge_add/remove()
>     drm/bridge: get/put the bridge reference in drm_bridge_attach/detach()
>=20
>  3. as an example of changes for bridge consumers, get a reference for the
>     bridge returned by drm_bridge_chain_get_first_bridge(), have it put by
>     all callers (all users will be covered later on separately):
>=20
>     drm/bridge: add a cleanup action for scope-based drm_bridge_put() inv=
ocation
>     drm/bridge: get the bridge returned by drm_bridge_chain_get_first_bri=
dge()
>     drm/mxsfb: put the bridge returned by drm_bridge_chain_get_first_brid=
ge()
>     drm/atomic-helper: put the bridge returned by drm_bridge_chain_get_fi=
rst_bridge()
>     drm/probe-helper: put the bridge returned by drm_bridge_chain_get_fir=
st_bridge()
>=20
>  4. convert a few bridge drivers (bridge providers) to the new API:
>=20
>     drm/bridge: ti-sn65dsi83: use dynamic lifetime management
>     drm/bridge: samsung-dsim: use dynamic lifetime management
>=20
> This work was formerly a part of my v6 DRM bridge hotplug series[0], now
> split as a standalone series with many improvements, hence the "v7" versi=
on
> number.

Except for one patch where I had comments, I think the series is in
excellent shape. We're still missing a couple of things to close this
topic though:

  - Converting the other bridge iterators/accessors to take / put the refer=
ences
  - Mass converting the drivers to devm_drm_bridge_alloc
  - Documenting somewhere (possibly in drm_bridge_init?) that it really
    shouldn't be used anymore

Maxime

--mifitjekzidylpjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9RzjQAKCRAnX84Zoj2+
diSPAYD12sjIXgXPRf7BpM6STJktvb89YmsuXfj5+lHzeniMrs6Zp+V4ziemLado
cqXTAAgBfj5T5uiMZqBaPy+UxbyoWpdNB5xJ8B5O7i7F+qiCLQoCXZjhFQdI1vaR
wbgQnB8LMA==
=oW4m
-----END PGP SIGNATURE-----

--mifitjekzidylpjw--

