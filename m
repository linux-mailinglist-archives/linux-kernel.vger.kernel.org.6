Return-Path: <linux-kernel+bounces-297918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52B95BF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A91B2431A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414741D0DCA;
	Thu, 22 Aug 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjFr4vdm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DA1D0498
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356139; cv=none; b=sOVnYN+EQ8jO5+eDtAqKTyrExoVvJ+E6o0zKHH3VeqWYYKDQUfsvcXONPAPB8qh63+P9tQ+Ksl1RjEdquIOjH6XhpPP53OAM4dBXmVop0Dz1yDULuvvq8MpEbDwTD0wxZpbBQx7oTxhCQ6uBgJp+t0diQ+kjEWh9nSYnhDKLOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356139; c=relaxed/simple;
	bh=vHrYYwpLYrMdWCxNwu9b7Dbs6lQkJVhNyl0BaU6kaqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKc3BhYbuJ4J3CBvs+lVm3kwd8RijyLUiSNqkmpqFLSWtJG+ljjj489RL68rCaExZbLiz/wAIU6eDo4L8fxBEctJ6/0b1LOr5dg8wNiGXJUTUCH21t3bDyuU6efF1Vqu+iAbTjb88nmx59yrVbAchqWrrhpgY8Gmqonu+mv4Wto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjFr4vdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97675C32782;
	Thu, 22 Aug 2024 19:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724356139;
	bh=vHrYYwpLYrMdWCxNwu9b7Dbs6lQkJVhNyl0BaU6kaqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjFr4vdmuguovWr4xstpV8xF58Pq4jPc8qo0rDXbMkPwNwi/Mtjfj7iPgvESHqIf/
	 0Vu3uk+CHl7dkhCPmdQwf9rDaB3rt9zi56N25TflW89xjirvRVH+9bmEE3cPnVfM8A
	 1ycLXEQFqVHm8XpKomSwSy2eWKKupfqLQqnYoX3k4ZUbvgtbd7KlgPs+5my4YdLJ1F
	 Gu2oqt82Qzl29Y896EhXUW0zDcXd9LTkL+Qyrq5Td/80vpFHbkRG0bADmOmrfxDdqe
	 6XjmxgUu7aGgbErPP34636gRbvizmYXf1yHFQGHdr2fxw1ucuoMtOPzT1c9FbdG8Do
	 XVfahtHXMi++Q==
Date: Thu, 22 Aug 2024 20:48:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] maple_tree: Allow external locks to be configured
 with their map
Message-ID: <ZseWKBCkxTrJfEot@finisterre.sirena.org.uk>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
 <20240822-b4-regmap-maple-nolock-v1-1-d5e6dbae3396@kernel.org>
 <ZsePxD2FtYcBIaD5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4fxvcd//gcNS1l/S"
Content-Disposition: inline
In-Reply-To: <ZsePxD2FtYcBIaD5@casper.infradead.org>
X-Cookie: Your love life will be... interesting.


--4fxvcd//gcNS1l/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2024 at 08:21:40PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 22, 2024 at 08:13:35PM +0100, Mark Brown wrote:

> > Currently the maple tree code allows external locks to be configured by
> > passing the lock itself. This is generally helpful and convenient but is

> No, it's a really bad idea.  Stop doing it.  Use the internal lock.
> It's a temporary hack we put in and I'm really regretting allowing it.

I mean, we do use the internal lock here since otherwise lockdep moans
but it's pure overhead which just complicates the code.  It's only ever
taken within another lock, meaning it winds up protecting nothing for
these maple trees.  We can't go the other way round and use the maple
tree lock as the regmap lock since apart from anything else it's a spin
lock and we need to use a mutex most of the time to support busses that
sleep during I/O.

--4fxvcd//gcNS1l/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHliAACgkQJNaLcl1U
h9BGLQf+KaHwyNa3gCljDUOtxigUv0bPCPgmuFaZzITTLKm0YvnpxqQJIOWokFq9
7+bmG3fdtxffPVO/BceSbfQkMbW8Gjkbh0TWCD3VmZBQ3UMiIiU0LF9/Vnv1ZAlG
dnRCUtXzULqlDHCHNBoaQgDV0L0xB3+RmAxEWtfny1gTqaN+BO1yP6s1nPD+qBos
9qa71AYCM7lSjObStWccEqct9gLC08gDwIFknroF7YGRIk8/eRRzr4AA/61LkZEK
UDMEODc7+qeDCBnUp7/U2GFvYmss6+1axzeKEi+GRjMoi2ds8wUv2DDCorSeY1aX
CFWA7G++3W4VraKYnaQKNl1qG2OIzA==
=RNbC
-----END PGP SIGNATURE-----

--4fxvcd//gcNS1l/S--

