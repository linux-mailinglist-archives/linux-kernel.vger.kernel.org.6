Return-Path: <linux-kernel+bounces-319263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDB96F9CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B262832E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48A1D4178;
	Fri,  6 Sep 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP1IhbIH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B8129E93
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642970; cv=none; b=oaFIYnvxkDvsGtuFsvzRfHtqjA1IXspaTpte03B0B3jRc1hYgibWKP/eTZThHf6FvIcE0UxYM571V7ZQTSsqq3SKDhfxRSDYwKN+6TbVD9c2BTogqHulzFnRqLJbHDSW/xkI8Ud3jZxAz0+ZoS91dZFybbp/8VtQnd1ZNa+FZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642970; c=relaxed/simple;
	bh=aE1Xcj78JU4ye7NcyZ7ekBSM5M5rF82jsfwtvrFTCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpM1qsAQVZXQBtpBu19+OmRUiVp3odSjcBU1kftTNWywWRrPCeRAb7Uq3q+Y3Z+askYqCuAOrwBNrvM2EUYC/YIp92WYI9rKIzHD+Rj/SdWpnHa0/abLG7oFfhQ+6Lgg2vKIAjlzhYTT4IBR6aH+SR3x22jxOvamRm1HdtUZcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP1IhbIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C7CC4CEC4;
	Fri,  6 Sep 2024 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725642969;
	bh=aE1Xcj78JU4ye7NcyZ7ekBSM5M5rF82jsfwtvrFTCkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TP1IhbIHsX96dsuCqgcgiHTwQz5/v9nUYDYYklrNLeaGFU6ioNJ81njLYIi0QpTEH
	 UMmOiaMPKGBaVSAyXZk7+2RQnQPYnyEZvznWa03SC50jR0Rrw3IozlqxP+tEwmUATt
	 PaOUzxMnVdQdFWjk1XdwnlMYEcFd13l6f01yrtrsUSpIqffR45zY6jcimztz+wD1kF
	 Vl50LMr7JL5XGtvXKN7F/rJEoiVhYm0AIuJkWPl+UUXg0Tw5eOaAW9X7A08L/U6+JN
	 XjnltmOgj8rSUa7IV/1AdlSydLvOQUBhZo5YPAfiUeeP+cm/PeqCs0Z9o3blRZYYEg
	 07YBG+HMkBsnQ==
Date: Fri, 6 Sep 2024 18:16:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Message-ID: <Zts41l46Ufo0tk4Q@finisterre.sirena.org.uk>
References: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
 <Zo7qzWVXRWulVtCT@arm.com>
 <Zo8ZDBisWJonBVqF@finisterre.sirena.org.uk>
 <Ztnvosf0JHsvCf7-@arm.com>
 <8c625518-7f73-40c9-8c91-3a0b14240003@sirena.org.uk>
 <ZtsYNOTA6ekEa6TE@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A2vu8oGfyfYpZjk9"
Content-Disposition: inline
In-Reply-To: <ZtsYNOTA6ekEa6TE@arm.com>
X-Cookie: Your love life will be... interesting.


--A2vu8oGfyfYpZjk9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 03:56:52PM +0100, Catalin Marinas wrote:
> On Thu, Sep 05, 2024 at 07:34:41PM +0100, Mark Brown wrote:

> > On context switch the SMSTOP is issued as part of loading the state for
> > the task but we only do that when either returning to userspace or it's
> > a kernel thread with active FPSIMD usage.  The idle thread is a kernel
> > thread with no FPSIMD usage so we don't touch the state.  If we did the
> > SMSTOP unconditionally that'd mean that the optimisation where we don't
> > reload the FP state if we bounce through a kernel thread would be broken
> > while using SME which doesn't seem ideal, idling really does seem like a
> > meaningfully special case here.

> It depends on why the CPU is idling and we don't have the whole
> information in this function. If it was a wait on a syscall, we already
> discarded the state (but we only issue sme_smstop_sm() IIUC). With this
> patch, we'd disable the ZA storage as well, can it cause any performance
> issues by forcing the user to re-fault?

There will be some overhead from reloading the FP state, yes.

> If it's some short-lived wait for I/O on page faults, we may not want to
> disable streaming mode. I don't see this last case much different from
> switching to a kernel thread that doesn't use SME.

Yeah, that one is going to depend a lot on how performant the I/O is.

> So I think this leaves us with the case where a thread is migrated to a
> different CPU and the current CPU goes into idle for longer. But, again,
> we can't tell in the arch callback. The cpuidle driver calling into
> firmware is slightly better informed since it knows it's been idle (or
> going to be) for longer.

Yes, cpuidle is a whole different case - this is mainly targeted at the
case where that's been disabled in the kernel configuration (I was
considering making this conditional on !CPUIDLE, it was an oversight not
to do that in the first place).

> > > Also this looks hypothetical until we have some hardware to test it on,
> > > see how it would behave with a shared SME unit.

> > The specific performance impacts will depend on hardware (there'll
> > likely be some power impact even on things with a single FP unit per
> > PE) but given that keeping SM and ZA disabled when not in use is a
> > fairly strong recommendation in the programming model my inclination at
> > this point would be to program to the advertised model until we have
> > confirmation that the hardware actually behaves otherwise.

> Does the programming model talk about shared units (I haven't read it,
> not even sure where it is)? I hope one CPU cannot DoS another by not
> issuing SMSTOPs and the hardware has some provisions for sharing that
> guarantees forward progress on all CPUs. They may not be optimal but
> it's highly depended on the software usage and hardware behaviour.

This is all getting totally into IMPDEF behaviour (and QoI issues) but
implementations are supposed to default to something which shares things
equally between all the users and guarantees forward progress.  Anything
that doesn't guarantee forward progress would obviously be quite
specialist, and you'd hope that if the PE isn't actually issuing FP
instructions it won't impact anything.  Even if things do great you'll
still have the cost of keeping the unit on though.

> I'm inclined not to do anything at this stage until we see the actual
> hardware behaviour in practice.

Like I say my inclination is the opposite way round, though probably
with a check for !CONFIG_CPUIDLE.

--A2vu8oGfyfYpZjk9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbbONMACgkQJNaLcl1U
h9DatQf8D9DHZ0Vhbq9V0cW2vIt6LXXEvxPf5EjBHJ1p6KSyMGAvAdxDqz/09FN5
NJuh7VMS6a41FqJlxNx3P3f+5qBk2L+IrEycA4jXrjXIx2Hfzt95NKc3KoGu44jS
gh+VJ0Vc7kz+CgvLOnPb4qATxQpX9XstQdPtDty5qBERzeHslmiaQiL7wQc7zbBQ
+M9FNp+DUmZHZ0PS++bvyVTjUNzaspkXRW89OTejVXfRkrve6OXP6dG1GZv8dNr1
Xg3GQNYNnYHDAbx/m95mIOFbeQu0mZrGXw0QKYdkpk978dT+zcSh9jLGaNRdbefm
aYPmR8eWD54xQ42n1T+hh+xljVjQmQ==
=Zxil
-----END PGP SIGNATURE-----

--A2vu8oGfyfYpZjk9--

