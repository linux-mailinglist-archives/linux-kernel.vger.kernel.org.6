Return-Path: <linux-kernel+bounces-264586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB32693E5A7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029F51C20C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82DA47F6B;
	Sun, 28 Jul 2024 14:23:09 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF339FFE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176589; cv=none; b=qbiCB2DJUWNfcPXL7VC2kZL1K9/BGF9ZeKVOrTrDh5tgyndPVrwN4KWMA14OctL4sJRNPQd4JTygG4+7gqI+kHWLmpTN1jDRiPQNn4Y2QNbq49njjYhmHBTLVO4ZUL0h1Wmun3+7tJvFwiW2w5xR/kV06IlASfmolWmgeVKtdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176589; c=relaxed/simple;
	bh=0tAgnZnNa7Oxzz94ggec/aR6GTvZMg8hnsCjUYlG5YQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=d5mO9JqIbNhq3vwgzj/INAMhjq34+6YqFRhyJUVboRcj2TS9zvv3kWDRHuLn3BA367NUC1ixdN7vnl7k2h1khog1r2cwUo4MB0o5LRjPe6tbgFRl45nPCS3D60fEWzDxMzeSH/xd4ql1OBPYsK+dn3Ho5+XthrThdKY5siBreXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69-SvVKtw3EPaGCg6lHdtAGIQ-1; Sun, 28 Jul 2024 15:23:03 +0100
X-MC-Unique: SvVKtw3EPaGCg6lHdtAGIQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:22:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:22:19 +0100
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
Subject: [PATCH v2 6/8] minmax: Optimise _Static_assert() check in clamp()
Thread-Topic: [PATCH v2 6/8] minmax: Optimise _Static_assert() check in
 clamp()
Thread-Index: Adrg+aI2g2sJGNTJQ4aVVAXDWlMAag==
Date: Sun, 28 Jul 2024 14:22:19 +0000
Message-ID: <bcdd94d75fec4f3994f0123197d71bbd@AcuMS.aculab.com>
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

Use __if_constexpr() instead of __builtin_choose_expr(__is_constexpr()).

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2 - no change

The misaligned \ is fixed in a later path.

 include/linux/minmax.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index a0c948ad576d..ad57c8eddc8a 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -142,8 +142,7 @@
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


