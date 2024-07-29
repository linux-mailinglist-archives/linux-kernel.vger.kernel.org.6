Return-Path: <linux-kernel+bounces-265310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F4793EF59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5109BB232D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CC136E23;
	Mon, 29 Jul 2024 08:02:49 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902D135A79
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240168; cv=none; b=vFGXvZsXSgQ6VCBx/dRqF/ScX+3VlZD8Pa/RvVp77DswdqrQnrU0X865sXSMJ3nVU6VDavadZWRDiU/S+eAvcqLiN/SwmggtSLcf6ps24J6mlc/krFCw4MIAPo5Pk3wj5N7Yt5kNYPxTmHTl8yxGE5crxG8rpdJgJxbXHF4c+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240168; c=relaxed/simple;
	bh=q1Y16MSWxf1bSve2FzJY59rnQgyP2XIizZAYxQnE71I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=u0+JG+Qbwl5jvhZPcyOCGgc9hT4cQwCORx6h0suQanrX0byqm05bJ1twm++sN9SiAk9tCNp20Z+ZuvCHv2xBQat+cAcIq/Wa4kQa3J6kMFglQSzWngRi+gE9lZDdsHCBLQR4BrDiVs2LgfCnYCqd1nkPVPlP6w0tQB3BHRdV5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-187-2qhR61uDM3aZ3G2VNt9HZQ-1; Mon, 29 Jul 2024 09:02:43 +0100
X-MC-Unique: 2qhR61uDM3aZ3G2VNt9HZQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 29 Jul
 2024 09:01:56 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 29 Jul 2024 09:01:56 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqg///x1wD//+6RQIAAFn6A///XzcCAAEdEAP//T2ng
Date: Mon, 29 Jul 2024 08:01:56 +0000
Message-ID: <cff11202f85d4355bd1f07284eea7f25@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
 <CAHk-=wigkg43sZJKuRuYOzWzj9bxczE2toHNc=yxfyMM3m_kcA@mail.gmail.com>
 <b89b80c7060c43f8a937b8021b4fd7cb@AcuMS.aculab.com>
 <CAHk-=wicdsz3bvy9g7RJ_XvugjxAT0XDitwTQLZmxq40JtHbzg@mail.gmail.com>
In-Reply-To: <CAHk-=wicdsz3bvy9g7RJ_XvugjxAT0XDitwTQLZmxq40JtHbzg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjggSnVseSAyMDI0IDIzOjIzDQo+IA0KPiBP
biBTdW4sIDI4IEp1bCAyMDI0IGF0IDE1OjE0LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9rLCBidXQgdGhvc2UgY2FuJ3QgYmUgdXNlZCBh
cyBhcnJheSBzaXplcyBvciBjb25zdGFudHMuDQo+ID4gU28gdGhlIHRlbXBvcmFyaWVzIGRvbid0
IG1hdHRlci4NCj4gDQo+IE5vLCBtdXQgSSBkb24ndCB3YW50IHRoZSBpbnNhbmUgc2l6ZSBleHBs
b3Npb24gZnJvbSB1bm5lY2Vzc2FyaWx5IGp1c3QNCj4gZm9yY2luZyBpdCB0byB1c2UgbWluKCkv
bWF4KCkuDQo+IA0KPiA+IERvbid0IHRoZXkganVzdCB3b3JrIHdpdGggbWluKCkgLSBpZiBub3Qg
d2hlcmUgaXMgdGhlIHNpZ25lZG5lcyBtaXNtYXRjaD8NCj4gDQo+IERhdmlkIC0gdGhpcyB3aG9s
ZSBkaXNjdXNzaW9uIGlzIEJFQ0FVU0UgVEhFU0UgVEhJTkdTIEFSRSBBIFRPVEFMDQo+IERJU0FT
VEVSIFdIRU4gVVNFRCBJTiBERUVQIE1BQ1JPIEVYUEFOU0lPTi4NCj4gDQo+IFNvIG5vLiBJdCBk
b2VzIG5vdCB3b3JrIC0gYmVjYXVzZSBjb3JlIG1hY3JvcyBsaWtlIEhVR0VUTEJfUEFHRV9PUkRF
Ug0KPiBlbmQgdXAgYmVpbmcgdXNlZCBkZWVwIGluIHRoZSBWTSBsYXllciwgYW5kIEkgZG9uJ3Qg
d2FudCB0byBzZWUNCj4gYW5vdGhlciBzdHVwaWQgbXVsdGktdGVuLWtCIGxpbmUganVzdCBiZWNh
dXNlIG1pbigpIGlzIHN1Y2ggYSBwaWcuDQo+IA0KPiBFbmQgcmVzdWx0OiBJJ20gZ29pbmcgdG8g
bWFrZSB0aGUgcnVsZSBiZSB0aGF0IHdoZW4geW91IGRvIG1hY3JvDQo+IGRlZmluaXRpb25zIHVz
aW5nIGNvbnN0YW50cywgdGhlbiAiTUlOKCkvTUFYKCkiIGlzIHByZWZlcmFibGUgc2ltcGx5DQo+
IGJlY2F1c2UgaXQgYXZvaWRzIHRoZSBpbnNhbmUgZXhwYW5zaW9uIG5vaXNlLg0KDQpJIHRoaW5r
IHlvdSBzdGlsbCBuZWVkIHRoZSB0ZW1wb3JhcmllcyBpZiB2YWx1ZXMgYXJlbid0IGNvbnN0YW50
Lg0KQW5kIHlvdSByZWFsbHkgZG9uJ3Qgd2FudCB0aGUgY2FzdHMgdW5sZXNzIHlvdSBhY3R1YWxs
eSBuZWVkIHRoZW0NCnRvIGRvIHNvbWV0aGluZyAndXNlZnVsJyAtIHVubGlrZWx5IGVzcGVjaWFs
bHkgc2luY2UgbmVnYXRpdmUNCnZhbHVlcyBhcmUgdW51c3VhbC4NCg0KTm93IHlvdSBtYXkgd2Fu
dCB0byBhdm9pZCB0aGUgZXhwbG9zaXZlIG5hdHVyZSBvZiBtaW4oKSwgYnV0IGlmIE1JTigpDQoo
b3IgTUlOX1QpIGV2YWx1YXRlcyBpdHMgYXJndW1lbnRzIHR3aWNlIHNvbWVvbmUgd2lsbCB1c2Ug
aXQgaW4gdGhlDQp3cm9uZyBwbGFjZS4NCg0KCURhdmlkDQoNCj4gDQo+IFRoZW4gaW4gbm9ybWFs
ICpjb2RlKiB5b3Ugc2hvdWxkIHVzZSBtaW4oKSBhbmQgbWF4KCkuIEJ1dCBub3QgZm9yDQo+IHRo
aW5ncyBsaWtlIG1hY3JvICJjb25zdGFudHMiIGV2ZW4gaWYgdGhvc2UgY29uc3RhbnRzIGVuZCB1
cCBiZWluZw0KPiBzb21lIGNvbXB1dGVkIHRoaW5nLg0KPiANCj4gICAgICAgICAgIExpbnVzDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==


