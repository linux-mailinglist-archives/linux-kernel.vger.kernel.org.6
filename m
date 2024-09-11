Return-Path: <linux-kernel+bounces-325105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7297550C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039761C222DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E5199945;
	Wed, 11 Sep 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATJZvCTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C111714AC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063959; cv=none; b=BT0B9c3ijybhLx8mTb2jr4Vc0RBap5HwUcI1OBLO7pfaJqHq4xrZfH6gNDKMsfjldK1Gew4K+8dIwX5Tm+P/w84faQQvyV0C24TGNgMKg1+qL9lNtJofULQBwYF0GyPNFhqg0ZJlRJJJZyOVaQAEpbZj/COsxvrvbn7lwJ/TsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063959; c=relaxed/simple;
	bh=b5WFAZnNM5N7sAM5gpTtc5eLCFkQcgSugQ8c0hlIWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjPbJpcaqMICb49VqmYw/AbM98tEM+jBO6wCBMBB0hjO2d9BDHaqiCcSQ+k+YaiOkBLCv2UjCHMQfPMYUDMbeAYo9iY9qvzyoOHpK5h8SUkec1X6qlL/gHnhCGhAThsWTmjuzqfF7T8wOLCFlYbSgwsa+d5p+WDhyf0dtPdXhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATJZvCTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB67C4CEC5;
	Wed, 11 Sep 2024 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726063959;
	bh=b5WFAZnNM5N7sAM5gpTtc5eLCFkQcgSugQ8c0hlIWF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATJZvCTi17jtTtaUPYBie2U5iEeUIb7YOe43/JHLa3hlAU9diRmSzFhBnkwJdbvDD
	 1OQkHEb363J6B1t1X778KGsr3njZ7qFAs3cYOOoLsufxbzJOh0mz/YInP8HJRxL45b
	 mFg7u5lLlwKVE7cIzV5xN+hF+CyV3orpmfxL3RTJqHl/lK2JrDz4KbhFT+IMwFzWd6
	 L1x7Nt3QYkwl91A5I9vhtC6T2WN+N+qt5PfgBDVTogF0XsUNi6PCx/geiJWKMSMCF+
	 3Fe1BQB4tpQzZ0ieN9EDY0/0WI1D7JfcsL++fjPEpV0bL03su46fcwWC+7qUK/WMjg
	 r/WKobPrk9aBg==
Date: Wed, 11 Sep 2024 15:12:35 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <8d4c1292-1e4d-4d11-b6c2-66dbb5aedb6d@sirena.org.uk>
References: <ZuGcQnzUev6eAy0w@zx2c4.com>
 <20240911133745.3124327-2-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ExFud+TJJYzsql5"
Content-Disposition: inline
In-Reply-To: <20240911133745.3124327-2-Jason@zx2c4.com>
X-Cookie: No Canadian coins.


--2ExFud+TJJYzsql5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 03:36:32PM +0200, Jason A. Donenfeld wrote:

> It's not correct to use $(top_srcdir) for generated header files, for
> builds that are done out of tree via O=, and $(objtree) isn't valid in
> the selftests context. Instead, just obviate the need for these
> generated header files by defining empty stubs in tools/include, which
> is the same thing that's done for rwlock.h.

...

> I'll replace the broken commit with this one. I've verified the
> kselftests are fine now, particularly for kvm.

Did you also check perf?  For arm64 it uses the sysregs values though I
don't off hand know if that includes any of the generated values.  I
would expect that KVM will start breaking for arm64 at some point even
if it works for now, there was a desire to replace use of magic numbers
for registers in the tests with defines.

--2ExFud+TJJYzsql5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbhpVIACgkQJNaLcl1U
h9D8fAf+MtSHlAONcSmk5pNsJLa8dUzK7MqVVNAn71DCRbSZ3qwfPzhe4BuwGBCR
w4CoAhlrYDZGW3pDcqh/0q95fjUc9FtlaQSnG5cmVDX4sqzp9wsgrrCQaDKQAZnL
htxNYCyttfgO+9d3kLZKeBtZdd3g9ovGUszv0Y3uXqrAmogNcN/ct6TXE/bCFl9f
6irBwUhbNQqfrj1mnc1gxyHQT3+fB0I/tT6ZbL93iAPOePMosw2NALs8kjyEX6Uj
9ubYnfquiEJPIggsg1SN62lKaYZymhIVIXvrbWU1D9FmJZS/m/9InQDG94Yqw8YY
o5gHulDDg7XiaotX22p7lKQRXTRZ1w==
=fHPp
-----END PGP SIGNATURE-----

--2ExFud+TJJYzsql5--

