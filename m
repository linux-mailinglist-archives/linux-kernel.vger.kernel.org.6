Return-Path: <linux-kernel+bounces-225703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D5913411
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF687B2295D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298916EC0A;
	Sat, 22 Jun 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rICmA/7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801414D6F9;
	Sat, 22 Jun 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061416; cv=none; b=hbxKCzg6QrCXiPvB3RO+vLLMVRexodiL+N2s7QRfL4EAoZlMFmfaatXtNkK+RvM3sCwBhsMAXU7AY5J4CMDFK0ewyp4qZhM7iuBV0rDagwXjvzAjw1+xRAV2fdPna5qPDGVcIWzS/2/udDqz+6DNRT5OgPktWbqbhreCRXAUD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061416; c=relaxed/simple;
	bh=UrxnrK5wRWLLAqbFuJQdybESu+fL2JUBL/OQiQsMn1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXFgS1B8qLNN6nEVmGgrNHto/Qf/C8zLG8avn42IMtKnppwAk9SJJw44CoR6UcjYwHV0s+4pA+7Fe6BhGCjro9MZsIFY92LxrrcwRfaNucBIa223/nWvfIhAVQaKCb0kxhplbEiRtUDGHqLTTFgfWLEuEDvztPcpQiksKkjTX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rICmA/7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16BBC3277B;
	Sat, 22 Jun 2024 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719061415;
	bh=UrxnrK5wRWLLAqbFuJQdybESu+fL2JUBL/OQiQsMn1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rICmA/7hK70cX0IM8LZFNqXzboC014+YqVAuaOumofoi5yYT73G7QM/sPccdVDXRC
	 Ds/JWgeRnBygStUgniH4iZAEy82fp3Hlq4a0dNFCrhTSd56vOua4AXaTQad9KMfz0I
	 uP9KFkg8gS8/8L4KgN+1KIXLam4+bHx9vIFTemOaQC3KIRjJo9wcqKLGrzz7Emn6G5
	 SqI4KtrZmSMe1aVqyjbgitUy/CTLYQJO9Q2LAGszmeZhCkB9ppCrqXK8JEjEs1QeOh
	 D90xD3WapBblbNM03i3Lk7mQ/ue7KOZNZw7X9T+O8X5rtL1P6oJSo92LFKpzSBmv6t
	 wMZRI4tt+7+DA==
Date: Sat, 22 Jun 2024 14:03:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: Add support for ti,pcm5242 to the pcm512x
 driver
Message-ID: <57f0036c-4412-48fa-a6f9-3fa721717be9@sirena.org.uk>
References: <20240622124603.2606770-1-christianshewitt@gmail.com>
 <20240622124603.2606770-3-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ns7W6Wuqxln5UvNz"
Content-Disposition: inline
In-Reply-To: <20240622124603.2606770-3-christianshewitt@gmail.com>
X-Cookie: No stopping or standing.


--Ns7W6Wuqxln5UvNz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 12:46:03PM +0000, Christian Hewitt wrote:
> Add a compatible string to enable support for the ti,pcm5242 DAC chip
> in the pcm512x driver.
>=20
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  sound/soc/codecs/pcm512x-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)

The device appears to have SPI support too like the other devices in the
family, why not add the ID for SPI as well:

   https://www.ti.com/product/PCM5242

--Ns7W6Wuqxln5UvNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ2y6EACgkQJNaLcl1U
h9BmaAf/Wf4dlhJjpl3fS3/Wwz1IA7U7HfafHCnGFTG5WaABcOG2qOrxjfPC42iR
KUeRAaU4lqzPSWjayl/eVXWAB6v+x7qKiZuAcQ4vP7g5odGfmIKt+syT5RN4P+xP
R/EC9NkzmlgH0nb23+NJXnuI+sekheoJvxEt2dkbOsDQivW4IMWwzmiOfTzwLCux
3zOVaKR+MzriPl0P06oDNsiDycmByd/S2q/bbAbcdrdacAoURmI7mY+F2Q5lVGOL
07n+SC66baBDVYndWfWS28+50cenwUOAwm1+am3xFTIiNa5U7Zr3ShBj+S67sDzV
ijKbKj9dvuc7CO9qB3dyJcvkOi9s0Q==
=lfJ9
-----END PGP SIGNATURE-----

--Ns7W6Wuqxln5UvNz--

