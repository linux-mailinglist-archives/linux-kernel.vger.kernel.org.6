Return-Path: <linux-kernel+bounces-264583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0793E5A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D28B21A03
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ADF46434;
	Sun, 28 Jul 2024 14:20:44 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EA224DC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176443; cv=none; b=hRLV1RSg5t/SlV20MyKO/d3CWw5gy48/3XY4OqLb7A0G1Cbav46gMIEH6IJXJxEZQ8K5zi58AZQ15P2xGbGBqTHvUcdDVtNnEzyHzx5zSl0ulinst+UK65L7DanEzY5QMA+WgM4km49N8b7/OxcXUGcYnTkV1qTnWNXwUxa5aOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176443; c=relaxed/simple;
	bh=DCcbZwPczLti18O5aV/kiKBtWPntq5y66aaO5tNPqbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mnoJLNzOg/fHl/txfBBRyyGAP8s7yr3y/h0XM9YPkXV83qv4Y/fzWggKWg8wd6qTa3g0xUk7ruiOG6biBa3W4eTSia2xIixEK8MY9hHFB+jxzPv/+U8jgtObc3+3YZ3ji2ODVZn968cP6UYtl2sEGVd0Pj6Gv2e7vs0F/A86s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-176-ASX4DscfNW6QCi1PP5Mc6g-1; Sun, 28 Jul 2024 15:20:36 +0100
X-MC-Unique: ASX4DscfNW6QCi1PP5Mc6g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:19:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:19:52 +0100
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
Subject: [PATCH v2 3/8] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Topic: [PATCH v2 3/8] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Index: Adrg+UWL9B3xHw3xQ5CeKplMo1TYvg==
Date: Sun, 28 Jul 2024 14:19:52 +0000
Message-ID: <2e12aefe29884e578283129411e1df26@AcuMS.aculab.com>
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

__if_constexpr(expr, if_const, if_not_const) returns 'if_const' if 'expr'
is a 'constant integer expression' otherwise 'if_not_const'.
The two values may have different types.

__is_constexpr(expr) is equivalent to __if_constexpr(expr, 1, 0).

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2:
- Don't change __is_constexpr()

 include/linux/compiler.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2594553bb30b..35d5b2fa4786 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,6 +242,23 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)=09BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
=20
+/**
+ * __if_constexpr - Check whether an expression is an 'integer
+ *=09=09constant expression'
+ * @expr: Expression to test, not evaluated, can be a pointer
+ * @if_const: return value if constant
+ * @if_not_const: return value if not constant
+ *
+ * The return values @if_const and @if_not_const can have different types.
+ *
+ * Relies on typeof(x ? NULL : ptr_type) being ptr_type and
+ * typeof(x ? (void *)y : ptr_type) being 'void *'.
+ */
+#define __if_constexpr(expr, if_const, if_not_const)=09=09\
+       _Generic(0 ? ((void *)((long)(expr) * 0l)) : (char *)0,=09\
+=09=09char *: (if_const),=09=09=09=09\
+=09=09void *: (if_not_const))
+
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument=
.
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


