Return-Path: <linux-kernel+bounces-403019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59B9C2FA0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A727C1F216F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79455154445;
	Sat,  9 Nov 2024 21:27:20 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765F38DF9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731187640; cv=none; b=ZXX2O9IV6bawBXJ8InmNQmvQh9bfJhreOv106nGGfLHul/M4Tp1D5+rtXGA6VHBnyldHHYODQnu9iQgB+T2gEiee8OAlLJ56zycH9u43VsPEkeKt5k4vWQXNZck/1teM8ABeUZY7JFJ9uFCeIR97FyfhouFXHrR4H+d/v029Ka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731187640; c=relaxed/simple;
	bh=sb9WdPrkipJCC6bIB9p5Ct0hlHweXkD7LkwxqCfQt2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ha+uQhTPDilpY4X9Y9Vjmlzj3+eKXFBcCalMztJKa/uj5b3koOm4pO1lh+Aat7CvZbzGkuegMLhWbdBiRmM/4A84CJatJ1Oul/NIdRlTZW4gsXl2LLLkeXDHonpEXBWDBIE8KXlmwyIfPyd+A0bR39jaGafl24M7WJxAJ5C+Ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-O_KLVAw2NHWNGw_I7e2Lwg-1; Sat, 09 Nov 2024 21:27:07 +0000
X-MC-Unique: O_KLVAw2NHWNGw_I7e2Lwg-1
X-Mimecast-MFC-AGG-ID: O_KLVAw2NHWNGw_I7e2Lwg
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Nov
 2024 21:27:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 9 Nov 2024 21:27:06 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brian Gerst' <brgerst@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak
	<ubizjak@gmail.com>
Subject: RE: [PATCH v5 00/16] x86-64: Stack protector and percpu improvements
Thread-Topic: [PATCH v5 00/16] x86-64: Stack protector and percpu improvements
Thread-Index: AQHbL5uNGPLMH1qOlUeFNPNYyx1uvLKusr0ggABhTACAAGabkA==
Date: Sat, 9 Nov 2024 21:27:06 +0000
Message-ID: <dee56ade8f2841c0b276a0b9af221981@AcuMS.aculab.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <5b42962e05754c15977a102ccd5cc7aa@AcuMS.aculab.com>
 <CAMzpN2h_4cKa7oxPQ0M169xQMKCtZCj9bTggBd4Cyk8j18tf=g@mail.gmail.com>
In-Reply-To: <CAMzpN2h_4cKa7oxPQ0M169xQMKCtZCj9bTggBd4Cyk8j18tf=g@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: w-0GuevKL-pkBVt5di1mKxEo_zqbyJFGJs_HdymJ0N8_1731187627
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogQnJpYW4gR2Vyc3QNCj4gU2VudDogMDkgTm92ZW1iZXIgMjAyNCAxNToxMQ0KPiANCj4g
T24gU2F0LCBOb3YgOSwgMjAyNCBhdCA0OjMx4oCvQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBCcmlhbiBHZXJzdA0KPiA+ID4g
U2VudDogMDUgTm92ZW1iZXIgMjAyNCAxNTo1OA0KPiA+ID4NCj4gPiA+IEN1cnJlbnRseSwgeDg2
LTY0IHVzZXMgYW4gdW51c3VhbCBwZXJjcHUgbGF5b3V0LCB3aGVyZSB0aGUgcGVyY3B1IHNlY3Rp
b24NCj4gPiA+IGlzIGxpbmtlZCBhdCBhYnNvbHV0ZSBhZGRyZXNzIDAuICBUaGUgcmVhc29uIGJl
aGluZCB0aGlzIGlzIHRoYXQgb2xkZXIgR0NDDQo+ID4gPiB2ZXJzaW9ucyBwbGFjZWQgdGhlIHN0
YWNrIHByb3RlY3RvciAoaWYgZW5hYmxlZCkgYXQgYSBmaXhlZCBvZmZzZXQgZnJvbSB0aGUNCj4g
PiA+IEdTIHNlZ21lbnQgYmFzZS4gIFNpbmNlIHRoZSBHUyBzZWdlbWVudCBpcyBhbHNvIHVzZWQg
Zm9yIHBlcmNwdSB2YXJpYWJsZXMsDQo+ID4gPiB0aGlzIGZvcmNlZCB0aGUgY3VycmVudCBsYXlv
dXQuDQo+ID4gPg0KPiA+ID4gR0NDIHNpbmNlIHZlcnNpb24gOC4xIHN1cHBvcnRzIGEgY29uZmln
dXJhYmxlIGxvY2F0aW9uIGZvciB0aGUgc3RhY2sNCj4gPiA+IHByb3RlY3RvciB2YWx1ZSwgd2hp
Y2ggYWxsb3dzIHJlbW92YWwgb2YgdGhlIHJlc3RyaWN0aW9uIG9uIGhvdyB0aGUgcGVyY3B1DQo+
ID4gPiBzZWN0aW9uIGlzIGxpbmtlZC4gIFRoaXMgYWxsb3dzIHRoZSBwZXJjcHUgc2VjdGlvbiB0
byBiZSBsaW5rZWQgbm9ybWFsbHksDQo+ID4gPiBsaWtlIG90aGVyIGFyY2hpdGVjdHVyZXMuICBJ
biB0dXJuLCB0aGlzIGFsbG93cyByZW1vdmFsIG9mIGNvZGUgdGhhdCB3YXMNCj4gPiA+IG5lZWRl
ZCB0byBzdXBwb3J0IHRoZSB6ZXJvLWJhc2VkIHBlcmNwdSBzZWN0aW9uLg0KPiA+ID4NCj4gPiA+
IHY1Og0KPiA+ID4gLSBBZGRlZCB0d28gcGF0Y2hlcyBmcm9tIEFyZCBCaWVzaGV1dmVsIHRvIG1h
a2Ugc3RhY2sgcHJvdGVjdG9yIHdvcmsNCj4gPiA+ICAgcHJvcGVybHkgd2hlbiBjb21waWxpbmcg
d2l0aCBjbGFuZy4NCj4gPiA+IC0gUmFpc2UgbWluaW11bSBHQ0MgdmVyc2lvbiB0byA4LjEgZm9y
IHg4Ni4NCj4gPiA+IC0gRHJvcCBvYmp0b29sIGNvbnZlcnNpb24gY29kZS4NCj4gPg0KPiA+IElz
IHRoZXJlIGFueSBhY3R1YWwgbmVlZCB0byByYWlzZSB0aGUgR0NDIGxldmVsPw0KPiA+IElzbid0
IGl0IGVub3VnaCBqdXN0IHRvIGRpc2FibGUgc3RhY2sgcHJvdGVjdGlvbiB3aXRoIG9sZGVyIGNv
bXBpbGVycz8NCj4gPiBUaGUgcGVyY3B1IGxheW91dCBjYW4gdGhlbiBhbHdheXMgYmUgdGhlIG5l
dyAoc2FuZSkgb25lLg0KPiANCj4gRWFybGllciB2ZXJzaW9ucyBvZiB0aGlzIHNlcmllcyBkaWQg
bWFrZSBzdGFjayBwcm90ZWN0b3Igc3VwcG9ydA0KPiBjb25kaXRpb25hbCBvbiBuZXdlciBjb21w
aWxlcnMuICBUaGF0IGdvdCByZWplY3RlZC4gIEkgdGhlbiBhZGRlZA0KPiBvYmp0b29sIHN1cHBv
cnQgdG8gY29udmVydCB0aGUgY29kZSBvbGQgY29tcGlsZXJzIHByb2R1Y2VkLiAgVGhhdCBhbHNv
DQo+IGdvdCByZWplY3RlZC4gIEkgZ3Vlc3MgSSBjYW4ndCBwbGVhc2UgZXZlcnlvbmUuDQoNCkkg
Y2VydGFpbmx5IHdvdWxkbid0IGhhdmUgYm90aGVyZWQgaGFja2luZyBvYmp0b29sLg0KDQo+ID4g
SXMgdGhlcmUgZXZlbiBhIHNlbGVjdGFibGUgQ09ORklHX1NUQUNLX1BST1RFQ1RPUj8NCj4gPiBD
YW4gdGhhbiBkZXBlbmQgb24gZ2NjID49IDguMSBmb3IgeDg2LTY0Pw0KPiANCj4gWWVzLCBzdGFj
ayBwcm90ZWN0b3Igc3VwcG9ydCBpcyBvcHRpb25hbCwgYnV0IHByYWN0aWNhbGx5IGFsbCBkaXN0
cm8NCj4ga2VybmVscyBlbmFibGUgaXQuDQoNClRoZXkgaW5jbHVkZSBhbGwgc29ydHMgb2Ygc3R1
ZmYgdGhhdCBzbG93cyB0aGluZ3MgZG93biA6LSkNCkJ1dCBJJ2QgcmF0aGVyIGJlIGFibGUgdG8g
YnVpbGQgYW5kIHRlc3Qga2VybmVscyB0aGFuIGhhdmUgdGhlIHN0YWNrIHByb3RlY3Rvci4NCg0K
PiA+IEkndmUgYSBzbGlnaHQgdmVzdGVkIGludGVyZXN0IGluIHRoYXQgdGhlIHN5c3RlbSBJIHRl
c3Qga2VybmVscyBvbg0KPiA+IGhhcyBnY2MgNy41LjAgaW5zdGFsbGVkIDotKQ0KPiANCj4gV2hh
dCBkaXN0cm8gaXMgb24gdGhhdCBzeXN0ZW0/ICBJcyBpdCBzdGlsbCBhY3RpdmVseSBzdXBwb3J0
ZWQ/DQoNClRoZSBzeXN0ZW0gaW4gcnVubmluZyBVYnVudHUgMTguMDQgTFRTIC0gYW5kIHN0aWxs
IHJlY2VpdmVzIHVwZGF0ZXMuDQpJIGRvIHJ1biBsb2NhbGx5IGJ1aWxkIGtlcm5lbHMgb24gaXQs
IGJ1dCBJIGNvdWxkIGp1c3QgYmUgYnVpbGRpbmcga2VybmVscy4NClNlZW1zIGEgc2hhbWUgdG8g
Zm9yY2UgYW4gdXBkYXRlIGZvciBzb21ldGhpbmcgSSBjYW4ganVzdCBkZXNlbGVjdC4NCg0KRm9y
IHJlZmVyZW5jZSBSSEVMNyBpcyBzdGlsbCBzdXBwb3J0ZWQgYnV0IGhhcyBhIDQuOC41IGNvbXBp
bGVyLg0KU28gaXQgaXMgYSBsb25nIHRpbWUgc2luY2UgdGhhdCBoYXMgc2VsZi1ob3N0ZWQga2Vy
bmVscy4NCldlIGJ1aWxkIHNvZnR3YXJlIGZvciByZWxlYXNlIG9uIENlbnRvcy03IGFzIGFuIGVh
c3kgd2F5IHRvIGdldCBhbiBvbGQgZ2xpYmMgKGV0YyksDQphbHRob3VnaCBidWlsZHJvb3QvYnVz
eWJveCAoeDg2LTY0KSAnZGlzdHJpYnV0aW9uJyBoYXMgdG8gdXNlIGEgbmV3ZXINCmNvbXBpbGVy
IC0gdGhlIGdydWIgYnVpbGQgZmFpbHMgd2VsbCBiZWZvcmUgeW91IGdldCB0byBhIGtlcm5lbCEN
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==


