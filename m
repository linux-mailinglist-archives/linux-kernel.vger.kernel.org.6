Return-Path: <linux-kernel+bounces-305143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A4F962A33
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E061C23D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31F189B9F;
	Wed, 28 Aug 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAushX44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A62D600
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855254; cv=none; b=PwB2ADNq4HDLsAa5aAyYuLVVugkmWMRjkYBYLB1/NtlzBaN6Hh18Vk/R4e9Ibbru0WMrCbDLBivGmd3XUb0oHEoLQtyYXZiPsuUvAnTpoSc34dkHz82eKDUGVWk2rh5jLRp6xhX4E4y6sRzBTikI4V004rj0imFAr5W3tC6GcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855254; c=relaxed/simple;
	bh=1f0GM8hUkAqNGCKC4UeJzlvRwpjAPmIHcveEyFdIPQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syc1vD1zLbznEOknA8NP9ep033KKJ08JQO50ZbsmpBF1ZNhclD3LC52E06s6IbgzrboG1OZAI85JwTkAhFc3J9lokWO5Mh4MbZ/9VRiGM2A4JKjSWOKoURzX9NP70NPfwPipeQmwJSxZcu99mTAiDLsuNAq4KTlYYeQCPvZgaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAushX44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD427C4CEE5;
	Wed, 28 Aug 2024 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724855253;
	bh=1f0GM8hUkAqNGCKC4UeJzlvRwpjAPmIHcveEyFdIPQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAushX44OCSw8ggaOVktNLI0KQrqFQdn23UKjd05luCp7XLUmBYUMW5RMC6sTXoGK
	 0olfj2FOOmTbHDsVBBXQjtNwwGSX0mnCwuZ+0kiz4s41xIbt5pp1qIrWRLzsZ1RfeK
	 +6N1MO7f95zFZ5Wvs1hU+xSmu5UD1pL3wMf+0u/YAnvx/l6Q6ANQnGqBo4Xlm1Nkbu
	 xCoPD2+aDQk/2Qs+8fN9CCgFMGfiQHDwO38At/ZE0Rn4FHqctOQVg+pVY+2mmLL2hE
	 itmrlAmwrb1/Yt8WqKKnNjgTCssJg1NHF8fwMMCi+yIQ2b9AbNYcY4v7tGYLVM4AVf
	 HhoYsoyJOcLjg==
Date: Wed, 28 Aug 2024 15:27:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	afd@ti.com, bb@ti.com, d-gole@ti.com,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to
 a single register
Message-ID: <ce44b268-d138-445d-a149-e5348897d3c5@sirena.org.uk>
References: <20240828121008.3066002-1-nm@ti.com>
 <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
 <20240828133229.67bej3utpgrmzr3p@retired>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r+Wbd9LpO3QX5yNH"
Content-Disposition: inline
In-Reply-To: <20240828133229.67bej3utpgrmzr3p@retired>
X-Cookie: You are number 6!  Who is number one?


--r+Wbd9LpO3QX5yNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 08:32:29AM -0500, Nishanth Menon wrote:
> On 13:57-20240828, Mark Brown wrote:
> > On Wed, Aug 28, 2024 at 07:10:08AM -0500, Nishanth Menon wrote:

> > > Fixes: 0ec74ad3c157 ("regmap: rework ->max_register handling")

> > In what sense is this a fix?

> The max_register was 0x0 was clearly a corner case. The fix done for
> remap  should have cleaned up the users of max_register to maintain the
> behavior. That is just my opinion.

No, apart from the fact that catching all possible regmap users would be
rather hard it's entirely optional for regmaps to specify a maxium
register.

> > really does not seem like a good idea - unless you've done an audit of
> > every single syscon to make sure they do explicitly specify a maximum
> > register, and confirmed that this can't be specified via DT, then it's
> > going to break things.

> I understand the risk - but having a consistent max_register definition
> is important - key here is that in regmap, max_register is valid if:
> a) max_register not being 0
> b) if max_register is 0, it is valid only if max_register_is_0 is set to
> true.

> When syscon sets the max_register, it operates correctly for num_reg > 1
> however, when reg_size == 1, you don't get the checks that you
> get when num_regs > 1. That is inconsistent behavior.

> It might help if you can clarify why you think an inconsistent behavior
> is correct for syscon?

Like I say specifying a maximum register is entirely optional, not
everyone wants that feature and if you don't use the debugfs interface
or the flat cache it doesn't *super* matter.  With 0 as default it's
always going to be awkward to describe a maximum register of 0 while
allowing that to be optional, fortunately very few devices have a single
register.

--r+Wbd9LpO3QX5yNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPM9AACgkQJNaLcl1U
h9Aghwf+OLLk3MIiyJOte94+Y9YMQGcWM7eunBitGTaIb3+zGRlMKQInC/IjBRv5
1bSXYoIfK/bL5lHdju7eZ+p+2mxuztEczOdfFl2weoGL9kVztTL4D1ghVeq1RKk4
tIdjUfibxViu2yb5RPWnsUyZlaV0Rrq6SiLox+pZ7WCLoep9Dol9Jt/wVISFYry3
crqHhWyLYfU9qCtHKh9OI9l2z3ETQXa0DhwRV5aMgUgIHwPyqH2I5JyfOKhaVgjO
9fa+DnCMoL9pJqVMqbuSTkSCB+2bd2zuncG8uQRQf9N/sLr6mbVhyb8GY29zdMFH
QUzBEeivksblMDxJqfYXIy1Tqg7KsA==
=zuee
-----END PGP SIGNATURE-----

--r+Wbd9LpO3QX5yNH--

