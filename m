Return-Path: <linux-kernel+bounces-207384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C429901659
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CF1C20B78
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F847796;
	Sun,  9 Jun 2024 14:25:34 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A146B83
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943134; cv=none; b=nuQYPUOemKo2rqSpQWgwLzhOMZEtA48X85bpZPKqhKjW1Ea2pF3nofgOmbBdNoAZzukF377QmfI8GXRILMUJJImXl/+Lij/wQLmejmqE6dCfHGn7y0ILIBr9TCcJlfg1oGnEgb5YCzqYNASKJ/2g6yVkR1CX3wq9ym3iIVezGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943134; c=relaxed/simple;
	bh=VN7rGMngNajvYB6hirebK2nlzqZbuNQv8mi55iDXqnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Qyyni9E2dWmCc+l0tHivtCvraHku5/bfQQUu8zX/TCAXD6PjpTPVTiJSJ5/QTpIJ2Fu9gfRXEAFEQw9RijZN/J+N36J3oIht9AXc0KvS5A9qnQ48rpuqbWitD2dlVE5K2G5mxqrm2pKOfbyj9MpEbOs4B7/3S9pYM3GQ1G1n+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-It6GkIZFPYWw5GHkaa9spQ-1; Sun, 09 Jun 2024 15:25:29 +0100
X-MC-Unique: It6GkIZFPYWw5GHkaa9spQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 9 Jun
 2024 15:24:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 9 Jun 2024 15:24:51 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 'Woody Suwalski'
	<terraluna977@gmail.com>, 'Johan Hovold' <johan@kernel.org>
Subject: RE: Linux 6.10-rc2 - massive performance regression
Thread-Topic: Linux 6.10-rc2 - massive performance regression
Thread-Index: Adq5okQ7HduYf8qJTJSPwCpAtFdr/wAEqzOAAAzamAD///0jgP/+5CQg
Date: Sun, 9 Jun 2024 14:24:50 +0000
Message-ID: <3ca62f285df748b5b5d5cd891ace2db4@AcuMS.aculab.com>
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
 <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
 <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
 <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
In-Reply-To: <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggSnVuZSAyMDI0IDIzOjAxDQo+IA0KPiBP
biBTYXQsIDggSnVuIDIwMjQgYXQgMTQ6MzYsIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSSdsbCB0cnkgdG8gcmVtZW1iZXIgaG93IHRvIGJp
c2VjdCB0aHJvdWdoIHRoZSBtZXJnZSA6LSkNCj4gDQo+IGdpdCBiaXNlY3Qgc2hvdWxkIGp1c3Qg
ZG8gYWxsIHRoZSB3b3JrIGZvciB5b3UuIEFsbCB5b3UgbmVlZCB0byBkbyBpcw0KPiBnaXZlIGEg
a25vdyBnb29kIGFuZCBiYWQgcG9pbnQsIGFuZCBrZWVwIHRlc3Rpbmcgd2hhdCBnaXQgYmlzZWN0
IGFza3MNCj4geW91IHRvIGRvLg0KDQpUaGF0IHdvdWxkIGFsbCBiZSBlYXNpZXIgaWYgdGhlIGtl
cm5lbCB2ZXJzaW9uIGRpZG4ndCBrZWVwIGNoYW5naW5nDQphbmQvb3IgYWZ0ZXIgJ21ha2UgaW5z
dGFsbCcgZ3J1YiBkZWZhdWx0ZWQgdG8gYm9vdGluZyB0aGUgbGFzdA0KYnVpbHQga2VybmVsLg0K
SSBtYXkgYWxyZWFkeSBoYXZlICdmaXhlZCcgdGhpcyBzeXN0ZW0gc28gaXQgZG9lc24ndCBkZWZh
dWx0DQp0byBib290aW5nIHRoZSAnbGFzdCBib290ZWQnIGtlcm5lbCAtIGEgcmVhbCBQSVRBIHdo
ZW4geW91IGFyZQ0KdHJ5aW5nIHRvIGZpeCBub24tYm9vdGluZyBrZXJuZWxzLg0KDQpBbnl3YXkg
SSBjb21wbGV0ZWx5IGZhaWxlZCB0byBtYW5hZ2UgdG8gYnVpbGQgYSAnZ29vZCcga2VybmVsLg0K
RXZlbiA2LjktcmM1IGZhaWxlZCBhbmQgYmlzZWN0aW5nIGJldHdlZW4gNi45LXJjNCBhbmQgNi45
LnJjNQ0KZW5kZWQgdXAgYnVpbGRpbmcgYSA2LjktcmMzKyBrZXJuZWwgYW5kICdnaXQgZGlmZiB2
Ni45LXJjNCcNCndhcyBnaXZpbmcgbWFzc2l2ZSBjaGFuZ2VkIGV2ZW4gdGhvdWdoICdnaXQgYmlz
ZWN0IHZpZXcnIG9ubHkNCmdhdmUgYSBmZXcgY2hhbmdlcyB0aGF0IGNvdWxkbid0IGJlIHJlbGV2
YW50Lg0KDQpJIGZpbmFsbHkgcmVhbGlzZWQgd2hhdCB0aGUgZGlmZmVyZW50IGJldHdlZW4gJ2dv
b2QnIGFuZCAnYmFkJw0Ka2VybmVscyB3YXMuDQpBbGwgZG93biB0byBDT05GSUdfU1BFQ1VMQVRJ
T05fTUlUSUdBVElPTlMgYmVpbmcgcmVuYW1lZA0KQ09ORklHX0NQVV9NSVRJR0FUSU9OUyBhbmQg
Z2V0dGluZyBlbmFibGVkICdieSBtaXN0YWtlJy4NCg0KSWYgSSBidWlsZCBhIDYuMTAtcmMyIGtl
cm5lbCB3aXRob3V0IHRoZSBtaXRpZ2F0aW9ucyBJIGdldA0KdGhlICdmYXN0JyBiZWhhdmlvdXIu
DQpTbyB0aGVyZSBtdXN0IGFjdHVhbGx5IGJlIHNvbWV0aGluZyBxdWl0ZSBzdWJ0bGUgaW4gdGhl
DQp0aW1pbmdzLg0KDQpTbyB0aGVyZSBpcyBzdGlsbCBhIHByb2JsZW0gdGhhdCBpZiBhIGNwdS1p
bnRlbnNpdmUgcHJvY2Vzcw0KZ2V0IG1vdmVkIHRvIGEgZGlmZmVyZW50IGNwdSBvbiBhICdtb3N0
bHkgaWRsZScgc3lzdGVtIHRoZW4gdGhlDQpuZXcgY3B1IGlzIGxpa2VseSB0byBiZSBydW5uaW5n
IGF0IGEgbG93IGZyZXF1ZW5jeSBhbmQgd2lsbA0KdGFrZSBhIHdoaWxlIHRvIHNwZWVkIHVwLg0K
TW92ZSBpdCBvZnRlbiBlbm91Z2ggYW5kIGl0IHdpbGwgcnVuIHZlcnkgc2xvd2x5Lg0KSSBzdXNw
ZWN0IHRoYXQgc29tZXRoaW5nIGxpa2UgKHVudGVzdGVkKToNCg0KY3B1PTA7IHdoaWxlIFsgJGNw
dSAtbHQgJG51bV9jcHUgXTsgZG8NCgl0YXNrc2V0IC0tY3B1LWxpc3QgJGNwdSBzaCAtYyAnd2hp
bGUgc2xlZXAgMC4wMTsgZG8gOjsgZG9uZScgJg0KCWNwdT0kKChjcHUgKyAxKSkNCmRvbmUNCg0K
d2lsbCBjYXVzZSBhIGNwdS1ib3VuZCBwcm9jZXNzIHRvIHJ1biB2ZXJ5IHNsb3dseS4NCg0KSSB0
aGluayB0aGF0IG91Z2h0IHRvIGJlIGNvbnNpZGVyZWQgYSBidWcuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=


