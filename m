Return-Path: <linux-kernel+bounces-261946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCFA93BE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782A91F22D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC918EA85;
	Thu, 25 Jul 2024 08:46:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028918E75A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897160; cv=none; b=BusV50KscbJOMzaC515mLzwMzM0LElA1BnU+t17G78gpDTqD7YXQeu65WyJ2MzV8nHLTXmxOyOQfmML1HLZGJPIUMb9e4tESSjuNa+5cmLTUIw5GBj3lRGHK6wxOQdmL29/VlButVXs4TWB8LA5d0phbCXRRGg2CHGAScnVdT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897160; c=relaxed/simple;
	bh=w358xrmrQIllMraWjBBaSgEJDlVYwjEvJYKEvw0+nho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=k7PhpTChEvUTpTxnCLEHHIxH/mDln2ysqehrO1PUq5rBhw/QXbme00FVjpI7JjbFjM1lQh8Prj1nQg2Pb+Z5ms3fPRN6WO05TO6JbZyYsuL2lFhb/MQG6yDv6Vvq7WPiO31ghi1YVv5Pkz7mk8SWEDZesc8d3QUysmKzJ+lkvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-CjlXeZYdMHSNjXBfdwPZmw-1; Thu, 25 Jul 2024 09:45:47 +0100
X-MC-Unique: CjlXeZYdMHSNjXBfdwPZmw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jul
 2024 09:45:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 25 Jul 2024 09:45:08 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Topic: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const,
 if_not_const)
Thread-Index: Adrd1gZ7oS190yPcQj+hKNIa4uSuaQAJBooAAB0csBA=
Date: Thu, 25 Jul 2024 08:45:07 +0000
Message-ID: <db4143302c0847aabb15a621b60a59c0@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
 <CAHk-=wiQr8U7nCnUci3_20vKyU2cx0BQ7HRNqxsHm+EP-6PCPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiQr8U7nCnUci3_20vKyU2cx0BQ7HRNqxsHm+EP-6PCPQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgSnVseSAyMDI0IDIwOjQ5DQo+IA0KPiBP
biBXZWQsIDI0IEp1bCAyMDI0IGF0IDA3OjMwLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEltcGxlbWVudGVkIHVzaW5nIF9HZW5lcmljKCkg
Zm9yIHBvcnRpYmlsaXR5Lg0KPiANCj4gSSBkbyB0aGluayB0aGlzIGlzIHVsdGltYXRlbHkgdGhl
IGNsZWFyZXIgaW1wbGVtZW50YXRpb24sIGlmIG9ubHkNCj4gYmVjYXVzZSB0aGUgdW5kZXJseWlu
ZyB0cmljayBpdCB1c2VzIGRvZXMgdmVyeSBtdWNoIGRlcGVuZCBvbiBhIHZlcnkNCj4gc3BlY2lh
bCBvZGRpdHkgaW4gdGhlIEMgdHlwZSBzeXN0ZW0uDQo+IA0KPiBTbyB0aGVuIHVzaW5nIHRoZSB0
eXBlIGNvbXBhcmlzb24gd2l0aCBfR2VuZXJpYygpIGlzIHJhdGhlciBuYXR1cmFsLA0KPiBhbmQg
YWxsb3dzIGZvciBwaWNraW5nIG90aGVyIHRoaW5ncyB0aGFuIDAvMSBhcyBhIHJlc3VsdC4NCj4g
DQo+IEhvd2V2ZXIsIHRoZXJlIGlzIE5PIFdBWSB0aGlzIGlzIGEgInBvcnRhYmlsaXR5IiBlbmhh
bmNlbWVudC4NCg0KVGhlIG9sZCBjb2RlIHJlbGllZCBvbiBzaXplb2Yodm9pZCkgd2hpY2ggaXMg
aW52YWxpZCBDLg0KDQpTbyB0aGlzIHZlcnNpb24gY2FuIGJlIHVzZWQgd2hlbiB0aGF0IGdjYyBl
eHRlbnNpb24gaXNuJ3QgZW5hYmxlZC4NCldoaWxlIHRoZSBsaW51eCBrZXJuZWwgcmF0aGVyIGFz
c3VtZXMgaXQgb3RoZXIgYnVpbGRzIChlZyBub2xpYmMpIGRvbid0Lg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K


