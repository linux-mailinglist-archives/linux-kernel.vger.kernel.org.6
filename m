Return-Path: <linux-kernel+bounces-449464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954A9F4F66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DD41884304
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508401F7564;
	Tue, 17 Dec 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB+9DGMZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01F1F7545
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449145; cv=none; b=EXmMLwwWNXXfSDgNrh3pwtsiAX18jLIxGMRI0r9CmNRpERMpEGWo0yDPxTbPHiqX07OWMi3Haei22pb8j88o8NmLgThfc0fLitCWnLumrVZivWVw8q3/oHqvgeUyLsug/XYfr0JgNEuvl03kGzXwuexTMan9pgKv7ee4SCj1014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449145; c=relaxed/simple;
	bh=t4lCHfM/mAXjrGE7S2qLAcIcLim63yxLOA1JiYXXEZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea/gukv+8rFm7X5uHqbW8GerYrqcl3ge0rJW1NUtxU5zfuY7ncH7SXfpzJuAzZpqDqugTDnRKKO2ZaojlsYzrHtV9sYRwCSdX6Nf3prQkPUfR3DMAIygfGNr9bKkjHkqniXSp0rtajqzHzjvjYhGXNK04reQdvVnX10HPZH/8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB+9DGMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0602C4CED3;
	Tue, 17 Dec 2024 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449145;
	bh=t4lCHfM/mAXjrGE7S2qLAcIcLim63yxLOA1JiYXXEZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JB+9DGMZjhGVVSVR4UMhvdDnGxYdn/XBj1Np07pPvw5tpcylZICq9ARb9nRPFSyzT
	 dkNF2Ykpam041FTbbCn4AQ7QXsrcZqJNGgPAEtx2zoIIGD9JnjelmasFcnaSZUaZVL
	 +OFa572UYHn5kjCq0QzECvlJzgFiJVCsbJLFc0uNROsuIj7eCy1W+P/n2nhecFNFB6
	 yXBSWbJ2auW28tRtClB8btu8yV2qj7DFT81Y+i6cGcUObLV9E+SOTTc7I9FT0ELt5H
	 e9y5g6GfSjh2VINNc3h5tZRCAwg5YwCJkKyXGdskfSDma41qtT4NE5TuXrapQyl5yY
	 jPA/ULH7MVswA==
Date: Tue, 17 Dec 2024 16:25:42 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/connector: hdmi: Validate supported_formats
 matches ycbcr_420_allowed
Message-ID: <20241217-positive-elephant-of-resistance-f4b0ee@houat>
References: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
 <20241217-bridge-conn-fmt-prio-v3-2-3ecb3c8fc06f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4265vgf3cwvr5hxk"
Content-Disposition: inline
In-Reply-To: <20241217-bridge-conn-fmt-prio-v3-2-3ecb3c8fc06f@collabora.com>


--4265vgf3cwvr5hxk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] drm/connector: hdmi: Validate supported_formats
 matches ycbcr_420_allowed
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 12:54:08AM +0200, Cristian Ciocaltea wrote:
> Ensure HDMI connector initialization fails when the presence of
> HDMI_COLORSPACE_YUV420 in the given supported_formats bitmask doesn't
> match the value of drm_connector->ycbcr_420_allowed.
>=20
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index fc35f47e2849ed6786d6223ac9c69e1c359fc648..ca7f43c8d6f1b31ef9d3a1ee0=
5f4df930ecffac4 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -507,6 +507,9 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  	if (!supported_formats || !(supported_formats & BIT(HDMI_COLORSPACE_RGB=
)))
>  		return -EINVAL;
> =20
> +	if (connector->ycbcr_420_allowed !=3D !!(supported_formats & BIT(HDMI_C=
OLORSPACE_YUV420)))
> +		return -EINVAL;
> +
>  	if (!(max_bpc =3D=3D 8 || max_bpc =3D=3D 10 || max_bpc =3D=3D 12))
>  		return -EINVAL;

The patch looks fine to me, but we need to have unit tests to cover this ca=
se.

Maxime

--4265vgf3cwvr5hxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2GX9QAKCRAnX84Zoj2+
dlp/AX4zhUV/n+9WsZi3Av1I13uIvegSxFQT8yccNd/y1z8YEFM9hjmseO40j8u4
yCx7rkwBfjXrK85HiBud+46zgKwK9REjzNjetipHdPzSs+uMS/UPq6vtswXwAb9d
YVZ9uSF5Og==
=P8wk
-----END PGP SIGNATURE-----

--4265vgf3cwvr5hxk--

