Return-Path: <linux-kernel+bounces-560836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB0A609F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CE7A78D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1CA158DC4;
	Fri, 14 Mar 2025 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZJUWeP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE513D279;
	Fri, 14 Mar 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936628; cv=none; b=tYDoj59iekxFEVaI+9CNSs0RsMOkHwnrDCw2p2TnaiyqwRct1e1IOdk2cVPl6k4ORKspQPkLXdjNkVRD7MZ+NUALyo3Fc0eKAb1vforjpv7W4/RLQMjwclp0tgyJO/1QtT8RjjOwIy9w7SVbOnr0wnPZxmQI2VriRTCYdiR9Fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936628; c=relaxed/simple;
	bh=UQ9+UxxXMrfNzmzYIXUgXpda8cS4hyKtx7pSVVB4XT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WslolDbRoGxgMdBs81XopVvX6XbqpkvHI5mS9dWfAMFaXBBfr3Kk+RnPkYq7bu77QX9VmDd3gpnssqzvp875buUiqzGHjfGqnbApT/GBnbmjwBk2S8ZrjOr37Wuv9dRbcc6nTqfB3EI2Ww5U4BYUjwnsivxDFYnwjKZgnoSKAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZJUWeP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B100C4CEE3;
	Fri, 14 Mar 2025 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741936627;
	bh=UQ9+UxxXMrfNzmzYIXUgXpda8cS4hyKtx7pSVVB4XT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZJUWeP3sHk6WCJL0OtYdbiCuY/p+7aX9aOSQ5yYdne4MyGWo/SNiSeMrs1gYa+JO
	 CWwzl04PnwppTgZp8gLgNPVG5202ypbgmU2+TjMJuSKYHHOVdcVkQ7JeaCyHz63Vc4
	 yWtuEBPoUM45XMJle6OmEdnV9w1PH9lwGWqTT3vTpWOvue1kLL8noa57uuzJh9Jh+B
	 lCMpnwKHoFrjFVBL36k1eflre4uvWPrckExcnzh1t/UfGeQYnQcVnEir5wE9wAFYsd
	 7xXzAGwysS+21vOCMj9FdBfiGWEi+PuhZYCgD6viaU1zfl5o7laAY45ofEvF1GrLlq
	 fLQqcA28rGXaw==
Date: Fri, 14 Mar 2025 08:17:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: wens@csie.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, jernej.skrabec@gmail.com, samuel@sholland.org, 
	neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: backend: Fix error pointers in
 sun4i_backend_atomic_check
Message-ID: <20250314-prophetic-attentive-platypus-3ab214@houat>
References: <20250314012029.668306-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="6q3hnszpv4smntsm"
Content-Disposition: inline
In-Reply-To: <20250314012029.668306-1-chenyuan0y@gmail.com>


--6q3hnszpv4smntsm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/sun4i: backend: Fix error pointers in
 sun4i_backend_atomic_check
MIME-Version: 1.0

Hi,

On Thu, Mar 13, 2025 at 08:20:29PM -0500, Chenyuan Yang wrote:
> The function sun4i_backend_atomic_check was dereferencing pointers
> returned by drm_atomic_get_plane_state without checking for errors. This
> could lead to undefined behavior if the function returns an error pointer.
>=20
> This commit adds checks using IS_ERR to ensure that plane_state is
> valid before dereferencing them.
>=20
> Similar to commit da29abe71e16
> ("drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_changed"=
).
>=20
> Fixes: 96180dde23b7 ("drm/sun4i: backend: Add a custom atomic_check for t=
he frontend")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4=
i/sun4i_backend.c
> index 2dded3b828df..a8e0e2123764 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -490,6 +490,10 @@ static int sun4i_backend_atomic_check(struct sunxi_e=
ngine *engine,
>  	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
>  		struct drm_plane_state *plane_state =3D
>  			drm_atomic_get_plane_state(state, plane);
> +
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +

This introduces a build warning. You shouldn't mix declarations and code.

Maxime

--6q3hnszpv4smntsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9PX8AAKCRAnX84Zoj2+
digtAYDNEX1uj/4n3Y1V97Pum0BMwqi1SG9ZsgnDjPQggA14QSrt5669uvj0YJTA
3iABKQIBgMzzgD0FMGNquJ6X6rm3DTbMEwkB184/UVSwGcm7tvHmz5pua6n6Vv8l
gD3dBQbbBw==
=ecRp
-----END PGP SIGNATURE-----

--6q3hnszpv4smntsm--

