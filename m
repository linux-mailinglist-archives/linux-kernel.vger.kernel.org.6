Return-Path: <linux-kernel+bounces-541977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800DA4C41D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6EC3A6CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F22144DE;
	Mon,  3 Mar 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNj/pod5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C72147E8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014037; cv=none; b=t/zC6eYDOSCorUtRDuCMqtu8GjsU63eaNqfTEN2TurABQQZ1L8qyjDgi1qHWakE6Gx4cX3EERe7YkGcsDcFtPmAWcB+fb1lWW1bPnI3/nlxUwBu9xhonhx4R6trmtI7ufdoT3J1+Thr+JuEeYiw9z5Mk51Fkwq7iNmxG6aw0/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014037; c=relaxed/simple;
	bh=mbiIUj4/EVUrMF8Ts2vQ2M6GWTdgcmnzN/tc58xgIt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpTiCOlkN6f+9n66Du+i06vLMKo2S1wgia8jEWPXgiAwBao5/m8zlTyynNnpTL582aRqJTrWoGsouATrBIM6RjDqTX4d4zLiV2nPZZgFsPAKJTpwccl/WJuytALODytqSL3fDq6sy88l5i4HhWhm8rBQVuQ2X2OG3FHBc3H3zdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNj/pod5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB54BC4CED6;
	Mon,  3 Mar 2025 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014036;
	bh=mbiIUj4/EVUrMF8Ts2vQ2M6GWTdgcmnzN/tc58xgIt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNj/pod5Qt5IJeia9n3u9LWgap4a9MOon1FelHi80RE3+JAgmRc1OY2rXm1PaPZIo
	 dQ/9J6Cka5/r5k7xpLl5Xsc2qN27oKnHzWCKb7TrxIKXWC10crQyT0yZl6vUVNAcSf
	 4CNVKV6bjnr6rb2qajbvHleV1ulLoiUax3O90AUZkGZd0b3i2rcd+OF422ClMCZog0
	 ckXRW2TbN+0FyUuAEre+rbt0u+zrhxYHQ3+Tlop6lFMLaGVHl95hBgYgdmccwXNLVJ
	 UB5w+NDE0kTd2oRHOkV5EIAWah1v1aeyUEfq04mDzk2NINY6QCG6YBnN9XteKNSs5W
	 eE3RJEVmklKrQ==
Date: Mon, 3 Mar 2025 16:00:33 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4 00/15] drm/bridge: Various quality of life improvements
Message-ID: <20250303-idealistic-camouflaged-mandrill-4fb5f8@houat>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250227120004.77814e09@bootlin.com>
 <20250303-urban-trout-of-vastness-f8d0e7@houat>
 <20250303143404.623a3178@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="cogn5gh4bnpmv6p3"
Content-Disposition: inline
In-Reply-To: <20250303143404.623a3178@bootlin.com>


--cogn5gh4bnpmv6p3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/15] drm/bridge: Various quality of life improvements
MIME-Version: 1.0

On Mon, Mar 03, 2025 at 02:34:04PM +0100, Herve Codina wrote:
> Hi Maxime,
>=20
> On Mon, 3 Mar 2025 14:11:05 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Thu, Feb 27, 2025 at 12:00:04PM +0100, Herve Codina wrote:
> > > Hi Maxime,
> > >=20
> > > On Tue, 25 Feb 2025 17:43:48 +0100
> > > Maxime Ripard <mripard@kernel.org> wrote:
> > >  =20
> > > > Hi,
> > > >=20
> > > > Here's a series of changes after to the KMS helpers and bridge API
> > > > following a bunch of reviews I did.
> > > >=20
> > > > It's mostly centered across providing an easier time to deal with b=
ridge
> > > > states, and a somewhat consistent with the other entities API.
> > > >=20
> > > > It's build tested only, with arm64 allmodconfig.
> > > >=20
> > > > Maxime
> > > >=20
> > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > > --- =20
> > >=20
> > > I Tried to test this series on my system but I've got a compilation i=
ssue.
> > >      depmod: ERROR: Cycle detected: drm -> drm_kms_helper -> drm
> > >      depmod: ERROR: Found 2 modules in dependency cycles!
> > >=20
> > > CONFIG_DRM=3Dm in my configuration. =20
> >=20
> > Could you share your configuration? it doesn't happen with allmodconfig.
> >=20
>=20
> Here is a defconfig that leads to the issue on my side:

I still can't reproduce it, sorry. Is this based on linux-next /
drm-misc-next, or a private branch?

Maxime

--cogn5gh4bnpmv6p3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8XEDQAKCRAnX84Zoj2+
dg0uAX0WvqRhLb/HZAkDURiKptJwT/cCV4cvWXvhwevHn99+9y2MbewgRPnDXQAD
WRpELIIBfA98EqeQ6CPJ5vopALVEFTKGw5yAzuxR8RwfzvRHaac58eNTlLZYuxYE
9WqcJ9Ho8Q==
=qrxN
-----END PGP SIGNATURE-----

--cogn5gh4bnpmv6p3--

