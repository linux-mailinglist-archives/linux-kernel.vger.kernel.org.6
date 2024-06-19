Return-Path: <linux-kernel+bounces-220651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813B90E4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21631F283DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F505770FD;
	Wed, 19 Jun 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NaRnMILx"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8D770ED
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783605; cv=none; b=NnhfWgPv3e+mmn9QRfeID5zw6iq2BsMW0SmCBFaYgM5058pTDiS/J+4+gOEkTfdGgRvuaEQc0zRz08kBy7DiT8D5tsfrGZIqcJ3rl5nsrf9iEtK61/GPpCB5PwHQ+H3qvh8yOZqfQSybwe3FQLQyBvtTtA8J+aLItU3NPsEAzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783605; c=relaxed/simple;
	bh=OZ5ouAYW0cipbIEogzkWg2gns1j8tUxyGUKdhTmJWbw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KOwcKYbwOGzviX5oRwQF8uXZ0kigT7bXZsAmBUFI7lijF8QjaKL4FPpVV/NuizjoF1t+y32z3+uhvy/ZMw2I4hcKYEFooQ88r2pFftq+vgw8tixBY4622AX9AhQRmqhIQ9Svzg5mAoPTEIhLm28v6bLLU+Cxb/3bT3+iAQ91itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NaRnMILx; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718783604; x=1750319604;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=OZ5ouAYW0cipbIEogzkWg2gns1j8tUxyGUKdhTmJWbw=;
  b=NaRnMILxwhX11dVMlSPxM99cXwux2Sap3iQUOBpjbOTSGNUZkkmmnLIP
   +P3zcb8O2WN+Ef+QWALe3gD9rySt9qD3mQNixvcDy0fAAhNSY8PpImhlA
   hK7femi8GRXoewf0c5b0ycn5DvMQRwoG9DnPcPX7t9k/MG8whfoSorEd/
   I=;
X-IronPort-AV: E=Sophos;i="6.08,249,1712620800"; 
   d="scan'208";a="734467284"
Subject: Re: [PATCH] memblocks: Move late alloc warning down to phys alloc
Thread-Topic: [PATCH] memblocks: Move late alloc warning down to phys alloc
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 07:53:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:13519]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.70:2525] with esmtp (Farcaster)
 id 6ffc738e-0de2-4b81-bfc0-4adef2fbddc4; Wed, 19 Jun 2024 07:53:17 +0000 (UTC)
X-Farcaster-Flow-ID: 6ffc738e-0de2-4b81-bfc0-4adef2fbddc4
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Jun 2024 07:53:16 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Jun 2024 07:53:15 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Wed, 19 Jun 2024 07:53:14 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "rppt@kernel.org" <rppt@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Index: AQHavl8JEu7jPLy2j0OmqaY6NTX8mbHNYTwAgAFdeYA=
Date: Wed, 19 Jun 2024 07:53:14 +0000
Message-ID: <b5be15c1b7389afad2b67bf85b26aab4d213ca19.camel@amazon.com>
References: <20240614133016.134150-1-jgowans@amazon.com>
	 <ZnFpPCSTAUj90FJF@kernel.org>
In-Reply-To: <ZnFpPCSTAUj90FJF@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <610B10CA71BEAF459B33A1352956A266@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDE0OjAyICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBGcmksIEp1biAxNCwgMjAyNCBhdCAwMzozMDoxNlBNICswMjAwLCBKYW1lcyBHb3dhbnMg
d3JvdGU6DQo+ID4gU3ViamVjdDogW1BBVENIXSBtZW1ibG9ja3M6IE1vdmUgbGF0ZSBhbGxvYyB3
YXJuaW5nIGRvd24gdG8gcGh5cyBhbGxvYw0KPiANCj4gTml0OiBtZW1ibG9jaw0KDQpBY2shDQoN
Cj4gDQo+ID4gSWYgYSBkcml2ZXIvc3Vic3lzdGVtIHRyaWVzIHRvIGRvIGFuIGFsbG9jYXRpb24g
YWZ0ZXIgbWVtYmxvY2tzIGhhdmUNCj4gPiBiZWVuIGZyZWVkIGFuZCB0aGUgbWVtb3J5IGhhbmRl
ZCB0byB0aGUgYnVkZHkgYWxsb2NhdG9yLCBpdCB3aWxsIG5vdA0KPiA+IGFjdHVhbGx5IGJlIGxl
Z2FsIHRvIHVzZSB0aGF0IGFsbG9jYXRpb24gLSB0aGUgYnVkZHkgYWxsb2NhdG9yIG93bnMgdGhl
DQo+ID4gbWVtb3J5LiBUaGlzIGlzIGhhbmRsZWQgYnkgdGhlIG1lbWJsb2NrcyBmdW5jdGlvbiB3
aGljaCBkb2VzIGFsbG9jYXRpb25zDQo+ID4gYW5kIHJldHVybnMgdmlydHVhbCBhZGRyZXNzZXMg
YnkgcHJpbnRpbmcgYSB3YXJuaW5nIGFuZCBkb2luZyBhIGttYWxsb2MNCj4gPiBpbnN0ZWFkLiBI
b3dldmVyLCB0aGUgcGh5c2ljYWwgYWxsb2NhdGlvbiBmdW5jdGlvbiBkb2VzIG5vdCB0byBkbyB0
aGlzDQo+ID4gY2hlY2sgLSBjYWxsZXJzIG9mIHRoZSBwaHlzaWNhbCBhbGxvYyBmdW5jdGlvbiBh
cmUgdW5wcm90ZWN0ZWQgYWdhaW5zdA0KPiA+IG1pcy11c2UuDQo+IA0KPiBEaWQgeW91IHNlZSBz
dWNoIG1pc3VzZSBvciB0aGlzIGlzIGEgdGhlb3JldGljYWwgaXNzdWU/DQoNClllYWgsIEkgd2Fz
IGRyaXZpbmcgdGhlIG1lbWJsb2NrIGFsbG9jYXRvciBiYWRseSB3aGVuIHByb3RvdHlwaW5nDQpz
b21ldGhpbmcuIEFsbG9jYXRpbmcgYSBsYXJnZSBjb250aWd1b3VzIGJsb2NrIG9mIG1lbW9yeSBm
b3IgYW4gaW4tDQptZW1vcnkgZmlsZXN5c3RlbSBhbmQgSSB3YXMgZG9pbmcgdGhlIGFsbG9jYXRp
b24gaW4gYW4gaW5pdGNhbGwsIGJ1dCBieQ0KdGhhdCBwb2ludCBpdCB3YXMgdG9vIGxhdGUuIFRo
ZSBtZW1ibG9jayBhbGxvY2F0b3IgaGFwcGlseSBnYXZlIG1lIGENCmxhcmdlIGNodW5rIG9mIG1l
bW9yeSwgYnV0IGl0IHdhcyBhbHJlYWR5IGluIHVzZSBieSB0aGUgYnVkZHkgYWxsb2NhdG9yLA0K
c28gZW5kZWQgdXAgd2l0aCBtZW1vcnkgY29ycnVwdGlvbi4gT29wcyEgR2V0dGluZyB0aGlzIHdh
cm5pbmcgd291bGQNCmhhdmUgbWFkZSB0aGUgcHJvYmxlbSBpbW1lZGlhdGVseSBvYnZpb3VzLg0K
DQo+IA0KPiA+IEltcHJvdmUgdGhlIGVycm9yIGNhdGNoaW5nIGhlcmUgYnkgbW92aW5nIHRoZSBj
aGVjayBpbnRvIHRoZSBwaHlzaWNhbA0KPiA+IGFsbG9jYXRpb24gZnVuY3Rpb24gd2hpY2ggaXMg
dXNlZCBieSB0aGUgdmlydHVhbCBhZGRyIGFsbG9jYXRpb24NCj4gPiBmdW5jdGlvbi4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBHb3dhbnMgPGpnb3dhbnNAYW1hem9uLmNvbT4NCj4g
PiBDYzogTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPg0KPiA+IENjOiBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBBbGV4IEdyYWYgPGdyYWZA
YW1hem9uLmRlPg0KPiA+IC0tLQ0KPiA+ICBtbS9tZW1ibG9jay5jIHwgMTggKysrKysrKysrKyst
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9tZW1ibG9jay5jIGIvbW0vbWVtYmxvY2su
Yw0KPiA+IGluZGV4IGQwOTEzNmUwNDBkMy4uZGQ0ZjIzN2RjMWZjIDEwMDY0NA0KPiA+IC0tLSBh
L21tL21lbWJsb2NrLmMNCj4gPiArKysgYi9tbS9tZW1ibG9jay5jDQo+ID4gQEAgLTE0NTcsNiAr
MTQ1NywxNyBAQCBwaHlzX2FkZHJfdCBfX2luaXQgbWVtYmxvY2tfYWxsb2NfcmFuZ2VfbmlkKHBo
eXNfYWRkcl90IHNpemUsDQo+ID4gICAgICAgICAgICAgICBhbGlnbiA9IFNNUF9DQUNIRV9CWVRF
UzsNCj4gPiAgICAgICB9DQo+ID4gDQo+ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBEZXRlY3Qg
YW55IGFjY2lkZW50YWwgdXNlIG9mIHRoZXNlIEFQSXMgYWZ0ZXIgc2xhYiBpcyByZWFkeSwgYXMg
YXQNCj4gPiArICAgICAgKiB0aGlzIG1vbWVudCBtZW1ibG9jayBtYXkgYmUgZGVpbml0aWFsaXpl
ZCBhbHJlYWR5IGFuZCBpdHMNCj4gPiArICAgICAgKiBpbnRlcm5hbCBkYXRhIG1heSBiZSBkZXN0
cm95ZWQgKGFmdGVyIGV4ZWN1dGlvbiBvZiBtZW1ibG9ja19mcmVlX2FsbCkNCj4gPiArICAgICAg
Ki8NCj4gPiArICAgICBpZiAoV0FSTl9PTl9PTkNFKHNsYWJfaXNfYXZhaWxhYmxlKCkpKSB7DQo+
ID4gKyAgICAgICAgICAgICB2b2lkICp2YWRkciA9IGt6YWxsb2Nfbm9kZShzaXplLCBHRlBfTk9X
QUlULCBuaWQpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIHJldHVybiB2YWRkciA/IHZpcnRf
dG9fcGh5cyh2YWRkcikgOiAwOw0KPiA+ICsgICAgIH0NCj4gDQo+IEknZCBtb3ZlIHRoaXMgYmVm
b3JlIGFsaWdubWVudCBjaGVjay4NCg0KQWNrLCB3aWxsIGRvIGluIFYyLg0KDQpBbnl0aGluZyBl
bHNlIG9yIHNob3VsZCBJIG1ha2UgdGhlIHR3ZWFrcyBhbmQgcG9zdCBWMj8NCg0KSkcNCg==

