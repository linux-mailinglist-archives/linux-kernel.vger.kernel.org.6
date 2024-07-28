Return-Path: <linux-kernel+bounces-264825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7493E8D7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AA4B20C72
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD35FB95;
	Sun, 28 Jul 2024 18:13:40 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0B18EB0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722190420; cv=none; b=q8i99iLGDMdj7HF3eVSn5kDW35P1TE03mEt9Ud305qRJO2c2LFoy8Ek+HPG2Z0LIRN9gjGJm21gQTsen3CTLekgakrcvrrTLIpJBR9Rp/uR8SjrRCtP2jNssnkfeXIWOXd8mLThLHI3i6M9vNfQbqjg3H+AJTG+h4Cod588V1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722190420; c=relaxed/simple;
	bh=H2rw0mPmYBENcvi1qXqsgEgOBIvxsSNh81rECjHH+YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Rf55Ycqn8lC00OqB6ygvzlXPqUuQSw4lGnx5Gjdul9OfMVZlUiF7DYtbC2G6M8a5vQ4vvN9vv2XKz2vkThlDr6BT8KqiUwu5fP5m4bFt1YqtigSEqY1cYYinBjBprclDx9W0HcBrSw9LYk0UY5BDw5IbSn9FrzeuW/B0jZ9ov80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-70-rn4dB53gM8-TjpI3oUH8Gg-1; Sun, 28 Jul 2024 19:13:30 +0100
X-MC-Unique: rn4dB53gM8-TjpI3oUH8Gg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 19:12:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 19:12:46 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: 'Linus Torvalds' <torvalds@linuxfoundation.org>, 'Jens Axboe'
	<axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>, 'Andrew Morton'
	<akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>, "'pedro.falcato@gmail.com'"
	<pedro.falcato@gmail.com>, 'Mateusz Guzik' <mjguzik@gmail.com>,
	"'linux-mm@kvack.org'" <linux-mm@kvack.org>, 'Lorenzo Stoakes'
	<lorenzo.stoakes@oracle.com>
Subject: RE: [PATCH v2 2/8] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Topic: [PATCH v2 2/8] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Index: Adrg+SQVeb05XypLRkeZ+5Y+23noEAAFUgAAAALT6zA=
Date: Sun, 28 Jul 2024 18:12:46 +0000
Message-ID: <a5c56a65a0894497b0242a0bb80860cd@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <b169a04caaee43c7b917a7e48470da6a@AcuMS.aculab.com>
 <76573179-1e38-4620-bf59-6801341802b5@wanadoo.fr>
In-Reply-To: <76573179-1e38-4620-bf59-6801341802b5@wanadoo.fr>
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

RnJvbTogQ2hyaXN0b3BoZSBKQUlMTEVUDQo+IFNlbnQ6IDI4IEp1bHkgMjAyNCAxODo1Mg0KPiAN
Cj4gTGUgMjgvMDcvMjAyNCDDoCAxNjoxOCwgRGF2aWQgTGFpZ2h0IGEgw6ljcml0wqA6DQo+ID4g
VGhlIHN0YXRpY19hc3NlcnQoKSB3cmFwcGVyIHByb3ZpZGVzIHRoZSB0ZXh0IG9mIHRoZSBleHBy
ZXNzaW9uIGFzIHRoZQ0KPiA+IGVycm9yIG1lc3NhZ2UsIHRoaXMgaXNuJ3QgbmVlZGVkIGhlcmUg
YXMgYW4gZXhwbGljaXQgbWVzc2FnZSBpcyBwcm92aWRlZC4NCj4gPiBJZiB0aGVyZSBpcyBhbiBl
cnJvciAocXVpdGUgbGlrZWx5IGZvciBtaW4vbWF4KSB0aGUgd3JhcHBlciBhbHNvIGFkZHMNCj4g
PiB0d28gbW9yZSBsaW5lcyBvZiBlcnJvciBvdXRwdXQgdGhhdCBqdXN0IG1ha2UgaXQgaGFyZGVy
IHRvIHJlYWQuDQo+ID4NCj4gPiBTaW5jZSBpdCBnaXZlcyBubyBiZW5lZml0IGFuZCBhY3R1YWxs
eSBtYWtlcyB0aGluZ3Mgd29yc2UgZGlyZWN0bHkNCj4gPiB1c2luZyBfU3RhdGljX2Fzc2VydCgp
IGlzIG11Y2ggYmV0dGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGFpZ2h0IDxk
YXZpZC5sYWlnaHRAYWN1bGFiLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAtIE5vIGNoYW5n
ZS4NCj4gPg0KPiA+ICAgaW5jbHVkZS9saW51eC9taW5tYXguaCB8IDggKysrKy0tLS0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9taW5tYXguaCBiL2luY2x1ZGUvbGludXgvbWlu
bWF4LmgNCj4gPiBpbmRleCBjZWE2M2E4YWM4MGYuLmFiNjRiMmU3M2FlNSAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L21pbm1heC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9taW5t
YXguaA0KPiA+IEBAIC00OCw3ICs0OCw3IEBADQo+ID4gICAjZGVmaW5lIF9fY21wX29uY2Uob3As
IHgsIHksIHVuaXF1ZV94LCB1bmlxdWVfeSkgKHsJXA0KPiA+ICAgCXR5cGVvZih4KSB1bmlxdWVf
eCA9ICh4KTsJCQlcDQo+ID4gICAJdHlwZW9mKHkpIHVuaXF1ZV95ID0gKHkpOwkJCVwNCj4gPiAt
CXN0YXRpY19hc3NlcnQoX190eXBlc19vayh4LCB5KSwJCQlcDQo+ID4gKwlfU3RhdGljX2Fzc2Vy
dChfX3R5cGVzX29rKHgsIHkpLAkJCVwNCj4gDQo+IE5pdHBpY2ssIHNob3VsZCB0aGVyZSBiZSBh
IHYzOiBhIHRhYiBjYW4gYmUgcmVtb3ZlZCB0byBrZWVwIHRoaW5ncyBhbGlnbmVkLg0KDQpJIHRo
aW5rIHRoYXQgaXMgcGlja2VkIHVwIGJ5IGEgbGF0ZXIgcGF0Y2ggdG8gdGhlIHNhbWUgbGluZXMu
DQpUaGlzIGZpbmFsIGZpbGUgbG9va3Mgb2suDQoNCglEYXZpZA0KDQo+IA0KPiA+ICAgCQkjb3Ag
IigiICN4ICIsICIgI3kgIikgc2lnbmVkbmVzcyBlcnJvciwgZml4IHR5cGVzIG9yIGNvbnNpZGVy
IHUiICNvcCAiKCkgYmVmb3JlICIgI29wDQo+ICJfdCgpIik7IFwNCj4gPiAgIAlfX2NtcChvcCwg
dW5pcXVlX3gsIHVuaXF1ZV95KTsgfSkNCj4gDQo+IENKDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


