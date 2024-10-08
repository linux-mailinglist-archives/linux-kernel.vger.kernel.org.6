Return-Path: <linux-kernel+bounces-354931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444659944B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC74E28780F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869118FDB7;
	Tue,  8 Oct 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGo0ktr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECD17E006;
	Tue,  8 Oct 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380903; cv=none; b=bd2gcdnQt+by8KOOq75OSLMdYjc0zoohNq75/gTeDbYvZJul2zFJ3QGG6zGk//kA9oEc05wYTUiS+BB0VRQ6pEC6I/DjzsL/fAkRZDkiz7/mfoQ8op+NLRA3g/qNn/4UoqFIPMF+LRNUYTPVcgV2CMEntk4BHyfFDEIFol5bt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380903; c=relaxed/simple;
	bh=l4Y9THIVPzwyqMgIc7iT3tF4rTJpadb0M743GNCqZpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUhOOyofDrBDEhbsiGi5X60O9kJKQqRN/11asSDvGaEMFWZZ+qiZOPdEu351SeuGlnxnDdh+RlEVX7sQPivpfAJVrr2aHGWQtYRKSwOfJqMDCL35zCl5Gh8gQgV2C/D1Pbhj5Gviuyd5aaNH/uhJf5TyE1+FuTBc/sMe7fVyhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGo0ktr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11833C4CEC7;
	Tue,  8 Oct 2024 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728380903;
	bh=l4Y9THIVPzwyqMgIc7iT3tF4rTJpadb0M743GNCqZpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGo0ktr8QOqi2g2d6POyu07tk71AZLJaotZalr+y8ao1QqNrGrZoOYy1gyjwLI7MS
	 yVxUqvsfAm0J2DM9Xl4BWJS8mDMaDimTEBs2CZG6jJ3+c+lKeinK7O7vyxotjDIip2
	 x/vZ1OuwUkGLsr3xLEz1IwT1gPkul9fVhDS9nzXsojDRczq5/XRvU7EvnhcyBj5FEZ
	 8BUBABPtmbRA9KbJXdCP+tFTTQ+a0KQNiShfNErOqNTdIjvKrxvEwgvEPvjkoXUD6J
	 KU57UZNUQXwOnbTNcvhZlD3KdMzCYHybBKggjzgsssETg4RnepSn0Ztu2yJ9oNE1H6
	 s6c05UI87VpXg==
Date: Tue, 8 Oct 2024 10:48:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
	andriy.shevchenko@linux.intel.com, heiko@sntech.de,
	kuninori.morimoto.gx@renesas.com, nathan@kernel.org,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH] sound:aw88399:Correct error handling in
 aw_dev_get_dsp_status function
Message-ID: <ZwT_4ppnigehhlKR@finisterre.sirena.org.uk>
References: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jUuKGvrJBJd27UEz"
Content-Disposition: inline
In-Reply-To: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
X-Cookie: Editing is a rewording activity.


--jUuKGvrJBJd27UEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2024 at 07:59:23PM -0700, Zhu Jun wrote:
> Added proper error handling for register value check that
> return -EPERM when register value does not meet expected condition

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--jUuKGvrJBJd27UEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcE/+IACgkQJNaLcl1U
h9DT1wf6A0hvMJChLn2kYhJvVWkNhn11a6nicJZqy+vrYqMdf6TD8lX0BbewGEh8
nCTdtf3JO9wBMmEwshDiqN70wP67lQJi2qeBt2J2qTzbW8KkEt1ukr+3NKAy9FPo
GNCUjLCgWzY4ggUyELMemk/f5pv4T16vqyg6JchOr/t846wpZb6WC+BTK5C9FQfP
fknQftUof9trlta1ulMDWkljvGK8311QjlfcQ7BB8TfbsDHdyc6TImMuwvaEOuM2
7f1hHUFdXsRN+BQz9SNEiVy3aYxkvQGnmInUaITpvJmPTC5LAJom4LVIVB3RRXQe
8lcLqGb5zwhGXjPQVqli8RT1kiJyqQ==
=fHRi
-----END PGP SIGNATURE-----

--jUuKGvrJBJd27UEz--

