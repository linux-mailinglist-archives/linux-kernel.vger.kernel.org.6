Return-Path: <linux-kernel+bounces-207208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F156E9013B1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5899C281D01
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64423741;
	Sat,  8 Jun 2024 21:36:37 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48A1D531
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717882596; cv=none; b=J5c344ycMc5igUyWOj4SK9EHQXGJyRyo7sjixZDhEdaFIzsDSoPTTp/SNf5U7H2ik0XS7flU+HFFj/1ccP3fvIA2Xe8awPRgeDLEuVJHHiqLGyYt4mFEjJ+VA9JERxtNGdxlqHzxEZ/3TOvrDaCLK9C8o5bUX7mD/+ziYuYdupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717882596; c=relaxed/simple;
	bh=ckWyIeSdsDvmQmA7Uur7mW2LMT+TmsIo3QCKCFSBqSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=taJKUO9sk1Sbhgol3tMml0p1SbCCogH/BWlXekbU3g7vnV5kEzv9dN8QxXewgANSRlMvLQ7V9qKdHRDLE8wUbrCFROREPcTWVHYoVnLANcUYbFFHHvuZpiD2KSd/vFvHYQHTE0QIMcuCkYuz/iwRlJVfVts1JnG/z1TUO8TvBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-5ESWHAR6MZqEhqVHYHE5zQ-1; Sat, 08 Jun 2024 22:36:24 +0100
X-MC-Unique: 5ESWHAR6MZqEhqVHYHE5zQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 8 Jun
 2024 22:35:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 8 Jun 2024 22:35:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 6.10-rc2 - massive performance regression
Thread-Topic: Linux 6.10-rc2 - massive performance regression
Thread-Index: Adq5okQ7HduYf8qJTJSPwCpAtFdr/wAEqzOAAAzamAA=
Date: Sat, 8 Jun 2024 21:35:48 +0000
Message-ID: <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
 <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
In-Reply-To: <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggSnVuZSAyMDI0IDE3OjAzDQo+IA0KPiBP
biBTYXQsIDggSnVuIDIwMjQgYXQgMDc6NDQsIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSSBzdXNwZWN0IGl0IGlzIGR1ZSB0byB0aGUgY2hh
bmdlcyB0byB0aGUgd2F5IHRoZSBzY2hlZHVsZXIgcHJlLWVtcHRzDQo+ID4gcHJvY2Vzc2VzLg0K
PiANCj4gVGhlIFBSRUVNUFRfQVVUTyBjaGFuZ2VzIGhhdmVuJ3QgZXZlbiBtYWRlIGl0IGludG8g
dGhlIGtlcm5lbCB5ZXQsDQo+IG9ubHkgYSBjb3VwbGUgb2YgcHJlbGltaW5hcnkgcmN1IHBhdGNo
ZXMgdGhhdCBhcmVuJ3QgcmVsZXZhbnQgeWV0Lg0KPiANCj4gU28gd2hpbGUgdGhlcmUncyBiZWVu
IHNvbWUgc2NoZWR1bGVyIGNoYW5nZXMgaW4gNi4xMCwgdGhleSBoYXZlIG1vc3RseQ0KPiBiZWVu
IHByZXR0eSBpbnNpZ25pZmljYW50IC0gbW9zdGx5IHNvbWUgcmVuYW1pbmcgd2l0aG91dCBmdW5j
dGlvbmFsDQo+IGNoYW5nZXMsIGFuZCBvbmUtbGluZXJzLg0KPiANCj4gT2J2aW91c2x5IGV2ZW4g
YSBvbmUtbGluZXIgY2FuIGVuZCB1cCByZXN1bHRpbmcgaW4gcmFuZG9tIG9kZGl0aWVzLA0KPiBi
dXQgY291bGQgeW91IHRyeSB0byBiaXNlY3QgdGhlIGlzc3VlIHlvdSBzZWUgdG8gcGluIGl0IGRv
d24/DQoNCkknbGwgdHJ5IHRvIHJlbWVtYmVyIGhvdyB0byBiaXNlY3QgdGhyb3VnaCB0aGUgbWVy
Z2UgOi0pDQoNCkkndmUgZG9uZSBzb21lIHRlc3RzLg0KSSdtIHNlZWluZyBhIHRocmVlLWZvbGQg
c2xvdyBkb3duIG9uOg0KJCBpPTA7IHdoaWxlIFsgJGkgLWx0IDEwMDAwMDAgXTsgZG8gaT0kKChp
ICsgMSkpOyBkb25lDQp3aGljaCBnb2VzIGZyb20gMSBzZWNvbmQgdG8gMy4NCg0KSSBjYW4gcnVu
IHRoYXQgd2l0aCBmdHJhY2UgbW9uaXRvcmluZyBzY2hlZHVsZXIgZXZlbnRzIChhbmQgYSBmZXcN
Cm90aGVyIHRoaW5ncykgYW5kIGNhbid0IHNwb3QgYW55d2hlcmUgdGhlIHByb2Nlc3MgaXNuJ3Qg
cnVubmluZw0KZm9yIGEgc2lnbmlmaWNhbnQgdGltZS4NCg0KSSd2ZSBqdXN0IGhhZCBhIHRob3Vn
aHQuDQpIYXZlIHRoZXJlIGJlZW4gYW55IGNoYW5nZXMgdG8gdGhlIGNvZGUgdGhhdCBjaGFuZ2Vz
IHRoZSBjcHUgc3BlZWQNCmFuZC9vciBzY2hlZHVsZXIgZGVjaXNpb25zIGZvciBtaWdyYXRpbmcg
cHJvY2Vzc2VzPw0KDQpJdCBtaWdodCBiZSB0aGF0IHRoZSBidXN5IHNpbmdsZSBwcm9jZXNzIGtl
ZXBzIG9uIGJlaW5nIG1pZ3JhdGVkDQp0byBhbiBpZGxlIGNwdSB0aGF0IGlzIHJ1bm5pbmcgYXQg
ODAwTUh6IHJhdGhlciB0aGFuIHN0YXlpbmcgb24NCmEgY3B1IGFuZCBnZXR0aW5nIGl0cyBzcGVl
ZCByYW1wZWQgdXAgdG8gMy41LTRHSHoNCg0KSSBjYW4gc3BlZWQgdGhlIHNoZWxsIGxvb3AgdXAg
dG8ganVzdCBvdmVyIDIgc2Vjb25kcyBieSBydW5uaW5nDQphIGZldyBjb3BpZXMgb2Y6DQokIHdo
aWxlIDo7IGRvIDo7IGRvbmUNClRoYXQgbWlnaHQgYmUgdGhlIGJlc3QgSSBjYW4gZ2V0IHNpbmNl
IEknbSB1c2luZyBhbiBpNy03NzAwICg0IGNvcmVzDQp3aXRoIGh5cGVydGhyZWFkaW5nIGdpdmlu
ZyA4IGNwdSkgYW5kIGh5cGVydGhyZWFkaW5nIHByb2JhYmx5IHNsb3dzDQp0aGluZ3MgZG93biBi
eSBhIGZhY3RvciBvZiB0d28uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


