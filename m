Return-Path: <linux-kernel+bounces-229258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A43916D78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7028EEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F8171084;
	Tue, 25 Jun 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdJx4ftT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E0170845
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330597; cv=none; b=Kx5WZhXIxykFqzDk+C90JxozHVdUiupTg4NoqMHwXx8mCCNCssUuj1XM2rY5zMDtc/m9NwxMzM6jp2x1Bn+04vzIKXr/QgLIoVMXuqoikyQfKk+Z3xI8Bj1QczpCvPWy6WI2cvv4C8eh0RaLfdpiPxZSSpzNjgY0yOvaKxZR8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330597; c=relaxed/simple;
	bh=w8Fx4d6/3MQfGMWMyl25XvS93W+usv95xarRsQvk+qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4WLeEIN8CCo6NcIB8ChUNh6VYJDWEsboaQnqR1TKwXr8lYnzf4VgoHzFpZuJjE5ccbBi5lmely0xoUfVwi0YDomoUvn1N2DIJT/2gTCWpGWAIuT8BnVDOjB0RbxWAWcuvWLYzLDzA68/gIgRaPADfGAJhwYN+H4qTeS7mCqPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdJx4ftT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7965BC32781;
	Tue, 25 Jun 2024 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330596;
	bh=w8Fx4d6/3MQfGMWMyl25XvS93W+usv95xarRsQvk+qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdJx4ftTEe7Jffxs5i4qLoukCRDQ5hBPt6OKOLhNQ6lW0Fh6cyoYPLKpr3VROsfjG
	 1Vi7lZY/m1dRzk4CnOmTcV2/01PRjQ9N4zNevRWGarWBDmRY+Rx95SQGiWfP0bqfaC
	 t3BY4tIQnYSAlOApe7U0yUSO7RpYlhUbmVraSDi8CObwlh+fm+EelNBK/vc253yG24
	 aeLTh0GMBW+kL9vQ03gWu4/xPH5oxqgE1H6QguhLVlnptlISzyv/kROzeUgljHPphj
	 CrRVlwfn25oEpeda+oUwQJsNW4VInhaqVautyVEi2loTPHewkWV5dg3ioJijdMxszZ
	 u62iZa8hO4e5A==
Date: Tue, 25 Jun 2024 17:49:54 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector
 state
Message-ID: <20240625-jackrabbit-of-major-ampleness-e0becb@houat>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>
 <20240625-feathered-loon-of-health-ec7e6d@houat>
 <CAA8EJpq314tQFZpkXgL1cYDPfoFRukhB_KiaDvmsqdzHFD512g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f32x3stesnc5a3mi"
Content-Disposition: inline
In-Reply-To: <CAA8EJpq314tQFZpkXgL1cYDPfoFRukhB_KiaDvmsqdzHFD512g@mail.gmail.com>


--f32x3stesnc5a3mi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 06:05:33PM GMT, Dmitry Baryshkov wrote:
> On Tue, 25 Jun 2024 at 18:02, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Sun, Jun 23, 2024 at 08:40:12AM GMT, Dmitry Baryshkov wrote:
> > > On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_H=
DMI
> > > IGT chokes on the max_bpc property in several kms_properties tests due
> > > to the the drm_bridge_connector failing to reset HDMI-related
> > > properties.
> > >
> > > Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> > > the drm_bridge_connector has bridge_hdmi.
> > >
> > > Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> > > drm_atomic_state_helper.c because drm_bridge_connector.c can not depe=
nd
> > > on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossible to
> > > call this function from HDMI bridges, there is is no function that
> > > corresponds to the drm_connector_funcs::reset().
> >
> > Why can't it depend on DRM_DISPLAY_HDMI_STATE_HELPER?
>=20
> Is it okay to have DRM_KMS_HELPER to depend unconditionally or select
> DRM_DISPLAY_HDMI_STATE_HELPER?

No, but it's not clear to me why drm_bridge_connector is part of
DRM_KMS_HELPER? It doesn't seem to be called from the core but only
drivers, just like DRM_PANEL_BRIDGE which has a separate config option

Maxime

--f32x3stesnc5a3mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnrnIQAKCRDj7w1vZxhR
xbNfAP9H/Ub8lZQ243QWpi6FrOvJ4VikWvUVmgdMMw+fjKvvZwEA5ObWUNH6JiVL
6VbP97YSK5st6Yc9nX+yALwZD2/+BwU=
=YAbe
-----END PGP SIGNATURE-----

--f32x3stesnc5a3mi--

