Return-Path: <linux-kernel+bounces-261963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD893BEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A509CB21C57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92B19750B;
	Thu, 25 Jul 2024 09:08:19 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC081741EF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898499; cv=none; b=FyPStqziFWnaCAqWLGsErS4Gr+YskduiTfC+ulveCu6kwxtxoZVNnNkET1jK+IKAWb19uQxXheOHELSJuqiNJ5+EwfMnKGtbCG0LQ+y4ik1xI7xgVR8+TkZNbloTkACR9WTabKX5vFVMiq2m42aNdCz44D9vSfZuDsbBL0gpWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898499; c=relaxed/simple;
	bh=Wf6Q6+UK6kq2SdUDKqU+u8hs9pVzV/RnjBZfD0Rpdag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cf7F8sjuq6AxT9ru8t9EI222aT/XIUfW54kCAaUC+agPoSu+k6679gCzyrsLeeJITwPBg84QPv4EHoZyNCi3ZS/2CkyFV4NYd+GgQixtZulmdrE16fdqHJ/0D8gLBPcgBDJ37OgtUhNKbJF8TQN3l4qMxXvZ3Deyxh9KJ+LeM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-80-0tSVirVbNtCQfmxDPT3JXw-1; Thu, 25 Jul 2024 10:08:12 +0100
X-MC-Unique: 0tSVirVbNtCQfmxDPT3JXw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jul
 2024 10:07:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 25 Jul 2024 10:07:32 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>
CC: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "'linux-mm@kvack.org'" <linux-mm@kvack.org>
Subject: RE: [PATCH 7/7] minmax: minmax: Add __types_ok3() and optimise
 defines with 3 arguments
Thread-Topic: [PATCH 7/7] minmax: minmax: Add __types_ok3() and optimise
 defines with 3 arguments
Thread-Index: Adrd1nwhwSRYGwj9RxiIgqAQhw9FiAADIsiAACObMsA=
Date: Thu, 25 Jul 2024 09:07:32 +0000
Message-ID: <f093cc1b170b45839f06b3fbe7df5d2f@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <3484b7fcd2c74655bd685e5a7030c284@AcuMS.aculab.com>
 <1bb3d09c-3b34-4348-8d6f-bd867704625c@app.fastmail.com>
In-Reply-To: <1bb3d09c-3b34-4348-8d6f-bd867704625c@app.fastmail.com>
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
> Sent: 24 July 2024 18:04
>=20
> On Wed, Jul 24, 2024, at 16:33, David Laight wrote:
> > min3() and max3() were added to optimise nested min(x, min(y, z))
> > sequences, bit only moved where the expansion was requiested.
> >
> > Add a separate implementation for 3 argument calls.
> > These are never required to generate constant expressiions to
> > remove that logic.
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
>=20
> This brings another 3x improvement in the size of the expansion
> and build speed.
>=20
> > +#define __cmp_once3(op, x, y, z, uniq) ({=09\
> > +=09typeof(x) __x_##uniq =3D (x);=09=09\
> > +=09typeof(x) __y_##uniq =3D (y);=09=09\
> > +=09typeof(x) __z_##uniq =3D (z);=09=09\
> > +=09__cmp(op, __cmp(op, __x_##uniq, __y_##uniq), __z_##uniq); })
>=20
> This still has a nested call to __cmp(), which makes the
> resulting expression bigger than necessary.
>=20
> The three typeof(x) should be x/y/z, right?

Ooops...

> Using __auto_type
> would avoid the bug and also remove one more variable expansion.

I'd thought that as well.
But hadn't looked up the syntax.

> Using another temporary variable, plus the use of __auto_type
> brings the example line from xen/setup.c down 750KB to 530KB,
> and the compile speed from 0.5s to 0.34s.
>=20
>  #define __cmp_once3(op, x, y, z, uniq) ({      \
>        __auto_type __x_##uniq =3D (x);           \
>        __auto_type __y_##uniq =3D (y);           \
>        __auto_type __z_##uniq =3D (z);           \
>        __auto_type __xy##uniq =3D __cmp(op, __x_##uniq, __y_##uniq); \
>        __cmp(op, __xy_##uniq, __z_##uniq); })
>=20
> The __auto_type change can also be applied to the other typeof()
> in this file.

True.

=09David

>=20
>       Arnd

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


