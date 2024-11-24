Return-Path: <linux-kernel+bounces-419410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E1C9D6DB1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A055D28138D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFED185B76;
	Sun, 24 Nov 2024 10:28:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA136C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732444105; cv=none; b=ge3MRKthI1ANOFTPHPG2ZNDphm6xxmdPEUIGoPmyC6x4whxKczu3Mh7GPOL3m7fKO0+eZ2MaAH9O8pHRfaRlHwGM7vnk5lbiDuFMBoDjdLQCDUk1phvcduxmbJoAPyKASWJ3EmAipXqb8X3sZqIaSnRxKYMM7Uk5SMI6C5R+G0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732444105; c=relaxed/simple;
	bh=mIQ0vL1xuwidsUtCzvygmK1JTlA4QgFOpy9NW8WTXb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nnQo3ggPsA/4dMdWs5d4rf7sviKntKCWJg06tdkgprXoDNiBiCVDygWI/eosjyMev7crmKV9H9AMA9rZshrDLPGKE9uaba+QEaEhYpMRup914p05oDjoz1UXpU94xn8jAfELZm/TE8ygr0VlhrwdzmvnunAmYY64T9OzqU5qcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-190-K1YGnoheNaW0D407wCzztg-1; Sun, 24 Nov 2024 10:28:20 +0000
X-MC-Unique: K1YGnoheNaW0D407wCzztg-1
X-Mimecast-MFC-AGG-ID: K1YGnoheNaW0D407wCzztg
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Nov
 2024 10:28:17 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Nov 2024 10:28:17 +0000
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
Thread-Index: Ads91tEaZvh8m6sNQhyDMO+nmsu5/wAA3QOAAAboxyAAAu91AAAWZoxg
Date: Sun, 24 Nov 2024 10:28:17 +0000
Message-ID: <90e813acc14848b1aa0995578f80ffad@AcuMS.aculab.com>
References: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
 <CAHk-=wgT4E+6YO0-SvdD=Gh6wSuUB3Bq_qOiErfZkobQ9gn6=Q@mail.gmail.com>
 <e92823fee58d44b6a50a83fd27206857@AcuMS.aculab.com>
 <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
In-Reply-To: <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 60JGV1M1aN1-yOTIo3WDELfQEiLgNJfyyisc4vo6IKg_1732444099
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgTm92ZW1iZXIgMjAyNCAyMzo0NQ0KPiAN
Cj4gT24gU2F0LCAyMyBOb3YgMjAyNCBhdCAxNDozNiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGl0IGlz
IHZhbGlkIHRvIHBhc3MgYSBidWZmZXIgdGhhdCBlbmRzIHJpZ2h0DQo+ID4gYXQgdGhlIGVuZCBv
ZiB2YWxpZCB1c2VyIG1lbW9yeS4NCj4gDQo+IFRoZXJlJ3MgYSBkaWZmZXJlbmNlIGJldHdlZW4g
InZhbGlkIiBhbmQgIndlIGNhcmUiLg0KPiANCj4gVGhpcyBpcyB3YXkgcGFzdCB0aGF0IGNhc2Uu
IFRoZSBvbmx5IHBvc3NpYmxlIHJlYXNvbiBmb3IgdGhhdA0KPiB6ZXJvLWJ5dGUgdGhpbmcgYXQg
dGhlIGVuZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSBpcyBzb21lYm9keSBhY3RpdmVseQ0KPiBsb29r
aW5nIGZvciBzb21lIGVkZ2UgY2FzZSwgbm90IGEgcmVhbCB1c2UuDQoNCk1pa2VsIGdhdmUgdGhl
IGV4YWN0IHRlc3QgdGhhdCB3YXMgZmFpbGluZy4NCg0KSSBzaG91bGQgaGF2ZSBiZWVuIG1vcmUg
Y2xlYXIgdGhhdCB0aGUgaXNzdWUgaXMgZml4aW5nIHZhbGlkIHRyYW5zZmVycw0KdGhhdCBlbmQg
YXQgdGhlIGVuZCBvZiB2YWxpZCBtZW1vcnkgd2l0aG91dCBicmVha2luZyB6ZXJvIGxlbmd0aA0K
dHJhbnNmZXJzIGFueXdoZXJlIGVsc2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


