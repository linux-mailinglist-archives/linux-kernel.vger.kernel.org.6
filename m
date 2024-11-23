Return-Path: <linux-kernel+bounces-419293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A99D6BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B24B210F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11461A0BEE;
	Sat, 23 Nov 2024 22:36:42 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493641632DE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732401402; cv=none; b=Mr9+oLePSwTKlj2mz/r0lREypP4spynLnVP8ODTmFDNutS9LdyShi30de2n9p+Zbr39vOT020sSFPmxsrigJlxP4peWjmpdxgmEuYR/0JchiqRsTpVDGJLgxN5cu1jZVqZb1p4HqYZzqxEETR6B5aIgCds+Z+R8hRGCgq8wpL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732401402; c=relaxed/simple;
	bh=Rw/YGV/uBDU1Hx/Uh2el0gZfZw5hKoxhjFSdgHKPlK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CPTqFzcU6s2iC/ch/AknH1tksxNoMze4oYnQBLksTx+ehjxpyt+xewCq6Wcfm5rE2SPfwnSBlGwc8WIfg+N2gIs3KvFoS/x21I/USAvY79nDRyqiUMrExEjUoMeyoXm/7D9cIMlMeU8ULAMAfQovVWrTPoN9GIxJfUoKe0hhpOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-240-Ujh_iHYmOAKK_3Kq6oXaSQ-1; Sat, 23 Nov 2024 22:36:37 +0000
X-MC-Unique: Ujh_iHYmOAKK_3Kq6oXaSQ-1
X-Mimecast-MFC-AGG-ID: Ujh_iHYmOAKK_3Kq6oXaSQ
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Nov
 2024 22:36:34 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Nov 2024 22:36:34 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann
	<arnd@kernel.org>, Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] x86: Allow user accesses to the base of the guard page
Thread-Topic: [PATCH] x86: Allow user accesses to the base of the guard page
Thread-Index: Ads91tEaZvh8m6sNQhyDMO+nmsu5/wAA3QOAAAboxyA=
Date: Sat, 23 Nov 2024 22:36:34 +0000
Message-ID: <e92823fee58d44b6a50a83fd27206857@AcuMS.aculab.com>
References: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
 <CAHk-=wgT4E+6YO0-SvdD=Gh6wSuUB3Bq_qOiErfZkobQ9gn6=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgT4E+6YO0-SvdD=Gh6wSuUB3Bq_qOiErfZkobQ9gn6=Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: DdwqZgkdtL2C0IjvWCwesTfN8zawA_AuUf66antOegg_1732401396
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgTm92ZW1iZXIgMjAyNCAxOTowMw0KPiAN
Cj4gT24gU2F0LCAyMyBOb3YgMjAyNCBhdCAxMDo0OCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiB0aGF0IGNhc2UgYWNjZXNzX29rKHB0
ciwgc2l6ZSkgd2lsbCBjaGVjayB0aGF0ICdwdHIgKyBzaXplJw0KPiA+IGlzIGEgdmFsaWQgdXNl
ciBhZGRyZXNzIC0NCj4gDQo+IFRoZSBwb2ludCBvZiBVU0VSX1BUUl9NQVggaXMgdGhhdCB0aGUg
c2l6ZSBuZXZlciBtYXR0ZXJzIGFuZCB3ZSBuZXZlcg0KPiBjaGVjayBpdC4gU28gdGhlICItMSIg
aXMgYmFzaWNhbGx5IGp1c3QgdGhlIG1pbmltYWwgc2l6ZS4NCj4gDQo+IEFuZCB0aGUgY29kZSBk
b2VzIGFjdHVhbGx5IGRlcGVuZCBvbiB0aGUgZmFjdCB0aGF0IHRoZSBhY2Nlc3MgaGFzIHRvDQo+
IHN0YXJ0ICpiZWZvcmUqIHRoZSBib3VuZGFyeSB0byB3b3JrLg0KDQpUaGF0IGlzIHRoZSBib3Vu
ZGFyeSBhdCB0aGUgZW5kIG9mIHRoZSBndWFyZCBwYWdlLg0KDQo+IE5vdywgd2UgZG8gaGF2ZSB0
aGF0IHdob2xlICJhdCBsZWFzdCBQQUdFX1NJWkUgb2YgZ3VhcmQgcGFnZSIsIGFuZCBzbw0KPiB0
aGUgMS1ieXRlIG1pbmltYWwgc2l6ZSBkb2Vzbid0IGFjdHVhbGx5IG1hdHRlciwgYnV0IEkgZG9u
J3Qgc2VlIHRoZQ0KPiBwb2ludCBvZiB0aGUgY2hhbmdlLg0KPiANCj4gSW4gcGFydGljdWxhciwg
SSBkb24ndCBzZWUgd2hlbiBpdCB3b3VsZCBtYXR0ZXIgdG8gZG8gYWNjZXNzX29rKHB0ciwNCj4g
MCkgaW4gdGhlIGZpcnN0IHBsYWNlLiBXaG8gZG9lcyB0aGF0LCBhbmQgd2h5IHdvdWxkIGl0IG1h
a2UgYW55IHNlbnNlPw0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IGl0IGlzIHZhbGlkIHRvIHBhc3Mg
YSBidWZmZXIgdGhhdCBlbmRzIHJpZ2h0DQphdCB0aGUgZW5kIG9mIHZhbGlkIHVzZXIgbWVtb3J5
Lg0KSW4gdGhhdCBjYXNlIHRoZSAncHRyICsgc2l6ZScgdGhhdCBhY2Nlc3Nfb2soKSBjaGVja3Mg
aXMgZXF1YWwgdG8NCidUQVNLX1NJWkVfTUFYJyAtIGFuZCBjdXJyZW50bHkgZmFpbHMuDQoNClRo
ZXJlIGlzIGFsc28gYW4gYWNjZXNzX29rKCkgY2hlY2sgaW4gaW92ZWNfaW1wb3J0IChvciBpcyBp
dA0KaW1wb3J0X2lvdmVjKSB0aGF0IGRvZXMgYSBjaGVjayBvbiBldmVyeSBmcmFnbWVudC4NCkl0
IGlzIGRlZmluaXRlbHkgdmFsaWQgdG8gcGFzcyBhIHplcm8gbGVuZ3RoIGJ1ZmZlciB0aGVyZS4N
CihUaGF0IGNoZWNrIGlzIHByb2JhYmx5IHJlZHVuZGFudC4pDQoNClNvIGFjY2Vzc19vaygpIGNh
bid0IGNoZWNrICdwdHIgKyBzaXplIC0gMScgd2l0aG91dCBhbiBleHRyYSBjaGVjaw0KZm9yIHpl
cm8gbGVuZ3RoLg0KQW5kLCBpbiBhbnkgY2FzZSwgeW91IHdvdWxkbid0IHdhbnQgdG8gc3VidHJh
Y3Qgb25lIGluIGV2ZXJ5IGFjY2Vzc19vaygpDQpjYWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


