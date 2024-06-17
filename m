Return-Path: <linux-kernel+bounces-217258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73B90AD7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25EF1F24223
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00D195396;
	Mon, 17 Jun 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoMz1SDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C2194C66;
	Mon, 17 Jun 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625488; cv=none; b=DyRr8oeVbnCPUChDxnIrbeOGxD0psZCIQJiR1NijHSbPhGEa2tSeW1D/JLQhZgcHeSdB0DCiZq+0bsXHoiEvTrY5pU3PcdG8D6MbTMYJJqwAkeZriqO1QcExFgSO99xcinNHHdJhM+t0ZIHhoTNa436tPJCZ9x5tLlTdGfi3qYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625488; c=relaxed/simple;
	bh=X5JiCqypFbHptTUVDtzngaHI/weqhKP2QNBf0QsHGSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AemQraEYtHIgtVqiMAlDLd4UJwwJ7Wy+mMTaPyMS4hTkynjWJN5lmj13O4Erp29wagqd1Jd9Y4EZqh+HQ9nKJpdo9K9grqSdOVRqBaFZbHVvKQrWjTqzolN3hyoqsol8W6dorwKYY9OkGYeWFQfHqkn+gtwgl3mAYXx+OGwQs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoMz1SDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D08DC4AF1A;
	Mon, 17 Jun 2024 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718625487;
	bh=X5JiCqypFbHptTUVDtzngaHI/weqhKP2QNBf0QsHGSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoMz1SDF96V9gmkV+GM/1KCzQRTAYPiLaxKG7pObFz9DaXPVOPYbrs01pocf3r9Aq
	 XyVa+wyfqWoRuIhPLkZWtnnUvJZOeswKqDH6O6OCNmfCgAn3RBEW4lZfeVGmXwR2MJ
	 t+QiceaprTTkdPgI9fJS45sO3rsFi88QIGqeMWo8TQpkdImyqoAWWMBvwIJyMZIPJ8
	 uPjEG0F4ZRC4qDwKjmbQcc+moeRBlAN9FRcu3wHxhjuUkg5MsLPgBkWz9y4vtRl9Lk
	 tM+owBJ6xYrTmnq340Xc4H9PBb8wCyWvkJLhmU1ABRplaPLCjTngc9ezP/Jv1d7bpy
	 A3dYBZERt1+Sw==
Date: Mon, 17 Jun 2024 12:58:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Hao Ge <gehao@kylinos.cn>, linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Takashi Iwai <tiwai@suse.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoc: PCM6240: Fix a null pointer dereference in
 pcmdevice_i2c_probe
Message-ID: <a3bc08f4-176e-4111-8c20-d4570c3cdede@sirena.org.uk>
References: <20240614024116.22130-1-hao.ge@linux.dev>
 <083cd51b-06d8-4618-8517-a2bc2fa31554@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dtzp491h5UXtcDrc"
Content-Disposition: inline
In-Reply-To: <083cd51b-06d8-4618-8517-a2bc2fa31554@web.de>
X-Cookie: Life is the urge to ecstasy.


--Dtzp491h5UXtcDrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:20:38PM +0200, Markus Elfring wrote:
> > When devm_kzalloc return NULL,we return -ENOMEM directly to
>=20
> This information fits to a coding style advice.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv6.10-rc3#n532

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--Dtzp491h5UXtcDrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwJMcACgkQJNaLcl1U
h9D6Hgf7BnGok0SnkZFPurGv+oigIqbKUCEQ7sOWQEs8qgpu4xR1fWLY7c8vraJS
wCj1h9eBdtCnT0Gd1pu9gzPGcmpxlg7LLWUu5jpcFWHIPgMEN3bf4S8bO06MPE2y
Goz33J9PmQsg082i+gaztIwkCu8ZkS+4Z5BWSubdl4gv4hLsmU7qiedg7KCA6Ak8
eSnKr0JGvcPT0fjM48yg6dduhAJdFR7IC+NrS4my651RtFiRx4WnIysIeEpsYQsc
xtS4qu12f2Kv36mLEtlGT7GmocUJLBrSEWQqPFQYDz88DSsvSXPx7LaG69W2HJj9
A/+ODY4BxXz732C8MY/Xwkc0wkxXgA==
=5Lov
-----END PGP SIGNATURE-----

--Dtzp491h5UXtcDrc--

