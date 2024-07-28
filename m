Return-Path: <linux-kernel+bounces-264855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4304F93E938
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD271F21140
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6136EB73;
	Sun, 28 Jul 2024 20:23:43 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B622071
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198222; cv=none; b=Fi4yT7izuTjDbTFmF5q3oy3XmuejlNVn3wDn0T5NWYGQrfMpE3Q7Xv5TiOkh8rQ0my6nYPj4r8ZVm5RK1EVqLvFB4dAbUH6pC4lDFVfJQ0sR7ZOOeYIFddVkGC0wEAlnA/pYAjaf+XiYgABQ6Acl5bY8Wqee3W/+pFGowolMbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198222; c=relaxed/simple;
	bh=xLbJUwkxsmqFTG8Y/Is5iZHwCy7pBeenRc6dfDwIR9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=K5hW759n4V77fWvTY8viJetgm3H1IxksenTsUjsb22BvH6UABJz+iuB6WOxLH+dBMkPmqUkUqV9XxbvXDOwM+0JmVdohgXEfJcK69pEx/i675kxYDIZkQ2X/eePLgOTR2GIizCdpCmB2loaGy6dk3DMEW110Tx9hWYaPLHTJtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-107-IglUVtuWPzO5IDwbWfar6Q-1; Sun, 28 Jul 2024 21:23:36 +0100
X-MC-Unique: IglUVtuWPzO5IDwbWfar6Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 21:22:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 21:22:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Christoph Hellwig" <hch@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Andy Shevchenko"
	<andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
Subject: RE: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Topic: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqg///x1wD//+6RQA==
Date: Sun, 28 Jul 2024 20:22:48 +0000
Message-ID: <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
In-Reply-To: <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
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
Content-Transfer-Encoding: base64

Li4NCj4gQnV0IEknbSBpbmNsaW5lZCB0byBqdXN0IGRvIHRoYXQgdG9vLiBCaXRlIHRoZSBidWxs
ZXQsIGdldCByaWQgb2YgdGhlDQo+IHdob2xlICJoYXMgdG8gYmUgYSBDIGNvbnN0YW50IGV4cHJl
c3Npb24iIHBhaW4uDQoNCkF0IGxlYXN0IHlvdSBjYW4gJ2p1c3QgZG8gaXQnIDotKQ0KDQpJSVJD
IHNvbWUgb2YgdGhlIE1JTigpIG5lZWQgdG8gYmUgbWluKCkgYW5kIG90aGVycyBhcmUgdXNlZCBm
b3INCmNvbnN0YW50cyBzbyB3b3VsZCBuZWVkIGFuIGluaXRpYWwgI2lmbmRlZiBNSU4gdGVzdCB0
byBtYWludGFpbg0KYmlzZWN0aW9uIHdpdGhvdXQgaGF2aW5nIGEgc2luZ2xlIHBhdGNoIHRoYXQg
Y2hhbmdlcyBhbGwgdGhlDQpmaWxlcyBhdCBvbmNlLg0KDQpNSU4oKSAoYW5kIHByb2JhYmx5IHlv
dXIgTUlOX1QoKSkgb3VnaHQgdG8gaGF2ZSBhIGNoZWNrIGZvcg0KYmVpbmcgYSBjb25zdGFudCBp
biBvcmRlciB0byBzdG9wIG1pc3VzZS4NClBlcmhhcHMganVzdDoNCiNkZWZpbmUgTUlOKHgseSkg
XA0KCShfX2J1aWx0aW5fY2hvb3NlX2V4cHIoKHgpKyh5KSwgMCwgMCkgKyAoKHgpIDwgKHl9ID8g
KHgpIDogKHkpKSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


