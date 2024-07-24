Return-Path: <linux-kernel+bounces-261080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0D93B2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738CEB233A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808315920E;
	Wed, 24 Jul 2024 14:27:17 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61182158DA7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831237; cv=none; b=nwZSIfozfzyqT4JpGK36ADK+r/nqQeTYg8NhFWGRO+GNWDVawcEtpg2Hona0nWnIQilZpvqAmMXT5KN9yrp2NW0fYe1h8IVtDcVYcUSw8fC25nydwbhDv1wU044To3Ha8t1H4A8hkNv+3NA+ux84F3M3hjE/ok+yTX5MOoi96Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831237; c=relaxed/simple;
	bh=jJVn3gKnyzYSWSJUSPxW1yI+bePQSN5YLY/8c7vnK2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s77wgdN2Rx0djatNNqNj5GRy8YTL03giEPXATxXr2z2QyxHBfwomXHe/DOyamEcbqvOhnaaocvaLVaZLtJU0tf93rTb7odxlzPctVXXWFvvE5jW0QLVNSpILZUp/RiM5OijGDE3V8oe7AfpD6It61+AJ5e830BA4wQRNATFpJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-53-sJY-HC0JNsemD1OwgZ6oIg-1; Wed, 24 Jul 2024 15:27:12 +0100
X-MC-Unique: sJY-HC0JNsemD1OwgZ6oIg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:26:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:26:32 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linuxfoundation.org>
CC: "'Matthew Wilcox (Oracle)'" <willy@infradead.org>, 'Christoph Hellwig'
	<hch@infradead.org>, 'Andrew Morton' <akpm@linux-foundation.org>, "'Andy
 Shevchenko'" <andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>, "'hch@infradead.org'"
	<hch@infradead.org>, "'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
	'Mateusz Guzik' <mjguzik@gmail.com>, "'linux-mm@kvack.org'"
	<linux-mm@kvack.org>
Subject: [PATCH 0/7] minmax: reduce compilation time
Thread-Topic: [PATCH 0/7] minmax: reduce compilation time
Thread-Index: Adrd1UnD4d8H4E3lR3eDOQFKqPNnSw==
Date: Wed, 24 Jul 2024 14:26:32 +0000
Message-ID: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
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

The changes to minmax.h that changed the type check to a signedness
check significantly increased the length of the expansion.
In some cases it has also significantly increased compile type.
This is particularly noticeable for nested expansions.

These changes reduce the expansions somewhat.
The biggest change is the last patch that directly implements
min3() and max3() rather than using a nested expansion.

Further significant improvements can be made by removing the
requirement that min(1,2) be 'constant enough' for an array size.
Instead supporting MIN() and MAX() for constants only with a result
that is valid for a static initialiser.
However that needs an initial change to the few files that have
local versions of MIN() or MAX().


David Laight (7):
  minmax: Put all the clamp() definitions together
  minmax: Use _Static_assert() instead of static_assert()
  compiler.h: Add __if_constexpr(expr, if_const, if_not_const)
  minmax: Simplify signedness check
  minmax: Factor out the zero-extension logic from umin/umax.
  minmax: Optimise _Static_assert() check in clamp().
  minmax: minmax: Add __types_ok3() and optimise defines with 3
    arguments

 include/linux/compiler.h |  65 +++++----------
 include/linux/minmax.h   | 176 ++++++++++++++++++++-------------------
 2 files changed, 113 insertions(+), 128 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


