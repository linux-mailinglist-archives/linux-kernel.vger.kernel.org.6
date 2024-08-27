Return-Path: <linux-kernel+bounces-303540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4019D960DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AC4284EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB221C4EE2;
	Tue, 27 Aug 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmKS6XrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6D1BCA00
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769203; cv=none; b=q0k3Z7NzFYTqXFsRHevC0386RYV0GvdSHHNQR0SsuJ0tSB9/auST365EyAU870r2WJB/UhqvsgHRRTydapZLThzyEfQIVzqiJOoDIzWH/EyX7aSw+fc5198vo2+iDmLwrGamZdWJOm0+wXEyws8KymFwEqMSagrIZYCBnvahsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769203; c=relaxed/simple;
	bh=N7LkYANKbFgws/uh3+iH9lxlTG58CffdFxCr/9/NrsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3TRObs0RyaVECw3Db8MDlDxRQuuCHgSjj3BhJ5gmzd0sYWQjeu5xmr4sGhP+fhHRFwSlvnzF7CMFpbS6DrGBqHJFc5Y4NerjDyTsn89lya4Lx2xPcV6VGaK43L/Bbmj8Ay3YErHvDdiG2DAAoTkB221SuZwG+CImVZ8JZT2Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmKS6XrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29D1C4DDF4;
	Tue, 27 Aug 2024 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769203;
	bh=N7LkYANKbFgws/uh3+iH9lxlTG58CffdFxCr/9/NrsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmKS6XrOvipDliU4bx/WlyXNy7Ju4FTmhJTAwil+bO/W5k4/TRlo9e3IBYpuRPxFA
	 /ziAqmwcEUYH3x/4WZNaJw8EDLdT39XF5ApD5nI4nS4v+Cs823qooWuds3l7NLpf/d
	 nb5q8FnQv0hE+NM5okMisDyaWR/ibP2JWurJk3J0Z2/McYNdRRd+a0J7ft6Ua7+1O6
	 42wLbmMb22VDF+Av6EU7jMnjPiro52mlonwV1eJslHAkP7I1T1KzkBsjBxOK3Ufnh7
	 iMzK2pzqZB9FdLqwj1nNrxa/9f8H32ADkRu3t8gybZJ+ydEWoJ5yLG/9x4pYJoOUt7
	 +ALDoV7rRIG7A==
Date: Tue, 27 Aug 2024 16:33:20 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
	thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH RFC 11/15] drm: writeback: Add drm_writeback_connector
 cleanup
Message-ID: <20240827-solid-adorable-coucal-c3e0d1@houat>
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
 <20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="eyjyqs6v362l2ini"
Content-Disposition: inline
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com>


--eyjyqs6v362l2ini
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 04:36:33PM GMT, Louis Chauvet wrote:
> Currently drm_writeback_connector are created by
> drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> Both of the function uses drm_connector_init and drm_encoder_init, but
> there is no way to properly clean those structure from outside.
>=20
> This patch introduce the new function drm_writeback_connector_cleanup to
> allow a proper cleanup.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_writeback.c | 10 ++++++++++
>  include/drm/drm_writeback.h     | 11 +++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeb=
ack.c
> index a031c335bdb9..505a4eb40f93 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -184,6 +184,7 @@ int drm_writeback_connector_init(struct drm_device *d=
ev,
>  	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
> =20
>  	wb_connector->encoder.possible_crtcs =3D possible_crtcs;
> +	wb_connector->managed_encoder =3D true;
> =20
>  	ret =3D drm_encoder_init(dev, &wb_connector->encoder,
>  			       &drm_writeback_encoder_funcs,
> @@ -290,6 +291,15 @@ int drm_writeback_connector_init_with_encoder(struct=
 drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
> =20
> +void drm_writeback_connector_cleanup(struct drm_writeback_connector *wb_=
connector)
> +{
> +	drm_connector_cleanup(&wb_connector->base);
> +	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
> +	if (wb_connector->managed_encoder)
> +		drm_encoder_cleanup(&wb_connector->encoder);
> +}
> +EXPORT_SYMBOL(drm_writeback_connector_cleanup);
> +
>  int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>  			 struct drm_framebuffer *fb)
>  {
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 17e576c80169..e651c0c0c84c 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -35,6 +35,15 @@ struct drm_writeback_connector {
>  	 */
>  	struct drm_encoder encoder;
> =20
> +	/**
> +	 * @managed_encoder: Sets to true if @encoder was created by drm_writeb=
ack_connector_init()
> +	 *
> +	 * If the user used drm_writeback_connector_init_with_encoder() to crea=
te the connector,
> +	 * @encoder is not valid and not managed by drm_writeback_connector. Th=
is fields allows
> +	 * the drm_writeback_cleanup() function to properly destroy the encoder=
 if needed.
> +	 */
> +	bool managed_encoder;
> +

I think we should rather create drmm_writeback_connector variants,
and make both deprecated in favor of these new functions.

Maxime

--eyjyqs6v362l2ini
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZs3jqAAKCRAnX84Zoj2+
dqC/AX41x2/yRw5bNXUT1ld4NWuUvhzpWR9ibP9t6EQOQRPCRs2ZEdpfypeN+onm
B4GyXXEBf3hD2r8NNZs0TDJllfPpe3k7TCzWGX7GiUpnz3sBiYeqETc3RVk8EYuS
PldTUHYJKQ==
=LJyL
-----END PGP SIGNATURE-----

--eyjyqs6v362l2ini--

