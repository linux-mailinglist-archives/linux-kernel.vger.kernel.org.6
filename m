Return-Path: <linux-kernel+bounces-567529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66AFA68765
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438E6189B8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C92512EB;
	Wed, 19 Mar 2025 09:04:18 +0000 (UTC)
Received: from mailgw1.hygon.cn (mailgw.hygon.cn [110.188.70.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206B3F9D5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.188.70.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375058; cv=none; b=Gxd0VxRNFUlwM4zo5ODOF1rl4C/CM29MJE3hEfM3pqRh4JODERjAQUalm7WCUAZB1E3gvxNx/skXZWkbcwKbzqTdu8X5LuraFjGgaZq1JoKW8Cjey9h+BC6nm5+tAoBN40bvJMwdjAoT6Hwa0C/c73GxvdRVAFzfSMJSY9/JVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375058; c=relaxed/simple;
	bh=mlYcXNjze+YYNjgtIFk57mRNxut9+uts2vV5ZknzvRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCUVZpxKdu5TDzYS4fOPd23onikhyHyMMna+746k+/t7GXLruL9JuIsK9Ja8fC8tkp7Xdokua064p6Fiosx0/FYYcLv9zHiLznhZQYZJljBMFNyw+7z/91IxU52BWPvu6hG3vSKnSv+dS7Yq6E9Kj1k/KyQ5ZtrnCdMlAoiHAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=110.188.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id A28E0F999;
	Wed, 19 Mar 2025 17:03:44 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 0507E310FA1F;
	Wed, 19 Mar 2025 17:01:08 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Mar
 2025 17:03:49 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%6]) with mapi id
 15.02.1544.011; Wed, 19 Mar 2025 17:03:49 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "jianyong.wu@outlook.com" <jianyong.wu@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] SCHED: scatter nohz idle balance target cpus
Thread-Topic: [PATCH] SCHED: scatter nohz idle balance target cpus
Thread-Index: AQHbl61OpENeMFSo9kSeuaXOI4AsgbN5oRiAgACH+7A=
Date: Wed, 19 Mar 2025 09:03:49 +0000
Message-ID: <a056a0ec6a4646fbb4a6e1a30bc2fcab@hygon.cn>
References: <20250318022358.195154-1-wujianyong@hygon.cn>
 <CAKfTPtA+41UxOi6C2fcgZ1mjaL19rBYi5Kidc6TSYLhNt3u1mw@mail.gmail.com>
In-Reply-To: <CAKfTPtA+41UxOi6C2fcgZ1mjaL19rBYi5Kidc6TSYLhNt3u1mw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBHdWl0dG90
IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAx
OSwgMjAyNSA0OjQ2IFBNDQo+IFRvOiBKaWFueW9uZyBXdSA8d3VqaWFueW9uZ0BoeWdvbi5jbj4N
Cj4gQ2M6IG1pbmdvQHJlZGhhdC5jb207IHBldGVyekBpbmZyYWRlYWQub3JnOyBqaWFueW9uZy53
dUBvdXRsb29rLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBTQ0hFRDogc2NhdHRlciBub2h6IGlkbGUgYmFsYW5jZSB0YXJnZXQgY3B1
cw0KPiANCj4gT24gVHVlLCAxOCBNYXIgMjAyNSBhdCAwMzoyNywgSmlhbnlvbmcgV3UgPHd1amlh
bnlvbmdAaHlnb24uY24+IHdyb3RlOg0KPiA+DQo+ID4gQ3VycmVudGx5LCBjcHUgc2VsZWN0aW9u
IGxvZ2ljIGZvciBub2h6IGlkbGUgYmFsYW5jZSBsYWNrcyBoaXN0b3J5DQo+ID4gaW5mbyB0aGF0
IGxlYWRzIHRvIGNwdTAgaXMgYWx3YXlzIGNob3NlbiBpZiBpdCdzIGluIG5vaHogY3B1IG1hc2su
DQo+ID4gSXQncyBub3QgZmFpciBmb3QgdGhlIHRhc2tzIHJlc2lkZSBpbiBudW1hIG5vZGUwLiBJ
dCdzIHdvcnNlIGluIHRoZQ0KPiA+IG1hY2hpbmUgd2l0aCBsYXJnZSBjcHUgbnVtYmVyLCBub2h6
IGlkbGUgYmFsYW5jZSBtYXkgYmUgdmVyeSBoZWF2eS4NCj4gDQo+IENvdWxkIHlvdSBwcm92aWRl
IG1vcmUgZGV0YWlscyBhYm91dCB3aHkgaXQncyBub3QgZmFpciBmb3IgdGFza3MgdGhhdCByZXNp
ZGUgb24NCj4gbnVtYSBub2RlIDAgPyBjcHUwIGlzIGlkbGUgc28gaWxiIGRvZXNuJ3Qgc3RlYWwg
dGltZSB0byBvdGhlciB0YXNrcy4NCj4gDQo+IERvIHlvdSBoYXZlIGZpZ3VyZXMgb3IgdXNlIGNh
c2VzIHRvIGhpZ2hsaWdodCB0aGlzIHVuZmFpcm5lc3MgPw0KPiANCltKaWFueW9uZyBXdV0gDQpZ
ZWFoLCBoZXJlIGlzIGEgdGVzdCBjYXNlLg0KSW4gYSBzeXN0ZW0gd2l0aCBhIGxhcmdlIG51bWJl
ciBvZiBDUFVzIChpbiBteSBzY2VuYXJpbywgdGhlcmUgYXJlIDI1NiBDUFVzKSwgd2hlbiB0aGUg
ZW50aXJlIHN5c3RlbSBpcyB1bmRlciBhIGxvdyBsb2FkLCBpZiB5b3UgdHJ5IHRvIGJpbmQgdHdv
IG9yIG1vcmUgQ1BVIC0gYm91bmQgam9icyB0byBhIHNpbmdsZSBDUFUgb3RoZXIgdGhhbiBDUFUw
LCB5b3UnbGwgbm90aWNlIHRoYXQgdGhlIHNvZnRpcnEgdXRpbGl6YXRpb24gZm9yIENQVTAgY2Fu
IHJlYWNoIGFwcHJveGltYXRlbHkgMTAlLCB3aGlsZSBpdCByZW1haW5zIG5lZ2xpZ2libGUgZm9y
IG90aGVyIENQVXMuIEJ5IGNoZWNraW5nIHRoZSAvcHJvYy9zb2Z0aXJxcyBmaWxlLCBpdCBiZWNv
bWVzIGV2aWRlbnQgdGhhdCBhIHNpZ25pZmljYW50IG51bWJlciBvZiBTQ0hFRCBzb2Z0aXJxcyBh
cmUgb25seSBleGVjdXRlZCBvbiBDUFUwLg0KPiA+DQo+ID4gVG8gYWRkcmVzcyB0aGlzIGlzc3Vl
LCBhZGRpbmcgYSBtZW1iZXIgdG8gIm5vaHoiIHRvIGluZGljYXRlIHdobyBpcw0KPiA+IGNob3Nl
biBsYXN0IHRpbWUgYW5kIGNob29zZSBuZXh0IGZvciB0aGlzIHJvdW5kIG9mIG5vaHogaWRsZSBi
YWxhbmNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPHd1amlhbnlvbmdA
aHlnb24uY24+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC9zY2hlZC9mYWlyLmMgfCA5ICsrKysrKy0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQv
ZmFpci5jIGluZGV4DQo+ID4gYzc5OGQyNzk1MjQzLi5iYTY5MzBjNzllMjUgMTAwNjQ0DQo+ID4g
LS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMN
Cj4gPiBAQCAtNzE5Nyw2ICs3MTk3LDcgQEAgc3RhdGljIHN0cnVjdCB7DQo+ID4gICAgICAgICBh
dG9taWNfdCBucl9jcHVzOw0KPiA+ICAgICAgICAgaW50IGhhc19ibG9ja2VkOyAgICAgICAgICAg
ICAgICAvKiBJZGxlIENQVVMgaGFzIGJsb2NrZWQgbG9hZA0KPiAqLw0KPiA+ICAgICAgICAgaW50
IG5lZWRzX3VwZGF0ZTsgICAgICAgICAgICAgICAvKiBOZXdseSBpZGxlIENQVXMgbmVlZCB0aGVp
cg0KPiBuZXh0X2JhbGFuY2UgY29sbGF0ZWQgKi8NCj4gPiArICAgICAgIGludCBsYXN0X2NwdTsg
ICAgICAgICAgICAgICAgICAgLyogTGFzdCBjcHUgY2hvc2VuIHRvIGRvIG5vaHoNCj4gaWRsZSBi
YWxhbmNlICovDQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIG5leHRfYmFsYW5jZTsgICAgIC8q
IGluIGppZmZ5IHVuaXRzICovDQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIG5leHRfYmxvY2tl
ZDsgICAgIC8qIE5leHQgdXBkYXRlIG9mIGJsb2NrZWQgbG9hZCBpbg0KPiBqaWZmaWVzICovDQo+
ID4gIH0gbm9oeiBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ID4gQEAgLTEyMjY2LDEzICsxMjI2
NywxNSBAQCBzdGF0aWMgaW5saW5lIGludCBmaW5kX25ld19pbGIodm9pZCkNCj4gPg0KPiA+ICAg
ICAgICAgaGtfbWFzayA9IGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVfS0VSTkVMX05PSVNF
KTsNCj4gPg0KPiA+IC0gICAgICAgZm9yX2VhY2hfY3B1X2FuZChpbGJfY3B1LCBub2h6LmlkbGVf
Y3B1c19tYXNrLCBoa19tYXNrKSB7DQo+ID4gKyAgICAgICBmb3JfZWFjaF9jcHVfd3JhcChpbGJf
Y3B1LCBub2h6LmlkbGVfY3B1c19tYXNrLCBub2h6Lmxhc3RfY3B1DQo+ID4gKyArIDEpIHsNCj4g
Pg0KPiA+IC0gICAgICAgICAgICAgICBpZiAoaWxiX2NwdSA9PSBzbXBfcHJvY2Vzc29yX2lkKCkp
DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChpbGJfY3B1ID09IHNtcF9wcm9jZXNzb3JfaWQoKSB8
fA0KPiA+ICsgIWNwdW1hc2tfdGVzdF9jcHUoaWxiX2NwdSwgaGtfbWFzaykpDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgaWYg
KGlkbGVfY3B1KGlsYl9jcHUpKQ0KPiA+ICsgICAgICAgICAgICAgICBpZiAoaWRsZV9jcHUoaWxi
X2NwdSkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBub2h6Lmxhc3RfY3B1ID0gaWxi
X2NwdTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gaWxiX2NwdTsNCj4gPiAr
ICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICByZXR1cm4g
LTE7DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0K

