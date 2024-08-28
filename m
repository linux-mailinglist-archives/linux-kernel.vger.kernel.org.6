Return-Path: <linux-kernel+bounces-305003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B04E9627F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E369C2867FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2917BEBD;
	Wed, 28 Aug 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psZDIVWU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31117BB13
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849866; cv=none; b=WRdSmMbDNhCunljjbPpRK22/eJ2E+E7p9uiWrQVNYM6EBY1hvxApxtMLXNWpk1Boz/uF5FBpibqO95XpUogpSEu0mjrwlaV9xKJs/s1H49VGt4viEGIr5WqGlWvE5kYxN3YiCMA4ckTPyBONZgd6ra4iwsmzic646o/0QzdQEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849866; c=relaxed/simple;
	bh=/0HnAn5TqEASLLSd0qy3OtH1wUH2rhGXgjlS/1FhzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inPudW8F2z2YNuiIJWxGVUF37lcvbMlJaYE7K4cbYmBii7whMC10howx10ZdOyNerYIAlmPFXQockp+Si+unBEF3zuKoFlRgBdyAijZJD8owbyfbSWwHihwTk71sI8+VmfZd586FcqmGRNMfVHn4ibbSbGz9AL6tUPqKFZ7vQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psZDIVWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D750C98ED2;
	Wed, 28 Aug 2024 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724849866;
	bh=/0HnAn5TqEASLLSd0qy3OtH1wUH2rhGXgjlS/1FhzOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psZDIVWUG59qivS+sIeGHgjCQiPZGNBgf/oTqePXIKq5MsMoYcRawIwxvOAJUKv+v
	 V6Lou55AfXcDRzy8jkSQ9gFXXOYkbBbWmgM0AM4yhbzGCrEd+SZZE+TEx7UhQec0dQ
	 bfhCfwqcR0kGyei0Pb0OdJLe9umq39lkdk9Tt3/tw4HETRe0W+dP5h4cIcVzrikB9q
	 GN3qfDkQlBQ98jlIc7sCoAcBBQkAgnV5FLR4+y8snlhLYB7OiIvaZpIACfaPvI8Hj3
	 XHGqUTps9vepOgci6Jokd3HO37pN1P7eFGkCUh3P7v/y5/XAqxvrz/VF+D5oDo4Qha
	 kEcvGX+YYJRSA==
Date: Wed, 28 Aug 2024 13:57:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	afd@ti.com, bb@ti.com, d-gole@ti.com,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to
 a single register
Message-ID: <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
References: <20240828121008.3066002-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iTRQaRjc86NpHeE5"
Content-Disposition: inline
In-Reply-To: <20240828121008.3066002-1-nm@ti.com>
X-Cookie: You are number 6!  Who is number one?


--iTRQaRjc86NpHeE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 07:10:08AM -0500, Nishanth Menon wrote:

> Commit 0ec74ad3c157 ("regmap: rework ->max_register handling")
> introduced explicit handling in regmap framework for register maps
> that is exactly 1 register wide. As a result, a syscon pointing
> to a single register would cause regmap checks to skip checks
> (or in the case of regmap_get_max_register, return -EINVAL) as
> max_register_is_set will not be true.

In what sense is the behaviour changed for a map that doesn't specify a
maximum register?

> Fixes: 0ec74ad3c157 ("regmap: rework ->max_register handling")

In what sense is this a fix?

> +	if (!syscon_config.max_register)
> +		syscon_config.max_register_is_0 = true;

This will cause any syscon which does not explicitly specify a maximum
register to be converted to having only one register at number 0.  That
really does not seem like a good idea - unless you've done an audit of
every single syscon to make sure they do explicitly specify a maximum
register, and confirmed that this can't be specified via DT, then it's
going to break things.

--iTRQaRjc86NpHeE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPHsQACgkQJNaLcl1U
h9BE6gf/RHhq79Tq0fiYtY3Cl/2E3MvVUh5pU3mY9FTezhPN+eiBwkVpSCQ2kbLJ
8WSEjxw2EgWB+yJvcbYt4R4ARyBQ6rsUZOrecg2pT+NDRtck9OYFnPEwziluX3Xr
/+oxxTfGifxZA+DjZa+Cb0Iwoicg6USgARRETmR0+DSqpQXx7i8b0TxaMQm+5Pqx
sZuO4PS/PoS0+fUb2AZVpu4/kGMrI0OtS2ksljb0JzaMfhLw/HzA7HIl0RPkNT7Y
bXjaR+qE3Rbl65YqbB0zB1FZgN9J/Av0ZUkZ2yFFqNT1mWEinGj4bS72K6F7x8x0
ua6zT6/4x7zVzpdqqyChY1Q7L3Jr2A==
=s01d
-----END PGP SIGNATURE-----

--iTRQaRjc86NpHeE5--

