Return-Path: <linux-kernel+bounces-361132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE899A3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4216E1F2260B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F9216A11;
	Fri, 11 Oct 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="HveZgY/l"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557211CDFA6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650203; cv=none; b=O1y2+5ZPms2+yZpoVG/U7SafnwstcLmbhuB4LbM1f/+XfX0O+BdMCGdAocyhxCWyXGbVIFhuThEAGnIkgJDsHFSAjQ1F4NgZBuQQdhqRPeS4mhX3bw+uKXOJ/eUXQ+NBIHWTzucrosUq6m9QjOdhiqXZz8jSq5YBjQgKBLhe344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650203; c=relaxed/simple;
	bh=BAn3siRDAgnwVG25BLsVB00Q6mbO9E4IIfsnTZzWDaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+Du8cSnhAiw41MZTl+8fPR5ZrYElf1NmP3/WR1/LPkOARwvraRJuzDBJppUxLZk/UFI6+qgnXQa7/If0O5qTtX50/eNV8Gme1qybIs+5TXFOEOL8xNWGCi9GGQKiAippQSUQUKNQ2cHtUFJxnnNF1ZEATfrdLsQDUJ6/J3LY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=HveZgY/l; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728650202; x=1760186202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=BAn3siRDAgnwVG25BLsVB00Q6mbO9E4IIfsnTZzWDaw=;
  b=HveZgY/lXGZZfUg+iodDiOWfEC8X9HedN66IawEvlaspyrCOSGLNUwHf
   aa8xF6hJWKYNi9eVS7srDqsRjtsxawRlIf5Hll4gWUPVEb6sKA+OZNodk
   CaMJ8JFqmLMNHkvMJL37DjHqKYT1xaNu4E7aZk00nacwXOUOot5AuMmuO
   M=;
X-IronPort-AV: E=Sophos;i="6.11,195,1725321600"; 
   d="scan'208";a="238571706"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 12:36:25 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:1074]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.6.84:2525] with esmtp (Farcaster)
 id 2a91b7c2-149e-457e-8ebb-790fdd488b8e; Fri, 11 Oct 2024 12:36:23 +0000 (UTC)
X-Farcaster-Flow-ID: 2a91b7c2-149e-457e-8ebb-790fdd488b8e
Received: from EX19D007EUA001.ant.amazon.com (10.252.50.133) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 12:36:23 +0000
Received: from EX19D026EUB001.ant.amazon.com (10.252.61.12) by
 EX19D007EUA001.ant.amazon.com (10.252.50.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 12:36:22 +0000
Received: from EX19D026EUB001.ant.amazon.com ([fe80::461a:a9c3:6352:d9d1]) by
 EX19D026EUB001.ant.amazon.com ([fe80::461a:a9c3:6352:d9d1%4]) with mapi id
 15.02.1258.034; Fri, 11 Oct 2024 12:36:22 +0000
From: "Mediouni, Mohamed" <mediou@amazon.de>
To: David Hildenbrand <david@redhat.com>
CC: "Mehanna, Fares" <faresx@amazon.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "ardb@kernel.org" <ardb@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"javierm@redhat.com" <javierm@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "ptosi@google.com"
	<ptosi@google.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "Kagan,
 Roman" <rkagan@amazon.de>, "rppt@kernel.org" <rppt@kernel.org>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "tabba@google.com"
	<tabba@google.com>, "will@kernel.org" <will@kernel.org>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>
Subject: Re: [RFC PATCH 0/7] support for mm-local memory allocations and use
 it
Thread-Topic: [RFC PATCH 0/7] support for mm-local memory allocations and use
 it
Thread-Index: AQHbBFfTHkfWP5JGCkGvLyon8je4I7JrsYmAgBSeggCAAVKjAIAACPEA
Date: Fri, 11 Oct 2024 12:36:22 +0000
Message-ID: <6E620679-FC47-4B13-BEF6-B63975881CCD@amazon.de>
References: <813b9bcb-afde-40b6-a604-cdb71b4b6d7a@redhat.com>
 <20241010155210.13321-1-faresx@amazon.de>
 <465ce78b-d023-40e6-b066-5e4a01e266b6@redhat.com>
In-Reply-To: <465ce78b-d023-40e6-b066-5e4a01e266b6@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <45974444DDED3543A93B2FD77750CA66@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTEuIE9jdCAyMDI0LCBhdCAxNDowNCwgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlk
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTAuMTAuMjQgMTc6NTIsIEZhcmVzIE1laGFu
bmEgd3JvdGU6DQo+Pj4+IEluIGEgc2VyaWVzIHBvc3RlZCBhIGZldyB5ZWFycyBhZ28gWzFdLCBh
IHByb3Bvc2FsIHdhcyBwdXQgZm9yd2FyZCB0byBhbGxvdyB0aGUNCj4+Pj4ga2VybmVsIHRvIGFs
bG9jYXRlIG1lbW9yeSBsb2NhbCB0byBhIG1tIGFuZCB0aHVzIHB1c2ggaXQgb3V0IG9mIHJlYWNo
IGZvcg0KPj4+PiBjdXJyZW50IGFuZCBmdXR1cmUgc3BlY3VsYXRpb24tYmFzZWQgY3Jvc3MtcHJv
Y2VzcyBhdHRhY2tzLiAgV2Ugc3RpbGwgYmVsaWV2ZQ0KPj4+PiB0aGlzIGlzIGEgbmljZSB0aGlu
ZyB0byBoYXZlLg0KPj4+PiANCj4+Pj4gSG93ZXZlciwgaW4gdGhlIHRpbWUgcGFzc2VkIHNpbmNl
IHRoYXQgcG9zdCBMaW51eCBtbSBoYXMgZ3Jvd24gcXVpdGUgYSBmZXcgbmV3DQo+Pj4+IGdvb2Rp
ZXMsIHNvIHdlJ2QgbGlrZSB0byBleHBsb3JlIHBvc3NpYmlsaXRpZXMgdG8gaW1wbGVtZW50IHRo
aXMgZnVuY3Rpb25hbGl0eQ0KPj4+PiB3aXRoIGxlc3MgZWZmb3J0IGFuZCBjaHVybiBsZXZlcmFn
aW5nIHRoZSBub3cgYXZhaWxhYmxlIGZhY2lsaXRpZXMuDQo+Pj4+IA0KPj4+PiBBbiBSRkMgd2Fz
IHBvc3RlZCBmZXcgbW9udGhzIGJhY2sgWzJdIHRvIHNob3cgdGhlIHByb29mIG9mIGNvbmNlcHQg
YW5kIGEgc2ltcGxlDQo+Pj4+IHRlc3QgZHJpdmVyLg0KPj4+PiANCj4+Pj4gSW4gdGhpcyBSRkMs
IHdlJ3JlIHVzaW5nIHRoZSBzYW1lIGFwcHJvYWNoIG9mIGltcGxlbWVudGluZyBtbS1sb2NhbCBh
bGxvY2F0aW9ucw0KPj4+PiBwaWdneS1iYWNraW5nIG9uIG1lbWZkX3NlY3JldCgpLCB1c2luZyBy
ZWd1bGFyIHVzZXIgYWRkcmVzc2VzIGJ1dCBwaW5uaW5nIHRoZQ0KPj4+PiBwYWdlcyBhbmQgZmxp
cHBpbmcgdGhlIHVzZXIvc3VwZXJ2aXNvciBmbGFnIG9uIHRoZSByZXNwZWN0aXZlIFBURXMgdG8g
bWFrZSB0aGVtDQo+Pj4+IGRpcmVjdGx5IGFjY2Vzc2libGUgZnJvbSBrZXJuZWwuDQo+Pj4+IElu
IGFkZGl0aW9uIHRvIHRoYXQgd2UgYXJlIHN1Ym1pdHRpbmcgNSBwYXRjaGVzIHRvIHVzZSB0aGUg
c2VjcmV0IG1lbW9yeSB0byBoaWRlDQo+Pj4+IHRoZSB2Q1BVIGdwLXJlZ3MgYW5kIGZwLXJlZ3Mg
b24gYXJtNjQgVkhFIHN5c3RlbXMuDQo+Pj4gDQo+Pj4gSSdtIGEgYml0IGxvc3Qgb24gd2hhdCBl
eGFjdGx5IHdlIHdhbnQgdG8gYWNoaWV2ZS4gVGhlIHBvaW50IHdoZXJlIHdlDQo+Pj4gc3RhcnQg
ZmxpcHBpbmcgdXNlci9zdXBlcnZpc29yIGZsYWdzIGNvbmZ1c2VzIG1lIDopDQo+Pj4gDQo+Pj4g
V2l0aCBzZWNyZXRtZW0sIHlvdSdkIGdldCBtZW1vcnkgYWxsb2NhdGVkIHRoYXQNCj4+PiAoYSkg
SXMgYWNjZXNzaWJsZSBieSB1c2VyIHNwYWNlIC0tIG1hcHBlZCBpbnRvIHVzZXIgc3BhY2UuDQo+
Pj4gKGIpIElzIGluYWNjZXNzaWJsZSBieSBrZXJuZWwgc3BhY2UgLS0gbm90IG1hcHBlZCBpbnRv
IHRoZSBkaXJlY3QgbWFwDQo+Pj4gKGMpIEdVUCB3aWxsIGZhaWwsIGJ1dCBjb3B5X2Zyb20gLyBj
b3B5X3RvIHVzZXIgd2lsbCB3b3JrLg0KPj4+IA0KPj4+IA0KPj4+IEFub3RoZXIgd2F5LCB3aXRo
b3V0IHNlY3JldG1lbSwgd291bGQgYmUgdG8gY29uc2lkZXIgdGhlc2UgInNlY3JldHMiDQo+Pj4g
a2VybmVsIGFsbG9jYXRpb25zIHRoYXQgY2FuIGJlIG1hcHBlZCBpbnRvIHVzZXIgc3BhY2UgdXNp
bmcgbW1hcCgpIG9mIGENCj4+PiBzcGVjaWFsIGZkLiBUaGF0IGlzLCB0aGV5IHdvdWxkbid0IGhh
dmUgdGhlaXIgb3JpZ2luIGluIHNlY3JldG1lbSwgYnV0DQo+Pj4gaW4gS1ZNIGFzIGEga2VybmVs
IGFsbG9jYXRpb24uIEl0IGNvdWxkIGJlIGFjaGlldmVkIGJ5IHVzaW5nIFZNX01JWEVETUFQDQo+
Pj4gd2l0aCB2bV9pbnNlcnRfcGFnZXMoKSwgbWFudWFsbHkgcmVtb3ZpbmcgdGhlbSBmcm9tIHRo
ZSBkaXJlY3RtYXAuDQo+Pj4gDQo+Pj4gQnV0LCBJIGFtIG5vdCBzdXJlIHdobyBpcyBzdXBwb3Nl
ZCB0byBhY2Nlc3Mgd2hhdC4gTGV0J3MgZXhwbG9yZSB0aGUNCj4+PiByZXF1aXJlbWVudHMuIEkg
YXNzdW1lIHdlIHdhbnQ6DQo+Pj4gDQo+Pj4gKGEpIFBhZ2VzIGFjY2Vzc2libGUgYnkgdXNlciBz
cGFjZSAtLSBtYXBwZWQgaW50byB1c2VyIHNwYWNlLg0KPj4+IChiKSBQYWdlcyBpbmFjY2Vzc2li
bGUgYnkga2VybmVsIHNwYWNlIC0tIG5vdCBtYXBwZWQgaW50byB0aGUgZGlyZWN0IG1hcA0KPj4+
IChjKSBHVVAgdG8gZmFpbCAobm8gZGlyZWN0IG1hcCkuDQo+Pj4gKGQpIGNvcHlfZnJvbSAvIGNv
cHlfdG8gdXNlciB0byBmYWlsPw0KPj4+IA0KPj4+IEFuZCBvbiB0b3Agb2YgdGhhdCwgc29tZSB3
YXkgdG8gYWNjZXNzIHRoZXNlIHBhZ2VzIG9uIGRlbWFuZCBmcm9tIGtlcm5lbA0KPj4+IHNwYWNl
PyAodGVtcG9yYXJ5IENQVS1sb2NhbCBtYXBwaW5nPykNCj4+PiANCj4+PiBPciBob3cgd291bGQg
dGhlIGtlcm5lbCBtYWtlIHVzZSBvZiB0aGVzZSBhbGxvY2F0aW9ucz8NCj4+PiANCj4+PiAtLSAN
Cj4+PiBDaGVlcnMsDQo+Pj4gDQo+Pj4gRGF2aWQgLyBkaGlsZGVuYg0KPj4gSGkgRGF2aWQsDQo+
IA0KPiBIaSBGYXJlcyENCj4gDQo+PiBUaGFua3MgZm9yIHRha2luZyBhIGxvb2sgYXQgdGhlIHBh
dGNoZXMhDQo+PiBXZSdyZSB0cnlpbmcgdG8gYWxsb2NhdGUgYSBrZXJuZWwgbWVtb3J5IHRoYXQg
aXMgYWNjZXNzaWJsZSB0byB0aGUga2VybmVsIGJ1dA0KPj4gb25seSB3aGVuIHRoZSBjb250ZXh0
IG9mIHRoZSBwcm9jZXNzIGlzIGxvYWRlZC4NCj4+IFNvIHRoaXMgaXMgYSBrZXJuZWwgbWVtb3J5
IHRoYXQgaXMgbm90IG5lZWRlZCB0byBvcGVyYXRlIHRoZSBrZXJuZWwgaXRzZWxmLCBpdA0KPj4g
aXMgdG8gc3RvcmUgJiBwcm9jZXNzIGRhdGEgb24gYmVoYWxmIG9mIGEgcHJvY2Vzcy4gVGhlIHJl
cXVpcmVtZW50IGZvciB0aGlzDQo+PiBtZW1vcnkgaXMgdGhhdCBpdCB3b3VsZCBuZXZlciBiZSB0
b3VjaGVkIHVubGVzcyB0aGUgcHJvY2VzcyBpcyBzY2hlZHVsZWQgb24gdGhpcw0KPj4gY29yZS4g
b3RoZXJ3aXNlIGFueSBvdGhlciBhY2Nlc3Mgd2lsbCBjcmFzaCB0aGUga2VybmVsLg0KPj4gU28g
dGhpcyBtZW1vcnkgc2hvdWxkIG9ubHkgYmUgZGlyZWN0bHkgcmVhZGFibGUgYW5kIHdyaXRhYmxl
IGJ5IHRoZSBrZXJuZWwsIGJ1dA0KPj4gb25seSB3aGVuIHRoZSBwcm9jZXNzIGNvbnRleHQgaXMg
bG9hZGVkLiBUaGUgbWVtb3J5IHNob3VsZG4ndCBiZSByZWFkYWJsZSBvcg0KPj4gd3JpdGFibGUg
YnkgdGhlIG93bmVyIHByb2Nlc3MgYXQgYWxsLg0KPj4gVGhpcyBpcyBiYXNpY2FsbHkgZG9uZSBi
eSByZW1vdmluZyB0aG9zZSBwYWdlcyBmcm9tIGtlcm5lbCBsaW5lYXIgYWRkcmVzcyBhbmQNCj4+
IGF0dGFjaGluZyB0aGVtIG9ubHkgaW4gdGhlIHByb2Nlc3MgbW1fc3RydWN0LiBTbyBkdXJpbmcg
Y29udGV4dCBzd2l0Y2hpbmcgdGhlDQo+PiBrZXJuZWwgbG9zZXMgYWNjZXNzIHRvIHRoZSBzZWNy
ZXQgbWVtb3J5IHNjaGVkdWxlZCBvdXQgYW5kIGdhaW4gYWNjZXNzIHRvIHRoZQ0KPj4gbmV3IHBy
b2Nlc3Mgc2VjcmV0IG1lbW9yeS4NCj4+IFRoaXMgZ2VuZXJhbGx5IHByb3RlY3RzIGFnYWluc3Qg
c3BlY3VsYXRpb24gYXR0YWNrcywgYW5kIGlmIG90aGVyIHByb2Nlc3MgbWFuYWdlZA0KPj4gdG8g
dHJpY2sgdGhlIGtlcm5lbCB0byBsZWFrIGRhdGEgZnJvbSBtZW1vcnkuIEluIHRoaXMgY2FzZSB0
aGUga2VybmVsIHdpbGwgY3Jhc2gNCj4+IGlmIGl0IHRyaWVzIHRvIGFjY2VzcyBvdGhlciBwcm9j
ZXNzZXMgc2VjcmV0IG1lbW9yeS4NCj4+IFNpbmNlIHRoaXMgbWVtb3J5IGlzIHNwZWNpYWwgaW4g
dGhlIHNlbnNlIHRoYXQgaXQgaXMga2VybmVsIG1lbW9yeSBidXQgb25seSBtYWtlDQo+PiBzZW5z
ZSBpbiB0aGUgdGVybSBvZiB0aGUgb3duZXIgcHJvY2VzcywgSSB0cmllZCBpbiB0aGlzIHBhdGNo
IHNlcmllcyB0byBleHBsb3JlDQo+PiB0aGUgcG9zc2liaWxpdHkgb2YgcmV1c2luZyBtZW1mZF9z
ZWNyZXQoKSB0byBhbGxvY2F0ZSB0aGlzIG1lbW9yeSBpbiB1c2VyIHZpcnR1YWwNCj4+IGFkZHJl
c3Mgc3BhY2UsIG1hbmFnZSBpdCBpbiBhIFZNQSwgZmxpcHBpbmcgdGhlIHBlcm1pc3Npb25zIHdo
aWxlIGtlZXBpbmcgdGhlDQo+PiBjb250cm9sIG9mIHRoZSBtYXBwaW5nIGV4Y2x1c2l2ZWx5IHdp
dGggdGhlIGtlcm5lbC4NCj4+IFJpZ2h0IG5vdyBpdCBpczoNCj4+IChhKSBQYWdlcyBub3QgYWNj
ZXNzaWJsZSBieSB1c2VyIHNwYWNlIC0tIGV2ZW4gdGhvdWdoIHRoZXkgYXJlIG1hcHBlZCBpbnRv
IHVzZXINCj4+ICAgICBzcGFjZSwgdGhlIFBURXMgYXJlIG1hcmtlZCBmb3Iga2VybmVsIHVzYWdl
Lg0KPiANCj4gQWgsIHRoYXQgaXMgdGhlIGRldGFpbCBJIHdhcyBtaXNzaW5nLCBub3cgSSBzZWUg
d2hhdCB5b3UgYXJlIHRyeWluZyB0byBhY2hpZXZlLCB0aGFua3MhDQo+IA0KPiBJdCBpcyBhIGJp
dCBhcmNoaXRlY3R1cmUgc3BlY2lmaWMsIGJlY2F1c2UgLi4uIGltYWdpbmUgYXJjaGl0ZWN0dXJl
cyB0aGF0IGhhdmUgc2VwYXJhdGUga2VybmVsK3VzZXIgc3BhY2UgcGFnZSB0YWJsZSBoaWVyYXJj
aGllcywgYW5kIG5vdCBhIHNpbXBsZSBQVEUgZmxhZyB0byBjaGFuZ2UgYWNjZXNzIHBlcm1pc3Np
b25zIGJldHdlZW4ga2VybmVsL3VzZXIgc3BhY2UuDQo+IA0KPiBJSVJDIHMzOTAgaXMgb25lIHN1
Y2ggYXJjaGl0ZWN0dXJlIHRoYXQgdXNlcyBzZXBhcmF0ZSBwYWdlIHRhYmxlcyBmb3IgdGhlIHVz
ZXItc3BhY2UgKyBrZXJuZWwtc3BhY2UgcG9ydGlvbnMuDQo+IA0KPj4gKGIpIFBhZ2VzIGFjY2Vz
c2libGUgYnkga2VybmVsIHNwYWNlIC0tIGV2ZW4gdGhvdWdoIHRoZXkgYXJlIG5vdCBtYXBwZWQg
aW50byB0aGUNCj4+ICAgICBkaXJlY3QgbWFwLCB0aGUgUFRFcyBpbiB1dmFkZHIgYXJlIG1hcmtl
ZCBmb3Iga2VybmVsIHVzYWdlLg0KPj4gKGMpIGNvcHlfZnJvbSAvIGNvcHlfdG8gdXNlciB3b24n
dCBmYWlsIC0tIGJlY2F1c2UgaXQgaXMgaW4gdGhlIHVzZXIgcmFuZ2UsIGJ1dA0KPj4gICAgIHRo
aXMgY2FuIGJlIGZpeGVkIGJ5IGFsbG9jYXRpbmcgc3BlY2lmaWMgcmFuZ2UgaW4gdXNlciB2YWRk
ciB0byB0aGlzIGZlYXR1cmUNCj4+ICAgICBhbmQgY2hlY2sgYWdhaW5zdCB0aGlzIHJhbmdlIHRo
ZXJlLg0KPj4gKGQpIFRoZSBzZWNyZXQgbWVtb3J5IHZhZGRyIGlzIGd1ZXNzYWJsZSBieSB0aGUg
b3duZXIgcHJvY2VzcyAtLSB0aGF0IGNhbiBhbHNvDQo+PiAgICAgYmUgZml4ZWQgYnkgYWxsb2Nh
dGluZyBiaWdnZXIgY2h1bmsgb2YgdXNlciB2YWRkciBmb3IgdGhpcyBmZWF0dXJlIGFuZA0KPj4g
ICAgIHJhbmRvbWx5IHBsYWNpbmcgdGhlIHNlY3JldCBtZW1vcnkgdGhlcmUuDQo+PiAoZSkgTWFw
cGluZyBpcyBvZmYtbGltaXRzIHRvIHRoZSBvd25lciBwcm9jZXNzIGJ5IG1hcmtpbmcgdGhlIFZN
QSBhcyBsb2NrZWQsDQo+PiAgICAgc2VhbGVkIGFuZCBzcGVjaWFsLg0KPiANCj4gT2theSwgc28g
aW4gdGhpcyBSRkMgeW91IGFyZSBqdW1waW5nIHRocm91Z2ggcXVpdGUgc29tZSBob29wcyB0byBo
YXZlIGEga2VybmVsIGFsbG9jYXRpb24gdW5tYXBwZWQgZnJvbSB0aGUgZGlyZWN0IG1hcCBidXQg
bWFwcGVkIGludG8gYSBwZXItcHJvY2VzcyBwYWdlIHRhYmxlIG9ubHkgYWNjZXNzaWJsZSBieSBr
ZXJuZWwgc3BhY2UuIDopDQo+IA0KPiBTbyB5b3UgcmVhbGx5IGRvbid0IHdhbnQgdGhpcyBtYXBw
ZWQgaW50byB1c2VyIHNwYWNlIGF0IGFsbCAoY29uc2VxdWVudGx5LCBubyBHVVAsIG5vIGFjY2Vz
cywgbm8gY29weV9mcm9tX3VzZXIgLi4uKS4gSW4gdGhpcyBSRkMgaXQncyBtYXBwZWQgYnV0IHR1
cm5lZCBpbmFjY2Vzc2libGUgYnkgZmxpcHBpbmcgdGhlICJrZXJuZWwgdnMuIHVzZXIiIHN3aXRj
aC4NCj4gDQo+PiBPdGhlciBhbHRlcm5hdGl2ZSAodGhhdCB3YXMgaW1wbGVtZW50ZWQgaW4gdGhl
IGZpcnN0IHN1Ym1pc3Npb24pIGlzIHRvIHRyYWNrIHRob3NlDQo+PiBhbGxvY2F0aW9ucyBpbiBh
IG5vbi1zaGFyZWQga2VybmVsIFBHRCBwZXIgcHJvY2VzcywgdGhlbiBoYW5kbGUgY3JlYXRpbmcs
IGZvcmtpbmcNCj4+IGFuZCBjb250ZXh0LXN3aXRjaGluZyB0aGlzIFBHRC4NCj4gDQo+IFRoYXQg
c291bmRzIGxpa2UgYSBiZXR0ZXIgYXBwcm9hY2guIFNvIHdlIHdvdWxkIHJlbW92ZSB0aGUgcGFn
ZXMgZnJvbSB0aGUgc2hhcmVkIGtlcm5lbCBkaXJlY3QgbWFwIGFuZCBtYXAgdGhlbSBpbnRvIGEg
c2VwYXJhdGUga2VybmVsLXBvcnRpb24gaW4gdGhlIHBlci1NTSBwYWdlIHRhYmxlcz8NCj4gDQo+
IENhbiB5b3UgZW52aXNpb24gdGhhdCB3b3VsZCBhbHNvIHdvcmsgd2l0aCBhcmNoaXRlY3R1cmVz
IGxpa2UgczM5MHg/IEkgYXNzdW1lIHdlIHdvdWxkIG5vdCBvbmx5IG5lZWQgdGhlIHBlci1NTSB1
c2VyIHNwYWNlIHBhZ2UgdGFibGUgaGllcmFyY2h5LCBidXQgYWxzbyBhIHBlci1NTSBrZXJuZWwg
c3BhY2UgcGFnZSB0YWJsZSBoaWVyYXJjaHksIGludG8gd2hpY2ggd2UgYWxzbyBtYXAgdGhlIGNv
bW1vbi9zaGFyZWQtYW1vbmctYWxsLXByb2Nlc3NlcyBrZXJuZWwgc3BhY2UgcGFnZSB0YWJsZXMg
KGUuZy4sIGRpcmVjdG1hcCkuDQpZZXMsIHRoYXTigJlzIGFsc28gYXBwbGljYWJsZSB0byBhcm02
NC4gVGhlcmXigJlzIGN1cnJlbnRseSBubyBzZXBhcmF0ZSBwZXItbW0gdXNlciBzcGFjZSBwYWdl
IGhpZXJhcmNoeSB0aGVyZS4NCj4+IFdoYXQgSSBsaWtlIGFib3V0IHRoZSBtZW1mZF9zZWNyZXQo
KSBhcHByb2FjaCBpcyB0aGUgc2ltcGxpY2l0eSBhbmQgYmVpbmcgYXJjaA0KPj4gYWdub3N0aWMs
IHdoYXQgSSBkb24ndCBsaWtlIGlzIHRoZSBpbmNyZWFzZWQgYXR0YWNrIHN1cmZhY2UgYnkgdXNp
bmcgVk1BcyB0bw0KPj4gdHJhY2sgdGhvc2UgYWxsb2NhdGlvbnMuDQo+IA0KPiBZZXMsIGJ1dCBt
ZW1mZF9zZWNyZXQoKSB3YXMgcmVhbGx5IGRlc2lnbiBmb3IgdXNlciBzcGFjZSB0byBob2xkIHNl
Y3JldHMuIEJ1dCBJIGNhbiBzZWUgaG93IHlvdSBjYW1lIHRvIHRoaXMgc29sdXRpb24uDQo+IA0K
Pj4gSSdtIHRoaW5raW5nIG9mIHdvcmtpbmcgb24gYSBQb0MgdG8gaW1wbGVtZW50IHRoZSBmaXJz
dCBhcHByb2FjaCBvZiB1c2luZyBhDQo+PiBub24tc2hhcmVkIGtlcm5lbCBQR0QgZm9yIHNlY3Jl
dCBtZW1vcnkgYWxsb2NhdGlvbnMgb24gYXJtNjQuIFRoaXMgaW5jbHVkZXMNCj4+IGFkZGluZyBr
ZXJuZWwgcGFnZSB0YWJsZSBwZXIgcHJvY2VzcyB3aGVyZSBhbGwgUEdEcyBhcmUgc2hhcmVkIGJ1
dCBvbmUgd2hpY2gNCj4+IHdpbGwgYmUgdXNlZCBmb3Igc2VjcmV0IGFsbG9jYXRpb25zIG1hcHBp
bmcuIEFuZCBoYW5kbGUgdGhlIGZvcmsgJiBjb250ZXh0DQo+PiBzd2l0Y2hpbmcgKFRUQlIxIHN3
aXRjaGluZyg/KSkgY29ycmVjdGx5IGZvciB0aGUgc2VjcmV0IG1lbW9yeSBQR0QuDQo+PiBXaGF0
IGRvIHlvdSB0aGluaz8gSSdkIHJlYWxseSBhcHByZWNpYXRlIG9waW5pb25zIGFuZCBwb3NzaWJs
ZSB3YXlzIGZvcndhcmQuDQo+IA0KPiBOYWl2ZSBxdWVzdGlvbjogZG9lcyBhcm02NCByYXRoZXIg
cmVzZW1ibGUgdGhlIHMzOTB4IG1vZGVsIG9yIHRoZSB4ODYtNjQgbW9kZWw/DQphcm02NCBoYXMg
c2VwYXJhdGUgcGFnZSB0YWJsZXMgZm9yIGtlcm5lbCBhbmQgdXNlci1tb2RlLiBFeGNlcHQgZm9y
IHRoZSBLUFRJIGNhc2UsIHRoZSBrZXJuZWwgcGFnZSB0YWJsZXMgYXJlbuKAmXQgc3dhcHBlZCBw
ZXItcHJvY2VzcyBhbmQgc3RheSB0aGUgc2FtZSBhbGwgdGhlIHRpbWUuDQoNClRoYW5rcywNCi1N
b2hhbWVkDQo+IC0tIA0KPiBDaGVlcnMsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQo+IA0KDQoK
CgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1
MzggNTk3Cg==


