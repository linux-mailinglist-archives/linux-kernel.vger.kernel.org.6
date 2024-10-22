Return-Path: <linux-kernel+bounces-376464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A029AB1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933E31F24F68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E011A42A5;
	Tue, 22 Oct 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI+6RS5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9251A3BAD;
	Tue, 22 Oct 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610739; cv=none; b=ivSXrIiRQuuiP8uZm76EZE1oAI0uzwxqaIVhyXwW1+tPy24Othe2AH66hzP3fjXjQ+tmDyQY5MC/e3bK+vFbzVOfY2G2hO0walVZdO6L5dNlQf80Ud+51Rk7kSjQVylp+DkZop3vmtbQMyIABfdAbWLBMLUPdWr1iYo4GCyCDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610739; c=relaxed/simple;
	bh=h34Axa/KZlQzWP+2wyFKUah+okUK83vDiQMrMkwq6CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVT5YYJ/vr21gbFJB9A0Xzvr2OnvpQkZ99hqRzJabVJRP2XPxdP8rv/AyCmDMdLXGLdGe6EkUghmK+5Fi5dbcYQiyNY/YNd+LkP91VmhLhPc0phmUvvlq9XfKVk7GWWc4Ot1DgsS9+fJ2WZm0Z+hyKWyE8SVAmGiCLxapy7sMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI+6RS5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F07BC4CEC3;
	Tue, 22 Oct 2024 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729610739;
	bh=h34Axa/KZlQzWP+2wyFKUah+okUK83vDiQMrMkwq6CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XI+6RS5YZRP3xAkJXqLyvdp1C83tAxIBS/gZhQc0lx6egdQndN9PJhxjK0ZhGrAPX
	 el0AQsXCHahZJwm5pfk+kGwjEVtLRSqoOnYlq6/osH8ccofn7e2wHfsInd+az4Rlmh
	 edkq7sJAfddtFbuD9pTglCDzfoDgFeTs50WJ7b3zYqa1AvI04RKkEkI+aUthRsrLiH
	 FsSJgAp1SozSMgZ2ybeYFi6J5CGq1v36UvQWvnY8ZcQwLpvfN3JmYDG+pvEV5oqfLo
	 Fao6x4xp9D2gTTr2EYrRpXUC8p3H/EFNsBxGBbFLq2xrw5WuXqMf5q8W5Ao7M8dm/a
	 cpcyRtcOKMrhA==
Date: Tue, 22 Oct 2024 16:25:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <1f167f58-ad71-492c-a5b1-23800e915b76@sirena.org.uk>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxeEA6i_xfBMxJm4@sashalap>
 <1e89542d-6f9e-4e85-8292-ebb49091433a@sirena.org.uk>
 <Zxe65Zu3GRdwzXjo@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B9DONd5FGMw6Tg6Y"
Content-Disposition: inline
In-Reply-To: <Zxe65Zu3GRdwzXjo@sashalap>
X-Cookie: Surprise due today.  Also the rent.


--B9DONd5FGMw6Tg6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2024 at 10:47:01AM -0400, Sasha Levin wrote:

> If folks are interested in collaborating around -next analysis and maybe
> adding a bot/dashboard/etc, I've pushed my scripts to
> https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/

Those look interesting, it'd be good to get some licensing on the repo.

--B9DONd5FGMw6Tg6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcXw+0ACgkQJNaLcl1U
h9AAkQf/RxmxZpiIVkHzFH2KEH+voigJm3CdzGygyR2ebCnMVzkmv6a7ms2/m5ub
QzzQWP56731BUHNnnaXpV1OwPc1eUflcyljwSKMOHi8hdpoN8QOOXWy8dB7hSYTa
bwt0kAKpzQg9Ml9hspiU3jinmwoeZckaVT6cWNsRUNFPQnCHjyQfNZFAD13jXGGY
ri5x8Xos3NR8jkhCdXC/3zWFoUNQnToqkutzj0oCzxfnQWkZDjZHTwW/sF9Z0qPX
fyjclRZS63I9duKBVWpmJrB3oaVd1amZCXU0ViqNtmuV+tp5sz65vHpALgfPRQBQ
dhRGx+zodiKCUyZuJIhvuqT/FLhehA==
=0xA+
-----END PGP SIGNATURE-----

--B9DONd5FGMw6Tg6Y--

