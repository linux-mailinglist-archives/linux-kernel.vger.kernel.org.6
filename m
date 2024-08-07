Return-Path: <linux-kernel+bounces-277694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD894A4E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D5C1C20E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E951D1F42;
	Wed,  7 Aug 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j28K3tku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41C1CCB35;
	Wed,  7 Aug 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024843; cv=none; b=EoiWGj4DOeYoAAzXuuUMxDZbQsCHOMjKSPha9NcLo1d8rCkAELVOcRpFu34KeOYPTxBO3D79BYNTA/3+BPUtzDUDj9a4rNGSaEBOEQjuV18tFoubmfyfFis9WTuy1wukEyd6W61JiyjfH7Xxa4XS+c7LuAbWMFcdEpHPWF40jLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024843; c=relaxed/simple;
	bh=GYOdhohoWSTAlECirRhTbMhtu4F/Qp2FJ9KwXEWuheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZu8tQECl9KmosoxsQwzvLhhzWRFZOsImPo3XyotQCWQZrERRYF1crHWaghRqsDDIdujJmCkgDOUKEnvp956acn8gAp+nT1z2JVU4tBW+q01zMned+vVsGxoDB4YFBe0U7CNj64WHjpJPH5XAh7ysdUjF70I9DBC74klPsBfyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j28K3tku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90FDC32782;
	Wed,  7 Aug 2024 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723024843;
	bh=GYOdhohoWSTAlECirRhTbMhtu4F/Qp2FJ9KwXEWuheI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j28K3tkuqO/kIgwQvpVAsL5q34iez39cNmTnhtvVEBvaU3KqGUFLWljW8mwAyqx8J
	 89VuvjQMJX7G5kTZRS2jeVuBwvsVq0mRD9KfA22gEM96PltSDsFTQ3R6Rc85rpybvJ
	 F/ikbJaEpBg//80I1w6fIog3MWe4jBqGifBuD5hQsa8maYS0v/p3URM7ZMUSa+K32o
	 FYaSd8QUFVN1OAc2S6UhRfcNORBOznkbE++aZuF/gliCzvypYiVcQAK9jmtnJaLPGK
	 8rv6O7hQUoPg2qk5BnZlG4q3cTQxkTbt9Hg4LTgVH80JLXsjuAMUhUoPhCxwHI7L3j
	 Z8jGpLgv03OEA==
Date: Wed, 7 Aug 2024 11:00:35 +0100
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
Message-ID: <f1d65326-e671-44f1-bc10-0e1ec33c30ce@sirena.org.uk>
References: <20240807080302.2372297-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tj0N6rkUapViYW72"
Content-Disposition: inline
In-Reply-To: <20240807080302.2372297-1-arnd@kernel.org>
X-Cookie: Offer may end without notice.


--tj0N6rkUapViYW72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 10:02:27AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The snd_pcm_hw_params structure is really too large to fit on the
> stack. Because of the way that clang inlines functions, it ends up
> twice in one function, which exceeds the 1024 byte limit for 32-bit
> architecutes:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tj0N6rkUapViYW72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmazRcMACgkQJNaLcl1U
h9CF4Qf+Odlon1G/8fg6R//jYM1cLs/S2fc/r/6YmRgmBsaMl8WG/XWiUWHD7I43
jFfc+MQeQn27U37A0p22iblDjx7nAuo0fK0HwoPu6oHm+5TyeW9x+aXeGQYzyyvg
WDthIEXhk2vB4pfFb6H9s2z2hZ1I6Q19HKS8HMtWLLaU/m6PP5pDw4iWP0qG1Ji5
MQeDNTc1zbiZgz0vPgczuBkAUZtnrXJW2/46uXESwQzOEiXd4gp5e/b/qdGj1MZ3
ob+W79ECNyRaSkmhN9EcggyN0ugZ6E3Nm71ZX2QtKkE5Swuy6MqV+hqNvie3A+NZ
81CHvb2TLQobkgSF1WVSyMOolV89JA==
=l80j
-----END PGP SIGNATURE-----

--tj0N6rkUapViYW72--

