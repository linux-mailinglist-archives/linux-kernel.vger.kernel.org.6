Return-Path: <linux-kernel+bounces-409215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348E9C8904
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823491F252F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18D1F940A;
	Thu, 14 Nov 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAgTvXN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360B1F8F15;
	Thu, 14 Nov 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583998; cv=none; b=FbhpsOCRoEqoNKKZipeUOqY1le8Lk4kIzGAr8M1QCFOJ+igYTZ4se9fU3dr0aYZXOcTvj5m29lEvg1s7Ku8KgyA0ePRUWDR2OpCcYRui0L01BSkv7nJQvqrVgFRvQ4hbTjpexQ9WLufZEDcspxYg9l0EEFg1rd834uSmnkBSmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583998; c=relaxed/simple;
	bh=uBUzpUqhVVausszbfK5jeC9oMY4Oemoi5dUNSxYiau4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppIzDc/cLbT8gC65yD5vruQ5v2cUfAE6KZigKavP3deKAFbt+D59InxgyHLibWKsDAGuDcipxWj+8QqmqXDxncbacl0M1r+8swqx1AowmUNijZC4PZYRdc1u2Mo3gnuCdDV7t07TLczCujcYF9wPFJPKUfzAeoB803CijwlHgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAgTvXN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ED1C4CECD;
	Thu, 14 Nov 2024 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583997;
	bh=uBUzpUqhVVausszbfK5jeC9oMY4Oemoi5dUNSxYiau4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAgTvXN9JlwlxPUhUoJ+a9SbSutQYj9Z4UxFs7oyVe4vEnKsVqxB3iJZERjHEoi/J
	 Qg33AzV3KABWHu2sn8JodgbDogbRKHXgeDeWPVv8fTuEok0OhiTHMrflx6d+0WL5PM
	 n4TJgtjZpKob7jwL16ZmV8TGZyVK8SlrG9X8CMFV8+ar3w8PsHhhJz2alXOXzcCbJv
	 q9G0diYqr689bwFtbN3xRDNIPmbEglozewEhKEJj2sVgHLLDxxN9ynCMlT3DI7eW6C
	 pezaEvIUaCyHFR23vj05tCu9DzGWpV3MLzqkejo3Jf7583gFjxY/nelEEm/Xt+6lV4
	 cOyUQiluSxMag==
Date: Thu, 14 Nov 2024 11:33:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sma1307: fix uninitialized variable refence
Message-ID: <ZzXf-kdRnDk6-sGx@finisterre.sirena.org.uk>
References: <20241113115708.4772-1-arnd@kernel.org>
 <ZzSoeF7dnWDw6rqj@finisterre.sirena.org.uk>
 <253ed1d8-fdbe-40ac-9791-843f3e1ca226@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EXKFQsetu0vlZO4G"
Content-Disposition: inline
In-Reply-To: <253ed1d8-fdbe-40ac-9791-843f3e1ca226@app.fastmail.com>
X-Cookie: Editing is a rewording activity.


--EXKFQsetu0vlZO4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 11:43:12PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 13, 2024, at 14:24, Mark Brown wrote:

> > There is one path in the actual implementation that returns an error
> > code without setting fw, though most do.  Either this caller should be
> > updated to check the return code or if checking fw alone is valid (which
> > TBH does look like the intent) the stub should be updated to set it.

> From what I saw earlier, the fw pointer gets set exactly in the
> same cases that return success (through *firmware_p), checking one
> or the other is almost the same, but you are totally right checking
> the return code is the right thing to do here, plus it avoids
> the pointless release_firmware(NULL).

Yeah, the case I noticed that doesn't set firmware_p is the check for
firmware_p where it's kind of unavoidable.

--EXKFQsetu0vlZO4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc13/oACgkQJNaLcl1U
h9CVBgf/SbeQaijauH0lGQ5DSi/hEvs/kpEWNX9yNn/W4uPhrZ0ItoLgVlrctS9s
93sM/XyjJPnQw/aIxIcFNw9dzFBG6fN8bGpd77xfQNic00WvlvqEX7/WknprJ7zb
ffPGPdsOETBVcg7es9JoUYjLm4KJIQevXt3TJb42IFy95uzcMrznMJnxibpGKj5c
JcGO5WgzvOG6R/aqv9lI5pUIVmRrEp6IVKxGVjdz3h2JirsrTNWSNWemKZgX8gsL
zbU0jHlPetdIjAx868u+i1F7X1E+SGeujLus/jq7c6SMHCoNrwvmpc+s94UpURPG
oqUgO519T/CpU4l7vm1Ua6SNW9Nj6w==
=pgxD
-----END PGP SIGNATURE-----

--EXKFQsetu0vlZO4G--

