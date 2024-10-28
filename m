Return-Path: <linux-kernel+bounces-384908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082119B3006
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A34D1C21C36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1011DA31D;
	Mon, 28 Oct 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0aUbagg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DD1922DD;
	Mon, 28 Oct 2024 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118108; cv=none; b=Tj7yGejJoX2qt/iU6GzPxldXApH/+kjlSM2alsygMxHe1Qr8GNxLUyLdM9iIAb5AhSqu2NOkGfoBzfpxf2Gi8/xnGdDhENv0QfsNfbVEWQHeppFYF7977VpjewGKhuXIgni9UTAEAuTsP/y+8XNHaxf52YxNDe/puUS3qq5I1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118108; c=relaxed/simple;
	bh=MlbLQb+KBwj20dusYA7M3Xo173dioqX9FKeduYVGkGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrvbxeimM0UGH3aMOVzGb95IAo4EEb2KYv7wT8TQNkibCQgtUCWZtvXpidggWt2qiQ8tRzsoKB2yMRxWOniFp7hmwt91mk4v9bulw4J8IOlosnhTAwlcxeWW8/sKxqJCcqoctrSbz/xn+sBBhKxO77fNz+eOAZGxZCHEGKqd4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0aUbagg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B292AC4CEC3;
	Mon, 28 Oct 2024 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730118108;
	bh=MlbLQb+KBwj20dusYA7M3Xo173dioqX9FKeduYVGkGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0aUbaggBYH62yrig6yRJLdIvroG9ttfp6TO6McWCjE5OmmfaUCI2mWO+UdqIP4/z
	 gGvDepSh3H9fBcyyxM8y0GRZaC36LzlEsmCpI203aKI2iMhN8K93twlwTvnyAT+ges
	 YTzKiH0cya7YJ1XFXIGBJFh50Pnf2YaX7yTmjtyyHPkRIM9xvpKPDEe1gl0nv5Gfy+
	 xKLJ5WZWTXkGZYKL6+ANR+Z/b2Mufn9taKDZsh5dNWInOFVQM3hN/8PMwmevFso3+d
	 bjRtJBOyLg/5iUnP6e9A0c9t0nFCrzkNu4XqkxLhvLLqxcAOzCMw7TiflqRW8i3IaR
	 55duWcUYTlIPA==
Date: Mon, 28 Oct 2024 13:21:45 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241028-nebulous-yellow-dragon-2cfb5f@houat>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <20241027162350.GA15853@pendragon.ideasonboard.com>
 <20241028091331.6f67e29e@bootlin.com>
 <20241028112857.GF24052@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="r7g5pyau5d4sslae"
Content-Disposition: inline
In-Reply-To: <20241028112857.GF24052@pendragon.ideasonboard.com>


--r7g5pyau5d4sslae
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
MIME-Version: 1.0

On Mon, Oct 28, 2024 at 01:28:57PM +0200, Laurent Pinchart wrote:
> On Mon, Oct 28, 2024 at 09:13:31AM +0100, Herve Codina wrote:
> > Hi Laurent,
> >=20
> > On Sun, 27 Oct 2024 18:23:50 +0200
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> >=20
> > [...]
> > > > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > > > +{
> > > > +	struct drm_device *dev =3D sn65dsi83->bridge.dev;
> > > > +	struct drm_modeset_acquire_ctx ctx;
> > > > +	struct drm_atomic_state *state;
> > > > +	int err;
> > > > +
> > > > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > > > +	 * operation done in drm_atomic_helper_resume() but without relea=
sing
> > > > +	 * the lock between suspend()/resume()
> > > > +	 */
> > > > +
> > > > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > > > +
> > > > +	state =3D drm_atomic_helper_duplicate_state(dev, &ctx);
> > > > +	if (IS_ERR(state)) {
> > > > +		err =3D PTR_ERR(state);
> > > > +		goto unlock;
> > > > +	}
> > > > +
> > > > +	err =3D drm_atomic_helper_disable_all(dev, &ctx);
> > > > +	if (err < 0)
> > > > +		goto unlock;
> > > > +
> > > > +	drm_mode_config_reset(dev);
> > > > +
> > > > +	err =3D drm_atomic_helper_commit_duplicated_state(state, &ctx); =
=20
> > >=20
> > > Committing a full atomic state from a bridge driver in an asynchronous
> > > way seems quite uncharted territory, and it worries me. It's also a v=
ery
> > > heavyweight, you disable all outputs here, instead of focussing on the
> > > output connected to the bridge. Can you either implement something mo=
re
> > > local, resetting the bridge only, or create a core helper to handle t=
his
> > > kind of situation, on a per-output basis ?
> >=20
> > A full restart of the bridge (power off/on) is needed and so we need to
> > redo the initialization sequence. This initialization sequence has to be
> > done with the DSI data lanes (bridge inputs) driven in LP11 state and so
> > without any video stream. Only focussing on bridge outputs will not be
> > sufficient. That's why I brought the pipeline down and restarted it.
>=20
> Fair point.
>=20
> > Of course, I can copy/paste sn65dsi83_reset_pipeline() to a core helper
> > function. Is drm_atomic_helper_reset_all() could be a good candidate?
>=20
> The helper should operate on a single output, unrelated outputs should
> not be affected.

Also, you don't want to reset anything, you just want the last commit to
be replayed.

Maxime

--r7g5pyau5d4sslae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZx+B1AAKCRAnX84Zoj2+
dm9CAYCqEi3yerFbAJ3P7ZJw1A7SZJbfZG7IERHg95sH2IFq3z/wA4bfn8Syz3JT
NlxnchcBfR7/CbJL+XJP6dzID9Lqh3k4pduwiQB/zVB6lQg34+KWwk4BrhPPavXO
OwTzZeDQNw==
=+iI0
-----END PGP SIGNATURE-----

--r7g5pyau5d4sslae--

