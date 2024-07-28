Return-Path: <linux-kernel+bounces-264824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DDF93E8D5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67ED31C21088
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C75FB95;
	Sun, 28 Jul 2024 18:12:11 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC026AD5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722190331; cv=none; b=mY8B7EPy+rWCiSeb7Mak+MIbMlVtGh/HayDSng30AYmxH/kPH1U9dcqtcJaBtll4g34CwadUTYkFjhqxc+vW9mEciQ8OByy9C9fIAQiMz5gp9CCDLrBGnHargWNrCVy++tB0JKeGFBejP9rgszwNmvY1PWmpCkhy40n4/+K62tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722190331; c=relaxed/simple;
	bh=6ekOtjMHh3SMxGonjB5HyJKcJKQvDZqam9fDzjfBL/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=S0o6ShnauxoK1987DokTGGGXZplMNSQScIpCUF8ofGiI7BjlJtjCZn0jHqn34Ao82JkrxWEoYhd2dgYwARAWepVOTmP7me7v1mhgTvCBSzbN6RCg1cUTqA/TUijbfH+Y2cwwu7itRXbPeZjEKAr+UU66y59ovh8yJ1vnC9X6iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-45-59jZv_FsOyOVLBfahBn_jQ-1; Sun, 28 Jul 2024 19:12:03 +0100
X-MC-Unique: 59jZv_FsOyOVLBfahBn_jQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 19:11:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 19:11:18 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHA=
Date: Sun, 28 Jul 2024 18:11:18 +0000
Message-ID: <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
In-Reply-To: <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjggSnVseSAyMDI0IDE4OjI1DQo+IA0KPiBP
biBTdW4sIDI4IEp1bCAyMDI0IGF0IDA3OjE4LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+ICsjZGVmaW5lIG1pbl90KHR5cGUsIHgsIHkpICAg
ICAgX19jYXJlZnVsX2NtcChtaW4sICh0eXBlKSh4KSwgKHR5cGUpKHkpKQ0KPiA+ICsjZGVmaW5l
IG1heF90KHR5cGUsIHgsIHkpICAgICAgX19jYXJlZnVsX2NtcChtYXgsICh0eXBlKSh4KSwgKHR5
cGUpKHkpKQ0KPiANCj4gVGhpcyBpcyB1bnJlbGF0ZWQgdG8geW91ciBwYXRjaCwgYnV0IHNpbmNl
IGl0IG1vdmVzIHRoaW5ncyBhcm91bmQgYW5kDQo+IHRvdWNoZXMgdGhlc2UsIEkgcmVhY3RlZCB0
byBpdC4uDQo+IA0KPiBXZSBzaG91bGQgKm5vdCogdXNlIF9fY2FyZWZ1bF9jbXAoKSBoZXJlLg0K
PiANCj4gV2h5PyBCZWNhdXNlIHBhcnQgb2YgX19jYXJlZnVsX2NtcCgpIGlzIHRoZSAib25seSB1
c2UgYXJndW1lbnRzIG9uY2UiLg0KPiANCj4gQnV0ICphbm90aGVyKiBwYXJ0IG9mIF9fY2FyZWZ1
bF9jbXAoKSBpcyAiYmUgY2FyZWZ1bCBhYm91dCB0aGUgdHlwZXMiDQo+IGluIF9fY21wX29uY2Uo
KS4NCj4gDQo+IEFuZCBiZWluZyBjYXJlZnVsIGFib3V0IHRoZSB0eXBlcyBpcyB3aGF0IGNhdXNl
cyBob3JyZW5kb3VzIGV4cGFuc2lvbiwNCj4gYW5kIGlzIHBvaW50bGVzcyB3aGVuIHdlIGp1c3Qg
Zm9yY2VkIHRoaW5ncyB0byBiZSB0aGUgc2FtZSB0eXBlLg0KPiANCj4gU28gd2Ugc2hvdWxkIHNw
bGl0IF9fY2FyZWZ1bF9jbXAoKSBpbnRvIG9uZSB0aGF0IGRvZXMganVzdCB0aGUgImRvDQo+IG9u
Y2UiIGFuZCBvbmUgdGhhdCB0aGVuIGFsc28gZG9lcyB0aGUgdHlwZSBjaGVja2luZy4NCi4uLg0K
DQpZZXMgSSd2ZSBzZWVuIHRoYXQgYW5kIGxlZnQgd2VsbCBhbG9uZSA6LSkNCk9yIHJhdGhlciwg
bGVmdCBpdCB1bnRpbCBhZnRlciBNSU4oKSBhbmQgTUFYKCkgYXJlIHVzZWQgZm9yIGNvbnN0YW50
cy4NCg0KQWx0aG91Z2ggbWluX3QodHlwZSx4LHkpIHNob3VsZCBqdXN0IGJlDQoJdHlwZSBfX3gg
PSB4Ow0KCXR5cGUgX195ID0geTsNCglfX3ggPCBfX3kgPyBfX3ggOiBfX3k7DQpBYnNvbHV0ZWx5
IG5vIHBvaW50IGRvaW5nIGFueXRoaW5nIGVsc2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


