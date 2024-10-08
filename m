Return-Path: <linux-kernel+bounces-354717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB999419D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C188283392
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4C1FCC58;
	Tue,  8 Oct 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkDNjCv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8CB676;
	Tue,  8 Oct 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374001; cv=none; b=CsQfaz3oMggieumFl5i2DuqLH25ssu+LxLOif0OE68CenF74+vOZOhdH4P/Mt0wEk7zPPOPI8UvAYOiZ2N/vSzM22z33aOYrjX90sAdpOAzZtiIAUVQ7qs8LTeHHmHdj3+Tt/hy1/d+11cEY57Ld8KH2SYnSc9aJdTDvY3bLSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374001; c=relaxed/simple;
	bh=ZolOtss5LdxgK0cQ4wMklPeLLWy8E7FsrWTQCKegLW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIa60PcxYsX6HyEUcNAcBt3dGNnx81WFwV3S2imxZz+EihfTZrG5QdYLScugd+TC+iOJKaYlO7/lQ2uV7tS5+XJMX3c4Z7yczlinDKO03ubhiN8qInA9I+WFYbxJWmwDKtbsJRUSnzWkerAAWXOygsU1Wwx2MnUSTdbKuNhxlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkDNjCv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF3BC4CEC7;
	Tue,  8 Oct 2024 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728374001;
	bh=ZolOtss5LdxgK0cQ4wMklPeLLWy8E7FsrWTQCKegLW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkDNjCv2cXGTLUY1GG3QCMxnvSAF/v8dl3/+C9zhVZUMVWVAfpDgtwnBl3xQ0ogZC
	 gPQl30l4yIKNxn6HIP+A+r9I9umxl3oZWlpjA/XWNZH90dc7vd2tHi/1RwK8OpEW3L
	 +AEi7/GNtBleExcKSvi1jlvSlAYLk+VAGcQjPHcS6iIyp0W4a0n98aeYODNqmgWGj0
	 fFw9/34IzKBZ9xZHNiGoZRN018MSKpcCrFpzEoMdS+axVf/MRffno5GtNgjwROOJDz
	 HavbcbWZTgU45kPlJEWGrlmXMf3blYFHRFaIB20zJMOST9PFUpBlVmCUlDPC3rWNdW
	 AIBtvA9ToB8cQ==
Date: Tue, 8 Oct 2024 09:53:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org, 
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
	Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, jeremie.dautheribes@bootlin.com, 
	miquel.raynal@bootlin.com, seanpaul@google.com, marcheu@google.com, 
	nicolejadeyee@google.com, Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v12 13/15] drm/vkms: Create KUnit tests for YUV
 conversions
Message-ID: <20241008-ingenious-calm-silkworm-3e99ba@houat>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="wyrq7ipcxm5yvck5"
Content-Disposition: inline
In-Reply-To: <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>


--wyrq7ipcxm5yvck5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 07, 2024 at 06:10:47PM GMT, Louis Chauvet wrote:
> From: Arthur Grillo <arthurgrillo@riseup.net>
>=20
> Create KUnit tests to test the conversion between YUV and RGB. Test each
> conversion and range combination with some common colors.
>=20
> The code used to compute the expected result can be found in comment.
>=20
> [Louis Chauvet:
> - fix minor formating issues (whitespace, double line)
> - change expected alpha from 0x0000 to 0xffff
> - adapt to the new get_conversion_matrix usage
> - apply the changes from Arthur
> - move struct pixel_yuv_u8 to the test itself]
>=20
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/Kconfig                  |  15 ++
>  drivers/gpu/drm/vkms/Makefile                 |   1 +
>  drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
>  drivers/gpu/drm/vkms/tests/Makefile           |   3 +
>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 232 ++++++++++++++++++++=
++++++
>  drivers/gpu/drm/vkms/vkms_formats.c           |   7 +-
>  drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
>  7 files changed, 265 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
> index 9def079f685b..98ecfce929f3 100644
> --- a/drivers/gpu/drm/vkms/Kconfig
> +++ b/drivers/gpu/drm/vkms/Kconfig
> @@ -14,3 +14,18 @@ config DRM_VKMS
>  	  a VKMS.
> =20
>  	  If M is selected the module will be called vkms.
> +
> +config DRM_VKMS_KUNIT_TESTS
> +	tristate "KUnit tests for VKMS." if !KUNIT_ALL_TESTS
> +	depends on DRM_VKMS=3Dy && KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds unit tests for VKMS. This option is not useful for
> +	  distributions or general kernels, but only for kernel
> +	  developers working on VKMS.
> +
> +	  For more information on KUnit and unit tests in general,
> +	  please refer to the KUnit documentation in
> +	  Documentation/dev-tools/kunit/.
> +
> +	  If in doubt, say "N".
> diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
> index 1b28a6a32948..8d3e46dde635 100644
> --- a/drivers/gpu/drm/vkms/Makefile
> +++ b/drivers/gpu/drm/vkms/Makefile
> @@ -9,3 +9,4 @@ vkms-y :=3D \
>  	vkms_writeback.o
> =20
>  obj-$(CONFIG_DRM_VKMS) +=3D vkms.o
> +obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) +=3D tests/
> diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vk=
ms/tests/.kunitconfig
> new file mode 100644
> index 000000000000..70e378228cbd
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_DRM=3Dy
> +CONFIG_DRM_VKMS=3Dy
> +CONFIG_DRM_VKMS_KUNIT_TESTS=3Dy
> diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/t=
ests/Makefile
> new file mode 100644
> index 000000000000..2d1df668569e
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/tests/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) +=3D vkms_format_test.o
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/=
drm/vkms/tests/vkms_format_test.c
> new file mode 100644
> index 000000000000..351409897ca3
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <kunit/test.h>
> +
> +#include <drm/drm_fixed.h>
> +#include <drm/drm_fourcc.h>
> +
> +#include "../../drm_crtc_internal.h"
> +
> +#include "../vkms_formats.h"
> +
> +#define TEST_BUFF_SIZE 50
> +
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +
> +struct pixel_yuv_u8 {
> +	u8 y, u, v;
> +};
> +
> +struct yuv_u8_to_argb_u16_case {
> +	enum drm_color_encoding encoding;
> +	enum drm_color_range range;
> +	size_t n_colors;
> +	struct format_pair {
> +		char *name;
> +		struct pixel_yuv_u8 yuv;
> +		struct pixel_argb_u16 argb;
> +	} colors[TEST_BUFF_SIZE];
> +};
> +
> +/*
> + * The YUV color representation were acquired via the colour python fram=
ework.
> + * Below are the function calls used for generating each case.
> + *
> + * For more information got to the docs:
> + * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr=
=2Ehtml
> + */
> +static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] =3D {
> +	/*
> +	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
> +	 *                     K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.601"],
> +	 *                     in_bits =3D 16,
> +	 *                     in_legal =3D False,
> +	 *                     in_int =3D True,
> +	 *                     out_bits =3D 8,
> +	 *                     out_legal =3D False,
> +	 *                     out_int =3D True)
> +	 */

We should really detail what the intent and expected outcome is supposed
to be here. Relying on a third-party python library call for
documentation isn't great.

Maxime

--wyrq7ipcxm5yvck5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZwTk5gAKCRAnX84Zoj2+
druTAX4hTMoQugVai2QJ1+0Eza191utfm5RxJ0Zb9dWjGrTw2VnJBbVpSX2hSlev
HllnwM4BgKEgEV2a4hCAoF+4oR8w66ZHex4NLxAaZjmjt93QEVw2BmSgrhCgspOi
zV2j+K+8fA==
=/NOH
-----END PGP SIGNATURE-----

--wyrq7ipcxm5yvck5--

