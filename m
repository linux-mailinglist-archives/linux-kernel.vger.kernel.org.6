Return-Path: <linux-kernel+bounces-418513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056999D6268
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEB3283DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D051DDC16;
	Fri, 22 Nov 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecr8Xx66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4183CD3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293398; cv=none; b=lLEp39Plr02MyhSSxSxGoX9iJwfNZBrfIbQdYvfv/WEfbmbdW3hB1At0UlSzVJKHeKtSLRz+mbupsl4QM1vajz1KIecPUiyI660dfw/5IFH5LuSFtwI3tS6vwLVLWlO6TnmkZI1zhOxwOeTfaVmn4pycvIlhooho7kL14oKEpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293398; c=relaxed/simple;
	bh=pE8ixWo8gzZiQLIdVAgn6WfVkyTQhdYuv7ULnA+hrH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q70H7vQ31a8hrXAA/8YHXta/Xtbg+aROcykUZyNCqKEVtM0bOdaXVwuBBYAonJMXqp9Py2t354y3h8OYdI7zlxc/UnnBnX4LBQTlJ3FBouEjh4Nv0030O95wCMiAcFw160xpgOEYulZkw3H/6ur8F9QnUOgCq1HIfA2I439fmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecr8Xx66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F69C4CECE;
	Fri, 22 Nov 2024 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732293397;
	bh=pE8ixWo8gzZiQLIdVAgn6WfVkyTQhdYuv7ULnA+hrH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecr8Xx66rrTgKwDRj90xlTTBW9TLELsDrXcxB0+upWmCuduXetjxvyHesJbyQlcj6
	 dIAkF1TubljM+JkLvgY4o4SPTOJ7W7iTHGZePpaGlLl5Po12dv6YqEMjvBbohWe23O
	 dZGffjovCzlC+GMw39Vv9ZqnMGnVn8jPgOvnWwUYKnn8GFDeyULP7mXCWzC0sxRlET
	 wm2Ko+KUaQtNLJ1UV6VaMo7iD6H+mppGW+oZMVh0YW86M689NL7L+N6aqjTyQD1iqG
	 OXYDqrUj7Vrpi+VDnSPt8BvUaCgTvIPiK68svnPOWV9kEAckqTxQIGeNcO4IfJCrpi
	 rGwrS+h0WrYFQ==
Date: Fri, 22 Nov 2024 17:36:34 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v14 4/7] drm: Export symbols to use in tests
Message-ID: <20241122-crafty-feathered-capybara-b16c9d@houat>
References: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
 <20241122-yuv-v14-4-e66d83d28d0c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rdydydsfebkvtk6d"
Content-Disposition: inline
In-Reply-To: <20241122-yuv-v14-4-e66d83d28d0c@bootlin.com>


--rdydydsfebkvtk6d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 4/7] drm: Export symbols to use in tests
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 05:15:04PM +0100, Louis Chauvet wrote:
> The functions drm_get_color_encoding_name and drm_get_color_range_name
> are useful for clarifying test results. Therefore, export them so they
> can be used in tests built as modules.
> ---
>  drivers/gpu/drm/drm_color_mgmt.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color=
_mgmt.c
> index 3969dc548cff605cbdd3d56dceafb2ca00a5c886..509aa4325391340f8cfc50bd0=
fc277c48c889d3d 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -494,6 +494,7 @@ const char *drm_get_color_encoding_name(enum drm_colo=
r_encoding encoding)
> =20
>  	return color_encoding_name[encoding];
>  }
> +EXPORT_SYMBOL(drm_get_color_encoding_name);

If it's only required for tests, then EXPORT_SYMBOL_IF_KUNIT or
EXPORT_SYMBOL_FOR_TESTS_ONLY would be better.

Maxime

--rdydydsfebkvtk6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0CzDgAKCRAnX84Zoj2+
dhTFAX0V6AnVDd5Olsac8BDOeLeqSrE5iOoqQ7owO/CjGHpxob3C5cxUEEy05pWL
jF1sx74BgLgWgq0ptGvGTkCDvfigMvu4yG9AQh5aW6z6G0JQClAsFuIH9sj0PMMW
0000k2dgzg==
=9mD+
-----END PGP SIGNATURE-----

--rdydydsfebkvtk6d--

