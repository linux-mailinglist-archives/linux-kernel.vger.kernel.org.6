Return-Path: <linux-kernel+bounces-264849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BE93E92F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B81C20A40
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823C6EB4A;
	Sun, 28 Jul 2024 20:10:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEC1D69E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197412; cv=none; b=G86gBWlej4jOoJAER0uz8hVCL0Bc3qwWOfRZn4Whjs30Lq+cNWVqLCZwpFioGMuHWj5ueoLxYUEtCVI33FsZdufoRAUQlSp6U7QCU7Zms3f4eBe1RdRc8kj5UQxHM4dWzBXCxrAL7j8MnyrV4MliA6jwrC9J0iQihSF1cjccxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197412; c=relaxed/simple;
	bh=+Vc0/1Sv0FzZ2Vc3u0nAKXFBN0TNCL6RStYGqkU7j4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JNJ8whRu5ULYGbegWIF27ogaUQrjPzMxgfDexQX7XeOpTOca2+dU4aYRshWwGDPS/Nddvc2fjWKCe+vRq4c77QHkCx4TZ+FzPAkpW3cQFuxwFZMfV3qxtbT1RIz63qXaaDdVpDXGPMtZZ7NL7MmMRMrildgc78Au+rdoKPvNDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-DRc-5r_cMRmYocbGRQaRxA-1; Sun, 28 Jul 2024 21:10:03 +0100
X-MC-Unique: DRc-5r_cMRmYocbGRQaRxA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 21:09:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 21:09:17 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqg
Date: Sun, 28 Jul 2024 20:09:17 +0000
Message-ID: <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
In-Reply-To: <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
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
bnQ6IDI4IEp1bHkgMjAyNCAyMDo1NQ0KPiANCj4gT24gU3VuLCAyOCBKdWwgMjAyNCBhdCAxMTox
MiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBBbHRob3VnaCBtaW5fdCh0eXBlLHgseSkgc2hvdWxkIGp1c3QgYmUNCj4gPiAgICAgICAgIHR5
cGUgX194ID0geDsNCj4gPiAgICAgICAgIHR5cGUgX195ID0geTsNCj4gPiAgICAgICAgIF9feCA8
IF9feSA/IF9feCA6IF9feTsNCj4gPiBBYnNvbHV0ZWx5IG5vIHBvaW50IGRvaW5nIGFueXRoaW5n
IGVsc2UuDQo+IA0KPiBJIHRyaWVkIGl0LiBEb2Vzbid0IHF1aXRlIHdvcms6DQo+IA0KPiAgIG5l
dC9pcHY0L3Byb2MuYzogSW4gZnVuY3Rpb24g4oCYc25tcF9zZXFfc2hvd190Y3BfdWRw4oCZOg0K
PiAgIG5ldC9pcHY0L3Byb2MuYzo0MTQ6OTogZXJyb3I6IElTTyBDOTAgZm9yYmlkcyB2YXJpYWJs
ZSBsZW5ndGggYXJyYXkNCj4g4oCYYnVmZuKAmSBbLVdlcnJvcj12bGFdDQo+ICAgICA0MTQgfCAg
ICAgICAgIHVuc2lnbmVkIGxvbmcgYnVmZltUQ1BVRFBfTUlCX01BWF07DQo+ICAgICAgICAgfCAg
ICAgICAgIF5+fn5+fn5+DQouLi4NCg0KQWgsIHRoZSBjb25zdGFudHMuDQpJIHRoaW5rIHRoZXkg
anVzdCBuZWVkIHRvIGJlIE1JTl9DT05TVCgpICh3aXRob3V0IHRoZSBjYXN0cykuDQpPbmUgbWln
aHQgbmVlZCBhIGNhc3Qgb2Ygb25lIG9mIGl0cyBjb25zdGFudHMuDQpCdXQgbWF5YmUgdGhlIHNp
Z25lZG5lc3MgdGVzdCBjYW4gYmUgaWdub3JlZCBpZiB0aGVyZSBpcyBhDQp0ZXN0IGZvciBpdCBi
ZWluZyBhIGNvbnN0YW50Lg0KDQpCdXQgKGFzIHlvdSBzYWlkIGVhcmxpZXIgaW4gdGhlIHllYXIp
IHRoYXQgc2hvdWxkIGp1c3QgYmUgTUlOKCkuDQpFeGNlcHQgdGhlcmUgYXJlIGEgZmV3IHBsYWNl
cyB0aGF0IGlzIHVzZWQgdGhhdCBuZWVkIGNoYW5naW5nIGZpcnN0Lg0KDQoJRGF2aWQNCg0KPiAN
Cj4gSSBndWVzcyBhbGwgb2YgdGhlc2UgY291bGQganVzdCBiZSBtYWRlIHRvIHVzZSBNSU5fVCgp
L01BWF9UIGluc3RlYWQuDQo+IFdlJ3JlIG5vdCB0YWxraW5nIGh1bmRyZWRzIG9mIGNhc2VzLCBp
dCBzZWVtcyB0byBiZSBqdXN0IGEgc21hbGwNCj4gaGFuZGZ1bC4NCj4gDQo+IExldCBtZSBnbyBj
aGVjay4NCj4gDQo+ICAgICAgICAgICAgICAgIExpbnVzDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


