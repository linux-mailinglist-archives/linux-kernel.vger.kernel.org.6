Return-Path: <linux-kernel+bounces-246427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5628C92C198
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA00D1F23316
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093A219E7D0;
	Tue,  9 Jul 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHdvWKaQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CE158A36
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542831; cv=none; b=SDae4U5KZbooJ+0GdzNdetkzIvWic34ae7chjNinQXmwFAQZ3f2/He3pFRqbUoFJ9FXSLcsNykeXI1XO8xLcB3LyNW+7vhmkIcworNRDonUQqfbmXjH8Olohj1e+WXTmcy/28VL4PxCwPbAXpKcj1Ekyq7xMccdcaZV5Q9BJoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542831; c=relaxed/simple;
	bh=ieyUAGYiVa46emkVrhl4+PzpqIB/zaKo65nwYoPV9AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKkXgiKz1C/nihvAwsZAuY2k+QfRSJcaDW4sL+HfY+YkWUraKvHfxpa/rnGSDPKgiLMIAsSJHFzmiJG/pgrfSAFClWe3TEeaY8rPSZ/JBjgye3FUn+0Uj9E33BOEdd2XEozx7uZJCDZadUwbvSetissBYxglzoImrzcoE+Fsoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHdvWKaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4870CC3277B;
	Tue,  9 Jul 2024 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542830;
	bh=ieyUAGYiVa46emkVrhl4+PzpqIB/zaKo65nwYoPV9AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHdvWKaQJdfVE98jA3FQVY5aUw2hlHkm/tinrJt2MBRd03MlIG7+FAdP8Po1idu8T
	 jkfokUVp96HAzYpkwSyyMOqsjRF5mghpNsbGj36NcwMaA7p1NmM1VIbROUxa6OOSd8
	 FASymBzQiQOUNoBPhChuIZTQPoHDe+cTPl4QpQJfkltA+okchRmxVYoDU9wIrVfJRG
	 1uDzyL+qixZnsjn1puzrBdxWYZsrb+uwtHkqtk/LwUxps9hSK/16ugPvd9EUDAxu9z
	 rnyTxraHL+BzZFvANMMnxQbL5HigybhWXnWBNnhbvQ3G28+3b3474omhMhahcXHpQK
	 4SVu7mwFv7lvQ==
Date: Tue, 9 Jul 2024 17:33:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	David Abdurachmanov <david.abdurachmanov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ross Burton <ross.burton@arm.com>
Subject: Re: [PATCH v2] clocksource: sp804: Make user selectable
Message-ID: <97f02ddd-5e9a-440a-bda8-82c2fd7957d5@sirena.org.uk>
References: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
 <2b946a68-dcdd-4a1e-b7c3-416725033c2e@linaro.org>
 <ddfc867d-2431-44d2-9753-b577e8f5ddea@sirena.org.uk>
 <11c5de84-21f0-45de-81e0-dc765a391123@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KfBOkOhXk/hPZUaU"
Content-Disposition: inline
In-Reply-To: <11c5de84-21f0-45de-81e0-dc765a391123@linaro.org>
X-Cookie: Most of your faults are not your fault.


--KfBOkOhXk/hPZUaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2024 at 06:15:40PM +0200, Daniel Lezcano wrote:
> On 08/07/2024 19:44, Mark Brown wrote:
> > On Mon, Jul 08, 2024 at 06:49:38PM +0200, Daniel Lezcano wrote:

> > > Would it make sense to add the option in the platform so it selects the
> > > timer ?

> > As the commit log says far as I'm aware all the platforms that rely on
> > the sp804 timer already select it (they wouldn't otherwise be able to
> > work unless COMPILE_TEST was enabled).  The Arm models and possibly
> > other platforms have the sp804 but it will currently be ignored by Linux
> > and the architected timers used instead so it would be wasteful to force
> > it on for them.

> The policy of the Kconfig is we should keep the option silent.

That's not what the changelog claimed was the reason for adding the
dependency, and we have other number of Kconfig options (eg,
TEGRA186_TIMER or ARM_ARCH_TIMER_EVTSTREAM) which don't.  There does
seem to be a bit of a randomness if the options are only visible with
COMPILE_TEST too, quite a few depend on an arch or COMPILE_TEST.

> My suggestion was to provide the option in the platforms Kconfig and
> [un]select the ARM_TIMER_SP804 from there

I can't parse what that means, sorry.  The goal here is to not have the
FVP platforms depend on the driver since they don't actually depend on
it, it's merely physially present.

--KfBOkOhXk/hPZUaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaNZmkACgkQJNaLcl1U
h9BS3Qf/bc4q1MlGYJLMX7Dgq5dtc5dAQv6Z47lh53EhMgwBxwRH17pMSPtQ/B/D
nwY8BnlKyBEKspXIixKxYBGMbe0L8T+f8rUDzSewqx/0yHk7ym0SkBQvucuofCLF
0xbsXmnhVusN2+Z76MeTeu5TLhHrujBapn5m2xuhfbmcl0fmTBMnFjD0vMscaa/F
yOZAY9yJHjEMYocu58A2fHFDF6uWXwEq4R9oi0g09tkECyasmZqjyQnvZNVxSN+7
leFwH6vh3Lqc79B/4DjzQgHSc7VdO4bizSwIi0/hACZWVce8qjFA9JLt5s/E3CTr
7XeLU1SpvvVo/Pbtpr4NJyrXcw/xmA==
=7r4/
-----END PGP SIGNATURE-----

--KfBOkOhXk/hPZUaU--

