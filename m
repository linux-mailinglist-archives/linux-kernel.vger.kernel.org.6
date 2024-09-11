Return-Path: <linux-kernel+bounces-324661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3147974F70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9981F24E18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234A181B82;
	Wed, 11 Sep 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqc5I8d8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212016EC1B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049653; cv=none; b=lLWdCrQSivR0FqDixLU2JBe7X1FpM8A7am/OBWk4ja3Urm4ydL/4kiF9fZu9KJBTNC0zKgJXiUJil4mP+8P4vKMxBilGFe1YyhtIX+SRs6A+1A+CpXh5KYaidf4+8q7/apL59va5adNbW+taqyI+D0MOVbiIfplxuTjspLV0E5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049653; c=relaxed/simple;
	bh=iargtGvZZ/wpkoshheDBIijiCYuu3qJx/umc2KzgDP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQyTK71k01soS5Gk4+sjiGt8Tcfh1Ko+fJCpLlay/oxIRrrxLsGypo4wtVfZIebWStW8lFofVOCh5NLhO8j3uY+jKGJMv4uSYIsSeoOrDOOU3jNP8A9Ea0cZxUCtobcamx+gRtut9rb+VppkD3AL1yx97Xx3V9qC7J7BqGzX+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqc5I8d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57371C4CEC5;
	Wed, 11 Sep 2024 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726049652;
	bh=iargtGvZZ/wpkoshheDBIijiCYuu3qJx/umc2KzgDP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fqc5I8d8/dUaI/GicAmYwRoiyG5AsQ/NdZ5gMyvcKkhLaHmsMNE00YRMwKel128cC
	 ECgJ4m/RtwIkG2dFeenG8ku9SYIfgzZFUuaJ5AZNEWqYUwASnJ7kyCDkym4Z8Bg7pG
	 MBhcyE8b/mG5MZTDKLoLDklpyWRuKC7K0PpWxn9Ly48tcAggDVZhAvKklm7qO9O0hR
	 5S19r3h+fRcgkKiNCOdMDrQR1CTT9zzrkA9HMLINWaFzU60GAkpPgYiZsbfqXFplkX
	 mIFmg2AABxRXF52dSM+B0MO9391Wwoe0n9Qw5fnIFU+PAeg89ljMNkcmSlPjTuH2Ql
	 aL4TeHSJMdp8g==
Date: Wed, 11 Sep 2024 11:14:06 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <974bdaba-6f99-4275-8b4e-f3e95d273ddd@sirena.org.uk>
References: <20240904155817.1153783-1-Jason@zx2c4.com>
 <fed980be-5082-4454-b696-6245d6a3d265@arm.com>
 <ZuEEIIV-J0mQVKE4@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2+Uk9uY6hmbgyuH"
Content-Disposition: inline
In-Reply-To: <ZuEEIIV-J0mQVKE4@zx2c4.com>
X-Cookie: No Canadian coins.


--t2+Uk9uY6hmbgyuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 04:44:48AM +0200, Jason A. Donenfeld wrote:
> On Tue, Sep 10, 2024 at 11:52:51PM +0100, Aishwarya TCV wrote:
> > make[4]: *** [Makefile:299:
> > /tmp/kci/linux/build/kselftest/kvm/aarch64/aarch32_id_regs.o] Error 1
> > make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/kvm'

> You sure this bisected right? That directory isn't related to the
> commit in question, I don't think...

I eyeballed it for Aishwarya and it looked related on first glance
(messing around with the generated headers), though looking again it's
only in the vDSO directory so shouldn't be messing up other
directories...

--t2+Uk9uY6hmbgyuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbhbW0ACgkQJNaLcl1U
h9CavQf/Ztl+g2X/xe1K+2I9ki/XxFcAd0Y66JFpz/QEcU1o5FkGdtvZCZJ5XlBP
kjM6uBfDPHqx2Kwpo34VeVpx3da/Y1kKb0G0OdajpcIIpnbRFwvOu05vq+EmKddN
7Rm0LQfpkA0FD/nNH04KsUcB9j4PZZU7hbiKM0qzhtdGy9rBk8wIuNF3X1fAJ/Sr
dMWz2E1cHOPm2Z72FbuDC72a30A9yLIXmKB8A0e6POhEUrYphyJVJmHX/DU7rEpl
WUWJfFNmEYxZ4A4DxWJ0cwQChmbew4Zh0hhAgPJGlW3GdzcRT1uEWfcb3InzcIR1
noSjzNpRWF9fx+thg83XtFV2I7T66w==
=Jgpi
-----END PGP SIGNATURE-----

--t2+Uk9uY6hmbgyuH--

