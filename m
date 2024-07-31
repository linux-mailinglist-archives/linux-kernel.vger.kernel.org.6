Return-Path: <linux-kernel+bounces-268752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8109428DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EC284F11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C91A7F73;
	Wed, 31 Jul 2024 08:10:52 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEA1A7F64
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413451; cv=none; b=uAxXU4gbvIehZuX8+ZHNngRt3SCoPkrEG1fjRc9A+j7H4FfIKQ9U3Y5bFhZEkZpMS5JDRn7qnwcx3PSyeQRMaeaCI8DxuNiJWDr03IEt6XC7QT4s3A7fRFwckTszz49rl+EZAKIL/Jby6tYGLckv3jAtWv5Pwax9ZggVWYsS88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413451; c=relaxed/simple;
	bh=m/8cIYF97oU89DZY8gsHKzQYr9GGmbQQzEuh29nDxRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HQ4IlZ0bmKbVbXiHkorMR8wN/Gl4RTr13ZJyV/xqRzxph1YZVmywU1O2HWBSqbZjX9q1LbkdL9LYb5SaFIBNu7N39IGP+lCIu97TA/Md4XzvIcO56UvvuDh3uABa9ffa6rlGn3KGqTMoORSDboCJf5CQkdnJywZmtAzgAIzzPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-14-0qShZarpOyuFvbAFA6eT4Q-1; Wed, 31 Jul 2024 09:10:39 +0100
X-MC-Unique: 0qShZarpOyuFvbAFA6eT4Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 31 Jul
 2024 09:09:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 31 Jul 2024 09:09:59 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>
CC: Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
	<willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>
Subject: RE: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Topic: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqgAGQsLzQABAMbUAACpmiTABKeZ/A=
Date: Wed, 31 Jul 2024 08:09:59 +0000
Message-ID: <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
 <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
 <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
 <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
 <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
 <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com>
 <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
 <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com>
In-Reply-To: <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzEgSnVseSAyMDI0IDAwOjA0DQo+IA0KPiBP
biBUdWUsIDMwIEp1bCAyMDI0IGF0IDE1OjQ0LCBMaW51cyBUb3J2YWxkcw0KPiA8dG9ydmFsZHNA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBEb2VzIHRoaXMgd29yayBmb3Ig
eW91Pw0KPiANCj4gSXQgc2VlbXMgdG8gYXQgbGVhc3QgYnVpbGQgY2xlYW5seSBoZXJlLCBidXQg
SSdtIG5vdCBjbGFpbWluZyBpdCdzIGFsbA0KPiB0aGF0IGdyZWF0Lg0KPiANCj4gVGhlIG5lc3Rl
ZCBfX2NtcCgpIGlzIHN0aWxsIHJhdGhlciBsZXNzIHRoYW4gb3B0aW1hbCBmcm9tIGFuIGV4cGFu
c2lvbg0KPiBzdGFuZHBvaW50LCBidXQgYXQgbGVhc3QgaXQgZXhwYW5kcyBvbmx5IHRob3NlIHVu
aXF1ZSB0ZW1wb3Jhcmllcy4NCg0KVGhhdCBpcyB0aGUgbWFpbiBnYWluLCBJSVJDIEFybmQgZGlk
IHN1Z2dlc3Qgc3BsaXR0aW5nIGl0IGJ1dCB0aGF0IGlzDQphIHJlbGF0aXZlbHkgc21hbGwgZ2Fp
bi4NCg0KPiBbIFNpZGUgbm90ZTogaGF2aW5nIG5vdCBsb29rZWQgYXQgYSBsb3Qgb2YgdGhlIHJl
c3VsdGluZyBwcmUtcHJvY2Vzc2VkDQo+IG1lc3MsIEknbSBub3QgY29udmluY2VkIGl0IHJlYWxs
eSBoZWxwcyB0byBtYWtlIHRob3NlIHVuaXF1ZSBuYW1lcyBzbw0KPiBsb25nLg0KPiANCj4gICBU
aGUgd2hvbGUgIl9fVU5JUVVFX0lEXyIgcHJlZml4IGxvb2tzIGdvb2Qgb25jZSwgYnV0IHRvIHNv
bWUgZGVncmVlDQo+IGl0IGFjdHVhbGx5IGhpZGVzIHRoZSBpbXBvcnRhbnQgcGFydCwgd2hpY2gg
aXMgdGhlIGFjdHVhbCBwcmVmaXggYW5kDQo+IHRoZSB1bmlxdWUgbnVtYmVyLg0KDQpJIGp1c3Qg
cGFzc2VkIF9fQ09VTlRFUl9fIHRocm91Z2ggaW4gbXkgbWluMygpIHBhdGNoIHRvIGF2b2lkDQpw
YXNzaW5nIGxvdHMgb2YgcGFyYW1ldGVycyBhbmQgdGhlbiBhcHBlbmRlZCBpdCB0byB0aGUgbmFt
ZQ0KZ2l2aW5nIF94XzEyMzQ1IChldGMpLg0KVGhlIF9fVU5JUVVFX0lEXygpIGRlZmluZSBqdXN0
IHNlZW1lZCBleGNlc3NpdmUgLSBlc3BlY2lhbGx5DQpzaW5jZSBhbGwgY29tcGlsZXIgdmVyc2lv
bnMgc3VwcG9ydCBfX0NPVU5URVJfXy4NCg0KSnVzdCBuZWVkIHRvIHJlbWVtYmVyIGEgcmVsYXkg
I2RlZmluZSBzaW5jZSAjZGVmaW5lIGFyZ3VtZW50cyBnZXQNCmV4cGFuZGVkIHdoZW4gdGhleSBh
cmUgc3Vic3RpdHV0ZWQgbm90IGF0IHRoZSAnY2FsbCcgc2l0ZS4NCihXaGljaCBpcyBhbHNvIHRy
dWUgZm9yIF9fVU5JUVVFX0lEKCkpDQoNClRoYXQgYWxzbyBtYWtlcyBpdCBtdWNoIGVhc2llciB0
byBhZGQgYW4gZXh0cmEgdW5pcXVlIG5hbWUuDQoNCj4gICBCdXQgaG9uZXN0bHksIG5vYm9keSBl
dmVyIGxvb2tzIGF0IHRoaXMgcGFydCBub3JtYWxseSwgc28gaXQNCj4gcHJvYmFibHkgZG9lc24n
dCBtYXR0ZXIgXQ0KDQpFeGNlcHQgdGhhdCB3aGVuIHlvdSBkbyBpdCBpcyBhbGwgYSByaWdodCBQ
SVRBLg0KTm90IGhlbHBlZCBieSB0aGUgYWN0dWFsIG5hbWUgYmVpbmcgcmFtbWVkIG9uIHRoZSBl
bmQuDQoNCj4gDQo+IEl0IG1pZ2h0IGJlIHBvc3NpYmxlIHRvIGN1dCBkb3duIG9uIHRoYXQgYnkg
ZG9pbmcgdGhlbSBpbiBzZXJpZXMNCj4gaW5zdGVhZCBvZiBuZXN0ZWQsIGJ1dCBJIHRoaW5rIHRo
YXQgd291bGQgcmVxdWlyZSBzb21ldGhpbmcgbGlrZQ0KPiBnZW5lcmF0aW5nIGEgZm91cnRoIHVu
aXF1ZSBuYW1lLCBhbmQgc29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcyBvZg0KPiANCj4gICAgIF9f
YXV0b190eXBlIHU0ID0gX19jbXAob3AsIHV4LCB1eSk7IF9fY21wKG9wLCB1NCwgdXopOw0KPiAN
Cj4gYXMgdGhhdCBsYXN0IGxpbmUuDQo+IA0KPiBBbmQgbm8sIEkgZGlkICpub3QqIHRyeSB0aGF0
LCBhbmQgdGhlcmUgbWlnaHQgYmUgc29tZXRoaW5nIEknbSBtaXNzaW5nLg0KDQpJZiB5b3UgaGF2
ZSB0byBwYXNzIHRocm91Z2ggYSAndTQnIG5hbWUgdGhhdCBjb3VsZCBlYXNpbHkgdGFrZSBsb25n
ZXIuDQoNCglEYXZpZA0KDQo+IA0KPiAgICAgICAgIExpbnVzDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


