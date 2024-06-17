Return-Path: <linux-kernel+bounces-218007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284C90B7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A692C1C2342A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD416DC26;
	Mon, 17 Jun 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mno24mML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC716DC1D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644944; cv=none; b=GzcYaaja3wNwFF2oCBwNGFQ1N8RDqblPZSJzxZpj8uO6Kx/RWIQVkG2SW6utX0CSFsKOt4/Kl0/u7mJgpbINAYZbgST9T8yVCrIbQi3bOyGuoiq2C2immp8M3EuGM8UPX/E+aBPpFZ/6b0yGASTbA6oY275snxNtsVD6tmrk6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644944; c=relaxed/simple;
	bh=xMBNjWoj2BogXC3Z1A0ni1Ag4wgonRSM6djm/zo9wSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCtj4k90g2s4FeelXKBgY/XFyBO27h0Ezjbf4GLqFm1QsbYfq2gQWsB/SVqdKAAlxo5ccRDADbXCd93rrDfrOwzSgCwhHYWe2ZQSUKMQUimQWO72j55xdj9R4+NHwz60xjDVuxVlVBqjALnKL9AeURzfuV3cbT9ZNAaHB72Sytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mno24mML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3012BC4AF1C;
	Mon, 17 Jun 2024 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718644944;
	bh=xMBNjWoj2BogXC3Z1A0ni1Ag4wgonRSM6djm/zo9wSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mno24mMLHy57nF77+4yEx2BvNa5aO59Mb86c5G6f3vG3QWRbfe+bhFEkk4zhQkl0Q
	 cNQd47mj0eYbke4IS+FkyW79nuibOUOYGYHicsoZQoSGfcWaa6nzS8jTGX1jsZzZjQ
	 HoHvp2IYk7QVfSjkRmTisV+jMPDABdZ6UF3zQwKl2HAtbVUrWJGEHUEKoUJRqSRJlI
	 0vmfL+Ejp9270tPiR8sEF8gnsMtahSA0EwQXT5SPS0f/WQwf82jt+XHTXHwBEjknr+
	 dxFz16Ov2WLWqQP7K8Lr1kU3e57p9kI6iEy7tnz4sL6uTJXCWOahL4lsis6qexFrkW
	 xhsefP1pq+34w==
Date: Mon, 17 Jun 2024 18:22:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C/ZYoGpwsWinse6Z"
Content-Disposition: inline
In-Reply-To: <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
X-Cookie: Life is the urge to ecstasy.


--C/ZYoGpwsWinse6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 09:59:50AM -0700, Guenter Roeck wrote:
> On Mon, Jun 17, 2024 at 04:08:08PM +0100, Mark Brown wrote:

> > You appear to be trying to define ranges that overlap with the windows
> > that you're trying to expose.  I can't understand what that's trying to
> > represent or how that would work.  The window is the physical registers
> > that the host can actually see, the range is the virtual addresses which
> > users of the region should use to access registers behind the window.
> > This should be a range of register values which don't physically exist
> > on the device.  I really can't understand what a sensible handling of an

> Can you point me to an example ? All examples I can find have overlapping
> values for .range_min/.range_max and .window_start/.window_len, and pretty
> much all of them start range_min with 0.

sound/soc/codecs/wm2200.c.  I do see a bunch of bad examples now I grep,
bluntly I'm astonished any of them do anything useful and wonder if
anyone has even run the code.

> > overlap would be, any attempt to access the window should recursively
> > trigger selection of the range so no actual register should work.  I
> > can't tell what it's trying to model.

> page 0: 0x00-0x7f	Volatile registers, page selector at 0x0b
> 	0x80-0xff	page 0 of non-volatile memory
> page 1:	0x0b		page selector register	<-- this is what trips the check
> 	0x80-0xff	page 1 of non-volatile memory
> ...
> page 7:	0x0b		page selector register
> 	0x80-0xff	page 7 of non-volatile memory

So you've got two windows from 0-0x7f and 0x80-0xff which share a
selector register because of course that makes sense, the selector is
placed inside one of the ranges.  That's all perfectly fine, modulo the
multi-use selector register the hardware seems fine.  What I don't
understand is what the attempt to put the window on top of this is
supposed to mean.

> > This configuration would also be rejected by the next test which
> > verifies that the window does not overlap with the range.

> No, it isn't. The windows in the two ranges don't overlap, and neither
> do the ranges. The only overlap is the selector register. The check you
> refer to explicitly does not apply to a single range.

Ugh, it should - like I say these configurations are just incoherent
nonsense.

> Pretty much all drivers I looked at start the range with 0, having
> the selector register within the range is explicitly accepted by the
> regmap code, and pretty much all drivers using regmap for page
> selection do that. The difference here is that the page selector
> register is in the first range and visible from all pages, but the
> other volatile registers are only visible in page 0.

Having the page selector register be inside the page is pretty common.

> Yes, I would agree that this doesn't make much sense, but it is what
> the spd5118 standard calls for, and at least the Renesas/IDT spd5188
> chip implements it that way.

The range is *entirely* defined within the driver, it is 100% a software
construct, the hardware only influences our choice of range in that we
can't place it on top of hardware registers.

> Anyway, how should I model this ?

To repeat:

> > Like I say I can't tell what this is trying to describe or how it could
> > possibly work.  The range should be completely distinct from the window.

--C/ZYoGpwsWinse6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwcMsACgkQJNaLcl1U
h9DZ/wf+MJdee0EFIyJfF6E33bmUltBfkIoAWd2xM3J4OxFYIlL2/isN/Vof8zs5
NUQiYxUINnUC+QTJx1D/qiN1IS8zd6Y6l/h1Z4I5QtDEV/J7bGCSYC6rbyWh5AnQ
vy52wfTSbYb3FKnJnFLmlczoh46pKgxEr4W2WyDNoXPWLrNrDUTYaNEdMeK5F+ED
Pv8OuFv+vx8MMCmypsiX6/uHHl07a39Se6OgEqSI4I9/tlS0aAUoS/0uH9U/bMaI
KV987UOBMvVE+8BHFjv0Yoblv9sRZa26uoUaqBkWOb37CitButevxs2afPD4RSG2
04G3erXF9Dd5f/vxQqCVuH5oV6vlxw==
=+gKR
-----END PGP SIGNATURE-----

--C/ZYoGpwsWinse6Z--

