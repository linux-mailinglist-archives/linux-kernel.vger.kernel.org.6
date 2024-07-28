Return-Path: <linux-kernel+bounces-264580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC793E5A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDD42814FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D746434;
	Sun, 28 Jul 2024 14:16:46 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6602F28
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176205; cv=none; b=eWTB0BRyNBkFeIvdYcSdAzIjkbb9UymK8FR9q0+GEJ/0lyiqgnGYP2ulNl3TmQ2iDgvRmVeFbN9wYWsPZcDoEYgvfYImFPRadDiS+RSZvjxF7zJu3ub4P3qQBzNgVODZ/EFxh4wr9gQDQGRmMdT2K2tmZhDxUCI5gWb05YkBBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176205; c=relaxed/simple;
	bh=BIohjsek9iZ0/CJ6P8DLMq3trAGMe7tQ5wm62/YhhO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBxbBQj1e4ynI926CLjQm/ID+juw1Bg1lbpnKnIGY1q2OhhGTjZCWEVaM2XYNccYwgLed6ERqRYBYFSqH4zX4NZItRxfgUrUBOsdRz4wIRHfE5OlRdsCfcZrdPkREWW1yGul+sSUc33CHjXqtH99UsSBTeiftOs46ljn+0sLN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-02zQ_LJvPdOjNY95HXxCVw-1; Sun, 28 Jul 2024 15:16:35 +0100
X-MC-Unique: 02zQ_LJvPdOjNY95HXxCVw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 15:15:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 15:15:51 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: 'Linus Torvalds' <torvalds@linuxfoundation.org>, Jens Axboe
	<axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Christoph Hellwig" <hch@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Andy Shevchenko"
	<andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 'Lorenzo Stoakes'
	<lorenzo.stoakes@oracle.com>
Subject: [PATCH v2 0/8] minmax: reduce compilation time
Thread-Topic: [PATCH v2 0/8] minmax: reduce compilation time
Thread-Index: Adrg+KhCWB2cpLIWSWqM61xRSOy7tg==
Date: Sun, 28 Jul 2024 14:15:51 +0000
Message-ID: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
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
Instead supporing MIN() and MAX() for constants only with a result
that is valid for a static initialiser.
However that needs an initial change to the few files that have
local versions of MIN() or MAX().

Main changes for v2:
- Keep existing definition of __is_constexpr().
- Fix warning in signedness test for pointer types.
- Use __auto_type (From Arnd).

David Laight (8):
  minmax: Put all the clamp() definitions together
  minmax: Use _Static_assert() instead of static_assert()
  compiler.h: Add __if_constexpr(expr, if_const, if_not_const)
  minmax: Simplify signedness check
  minmax: Factor out the zero-extension logic from umin/umax.
  minmax: Optimise _Static_assert() check in clamp().
  minmax: Use __auto_type
  minmax: minmax: Add __types_ok3() and optimise defines with 3
    arguments

 include/linux/compiler.h |  17 ++++
 include/linux/minmax.h   | 188 +++++++++++++++++++++------------------
 2 files changed, 117 insertions(+), 88 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


