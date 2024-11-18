Return-Path: <linux-kernel+bounces-413405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9589D18B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346271F21D55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D51E2312;
	Mon, 18 Nov 2024 19:12:56 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E11B6CEE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957176; cv=none; b=B+bR7j63XX8ZW5xOchPZDmt8z7gK2Hz41BtSeiiArhhlQRCaExGHEWMY6sIRsDlXHerYE+jqI3UgxdDVSS5FgZ7zSdx6Wu4HYXea9aJVaE/YKhdb+STv8mJ3O4peGQh+78+sJEjSqnJ9xxhVCmV9v7U1LOVVGXsXYqj/ze6pxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957176; c=relaxed/simple;
	bh=+pIQk7eCsmAdmtYHEwZZ8K6Ju4w7pztgt00SlhUg310=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EYgk4/GyIy75rzBhHp5Y4RcXI8eXzUEV4BUfaGplKRS70iB6/iC5mn+0tARsdIARsm3gfJlOa7E0TDGnXPv09ICxjClzaaJWTBulQ4VlOvpGTgfd9z8cOloie8PksypUll3KnaDsU72J1F9si8pscsLLc7ho7j4NPZw6Oc9GbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-27-JS3bqrNRMXmEnncm00apUg-1; Mon, 18 Nov 2024 19:12:51 +0000
X-MC-Unique: JS3bqrNRMXmEnncm00apUg-1
X-Mimecast-MFC-AGG-ID: JS3bqrNRMXmEnncm00apUg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:12:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:12:50 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: 'Arnd Bergmann' <arnd@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Jens Axboe' <axboe@kernel.dk>, "'Matthew
 Wilcox'" <willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
	'Andrew Morton' <akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, "'Jason A . Donenfeld'" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>, 'Mateusz Guzik'
	<mjguzik@gmail.com>, "'linux-mm@kvack.org'" <linux-mm@kvack.org>, "'Lorenzo
 Stoakes'" <lorenzo.stoakes@oracle.com>
Subject: [PATCH next 3/7] minmax.h: Reduce the #define expansion of min(),
 max() and clamp()
Thread-Topic: [PATCH next 3/7] minmax.h: Reduce the #define expansion of
 min(), max() and clamp()
Thread-Index: Ads57dnbMgzUo0QtRCKjFtFmfCRzXg==
Date: Mon, 18 Nov 2024 19:12:50 +0000
Message-ID: <051afc171806425da991908ed8688a98@AcuMS.aculab.com>
References: <c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com>
In-Reply-To: <c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: FKrpuodfHVbUk7k-sRSdAqDczdcfOLlDGpjvionMdxM_1731957170
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Since the test for signed values being non-negative only relies on
__builtion_constant_p() (not is_constexpr()) it can use the 'ux'
variable instead of the caller supplied expression.
This means that the #define parameters are only expanded twice.
Once in the code and once quoted in the error message.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 24e4b372649a..6f7ea669d305 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -46,10 +46,10 @@
  * comparison, and these expressions only need to be careful to not cause
  * warnings for pointer use.
  */
-#define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
-#define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
-#define __sign_use(x, ux) (is_signed_type(typeof(ux)) ? \
-=09__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
+#define __signed_type_use(ux) (2 + __is_nonneg(ux))
+#define __unsigned_type_use(ux) (1 + 2 * (sizeof(ux) < 4))
+#define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
+=09__signed_type_use(ux) : __unsigned_type_use(ux))
=20
 /*
  * Check whether a signed value is always non-negative.
@@ -71,13 +71,13 @@
 #else
   #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1=
LL, 1L))
 #endif
-#define __is_nonneg(x, ux) statically_true((__signed_type(ux))(x) >=3D 0)
+#define __is_nonneg(ux) statically_true((__signed_type(ux))(ux) >=3D 0)
=20
-#define __types_ok(x, y, ux, uy) \
-=09(__sign_use(x, ux) & __sign_use(y, uy))
+#define __types_ok(ux, uy) \
+=09(__sign_use(ux) & __sign_use(uy))
=20
-#define __types_ok3(x, y, z, ux, uy, uz) \
-=09(__sign_use(x, ux) & __sign_use(y, uy) & __sign_use(z, uz))
+#define __types_ok3(ux, uy, uz) \
+=09(__sign_use(ux) & __sign_use(uy) & __sign_use(uz))
=20
 #define __cmp_op_min <
 #define __cmp_op_max >
@@ -92,7 +92,7 @@
=20
 #define __careful_cmp_once(op, x, y, ux, uy) ({=09=09\
 =09__auto_type ux =3D (x); __auto_type uy =3D (y);=09\
-=09BUILD_BUG_ON_MSG(!__types_ok(x, y, ux, uy),=09\
+=09BUILD_BUG_ON_MSG(!__types_ok(ux, uy),=09=09\
 =09=09#op"("#x", "#y") signedness error");=09\
 =09__cmp(op, ux, uy); })
=20
@@ -109,7 +109,7 @@
 =09static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), =09\
 =09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09BUILD_BUG_ON_MSG(!__types_ok3(val, lo, hi, uval, ulo, uhi),=09=09\
+=09BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),=09=09=09=09\
 =09=09"clamp("#val", "#lo", "#hi") signedness error");=09=09\
 =09__clamp(uval, ulo, uhi); })
=20
@@ -149,7 +149,7 @@
=20
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({=09=09=09\
 =09__auto_type ux =3D (x); __auto_type uy =3D (y);__auto_type uz =3D (z);\
-=09BUILD_BUG_ON_MSG(!__types_ok3(x, y, z, ux, uy, uz),=09=09\
+=09BUILD_BUG_ON_MSG(!__types_ok3(ux, uy, uz),=09=09=09\
 =09=09#op"3("#x", "#y", "#z") signedness error");=09=09\
 =09__cmp(op, ux, __cmp(op, uy, uz)); })
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


