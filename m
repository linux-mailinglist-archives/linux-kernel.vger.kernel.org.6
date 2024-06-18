Return-Path: <linux-kernel+bounces-219805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C890D7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D8F1C23A66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45546435;
	Tue, 18 Jun 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StR/+jKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6663B79C;
	Tue, 18 Jun 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726342; cv=none; b=soAnWSOKsO7F+RwIWARAwf93rMdw1SZjJWkXS8WhScCUVEQZ0XqORcPO4DZ1ZPRc9nqUCKkZVCQtqFyjZrccFmCofQUgaSBNqF7qrCbXpA0dfrkH/plsYPnWzTs5v9Yob2ceB4LBOVbmsh7sdjy2sBuygXXk+HRXoQdrRN17nxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726342; c=relaxed/simple;
	bh=sz0YN0y0FVSjHDPfeBoW60WGnfjUu8f2okvfcc2MHlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G93wDXOoOQKayBM6VR5xhJPCMT6DQmaxT8dk6GVY0UndIJwMh1fsyae/HypTXDRBlDTFtMOW4ZO3yk9hs4SZs3G4E4t7ZvdijV3VMQDHPzjVQFtC+dRHCC9fZYfgYHn8dW30Ih8M3d+siqeGP43J5Ytmays5EQuAGRjCuXZYwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StR/+jKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B754DC3277B;
	Tue, 18 Jun 2024 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718726341;
	bh=sz0YN0y0FVSjHDPfeBoW60WGnfjUu8f2okvfcc2MHlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StR/+jKUNlVdvEZAmn/erjopL4xhu+f9M29jo/xZNGNAUZLes5ueyFEf1gMbhk+XV
	 A/OMRaMbZclI4zSb+VoObGGIU9Sly4lOuuzY0Vo4APTc+BYcys+o3a6AUEAyfw1B6c
	 BYd24NogKShRq7igav6Al55NjhFOuwBKJpC+yi5Q6rp+N3MFcguHWo9AmXifm2IadE
	 8JSOCNK/bFnnU18Oz8p/kJonak2enuO/3tVpE5tZuPecB/epdOSouu++qPIzxdgRj2
	 JMXTNH1CuD6PVCBaoR0Wwr8nCGQZOvMXXqCC9XE57Jb5haoFnAySEKboYmGbYRHvxI
	 VjLsz8hGzpQ2g==
Date: Tue, 18 Jun 2024 16:58:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
Message-ID: <dfa7d5d7-2501-4c5f-a6e2-792c7aeb9bb3@sirena.org.uk>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
 <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LcvkV2LVLHBdzUd/"
Content-Disposition: inline
In-Reply-To: <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
X-Cookie: If you can read this, you're too close.


--LcvkV2LVLHBdzUd/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 03:33:59PM +0100, Richard Fitzgerald wrote:
> On 17/06/2024 15:04, Mark Brown wrote:

> > Have all architectures removed 0 as a valid IRQ?

> From discussion threads we can find 0 might still used on x86 for a
> legacy device.

Some of the arm platforms were also an issue in the past, though
possibly they've all been modernised by now.  Don't know about other
older architectures.

> But the conversations we can find on this don't seem to exclude passing
> a negative error number, just that 0 can normally be assumed invalid.

Yes, the question was specifically about the assumption that 0 is
invalid.  The status of 0 is kind of a mess, people keep assuming that
it isn't valid and it just depends if users of platforms which try to
use 0 trip up over it.  Sometimes people work on trying to eliminate
uses of 0 but it tends to get you into older code nobody wants to touch.

> The kerneldoc for SPI says:

>  * @irq: Negative, or the number passed to request_irq() to receive
>  *	interrupts from this device.

Which includes the 0 as valid thing...

--LcvkV2LVLHBdzUd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxrr8ACgkQJNaLcl1U
h9DcJgf/besPBBSWE+U9Elv/LY0aj6BtDK56+ADVsywz9T5PWa+Vba1Eetg1r+Dv
uvxXRyuNqT05o2FCB/Y89gVWR198ikoYvxVn+GtPjo56flVshC2trkVNgN5FHqWK
i59G2+xwbiwQM5rMCQhc5ouej7zVrw80AqWNTcIV63BxoN5gh8zWONukbyjwKAUv
tJblecSBXxpbeI7JwiJR32L9IS21nzYwF7PUaBLOBK0Q48Y+iU0U/5hWLnleEAww
XCIvEHYjv5/RXWvaNNIowJOMdytuluhi9/4JsJ1udUzloqYbFlNZ1dF0v0LsEuRn
abuLr9yaB1q2yJfnXOJ+KSWYIlnJVQ==
=Tyb5
-----END PGP SIGNATURE-----

--LcvkV2LVLHBdzUd/--

