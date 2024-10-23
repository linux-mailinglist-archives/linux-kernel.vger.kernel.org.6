Return-Path: <linux-kernel+bounces-378882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D809AD6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7FB285E00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6B1EC01E;
	Wed, 23 Oct 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQw4TDJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD51FAC51;
	Wed, 23 Oct 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718675; cv=none; b=JnHMkIJZgmHODKCfVHS5TyiMo/SM3mywBaUAujRP/3UR577K9NTmsg7O8Ti4dGkt2VwwUmefpzVJL5UKcuGxsf+h2Q6fj78L0+5r+82os94Wy4dvt8xyYoDY54jXoeeorxLdr/VqhddDNUtHc4rseebm+5mL6HtiiIUqIfzgBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718675; c=relaxed/simple;
	bh=Aqafuie2wrvB1s2PTxsikun42xUMGsN0qX0ch+2fzjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+6EpGVHvZy9wT0kbXgo+DquWTKtvnnaiPu+gb/UeYIlCtZ+QAKvAfMjmRvSSn0ZRGtNB6hnbiTY85Pb0uYZxLx4r37tjeBO5TRezJEj+YHad5IveMHw+yp5YBnPmKEejGjnudWuH7p6vCciS0fZzOHykyC/9NtFhMmqplDL2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQw4TDJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389CDC4CEC6;
	Wed, 23 Oct 2024 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729718673;
	bh=Aqafuie2wrvB1s2PTxsikun42xUMGsN0qX0ch+2fzjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQw4TDJvA99Cw7nLodbzIVrnkZ3dQSvB6AQ3wWDJwdYybCnotDf5bA1o7SHfH1U8f
	 4YRTbXPh3rWo47RBuDt1pJfdX5eC+Uf7V4mmM6lzPBdN7gWiSpqc+cl0mw7uM0K+OX
	 YrhGZ1HdHinJKHbEgn9rM+0fYS5zpO2CAtKZlQAO2NWJdAI3dHw3dDhOQTGvDN3yXT
	 j/quEQxcn5cuLPP37y1rpBnPctZQ7bCf5O1Jont8gb/OQgCWk1GP0WRpjR4TU/P8Qx
	 tYk3MAV7+WxuVAH5WuhZdyVw01ptRldvCqrgkpC5PQQa06CUS0w4j1dA5CxgjfPo7J
	 i7F7YTiduyYzQ==
Date: Wed, 23 Oct 2024 22:24:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulmck@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <bf42489f-4a86-4717-b367-d8be877b3036@sirena.org.uk>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org>
 <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ioEWPPSyV9nWR8oK"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
X-Cookie: A bachelor is an unaltared male.


--ioEWPPSyV9nWR8oK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2024 at 11:06:59AM -0700, Linus Torvalds wrote:

> And yes, I know some people do functional testing on linux-next
> already. The message at the maintainer summit was a bit mixed with
> some people saying linux-next tends to work even for that, others
> saying it's often too broken to be useful.

It very much depends on what you're trying to get out of the testing -
-next does work well most of the time, but it will absolutely just blow
up catastrophically on you from time time to time so you have to be
prepared to cope with loosing some or all of your coverage sometimes.
Usually anything major gets fixed fairly promptly, but sometimes you'll
be missing coverage for extended periods especially if it's something
like a more niche platform that's been broken or there's some problem
getting people to actually apply the fixes.  Submaintainer trees that
people don't want to add to -next can be an issue too.

You're also going to run into issues that are nothing to do with
whatever you're actually working on yourself and need to consider what
you're covering based on your tolerance for dealing with that.  The rate
of change can also be an issue if the tests you're intersted in are
expensive.  OTOH if you're doing things that are likely to be affected
by changes in a broad set of trees (eg, maintaining some embedded
platform where you care about all the various subsystems breaking
platform specific drivers) it can be a lot easier to cover -next rather
than all the individual subsystems.

--ioEWPPSyV9nWR8oK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcZaYwACgkQJNaLcl1U
h9CBFwf/baQc1d+DPbHZkU7xPtesjhxW7lpotKMwoWrIucWWP0Ta3C7sxX3Lexcf
iCJpJLtIMciJOh9eoA4kcuXi1PyvVvPewL38XFlrqstiIzUh2T+iWjLaUW5Kc+4l
VPJ1jrUiLL3ydkWJO8C7TgsKefJ5fN/dQinYUHSP7bGM9v8I56wC0JIeQt2BBqME
Q2sZiV3uopQt+xfrP4QZkbAhlHlM0JJANXwhnf9fO8vRkDHA0RGjLzhVB+oGmfEW
Q2ldd5tzg7LEkBR+vl8AqI5vtdAlfbtf06SNxTg+pMWXw7Z1UaEWqWYOM19abvgV
ga9eDAgQ2Qfhog1GSgpfHtHOkwj1Wg==
=9nRl
-----END PGP SIGNATURE-----

--ioEWPPSyV9nWR8oK--

