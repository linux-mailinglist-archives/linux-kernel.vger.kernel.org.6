Return-Path: <linux-kernel+bounces-316237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD996CCEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE18285A36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB813D2BB;
	Thu,  5 Sep 2024 03:05:15 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3F25634;
	Thu,  5 Sep 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505515; cv=none; b=SVdTEjvJ+ElXkA1pvz/nD9Q2oPtGRGBWy3mtLE7NO15rbp86kFV17TZ9h0PP5rw4mr3p41N8vlvldIhD+Ehq2NKU6+x9uXlHI+wMrUbIjVlw2s3BA7n3QvF9J3OK5DvNJdVGjrliQfmVPnxgWhkMpJmBLC4Tfn2aqpO6xKaXqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505515; c=relaxed/simple;
	bh=5/0dQs5nHT7aU+wiTJCNmQZy8BlOE3HVXAvpG+REYsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sxWK2NQAddSMFe/wcJ67NrPQhEbmAJ0rz8MdZKfC341yYFm4RcjP3V1S1HS/b1dOnSRrik7uLFbCMXKMD/3/VpHu2vCsIzOhhkHEfgANpae4FIpoSBt4+eAyhqF8cqmQL3CEBTtYQfOcGzu4wiC2zbIbpkdajuZBxLC1pgNdG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: HjVoPGokRDi945fTJbKpIw==
X-CSE-MsgGUID: BAX83Nz6QKyZQJ4nF74JCQ==
X-IronPort-AV: E=Sophos;i="6.10,203,1719849600"; 
   d="scan'208";a="121174424"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Bart Van Assche <bvanassche@acm.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5pa557+U?= <fangxiang@xiaomi.com>, =?utf-8?B?546L6L6J?=
	<wanghui33@xiaomi.com>
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHa/fgOh/cV01vbcESyzBPikRppQrJFy1gAgACpkoCAAOcQgIAAos8A
Date: Thu, 5 Sep 2024 03:05:09 +0000
Message-ID: <3ef65dbf-6a75-45f5-b9e4-af2d6603c581@xiaomi.com>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
 <f669709a-b8e6-4c76-a75c-f3e7828e09f2@xiaomi.com>
 <a2cb0302-b333-4cea-aaea-4a7bae7024a9@acm.org>
In-Reply-To: <a2cb0302-b333-4cea-aaea-4a7bae7024a9@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B412BFE939FE74DB44A197FA52D31FA@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzUgMToyMiwgQmFydCBWYW4gQXNzY2hlwqB3cm90ZToNCj4gT24gOS8zLzI0IDg6
MzUgUE0sIOeroOi+iSB3cm90ZToNCj4+IERvZXMgc2V0IHJxX2FmZmluaXR5IHRvIDIgbWVhbiBR
VUVVRV9GTEFHX1NBTUVfQ09NUD8NCj4NCj4gRnJvbSBibG9jay9ibGstc3lzZnMuYzoNCj4NCj4g
wqDCoMKgwqDCoMKgIGlmICh2YWwgPT0gMikgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1NBTUVfQ09NUCwgcSk7DQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfU0FN
RV9GT1JDRSwgcSk7DQo+IMKgwqDCoMKgwqDCoCB9DQo+DQo+PiBUaGlzIHNlZW1zIHRvIGRldGVy
bWluZSBvbiB3aGljaCBjb3JlIHRoZSBjdXJyZW50IHJlcXVlc3QgaXMNCj4+IGNvbXBsZXRlZCwg
cmF0aGVyIHRoYW4gaW4gdGhlIGludGVycnVwdCB0b3Agb3IgYm90dG9tIGhhbGY/DQo+DQo+IFRo
YXQncyBjb3JyZWN0LiBJIHN1Z2dlc3RlZCB0aGlzIGJlY2F1c2UgSSB3YXMgd29uZGVyaW5nIHdo
ZXRoZXINCj4gc3ByZWFkaW5nIHRoZSBJL08gY29tcGxldGlvbiB3b3JrbG9hZCBvdmVyIG1vcmUg
Q1BVIGNvcmVzIHdvdWxkIGhlbHA/DQo+DQo+IFRoYW5rcywNCj4NCj4gQmFydC4NCj4NCmhpIEJh
cnQsDQoNCkluY3JlYXNpbmcgdGhlIENQVSBmcmVxdWVuY3kgb3IgZGlyZWN0bHkgYmluZGluZyB0
aGUgaW50ZXJydXB0IHRvIHRoZQ0KYmlnIGNvcmUgcHJvY2Vzc2luZyB3aWxsIGRlZmluaXRlbHkg
aGVscCB0aGUgZW5kIGlvIHByb2Nlc3NpbmcgZGVsYXksDQpkZXBlbmRpbmcgb24gdGhlIHN5c3Rl
bSdzIHJlcXVpcmVtZW50cyBmb3IgSU8gcmVzcG9uc2UgZGVsYXkuDQoNCkJ1dCBpdCBkb2VzIG5v
dCBzZWVtIHRvIGNvbmZsaWN0IHdpdGggdGhpcyBtb2RpZmljYXRpb24gdG8gcHV0IHRoZQ0KdGlt
ZS1jb25zdW1pbmcgb3BlcmF0aW9uIGluIHRoZSBsb3dlciBoYWxmLg0KDQoNClRoYW5rcw0KWmhh
bmcNCg0KDQoNCg==

