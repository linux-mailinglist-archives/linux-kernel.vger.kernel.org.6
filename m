Return-Path: <linux-kernel+bounces-170072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B728BD183
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DDE1F224D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D7155356;
	Mon,  6 May 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfIh/CkW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02513D895;
	Mon,  6 May 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009349; cv=none; b=Tedg4OQTvVQnKV4j5Kj8faOtK7lFSuyVD68sCGzYYMSevYdk5eytplMGjtyLjtQ7JzSKUWFWGuGVkxXEyl9+W/kKfcaDfp8reth+G+6T/ttvuJbGNOH5vC7Zv+nd9s6BYyUHnKDC1B7fISatIvbDj3Jof5Q9FkWR0zMVnk73yFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009349; c=relaxed/simple;
	bh=7mpLZ7DoaIdwoc0l1wvPItAXaCaxe1gZbugq2m1PBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soMccG8RuGW+/ojnLoH8CNtRO/thOVmqCdxWP0LE+w6C+TQO09DnBopDvUIpM8yV7Jn3sGW+hjEYI1an4iMcT6voRfSWuAHer7atN4f5k56YspA/O7mqKYwHY47P6l0N/cHT94hgTEsAc7MukRXukXVP4PuDFZDmKfO2Wp8ghDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfIh/CkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC330C116B1;
	Mon,  6 May 2024 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715009348;
	bh=7mpLZ7DoaIdwoc0l1wvPItAXaCaxe1gZbugq2m1PBnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfIh/CkWMiQWvgnUX1DhIQxvWqGWSQVV7J/xu33m8qS8LOm/09C5KFxEbs7YmT9eV
	 NETEMYBT4fnl/5oNYpOQGV4qYl4wH04ORGi2hxSvEB4Qk+ehIXm5H9R6/bTc4XluMd
	 ZURfjGTYiuRGMD0B5yyOID4r3UBGdBLg6cW/Iba1bVy33HsmLwlh4QBKQ2iVSknLdy
	 /keor2zEVOrVS4PUW5PAx3xwtGFacxpi36aUdEMCMmo1hccYbL4B2/xquKJWBSPNTA
	 +gNR5RCHBpdb2tnSN/VQqOQSzqxYrm1BO61C+Zp4SbKYYpFvqLZENS3DWjwGIqtYwm
	 +/aqHHHY0LUeg==
Date: Tue, 7 May 2024 00:29:05 +0900
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-ID: <Zjj3QbwdLjygcP1g@finisterre.sirena.org.uk>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <ZidE5UcQ6XSc0YBI@finisterre.sirena.org.uk>
 <20240502093836.GL5338@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mBiHePcirhd8HAPH"
Content-Disposition: inline
In-Reply-To: <20240502093836.GL5338@google.com>
X-Cookie: lisp, v.:


--mBiHePcirhd8HAPH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2024 at 10:38:36AM +0100, Lee Jones wrote:

> > Lee, this looks like more of a regulator series than a MFD one (it's got
> > a couple of small updates to the MFD but it's mainly focused on the
> > regualtor functionality) so it probably makes sense to merge via the
> > regulator tree?

> I'm fine with it.

> Please ensure a succinct immutable branch is available in case of future conflicts.

Actually now I look again it's fixes to stuff that's only in your tree
anyway so it probably makes more sense for it to go via MFD, sorry.

--mBiHePcirhd8HAPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY490EACgkQJNaLcl1U
h9DiKwf/XZJAh/5M/RaUixwiyjLa5in4Pfr0FR0kfjFmn+9xEum8MGPl8+0hyEct
Y4Q0QnyhhFos9UdsHhXD8tfA1D2GqbQlK8gEUpJMvvt6eXMg4CC3S3i/69A47S9h
TfsqBdH30O3bN7rqhFvqUxF3Oopvw9Gp7uZnbrQIRSnjLgrsi/rQrHM6+FqGG2qR
VptdxU3x48sforNN0daagqlym/SsUsiGXU0qPMh1NhwfAUyF1HmA++VuLfpwDhwI
hqH27Yao/99dAFHHLP1nDCErE5QXiI5rxMAosoajgC/JpOXOwK327OHv+XqzirQt
3fU39yz2Vm9OYE4byh3wfVjsWXqs6w==
=Z90i
-----END PGP SIGNATURE-----

--mBiHePcirhd8HAPH--

