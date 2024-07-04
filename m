Return-Path: <linux-kernel+bounces-241058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E292768C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D718FB21A17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278121AE847;
	Thu,  4 Jul 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqGnOcgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74E1AC221
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097807; cv=none; b=amJebfMX4nTknkC80YL9qV8viFVPTd7CtLdRiCv2jz4wJBOHS+RRURAm5PFnKkgwK08VbCaq7mvC/jGRyWAMd30PTRh3CPdh3O8dfSZuP+gSBLcfcxm5gHFCJdD0E7pdziblumumF727R06BpkkNP5MOK8Op42tvTugV2ri93GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097807; c=relaxed/simple;
	bh=PVroVr5VS+tv2unXGroLj7wH6BRx+DmoasU5vVT6qLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCm56PouYqOFX/bHMzWLF9qEsHqeZAcam48kk6IZBer40cx37qItcm4uwUR6xWt8ChGArtfljuqLlYbnO3+Ku5Mr2AnuDkz+A+oPqcz+Pm+N/NZth1EB7+p+3sbwLq/qw98/cPUpq/SgbZ7Td/mJOFbnZ3L8gcSV0NBCSjyDmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqGnOcgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7268C3277B;
	Thu,  4 Jul 2024 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720097807;
	bh=PVroVr5VS+tv2unXGroLj7wH6BRx+DmoasU5vVT6qLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqGnOcgYwZ4oi1+bFCrkwSYSjnxslsfvgCnM91eu3i8YszOa5kuzhMvNnYIs4ZsiY
	 NIy1PScgBGrwy6x2GMBOZIpoNEcUeZ0hi5HpBUrZqMrKiH/KhyOdCsehGimmynDdsk
	 dNGi24wLnqPuKeBup5dIKJMun9IhC0HWLRLIfIfS/wt4dM5uFWPOpJJip5SYqxuLWF
	 64i7GMNADdv3Iyb4WYoAfdNPSXrGlMd7Mbp6qhKOfP1ZjljOQv04xcnHXfgVUzGDih
	 IIX+edxeQzsC4ZnPSQNevoejUTgaavvsAgud2AygURl+E3Sc4Q2BGsuVXhul+XW0Fa
	 3/CdFAUftT52Q==
Date: Thu, 4 Jul 2024 14:56:44 +0200
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
Subject: Re: [PATCH v3 4/4] drm/bridge-connector: reset the HDMI connector
 state
Message-ID: <20240704-jumping-saffron-shrew-d5f3b7@houat>
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
 <20240702-drm-bridge-connector-fix-hdmi-reset-v3-4-12b0e3124ca4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vwtwdy7kgdsohoy"
Content-Disposition: inline
In-Reply-To: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-4-12b0e3124ca4@linaro.org>


--7vwtwdy7kgdsohoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Tue, Jul 02, 2024 at 12:48:55PM GMT, Dmitry Baryshkov wrote:
> On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> IGT chokes on the max_bpc property in several kms_properties tests due
> to the the drm_bridge_connector failing to reset HDMI-related
> properties.
>=20
> Call __drm_atomic_helper_connector_hdmi_reset() if the
> drm_bridge_connector has bridge_hdmi.
>=20
> It is impossible to call this function from HDMI bridges, there is is no
> function that corresponds to the drm_connector_funcs::reset().
>=20
> Fixes: 6b4468b0c6ba ("drm/bridge-connector: implement glue code for HDMI =
connector")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/display/Kconfig                |  1 +
>  drivers/gpu/drm/display/drm_bridge_connector.c | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kc=
onfig
> index 1a192a45961b..bfd025f8c7b5 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -9,6 +9,7 @@ config DRM_DISPLAY_HELPER
>  config DRM_BRIDGE_CONNECTOR
>  	bool
>  	depends on DRM && DRM_BRIDGE && DRM_DISPLAY_HELPER
> +	select DRM_DISPLAY_HDMI_STATE_HELPER

Sorry, I notice it on that patch, but it's really on the previous one:
both DRM_BRIDGE and DRM_DISPLAY_HELPER are meant to be selected, not
depended on.

Otherwise,

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--7vwtwdy7kgdsohoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoacCwAKCRDj7w1vZxhR
xanRAQColvBTOI0QEUf8DcGVNjKDA1/UU+PpylKjFBS+1Af3UwD+NRXO6kyzueZq
/yJoJX5gAP4jYt81QeQl/Vb8tObX3g8=
=F6fl
-----END PGP SIGNATURE-----

--7vwtwdy7kgdsohoy--

