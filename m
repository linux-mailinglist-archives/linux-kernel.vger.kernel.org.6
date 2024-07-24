Return-Path: <linux-kernel+bounces-260767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797893ADF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA4D1F2227C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8414A09C;
	Wed, 24 Jul 2024 08:34:58 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523286CDB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810098; cv=none; b=VQjgzxI03D3D4/1GNIyXKh3DF1CZ2fEbdU93qeFO22yVp3S3H/3BH/7QVtHX4/cuzDM9gN+3BjWUQriEXytm3cOocR77vA1yJzVb/P/f73KaZYOXwMbf7+KIlC43TR8XDLTd9EIy+wmxfrzhv8vX8bduGv62dmdNBBfnZ4F9vJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810098; c=relaxed/simple;
	bh=7DZDHnnNc7dTg2bUMR2rrS8TD6bUZ64E+4Za+gDA5DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NW2KBsB45RQ5AFX1rUDzHwVhiBm7cS4h0eWDex76XmlkMXI0vSu72xj57GPxjp5r2xsQtSYq3IUirFVWSJ9y8LBJ36jBmeaqcbBckNfTMfVmEVkn8lRwFZWXoNrE8uWq8yyEYcQRrbRuJDjl8++RQM2CGBSW03CH6PpmMwe9rxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-6-jg69a_ZJOnWnjLif97PHlQ-1; Wed, 24 Jul 2024 09:34:42 +0100
X-MC-Unique: jg69a_ZJOnWnjLif97PHlQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 09:34:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 09:34:03 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: =?utf-8?B?J0rDvHJnZW4gR3Jvw58n?= <jgross@suse.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Arnd Bergmann <arnd@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
	"hch@infradead.org" <hch@infradead.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Build performance regressions originating from min()/max() macros
Thread-Topic: Build performance regressions originating from min()/max()
 macros
Thread-Index: AQHa3aFjhf3rusWJtUWi2ZkpzzdkQbIFiEjQ
Date: Wed, 24 Jul 2024 08:34:03 +0000
Message-ID: <1e6a836ed59c463aad55acb12a3431e2@AcuMS.aculab.com>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
In-Reply-To: <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
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

RnJvbTogSsO8cmdlbiBHcm/Dnw0KPiBTZW50OiAyNCBKdWx5IDIwMjQgMDk6MTQNCj4gDQo+IE9u
IDIzLjA3LjI0IDIzOjU5LCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6DQo+ID4gQXJuZCByZXBvcnRl
ZCBhIHNpZ25pZmljYW50IGJ1aWxkIHNsb3dkb3duIFswXSwgd2hpY2ggd2FzIGJpc2VjdGVkIHRv
IHRoZQ0KPiA+IHNlcmllcyBzcGFubmluZyBjb21taXQgODBmY2FjNTUzODVjICgibWlubWF4OiBy
ZWxheCBjaGVjayB0byBhbGxvdw0KPiA+IGNvbXBhcmlzb24gYmV0d2VlbiB1bnNpZ25lZCBhcmd1
bWVudHMgYW5kIHNpZ25lZCBjb25zdGFudHMiKSB0byBjb21taXQNCj4gPiA4NjcwNDZjYzcwMjc3
ICgibWlubWF4OiByZWxheCBjaGVjayB0byBhbGxvdyBjb21wYXJpc29uIGJldHdlZW4gdW5zaWdu
ZWQNCj4gPiBhcmd1bWVudHMgYW5kIHNpZ25lZCBjb25zdGFudHMiKSwgb3JpZ2luYXRpbmcgZnJv
bSB0aGUgc2VyaWVzICJtaW5tYXg6DQo+ID4gUmVsYXggdHlwZSBjaGVja3MgaW4gbWluKCkgYW5k
IG1heCgpLiIgWzFdLg0KPiA+DQo+ID4gSSBoYXZlIHJlcHJvZHVjZWQgdGhpcyBsb2NhbGx5LCBy
ZXZlcnRpbmcgdGhpcyBzZXJpZXMgYW5kIG1hbnVhbGx5IGZpeGluZw0KPiA+IHVwIGFsbCBjYWxs
IHNpdGVzIHRoYXQgaW52b2tlIG1pbigpL21heCgpIGZvciBhIHNpbXBsZSB4ODYtNjQgZGVmY29u
ZmlnICgrDQo+ID4gc29tZSBvdGhlciBkZWJ1ZyBmbGFncyBJIHVzZSBmb3IgZGVidWcga2VybmVs
cywgSSBjYW4gcHJvdmlkZSB0aGUgLmNvbmZpZw0KPiA+IGlmIG5lZWRlZCkuDQo+ID4NCj4gPiBB
cm5kIG5vdGVkIHRoYXQgdGhlIGFyY2gveDg2L3hlbi9zZXR1cC5jIGZpbGUgd2FzIHBhcnRpY3Vs
YXJseSBwcm9ibGVtYXRpYywNCj4gPiB0YWtpbmcgMTUgKCEpIHNlY29uZHMgdG8gcHJlLXByb2Nl
c3Mgb24gaGlzIG1hY2hpbmUsIHNvIEkgYWxzbyBlbmFibGVkDQo+ID4gQ09ORklHX1hFTiB0byB0
ZXN0IHRoaXMgYW5kIG9idGFpbmVkIHBlcmZvcm1hbmNlIG51bWJlcnMgd2l0aCB0aGlzIHNldC9u
b3QNCj4gPiBzZXQuDQo+ID4NCj4gPiBJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzIHZlcnkg
c2lnbmlmaWNhbnQgcHJlLXByb2Nlc3NvciB0aW1lIG9uIHRoaXMNCj4gPiBmaWxlLCBub3Rpbmcg
dGhhdCB3aXRoIHRoZSBzZXJpZXMgcmV2ZXJ0ZWQgY29tcGlsZSB0aW1lIGZvciB0aGUgZmlsZSBp
cw0KPiA+IDAuNzlzLCB3aXRoIGl0IGluIHBsYWNlLCBpdCB0YWtlcyA2LjkwcyBmb3IgYSA4NzMu
NCUgc2xvd2Rvd24uDQouLi4NCj4gPiBXaGljaCBzdWdnZXN0cyBhIHdvcnJ5aW5nbHkgc2lnbmlm
aWNhbnQgc2xvd2Rvd24gb2YgfjQ1cyB3aXRoIENPTkZJR19YRU4NCj4gPiBlbmFibGVkIGFuZCB+
MzVzIGV2ZW4gd2l0aG91dCBpdC4NCj4gPg0KPiA+IFRoZSB1bmRlcmx5aW5nIHByb2JsZW1zIHNl
ZW1zIHRvIGJlIHZlcnkgbGFyZ2UgbWFjcm8gZXhwYW5zaW9ucywgd2hpY2ggQXJuZA0KPiA+IG5v
dGVkIGluIHRoZSB4ZW4gY2FzZSBvcmlnaW5hdGVkIGZyb20gdGhlIGxpbmU6DQo+ID4NCj4gPiBl
eHRyYV9wYWdlcyA9IG1pbjMoRVhUUkFfTUVNX1JBVElPICogbWluKG1heF9wZm4sIFBGTl9ET1dO
KE1BWE1FTSkpLA0KPiA+IAkJZXh0cmFfcGFnZXMsIG1heF9wYWdlcyAtIG1heF9wZm4pOw0KDQpK
ZWVwZXJzLCB0aGF0IGlzIGRlZmluaXRlbHkgZ29pbmcgdG8gYmUgYmlnIC0gaXQgbmV2ZXIgd2Fz
IHNtYWxsLg0KVGhlIGV4cGFuc2lvbiBvZiBtaW4oKSBpdHNlbGYgaXNuJ3QgdGhhdCBiYWQuDQpC
dXQgYm90aCBhcmd1bWVudHMgZ2V0IGV4cGFuZGVkIGEgZmV3IHRpbWVzIChhbmQgYSBmZXcgbW9y
ZSB0aGFuIHRoZSBvbGQgY29kZSkuDQpTbyBhIG5lc3RlZCBtaW4vbWF4IGNhdXNlcyBhbiBPKG5e
MikgZXhwYW5zaW9uIC0gbGl2YWJsZS4NCkJ1dCBtaW4zKGEsYixjKSBpcyBqdXN0IG1pbihtaW4o
YSxiKSxjKSAtIHNvIGEgbmVzdGVkIGNhbGwuDQooSXQgc2VlbXMgdG8gaGF2ZSBiZWVuIGFkZGVk
IHRvIGF2b2lkIHRoZSBjb3N0IG9mIHRoZSBuZXN0ZWQgY2FsbCwgYnV0DQpqdXN0IGltcGxlbWVu
dGVkIGEgbmVzdGVkIGNhbGwgYW55d2F5LikNCkhlcmUgb25lIG9mIHRoZSBhcmd1bWVudHMgdG8g
bWluMygpIGlzIGEgbWluKCkgLSBhbmQgSSBzdXNwZWN0IGl0IGdvZXMNCmludG8gdGhlIGlubmVy
IG1pbigpIHNvIE8obl4zKSAtIHdoaWNoIGlzIGJhZCBuZXdzLg0KDQo+ID4NCj4gPiBBbmQgcmVz
dWx0ZWQgaW4gdGhlIGdlbmVyYXRpb24gb2YgNDcgTUIgKCEpIG9mIHByZS1wcm9jZXNzb3Igb3V0
cHV0Lg0KPiA+DQo+ID4gSXQgc2VlbXMgYSBsb3Qgb2YgY29kZSBub3cgcmVsaWVzIG9uIHRoZSBy
ZWxheGVkIGNvbmRpdGlvbnMgb2YgdGhlIG5ld2x5DQo+ID4gY2hhbmdlZCBtaW4vbWF4KCkgbWFj
cm9zLCBzbyB0aGUgcXVlc3Rpb24gaXMgLSB3aGF0IGNhbiB3ZSBkbyB0byBhZGRyZXNzDQo+ID4g
dGhlc2UgcmVncmVzc2lvbnM/DQo+IA0KPiBJIGNhbiBzZW5kIGEgcGF0Y2ggdG8gc2ltcGxpZnkg
dGhlIHByb2JsZW1hdGljIGNvbnN0cnVjdCwgYnV0IE9UT0ggdGhpcw0KPiB3aWxsIGF2b2lkIG9u
bHkgb25lIHBhcnRpY3VsYXJseSBiYWQgZXhhbXBsZS4NCg0KSSBzdXNwZWN0IHRoYXQgcmV2ZXJz
aW5nIHRoZSBvcmRlciBvZiB0aGUgYXJncyB0byBtaW4zKCkgd2lsbCBoZWxwIHRoaXMgY2FzZS4N
Cg0KVGhlcmUgaXMgYW4gdXBkYXRlZCBwYXRjaCBzZXQgSSBzZW50IGluIEphbnVhcnkgdGhhdCBy
ZWR1Y2VzIHRoZQ0KZXhwYW5zaW9uIGEgYml0Lg0KSSd2ZSBhIHJld29ya2VkIHZlcnNpb24gdGhh
dCByZW1vdmVzIHRoZSBsYXN0IGZldyBwYXRjaGVzIChyZW1vdmluZw0Kc3VwcG9ydCBmb3IgY29u
c3RhbnQgb3V0cHV0IGFuZCB1c2luZyBNSU4oKSBmb3IgdGhhdCBpbnN0ZWFkKS4NCkknbGwgcmVw
b3N0IGl0IGFuZCBtYXliZSBBcm5kIHdpbGwgcGljayBpdCB1cD8NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


