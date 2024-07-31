Return-Path: <linux-kernel+bounces-269520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3799433BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35A11C243E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECF1BBBE1;
	Wed, 31 Jul 2024 15:57:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0C1799F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441421; cv=none; b=j5BDtBwPAWcVwRCoPxtY2exxee9RWuXJTOtUy2/eZm7D0EYQxsKzOVWuG65RfD3ZFFaaK6Cqy/eOmFei+W+68S4D8mJRu83E6c8jK3bga31FoPTwz3aDqhtXEjhJjVq+UhkyiWFYYqiJKbeJAuFPUH0cVh2RUUgjk3Zo9rYcDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441421; c=relaxed/simple;
	bh=jjFUvWKuOM2iF3uyF+5xmTwgqm8OWHiXn3t1DxgNq6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DtvKROjkEaZPAXH+qc6lOIotE6sZ/JD06z6TAXWrhD4GHYD0IQWsda2lG6cM7SBbhdH4oDSo7bUx0QhdZZfjK2wCJ4KLknwybF6VKCUjTnWSzFi0xBtYBg78W2czdGTgxUuQhMC954h7+7/6RPuAYN0HULDAfkY1gmcxrSi75Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-y2AfI9EuPCilBFg4_mYNkQ-1; Wed, 31 Jul 2024 16:56:56 +0100
X-MC-Unique: y2AfI9EuPCilBFg4_mYNkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 31 Jul
 2024 16:56:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 31 Jul 2024 16:56:15 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqgAGQsLzQABAMbUAACpmiTABKeZ/AADgjwAAACU/gQ
Date: Wed, 31 Jul 2024 15:56:15 +0000
Message-ID: <fbdf2df07e7140dbb96dcda48d4da270@AcuMS.aculab.com>
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
 <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com>
 <CAHk-=whwrXgtOrr6AKQTSYSG5V820cSsMcUjRhapnoqCh+Ciog@mail.gmail.com>
In-Reply-To: <CAHk-=whwrXgtOrr6AKQTSYSG5V820cSsMcUjRhapnoqCh+Ciog@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzEgSnVseSAyMDI0IDE2OjM4DQo+IE9uIFdl
ZCwgMzEgSnVsIDIwMjQgYXQgMDE6MTAsIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxh
Yi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIF9fVU5JUVVFX0lEXygpIGRlZmluZSBqdXN0IHNl
ZW1lZCBleGNlc3NpdmUgLSBlc3BlY2lhbGx5DQo+ID4gc2luY2UgYWxsIGNvbXBpbGVyIHZlcnNp
b25zIHN1cHBvcnQgX19DT1VOVEVSX18uDQo+IA0KPiBZZXMsIHdlIGNvdWxkIHByb2JhYmx5IGp1
c3Qgc2ltcGxpZnkgaXQuDQouLi4NCj4gU28gdGhhdCAicHJlZml4IiBsaXRlcmFsbHkgZXhpc3Rz
IGJlY2F1c2UgaXQgbGl0ZXJhbGx5IHdhc24ndCB1bmlxdWUNCj4gZW5vdWdoIHdpdGhvdXQgaXQu
DQoNCkkgZG9uJ3QgcmVtZW1iZXIgdGhhdCBmYXIgYmFjayA6LSkNCg0KPiBBbmQgdGhlICJfX1VO
SVFVRV9JRF8iIHRoaW5nIGlzIHByb2JhYmx5IGJlY2F1c2UgdGhhdCB3YXkgaXQgd2FzDQo+IGNs
ZWFyZXIgd2hhdCB3YXMgZ29pbmcgb24gd2hlbiBzb21ldGhpbmcgd2VudCB3cm9uZy4NCj4gDQo+
IEJ1dCB0b2dldGhlciB0aGV5IHJlYWxseSBlbmQgdXAgYmVpbmcgYSBzb21ld2hhdCB1bnJlYWRh
YmxlIG1lc3MuDQo+IA0KPiBUaGF0IHNhaWQsIEkgZGlkIGVuZCB1cCBsaWtpbmcgdGhlICJwcmVm
aXgiIHBhcnQgd2hlbiBsb29raW5nIGF0DQo+IGV4cGFuc2lvbnMsIGJlY2F1c2UgaXQgaGVscHMg
c2hvdyAid2hpY2giIGV4cGFuc2lvbiBpdCBpcyAoaWUgInhfMTIzIg0KPiBhbmQgInlfMTI0IiB3
ZXJlIGNsZWFyZXIgdGhhbiBqdXN0IHNvbWUgcHVyZSBjb3VudGVyIHZhbHVlIHRoYXQNCj4gZG9l
c24ndCBoYXZlIGFueSByZWxhdGlvbnNoaXAgdG8gdGhlIG9yaWdpbiBhdCBhbGwgaW4gdGhlIG5h
bWUpLg0KDQpJIGd1ZXNzIHRoYXQgb25jZSB0aGUgY2FsbGVyLXN1cHBsaWVkIHByZWZpeCB3YXMg
YWRkZWQgdGhlIGZpeGVkDQpfX1VOSVFVRV9JRF8gYml0IGNvdWxkIGp1c3QgaGF2ZSBiZWVuIHJl
bW92ZWQuDQoNCj4gQnV0IEkgZGlkIGNoYW5nZSBpdCB0byAieF8iIGZyb20gIl9feCIsIGJlY2F1
c2UgdGhhdCB3YXkgaXQgd2FzDQo+IG1pbmltYWwsIHlldCBjbGVhcmx5IHNlcGFyYXRlIGZyb20g
dGhlIGNvdW50ZXIgbnVtYmVyIChpZSAieF8xMjMiIHdhcw0KPiBiZXR0ZXIgdGhhbiAiX194MTIz
IikuDQoNCkluZGVlZC4uLg0KDQpJIGdvdCBhbm5veWVkIGJlY2F1c2UgdGhlIHVuaXF1ZSAneCcg
YW5kICd5JyBmb3IgbWluKCkgZW5kIHVwDQpoYXZpbmcgZGlmZmVyIG51bWJlcnMgLSB3aGljaCBj
YW4gbWFrZSBpdCBoYXJkZXIgc2VlIHdoYXQgaXMgZ29pbmcNCm9uIHdpdGggbmVzdGVkIGV4cGFu
c2lvbnMuDQpJIG1pZ2h0IGV2ZW4gaGF2ZSBkb25lIGEgZ2xvYmFsIHJlcGxhY2UgdG8gZ2V0IHJp
ZCBvZiB0aGUgX19VTklRVUVfSURfDQp0ZXh0IGluIGFuIGF0dGVtcHQgdG8gbWFrZSB0aGUgZXhw
YW5zaW9ucyByZWFkYWJsZS4NCg0KUGVyaGFwcyBzb21ldGhpbmcgbGlrZToNCiNkZWZpbmUgZG9f
Zm9vKHgsIHVuaXEpICh7IFwNCglfX2F1dG9fdHlwZSBfeF8jI3VuaXEgPSB6OyBcDQoJLi4NCg0K
I2RlZmluZSBmb29fcmVsYXkoeCwgY291bnRlcikgZG9fZm9vKHgsIGNvdW50ZXIpDQojZGVmaW5l
IGZvbyh4KSBmb29fcmVsYXkoeCwgX19DT1VOVEVSX18pDQppcyB0aGUgd2F5IHRvIG9yZ2FuaXNl
IGl0Lg0KU2luY2UgeW91IGRvbid0IGdldCBhIHVuaXF1ZSBudW1iZXIgdW50aWwgX19DT1VOVEVS
X18gaXMgZXhwYW5kZWQNCmluc2lkZSBmb29fcmVsYXkoKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


