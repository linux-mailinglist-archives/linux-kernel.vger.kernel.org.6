Return-Path: <linux-kernel+bounces-263276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8393D397
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ECB285B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5F17B512;
	Fri, 26 Jul 2024 12:58:34 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422E2E3E8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998714; cv=none; b=eks65D6N6CqG4iqIhLUQa9kcVcaFrQmJkgv9KL7blNymmGDwG3XY6D8C3EZBjYZ8zAAoNOTJoQFECYf+Hcxvnlyn3IWCvabDfSaqWOHORjd7jr0UmS7u3EyxY1LzEvCabxz/y0JxldXrbBr8pk7LtAvlMJ6qC2t+W3+fJDI/v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998714; c=relaxed/simple;
	bh=kQSU1lhDhLBj6wRkET5kINFcVfR/CaXSYVaZHjwzhsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=urZOAO4gDP3qh/0S+uzEKA5cGhN7ssLGVL+7zit8lrqhVBuZa8rp5I9fJcOWCEDbL9qPSf9AwDKc2AJLJqVySEaCERld59gO0IcBTLIlW+sP3cJ5lbshyIydVe6vy2jbggJihhD2gExwMKIccyet7rpx0Jlt3JiUd1mrTUSLdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-138-dErO4UU2Os2Sn7zB_sImjg-1; Fri, 26 Jul 2024 13:58:23 +0100
X-MC-Unique: dErO4UU2Os2Sn7zB_sImjg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 26 Jul
 2024 13:57:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 26 Jul 2024 13:57:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>, Linus Torvalds
	<torvalds@linuxfoundation.org>
CC: Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 4/7] minmax: Simplify signedness check
Thread-Topic: [PATCH 4/7] minmax: Simplify signedness check
Thread-Index: Adrd1i0k/JcX2h1sSAO9D37F5HIFAAALj27TABqyPTAANETWLQAFsOCg
Date: Fri, 26 Jul 2024 12:57:43 +0000
Message-ID: <f2ee5fe686f7440ab1e5469a6e560064@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
 <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
 <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
 <5a129d04e0b84b48ba6c5189a047ac8f@AcuMS.aculab.com>
 <CAHk-=whLcr11D28vu2NotZYn3GNH6BCTK57Zw4d4v7eut39z=g@mail.gmail.com>
 <d48ce3b3-9173-4309-aae6-96be42327f97@lucifer.local>
In-Reply-To: <d48ce3b3-9173-4309-aae6-96be42327f97@lucifer.local>
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

From: Lorenzo Stoakes
> Sent: 26 July 2024 10:44
>=20
> On Thu, Jul 25, 2024 at 10:02:45AM GMT, Linus Torvalds wrote:
> > On Thu, 25 Jul 2024 at 02:01, David Laight <David.Laight@aculab.com> wr=
ote:
> > >
> > > The condition is '>=3D 0' so it doesn't matter if it is '1' or '0'.
> >
> > Yes, but that's because the whole conditional is so inexplicably comple=
x.
> >
> > But the explanation is:
> >
> > > That gives a 'comparison of unsigned type against 0 is always true' w=
arning.
> > > (The compiler generates that for code in the unused branches of both
> > > __builtin_choose_expr() and _Generic().)
> > > Moving the comparison to the outer level stops all such compiler warn=
ings.
> >
> > Christ. This whole series is a nightmare of "add complexity to deal
> > with stupid issues".
> >
> > But the kernel test robot clearly found even more issues.
> >
> > I think we need to just go back to the old code. It was stupid and
> > limited and caused us to have to be more careful about types than was
> > strictly necessary.
>=20
> The problem is simply reverting reveals that seemingly a _ton_ of code ha=
s
> come to rely on the relaxed conditions.
>=20
> When I went to gather the numbers for my initial report I had to manually
> fix up every case which was rather painful, and that was just a defconfig=
 +
> a few extra options. allmodconfig is likely to be a hellscape.
>=20
> I've not dug deep into the ins + outs of this, so forgive me for being
> vague (Arnd has a far clearer understanding) - but it seems that the
> majority of the complexity comes from having to absolutely ensure all thi=
s
> works for compile-time constant values.

The problems arise due to some odd uses, not just the requirement for compi=
le-time
constants for on-stack array sizes.

The test robot report is for a test between pointers.
I thought there was one in the build I do - and it doesn't usually generate=
 a warning.
This one is related to the different between a 'compile time constant' and
a 'constant integer expression'.
This is due to is_unsigned_type(t) being (t)-1 > 0 but (type *)x not being
'constant enough' unless 'x' is zero.
Fixable by something like:
=09(__if_constexpr((t)-1, (t)-1, 1) > 0)
But that requires two expansions of the type.
Now the type could be that of the unique temporary - but that would make it
all more complicated.

There are fewer min/max of pointers than when constants are needed.
So requiring them be min_ptr() wouldn't be a massive change.

> Arnd had a look through and determined there weren't _too_ many cases whe=
re
> we need this (for instance array sizes).
>=20
> So I wonder whether we can't just vastly simplify this stuff (and reducin=
g
> the macro expansion hell) for the usual case, and implement something lik=
e
> cmin()/cmax() or whatever for the true-constant cases?

I did do that in a patch set from much earlier in the year.
But Linus said they'd need to be MIN() and MAX() and that requires changes
to a few places where those are already defined.

> > But it was also about a million times simpler, and didn't cause build
> > time regressions.

Just bugs because people did min_t(short, 65536, 128) and didn't expect zer=
o.

It has to be said that the chances of a min(negative_value, unsigned_consta=
nt)
appearing are pretty slim.
All these tests are there to trap that case.

There is always the option of disabling the tests for 'normal' build, but
leaving them there for (say) the W=3D1 builds.
Then it won't matter as much if the tests slow down the build a little.

I think I have tried a W=3D1 build - but there are too many warnings/errors
from other places to get anywhere.
A lot are for 'unsigned_var >=3D 0' in paths that get optimised away.
The compiler doesn't help!

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


