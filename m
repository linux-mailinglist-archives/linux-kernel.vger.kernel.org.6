Return-Path: <linux-kernel+bounces-413410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E109D18BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4C1B2132F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE11DED7D;
	Mon, 18 Nov 2024 19:15:56 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131B17597
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957356; cv=none; b=nrCHEzdTQ7cSMMwRy57LnZ/U0HeR69wto5vHuog42Btb2/Lh8sMLMojPuEdQcshj31Z9gO8+igGij2qkc9blsu3Nsnt+MKsXsTdHv+quzsm70JQmIBWp9UOQqz/0mSuS2a72PEp8ePh9pJ/eqs8GIirRYlFagSlpcbynJTFEC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957356; c=relaxed/simple;
	bh=igb3jrCi8N0kaaUYkWu8zs4q28/tALgnxPMV8XGKQDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ao7W2hzv0n5YNvYg+LNvz+Dw+mMtmkQ7/eVSnDfXP80hXVU0MDBDrNI1J+ZIW+FhDaaDdbF9bFNG8DD09WxmnYOoLVp4b78a6gJi+KpbHugtJZHbRFDHsSxzkF0tJBYcHAtYGFH9B4K7tRO7nXpdfOjWpIz6wuzAscxEqh4qwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-53-13-iqr8aPEKNwrfrKL2jEg-1; Mon, 18 Nov 2024 19:15:52 +0000
X-MC-Unique: 13-iqr8aPEKNwrfrKL2jEg-1
X-Mimecast-MFC-AGG-ID: 13-iqr8aPEKNwrfrKL2jEg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:15:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:15:51 +0000
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
Subject: [PATCH next 7/7] minmax.h: Remove some #defines that are only
 expanded once
Thread-Topic: [PATCH next 7/7] minmax.h: Remove some #defines that are only
 expanded once
Thread-Index: Ads57kK39EnzR0zLSLWjfI7GoDxEdQ==
Date: Mon, 18 Nov 2024 19:15:51 +0000
Message-ID: <9386d1ebb8974fbabbed2635160c3975@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: LVEWnDLR-vaMMGf6-ZUy3MlpKY_mO9TXxlpyV8RKvwY_1731957351
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The bodies of __signed_type_use() and __unsigned_type_use() are
much the same size as their names - so put the bodies in the only
line that expands them.

Similarly __signed_type() is defined separately for 64bit and then
used exactly once just below.

Change the test for __signed_type from CONFIG_64BIT to one based
on gcc defined macros so that the code is valid if it gets used
outside of a kernel build.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 2bbdd5b5e07e..eaaf5c008e4d 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -46,10 +46,8 @@
  * comparison, and these expressions only need to be careful to not cause
  * warnings for pointer use.
  */
-#define __signed_type_use(ux) (2 + __is_nonneg(ux))
-#define __unsigned_type_use(ux) (1 + 2 * (sizeof(ux) < 4))
 #define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
-=09__signed_type_use(ux) : __unsigned_type_use(ux))
+=09(2 + __is_nonneg(ux)) : (1 + 2 * (sizeof(ux) < 4)))
=20
 /*
  * Check whether a signed value is always non-negative.
@@ -57,7 +55,7 @@
  * A cast is needed to avoid any warnings from values that aren't signed
  * integer types (in which case the result doesn't matter).
  *
- * On 64-bit any integer or pointer type can safely be cast to 'long'.
+ * On 64-bit any integer or pointer type can safely be cast to 'long long'=
.
  * But on 32-bit we need to avoid warnings about casting pointers to integ=
ers
  * of different sizes without truncating 64-bit values so 'long' or 'long =
long'
  * must be used depending on the size of the value.
@@ -66,12 +64,12 @@
  * them, but we do not use s128 types in the kernel (we do use 'u128',
  * but they are handled by the !is_signed_type() case).
  */
-#ifdef CONFIG_64BIT
-  #define __signed_type(ux) long
+#if __SIZEOF_POINTER__ =3D=3D __SIZEOF_LONG_LONG__
+#define __is_nonneg(ux) statically_true((long long)(ux) >=3D 0)
 #else
-  #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1=
LL, 1L))
+#define __is_nonneg(ux) statically_true( \
+=09(typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L)))(ux) >=3D 0)
 #endif
-#define __is_nonneg(ux) statically_true((__signed_type(ux))(ux) >=3D 0)
=20
 #define __types_ok(ux, uy) \
 =09(__sign_use(ux) & __sign_use(uy))
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


