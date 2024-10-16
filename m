Return-Path: <linux-kernel+bounces-367703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618D9A059C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688961C21432
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D5205158;
	Wed, 16 Oct 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWqL2wnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386A1C07E7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071316; cv=none; b=vDIYJhcW3qeVl/qsNyz9JW8/ToEqcOUoku/Tbgnjzb7RSJnpoTDttXLM5A9xtzA9pSlUz0MB1ncdWpTPr/+RgWCTEDNAmdAFMufdc9AVhpXizdrRK9hZuodNrfxGqrlDPat6z05mhG7d1ofB3XIBY95rqiu6VfM3wNrt/Jy/GPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071316; c=relaxed/simple;
	bh=F8dkLZRR87Zpj8p9AJe6Uu5JRoeHMVT25dJvUmt3ymE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKSrYvQAYY0pBVOH4NbT5iAXtfsLealVdM6zkExsmok0T+nCYgsUCOnJMg1SVuk2ajS8c/NIlfYeUKH5toZPBDY9cmc7a+wu4txQ5RLpmlPtyuN0m3hL+eUjCW2QcYiq7KJ5WRn0hJaeLKm+Rx/jAj2zDUvE15qe/GpzIzUyXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWqL2wnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D1AC4CEC5;
	Wed, 16 Oct 2024 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071316;
	bh=F8dkLZRR87Zpj8p9AJe6Uu5JRoeHMVT25dJvUmt3ymE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWqL2wnXDBx6Dx7PRTp2mTzR+Xn3SrjmC2l1JIsS6TZrxn9glL8/v4cijINnA5pA2
	 cnPCTvdYFz1d9lpCG6jjCa+unKrmFEdX7df85hrIXBqBcVlF0DbO29QXnwZIxW/x6s
	 2r0jJq70Ss9A3RHgu5DyJXMpYoZmUKDw5uvdE3uwxFKPqonHvzWiqrMcRlpke3A8Xy
	 7BxZBhtivo1FvF23KJe4O/LQbG+WFqQ33nt7BVfxVwTFdRGM5AiRCLxrsJQmNFzHi0
	 8L0KTtBF2NgJesmG4SwyUVbcoVJb93f2yb3GlBDnRZKzKOE2jXdkCvr9vhaib1GEte
	 xkxSSPsW20sAw==
Date: Wed, 16 Oct 2024 11:35:13 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, christian.koenig@amd.com, ray.huang@amd.com, 
	dmitry.baryshkov@linaro.org, dave.stevenson@raspberrypi.com, mcanal@igalia.com, 
	quic_jjohnson@quicinc.com, skhan@linuxfoundation.org, davidgow@google.com, 
	karolina.stolarek@intel.com, Arunpravin.PaneerSelvam@amd.com, 
	thomas.hellstrom@linux.intel.com, asomalap@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drm/tests: helpers: Add helper for
 drm_display_mode_from_cea_vic()
Message-ID: <20241016-poised-athletic-adder-ef2998@houat>
References: <20241014125204.1294934-1-ruanjinjie@huawei.com>
 <20241014125204.1294934-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jt25227utkuyjm4u"
Content-Disposition: inline
In-Reply-To: <20241014125204.1294934-2-ruanjinjie@huawei.com>


--jt25227utkuyjm4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 08:52:01PM GMT, Jinjie Ruan wrote:
> As Maxime suggested, add a new helper
> drm_kunit_helper_display_mode_from_cea_vic(), it can replace
> the direct call of drm_display_mode_from_cea_vic(), and it will
> help solving the `mode` memory leaks.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 40 +++++++++++++++++++++++
>  include/drm/drm_kunit_helpers.h           |  6 ++++
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/=
tests/drm_kunit_helpers.c
> index aa62719dab0e..dc70bafcd394 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -311,6 +311,46 @@ drm_kunit_helper_create_crtc(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
> =20
> +static void kunit_action_drm_mode_destroy(void *ptr)
> +{
> +	struct drm_display_mode *mode =3D ptr;
> +
> +	drm_mode_destroy(NULL, mode);
> +}
> +
> +/**
> + * drm_kunit_helper_display_mode_from_cea_vic() - return a mode for CEA =
VIC
> +						  for a KUnit test
> + * @test: The test context object
> + * @dev: DRM device
> + * @video_code: CEA VIC of the mode
> + *
> + * Creates a new mode matching the specified CEA VIC for a KUnit test.
> + *
> + * Resources will be cleaned up automatically.
> + *
> + * Returns: A new drm_display_mode on success or NULL on failure
> + */
> +struct drm_display_mode *
> +drm_kunit_helper_display_mode_from_cea_vic(struct kunit *test,
> +					   struct drm_device *dev,
> +					   u8 video_code)
> +{
> +	struct drm_display_mode *mode;
> +	int ret;
> +
> +	mode =3D drm_display_mode_from_cea_vic(dev, video_code);
> +
> +	ret =3D kunit_add_action_or_reset(test,
> +					kunit_action_drm_mode_destroy,
> +					mode);
> +	if (ret)
> +		return NULL;
> +
> +	return mode;
> +}
> +EXPORT_SYMBOL_GPL(drm_kunit_helper_display_mode_from_cea_vic);
> +

I think you can drop the "helper" name there, it's usually reserved for
blanket implementation of DRM hooks. This one isn't a hook, so just
calling it drm_kunit_display_mode_from_cea_vic makes a bit more sense to
me.

>  MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>  MODULE_DESCRIPTION("KUnit test suite helper functions");
>  MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_help=
ers.h
> index e7cc17ee4934..1e7fd4be550c 100644
> --- a/include/drm/drm_kunit_helpers.h
> +++ b/include/drm/drm_kunit_helpers.h
> @@ -4,6 +4,7 @@
>  #define DRM_KUNIT_HELPERS_H_
> =20
>  #include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
>
>  #include <linux/device.h>
> =20
> @@ -120,4 +121,9 @@ drm_kunit_helper_create_crtc(struct kunit *test,
>  			     const struct drm_crtc_funcs *funcs,
>  			     const struct drm_crtc_helper_funcs *helper_funcs);
> =20
> +struct drm_display_mode *
> +drm_kunit_helper_display_mode_from_cea_vic(struct kunit *test,
> +					   struct drm_device *dev,
> +					   u8 video_code);

It's not clear to me what you need the drm_edid header, you just return
a drm_display_mode pointer so you can just forward declare the structure

Once fixed
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--jt25227utkuyjm4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZw+IzAAKCRAnX84Zoj2+
dm8KAYCpUBGl0F8vsxxXZYqq9HJtXd+BOY2mJo6Ll/KhbldHuFEF/Vc+IpBzOCC7
5uxQ26oBgLvvctDjOw/Aw+k4wBjK5dMPRSPvk7VDBLAqwwbOv03rkZpckTNu5qzh
WoCQVJNCoA==
=BcMk
-----END PGP SIGNATURE-----

--jt25227utkuyjm4u--

