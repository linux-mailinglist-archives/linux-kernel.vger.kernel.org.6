Return-Path: <linux-kernel+bounces-426748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E89DF745
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AD6B2121D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8951D95A2;
	Sun,  1 Dec 2024 22:24:52 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBB134A8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733091892; cv=none; b=EwcXHNGGoG53nSDoK+D+LTiM089FtrQpKgXX3O1ZkXE4qgbf2XMZ+FyXBTb6qY/O/9IXQb7kFW4+foYKTqwhcqbu3mEKVZTwwySgomBStnXKfAvveGv6D8x8AoAsQkDIyn+X7EvzciI6rw2YKOvOpzZtaHFfCaltGD0eC5+hblA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733091892; c=relaxed/simple;
	bh=sE0JEij9txwEkjI07Nqgm8d+IF505qhXkkjA0V9EoeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=unT6HJMNxCfbxjvvM6g2RG577vyjpo6+mJ0SBRIP/MsZ6ogwXzHnbQaCDjgQPwdTOv/sIZWmlcdvausMZPX6eXjjnsghOC8epXi13N0pIGixcp6/0QdPHi/mXsZQtux7u3S6jUpOUxUlgCkDJnYcets96Xg+RMzw2YC1ecBj6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-347-fegmrYrnPLWdOsbPdJ2qHg-1; Sun, 01 Dec 2024 22:24:39 +0000
X-MC-Unique: fegmrYrnPLWdOsbPdJ2qHg-1
X-Mimecast-MFC-AGG-ID: fegmrYrnPLWdOsbPdJ2qHg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 1 Dec
 2024 22:24:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 1 Dec 2024 22:24:12 +0000
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
Thread-Index: AdtEHKHDLvCr/TWKQ76WywrKdPgaxgAD2wgAAAKsUnA=
Date: Sun, 1 Dec 2024 22:24:12 +0000
Message-ID: <b853710c4cb94ec0bf869edb41a685b6@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: Sd2B_I0JPdOZyuvaR_QxoBQYE-OiwrIAYzduuwn96kQ_1733091878
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
Cj4gd291bGQgYmUgc2ltcGxlLg0KDQpOb3QgcmVhbGx5LCAncHJlZGljdGlvbicgaXMgYWxsIGFi
b3V0IHRoZSB3aGVyZSB0aGUgJ2Zyb250IGVuZCcgcmVhZHMNCmluc3RydWN0aW9ucyBmcm9tIC0g
YW5kIHRyeWluZyB0byBhdm9pZCBpdCBkZXBlbmRpbmcgb24gb3RoZXIgY3B1IHN0YXRlLg0KV2hp
Y2ggaXMgd2h5IHNvbWUgY3B1IGRvbid0IGV2ZW4gY2hlY2sgdGhlIGluc3RydWN0aW9uIGlzIGV2
ZW4gYSBicmFuY2guDQoNCldoZXJlYXMgJ2Ntb3YnIGlzIHByZXR0eSBtdWNoIGFuIEFMVSBpbnN0
cnVjdGlvbiB3aXRoIHRoZSBvdXRwdXQNCmRlcGVuZGluZyBvbiB0aGUgc3RhdGUgb2YgcmVnaXN0
ZXJzLg0KDQpBZ25lcidzIHRhYmxlcyBwcmV0dHkgbXVjaCBzaG93IHRoYXQgSW50ZWwgaW1wbGVt
ZW50ZWQgYXMNCgl4ID0gY29uZCA/IHkgOiB4DQpzbyBpdCBzdWZmZXJzIGZyb20gYmVpbmcgYSAy
IHUtb3AgaW5zdHJ1Y3Rpb24gKHRoZSBzYW1lIGFzIHNiYikNCm9uIG9sZGVyIGNvcmUtMiBjcHUu
DQpPVE9IIEFNRCBoYXZlIGlzIGFzICc0IHBlciBjbG9jaycgKHRoZSBzYW1lIGFzIG1vdikgc28g
Y291bGQgYmUNCmEgJ21vdicgd2l0aCB0aGUgd3JpdGUgZGlzYWJsZWQnIChidXQgSSdtIG5vdCBz
dXJlIGhvdyB0aGF0DQp3b3VsZCB3b3JrIGlmICdtb3YnIGlzIGEgcmVnaXN0ZXIgcmVuYW1lKS4N
Cg0KPiBPZiBjb3Vyc2UsICdzYmInIGNvdWxkIGJlIGRvbmUgdXNpbmcgcHJlZGljdGluZyB0aGUg
Y2FycnkgZmxhZyB0b28uDQo+IFRoZXJlJ3MgYSBsb3Qgb2Ygd2F5cyB0byBzY3JldyB0aGlzIHVw
Lg0KPiANCj4gSW50ZWwgYXQgc29tZSBwb2ludCBleHBsaWNpdGx5IHNhaWQNCj4gDQo+ICAiT3Ro
ZXIgaW5zdHJ1Y3Rpb25zIHN1Y2ggYXMgQ01PVmNjLCBBTkQsIEFEQywgU0JCIGFuZCBTRVRjYyBj
YW4gYWxzbw0KDQpQcmVzdW1hYmx5IHRoYXQgaXMgJ2FzIHdlbGwgYW4gbGZlbmNlJyA/DQpOb3Qg
c3VyZSBob3cgbXVjaCB1c2Ugc2V0Y2MgY291bGQgYmUgLSBpdCBvbmx5IGNoYW5nZXMgJWFsLg0K
DQo+IGJlIHVzZWQgdG8gcHJldmVudCBib3VuZHMNCj4gICBjaGVjayBieXBhc3MgYnkgY29uc3Ry
YWluaW5nIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbiBvbiBjdXJyZW50IGZhbWlseQ0KPiA2IHByb2Nl
c3NvcnMgKEludGVswq4gQ29yZeKEoiwNCj4gICBJbnRlbMKuIEF0b23ihKIsIEludGVswq4gWGVv
bsKuIGFuZCBJbnRlbMKuIFhlb24gUGhp4oSiIHByb2Nlc3NvcnMpLg0KPiBIb3dldmVyLCB0aGVz
ZSBpbnN0cnVjdGlvbnMgbWF5IG5vdA0KPiAgIGJlIGd1YXJhbnRlZWQgdG8gZG8gc28gb24gZnV0
dXJlIEludGVsIHByb2Nlc3NvcnMiDQo+IA0KPiBzbyBub25lIG9mIHRoZXNlIGFyZSBzYWZlIGFj
Y29yZGluZyB0byB0aGF0Lg0KDQpXZWxsLCB0aGV5IGFyZSBhbGwgY3VycmVudGx5IHNhZmUsIGJ1
dCB0aGUgZnV0dXJlIGlzIHVuZGVjaWRlZC4NClNvdW5kcyBsaWtlIGp1c3QgYmUgbm9uLWNvbW1p
dHRhbC4uLg0KDQo+IE1heWJlIHRoZXJlIHdlcmUgbmV3ZXIgdXBkYXRlcyBvbiB0aGlzLCBidXQg
aW4gdGhlIG1lYW50aW1lIEknZCByYXRoZXINCj4gaGF2ZSBqdXN0ICpvbmUqIHBhdHRlcm4sIG5v
dCBzd2l0Y2ggYmV0d2VlbiBtdWx0aXBsZSBwb3NzaWJseQ0KPiBwcm9ibGVtYXRpYyBvbmVzLiBB
bmQgc2JiIGhhcyBiZWVuIHRoYXQgdHJhZGl0aW9uYWwgb25lLg0KDQpXZWxsLCBhcnJheV9pbmRl
eF9ub3NwZWMoKSBjb3VsZCBqdXN0IGJlIGEgY21wICsgY21vdi4NCklmIHlvdSBwYXNzICdzaXpl
IC0gMScgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdGhlICdvdXQgb2YgcmFuZ2UnIHZhbHVlLg0KT3Ro
ZXJ3aXNlIHlvdSdkIG5lZWQgdG8gcGFzcyBpbiBhIHplcm8gKHRoYXQgdGhlIGNvbXBpbGVyIGNh
biBnZW5lcmF0ZSBlYXJsaWVyKS4NClRoYXQgd291bGQgc2F2ZSBhbiBpbnN0cnVjdGlvbiAoYW5k
IHJlZ2lzdGVyIGRlcGVuZGVuY3kpIGluIHRoZSAnaW5kZXggaW4gcmFuZ2UnIHBhdGguDQoNClRo
ZSBvbmx5IG90aGVyIHVzZSBJIHNwb3R0ZWQgaXMgaW4gZmlsZXNfbG9va3VwX2ZkX3JhdygpIHdo
aWNoIGFsc28gdXNlcyB0aGUNCjAvfjEgZnJvbSBhcnJheV9pbmRleF9tYXNrX25vc3BlYygpIHRv
IGFsc28gbWFzayB0aGUgdmFsdWUgcmVhZCBmcm9tIHh4eFswXS4NCg0KPiBBbHNvLCBpZiBzYmIg
aXMgZXZlciBtYWRlIHNwZWN1bGF0aXZlLCBJIHRoaW5rIGl0J3MgdGltZSB0byBqdXN0IGp1bXAg
c2hpcC4NCg0KV2VsbCBBTkQgYW5kIChwcmVzdW1hYmx5KSBPUiBhcmUgYWxzbyBpbiB0aGUgbGlz
dC4NCllvdSBhcmUgcmVseWluZyBvbiB0aG9zZSBhcyB3ZWxsIGFzIHRoZSBzYmIuDQoNCklmIHlv
dSBnZXQgaXNzdWVzIGluIGEgbWlwcy1saWtlIGNwdSBpdCBhbGwgZ2V0cyBoYXJkZXIuDQpXaXRo
b3V0IGEgJ2NhcnJ5IGZsYWcnIHlvdSBjYW4gdXNlciAnc2JiJy4NCkl0IGFsc28gbWFrZXMgYW55
IGtpbmQgb2YgY21vdiBoYXJkIHRvIGltcGxlbWVudC4NCkkgZ3Vlc3MgY21vdi1vZGQgYW5kIGNt
b3YtZXZlbiBjb3VsZCBiZSBpbXBsZW1lbnRlZCBieSBkaXNhYmxpbmcNCnRoZSByZWdpc3Rlci1m
aWxlIHdyaXRlIChhbmQgdXNlZCBhZnRlciBhIGNtcCAtIHRoYXQgc2V0cyAwLzEpLg0KV2hldGhl
ciB0aGUgYXJjaGl0ZWN0dXJlIGRlZmluZXMvaW1wbGVtZW50cyB0aGVtIGlzIGFub3RoZXIgbWF0
dGVyLg0KVGhleSBhcmVuJ3QgaW4gdGhlIG9uZSBJIGltcGxlbWVudGVkIGVhcmxpZXIgaW4gdGhl
IHllYXIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


