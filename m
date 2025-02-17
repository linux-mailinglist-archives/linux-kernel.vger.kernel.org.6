Return-Path: <linux-kernel+bounces-516868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC61A37912
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BF61881F04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09216433B1;
	Mon, 17 Feb 2025 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0g5H7OE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDD2C9D;
	Mon, 17 Feb 2025 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739750449; cv=none; b=aDEEzM9WEanNMeaOpMWRObcBef4+I8GRaOl6fLgvx5P+H7lycxVH6CKcCdTApOavYxnHNnw+54UsM0vSsGzqYKJ7KKQrAUeTUj4g/pSusZlxUIOaSj8/YHbqrn0cdvl6jml1xhzpGLnAqVE8xrT75z9fAiuYyar3XAMV0FY+ICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739750449; c=relaxed/simple;
	bh=eSP9o7bMvgAT9G8orH5Tws3JfI0o1msv/DmweYrihxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5BrfUk5K2X+9kbMuOiKTlUDSm4moIV9e7574Usz1CcyBsKG8D0CyCDt2iqHnSFW3pTHxDVqPWv0mT74RpiEyrhr4SHokWhlpRmnFbZDLTJ4FSnYARcE6vgcVuDd4oLpaU9wVehWpHsCR1XUr8UisIGADm4pfZ9YpK0yZVpUEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0g5H7OE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F878C4CEDD;
	Mon, 17 Feb 2025 00:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739750448;
	bh=eSP9o7bMvgAT9G8orH5Tws3JfI0o1msv/DmweYrihxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0g5H7OEPR/oyel1NMUUvLTByUpGtzJ8rXpDEbWo7tAWeZoIQbkAQllMe/Gw7Talm
	 JER7qt2Z8VYjRmXmMl7LQMWATbxldvgb5AnDIQBqpwOB4iRDwnU8TQ4B+mtEYgNmSt
	 9iJYj34cKo5fRorAc8j+864+lunav36AUV6PHxa1g2aAyQd8uD/IOWCVo4/Y5WTaAK
	 tbg6qUzNYKnlicuLSQt3oylsY7TlHxlomU6mhuQGhNKPa4qKsf7PWuowlXzgJMtymH
	 AXj9rpNMeP6z+6A5mzNeM6N/w/HKhNVbnEvvhjItFrcmxqxN0fMdhZmWI1PzieqZW5
	 GAh6FqCKOYSbA==
Date: Mon, 17 Feb 2025 00:00:42 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH 25/27] ASoC: tas2770: Fix volume scale
Message-ID: <e63802aa-16e9-4efd-8ba1-d112848b6e98@sirena.org.uk>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-25-723569b21b19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YvtZ4gaHZqFG+sI6"
Content-Disposition: inline
In-Reply-To: <20250215-apple-codec-changes-v1-25-723569b21b19@gmail.com>
X-Cookie: This is a good time to punt work.


--YvtZ4gaHZqFG+sI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:02:58AM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> The scale starts at -100dB, not -128dB.

This was one of the patches I pulled out, it's already in CI (I left
everything for a week in case there were review comments).

--YvtZ4gaHZqFG+sI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeyfCkACgkQJNaLcl1U
h9CSrwf9E0w8I+/F3NRQ3YIK1ehAafc+rgjLcq/PZHkZ6iVFMF9AKUD8LKzoeZYF
HfTXnOCqDN5KkMvBDrJA6+DAeMpgUx4znD0f7YSwMZpZqx8COFj208yQUDoHR1Y1
9z7p1CMfbkkWSds1RumDwhFqeD4Uz9/I6j1QIwZJmNXXc1RZ+i9lqMphZpcMDrbs
o/RdQgkeMk06SihjVHdr7itWXHZv754v/54FLzkJe3wS8xEGodBdiKRpOAgItz9P
KvMUosd+MjRRdG5D5rSAku8LviRyE489e8bJ6D/DesXcPsfx6eI0tHATFXdbvfsk
vx+5MoNQxZhTtFiM6WysQffKnBqVmQ==
=sFyb
-----END PGP SIGNATURE-----

--YvtZ4gaHZqFG+sI6--

