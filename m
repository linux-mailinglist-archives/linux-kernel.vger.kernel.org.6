Return-Path: <linux-kernel+bounces-261958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78F93BE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01A11C211B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A3176239;
	Thu, 25 Jul 2024 09:01:29 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C31F17B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898089; cv=none; b=D5XeM29dxa+ZuXTE/j48gnBByRSKJonaMufyEeMOsRRYLUl7nmuJ5sHMKKNUz7Xd/j99vL/uOoHTY+EMyXJ/5//JUVLc+Ixf5YR8gs+LooyUsJwG0GYRJB5JA1ydTWgPUaA+pChQvnoRiobHdkMTU+P0hkOQNjeamTJjSuMe4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898089; c=relaxed/simple;
	bh=MTw9YQpaP4DZIllDv2i1QDKKCngSly6MsuKSmKn3Pjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=J5sf/ra4owIt1o/OLVeor3Ft28CN9+TonZd+sP8mYBBdJRqwN4e/J0tssUlBp7O3gxQlNeSjJ1IJwoQGKEeSRH+T8V3C7ADHhFeAwZjX0k6cjhthsRc5ISCHRBzXpCe2ApnTVm8HaOu4dhFgt0ThjegF6+oKf3guWQ6NGAeG5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313-Ao-nHRIrNGeHCG2F6qKLUg-1; Thu, 25 Jul 2024 10:01:20 +0100
X-MC-Unique: Ao-nHRIrNGeHCG2F6qKLUg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jul
 2024 10:00:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 25 Jul 2024 10:00:41 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>, Arnd Bergmann
	<arnd@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 4/7] minmax: Simplify signedness check
Thread-Topic: [PATCH 4/7] minmax: Simplify signedness check
Thread-Index: Adrd1i0k/JcX2h1sSAO9D37F5HIFAAALj27TABqyPTA=
Date: Thu, 25 Jul 2024 09:00:41 +0000
Message-ID: <5a129d04e0b84b48ba6c5189a047ac8f@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
 <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
 <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
In-Reply-To: <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgSnVseSAyMDI0IDIxOjAzDQo+IA0KPiBP
biBXZWQsIDI0IEp1bCAyMDI0IGF0IDA5OjQ5LCBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiA+DQo+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGlzIHJldHVybiAn
MCcgZm9yIHVuc2lnbmVkIHR5cGVzLA0KPiA+IHNob3VsZG4ndCB0aGlzIGJlDQo+ID4NCj4gPiAo
KGlzX3Vuc2lnbmVkX3R5cGUodHlwZW9mKHgpKSA/IDEgOiBfX2lmX2NvbnN0ZXhwcih4LCAoeCkg
KyAwLCAtMSkpID49IDApDQo+IA0KPiBZZXMsIHRoYXQgbG9va3MgbW9yZSBsb2dpY2FsLg0KDQpU
aGUgY29uZGl0aW9uIGlzICc+PSAwJyBzbyBpdCBkb2Vzbid0IG1hdHRlciBpZiBpdCBpcyAnMScg
b3IgJzAnLg0KDQo+IFBsdXMgd2h5IGRvIHRoYXQgIl9faWZfY29uc3RleHByKHgsICh4KSArIDAs
IC0xKSkgPj0gMCkiIHdoZW4gaXQgd291bGQNCj4gYXBwZWFyIHRvIGJlIG1vcmUgbG9naWNhbCB0
byBtb3ZlIHRoZSBjb21wYXJpc29uIGluc2lkZSwgaWUNCj4gDQo+ICAgX19pZl9jb25zdGV4cHIo
eCwgKHgpID49IDAsIDApDQoNClRoYXQgZ2l2ZXMgYSAnY29tcGFyaXNvbiBvZiB1bnNpZ25lZCB0
eXBlIGFnYWluc3QgMCBpcyBhbHdheXMgdHJ1ZScgd2FybmluZy4NCihUaGUgY29tcGlsZXIgZ2Vu
ZXJhdGVzIHRoYXQgZm9yIGNvZGUgaW4gdGhlIHVudXNlZCBicmFuY2hlcyBvZiBib3RoDQpfX2J1
aWx0aW5fY2hvb3NlX2V4cHIoKSBhbmQgX0dlbmVyaWMoKS4pDQpNb3ZpbmcgdGhlIGNvbXBhcmlz
b24gdG8gdGhlIG91dGVyIGxldmVsIHN0b3BzIGFsbCBzdWNoIGNvbXBpbGVyIHdhcm5pbmdzLg0K
DQo+IGJ1dCBJIGFsc28gZG9uJ3Qgc2VlIHdoeSB0aGF0ICIrIDAiIGV4aXN0ZWQgaW4gdGhlIG9y
aWdpbmFsLiBTbw0KPiB0aGVyZSdzIHByZXN1bWFibHkgc29tZXRoaW5nIEknbSBtaXNzaW5nLg0K
DQpJSVJDIGl0IHdhcyB0aGVyZSB0byBjb252ZXJ0IGEgJ2Jvb2wnIHRvICdpbnQnLg0KU29tZXdo
ZXJlIHRoZSBpcyBhIG1heChib29sLGJvb2wpIHRoYXQgY291bGQganVzdCBiZSB8Lg0KSWYgbWF5
IG5vdCBiZSBuZWVkZWQgbm93IHRoZSBleHBhbnNpb24gaXMgJyhjb25kID8gMCA6IGJvb2wpID49
IDAnDQpzaW5jZSB0aGUgJ2Jvb2wnIHBpY2tzIHVwIGFuIChpbnQpIGNhc3QgZnJvbSB0aGUgcmVz
dWx0IG9mID86Lg0KDQoJRGF2aWQNCg0KPiBJIGRvIGdldCB0aGUgZmVlbGluZyB0aGF0IHRoZSBw
cm9ibGVtIGNhbWUgZnJvbSB1cyBiZWluZyBtdWNoIHRvbw0KPiBjbGV2ZXIgd2l0aCBvdXQgbWlu
L21heCBtYWNyb3MsIGFuZCBub3cgdGhpcyBzZXJpZXMgaXMgIGRvdWJsaW5nIGRvd24NCj4gaW5z
dGVhZCBvZiBzYXlpbmcgIml0IHdhc24ndCByZWFsbHkgd29ydGggaXQiLg0KPiANCj4gICAgICAg
ICAgICAgICBMaW51cw0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=


