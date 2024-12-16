Return-Path: <linux-kernel+bounces-447084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B79F2D22
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5048166469
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05256201100;
	Mon, 16 Dec 2024 09:40:39 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3AB347B4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342038; cv=none; b=RAUxAG9NVq1t0SWG7HG9mpuW4r7xKiSqvdpuy8b4fL56Py/BBf7sE5Ae/rL4NXxPFDFV4nj96D/nIQkSk6ORvr+RjnnD7nES8oXEstpzWUBtvpUVEBfDLWpMcGK4g1ZyIFfohReu8+8ZbtTwtsDVjclIa4NN8dvVZDNNDytzszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342038; c=relaxed/simple;
	bh=bHpJIiI25LZeZz/ihOtAculOrCMKvYHHdeszr+Hs0oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/ryfa3EuzwbUNVumoRadwOlgC3vPFwNm8b3pbxcGdFnXkmGJQ+5+IMARsWD2iFzYRs25BAsqKowaoOldAPSHogJhHTv5E3rN4T9XBqpnDO5LHWLmzYF+UT1y6pXctgAC9JF92U+4O97dr5ycMsFvOCSB3RTFDRKN30oxLXA9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-fTsEXnYoOaqeiluB3YywZw-1; Mon, 16 Dec 2024 09:40:28 +0000
X-MC-Unique: fTsEXnYoOaqeiluB3YywZw-1
X-Mimecast-MFC-AGG-ID: fTsEXnYoOaqeiluB3YywZw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Dec
 2024 09:39:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 16 Dec 2024 09:39:24 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Yury
 Norov'" <yury.norov@gmail.com>, 'Rasmus Villemoes' <linux@rasmusvillemoes.dk>
CC: 'Andrew Morton' <akpm@linux-foundation.org>, 'Masahiro Yamada'
	<masahiroy@kernel.org>, 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>,
	'Linus Torvalds' <torvalds@linux-foundation.org>
Subject: [PATCH v2 next] linux/bits.h: Simplify GENMASK()
Thread-Topic: [PATCH v2 next] linux/bits.h: Simplify GENMASK()
Thread-Index: AdtPnhh6INCU27N6T4uBovATuONM6w==
Date: Mon, 16 Dec 2024 09:39:23 +0000
Message-ID: <7a1b1534e51342769740985db773d5e1@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: G0lalmA_GGbq46JAyjt1xxOZ8KX9cOGOdj35DS61kg0_1734342027
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Change 95b980d62d52c replaced ~0ul and ~0ull with ~UL(0) and ~ULL(0)
in the GENMASK() defines as part of a change to allow the bitops
definitions be used from assembly.

The definitions have since been moved to a uapi header which
probably shouldn't require some other header be included first.

The definition of __GENMASK() is also overcomplicated partially
due to avoiding overflow warnings from shifting ~0u left.

Implement GENMASK() using the simpler (1u << hi) * 2 - (1u << lo) formula.
This doesn't rely on right shifts and doesn't need to know the number
of bits in the integral type.
It can be used for different types by just changing the type of the 1u.
__GENMASK() __GENMASK_ULL() and __GENMASK_U128() can now implemeted
using a single ___GENMASK(one, hi, lo).

Overflow warnings (from shifting out the MSB) are avoided by subtracting 1
before the multiply and adding two back in later.
The complers see straight through the subterfuge when generating code.

Since there are already conditionals for ASSEMBLY in bits.h, for ASSEMBLY
directly expand GENMASK() and GENMASK_ULL() as ___GENMASK(1, hi, lo)
rather than through the __GENMASK() and __GENMASK_ULL() uapi defines.
Remove the UL(x) and ULL(x) from the uapi file.

GENMASK() and GENMASK_ULL() now generate the correct values when
ASSEMBLY is defined.
Fortunately they've never been used.

Rename 'h' to 'hi' and 'l' to 'lo' because 'l' looks like '1' in many fonts=
.

Signed-off-by: David Laight <david.laight@aculab.com>
---

v2: '__uint128' =3D> 'unsigned __int128'

 include/linux/bits.h      | 43 ++++++++++++++++-----------------------
 include/uapi/linux/bits.h | 15 +++++++-------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 60044b608817..d5cf0ec22e43 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -14,41 +14,32 @@
 #define BITS_PER_BYTE=09=098
=20
 /*
- * Create a contiguous bitmask starting at bit position @l and ending at
- * position @h. For example
+ * Create a contiguous bitmask starting at bit position @lo and ending at
+ * position @hi. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #if !defined(__ASSEMBLY__)
 #include <linux/build_bug.h>
-#define GENMASK_INPUT_CHECK(h, l) \
+#define GENMASK_INPUT_CHECK(hi, lo) \
 =09(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-=09=09__is_constexpr((l) > (h)), (l) > (h), 0)))
-#else
-/*
- * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
- * disable the input check if that is the case.
- */
-#define GENMASK_INPUT_CHECK(h, l) 0
-#endif
+=09=09__is_constexpr((lo) > (hi)), (lo) > (hi), 0)))
=20
-#define GENMASK(h, l) \
-=09(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-#define GENMASK_ULL(h, l) \
-=09(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+#define GENMASK(hi, lo) \
+=09(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK(hi, lo))
+#define GENMASK_ULL(hi, lo) \
+=09(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_ULL(hi, lo))
=20
-#if !defined(__ASSEMBLY__)
+#define GENMASK_U128(hi, lo) \
+=09(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
+#else
 /*
- * Missing asm support
- *
- * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __init128' data
- * type instead of direct representation of 128 bit constants
- * such as long and unsigned long. The fundamental problem is
- * that a 128 bit constant will get silently truncated by the
- * gcc compiler.
+ * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
+ * 128bit exprssions don't work, neither can C 0UL (etc) constants be used=
.
+ * These definitions only have to work for constants and don't require
+ * that ~0 have any specific number of set bits.
  */
-#define GENMASK_U128(h, l) \
-=09(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
+#define GENMASK(hi, lo) ___GENMASK(1, hi, lo)
+#define GENMASK_ULL(hi, lo) ___GENMASK(1, hi, lo)
 #endif
=20
 #endif=09/* __LINUX_BITS_H */
diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 5ee30f882736..a25d9dfb7072 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -4,15 +4,14 @@
 #ifndef _UAPI_LINUX_BITS_H
 #define _UAPI_LINUX_BITS_H
=20
-#define __GENMASK(h, l) \
-        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
-         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
+/* Result is '(1u << (hi + 1)) - (1u << lo)' coded to avoid overflow. */
+#define ___GENMASK(one, hi, lo) \
+=09((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
=20
-#define __GENMASK_ULL(h, l) \
-        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
-         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
+#define __GENMASK(hi, lo) ___GENMASK(1UL, hi, lo)
=20
-#define __GENMASK_U128(h, l) \
-=09((_BIT128((h)) << 1) - (_BIT128(l)))
+#define __GENMASK_ULL(hi, lo) ___GENMASK(1ULL, hi, lo)
+
+#define __GENMASK_U128(hi, lo) ___GENMASK((unsigned __int128)1, hi, lo)
=20
 #endif /* _UAPI_LINUX_BITS_H */
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


