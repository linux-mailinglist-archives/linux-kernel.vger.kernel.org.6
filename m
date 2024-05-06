Return-Path: <linux-kernel+bounces-170070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD568BD180
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725EC1F2213B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5A155336;
	Mon,  6 May 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFi1Grmf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74F13D895;
	Mon,  6 May 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009187; cv=none; b=XB90EZP+PZIAV45jbxMoPFS2faG4C89SYODQIJQ7fcH5chfjtVQ/SX/fCBnoXJC8txXqouhZd2/BQwg94DEfIr5c7oEX/ra+pwTYOSGID6EcQohILL0aEVw3SRmXqpiEAUmMydBV+FjtRoTik2vdc6p81UaBk7yLWMomwvTiMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009187; c=relaxed/simple;
	bh=5VS/vf0A/N10rF9eCtOmTnYAP2GPfH1vtX8J3tb+Xsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etSUBQN6YZCIvb811FzuBZc+OC2BU7z6sBxsD/NohzYDhlr/4kC14X2XlhyftpSSSA3uCmaRNWJP2UfEcST5o5eDOrOSKOr99ArEBv8NQoNhnusjuWEpy/mt+Zk1oGq96g9Uz88mPuQfsnE35tPszPqbPYGbAt/DD2Xdt+nHnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFi1Grmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49601C4AF65;
	Mon,  6 May 2024 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715009187;
	bh=5VS/vf0A/N10rF9eCtOmTnYAP2GPfH1vtX8J3tb+Xsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFi1Grmf2uB45I7MM5mZ1V6xoeHDtc4+Z1w5JZivqY6jFGFFXAeuIrU0G/zKRdlr/
	 1btkQtKwgJS/qjQc+uuDKeCUAjwNmcfh2ZbyrnVWCqekRMDslGhMibEy62KBEPVwvg
	 vbd7bFOoD8ZwVLs2CgtYBu9NbF/pmxIZu6GllRIc3Hygyzx6TOs5vNebuivz8y6SIQ
	 7ypBDokpvXpF90iqIPMHgezlbQoqwJe43zoDqxjQJTU84UPkFOHoZTgvidN276spJd
	 sUvJX2VibF/XkAxH+8o+195hodpju12n7Pg1B6sqjm5AEZ8Atpunawgm+r4NzEuSaR
	 MYyYbVt5ejzjA==
Date: Tue, 7 May 2024 00:26:23 +0900
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
Message-ID: <Zjj2n6t1nj0cd0pB@finisterre.sirena.org.uk>
References: <20240418000736.24338-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+LJHUmfzVTIjCody"
Content-Disposition: inline
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
X-Cookie: lisp, v.:


--+LJHUmfzVTIjCody
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 01:07:31AM +0100, Andre Przywara wrote:

> Based on mfd/ib-mfd-regulator-6.10, as detailed below.

Please provide references like this in a form that's directly usable,
ideally the git URL plus tag format used for git pull requests.  The
only references lore has to an 'ib-mfd-regulator-6.10' are to this
thread...

> prerequisite-patch-id: 2b5fb10f68e0994071fc4c7dce73db7047c23220
> prerequisite-patch-id: 5d0735de888d155b2c1cdb814e852a5852a17ec7
> prerequisite-patch-id: 29c30894b4bf0b9e1e71de065cabbd842505e248
> prerequisite-patch-id: 0ab87cbf7362b6dc2d577d2264eb9574be47b5f6

Patch IDs aren't terribly useful for reverse engineering what you're
talking about here...

--+LJHUmfzVTIjCody
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY49p8ACgkQJNaLcl1U
h9APywf/YmAkHZOy1LIJQaRkJxvNpt/P8t2G3O9NLT5ct3dXnd4sLu2LbHIaiph1
TTy+IcH2Ntkgx/IpHLib/PmLc0IiKzxWAaU9UkYkNl5lwhGOBlqyb1rDHKIIosA3
IY9V0fZ8ziQrERil9kFSwAX7vFgNALA8VuQ7SZkRL34T3gRjENsaAOCOa1UEnWm7
mIZmBpPiEiaKsNVttowvS5M9CcRSk/VCBIR+3xe2l84pDV/+TbNx1GXQPdhmXFI2
WqYD4GQE1A0iTl1gTebBu3ldz3fzkZjY9fSEoAeAq+PKW1mQz1P2T/ZrRjca/I/F
qrgtyqUcaqrU/yjain5EfoLk8zSDvQ==
=yXQ/
-----END PGP SIGNATURE-----

--+LJHUmfzVTIjCody--

