Return-Path: <linux-kernel+bounces-261140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C793B317
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BFF1C2130F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F815B0F2;
	Wed, 24 Jul 2024 14:48:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAB158871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832505; cv=none; b=IXhVQwuDsz+jOt45v/BothiXef+AkOngb3gEXcDwuaG/uUj4C4IgIbzXOr4UrtgtkwquNb2OLeFtRycCAt773MCtByq1tcBemxE/qAfSDKr603Ln+YOheHjvqsWhR4U5V8jghoT23PXQP5zfaXVTo0GKcpulGZlk1UiazaUWLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832505; c=relaxed/simple;
	bh=fprRPMWTkOBhzkBF9cmlViK38eaupYEOgKLZ2XR4x3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=D+CZ2j7OPGTkyroTBtZB5UBfz1VcIkWh0QOp4Bg8dRcaSMLJM/gKe0iI1T9Nhkb2xk0uaaLLn1m7Ux4RqGRLGe66LhChKEortCKV+qHhVGU1hG1bI2t7YTMOyHcpSHj+ASnS6AiTzC/1ZnEjM0Nqy54zbn37ZZMDsYtO0lMy0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-9-iUKVZuv5M4mSkKrg5z1QDA-1; Wed, 24 Jul 2024 15:48:20 +0100
X-MC-Unique: iUKVZuv5M4mSkKrg5z1QDA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 15:47:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 15:47:40 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: =?utf-8?B?J0rDvHJnZW4gR3Jvw58n?= <jgross@suse.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann
	<arnd@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "hch@infradead.org" <hch@infradead.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Build performance regressions originating from min()/max() macros
Thread-Topic: Build performance regressions originating from min()/max()
 macros
Thread-Index: AQHa3a13hf3rusWJtUWi2ZkpzzdkQbIF9RFw
Date: Wed, 24 Jul 2024 14:47:40 +0000
Message-ID: <fb4794f9aae747919f81ea6a313fb0fd@AcuMS.aculab.com>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
 <9d62cd2d-a00b-4260-8ffb-0e0e4574f222@lucifer.local>
 <0b11e6c8-170d-4b95-ad14-76685d657643@suse.com>
In-Reply-To: <0b11e6c8-170d-4b95-ad14-76685d657643@suse.com>
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

RnJvbTogSsO8cmdlbiBHcm/Dnw0KPiBTZW50OiAyNCBKdWx5IDIwMjQgMTA6NDANCj4gDQo+IE9u
IDI0LjA3LjI0IDEwOjMxLCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6DQo+ID4gT24gV2VkLCBKdWwg
MjQsIDIwMjQgYXQgMTA6MTQ6MTJBTSBHTVQsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+ID4+IE9u
IDIzLjA3LjI0IDIzOjU5LCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6DQo+ID4+PiBBcm5kIHJlcG9y
dGVkIGEgc2lnbmlmaWNhbnQgYnVpbGQgc2xvd2Rvd24gWzBdLCB3aGljaCB3YXMgYmlzZWN0ZWQg
dG8gdGhlDQo+ID4+PiBzZXJpZXMgc3Bhbm5pbmcgY29tbWl0IDgwZmNhYzU1Mzg1YyAoIm1pbm1h
eDogcmVsYXggY2hlY2sgdG8gYWxsb3cNCj4gPj4+IGNvbXBhcmlzb24gYmV0d2VlbiB1bnNpZ25l
ZCBhcmd1bWVudHMgYW5kIHNpZ25lZCBjb25zdGFudHMiKSB0byBjb21taXQNCj4gPj4+IDg2NzA0
NmNjNzAyNzcgKCJtaW5tYXg6IHJlbGF4IGNoZWNrIHRvIGFsbG93IGNvbXBhcmlzb24gYmV0d2Vl
biB1bnNpZ25lZA0KPiA+Pj4gYXJndW1lbnRzIGFuZCBzaWduZWQgY29uc3RhbnRzIiksIG9yaWdp
bmF0aW5nIGZyb20gdGhlIHNlcmllcyAibWlubWF4Og0KPiA+Pj4gUmVsYXggdHlwZSBjaGVja3Mg
aW4gbWluKCkgYW5kIG1heCgpLiIgWzFdLg0KPiA+DQo+ID4gW3NuaXBdDQo+ID4NCj4gPj4gSSBj
YW4gc2VuZCBhIHBhdGNoIHRvIHNpbXBsaWZ5IHRoZSBwcm9ibGVtYXRpYyBjb25zdHJ1Y3QsIGJ1
dCBPVE9IIHRoaXMNCj4gPj4gd2lsbCBhdm9pZCBvbmx5IG9uZSBwYXJ0aWN1bGFybHkgYmFkIGV4
YW1wbGUuDQo+ID4NCj4gPiBUaGFua3MsIGFwcHJlY2lhdGVkIGJ1dCBJIGFtIGEgbGl0dGxlIGNv
bmNlcm5lZCB0aGF0IHdlIG1pZ2h0IGdldCBzdHVjayBpbg0KPiA+IHdoYWNrLWEtbW9sZSBoZXJl
IGEgYml0LiBJJ20gcHJldHR5IHN1cmUgd2UndmUgaGFkIHByZXZpb3VzIHBhdGNoZXMgdGhhdA0K
PiA+IGhhdmUgYWRkcmVzc2VkIGludm9jYXRpb24gcG9pbnRzLCBidXQgb2J2aW91c2x5IHRoZSB1
bmRlcmx5aW5nIGlzc3VlIGFyZQ0KPiA+IHRoZXNlIG1hY3JvcyB3aGljaCB3aWxsIGtlZXAgY3Jv
cHBpbmcgdXAgYWdhaW4gYW5kIGFnYWluLg0KPiANCj4gVGhlIHhlbiBleGFtcGxlIHNlZW1zIHRv
IGJlIG9uZSBvZiB0aGUgd29yc3QgZHVlIHRvIG5lc3Rpbmcgb2YgbWluMygpIGFuZA0KPiBtaW4o
KSwgc28gYmVpbmcgZGUgZmFjdG8gYSBtaW40KCkuDQo+IA0KPiBJIHRoaW5rIGRyaXZlcnMvZmly
bXdhcmUvc3lzZmJfc2ltcGxlZmIuYyBoYXMgYSBzaW1pbGFyIHByb2JsZW0sIGFzIGl0IGlzDQo+
IG5lc3RpbmcgbWF4KCkgd2l0aCBtYXgzKCkuIFNhbWUgYXBwbGllcyB0byBhcmNoL3g4Ni9rZXJu
ZWwvY3B1L2NhY2hlaW5mby5jDQo+IGFuZCBtdWx0aXBsZSB0aW1lcyB0byBmcy94ZnMvbGlieGZz
L3hmc190cmFuc19yZXN2LmMuDQo+IA0KPiBUaGVyZSBhcmUgcHJvYmFibHkgbW9yZSBzdWNoIGV4
dHJlbWUgY2FzZXMuDQoNCkkndmUganVzdCBzZW50IGluIGEgNy1wYXJ0IHBhdGNoIHNlcmllcyB0
aGF0IHNsaWdodGx5IHJlZHVjZXMgdGhlIGNvbXBsZXhpdHkNCmFuZCBkaXJlY3RseSBpbXBsZW1l
bnRzIG1pbjMoKSBhbmQgbWF4MygpLg0KVGhlIGxhdHRlciBzaG91bGQgaGVscC4NCg0KVGhpcyBp
cyBiYXNlZCBvbiBwYXJ0IG9mIGEgc2VyaWVzIEkgc2VuZCBtb250aHMgYWdvIHRoYXQgd2lsbCBo
YXZlICdnb3QgbG9zdCcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


