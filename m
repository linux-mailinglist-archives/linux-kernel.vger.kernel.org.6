Return-Path: <linux-kernel+bounces-536846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88EA484B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9567A232D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906941B040D;
	Thu, 27 Feb 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQHKb5GS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2061AA1DA;
	Thu, 27 Feb 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673354; cv=none; b=QbRTUZy5ulFzBmBkFKglTW7bl/kI8yvsXcSQMd2mB8sZmbxDr2miCLWWo4CsmEm0P+utpVGzqmOlc88OYkWWYNDLW5dwoqpXIdz+uuq7NRJbVei71rVhXGIEwq9tIx0u10oq5nb7yGS95G1htj2t0KNZ+jIjLT+YoumU/MekDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673354; c=relaxed/simple;
	bh=7oJwvuZomMWiCSFUAia+pino3G8sWkHGl5wL803IjLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJN2AOkqJTD35o5Q6+QO9TsstXAQPCg0sycLkdGBRT2sSs3OXqsTX55RnUgaSnfXCwVQMar7VGFEyvElq3UKeFdsy5Mt9HfdGrBMm+J2XafdBzxQHWotlxXOAajLUCwKudhOWeNPG46jz3/0DjyrO67nis3T0Weh3JhbFDVBHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQHKb5GS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6B5C4CEDD;
	Thu, 27 Feb 2025 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673353;
	bh=7oJwvuZomMWiCSFUAia+pino3G8sWkHGl5wL803IjLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQHKb5GSo139CsmkCQwX24SS+iDXoyAh0UP5nqNCwvuAFiCF64xYBpyjGVusK/Ywy
	 BPnkwSbOy+Qe4YcVaKV5zVi9K6UkbF1FX8PgR3YhH8by94484RtCHeYp6vxbyynPqD
	 FZSh7cPSOg4j+5hICQLlzGbfqjW+xk68cJC7cEaMCuneM7gQnHH4Uv9HBjzYHJnf0k
	 K5pKA7Z+P6R9zxaFAeQHi/8D6WTHlT5g3G9AiWCxZGyTbG9rXhpF+QYrHxW/HQTnO6
	 NABsh0la8VqbSRFAA38ogUMXoJoRTXZi63OD8UwYOp/WyF04RQgC/dloOEqO230Roe
	 NI89VEcRKTi0w==
Date: Thu, 27 Feb 2025 16:22:26 +0000
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
Subject: Re: [PATCH v3 14/20] ASoC: tas2764: Crop SDOUT zero-out mask based
 on BCLK ratio
Message-ID: <e13e0922-f51f-4ce3-8ff4-3dbce41864c9@sirena.org.uk>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-14-cbb130030acf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RQ2t0JCNkbhgW4MV"
Content-Disposition: inline
In-Reply-To: <20250227-apple-codec-changes-v3-14-cbb130030acf@gmail.com>
X-Cookie: Swim at your own risk.


--RQ2t0JCNkbhgW4MV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:07:41PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> As per the datasheet, SDOUT bits must be zeroed out if the
> corresponding TDM slot is invalid for a given clock ratio.

This seems like a fix?

--RQ2t0JCNkbhgW4MV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfAkUEACgkQJNaLcl1U
h9BLSAf/dKpfouQU0WEWnlQyGAZst+aDj7j5Va/OtzoOiOirCIqTRjok8L6HNuJ4
pYiCTZFKXziWVijVOGyBiYcZDdEP9VnwPUjFTsqJftGoWyqxsiHI0dO9H1yEdXsH
JBLwGduWkAMRrpofp6R8YILSpm8zeukGj5P9zaoCFNp4UEy/2G6RWB3tPFlLsKyp
Y8x7BtRH/r399KpIiCd+5kF22sCtuQwtz8znricWctufvW4RhXxEGFGGBea8JkDJ
EG9wHpDwjwUAChK++dODpRAHUTydKZj3nxnoyH8pLFFcWC/qAXQUHNOvZoClN7cF
Xzfv+FEtTW2a2NmFadx2LHVrxvZgFA==
=BqH6
-----END PGP SIGNATURE-----

--RQ2t0JCNkbhgW4MV--

