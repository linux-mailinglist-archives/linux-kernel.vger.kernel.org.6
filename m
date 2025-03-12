Return-Path: <linux-kernel+bounces-557710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BDA5DCC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DD37A40F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A5242909;
	Wed, 12 Mar 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcMq3x2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD21E489
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782881; cv=none; b=OkEhMTwREauzTl2F3VKStKKMiV1HPNusT8WPBNHAuW9Mq1nu+Xw23Q2xiM+NJzz9Zi+4S8XwxhCX/x/fHIbMxpMznMtspDiYCCYVJzA0RsOiKDkMa5xmaivvK0agpo8/m5MCjO8SBIh6GgOv2LRGEl8/7YiJbhtEyGXk/CE+V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782881; c=relaxed/simple;
	bh=z3lAKg1EBo5CrGDmv4+82VtP1/Cec7fMzvE95Lww3OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVw2qJDFsYKtu0DZeQ8Nai1n9bCeft4zISUAd5o85UZR96dvnA+6c7/xoyWSE0KSzZvZUSCfX7Nso87eBz0k2014SbKpywT2RRJTI99Mgno/JA2nguEpAqH6CHS6EzPRf5khDJ4ClfGqV/fT086taiW5RXbnCxSHDZVKQOwNncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcMq3x2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAECBC4CEE3;
	Wed, 12 Mar 2025 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741782880;
	bh=z3lAKg1EBo5CrGDmv4+82VtP1/Cec7fMzvE95Lww3OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcMq3x2mcsT1/IhZZQGtJLDE187pAyU0hqHsMI5pz28uEJRXIZPmzhtdz9uEBnuAf
	 /bjo9EOJyibrIiDwD4tvWDcpEzeedt7bDQ1evAYi+NdHBwJg6A9WL6Dz+AoUa9np+i
	 7YwR32r8yAR1tRv38P7OSTIcNggqVR0TFyRGE9/4MMmAyzYqW14p5ryKiVhsa1zXjQ
	 4CQ6wPI45w/WS4H/Y3xuYIhfpN5uOo18YQBMZZslTA/mA+JtmSHegxR9XcHu+bn67u
	 Or3WUBaAC7WP5Y/+CdQcjOS/icObs7dhgrle1718DOQTBP+iEfcJcUrTHnQOF1nVPM
	 qbV0K/oHpPHFQ==
Date: Wed, 12 Mar 2025 12:34:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] regulator: act8865-regulator: switch psy_cfg from
 of_node to fwnode
Message-ID: <4fd63a7e-e22c-4f7e-b6e4-25412eaeaebe@sirena.org.uk>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-2-d5e4369936bb@collabora.com>
 <clovsoj2joegkabhzsbjre5adj7qwo6vmf47urnam6xnlh3cm3@jcitrknzomvf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TaioqsGsno/YeuoR"
Content-Disposition: inline
In-Reply-To: <clovsoj2joegkabhzsbjre5adj7qwo6vmf47urnam6xnlh3cm3@jcitrknzomvf>
X-Cookie: You will outgrow your usefulness.


--TaioqsGsno/YeuoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 01:12:14AM +0100, Sebastian Reichel wrote:

> Can you apply this trivial patch for 6.15, so that we don't have to
> bother with an immutable branch for the remaining series in the 6.16
> cycle? In case the patch itself did not reach you for some reason:

I have no idea what the story with dependencies is here...

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--TaioqsGsno/YeuoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfRf1wACgkQJNaLcl1U
h9Bf4Af/Z6tJrpuOBCeHF0MpQdokzHgfbQAHKKr4fBN5OGzwERLzvuwxjiKWL6aF
jcsxMffqa7cYPpVmxMRZYUcWCP8JPTbp2Ci8F7noqn+nxoDf7kjFgQdC1UG0f1xx
tthMY9RslcgtRPRi4odbiV8r1XcDv5LS9F5zKrLPYuLCgaDtcGmTMT34b0d3p8XY
fBlOwM9Q8mFHxRXAP+m+3EkKgQhBYtCwxXemnV2uGZYB7rlHm28IP80JURC6iXcj
aKsTOGeJOoyqMcL0lcPsazGUeQROKCRM5TssjMCXyEe7w3tbiKuAZNxkDx5Lup59
oPgi7GReAyHxScjf9SSdxG8NKDRDkQ==
=rntj
-----END PGP SIGNATURE-----

--TaioqsGsno/YeuoR--

