Return-Path: <linux-kernel+bounces-379468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C69ADF05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CA41C2169F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84891B0F26;
	Thu, 24 Oct 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF0cVyl1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF418A6AB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758005; cv=none; b=XUpGHKF7An5NBQnwfPqvEFe9G55sQbZtTnJE10TbUCFltZopreEPcmcGAtO8MJataLqAIaq5m7v/H0iQPdbWwT3QCGTs1R8rFFmbQ+Lecn7U26WloHP/+44PZv1fuzey85aIJyADkgOapb61UObqfAPFE26W9SwNt8UdEn3WKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758005; c=relaxed/simple;
	bh=K5sKOy6tY7heI8aybC+Dts0yJNvkoBAm47lR7ke4zpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NclF+235sDtyRF3z4agJ6r7n1Ev4BSD1du+Hm/WaSto4AreJFVEZcSRASUaCCGmaW/n7emy92Dmk9ofqm3B8DTNuHtUaj1yENO5sW6intG7XCSTUAFzLm6fxWAgprgMrzo+c7Ht7idObncexaHqxOMvaKNclo+rYuJGGcGon+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF0cVyl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B0AC4CEC7;
	Thu, 24 Oct 2024 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729758004;
	bh=K5sKOy6tY7heI8aybC+Dts0yJNvkoBAm47lR7ke4zpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WF0cVyl1s5gb+qNVxZ/tD7tpy6FtaotyaP1VOlIaZsVmuSOrl6G5Ju5M3OHtXs2jZ
	 0OiUMWb9rApd2WyEhSjTPFdW2hy2eij3GdEZs0nEhixXKNxoqoQ1yiDMijlGCdEhrL
	 Y/hg8gSsqf0ifRG2of7EsXaA9BgFzzus1U/GVzD1i40ZnHxKFwJ2mU4g2DZYEP7+6j
	 lzClmk0sAS09w+o6LOGGMiDJQyio6AhKmUNnD7HQAzut9Je2Uz1PwxKwDtGBULnYuf
	 fm6HzB2jYsUwoEYIQlwGQEhSkvPRf2TkCW+7qE3t3tnht1b5SztBaai231q8+OQo75
	 YRcQ09Jbmc40w==
Date: Thu, 24 Oct 2024 10:19:56 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, nicolejadeyee@google.com, 
	20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
Subject: Re: [PATCH v4 4/5] drm: writeback: Introduce drm managed helpers
Message-ID: <20241024-slim-onyx-emu-3e4869@houat>
References: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
 <20241010-google-vkms-managed-v4-4-ed04a62ad2e3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="o5dho5pvqeibpqga"
Content-Disposition: inline
In-Reply-To: <20241010-google-vkms-managed-v4-4-ed04a62ad2e3@bootlin.com>


--o5dho5pvqeibpqga
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/5] drm: writeback: Introduce drm managed helpers
MIME-Version: 1.0

Hi,

On Thu, Oct 10, 2024 at 07:39:06PM +0200, Louis Chauvet wrote:
> Currently drm_writeback_connector are created by
> drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> Both of the function uses drm_connector_init and drm_encoder_init, but
> there is no way to properly clean those structure from outside. By using
> drm managed variants, we can ensure that the writeback connector is
> properly cleaned.
>=20
> This patch introduce drmm_writeback_connector_init, an helper to initiali=
ze
> a writeback connector using drm managed helpers. This function allows the
> caller to use its own encoder.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_connector.c |   4 +
>  drivers/gpu/drm/drm_writeback.c | 224 ++++++++++++++++++++++++++++++++++=
------
>  include/drm/drm_writeback.h     |  10 ++
>  3 files changed, 208 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index fc35f47e2849..fe4c1967860a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -613,6 +613,7 @@ static void drm_mode_remove(struct drm_connector *con=
nector,
>  	drm_mode_destroy(connector->dev, mode);
>  }
> =20
> +void drm_writeback_connector_cleanup(struct drm_device *dev, void *data);
>  /**
>   * drm_connector_cleanup - cleans up an initialised connector
>   * @connector: connector to cleanup
> @@ -631,6 +632,9 @@ void drm_connector_cleanup(struct drm_connector *conn=
ector)
>  		    DRM_CONNECTOR_REGISTERED))
>  		drm_connector_unregister(connector);
> =20
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
> +		drm_writeback_connector_cleanup(dev, connector);
> +

So I think it should live in its own patch.

You're doing multiple things here. There's a) the bug that writeback
connectors aren't built properly, b) the discussion about how it's best to
clean it up, and c) how to make every driver clean up properly.

AFAIU, you're trying to address a and c here.

I think putting that call in drm_connector_cleanup is backward compared
to the pattern we're using in the rest of DRM.

drm_connector_cleanup should just clean what was allocated by
drm_connector_init, and that's it.

So we should create a drm_writeback_connector_cleanup function to
address a). That should be your first patch.

Now, it would indeed be best if drm_writeback_connector_cleanup didn't
need to be called at all. That's the second part of your patch, and
should be in its own patch as well. It would address b).

And finally, addressing c will require some driver changes, to either a
call to drmm_writeback_connector_init_* or by using
drm_writeback_connector_cleanup, but we'll have to make that change in
every driver.

Maxime

--o5dho5pvqeibpqga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxoDJQAKCRAnX84Zoj2+
du3bAYDYtM57/go755CLaBUrfDiCBY8n1D+4kvkJfiaa7gCpFikF4h3VBPgRcBDW
SP7pTQ4BgJRqMFQVXtGc9XarQJFeooYfRcrZ+wFWsyaMsD56J7OSsGOjSIwdz876
syUY5lnVuQ==
=Cnum
-----END PGP SIGNATURE-----

--o5dho5pvqeibpqga--

