Return-Path: <linux-kernel+bounces-197880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8A8D704E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03F81C2237F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15121152181;
	Sat,  1 Jun 2024 13:52:02 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1E14267
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249921; cv=none; b=Ebs1yjxZdkHzzzN+oK5esq8OyYRGrPeMnHtgZLJdj5j9+tx4tpAivVfRBI0gwmM5iZ1YcIkqyikq/JPGYbvLBC+3OUBiRv9mUINO+h2nwtbaSZ9E3G36y7TmXS3pigEvaqsbtaGnQ+6Obb6UgaoSBIBO5eviLHqpDQqAzSCqdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249921; c=relaxed/simple;
	bh=1swqdd3h6pFCFF9FkaDga64RadxTF94ynOEkAnJ0yeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=paTJMZ6rpdOThcvmPn46hnapAdu4HXJ8wPO9oo+6kKSazRyHmSdRIwi3LgXX1wNPMnWYuXLEGWhZnRM42qKt8SFqpx7ZKDwItWu5nwl6CziYTL7wDtTPnNEitAPAdSO5nJQ7+8gEhqXb+oj7h3Jbe5NhpBLa5vkaQPu7NXiLgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-UpaXNTL1Oe6ZI-Mr5uhv1Q-1; Sat, 01 Jun 2024 14:51:48 +0100
X-MC-Unique: UpaXNTL1Oe6ZI-Mr5uhv1Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 1 Jun
 2024 14:51:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 1 Jun 2024 14:51:15 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Arnd Bergmann
	<arnd@arndb.de>
CC: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Paul E. McKenney"
	<paulmck@kernel.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@kernel.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Marc Zyngier <maz@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Cree
	<mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Subject: RE: [PATCH 00/14] alpha: cleanups for 6.10
Thread-Topic: [PATCH 00/14] alpha: cleanups for 6.10
Thread-Index: AQHas3geHvAQAz06HUaUVIZjte+qOLGy6zYA
Date: Sat, 1 Jun 2024 13:51:15 +0000
Message-ID: <7b84fcf6b64a4553a377c98fdcd48837@AcuMS.aculab.com>
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
 <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
 <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
In-Reply-To: <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
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

Li4uDQo+IFRoZSBmYWN0IGlzLCB0aGUgb3JpZ2luYWwgYWxwaGEgaXMgdGhlIHdvcnN0IGFyY2hp
dGVjdHVyZSBldmVyIG1hZGUuDQo+IFRoZSBsYWNrIG9mIGJ5dGUgaW5zdHJ1Y3Rpb25zIGFuZCB0
aGUgYWJzb2x1dGVseSBob3JyZW5kb3VzIG1lbW9yeQ0KPiBvcmRlcmluZyBhcmUgZmF0YWwgZmxh
d3MuIEFuZCB3aGlsZSB0aGUgbWVtb3J5IG9yZGVyaW5nIGFyZ3VhYmx5IGhhZA0KPiBleGN1c2Vz
IGZvciBpdCAoInRoZXkgZGlkbid0IGtub3cgYmV0dGVyIiksIHRoZSBsYWNrIG9mIGJ5dGUgb3Bz
IHdhcw0KPiB3aWxmdWwgbWlzZGVzaWduIHRoYXQgdGhlIGRlc2lnbmVycyB3ZXJlIHByb3VkIG9m
LCBhbmQgbWFkZSBhIGNlbnRyYWwNCj4gdGVuZXQgb2YgdGhlaXIgbWVzcy4NCg0KSWYgaXQgd2Fz
bid0IGZyb20gREVDICh3aGVyZSB0aGUgcGRwLTExIGFuZCB2YXggd2VyZSBmaW5lKSBJJ2QgdGhp
bmsNCml0IHdhcyBzb21lb25lIGhhcmtpbmcgYmFjayB0byB0aGUgb2xkIG1haW5mcmFtZSBkYXlz
IHdoZXJlIGlzIHdhcw0KcGVyZmVjdGx5IG5vcm1hbCB0byBvbmx5IGhhdmUgJ3dvcmQgYWRkcmVz
c2luZycgYW5kLCBmb3IgZXhhbXBsZSwNCnRvIHB1dCB0aHJlZSA2LWJpdCBjaGFyYWN0ZXJzIGlu
dG8gYW4gMTgtYml0IHdvcmQgKGhpIFVuaXZhYyEpLg0KKERvbid0IGV2ZW4gdGhpbmsgaG93IDE4
LWJpdCB3b3JkcyBnb3Qgd3JpdHRlbiB0byBtYWcgdGFwZSEpDQoNCkl0IGlzIGFsbW9zdCBhcyBp
cyBzb21lb25lIGFzc3VtZWQgdGhhdCB0aGUgb25seSB1c2UgZm9yIGJ5dGUgYWNjZXNzZXMNCndh
cyB3aXRoaW4gY2hhcmFjdGVyIGFycmF5cyAtIGFuZCB0aGV5IGNhbiBqb2xseSB3ZWxsIGFsaWdu
IHRoZSBhcnJheXMuDQoNCk1pbmQgeW91LCBhbGwgdGhlIGJ5dGUgc2hpZnRpbmcgbmVlZGVkIHRv
IGdldCB0aGUgZGF0YSBvbnRvIHRoZQ0KcmlnaHQgZGF0YSBidXMgbGluZXMgaXMgYSBQSVRBIGFu
ZCB3aWxsIGFmZmVjdCB0aGUgbWF4IGNwdSBmcmVxdWVuY3kgWzFdLg0KU28gcGVyaGFwcyB0aGV5
IGRlY2lkZWQgaXQgd2FzIGEgJ3NvZnR3YXJlIHByb2JsZW0nIHNvIHNvbWUgYmVuY2htYXJrcw0K
Y291bGQgcnVuIGZhc3Rlci4NCg0KCURhdmlkDQoNClsxXSBJJ3ZlIGJlZW4gYnVzeSByZS1pbXBs
ZW1lbnRpbmcgdGhlIE5pb3MtSUkgY3B1Lg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


