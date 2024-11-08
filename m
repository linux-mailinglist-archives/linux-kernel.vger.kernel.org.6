Return-Path: <linux-kernel+bounces-402050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AEE9C22BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782841C23BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF31EBA0C;
	Fri,  8 Nov 2024 17:13:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65F192D89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085984; cv=none; b=s+5f/mLN4ZSAP30SEqGg6hN3JVsAmLl9qd+crHfctseDIgwZd3eEviyz5lIBr4cvLRobayc5vq362GcnQ8EJfuHJ6oUzPJoe7emvelDe1i0wza/mruBnX3DPz/bi06ghQVi0vnij+YUyKINb1TITqV9AyNXXa6poJjgcFAr3Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085984; c=relaxed/simple;
	bh=RO3czDvu1nri5fQkZQg3VXkpBVm+X4ozSSPv7SC0XAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nI75TjUOuux3Y5t0nuw06LKIHmF81Ebhc6oBWF0yNBmPLliHG0QWMAhOfzqJrRGWPBJlyRP400Ym4E9L1i60qAFpcl8blBUJyAF3b7FfmRnF5NGcymGtpEPzEAamdx2Ub0HpajouYkfK4xisxwtvVxnWEWzScF+qysfJPaGGY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-134-MLpserxzNgiutJrUqBQt6w-1; Fri, 08 Nov 2024 17:12:54 +0000
X-MC-Unique: MLpserxzNgiutJrUqBQt6w-1
X-Mimecast-MFC-AGG-ID: MLpserxzNgiutJrUqBQt6w
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Nov
 2024 17:12:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 8 Nov 2024 17:12:53 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Josh Poimboeuf' <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Michael Ellerman
	<mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "Andrew Cooper" <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov"
	<kirill@shutemov.name>
Subject: RE: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Thread-Topic: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Thread-Index: AQHbKc6je06svG7vU0mpJNDFnNBsh7Ktq5PQ
Date: Fri, 8 Nov 2024 17:12:53 +0000
Message-ID: <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
In-Reply-To: <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
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
X-Mimecast-MFC-PROC-ID: 6EzCnmUf2xL8WnHlINObZ2s3wcN5h3Np277CcPRrvDs_1731085973
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMjkgT2N0b2JlciAyMDI0IDAzOjI4DQo+IA0K
PiBPbiBNb24sIE9jdCAyOCwgMjAyNCBhdCAwNjo1NjoxNVBNIC0wNzAwLCBKb3NoIFBvaW1ib2V1
ZiB3cm90ZToNCj4gPiBUaGUgYmFycmllcl9ub3NwZWMoKSBpbiA2NC1iaXQgX19nZXRfdXNlcigp
IGlzIHNsb3cuICBJbnN0ZWFkIHVzZQ0KPiA+IHBvaW50ZXIgbWFza2luZyB0byBmb3JjZSB0aGUg
dXNlciBwb2ludGVyIHRvIGFsbCAxJ3MgaWYgYSBwcmV2aW91cw0KPiA+IGFjY2Vzc19vaygpIG1p
c3ByZWRpY3RlZCB0cnVlIGZvciBhbiBpbnZhbGlkIGFkZHJlc3MuDQo+IA0KPiBMaW51cyBwb2lu
dGVkIG91dCB0aGF0IF9fZ2V0X3VzZXIoKSBtYXkgYmUgdXNlZCBieSBzb21lIGNvZGUgdG8gYWNj
ZXNzDQo+IGJvdGgga2VybmVsIGFuZCB1c2VyIHNwYWNlIGFuZCBpbiBmYWN0IEkgZm91bmQgb25l
IHN1Y2ggdXNhZ2UgaW4NCj4gdmNfcmVhZF9tZW0oKS4uLi4NCj4gDQo+IFNvIEkgc2VsZi1OQUsg
dGhpcyBwYXRjaCBmb3Igbm93Lg0KPiANCj4gU3RpbGwsIGl0IHdvdWxkIGJlIGdyZWF0IGlmIHBh
dGNoIDEgY291bGQgZ2V0IG1lcmdlZCBhcyB0aGF0IGdpdmVzIGENCj4gc2lnbmlmaWNhbnQgcGVy
Zm9ybWFuY2UgYm9vc3QuDQoNCkknbSBhIGJpdCBsYXRlIHRvIHRoZSBwYXJ0eSBhbmQgc3RpbGwg
YSB3ZWVrIGJlaGluZCA6LSgNCg0KQnV0IEkndmUgd29uZGVyZWQgaWYgYWNjZXNzX29rKCkgb3Vn
aHQgdG8gYmUgaW1wbGVtZW50ZWQgdXNpbmcgYW4NCidhc20gZ290byB3aXRoIG91dHB1dCcgLSBt
dWNoIGxpa2UgZ2V0X3VzZXIoKS4NCg0KVGhlbiB0aGUgdXNlIHdvdWxkIGJlOg0KCW1hc2tlZF9h
ZGRyZXNzID0gYWNjZXNzX29rKG1heWJlX2JhZF9hZGRyZXNzLCBzaXplLCBqdW1wX2xhYmVsKTsN
CndpdGggbGF0ZXIgdXNlciBhY2Nlc3NlcyB1c2luZyB0aGUgbWFza2VkX2FkZHJlc3MuDQoNCk9u
Y2UgeW91J3ZlIGRvbmUgdGhhdCBfX2dldF91c2VyKCkgZG9lc24ndCBuZWVkIHRvIGNvbnRhaW4g
YWRkcmVzcyBtYXNraW5nLg0KDQpHaXZlbiB0aGF0IGNsYWMvc3RhYyBpYXJlIHNvIHNsb3cgc2hv
dWxkIHRoZXJlIGFyZSBiZSBzb21ldGhpbmcgdGhhdA0KY29tYmluZXMgc3RhYyB3aXRoIGFjY2Vz
c19vaygpIGJyYWNrZXRlZCB3aXRoIGEgJ3VzZXJfYWNjZXNzX2VuZCcNCm9yIGFuIGFjdHVhbCBm
YXVsdC4NCg0KSSd2ZSBzdXJlIHRoZXJlIGlzIGNvZGUgKG1heWJlIHJlYWRpbmcgaW92ZWNbXSBv
ciBpbiBzeXNfcG9sbCgpKQ0KdGhhdCB3YW50cyB0byBkbyBtdWx0aXBsZSBnZXQvcHV0X3VzZXIg
aW4gYSBzaG9ydCBsb29wIHJhdGhlciB0aGF0DQpjYWxsaW5nIGNvcHlfdG8vZnJvbV91c2VyKCku
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=


