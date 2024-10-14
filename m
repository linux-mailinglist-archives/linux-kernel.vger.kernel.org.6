Return-Path: <linux-kernel+bounces-364400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E380199D424
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C671F22CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52801ABECD;
	Mon, 14 Oct 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6WqEIQh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B684D3E;
	Mon, 14 Oct 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921700; cv=none; b=TIV7YGxR5SMQcuFFSjhHKQj5Ktchi810hEoL1gYYIbCRhUVDjqAVEP30XVbwM+avAVfj+Er9alWcAFuo9RvPZKYKjx9tdcVzYfPE95IVwYj7JUCovzLycUHZnVZb0ncFqO+ghrGVVNjz7PCI5oLa+id8N4zauupNmbli0SItDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921700; c=relaxed/simple;
	bh=/LxBb/XpJeYTRjuQxo2hPSUULibUtnh60pBYguxgPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUySb6P51pMQmI0GnuwdzSQkJluff8ok0dw4fchcmtyr3VglRYFauqpWlrtc/ggirBLuFMiu6MOhDPMsqu0mLQjxhBvkz759MdHrsZ1XJWOhrqIPFV6kHX0BQt3NQvqBgT0Jo/S8iYGiA7UVzthQMV+eymnWRq4+9MlBQt5Bb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6WqEIQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F7BC4CEC3;
	Mon, 14 Oct 2024 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728921699;
	bh=/LxBb/XpJeYTRjuQxo2hPSUULibUtnh60pBYguxgPOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6WqEIQhvd1zimAbUe+3tMHiLGy7AdQ8uq4due8CME0s9V7+dL+JNyvTYZu0LhZR6
	 H8s8+v5nWSvdZv7eQWthiBwQVkxJoFuCIBb8w8qd3wNkTigXdmVOe9oKAbbqXQEKTm
	 yoH7SmoEiAEmM9KnKXd95bpNw0BcFxIsgxbd2tp2M/JCz51GWHhcxYPefhc//9f8XY
	 NIOlCCEuIiBh6L+pEWJTWS2bwTwrMkmivYbxdoKanAGnb1odK5IIO+5wq+gocIuZf8
	 tnOTPmHtHx42oyxq2rSZKXyEfb8Ev6/m7RrscJ8X/VUwJ6VKqxXvsIkqyUq1JKVv5e
	 /zVYto9VrB24Q==
Date: Mon, 14 Oct 2024 17:01:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Takashi Iwai <tiwai@suse.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH v1 22/57] sound: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <Zw1AWEpQYBDyBar6@finisterre.sirena.org.uk>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-22-ryan.roberts@arm.com>
 <Zw0CyAlSmaxOCZJl@finisterre.sirena.org.uk>
 <6926988e-5532-457f-9e1a-135b03585c5d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YQ5NQwwWvL7pQhlB"
Content-Disposition: inline
In-Reply-To: <6926988e-5532-457f-9e1a-135b03585c5d@arm.com>
X-Cookie: Editing is a rewording activity.


--YQ5NQwwWvL7pQhlB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 01:24:02PM +0100, Ryan Roberts wrote:
> On 14/10/2024 12:38, Mark Brown wrote:
> > On Mon, Oct 14, 2024 at 11:58:29AM +0100, Ryan Roberts wrote:

> >> ***NOTE***
> >> Any confused maintainers may want to read the cover note here for cont=
ext:
> >> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.=
com/

> > As documented in submitting-patches.rst please send patches to the=20
> > maintainers for the code you would like to change.  The normal kernel
> > workflow is that people apply patches from their inboxes, if they aren't
> > copied they are likely to not see the patch at all and it is much more
> > difficult to apply patches.

> Sure. I think you're implying that you would have liked to be in To: for =
this
> patch? I went to quite a lot of trouble to ensure all maintainers were at=
 least
> in the To: field for patches touching their code. But get_maintainer.pl l=
ists
> you as a supporter, not a maintainer when I ran this patch through. Could=
 you
> clarify what would have been the correct thing to do? I could include all
> reviewers and supporters as well as maintainers but then I'd be banging up
> against the limits for some of the patches.

The entry in MAINTAINERS for me is a M:, supporter is just the usual
get_maintainers noise.  Supported is exactly equivalent to a maintainer.
Generally if you're going to filter people you should be filtering less
specific matches out rather than more and if you're looking to filter
very aggressively look at who actually commits changes to whatever
you're trying to change, less specific maintainers will generally
delegate down to the more specific ones.

> > It's probably better to just use PAGE_SIZE_MAX here and avoid the
> > deferred patching, like the comment says we don't particularly care what
> > the value actually is here given that it's a dummy.

> OK, so would that be:

> 	.buffer_bytes_max	=3D 128*1024,
> 	.period_bytes_min	=3D PAGE_SIZE_MAX,      <<<<<
> 	.period_bytes_max	=3D PAGE_SIZE_MAX*2,    <<<<<
> 	.periods_min		=3D 2,
> 	.periods_max		=3D 128,

> It's not really clear to me how all the parameters interact; the buffer s=
ize
> 128K, which, if PAGE_SIZE_MAX is 64K, would hold 1 period of the maximum =
size.
> But periods_min is 2. So not sure that works? Or perhaps I'm trying to ap=
ply too
> much meaning to the param names...

Like Takashi says just using absolute numbers here is probably just as
sensible, the numbers are there to stop userspace tripping over itself
but like I say it shouldn't ever get as far as actually using them for
anything.  So long as we end up with some numbers that don't need any
late init patching the specifics aren't super important, the use of
PAGE_SIZE was kind of random.

--YQ5NQwwWvL7pQhlB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcNQFUACgkQJNaLcl1U
h9C0BQgAgLqixHC2HmBLzE8BtScypVWosu4/llyhlnVLHix+5KCjWH4yMIAcDIkm
jSFLEZw+OQkiVYFGEmM/QkODuq0/yw1Fj9xAh8n5Po4KNj86ffwVuVtgmg8MXlIX
ze+ysOH4IaGnEzu1ppJLCNNtrOftI1Fm7mDwkGUEB2ZMfP4JoY+q+OnXpZlpqVIf
t1uQWnUb2bhLR6J9awpzY+fRSoz5x0CJF540oKfBMU3Jo6mhJH0sLc1zZmxwCYIn
YGFPJVjIjJ0VaXa5+XFXSDvlcLvPiegwSR9Ys3rmEWJNpb/uWdSEDy8+tus4OH2/
SQF5XoYZF2SEAD1WU+LcRqS3+yzikQ==
=ZFCZ
-----END PGP SIGNATURE-----

--YQ5NQwwWvL7pQhlB--

