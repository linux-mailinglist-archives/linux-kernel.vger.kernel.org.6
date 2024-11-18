Return-Path: <linux-kernel+bounces-413409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2D9D18BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56070282DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482D1E5701;
	Mon, 18 Nov 2024 19:15:11 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA691E5027
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957311; cv=none; b=R6KCchUShmnzSoXaOpUXRH+LGDCp6pjFR5FRhpzsEW/RGk6WVm0P5fpdpjC0Rp3/556faDfY9a8Kt86eohygg9en1QS9aiDmv+2a7akKSVSl6sshRLF7/vK6KVD3tVqHRVGpFzTTiD2RaeD7hobZwKzj0/avynX8WbHH4zcYbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957311; c=relaxed/simple;
	bh=2EpvyN9CxJEj4ZXsu28zRv9w2icqPvbVOpd6OJzKK7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FiWZcdmUR3XRnmYTM4gEXXI0Ttw423z1Xa/T3T5OVETffKGStFxCXfvxUxi3wc7M+k8jMBqtJ2KRl/DMgAAugIaHT3X2FIUMjMVOTbX8Lxgs8b4t/Zcw1zhWjwflGh5mPfJ7pnK4NeZDIWZA2BqKtizRnZcxgHhxoxKGIZt7WNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-1-Li-56pJWM8mS-HZ_UNxcng-1; Mon, 18 Nov 2024 19:15:06 +0000
X-MC-Unique: Li-56pJWM8mS-HZ_UNxcng-1
X-Mimecast-MFC-AGG-ID: Li-56pJWM8mS-HZ_UNxcng
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:15:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:15:05 +0000
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
Subject: [PATCH next 6/7] minmax.h: Simplify the variants of clamp()
Thread-Topic: [PATCH next 6/7] minmax.h: Simplify the variants of clamp()
Thread-Index: Ads57ipn63eWKuUFSOOk3Sda6NOThQ==
Date: Mon, 18 Nov 2024 19:15:05 +0000
Message-ID: <8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: IMuDVPd0wJHazzc97IwBF5caQx74jK1M1gbO88qh3FI_1731957305
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Always pass a 'type' through to __clamp_once(), pass '__auto_type'
from clamp() itself.

The expansion of __types_ok3() is reasonable so it isn't worth the
added complexity of avoiding it when a fixed type is used for all
three values.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 75fb7a6ad4c6..2bbdd5b5e07e 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -183,29 +183,29 @@
 #define __clamp(val, lo, hi)=09\
 =09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))
=20
-#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({=09=09=09=09\
-=09__auto_type uval =3D (val);=09=09=09=09=09=09\
-=09__auto_type ulo =3D (lo);=09=09=09=09=09=09=09\
-=09__auto_type uhi =3D (hi);=09=09=09=09=09=09=09\
+#define __clamp_once(type, val, lo, hi, uval, ulo, uhi) ({=09=09=09\
+=09type uval =3D (val);=09=09=09=09=09=09=09\
+=09type ulo =3D (lo);=09=09=09=09=09=09=09\
+=09type uhi =3D (hi);=09=09=09=09=09=09=09\
 =09BUILD_BUG_ON_MSG(statically_true(ulo > uhi),=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
 =09BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),=09=09=09=09\
 =09=09"clamp("#val", "#lo", "#hi") signedness error");=09=09\
 =09__clamp(uval, ulo, uhi); })
=20
-#define __careful_clamp(val, lo, hi) \
-=09__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID=
(h_))
+#define __careful_clamp(type, val, lo, hi) \
+=09__clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNI=
QUE_ID(h_))
=20
 /**
- * clamp - return a value clamped to a given range with strict typecheckin=
g
+ * clamp - return a value clamped to a given range with typechecking
  * @val: current value
  * @lo: lowest allowable value
  * @hi: highest allowable value
  *
- * This macro does strict typechecking of @lo/@hi to make sure they are of=
 the
- * same type as @val.  See the unnecessary pointer comparisons.
+ * This macro checks @val/@lo/@hi to make sure they have compatible
+ * signedness.
  */
-#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
+#define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
=20
 /**
  * clamp_t - return a value clamped to a given range using a given type
@@ -217,7 +217,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo)=
, (type)(hi))
+#define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
=20
 /**
  * clamp_val - return a value clamped to a given range using val's type
@@ -230,7 +230,7 @@
  * type and @lo and @hi are literals that will otherwise be assigned a sig=
ned
  * integer type.
  */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+#define clamp_val(val, lo, hi) __careful_clamp(typeof(val), val, lo, hi)
=20
 /*
  * Do not check the array parameter using __must_be_array().
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


