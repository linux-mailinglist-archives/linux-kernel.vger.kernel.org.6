Return-Path: <linux-kernel+bounces-413401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4749D18AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40204282C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADD1E2827;
	Mon, 18 Nov 2024 19:09:19 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72681E2615
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956959; cv=none; b=mRnW4iDnhCfhA5p5yKiztkKgQKM8hrJGSACcZIbOOc3F1Pb0PaVuUzarpwCPVX08JEpFWXOncfB/c6BkLRBevRuDgdZae9etHWVLZ1SJSsC2zfxMgMgbNEWxNfhWQBc8ZglnFrAdscB1Kmb4z58uRrf3WrtKjk1vNTaWcQM/ffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956959; c=relaxed/simple;
	bh=uFuHKZOqAt8u1V+nrFIjGfO+qFM4wiGG/dMRdL97s9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcphifG+4xh1fTahF3klTPEC3qCvCGSqbyNxT4PI5WrLjJjg2vfSD1oyovB4n5dFS0ab4SnxvWa6aWP+E56BcHMoHFDqtsMkj4Tda7Y4pO+kYuOUjeaOzy1IuYyAoLn/t4ZKpx6z5Ys6uts/dnTQJGVSs0wJ/CpbYRz/0btph5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-aUZ0AiFpPY6ZW4XCRBTyQQ-1; Mon, 18 Nov 2024 19:09:07 +0000
X-MC-Unique: aUZ0AiFpPY6ZW4XCRBTyQQ-1
X-Mimecast-MFC-AGG-ID: aUZ0AiFpPY6ZW4XCRBTyQQ
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:09:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:09:06 +0000
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
Subject: [PATCH next 0/7] minmax.h: Cleanups and minor optimisations
Thread-Topic: [PATCH next 0/7] minmax.h: Cleanups and minor optimisations
Thread-Index: Ads57NOVmVgyyNpHRyKrutlNFx/4hw==
Date: Mon, 18 Nov 2024 19:09:06 +0000
Message-ID: <c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: 5Jc2cvaVDkmE7jGjMtXHZ9ZP6DgCy40WZej7qwGwZXc_1731956946
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Some tidyups and minor changes to minmax.h.

Patches 1, 2 and 5 have no functional changes.
Patch 3 changes the statically_true() tests in __types_ok() to use the
  local 'unique' variables rather than the caller supplied expressions.
  This will reduce the line length of the preprocessor output.
Patch 4 uses statically_true() for clamp's (lo) < (hi) check.
Patch 6 passes '__auto_type' as the 'fixed type' to reduce the number
  of variants.
Patch 7 removes a level of indirection from __sign_use() and=20
  __is_nonneg().

David Laight (7):
  1) Add whitespace around operators and after commas
  2) Update some comments
  3) Reduce the #define expansion of min(), max() and clamp()
  4) Use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  5) Move all the clamp() definitions after the min/max() ones.
  6) Simplify the variants of clamp()
  7) Remove some #defines that are only expanded once

 include/linux/minmax.h | 205 +++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 110 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


