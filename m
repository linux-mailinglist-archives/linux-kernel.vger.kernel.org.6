Return-Path: <linux-kernel+bounces-180746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A78C728B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A5D1F2154A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73412DD82;
	Thu, 16 May 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC9YOc7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F284501A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847103; cv=none; b=kfctKYm8RxFor0xASLG/ouAE1TUgJcod3AHo/+T212Hu2UxdYc2l+SZETRUcN5YMU+QEgTGr+T2sXr+9DknnkNu6f9CL+frNu4HHc38mzmkSpJYUZpUxeOtP5fwQYtusgmpxN+y5LcOGeBRALuZpLnDEyOH8siTiFyATIPG2kjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847103; c=relaxed/simple;
	bh=SDHydIIcgExVBBEGQEV4opyzcJq5q4MSmcgzjXkbO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp2b6xEfoMbjtlNKT0NdCNS0ahxvGnI35Gg9bOdxTtIFLzbt8f/sscIekDouh4S+3G3yxvv0tJDOpVGRglaPKpnAr7xo3U1P0rKx9UFMObU95h+QGPPlN4+eU4JswJpZ4Krptt4OPgnSSRjN4/htWGG0vRQvxw69GT3EHjaZ4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC9YOc7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5C1C113CC;
	Thu, 16 May 2024 08:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847103;
	bh=SDHydIIcgExVBBEGQEV4opyzcJq5q4MSmcgzjXkbO1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eC9YOc7pWDAxfIPvy6qHkI5yDPZzkilKJ8iFLiIsMFpGmxtavV4DoI4rrgbvfWwOf
	 UzHnDPn7xheBOmWtjuti6olVKO2UJICtwiKqS1ML7RSWPNb4GTyLzR+OfyTJwU5qq3
	 3aQ2Z2c+cC56OM0PaEyXDZcfAClAV60I76ybPtnGzwxXTKhmJXgbnMSTnHNlTKI3Y6
	 DMCggVedsvUreGsKZwQoDuMz7RFRE27ydn47607BbtUoHGgJtcOU4omAx/XA7R25Iy
	 xTGhf7OC54ObcQTJCTWsz4/K5ukJ7oTsNnmYh9HZNinjeuEoLvinfeFPQCbFM/xCG8
	 gbvbiV/pq7BAw==
Date: Thu, 16 May 2024 10:11:39 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Boris Brezillon <boris.brezillon@bootlin.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 2/7] drm/bridge: cdns-dsi: Fix minor bugs
Message-ID: <20240516-stereotyped-precise-wapiti-6d0cd3@penduick>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
 <20240511153051.1355825-3-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="cnswkacfnsz3omkc"
Content-Disposition: inline
In-Reply-To: <20240511153051.1355825-3-a-bhatia1@ti.com>


--cnswkacfnsz3omkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 09:00:46PM +0530, Aradhya Bhatia wrote:
> Update the Phy initialized state to "not initialized" when the driver
> (and the hardware by extension) gets suspended. This will allow the Phy
> to get initialized again after resume.
>=20
> Fix the OF node that gets passed to find the next available bridge in
> the display pipeline.
>=20
> Fix the order of DSI Link and DSI Phy inits. The link init needs to
> happen before the Phy is initialized, so the Phy can lock on the
> incoming PLL reference clock. If this doesn't happen, the Phy cannot
> lock (until DSI Link is init later on). This causes a warning dump
> during the kernel boot.
>=20
> Allow the D-Phy config checks to use mode->clock instead of
> mode->crtc_clock during mode_valid checks, like everywhere else in the
> driver.

All these should be in separate patches.

Maxime

--cnswkacfnsz3omkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkW/uwAKCRAnX84Zoj2+
dvbiAYCTM8TvoHNwZ6Dm4SMhmLrZgas5Prx9utVjWzNDduffCVKQ1muJvPEoKLqS
yfhdttQBgJkKcyWiqBjQtycklQDU+f/9fZ9eqO63kMLYM4jz3wRj66wF92677VhA
nVOw35Wlnw==
=NUy6
-----END PGP SIGNATURE-----

--cnswkacfnsz3omkc--

