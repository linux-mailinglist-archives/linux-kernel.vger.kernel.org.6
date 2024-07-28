Return-Path: <linux-kernel+bounces-264826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4593E8D8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AB51C20F36
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40807548E1;
	Sun, 28 Jul 2024 18:15:30 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46A8F45
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722190529; cv=none; b=OC6tzbRg7RpOuk99j6EpUp5XpZNnpO0j+WrwxGuBL8n9xaO+DZhbR5OeW/59Wqa55HC6qm5i211poBaVjVf8gCq1yR1lwSNAh/W17vTcNBneyVMHdGM9TNxvGQ3D9epHmI+B++y4GnJsxpirgLLelK3lGktQivO3PRNTQDvzhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722190529; c=relaxed/simple;
	bh=6bXleyjCBCvOZ4FxuL39KAD9sKInAkMJuOsUzl0lKmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ekONiAWBYbqp5qCPiARQ7krhUexPznoW36BZBE57H6UFP+CJFBMQCBxIOxKRPGebSfiRPvCsOIH3hOXzSyAHFEl6ZZOQ+J/gEx8344GbNiEirbtJ3DXgyw3EEduPPC+VDA7h3r3luE94us9crAI6lprEILGIKa/ccnFUyRabyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69-aeTv2hp3M_K3fO1DKuATUQ-1; Sun, 28 Jul 2024 19:15:23 +0100
X-MC-Unique: aeTv2hp3M_K3fO1DKuATUQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 19:14:38 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 19:14:38 +0100
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
Subject: RE: [PATCH v2 4/8] minmax: Simplify signedness check
Thread-Topic: [PATCH v2 4/8] minmax: Simplify signedness check
Thread-Index: Adrg+WoBXlsaZZWKRzqVZpRDUvrsDQADV+mAAALbLLA=
Date: Sun, 28 Jul 2024 18:14:38 +0000
Message-ID: <07727bf98df54d789ba9e8ac66a4190c@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <74e0b027a908461da879b69b0e12c0de@AcuMS.aculab.com>
 <CAHk-=wjbP7cTOYWusAS-Zg8_YbVBGrNLmJBg3wrhKN7C09CsbA@mail.gmail.com>
In-Reply-To: <CAHk-=wjbP7cTOYWusAS-Zg8_YbVBGrNLmJBg3wrhKN7C09CsbA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjggSnVseSAyMDI0IDE3OjU3DQo+IA0KPiBP
biBTdW4sIDI4IEp1bCAyMDI0IGF0IDA3OjIxLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+ICsvKiBBbGxvdyBpZiBib3RoIHggYW5kIHkgYXJl
IHZhbGlkIGZvciBlaXRoZXIgc2lnbmVkIG9yIHVuc2lnbmVkIGNvbXBhcmVzLiAqLw0KPiA+ICsj
ZGVmaW5lIF9fdHlwZXNfb2soeCwgeSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiA+ICsgICAgICAgKChfX2lzX29rX3NpZ25lZCh4KSAmJiBfX2lzX29rX3NpZ25lZCh5KSkgfHwg
ICAgXA0KPiA+ICsgICAgICAgIChfX2lzX29rX3Vuc2lnbmVkKHgpICYmIF9faXNfb2tfdW5zaWdu
ZWQoeSkpKQ0KPiANCj4gVGhpcyBzZWVtcyBob3JyZW5kb3VzLCBleGFjdGx5IGJlY2F1c2UgaXQg
ZXhwYW5kcyBib3RoIHggYW5kIHkgdHdpY2UuDQo+IEFuZCB0aGUgImV4cGFuZCBtdWx0aXBsZSB0
aW1lcyIgd2FzIHJlYWxseSB0aGUgZnVuZGFtZW50YWwgcHJvYmxlbS4NCg0KVGhpcyB2ZXJzaW9u
IGlzIGJldHRlciB0aGFuIHRoZSBwcmV2aW91cyBvbmUgOy0pDQoNCj4gV2h5IG5vdCBqdXN0IGNo
YW5nZSB0aGUgbW9kZWwgdG8gc2F5IGl0J3MgYSBiaXRtYXNrIG9mICJzaWduZWRuZXNzDQo+IGJp
dHMiLCB0aGUgYml0cyBhcmUgInNpZ25lZCBvayIgYW5kICJ1bnNpZ25lZCBvayIsIGFuZCB0dXJu
IGl0IGludG8NCj4gDQo+ICAgLyogU2lnbmVkbmVzcyBtYXRjaGVzPyAqLw0KPiAgICNkZWZpbmUg
X190eXBlc19vayh4LCB5KSBcDQo+ICAgICAgKF9fc2lnbmVkbmVzc19iaXRzKHgpICYgX19zaWdu
ZWRuZXNzX2JpdHMoeSkpDQoNClNvbWV0aGluZyBsaWtlIHRoYXQgbWlnaHQgd29yaywgYnV0IGl0
IHdvdWxkIHRha2Ugc29tZSBlZmZvcnQgdG8gZ2V0IHJpZ2h0Lg0KDQpJdCB3b3VsZCBiZSBiZXR0
ZXIgdG8gcmVtb3ZlIHRoZSAnbG93IGhhbmdpbmcgZnJ1aXQnIG9mIG1pbihwb2ludGVyX3R5cGUp
DQphbmQgdGhlIHBsYWNlcyB3aGVyZSBhIGNvbnN0YW50IGlzIG5lZWRlZCBmaXJzdC4NCkJvdGgg
dGhvc2UgcmVxdWlyZSBleHRyYSBleHBhbnNpb25zIGFuZCB0ZW5kIHRvIG1ha2UgaXQgYWxsIHRo
YXQgbXVjaCBoYXJkZXIuDQoNCj4gYW5kIF9fc2lnbmVkbmVzc19vaygpIHNpbXBseSBkb2VzIHNv
bWV0aGluZyBsaWtlICIxIGlmIHVuc2lnbmVkIHR5cGUsDQo+IDIgaWYgc2lnbmVkIHR5cGUsIDMg
aWYgc2lnbmVkIHBvc2l0aXZlIGludGVnZXIiLg0KPiANCj4gU29tZXRoaW5nIGxpa2UgKHZlcnkg
dmVyeSBoYW5kd2F2eSwgdmVyeSB2ZXJ5IHVudGVzdGVkKToNCj4gDQo+ICAgIF9fYnVpbHRpbl9j
aG9vc2VfZXhwcihpc19zaWduZWRfdHlwZSh0eXBlb2YoeCkpLA0KPiAgICAgICAgIDIrX19pZl9j
b25zdGV4cHIoeCwoeCk+MCwwKSwNCj4gICAgICAgICAxKQ0KDQpZb3UnZCB3YW50IHRvIHRlc3Qg
Jyh4KSA+PSAwJyBhbmQgdGhlIGNvbXBpbGVyIGlzIGdvaW5nIHRvIGJsZWF0DQood2l0aCAtV2Fs
bCkgaWYgKHgpIGlzIGFuIHVuc2lnbmVkIHR5cGUgLSBldmVuIHRob3VnaCB0aGUgY29kZSBpc24n
dCB1c2VkLg0KTmVpdGhlciBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoKSBvciBfR2VuZXJpYygpIGhl
bHAgd2l0aCB0aGF0Lg0KVW5sZXNzIHlvdSBuZWVkIHRoZSB0eXBlcyB0byBkaWZmZXIgPzogaXMg
anVzdCBhcyBnb29kLg0KDQo+IEFjdHVhbGx5LCBJIHRoaW5rIHRoYXQgIl9faWZfY29uc3RleHBy
KCkiIGNvdWxkIHZlcnkgd2VsbCBiZSAiaWYga25vd24NCj4gcG9zaXRpdmUgdmFsdWUiLCBpZSAn
eCcgaXRzZWxmIGRvZXNuJ3QgaGF2ZSB0byBiZSBjb25zdGFudCwgYnV0ICJ4PjAiDQo+IGhhcyB0
byBiZSBhIGNvbnN0YW50ICh0aGUgZGlmZmVyZW5jZSBiZWluZyB0aGF0IHRoZSBjb21waWxlciBt
YXkgYmUNCj4gYWJsZSB0byB0ZWxsIHRoYXQgc29tZSB2YXJpYWJsZSBpcyBhbHdheXMgcG9zaXRp
dmUsIGV2ZW4gaWYgaXQncyBhDQo+IHZhcmlhYmxlKToNCj4gDQo+ICAgI2RlZmluZSBzdGF0aWNh
bGx5X3RydWUoeCkgX19idWlsdGluX2NvbnN0YW50X3AoKHgpLCh4KSwwKQ0KPiAgICNkZWZpbmUg
aXNfcG9zaXRpdmVfdmFsdWUoeCkgc3RhdGljYWxseV90cnVlKCh4KT49MCkNCg0KSSB0aGluayB0
aGF0IHRlc3QgY291bGQgYmUgZG9uZSBvbiBfX3ggKGllIHRoZSBsb2NhbCBjb3B5KS4NCkJ1dCB0
aGVuIHlvdSBjYW4ndCB1c2Ugc3RhdGljX2Fzc2VydCgpIGFuZCBnZXQgYSBzYW5lIGVycm9yIG1l
c3NhZ2UuDQooQnV0IGRvbid0IGxvb2sgYXQgd2hhdCBjbGFuZyBvdXRwdXRzLi4uKQ0KDQo+IGFu
ZCB0aGVuIHVzZQ0KPiANCj4gICAgX19idWlsdGluX2Nob29zZV9leHByKGlzX3NpZ25lZF90eXBl
KHR5cGVvZih4KSksDQo+ICAgICAgICAgMitpc19wb3NpdGl2ZV92YWx1ZSh4KSwgMSkNCj4gDQo+
IGFuZCB5ZXMsIEkgcmVhbGl6ZSBJIGNvdW50IHplcm8gYXMgYSBwb3NpdGl2ZSB2YWx1ZSwgYnV0
IHdyaXRpbmcgb3V0DQo+ICJub25uZWdhdGl2ZSgpIiBpcyBhbm5veWluZyBhbmQgd2UgbmV2ZXIg
Y2FyZS4NCg0KSSBnb3QgYW5ub3llZCBlYXJsaWVyIDotKQ0KPiANCj4gSSBndWVzcyB3ZSBjb3Vs
ZCBzYXkgImlzX3Vuc2lnbmVkX3ZhbHVlKCkiPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


