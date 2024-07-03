Return-Path: <linux-kernel+bounces-240139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16112926982
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DDE1F2303E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8418FDC2;
	Wed,  3 Jul 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsMHSpij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE61136678;
	Wed,  3 Jul 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038323; cv=none; b=cC5udfuRlS17O64CaangwO3W62+gO3EwbEhKonPObZGa17Cw99ZylMx+kXfSZhu1L31ty4xvK0gUbwewyDpRqggMMOOttU0Pttfniy3w9+twg7Z2XiTPwvPdPiLT9eTn9RIM9M9B9Nc1nn0EYjwpwW7KxuLayTeabKpNVMS+oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038323; c=relaxed/simple;
	bh=fM17ACxPi48RUkc6CTYUTCDM5lj10S/OBmpaFFNIkcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch1Uvgxcz4JW22CX6/4WgkxpOZ+kQl2lnpyyvva387oJFCXzWORSRYA6fIl6hWX/B6b/9+M0Umj6BvkGG7HKPIroTfZsUfFFcOlE7sqpRHiJLdOCYrFYGEWEpO6G2kgBt6CgxubOYqi5LE6i8s1ombORprfoA+WQmq/pxmdAEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsMHSpij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBD6C2BD10;
	Wed,  3 Jul 2024 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720038322;
	bh=fM17ACxPi48RUkc6CTYUTCDM5lj10S/OBmpaFFNIkcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsMHSpijNHgNraF3XmxVNow8XXBH8g/B5rA/mkxtYdBXza28HZvqneW87fCE9tetR
	 pLs/iFZ+oItTxRg+CYcNp6YFgG3O+4M+XGVjkrXiqooUxLfVnz7eYbqQbWJPztHC99
	 zY2KnY4a88ycjf04f0gzxOc0jU1hXTE8qT1LSdnZcOf6dNhc8bMOc0ZxXw/Y9bDWQ2
	 o5oFKlLoA3K1/yubdduHwDPWeKeJXIAmsqbEuYzgGguTgAU0fplVjEPg4zvJlfYbis
	 UIt6SIc+cJHXRhnR10KpEP6PynuDmIWKv4GakgPEsrohA2mypinD3lyvFurSWlYzTs
	 o6xQdJ/8XZLYg==
Date: Wed, 3 Jul 2024 21:25:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shenghao Ding <13916275206@139.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/4] ASoC: tas2781-i2c: Drop weird GPIO code
Message-ID: <c14e3b14-ea10-4a92-b758-557a87fc8047@sirena.org.uk>
References: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
 <20240701-asoc-tas-gpios-v1-2-d69ec5d79939@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lld/DtCFEGNZXhT7"
Content-Disposition: inline
In-Reply-To: <20240701-asoc-tas-gpios-v1-2-d69ec5d79939@linaro.org>
X-Cookie: There is a fly on your nose.


--Lld/DtCFEGNZXhT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2024 at 09:02:13AM +0200, Linus Walleij wrote:
> The tas2781-i2c driver gets an IRQ from either ACPI or device tree,
> then proceeds to check if the IRQ has a corresponding GPIO and in
> case it does enforce the GPIO as input and set a label on it.

This doesn't apply against current code, please check and resend.

--Lld/DtCFEGNZXhT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaFs6wACgkQJNaLcl1U
h9B5AQf+JweFR/QE46WZc782ZDWwAiD8hsguRmw353JdgBSB4wltFwz9wl2Rcg66
4fFZ9FGFQ6+GRqYrCWbmnpgevm6G9JORPHSAKs3GJhvn8QWXK9IbRROaAPBHcnIV
RxMMX/jjkPFsQOXWIDsV9VFi3XFNDD62AApXka9ctdWjxEb0XTgoF6SO6Qe9gn8k
8O+UXOwai17vWnU8MRIwMFtZGe+PM+jIDee+B2B+hYuivpJ/JhZ9EsqcyFzEjfZe
ovj4QXcHVVBZ3dAakTYoo17COckJu0bxH3IbuaacLtbVzcRA+P8VgCu4olUkjMgK
eNtwwwO+BCD9U7wxoCTg/Ep9gHdCoQ==
=KAlW
-----END PGP SIGNATURE-----

--Lld/DtCFEGNZXhT7--

