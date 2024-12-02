Return-Path: <linux-kernel+bounces-427087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3AD9DFC41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0BB21741
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AD1F9F5C;
	Mon,  2 Dec 2024 08:44:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371B2940F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129064; cv=none; b=lac76k4LX94DWPvbAu3EOdJ9dPurR83UCK1Dhnw3rFFT2n7aAibUnagUkMbHQARw2/Yb7iCSnwRsYKaBeyCWF2jt/TetMAPXIqHxH0ytZeWbXQuWqOXDrq8bcpVZosdZ1g3hcl3db54PWF1LoQCt6yswL+r4fDIwdxb8CvJWY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129064; c=relaxed/simple;
	bh=5ykKuNUwwbKPtOwOkSK81tnLQry+HlOhPKQ6jRaZkv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Lz+QL3eVtOSqpPpIqrPguqE8oxMlNm0T7Gcrqj5wYKZeH9GKc27Hh3zMPe6Ti0JZspcS/lNOA3uHiL70w5U55BkuJV3xFhzkZchgnyOFgazuTy4oroYyuCi5oxyVfmsseQ6TnYyw14nIHWnLoVbIKkGOXbAbQOWcvMnkf7zsv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-4gPIbQP5MVu2_w65CfgrJA-1; Mon, 02 Dec 2024 08:44:20 +0000
X-MC-Unique: 4gPIbQP5MVu2_w65CfgrJA-1
X-Mimecast-MFC-AGG-ID: 4gPIbQP5MVu2_w65CfgrJA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 2 Dec
 2024 08:43:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 2 Dec 2024 08:43:50 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Andrew Cooper" <andrew.cooper3@citrix.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH next] x86: mask_user_address() return base of guard page
 for kernel addresses
Thread-Topic: [PATCH next] x86: mask_user_address() return base of guard page
 for kernel addresses
Thread-Index: AdtEHKHDLvCr/TWKQ76WywrKdPgaxgAD2wgAABm24BA=
Date: Mon, 2 Dec 2024 08:43:50 +0000
Message-ID: <728cccd6a6d942d0b9249e7991fdce13@AcuMS.aculab.com>
References: <e654a20c9045487eaacbd256f584ce45@AcuMS.aculab.com>
 <CAHk-=wiG7dGtE6UsynOP3FuvApkh=FYrv1Q42DEVZmosuOFXnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiG7dGtE6UsynOP3FuvApkh=FYrv1Q42DEVZmosuOFXnQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: OTFmxn6rPB3kbS2VO4irNynRPGPkBAQ48dzIjKQKR0o_1733129058
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDEgRGVjZW1iZXIgMjAyNCAyMDowMw0KPiAN
Cj4gT24gU3VuLCAxIERlYyAyMDI0IGF0IDEwOjEyLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdo
dEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEkndmUgYnVpbHQgYW5kIHJ1biBhIGtlcm5l
bCB3aXRoIGl0IC0gc28gbm90IGJyb2tlbiENCj4gDQo+IEkgd29ycnkgdGhhdCAnY21vdicgY291
bGQgYmUgcHJlZGljdGVkIC0gbWFraW5nIHRoZSB3aG9sZSBzZXF1ZW5jZQ0KPiBwb2ludGxlc3Mu
IEl0IHdvdWxkIGJlIGEgc3R1cGlkIHRoaW5nIGZvciBhIENQVSBjb3JlIHRvIGRvLCBidXQgaXQN
Cj4gd291bGQgYmUgc2ltcGxlLg0KPiANCj4gT2YgY291cnNlLCAnc2JiJyBjb3VsZCBiZSBkb25l
IHVzaW5nIHByZWRpY3RpbmcgdGhlIGNhcnJ5IGZsYWcgdG9vLg0KPiBUaGVyZSdzIGEgbG90IG9m
IHdheXMgdG8gc2NyZXcgdGhpcyB1cC4NCg0KQWJvdXQgdGhlIG9ubHkgcmVnaXN0ZXIgdGhhdCBp
dCB3b3VsZCBtYWtlIGFueSBzZW5zZSB0byAncHJlZGljdCcNCmlzIHRoZSBmbGFncyByZWdpc3Rl
ci4NClRoYXQgaXMgZ29pbmcgdG8gYWZmZWN0IGNtb3YgYW5kIHNiYiB0aGUgc2FtZS4NCg0KPiBJ
bnRlbCBhdCBzb21lIHBvaW50IGV4cGxpY2l0bHkgc2FpZA0KPiANCj4gICJPdGhlciBpbnN0cnVj
dGlvbnMgc3VjaCBhcyBDTU9WY2MsIEFORCwgQURDLCBTQkIgYW5kIFNFVGNjIGNhbiBhbHNvDQo+
IGJlIHVzZWQgdG8gcHJldmVudCBib3VuZHMNCj4gICBjaGVjayBieXBhc3MgYnkgY29uc3RyYWlu
aW5nIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbiBvbiBjdXJyZW50IGZhbWlseQ0KPiA2IHByb2Nlc3Nv
cnMgKEludGVswq4gQ29yZeKEoiwNCj4gICBJbnRlbMKuIEF0b23ihKIsIEludGVswq4gWGVvbsKu
IGFuZCBJbnRlbMKuIFhlb24gUGhp4oSiIHByb2Nlc3NvcnMpLg0KPiBIb3dldmVyLCB0aGVzZSBp
bnN0cnVjdGlvbnMgbWF5IG5vdA0KPiAgIGJlIGd1YXJhbnRlZWQgdG8gZG8gc28gb24gZnV0dXJl
IEludGVsIHByb2Nlc3NvcnMiDQo+IA0KPiBzbyBub25lIG9mIHRoZXNlIGFyZSBzYWZlIGFjY29y
ZGluZyB0byB0aGF0Lg0KPiANCj4gTWF5YmUgdGhlcmUgd2VyZSBuZXdlciB1cGRhdGVzIG9uIHRo
aXMsIGJ1dCBpbiB0aGUgbWVhbnRpbWUgSSdkIHJhdGhlcg0KPiBoYXZlIGp1c3QgKm9uZSogcGF0
dGVybiwgbm90IHN3aXRjaCBiZXR3ZWVuIG11bHRpcGxlIHBvc3NpYmx5DQo+IHByb2JsZW1hdGlj
IG9uZXMuIEFuZCBzYmIgaGFzIGJlZW4gdGhhdCB0cmFkaXRpb25hbCBvbmUuDQoNCkkgaGFkIHNv
bWUgbW9yZSB0aG91Z2h0cyB3aGlsZSBmYWlsaW5nIHRvIHNsZWVwIDotKQ0KDQpUaGUgY3VycmVu
dCBjb2RlIHJlbGllcyBvbiB0aGUgY21wLCBzYmIgYW5kIG9yL2FuZCBub3QgYmVpbmcgcHJlZGlj
dGVkLg0KVGhpcyBiYXNpY2FsbHkgcmVxdWlyZXMgdGhhdCBhbGwgYWx1IGluc3RydWN0aW9ucyBu
b3QgYmVpbmcgcHJlZGljdGVkLg0KSWYgdGhhdCBpc24ndCB0cnVlIHRoZW4gcHJldHR5IG11Y2gg
YW55IG1lbW9yeSBhY2Nlc3MgY291bGQgc3BlY3VsYXRpdmVseQ0KYWNjZXNzIGFsbW9zdCBhbnkg
bWVtb3J5IGFkZHJlc3MuDQoNClRoZSAnbWF5IG5vdCBiZSBndWFyYW50ZWVkJyBwYXJ0IG1pZ2h0
IGJlIGJlY2F1c2Ugc29tZW9uZSBoYXMgbW9vdGVkDQp0aGUgKHByb2JhYmx5IGJyYWluLWRlYWQp
IGlkZWEgb2Ygc3BlY3VsYXRpdmVseSBleGVjdXRpbmcgYWx1IGluc3RydWN0aW9ucw0KaW5zdGVh
ZCBvZiBpbXBsZW1lbnRpbmcgcGlwZWxpbmUgc3RhbGxzLg0KTW9zdCBhbHUgZm9yd2FyZGluZyAo
cmVzdWx0IHRvIG5leHQgaW5zdHJ1Y3Rpb24pIGFuZCBzdGFsbHMgY2FuIGJlDQpkZXRlcm1pbmVk
IGR1cmluZyB0aGUgZGVjb2RlIGNsb2NrcyAodGhleSBhZmZlY3QgdGhlIGluc3RydWN0aW9uDQpz
Y2hlZHVsaW5nIG9uIGN1cnJlbnQgeDg2IGNwdSkuDQpQZXJoYXBzIGl0IG1pZ2h0IGhlbHAgd2l0
aCB2YXJpYWJsZSBsZW5ndGggaW5zdHJ1Y3Rpb25zIChsaWtlIG1lbW9yeSByZWFkcykNCmJ1dCB0
aGV5IGFyZSB0aGUgdmVyeSBvbmVzIHdoZXJlIHlvdSBkb24ndCB3YW50IHRvIHVzZSB3cm9uZyB2
YWx1ZXMgZnJvbS4NCg0KTWluZCB5b3UgdGhlIGhhcmR3YXJlIGVuZ2luZWVycyBoYXZlIGRvbmUg
b3RoZXIgaG9ycmlkIHRoaW5ncyB0byBpbmNyZWFzZQ0KY3B1IGNsb2NrIHNwZWVkIHRvIGdldCBz
b21lIGJlbmNobWFya3MgcnVuIGZhc3RlciB3aXRob3V0IGNvbnNpZGVyaW5nIHRoZQ0KZnVsbCBl
ZmZlY3Qgb24gb3RoZXIgc29mdHdhcmUgLSB3aGljaCBpcyB3aHkgd2UgYXJlIGluIHRoaXMgbWVz
cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


