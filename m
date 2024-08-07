Return-Path: <linux-kernel+bounces-278122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164794ABD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F012856BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31D82C8E;
	Wed,  7 Aug 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7ztl3Re"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCC27448;
	Wed,  7 Aug 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043366; cv=none; b=i/AjG7cuOZbCpn6wOzXto0f3VgsRZ0xcXJ0e2eCyNJFPMxMDNacyOhsGJx5XCfzti0Ql0Y6rnKKu2RD8syw2UNwUYcpEB9skCdkcjLaR5voNg51wkmEOcxbk17ctPFaheuduk7X3w5CAR5DSNjopbBaXBFqLnd1ko45oX7mpFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043366; c=relaxed/simple;
	bh=1ZoMg3Nw5YU6eDtyDLGwfU4jQwDXQut9kygF6jGLe+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK/N/oPoxM9RqbNYzFKe0L87GtvmePNVWLrSQHqTyX1klyHW2zOdej7Nmm7/srQhO+K1gn9FrzuLdYmkanV43z8MJHTM8tWObtNKSlzB4QKlttFaVJGbl5plCH5sVVq3isqAEduXrg+m8G58ictSzAH/WhSCgKijxN+SXnSKbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7ztl3Re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C0BC4AF0B;
	Wed,  7 Aug 2024 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723043365;
	bh=1ZoMg3Nw5YU6eDtyDLGwfU4jQwDXQut9kygF6jGLe+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7ztl3ReQajwfAuSM08RqGPhoaDrtGXILt6ia24Pv/RKaH6ycPIb/FrpamotwpHfS
	 FpReu3q3+NH7FSy4RuXaV5i8PzVwrwZV7JwEME/C8zYl9Q0liLCKURJ5H+AMrIxcTc
	 W4NylVT0eDHOsMeTu4OgTvFBqXLoCE+fYGpBXbZE2lAajEk0u+LSS/eKB692qllskA
	 8tezOY9b8dyHxBob1aXbl4aX8G9jscAmJiecs7CEdY6kLhQXDbCfGdc1LbdBkFswxL
	 wYwojrVviJ9kbAxidB6Qgvn9dUmOc3DGCCJdxuB8BHZZ6XBnsS7mKcg7hYB7iJP6lI
	 eFdN3VntDCHWQ==
Date: Wed, 7 Aug 2024 16:09:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Brent Lu <brent.lu@intel.com>, sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] sound: sof: ioc4-topology: avoid extra dai_params copy
Message-ID: <731fa66a-bed7-45fb-9187-a9263612eac4@sirena.org.uk>
References: <20240807080302.2372297-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4XGELTP9/4XoJJVs"
Content-Disposition: inline
In-Reply-To: <20240807080302.2372297-1-arnd@kernel.org>
X-Cookie: Offer may end without notice.


--4XGELTP9/4XoJJVs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 10:02:27AM +0200, Arnd Bergmann wrote:

> From what I can tell, this was unintentional, as both
> sof_ipc4_prepare_dai_copier() and sof_ipc4_prepare_copier_module() make a
> copy for the same purpose, but copying it once has the exact same effect.

> Remove the extra copy and change the direct struct assignment to
> an explicit memcpy() call to make it clearer to the reader that this
> is what happens. Note that gcc treats struct assignment as a memcpy()
> that may be inlined anyway, so the resulting object code is the same.

The effect of the copy is to ensure that if the function fails the
argument is unmodified - did you do the analysis to check that it's OK
to modify on error?  Your commit log says "the same purpose" but never
specifies what that purpose is.

--4XGELTP9/4XoJJVs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmazjh0ACgkQJNaLcl1U
h9CH0Qf+PkIAJuaXgW2ZlB/lV0c9qstd5NqOjIDa9douc4XYdRJhkO+ttJPleTv7
TzTjE4b9DsnjLpaikE7U1csAfX6T4id03Cs7O8kShNdw8lX7pxyYoN5NXx7GNJFj
EFA11ugixS5CP1wWlAbizjKM7T9YPxO2cFoif2BjQFLwFrlXP+tkpBmIGB4Dyhse
Z+PQRQvxd92ljQWMvQMNzne6ypp8B9IqMOHPny9OC+MAacHc404S53Ad4lLaQXk+
ssA9WcpNW7tNorWlIN7Y4quQiJyBxYffnhO8kUYTN3kkmJ2a6f3uUdFdv+EpRnyz
g3YqQ/j57+3QIdnDb75kxo8pugNYYg==
=TXp9
-----END PGP SIGNATURE-----

--4XGELTP9/4XoJJVs--

