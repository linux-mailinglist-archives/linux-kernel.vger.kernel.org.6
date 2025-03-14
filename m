Return-Path: <linux-kernel+bounces-561947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D9A61906
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2CE3B7171
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C0202F96;
	Fri, 14 Mar 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEGAuMio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8C3BBE5;
	Fri, 14 Mar 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975706; cv=none; b=gJxjpNPNegeJx9wbUJZ8xqzewSOzbPlBKdAFZAeJ+expRxWmzfFq2mjQE/4T/xboKx2IYslg0MSyW7YqpSp6eWMGsOMXnBp05Zw0Vaq6G5G+BPl9G4fV5PGsJMLEj4GjydIJy5FKpGltaI5gSbqkKm5YI3k2JmSHmAVzRHOyhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975706; c=relaxed/simple;
	bh=pMndPzOi39LiqdZDL0zZ2D/xV+aNKHKbxp2vkbYQzcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmy+H0SGFLky2b+7kOg7GJB3Gh18y6oAdyg+cCFwGeipNC/fsiw/ZFL6Efx581/hv/Bc6ba4W7cZ8wmlb/R+A2L7zkmU0mA9TlPRnAARj4mB+smQqVHogMYBcsbIFKoECC3QPglMKsyHCoZRxp2RH90ycZBgWtPZ3JYpEIhphdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEGAuMio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD0DC4CEE3;
	Fri, 14 Mar 2025 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975705;
	bh=pMndPzOi39LiqdZDL0zZ2D/xV+aNKHKbxp2vkbYQzcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEGAuMioxwmMWMH7D1iLTaJ1TstHwcF5CkjS7V6l1SxaUPZEhUf7Qcw+g/XCFMVui
	 AmygB1SFx8T7kM8igKskWpBDTliayYSZ+Ly1JdSv5HYqyVDrp2rotsOEOA9JAE4+AQ
	 w72KM5ezEX1XdaDBL6Xy1l4SG6Mri7pt/x0Uqkszj/gcLL8Qlv+OmwVbxrfQEqD+GF
	 y0/0w80+BXczoAcY6Ar1YLjdk3sc11iNZr4lp0E+HgJVSnhEco4cCmHzzkwbCQSOPN
	 gJK6lcXQIyPHcxpmtskWzTLykqYKE9kiatCEYyynfZ65S+0rwBlmPl/6blwh8+QPgG
	 Z8k5MQCwq89iQ==
Date: Fri, 14 Mar 2025 19:08:22 +0100
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
Subject: Re: [PATCH v7 05/11] drm/bridge: add a cleanup action for
 scope-based drm_bridge_put() invocation
Message-ID: <20250314-banana-toucanet-of-masquerade-8eeb4e@houat>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
 <20250314-drm-bridge-refcount-v7-5-152571f8c694@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="nzqdgqjykuda4cgv"
Content-Disposition: inline
In-Reply-To: <20250314-drm-bridge-refcount-v7-5-152571f8c694@bootlin.com>


--nzqdgqjykuda4cgv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 05/11] drm/bridge: add a cleanup action for
 scope-based drm_bridge_put() invocation
MIME-Version: 1.0

On Fri, Mar 14, 2025 at 11:31:18AM +0100, Luca Ceresoli wrote:
> Many functions get a drm_bridge pointer, only use it in the function body
> (or a smaller scope such as a loop body), and don't store it. In these
> cases they always need to drm_bridge_put() it before returning (or exiting
> the scope).
>=20
> Some of those functions have complex code paths with multiple return poin=
ts
> or loop break/continue. This makes adding drm_bridge_put() in the right
> places tricky, ugly and error prone in case of future code changes.
>=20
> Others use the bridge pointer in the return statement and would need to
> split the return line to fit the drm_bridge_put, which is a bit annoying:
>=20
>   -return some_thing(bridge);
>   +ret =3D some_thing(bridge);
>   +drm_bridge_put(bridge);
>   +return ret;
>=20
> To make it easier for all of them to put the bridge reference correctly
> without complicating code, define a scope-based cleanup action to be used
> with __free().
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> This patch was added in v7.
> ---
>  include/drm/drm_bridge.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 5c1e2b9cafb12eb429d1f5d3ef312e6cf9b54f47..a5accd64c364ebb57903ae1e7=
459034ad9ebf4f3 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -23,6 +23,7 @@
>  #ifndef __DRM_BRIDGE_H__
>  #define __DRM_BRIDGE_H__
> =20
> +#include <linux/cleanup.h>
>  #include <linux/ctype.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> @@ -995,6 +996,9 @@ static inline struct drm_bridge *drm_bridge_put(struc=
t drm_bridge *bridge)
>  	return bridge;
>  }
> =20
> +/* Cleanup action for use with __free() */
> +DEFINE_FREE(drm_bridge_put, struct drm_bridge *, if (_T) drm_bridge_put(=
_T))
> +

IIRC, drm_bridge_put already checks for the pointer being null before
dereferencing it, right? Then we can probably simplify the macro here.

Either way,

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--nzqdgqjykuda4cgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9RwlgAKCRAnX84Zoj2+
dnRWAYDqJA/VzvRJeITRDaiSnp2e56ZEkITDBPZ7/s3WFGqse2NghJmcSAfLhnuR
0TgauxABfA8DQKzCstRILIp+mDGDhAoLus6nq23qduwVcOmS4bwHSjtg2Al4L1qn
7TGVN2z+zg==
=GY7p
-----END PGP SIGNATURE-----

--nzqdgqjykuda4cgv--

