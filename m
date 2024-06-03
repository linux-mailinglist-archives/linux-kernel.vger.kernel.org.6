Return-Path: <linux-kernel+bounces-198781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4688D7D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CE11C217CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D85FDA7;
	Mon,  3 Jun 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXe2n9Nt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECA5B68F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403149; cv=none; b=ufg7YgitLy9n3BseslEDjQe9JMSN814iWTjt36kQWCOSP/VTh0aH6vQSGz1F5QdRpt/JbFqYbkTuwrtt+qIpO61kdiQ6Z0ttFEDDUHDWrI/rImeyWVvomJ+cudkNThUv5ZFePIDZt41R/ojuARCpUDIne3++oi7JgDscEiWJP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403149; c=relaxed/simple;
	bh=aE1fh3+CXtMRxNu0TYmWUzvdn7c0d7qbCuoHrxexG4I=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Pi7MC+GnKzDnTdVsetZYy8Tyqr+d5+/PFNG/zT5eMLvKkqRddMKLSTpqJOY7CJ4hWDNvMNPmbmw0VRWqgrU+u3p7Heb3wZwWepNDeoAmYAKPGvdI/+YjxYl3EajyVdJmUcJIVbr3xUvZzwIKi9H7S7wljPcb5GfmjplV8WiC0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXe2n9Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78666C2BD10;
	Mon,  3 Jun 2024 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717403148;
	bh=aE1fh3+CXtMRxNu0TYmWUzvdn7c0d7qbCuoHrxexG4I=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=AXe2n9NtXRQn9XVB5NIKk6nnUYAlRbvhXwlh8/To0Jrs9hyGfmlCFYftFr8TeP4be
	 8iqtNcBeiE0zdk/iL06mr1qTVy9gPpknLSukMmzkU8PN4Q6q+DOVRtNdj0usVt32vy
	 XO9kVWohKwtbPPQ4JaJJ6CWCSEZUT2HkhHPzwr2fKF5Dmh0qxxzPT6nTKrRgm+I3gy
	 +IU1n21gf7IKcfniySh6Ov9fuYSpyqf1BPx6PumlZA6U4/SR2r+60AmoMFIrUTg2kH
	 POn/O+PbfbeEBdH4bh6nUvFx9iVeHH9jUNIy3gJYjKJb7A+6OWC0RSDxZIZ1DfdheX
	 d8lMpCZqO8qZQ==
Content-Type: multipart/signed;
 boundary=d46e1a1054ac3317006112254d36d8e54f39007c7af5372dd6e3ff89531b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 03 Jun 2024 10:25:44 +0200
Message-Id: <D1Q8LSUGXEIH.1N6HH5514YIJV@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <mwalle@kernel.org>
To: "Esben Haabendal" <esben@geanix.com>
X-Mailer: aerc 0.16.0
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com> <D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org> <87frtuigo3.fsf@geanix.com>
In-Reply-To: <87frtuigo3.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--d46e1a1054ac3317006112254d36d8e54f39007c7af5372dd6e3ff89531b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > In that case, I'd rather see a new flag in .no_sfdp_flags
> > to explicitly trigger the SFDP read. Then your new flash would only
> > need this flag and doesn't require the shenanigans with the fixup,
> > right?
>
> I fixup would still be required in order to enable 1-2-2 for MX25L3205D,
> as it will fail the SFDP read, but actually does support 1-2-2.

But you (probably) don't care and we also don't care for the
additional speed. So, I'd rather drop that code that is just there
for that ancient EoL flash.

-michael

--d46e1a1054ac3317006112254d36d8e54f39007c7af5372dd6e3ff89531b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZl1+CRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jdKQF8DveA1osmeLfihnlbROPQphfmdPnklv7X
NaNjhbgJEmKxtS2zk+jZVwssNfPFUUnxAYDHBEZh9zqy67jhffWnmu8w9KS9vEI9
8kUa3IDDladbn6eU15rcwQXCHadZvM6CGQg=
=JZ4L
-----END PGP SIGNATURE-----

--d46e1a1054ac3317006112254d36d8e54f39007c7af5372dd6e3ff89531b--

