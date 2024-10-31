Return-Path: <linux-kernel+bounces-390895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B69B7FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF32A1C219CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869711B6541;
	Thu, 31 Oct 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOcBTstv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C11386C9;
	Thu, 31 Oct 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391433; cv=none; b=Dk+VkOao7PW2RDTDFb7zOEhUu86RlsYGO2NaGZPtHKaxWrsGeL5Zh4exSF6sTE/nsuKebhyhy5cxdmPNv+DHo8t9p0KHQEgpC3zTsCmtVg+04Mb/MkoYHw2yV+wEaA3/5kjjMRrpep1lqF2ETOTNIhsqpdNGxg/87IU9RHySxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391433; c=relaxed/simple;
	bh=GD77o6wDWPVJSdV448NuijMv5dO/BCfKcwYpRdlroN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foyvrIOTexnN6pSpOYmX4V9GR+FA2NXuYvOfFWDHxEhSd4Gvaj4RfdFpjCeb9qRLTn2TgNoWeU8/gJ2D81A15Zj6XDrd/22M9yx1KOvMypUN750OEUIGL2sJmLgGRdJw+CCI7/JkiETgP5UQ/iFOcqpcO8Sk0H/XHc8mLY4ACDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOcBTstv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBECC4E695;
	Thu, 31 Oct 2024 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391432;
	bh=GD77o6wDWPVJSdV448NuijMv5dO/BCfKcwYpRdlroN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOcBTstv+fB1unmrew1x98bsx53N5gvm0tay5K48wwsIkLSSIALxL6EKXP2ynRVs9
	 5uIRnumUYr8mIL1/W1wkpH0i34ncXrcalrbOdRe9xughOFjP2zFqEaHtXi9XtFaTCD
	 eYITWcRCCHdRHaipW0xVmwznJIPbvJIMw0b2RrSKbql5KtpQv1uf1IkQJxtvNkuSYH
	 s2pk0SuRyuDN0adhYXBHwq8yXo/V7xGi8dFtJ6JcAjBcE5mpQhbucTlIwj7ES5iG8e
	 EP2pKl4dnVu0vJGhZZPrHMzavgwXCjynpRV334NtMML3mjczmbew97Cb1/h+QY2Hh6
	 ZhMWOsQ2WZ7Gg==
Date: Thu, 31 Oct 2024 16:17:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: fix uninit-value in i2s_dma_isr
Message-ID: <d97a58c7-347b-48f9-aa69-d4ff5a4038e3@sirena.org.uk>
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
 <635f1691-74e9-4e48-8ebf-8e7ce0c6d1e3@sirena.org.uk>
 <a4039ca2-6c76-4431-8e27-caebe1a56deb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e/Kq205jgHuYrXyw"
Content-Disposition: inline
In-Reply-To: <a4039ca2-6c76-4431-8e27-caebe1a56deb@gmail.com>
X-Cookie: Make a wish, it might come true.


--e/Kq205jgHuYrXyw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 12:17:56PM +0530, Suraj Sonawane wrote:
> On 30/10/24 22:44, Mark Brown wrote:

> > This will shut the warning up, but why are these values valid?  Are we
> > handling the cases where the loops do not execute properly?

> Thank you for the feedback and your time.

> The uninitialized warning for val_1 and val_2 arises because, in some cas=
es,
> the offlevel value is zero, and as a result, the loop does not execute,
> leaving these variables potentially undefined. The subsequent code
> calculates prtd->dma_addr_next using val_1 + val_2, so it's necessary to
> have val_1 and val_2 initialized to a known value, even when the loop does
> not run.

> Initializing them to zero ensures prtd->dma_addr_next has a defined value
> without triggering undefined behavior. However, if a zero initialization
> could cause unintended behavior in dma_addr_next, I could alternatively
> handle this case by setting dma_addr_next conditionally when offlevel is
> non-zero.

This is describing again what the patch does, which basically just boils
down to shutting up the warning.

> Let me know if there=E2=80=99s a preferred approach, or if you'd suggest =
a different
> initial value for these variables based on the expected use.

We need to understand what the change is doing - what do the values
mean, is the real issue that we're missing some error handling for the
case that lets us fall through without initialisation?

--e/Kq205jgHuYrXyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcjrYMACgkQJNaLcl1U
h9CviAf/ZGEEcO/JvFeZxfdjosIExKyugcJouP3kA4Y9MyFwuEsG/u4JbxzJIbeY
m69cr55NfPfiHOp21LOSK7ofb4f5eLzkWvHNyQRu5criru5UmmkWMjKh189QIQ+L
aAGuehlFs9S6uW9Jy/He+R4lGfA2nxxMvG/BP6OR9Zi8cR8LIf+BE+mh7wTB2kkT
blCjH/VRW6fCQLofWfzDy+VfZOkgNjg5ksVV3qRNPSy5t9Go6lC/0OWObLHrSX0f
4T1XHkESFlowe9w74fd8WcemXWOlP5irCpYHCgew7LZ2Ig31azYHt3IlSvR1jDbD
y9Bo6tVEJ4eHfF4/SMd1NeVhq79t2Q==
=MJU1
-----END PGP SIGNATURE-----

--e/Kq205jgHuYrXyw--

