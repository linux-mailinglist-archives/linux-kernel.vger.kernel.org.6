Return-Path: <linux-kernel+bounces-439772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43989EB3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36BE2821D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930621A2846;
	Tue, 10 Dec 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzXvF2eT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BB13D8B1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841958; cv=none; b=l6/HMcSkWcdjATNF/GY4wdE8A7Bdv+pvLcnnpqbh5O1GE6QyA7AmV69ZyBcnJqaWAjfv/IxXU9BKrK+0kc3Syvjzzyxik+5IEwaHZqAvic3OZ3K6WMUsOasKJOfvw71BpSfFNoJ6pKGecvJf0O4sBTcIzx0BKUK9orXpuXB8jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841958; c=relaxed/simple;
	bh=GMYrMpfwKSGDucGIkOOyekDt9RHScYPq0EWm9Q8WkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEQ5osW3PlxVXABCWfRxfnb9h4T9NPn+5HhAqxbCHwr/lL6C5EsykFz3rvMhB2adlk4nR92WPqMeF9tA4ZUxCmrR4T/Sk04wHH3o3RrfkOs2qu7h2NJ+3sucJKSMdzTSAOKoTSz2tyzSDtCBs2T1NDhVX92CJTBkxYR+jCwDkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzXvF2eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E93C4CED6;
	Tue, 10 Dec 2024 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841957;
	bh=GMYrMpfwKSGDucGIkOOyekDt9RHScYPq0EWm9Q8WkiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzXvF2eThXHwU3rAjHNMrf4VIL9uJpQDhOl+3xxAuzv394F+6QqczY9KtW4lWksJy
	 wiv7nYvPWK6AGkcj0b3jw/d/7XvtOk750NzZUQlv0NCkJq+5paMdadCa6QkRLscnok
	 dEvl3S1VDPLI4hULXsCecaLB0rrDBCQ2OTyNDOqUuBjBPr9TPpBAKQOPW3U+/YqZE/
	 RWpato4HeAFvQYlbS9T3db0Ko+/v74iOttwWhHrlK0RH+6dcvoyYZ9PoL2gOveoumz
	 SHlP9QI/1s4zGxUujQwbECbmvXhANkmGjBjaXEqm+m8xNwZnTRrM+fv94ZlfaYQds5
	 v8TWkDxZMnKbw==
Date: Tue, 10 Dec 2024 14:45:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <755660a1-0536-4520-8c01-9c254b02fae0@sirena.org.uk>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
 <Z1hNllCWa4u-IxrH@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ey7ko7zyVLfp6lHg"
Content-Disposition: inline
In-Reply-To: <Z1hNllCWa4u-IxrH@arm.com>
X-Cookie: Leave no stone unturned.


--ey7ko7zyVLfp6lHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 02:17:58PM +0000, Catalin Marinas wrote:
> On Tue, Dec 10, 2024 at 12:42:53AM +0000, Mark Brown wrote:

> > -	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
> > +	write_sysreg_s((unsigned long)(gcspr_el0 + 1), SYS_GCSPR_EL0);

> Would we now get a warning here?

No, like the changelog mentions converting to an unsigned long is
regarded by sparse as a (the AFAICT) valid way of discarding the
__userness of a pointer so it's that change that silences the warning.
It does the right thing with whatever sparse I have here.

--ey7ko7zyVLfp6lHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYVCAACgkQJNaLcl1U
h9CsSgf/YtXlOQ/FWK5sRGxFr3DCs0csSiv0kz4bc8U5saalD7Tf7Z2hk/HyAcmM
VQWiUCuKYnysyju9p2hKfQKM0PrWgZ5Fv52dMF5omVBLQpfSCrokqZTMpGlpOgqP
zHfuKIcHC/Iby1wDzevxfHJUkmVr+MkdREIb+x67guEMewJF4eri8cE4n22kZtQJ
2Lhky5EYP8TzS8qd6SAYGMRkGqF5RRjPlmuUghwlp3KBypsdEqhWN4sFFS5lnp9I
EUKULrAuMWD4yI3T2o0X+M0iGF5OkZNWbrGnvzi4To674f0J29w4xS0hqFZEOyCC
LmUYGWEdQe8Gd1NewbwdnuQgwDPoXQ==
=UPH8
-----END PGP SIGNATURE-----

--ey7ko7zyVLfp6lHg--

