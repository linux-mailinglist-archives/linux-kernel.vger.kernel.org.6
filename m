Return-Path: <linux-kernel+bounces-234081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3DD91C1F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E35E1C2368A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476121C6897;
	Fri, 28 Jun 2024 14:58:23 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5911CCCD3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586702; cv=none; b=rXTnu8M5wG7Lkuj9h960PwkTPZqpAOX/f+jhA39yAce+XoTpxJW8/eUY4NGkg3LEzAf0u93uwzSZLFP87b+fwN6nuurST9iyhiRquhF1+OstSnVDwACFfyx/ky/YapHsQIxzNJdaE3oNq9+cnWDgpM5giwSRvDZ6q4jdqbHV9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586702; c=relaxed/simple;
	bh=aluzX6XcpilgB3wDHaOqW0ZRnk7WB4V+K/VgLgLVeaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RX+hYNz2/5tc8vb3HUXhWo1phRDaQfe0T9B7GmcmGDAQFdZLkuC0MOQUqjBOFTEAB0O7NFD1/yNvFy7UTklfKtKo+MFE6pHZzV18BUczMI+xoSsBIf9Z5N+XQaQt9T7KAy6atyCYxFSLgCAzQljPwo+XLUCypP2oeMTjTQhej/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-104-l7HmKX8rN7mrGQuUZu-NOg-1; Fri, 28 Jun 2024 15:51:55 +0100
X-MC-Unique: l7HmKX8rN7mrGQuUZu-NOg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jun
 2024 15:51:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jun 2024 15:51:19 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Marco Elver' <elver@google.com>, Thorsten Blum <thorsten.blum@toblux.com>
CC: "dvyukov@google.com" <dvyukov@google.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kcsan: Use min() to fix Coccinelle warning
Thread-Topic: [PATCH] kcsan: Use min() to fix Coccinelle warning
Thread-Index: AQHaxgSOjZ6+csUQK0qGWpfhAg1cdrHdSOuA
Date: Fri, 28 Jun 2024 14:51:19 +0000
Message-ID: <1bebf2e8a8a64b4aa4097fd045993106@AcuMS.aculab.com>
References: <20240623220606.134718-2-thorsten.blum@toblux.com>
 <CANpmjNMHPt7UvcZBDf-rbxP=Jm4+Ews+oYeT4b2D_nxWoN9a+g@mail.gmail.com>
In-Reply-To: <CANpmjNMHPt7UvcZBDf-rbxP=Jm4+Ews+oYeT4b2D_nxWoN9a+g@mail.gmail.com>
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

RnJvbTogTWFyY28gRWx2ZXINCj4gU2VudDogMjQgSnVuZSAyMDI0IDA4OjAzDQo+ID4NCj4gPiBG
aXhlcyB0aGUgZm9sbG93aW5nIENvY2NpbmVsbGUvY29jY2ljaGVjayB3YXJuaW5nIHJlcG9ydGVk
IGJ5DQo+ID4gbWlubWF4LmNvY2NpOg0KPiA+DQo+ID4gICAgICAgICBXQVJOSU5HIG9wcG9ydHVu
aXR5IGZvciBtaW4oKQ0KPiA+DQo+ID4gVXNlIHNpemVfdCBpbnN0ZWFkIG9mIGludCBmb3IgdGhl
IHJlc3VsdCBvZiBtaW4oKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRob3JzdGVuIEJsdW0g
PHRob3JzdGVuLmJsdW1AdG9ibHV4LmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYXJjbyBFbHZl
ciA8ZWx2ZXJAZ29vZ2xlLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgcG9saXNoaW5nIChidXQgc2Vl
IGJlbG93KS4gUGxlYXNlIGNvbXBpbGUtdGVzdCB3aXRoDQo+IENPTkZJR19LQ1NBTj15IGlmIHlv
dSBoYXZlbid0Lg0KPiANCj4gPiAtLS0NCj4gPiAga2VybmVsL2tjc2FuL2RlYnVnZnMuYyB8IDIg
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2tjc2FuL2RlYnVnZnMuYyBiL2tlcm5lbC9rY3Nh
bi9kZWJ1Z2ZzLmMNCj4gPiBpbmRleCAxZDFkMWIwZTQyNDguLjExYjg5MWZlNmY3YSAxMDA2NDQN
Cj4gPiAtLS0gYS9rZXJuZWwva2NzYW4vZGVidWdmcy5jDQo+ID4gKysrIGIva2VybmVsL2tjc2Fu
L2RlYnVnZnMuYw0KPiA+IEBAIC0yMjUsNyArMjI1LDcgQEAgZGVidWdmc193cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCBsb2ZmX3Qg
Km8NCj4gPiAgew0KPiA+ICAgICAgICAgY2hhciBrYnVmW0tTWU1fTkFNRV9MRU5dOw0KPiA+ICAg
ICAgICAgY2hhciAqYXJnOw0KPiA+IC0gICAgICAgaW50IHJlYWRfbGVuID0gY291bnQgPCAoc2l6
ZW9mKGtidWYpIC0gMSkgPyBjb3VudCA6IChzaXplb2Yoa2J1ZikgLSAxKTsNCj4gPiArICAgICAg
IHNpemVfdCByZWFkX2xlbiA9IG1pbihjb3VudCwgKHNpemVvZihrYnVmKSAtIDEpKTsNCj4gDQo+
IFdoaWxlIHdlJ3JlIGhlcmUgcG9saXNoaW5nIHRoaW5ncyB0aGlzIGNvdWxkIGJlOg0KPiANCj4g
Y29uc3Qgc2l6ZV90IHJlYWRfbGVuID0gbWluKGNvdW50LCBzaXplb2Yoa2J1ZikgLSAxKTsNCj4g
DQo+ICggK2NvbnN0LCByZW1vdmUgcmVkdW5kYW50ICgpICkNCg0KUHJldHR5IG11Y2ggbm8gb25l
IG1ha2VzIHZhcmlhYmxlcyAnY29uc3QnLCBpdCBtb3N0bHkganVzdCBtYWtlcyB0aGUgY29kZSBo
YXJkZXIgdG8gcmVhZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


