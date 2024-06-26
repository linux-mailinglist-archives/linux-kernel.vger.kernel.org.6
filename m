Return-Path: <linux-kernel+bounces-231037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D553918546
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C01F2845B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455CB1891D7;
	Wed, 26 Jun 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l79HF2tu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528D1891C4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414443; cv=none; b=fJHapq44RYlDHRldXIS94mEpLMCrR/yVLZIAAPBBhE5huwTRbNib5Iqi6Ssi+MA43gJt9R1qQrkW+yIchlHetnUblxaDdGAdHZX30mrKE4naaUGrt9VugLJDkZFOmMnmMXGAxaPiFbE/LM4CGw59YkaK8eQMcIuxOpc8WlTzx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414443; c=relaxed/simple;
	bh=8YbKPg4TH0BC9rgNk25pmOEVOwAaOWPwPd5XpI7GyLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0G1lSdriHMZP14rdlYWlsA9aBWVs3ZZjx7cmjHUtCATdgIS3FqK9BUWxV16ggN4mDqdAmGXLzimyDwo5BtV5yT+I0Xo9RgTnBsgXxWZJCfDJcN9VBzFK672OQOCIVgLckYRLibSmABW2TsZssn4hAyoUYqbVRSA+FpB/T9Yc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l79HF2tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD35BC116B1;
	Wed, 26 Jun 2024 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414443;
	bh=8YbKPg4TH0BC9rgNk25pmOEVOwAaOWPwPd5XpI7GyLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l79HF2tudG6y/4LacGEmIzyqanrFY4qJLdhDHWHoayA9S/SPVKJfwlRiJFc/ZLmBL
	 pxk5SruUJyQLU258DbEUdNhcVW5ef2Xl9iOTc991bkOlkKgTH5yP1aFkMffun9uWag
	 n1eosgnZpDGNdHm0npm8arvFUS73RbIgjusSyMoufg0GYYw+zDXrct57mYGbzOXgnl
	 683M8W3FynL7SSOfM35bpdcjp1qEfwNCWr0UGKCIeRQzjACOgai/jgEgJcZa0otq8A
	 jC0llHIcb65n+0I3T7cpxwZCGRhpqZnPxd0ATG/1/hqM5CEvax4Ws+nKzL4t/1EFH+
	 6a0fL/4hdvc6w==
Date: Wed, 26 Jun 2024 17:07:20 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: Re: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
Message-ID: <20240626-warping-nondescript-mustang-bfce27@houat>
References: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>
 <20240626-gabby-ladybug-of-freedom-08e6eb@houat>
 <66ab4206-d1c8-4aad-99a7-c4c316e343a9@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4khqpx6p275qalu4"
Content-Disposition: inline
In-Reply-To: <66ab4206-d1c8-4aad-99a7-c4c316e343a9@ideasonboard.com>


--4khqpx6p275qalu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:55:39PM GMT, Tomi Valkeinen wrote:
> On 26/06/2024 11:49, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Jun 19, 2024 at 12:07:48PM GMT, Tomi Valkeinen wrote:
> > > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > >=20
> > > When a bridge driver uses devm_mipi_dsi_device_register_full() or
> > > devm_mipi_dsi_attach(), the resource management is moved to devres,
> > > which releases the resource automatically when the bridge driver is
> > > unbound.
> > >=20
> > > However, if the DSI host goes away first, the host unregistration code
> > > will automatically detach and unregister any DSI peripherals, without
> > > notifying the devres about it. So when the bridge driver later is
> > > unbound, the resources are released a second time, leading to crash.
> >=20
> > That's super surprising. mipi_dsi_device_unregister calls
> > device_unregister, which calls device_del, which in turn calls
> > devres_release_all.
>=20
> Hmm, right.
>=20
> > If that doesn't work like that, then it's what needs to be fixed, and
> > not worked around in the MIPI-DSI bus.
>=20
> Well, something causes a crash for both the device register/unregister ca=
se
> and the attach/detach case, and the call stacks and debug prints showed a
> double unregister/detach...
>=20
> I need to dig up the board and check again why the devres_release_all() in
> device_del() doesn't solve this. But I can probably only get back to this=
 in
> August, so it's perhaps best to ignore this patch for now.
>=20
> However, the attach/detach case is still valid? I see no devres calls in =
the
> detach paths.

I'm not sure what you mean by the attach/detach case. Do you expect
device resources allocated in attach to be freed when detach run?

Maxime

--4khqpx6p275qalu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnwuqAAKCRDj7w1vZxhR
xelYAP9rq4DgTOaWAG1GpentPFM+Oa9rCBemRAdO5P0rv5Pk3gEA6OdubZA8Txgw
Q5vjke+QG9l7PrrBtNutY58rA4DaqQ4=
=8rll
-----END PGP SIGNATURE-----

--4khqpx6p275qalu4--

