Return-Path: <linux-kernel+bounces-413407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA579D18BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7056C282D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A381E47D7;
	Mon, 18 Nov 2024 19:13:38 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774121DED7D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957218; cv=none; b=rCQb/jX9XLJIDQ1gNMrftFW6odkhFHhIiblOf2RHdUr0lvOzQtH7GrhHsahj454hcwG8DtQt4Xw9oTNOsjTi6NgBUZ8nbRTxppsV25Uf7YbdeDBmBD9HJTxHaFUoWjEqtwMiUeziLBiG5IwhWLFE55fkXH6EzMS2Ro5DR5OEMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957218; c=relaxed/simple;
	bh=DLnsRHfCjtWxXwmCaXLQoT++BY50b46si2gHIz+U13M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VzV8bI3VD4SzXdMKdW7UcOIzWeni1KgoT6ZELT2+YNCPewO3uqpEi9pvG2TXjDaDQEEpJrChGjkPldNlpH/nPSheSuKY9oZNrWGy+ozX+tyO7ZgNDwQW6RDaf1s5hPodhsemx94/Wgx1hvCZSdrNXp+XiO75TR5VZhDzLJIb2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-53-8QuoD1GfPLOo-8Il3CnRIg-1; Mon, 18 Nov 2024 19:13:33 +0000
X-MC-Unique: 8QuoD1GfPLOo-8Il3CnRIg-1
X-Mimecast-MFC-AGG-ID: 8QuoD1GfPLOo-8Il3CnRIg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:13:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:13:32 +0000
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
Subject: [PATCH next 4/7] minmax.h: Use BUILD_BUG_ON_MSG() for the lo < hi
 test in clamp()
Thread-Topic: [PATCH next 4/7] minmax.h: Use BUILD_BUG_ON_MSG() for the lo <
 hi test in clamp()
Thread-Index: Ads57fNMrPBo0VpjT1C2YVoqcr+8eA==
Date: Mon, 18 Nov 2024 19:13:31 +0000
Message-ID: <34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: u9LLKLreo8Fks-0AXKgDSoDVajyEvVsE3UfH5cSYJGw_1731957212
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Use BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...) for the sanity
check of the bounds in clamp().
Gives better error coverage and one less expansion of the arguments.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 6f7ea669d305..91aa1b90c1bb 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -106,8 +106,7 @@
 =09__auto_type uval =3D (val);=09=09=09=09=09=09\
 =09__auto_type ulo =3D (lo);=09=09=09=09=09=09=09\
 =09__auto_type uhi =3D (hi);=09=09=09=09=09=09=09\
-=09static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), =09\
-=09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
+=09BUILD_BUG_ON_MSG(statically_true(ulo > uhi),=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
 =09BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),=09=09=09=09\
 =09=09"clamp("#val", "#lo", "#hi") signedness error");=09=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


