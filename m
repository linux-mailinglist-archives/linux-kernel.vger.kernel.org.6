Return-Path: <linux-kernel+bounces-261087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BEA93B2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381AD1C214C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B5158A3C;
	Wed, 24 Jul 2024 14:31:38 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA64C6D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831497; cv=none; b=SF2Q2wsdsbjLVmMn/2LaxX2lYYJC70D2HyRJqSHnpyS2lcC5V1bgMaysoofDEUbF4UJFWipoVZUVIKpRqm45yIaDpvsO/XVfcBOW+r7AHZhqTkLJ4N2zz1Vvepe1EImog8HsWbJGJbWGaMdnqoCVIYZRkRW2QbkCBtechhBMPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831497; c=relaxed/simple;
	bh=oSxGQle+W5noOa3xjHkEranHgL72w3YI6tsrzK9FGF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MpBSlbtBCf1AnShM4g/TSQ1VjdQ3aUjY573wSQPTkrnCrVcamC5/VJR1i+YQyWZrU5qzE7NgMRKebkP4pO+Ay4ZGbsqAmhZiK1FlAzEClpZmaFfh6EVNDD7Wd0cJbvqM++L61WZjg3tGNnL6Ht9vSDeLjX+1kQGwFU6t/KX2fTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-45-vGdKy7opNf27HweZ6J__xg-1; Wed, 24 Jul 2024 15:31:32 +0100
X-MC-Unique: vGdKy7opNf27HweZ6J__xg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:30:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:30:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linuxfoundation.org>
CC: "'Matthew Wilcox (Oracle)'" <willy@infradead.org>, 'Christoph Hellwig'
	<hch@infradead.org>, 'Andrew Morton' <akpm@linux-foundation.org>, "'Andy
 Shevchenko'" <andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>, "'hch@infradead.org'"
	<hch@infradead.org>, "'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
	'Mateusz Guzik' <mjguzik@gmail.com>, "'linux-mm@kvack.org'"
	<linux-mm@kvack.org>
Subject: [PATCH 4/7] minmax: Simplify signedness check
Thread-Topic: [PATCH 4/7] minmax: Simplify signedness check
Thread-Index: Adrd1i0k/JcX2h1sSAO9D37F5HIFAA==
Date: Wed, 24 Jul 2024 14:30:52 +0000
Message-ID: <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
In-Reply-To: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
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

It is enough to check that both 'x' and 'y' are valid for either
a signed compare or an unsigned compare.
For unsigned they must be an unsigned type or a positive constant.
For signed they must be signed after unsigned char/short are promoted.

Order the expressions to avoid warnings about comparisons that are
always true.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 900eec7a28e5..d3ac65c1add7 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
=20
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
@@ -26,19 +26,17 @@
 #define __typecheck(x, y) \
 =09(!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
=20
-/* is_signed_type() isn't a constexpr for pointer types */
-#define __is_signed(x) =09=09=09=09=09=09=09=09\
-=09__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),=09\
-=09=09is_signed_type(typeof(x)), 0)
+/* Allow unsigned compares against non-negative signed constants. */
+#define __is_ok_unsigned(x) \
+=09((is_unsigned_type(typeof(x)) ? 0 : __if_constexpr(x, (x) + 0, -1)) >=
=3D 0)
=20
-/* True for a non-negative signed int constant */
-#define __is_noneg_int(x)=09\
-=09(__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >=3D=
 0)
+/* Check for signed after promoting unsigned char/short to int */
+#define __is_ok_signed(x) is_signed_type(typeof((x) + 0))
=20
-#define __types_ok(x, y) =09=09=09=09=09\
-=09(__is_signed(x) =3D=3D __is_signed(y) ||=09=09=09\
-=09=09__is_signed((x) + 0) =3D=3D __is_signed((y) + 0) ||=09\
-=09=09__is_noneg_int(x) || __is_noneg_int(y))
+/* Allow if both x and y are valid for either signed or unsigned compares.=
 */
+#define __types_ok(x, y)=09=09=09=09\
+=09((__is_ok_signed(x) && __is_ok_signed(y)) ||=09\
+=09 (__is_ok_unsigned(x) && __is_ok_unsigned(y)))
=20
 #define __cmp_op_min <
 #define __cmp_op_max >
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


