Return-Path: <linux-kernel+bounces-264007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E993DDCB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD3C2837CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3E3CF65;
	Sat, 27 Jul 2024 08:09:30 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EA25745
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067769; cv=none; b=Nvcna+eMbxPwqAwK7NBhJ251b4RLr3EZRpA0gWu4dBYax2Mk5mLUqKnaiQDx9m/Sv1bXqcPGnpAg4IsmsV8w+vOUNwafxMmuq7n2NvJHrFnS/59S2JhqcOUYg2Nsc7G6vSJSL69tWoax5yUXy4OdWMUVGMeicxO2KmbiRHZbhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067769; c=relaxed/simple;
	bh=UgHGFys7HNnqiBeMC/GuBNAqLhnwF5Plq8jJTKFsKlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EgkfxQ61+iWuiPdfKZ3J7eO5qGSXgKylD4rbL/rkohQ9OqNxYAc1PIkTRxIO2AyICMp5xJSWooTzEXqRKOoyFyglAlA9ESWJpJcXo7VlF28PjbBXs6AXPxbmvxDG/1tfmU9aQgNbYW0vlYijORJM/6afndVrVeuCJUkpzZKrH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-119-yJiuI0zgMP-QS7m7LuOXKQ-1; Sat, 27 Jul 2024 09:09:18 +0100
X-MC-Unique: yJiuI0zgMP-QS7m7LuOXKQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Jul
 2024 09:08:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Jul 2024 09:08:39 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Jens Axboe <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/7] minmax: reduce compilation time
Thread-Topic: [PATCH 0/7] minmax: reduce compilation time
Thread-Index: Adrd1UnD4d8H4E3lR3eDOQFKqPNnSwCBfkcCAAdYOfA=
Date: Sat, 27 Jul 2024 08:08:39 +0000
Message-ID: <40369e153bd447e5b597c31e7bc9a2b1@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
In-Reply-To: <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
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

Li4uDQo+IGFuZCBpdCB3aWxsIHNwaXQgb3V0DQo+IA0KPiAgIExvbmdlc3QgbGluZSBpcyBkcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212cHAyL212cHAyX21haW4uYzoxMTM2ICgyMzQ2a0Ip
DQo+ICAgICAgJyAgICgoKCgoKHBrdF9zaXplKSArIF9fYnVpbHRpbl9jaG9vc2VfZXhwcigoc2l6
ZW9mKGludCkgPT0NCj4gc2l6ZW9mKCooOCA/ICgodm9pZCAqKSgobG9uZykoKF9fYnVpbHRpbl8u
Li4nDQo+IA0KPiB0byB0ZWxsIG1lIHRoYXQgd2UgaGF2ZSB0aGF0IGluc2FuZSAyLjIgKm1lZ2Fi
eXRlKiBsaW5lIGR1ZSB0byB0aGUNCj4gTVZQUDJfU0tCX0hFQURST09NIHRoaW5nLCBhbmQgSSBz
aG91bGQgYXBwbHkgdGhpcyBwYXRjaDoNCj4gDQo+IC0jZGVmaW5lIE1WUFAyX1NLQl9IRUFEUk9P
TSAgICAgbWluKG1heChYRFBfUEFDS0VUX0hFQURST09NLCBORVRfU0tCX1BBRCksIDIyNCkNCj4g
KyNkZWZpbmUgTVZQUDJfU0tCX0hFQURST09NDQo+IE1JTl9UKGludCxNQVhfVChpbnQsWERQX1BB
Q0tFVF9IRUFEUk9PTSwgTkVUX1NLQl9QQUQpLCAyMjQpDQo+IA0KPiB0byBmaXggaXQuDQoNCk9y
IChpZiBJJ3ZlIGdvdCBpcyByaWdodCk6DQojZGVmaW5lIE1WUFAyX1NLQl9IRUFEUk9PTSBjbGFt
cChYRFBfUEFDS0VUX0hFQURST09NLCBORVRfU0tCX1BBRCwgMjI0KQ0KDQpIbW1tLi4uDQpJJ3Zl
IGZvdW5kOg0KI2RlZmluZSBYRFBfUEFDS0VUX0hFQURST09NIDI1Ng0KI2RlZmluZSBORVRfU0tC
X1BBRCBtYXgoMzIsIEwxX0NBQ0hFX0JZVEVTKQ0KSSdkIGJldCB0aGF0IHNvbWUgYXJjaGl0ZWN0
dXJlIGV2ZW4gaGFzIGEgbm9uLWNvbnN0YW50IEwxX0NBQ0hFX0JZVEVTLg0KDQpCdXQgdGhlIDI1
NiBtZWFucyB0aGUgaGVhZHJvb20gaXMgYWx3YXlzIDIyNCAod2hhdGV2ZXIgdGhhdCBsaW1pdCBp
cyByZWxhdGVkIHRvKS4NCg0KSXQgaXMgZGVmaW5pdGVseSB3b3J0aCBmcmVlaW5nIHVwIE1JTigp
IGFuZCBNQVgoKSBmb3I6DQojZGVmaW5lIE1JTih4LCB5KSAoIFwNCglCVUlMRF9CVUdfT05fWkVS
TyhfX2lzX2NvbnN0ZXhwcigoeCkgKyAoeSkpICsgKCh4KSA8ICh5KSA/ICh4KSA6ICh5KSkpDQp3
aGljaCBpcyB0aGVuIHVzYWJsZSBmb3Igc3RhdGljIGluaXRpYWxpc2Vycy4NCkp1c3QgYXNzdW1p
bmcgdGhhdCBubyBvbmUgaXMgc2lsbHkgZW5vdWdoIHRvIGdldCBhIG5lZ2F0aXZlIGNvbnN0YW50
DQpjb21wYXJlZCB0byBhbiB1bnNpZ25lZCB2YWx1ZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


