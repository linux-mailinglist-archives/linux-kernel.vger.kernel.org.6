Return-Path: <linux-kernel+bounces-261086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AAE93B2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CB61F2493F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C95158A3C;
	Wed, 24 Jul 2024 14:30:38 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41D158DC1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831437; cv=none; b=Lf+SYFVnn/U22cnSS21cjDuv/fbU59KhZoJ6bjtv2sj2R6nf9ZkSBnuBy0gOCKQGHvgVnKS/A3uaCOkEROxepTAluhyqwv819VR6fKgShLtt7pcyWQdOkMjyEeQkLPSqdtUomSx49UsV/8iR+bvcOziU1aoKC9w8KU4Gi81ROFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831437; c=relaxed/simple;
	bh=AaKdN6HcqgfCCFAVvz/Al+Lrum6JH6Mv01fYiGr+egQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cyFpKrH9dV2ihFoyQTEcypZfO5+XIoskyC9rf3aC9oCgrA+QK2u794whEphBtNEFQNeK721OfZEEEU00VOpYs+Y45nnK2rgF7oS2k8DFt8k9xr7AKOb3NJHCueBQHw1fEX+y+BbTd4yDDDOF+WPpbr3GCBsWJaidfYXGU7Nu4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-178-jMukQN13NBi_V9QrS7w-jQ-1; Wed, 24 Jul 2024 15:30:32 +0100
X-MC-Unique: jMukQN13NBi_V9QrS7w-jQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:29:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:29:52 +0100
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
Subject: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Topic: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Index: Adrd1gZ7oS190yPcQj+hKNIa4uSuaQ==
Date: Wed, 24 Jul 2024 14:29:52 +0000
Message-ID: <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
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

__if_constexpr(expr, if_const, if_not_const) returns 'if_const' if 'expr'
is a 'constant integer expression' otherwise 'if_not_const'.
The two values may have different types.

Redefine __is_constextpr(expr) as __if_constexpr(expr, 1, 0).

Implemented using _Generic() for portibility.

Add proper kerndoc comments.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/compiler.h | 65 +++++++++++++---------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2594553bb30b..7d559e390011 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,52 +242,29 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)=09BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
=20
-/*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument=
.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+/**
+ * __if_constexpr - Check whether an expression is an 'integer
+ *=09=09constant expression'=20
+ * @expr: Expression to test, not evaluated, can be a pointer
+ * @if_const: return value if constant
+ * @if_not_const: return value if not constant
+ *
+ * The return values @if_const and @if_not_const can have different types.
  *
- * Details:
- * - sizeof() return an integer constant expression, and does not evaluate
- *   the value of its operand; it only examines the type of its operand.
- * - The results of comparing two integer constant expressions is also
- *   an integer constant expression.
- * - The first literal "8" isn't important. It could be any literal value.
- * - The second literal "8" is to avoid warnings about unaligned pointers;
- *   this could otherwise just be "1".
- * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
- *   architectures.
- * - The C Standard defines "null pointer constant", "(void *)0", as
- *   distinct from other void pointers.
- * - If (x) is an integer constant expression, then the "* 0l" resolves
- *   it into an integer constant expression of value 0. Since it is cast t=
o
- *   "void *", this makes the second operand a null pointer constant.
- * - If (x) is not an integer constant expression, then the second operand
- *   resolves to a void pointer (but not a null pointer constant: the valu=
e
- *   is not an integer constant 0).
- * - The conditional operator's third operand, "(int *)8", is an object
- *   pointer (to type "int").
- * - The behavior (including the return type) of the conditional operator
- *   ("operand1 ? operand2 : operand3") depends on the kind of expressions
- *   given for the second and third operands. This is the central mechanis=
m
- *   of the macro:
- *   - When one operand is a null pointer constant (i.e. when x is an inte=
ger
- *     constant expression) and the other is an object pointer (i.e. our
- *     third operand), the conditional operator returns the type of the
- *     object pointer operand (i.e. "int *"). Here, within the sizeof(), w=
e
- *     would then get:
- *       sizeof(*((int *)(...))  =3D=3D sizeof(int)  =3D=3D 4
- *   - When one operand is a void pointer (i.e. when x is not an integer
- *     constant expression) and the other is an object pointer (i.e. our
- *     third operand), the conditional operator returns a "void *" type.
- *     Here, within the sizeof(), we would then get:
- *       sizeof(*((void *)(...)) =3D=3D sizeof(void) =3D=3D 1
- * - The equality comparison to "sizeof(int)" therefore depends on (x):
- *     sizeof(int) =3D=3D sizeof(int)     (x) was a constant expression
- *     sizeof(int) !=3D sizeof(void)    (x) was not a constant expression
+ * Relies on typeof(x ? NULL : ptr_type) being ptr_type and
+ * typeof(x ? (void *)y : ptr_type) being 'void *'.
+ */
+#define __if_constexpr(expr, if_const, if_not_const)=09=09\
+=09_Generic(0 ? ((void *)((long)(expr) * 0l)) : (char *)0,=09\
+=09=09char *: (if_const),=09=09=09=09\
+=09=09void *: (if_not_const))
+
+/**
+ * __is_constexpr - Return 1 for an 'integer constant expression'
+ *=09=090 otherwise.
+ * @expr: expression to check, not evaluated
  */
-#define __is_constexpr(x) \
-=09(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)=
))
+#define __is_constexpr(expr) __if_constexpr((expr), 1, 0)
=20
 /*
  * Whether 'type' is a signed type or an unsigned type. Supports scalar ty=
pes,
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


