Return-Path: <linux-kernel+bounces-247722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4446292D3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735791C22E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F519344F;
	Wed, 10 Jul 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlgOnuRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56E18622;
	Wed, 10 Jul 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620077; cv=none; b=QmhaqBF7WdzSUDHH/yHbXf18F2MnSrVAKr30zWlutfrrdmkFdAWxEYXRoeUw9/L7Sl7H3kpyPH91Zb43ZCFwy4o4L/59dZTrARDhL1Z2pOFEWbhUIKm0xQVsBzyNAZ/Q5G59Tq3b1DJa7OqrFPZ55rkj9qrNIWQnH+fLZUoVF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620077; c=relaxed/simple;
	bh=DqU9cIN76ke48HhYoQkN5R6zkS5nfvCzZJkiZIS32WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2qsYIRyGBdfuL75n3GBclI9F2kQOUuPUreEsyqHVlaNDHTFRRo78elbCyOcGkQb+MgKXgEpPRd6WQdqhZ4YSTx2QWqkUzlRqvlzVvserPWYmBKuD3rz6ZMLd1SNrDmD78T/t0bAtqLeMzgKcbj0HpN+H0cX6AkShqt8vqzv2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlgOnuRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0FAC32781;
	Wed, 10 Jul 2024 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720620077;
	bh=DqU9cIN76ke48HhYoQkN5R6zkS5nfvCzZJkiZIS32WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlgOnuRbZ6Xx/tQ4gLcqAf1Gwh+iqXg4Mwrgmxhw0RxEamHK/vWBzh6aW6egfM4UU
	 2VJMSyzxe9Gz34O1AHUYmkPLb+84UVZlTLaMm7RMIUwfTyrHjKU0TDn1fKlkTKCiE1
	 CpS9AF1V2gFvOI/ys1c0rF0kXb2IRt2RDKUgW/Ek0YTL2qxeLPwZ1Ni4lJg9Z6LZ1y
	 J+hXtqI2ygWYGSp8+GOSVeLVHALLni5Ji0i2R/6/UrdSdP9h4GS8fppawM8UfRBy4r
	 8RE30X/M+dLvqXO/TZGsJrhsvXpmFSlyuYz8ElZxikpuTX88ZOoQoZRn9jnPgF1Nfp
	 VIf1GNy49IdqA==
Date: Wed, 10 Jul 2024 15:01:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: display: st7701: Add Anbernic RG28XX
 panel
Message-ID: <20240710-showdown-antirust-a3eb8b65c57f@spud>
References: <20240706102338.99231-1-kikuchan98@gmail.com>
 <20240706102338.99231-4-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HFMSCswt+gKrOFT8"
Content-Disposition: inline
In-Reply-To: <20240706102338.99231-4-kikuchan98@gmail.com>


--HFMSCswt+gKrOFT8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2024 at 07:23:34PM +0900, Hironori KIKUCHI wrote:
> The RG28XX panel is a display panel of the Anbernic RG28XX, a handheld
> gaming device from Anbernic. It is 2.8 inches in size (diagonally) with
> a resolution of 480x640.
>=20
> This panel is driven by a variant of the ST7701 driver IC internally,
> confirmed by dumping and analyzing its BSP initialization sequence
> by using a logic analyzer. It is very similar to the existing
> densitron,dmt028vghmcmi-1a panel, but differs in some unknown
> register values, so add a new entry for the panel to distinguish them.
>=20
> Additionally, the panel only has an SPI instead of MIPI DSI.
> So add and modify for SPI as well.
>=20
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>

With a mention in the commit message about why we are adding a property
and then immediately forbidding its use:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--HFMSCswt+gKrOFT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo6UJwAKCRB4tDGHoIJi
0rWJAP9IHO7fHqyM5a/UICny+oqraSfmKGBb4QQ3LA2EqBU78AD/a0EsmZU8OROj
g207SYlLjekZTX5pN4bqKdUwpSj4AQE=
=8tYI
-----END PGP SIGNATURE-----

--HFMSCswt+gKrOFT8--

