Return-Path: <linux-kernel+bounces-415358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF29D34F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2FC1F218D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAB158DD1;
	Wed, 20 Nov 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUlDZMBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D015098B;
	Wed, 20 Nov 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089717; cv=none; b=oSCVeEcGNTCcRWhEvYGzPpSVfzMZNW/G6KljA/3eoYqN6hQ7xYrH8Mjhf4Qi2WRuPLLgAfGHL2nc+GTh5ntyUJWR8LRUfKrj0ZC3GvIbwqE/2Q3sdnYK5HiHcu2Y0XykMw/1SkoBJtxHZ3kzIL7iQMahAptSGKKd99Vmkm2EZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089717; c=relaxed/simple;
	bh=YcmvsqJy4lqAiAYIlhOSKHvpYFak6R4CiBmUT+zJfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr0b8Zwhy9zXV70fda5T5/YNkIQQtIs0Dux6wpn3zTCxFYor9BWoH9wQzgolSnj69tpsrRycC0oN/P2Q04wpvNRNPkkAiP2umPe3l0uDHhs1E7a5XwmPxgyKg/X1FesQO5J+4MWXcDTWZBeGUBc4bbTu4sbTcUmgyKyLBYapOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUlDZMBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABDCC4CECD;
	Wed, 20 Nov 2024 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732089716;
	bh=YcmvsqJy4lqAiAYIlhOSKHvpYFak6R4CiBmUT+zJfh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUlDZMBcMQ365PhtQG0i0AUFWBmkOsJIKw8Uqs0oK7PH3p0eBy/81StVUr5WJaDbs
	 Y7ur7u6VtUqnv9iUqObzZXoiW49lFKQodsWxdtiKF8UTe+szrxb1M88oh5kC41EIAn
	 UqmcbOOkug1xsSj7Cnw5njX7nHmMMHWxZTicgia6nVDbN0J7JDRNTmN9QPIR/G5p9C
	 BzZofxvUimfRxYxU1PFhvJ3WziavFwRlrNJNC+fjkGwo+FhPzNGP6LmZ+9nfyoXQOG
	 MPEPGjp4BvvvApFtQ7ZCiOzBEwG3XiHBqmyGL1znGFgh55+4V479S0OG7bbemTytRf
	 EcgJyiuJ6fH6A==
Date: Wed, 20 Nov 2024 09:01:53 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <20241120-wild-stimulating-prawn-ffefb7@houat>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
 <ZzzdT0wr0u1ApVgV@collins>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="khkrvqq44ignfwqp"
Content-Disposition: inline
In-Reply-To: <ZzzdT0wr0u1ApVgV@collins>


--khkrvqq44ignfwqp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
MIME-Version: 1.0

On Tue, Nov 19, 2024 at 07:47:43PM +0100, Paul Kocialkowski wrote:
> > > In any case I don't think it makes sense for the platform code to imp=
ose
> > > what a reasonable period for interrupts is (especially with such a la=
rge
> > > period as default).
> >=20
> > So you don't think it makes sense for the platform code to impose a
> > reasonable period, so you want to impose a (more, obviously) reasonable
> > period?
>=20
> Yes absolutely. Anything that brings us closer to "you get what is really
> happening with the hardware". The sunxi controller doesn't allow disabling
> debouncing entirely, so the next best thing is to have it with the smalle=
st
> period.

That's an opinion, not a fact.

> > If anything, the status quo doesn't impose anything, it just rolls with
> > the hardware default. Yours would impose one though.
>=20
> The result is that it puts a strong limitation and breaks many use cases =
by
> default. I don't think we have to accept whatever register default was ch=
osen
> by hardware engineers as the most sensible default choice and pretend tha=
t this
> is not a policy decision.

You're making it much worse than it is. It doesn't "break many use
cases" it broke one, by default, with a supported way to unbreak it, in
12 years.

Maxime

--khkrvqq44ignfwqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZz2XcAAKCRAnX84Zoj2+
dmOZAYCCwKdo2KomekdZdkk+Kd79+7gZmQ8SrPSQzSWbl2+IJ85851VQZ0/OISxV
k9BcONYBfif3yXkFohd7QveN2ljpb7hJ4Zqr7VjiC6i0H3Q4mGH+uU2q6nA0YHAg
QUpfeaJlSQ==
=G1Sx
-----END PGP SIGNATURE-----

--khkrvqq44ignfwqp--

