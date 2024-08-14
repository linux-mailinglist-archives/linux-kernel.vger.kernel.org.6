Return-Path: <linux-kernel+bounces-287075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4F95229D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EEA1C21AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668B31BE862;
	Wed, 14 Aug 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPT86keb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60831B1505
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663511; cv=none; b=ivQKL9+wKrQlCCNKgBxV0Nl/Fy5LYweWOHUjDxJfCc1JsHLOEsUgoMuLoUP4ZQo2bS6a8EYRqDfOGirtQgtp5HQtSux02Lyn1mv662UsKyKM8MSrv+og/+S+Oge1thlvT4dLyve6tdfoBuPDutpXz7J3hLlpqh8F1k/79sGMa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663511; c=relaxed/simple;
	bh=dfJ1fBH05zx/2OShlNq0Iby0NYbj5piGEzz4tv4Qh6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jez/rMHlQp8oGc/018JrCSywzo4b0yjwQl8CxE6vUbQkAWKa3OHLlUXz5EThd+7tFdY6xlWCCvqqszB3JQGf6fyaa3CdQKD1epOAgPctmszvOTWx7LuJo7YVF3iowBHoHNdR9VX8XksME/rOZK1ZCswCRwtpvt1JPWiw2M5/GLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPT86keb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8908EC116B1;
	Wed, 14 Aug 2024 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723663511;
	bh=dfJ1fBH05zx/2OShlNq0Iby0NYbj5piGEzz4tv4Qh6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPT86kebiOzXPqcQLfKGeLhlp7SZhZIfv881BlIxgYEl7xqS14k7oNUcyzI3Znow+
	 PWGpq6j04zvVTQhk9IlZdg1iMktHrrCJGORX74FCSufXe6DmTIhYj+Zq6uw7nGFnJb
	 kBAFrnkAZZRoXW7bjuuiWdhg4ni5I5yW1b6ZQr0O758UL4tmbakFTLilaGi+4aHo3M
	 mpgeEzOKfq6M+NPPtexN0Qoa4032xjVl7nmF83zat7nNcukGmdJ0fCuLI/Roy0gcLq
	 56fh0DbLe3WzWTjNoXjyNleRtNS7hRZIi1L8vRW1faUHjTY7sWC9Ff8HbrLo4dZ7Pl
	 lkbTiX7Yf2JTA==
Date: Wed, 14 Aug 2024 20:25:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFC] regmap: maple: Switch to use irq-safe locking
Message-ID: <408477bf-2f00-46cd-b962-cb2d17bde8ae@sirena.org.uk>
References: <20240814-regcache-maple-irq-safe-v1-1-1b454c5767de@collabora.com>
 <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OMyhguhabT8MHZgD"
Content-Disposition: inline
In-Reply-To: <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
X-Cookie: The second best policy is dishonesty.


--OMyhguhabT8MHZgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 08:04:07PM +0100, Mark Brown wrote:

> My first thought here is that if we've got a regmap using spinlocks for
> the regmap lock and a maple tree cache we should arrange things so that
> the maple tree lock is used for the regmap's lock.  That would however
> involve some unpleasant abstraction violation, and possibly some macro
> fun since we'd need to elide the locking from the cache itself when
> using the same lock at the regmap level.  I think that's going to be a
> case of choosing the least unpleasant option.

Actually I think that modulo issues with devices that disable regmap
level locking entirely or use hwspinlocks we can persuade the cache to
always use the regmap level lock, even for mutexes, which might clean up
the code a bit and would avoid the double locking for the common case.

--OMyhguhabT8MHZgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma9BJEACgkQJNaLcl1U
h9BU5Af/eE0XqC6itGw/R4iiMHSEuo/xP3knXl3KQwYKBBCNiCimZVVvNEPt5nnm
S6CHcBolLl3+YcSFhrEyUnUTxyEZ0Njbt0TA9sgNGQVYEWimrDz1t74Sl2H7337r
Wtyc0BAG/PBP8kN4BE1x8Xv1w/Y28cl02K7UnvdXhsHSpgBvL9RG+TDxzc38Ntyo
17Zg5OKO5baolxvsFiuvQALbnYXXDMhjFpbQJEFwD52IEodjiyEobRUjjDwvfCmh
N/KJXDQTs6kjcvtu6da3FAJcnOCO7x/PgSnMXzoQpJ8z/fOE7t5E3dKvbkmzh97C
9K70v242RurHrI0yDb2zHxJv7b/KqQ==
=b5eI
-----END PGP SIGNATURE-----

--OMyhguhabT8MHZgD--

