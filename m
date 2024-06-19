Return-Path: <linux-kernel+bounces-221309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A190F1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2712881A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4A142E98;
	Wed, 19 Jun 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khNXe69m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE778C91;
	Wed, 19 Jun 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809602; cv=none; b=i70X8RUW/MQ+3+Hd750y8y2oa8wooAPoIjCMtI2OuspJJpsIU+ieYnYtZAhb2QfUlOxEELX39MajY7CAC982uOcDMNUDisD4RNh7s2z34ldgzzldOznLAPouVTcoaQ8D0wHQehQIvK1D5NHHNEVe7/t33M38fU4F24kLF0KLla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809602; c=relaxed/simple;
	bh=t6RqYDc9zHOqi3suBjLShR9za2xsd+P52ElnvkNMnNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIdoF+wOwaQFsgImuAl0Dxbgg6qe+7isKv6ubZHj7BnzgfzwNrtNa7rmjFqCedXkOpTt12GfXSu/RGqG/jqIl9pNzhJJH5tHlsfvDHyur3RU7XZVKIHAd37fm04C7/JN7U3pRNl0DIemU6cKL3Eyn6y4A3O+XiThnqrebdmITLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khNXe69m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E22C2BBFC;
	Wed, 19 Jun 2024 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718809601;
	bh=t6RqYDc9zHOqi3suBjLShR9za2xsd+P52ElnvkNMnNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khNXe69msU/1f4gJPQxwg7veWijNkvSzAGBJjeoYKc5VdJWwGLc7AJaKotbqedCyc
	 iJckGaj+CUMmhrIJZVZmWLc4FY6Opl83Tzreg9vJZyCdLETg1ZKvdwUTAY/DK9xXL5
	 IKNiIgWoQh0XSFZTWwf3YyL/vId3H41NIZ2pNAWHpJ2VCUMgXrhjSUxD98aY8ddh/H
	 HUVYKhUzVsjznbSwdYdR36Zp4gnbHLxrtUANbQcQhQQMRBe5dThPWsOW9Q7GfJLkAl
	 b6TzGFllyz3P2JW13k6rgxQE69HGXNb5c3liTmctJIwi1rNh5FDItxysX1bX+oF57p
	 2EBqJBwDOUhRQ==
Date: Wed, 19 Jun 2024 16:06:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] ASoC: simple-card-utils: Fix error
 handling in simple_util_init_jack()
Message-ID: <cdeb8451-8a72-473f-812e-6c21a96cecb9@sirena.org.uk>
References: <20240619142432.573338-1-Igor.A.Artemiev@mcst.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngyz7Xu2vyiOf4Qc"
Content-Disposition: inline
In-Reply-To: <20240619142432.573338-1-Igor.A.Artemiev@mcst.ru>
X-Cookie: Don't I know you?


--ngyz7Xu2vyiOf4Qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 05:24:32PM +0300, Igor Artemiev wrote:

> Currently, if snd_soc_card_jack_new_pins() or snd_soc_jack_add_gpios()
> fails, the function continues execution without handling the error.
> This can lead to unexpected behavior and potential crashes.

This just looks like some static checker thing, I'm just seeing a bald
assertation about issues and crashes with no analysis about what those
might be.  TBH I'd expect this to make things worse not better.

--ngyz7Xu2vyiOf4Qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZy8/sACgkQJNaLcl1U
h9BYcgf+OnjKQt79MdSbG/lH7BYTolBSIy5tsmp0AuL540BEGkdL8bvLOmsOtVHf
btjHv7kQRhkt6JbSpQvAbDvInPU8oBNWlRBfr7S3WXkRgzn8bidhw/XjPjOHq/fl
dQOgbjpnPRjd3xVgzec1xxsLz+u4y3mnwS0qIr/nPwUGm/tLOP+Q1JK5DlYwaBbj
gD9DdFdTywY/dsfqPgjkm54CoYCG7SVhMNWISWUTvfoNg5laoP2DSKJVLXZ8g3fR
kI6AYLfCti3msZh2un5yONgyaPWzg/k9zxULKwiN5k/alW7dW6Lp9Dh2ifpA4anA
eU3BauCXjomvQ4gvQMBI0edBhoA76w==
=RspS
-----END PGP SIGNATURE-----

--ngyz7Xu2vyiOf4Qc--

