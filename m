Return-Path: <linux-kernel+bounces-304877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE32C962622
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709301F2498E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CECD1714AE;
	Wed, 28 Aug 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1a0uhad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244316D321
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844777; cv=none; b=N3NaK5Z+TOIcGg57oS+r0vMYCVvLQDnDjmfi3Q6Iq+CoumFPZ2cf11miU0nef05pfrpka7g4Wrp+eRbjzwWLoRm2shvRzQXQsYHVSCUAdYIvvAPYiZ3jUPs2VMsBRm370moa764kannWNBtyi50Sjk0JMCQUS3ETG+UZ10cT6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844777; c=relaxed/simple;
	bh=XIqaCe+46C67npY7smvqvvMdTwA1I4wQP7hnk8kfe5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZTdrA4VWd2Rgvav8o9ppFIKUA/h8UmJYcaiXeZ5+20FINZp/MJQpQMdQYly27U5lfMmdux0nspT4lLfhjeYt+/Ul8xoYj48A2IAecDG3sYKifxabBi9FztkHOllIc3rIHJEwUCbimZUUmETcFEDEK+Zoa9l8fYqJuas5n4DdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1a0uhad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDF1C98EC2;
	Wed, 28 Aug 2024 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724844777;
	bh=XIqaCe+46C67npY7smvqvvMdTwA1I4wQP7hnk8kfe5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1a0uhad76ZS+0V15BQcZS2cIH2hjae88F9/Ja0u6fFC20PIR+rRi5Sn9crynr/eI
	 yJ7AMXiKyGxB/InpJKnUWxVpFQ+/BKvpRGdn19qnxnHOhp881cc6t8z73BdRNUWZVc
	 ArJc+UHmE5zAVUfMwRJHgk/z0w3Fm1bzvgYlvHexsz3Bf33sI5f6/POfARDJESkVO7
	 zIZvHKtCSO8f6MVprppB7C6q0/BXv6BonNg9NxBTe1aTvJNKyCD8Wu6nn3HhFzn79B
	 Y36cQKtNVIBz0FFHAa81hN3T2KcCeLol7wXnogQWC6Bz8+AWGMxQdaWboOlDUqMgs8
	 E5e4lPB98dbRQ==
Date: Wed, 28 Aug 2024 12:32:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] regmap: Hold the regmap lock when allocating and
 freeing the cache
Message-ID: <1c717eca-c763-4fd9-9b79-3ec307c51dc8@sirena.org.uk>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
 <20240822-b4-regmap-maple-nolock-v1-2-d5e6dbae3396@kernel.org>
 <CGME20240828100239eucas1p2afc0d3088c66468061baf81c5676882a@eucas1p2.samsung.com>
 <8303f283-d60a-4840-aff2-b486d6a9774f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zufbI9XVA9tXuK/"
Content-Disposition: inline
In-Reply-To: <8303f283-d60a-4840-aff2-b486d6a9774f@samsung.com>
X-Cookie: You are number 6!  Who is number one?


--6zufbI9XVA9tXuK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:02:38PM +0200, Marek Szyprowski wrote:
> On 22.08.2024 21:13, Mark Brown wrote:

> BUG: sleeping function called from invalid context at=20
> include/linux/sched/mm.h:337
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 157, name:=20
> systemd-udevd

Please, put any actual content in your mail *before* huge log spams,
especially absurdly big things like lockdep.  It makes it very hard to
find anything you've written, I very nearly didn't here and it'd be a
lot of effort for me to wade through all that text to find it again to
reply to the mail.

Your patch looks basically fine but should use alloc_flags.

--6zufbI9XVA9tXuK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPCuQACgkQJNaLcl1U
h9BzkQf7BbQw6vzWI3PFPDdOzWT9gF1NMlTaTTVluWa26DFiD2ovgQ36SgLSjdoV
lOWbpYHiYhX1Jqs5TqeMEtt+HowW9XYLma+QOrCMXGkDESHHpatRRIrkR4E+eXU/
EZSOAoAasevM9vGApt85PTzsRbPJOkWlFCcIx3N/Hh7E0k+hWgw6EHYzkzam8vvk
bN1RHCBNY5ePRMNWllNA7EuZnhg9UKvDzTKBx51dDcruHhgQO8Bp4GYwmN17qLOT
XzPwHKtm7aWmbZ/sYY8SoZEfNJt12w7uqmK5P+2PROtoLzStRshBpoaVcx4XNKM2
OTf2eTd7bHcmZNkKIxF7h8jvKUGHNw==
=Qosc
-----END PGP SIGNATURE-----

--6zufbI9XVA9tXuK/--

