Return-Path: <linux-kernel+bounces-516863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306EA37908
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BAA16BC84
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EAA1A83E2;
	Sun, 16 Feb 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVNbZTBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAB42070;
	Sun, 16 Feb 2025 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739750074; cv=none; b=KBrt+9JTsfR+Vl9tYryUJXfMSyr2j2WIV1laHP1I0l5huDtt3hQ3JDsyHh8K/NI2z1zmqL/HRl/hZoxr6ir1J5LBRjWbZyCW0nmisHIdm01WlFUX03Ch4iCEWn+aUT8/Jo0Gd7n9TcnA7txSikGbMC29pK3hges+is/aTJYOozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739750074; c=relaxed/simple;
	bh=dRbOoNPDAav7vOon2bl1IWC4PYB584wp3fauzmyTL10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icw9wZaGk9/MNyGQ50QIbynuCvNigv6srsjV0cZgN/pR7mSPdSA7yVvqPPQe0zXgh91J0In36ngPdRZNcZpAwtAy5OXXlPuQznCD1rA4+4EknRgFHQ2UyL8Hivmr91zcldUIckx0mTQRMhxK835viU2ekXbGKMdAvms2lOHLTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVNbZTBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD0C4CEDD;
	Sun, 16 Feb 2025 23:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739750073;
	bh=dRbOoNPDAav7vOon2bl1IWC4PYB584wp3fauzmyTL10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVNbZTBJYP00hVBmRgPdsaVj9nN1CQ5ZC7NBZp4+8tRK6NDu+dytcq3CTwLuuYk9x
	 439TR1HYSDyPB98VHZi9M7Wk3IgyX8J8yhXXKiNn2Gm399mA1z/QFUbbg5KSdCS8Y7
	 0h1VYTDnIgAXoDrQW/tuvRChTjJ4tMHL8XIv3wvm3pOHI9S+8rGj0pF/BQ1ahM1sZu
	 paVUhfdiIEMWxRdZ2l49e74Sk8zqQyERNIQ+d5ScZfIZYfzzgRE9Got8xGb4R0C5ze
	 4IzqGyqm+lRKx7SQjZ+WyI9G2winxVAw4PBWi5MD33qADqc+dT7hsK50ie355kYWGL
	 uEId50/Ul3djw==
Date: Sun, 16 Feb 2025 23:54:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: James Calligeros <jcalligeros99@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH 03/27] ASoC: tas2764: Extend driver to SN012776
Message-ID: <72674ddb-6b5f-40b1-bed8-edaf4547b27b@sirena.org.uk>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-3-723569b21b19@gmail.com>
 <Z7JtoIOECq-BjT9V@blossom>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6X4NoWFeMpCzPIN9"
Content-Disposition: inline
In-Reply-To: <Z7JtoIOECq-BjT9V@blossom>
X-Cookie: This is a good time to punt work.


--6X4NoWFeMpCzPIN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 16, 2025 at 05:58:40PM -0500, Alyssa Rosenzweig wrote:
> >  config SND_SOC_TAS2764
> >  	tristate "Texas Instruments TAS2764 Mono Audio amplifier"
> >  	depends on I2C
> > +	depends on OF

> Do we want to drop support for !OF configurations? The alternative would
> be extra #ifdef soup. I don't know if this is a useful build configuration but we should be deliberate about adding the depends.

If the Apple variants of these chips are making their way into laptops
I'd not be surprised if the other variants might appear in x86 laptops
too.  What's the specific reason for dropping the build coverage, is it
actually getting in the way at all?  We have lots of drivers which build
happily with !OF even if practically speaking they'll never appear on
such systems since it helps improve build coverage which makes life
easier for people doing general coverage.

--6X4NoWFeMpCzPIN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeyerEACgkQJNaLcl1U
h9CURAf+Ndu7lZbQOyYpeCgjFeV/eBVg/L33ogoUSCpxmlR7xM9XxYVkDr1XQ1JZ
HveuFs38BCFXqubRUN5fIZKZq9RWV6B30V4j1rDNEKFtZ8BwuerFVV6b+zD2Ncjo
tyKSvRq/EGGSh7yhVPwEgZkZbgwhe6lH05uG3/x8Q2eBKfF3qT0GITu0sxp+AIf7
VL7hJyHjYxmxUL/JkXWQMxw8XTx3W3RpKvdOG0aexeDe9CFYjlNukg/2RwGEwebU
dyCSkKX/iKi5weJ1k6952E0BZG6rr4sOQyNMX6gWSY/8joQcKY1YCgCzX3FcX3uI
AayVFhpaMGpqhi1RorPXCTQ7Hr4eEw==
=pNZo
-----END PGP SIGNATURE-----

--6X4NoWFeMpCzPIN9--

