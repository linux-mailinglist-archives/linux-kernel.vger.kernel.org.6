Return-Path: <linux-kernel+bounces-448994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91689F482A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC87188202E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AE1DED58;
	Tue, 17 Dec 2024 09:57:45 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616D1D5141
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429465; cv=none; b=TT4DZbZzEdF4HNsTQCYtLv1dgZcP3xmY4SPqsLuU2l4fh2coU0VEMJOnN1fdcNcoD5R/DeuQYxoYbbzqYYRERzTTvv57HlMRzXL0H0hQ0akVpXxYx/aSLXnbkrnvXMQJ4R2GeLsz67SpH6mX6Psqb6qx+izNxHrdLkrHP2eux1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429465; c=relaxed/simple;
	bh=JmkpBjnmEqslrlbnmVrevdhf9arH2zEfcPCwpNmaT30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FKsep4Cqk4XoQXymNMrNCGMwpLJ2Hj5ODflis6tAv4TqrnhQLjv1Q+WJrTYT0WDK/7tU66vZJjIok2kvqJUQO/V5s/WlQhd4JojMYe6iHxZOKmIr31H2A+ay/ngXf8CTmrnKhqW8IjHgRI8oHVhk2Hrh26L979oo7WkQyIFiNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-nfT-89vjMx6f-RQZGx7b9A-1; Tue, 17 Dec 2024 09:57:34 +0000
X-MC-Unique: nfT-89vjMx6f-RQZGx7b9A-1
X-Mimecast-MFC-AGG-ID: nfT-89vjMx6f-RQZGx7b9A
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 17 Dec
 2024 09:56:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 17 Dec 2024 09:56:38 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yury Norov' <yury.norov@gmail.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Rasmus
 Villemoes'" <linux@rasmusvillemoes.dk>, 'Andrew Morton'
	<akpm@linux-foundation.org>, 'Masahiro Yamada' <masahiroy@kernel.org>,
	'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>
Subject: RE: [PATCH v2 next] linux/bits.h: Simplify GENMASK()
Thread-Topic: [PATCH v2 next] linux/bits.h: Simplify GENMASK()
Thread-Index: AdtPnhh6INCU27N6T4uBovATuONM6wAi9emAAA8rj+A=
Date: Tue, 17 Dec 2024 09:56:38 +0000
Message-ID: <8fc262c0af694a2e8f5f71b6574a61af@AcuMS.aculab.com>
References: <7a1b1534e51342769740985db773d5e1@AcuMS.aculab.com>
 <Z2Dfaw7OTagl47ir@yury-ThinkPad>
In-Reply-To: <Z2Dfaw7OTagl47ir@yury-ThinkPad>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OI2KdExobdg7c7t2lroiRNcn7ssiGnhaRDFgGzMIfuY_1734429454
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Yury Norov
> Sent: 17 December 2024 02:18
>=20
> On Mon, Dec 16, 2024 at 09:39:23AM +0000, David Laight wrote:
> > Change 95b980d62d52c replaced ~0ul and ~0ull with ~UL(0) and ~ULL(0)
> > in the GENMASK() defines as part of a change to allow the bitops
> > definitions be used from assembly.
> >
> > The definitions have since been moved to a uapi header which
> > probably shouldn't require some other header be included first.
>=20
> Sorry, I don't understand that. Are you saying that uapi headers
> should not include one another? What is exactly wrong with that
> for you? Or did you mean something else?

It doesn't explicitly include whatever defines UL(x)

> > The definition of __GENMASK() is also overcomplicated partially
> > due to avoiding overflow warnings from shifting ~0u left.
> >
> > Implement GENMASK() using the simpler (1u << hi) * 2 - (1u << lo) formu=
la.
>=20
> I don't think that this formula is any simpler than the original one.

The original one has a horrid double-subtract to avoid a warning
from overflow when shifting ~0u left.

> > This doesn't rely on right shifts
>=20
> What is wrong with right shifts?
>=20
> > and doesn't need to know the number
> > of bits in the integral type.
>=20
> What is wrong in BITS_PER_LONG?

Well apart from needing to have included the correct header it is
wrong for the expansions when ASSEMBLER is defined.

> > It can be used for different types by just changing the type of the 1u.
> > __GENMASK() __GENMASK_ULL() and __GENMASK_U128() can now implemeted
> > using a single ___GENMASK(one, hi, lo).
>=20
> I like idea of generic implementation or different flavors of GENMASK().
> I even proposed something similar back then for fixed-type genmasks:
>=20
> https://lkml.org/lkml/2023/6/21/1734

The _U8 and _U16 versions are broken (and pretty pointless).
The result type is 'signed int'.
You have to cast the result of the last arithmetic operation,
and even then the result will be converted back to 'signed int'
pretty much as soon as it is used.

>=20
> Both you and I do the same - provide type as a macro parameter. I like
> my way of doing it a bit more because it's more explicit. But now that
> we have _Generic(), we don't need this hack at all.
>=20
> >
> > Overflow warnings (from shifting out the MSB) are avoided by subtractin=
g 1
> > before the multiply and adding two back in later.
> > The complers see straight through the subterfuge when generating code.
>=20
> Ironically... You're trying to simplify a part that silences Woverflow, a=
nd
> end up by adding another part that silences Woverflow...

It is a much simpler fix :-)
The existing isn't obviously generating the correct value.

>=20
> > Since there are already conditionals for ASSEMBLY in bits.h, for ASSEMB=
LY
> > directly expand GENMASK() and GENMASK_ULL() as ___GENMASK(1, hi, lo)
> > rather than through the __GENMASK() and __GENMASK_ULL() uapi defines.
> > Remove the UL(x) and ULL(x) from the uapi file.
> >
> > GENMASK() and GENMASK_ULL() now generate the correct values when
> > ASSEMBLY is defined.
> > Fortunately they've never been used.
>=20
> They were used before. They are not used now - that's true.

And they've never generated the correct value!

> Can you explain in details how are those macros are broken for assemblers=
?
> Can you add a test?

Well UL(x) and ULL(x) both expand to (x) so GENMASK() and GENMASK_ULL()
cannot both be correct.

I suspect they are also signed so '~1 >> n' doesn't have the correct
value at all.

> > Rename 'h' to 'hi' and 'l' to 'lo' because 'l' looks like '1' in many f=
onts.
>=20
> No please don't!

Most of the lines got changed anyway.

=09David

>=20
> This type of changes don't help at all. They effectively wipe all the
> history for absolutely nothing. If your fonts mess characters, please
> use other fonts.
>=20
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > ---
> >
> > v2: '__uint128' =3D> 'unsigned __int128'
> >
> >  include/linux/bits.h      | 43 ++++++++++++++++-----------------------
> >  include/uapi/linux/bits.h | 15 +++++++-------
> >  2 files changed, 24 insertions(+), 34 deletions(-)
> >
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 60044b608817..d5cf0ec22e43 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -14,41 +14,32 @@
> >  #define BITS_PER_BYTE=09=098
> >
> >  /*
> > - * Create a contiguous bitmask starting at bit position @l and ending =
at
> > - * position @h. For example
> > + * Create a contiguous bitmask starting at bit position @lo and ending=
 at
> > + * position @hi. For example
> >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> >   */
> >  #if !defined(__ASSEMBLY__)
> >  #include <linux/build_bug.h>
> > -#define GENMASK_INPUT_CHECK(h, l) \
> > +#define GENMASK_INPUT_CHECK(hi, lo) \
> >  =09(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -=09=09__is_constexpr((l) > (h)), (l) > (h), 0)))
> > -#else
> > -/*
> > - * BUILD_BUG_ON_ZERO is not available in h files included from asm fil=
es,
> > - * disable the input check if that is the case.
> > - */
> > -#define GENMASK_INPUT_CHECK(h, l) 0
> > -#endif
> > +=09=09__is_constexpr((lo) > (hi)), (lo) > (hi), 0)))
> >
> > -#define GENMASK(h, l) \
> > -=09(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > -#define GENMASK_ULL(h, l) \
> > -=09(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> > +#define GENMASK(hi, lo) \
> > +=09(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK(hi, lo))
> > +#define GENMASK_ULL(hi, lo) \
> > +=09(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_ULL(hi, lo))
> >
> > -#if !defined(__ASSEMBLY__)
> > +#define GENMASK_U128(hi, lo) \
> > +=09(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
> > +#else
> >  /*
> > - * Missing asm support
> > - *
> > - * __GENMASK_U128() depends on _BIT128() which would not work
> > - * in the asm code, as it shifts an 'unsigned __init128' data
> > - * type instead of direct representation of 128 bit constants
> > - * such as long and unsigned long. The fundamental problem is
> > - * that a 128 bit constant will get silently truncated by the
> > - * gcc compiler.
> > + * BUILD_BUG_ON_ZERO is not available in h files included from asm fil=
es,
> > + * 128bit exprssions don't work, neither can C 0UL (etc) constants be =
used.
> > + * These definitions only have to work for constants and don't require
> > + * that ~0 have any specific number of set bits.
> >   */
> > -#define GENMASK_U128(h, l) \
> > -=09(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> > +#define GENMASK(hi, lo) ___GENMASK(1, hi, lo)
> > +#define GENMASK_ULL(hi, lo) ___GENMASK(1, hi, lo)
> >  #endif
> >
> >  #endif=09/* __LINUX_BITS_H */
> > diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> > index 5ee30f882736..a25d9dfb7072 100644
> > --- a/include/uapi/linux/bits.h
> > +++ b/include/uapi/linux/bits.h
> > @@ -4,15 +4,14 @@
> >  #ifndef _UAPI_LINUX_BITS_H
> >  #define _UAPI_LINUX_BITS_H
> >
> > -#define __GENMASK(h, l) \
> > -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> > -         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> > +/* Result is '(1u << (hi + 1)) - (1u << lo)' coded to avoid overflow. =
*/
> > +#define ___GENMASK(one, hi, lo) \
> > +=09((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
> >
> > -#define __GENMASK_ULL(h, l) \
> > -        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> > -         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> > +#define __GENMASK(hi, lo) ___GENMASK(1UL, hi, lo)
> >
> > -#define __GENMASK_U128(h, l) \
> > -=09((_BIT128((h)) << 1) - (_BIT128(l)))
> > +#define __GENMASK_ULL(hi, lo) ___GENMASK(1ULL, hi, lo)
> > +
> > +#define __GENMASK_U128(hi, lo) ___GENMASK((unsigned __int128)1, hi, lo=
)
> >
> >  #endif /* _UAPI_LINUX_BITS_H */
> > --
> > 2.17.1
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


