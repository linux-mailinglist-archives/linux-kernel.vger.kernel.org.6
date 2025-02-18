Return-Path: <linux-kernel+bounces-519753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BACA3A175
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669A4173803
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9D26D5CA;
	Tue, 18 Feb 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDF4hNMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8126B953;
	Tue, 18 Feb 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893045; cv=none; b=oLT/1Iyl9uOctGwZmBzNWvSTBtfjCqNPdEP4oO4R39jR/dSZOkqllc7kYhjOFEbID9X/mP9s8yK1V8xH70P9NPsxDXbxzv4BIncuddJiN5hHWR6oc72arRW9Nh7M4qbzneCCgGhvQ1mhHKhc0rN8PX8AcWMaawfO7QOXOkOS450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893045; c=relaxed/simple;
	bh=Pt12o47FXSx6eqtwoWUeScEOX3oJJlfjIsbV4sD9XRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9EMg8k/tN/fId8Z3EptwrApO4D73OsgRVw73R9XKkYfq6C3n6MK86kRprmb24tHLc72jOJ9oYMwTkLQayvvbxP7+RM1LYS5I6COibI0Mp3au9Vq8IycLr+hA2AUBHsOTUgkf93u/gA1Oeb34ipXr9Dn78CsLwoPMw5qGdpg/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDF4hNMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D349AC4CEE2;
	Tue, 18 Feb 2025 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893044;
	bh=Pt12o47FXSx6eqtwoWUeScEOX3oJJlfjIsbV4sD9XRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDF4hNMHcXEh9Ay/SdBtdRxvDYUKoYxDDUdeW3dHZag7lEFN8wUHLFvSQoxdb62sh
	 Xlm2+apObb3FGSZFjoe9Pnl4Gi1GjPLkHrxiJkI9+xDq/pbYfz+d+J4YEj8Yfp4VGS
	 YFa/BOBbzoT/kZOXn8eK3PlIFq64OmvHQ3ggHcr0581ejv9L0ueZwsvAl6vsUMwWQ5
	 LHL5OBSxvVxc7vKSVUuyHz74VFHwyXUHM9eWo6cyoAahzOFlU3Z0VVtBMDRHNWt4Ea
	 TdZudm6Zhx+rl4oPz1rrTYMARc8AKbTzfZqd5rd+3jEJU8HyikPHJKAtdRhW8mi2Ne
	 EUhIt0or/aJ/Q==
Date: Tue, 18 Feb 2025 15:37:21 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 26/29] ASoC: tas2770: Add zero-fill and pull-down
 controls
Message-ID: <Z7SpMY1XtvjlUTDo@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-26-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dgm1DNGToy699Htt"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-26-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--Dgm1DNGToy699Htt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:36:00PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> Expose the bits that control the behavior of the SDOUT pin when not
> actively transmitting slot data. Zero-fill is useful when there is a
> single amp on the SDOUT bus (e.g. Apple machines with mono speakers or a
> single stereo pair, where L/R are on separate buses).

This is adding a DT property, please add a bindings update.

--Dgm1DNGToy699Htt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0qTAACgkQJNaLcl1U
h9DMrQf/XvTsX5DHjtmIknji5B4246yYWOquIxmQFtaGwN4c6iu8iDlW5f+cJiAr
by1QACyYIwd6ef3vxOD1CG2g2cwwvaqIsvX/lSYmeV276wLBi9Bhkwyxx0ySmQZD
7xOktLhIXsmRkIMpgJfciaRdzE4F5XGjeCcBZB8AjtimcWFDuDI/iT3FAfCPM2mB
oHFMT8pSHn3Cx9uq56GJbeE3fyXQkSJcQz7X3ExQ4U3kTDXeqIB/EbPwbFcgg0py
8rwXonCUMy4wdVTjkngjs5G5alrlG70k2/vRqGtPJ803/xs4M2R6jZecudOuCzby
KnFXB6e3l06mZTM40xMSm70VixH5dQ==
=y0ej
-----END PGP SIGNATURE-----

--Dgm1DNGToy699Htt--

