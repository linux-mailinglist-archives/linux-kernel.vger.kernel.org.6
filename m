Return-Path: <linux-kernel+bounces-261089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402693B2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A8285AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235E1586DB;
	Wed, 24 Jul 2024 14:32:30 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A241E50F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831550; cv=none; b=Y8WQkpqxNJC6o201bI8QHWC2unuzzMf6pzBQu1uiDKl16GIWhkNDTHSxw612MaVdkx2YDk/pedlIisW7qEPMP6SWHowtrUc0cy8A0BG4xWcBpT6ZJqxrYdLhjv+YDiUM/i7fWc2CugAXz2w5g6gUa+VFOZ9lNDxCgyg/T9UW5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831550; c=relaxed/simple;
	bh=uSPYPEqvPzAncnkNVy7BRec1JU2+johr/G+OLgn9r/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Jdreq/62RYKlURtgUOITBiiv9WQoX4UNIv0gZBGWJpPMpM0VwhhBNe3tNkAV4VSwMnQfiW31IB1p+0MoGjOJKf4PBGu94P7nIAzJrrgf/OLSi7Z7diuflc5JZRwXKrR7wqfqa0eKt72E9A6hdRHSzC+Y8vYz08ljIISzV3B/h7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-201-p-9t2K8xPV2o1h-xKKZUHA-1; Wed, 24 Jul 2024 15:32:25 +0100
X-MC-Unique: p-9t2K8xPV2o1h-xKKZUHA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:31:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:31:45 +0100
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
Subject: [PATCH 5/7] minmax: Factor out the zero-extension logic from
 umin/umax
Thread-Topic: [PATCH 5/7] minmax: Factor out the zero-extension logic from
 umin/umax
Thread-Index: Adrd1kXn5nCrisyjTAW42k9g3Yw8yA==
Date: Wed, 24 Jul 2024 14:31:45 +0000
Message-ID: <f19f6d98fba44c39b347f3c0fbb5bdba@AcuMS.aculab.com>
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

The '+ 0u + 0ul + 0ull' to zero extend to 64bit on both 32bit and
64bit systems was replicated 4 times.
Factor out and then join up some 'not overlong' lines.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index d3ac65c1add7..e250957036a1 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -28,7 +28,7 @@
=20
 /* Allow unsigned compares against non-negative signed constants. */
 #define __is_ok_unsigned(x) \
-=09((is_unsigned_type(typeof(x)) ? 0 : __if_constexpr(x, (x) + 0, -1)) >=
=3D 0)
+=09((is_unsigned_type(typeof(x)) ? 0 : __if_constexpr(x, x, -1)) >=3D 0)
=20
 /* Check for signed after promoting unsigned char/short to int */
 #define __is_ok_signed(x) is_signed_type(typeof((x) + 0))
@@ -69,22 +69,26 @@
  */
 #define max(x, y)=09__careful_cmp(max, x, y)
=20
+/*
+ * Zero extend a non-negative value to 64bits.
+ * Undefined for negative values.
+ * The extension to 64 bits is often optimised away.
+ */
+#define __zero_extend(x) ((x) + 0u + 0ul + 0ull)
+
 /**
  * umin - return minimum of two non-negative values
- *   Signed types are zero extended to match a larger unsigned type.
  * @x: first value
  * @y: second value
  */
-#define umin(x, y)=09\
-=09__careful_cmp(min, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
+#define umin(x, y)=09__careful_cmp(min, __zero_extend(x), __zero_extend(y)=
)
=20
 /**
  * umax - return maximum of two non-negative values
  * @x: first value
  * @y: second value
  */
-#define umax(x, y)=09\
-=09__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
+#define umax(x, y)=09__careful_cmp(max, __zero_extend(x), __zero_extend(y)=
)
=20
 /**
  * min3 - return minimum of three values
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


