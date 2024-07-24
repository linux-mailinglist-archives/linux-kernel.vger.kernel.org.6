Return-Path: <linux-kernel+bounces-261093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E433B93B2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CA31C23853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244E158D8F;
	Wed, 24 Jul 2024 14:33:56 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB12D030
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831636; cv=none; b=L494222RoD1yP96sGal2a+6TSjdzwSRc3XLHbcw3QdzZKOuk0KZiZHDa66TWhbgQ/k4TokL75TmKT9thuV2N0p60uofZneyKNx9qV1dVSd3cI40G2wn/y0ouE9WxbFeorzbaIfisz7ztfaQYY2nkof8oxy6Hlzv6dsydqgbcHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831636; c=relaxed/simple;
	bh=jLnKvSZlPOAnSOf1fn/4TEqyIhl6sYZr0GkcFdPm6IY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YDJZynY4eUOwrybIDW6fmMBJ2793Z5Ict1+Uz59g30ye+B9FL+sXQYw+IS1vsLgUWzByvixnZSNE5zaq2pQD+Q4TGLVdo8Cy9vR+OCZkYrEhZFD4nxj1cReCnRiDo3OCkDkIGJfwz/8vvxtdKcT4SZ/+X0PdDq4oyN8FsyLs1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-eKrR_BFuOPKLqYqDBV76gg-1; Wed, 24 Jul 2024 15:33:51 +0100
X-MC-Unique: eKrR_BFuOPKLqYqDBV76gg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:33:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:33:11 +0100
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
Subject: [PATCH 7/7] minmax: minmax: Add __types_ok3() and optimise defines
 with 3 arguments
Thread-Topic: [PATCH 7/7] minmax: minmax: Add __types_ok3() and optimise
 defines with 3 arguments
Thread-Index: Adrd1nwhwSRYGwj9RxiIgqAQhw9FiA==
Date: Wed, 24 Jul 2024 14:33:11 +0000
Message-ID: <3484b7fcd2c74655bd685e5a7030c284@AcuMS.aculab.com>
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

min3() and max3() were added to optimise nested min(x, min(y, z))
sequences, bit only moved where the expansion was requiested.

Add a separate implementation for 3 argument calls.
These are never required to generate constant expressiions to
remove that logic.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 2fb63efbeb0e..4bbc82c589cf 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -38,6 +38,11 @@
 =09((__is_ok_signed(x) && __is_ok_signed(y)) ||=09\
 =09 (__is_ok_unsigned(x) && __is_ok_unsigned(y)))
=20
+/* Check three values for min3(), max3() and clamp() */
+#define __types_ok3(x, y, z)=09=09=09=09=09=09=09\
+=09((__is_ok_signed(x) && __is_ok_signed(y) && __is_ok_signed(z)) ||=09\
+=09 (__is_ok_unsigned(x) && __is_ok_unsigned(y) && __is_ok_unsigned(z)))
+
 #define __cmp_op_min <
 #define __cmp_op_max >
=20
@@ -90,13 +95,24 @@
  */
 #define umax(x, y)=09__careful_cmp(max, __zero_extend(x), __zero_extend(y)=
)
=20
+#define __cmp_once3(op, x, y, z, uniq) ({=09\
+=09typeof(x) __x_##uniq =3D (x);=09=09\
+=09typeof(x) __y_##uniq =3D (y);=09=09\
+=09typeof(x) __z_##uniq =3D (z);=09=09\
+=09__cmp(op, __cmp(op, __x_##uniq, __y_##uniq), __z_##uniq); })
+
+#define __careful_cmp3(op, x, y, z, uniq) ({=09=09=09=09\
+=09static_assert(__types_ok3(x, y, z),=09=09=09=09\
+=09=09#op "3(" #x ", " #y ", " #z ") signedness error");=09\
+=09__cmp_once3(op, x, y, z, uniq); })
+
 /**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
  * @z: third value
  */
-#define min3(x, y, z) min((typeof(x))min(x, y), z)
+#define min3(x, y, z) __careful_cmp3(min, x, y, z, __COUNTER__)
=20
 /**
  * max3 - return maximum of three values
@@ -104,7 +120,7 @@
  * @y: second value
  * @z: third value
  */
-#define max3(x, y, z) max((typeof(x))max(x, y), z)
+#define max3(x, y, z) __careful_cmp3(max, x, y, z, __COUNTER__)
=20
 /**
  * min_t - return minimum of two values, using the specified type
@@ -139,10 +155,9 @@
 =09typeof(val) unique_val =3D (val);=09=09=09=09=09=09\
 =09typeof(lo) unique_lo =3D (lo);=09=09=09=09=09=09\
 =09typeof(hi) unique_hi =3D (hi);=09=09=09=09=09=09\
-=09_Static_assert(__if_constexpr((lo) <=3D (hi), (lo) <=3D (hi), true),=09=
=09\
+=09_Static_assert(__if_constexpr((lo) <=3D (hi), (lo) <=3D (hi), true),=09=
\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
-=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
+=09_Static_assert(__types_ok3(val, lo, hi), "clamp() signedness error");=
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


