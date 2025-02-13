Return-Path: <linux-kernel+bounces-513243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C716DA34565
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BA616FF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFBD15665C;
	Thu, 13 Feb 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJuraUwo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F626B0B1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459223; cv=none; b=GWBl+UZ6tt8EWftC5941St64gPS8YP2HEeuPQaQC+oRwkdBLO2v2wWTR05W/gX1QQRoobDxDYYUHmEGgD2bj12asxGhvjgMo23/bqXfaT246BqypLUiFW85qI2h+s6PojL0KyW4aV8NmciaVSHqnH3T9Z0ockC1FQ6ZrIXjjifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459223; c=relaxed/simple;
	bh=Q7rSdhDrWhU3f+iWldWt8i1V01SlA4A4sVANfLGnNVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMEqAVc2QxtNaqGwH1vbWjJgrowB7JritB0Th/vrcNnFuIZd2jr1bjVfA5vLI1QL8lUVLWiNnxHtshrcR4lWtmUeYqV3pAutKGFhMAvJOocZC12m6rdmD/f5jSlrS4J+Tfge3xuSFNwjjYkpsu+xLvOTG3Ux6OYiFTMoLbCCx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJuraUwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED464C4CEE5;
	Thu, 13 Feb 2025 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739459223;
	bh=Q7rSdhDrWhU3f+iWldWt8i1V01SlA4A4sVANfLGnNVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJuraUwoRiOIFuMjGU5Q3TKICE2WUwyNz0sJjf+gfjbiysYCFTSSEfFOpIS16hFiA
	 lgAKUfgoZrq/6YopvKpoPeQTtrE0k0bb7MuL3VdRpSROjAKvA9JtM/bx6oP3ZmanH5
	 2HdwaYCnwz4EHnq31kD/Vp07cRqskbABqn1f7ahK8ac989QcL4R5d0C0o1pFID91XE
	 JT0mF4SYc2j+5od/ivmpp4j9pITdiL0/4FLlhENSPgjX2z7B1oAgf30u7Tbtb6snbt
	 UsiLFMVf5uUQnGcbkYFzKmVgZdgDr7PYBNOYXkLG1nu585MU8lHS9ykIYgpd8+98od
	 B7aMa4xex0Xcg==
Date: Thu, 13 Feb 2025 15:06:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
Message-ID: <1e251815-5d58-436b-9120-e88f75a7ecaa@sirena.org.uk>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
 <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="petKQvVFYm+g2Xev"
Content-Disposition: inline
In-Reply-To: <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
X-Cookie: Take it easy, we're in a hurry.


--petKQvVFYm+g2Xev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2025 at 02:28:06PM +0000, Richard Fitzgerald wrote:
> On 11/02/2025 5:21 pm, Richard Fitzgerald wrote:

> > > Not tested on real hardware.
> > > This came up while porting kunit to mips64.
> > > Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by

> I would say that is a bug in mips64 that should be fixed in mips64.
> It is not reasonable to expect generic drivers to have special cases for
> platforms that don't handle GFP_DMA.

What specifically is the issue?  If it's a build time issue I'd
definitely agree that we should just be able to assume that platforms at
least build.  IIRC there is a Kconfig you can depend on for DMA but it
seems more trouble than it's worth to fix all users.

--petKQvVFYm+g2Xev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeuCpIACgkQJNaLcl1U
h9D19gf/Rx3mROu/ZxjTGUKa9dJPNAFFzkay11d/PJqF5yhG0DRnRN8itRfsyLtU
RwfSxBdjQQv0gY/dI08IJsLGW/HhGodM+Am6g7hRwfvC0zXwYqjk7S9vsJASMJqD
DXCcu2nLUTIwm19DhCpS62QNIJA65uORQ42Ye+vhK7UkGKBqoS/M+f5BQNfQlRBm
6/GRYVjuKpDcP9Q2APNDpq4m4VvmS4AsUkJhEMkTpICvC6nFR2QJ4PwjVL4HSWty
5Zs+ekODituDKOR6TgzWUXeZ71HqJA+bbz4YtrkqcZhcmk+SClG6ifalvKYThHz9
b1gsCJH3fZHgCOHhMY4TtV70qYkzlA==
=DkFD
-----END PGP SIGNATURE-----

--petKQvVFYm+g2Xev--

