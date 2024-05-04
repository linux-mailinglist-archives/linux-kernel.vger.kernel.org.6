Return-Path: <linux-kernel+bounces-168815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721DC8BBE02
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 22:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A149D1C20CBC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61584A51;
	Sat,  4 May 2024 20:26:53 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC583CD3
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714854412; cv=none; b=sFxdcDnIsohiAVhzLive28WFE2uMbU6E71gGZrkzGlUDxcTPjJinsaW/4mS/3hec52p/g722bEa6Py/RXTH+ILy+HmThGX+EvP47w0kKkB8Bpi4wsvRqOLmw4cTPi174G6DBPDBsfl5PkoD0+o/E6emcKqV7sTG73USMx3gYCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714854412; c=relaxed/simple;
	bh=a7k/F1PKwS/4p3POLuiedXV28zFTkH7Y4HJyhJXdOLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=C0ggMiDtu2FGqq5v4foaAywddnpbbb/Ixb2ZzhhxxxY2WvbtiFFnZjQhVBKDVpWgALmWfcmy13K2y2i+Srnm/KmBUGyuQdz7ByLkR2pXEv4lg6gSR8hPOcNC0aT+6zU2ELHLxmBn2kTG3bGA+4WXa4hEp3kDLHe2FUE6K9GITVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-R6kMj-4qPjKWBI3Zp6dTjQ-1; Sat, 04 May 2024 21:26:38 +0100
X-MC-Unique: R6kMj-4qPjKWBI3Zp6dTjQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 4 May
 2024 21:26:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 4 May 2024 21:26:07 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Waiman Long' <longman@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'peterz@infradead.org'"
	<peterz@infradead.org>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Topic: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Index: Ado8NCf0vtha6NqURtGgfE7//QxHexhPrXlAAAq+3cAAADquAAAwkN2g
Date: Sat, 4 May 2024 20:26:07 +0000
Message-ID: <3078b5f07e3e4dc0a3e18aa08af2c9f1@AcuMS.aculab.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
 <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
 <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
 <8373c730-2e08-4abb-8d21-fd9a76116d2c@redhat.com>
In-Reply-To: <8373c730-2e08-4abb-8d21-fd9a76116d2c@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMDMgTWF5IDIwMjQgMjM6MTQNCj4gDQo+IA0KPiBP
biA1LzMvMjQgMTc6MTAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBXYWltYW4gTG9u
Zw0KPiA+PiBTZW50OiAwMyBNYXkgMjAyNCAxNzowMA0KPiA+IC4uLg0KPiA+PiBEYXZpZCwNCj4g
Pj4NCj4gPj4gQ291bGQgeW91IHJlc3BpbiB0aGUgc2VyaWVzIGJhc2VkIG9uIHRoZSBsYXRlc3Qg
dXBzdHJlYW0gY29kZT8NCj4gPiBJJ3ZlIGp1c3QgcmVhcHBsaWVkIHRoZSBwYXRjaGVzIHRvICdt
YXN0ZXInIGFuZCB0aGV5IGFsbCBhcHBseQ0KPiA+IGNsZWFubHkgYW5kIGRpZmZpbmcgdGhlIG5l
dyBwYXRjaGVzIHRvIHRoZSBvbGQgb25lcyBnaXZlcyBubyBkaWZmZXJlbmNlcy4NCj4gPiBTbyBJ
IHRoaW5rIHRoZXkgc2hvdWxkIHN0aWxsIGFwcGx5Lg0KPiA+DQo+ID4gV2VyZSB5b3Ugc2VlaW5n
IGEgc3BlY2lmaWMgcHJvYmxlbT8NCj4gPg0KPiA+IEkgZG9uJ3QgcmVtZW1iZXIgYW55IHN1Z2dl
c3RlZCBjaGFuZ2VkIGVpdGhlci4NCj4gPiAoQXBhcnQgZnJvbSBhIHZlcnkgbG9jYWwgdmFyaWFi
bGUgSSB1c2VkIHRvIGtlZXAgYSBwYXRjaCBpc29sYXRlZC4pDQo+IA0KPiBObywgSSBqdXN0IHdh
bnQgdG8gbWFrZSBzdXJlIHRoYXQgeW91ciBwYXRjaGVzIHdpbGwgc3RpbGwgYXBwbHkuIEFueXdh
eSwNCj4gaXQgd2lsbCBiZSBlYXNpZXIgZm9yIHRoZSBtYWludGFpbmVyIHRvIG1lcmdlIHlvdXIg
cmVtYWluaW5nIHBhdGNoZXMgaWYNCj4geW91IGNhbiBzZW5kIG91dCBhIG5ldyB2ZXJzaW9uIGV2
ZW4gaWYgdGhleSBhcmUgYWxtb3N0IHRoZSBzYW1lIGFzIHRoZQ0KPiBvbGQgb25lcy4NCg0KSSBk
b24ndCB0aGluayBhbnkgY2hhbmdlcyBhcmUgbmVlZGVkLg0KU28gdGhlIGV4aXN0aW5nIHZlcnNp
b25zIGFyZSBmaW5lLg0KVGhleSBhcHBsaWVkICh3ZWxsIG15IGNvcHkgb2Ygd2hhdCBJIHRoaW5r
IEkgc2VudCBhcHBsaWVkKSBhbmQgYnVpbHQuDQpTbyB0aGVyZSBzaG91bGRuJ3QgYmUgYW55IGlz
c3Vlcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


