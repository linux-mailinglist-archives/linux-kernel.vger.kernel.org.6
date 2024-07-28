Return-Path: <linux-kernel+bounces-264899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF493E9F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7691C2134F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3827B3E1;
	Sun, 28 Jul 2024 22:14:13 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A347A158
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722204852; cv=none; b=a6HliZ7rYrFO6bLU2VM6Iiy/f4Kv0YJEykiructtVH7YB+8AF4CzXz1RilX1OTyEFMiScZ9xij/Wg17JzM5HmcaxmByCjUkWPki6z1Ruq+2thX6dkImbHCNn6DXUGu+wb7h6I9M0JMLsG8qigGOJ8288XmnlsfFsMisFh4GnSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722204852; c=relaxed/simple;
	bh=B0EGmmjI8WlEceYL4vqP8Yj6mQFWXhv9JrhFRfagic0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ncFMIy8yLRRyOPx/YcTh+Hd1V9rfKPRwWwouLbImwYmbciKmtj5/KbY/Si7p/CIQmBWulcYwa+SxAge7VeGGUxyKPtFwzD9qMy6+gYhUzRDcyx03dpSePR87th2ieoMlR8gfXV5hacz13po0TWVEfyz4Mr45nBp788s5zJo0W2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-JC2wg0YkNCiYh_J5XzjyaQ-1; Sun, 28 Jul 2024 23:14:01 +0100
X-MC-Unique: JC2wg0YkNCiYh_J5XzjyaQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 23:13:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 23:13:16 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqg///x1wD//+6RQIAAFn6A///XzcA=
Date: Sun, 28 Jul 2024 22:13:15 +0000
Message-ID: <b89b80c7060c43f8a937b8021b4fd7cb@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
 <CAHk-=wigkg43sZJKuRuYOzWzj9bxczE2toHNc=yxfyMM3m_kcA@mail.gmail.com>
In-Reply-To: <CAHk-=wigkg43sZJKuRuYOzWzj9bxczE2toHNc=yxfyMM3m_kcA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNl
bnQ6IDI4IEp1bHkgMjAyNCAyMTozMg0KPiANCj4gT24gU3VuLCAyOCBKdWwgMjAyNCBhdCAxMzoy
MywgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBNSU4oKSAoYW5kIHByb2JhYmx5IHlvdXIgTUlOX1QoKSkgb3VnaHQgdG8gaGF2ZSBhIGNoZWNr
IGZvcg0KPiA+IGJlaW5nIGEgY29uc3RhbnQgaW4gb3JkZXIgdG8gc3RvcCBtaXN1c2UuDQo+IA0K
PiBObywgd2UgaGF2ZSBhIG51bWJlciBvZiAicnVudGltZSBjb25zdGFudHMiIHRoYXQgYXJlIGJh
c2ljYWxseQ0KPiAiY29uc3RhbnRzIiBzZXQgdXAgYXQgYm9vdC10aW1lIGZvciB0aGUgYXJjaGl0
ZWN0dXJlLGFzIHBvaW50ZWQgb3V0IGJ5DQo+IHRoZSBwb3dlcnBjIHBlb3BsZSBpbiBwcml2YXRl
Og0KPiANCj4gSWUsIHdlIGhhdmUgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BhZ2UuaDoNCj4g
DQo+ICAgICNkZWZpbmUgSFBBR0VfU0hJRlQgaHBhZ2Vfc2hpZnQNCj4gDQo+IGFuZCB0aGVuDQo+
IA0KPiAgICNkZWZpbmUgSFVHRVRMQl9QQUdFX09SREVSICAgICAgKEhQQUdFX1NISUZUIC0gUEFH
RV9TSElGVCkNCj4gDQo+IGFuZCB0aGVuDQo+IA0KPiAgICAjZGVmaW5lIHBhZ2VibG9ja19vcmRl
ciAgICAgICAgIE1JTl9UKHVuc2lnbmVkIGludCwNCj4gSFVHRVRMQl9QQUdFX09SREVSLCBNQVhf
UEFHRV9PUkRFUikNCj4gDQo+IGFuZCB3ZSByZWFsbHkgKlJFQUxMWSogZG9uJ3Qgd2FudCB0byBm
b3JjZSB0aGUgY29tcGxpY2F0ZWQgIm1pbl90KCkiDQo+IChvciwgd29yc2UgeWV0LCAibWluKCki
KSBmdW5jdGlvbnMgaGVyZSBqdXN0IGJlY2F1c2UgdGhlcmUncyBhY3R1YWxseQ0KPiBhIHZhcmlh
YmxlIGludm9sdmVkLg0KPiANCj4gVGhhdCB2YXJpYWJsZSBnZXRzIGluaXRpYWxpemVkIGVhcmx5
IGluDQo+IGh1Z2V0bGJwYWdlX2luaXRfZGVmYXVsdHNpemUoKSwgc28gaXQncyAqZWZmZWN0aXZl
bHkqIGEgY29uc3RhbnQsIGJ1dA0KPiBub3QgYXMgZmFyIGFzIHRoZSBjb21waWxlciBpcyBjb25j
ZXJuZWQuDQoNCk9rLCBidXQgdGhvc2UgY2FuJ3QgYmUgdXNlZCBhcyBhcnJheSBzaXplcyBvciBj
b25zdGFudHMuDQpTbyB0aGUgdGVtcG9yYXJpZXMgZG9uJ3QgbWF0dGVyLg0KRG9uJ3QgdGhleSBq
dXN0IHdvcmsgd2l0aCBtaW4oKSAtIGlmIG5vdCB3aGVyZSBpcyB0aGUgc2lnbmVkbmVzIG1pc21h
dGNoPw0KDQpQZXJoYXBzIHdlIHdhbnQ6DQoJbWluKCkgLSB0ZW1wb3Jhcmllcywgc2lnbmVkbmVz
cyBjaGVjay4NCgltaW5fdCgpIC0gdGVtcG9yYXJpZXMgb2YgZ2l2ZW4gdHlwZSwgbWF5YmUgY2hl
Y2sgc2l6ZSBub3QgcmVkdWNlZD8NCglNSU4oKSAtIG5vIHRlbXBvcmFyaWVzLCBubyBzaWduZWRu
ZXNzIGNoZWNrLCBvbmx5IHZhbGlkIGZvciBjb25zdGFudHMuDQoJX21pbigpIC0gdGVtcG9yYXJp
ZXMsIG5vIHNpZ25lZG5lc3MgY2hlY2suDQoJX01JTigpIC0gbm8gdGVtcG9yYXJpZXMsIG5vIHNp
Z25lZG5lc3MgY2hlY2ssIHZhcmlhYmxlcyBhbGxvd2VkLg0KDQpJJ20gbm90IHN1cmUgd2hlcmUg
eW91ciBNSU5fVCgpIGZpdHMgaW4gdGhlIGFib3ZlLg0KDQpQZXJzb25hbGx5IEkgdGhpbmsgbWlu
X3QoKSB3YXMgYSBtaXN0YWtlLg0KT25seSBvbmUgaW5wdXQgY2FuIG5lZWQgYSBjYXN0IGFuZCBh
biBleHBsaWNpdCBjYXN0IHdvdWxkIGJlIHNhZmVyLg0KDQoJRGF2aWQNCg0KPiANCj4gICAgICAg
ICAgICBMaW51cw0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=


