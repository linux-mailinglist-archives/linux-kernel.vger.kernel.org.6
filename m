Return-Path: <linux-kernel+bounces-211339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D25905044
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140CE282B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299916E89D;
	Wed, 12 Jun 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQaeT1AB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E616E877;
	Wed, 12 Jun 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187543; cv=none; b=PwM14lxOug5Y7GLuas2L+o7DpOlF/nY46FQkyaZjpXRLxc1w4R+nW0EvPD57c8X4Z4CcBRZrw+qlCHmxkxjNZ7yrdZxIRkeC04k4qtfO1kHB2uSb+3POUK/Z1HlBX5i3EOx/2Y5TXfRiw93O62ooqekEwqw2zjL2qkA5jAb7fYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187543; c=relaxed/simple;
	bh=2pp2Sjb/QpY6CgP8p3SLRpy7RO9RffL4SAxvnbN455c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIbfULrdJblwflP9R7h8aSadr+bxHYX2ntVBzOuPCfXEMQVWEVx/+0l4uNNYG9ELcvflv4QDgrHlk62pi2Z7WOFGk1/LBfIbysXCzfuw5Eq6cFMs7zVAPqsuewFacdC/Xc9bYxqBJLAcNBSjUjp85cxP0GxSL9lAulCbIbdptRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQaeT1AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E53AC3277B;
	Wed, 12 Jun 2024 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718187542;
	bh=2pp2Sjb/QpY6CgP8p3SLRpy7RO9RffL4SAxvnbN455c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQaeT1AB2uRS3lhsBP8uQkQ4JQbcRrG8FBYSN6WND1PvDdutv63iL/30vjpoarwDA
	 jumJQxTptkCnEY1ju4t5glnKEQ91wbDDM0W5QjmkTocssrmRWfGn+KAlzTvs2R+OCz
	 yfav/WhF1FJvO+aocqJHT66kZu/kThh+LEGgQAt7QyDUXb9ZF/I/eegRjeXOElanr8
	 1HrfocH0E8rg6lsgXqqfXJzLf0mAZH7UMfeUyQbV9JEb3FnGUmPN79VhVj+apzZwdv
	 mifB928AonFd79TrNADuo8gFTvbgpbEF3cSYYw2nIBaqE1Oy1c6zv7Vk5tl3y+OQ24
	 2KtQtCw5zs+Hg==
Date: Wed, 12 Jun 2024 11:19:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI
 is hooked up
Message-ID: <Zml2FfjbO4Vgk0jy@finisterre.sirena.org.uk>
References: <20240611145746.1454663-1-rf@opensource.cirrus.com>
 <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
 <36219997-397b-4a26-96ee-7527fb6eb024@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZyARGDXRBReq3B2w"
Content-Disposition: inline
In-Reply-To: <36219997-397b-4a26-96ee-7527fb6eb024@opensource.cirrus.com>
X-Cookie: Your love life will be... interesting.


--ZyARGDXRBReq3B2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 10:19:06AM +0100, Richard Fitzgerald wrote:
> On 11/06/2024 17:12, Mark Brown wrote:

> > This doesn't seem particularly different to any other unhelpful chip
> > default, I'm not sure why it'd be so urgent that we'd hard code a

> I'm not sure I understand the objection here. Are you objecting to the
> patch itself, or that I marked it as a Fixes?

Both I guess, but mainly the patch itself - we generally have an
extremely high bar for setting defaults different to the chip defaults
to avoid issues with differing use cases.

--ZyARGDXRBReq3B2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpdhIACgkQJNaLcl1U
h9Dpngf+J2Jih6an19izkqDx/DWBL+NSyvVWEBmPw/+20KHVMdXPbMmyFH0ncfiI
nVtt2Ojsf3LSykVxbutLUD7GfB3xrSICPfwEbgVuPuW9RQ7bxSz7y3YkIjSl6TpM
69xpoWaTLRbfN8UuXiDT7wcjGFhGLHPAgSlet+K1uJmSaSVZE5eR5ELfhjLrszsv
ic47Dn+txdqx2zfr+XKqBfJPk00mqGfRyOcsm7HMIi8L8tz1jIU32uagmgzEd61r
qVE0RB0DwCREK+AYukDi4+aVsaYHZRhpjLI+R5c/JKpoLRigvlr5UJ0pd9+GtUB6
PHV59zLfLQEvU+SyaON1qUDB+aN/bw==
=+MLc
-----END PGP SIGNATURE-----

--ZyARGDXRBReq3B2w--

