Return-Path: <linux-kernel+bounces-413408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33A9D18BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145141F21DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B61E130F;
	Mon, 18 Nov 2024 19:14:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3614D2A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957265; cv=none; b=MqQUvWu5ea54davVIYVg7g+i1t6VgFKXvaXY88CDbJU4tDLbflwb4Z280nep6RDIT0gzihQMBzdhVoUXKS5KWKQDU04ywy4TD9rFcqH0lS2RR6QFWnDbNDwG5NcCCErhCN0Hg64x9kVp+eW3oPq/6xHxZPEn5Go8lA8hiXUmNJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957265; c=relaxed/simple;
	bh=HLZzrJGkihk3afAURm6BY68sSbtigQ/gZHwBqyIDgHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UXKst5FQunatMJaCYawmHKGcIM3SSH/mc8Y18xHiB7HWuR8l4/vQCVyR9oUKuggqfzVYWNQ0HKOQvdYDgy09n2zlczqE/Pv4UwsNwOFX+OdzhIdXeZZEAdKywnSESdAEjJHwZ9HTAkz54+OMBgA+shFSoaZJlRJurLEuGOXdDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-uKPs-5wQMmmpgcJGIGanNA-1; Mon, 18 Nov 2024 19:14:20 +0000
X-MC-Unique: uKPs-5wQMmmpgcJGIGanNA-1
X-Mimecast-MFC-AGG-ID: uKPs-5wQMmmpgcJGIGanNA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:14:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:14:19 +0000
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
Subject: [PATCH next 5/7] minmax.h: Move all the clamp() definitions after the
 min/max() ones
Thread-Topic: [PATCH next 5/7] minmax.h: Move all the clamp() definitions
 after the min/max() ones
Thread-Index: Ads57g96P3rlqjRlR9q8btqd7zczRA==
Date: Mon, 18 Nov 2024 19:14:19 +0000
Message-ID: <8bb285818e4846469121c8abc3dfb6e2@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: uc7qQ6H89YjbJ4HFo8UV6S-jTIe36nAJAKGHSLqBA0w_1731957259
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

At some point the definitions for clamp() got added in the middle
of the ones for min() and max().
Re-order the definitions so they are more sensibly grouped.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 109 +++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 91aa1b90c1bb..75fb7a6ad4c6 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -99,22 +99,6 @@
 #define __careful_cmp(op, x, y) \
 =09__careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
=20
-#define __clamp(val, lo, hi)=09\
-=09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))
-
-#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({=09=09=09=09\
-=09__auto_type uval =3D (val);=09=09=09=09=09=09\
-=09__auto_type ulo =3D (lo);=09=09=09=09=09=09=09\
-=09__auto_type uhi =3D (hi);=09=09=09=09=09=09=09\
-=09BUILD_BUG_ON_MSG(statically_true(ulo > uhi),=09=09=09=09\
-=09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),=09=09=09=09\
-=09=09"clamp("#val", "#lo", "#hi") signedness error");=09=09\
-=09__clamp(uval, ulo, uhi); })
-
-#define __careful_clamp(val, lo, hi) \
-=09__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID=
(h_))
-
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
@@ -170,6 +154,22 @@
 #define max3(x, y, z) \
 =09__careful_op3(max, x, y, z, __UNIQUE_ID(x_), __UNIQUE_ID(y_), __UNIQUE_=
ID(z_))
=20
+/**
+ * min_t - return minimum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define min_t(type, x, y) __cmp_once(min, type, x, y)
+
+/**
+ * max_t - return maximum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define max_t(type, x, y) __cmp_once(max, type, x, y)
+
 /**
  * min_not_zero - return the minimum that is _not_ zero, unless both are z=
ero
  * @x: value1
@@ -180,6 +180,22 @@
 =09typeof(y) __y =3D (y);=09=09=09\
 =09__x =3D=3D 0 ? __y : ((__y =3D=3D 0) ? __x : min(__x, __y)); })
=20
+#define __clamp(val, lo, hi)=09\
+=09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))
+
+#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({=09=09=09=09\
+=09__auto_type uval =3D (val);=09=09=09=09=09=09\
+=09__auto_type ulo =3D (lo);=09=09=09=09=09=09=09\
+=09__auto_type uhi =3D (hi);=09=09=09=09=09=09=09\
+=09BUILD_BUG_ON_MSG(statically_true(ulo > uhi),=09=09=09=09\
+=09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
+=09BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),=09=09=09=09\
+=09=09"clamp("#val", "#lo", "#hi") signedness error");=09=09\
+=09__clamp(uval, ulo, uhi); })
+
+#define __careful_clamp(val, lo, hi) \
+=09__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID=
(h_))
+
 /**
  * clamp - return a value clamped to a given range with strict typecheckin=
g
  * @val: current value
@@ -191,28 +207,30 @@
  */
 #define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
=20
-/*
- * ..and if you can't take the strict
- * types, you can specify one yourself.
- *
- * Or not use min/max/clamp at all, of course.
- */
-
 /**
- * min_t - return minimum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
+ * clamp_t - return a value clamped to a given range using a given type
+ * @type: the type of variable to use
+ * @val: current value
+ * @lo: minimum allowable value
+ * @hi: maximum allowable value
+ *
+ * This macro does no typechecking and uses temporary variables of type
+ * @type to make all the comparisons.
  */
-#define min_t(type, x, y) __cmp_once(min, type, x, y)
+#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo)=
, (type)(hi))
=20
 /**
- * max_t - return maximum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
+ * clamp_val - return a value clamped to a given range using val's type
+ * @val: current value
+ * @lo: minimum allowable value
+ * @hi: maximum allowable value
+ *
+ * This macro does no typechecking and uses temporary variables of whateve=
r
+ * type the input argument @val is.  This is useful when @val is an unsign=
ed
+ * type and @lo and @hi are literals that will otherwise be assigned a sig=
ned
+ * integer type.
  */
-#define max_t(type, x, y) __cmp_once(max, type, x, y)
+#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
=20
 /*
  * Do not check the array parameter using __must_be_array().
@@ -257,31 +275,6 @@
  */
 #define max_array(array, len) __minmax_array(max, array, len)
=20
-/**
- * clamp_t - return a value clamped to a given range using a given type
- * @type: the type of variable to use
- * @val: current value
- * @lo: minimum allowable value
- * @hi: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of type
- * @type to make all the comparisons.
- */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo)=
, (type)(hi))
-
-/**
- * clamp_val - return a value clamped to a given range using val's type
- * @val: current value
- * @lo: minimum allowable value
- * @hi: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of whateve=
r
- * type the input argument @val is.  This is useful when @val is an unsign=
ed
- * type and @lo and @hi are literals that will otherwise be assigned a sig=
ned
- * integer type.
- */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
-
 static inline bool in_range64(u64 val, u64 start, u64 len)
 {
 =09return (val - start) < len;
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


