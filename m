Return-Path: <linux-kernel+bounces-293886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C695862D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712A3B25F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3F18EFC4;
	Tue, 20 Aug 2024 11:54:11 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260F18E74B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154851; cv=none; b=UpXSaqauzfSiATG0wb+11pgz7n9ZSChl92Dbj1L5/X8LCYASgcYMK/25nbf1CHdp/wrSce0/P18IdJYBxZYjdc8qMExEmdIiqYU38YS8sh1UQBcifyNhKAUhT1f+WnfAAwu4MMRHKRfGtptwEFjIBj9xZ5F61tEbvgLk9oOHHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154851; c=relaxed/simple;
	bh=2VjylQ+L2bQQ+nk0Wof9mdfQY5qnbHyO48si4LsoWrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aHRc/FXZ23E4aLJ8s45P00z6yZSVv3ns23j5kL3/9ldNg7ttIqfli8ohdYRz5E2XlabhflpM8D3gkX88cro8iiZtakUWV3s4cL/r88C9bVPNf0vs05slVoHeXCtmy2xwu/xj7cuDCqHkawZ4SXZ9DF9/bChLAyTEWpnu10lGHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Wp7Bh3BmmzYl50L;
	Tue, 20 Aug 2024 19:53:00 +0800 (CST)
Received: from a014.hihonor.com (10.68.16.227) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 19:54:00 +0800
Received: from a007.hihonor.com (10.68.22.31) by a014.hihonor.com
 (10.68.16.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 19:53:59 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Tue, 20 Aug 2024 19:53:59 +0800
From: gaoxu <gaoxu2@honor.com>
To: Barry Song <21cnbao@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
	<fengbaopeng@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG1tOiBhZGQgbGF6eWZyZWUgZm9saW8gdG8g?=
 =?utf-8?Q?lru_tail?=
Thread-Topic: [PATCH v2] mm: add lazyfree folio to lru tail
Thread-Index: Adrvp/sHXyayf1r5TQG6pnGY8/qB0AC/kX6AABOpIwA=
Date: Tue, 20 Aug 2024 11:53:59 +0000
Message-ID: <974d9d6c3b5e4848a32b930732366084@honor.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
 <CAGsJ_4xTW5y4O6BoVuXKk=awhoiZV0zitPYYbfsX1pmqZgY9WQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xTW5y4O6BoVuXKk=awhoiZV0zitPYYbfsX1pmqZgY9WQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gT24gRnJpLCBBdWcgMTYsIDIwMjQgYXQgNzo0OOKAr1BNIGdhb3h1IDxnYW94dTJAaG9u
b3IuY29tPiB3cm90ZToNCj4gPg0KPiA+IFJlcGxhY2UgbHJ1dmVjX2FkZF9mb2xpbyB3aXRoIGxy
dXZlY19hZGRfZm9saW9fdGFpbCBpbiB0aGUgbHJ1X2xhenlmcmVlX2ZuOg0KPiA+IDEuIFRoZSBs
YXp5LWZyZWUgZm9saW8gaXMgYWRkZWQgdG8gdGhlIExSVV9JTkFDVElWRV9GSUxFIGxpc3QuIElm
IGl0J3MNCj4gPiAgICBtb3ZlZCB0byB0aGUgTFJVIHRhaWwsIGl0IGFsbG93cyBmb3IgZmFzdGVy
IHJlbGVhc2UgbGF6eS1mcmVlIGZvbGlvIGFuZA0KPiA+ICAgIHJlZHVjZXMgdGhlIGltcGFjdCBv
biBmaWxlIHJlZmF1bHQuDQo+ID4gMi4gV2hlbiBtZ2xydSBpcyBlbmFibGVkLCB0aGUgbGF6eS1m
cmVlIGZvbGlvIGlzIHJlY2xhaW1hYmxlZCBhbmQgc2hvdWxkIGJlDQo+ID4gICAgYWRkZWQgdXNp
bmcgbHJ1X2dlbl9hZGRfZm9saW8obHJ1dmVjLCBmb2xpbywgdHJ1ZSkgaW5zdGVhZCBvZg0KPiA+
ICAgIGxydV9nZW5fYWRkX2ZvbGlvKGxydXZlYywgZm9saW8sIGZhbHNlKSBmb3IgYWRkaW5nIHRv
IGdlbi4NCj4gPg0KPiA+IFdpdGggdGhlIGNoYW5nZSBpbiBwbGFjZSwgd29ya2luZ3NldF9yZWZh
dWx0X2ZpbGUgaXMgcmVkdWNlZCBieSAzMyUgaW4NCj4gPiB0aGUgY29udGludW91cyBzdGFydHVw
IHRlc3Rpbmcgb2YgdGhlIGFwcGxpY2F0aW9ucyBpbiB0aGUgQW5kcm9pZCBzeXN0ZW0uDQo+ID4N
Cj4gDQo+IEhpIEdhbywNCj4gDQo+IEp1c3QgY3VyaW91cywgaW4gd2hpY2ggc2NlbmFyaW8gYXJl
IHdlIGZyZXF1ZW50bHkgY2FsbGluZyBNQURWX0ZSRUUgYnV0IG5vdA0KPiBNQURWX0RPTlRORUVE
Pw0KSGkgU29uZywNCiBBbmRyb2lkIEFSVCB1c2UgTUFEVl9GUkVFLCBwbGVhc2UgcmVmZXIgdG8g
dGhlIGZvbGxvd2luZyBsaW5rLg0KIGh0dHBzOi8vYW5kcm9pZC1yZXZpZXcuZ29vZ2xlc291cmNl
LmNvbS9jL3BsYXRmb3JtL2FydC8rLzI2MzMxMzINCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogZ2Fv
IHh1IDxnYW94dTJAaGlob25vci5jb20+DQo+ID4gLS0tDQo+ID4gVjEgLT4gVjI6IEJhc2VkIG9u
IHRoZSBsYXRlc3QgbW0tdW5zdGFibGUsIHJlY3JlYXRlIHRoZSBwYXRjaC4NCj4gPg0KPiA+ICBt
bS9zd2FwLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3N3YXAuYyBiL21tL3N3YXAuYw0K
PiA+IGluZGV4IDZiODM4OTg2ZC4uZTBkYmZjOTgzIDEwMDY0NA0KPiA+IC0tLSBhL21tL3N3YXAu
Yw0KPiA+ICsrKyBiL21tL3N3YXAuYw0KPiA+IEBAIC02NDEsNyArNjQxLDcgQEAgc3RhdGljIHZv
aWQgbHJ1X2xhenlmcmVlKHN0cnVjdCBscnV2ZWMgKmxydXZlYywgc3RydWN0DQo+IGZvbGlvICpm
b2xpbykNCj4gPiAgICAgICAgICAqIGFub255bW91cyBmb2xpb3MNCj4gPiAgICAgICAgICAqLw0K
PiA+ICAgICAgICAgZm9saW9fY2xlYXJfc3dhcGJhY2tlZChmb2xpbyk7DQo+ID4gLSAgICAgICBs
cnV2ZWNfYWRkX2ZvbGlvKGxydXZlYywgZm9saW8pOw0KPiA+ICsgICAgICAgbHJ1dmVjX2FkZF9m
b2xpb190YWlsKGxydXZlYywgZm9saW8pOw0KPiA+DQo+ID4gICAgICAgICBfX2NvdW50X3ZtX2V2
ZW50cyhQR0xBWllGUkVFLCBucl9wYWdlcyk7DQo+ID4gICAgICAgICBfX2NvdW50X21lbWNnX2V2
ZW50cyhscnV2ZWNfbWVtY2cobHJ1dmVjKSwgUEdMQVpZRlJFRSwNCj4gPiBucl9wYWdlcyk7DQo+
ID4gLS0NCj4gPiAyLjE3LjENCg==

