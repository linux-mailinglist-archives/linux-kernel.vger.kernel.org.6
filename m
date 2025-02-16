Return-Path: <linux-kernel+bounces-516865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABEA3790C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B383A04F0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13981A9B4C;
	Sun, 16 Feb 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFpoj70M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1742070;
	Sun, 16 Feb 2025 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739750187; cv=none; b=BAqIuYrRtwgvdIr5CnJdYas46A8ofVXZgp6sAKklpskcXuJVBMqMdKrenm7TzdyxcqkBPun13fk/U9kiSkmfRZq3GVi5GE08TEvMON9j8cClu8TbqeymXRr+qSTWQEpm/EUWDUWsZ78A+huSbh3U2y50w8eZ4UAkqwZjzLNZwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739750187; c=relaxed/simple;
	bh=j6Gn+HMB6SopZbs1Rg2ehZv/3D386/1lLfPTTt36S5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr/gn+5g6+GjIy94u1TjMU/q8rvKg/DtA0pzkCSc+qLNwluxjWCbU2UBJOn87ITIA3mmlV+pR9m2jJYxSI06VOG4pigyg47+K18Zi/2NuzQliTH2zsvzTfXeXQBrQHpfU1cCoHSPmUpQ1vO7P0DAXdSvfsfj5bPCS6024YY29mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFpoj70M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D5C4CEE7;
	Sun, 16 Feb 2025 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739750186;
	bh=j6Gn+HMB6SopZbs1Rg2ehZv/3D386/1lLfPTTt36S5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFpoj70MmzIdRjLlmXyjeMgnSlPUdnKm6CDdyDuFqVNYAPtZXTXdBCkRIvYUuHjGx
	 8MwLcJszK5qyiRliGArDiLLCxq7Bh2xZ2CHw6Cwd9gmj9g58X2or02lGwGW8bMDgTe
	 /jyxXW1d6qCdeiJElajHel/LF+XFVzdXmUPN4EdJliLQZkGjueto01l+UxvGuZ4foR
	 DtUA4dNCHrrvnPpt4jei5KNLwJ9ptTwxyuV+2uocY7zoAOs41WSJF3R0kIfpAPIk56
	 JWFTdYcwphi32QA4QDMXyczkbsPlhC5/ubHABoOCWwc5K2KKz8Gk+GAkxCnzSYtqu9
	 A7PBRBhsbmT5Q==
Date: Sun, 16 Feb 2025 23:56:19 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH 11/27] ASoC: tas2770: Export 'die_temp' to sysfs
Message-ID: <7b4adf37-fdbd-4245-973c-5f923414b131@sirena.org.uk>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-11-723569b21b19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PXshCQ8lgf8ndIg+"
Content-Disposition: inline
In-Reply-To: <20250215-apple-codec-changes-v1-11-723569b21b19@gmail.com>
X-Cookie: This is a good time to punt work.


--PXshCQ8lgf8ndIg+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:02:44AM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> Export a file for the readout of die temperature measurements.
> As per the datasheet, the temperature can be calculated by
> dividing the register value by 16 and then subtracting 93.

Should this be registered with hwmon - it appears to be exactly the sort
of thing that gets exported through there?

--PXshCQ8lgf8ndIg+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeyeyMACgkQJNaLcl1U
h9CkUAf+OlvePkmuGFAOUofSjCQ2n99p0ULLt0fZMHvj7hUNIXjnGzTO0Po8FRkz
2nvCgko1DkFadWb6HKMyoaJMHCSF/tkWKDJHs2YeGbRvNkW93eWano1G05Q7OWK1
XIy8NkwZk54Dy7+/Ahz85TULty7IcvbjTizwwqncuK6rVIJ3YWw1tHKg84KPWz77
4KlLayI1Iq/U+AXEd/qEOoMy6j+nbfWfgWDL/ee7a8bmX9T4GkhPWS+bcnOP06Yv
3YcS0CIxT0LSGyu0IhJAguZSfQpcl2LKtFH1nIsFV5CH9G27yzBeZYRYwFGJlihI
+YGmpmbBXq7Y1bXfk1eXLpBzhlOAqw==
=d09O
-----END PGP SIGNATURE-----

--PXshCQ8lgf8ndIg+--

