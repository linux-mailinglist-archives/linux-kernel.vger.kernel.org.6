Return-Path: <linux-kernel+bounces-571325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B3A6BBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F343A421D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A022A7F4;
	Fri, 21 Mar 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtVj2fDX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD38216E01
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564066; cv=none; b=D+p+c5q+Fgezf5Nnw0pSKtogJQhfXCRL3KXNdlSJQDUz6NQL87Q3qmppTC+eW1g6GfppHlSIzYwA9FAFgvEg4iruUWZYo1o9o6z3vIueXugVvatB8fNCe3JlmHkNMod2deK1MRi6XgTU12U0DUZ1jE2y+vC+of8fqyekdylTXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564066; c=relaxed/simple;
	bh=izujH16hZ5B1lvNp9sMLIekrfi8CmtK+NCCtfVgxpJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw4HUjypBx3UvI3UVS25IL5GJzRRlRZq91FTFRV3gcdl+zQU6Q0Df2/1mugObEqRCfe68z2dhjfzVyL2TCiy8vnL6FHJxTlRiZ23KPbiJXblQmwMTP/rBlFMWyJs2IfUopoDt1Bfb3Qky8ageoXvu+cD7PW+YSjE2vcP0SueLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtVj2fDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D066C4CEEA;
	Fri, 21 Mar 2025 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742564065;
	bh=izujH16hZ5B1lvNp9sMLIekrfi8CmtK+NCCtfVgxpJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtVj2fDXWCS1lJrLsECvEqszGMLHOL0P+gPjVilJ9GCb+GedRmocGDguG9N//5MAo
	 Xb7lJIWxDNmLqF06FUKb9lnrcGrHZo/TORiJlyH6UNp35fArkvMgu2wWoGI639vBZl
	 lDcemYMOTvBUsMUw1jldxhG22ksXRWu2wqnXYseMHJ1HaaiyFoBkm/sMHLoyMb+1u5
	 +oZlYsNeQ98f+pdKnK/22RMSk1izAL6KAUm0Z0kFRIVS0ARa8+p5auRwX2A515rKiU
	 RjHxW+QCJRMXJiR4lVJ0fH6JwuWLcn/1w9IPOmcmMllocRBiVDZHDNU7KQsytSmAdN
	 Lf0MNMq1QiW2w==
Date: Fri, 21 Mar 2025 13:34:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: spi: Don't use spi_write_then_read()
Message-ID: <Z91q17GaHDpJKLIV@finisterre.sirena.org.uk>
References: <20250320-regmap-spi-write-read-v1-1-31666bc6ebe8@kernel.org>
 <b32120b4-3805-43f0-956d-3c28810fc8b9@sirena.org.uk>
 <31f54b9e-6140-4a21-bfb3-ce07febe4e36@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xF9td3uOK7nC68+R"
Content-Disposition: inline
In-Reply-To: <31f54b9e-6140-4a21-bfb3-ce07febe4e36@app.fastmail.com>
X-Cookie: Well begun is half done.


--xF9td3uOK7nC68+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2025 at 12:27:01PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 21, 2025, at 00:08, Mark Brown wrote:

> > I think this actually needs to be part of a wider series, but pushing it
> > out there just now since there's the other regmap paths which also use
> > spi_sync() and will need any adjustments anyway.

> I can see some code paths that are potentially broken by this
> patch on its own, e.g.

Yeah, I was pretty sure there were some but hadn't actually gone and
found a specific example yet.

> If your plan is to have _regmap_raw_read() always do its
> own buffering (at least for unaligned buffers on noncoherent
> devices), it will still work.

Either that or having some library that all the buses use (IIRC
at least SoundWire can do DMA), yeah.  We also have I/O that regmap
generates itself as part of cache sync potentially, especially with
rbtree caches.

I remembered what the difference between writes and reads I was thinking
of was BTW - only reads use spi_write_then_read(), writes are already
using spi_sync() directly for gather writes (which are the ones most
likely to use DMA since they'll be for bigger blocks of data, non-gather
writes are usually single register) or otherwise spi_write() which
doesn't bother with a bounce buffer.

--xF9td3uOK7nC68+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfdatYACgkQJNaLcl1U
h9B+gAf/ehimSDuGesZOB7uxoqw7WzpoaaTH3wXjnnNwd4X7e6WcLNccud2tByDN
Ye1gK5nbwF/Wgge5gGcVhNJYLmMH12BAzHH+XkuwQH21uO8z9TTFdBlcr+OZIt34
KjDEQdQp5rT4UTf03JZ1rf8C0gaXxC108TkbNximzTV+ly7+yLqR/6hDh9gtzuuX
/51bnmTGzdUb75p10AS6M2SCVfeVu+8E6bhD/1QGa/N6V+99aLy+jOJE4IzflIL4
G/KK29GBNqVvwNg67aKKPmLGU7AqDKCnLsQmXhsDvDbzZiXYVcgwZCqmd6CDSeA5
AH5KD5/HvJQPHZuyS0X1PmxdryhhWg==
=afIk
-----END PGP SIGNATURE-----

--xF9td3uOK7nC68+R--

