Return-Path: <linux-kernel+bounces-519757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1124A3A181
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E743AC09B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DC26D5DD;
	Tue, 18 Feb 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPztPw+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118A269AF4;
	Tue, 18 Feb 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893110; cv=none; b=eT/lgzvJbjxUZN5CPnmL7quy2ZpriahXziWUkYg9gL7bDDl1V1YBSzHQqEM1ytAAVkSDI4/N4GgMi/HwrzwBBBIbYmBurcRHWoGuzTPEPw2x9MTIgw7Z0r/HftU7MwO8NMzv+XjPGnipzwXZK5bBxiNjr7K/3BrWknPlgT4SMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893110; c=relaxed/simple;
	bh=joPSfEZV+4aLPYPABOyQKt5zihMFx75oapssE5Ldad0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5ztyNZNHVV/7OWxkSZ+/EmklIcfmX/Hv0i5LXdqgjlSNxXgFkNC09KikuUrKYDlDitFxSaQraHZ9/FQoGTpjlrp3aQpdYNgOK0Zxd6GCEHSgSo2uyJx4MAYGsrpHdQsLDigTtgPhWCynpJFXigDkV7lLKl2zLwvHXavGz9t/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPztPw+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625B9C4CEE7;
	Tue, 18 Feb 2025 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893110;
	bh=joPSfEZV+4aLPYPABOyQKt5zihMFx75oapssE5Ldad0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPztPw+Roy+YvCLWy35PZsaqIno+mahEvJbPMVp5hOm47FVarfI23U3aNpEuN6JhL
	 m7Ql9wJNzWqqX5QW+XhPQgNdIxEPkYDJ/qRdIhP6GsxQlWjGlVxjSYRu7xc7LuBlSS
	 bg0kaMGODbGkS4nwYdyJ6XimJLLrADEt3750qymla7yF1LxNLO9DaHA33FOPYfF4qm
	 zHX695BOFsGCpxJXEgdHgR/6cB8YJkm6EmoVdM49xrP/ioslZ2pxpBzKjMc2Du/M7A
	 hAxg/E25n7iBG1jXEz63gsiZe5+3tdtaGvhH41ctdR6uP9adCu8UmF4UDpC2VNZ4z7
	 CSUuwTh89t8Ew==
Date: Tue, 18 Feb 2025 15:38:27 +0000
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
Subject: Re: [PATCH v2 28/29] ASoC: tas2764: Set the SDOUT polarity correctly
Message-ID: <Z7Spc-tHHy4IvRGx@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-28-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KgWXd3LHFB3bSERc"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-28-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--KgWXd3LHFB3bSERc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:36:02PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> TX launch polarity needs to be the opposite of RX capture polarity, to
> generate the right bit slot alignment.

Fixes should go at the start of the series.

--KgWXd3LHFB3bSERc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0qXIACgkQJNaLcl1U
h9BC7Af/UOtCJ5cQmn09R6PYGG6NnfBWsq54Xp2YhaSnH5VhqP384/z/zKBEMS1N
+3K1ni9mXewI25rH+vfMrjz80E4lcS2DL7he1OfscG0SAOtyzcNdtWJlVdhX13Zw
lgOAP73k56zbG7Ub31xSlL1TqQ1IPBI2JoK/2mo0H/hZaw+wMmKVPWB4QM6KQmiY
1/8ZDG7VxzHD8cWeLXrwIkmEwJ/Sn+JOk06C5h38LYkbL8M8DQSEC0c82qk/HnVZ
YB33HOsStfukrmdKgWwn1wUpZ/Z06LQShvoTGCK5sIE9but3BXluKft9rVIUlANv
53CamT8Ww9O3Ae7vZsuErVOkOxgpOA==
=5mkQ
-----END PGP SIGNATURE-----

--KgWXd3LHFB3bSERc--

