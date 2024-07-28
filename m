Return-Path: <linux-kernel+bounces-264582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7F93E5A3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB4AB20FE6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2773E46434;
	Sun, 28 Jul 2024 14:19:40 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20823224DC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176379; cv=none; b=Q+GxHd/mxz1Qi1U7+JOft1RJ8/5ortGbx04wEzMADkNlr+FOgo4Oyf6jRrMZOIkH/WxHTGh/2jOrHaikHbmbQFu6twVUREYkLPa3b74jZfScT52UsVHip1ATojc3DANp9REP5RFQlKfCWcfO96QZhUCCl43NOceERoFnTVuF30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176379; c=relaxed/simple;
	bh=MuvoUgdtghS6rQkUL1LMIng5Fy8TT6pQDoAeXgc4g8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UK6Q3Xf5XzuhP9e9SlXuwlQ+VmBKl7JEpPIXr2txyc0FVnuz2c2TIUwGzebqTXK+HO6GedpehUhu1AlWjb/lRVF22aXba5Gh/7VQ8vQeIp4ye6taG9ZSqhjFhLPnI3b9dDqDTfH9ay3CUKil4VhcO6/jmVrdtPRIWRyno8ElS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-44-u0K9Dgy5NXe-98MhLF4xEg-1; Sun, 28 Jul 2024 15:19:32 +0100
X-MC-Unique: u0K9Dgy5NXe-98MhLF4xEg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:18:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:18:47 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: 'Linus Torvalds' <torvalds@linuxfoundation.org>, 'Jens Axboe'
	<axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>, 'Andrew Morton'
	<akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>, "'pedro.falcato@gmail.com'"
	<pedro.falcato@gmail.com>, 'Mateusz Guzik' <mjguzik@gmail.com>,
	"'linux-mm@kvack.org'" <linux-mm@kvack.org>, 'Lorenzo Stoakes'
	<lorenzo.stoakes@oracle.com>
Subject: [PATCH v2 2/8] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Topic: [PATCH v2 2/8] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Index: Adrg+SQVeb05XypLRkeZ+5Y+23noEA==
Date: Sun, 28 Jul 2024 14:18:47 +0000
Message-ID: <b169a04caaee43c7b917a7e48470da6a@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
In-Reply-To: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
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

The static_assert() wrapper provides the text of the expression as the
error message, this isn't needed here as an explicit message is provided.
If there is an error (quite likely for min/max) the wrapper also adds
two more lines of error output that just make it harder to read.

Since it gives no benefit and actually makes things worse directly
using _Static_assert() is much better.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2:
- No change.

 include/linux/minmax.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index cea63a8ac80f..ab64b2e73ae5 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -48,7 +48,7 @@
 #define __cmp_once(op, x, y, unique_x, unique_y) ({=09\
 =09typeof(x) unique_x =3D (x);=09=09=09\
 =09typeof(y) unique_y =3D (y);=09=09=09\
-=09static_assert(__types_ok(x, y),=09=09=09\
+=09_Static_assert(__types_ok(x, y),=09=09=09\
 =09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" #op=
 "() before " #op "_t()"); \
 =09__cmp(op, unique_x, unique_y); })
=20
@@ -137,11 +137,11 @@
 =09typeof(val) unique_val =3D (val);=09=09=09=09=09=09\
 =09typeof(lo) unique_lo =3D (lo);=09=09=09=09=09=09\
 =09typeof(hi) unique_hi =3D (hi);=09=09=09=09=09=09\
-=09static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
+=09_Static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
 =09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=09=
\
-=09static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=09=
\
+=09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
+=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
 =09__clamp(unique_val, unique_lo, unique_hi); })
=20
 #define __careful_clamp(val, lo, hi) ({=09=09=09=09=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


