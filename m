Return-Path: <linux-kernel+bounces-546905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B429DA50068
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9E018871BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C5248873;
	Wed,  5 Mar 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1SpsoBa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54CC1EDA0E;
	Wed,  5 Mar 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180693; cv=none; b=Qke9J7zS47xERXRH/ewrvIAK6ecU6syUAH9wJkTcxnUstK9d0r/pFCRVUPOAqQJZCndubq8FvkKPZ9untSRPVA3Ey1Ta/L/FBuI2wWTK0LVuQh5AWrpE5fFNhKKXVVA13ndnSaUltsbuU5tsiE4dwMX7Wt8Ph2DNrUbmPu6Fv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180693; c=relaxed/simple;
	bh=mkvPJ4QumDqS6HAf3LUJzR0K1EUYms/KQSx5cZsbzRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU4IA2D24up3x7s3P6p7XNvARbzhH6cxNQ/evm3v/tot4BgZ5DUCddzXzz+lE1SKWTuhHQDxPw9pmlJdzjrhDWNOrFhn038tlL4zLxVANFH6VN4s0GobOfkgn760jlXXTokZKKBw2xaJxIKa1lCzODyJY9YS1G2HQlPeksR09RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1SpsoBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA67C4CEE2;
	Wed,  5 Mar 2025 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180693;
	bh=mkvPJ4QumDqS6HAf3LUJzR0K1EUYms/KQSx5cZsbzRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1SpsoBaX76DjvOnqlwAYpuPI11km6TAPDAp98v0+WMjohMzhFxzPSsOo5IFua2zj
	 UPlidR4UrL9KeINpe8nhRzE/LYSoDOdOXaFeZblF6KyJ1QS9dEGns5XJWyvolVDwTT
	 gd8emGKyrJKeC/ZQpH5DuekMOl1xP0H52/278jei4+COPFG3r2Tv7X6WObTDdrW1Dt
	 u31C3GTt9Ftme6cGJx/h58KYNUMz5Ed+7DIRCsz7awDfZomHMnl+NoBX+699mkv3z6
	 7HdvwzrnjJO+kYQKU0IEzvl3daEB+nnHzPgJ0eMrlIAOgCg8+WljsvEWgEexJZSUws
	 wQoVBqrclmDcg==
Date: Wed, 5 Mar 2025 13:18:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <f0be0cc3-4349-4300-9fd2-9aecdcd9d099@sirena.org.uk>
References: <20250224155500.52462-1-francesco@dolcini.it>
 <20250224155500.52462-4-francesco@dolcini.it>
 <20250225-delicate-tortoise-of-management-e43fa2@krzk-bin>
 <er4bcixggriqp6idl6xmr7bjetf5kkhadyeplkbyxvrffuiknc@ews752x4ugh7>
 <f690d858-a427-4db4-81ee-d5eb6223368c@kernel.org>
 <Z8geyb9ilUPmDUXk@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2SZ6TScEb313MOV6"
Content-Disposition: inline
In-Reply-To: <Z8geyb9ilUPmDUXk@opensource.cirrus.com>
X-Cookie: Everybody gets free BORSCHT!


--2SZ6TScEb313MOV6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2025 at 09:52:09AM +0000, Charles Keepax wrote:
> On Wed, Mar 05, 2025 at 07:45:50AM +0100, Krzysztof Kozlowski wrote:
> > On 27/02/2025 16:34, Ernest Van Hoecke wrote:

> > > I expect most users to use the first five Retune Mobile registers and
> > > not care about the rest, which require a proprietary tool and are not
> > > well documented. The example in the binding shows how some simple
> > > static EQ can be configured. Anyone interested in the extended config
> > > can also use it (statically).

> > No, if this is suitable for dynamic configuration then it's a proof it
> > is not suitable for DT.

> Whilst I can see the argument that this could be exposed as an
> ALSA control. I would also suggest that this is not adding some new
> feature, these values have been filled in from pdata for 16 years
> now. Changing the way such a vintage part works at this point feels
> more problematic to me than a slightly iffy DT property.

> On the flip side of the argument, the parameters that are filled
> into this are almost certainly specific tuning for the hardware,
> so in many ways this is hardware description and there is a
> certain appeal to shipping the tuning with the hardware (ie. in
> DT).

Right, the intended use case for the dynamic configuration is lab tuning
rather than with end users - most things that are configured like this
*can* be tuned interactively (or interactively from the point of view of
the driver) but that doesn't translate to end users doing it.  It's more
like coefficient data that could also be loaded from a firmware blob
(but again, there's a proprietary tool here and it's not expecting to
produce anything except a list of register values), we do have some EFI
examples of pulling tuning data from the firmware for things like
speaker correction (which is one of the use cases here) IIRC.

Like Charles says this scheme has been deployed for a decade or
something, it seems unhelpful to upend everything right now.  We could
also implement an alternative scheme but providing something that makes
DT transition easy seems productive.

--2SZ6TScEb313MOV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfITw0ACgkQJNaLcl1U
h9C39wf9EwzxjxnqwmMPXRA6fF+xUJYybxJvfyV1u5DNHECxtYqJWZsEuQpRp2CD
v0OmfZHyVfUcFSWA4+1Tdv5u+F7lxmqCZ6dzeqRz3AAginWJeXiwXR2bwlDJ61oq
3yHkNm3j0uElMkjJEAP5bw/MHgBE+4Be/PvdnYHipApgEOgQ4TIgHH8yRFCPY3Wo
kTxPYkufiLRPTmH7t1oonaLddybuyXOlxL9lq+xuhsSDnAbQoOcq4DBg/AcBhMG0
D+DJr+5C/WCXPRfAqNznBX7wCJNQvfXtwYW0GA13OOWqoTwsjjoeNgK++W73+5/v
N9IoR2lXdMQWqAexh3v8q3dm33IhbQ==
=c6jI
-----END PGP SIGNATURE-----

--2SZ6TScEb313MOV6--

