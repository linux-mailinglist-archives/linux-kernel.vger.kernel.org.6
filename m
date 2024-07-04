Return-Path: <linux-kernel+bounces-241721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A0927E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AEF1C229F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC01422CC;
	Thu,  4 Jul 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mx31ZCqB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DmVEtPF/"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603344C9E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127809; cv=none; b=stY8AXbluXWokyJ0pvG9WV4LFyN1nM1jRFERMlwuTBDIfe6tfa738OT6U7EITDpns09+KOX1pFDRdb2pWl8o5ZbZ7ISD2De3wbpKVePyN0HOZ3jpy/FJZJ9XYnoG9/KbngQwdP6KnOEw8N0WTFZ2N/qLX7sg9uFyGtL0qDxUsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127809; c=relaxed/simple;
	bh=yimfb403pWmUlvjFEZblWpJ/YdtvzteD/2XJBc7FA20=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lEyMMphWOgmOQCmEpOZGUkzws8gALkoaDhv4RirL9yurLrSr3IN9IpM8eiUuQS/7rreaavgw9UhGOgjNUfAxfijWjKyezo95shdyVFsAE8+sbxGU14mHmpxwdHxvZwc9StHnvhIvz1SP2M4YkqCpOcVU4fGWbCEHUeRpKwEddqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mx31ZCqB; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DmVEtPF/ reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4472334D3E;
	Thu,  4 Jul 2024 17:16:39 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type:content-id; s=sasl; bh=yimfb403pWmUlvjFEZblWpJ/Ydt
	vzteD/2XJBc7FA20=; b=mx31ZCqBTwtrrvq1s4FAhbgiJuRYcBDEGIXQvjLILo7
	IPNdBDkYw78ZWOAe7eg3Mmq+8QM44Z77dblN7oatztXrQSKf0t1MbbMZ4eC2qFLS
	wZ1v/f7/9Ri72DWTmHkazWWhUp2xQQMLlYOiCi7Vu8L8AGz55NWyoV3n/Hm6sR1M
	=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B3BF34D3D;
	Thu,  4 Jul 2024 17:16:39 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:content-id; s=2016-12.pbsmtp; bh=/SdQ6wJ3TzdLQFYb25H7Ybf7SA3PsZS58bSfh0NRtOc=; b=DmVEtPF/xExxNfdNjxki0HPrPGK2GwMrYr06LBNcQ9GhFHt3CqK40UsMlO9KshuOWGydLAQGi/y0q9Ps0aUM+XcSJYoWEE8htDqP2T5nDBZDui46C+BTHvQLxvx9byBXqqQ64bM4eat7xdvkQnjRPOtUIKmoQATMucrY50oKhOA=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C08F34D3C;
	Thu,  4 Jul 2024 17:16:38 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 7D2DED3526E;
	Thu,  4 Jul 2024 17:16:37 -0400 (EDT)
Date: Thu, 4 Jul 2024 17:16:37 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mul_u64_u64_div_u64: make it precise always
In-Reply-To: <adjv6ypwuvlugbx3uqd6q4r5hyj3v3gx4bs6cwcvj6h7llbo6v@jr4p35pkkzyx>
Message-ID: <6496p439-p76r-oq72-n716-9q6757071609@syhkavp.arg>
References: <20240703033552.906852-1-nico@fluxnic.net> <20240703033552.906852-2-nico@fluxnic.net> <adjv6ypwuvlugbx3uqd6q4r5hyj3v3gx4bs6cwcvj6h7llbo6v@jr4p35pkkzyx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-1963667944-1720121523=:826828"
Content-ID: <93p1sn3o-5q76-q531-nn83-no39592nos41@syhkavp.arg>
X-Pobox-Relay-ID:
 B3933B9E-3A4A-11EF-87B8-5B6DE52EC81B-78420484!pb-smtp1.pobox.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-1963667944-1720121523=:826828
Content-Type: text/plain; charset=ISO-8859-15
Content-ID: <6nnso2q8-32ro-q8sq-n476-r83695785429@syhkavp.arg>
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024, Uwe Kleine-K=F6nig wrote:

> Hello Nico,
>=20
> On Tue, Jul 02, 2024 at 11:34:08PM -0400, Nicolas Pitre wrote:
> > +	A.v =3D a;
> > +	B.v =3D b;
> > +
> > +	X.v =3D (u64)A.l * B.l;
> > +	Y.v =3D (u64)A.l * B.h + X.h;
> > +	Z.v =3D (u64)A.h * B.h + Y.h;
> > +	Y.v =3D (u64)A.h * B.l + Y.l;
> > +	X.h =3D Y.l;
> > +	Z.v +=3D Y.h;
> > +
> > +	u64 n_lo =3D X.v, n_hi =3D Z.v;
>=20
> I tried to understand your patch. This part could really benefit from
> some comments. With pen and paper I worked out your idea:
>=20
> 	The goal is:
>=20
> 		A * B =3D=3D Z << 64 + X
>=20
> 	With A =3D A.h << 32 + A.l and similar identities for B, we have:
>=20
> 	A * B =3D (A.h << 32 + A.l) * (B.h << 32 + B.l)
> 	      =3D (A.h * B.h << 64 + (A.h * B.l + A.l * B.h) << 32 + A.l * B.l
                          ^ missing )

> 	The operations done here are only 32 bit multiplications and
> 	additions, and with U32_MAX =3D 0xffffffff we have:
> 	U32_MAX * U32_MAX + U32_MAX =3D (U32_MAX + 1) * U32_MAX =3D
> 	0xffffffff00000000 which fits into an u64.  Even when adding
> 	another U32_MAX (which happens with Z.v +=3D Y.h) it still fits
> 	into u64, and so the operations won't overflow.

Exact, that's the idea.

I was about to reproduce the code I wrote for a similar purpose about 18=20
years ago that currently lives in __arch_xprod_64()=20
(include/asm-generic/div64.h). when I realized that, with some=20
reordering, all the overflow handling could be avoided entirely.

So I'm about to submit some nice simplification for my old optimized=20
__div64_const32() based on this realisation.

> > +	/* Do the full 128 by 64 bits division */
>=20
> Here is the code location where I stop understanding your code :-)

Here's how it goes:

To do a binary division, you have to align the numbers, find how many=20
times the=20
divisor fits and subtract, just like we learned in primary school.=20
Except that we have binary numbers instead of base 10 numbers, making=20
the "how many times" either 0 or 1.

To align numbers, let's simply move set bits to the top left bit.

Let's suppose a divisor c of 0x00ffffff00000000

        shift =3D __builtin_clzll(c);
        c <<=3D shift;

so shift =3D 8 and c becomes 0xffffff0000000000

Also need to track the actual divisor power. Given that we start working=20
on n_hi not n_lo, this means the power is initially 64. But we just=20
shifted c which increased its power:

        p =3D 64 + shift;

Then, remember that n_hi < original c. That's ensured by the overflow=20
test earlier. So shifting n_hi leftwards will require a greater shift=20
than the one we applied to c, meaning that p will become 63 or less=20
during the first loop.

Let's suppose n_hi =3D 0x000ffffffff00000 and n_lo =3D 0

Then enter the loop:

                carry =3D n_hi >> 63;

Top bit of n_hi is unset so no carry.

                shift =3D carry ? 1 : __builtin_clzll(n_hi);

If n'hi's top bit was set we'd have a shift of 1 with a carry. But here=20
there is no carry and aligning n_hi to the top left bit requires a shift=20
of 12.

                n_hi <<=3D shift;
                n_hi |=3D n_lo >> (64 - shift);
                n_lo <<=3D shift;

So n_hi is now 0xffffffff00000000

                p -=3D shift;

Shifting left the dividend reduces the divisor's power.
So p is now 64 + 8 - 12 =3D 60

Then, the crux of the operation:

                if (carry || (n_hi >=3D c)) {
                        n_hi -=3D c;
                        res |=3D 1ULL << p;
                }

So... if the divisor fits then we add a 1 to the result and subtract it.
n_hi =3D 0xffffffff00000000 - 0xffffff0000000000 =3D 0x000000ff00000000
res |=3D 1 << 60

Let's loop again:

                carry =3D n_hi >> 63;
                shift =3D carry ? 1 : __builtin_clzll(n_hi);
                ...

No carry, shift becomes 24, p becomes 60 - 24 =3D 36 and
n_hi becomes 0xff00000000000000.

                if (carry || (n_hi >=3D c)) { ...

No carry and n_hi is smaller than c so loop again.

                carry =3D n_hi >> 63;
                shift =3D carry ? 1 : __builtin_clzll(n_hi);

This time we have a carry as the top bit of n_hi is set and we're about=20
to shift it by 1. p becomes 35 and n_hi becomes 0xfe00000000000000. In=20
reality it is like having 0x1fe00000000000000 (a 65-bits value) which is=20
obviously bigger than 0xffffff0000000000. So we can augment the result=20
and subtract. Thanks to two's complement, we have:

n_hi =3D 0xfe00000000000000 - 0xffffff0000000000 =3D 0xfe00010000000000

and=20

res =3D 1 << 60 | 1 << 35

And so on until either n_hi becomes 0 or p would go negative, which=20
might happen quite quickly in some cases.

> > +	/* The remainder value if needed would be n_hi << p */
>=20
> I indeed need a variant of this function that rounds up. So maybe
> creating a function
>=20
> 	u64 mul_u64_u64_div_u64_rem(u64 a, u64 b, u64 c, u64 *rem)
>=20
> with the sophistication of your mul_u64_u64_div_u64 and then:
>=20
> 	u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> 	{
> 		u64 rem, ret;
>=20
> 		ret =3D mul_u64_u64_div_u64_rem(a, b, c, &rem);
> 		return ret;
> 	}
>=20
> (In the hope that the compiler optimizes out the calculation for the
> remainder)=20

It probably won't unless the core function is a static inline.

It might be more efficient to do this:

u64 mul_u64_u64_div_u64_rem(u64 a, u64 b, u64 c, u64 *rem)
{
	u64 res =3D u64 mul_u64_u64_div_u64(a, b, c);

	/* those multiplications will overflow but it doesn't matter */
	*rem =3D a * b - c * res;

	return res;
}

This way the core code doesn't get duplicated.

> and:
>=20
> 	u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
> 	{
> 		u64 rem, ret;
>=20
> 		ret =3D mul_u64_u64_div_u64_rem(a, b, c, &rem);
>=20
> 		if (rem)
> 			ret +=3D 1;
>=20
> 		return ret;
> 	}
>=20
> would be nice. (This could be done in a follow up patch though.)

You're welcome to it.  ;-)


Nicolas
---1463781375-1963667944-1720121523=:826828--

