Return-Path: <linux-kernel+bounces-261091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893CC93B2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EAA28119D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93839158DC1;
	Wed, 24 Jul 2024 14:33:10 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FC1586DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831590; cv=none; b=GrTyLFFsEzHanx+H+bSXy13Wuh7d+LWEV9XcXdyUleHTurU0n0VwjDJIsT5WkyMvoxwxNRppB47MzpMVbV8nRqhkvJJenwKnGAcRIg0aIVuZtvB5Nr9oLJ8CM7ZZWRRnZ4P9y9IJjwIrIZNaEbx5Of0gF/UL3s6062wMkS2S2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831590; c=relaxed/simple;
	bh=QDy57ZVQoNG35uF/IJ1jWNERroyPlmeJLF5V2Pdwlk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OuS770DfQ8+65OkY+n53UCkcRQlJy7GOIBxzbBArE/sWsTmlcv3ioYT0YCtvspyyLSnmTuSJ0boit5Vp//i+EG+uQB88NEOBJSqIL1sHlSjHIphWPNkD46vMP2MhmlF8vZrka7kEg3oJUE2gC1vvvCZPtRg8qCDneGX6UJVQPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-401NOTxeOC-NAXlBON6hgw-1; Wed, 24 Jul 2024 15:33:03 +0100
X-MC-Unique: 401NOTxeOC-NAXlBON6hgw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:32:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:32:23 +0100
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
Subject: [PATCH 6/7] minmax: Optimise _Static_assert() check in clamp()
Thread-Topic: [PATCH 6/7] minmax: Optimise _Static_assert() check in clamp()
Thread-Index: Adrd1mBpxXCRV5VDT5OkO29yw5aIOQ==
Date: Wed, 24 Jul 2024 14:32:22 +0000
Message-ID: <46f446f61c4f4304b756e38a19782ed9@AcuMS.aculab.com>
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

Use __if_constexpr() instead of __builtin_choose_expr(__is_constexpr()).

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index e250957036a1..2fb63efbeb0e 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -139,8 +139,7 @@
 =09typeof(val) unique_val =3D (val);=09=09=09=09=09=09\
 =09typeof(lo) unique_lo =3D (lo);=09=09=09=09=09=09\
 =09typeof(hi) unique_hi =3D (hi);=09=09=09=09=09=09\
-=09_Static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
-=09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
+=09_Static_assert(__if_constexpr((lo) <=3D (hi), (lo) <=3D (hi), true),=09=
=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
 =09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
 =09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


