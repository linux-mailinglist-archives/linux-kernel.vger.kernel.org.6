Return-Path: <linux-kernel+bounces-264585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9962293E5A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD467B20A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF847F6B;
	Sun, 28 Jul 2024 14:22:24 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C939FFE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176544; cv=none; b=KNdYSQ9dxWc7LVM+JYy3zUk9LPmN7jQ4wIQZrcqItTLxO9Z2n+tpymVufsZ81/IumCYCMemfW1jLk57MoLjeWtjJFLIAP2HXPX0VyERRDVcClUo7Dcwhw11A7gnRiaqVAXvtuEeI9K0C5jOjQ/6wf2bnVcgozDQBpDMP9K306ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176544; c=relaxed/simple;
	bh=dTucdDYiXIZVZl/15Og0dB3SqMzYWkLnvO7HIcNkJR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=boHBpc2A+muOP7NnmngCpxJGLzIhDv/cztqb2Tzab2+4bMH2rG7vZ/X5qUjkaezshN3U0CceHdYs2I4BYj6gHlXagR+PtvvNLo/1ZEewN7J15YMY0166rXy+aMTuvCLT2EzagU0LKPVpEJWjjpu9ewRtypSSV0+GWY5L1MYWWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-55-06CRokqUOX-KjYRbAhL1jw-1; Sun, 28 Jul 2024 15:22:11 +0100
X-MC-Unique: 06CRokqUOX-KjYRbAhL1jw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:21:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:21:27 +0100
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
Subject: [PATCH v2 5/8] minmax: Factor out the zero-extension logic from
 umin/umax.
Thread-Topic: [PATCH v2 5/8] minmax: Factor out the zero-extension logic from
 umin/umax.
Thread-Index: Adrg+YXyDMjC+R5zRZ+wfV++JCCsqA==
Date: Sun, 28 Jul 2024 14:21:27 +0000
Message-ID: <3e11fa68f33b4fb5beec1fc3f41b123e@AcuMS.aculab.com>
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

The '+ 0u + 0ul + 0ull' to zero extend to 64bit on both 32bit and
64bit systems was replicated 4 times.
Factor out and then join up some 'not overlong' lines.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2 - no change

 include/linux/minmax.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index b9b5348a3879..a0c948ad576d 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -72,22 +72,26 @@
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


