Return-Path: <linux-kernel+bounces-264587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF693E5A9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBE6B21968
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD34AEE0;
	Sun, 28 Jul 2024 14:24:47 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2544174C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176686; cv=none; b=LXiWffumo5wIEm7gA+vDJtteW/449Qar1HhBRy2dIuDy9So0fmH0CWJw7eViX5Fhp3xeZFokDm3t6yPhxg3elomcYjjz52Mkea+zuVQfP67C7mjH6rtZvXwyw/JptE6wS7xz+LwjFQmHekdVm4Hn3cIDDx3bA5QsOF4D6a7T+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176686; c=relaxed/simple;
	bh=lLxFQwdnAuRPbrJit6Ocd1M+MA5j9LSLm1WrWa6k+SA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dCwkLLHEBZZcLveTUe11lLKqie1Y2l69/dfMi66O8JIO/xRLyO8ryb93RSMx5goaz1fP9MWNbe5dUX60uFeQLnjgFcczg3JyySwdDaqOTaXR14CImJOmyyp+73Mnfz6O0VlKcJUKfCO0r/Pc5k/qQqC5RyuM+jKSOMisSHBBSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-277-nlUHsBjeMUSsZCF2tSpzXw-1; Sun, 28 Jul 2024 15:24:37 +0100
X-MC-Unique: nlUHsBjeMUSsZCF2tSpzXw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:23:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:23:52 +0100
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
Subject: [PATCH v2 7/8] minmax: Use __auto_type
Thread-Topic: [PATCH v2 7/8] minmax: Use __auto_type
Thread-Index: Adrg+b/Mt8JjzpFvR/SgdqY3jGnUug==
Date: Sun, 28 Jul 2024 14:23:52 +0000
Message-ID: <431f7c45e7294d4da4f8abcd57ce7b5e@AcuMS.aculab.com>
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

Replacing 'typeof(x) _x =3D (x)' with '__auto_type _x =3D (x)' removes
one expansion of 'x'.

Signed-off-by: David Laight <david.laight@aculab.com>
---
New patch for v2

 include/linux/minmax.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index ad57c8eddc8a..cb3515824a64 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -47,9 +47,9 @@
 #define __cmp(op, x, y)=09((x) __cmp_op_##op (y) ? (x) : (y))
=20
 #define __cmp_once(op, x, y, unique_x, unique_y) ({=09\
-=09typeof(x) unique_x =3D (x);=09=09=09\
-=09typeof(y) unique_y =3D (y);=09=09=09\
-=09_Static_assert(__types_ok(x, y),=09=09=09\
+=09__auto_type unique_x =3D (x);=09=09=09\
+=09__auto_type unique_y =3D (y);=09=09=09\
+=09_Static_assert(__types_ok(x, y),=09=09\
 =09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" #op=
 "() before " #op "_t()"); \
 =09__cmp(op, unique_x, unique_y); })
=20
@@ -131,18 +131,18 @@
  * @y: value2
  */
 #define min_not_zero(x, y) ({=09=09=09\
-=09typeof(x) __x =3D (x);=09=09=09\
-=09typeof(y) __y =3D (y);=09=09=09\
+=09__auto_type __x =3D (x);=09=09=09\
+=09__auto_type __y =3D (y);=09=09=09\
 =09__x =3D=3D 0 ? __y : ((__y =3D=3D 0) ? __x : min(__x, __y)); })
=20
 #define __clamp(val, lo, hi)=09\
 =09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))
=20
 #define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({=09=
=09\
-=09typeof(val) unique_val =3D (val);=09=09=09=09=09=09\
-=09typeof(lo) unique_lo =3D (lo);=09=09=09=09=09=09\
-=09typeof(hi) unique_hi =3D (hi);=09=09=09=09=09=09\
-=09_Static_assert(__if_constexpr((lo) <=3D (hi), (lo) <=3D (hi), true),=09=
=09\
+=09__auto_type unique_val =3D (val);=09=09=09=09=09=09\
+=09__auto_type unique_lo =3D (lo);=09=09=09=09=09=09\
+=09__auto_type unique_hi =3D (hi);=09=09=09=09=09=09\
+=09_Static_assert(__if_constexpr((lo) <=3D (hi), (lo) <=3D (hi), true),=09=
\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
 =09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
 =09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


