Return-Path: <linux-kernel+bounces-264588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD693E5AA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9601C20D1B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040B4AEE0;
	Sun, 28 Jul 2024 14:25:39 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952341A84
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176739; cv=none; b=Cxvc7nhfal3KnLtgyI5KJ5LaopnxEa/OMdzK9Vzsn9GiqgCDxLhbE4LO7nb3p3a7qtRYrlZJ1Vc+YJi2hALY3BakNZ/bGuBN7cGuZSxPdeC7rZUYC9VUaAfupxx39x8UIy2RJ3XoWnfCR0ISdVNPQfySGsHqP+en4as7Nd5IcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176739; c=relaxed/simple;
	bh=1dbgvmdaF1nAa6KOYKC34cBRcp6an9l5zjBHwas93PM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=i1YziI28lZQMqXmEZAbDSWlNrknG9e46qGmfNwySkKeuyjY1qnAypjSFB1lBjJ0Mk+bsAVJ6PNcfjurNGLjnePohDAxJuHxrCjy016rxa0a5Fecex5kfBGVgKm1tD0C0RrrBMFSnphQn2xLPOnognk2RQIea4H0K+TGDTwdtIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-225-Ran_uoH8NAunlrVN1XlTGw-1; Sun, 28 Jul 2024 15:25:31 +0100
X-MC-Unique: Ran_uoH8NAunlrVN1XlTGw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:24:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:24:46 +0100
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
Subject: [PATCH v2 8/8] minmax: minmax: Add __types_ok3() and optimise defines
 with 3 arguments
Thread-Topic: [PATCH v2 8/8] minmax: minmax: Add __types_ok3() and optimise
 defines with 3 arguments
Thread-Index: Adrg+fzAGOYJcfIuRPCxFJC4Oy7+aw==
Date: Sun, 28 Jul 2024 14:24:46 +0000
Message-ID: <75f18af7162c4414be28a890e9504c8d@AcuMS.aculab.com>
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

min3() and max3() were added to optimise nested min(x, min(y, z))
sequences, but only moved where the expansion was requested.

Add a separate implementation for 3 argument calls.
These are never required to generate constant expressiions so
remove that logic.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2 (was pacth 7/7):
- Use __auto_type.
- Use an extra __xy local to slightly reduce the expansion.
- Fix typos in the commit message.

 include/linux/minmax.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index cb3515824a64..e1e31a827547 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -41,6 +41,11 @@
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
@@ -93,13 +98,25 @@
  */
 #define umax(x, y)=09__careful_cmp(max, __zero_extend(x), __zero_extend(y)=
)
=20
+#define __cmp_once3(op, x, y, z, uniq) ({=09=09=09=09\
+=09__auto_type __x_##uniq =3D (x);=09=09=09=09=09\
+=09__auto_type __y_##uniq =3D (y);=09=09=09=09=09\
+=09__auto_type __z_##uniq =3D (z);=09=09=09=09=09\
+=09__auto_type __xy_##uniq =3D __cmp(op, __x_##uniq, __y_##uniq);=09\
+=09__cmp(op, __xy_##uniq, __z_##uniq); })
+
+#define __careful_cmp3(op, x, y, z, uniq) ({=09=09=09=09\
+=09_Static_assert(__types_ok3(x, y, z),=09=09=09=09\
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
@@ -107,7 +124,7 @@
  * @y: second value
  * @z: third value
  */
-#define max3(x, y, z) max((typeof(x))max(x, y), z)
+#define max3(x, y, z) __careful_cmp3(max, x, y, z, __COUNTER__)
=20
 /**
  * min_t - return minimum of two values, using the specified type
@@ -144,8 +161,7 @@
 =09__auto_type unique_hi =3D (hi);=09=09=09=09=09=09\
 =09_Static_assert(__if_constexpr((lo) <=3D (hi), (lo) <=3D (hi), true),=09=
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


