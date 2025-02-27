Return-Path: <linux-kernel+bounces-536822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CCA4847F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82A47A3337
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BCC1CD205;
	Thu, 27 Feb 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9jgtNv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B601A841C;
	Thu, 27 Feb 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672620; cv=none; b=GZG6nq7MrQVo6djmHmGiUP/yZc1RcKotaKvsGdTzZcb8JDU3fbjpqosCjw8t7iqvt9HOKCoXrpSTUS/5uATsfJxTaLZNcP/H+VCfODK+5e2pQOJDRcYerUn3A5fwS2UQFN4xQsN3aBqp050A0pMZanjzpDKNyzmfPUCFF6lHrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672620; c=relaxed/simple;
	bh=YCYZEqDU29mV/oNhQzvKUezViExGkTYP3v0Ttd1er+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMGOTR68klGUrH665855e42vUAr2YR1OnlHHwOX3OsKP2nN+5U/XMOHz5g5KKfTQ7yNJoqgd3wKg8v6EAMJ6hywOyAv/uNjSNF+cWhglfpdvX7bXMjVlcx1YGvjzXnr/OEm0nYcEOQqr2DtbLgbXtA31tQtba00zA/twI+FaPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9jgtNv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BDC4CEE7;
	Thu, 27 Feb 2025 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672619;
	bh=YCYZEqDU29mV/oNhQzvKUezViExGkTYP3v0Ttd1er+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9jgtNv2TfNW57fbo62ipO3IfdMDTIdaY+Q2mzg4eQ8YdQsp0h/yXw3FkSA8Myfmi
	 V6d7RW0ZzMYMlsAwg6z3dlyUaiIdZCwtyw3yLiD/au7CHcZTSMl9HP1Ager722NGzk
	 B3jIc9TGXbZ3SgNkr1tU0bobTT1MwYTyQk+/ABjjOdbdnE4DzqNZOSQpaWJfNlPfii
	 UheFk+CcWHIroX7zRZOT7vM/PoPJEJ8N0Gyw4ddK6rK2/xzLQ/IOwd+AyuppJeNWKG
	 2h0UF/GQJLHjn1KsDMfHs96xZT2QERoEWPJ2TfanTIbmAa7dig1BdnJHPPKvmZfUd5
	 NeNRRvg4anqOw==
Date: Thu, 27 Feb 2025 16:10:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: mediatek: mt8188: Fix uninitialized variable
 msk
Message-ID: <7e26d6f8-a920-4933-9f27-52f08a975acf@sirena.org.uk>
References: <20250226161847.567160-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWySIzzNsqHTGnmF"
Content-Disposition: inline
In-Reply-To: <20250226161847.567160-1-colin.i.king@gmail.com>
X-Cookie: Swim at your own risk.


--pWySIzzNsqHTGnmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2025 at 04:18:47PM +0000, Colin Ian King wrote:
> The variable msk not initialized and is being bit-wise or'd with values
> in a for-loop, leading to an undefined result. Fix this by initializing
> msk to zero before the for-loop.

Arnd sent a version of this that picked up reviews from the Mediatek
people so I applied that one, should be fixed in tomorrow's -next.

--pWySIzzNsqHTGnmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfAjmUACgkQJNaLcl1U
h9Cs1Af+MSLOz0trHITEydA1HvWLS0Wo5bVckllFyYx804ML5J1ygfDeFai7jkCg
xvv6G4/0iIDehHzjt6Dgx9QchR7zs1jYHqYB18VHczyC1FmDxAZqsJP8BiLdiZAc
LmJqP7Ja/AKV38HZ7PRzNumF6+wleFdUFGSFUjTVPeQhY3gBBA6m+/yzt9OsBmnq
vFaxQQO7gi0K1o/FGNtYrFVvd9M/daCguvavPfHWUFA4CRTc/sMKCEfmxPwTcqQl
4Qy2pG9lptEg0Z2NWfDyk7eS9lXPZgMae4Ce9OXhQFR8UnLprTGz9xXoQjvGQ7qm
UhKi612TSq9alxvM1gAim+feYjpyTg==
=YEY3
-----END PGP SIGNATURE-----

--pWySIzzNsqHTGnmF--

