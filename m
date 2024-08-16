Return-Path: <linux-kernel+bounces-288810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394D953F04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4091F24108
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433C1EB31;
	Fri, 16 Aug 2024 01:41:49 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0F1DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772509; cv=none; b=BC9C7kQtltffn9o8IUasVxFMFNzWXXLS9tTh9p3SFd0frUnCBPbOQiSCmQBS6V27tt0YbInoAftCx0rl5YH+oiMxm1k54Whnu7Fasf16Xkk/G20tb4Il9k4pSFw7xiRZ8uEZa699/GjGV1/u3v3qSFiqroFE25ZYbQGTNvI9qCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772509; c=relaxed/simple;
	bh=cIFEptHDKhWbRMlTceUW9tJyF1zOrDqmgxDJ9GRJxmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYeTXsDe8LwY5ivBQ5V5ySchwLG+w/0T8Ex3D+/lnWY/0IynIJnZ/OrKOBxq+2wGsz6ZW5hLtjHbhyPV8suFhKqcOoJnPhpuU4A7Jvy7HQ67v/lr6rJhw2dZip0qspMg8sBnL+BtaP0rzFh1RPwLwHdjERCOvux5aX5k2QPXNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4WlPmY4vNTzYlK9K;
	Fri, 16 Aug 2024 09:39:25 +0800 (CST)
Received: from a009.hihonor.com (10.68.30.244) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 09:41:44 +0800
Received: from a007.hihonor.com (10.68.22.31) by a009.hihonor.com
 (10.68.30.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 09:41:43 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Fri, 16 Aug 2024 09:41:43 +0800
From: gaoxu <gaoxu2@honor.com>
To: Yu Zhao <yuzhao@google.com>, Kalesh Singh <kaleshsingh@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
	<fengbaopeng@honor.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOiBhZGQgbGF6eWZyZWUgZm9saW8gdG8gbHJ1?=
 =?utf-8?Q?_tail?=
Thread-Topic: [PATCH] mm: add lazyfree folio to lru tail
Thread-Index: AdrvDo5mhFpHwjY+TGSie/L6+cGQzf//2ZUA//7+IPA=
Date: Fri, 16 Aug 2024 01:41:43 +0000
Message-ID: <86738d19f97843efbfa0f83a2d85115a@honor.com>
References: <37bbf461e81342a7b5798923b783e349@honor.com>
 <CAOUHufZzmUU6YxOfQ7-v6AMj29uoMOLKMz0RWk9MRA4DkDSXAQ@mail.gmail.com>
In-Reply-To: <CAOUHufZzmUU6YxOfQ7-v6AMj29uoMOLKMz0RWk9MRA4DkDSXAQ@mail.gmail.com>
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

PiANCj4gT24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgNjozM+KAr0FNIGdhb3h1IDxnYW94dTJAaG9u
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
dWx0X2ZpbGUgaXMgcmVkdWNlZCBieSAzMyUgaW4gdGhlDQo+ID4gY29udGludW91cyBzdGFydHVw
IHRlc3Rpbmcgb2YgdGhlIGFwcGxpY2F0aW9ucyBpbiB0aGUgQW5kcm9pZCBzeXN0ZW0uDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBnYW8geHUgPGdhb3h1MkBoaWhvbm9yLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgbW0vc3dhcC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9tbS9zd2FwLmMgYi9tbS9z
d2FwLmMNCj4gPiBpbmRleCA2Nzc4NmNiNzcuLmVkNDk2NDNlYyAxMDA2NDQNCj4gPiAtLS0gYS9t
bS9zd2FwLmMNCj4gPiArKysgYi9tbS9zd2FwLmMNCj4gPiBAQCAtNjM1LDcgKzYzNSw3IEBAIHN0
YXRpYyB2b2lkIGxydV9sYXp5ZnJlZV9mbihzdHJ1Y3QgbHJ1dmVjICpscnV2ZWMsIHN0cnVjdA0K
PiBmb2xpbyAqZm9saW8pDQo+IA0KPiBQbGVhc2Ugd29yayBhZ2FpbnN0IHRoZSBsYXRlc3QgbW0t
dW5zdGFibGUuDQpUaGlzIHdhcyBteSBtaXN0YWtlLiBUaGFuayB5b3UgZm9yIHRoZSByZW1pbmRl
ci4NCkkgd2lsbCByZXNlbmQgdGhlIHBhdGNoIGJhc2VkIG9uIHRoZSBtbS11bnN0YWJsZSBicmFu
Y2gNCj4gDQo+ID4gICAgICAgICAgICAgICAgICAqIGFub255bW91cyBmb2xpb3MNCj4gPiAgICAg
ICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICAgIGZvbGlvX2NsZWFyX3N3YXBiYWNr
ZWQoZm9saW8pOw0KPiA+IC0gICAgICAgICAgICAgICBscnV2ZWNfYWRkX2ZvbGlvKGxydXZlYywg
Zm9saW8pOw0KPiA+ICsgICAgICAgICAgICAgICBscnV2ZWNfYWRkX2ZvbGlvX3RhaWwobHJ1dmVj
LCBmb2xpbyk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgX19jb3VudF92bV9ldmVudHMoUEdM
QVpZRlJFRSwgbnJfcGFnZXMpOw0KPiA+ICAgICAgICAgICAgICAgICBfX2NvdW50X21lbWNnX2V2
ZW50cyhscnV2ZWNfbWVtY2cobHJ1dmVjKSwNCj4gUEdMQVpZRlJFRSwNCj4gDQo+IEthbGVzaCBo
YXMgYmVlbiB3b3JraW5nIG9uIHNvbWV0aGluZyBzaW1pbGFyIGZvciBscnVfZGVhY3RpdmF0ZSgp
LCBhbmQNCj4gaGUgY2FuIGhlbHAgdGVzdCBhbmQgcmV2aWV3IHRoaXMgcGF0Y2guDQo=

