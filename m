Return-Path: <linux-kernel+bounces-264851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A98F93E931
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61DA1C20C42
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7806EB4A;
	Sun, 28 Jul 2024 20:14:00 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1C1D69E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197640; cv=none; b=QM3o5a0D67R8/sBgkt4QhwFC7kUsfJux09km+YM1sXD9MVsnpq/ph+7qmrCrjuGs4sg7IIQvlfPn9aMzzjyilSQ0mLvHl5G1fSE8VLNS6QKzMvX3F9+aeEmkJqdHkXIyooXZT4Q3mfK/GpK7XTjnmXBwAh5cCs5rju5x8vlAfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197640; c=relaxed/simple;
	bh=ZCMfWxarbHMlN+q25sA7GEt8DahNAdmdlxvB15TgEMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ebttEIYlfe15fTeKL0vgCf9lucZfr8Npj2fQNQ2RR4wcDQihRpd9sh5uC4keZ22mKdNjtN6cXN/tgkBRHMmo0aK7o+Jo/Ob5EOIV8Ga0gzz2HaXYioYgKmsdpEm8pvYJGv34KwPa5Ba7xYkboqVj+yf/oaAUhtNvwITS6DILP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-201-3yRugQglNqyLZF9Tkb6Raw-1; Sun, 28 Jul 2024 21:13:50 +0100
X-MC-Unique: 3yRugQglNqyLZF9Tkb6Raw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 21:13:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 21:13:05 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Jens
 Axboe'" <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>, 'Andrew Morton'
	<akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>, "'pedro.falcato@gmail.com'"
	<pedro.falcato@gmail.com>, 'Mateusz Guzik' <mjguzik@gmail.com>,
	"'linux-mm@kvack.org'" <linux-mm@kvack.org>, 'Lorenzo Stoakes'
	<lorenzo.stoakes@oracle.com>
Subject: RE: [PATCH v2 4/8] minmax: Simplify signedness check
Thread-Topic: [PATCH v2 4/8] minmax: Simplify signedness check
Thread-Index: Adrg+WoBXlsaZZWKRzqVZpRDUvrsDQADV+mAAALbLLAABf5wgA==
Date: Sun, 28 Jul 2024 20:13:04 +0000
Message-ID: <ddf0d76649c44fa29f0fb5c5514987cd@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <74e0b027a908461da879b69b0e12c0de@AcuMS.aculab.com>
 <CAHk-=wjbP7cTOYWusAS-Zg8_YbVBGrNLmJBg3wrhKN7C09CsbA@mail.gmail.com>
 <07727bf98df54d789ba9e8ac66a4190c@AcuMS.aculab.com>
In-Reply-To: <07727bf98df54d789ba9e8ac66a4190c@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDI4IEp1bHkgMjAyNCAxOToxNQ0KPiANCj4gRnJv
bTogTGludXMgVG9ydmFsZHMNCj4gPiBTZW50OiAyOCBKdWx5IDIwMjQgMTc6NTcNCj4gPg0KPiA+
IE9uIFN1biwgMjggSnVsIDIwMjQgYXQgMDc6MjEsIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ICsvKiBBbGxvdyBpZiBib3RoIHggYW5k
IHkgYXJlIHZhbGlkIGZvciBlaXRoZXIgc2lnbmVkIG9yIHVuc2lnbmVkIGNvbXBhcmVzLiAqLw0K
PiA+ID4gKyNkZWZpbmUgX190eXBlc19vayh4LCB5KSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQo+ID4gPiArICAgICAgICgoX19pc19va19zaWduZWQoeCkgJiYgX19pc19va19zaWdu
ZWQoeSkpIHx8ICAgIFwNCj4gPiA+ICsgICAgICAgIChfX2lzX29rX3Vuc2lnbmVkKHgpICYmIF9f
aXNfb2tfdW5zaWduZWQoeSkpKQ0KPiA+DQo+ID4gVGhpcyBzZWVtcyBob3JyZW5kb3VzLCBleGFj
dGx5IGJlY2F1c2UgaXQgZXhwYW5kcyBib3RoIHggYW5kIHkgdHdpY2UuDQo+ID4gQW5kIHRoZSAi
ZXhwYW5kIG11bHRpcGxlIHRpbWVzIiB3YXMgcmVhbGx5IHRoZSBmdW5kYW1lbnRhbCBwcm9ibGVt
Lg0KPiANCj4gVGhpcyB2ZXJzaW9uIGlzIGJldHRlciB0aGFuIHRoZSBwcmV2aW91cyBvbmUgOy0p
DQo+IA0KPiA+IFdoeSBub3QganVzdCBjaGFuZ2UgdGhlIG1vZGVsIHRvIHNheSBpdCdzIGEgYml0
bWFzayBvZiAic2lnbmVkbmVzcw0KPiA+IGJpdHMiLCB0aGUgYml0cyBhcmUgInNpZ25lZCBvayIg
YW5kICJ1bnNpZ25lZCBvayIsIGFuZCB0dXJuIGl0IGludG8NCj4gPg0KPiA+ICAgLyogU2lnbmVk
bmVzcyBtYXRjaGVzPyAqLw0KPiA+ICAgI2RlZmluZSBfX3R5cGVzX29rKHgsIHkpIFwNCj4gPiAg
ICAgIChfX3NpZ25lZG5lc3NfYml0cyh4KSAmIF9fc2lnbmVkbmVzc19iaXRzKHkpKQ0KPiANCj4g
U29tZXRoaW5nIGxpa2UgdGhhdCBtaWdodCB3b3JrLCBidXQgaXQgd291bGQgdGFrZSBzb21lIGVm
Zm9ydCB0byBnZXQgcmlnaHQuDQoNCkFjdHVhbGx5IGl0IGRvZXNuJ3Qgd29yay4NClRoZSBjaGVj
a3MgYXJlIGlzX3NpZ25lZCgoeCkgKyAwKSBhbmQgaXNfdW5zaWduZWQoKHgpKSBzbyB0aGF0ICd1
bnNpZ25lZCBjaGFyJw0KY2FuIGJlIGNvbXBhcmVkIGFnYWluc3QgYm90aCAnaW50JyBhbmQgJ3Vu
c2lnbmVkIGludCcuDQoNCkJ1dCB0aGUgc2lnbmVkbmVzcyB0ZXN0cyBjYW4gdXNlIF91bmlxdWVf
eCB3aGljaCBpcyB0cml2aWFsbHkgc2hvcnQuDQpUaGF0IG5lZWRzIGEgcHJlLWNoYW5nZSB0byBw
YXNzIF9fQ09VTlRFUl9fIHRocm91Z2ggKGFzIGluIG1pbjMoKSkuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=


