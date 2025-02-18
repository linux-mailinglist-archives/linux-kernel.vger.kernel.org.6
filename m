Return-Path: <linux-kernel+bounces-519170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F9DA398DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884AE3A2458
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C7233157;
	Tue, 18 Feb 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF9DDByj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4D1AE863
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874183; cv=none; b=FsLajZiAWUJB/k5po4lMPmleWCFTOTWjoGxDYqYCtmcJMzceYxHQq5ZUHODgkOGwPv0lg04hy1pEgf1dMkl1wmG6OZczQpwta2xQoyVk88TwQBDt8ta/nzq9FifFkXx9mpU2oh8k9yHNaCzBAvUWEP1anGAbPcnDfOukwhFv1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874183; c=relaxed/simple;
	bh=J97cmWZxIhO2AD5DCW1yf5u2TgYTs8xKBisHCggs4Os=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjsiuNRYm3/1kGKNTEEWTebQpCOmLcJck+vmuF+blhWhT6BHUx9HjhgoVHu2OEBylcB/LbHNR/tWKTtO6NyZWTJ/8ZIQNhTNKNySfMK1/+gUNk7+kteomCLXLI3gi7HfMi8WrKU/M/zs8IATSDHfMXQkXaJ0/RaFymInc0fnoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF9DDByj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2FFC4CEE2;
	Tue, 18 Feb 2025 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874182;
	bh=J97cmWZxIhO2AD5DCW1yf5u2TgYTs8xKBisHCggs4Os=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=TF9DDByj9vNXRHA8paJjEUZv5cqyvKor3+yCurZ8UlXe0BXfnPK/GWJJrr9HM/FE6
	 3Ct3nSCsGYGYUTxPkVKRiFMZuQZTIyaz/z7y706PlslfH06l92Ulg5zCgGj64yPyOF
	 lQkQncqqdrO0JRDUjlTb24gBzoB3wfQUmMY4MP5UqkHqGtI90zOnehtWqBPeiODE1b
	 pZSLNDOHM3hmF/l96itSYf54ilWMG/RATsfWzzodsJJF2mwQY5hdbprOhaO69QX8wy
	 BVsd1YQrLTSx62vpUYKFQ3TqGcCpkuOdrDLBOjP5i+zYN+yGMBfnqvGh+t9V2850X6
	 klyZKeFUuJ5tg==
Date: Tue, 18 Feb 2025 11:23:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <20250218-adamant-translucent-civet-aebcc5@houat>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
 <Z7NmtF83adILfasi@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="fjwpfvmnbqk5kxno"
Content-Disposition: inline
In-Reply-To: <Z7NmtF83adILfasi@phenom.ffwll.local>


--fjwpfvmnbqk5kxno
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
MIME-Version: 1.0

Hi,

Thanks for your answer

On Mon, Feb 17, 2025 at 05:41:24PM +0100, Simona Vetter wrote:
> On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > Now that connectors are no longer necessarily created by the bridges
> > drivers themselves but might be created by drm_bridge_connector, it's
> > pretty hard for bridge drivers to retrieve pointers to the connector and
> > CRTC they are attached to.
> >=20
> > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > encoder field, and then the drm_encoder crtc field, both of them being
> > deprecated.
>=20
> Eh, this isn't quite how this works. So unless bridges have become very
> dynamic and gained flexible routing the bridge(->bridge->...)->encoder
> chain is static. And the crtc for an encoder you find by walking the
> connector states in a drm_atomic_state, finding the right one that points
> at your encoder, and then return the ->crtc pointer from that connector
> state.
>=20
> It's a bit bonkers, but I think it's better to compute this than adding
> more pointers that potentially diverge. Unless there's a grand plan here,
> but then I think we want some safety checks that all the pointers never
> get out of sync here.

That work stemed from this series
https://lore.kernel.org/all/20250210132620.42263-1-herve.codina@bootlin.com/

and in particular:
https://lore.kernel.org/all/20250210132620.42263-5-herve.codina@bootlin.com/

Bridges, outside of the modesetting code path, don't have a way to
access the drm_atomic_state since drm_bridge_state->state is typically
cleared after swap_state. So accessing the connectors and CRTCs don't
work anymore.

In this particular case, we needed to access those from the bridge
interrupt handler.

Maxime

--fjwpfvmnbqk5kxno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7RfgwAKCRAnX84Zoj2+
dsY1AX4m3Y/rhtfrfL5pI16GfnzyxUJw2QAzb0L4622v2eq+g/W1fSXTAxY8KzW6
Wfbhq50BfjjytZiYw6O6WKEMflBVSv+Gc/VkyjXHS8b8meNQ7mNNuSLrxtbC3ijN
L5iN3mmqkw==
=2pcx
-----END PGP SIGNATURE-----

--fjwpfvmnbqk5kxno--

