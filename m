Return-Path: <linux-kernel+bounces-219773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A661F90D79D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C42889D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEAC56B8C;
	Tue, 18 Jun 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZVBhP5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71979745ED
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725424; cv=none; b=Ie8rJLjm/w+uqbP0b6E7zdAMRT0Q44AOahyghBeyZ5Pe9FSpg1bSZiXnllFCheg0arubCw1phQslTx9N7vwhiOAt3H6Wrwe4IHb1ulo99yBkzoxasTgtBetCK749QVxvk3vr5aLKuZA614yM1mYgHtgspdSNMni7oXr2lTsIxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725424; c=relaxed/simple;
	bh=4zsI49DcZDsdL2v6wMfGPIPF25Eu/iZX0mc0tTS2fVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+P+/SaCLPj7b8WD8frUF0R12OficCTmakn/aNQAEf36WyXBu6sSZS98LOqdlRe9aoGZ4zCO+FkHHYk/Y9Mc7LHaiAets+prtcGHce0FNSZa/0f1ZJfikYrSHPCwXAoM/oaUzX7auslXwKSEgRbBjdrqdrTNurRKSDI+Rbxb3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZVBhP5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852B1C4AF48;
	Tue, 18 Jun 2024 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725423;
	bh=4zsI49DcZDsdL2v6wMfGPIPF25Eu/iZX0mc0tTS2fVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZVBhP5B/moy4GwOmX9eZ1yYVwYcU8i/6xDRL19pVk3FTGr0wu9Ki5PcuOpC3/FIg
	 ph1tNvXcaMgVIpo7kGmiYvUN53IX/nhZxT2+RLre3mY/vPG4DJa72x+k1qb3W92c6t
	 QGAcIECjXM8Fih6OXInZSvSgwPvpsLTrlk0szzls1JCiHRQGiZ/BEJViOF+C7fhxN1
	 l2DrUUMtB7MH2g8h14cSt4ddfxAzIiiXzqcPrR9x1Sve0lNvlOOVV8z0BXiSSlFB8w
	 W0gQx0NyuZ25yz0NLPhWVgFecfbz0Dee0GpM9xYcHbDz8IDbU8rMOt2+Um749SR0Em
	 j5qI03bg4yLng==
Date: Tue, 18 Jun 2024 16:43:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Ensure that offlined CPUs are not using SME
Message-ID: <73a2dbc7-6297-401a-a8b2-3ed02afe5e4f@sirena.org.uk>
References: <20240618-arm64-fpsimd-sme-cpu-die-v1-1-9a90d1a34918@kernel.org>
 <ZnGfA-kGqCjbDu90@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p/f/KnoKXBxCI4tt"
Content-Disposition: inline
In-Reply-To: <ZnGfA-kGqCjbDu90@J2N7QTR9R3>
X-Cookie: If you can read this, you're too close.


--p/f/KnoKXBxCI4tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 03:51:47PM +0100, Mark Rutland wrote:
> On Tue, Jun 18, 2024 at 03:03:50PM +0100, Mark Brown wrote:

> > When we use CPU hotplug to offline a CPU we may transition directly from
> > running a task which was using SME to the CPU being offlined. This means
> > that PSTATE.{SM,ZA} may still be set, indicating to the system that SME=
 is
> > still in use. This could create contention with other still running CPU=
s if
> > the system uses shared SMCUs.

> Does it actually cause contention if the CPU isn't issuing SME
> instructions?

It was misbehaving, I didn't dig into the specifics of how.  There will
be a power impact too regardless of any instructions being issued.

> Is this theoretical or something you see in practice?

It was inspired by a report, the reporter was able to fix their firmware
to be more sensible and issue the SMSTOP itself but it seemed like
reasonable defensiveness/politeness for us to release the resource
anyway.

> I don't think spin-table is relevant; there's no support whatsoever for
> offlining CPUs with spin-table (and offlining will be rejected long
> before cpu_die()).

Ah, good - I didn't spend enough time to convince myself there were no
situations where we'd try to take down the CPU anyway.

> > and it is possible that system firmware may not be ideally
> > implemented, so let's explicitly disable SME during the process of
> > offlining the CPU in order to ensure there's no spurious contention.

> If this is an issue, surely it's the same with idle, or any other long
> period spent in the kernel, or any long period where userspace leaves
> the CPU in streaming mode?

> It feels very odd that we should need to do something for cpu offlining
> in particular.

Yes, it's an issue for idle too in the case where we're not using
cpuidle - I sent a separate patch for that.  cpuidle should already
cover this either itself or when it notifies us that register state
will be lost. =20

A good chunk of the other users that spend noticable time in kernel mode
will be using kernel mode floating point so disable anyway due to that,
and for everything else there's a tricky tradeoff with how long we're
spending in kernel vs how much pressure is being applied and the
likelyhood of returning to the same userspace process.  That feels like
we need some more real world experience to see what if anything is
needed.

--p/f/KnoKXBxCI4tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxqyoACgkQJNaLcl1U
h9BA7Af+Ohjo17i8FsJvBpk/mpV/X2Lcv/96OpBtAavt6Ol08JF9y0+62fgG8EUN
n8bQwYaLgktTZkTwC8doPT+8Mw7C8KHDOYd3KU1pGpLReF9g4zQ0udpMS4P+wJhX
qNGxwc+dr6gBOAzCHxDeGgmpyaHmDn7P7wvcVggptQe0vxQoSh3IAagug+V3DzBa
pLXvpSXHekK6n8WA0t51m+47oE2SCW02vh1qUo+7wEJL10VwZJfdZS7xEWTo8ABf
66Bvv5ZMwwXFI15mJ6YG3wa76uSlIRMnnjfrV5zI4XV8aWH3JXZH1eZCg3GtidLm
nSAB8K9z38doPnT2/2xocNl2ey/VAQ==
=sW36
-----END PGP SIGNATURE-----

--p/f/KnoKXBxCI4tt--

