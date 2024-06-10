Return-Path: <linux-kernel+bounces-208961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D1A902B08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D86288288
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA81494B9;
	Mon, 10 Jun 2024 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtb926Bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D6558A5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056561; cv=none; b=dqkDXhmszI2VOAUKJ1xrLKiHHsH4eUeslVqcrAfCXDIjMqEAMNnRwGc0a2Iml7Sx1rliYek4b2VmBgKxuOJMGujHzXQSHx3pQ0WyrdBZdzEAOAJ/1uwkc0vxmB8oEcy2cwjEJ4RV4p32lWhxF1gUwYojcbV2pyEPgj00MoRECf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056561; c=relaxed/simple;
	bh=iy8lvVjaZjXbwrzNiZJeZRnHGUvPcMcMOjoy1+lYEPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXq0nT6b4O7wxIxX84/E1wJyRFJ75y1DNN+Y8DEaTtjrqlPTfOaOtPMcc1dus+rHsSA0kmuz9exVzS9GC87QRAJQjG9w7XsojZCyqEiJ1tlAiVtKLybAg6mN3W/EY4rG/S0z922XKpkx/gkH2jz+cEY2faPNANkUid6bhtPLVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtb926Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F115DC2BBFC;
	Mon, 10 Jun 2024 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056561;
	bh=iy8lvVjaZjXbwrzNiZJeZRnHGUvPcMcMOjoy1+lYEPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtb926BdkY6NdF3diS/WEHS6WhKcYDSVE8Zno3mjBoZ9IFIjKc75oUA+TvBm6nyaA
	 JP2PJYaTr6yWMCMB/Faz2tanjYDsBpXCsSGRYGy61rMv8HSMHVIkiEbfPylS8982E+
	 Psh1iotj2T1bN4jY1dCd2AxojWkOno9/jUEkkZZSXqu2PvHAI9ZfC+xt6zGNtdQfEx
	 53j9GCc3wANfFfd/PI2BvMWpi2JxXirEFc+M7zEE4QyNue376gP0SHjT/9EIn+4SJp
	 KMAgHkYOm8WyPI5+8WwYWu3rnQg9mDtkf43b7MDbtGb0Sb8FFlpjQeBs4kX3K11hfz
	 idTK2Wf0lx+rg==
Date: Mon, 10 Jun 2024 22:55:55 +0100
From: Mark Brown <broonie@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH 0/1] pwm-regulator with voltage table problem
Message-ID: <Zmd2a0Etz3elXFID@finisterre.sirena.org.uk>
References: <20240610120025.405062-1-gnstark@salutedevices.com>
 <Zmcdvm7XbtU1JlQr@finisterre.sirena.org.uk>
 <62c9b99d-f0a4-4207-84b9-2176823b9724@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QZBuJqS1t1o6h8AA"
Content-Disposition: inline
In-Reply-To: <62c9b99d-f0a4-4207-84b9-2176823b9724@salutedevices.com>
X-Cookie: Your love life will be... interesting.


--QZBuJqS1t1o6h8AA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 12:33:42AM +0300, George Stark wrote:

> Actually we did a similar thing - we modified voltage table adding
> duty-cycle that was set by bootloader with fractional voltage value that is
> not used in opp table - just to make pwm-regulator happy.
> But this issue was very hard to find. Due to deviations of hardware
> component's characteristics some devices managed to keep working with
> minimal voltage till cpu opp driver got probed and appropriate voltage is
> restored. Other devices got stuck at different places with random errors.

I think the diagnostics you are looking for here are in the PWM
regulator driver.  The core does announce that it's bringing the voltage
into range when it does it so there's a hint that the voltage got
changed there.

> Of course such a behavior should be configurable. At the other hand it may
> be too much changes for a corner case that's why I proposed only a
> warning patch just to simplify detecting the problem.

> Actually we already have a hint that says voltage is reset:
> rdev_info(rdev, "Setting %d-%duV\n",
> 				  rdev->constraints->min_uV,
> 				  rdev->constraints->max_uV);
> but there's no indication this is due to regulator device  error.

The issue is that it may not be an error, it may be normal operation -
there are some regulators (those for some of the Qualcomm firmware
controlled devices for example) which are purely write only so we've got
no way to tell what the current configuration is and always need to
write out what we want during startup.

> Should I consider adding my warning only for "system-critical-regulator"
> regulators (cpu power regulator is critical indeed)? Although this property
> is never used in mainline bindings.

To the extent that it's an issue it's going to depend on the specific
regulator, the driver for a given regulator is best placed to know if
being able to read back from the hardware is expected and if it should
complain about not being able to.

--QZBuJqS1t1o6h8AA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZndmoACgkQJNaLcl1U
h9CKGgf/QI5Kdu1s/26vxdH6WSQvo2/mzgmPQpyFgmucgUPTfbkhPiQkEOTmTLYM
6Zz8LV5sfIk+HSGlanwbgvdeAowZH8Arb0sb15jmTiAn76G6lHd8eNvZbIL11Ytk
sze7nsOfE3bUmMC6/WUzuCTcnEXNv1AaQDurkNEdtRdieCPQBDyA5BhHaTmvZU9i
0yoIdMZUDZPPOoiqJJTRhTTBwgSSg87AdrTQADo5aJXVSxwPe5G07mzXZfJddeU7
jSvtzMS8GEnpoTQ3fQUoi4WbWOxopZxW3qcrNSF1kEQ3ixcnmf6/dDZzcz00RLLS
bncFH71acPXmO+41X8+qK5QzTNDtkQ==
=ZabS
-----END PGP SIGNATURE-----

--QZBuJqS1t1o6h8AA--

