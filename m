Return-Path: <linux-kernel+bounces-215290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AB9090B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D14F1C22EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED919AA41;
	Fri, 14 Jun 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL+l8FUI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFF181B84;
	Fri, 14 Jun 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383428; cv=none; b=lnle25+6WBkzXMvSaaUI4YHoxDbR92pu4S4edtsYjowIVZAnB/ZRVdV02wUPVIVYt9T24p9j1p33PYFeU46o7oxLQf8agRO9ouYA8ZHODVVmornZx4U5/8uWos5RAPFPIvQbfrl2U0i9htR7T8H8ITdVBeg3RhQ6X5AcQze+5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383428; c=relaxed/simple;
	bh=OGecIESkxQlGPPHFvJKS/1V4WaNGOExMXfaeDU81YVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUNFMuY0ucyF+v5e/HwLAjU4//fa00A1ilvYHqCLRr2/PzatMPI+XQVrYSYM2W5f2XWcJ2WtWOEzYCserclRPZYv8V2wen9IY2DoDd5sy2NDiPNMdBG6CH/WV9BMUOk3oN8mSv70LzoMuynSP0cwzhQzAFGJx+opzS3QhcM4Jk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL+l8FUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56300C2BD10;
	Fri, 14 Jun 2024 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718383428;
	bh=OGecIESkxQlGPPHFvJKS/1V4WaNGOExMXfaeDU81YVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hL+l8FUIXR9ASHQf9xeEPHt7CfdJYNX0X2a16Kb6dXovnPp+k2I7dQZVJz+bHAS+w
	 /Akw4bgdYCbPoCYPoxyXVhpR07QLakzGw+lOuLOCEcwc4m6XbzkVwX996ca3rr7kcm
	 ZekEHG9V5TCkNvXESp+C05L37+ynL56sBerph8iI/t5rhWxp+D44Fo5+P42u35Gl0K
	 7dhB+rmHkWPUfnZ28d9jgrO3szh5oJ5ZQY2ImBXkHINHxIt+m8b3G8wRkGcMlTbQL6
	 yUuCucQDUEkjvZjxu10iU71nkcLMlqu5oTEbzmsM1vD1k2Y6LXTCZz2aWqsZ/1SvcG
	 l+KTBfQzjR8yQ==
Date: Fri, 14 Jun 2024 17:43:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/4] Add audio support for LPC32XX CPUs
Message-ID: <ZmxzQLbzuEupDkiJ@finisterre.sirena.org.uk>
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4uEH+YoQX+igcbHZ"
Content-Disposition: inline
In-Reply-To: <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
X-Cookie: Your love life will be... interesting.


--4uEH+YoQX+igcbHZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2024 at 06:34:48PM +0200, Piotr Wojtaszczyk wrote:
> This pach set is to bring back audio to machines with a LPC32XX CPU.
> The legacy LPC32XX SoC used to have audio spport in linux 2.6.27.
> The support was dropped due to lack of interest from mainaeners.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--4uEH+YoQX+igcbHZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZscz8ACgkQJNaLcl1U
h9BWvgf/f+S9NLVWH8/lPOJWNtq9tQndYQy8OK5iMAQJm7mKL0A4ttTTMYMYnh9h
tL3EW+ywS15IBWgG89JDmI9AuB9nWQKgmQIqjVuGW+54g1EYmViI28IteOGUZnv4
xSF8N2Ak+ag00veuwAnYp3oMDUbtZ/VpEcoBj6Na+QDI5ok19cDT4Vqo0lWSMTn8
9liaCr84fAjnbULZLuudLqd4wrhxbBtaYwCQ+iH2tW/N4j04iuTdop7ogfilTi/0
ZsZOYX4xC1lJ1EbS7qpQSTsA5aDQQ7BwwzOE43HOhzTLoOcVVEl2a5dmZkSHNNDc
2R617vs7FjbtGTrFUOVMTAzD01F8lQ==
=TUpG
-----END PGP SIGNATURE-----

--4uEH+YoQX+igcbHZ--

