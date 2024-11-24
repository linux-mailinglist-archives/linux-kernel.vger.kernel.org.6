Return-Path: <linux-kernel+bounces-420150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6889D7711
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857F7B2300B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7C188CCA;
	Sun, 24 Nov 2024 16:11:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294A186294
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732464671; cv=none; b=LXC6Mfa+19P+wI+OpY5cISKOIMSW5eI5RXJZRmeIjss5s1C26KjowsB5RUCVWvBBeFNAmLTZIQhMy2piWf2NtvMhv09tZz8kijYPzvkzV47jc3iilzdZ6FU8CR7KM9QeWSq9f7hV5v7wK41Z/0CvT7uAdJ92X506td9jOJbtevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732464671; c=relaxed/simple;
	bh=+KOcutOP1PSDiev4veBz7LGcShr8DBpOg10AsqqkIAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=j2Nd551EDqSvDo/fdX14YJ/qfSn8jYLCdzvRIp9xz09bZTGQU6dW0MRyK+j3rzoXZ3rzTwGNJ6W+L14O6Wmjk169GMvIazUd/k0ISDZFVglRZBNnUmu50rqJ9ZB7yKUzfos9VR5y2xuqwFSaHXr/KbjjcqUjBEAQ7EX9OlEUY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-330-avUDmvL1PZyQW6YwkxJjow-1; Sun, 24 Nov 2024 16:11:07 +0000
X-MC-Unique: avUDmvL1PZyQW6YwkxJjow-1
X-Mimecast-MFC-AGG-ID: avUDmvL1PZyQW6YwkxJjow
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Nov
 2024 16:11:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Nov 2024 16:11:04 +0000
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
Thread-Index: AQHbKc6je06svG7vU0mpJNDFnNBsh7Ktq5PQgBYsN/GAAufo0A==
Date: Sun, 24 Nov 2024 16:11:04 +0000
Message-ID: <2d7744d7ce504b288c3f1356f27910ec@AcuMS.aculab.com>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
 <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
 <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe>
 <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe>
 <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
 <20241122031115.5aasuktqrp2sidfj@jpoimboe>
 <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
 <CAHk-=wiL0TepguMNaR65ZdkkiBEoi4hTE7PwG3bBO1c5SOXmWw@mail.gmail.com>
 <CAHk-=wj4LHCiD8f75q-jf7mu7Jyn-wHgGoni6WSQtdh7+HtGNw@mail.gmail.com>
In-Reply-To: <CAHk-=wj4LHCiD8f75q-jf7mu7Jyn-wHgGoni6WSQtdh7+HtGNw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: kpEwDBHaq8EOCIbwspxirPcjN0C17oicXWgvPV-CY9M_1732464666
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjIgTm92ZW1iZXIgMjAyNCAxOTozNQ0KPiAN
Cj4gT24gRnJpLCAyMiBOb3YgMjAyNCBhdCAxMToxMywgTGludXMgVG9ydmFsZHMNCj4gPHRvcnZh
bGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IEkndmUgb25seSBjb21w
aWxlZCBpdCBzbyBmYXIsIGFib3V0IHRvIGFjdHVhbGx5IGJvb3QgaW50byBpdC4NCj4gDQo+IExv
b2tzIGZpbmUuIFNlbnQgb3V0IGEgcHJvcGVyIHBhdGNoIHdpdGggY29tbWl0IG1lc3NhZ2UgZXRj
IGF0DQo+IA0KPiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDExMjIxOTMzMDUu
NzMxNi0xLXRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnLw0KPiANCj4gYmVjYXVzZSBpdCBs
b29rcyBnb29kIHRvIG1lLiBDb21tZW50cz8NCg0KK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgaW50
IGZ1dGV4X3JlYWRfaW5hdG9taWModTMyICpkZXN0LCB1MzIgX191c2VyICpmcm9tKQ0KK3sNCisJ
dTMyIHZhbDsNCisNCisJaWYgKGNhbl9kb19tYXNrZWRfdXNlcl9hY2Nlc3MoKSkNCisJCWZyb20g
PSBtYXNrZWRfdXNlcl9hY2Nlc3NfYmVnaW4oZnJvbSk7DQorCWVsc2UgaWYgKCF1c2VyX3JlYWRf
YWNjZXNzX2JlZ2luKGZyb20sIHNpemVvZigqZnJvbSkpKQ0KKwkJcmV0dXJuIC1FRkFVTFQ7DQor
CXVuc2FmZV9nZXRfdXNlcih2YWwsIGZyb20sIEVmYXVsdCk7DQorCXVzZXJfYWNjZXNzX2VuZCgp
Ow0KKwkqZGVzdCA9IHZhbDsNCisJcmV0dXJuIDA7DQorRWZhdWx0Og0KKwl1c2VyX2FjY2Vzc19l
bmQoKTsNCisJcmV0dXJuIC1FRkFVTFQ7DQorfQ0KKw0KK3N0YXRpYyBpbmxpbmUgaW50IGZ1dGV4
X2dldF92YWx1ZV9sb2NrZWQodTMyICpkZXN0LCB1MzIgX191c2VyICpmcm9tKQ0KK3sNCisJaW50
IHJldDsNCisNCisJcGFnZWZhdWx0X2Rpc2FibGUoKTsNCisJcmV0ID0gZnV0ZXhfcmVhZF9pbmF0
b21pYyhkZXN0LCBmcm9tKTsNCisJcGFnZWZhdWx0X2VuYWJsZSgpOw0KKw0KKwlyZXR1cm4gcmV0
Ow0KK30NCg0KSXMgdGhlcmUgYW4gJ3Vuc2FmZV9nZXRfdXNlcl9ub2ZhdWx0KCknIHRoYXQgdXNl
cyBhIHRyYXAgaGFuZGxlcg0KdGhhdCB3b24ndCBmYXVsdCBpbiBhIHBhZ2U/DQpUaGF0IHdvdWxk
IHNhdmUgdGhlIGluYy9kZWMgZG9uZSBieSBwYWdlZmF1bHRfZW4vZGlzYWJsZSgpLg0KDQpJJ2Qg
YWxzbyBoYXZlIHRob3VnaHQgdGhhdCB0aGUgdHJhcCBoYW5kbGVyIGZvciB1bnNhZmVfZ2V0X3Vz
ZXIoKQ0Kd291bGQganVtcCB0byB0aGUgRWZhdWx0IGxhYmVsIGhhdmluZyBhbHJlYWR5IGRvbmUg
dXNlcl9hY2Nlc3NfZW5kKCkuDQpCdXQgbWF5YmUgaXQgZG9lc24ndCB3b3JrIG91dCB0aGF0IHdh
eT8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


