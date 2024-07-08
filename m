Return-Path: <linux-kernel+bounces-244713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BF92A85A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C861F21D04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76B14659F;
	Mon,  8 Jul 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc7i3+N7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BDAD2C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460682; cv=none; b=IKmvqSKR9QubNjE6ftpNyoMxmNTlFbpKwrw9Aj0etXpYQKi66vcthaGuFky+rVbV8ojqVRwvJ5uSh18DQ/26hisUep2RRH4J33FJj1S0/8bwiBMKitKXkl5J2s60iluwfL47lDmwdmaAC/OraaEOZ9uTdBtKl2H+XbjWFx2SAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460682; c=relaxed/simple;
	bh=fJdijarOdeOiYkJmtENxWG6XvECxSgzYRkmGDVjF3cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtTDHspMdZoVruAvvohBxnuJwutqRmLLrKVz/lugrh5VTFHg19/CXS4DvFQQL7FEO9dw6ZByal6VVzII2r8PcsQ9mVnZUwk+qtt3Lx2O7aTUy9NT4cKjY7FLO8DTsG1BgAvvUUqQt4tEpBIN01j7Y7ytrygIX2vsaFHkQOnmFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc7i3+N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A914BC32786;
	Mon,  8 Jul 2024 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720460682;
	bh=fJdijarOdeOiYkJmtENxWG6XvECxSgzYRkmGDVjF3cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cc7i3+N7+FIV0PBx6xtg8oegYLv+kIAV8RfCoFmm+QwC+4f1J3CRSZdu/ERk+R4DQ
	 o8IAP28r2NQ2PuydwzXzOKcCDFbOXqaHRVLcbMI1MYiMGnGJ5c70/Wl4+igc9Afr3u
	 7xtMe5n38a+l9RdOwbtrEuBG8b+GTSq01oUqX/gReHej9OyznvVQj800WgmYBn7//K
	 qE1SDSZvAco8s5+q/lmFpfV/S9+O5Upg5JmcamNtDpHu6Z4kbPNbwSHtnNO+dRiwjk
	 L6/rHtK9XUhz95O/AW3r00nu47NonicxCj7WOGQ8TeDmL99oh99nO+ca0W6hlwoIU1
	 AbgUPedE9V6oQ==
Date: Mon, 8 Jul 2024 18:44:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	David Abdurachmanov <david.abdurachmanov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ross Burton <ross.burton@arm.com>
Subject: Re: [PATCH v2] clocksource: sp804: Make user selectable
Message-ID: <ddfc867d-2431-44d2-9753-b577e8f5ddea@sirena.org.uk>
References: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
 <2b946a68-dcdd-4a1e-b7c3-416725033c2e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B3oMzoTFaOm/yyLw"
Content-Disposition: inline
In-Reply-To: <2b946a68-dcdd-4a1e-b7c3-416725033c2e@linaro.org>
X-Cookie: Many are cold, but few are frozen.


--B3oMzoTFaOm/yyLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 06:49:38PM +0200, Daniel Lezcano wrote:
> On 29/05/2024 21:48, Mark Brown wrote:

> > The sp804 is currently only user selectable if COMPILE_TEST, this was
> > done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
> > COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
> > spuriously offered on platforms that won't have the hardware since it's
> > generally only seen on Arm based platforms.  This config is overly
> > restrictive, while platforms that rely on the SP804 do select it in
> > their Kconfig there are others such as the Arm fast models which have a
> > SP804 available but currently unused by Linux.  Relax the dependency to
> > allow it to be user selectable on arm and arm64 to avoid surprises and
> > in case someone comes up with a use for extra timer hardware.

> Would it make sense to add the option in the platform so it selects the
> timer ?

As the commit log says far as I'm aware all the platforms that rely on
the sp804 timer already select it (they wouldn't otherwise be able to
work unless COMPILE_TEST was enabled).  The Arm models and possibly
other platforms have the sp804 but it will currently be ignored by Linux
and the architected timers used instead so it would be wasteful to force
it on for them.

--B3oMzoTFaOm/yyLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaMJYUACgkQJNaLcl1U
h9D/PQf/ex4DnX3Sz8k/XryILFJMLeyiZmFd2gRAFjcP10e0sUXv8QEuB99JtntF
F/U6KIKhGa3lY6LvnY8ZWMs++1VzyCQkGMjcOxudenZpYfEG6tRrsai2UQeNw/CB
po9s1i3tzj/6iXSRMetXsZvP0egNNEXBLAMOqJn+DQTOYKYpJKDIMIWUUGgsfKor
8eMpo7gGSuBzB+iJbiSiuhkkeaXzduea3Bl+0LVeuNc8Pn1Wcnw6j/HEvCZNxvcm
rxyQ2V6ub2TGraMI+hey/t6i5zwC/7pcw6mDJ77/qbNt84KOLoKrK7J8IVC6geRk
zXoiFKUB7kZdS588Ggyx5upcLsMUDw==
=QXrh
-----END PGP SIGNATURE-----

--B3oMzoTFaOm/yyLw--

