Return-Path: <linux-kernel+bounces-230329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5570C917B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D7D1C24CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC51662F7;
	Wed, 26 Jun 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYGQ2IbG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED583B1A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391791; cv=none; b=ZkRyPdwspVHn0mGUXYe2QS76Nx5rxzp06Ubwc9lVDI7zuMKgqAgORf0s9fpGCDOEVZ1uHvcnCrLj7CmYbHNMiGhhwcoB1fwMNpTCl6+j7W2TDf3N/5Ntp2FITdhSZikjlb+nr2BWfbWWk09HGmJWNNY00ScjT/lWE3hDkxSE7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391791; c=relaxed/simple;
	bh=x2FQqs4Sx0iJn0+hfgdF3u+B2PEHaqqKDMTHL+Hlyu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hoh/mDjs4dOTJpkJwBWwfuliW8WSV2913CCqkA1Fl37RrFv6fzYRa4RgXVB1+yhRnxyrGU0aJUOj1OqdnIy8M9jQx45VzxhgNDPhlZqWvBS6BLeGW2hhB59Wa4u/j6UvpaQZ0MVqa98pMOz9tUMPgE1Wfqkfvcqb1LgZin6oQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYGQ2IbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C088C2BD10;
	Wed, 26 Jun 2024 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719391790;
	bh=x2FQqs4Sx0iJn0+hfgdF3u+B2PEHaqqKDMTHL+Hlyu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYGQ2IbGRTMrHKwG4fIR9ePAyoeTZCAVRGxiy9a7ZhDnz/t11Ps202E2sT+ZsKKbM
	 XUtr+ozeoGNb3FWN36aN0Z6Mm5iNQ4nCVaEg3RptIoKGfhZSplP++PEMnmq8yPWqqc
	 Dpx3vSlrc+lF/rwYamEsNcD+dGgRZho+fVh22thNfkvdyIOZtG0cnBH8lea7iHzV4o
	 PK50q/u+0lo7gaQOa96DZ966nan/1EIv7vrA6bn1hR5E1F71ZBZl+PbPf40VaUOGlP
	 oPQHILH6IJaaqc2iAbUJhfnwLdipDfRWFqwcPevbEHdslAxVGb/TC35xyUjrr8dRp0
	 QZqRchXBTvhHA==
Date: Wed, 26 Jun 2024 10:49:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: Re: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
Message-ID: <20240626-gabby-ladybug-of-freedom-08e6eb@houat>
References: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ma4ycpybtoh2dbzf"
Content-Disposition: inline
In-Reply-To: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>


--ma4ycpybtoh2dbzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 12:07:48PM GMT, Tomi Valkeinen wrote:
> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>=20
> When a bridge driver uses devm_mipi_dsi_device_register_full() or
> devm_mipi_dsi_attach(), the resource management is moved to devres,
> which releases the resource automatically when the bridge driver is
> unbound.
>=20
> However, if the DSI host goes away first, the host unregistration code
> will automatically detach and unregister any DSI peripherals, without
> notifying the devres about it. So when the bridge driver later is
> unbound, the resources are released a second time, leading to crash.

That's super surprising. mipi_dsi_device_unregister calls
device_unregister, which calls device_del, which in turn calls
devres_release_all.

If that doesn't work like that, then it's what needs to be fixed, and
not worked around in the MIPI-DSI bus.

Maxime

--ma4ycpybtoh2dbzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnvWKwAKCRDj7w1vZxhR
xV+RAQDxPPXHzU0G5JIlvexkx+UGfN/vqNUmfWcE/Uf5o9YCBgD6AxDzso4qILCM
yKnz2Ap02KUvyMTtu1qzFLkfRoYDzAI=
=Paf6
-----END PGP SIGNATURE-----

--ma4ycpybtoh2dbzf--

