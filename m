Return-Path: <linux-kernel+bounces-267437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5E941179
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FA51F2245C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC919E7D3;
	Tue, 30 Jul 2024 12:04:16 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D779194C8D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341055; cv=none; b=J7HBL4GnyB1cXwo1VLc7KX/znl7OlxRWqEdNQit0wAkdnKc3ZbrNT+T/GAcqiXhNIW11SZD1+ho9aVSACE0sJugVAp7uMA4AAnDPgypO5l+RCdWrJyldaoQgZE+JCKybvE7ZBP3WQ/Y5Iu4ybfM3ysF11YQCwT7dJFrbLb+EFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341055; c=relaxed/simple;
	bh=/iwFvWWPQCIFjhr8xq0yvCyejzJDiLvninasg8jl7HE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AG8to+vL9GMiruDchMvWirqCbhobYDMTJuUFvQGj53Xp3xErjAEOnfZc7Cwx7ZiZPYvtwxjN5WbrfauIG4QGBD340adeGd+hfldgFjCyClFg4ln5c2VqoszvrCT92Qxz3fZ9jW0I2wKiGxe+hD1AGLHGCw2ya5bhrOUpBMyFRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-YJgdhREpNjWCHCFE7JUojg-1; Tue, 30 Jul 2024 13:04:04 +0100
X-MC-Unique: YJgdhREpNjWCHCFE7JUojg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jul
 2024 13:03:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 30 Jul 2024 13:03:24 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@kernel.org>, Linus Torvalds
	<torvalds@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>
Subject: RE: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Topic: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqgADc22WIAGyOt4A==
Date: Tue, 30 Jul 2024 12:03:24 +0000
Message-ID: <424323bd65354ecbad256657d5782bc2@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
In-Reply-To: <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
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
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Arnd Bergmann
> Sent: 29 July 2024 23:25
..
> - My macros use __builtin_choose_expr() instead of ?: to
>   ensure that the arguments are constant, this produces a
>   relatively clear compiler warning when they are not.
>   Without that, I would expect random drivers to start
>   using MIN()/MAX() in places where it's not safe.

Yes, I think you either want temporaries or a constant check.
Losing the signedness check is less of a problem.
Since 'constantness' is only important for array sizes and
static initialisers the constant check is unlikely to be a problem.

Just adding __builtin_choose_expr((x)+(y),0,0) to the result
is enough and quite simple.
Then each argument is expanded 3 times.
(cf once for temporaries without a signedness check.))

>=20
> - I went with the belts-and-suspenders version of MIN()/MAX()
>   that works when comparing a negative constant against
>   an unsigned one. This requires expanding each argument
>   four or five times instead of two, so you might still
>   want the simpler version (like MIN_T/MAX_T):

I'm not sure that is worth it, there are very few negative
values (except error values) in the entire kernel.
And where ever the value is used a carefully created negative
constant is likely to be promoted to unsigned.

I'm not sure I like the casts in MIN_T() and MAX_T() either.
As with min_t() someone will use too small a type.

OTOH umin(x, y) could now be defined as:
=09min_t(u64, (x) + 0 + 0u, (y) + 0 + 0u)
(which will never sign extend).
Then some of the bloating min() that are known to generate
unsigned values can be changed to umin().

It is also worth noting that umin() is likely to generate
better code than an _min() (that doesn't have the type check)
because comparing a 32bit signed type (assumed positive) with
a 64bit value won't require the (pointless) sign extension
code (particularly nasty on 32bit).
In my tests the compiler optimised for the high 32bits being
zero (from the zero extend) - so extending to 64bits doesn't matter.

The typeof((x) + 0) in the signedness test (a different email)
that matches the C promotion of u8 and u16 might have been added
before I did the change to allow unsigned comparisons against
positive integer constants.

Another anti-bloat is to do all the type tests on the temporaries.
So something based on:
#define ok_unsigned(_x, x)
=09(is_unsigned_type((typeof(_x)) ? 1 : if_constexpr((x), (x) >=3D 0, 0)))=
=20

#define min(x, y)
=09__auto_type _x =3D x;
=09__auto_type _y =3D y;
=09if (!is_signed_type(typeof(_x + _y))
=09=09&& !(ok_unsigned(_x, x) && ok_unsigned(_y, y)))
=09   error();
=09__x < _y ? _x : _y;
which only has 3 expansions of each term.

(Of course the 'uniq' needed for nested calls don't help.)

=09David

=09

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


