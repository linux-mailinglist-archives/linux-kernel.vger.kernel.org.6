Return-Path: <linux-kernel+bounces-264827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959693E8DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415911F21521
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282255D477;
	Sun, 28 Jul 2024 18:24:09 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8041DA2F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722191048; cv=none; b=aq8GX30icr3+Oui8tJtr/nfirViLzBMUSPWBRwi/ad/3eRz/IUVAffh8YmTIouF6CJNVx+pqLT5EpczXdM3phNzLciI/shsCpS8sUAZAOBXB6SRZX0Uam5khS2BAIxX/uBDoVaPVO6xcDubdLLWLFdQchHYknRziGqXoGKjG2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722191048; c=relaxed/simple;
	bh=wdPHeHNM/YtxmqofScmdlWc6oxJIwoldZMLpHvDpKKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VqIHsUi/+hJF2qMbElTKMgsseIDYU1DvF3if6e0eTIwWBWgHeGGTLuDLVKyuH/FWiutnH9XW+0cwPzJgFvvVfO3CfvjR2rNBvRWH/puBnFJXlTtg+Tpf52ZdAy8cX82r8qzJSeIwMo/2esdRBijOB72r1qRtJZwclA5SzsOeb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-5U1uEh_RMOSzpACMfXPSnQ-1; Sun, 28 Jul 2024 19:24:02 +0100
X-MC-Unique: 5U1uEh_RMOSzpACMfXPSnQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 19:23:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 19:23:17 +0100
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
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAAPgnrA=
Date: Sun, 28 Jul 2024 18:23:17 +0000
Message-ID: <0c14422500a4489a972aa917761b3100@AcuMS.aculab.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjggSnVseSAyMDI0IDE4OjI1DQouLi4NCj4g
QnV0IEkgdGhpbmsgZXZlbiBpZiB3ZSBkb24ndCBkbyB0aGF0LCBJIHdvbmRlciBpZiB3ZSBjYW4g
anVzdCBkbyB0aGlzOg0KPiANCj4gICAjZGVmaW5lIF9fY21wX29uY2Uob3AsIHgsIHksIHVuaXF1
ZV94LCB1bmlxdWVfeSkgKHsgICAgIFwNCj4gICAgICAgICAgIHR5cGVvZih4KSB1bmlxdWVfeCA9
ICh4KTsgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgIHR5cGVvZih5KSB1bmlx
dWVfeSA9ICh5KTsgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgIHN0YXRpY19h
c3NlcnQoX190eXBlc19vayh4LCB5KSwgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgIC4u
Lg0KPiANCj4gYW5kIGNoYW5nZSBpdCB0bw0KPiANCj4gICAjZGVmaW5lIF9fY21wX29uY2Uob3As
IHgsIHksIHVuaXF1ZV94LCB1bmlxdWVfeSkgKHsgICAgIFwNCj4gICAgICAgICAgIF9fYXV0b190
eXBlIHVuaXF1ZV94ID0gKHgpOyAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgIF9f
YXV0b190eXBlIHVuaXF1ZV95ID0gKHkpOyAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAg
ICAgIHN0YXRpY19hc3NlcnQoX190eXBlc19vayh1bmlxdWVfeCwgdW5pcXVlX3kpLCAgIFwNCj4g
ICAgICAgICAgIC4uLg0KPiANCj4gYmVjYXVzZSB3aGlsZSB0aGF0IG1heSBzY3JldyB1cCB0aGUg
ImNvbnN0YW50IGludGVnZXIiIGNhc2UgKGJlY2F1c2UNCj4gaXQgbm93IGdvZXMgdGhyb3VnaCB0
aGF0ICJ1bmlxdWVfWFkiIHZhcmlhYmxlLCBtYXliZSBpdCBkb2Vzbid0PyBBdA0KPiBsZWFzdCBn
Y2MgaGFzIGJlZW4ga25vd24gdG8gZGVhbCB3aXRoIHRoaW5ncyBsaWtlIGFyZ3VtZW50cyB0byBp
bmxpbmUNCj4gZnVuY3Rpb25zIHdlbGwgZW5vdWdoIChpZSBhIGNvbnN0YW50IGFyZ3VtZW50IG1l
YW5zIHRoYXQgdGhlIGFyZ3VtZW50cw0KPiBzaG93cyBhcyBfX2J1aWx0aW5fY29uc3RhbnRfcCgp
LCBhbmQgd2UgYWxyZWFkeSBkZXBlbmQgb24gdGhhdCkuDQo+IA0KPiBUaGF0IHNpbmdsZSBjaGFu
Z2Ugd291bGQgY3V0IGRvd24gb24gZHVwbGljYXRpb24gb2YgJ3gnIGFuZCAneScNCj4gX2Vub3Jt
b3VzbHlfLiBObz8NCg0KSUlSQyB0aGUgdW5pcXVlX3ggdmFsdWVzIGNhbiBiZSB0ZXN0ZWQgd2l0
aCBfX2J1aWx0aW5fY29uc3RhbnRwKCkNCmJ1dCB3aWxsIG5ldmVyIGJlICdjb25zdGFudCBpbnRl
Z2VyIGV4cHJlc3Npb25zJyBzbyBjYW4ndCBiZSB1c2VkDQp3aXRoIHN0YXRpY19hc3NlcnQoKSAo
ZXRjKS4NCg0KSSBoYXZlIHRob3VnaHQgYWJvdXQgdXNpbmcgdHlwZW9mKHVuaXF1ZV94KSBidXQg
dGhlIHZhbHVlICd4Jy4NClRoYXQgd291bGQgYmUgbWVzc3kgYnV0IG9ubHkgaGF2ZSBvbmUgZXhw
YW5zaW9uIG9mICd4Jy4NCk1pZ2h0IGJlIGRvYWJsZSBpZiBfX0NPVU5URVJfXyBpcyBwYXNzZWQg
YXMgSSBkaWQgZm9yIG1pbjMoKS4NCg0KSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYnVp
bGQgb24gdGhlc2UgY2hhbmdlcyAtIHNpbmNlIHRoZXkgaGVscC4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


