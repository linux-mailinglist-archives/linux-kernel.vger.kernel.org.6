Return-Path: <linux-kernel+bounces-414466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F209D286D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9EC28385D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FB1CEAC0;
	Tue, 19 Nov 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGky+BBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6C1CBE9C;
	Tue, 19 Nov 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027413; cv=none; b=ioNJVKpDqV8nkRLftfwtWyN338Rzv75wwHeNDzxNRbRljYrerEJFPZF2xjHq4Sc2nU3fON0ZHVx/x15x6MG5Hk3WvBTG0oIV3C9JIcQC8wu/GQCl3uRy4pmkN1dM3mt+CHgkMr2qV3PmUFMQhd6/6t8RKWADdi7eIMmbgHTb0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027413; c=relaxed/simple;
	bh=ZxvLKM0bNhMgDY9bHlRSPhBjrdjq5IG2dfXvn+jrPY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0tELwMyVyDp0uGHRYwIepTclcjM65QDAuqLCnr4/cnXnrN+U8HHi0pIwdkliUPhk1oso7CHQwOmMQF9db/N1j88oqbQwXERF8LDfOCxdptY+3WvFQi6eWTthQI7GW6VziB2f8xJz4hRRsTc3ook0x7cllRXiMvIcxpRp2IZ+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGky+BBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C26DC4CECF;
	Tue, 19 Nov 2024 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027412;
	bh=ZxvLKM0bNhMgDY9bHlRSPhBjrdjq5IG2dfXvn+jrPY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGky+BBRYQduW1jWNZzx5eiIKtSEdCIWdXGSH/PbDT90uDhpfoiqtxOUgbcUT5jgX
	 4dvnen2vCoNHtBKgnLqw3dqdFSLF35E0skC+FmiqHhzTuGY4EU8kd7SSros5NuXaLV
	 8ThyTDf7PdNG6jejM8QFVfo4JcDkwvOkCS6vIcQ4FTfW1PYlUkzrsUOpPqV7C8ALzV
	 6sUWqYD3HFRERD3L6Dn5uPO2baIMU9uOZmiwtiyKaP5hgx2Zhr+hH9+/0jjaEfTExi
	 ZY8HFIrn6GT2shUdWd5cujrUi8GiVb7wVWXWLh7Fy4AmiZQ9mI3yJvmntxhLXZm4aK
	 IQrfAugTXs0fA==
Date: Tue, 19 Nov 2024 15:43:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <20241119-prudent-jasmine-lizard-195cef@houat>
References: <20241119140805.3345412-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bbh5op4rp7zacygy"
Content-Disposition: inline
In-Reply-To: <20241119140805.3345412-1-paulk@sys-base.io>


--bbh5op4rp7zacygy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
MIME-Version: 1.0

On Tue, Nov 19, 2024 at 03:08:05PM +0100, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
>=20
> The sunxi external interrupts (available from GPIO pins) come with a
> built-in debouncing mechanism that cannot be disabled. It can be
> configured to use either the low-frequency oscillator (32 KHz) or the
> high-frequency oscillator (24 MHz), with a pre-scaler.
>=20
> The pinctrl code supports an input-debounce device-tree property to set
> a specific debouncing period and choose which clock source is most
> relevant. However the property is specified in microseconds, which is
> longer than the minimal period achievable from the high-frequency
> oscillator without a pre-scaler.

That can be fixed by introducing a new property with a ns resolution.

> When the property is missing, the reset configuration is kept, which
> selects the low-frequency oscillator without pre-scaling. This severely
> limits the possible interrupt periods that can be detected.
>=20
> Instead of keeping this default, use the minimal debouncing period from
> the high-frequency oscillator without a pre-scaler to allow the largest
> possible range of interrupt periods.
>=20
> This issue was encountered with a peripheral that generates active-low
> interrupts for 1 us. No interrupt was detected with the default setup,
> while it is now correctly detected with this change.

I don't think it's wise. If the debouncing is kept as is, the worst case
scenario is the one you had: a device doesn't work, you change it,
everything works.

If we set it up as fast as it can however, then our risk becomes
thousands of spurious interrupts, which is much more detrimental to the
system.

And that's without accounting the fact that devices might have relied on
that default for years

Maxime

--bbh5op4rp7zacygy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZzykEQAKCRAnX84Zoj2+
diw8AXwPEvKvZSexckPVmceqVmzVwPo9YwJrS+DitvJ95ldcD40YdZHdCu5AjBao
e+XhY+ABgOgEGGr/j6zPLo8Y5ot34kniaBX5Xx/Ej3W3uHV0gQDVY5V/mn8BbSIb
t4BJ6wtFAg==
=iQOi
-----END PGP SIGNATURE-----

--bbh5op4rp7zacygy--

