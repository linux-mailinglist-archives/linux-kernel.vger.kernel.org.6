Return-Path: <linux-kernel+bounces-261967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84A93BEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AEB1F21C61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89909196D81;
	Thu, 25 Jul 2024 09:13:44 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E91974FE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898824; cv=none; b=S2F+4HDexwzLVjQ1ImGG0oQfmmfVwYfEFv6hR+mCnP+3tztjFLGneNwt3X83pfkfG7D94uctfl/U+I1b4HJn/oZUNz0VewBqDQcSPf52Ic9TlRHS/Ku3gjLbcBzPeJ9u42AgZCKraeO4a6qfVILqVe+S3E4tZfNZL5lnWEQwo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898824; c=relaxed/simple;
	bh=NSuiLqwGlqURN9cIwFNSCdCNVTuqijjle2i3OVTJanM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=b2TeSSlY7sq7y286kVSyvhOJVi1Zff9Xf4XsOv0VEus9AlwZC80VchzmTsUUa+IsZB6AalrAR0Km8M6hX67SgxOC0VLZEsUiIHgPYo6EOQTSbBXuDQG74gSwSmXu1/lyvT44L1DLFleh1OVCqdYYovs7Ac4zGZJRLVjsS239kIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-uHipkxBVP7SWuPIbzBzFtA-1; Thu, 25 Jul 2024 10:13:36 +0100
X-MC-Unique: uHipkxBVP7SWuPIbzBzFtA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jul
 2024 10:12:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 25 Jul 2024 10:12:57 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>
CC: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "'linux-mm@kvack.org'" <linux-mm@kvack.org>
Subject: RE: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Topic: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Index: Adrd1gZ7oS190yPcQj+hKNIa4uSuaQAEQPEAACLTNbA=
Date: Thu, 25 Jul 2024 09:12:57 +0000
Message-ID: <3d6217d937994620a5de0d8967f518c0@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
 <24be8665-4717-4ee2-8a81-80fed5181736@app.fastmail.com>
In-Reply-To: <24be8665-4717-4ee2-8a81-80fed5181736@app.fastmail.com>
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
> Sent: 24 July 2024 18:32
>=20
> On Wed, Jul 24, 2024, at 16:29, David Laight wrote:
>=20
> > +#define __if_constexpr(expr, if_const, if_not_const)=09=09\
> > +=09_Generic(0 ? ((void *)((long)(expr) * 0l)) : (char *)0,=09\
> > +=09=09char *: (if_const),=09=09=09=09\
> > +=09=09void *: (if_not_const))
> > +
> > -#define __is_constexpr(x) \
> > -=09(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int =
*)8)))
> > +#define __is_constexpr(expr) __if_constexpr((expr), 1, 0)
>=20
> I don't immediately see anything wrong with this, but I'm
> still scared of any change to it, especially if this is
> meant to go straight into mainline.

Well it would be -rc1 (or maybe -rc2).

> Would it be possible to do patch 4/7 without the new
> __if_constexpr() and instead still using __builtin_choose_expr()?

The safer option would be to add __if_constexpr() but leave the
change to __is_constexpr() for 'next'.

=09David

>=20
>      Arnd

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


