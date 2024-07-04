Return-Path: <linux-kernel+bounces-241046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530092763C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4C31F242AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC726289;
	Thu,  4 Jul 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNraHRvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51A1AB51B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097168; cv=none; b=ebd73PaXqmOTbxA0qflDdvqg0bGoCNNk9FqdLDSibssz1HeyU2UNIvcXcpwmw6CWz1CnPa56FG+eIZN3uM+rxzqGFPPN4Hj1p9wk3kMJPosVlymT1D54q7SH4TSNSLxN36owRpk0OeXyFWrr01OE2ZtQWqHb3HXhk0tdo95VSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097168; c=relaxed/simple;
	bh=1qWmm6XjrlUwsQJPzKcSMSfddvtOQZ5Ao7DnMFxneuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECnmRhKZE4IUYsbwd3PaJ/IZjctF09qPUGnD1EgBALTck2n6KqS2xaiW0tm7AHRkLUV6IHAsR1B71EwK7eezu67gDDNenFntkiXHDlhUc6cPg03hkqmLeKv/vg35oZu266kG4OLCqHYaZOIE/wENyQvNPrrma/PGtMoB8Ck/daw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNraHRvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C829C3277B;
	Thu,  4 Jul 2024 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720097168;
	bh=1qWmm6XjrlUwsQJPzKcSMSfddvtOQZ5Ao7DnMFxneuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNraHRvVdmue1bEZNzHIo2hecWjHgxAkInCOUgJM5YyTHw7SyHtY50pfNuiQr4wCL
	 pEHFdb/9MBO6vLgFo2YfIpvbDEyxF+i6/3zIfD7nHMLGW4D6dZolKnMwj3dzRsPz0r
	 VtjtvKYMSO+mDLxwwq8SM3IBID+KOQ4BGkSjK0ptu2nd9WV3nYwHLgsPlHnZVZMunk
	 CGVpiXQpX5YuGvHT3GVex2Pt9vu1F7dLFomINj2voCxDF6FDqD1Xwox0FjF4EPkntY
	 Gk3KUwpFLCBPXPLjxjSXPvoC1NjvDzoEPkCoUIwnCLuzsXH3DjHggIxxmMqj57yDvh
	 wyH0Ba94axAzw==
Date: Thu, 4 Jul 2024 14:46:05 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] drm/drm_property: require DRM_MODE_PROP_IMMUTABLE
 for single-value props
Message-ID: <20240704-magnetic-cocky-hawk-a5cfe9@houat>
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
 <20240702-drm-bridge-connector-fix-hdmi-reset-v3-1-12b0e3124ca4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w5zuytjnfohfjfgo"
Content-Disposition: inline
In-Reply-To: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-1-12b0e3124ca4@linaro.org>


--w5zuytjnfohfjfgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 12:48:52PM GMT, Dmitry Baryshkov wrote:
> Document that DRM_MODE_PROP_IMMUTABLE must be set for the properties
> that are immutable by definition - e.g. ranges with min =3D=3D max or enu=
ms
> with a single value. This matches the behaviour of the IGT tests, see
> kms_properties.c / validate_range_prop(), validate_enum_prop(),
> validate_bitmask_prop().
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  include/drm/drm_property.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> index 082f29156b3e..7d0f793f50ca 100644
> --- a/include/drm/drm_property.h
> +++ b/include/drm/drm_property.h
> @@ -162,6 +162,9 @@ struct drm_property {
>  	 *     userspace, e.g. the EDID, or the connector path property on DP
>  	 *     MST sinks. Kernel can update the value of an immutable property
>  	 *     by calling drm_object_property_set_value().
> +	 *     This flag should be set for all properties that have only a
> +	 *     single value (e.g. min =3D=3D max or if enum has only a single
> +	 *     value).

Given the IGT test, I think it should be a must, not a should.

Maxime

--w5zuytjnfohfjfgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoaZjQAKCRDj7w1vZxhR
xYNMAP4pPoXtV/8TZeOVseYJlA3QZ4iQPPmOElkvzWIVkh7DrAEAr862SWkiPWq6
0L04mnkplcEV0Ge/6Sb8n50qP8EA+Qg=
=XfbK
-----END PGP SIGNATURE-----

--w5zuytjnfohfjfgo--

