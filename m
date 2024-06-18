Return-Path: <linux-kernel+bounces-219147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C0990CA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F921F24155
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9A14F9D4;
	Tue, 18 Jun 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6jb7TK4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674F383BD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710512; cv=none; b=Vcv1Z16Yg5pVpKoxXGsS/oRbGsHGwUvXQwkm6pjfRugg9PdhGWsoiBx0RmLf1nwV+tZ/9//nO0BMuhT503mxBsWvKEs2zXeuzk7e2i6kdoZG7XIjqSBCopHehDTxX4CDI86IzS+ht0/NS5vtG8l3byxjzqvlcxk3eCEsIUF+MLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710512; c=relaxed/simple;
	bh=M4pnuz8cNuPU8c1HstU6mEYOGHH4rhaGZOnyxFYYFMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqEGaNlFhFDzjcvna7P1FdXHHVJ+hk32UHmDHwxs3VD6pxahGEofp+QFPcTWiIKkN3FWEVy1O8gR5TW9BFapT+WcrwzVmZ2OE1TY9cfD5vfVWKrcIM9fp3liQ07wJyvJKCHD+vf5lxdlK/lV2Kyc6aOSkgnaPFuVOsCZY2+K+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6jb7TK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4BAC32786;
	Tue, 18 Jun 2024 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718710512;
	bh=M4pnuz8cNuPU8c1HstU6mEYOGHH4rhaGZOnyxFYYFMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6jb7TK4AqUtxRSPRhtEDM4TaUnPyrlbwMYDEqbeCntG/CKNTpMISGpo6dvZ1IY05
	 qJZpXMJJ3VRuM1wuEe4uZxHAicjpxqR6zBI1BusyqDnQRq+ZowrJWXf4vyWZCdsuxt
	 1ldz1T5Myty+N7Gux4FdK0lJ0niiULGrKQqa8ViH8lj2TrIy7LV+GArNQkXJO+zV6x
	 EkHlLiRCR/9E6DYPOe4Qpc3Vu2fYr7iiV9gLSRD3yA2M1W+E0Bwv29qQueIEYa5VJ8
	 KcCWu3pAXPtNgrUzpwjmG+8XTA5zyPMi+13tV6ky+KCHhIJBfsehCABjgSSnowfhRj
	 lO+3FoKUxyO5Q==
Date: Tue, 18 Jun 2024 12:35:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YRK1sU5hNClG7S+h"
Content-Disposition: inline
In-Reply-To: <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
X-Cookie: If you can read this, you're too close.


--YRK1sU5hNClG7S+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 04:15:33PM -0700, Guenter Roeck wrote:
> On 6/17/24 15:47, Mark Brown wrote:
> > On Mon, Jun 17, 2024 at 02:55:09PM -0700, Guenter Roeck wrote:
> > > On 6/17/24 10:22, Mark Brown wrote:

> > > each register address and then accessing, say, the revision register
> > > not as register 0x02 but as register 0x102. I would then define the matching
> > > range from 0x100 .. 0x17f and the window from 0x00..0x7f.

> > That would make the range exactly the same size as the window so there'd
> > be no paging going on and the registers could be accessed directly?  I
> > guess that's another check that should be added...

> I tried to explain this before. The registers in address range 00..0x7f
> are physical, but they are only accessible from page 0 with the exception
> of the page select register. So, sure, the registers are not actually paged,
> but page 0 must be selected to access them. That is the one and only reason
> for specifying that first range and window. It ensures that page 0 is
> selected when accessing the registers. If that wasn't the case, I could
> define a single range for the actually paged addresses in the 0x80..0xff
> window and be done with it.

So surely this means that the entire register map is one window and
there's no point in defining two ranges?  Those registers are paged with
the same selector as the other registers.  At which point you can just
sidestep the issue and be like the other current problematic drivers.

> The non-regmap access all happens in the probe function before regmap is
> initialized. It is needed for basic chip identification, to prevent someone
> from instantiating the driver on a random nvram/eeprom and messing it up
> with attempts to write the page select register. I would not want to be
> held responsible for someone with, say, DDR4 DIMMs force-instantiating
> the spd5118 driver and then complaining about bricked DIMMs.

What some devices do for enumeration if the fully specified regmap won't
work for all is create a trivial regmap used for enumeration, then throw
that away and instantiate a new regmap based on the results of initial
identification, though that wouldn't really work for letting you skip
paging.  I don't see how you avoid handling paging in the probe theough,
unless you just assume that the chip is left on page 0 by whatever came
before.

--YRK1sU5hNClG7S+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxcOsACgkQJNaLcl1U
h9D65Qf+IrZCCyK+pbghAZoF7jmFba59dcZHCCApvqPHF0iT7x39Ku3wsQI3svaV
XpGqASHAFySvOLSye2tn9/1d/NzJ2uV6cvXqzYF4ii36tzn5UbAcz0kM0rkhrW2I
sKvamqkKlJJwEQWkEULegKoeXSLwcA6ZrGIhQGkWqltqD85RjA9fX5lfb9OPeMPZ
UQb9UFGgWQjQhLgSBF+YHGGrWr0lbAUZ8dTnOIUm/iv1sECtYBuonW9GElAsbqhF
xdyhITWcMne+DpH4wfsGvYvF+F7n0cGUgnxDO1GkYuMdMS9ltLO0dPrT0zOyBGwA
082ExvYULGI0aGK0Ke+M4K5pnKUG7g==
=nBui
-----END PGP SIGNATURE-----

--YRK1sU5hNClG7S+h--

