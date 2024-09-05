Return-Path: <linux-kernel+bounces-317681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2C96E214
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3506A287738
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8217C9B5;
	Thu,  5 Sep 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt0XZlem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E158D66
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561286; cv=none; b=bHv/b6x9BwlNl1dC2BFlAcCgXK1vo3sW/Sl2SbFzxEi37s9HX3RCb4DPn/CWhQpK9ZARMt1VIb1PZQc758lgoHqzHgi09EjhY6lYfMwcUYD6pIWeYJVR0+O6IUf/EpeVRDRkoqa8W7bTHreFJB0ljMR+mlRK/jLK9tEbc+jHAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561286; c=relaxed/simple;
	bh=0uMROum9XNOcVUAFoAQ36q/ZXRlfEjbfwAOURHN8/vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0E/oorShdwnB4xrfCThFNc7J36UUO0Y4Y5jRFqq5r2eETPqMsNmfJWKS1710KJ1MO5oVd2palwp/kD+nxTM4yxtPrfHVxXbcIPOcE8nY1rZZzL27GCjMH/FynUb/XJywIlVHAuUmAPAwCEMctjQdpItHQDiAEs3Gx4ZNeSqSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt0XZlem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309DFC4CEC3;
	Thu,  5 Sep 2024 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561285;
	bh=0uMROum9XNOcVUAFoAQ36q/ZXRlfEjbfwAOURHN8/vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tt0XZlemqP/pwMc8HWGfFOJ1U4ijwO27JubWSBkHqQg0hNPj4OQdoMjdv/03QeTT0
	 xj4hcwB0T8c95j9/Hla+dPjiF7qGtaGg/Nx1cbKvyUkZYKAtTQ1rmCGZrFrv4k6dID
	 6KWWWIJz2dhlXvuPQc3jBhKzOEdKI15gKtBa4TLV00AImqNOMEdyxEVDxmbUPsxkYe
	 a30m5583huznzJrkUM26ExUcH1LcL9qzW1JipQyWOtUnkUYsMN+B6ZawPmwLeGlYwu
	 gLOjsCYj+9MOd7a2ldlZWjRmeFxTLoJxu0Z3pWjs6NFOM2/aLF5jsBGdtEQrYLKJoG
	 1v73GoN/2uQ+g==
Date: Thu, 5 Sep 2024 19:34:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Message-ID: <8c625518-7f73-40c9-8c91-3a0b14240003@sirena.org.uk>
References: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
 <Zo7qzWVXRWulVtCT@arm.com>
 <Zo8ZDBisWJonBVqF@finisterre.sirena.org.uk>
 <Ztnvosf0JHsvCf7-@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eSpzNz42p2k1tdwX"
Content-Disposition: inline
In-Reply-To: <Ztnvosf0JHsvCf7-@arm.com>
X-Cookie: The horror... the horror!


--eSpzNz42p2k1tdwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 06:51:30PM +0100, Catalin Marinas wrote:

> OK, so likely the state is already saved, all we need to do here is
> flush the state and SMSTOP. But why would switching to idle be any
> different than switching to a thread that doesn't used SME? It feels
> like we are just trying to optimise a special case only. Could we not
> instead issue an SMSTOP in the context switch code?

On context switch the SMSTOP is issued as part of loading the state for
the task but we only do that when either returning to userspace or it's
a kernel thread with active FPSIMD usage.  The idle thread is a kernel
thread with no FPSIMD usage so we don't touch the state.  If we did the
SMSTOP unconditionally that'd mean that the optimisation where we don't
reload the FP state if we bounce through a kernel thread would be broken
while using SME which doesn't seem ideal, idling really does seem like a
meaningfully special case here.

> Also this looks hypothetical until we have some hardware to test it on,
> see how it would behave with a shared SME unit.

The specific performance impacts will depend on hardware (there'll
likely be some power impact even on things with a single FP unit per
PE) but given that keeping SM and ZA disabled when not in use is a
fairly strong recommendation in the programming model my inclination at
this point would be to program to the advertised model until we have
confirmation that the hardware actually behaves otherwise.

--eSpzNz42p2k1tdwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbZ+cAACgkQJNaLcl1U
h9BdCgf+NqcHCZvlXlpmrRcayXw0okot9nB13WCb1eEZBAdP7WAdMtJIWl0Wiys5
UeJyw9Pzxdlpz1RMxuDtdfQZ400It0YJy61q9nk/LQCA2Yt0Ln3fdCy7UFOWVoFt
HIIiCrZxA6JP2tltWF6S4B1JD0cX8tHXb4HEZzkH5xR+CnM4YhZo9Z8hMHTDFDUf
CqV37gQYd9rAagpglLhA4GAVaoa9Mx5CaWY7O865SfR86UarPYzZMS7GdH6oQcqH
rwb0OUffN8AhCENY2bHPlvxS7ruqrtxRPvZHCIWUyiz4ad4aqL/t8PEcis904h92
yEgj/sRKUy5DIdfy/9o2aHvm463vuw==
=Y1lt
-----END PGP SIGNATURE-----

--eSpzNz42p2k1tdwX--

