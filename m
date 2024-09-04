Return-Path: <linux-kernel+bounces-315144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ED496BE83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4681F23AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0F1DA11C;
	Wed,  4 Sep 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNzk1DzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F106B1E884
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456523; cv=none; b=g8WtLejlSq/ShpMJLvglfYxsImqP6gEgCxmuvdYuHdS1SSozAcNHzn5z/+9qoswgbQmaQlPyaEJZ7Tjn2ycme14hOTw4pGW5QY6CZRLtvapiLDF9x7G0sJOIHsOnx0GE4RXVCnBTd/OuSzjpuYqCMVOiPVyl0bTjYFt4nOYcgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456523; c=relaxed/simple;
	bh=eroJLeqLf0OUq02IKQEdp68yOvp3QMxXS4C8SFKb3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MayIvytyexIJHrQYyy1Z2Hl5QPOTY1Qi2aFeWOXbJDzCnoMNwF2+2p0VgJli3UffE55W5/Iq+QxMfii7Z5EsWdW/axP0H31NJWoxoThMHMF3l0mWRvuNpI0j+f0Wa2yVAHEWbKvg6iq0ovFQfFPNENfHcRkUJZ1cw//2Xn+rjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNzk1DzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00E9C4CEC2;
	Wed,  4 Sep 2024 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725456522;
	bh=eroJLeqLf0OUq02IKQEdp68yOvp3QMxXS4C8SFKb3FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNzk1DzCP0Mt0bAAp77FH+jZdsw/vAaV/aqtOl+woShNxlOHGexw7PzSxYm66F0eR
	 Qlefgu6sBzmO1tygJbJaccJQKr+/EPYuEwB6Pek6CQDo96GfMEApEYd1ZDiwR4D+Aw
	 XmK8YgSJZLb36+m7QK+h0FNWCJ3x/2PG8yDs8qzjK4FdwmDHCNGVL4mTpqw3UVLGYM
	 tgFnFFab+TVp7+0+gAbw+CFNWwaXN3ka3AkKoYSIEdtxmCI+wP1quzwt6rsMR4smQJ
	 sTriLpnrQD+bqdeugaS2KLIVXWDqgeQf/u22FUEuofaYu3Ql2euYyML0z+H4vzAD6M
	 8NuV/fL5HHmTg==
Date: Wed, 4 Sep 2024 14:28:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 11/15] regulator: core: Use fsleep() to get best sleep
 mechanism
Message-ID: <544ffae4-b67b-4152-bebf-21a90c00fb76@sirena.org.uk>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-11-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7foanu/9iFLKz/F"
Content-Disposition: inline
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-11-e98760256370@linutronix.de>
X-Cookie: Linux is obsolete


--m7foanu/9iFLKz/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2024 at 03:05:01PM +0200, Anna-Maria Behnsen wrote:
> _regulator_delay_helper() implements the recommondation of the outdated
> documentation which sleep mechanism should be used. There is already a
> function in place which does everything and also maps to reality called
> fsleep().

> - * Delay for the requested amount of time as per the guidelines in:
> + * For details please refere to fsleep() function description.

> -static void _regulator_delay_helper(unsigned int delay)
> +static inline void _regulator_delay_helper(unsigned int delay)

Gien that this just becomes a trivial wrapper for fsleep() why not just
replace all the calls with fsleep() and remove the function entirely?

--m7foanu/9iFLKz/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbYYIQACgkQJNaLcl1U
h9BzcAf+JaPSWYXXMMKMUK07mS0KMm4MTPr/qzmeFZzFXV8iyAC4wlkDBsoj2/+/
3YYy/llUkCN8TDDh/2PIjVYy6GiiH4K1z00dcIzNEwC3XhtRuAOr8tz2dXH2/ba1
nRXmFp/tvse/JazEYACRHwXSNZb/xmdm21Y2Cs+4Co1qIRIzc3gNuo266XlOCYio
b9s6kSbRHXcsQUVuUkzbUMeDlL4TclwGcP+RuqrD3zTHQzBoIy+DXTRzg5eROEaJ
kR0c8UnKZLo3T5I7VEiO/Z/x3MEFbsuehUfecauhmjqIPfDRyEK4nV4m/lZTPuqb
c7Ao5iEwUx0fTv4CrXg4BWKbdUSyYQ==
=J/+e
-----END PGP SIGNATURE-----

--m7foanu/9iFLKz/F--

