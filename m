Return-Path: <linux-kernel+bounces-369735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB69A21EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D221C2138A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD11DD0F2;
	Thu, 17 Oct 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ/QLe9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3881DD0E0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167208; cv=none; b=haSXjtOWELXVlzJaeFj0DSD3UfXPnpIrz1bt9NYQ9oD444Bih02OmHW+vC7k/f6WNSyDIPegX26qtpveiGqrjaQX601RP11GHPP2ARxz2g4t1BHTWPNudpKSGBZkNadQUzy/GwiaqgbD7dCn5wM/Ztxz4z0H1SKwiHnU/9wzrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167208; c=relaxed/simple;
	bh=FZrh2cYXSymBvwhsnn+sY5mjJHV0HuES4LzynSZHkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpD/oPWGG4kQuIJaFENKLOQRcCtugCqsRP0KOiI+2AM7q5V3NX7bmLQG54ARUKeQZfa4nFqiUpTJvFYDYBU/Uw4FcN4INoXSYfG1qOcOZSe9YKH2l2q53lxkFQfjtm9/0luLJZuCvCR6ya2K6jbN5evwMFVVpOU03iIT9kKlMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ/QLe9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0459C4CEC3;
	Thu, 17 Oct 2024 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729167205;
	bh=FZrh2cYXSymBvwhsnn+sY5mjJHV0HuES4LzynSZHkyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJ/QLe9Fl2ZF0wDKwObrrbSp4f57etrtYEhUwJ1YIA1e0QCwyrTrvUYmSps+gO70M
	 AIdKg7p2yNm0EwiUZsYG6sSnYcaXXzwA9wnJkdL/m7KMUvlreBvpnUReo+yy4cvtaK
	 UCv7dSYUn/QGf1WlUbi32YGLXnrpdw0RMUR2j+GWP/FsPPYuN+on3WUgse2V7R2fIN
	 ATyscKmNIc4RENBJhPPQrm3XlH+bjyflr+Khs+QAfUqPVkIC48hISH8WjBbcLzPLRR
	 SzBLVeNSJ/st4MryBYoOHqNwAougUPuvurlJabVZ9TZN4vYuWXIK0MJXMwl2e0PGlM
	 jkZB8lo7SQ5kw==
Date: Thu, 17 Oct 2024 14:13:21 +0200
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
Message-ID: <20241017-fearless-terrier-from-avalon-b9769f@houat>
References: <20241014125204.1294934-1-ruanjinjie@huawei.com>
 <20241014125204.1294934-2-ruanjinjie@huawei.com>
 <20241016-poised-athletic-adder-ef2998@houat>
 <8ddc72c9-8662-59d0-c3b6-904f2688cb29@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jr3n2neihasnwj2m"
Content-Disposition: inline
In-Reply-To: <8ddc72c9-8662-59d0-c3b6-904f2688cb29@huawei.com>


--jr3n2neihasnwj2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 09:33:07AM GMT, Jinjie Ruan wrote:
> >> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_h=
elpers.h
> >> index e7cc17ee4934..1e7fd4be550c 100644
> >> --- a/include/drm/drm_kunit_helpers.h
> >> +++ b/include/drm/drm_kunit_helpers.h
> >> @@ -4,6 +4,7 @@
> >>  #define DRM_KUNIT_HELPERS_H_
> >> =20
> >>  #include <drm/drm_drv.h>
> >> +#include <drm/drm_edid.h>
> >>
> >>  #include <linux/device.h>
> >> =20
> >> @@ -120,4 +121,9 @@ drm_kunit_helper_create_crtc(struct kunit *test,
> >>  			     const struct drm_crtc_funcs *funcs,
> >>  			     const struct drm_crtc_helper_funcs *helper_funcs);
> >> =20
> >> +struct drm_display_mode *
> >> +drm_kunit_helper_display_mode_from_cea_vic(struct kunit *test,
> >> +					   struct drm_device *dev,
> >> +					   u8 video_code);
> >=20
> > It's not clear to me what you need the drm_edid header, you just return
> > a drm_display_mode pointer so you can just forward declare the structure
>=20
>=20
> There is a compile error without the header=EF=BC=8Cbecause there is no
> "drm_display_mode_from_cea_vic()" declare.
>=20
> drivers/gpu/drm/tests/drm_kunit_helpers.c:341:16: error: implicit
> declaration of function =E2=80=98drm_display_mode_from_cea_vic=E2=80=99; =
did you mean
> =E2=80=98drm_kunit_display_mode_from_cea_vic=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   341 |         mode =3D drm_display_mode_from_cea_vic(dev, video_code);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                drm_kunit_display_mode_from_cea_vic
> drivers/gpu/drm/tests/drm_kunit_helpers.c:341:14: warning: assignment to
> =E2=80=98struct drm_display_mode *=E2=80=99 from =E2=80=98int=E2=80=99 ma=
kes pointer from integer
> without a cast [-Wint-conversion]
>   341 |         mode =3D drm_display_mode_from_cea_vic(dev, video_code);
>       |              ^

Right, but the error is in the C file, not the header.

Maxime

--jr3n2neihasnwj2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxD/YAAKCRAnX84Zoj2+
dgqwAX9Cl1tRywgR6t4UbBMXW2l8tdFFiFYGwo/RwCqlmNME7a2m3LOA+UEPwKMZ
h2djCgEBgOukMQIw3mWIdAEkUtuwe2MNdopAp1rNumoDvksclKfXWrBtvKH4gYad
naPhDqXd5A==
=OXLz
-----END PGP SIGNATURE-----

--jr3n2neihasnwj2m--

