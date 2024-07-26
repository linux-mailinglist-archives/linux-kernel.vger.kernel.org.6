Return-Path: <linux-kernel+bounces-263757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5793DA34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA23B227E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91D149DFF;
	Fri, 26 Jul 2024 21:33:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15438DEE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029607; cv=none; b=YWK5FwVNaEvbpZaVGxhuf09J7MdClb9166nzw77QOxDOAXutoqPmcCoiP6RLYsVMimK4Lz9TKRY3Mt9zx/Z4NUmACtEhuW9pJkKp6lha4u8Y3QJld3gzsVmF2MIZgds2mrCULuwwbUd+P/MbgXvKtUJfTiSB8jb45RiXy746JVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029607; c=relaxed/simple;
	bh=OFjSYsehepx77wEMqry9IIbi4Y0fqCN70nQtwDkk2F4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=G/DWyCSreWoWvA1+5XKzWeT6s4peU65cjj8/b/onBLaZV3GxMWhK7T1PPAUZ9WAQL8+b+w3Zbo8uuCn1Csr9kwpSiHwsznD6RzNvb62OiveXlkGo4QVN4zoUijZEtANKztMRNulVKxdqappriiNEoFPTYQk582Q6cYccfvQbozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-R4K3B1YWPbGMagsXExZgPQ-1; Fri, 26 Jul 2024 22:33:21 +0100
X-MC-Unique: R4K3B1YWPbGMagsXExZgPQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 26 Jul
 2024 22:32:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 26 Jul 2024 22:32:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/7] minmax: reduce compilation time
Thread-Topic: [PATCH 0/7] minmax: reduce compilation time
Thread-Index: Adrd1UnD4d8H4E3lR3eDOQFKqPNnSwBs614ZAAZcE0A=
Date: Fri, 26 Jul 2024 21:32:43 +0000
Message-ID: <20e5a0db0ebf4bbb991b13a1d8951137@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
In-Reply-To: <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgSnVseSAyMDI0IDE5OjI0DQo+IA0KPiBP
biBGcmksIDI2IEp1bCAyMDI0IGF0IDExOjEzLCBMb3JlbnpvIFN0b2FrZXMNCj4gPGxvcmVuem8u
c3RvYWtlc0BvcmFjbGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IDUsNDQ3LDUzOSAgICAgICAuL2Fy
Y2gveDg2L3hlbi9zZXR1cC5vLnByZQ0KPiANCj4gQ2FuIHlvdSBwZXJoYXBzIGRvIHNvbWUga2lu
ZCBvZiAibWF4IGV4cGFuc2lvbiIgb24gYWxsIHRoZQ0KPiBwcmVwcm9jZXNzb3IgZmlsZXMgKHlv
dSBzZWVtIHRvIGhhdmUgZG9uZSBpdCBieSBjaGFuZ2luZyB0aGUgIi5jLm8iDQo+IHJ1bGUgdG8g
anVzdCBzcGl0IGl0IG91dCBhcyAiby5wcmUiLCB3aGljaCBzb3VuZHMgZmluZSkuDQo+IA0KPiBG
b3IgZXhhbXBsZSwgdGhpcyB0cml2aWFsIHBhdGNoIHNlZW1zIHRvIGZpeCB0aGUgc2V0dXAuYyBl
eHBhbnNpb24gYnkNCj4gYWJvdXQgYW4gb3JkZXIgb2YgbWFnbml0dWRlIChpZSA1ME0gLT4gNU0p
Lg0KPiANCj4gRW50aXJlbHkgdW50ZXN0ZWQsIGJ1dCBsb29rcyBPYnZpb3VzbHlDb3JyZWN0KHRt
KSB0byBtZS4NCg0KLQlleHRyYV9wYWdlcyA9IG1pbjMoRVhUUkFfTUVNX1JBVElPICogbWluKG1h
eF9wZm4sIFBGTl9ET1dOKE1BWE1FTSkpLA0KLQkJCSAgIGV4dHJhX3BhZ2VzLCBtYXhfcGFnZXMg
LSBtYXhfcGZuKTsNCisJbWF4bWVtX3BhZ2VzID0gRVhUUkFfTUVNX1JBVElPICogbWluKG1heF9w
Zm4sIFBGTl9ET1dOKE1BWE1FTSkpOw0KKwlleHRyYV9wYWdlcyA9IG1pbjMobWF4bWVtX3BhZ2Vz
LCBleHRyYV9wYWdlcywgbWF4X3BhZ2VzIC0gbWF4X3Bmbik7DQoNCkkgc3VzcGVjdCBqdXN0IHJl
b3JkZXJpbmcgdG86DQoJZXh0cmFfcGFnZXMgPSBtaW4zKGV4dHJhX3BhZ2VzLCBtYXhfcGFnZXMg
LSBtYXhfcGZuLA0KCQlFWFRSQV9NRU1fUkFUSU8gKiBtaW4obWF4X3BmbiwgUEZOX0RPV04oTUFY
TUVNKSkpOw0Kd2lsbCBoYXZlIGEgc2ltaWxhciBlZmZlY3QuDQoNCkknbGwgdHJ5IHRvIGRvIGEg
djIgb2YgdGhlIHBhdGNoc2V0IHRvbW9ycm93Lg0KLSBJJ2xsIGxlYXZlIF9faXNfY29uc3RleHBy
KCkgd2l0aCBpdHMgY3VycmVudCBkZWZpbmUgKGZvciBub3cpLg0KLSBGaXggdGhlIGlzc3VlIHRo
ZSBidWlsZCByb2JvdCBmb3VudC4NCi0gRml4IHRoZSB0eXBvIGluIG1pbjMoKS4NCi0gdXNlIGF1
dG9fdHlwZSBmb3IgbWluL21heCBmdW5jdGlvbnMuDQoNCk9uY2UgdGhhdCBsb3QgaXMgaW4gSSds
bCBkbyBzb21lIGZ1cnRoZXIgY2hhbmdlcyBmb3IgJ25leHQnLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


