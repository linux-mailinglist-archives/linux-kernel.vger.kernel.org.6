Return-Path: <linux-kernel+bounces-264894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A893E9CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C651C214C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BF78B4C;
	Sun, 28 Jul 2024 21:54:34 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96A74418
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722203674; cv=none; b=T2HvR4FfvwGZ84U0DKRqguHCuM9XyLCKpUBdKfsWd2BXuIKXlorwbUh+GTD9y2cc+7o0Z44ngp8zWuW8r6FuccxeOkF97g/VoMZL7A8sBpn7+pzTbgMkp/LJT0DeHjFrFJHJef/Z6vW336XoGuuAegubaE21XqqZrrjFO354JaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722203674; c=relaxed/simple;
	bh=szZQYXwjNAFczvWVTmTMGeJRSYNLwY18L+ssjrATolM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=j+j6pJAVAdrJWnlk9VMo+fKp8Fq+d5dxkD/YoLXc9XyVktUS6CZs9xckPgHM1TpTq5zqIfk04iF205OL7Cg38nvWXJMcH5vnOX3W4IhmH5EA+KxTMexlxpgobp52s79QPK3JbqhKrYzIEq//i0x7mDEUpiYshSnUxkVknJtdHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-323-4KTay3tLMlOm-TGWgebSbw-1; Sun, 28 Jul 2024 22:54:27 +0100
X-MC-Unique: 4KTay3tLMlOm-TGWgebSbw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 22:53:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 22:53:41 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqg///x1wD//+6RQIAAHriA///iUsA=
Date: Sun, 28 Jul 2024 21:53:41 +0000
Message-ID: <8928e9a416204001ac73442d47ab3b70@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
 <CAHk-=wjJCCrErtSbH42mx32kHMrwm2xxpZU-9fAHNJFR30G1rw@mail.gmail.com>
In-Reply-To: <CAHk-=wjJCCrErtSbH42mx32kHMrwm2xxpZU-9fAHNJFR30G1rw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjggSnVseSAyMDI0IDIyOjAxDQo+IA0KPiBP
biBTdW4sIDI4IEp1bCAyMDI0IGF0IDEzOjIzLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEF0IGxlYXN0IHlvdSBjYW4gJ2p1c3QgZG8gaXQn
IDotKQ0KPiANCj4gSSBkZWNpZGVkIHRvIHVzZSBteSBwb3dlcnMgZm9yIGdvb2QuIE9yIGF0IGxl
YXN0IGdvb2Rpc2guDQo+IA0KPiBJIHdlbnQgdGhyb3VnaCBhIGxvdCBvZiAnbWluX3QoKScgYW5k
ICdtYXhfdCgpJyB1c2VycywgYW5kIEkgdGhpbmsgSQ0KPiBmb3VuZCB0aGVtIGFsbC4gVGhlcmUn
cyBhIHBvc3NpYmlsaXR5IHRoYXQgc29tZSBkcml2ZXIgdGhhdCBJIGNhbid0DQo+IGVhc2lseSBi
dWlsZC10ZXN0IGhhcyBpc3N1ZXMsIGJ1dCBJIHRyaWVkIHRvIG1hbnVhbGx5IGNoZWNrIGFsbCB0
aGUNCj4gYXJjaGl0ZWN0dXJlIG9uZXMsIGFuZCBkaWQgYW4gYWxsbW9kY29uZmlnIGJ1aWxkIG9u
IGFybTY0IGFuZCB4ODYtNjQuDQo+IA0KPiBBbmQgYnkgdmlzdWFsIGluc3BlY3Rpb24gSSBmb3Vu
ZCBhIDMyLWJpdCB4ODYgUEFFIGNhc2UuIFdoaWNoIG1ha2VzIG1lDQo+IHRoaW5rIG15IHZpc3Vh
bCBpbnNwZWN0aW9uIHdhcyBub3QgZW50aXJlbHkgYnJva2VuLg0KDQpJJ3ZlIGJlZW4gdGhyb3Vn
aCBhIGxvdCBvZiB0aGVtIGluIHRoZSBwYXN0Lg0KQWJvdXQgOTUlIGNvdWxkIG5vdyBqdXN0IGJl
IG1pbi9tYXguDQpUaGUgJ2Z1bicgb25lcyBhcmUgd2hlcmUgdGhlIGNhc3QgcmVkdWNlcyB0aGUg
c2l6ZSBvZiBvbmUgdHlwZS4NCk9uZSBvZiB0aG9zZSBnb3QgZml4ZWQgYmVjYXVzZSBpdCB3YXMg
YSByZWFsIGJ1Zy4NCkJ1dCB0aGVyZSBhcmUgc29tZSBzdHJhbmdlICh1OCkgb25lcyBpbiBzb21l
IHRlcm1pbmFsIHdpbmRvdyBzaXplDQpjb2RlIHdoaWNoIG1hbmFnZSB0byBjb252ZXJ0IDAgdG8g
LTEgdGhlbiB+MHUgYW5kIGZpbmFsbHkgdG8gdGhlDQptYXggc2l6ZSAtIHdoaWNoIG1pZ2h0IGV2
ZW4gYmUgZGVzaXJhYmxlIQ0KDQo+IEFueXdheSwgSSBkb24ndCBsb3ZlIHRoZSB0aW1pbmcsIHNp
bmNlIEknbSBnb2luZyB0byBjdXQgNi4xMS1yYzEgYXNhcCwNCj4gYnV0IEkgYWxzbyBkb24ndCB3
YW50IHRvIHVubmVjZXNzYXJpbHkgbGVhdmUgdGhpcyBwZW5kaW5nIGZvciBsYXRlciwNCj4gc28g
SSBqdXN0IGNvbW1pdHRlZCB0aGUgc2ltcGxpZmljYXRpb25zIGZvciBtaW5fdC9tYXhfdC4NCg0K
QmV0dGVyIHRoYW4ganVzdCBiZWZvcmUgLXJjNiENCkF0IGxlYXN0IHRoZXNlIGNoYW5nZXMgdGVu
ZCB0byBnZW5lcmF0ZSBidWlsZCBlcnJvcnMuDQoNCglEYXZpZA0KDQo+IERvaW5nIHRoZSBzYW1l
IGZvciBtaW4vbWF4IChubyBtb3JlIEMgY29uc3RhbnQgZXhwcmVzc2lvbiB3b3JyaWVzISkNCj4g
d291bGQgYmUgdmVyeSBnb29kLCBidXQgSSB0aGluayB0aGF0J3MgZ29pbmcgdG8gYmUgZm9yIGxh
dGVyLg0KPiANCj4gICAgICAgICAgICAgICAgIExpbnVzDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


