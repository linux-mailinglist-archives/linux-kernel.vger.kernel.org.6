Return-Path: <linux-kernel+bounces-281633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1394D918
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B2B1C217D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138216D336;
	Fri,  9 Aug 2024 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOXt9KEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83D26AE4;
	Fri,  9 Aug 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245982; cv=none; b=F1+xFo7eedF3L+M+agP0C8E898pjtyMe6GKg9sB9fjxxkGFg6ji00dwsqNwEaS5+E6LGrbqUIV7GXWUR4MGmxaJNkRkIUbPYmnjzEXIdjW1Oqe179BTIfAIOd1+kvst21o0B/cg6CILvZskYKXRc28vd+Pmd7+hyzyyF8Otw0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245982; c=relaxed/simple;
	bh=lN/OqN7miAwFNcF8H3xwMIZzDoeycCOqpmGCgUI+PSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB8l60kzRgPl/gd4ZqDOyr8sNFcWEi/oUq7j4eR3mnYNKPGoH6ezhC3HaYqmffcSeSbVaMxqJkkLaZ6Nm3xBzJQKssp209nN/HYL9MPItbsM5illS490EOmacSAgjnCfWoGGE10ou0kS7vgwTCGhpi14XYqh0i4yLQ/QX/p++48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOXt9KEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3133CC32782;
	Fri,  9 Aug 2024 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723245982;
	bh=lN/OqN7miAwFNcF8H3xwMIZzDoeycCOqpmGCgUI+PSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOXt9KEig8TOSTEtraorQBKpBqKyG9RnFmXv78GMccG7EYlWNlhl7Oj0syMgcJrnn
	 kyzNv9i4QTjO4QGxQUBXWLHIqlfpzxWxQw5nmrFwANQMFWvBnIfdfzT6noXhlPIMwr
	 1tOKWUNtLChcJdSUcJguNS8kxhHjVydUCkgSTXM0u6n+p2Olrvv+i43zpkbY8L1uY2
	 igAKn++xAgGzPoBlBLKl2NQr7Y4rVgea1LK4swoSByJTa5YjOEY67bLcrEBMsD19Am
	 JIPPhz1juMdpwEcx4LKcdVcn35dgWbTorNDp9x21fRhSmpcc2vLmU27LmvbRAjrnRy
	 nQE/qhqrAzEDw==
Date: Sat, 10 Aug 2024 00:26:15 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] ASoC: SOF: amd: fix for acp error reason registers
 wrong offset
Message-ID: <Zrall8SwKewe2_hJ@finisterre.sirena.org.uk>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
 <20240807051341.1616925-2-Vijendar.Mukunda@amd.com>
 <ZrUdOyGiFRH0sRlt@finisterre.sirena.org.uk>
 <a6a0c975-728b-4379-b074-b88ac928c58b@amd.com>
 <ZrXGzmhgyIJ9ID6I@finisterre.sirena.org.uk>
 <adeb6cf8-1fb6-4bf7-8d36-504b22c366be@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IlVGhZeaPl9FJZ8o"
Content-Disposition: inline
In-Reply-To: <adeb6cf8-1fb6-4bf7-8d36-504b22c366be@amd.com>
X-Cookie: Your love life will be... interesting.


--IlVGhZeaPl9FJZ8o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 01:49:37PM +0530, Mukunda,Vijendar wrote:
> On 09/08/24 13:05, Mark Brown wrote:

> > We want the resulting git tree to be bisectable, that means testing each
> > commit not just the final result.

> This patch series is prepared on top of
> 20240801111821.18076-1-Vijendar.Mukunda@amd.com
> which are incremental changes and also has dependency.

For the benefit of those playing at home that's "ASoC: intel/sdw_utils:
move dai id common macros" which is in -next as 8f87e292a34813e.  It's
not great to base a fix for something that's in Linus' tree like this
one which has:

   Fixes: 96eb81851012 ("ASoC: SOF: amd: add interrupt handling for SoundWi=
re manager devices")

in it, and any such dependency really needs to get called out in the
cover letter if it exists. =20

In general you should expect bug fixes to be applied for Linus' tree by
default, especially if they're tagged as fixing a particular commit in
there.  That means no dependencies on anything that's already in -next
unless explicitly called out, and if the thing in -next is just a
cleanup or refactoring then generally it's best to just do the fix for
Linus' tree and then separately merge it up to -next and integrate with
whtaever cleanup/refactoring is going on there.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--IlVGhZeaPl9FJZ8o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma2pZQACgkQJNaLcl1U
h9CqmQf9Ell6DPD08llQhhPHkKPMmyMVMH3Em6EclWBfkZwMwcEkfeDi/gAmk/Nz
tq5bPTJlwqHSpHpYrhos+kf5H2ObSccJw5NqtHBtP5gZk/1TiKmh9e2zfH9Z4n29
hO5MKZ26/2OR1er7onLT9wq6WtC4VL0zO4wUTLq2N+VJPonmzUVLgarvpfZoiTGK
QxNFESF5EJ49Ci3WGfAFM9m395WBCJN5f1GXiUAxBvxe0pSt9g85zekj2KTlTBAt
dpSJsmM646UPt8H29qgOs4kC9O+MqCNqg9ws0sRF5gD6Pewsp1J0wHn2WN5lfln/
LHa+GWZR6Fp4wDP6q6FaB4GdyJdCgg==
=djWk
-----END PGP SIGNATURE-----

--IlVGhZeaPl9FJZ8o--

