Return-Path: <linux-kernel+bounces-420280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B49D7828
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 21:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F52B21524
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782515573A;
	Sun, 24 Nov 2024 20:49:44 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BD2500BA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732481383; cv=none; b=MCOQkMUEBI3mail9wRzHsU5RsUj1bM/NQ255WJtPGMRcrrZ8JMrYQu529eOeLBuj2SbVNsQFf51PzdCt9qLoyGyBBw67T3MIq/toYr07yurRh/6RnfzvQ5fo0zZZRTDLxFoc5jZyFgf1PQcW4VPeEceSsOiSqSmEssSOFzTLVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732481383; c=relaxed/simple;
	bh=KQHlwrqz5FzBL+S3ezApildHs9fffOcu7tlhfN0CPKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LE0uVN5A5rRRfoWcm9UeC2pPCJFFwBoVsWNmHFTQa4XycPDuDhIAWCOVR4Y4rqbD3L1t0EzW57R+/OM0KlOMFZ8iwN1c105orxo6LpHJKxx+cNQoY+a+ZDaNJoKohHdQwsP9L1b5h2KazJXWVLYW2Aev/vmXZGl+UcXA2P65h5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-U9gd-n_7P-6_cRZY56VrNQ-1; Sun, 24 Nov 2024 20:49:32 +0000
X-MC-Unique: U9gd-n_7P-6_cRZY56VrNQ-1
X-Mimecast-MFC-AGG-ID: U9gd-n_7P-6_cRZY56VrNQ
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Nov
 2024 20:49:29 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Nov 2024 20:49:29 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann
	<arnd@kernel.org>, Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2] x86: Allow user accesses to the base of the guard page
Thread-Topic: [PATCH v2] x86: Allow user accesses to the base of the guard
 page
Thread-Index: Ads+hc9sKIgnrLHqRG2ra9Mk31sA5wAHDeIAAAF5AvA=
Date: Sun, 24 Nov 2024 20:49:29 +0000
Message-ID: <b90410d3f213496ebfdd2f561281791b@AcuMS.aculab.com>
References: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
 <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com>
In-Reply-To: <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: SlZLhVSZBtSa5TiQRjSrvb6any_YqfnQBOx5CrMFLxc_1732481371
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgTm92ZW1iZXIgMjAyNCAxODo1Mw0KDQo+
IE9uIFN1biwgMjQgTm92IDIwMjQgYXQgMDc6MzksIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gdjI6IFJld3JpdHRlbiBjb21taXQgbWVzc2Fn
ZS4NCj4gDQo+IEdyci4gTm93IEkgcmVtZW1iZXIgd2h5IEkgZGlkIGl0IHRoaXMgd2F5IC0gSSBz
dGFydGVkIGxvb2tpbmcgYXJvdW5kDQo+IGZvciB0aGUgYmlnZ2VyIGNvbnRleHQgYW5kIGhpc3Rv
cnkuDQo+IA0KPiBJIHdhbnRlZCB0aGF0ICJ2YWxpZF91c2VyX2FkZHJlc3MoKSIgdG8gcmVhbGx5
IGJlICJpcyB0aGlzIGEgdmFsaWQNCj4gdXNlciBhZGRyZXNzIiwgYmVjYXVzZSBpdCdzIGFsc28g
dXNlZCBieSB0aGUgZmF1bHQgaGFuZGxpbmcgY29kZSAoZm9yDQo+IHRoYXQgcmVhc29uKS4NCg0K
RG9lc24ndCB0aGF0IGp1c3QgbmVlZCBhIDw9IGNoYW5nZWQgdG8gPCA/DQooQW5kIHBvc3NpYmx5
IG9mIG5hbWUpDQoNCi4uLg0KPiBhbmQgdGhhdCB3b3VsZCBtYWtlIHRoaXMgYWxsIGdvIGF3YXks
IGFuZCB0aGF0IHdhcyB3aHkgSSB3YXMNCj4gKGluY29ycmVjdGx5KSBmaXhhdGluZyBvbiB0aGUg
emVyby1zaXplZCBhY2Nlc3MgYXQgdGhlIGVuZCBvZiB0aGUNCj4gYWRkcmVzcyBzcGFjZSwgYmVj
YXVzZSBJIHdhc24ndCBldmVuIHRoaW5raW5nIGFib3V0IHRoaXMgcGFydCBvZg0KPiBfX2FjY2Vz
c19vaygpLg0KDQphY2Nlc3Nfb2soTlVMTCwgMCkgaXMgcHJvYmFibHkgdGhlIGFubm95aW5nIGNh
c2UgdGhhdCBzdG9wcyBpdCB1c2luZw0KdmFsaWRfdXNlcl9hZGRyZXNzKHB0ciArIHNpemUgLSAx
KS4NCkFuZCB0aGUgJ2xlYScgdGhhdCB3aWxsIGRvICd4ICsgeSAtIDEnIHJ1bnMgb24gZmV3ZXIg
J3BvcnRzJyB0aGFuIGFkZC4NCg0KPiBJT1csIG15ICpwcmVmZXJyZWQqIGZpeCBmb3IgdGhpcyBh
bGwgd291bGQgYWN0dWFsbHkgbG9vayBsaWtlIHRoaXM6DQo+IA0KPiAgIC0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaA0KPiAgICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3VhY2Nlc3NfNjQuaA0KPiAgIEBAIC04NiwyNCArODYsMTIgQEAgc3RhdGljIGlubGluZSB2b2lk
IF9fdXNlciAqbWFza191c2VyX2FkZHJlc3MoY29uc3Qgdm9pZCBfX3VzZXIgKnB0cikNCj4gICAg
ICoNCj4gICAgICogTm90ZSB0aGF0IHdlIGFsd2F5cyBoYXZlIGF0IGxlYXN0IG9uZSBndWFyZCBw
YWdlIGJldHdlZW4gdGhlDQo+ICAgICAqIG1heCB1c2VyIGFkZHJlc3MgYW5kIHRoZSBub24tY2Fu
b25pY2FsIGdhcCwgYWxsb3dpbmcgdXMgdG8NCj4gICArICogaWdub3JlIHRoZSBzaXplIGVudGly
ZWx5LCBzaW5jZSBhbnkga2VybmVsIGFjY2Vzc2VzIHdpbGwgYmUgaW4NCj4gICArICogaW5jcmVh
c2luZyBhZGRyZXNzIG9yZGVyIHN0YXJ0aW5nIGF0ICdwdHInLg0KPiAgICAgKi8NCj4gICAgc3Rh
dGljIGlubGluZSBib29sIF9fYWNjZXNzX29rKGNvbnN0IHZvaWQgX191c2VyICpwdHIsIHVuc2ln
bmVkIGxvbmcgc2l6ZSkNCj4gICAgew0KPiAgICsgICAgIHJldHVybiB2YWxpZF91c2VyX2FkZHJl
c3MocHRyKTsNCj4gICAgfQ0KPiAgICAjZGVmaW5lIF9fYWNjZXNzX29rIF9fYWNjZXNzX29rDQo+
IA0KPiBidXQgSSBzdXNwZWN0IHRoYXQgSSdtIHRvbyBjaGlja2VuIHRvIGFjdHVhbGx5IGRvIHRo
YXQuDQo+IA0KPiBQbGVhc2Ugc29tZWJvZHkgY29udmluY2UgbWUuDQoNCkkgZGlkbid0IGtub3cg
eW91IHJlYWxseSBoYWQgYSAnY2hpY2tlbiBzdHJlYWsnIDotKQ0KDQpZb3UnZCBuZWVkIHRvIGRv
dWJsZS1jaGVjayB0aGF0IG5vdGhpbmcgaXMgcGFyc2luZyBUTEQgZGF0YQ0KKGxpa2UgQ01TRyBv
ciBuZXRsaW5rIGJ1ZmZlcnMpIGRpcmVjdGx5IGZyb20gdXNlcnNwYWNlIGhhdmluZw0KZG9uZSBh
biBvdXRlciBhY2Nlc3Nfb2soKSBhbmQgdGhlbiB1c2luZyBfX2dldF91c2VyKCkuDQpPVE9IIHRo
ZXJlIGFyZSBmZXcgZW5vdWdoIGNhbGxzIHRvIGFjY2Vzc19vaygpIHRoZXkgY2FuIGFsbA0KYmUg
Y2hlY2tlZC4NCg0KQW5vdGhlciBwbGFjZSBtaWdodCBiZSBhIGNvcHlfdG8vZnJvbV91c2VyKCkg
aW1wbGVtZW50YXRpb24NCnRoYXQgZG9lcyBhIGNvcHkgb2YgdGhlIGZpbmFsICd3b3JkJyBmaXJz
dCBhbmQgdGhlbiBjb3BpZXMNCmEgd2hvbGUgbnVtYmVyIG9mIHdvcmRzIGZyb20gdGhlIHN0YXJ0
IG9mIHRoZSBidWZmZXIuDQp4ODYgc2hvdWxkIGp1c3QgYmUgdXNpbmcgJ3JlcCBtb3ZzYicgKGV4
Y2VwdCBmb3Igc29tZSBjb25zdGFudCBzaXplcykNCmJlY2F1c2UgSSBkb3VidCBhbnl0aGluZyBl
bHNlIGlzIHdvcnRoIHRoZSBvdmVyaGVhZCBvZiB0aGUgKG1pc3ByZWRpY3RlZA0KaGFsZiB0aGUg
dGltZSkgYnJhbmNoLg0KDQpBcyBhbiBhc2lkZSB0aGU6DQo+ICAgICBtb3ZhYnMgJDB4MTIzNDU2
Nzg5YWJjZGVmLCVyY3ggICAgICAjIG1hZ2ljIHZpcnR1YWwgYWRkcmVzcyBzaXplDQo+ICAgICBj
bXAgICAgJXJzaSwlcmN4ICAgICAgICAgICAgICAgICAgICAjIGFkZHJlc3MgbWFza2luZw0KPiAg
ICAgc2JiICAgICVyY3gsJXJjeA0KPiAgICAgb3IgICAgICVyc2ksJXJjeA0Kc2VxdWVuY2UgY291
bGQgYmUNCj4gICAgIG1vdmFicyAkMHgxMjM0NTY3ODlhYmNkZWYsJXJjeCAgICAgICMgbWFnaWMg
dmlydHVhbCBhZGRyZXNzIHNpemUNCj4gICAgIGNtcCAgICAlcnNpLCVyY3ggICAgICAgICAgICAg
ICAgICAgICMgYWRkcmVzcyBtYXNraW5nDQo+ICAgICBjbW92YyAgJXJzaSwlcmN4DQpQcm92aWRl
ZCB0aGUgY29uc3RhbnQgaXMgVEFTS19TSVpFX01BWCAod2l0aG91dCB0aGUgLTEpLg0KDQpSZW1l
bWJlciBjbW92IGlzIGFuIGFyaXRobWV0aWMgaW5zdHJ1Y3Rpb24gbXVjaCBsaWtlIGFkYyBleGNl
cHQNCnRoYXQgaXQgY29udGFpbnMgYSBtdWx0aXBsZXhvci9zZWxlY3RvciBub3QgYW4gYWRkZXIu
DQpJbnRlcmVzdGluZ2x5IHRoZSBpbnRlbCBpbXBsZW1lbnRhdGlvbiBkcm9wcyB0byAxIGNsb2Nr
IGEgZmFtaWx5IGJlZm9yZQ0KYWRjL3NiYiAodGhlIGFyY2hpdGVjdHVyZSBkaWRuJ3Qgc3VwcG9y
dCAzIHJlZ2lzdGVyIGlucHV0cyB0byBvbmUgdS1vcCkuDQooYWN0dWFsbHkgUnl6ZW4gbWlnaHQg
aW1wbGVtZW50IGNtb3YgYXMgYSBjb25kaXRpb25hbCByZWdpc3RlciByZW5hbWUpDQoNCkluIGVp
dGhlciBjYXNlIGl0IHdvbid0IGJlIHN1YmplY3QgdG8gbWlzcHJlZGljdGlvbi4NCg0KVGhhdCBh
Y3R1YWxseSByZW1vdmVzIHRoZSByZXF1aXJlbWVudCB0byBhY2Nlc3MgdGhlIGJhc2UgYWRkcmVz
cyBmaXJzdC4NCkp1c3QgbmVlZCB0byBhdm9pZCBqdW1wcyBvZiBQQUdFX1NJWkUuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=


