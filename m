Return-Path: <linux-kernel+bounces-218398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA290BF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060CB284032
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536EE199259;
	Mon, 17 Jun 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4iZAhJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4E18FC7F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664435; cv=none; b=ep+1l4k6ZkI8ykj3GcKNMdIotA1JQ0BiclQC/AX+qZCiQLEpUv/5RQhPdTBmIThYNHovyVrUDCrQyUiZ2Qve9qHz3yFqWLRVk0rz7duIVyGufm9Y1mgoPQMdsa+Sdz5PgVlu0+3XXgurOl0bf453ssvNJtmFyNXarziIAeSuop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664435; c=relaxed/simple;
	bh=+6AszWB7NujJspRR9GmIktzxaT2CFwGId3UTKVzdtj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyy36fvTXqqfRfBmqmTK2Kqezy/87PGy4plc6ft396hED8nowpg99Tt2j4k1SidRlHLtiK4qye11uJQvVRUuuSwt9a5Ni0Dv/7v+BsbmrdoQe2IKZfEIqqq7VVan9B6bFrI4hByOwYcMgL+n6fudwtS4QKOpjUtfujle0qhGfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4iZAhJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B74EC2BD10;
	Mon, 17 Jun 2024 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718664435;
	bh=+6AszWB7NujJspRR9GmIktzxaT2CFwGId3UTKVzdtj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4iZAhJ4thKlvjoJTJuJUKiVOPnahcAx7q+LwmeH4PFiQ9queY8Cv7ptVUrfxvaac
	 gz/3HTfKJMYjtrZ5U6X1EUDNZFnqM7AuVyVHFph1F+GVUGl1TUAljme2ezgn1rdfsE
	 OEIxJ8iuT3zwxpQIjQN8GMNyKTz6aaRJwW4YwX1LczQJWUANMLCFsx4UHX4q2ZJxXX
	 yW97F/I6AHVSMh3nc+OuZpFmw1l8j5lbLdpYvPh7zQuqSzuS4EMkNRShiuBy2HtF5c
	 +f5l8hF7k2wNuNwShUnKvt8ZYLcl3oaB57b9Rk9TLp8BGDy8YAx+ohE9lEuKKuLo2q
	 qOileHcGyloRA==
Date: Mon, 17 Jun 2024 23:47:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2BuJWhK+1bPnOzgV"
Content-Disposition: inline
In-Reply-To: <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
X-Cookie: Life is the urge to ecstasy.


--2BuJWhK+1bPnOzgV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 02:55:09PM -0700, Guenter Roeck wrote:
> On 6/17/24 10:22, Mark Brown wrote:

> > The range is *entirely* defined within the driver, it is 100% a software
> > construct, the hardware only influences our choice of range in that we
> > can't place it on top of hardware registers.

> I _think_ what you are saying is that I'd have to model all registers
> which are to be addressed through regmap as virtual registers with an offset
> outside the range of real registers. Something like adding 0x100 to the

No, only registers that are accessed through a window need to be
mapped into a range.  Any other registers can just be accessed.

> each register address and then accessing, say, the revision register
> not as register 0x02 but as register 0x102. I would then define the matching
> range from 0x100 .. 0x17f and the window from 0x00..0x7f.

That would make the range exactly the same size as the window so there'd
be no paging going on and the registers could be accessed directly?  I
guess that's another check that should be added...

> Hmm, yes, I see that this should work. I don't think it is worth doing though
> since I need to be able to access some registers outside regmap, and I'd have
> to define two sets of addresses for all those registers. That would simplify
> the code a bit but one would have to remember that register addresses through
> regmap are different than register addresses when calling smbus functions
> directly. I think we'll just stick with the current code and keep the paging
> implementation in the driver.

Mixing regmap and non-regmap access to the same registers seems like a
bad idea in general, you will have locking issues (especially around the
paging).

--2BuJWhK+1bPnOzgV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwvO4ACgkQJNaLcl1U
h9AhHwf+NMGTDaTU4vWKayw3IlKp8KLFCqFyPB39jLtIYChO7RkDrPEiII+VGTeR
tBeaC8aWgp51ZjWocrlQcgt2mCu5iK6B4uvTYZrgQldDRpvGb9pw8kXNNCyo3VDp
LBU4n4Dnobri8eNVty9D/5q6opzcHX++iB6+EOY1qIIh8S3YpyGbyu77fJLPWNL0
WtGMwXsmsnO4oWJhn8oZq/EqHkMewvxIg4+wWEF4BspNzXkZvcEaUQGIklVPNvQ7
Thx/l6FuGzWryZMi7aIbi2zTZuRBYnLP4uTpNi7EFVS39S7yL8ahBWmmORMIS/fP
iwBxpBqOcOQ/xbYwR8QToXPfgv0Hvg==
=GCwD
-----END PGP SIGNATURE-----

--2BuJWhK+1bPnOzgV--

