Return-Path: <linux-kernel+bounces-170073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B938BD185
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DB41F22265
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C73155357;
	Mon,  6 May 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEUf4YmI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527E13D895;
	Mon,  6 May 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009381; cv=none; b=W9pQkNTEyX03i7ZefXcM8lP9h0QDOTz6/LBqKfiO6icERl/XFl/qcwTlEOkh1L/I1XS5qeJsJJExn1tQiAzFI73n5tvOK4BgAP3M7UaUmdHHoIJGNPMEMimSD/nQH1bl0aNeeQgHVXUvfceEzFCnEnF5LHvfYlz+viKSQ7okYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009381; c=relaxed/simple;
	bh=BBOSqboN379XSm9Iz1r2ZHSSPtDfxe+m253sEHdnvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neIF33RCaXm5JeiVlzEGAv8ylUWxnkMcWTbzCMuIkzyFMk/9ndGOlEglOZ5EFYXdH2Ftm+vxX8EJVmvKCWbgJzbjBUsm6uMeF1y3r3Jf4FXzCKRVay2qq6fo5mcCQJjjIjQSEVAopU6mpW+8st3fj0UQVuYhG4lNJ97AUM/k7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEUf4YmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB08C116B1;
	Mon,  6 May 2024 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715009381;
	bh=BBOSqboN379XSm9Iz1r2ZHSSPtDfxe+m253sEHdnvQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEUf4YmIlRaTdvYL/3k1/jMolHMfWrCwLr32yeivE4YqckERa8DT8fPNoNiLTWjnd
	 p55ERagLDo9l4gArxRG2SvLgaPvZAltgIRlEMWXiQd8bzqOp7G7kpb3QhOV2GBAags
	 2KeD+TDbslfRCNizvXXzZSv35wp96kOEnNj+T2JdXHmTiYRaVbNey8aeUNA7g2Gbvg
	 K9a58Tnf6bIIAWO9qR68v8fE6HIoWE8OXySzIqhX24gEYyvqnaU+t7hoDPi726UEw6
	 hZfk7YnO0ce/GGLPFAjGfEipmN61+c5/Sij/2eU//Z+vMvm+wVKdh0dC+xFNai9BQg
	 1ZZc+53VS3oiA==
Date: Tue, 7 May 2024 00:29:34 +0900
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-ID: <Zjj3XugCngk6zD01@finisterre.sirena.org.uk>
References: <20240418000736.24338-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WGlIPKQL/xVlV+lm"
Content-Disposition: inline
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
X-Cookie: lisp, v.:


--WGlIPKQL/xVlV+lm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 01:07:31AM +0100, Andre Przywara wrote:
> This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
> original patches in an immutable branch already, so these here go on top.

Reviewed-by: Mark Brown <broonie@kernel.org>

--WGlIPKQL/xVlV+lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY4910ACgkQJNaLcl1U
h9D6QQf/RC+0eK+EQGY5NwAKne9HyCDUIB5h2QjhV0eiUxr15tCPcWKLKMAxXrwg
63hJ+clOLScdjb18mzjuCuzbQsoe0buF04rNArj5BLMz0aSh4NTnDzLHb0OQ0J6u
e6wjiAuFyIPJOMBq8vqYHtT1IxqylDnHIRgHiE04ZwClwCR2tIUffGYAB73W/vz8
e6La/oMzXal5iXqRiNGv4+DEXy6pHLsHZ1B8uzddwWds0SHoNyUI0Y73IVgu3U9C
eMz3EYenA+zOrVOPDJfdmb05bJtGZrH7NNxvPQGahYlg/qCmFI9YLkjia0udAJ4P
MYbyrJ9GIyzVEzmZrwdAfiXFNkUddA==
=oo++
-----END PGP SIGNATURE-----

--WGlIPKQL/xVlV+lm--

