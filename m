Return-Path: <linux-kernel+bounces-414759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E69D2CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0284C282E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA21D1F44;
	Tue, 19 Nov 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJw3hpVY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BC1CF7B7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038421; cv=none; b=FRSoaSCF2M6Eh33T5debBVHUvYttboqkYLlJoPJsit1SsjGNF5xEtsm4/wLI4kvjlHlv3pLYShQWgPyAZNlV/NpscWaUlwegRKkzADt72MXMHIEIiqV3w5277NggrPTEJeMmQvNYBTSgrJkMZJ3flwsrG4TWMSMsr6Dd4esXMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038421; c=relaxed/simple;
	bh=mMVLpb5oOql/3FeLHET9XsnXdWYsUxvUYgL1hAGTBNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgjrgjTNUnkstScGwFXZOtfsHlKzY4Cqvq5FdZoScZWEyyHNO6y9twvSSlB3rNil/VtENeqkadgFsJK17adJqGPDE6AE6QfCHfzManUo3MsIX3JgRhwx85zBlMq9zqtM9kezkH2gTOUBWPMrBH+3hpim/4jIQWUjfnh3U2iHOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJw3hpVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9473CC4CECF;
	Tue, 19 Nov 2024 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038420;
	bh=mMVLpb5oOql/3FeLHET9XsnXdWYsUxvUYgL1hAGTBNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJw3hpVYHqMtoCRCcnE579jtajQCxg5yeExftVEY2Xs1/qzgoGOdTN3RWgi/FjIiX
	 YKQ54AzKBn2LFCy448zEYXvrf0qwBw2P690DeHZwckTHSmkc9pvII4bKCxXc+3kJbG
	 XfE50OWQVIBvBIMeMm2uQUObTVevEuysVair0HJJjaawj7iEIH3QKCSXujoRoy4VBs
	 OQGdoKaAL8KxNNgHOft9OrWPoVyVkdPoICDssrnYUveo16lKbUCfhrF8HEKNznFNO4
	 CCmJuAJHshgnpd3DdlF9hv9lMRd4I/drYBd56N3LEFMXDVL8bCvzMMUsBdYyFNvJMV
	 OarIdct8ntITw==
Date: Tue, 19 Nov 2024 17:46:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <49526254-546e-41e8-afb1-14aadeaa391b@sirena.org.uk>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
 <f904ed54-da90-4746-8230-0ae5dd0ca276@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPI2CxsDA6TDFk3o"
Content-Disposition: inline
In-Reply-To: <f904ed54-da90-4746-8230-0ae5dd0ca276@roeck-us.net>
X-Cookie: I have many CHARTS and DIAGRAMS..


--DPI2CxsDA6TDFk3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2024 at 08:35:04PM -0800, Guenter Roeck wrote:
> On 11/14/24 09:26, Mark Brown wrote:

> > Right, so the fact that I3C depends on I2C deals with a lot of the
> > problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
> > should be OK and there's not much doing for I2C/SPI.

> It looks like we can use

>        if (IS_ENABLED(CONFIG_REGMAP_I3C)) {
>                regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
>                if (IS_ERR(regmap))
>                        return dev_err_probe(dev, PTR_ERR(regmap),
>                                             "Failed to register i3c regmap\n");
> 		...
> 	}

> even if a stub function is not available as long as there is an external
> declaration.

> I don't really like it, but it turns out that this kind of code is already used
> elsewhere in the kernel. It looks like dead code elimination can now assumed
> to be available when building kernel code. We live and learn.

Ah, that solves that problem then I guess?

--DPI2CxsDA6TDFk3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc8zw8ACgkQJNaLcl1U
h9CVtgf+JrjHeuYv2BoLp+aaeXZmaJPBIxvuf20MChkqMpR8cjJnnYF+uryE3aSJ
mD31SeFZmpe6U0CeQV7aIFguHI5Ltp1577dU9Kx5MBwdX/U6NDyGj97KxImjWKBX
hXDSltlFpq6bAhaeeyZ/hA18O6WaQG14dgHMA4uOu1onTTKapt1RY+IFVSaH+7wr
7DIGFB0+YmIti0d9PCQr3nJHEIirl3CcVjZGTGYL9joaByghdGqRT/0rb3stU6nM
LiYsqOU02BlIVU+sCSoKrFtx33lPfdASYLa7G/r7+UHuL5gpRr+hgHtHm/A4DbfO
7bBYM0BejrKoxJa1zVTrqOwd5TMtEw==
=0a/0
-----END PGP SIGNATURE-----

--DPI2CxsDA6TDFk3o--

