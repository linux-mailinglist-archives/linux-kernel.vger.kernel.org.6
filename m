Return-Path: <linux-kernel+bounces-411905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A39D0106
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF71F23757
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64319D096;
	Sat, 16 Nov 2024 21:38:50 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CA15E97
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793130; cv=none; b=Asq8TstnfBlYcRXte+R2Fzy/CIRbfjv24O2KyjRS3Vk7bu7F9epesoenH0Ac3mKPgVqSBu87kgBT9S0+q5pWJjspzYBWj9uo1eorqZT4CK4lsmambYFiy8w2r9WpEez9pxI2BJbwQaOjLDUbnfqEjaooom8dJb+OGfLeRJjf3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793130; c=relaxed/simple;
	bh=Hc2XGFjuXeJ15jPzV6P+/r18QrW8HZSQd8bGKAujwus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PfcZuPPWDcwk1A8lzheMw3GxX3lCbISOOfe0iRPH3ttl8S6Zb6WCQMHfEEuf9IYNQlZYl/AAJvgOdT2VadQZ3cENdj4zxC1GSpTx149VrvA33a6AXNw7FgcYYwlLxNOaeAUlBnUxd7mLwmVQ79DRPlPeWsh6VUkKctG0wP85160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-141-h79k7KFOPgSvZ4dAolKOUQ-1; Sat, 16 Nov 2024 21:38:36 +0000
X-MC-Unique: h79k7KFOPgSvZ4dAolKOUQ-1
X-Mimecast-MFC-AGG-ID: h79k7KFOPgSvZ4dAolKOUQ
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 16 Nov
 2024 21:38:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 16 Nov 2024 21:38:35 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov"
	<kirill@shutemov.name>
Subject: RE: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Thread-Topic: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Thread-Index: AQHbKc6je06svG7vU0mpJNDFnNBsh7Ktq5PQgAuONbKAAUs+QA==
Date: Sat, 16 Nov 2024 21:38:35 +0000
Message-ID: <4055e18be7ff4f1f83fb9a4b6a8bc312@AcuMS.aculab.com>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
 <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
 <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
In-Reply-To: <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: Hj-nizpus-nveCwF3X3PaXcJjFhrlEu4K9JiB89Ca7I_1731793115
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTYgTm92ZW1iZXIgMjAyNCAwMToyNw0KPiAN
Cj4gT24gRnJpLCAxNSBOb3YgMjAyNCBhdCAxNTowNiwgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9l
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSXQncyBzYWQgdGhhdCBfX2dldF91c2VyKCkg
aXMgbm93IHNsb3dlciB0aGFuIGdldF91c2VyKCkgb24geDg2LCBpdCBraW5kDQo+ID4gb2YgZGVm
ZWF0cyB0aGUgd2hvbGUgcG9pbnQhDQo+IA0KPiBXZWxsLCBob25lc3RseSwgd2UndmUgYmVlbiB0
cnlpbmcgdG8gZ2V0IGF3YXkgZnJvbSBfX2dldF91c2VyKCkgYW5kDQo+IF9fcHV0X3VzZXIoKSBm
b3IgYSBsb25nIGxvbmcgdGltZS4NCj4gDQo+IFdpdGggQ0xBQy9TVEFDLCBpdCdzIGJlZW4gcHJv
YmFibHkgYSBkZWNhZGUgb3IgdHdvIHNpbmNlIF9fZ2V0X3VzZXIoKQ0KPiBhbmQgZnJpZW5kcyB3
ZXJlIGFjdHVhbGx5IGEgd29ydGh3aGlsZSBvcHRpbWl6YXRpb24sIHNvIGxldCdzIGp1c3QNCj4g
c3RyaXZlIHRvIGdldCByaWQgb2YgdGhlIG9uZXMgdGhhdCBtYXR0ZXIuDQoNClRoaW5rcy4uLi4N
Cg0KSWYgX19nZXRfdXNlcigpIGlzIHRoZSBzYW1lIGFzIGdldF91c2VyKCkgdGhlbiBhbGwgdGhl
IGFjY2Vzc19vaygpDQpvdXRzaWRlIG9mIGdldC9wdXRfdXNlcigpIGFuZCBjb3B5X3RvL2Zyb21f
dXNlcigpIGNhbiBiZSByZW1vdmVkDQpiZWNhdXNlIHRoZXkgYXJlIHBvaW50bGVzcyAoYW55b25l
IHRoYXQgYnJhdmU/KS4NClRoZXJlIGlzIG5vIHBvaW50IG9wdGltaXNpbmcgdGhlIGNvZGUgdG8g
ZmFzdC1wYXRoIGJhZCB1c2VyIHBvaW50ZXJzLg0KDQo+IFdlIGFscmVhZHkgaGF2ZSB0aGlzIHdp
dGggdXNlcl9hY2Nlc3NfYmVnaW4oKSArIHVuc2FmZV9nZXRfdXNlcigpLg0KPiBUaGVyZSdzIGFs
c28gYSB2ZXJzaW9uIHdoaWNoIG1hc2tzIHRoZSBhZGRyZXNzOiBtYXNrZWRfdXNlcl9hY2Nlc3Nf
YmVnaW4oKS4NCg0KVGhhdCBzb3VuZHMgYXMgdGhvdWdoIGl0IGlzIGJlZ2dpbmcgZm9yIGEgc2lt
cGxlIHRvIHVzZToNCgltYXNrZWRfYWRkciA9IHVzZXJfYWNjZXNzX2JlZ2luKGFkZHIsIHNpemUs
IGVycm9yX2xhYmVsKTsNCmFuZA0KCXZhbCA9IHVuc2FmZV9nZXRfdXNlcihtYXNrZWRfYWRkciwg
ZXJyb3JfbGFiZWwpOw0KZm9ybT8NClByb2JhYmx5IHdpdGggb2JqdG9vbCBjaGVja2luZyB0aGV5
IGFyZSBhbGwgaW4gYSB2YWxpZCBzZXF1ZW5jZQ0Kd2l0aCBubyBmdW5jdGlvbnMgY2FsbHMgKGV0
YykuDQoNCklmIGFkZHJlc3MgbWFza2luZyBpc24ndCBuZWVkZWQgKGJ5IGFuIGFyY2hpdGVjdHVy
ZSkgdGhlIGFkZHJlc3MgY2FuIGJlIGxlZnQNCnVuY2hhbmdlZC4NCg0KQSBxdWljayBncmVwIHNo
b3dzIGFjY2Vzc19vaygpIGluIDY2IC5jIGFuZCA4IC5oIGZpbGVzIG91dHNpZGUgdGhlIGFyY2gg
Y29kZS4NCkFuZCA2OSAuYyBmaWxlIGluIGFyY2gsIG1vc3Qgb2YgdGhlIGFyY2ggLmggYXJlIHVh
Y2Nlc3MuaCBhbmQgZnV0ZXguaC4NCkkgc3VzcGVjdCB0aGUgYXVkaXQgd291bGRuJ3QgdGFsZSB0
aGF0IGxvbmcuDQpHZXR0aW5nIGFueSBwYXRjaGVzIGFjY2VwdGVkIGlzIGFub3RoZXIgbWF0dGVy
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K


