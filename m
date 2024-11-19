Return-Path: <linux-kernel+bounces-414796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D389D2D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65F81F23CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5F1D1F4B;
	Tue, 19 Nov 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkePvW7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DC1D1E64
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039602; cv=none; b=EHXr+WAa9LKCxoftc2tMyeykhkWP0zDancQ7vPd6xMt2E+rPWm+WOS5qP9ZUv2kwZHyw2NfVMir5Vme+CH5k0yHZdO6WBn7uCktAR48CQV5YqlZEkXExHlGpbEzKaJ/kvS198CmHXJokm2cA+Yyirt1D1Q7itb/p/+Xv5yoZz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039602; c=relaxed/simple;
	bh=tO29qmXnQBiYVBJ8k86fc371KDYzbkkwm4QvEDUHdCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccywxg/DVMfmP7oLVvGl1Q92UTcDVB9dNnNZqqzRpuT/LgxqPmt5/EZPOYUV3J4tSFyUWrAiav7U01o6nfXxU/MulX8v1yhc9eYHOf+l8XdwpBKRKMaScxxSmHj974M1ZQrEO/jthLnCQbq8lGyODjVv2TfwE320xryrEKC6N5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkePvW7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54664C4CECF;
	Tue, 19 Nov 2024 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732039601;
	bh=tO29qmXnQBiYVBJ8k86fc371KDYzbkkwm4QvEDUHdCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkePvW7xB6nW3N7qHX0WDaEErluJ0FIHbMjXEp2BLmeiZ7iz7X49qEx8DoYHKXeB3
	 7AspRArmaFfzIbeHQcZwr6yHrcGiTqsri2Z0Bj//dZHusfpm6vvHumsS8Xpxn8DitB
	 HiBQDsZAc85cPEj48NrsJ5w1/yEhXHMYb4AnNLk9ckNncpsn8teNRWVhn493t2LEtP
	 G5AF7WCZq9sHmNBem0SipWhf1h2KNpXgTLhDM6vP6uRbDzTJdcSWNnGWkBBM9qsn6e
	 IlMKT89zcJOvdAfhpkXpo4oGMVbPMt6uKIyir0ylmYQxsNB+hHu3IGpPmn2KVEMm4s
	 wBSUHLaximUkA==
Date: Tue, 19 Nov 2024 18:06:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
	catalin.marinas@arm.com, jpoimboe@kernel.org,
	kaleshsingh@google.com, kristina.martsenko@arm.com,
	linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
	maz@kernel.org, mbenes@suse.cz, mhiramat@kernel.org,
	puranjay12@gmail.com, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH] arm64: disable ARCH_CORRECT_STACKTRACE_ON_KRETPROBE tests
Message-ID: <c5cd88f1-6390-4148-9595-07b3c09ab117@sirena.org.uk>
References: <20241118120204.3961548-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2YslX4LOWBeSjJG"
Content-Disposition: inline
In-Reply-To: <20241118120204.3961548-1-mark.rutland@arm.com>
X-Cookie: I have many CHARTS and DIAGRAMS..


--k2YslX4LOWBeSjJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2024 at 12:02:04PM +0000, Mark Rutland wrote:

> The test assumes that when a stacktrace straddles an exception boundary,
> no necessary entries will be omitted and no extraneous entries will be
> reported, and when unwinding from a kretprobed callee, the next entry in
> the trace will be its immediate caller (whether kretprobed or not).

> Recently the arm64 stacktrace code was changed to always report the LR
> at an exception boundary, where we don't know whether the LR is live.
> In the case of the kretprobe trampoline the LR is not live at the time
> the stacktrace is performed, and so the entry in the trace for the LR is
> extraneous. This can be seen if a call to show_stack() is added to
> stacktrace_internal_return_handler():

Oh, that's a bit annoying.  :/

> +++ b/arch/arm64/Kconfig
> @@ -14,7 +14,6 @@ config ARM64
>  	select ARCH_HAS_DEBUG_WX
>  	select ARCH_BINFMT_ELF_EXTRA_PHDRS
>  	select ARCH_BINFMT_ELF_STATE
> -	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE

This config option is only used for enabling parts of the kprobes tests
so it's not hurting anything at runtime AFAICT:

Reviewed-by: Mark Brown <broonie@kernel.org>

--k2YslX4LOWBeSjJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc806oACgkQJNaLcl1U
h9ABKgf/R/7u3P8XFaSDhIfVLJlsf9aPjfGZE00dJ22IL5QHSjG6/EL4j3/zOavI
B9waIUtfSwfMCeOYAzmEvr0lO7owU6ZV86Fc+xAwfA0oZVSa5P3PAwZu9PpF1dPY
PJKWNMS5+09RjMZiqKW4/E/JaL1xaQeMiHDnOUSdv9zazoFifqD9EZbwes3q89lW
EniQE3oD7BcoO0mXnLy6nSlJrw26hpbBzqQrXpdkMmUjErGsYZn/nCK6lC0ONJjJ
wmwC84AOeTJr6l9XPAikDLdrUz0QQBffq3sEnk98FSflhgm0foj3VaxSmaGcdjXA
xWCxzWIvczqUnGO4gsoD8hrq0wrllw==
=lv33
-----END PGP SIGNATURE-----

--k2YslX4LOWBeSjJG--

