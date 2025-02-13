Return-Path: <linux-kernel+bounces-513258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E826A3472B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D133AF894
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BBD156F5E;
	Thu, 13 Feb 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgIc7qdM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D51547F0;
	Thu, 13 Feb 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460074; cv=none; b=MP5s2Qb1Pw6JH5sXHbeNNPWDyDyTazxAH9KJpZbx5/MhADcOMqjKQosazjvcrcLJ6YiiMF7Z1+kM/qciQt/DietSlUyMlwncYdHfbqWVWhrl8MAw763HR2C+YZYB7eeu0jmkh/hI/GihBTmJ7wST7GciesWiIMccX/sqYIWq4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460074; c=relaxed/simple;
	bh=1r8Npm9BUrgfWKv/Ig1u/J729ZLsay612p1P+FDuxQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPJtelPCM6bZauXvDzllwC82MZdXEQM12p0UgyVtEOlEiQZiC3J0NZgJ7Q7Ub5hLOHGgC0h/XyKpYM0Y/UZwsynniLPi2MLHVV0vG+dsDpFIcLSt3imL5PfOnBYzV1jsNPduz3tdiDglky8SiWluNwr8lKXB834X89LcpHDCcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgIc7qdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD3C4CEE4;
	Thu, 13 Feb 2025 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460073;
	bh=1r8Npm9BUrgfWKv/Ig1u/J729ZLsay612p1P+FDuxQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgIc7qdMlU26bzgYV6RFmFfTu15BK/pkzjamfYIao6kGcQLNiZlHkpN3NXS2ksGVf
	 lHkN+oSW3ZD57Oe1A11LMXXZcNeQVeiALFDXHc9CCcR33bFfkt00Z1vp5FNnRKtVmS
	 zHpI76AV2s8D1geP5X7zjWGjQ2UWj70d+vjxuneXVAv4B94xOLjLwKOGYSRoKC4lpH
	 88Hex7Bnh89hUOEVIp+78yiHOu6Hih+UdnbPonBZAsl12Hq7zLDh+vmtudPvdklMRd
	 kU3qojnPZXWy30+3ys8z7pk3PjR9xpaQ0XyHrvfY8dqoihOEbifI8jAj3Lxt33EDCg
	 w+fgtl/Q4juSg==
Date: Thu, 13 Feb 2025 16:21:11 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 0/4] Add support for errors recovery in the TI
 SN65DSI83 bridge driver
Message-ID: <20250213-sceptical-coral-crocodile-c8c4b6@houat>
References: <20250210132620.42263-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="l2ycl75au4yfqn5p"
Content-Disposition: inline
In-Reply-To: <20250210132620.42263-1-herve.codina@bootlin.com>


--l2ycl75au4yfqn5p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/4] Add support for errors recovery in the TI
 SN65DSI83 bridge driver
MIME-Version: 1.0

On Mon, Feb 10, 2025 at 02:26:15PM +0100, Herve Codina wrote:
> Hi,
>=20
> Usually the TI SN65DSI83 recovers from error by itself but during ESD
> tests, we have some cases where the TI SN65DSI83 didn't recover.
>=20
> In order to handle those cases, this series adds support for a recovery
> mechanism.
>=20
> Compare to the previous iteration, this v6 series fixes a NULL
> pointer dereference.

Applied to drm-misc-next, thanks
Maxime

--l2ycl75au4yfqn5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ64N5gAKCRAnX84Zoj2+
duDnAX43dyDoYgSMO7AJmHTKGeMZSm8GBT/8SI46i62wiRVeedKdQvx/IbptPACw
z5u0l+IBfRlKzXIejmMI+r4uHcuSgOuPKGomH+BNnedzyRNtBFbgl4LW1NjcmtPH
RCS2989e2g==
=41Yj
-----END PGP SIGNATURE-----

--l2ycl75au4yfqn5p--

