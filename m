Return-Path: <linux-kernel+bounces-170031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA38BD0DF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A41F22406
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AB153BD9;
	Mon,  6 May 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE3G7fAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1E381AA
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007512; cv=none; b=iTBmsOBNWP0jN9Jz20s0/tepBNUNf1/u5Eof9Ws69ZM+Ha2k+D3olUKY1Uvi/W3mdLH8DJXkM1IIIg4yRkpUiO6776j/Z086AJ9ou0/3vMu5WzWk5ilyc3avyqHo3q1MawQA6L3qGwl6pHjwH5f0U3JsP4XKxxN7iCv9M6uqvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007512; c=relaxed/simple;
	bh=ge+5UyqIPPPc8xOgZDQDDjgrmpqqaD74dvE2knrvQCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2yANnQ4/LgZuPMBCQ2dZTKNz0UmYYUzsK11s4QpFZrIaJdvce2dibsF6TdeFs79xrais5SRsFLjHocCgMSFC1kViMCih04GvYVv6EJrSW9gUB4nrB8P4NP0n+ZuFXFkyKj7VclS7J1pJINqU0sWSYXotTjLIn2loFd328iXxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE3G7fAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6CBC4AF63;
	Mon,  6 May 2024 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007511;
	bh=ge+5UyqIPPPc8xOgZDQDDjgrmpqqaD74dvE2knrvQCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fE3G7fAPpUQxLbiRQLTx/79GDCNnCk5wNq0uJ3kZR9YZi1lkvfu7pcVi+dgXBIR+P
	 njbiLrJju2LThF44JoBYIiRj+x/liV59lnUySVocRZuRCjtGgQd4NDGKwM1VtRboDq
	 B9ZmccaJDqJj+80qLC0QaLjeyuJRFft1864umoRi8IcnGTVIT5q9xMhaxvcnWJhPh2
	 tHDQYdCYpxslnRPxYDfLWPJPsFjWv1sRi19YOGiZS4P1M/lgEXGHDLPFjoOan1j3Xp
	 2LUWejgoZLat0Yg20uRpmKoZt2+9nMKg/vi5BahmBzTJEphOe1lqsAxSC5yR4dEekL
	 M9zqZfSF7Gvcw==
Date: Mon, 6 May 2024 23:58:29 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
 <20240503073536.GA12846@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NWYZTbv7SVE/Vla5"
Content-Disposition: inline
In-Reply-To: <20240503073536.GA12846@linuxcarl2.richtek.com>
X-Cookie: lisp, v.:


--NWYZTbv7SVE/Vla5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 03:35:36PM +0800, Alina Yu wrote:
> On Fri, May 03, 2024 at 10:41:04AM +0900, Mark Brown wrote:

> > That's a substantail reconfiguration of the regulator, it would be
> > better to have an explicit property for these non-standard fixed
> > voltages rather than trying to do this using constraints, or at the very
> > least have validation that the values being set are supported by the
> > hardware.  The code should also be very clear about what is going on.

> May I add the 'richtek,use-fix-dvs' property back ?

It sounds like it might be better to add a property specifying the
specific fixed voltage rather than overloading the constraints for this
purpose.

--NWYZTbv7SVE/Vla5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY48BQACgkQJNaLcl1U
h9D0DAf/RuCsPm8RlbY4B3VwnIhIqwY5eVOgY/7xtH1X5VaqtD4f/b+Eho2MduNW
4rlRWmLei3uDTCweT84Eby8IM6Sc6R1iubkuoHWx1PCEI6b6g+t5OItYU6FIQ172
lMP7MkYrXCOlijpc1CkkRwerQt8++nI133+bBO700hS9ZBOzCf9/4homcJ4akgXu
JS3MAWA6R4Tl5JArwHroznZYvFuy4gZv0YkTOzojQGNWsCNbdERIpI2VbqCiT2WZ
flqkFLav/N36bXpSkoR5T2FCa5E7yWrOJzjKA5V09thwOWWAAEHkl3n1cfNmROMI
ZvYxIeEPx7V9SxA6c4ZzR1BLzJq/Ug==
=8mGb
-----END PGP SIGNATURE-----

--NWYZTbv7SVE/Vla5--

