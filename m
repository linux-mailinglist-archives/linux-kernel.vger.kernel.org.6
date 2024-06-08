Return-Path: <linux-kernel+bounces-207079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D1901224
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FB9B21807
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AB6F30A;
	Sat,  8 Jun 2024 14:44:59 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2A43165
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857898; cv=none; b=gQEpH2J/wFLycVlMaj0YCyAMtvi2lTvo60K0+LDIUzPJD2+F2e4GSUCa2jPm+64EnIvEy9OMciUWP4Vb4cHMw+8H5k4fW179NLah4mEZOu16kLof3JGUzm2Sso7Tlif2/Rl/2ogOzsxDjNxejzVclWQBCzNZQxVo/feC/8UY0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857898; c=relaxed/simple;
	bh=EWFxeGz3QBpGRSF0yU4snAyBekIaLtVl5vUMM8CS0pw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sBdAwGtZHb5LMiYaE2pB6+IOtUEtiIIIRhlh4XACJxze1MEscPWb7vI+RHgcLWJa70SjDukxrbU7QQxLb9i0ltOK2Ru/toq8hF1HOaVhH/egf2lZJ9Zs+wTeu6Czh1W0s3evZiZqpW61WzidKNKBd7CWRWsSxw51pTTEA1Ytc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-30-CxcMm8xbN2ad6xyJE1-WAQ-1; Sat, 08 Jun 2024 15:44:46 +0100
X-MC-Unique: CxcMm8xbN2ad6xyJE1-WAQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 8 Jun
 2024 15:44:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 8 Jun 2024 15:44:12 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, "Linux Kernel Mailing
 List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 6.10-rc2 - massive performance regression
Thread-Topic: Linux 6.10-rc2 - massive performance regression
Thread-Index: Adq5okQ7HduYf8qJTJSPwCpAtFdr/w==
Date: Sat, 8 Jun 2024 14:44:12 +0000
Message-ID: <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
In-Reply-To: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
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

SSdtIHNlZWluZyBhIG1hc3NpdmUgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBpbiA2LjEwLXJjMiBj
b21wYXJlZCB0byA2LjktcmM0Lg0KSSBzdXNwZWN0IHRoZSBjaGFuZ2UgaXMgaW4gNi4xMC1yYzEN
Cg0KU29tZSBjb2RlIHRoYXQgaXMgKG91Z2h0IHRvIGJlKSBtb3N0bHkgdXNlcnNwYWNlIGlzIHRh
a2luZyBhYm91dCAyLjUgdGltZXMNCmxvbmdlciB0byBydW4gKDMwIG1pbnV0ZXMgaW5zdGVhZCBv
ZiAxMikuDQoNClRoZSBwcm9ncmFtIHdpbGwgYmUgcHJldHR5IG11Y2ggcnVubmluZyBpbiB1c2Vy
c3BhY2UgKGZwZ2EgdmhkbCBjb21waWxlcikuDQoNCkkgc3VzcGVjdCBpdCBpcyBkdWUgdG8gdGhl
IGNoYW5nZXMgdG8gdGhlIHdheSB0aGUgc2NoZWR1bGVyIHByZS1lbXB0cw0KcHJvY2Vzc2VzLg0K
DQpXaGF0IG1ha2UgYWxsIHRoZSBkaWZmZXJlbmNlIGlzIGFuIGlkbGUgZGFlbW9uIHRoYXQgaXMg
cHJldHR5IG11Y2gNCmRvaW5nOg0KVGhyZWFkIDE6DQoJZm9yICg7Oykgew0KCQlwb2xsKDAsIDAs
IDEwKTsNCgkJcHRocmVhZF9jb25kX2Jyb2FkY2FzdChjdik7IC8vIFsxXQ0KCX0NClRocmVhZHMg
MisgKHRvdGFsIG9uZSBmb3IgZWFjaCBjcHUpOg0KCWZvciAoOzspIHsNCgkJcHRocmVhZF9jb25k
X3dhaXQoY3YsIG10eCk7DQoJfQ0KaWUgYWxsIHRoZSB0aHJlYWRzIHdha2UgdXAgZXZlcnkgMTBt
cywgZmluZCB0aGVyZSBpcyBub3RoaW5nDQp0byBkbyBhbmQgZ28gYmFjayB0byBzbGVlcC4NCihU
aGV5IHdvdWxkIGJlIHByb2Nlc3NpbmcgVERNIG9yIFJUUCBhdWRpby4pDQoNCk15IHN1c3BpY2lv
biBpcyB0aGF0IHRocmVhZHMgMisgYXJlIGxvb3BpbmcgaW4gdGhlIGZ1dGV4KCkgY2FsbA0KdW50
aWwgYSBzY2hlZHVsZXIgdGltZXIgdGljayBpbnN0ZWFkIG9mIGFjdHVhbGx5IHNsZWVwaW5nIGFu
ZA0KbGV0dGluZyBhbnl0aGluZyBlbHNlIHJ1bi4NCg0KRm9yIHRoaXMgY29uZmlndXJhdGlvbiBh
bGwgdGhlIGRhZW1vbiB0aHJlYWRzIGFyZSBydW5uaW5nIHVuZGVyIHRoZQ0KZGVmYXVsdCBzY2hl
ZHVsZXIsIGJ1dCBpdCB1c3VhbGx5IGJldHRlciB0byBydW4gdGhlbSBhdCBhIGxvdyBSVCBwcmlv
cml0eS4NCg0KSSBjYW4ndCByZW1lbWJlciB3aGV0aGVyIHRoZXJlIGlzIGEgc3lzY3RsIHRvIGNo
YW5nZSB0aGUgc2NoZWR1bGVyIGJlaGF2aW91ciwNCmJ1dCB0aGUgY3VycmVudCBkZWZhdWx0IGlz
IGJhZGx5IGJyb2tlbiBmb3Igc29tZSB3b3JrbG9hZHMuDQoNCglEYXZpZA0KDQpbMV0gSXQgaXNu
J3QgdGhhdCBzaW1wbGUsIHRoZSBicm9hZGNhc3Qgb25seSB3YWtlcyBvbmUgdGhyZWFkIHdoaWNo
IHRoZW4NCndha2VzIHRoZSBuZXh0IChldGMpLiBOb3Qgb25seSBkbyB0aGUgZGVsYXkgZ2V0dGlu
ZyB0aGUgY3B1IG91dCBvZiBzbGVlcA0Kc3RhdGVzIGFjY3VtdWxhdGUsIGJ1dCBpZiBhbnkgdGhy
ZWFkIGNhbid0IHJ1biAoZWcgaWYgdGhleSBhcmUgUlQgYW5kIHRoZQ0KY3B1IGlzIGJ1c3kpIG5v
bmUgb2YgdGhlIGxhdGVyIG9uZXMgd2FrZSB1cC4NClNvLCBpbiBmYWN0LCB0aGVyZSBpcyBhIHNl
cGFyYXRlIGN2IGZvciBlYWNoIHRocmVhZCBhbmQgdGhlIHdva2VuIHRocmVhZHMNCmFsc28gaXNz
dWUgd2FrZXVwcy4NCkJ1dCB0aGF0IGlzIGFsbCBhIGRpZmZlcmVudCBwcm9ibGVtLi4uKQ0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=


