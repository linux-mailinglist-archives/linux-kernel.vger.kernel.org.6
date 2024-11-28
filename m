Return-Path: <linux-kernel+bounces-424891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D79DBAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506D5B2278F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD331AA1D5;
	Thu, 28 Nov 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXfAU+EF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42F17C219;
	Thu, 28 Nov 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809184; cv=none; b=fjhA4/3CGWnO9Z133JsXwavf03h79DvWytVal+SNSH9bA1aUVtnW2JBJiSApvJJmM50QQy3Qh+kzPXQOhBnw6lAr4DRJF/blne0p4bLnXZbnOx/xq1uKjhQIf+lwNIRcCjwuFwgZPV/nQwJ0SM8BYADoTSCsg2JicNi4ANapEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809184; c=relaxed/simple;
	bh=DYMoUVWceQPmAtjDphSIYmwZJAv7qhg+wtzpXScpSfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltVAWUArcHduR3g3F4satIyE5GuAiseRl6177U90pz7Cqf2CPYN/RmAsxOU7eUprsUOxCEYFtm+ZDnq2DqyZ76bf2Mm6ANGtsgOn9lP+dITIFQ+Q/5NcRqls4vBYvwE4x5aqbC/xMvoi66/TFZx+4H9w1PAINjonQzTSHZK0mKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXfAU+EF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D532AC4CECE;
	Thu, 28 Nov 2024 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732809184;
	bh=DYMoUVWceQPmAtjDphSIYmwZJAv7qhg+wtzpXScpSfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXfAU+EFfvj399EZCxpifxsss0HLLTkhbcOf5Bh1AWukLN7SYstYrwOX72JNOFUe2
	 bbdsmWbnbmPnldlxsBfl0jq3sKXinHWk9439JdFmq/z9Gs/umuoc2RPpjPaKjYTV//
	 xUWJ91VPjv/1XZCKNwsmHErl01rUWTSTVJY0aASnd2mR7/lNKGL1sqzMcTONlS7NvE
	 rX4XFTZ+mJgdv13d/xK197md9zf5mVD2JXO00VJiP9ln9TUio2s1VucM/RANZ797Ic
	 SRl39jpEBIWj+8bDs1Et0Y4D8mmx+qhlYc0RtvfVLCM3xd+Vyzt1lM5SBAyuKw9cbk
	 3KMAkfbIsUQQA==
Date: Thu, 28 Nov 2024 15:52:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Message-ID: <30cd9a80-e9d8-4387-ad28-451f7f95637d@sirena.org.uk>
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
 <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
 <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
 <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
 <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
 <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
 <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
 <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
 <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
 <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VgxPLBsQjrLMBW0m"
Content-Disposition: inline
In-Reply-To: <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
X-Cookie: Close cover before striking.


--VgxPLBsQjrLMBW0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2024 at 04:34:46PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:

> > My initial rework had the creation in clock (note: that is why I
> > initially used 'imply', and forgot to update when the creation moved to
> > reset).
> >
> > I was asked to move the creation in reset:
> > https://lore.kernel.org/r/217a785212d7c1a5b504c6040b3636e6.sboyd@kernel.org
> >
> > We are deviating a bit from the initial regression reported by Mark.
> > Is Ok with you to proceed with that fix and then continue this discussion
> > ?

> I really don't want to see those stray 'select' statements
> in there, as that leave very little incentive for anyone to
> fix it properly.

One option would be to get a change in defconfig for -rc1 and then deal
with moving things about later.  I would very much like to have these
systems working in my CI if possible.

--VgxPLBsQjrLMBW0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdIkdoACgkQJNaLcl1U
h9CHrgf8CqA9sf4sAjvbEdL2zX3cOMrPt5ihQvdVHNhH60Y4Jw7vPM5JiNGf8f3u
xx0LSyViOjOrH0EBeEaWsKp3zN1Dn68NPJhi55EaNCKCIh8zX5EHuDxEEImgnpSS
C21JUbEYQ5Xd6EgtFgDUAQzQ8DDZLWqQzdUQQu+LJ9otUTLleiNht3oqk1SMz+Xy
mkK+koXFqdBkPDxWC4jKHPItUAm1oASEDU+R2bS0oAOVqkWz2DmSrkM5WNdM0EGJ
IoNvABSoO4xRy+ku+LfQ5ECtz1R10x3d1jDKU4edmqVeIgObD0ovojsv9scArjqN
qc2W4uEswYAnJdl0+BdjgzxF8ZMBoA==
=kZIi
-----END PGP SIGNATURE-----

--VgxPLBsQjrLMBW0m--

