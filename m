Return-Path: <linux-kernel+bounces-208073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C4902043
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8701C21C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F157C6C1;
	Mon, 10 Jun 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfcb4ZPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A96BFCA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018585; cv=none; b=i9PFbMCG69d0Sqj8bA9aljFZxwWcJe2kwIG4TiA0FNlmnhWCTgKUW9TXX0surPttm3LyAHvkJbxSQ2ISlIeKXbEyzBgDgkF3X2pL89P7LHFEoMStvhI1SYGf1t6nXOHVZrxOJB9KV+WMgkecjg+p62PSI4EOv718mclsgyWI3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018585; c=relaxed/simple;
	bh=xowKy7ttHfMUaUM+uHdbEw6XGE6pguNqiKHZGtqPbXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdFHnGwaahdla19hbSDw/0+iU5Rvij+c4q4sGdeQapxXtNAuu9o1cwBHqCoNHrIFKqoD3zGeZVZRD8qztgsLnmL+hfi3Ig23f8pblnghqI8inme9kj1aXAy4BEYNAvw8XYElmaTXPr4kqv5X27oFYFa68F6QdHEmDSeYTN1lKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfcb4ZPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80378C2BBFC;
	Mon, 10 Jun 2024 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018584;
	bh=xowKy7ttHfMUaUM+uHdbEw6XGE6pguNqiKHZGtqPbXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfcb4ZPx8lK0+yp2nxm1VEMH6eyt0gArCyyHnUbzNGjuRrzqbsdAmQsMjiAZJE6ge
	 UuagH0heWS4ky5pn9iyhGhy0nKJEZSK3GWXOVvPjW+k4EUeZeYHU3ckiUkjN5GwyJO
	 SQPVrxLOq9Sea2uwSeHBbF3SOQI57J6wKx/nnrodhkUddRp829osEuX+GV1WDUExHi
	 HoAetAhuiNOaj/2A/bZ+aSRfGjEvIjYN/jZLHP7G+BmQPZAuofNaRdvvMP9d55d02o
	 S9Xjot9PhoTDl5XTR47sacTcAG0qKEYsaCzqbTMNIHm/AVlzAGGYIZf4+TrXAKNKmY
	 8VH7UukUcdffA==
Date: Mon, 10 Jun 2024 13:23:02 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Adam Miotk <adam.miotk@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Smitha T Murthy <smitha.tmurthy@arm.com>, Deepak Pandey <deepak.pandey@arm.com>
Subject: Re: [PATCH] drm/bridge/panel: Fix runtime warning on panel bridge
 release
Message-ID: <20240610-gigantic-devious-tuna-e8a4e8@houat>
References: <20240610102739.139852-1-adam.miotk@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cz6p5zxgrj6zwsge"
Content-Disposition: inline
In-Reply-To: <20240610102739.139852-1-adam.miotk@arm.com>


--cz6p5zxgrj6zwsge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:27:39AM GMT, Adam Miotk wrote:
> Device managed panel bridge wrappers are created by calling to
> drm_panel_bridge_add_typed() and registering a release handler for
> clean-up when the device gets unbound.
>=20
> Since the memory for this bridge is also managed and linked to the panel
> device, the release function should not try to free that memory.
> Moreover, the call to devm_kfree() inside drm_panel_bridge_remove() will
> fail in this case and emit a warning because the panel bridge resource
> is no longer on the device resources list (it has been removed from
> there before the call to release handlers).
>=20
> Signed-off-by: Adam Miotk <adam.miotk@arm.com>

I've added a Fixes tag and applied to drm-misc-fixes, thanks!
Maxime

--cz6p5zxgrj6zwsge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZmbiFQAKCRDj7w1vZxhR
xXDaAQCXTckO6Gt0AQM1LwNgDv8fB3Wis8cB4feQmE+ZtENTUQEAzZxNfc0dd2KH
uUb331tpnU9u+D8haTTvx1aghreDcwo=
=LhxN
-----END PGP SIGNATURE-----

--cz6p5zxgrj6zwsge--

