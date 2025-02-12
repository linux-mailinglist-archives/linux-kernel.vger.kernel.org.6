Return-Path: <linux-kernel+bounces-510716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540FA320FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ED4165D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738D205E07;
	Wed, 12 Feb 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgmoXuog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7E205AAA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348664; cv=none; b=stgrcOxleiS1+S5DPbr/Fvvv9EUQOZODB3HUh2JbMhre0AzUzYSYItp2XUJ2wgrD5nM+ohHQoV9a52DEl85FnOX02dle/KZrifvk+nCBfkAzMjuFJtioIhgMG79Uk43UB3ckZQz3FmcLVHkccaJBOdYtGZDSoQCW73dhmw2JZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348664; c=relaxed/simple;
	bh=vS+Ibsqqgchtay7JQEgCkpVTBAH3Qqa/q39iH91TsXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJdSCmQgBcAp0p6OLXXTsfLUOkH8J9IJPOKhhvYr9vHoFjcqzXm5L09z5f8SxheV8ELggHap+/6EGHDpSijqBhO93MYYosdCUtYgV9xdS/Izx7uTYTQHZu29WdGNxVtwvhjq34Jr3i9c4PI+rprLlmyfEgleEULR1jgi7+3VR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgmoXuog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9776C4CEDF;
	Wed, 12 Feb 2025 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739348664;
	bh=vS+Ibsqqgchtay7JQEgCkpVTBAH3Qqa/q39iH91TsXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgmoXuogOEOPeVfCOBzROnw5BQ4hGdf52cd6lnL0RzJtiJtAgVIGrTLwmyIXeOeeM
	 Jag9tN4Ma72LlvKOVr2uW94ph45zzAyfpbmymqzEaOqn8OIURuhWuTYvxsuOixYaOB
	 E8YtPAk7LuQgf/Mbbypil1mPTo8X/N6EQSoAtrcczn/5xgqtZ3Xd+r2avxB+IqDDKr
	 meh81fG6E9+W4w8EeBqWhhLax9AB6bOop0RIKoZHnd0u+n6o+31xAtA6mmNAqFV2LW
	 EqfM50r5SlXtGpwkwQ6lzRjSfO5jXHRfeptQbWjDcjmZjICIgdfGmGpQGKQl/jjQ/5
	 YhRuSmrK88L5Q==
Date: Wed, 12 Feb 2025 09:24:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/35] drm/bridge: tc358768: Convert to atomic helpers
Message-ID: <20250212-versatile-donkey-of-thunder-0894ec@houat>
References: <20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org>
 <20250204-bridge-connector-v2-34-35dd6c834e08@kernel.org>
 <nbghrrl74xsuzomp7d6qjfosxfiooezipppjhxkx2ibnlpi6rj@b6ovgosmpuhl>
 <20250211-solemn-meticulous-angelfish-85d1ce@houat>
 <btehhpvkv6iqd4pofumspqbxzr5gxwp6vs5oh7vflbcmzqj5wz@s6yem2ryw6vs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7z47kinhio2ycy4k"
Content-Disposition: inline
In-Reply-To: <btehhpvkv6iqd4pofumspqbxzr5gxwp6vs5oh7vflbcmzqj5wz@s6yem2ryw6vs>


--7z47kinhio2ycy4k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 34/35] drm/bridge: tc358768: Convert to atomic helpers
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:38:52AM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 11, 2025 at 03:33:58PM +0100, Maxime Ripard wrote:
> > On Sun, Feb 09, 2025 at 09:13:36AM +0200, Dmitry Baryshkov wrote:
> > > On Tue, Feb 04, 2025 at 03:58:02PM +0100, Maxime Ripard wrote:
> > > > The tc358768 driver follows the drm_encoder->crtc pointer that is
> > > > deprecated and shouldn't be used by atomic drivers.
> > > >=20
> > > > This was due to the fact that we did't have any other alternative to
> > > > retrieve the CRTC pointer. Fortunately, the crtc pointer is now pro=
vided
> > > > in the bridge state, so we can move to atomic callbacks and drop th=
at
> > > > deprecated pointer usage.
> > > >=20
> > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/bridge/tc358768.c | 30 +++++++++++++++++++++++----=
---
> > > >  1 file changed, 23 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/br=
idge/tc358768.c
> > > > index 6db18d1e8824dd7d387211d6d1e668645cf88bbe..6ff6b29e8075d7c6fa0=
b74b4fec83c5230512d96 100644
> > > > --- a/drivers/gpu/drm/bridge/tc358768.c
> > > > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > > > @@ -601,17 +601,29 @@ static void tc358768_bridge_disable(struct dr=
m_bridge *bridge)
> > > >  	ret =3D tc358768_clear_error(priv);
> > > >  	if (ret)
> > > >  		dev_warn(priv->dev, "Software disable failed: %d\n", ret);
> > > >  }
> > > > =20
> > > > +static void tc358768_bridge_atomic_disable(struct drm_bridge *brid=
ge,
> > > > +					   struct drm_atomic_state *state)
> > > > +{
> > > > +	tc358768_bridge_disable(bridge);
> > > > +}
> > > > +
> > >=20
> > > Please change corresponding functions into atomic_disable() and
> > > atomic_post_disable(). Calling sites have access to the atomic state,=
 so
> > > there is no need to have yet another wrapper.
> >=20
> > It's pretty hard to do (at least without the hardware), both
> > tc358768_bridge_disable() and tc358768_bridge_post_disable() have
> > multiple call sites in the driver, and passing a state enabling the
> > bridge doesn't make sense for those.
>=20
> I think it makes sense. The function knows that the bridge needs to be
> disabled. The state is totally unused (or it can be used to get
> connectors / CRTC / etc).

That's the thing though, if we were to pass the state, it would be a
state where the bridge is enabled, like, it would have an active CRTC.
In a disable path, you wouldn't have it.

Another idea would be to just drop the call to disable the bridge, the
assumption is that we can't fail in atomic_enable, so no driver actually
tries to mitigate a failure. I'm not sure why this one would need to.

Maxime

--7z47kinhio2ycy4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6xasAAKCRAnX84Zoj2+
dueAAX9SMGyDftCM0SYN9inRzMrGoyoVgFYZk5PzoXmuKQ+UYPCBoo8GDDVJZtyx
PlBFR2cBgLoDsY265QHgxuKYGHvyxb/ClABRPEprT8Pe4CLpQIUvcheQUsXwhB74
B+vnEfdpag==
=fWeT
-----END PGP SIGNATURE-----

--7z47kinhio2ycy4k--

