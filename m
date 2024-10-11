Return-Path: <linux-kernel+bounces-361147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FE99A443
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EB6B21A71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D4221858F;
	Fri, 11 Oct 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="f7BZcfmm"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFF218582
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651377; cv=none; b=T1mjq1Mr/Seo8daT+3wetb0OaylnLq/rCqrw77UbnWat1isVqUA9ky0Bbs39R0EW4k+ZP+byy6KTgFDwscED+Rk8emgf7Lw3S5RGZHo+LRc0VClSaM0haVb4ZtfKHeOhn5m7srBb0y6OwOGlMJKT62Lb6bah3PA1nlogz1IE4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651377; c=relaxed/simple;
	bh=F65bfxBMhT5sT+0wha2wr3NScIjN5BrEZRD/gdbDLt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4RZoen5MmcPZMoLsSKDaWy64UV3eGXdlTZhw1fqJZ9ja/xtRMkjmUVuEzmaDx85TaEsyNjfIDcTGjtR7Uppm/kfYEPH/WFnFk5OZDH/4xUS5EbPIFz/Bf8S7a6CZTlDFD09ClDejbRUTprE4hh2bq5zWqpVsEDtfVs0dsVHd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=f7BZcfmm; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728651376; x=1760187376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=F65bfxBMhT5sT+0wha2wr3NScIjN5BrEZRD/gdbDLt4=;
  b=f7BZcfmmpeO1gcaAV7yIB17RZEnlT632ZBuNPWpchRe4LmilQrDe+dlY
   QnnMder0Y52zzd/IfY9p9fDnJqAVbVciIe9rT4EdVardlOnBnFHxC2igZ
   INS5i1nlR7jWSpO6RxNWXJOUZhzfLL5WnebwlNz8OjpEM0vVdyIB3YF1i
   I=;
X-IronPort-AV: E=Sophos;i="6.11,195,1725321600"; 
   d="scan'208";a="765755123"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 12:56:09 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:53171]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.166:2525] with esmtp (Farcaster)
 id ca804dee-56b2-48f1-9ffb-e8dcd06beabd; Fri, 11 Oct 2024 12:56:07 +0000 (UTC)
X-Farcaster-Flow-ID: ca804dee-56b2-48f1-9ffb-e8dcd06beabd
Received: from EX19D007EUB003.ant.amazon.com (10.252.51.43) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 12:56:06 +0000
Received: from EX19D026EUB001.ant.amazon.com (10.252.61.12) by
 EX19D007EUB003.ant.amazon.com (10.252.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 12:56:06 +0000
Received: from EX19D026EUB001.ant.amazon.com ([fe80::461a:a9c3:6352:d9d1]) by
 EX19D026EUB001.ant.amazon.com ([fe80::461a:a9c3:6352:d9d1%4]) with mapi id
 15.02.1258.034; Fri, 11 Oct 2024 12:56:06 +0000
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
Thread-Index: AQHbBFfTHkfWP5JGCkGvLyon8je4I7JrsYmAgBSeggCAAVKjAIAACPEAgAAFhAA=
Date: Fri, 11 Oct 2024 12:56:06 +0000
Message-ID: <C35C04F5-DEC3-45B3-A049-ED433F34767D@amazon.de>
References: <813b9bcb-afde-40b6-a604-cdb71b4b6d7a@redhat.com>
 <20241010155210.13321-1-faresx@amazon.de>
 <465ce78b-d023-40e6-b066-5e4a01e266b6@redhat.com>
 <6E620679-FC47-4B13-BEF6-B63975881CCD@amazon.de>
In-Reply-To: <6E620679-FC47-4B13-BEF6-B63975881CCD@amazon.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBDB2140A2C29844AFECAE6F8BCF96F5@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTEuIE9jdCAyMDI0LCBhdCAxNDozNiwgTWVkaW91bmksIE1vaGFtZWQgPG1lZGlv
dUBhbWF6b24uZGU+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gMTEuIE9jdCAyMDI0LCBhdCAx
NDowNCwgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gDQo+
PiBPbiAxMC4xMC4yNCAxNzo1MiwgRmFyZXMgTWVoYW5uYSB3cm90ZToNCj4+Pj4+IEluIGEgc2Vy
aWVzIHBvc3RlZCBhIGZldyB5ZWFycyBhZ28gWzFdLCBhIHByb3Bvc2FsIHdhcyBwdXQgZm9yd2Fy
ZCB0byBhbGxvdyB0aGUNCj4+Pj4+IGtlcm5lbCB0byBhbGxvY2F0ZSBtZW1vcnkgbG9jYWwgdG8g
YSBtbSBhbmQgdGh1cyBwdXNoIGl0IG91dCBvZiByZWFjaCBmb3INCj4+Pj4+IGN1cnJlbnQgYW5k
IGZ1dHVyZSBzcGVjdWxhdGlvbi1iYXNlZCBjcm9zcy1wcm9jZXNzIGF0dGFja3MuICBXZSBzdGls
bCBiZWxpZXZlDQo+Pj4+PiB0aGlzIGlzIGEgbmljZSB0aGluZyB0byBoYXZlLg0KPj4+Pj4gDQo+
Pj4+PiBIb3dldmVyLCBpbiB0aGUgdGltZSBwYXNzZWQgc2luY2UgdGhhdCBwb3N0IExpbnV4IG1t
IGhhcyBncm93biBxdWl0ZSBhIGZldyBuZXcNCj4+Pj4+IGdvb2RpZXMsIHNvIHdlJ2QgbGlrZSB0
byBleHBsb3JlIHBvc3NpYmlsaXRpZXMgdG8gaW1wbGVtZW50IHRoaXMgZnVuY3Rpb25hbGl0eQ0K
Pj4+Pj4gd2l0aCBsZXNzIGVmZm9ydCBhbmQgY2h1cm4gbGV2ZXJhZ2luZyB0aGUgbm93IGF2YWls
YWJsZSBmYWNpbGl0aWVzLg0KPj4+Pj4gDQo+Pj4+PiBBbiBSRkMgd2FzIHBvc3RlZCBmZXcgbW9u
dGhzIGJhY2sgWzJdIHRvIHNob3cgdGhlIHByb29mIG9mIGNvbmNlcHQgYW5kIGEgc2ltcGxlDQo+
Pj4+PiB0ZXN0IGRyaXZlci4NCj4+Pj4+IA0KPj4+Pj4gSW4gdGhpcyBSRkMsIHdlJ3JlIHVzaW5n
IHRoZSBzYW1lIGFwcHJvYWNoIG9mIGltcGxlbWVudGluZyBtbS1sb2NhbCBhbGxvY2F0aW9ucw0K
Pj4+Pj4gcGlnZ3ktYmFja2luZyBvbiBtZW1mZF9zZWNyZXQoKSwgdXNpbmcgcmVndWxhciB1c2Vy
IGFkZHJlc3NlcyBidXQgcGlubmluZyB0aGUNCj4+Pj4+IHBhZ2VzIGFuZCBmbGlwcGluZyB0aGUg
dXNlci9zdXBlcnZpc29yIGZsYWcgb24gdGhlIHJlc3BlY3RpdmUgUFRFcyB0byBtYWtlIHRoZW0N
Cj4+Pj4+IGRpcmVjdGx5IGFjY2Vzc2libGUgZnJvbSBrZXJuZWwuDQo+Pj4+PiBJbiBhZGRpdGlv
biB0byB0aGF0IHdlIGFyZSBzdWJtaXR0aW5nIDUgcGF0Y2hlcyB0byB1c2UgdGhlIHNlY3JldCBt
ZW1vcnkgdG8gaGlkZQ0KPj4+Pj4gdGhlIHZDUFUgZ3AtcmVncyBhbmQgZnAtcmVncyBvbiBhcm02
NCBWSEUgc3lzdGVtcy4NCj4+Pj4gDQo+Pj4+IEknbSBhIGJpdCBsb3N0IG9uIHdoYXQgZXhhY3Rs
eSB3ZSB3YW50IHRvIGFjaGlldmUuIFRoZSBwb2ludCB3aGVyZSB3ZQ0KPj4+PiBzdGFydCBmbGlw
cGluZyB1c2VyL3N1cGVydmlzb3IgZmxhZ3MgY29uZnVzZXMgbWUgOikNCj4+Pj4gDQo+Pj4+IFdp
dGggc2VjcmV0bWVtLCB5b3UnZCBnZXQgbWVtb3J5IGFsbG9jYXRlZCB0aGF0DQo+Pj4+IChhKSBJ
cyBhY2Nlc3NpYmxlIGJ5IHVzZXIgc3BhY2UgLS0gbWFwcGVkIGludG8gdXNlciBzcGFjZS4NCj4+
Pj4gKGIpIElzIGluYWNjZXNzaWJsZSBieSBrZXJuZWwgc3BhY2UgLS0gbm90IG1hcHBlZCBpbnRv
IHRoZSBkaXJlY3QgbWFwDQo+Pj4+IChjKSBHVVAgd2lsbCBmYWlsLCBidXQgY29weV9mcm9tIC8g
Y29weV90byB1c2VyIHdpbGwgd29yay4NCj4+Pj4gDQo+Pj4+IA0KPj4+PiBBbm90aGVyIHdheSwg
d2l0aG91dCBzZWNyZXRtZW0sIHdvdWxkIGJlIHRvIGNvbnNpZGVyIHRoZXNlICJzZWNyZXRzIg0K
Pj4+PiBrZXJuZWwgYWxsb2NhdGlvbnMgdGhhdCBjYW4gYmUgbWFwcGVkIGludG8gdXNlciBzcGFj
ZSB1c2luZyBtbWFwKCkgb2YgYQ0KPj4+PiBzcGVjaWFsIGZkLiBUaGF0IGlzLCB0aGV5IHdvdWxk
bid0IGhhdmUgdGhlaXIgb3JpZ2luIGluIHNlY3JldG1lbSwgYnV0DQo+Pj4+IGluIEtWTSBhcyBh
IGtlcm5lbCBhbGxvY2F0aW9uLiBJdCBjb3VsZCBiZSBhY2hpZXZlZCBieSB1c2luZyBWTV9NSVhF
RE1BUA0KPj4+PiB3aXRoIHZtX2luc2VydF9wYWdlcygpLCBtYW51YWxseSByZW1vdmluZyB0aGVt
IGZyb20gdGhlIGRpcmVjdG1hcC4NCj4+Pj4gDQo+Pj4+IEJ1dCwgSSBhbSBub3Qgc3VyZSB3aG8g
aXMgc3VwcG9zZWQgdG8gYWNjZXNzIHdoYXQuIExldCdzIGV4cGxvcmUgdGhlDQo+Pj4+IHJlcXVp
cmVtZW50cy4gSSBhc3N1bWUgd2Ugd2FudDoNCj4+Pj4gDQo+Pj4+IChhKSBQYWdlcyBhY2Nlc3Np
YmxlIGJ5IHVzZXIgc3BhY2UgLS0gbWFwcGVkIGludG8gdXNlciBzcGFjZS4NCj4+Pj4gKGIpIFBh
Z2VzIGluYWNjZXNzaWJsZSBieSBrZXJuZWwgc3BhY2UgLS0gbm90IG1hcHBlZCBpbnRvIHRoZSBk
aXJlY3QgbWFwDQo+Pj4+IChjKSBHVVAgdG8gZmFpbCAobm8gZGlyZWN0IG1hcCkuDQo+Pj4+IChk
KSBjb3B5X2Zyb20gLyBjb3B5X3RvIHVzZXIgdG8gZmFpbD8NCj4+Pj4gDQo+Pj4+IEFuZCBvbiB0
b3Agb2YgdGhhdCwgc29tZSB3YXkgdG8gYWNjZXNzIHRoZXNlIHBhZ2VzIG9uIGRlbWFuZCBmcm9t
IGtlcm5lbA0KPj4+PiBzcGFjZT8gKHRlbXBvcmFyeSBDUFUtbG9jYWwgbWFwcGluZz8pDQo+Pj4+
IA0KPj4+PiBPciBob3cgd291bGQgdGhlIGtlcm5lbCBtYWtlIHVzZSBvZiB0aGVzZSBhbGxvY2F0
aW9ucz8NCj4+Pj4gDQo+Pj4+IC0tIA0KPj4+PiBDaGVlcnMsDQo+Pj4+IA0KPj4+PiBEYXZpZCAv
IGRoaWxkZW5iDQo+Pj4gSGkgRGF2aWQsDQo+PiANCj4+IEhpIEZhcmVzIQ0KPj4gDQo+Pj4gVGhh
bmtzIGZvciB0YWtpbmcgYSBsb29rIGF0IHRoZSBwYXRjaGVzIQ0KPj4+IFdlJ3JlIHRyeWluZyB0
byBhbGxvY2F0ZSBhIGtlcm5lbCBtZW1vcnkgdGhhdCBpcyBhY2Nlc3NpYmxlIHRvIHRoZSBrZXJu
ZWwgYnV0DQo+Pj4gb25seSB3aGVuIHRoZSBjb250ZXh0IG9mIHRoZSBwcm9jZXNzIGlzIGxvYWRl
ZC4NCj4+PiBTbyB0aGlzIGlzIGEga2VybmVsIG1lbW9yeSB0aGF0IGlzIG5vdCBuZWVkZWQgdG8g
b3BlcmF0ZSB0aGUga2VybmVsIGl0c2VsZiwgaXQNCj4+PiBpcyB0byBzdG9yZSAmIHByb2Nlc3Mg
ZGF0YSBvbiBiZWhhbGYgb2YgYSBwcm9jZXNzLiBUaGUgcmVxdWlyZW1lbnQgZm9yIHRoaXMNCj4+
PiBtZW1vcnkgaXMgdGhhdCBpdCB3b3VsZCBuZXZlciBiZSB0b3VjaGVkIHVubGVzcyB0aGUgcHJv
Y2VzcyBpcyBzY2hlZHVsZWQgb24gdGhpcw0KPj4+IGNvcmUuIG90aGVyd2lzZSBhbnkgb3RoZXIg
YWNjZXNzIHdpbGwgY3Jhc2ggdGhlIGtlcm5lbC4NCj4+PiBTbyB0aGlzIG1lbW9yeSBzaG91bGQg
b25seSBiZSBkaXJlY3RseSByZWFkYWJsZSBhbmQgd3JpdGFibGUgYnkgdGhlIGtlcm5lbCwgYnV0
DQo+Pj4gb25seSB3aGVuIHRoZSBwcm9jZXNzIGNvbnRleHQgaXMgbG9hZGVkLiBUaGUgbWVtb3J5
IHNob3VsZG4ndCBiZSByZWFkYWJsZSBvcg0KPj4+IHdyaXRhYmxlIGJ5IHRoZSBvd25lciBwcm9j
ZXNzIGF0IGFsbC4NCj4+PiBUaGlzIGlzIGJhc2ljYWxseSBkb25lIGJ5IHJlbW92aW5nIHRob3Nl
IHBhZ2VzIGZyb20ga2VybmVsIGxpbmVhciBhZGRyZXNzIGFuZA0KPj4+IGF0dGFjaGluZyB0aGVt
IG9ubHkgaW4gdGhlIHByb2Nlc3MgbW1fc3RydWN0LiBTbyBkdXJpbmcgY29udGV4dCBzd2l0Y2hp
bmcgdGhlDQo+Pj4ga2VybmVsIGxvc2VzIGFjY2VzcyB0byB0aGUgc2VjcmV0IG1lbW9yeSBzY2hl
ZHVsZWQgb3V0IGFuZCBnYWluIGFjY2VzcyB0byB0aGUNCj4+PiBuZXcgcHJvY2VzcyBzZWNyZXQg
bWVtb3J5Lg0KPj4+IFRoaXMgZ2VuZXJhbGx5IHByb3RlY3RzIGFnYWluc3Qgc3BlY3VsYXRpb24g
YXR0YWNrcywgYW5kIGlmIG90aGVyIHByb2Nlc3MgbWFuYWdlZA0KPj4+IHRvIHRyaWNrIHRoZSBr
ZXJuZWwgdG8gbGVhayBkYXRhIGZyb20gbWVtb3J5LiBJbiB0aGlzIGNhc2UgdGhlIGtlcm5lbCB3
aWxsIGNyYXNoDQo+Pj4gaWYgaXQgdHJpZXMgdG8gYWNjZXNzIG90aGVyIHByb2Nlc3NlcyBzZWNy
ZXQgbWVtb3J5Lg0KPj4+IFNpbmNlIHRoaXMgbWVtb3J5IGlzIHNwZWNpYWwgaW4gdGhlIHNlbnNl
IHRoYXQgaXQgaXMga2VybmVsIG1lbW9yeSBidXQgb25seSBtYWtlDQo+Pj4gc2Vuc2UgaW4gdGhl
IHRlcm0gb2YgdGhlIG93bmVyIHByb2Nlc3MsIEkgdHJpZWQgaW4gdGhpcyBwYXRjaCBzZXJpZXMg
dG8gZXhwbG9yZQ0KPj4+IHRoZSBwb3NzaWJpbGl0eSBvZiByZXVzaW5nIG1lbWZkX3NlY3JldCgp
IHRvIGFsbG9jYXRlIHRoaXMgbWVtb3J5IGluIHVzZXIgdmlydHVhbA0KPj4+IGFkZHJlc3Mgc3Bh
Y2UsIG1hbmFnZSBpdCBpbiBhIFZNQSwgZmxpcHBpbmcgdGhlIHBlcm1pc3Npb25zIHdoaWxlIGtl
ZXBpbmcgdGhlDQo+Pj4gY29udHJvbCBvZiB0aGUgbWFwcGluZyBleGNsdXNpdmVseSB3aXRoIHRo
ZSBrZXJuZWwuDQo+Pj4gUmlnaHQgbm93IGl0IGlzOg0KPj4+IChhKSBQYWdlcyBub3QgYWNjZXNz
aWJsZSBieSB1c2VyIHNwYWNlIC0tIGV2ZW4gdGhvdWdoIHRoZXkgYXJlIG1hcHBlZCBpbnRvIHVz
ZXINCj4+PiAgICBzcGFjZSwgdGhlIFBURXMgYXJlIG1hcmtlZCBmb3Iga2VybmVsIHVzYWdlLg0K
Pj4gDQo+PiBBaCwgdGhhdCBpcyB0aGUgZGV0YWlsIEkgd2FzIG1pc3NpbmcsIG5vdyBJIHNlZSB3
aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIGFjaGlldmUsIHRoYW5rcyENCj4+IA0KPj4gSXQgaXMgYSBi
aXQgYXJjaGl0ZWN0dXJlIHNwZWNpZmljLCBiZWNhdXNlIC4uLiBpbWFnaW5lIGFyY2hpdGVjdHVy
ZXMgdGhhdCBoYXZlIHNlcGFyYXRlIGtlcm5lbCt1c2VyIHNwYWNlIHBhZ2UgdGFibGUgaGllcmFy
Y2hpZXMsIGFuZCBub3QgYSBzaW1wbGUgUFRFIGZsYWcgdG8gY2hhbmdlIGFjY2VzcyBwZXJtaXNz
aW9ucyBiZXR3ZWVuIGtlcm5lbC91c2VyIHNwYWNlLg0KPj4gDQo+PiBJSVJDIHMzOTAgaXMgb25l
IHN1Y2ggYXJjaGl0ZWN0dXJlIHRoYXQgdXNlcyBzZXBhcmF0ZSBwYWdlIHRhYmxlcyBmb3IgdGhl
IHVzZXItc3BhY2UgKyBrZXJuZWwtc3BhY2UgcG9ydGlvbnMuDQo+PiANCj4+PiAoYikgUGFnZXMg
YWNjZXNzaWJsZSBieSBrZXJuZWwgc3BhY2UgLS0gZXZlbiB0aG91Z2ggdGhleSBhcmUgbm90IG1h
cHBlZCBpbnRvIHRoZQ0KPj4+ICAgIGRpcmVjdCBtYXAsIHRoZSBQVEVzIGluIHV2YWRkciBhcmUg
bWFya2VkIGZvciBrZXJuZWwgdXNhZ2UuDQo+Pj4gKGMpIGNvcHlfZnJvbSAvIGNvcHlfdG8gdXNl
ciB3b24ndCBmYWlsIC0tIGJlY2F1c2UgaXQgaXMgaW4gdGhlIHVzZXIgcmFuZ2UsIGJ1dA0KPj4+
ICAgIHRoaXMgY2FuIGJlIGZpeGVkIGJ5IGFsbG9jYXRpbmcgc3BlY2lmaWMgcmFuZ2UgaW4gdXNl
ciB2YWRkciB0byB0aGlzIGZlYXR1cmUNCj4+PiAgICBhbmQgY2hlY2sgYWdhaW5zdCB0aGlzIHJh
bmdlIHRoZXJlLg0KPj4+IChkKSBUaGUgc2VjcmV0IG1lbW9yeSB2YWRkciBpcyBndWVzc2FibGUg
YnkgdGhlIG93bmVyIHByb2Nlc3MgLS0gdGhhdCBjYW4gYWxzbw0KPj4+ICAgIGJlIGZpeGVkIGJ5
IGFsbG9jYXRpbmcgYmlnZ2VyIGNodW5rIG9mIHVzZXIgdmFkZHIgZm9yIHRoaXMgZmVhdHVyZSBh
bmQNCj4+PiAgICByYW5kb21seSBwbGFjaW5nIHRoZSBzZWNyZXQgbWVtb3J5IHRoZXJlLg0KPj4+
IChlKSBNYXBwaW5nIGlzIG9mZi1saW1pdHMgdG8gdGhlIG93bmVyIHByb2Nlc3MgYnkgbWFya2lu
ZyB0aGUgVk1BIGFzIGxvY2tlZCwNCj4+PiAgICBzZWFsZWQgYW5kIHNwZWNpYWwuDQo+PiANCj4+
IE9rYXksIHNvIGluIHRoaXMgUkZDIHlvdSBhcmUganVtcGluZyB0aHJvdWdoIHF1aXRlIHNvbWUg
aG9vcHMgdG8gaGF2ZSBhIGtlcm5lbCBhbGxvY2F0aW9uIHVubWFwcGVkIGZyb20gdGhlIGRpcmVj
dCBtYXAgYnV0IG1hcHBlZCBpbnRvIGEgcGVyLXByb2Nlc3MgcGFnZSB0YWJsZSBvbmx5IGFjY2Vz
c2libGUgYnkga2VybmVsIHNwYWNlLiA6KQ0KPj4gDQo+PiBTbyB5b3UgcmVhbGx5IGRvbid0IHdh
bnQgdGhpcyBtYXBwZWQgaW50byB1c2VyIHNwYWNlIGF0IGFsbCAoY29uc2VxdWVudGx5LCBubyBH
VVAsIG5vIGFjY2Vzcywgbm8gY29weV9mcm9tX3VzZXIgLi4uKS4gSW4gdGhpcyBSRkMgaXQncyBt
YXBwZWQgYnV0IHR1cm5lZCBpbmFjY2Vzc2libGUgYnkgZmxpcHBpbmcgdGhlICJrZXJuZWwgdnMu
IHVzZXIiIHN3aXRjaC4NCj4+IA0KPj4+IE90aGVyIGFsdGVybmF0aXZlICh0aGF0IHdhcyBpbXBs
ZW1lbnRlZCBpbiB0aGUgZmlyc3Qgc3VibWlzc2lvbikgaXMgdG8gdHJhY2sgdGhvc2UNCj4+PiBh
bGxvY2F0aW9ucyBpbiBhIG5vbi1zaGFyZWQga2VybmVsIFBHRCBwZXIgcHJvY2VzcywgdGhlbiBo
YW5kbGUgY3JlYXRpbmcsIGZvcmtpbmcNCj4+PiBhbmQgY29udGV4dC1zd2l0Y2hpbmcgdGhpcyBQ
R0QuDQo+PiANCj4+IFRoYXQgc291bmRzIGxpa2UgYSBiZXR0ZXIgYXBwcm9hY2guIFNvIHdlIHdv
dWxkIHJlbW92ZSB0aGUgcGFnZXMgZnJvbSB0aGUgc2hhcmVkIGtlcm5lbCBkaXJlY3QgbWFwIGFu
ZCBtYXAgdGhlbSBpbnRvIGEgc2VwYXJhdGUga2VybmVsLXBvcnRpb24gaW4gdGhlIHBlci1NTSBw
YWdlIHRhYmxlcz8NCj4+IA0KPj4gQ2FuIHlvdSBlbnZpc2lvbiB0aGF0IHdvdWxkIGFsc28gd29y
ayB3aXRoIGFyY2hpdGVjdHVyZXMgbGlrZSBzMzkweD8gSSBhc3N1bWUgd2Ugd291bGQgbm90IG9u
bHkgbmVlZCB0aGUgcGVyLU1NIHVzZXIgc3BhY2UgcGFnZSB0YWJsZSBoaWVyYXJjaHksIGJ1dCBh
bHNvIGEgcGVyLU1NIGtlcm5lbCBzcGFjZSBwYWdlIHRhYmxlIGhpZXJhcmNoeSwgaW50byB3aGlj
aCB3ZSBhbHNvIG1hcCB0aGUgY29tbW9uL3NoYXJlZC1hbW9uZy1hbGwtcHJvY2Vzc2VzIGtlcm5l
bCBzcGFjZSBwYWdlIHRhYmxlcyAoZS5nLiwgZGlyZWN0bWFwKS4NCj4gWWVzLCB0aGF04oCZcyBh
bHNvIGFwcGxpY2FibGUgdG8gYXJtNjQuIFRoZXJl4oCZcyBjdXJyZW50bHkgbm8gc2VwYXJhdGUg
cGVyLW1tIHVzZXIgc3BhY2UgcGFnZSBoaWVyYXJjaHkgdGhlcmUuDQp0eXBvLCByZWFkIGtlcm5l
bA0KDQpUaGFua3MsDQotTW9oYW1lZA0KPj4+IFdoYXQgSSBsaWtlIGFib3V0IHRoZSBtZW1mZF9z
ZWNyZXQoKSBhcHByb2FjaCBpcyB0aGUgc2ltcGxpY2l0eSBhbmQgYmVpbmcgYXJjaA0KPj4+IGFn
bm9zdGljLCB3aGF0IEkgZG9uJ3QgbGlrZSBpcyB0aGUgaW5jcmVhc2VkIGF0dGFjayBzdXJmYWNl
IGJ5IHVzaW5nIFZNQXMgdG8NCj4+PiB0cmFjayB0aG9zZSBhbGxvY2F0aW9ucy4NCj4+IA0KPj4g
WWVzLCBidXQgbWVtZmRfc2VjcmV0KCkgd2FzIHJlYWxseSBkZXNpZ24gZm9yIHVzZXIgc3BhY2Ug
dG8gaG9sZCBzZWNyZXRzLiBCdXQgSSBjYW4gc2VlIGhvdyB5b3UgY2FtZSB0byB0aGlzIHNvbHV0
aW9uLg0KPj4gDQo+Pj4gSSdtIHRoaW5raW5nIG9mIHdvcmtpbmcgb24gYSBQb0MgdG8gaW1wbGVt
ZW50IHRoZSBmaXJzdCBhcHByb2FjaCBvZiB1c2luZyBhDQo+Pj4gbm9uLXNoYXJlZCBrZXJuZWwg
UEdEIGZvciBzZWNyZXQgbWVtb3J5IGFsbG9jYXRpb25zIG9uIGFybTY0LiBUaGlzIGluY2x1ZGVz
DQo+Pj4gYWRkaW5nIGtlcm5lbCBwYWdlIHRhYmxlIHBlciBwcm9jZXNzIHdoZXJlIGFsbCBQR0Rz
IGFyZSBzaGFyZWQgYnV0IG9uZSB3aGljaA0KPj4+IHdpbGwgYmUgdXNlZCBmb3Igc2VjcmV0IGFs
bG9jYXRpb25zIG1hcHBpbmcuIEFuZCBoYW5kbGUgdGhlIGZvcmsgJiBjb250ZXh0DQo+Pj4gc3dp
dGNoaW5nIChUVEJSMSBzd2l0Y2hpbmcoPykpIGNvcnJlY3RseSBmb3IgdGhlIHNlY3JldCBtZW1v
cnkgUEdELg0KPj4+IFdoYXQgZG8geW91IHRoaW5rPyBJJ2QgcmVhbGx5IGFwcHJlY2lhdGUgb3Bp
bmlvbnMgYW5kIHBvc3NpYmxlIHdheXMgZm9yd2FyZC4NCj4+IA0KPj4gTmFpdmUgcXVlc3Rpb246
IGRvZXMgYXJtNjQgcmF0aGVyIHJlc2VtYmxlIHRoZSBzMzkweCBtb2RlbCBvciB0aGUgeDg2LTY0
IG1vZGVsPw0KPiBhcm02NCBoYXMgc2VwYXJhdGUgcGFnZSB0YWJsZXMgZm9yIGtlcm5lbCBhbmQg
dXNlci1tb2RlLiBFeGNlcHQgZm9yIHRoZSBLUFRJIGNhc2UsIHRoZSBrZXJuZWwgcGFnZSB0YWJs
ZXMgYXJlbuKAmXQgc3dhcHBlZCBwZXItcHJvY2VzcyBhbmQgc3RheSB0aGUgc2FtZSBhbGwgdGhl
IHRpbWUuDQo+IA0KPiBUaGFua3MsDQo+IC1Nb2hhbWVkDQo+PiAtLSANCj4+IENoZWVycywNCj4+
IA0KPj4gRGF2aWQgLyBkaGlsZGVuYg0KPj4gDQo+IA0KDQoKCgpBbWF6b24gV2ViIFNlcnZpY2Vz
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVy
bGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vp
c3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1
Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


