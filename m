Return-Path: <linux-kernel+bounces-567648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4214A688AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107C78875CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20D24EF61;
	Wed, 19 Mar 2025 09:42:51 +0000 (UTC)
Received: from mailgw1.hygon.cn (mailgw.hygon.cn [110.188.70.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2E255E2A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.188.70.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377371; cv=none; b=DwDq8vBxFAGBdxl5HJ7rDkQ7bMY7wHojT1C5E+VcFU5+XQtosC4Sj6U7cdOldkfywY9Kp6Bj3Vrpt9dUjbZuRzLRDZvP84CfwSPkYnqykhw+Xo3jcILM9qMltIFSXIAqAJb3vQur4JEJiau7I3AeuA9o8YN3JUiNqiiI1SN5RKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377371; c=relaxed/simple;
	bh=6BGiOveuSDwXqHV9aSSF62cibXg2V/4/hqnFK9kRz00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIz8/ZiMLeBVdUUjhVOhUD+FpEwNqbXZfw8u1sFITUYPP1vExE3vQ88HaEBnZsSkNFRcYQ1rGDdFVYYBRvvi+RSnuhFbhL938dVfZYGDi6iMaeO6xRx0FkF4A1+4O8xgOYsUKemMlbPXWq6cwSs1VYWq9UvRa7e3yQ/wuDScOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=110.188.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 6B08AF990;
	Wed, 19 Mar 2025 17:42:23 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id CF9CC310FA1F;
	Wed, 19 Mar 2025 17:39:46 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Mar
 2025 17:42:28 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%6]) with mapi id
 15.02.1544.011; Wed, 19 Mar 2025 17:42:28 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "jianyong.wu@outlook.com" <jianyong.wu@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] SCHED: scatter nohz idle balance target cpus
Thread-Topic: [PATCH] SCHED: scatter nohz idle balance target cpus
Thread-Index: AQHbl61OpENeMFSo9kSeuaXOI4AsgbN5oRiAgACH+7D//4NugIAAiHww
Date: Wed, 19 Mar 2025 09:42:28 +0000
Message-ID: <31ff4ffeb1f9448d8044f707f856c046@hygon.cn>
References: <20250318022358.195154-1-wujianyong@hygon.cn>
 <CAKfTPtA+41UxOi6C2fcgZ1mjaL19rBYi5Kidc6TSYLhNt3u1mw@mail.gmail.com>
 <a056a0ec6a4646fbb4a6e1a30bc2fcab@hygon.cn>
 <CAKfTPtAZ_unLKjg5rxDOonrRdz3-4fqV6uEyd3eGLT5SFEjdOA@mail.gmail.com>
In-Reply-To: <CAKfTPtAZ_unLKjg5rxDOonrRdz3-4fqV6uEyd3eGLT5SFEjdOA@mail.gmail.com>
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
OSwgMjAyNSA1OjI2IFBNDQo+IFRvOiBKaWFueW9uZyBXdSA8d3VqaWFueW9uZ0BoeWdvbi5jbj4N
Cj4gQ2M6IG1pbmdvQHJlZGhhdC5jb207IHBldGVyekBpbmZyYWRlYWQub3JnOyBqaWFueW9uZy53
dUBvdXRsb29rLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBTQ0hFRDogc2NhdHRlciBub2h6IGlkbGUgYmFsYW5jZSB0YXJnZXQgY3B1
cw0KPiANCj4gT24gV2VkLCAxOSBNYXIgMjAyNSBhdCAxMDowMywgSmlhbnlvbmcgV3UgPHd1amlh
bnlvbmdAaHlnb24uY24+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0
dG90QGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE5LCAyMDI1IDQ6
NDYgUE0NCj4gPiA+IFRvOiBKaWFueW9uZyBXdSA8d3VqaWFueW9uZ0BoeWdvbi5jbj4NCj4gPiA+
IENjOiBtaW5nb0ByZWRoYXQuY29tOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgamlhbnlvbmcud3VA
b3V0bG9vay5jb207DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBTQ0hFRDogc2NhdHRlciBub2h6IGlkbGUgYmFsYW5jZSB0YXJn
ZXQgY3B1cw0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMTggTWFyIDIwMjUgYXQgMDM6MjcsIEppYW55
b25nIFd1IDx3dWppYW55b25nQGh5Z29uLmNuPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gQ3Vy
cmVudGx5LCBjcHUgc2VsZWN0aW9uIGxvZ2ljIGZvciBub2h6IGlkbGUgYmFsYW5jZSBsYWNrcyBo
aXN0b3J5DQo+ID4gPiA+IGluZm8gdGhhdCBsZWFkcyB0byBjcHUwIGlzIGFsd2F5cyBjaG9zZW4g
aWYgaXQncyBpbiBub2h6IGNwdSBtYXNrLg0KPiA+ID4gPiBJdCdzIG5vdCBmYWlyIGZvdCB0aGUg
dGFza3MgcmVzaWRlIGluIG51bWEgbm9kZTAuIEl0J3Mgd29yc2UgaW4NCj4gPiA+ID4gdGhlIG1h
Y2hpbmUgd2l0aCBsYXJnZSBjcHUgbnVtYmVyLCBub2h6IGlkbGUgYmFsYW5jZSBtYXkgYmUgdmVy
eSBoZWF2eS4NCj4gPiA+DQo+ID4gPiBDb3VsZCB5b3UgcHJvdmlkZSBtb3JlIGRldGFpbHMgYWJv
dXQgd2h5IGl0J3Mgbm90IGZhaXIgZm9yIHRhc2tzDQo+ID4gPiB0aGF0IHJlc2lkZSBvbiBudW1h
IG5vZGUgMCA/IGNwdTAgaXMgaWRsZSBzbyBpbGIgZG9lc24ndCBzdGVhbCB0aW1lIHRvIG90aGVy
DQo+IHRhc2tzLg0KPiA+ID4NCj4gPiA+IERvIHlvdSBoYXZlIGZpZ3VyZXMgb3IgdXNlIGNhc2Vz
IHRvIGhpZ2hsaWdodCB0aGlzIHVuZmFpcm5lc3MgPw0KPiA+ID4NCj4gPiBbSmlhbnlvbmcgV3Vd
DQo+ID4gWWVhaCwgaGVyZSBpcyBhIHRlc3QgY2FzZS4NCj4gPiBJbiBhIHN5c3RlbSB3aXRoIGEg
bGFyZ2UgbnVtYmVyIG9mIENQVXMgKGluIG15IHNjZW5hcmlvLCB0aGVyZSBhcmUgMjU2IENQVXMp
LA0KPiB3aGVuIHRoZSBlbnRpcmUgc3lzdGVtIGlzIHVuZGVyIGEgbG93IGxvYWQsIGlmIHlvdSB0
cnkgdG8gYmluZCB0d28gb3IgbW9yZSBDUFUgLQ0KPiBib3VuZCBqb2JzIHRvIGEgc2luZ2xlIENQ
VSBvdGhlciB0aGFuIENQVTAsIHlvdSdsbCBub3RpY2UgdGhhdCB0aGUgc29mdGlycQ0KPiB1dGls
aXphdGlvbiBmb3IgQ1BVMCBjYW4gcmVhY2ggYXBwcm94aW1hdGVseSAxMCUsIHdoaWxlIGl0IHJl
bWFpbnMgbmVnbGlnaWJsZSBmb3INCj4gb3RoZXIgQ1BVcy4gQnkgY2hlY2tpbmcgdGhlIC9wcm9j
L3NvZnRpcnFzIGZpbGUsIGl0IGJlY29tZXMgZXZpZGVudCB0aGF0IGENCj4gc2lnbmlmaWNhbnQg
bnVtYmVyIG9mIFNDSEVEIHNvZnRpcnFzIGFyZSBvbmx5IGV4ZWN1dGVkIG9uIENQVTAuDQo+IA0K
PiB5ZXMsIGJ1dCB0aGlzIDEwJSBvZiBzb2Z0aXJxIHRpbWUgd291bGQgaGF2ZSBiZWVuIGlkbGUg
dGltZSBvdGhlcndpc2Ugc28gd2h5DQo+IHNob3VsZCB3ZSBjYXJlID8NCj4gDQpbSmlhbnlvbmcg
V3VdIA0KSG93ZXZlciwgdGhpcyB2YWx1ZSBpcyBwcm9wb3J0aW9uYWwgdG8gdGhlIG51bWJlciBv
ZiBDUFVzLiBJbiB0aGUgZXZlbnQgdGhhdCB0YXNrcyBhcmUgc2NoZWR1bGVkIHRvIENQVTAsIGRl
bGF5cyB3aWxsIG9jY3VyLg0KIA0KPiBBdCB0aGUgb3Bwb3NpdGUsIGlmIGFsbCB5b3VyIGNwdXMg
YXJlIGJ1c3ksIHRoZW4gY3B1MCB3aWxsIGRvIHRoZSBidXN5IGxvYWQgYmFsYW5jZQ0KPiBvZiBw
YXJlbnRzIHNjaGVkIGRvbWFpbiBsZXZlbCB3aGVyZWFzIG90aGVyIGNwdXMgd2lsbCBub3QgYW5k
IHRoaXMgdGltZSBpcyBzdG9sZW4NCj4gdG8gdGhlIHRhc2sgcnVubmluZyBvbiBDUFUwIHdoaWNo
IGNvdWxkIGJlIHVuZmFpciBjb21wYXJlZCB0byB0YXNrIHJ1bm5pbmcgb24NCj4gb3RoZXIgQ1BV
Uw0KPiANCltKaWFueW9uZyBXdV0gDQpZZWFoLiBEbyB5b3UgdGhpbmsgdGhpcyBwYXRjaCBjYW4g
bWl0aWdhdGUgdGhpcz8NCj4gDQo+ID4gPiA+DQo+ID4gPiA+IFRvIGFkZHJlc3MgdGhpcyBpc3N1
ZSwgYWRkaW5nIGEgbWVtYmVyIHRvICJub2h6IiB0byBpbmRpY2F0ZSB3aG8NCj4gPiA+ID4gaXMg
Y2hvc2VuIGxhc3QgdGltZSBhbmQgY2hvb3NlIG5leHQgZm9yIHRoaXMgcm91bmQgb2Ygbm9oeiBp
ZGxlIGJhbGFuY2UuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEppYW55b25nIFd1
IDx3dWppYW55b25nQGh5Z29uLmNuPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGtlcm5lbC9zY2hl
ZC9mYWlyLmMgfCA5ICsrKysrKy0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jIGluZGV4DQo+ID4gPiA+IGM3
OThkMjc5NTI0My4uYmE2OTMwYzc5ZTI1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9rZXJuZWwvc2No
ZWQvZmFpci5jDQo+ID4gPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiA+ID4gQEAg
LTcxOTcsNiArNzE5Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgew0KPiA+ID4gPiAgICAgICAgIGF0b21p
Y190IG5yX2NwdXM7DQo+ID4gPiA+ICAgICAgICAgaW50IGhhc19ibG9ja2VkOyAgICAgICAgICAg
ICAgICAvKiBJZGxlIENQVVMgaGFzIGJsb2NrZWQNCj4gbG9hZA0KPiA+ID4gKi8NCj4gPiA+ID4g
ICAgICAgICBpbnQgbmVlZHNfdXBkYXRlOyAgICAgICAgICAgICAgIC8qIE5ld2x5IGlkbGUgQ1BV
cyBuZWVkDQo+IHRoZWlyDQo+ID4gPiBuZXh0X2JhbGFuY2UgY29sbGF0ZWQgKi8NCj4gPiA+ID4g
KyAgICAgICBpbnQgbGFzdF9jcHU7ICAgICAgICAgICAgICAgICAgIC8qIExhc3QgY3B1IGNob3Nl
biB0byBkbw0KPiBub2h6DQo+ID4gPiBpZGxlIGJhbGFuY2UgKi8NCj4gPiA+ID4gICAgICAgICB1
bnNpZ25lZCBsb25nIG5leHRfYmFsYW5jZTsgICAgIC8qIGluIGppZmZ5IHVuaXRzICovDQo+ID4g
PiA+ICAgICAgICAgdW5zaWduZWQgbG9uZyBuZXh0X2Jsb2NrZWQ7ICAgICAvKiBOZXh0IHVwZGF0
ZSBvZiBibG9ja2VkDQo+IGxvYWQgaW4NCj4gPiA+IGppZmZpZXMgKi8NCj4gPiA+ID4gIH0gbm9o
eiBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ID4gPiA+IEBAIC0xMjI2NiwxMyArMTIyNjcsMTUg
QEAgc3RhdGljIGlubGluZSBpbnQgZmluZF9uZXdfaWxiKHZvaWQpDQo+ID4gPiA+DQo+ID4gPiA+
ICAgICAgICAgaGtfbWFzayA9IGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVfS0VSTkVMX05P
SVNFKTsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICBmb3JfZWFjaF9jcHVfYW5kKGlsYl9jcHUs
IG5vaHouaWRsZV9jcHVzX21hc2ssIGhrX21hc2spIHsNCj4gPiA+ID4gKyAgICAgICBmb3JfZWFj
aF9jcHVfd3JhcChpbGJfY3B1LCBub2h6LmlkbGVfY3B1c19tYXNrLA0KPiA+ID4gPiArIG5vaHou
bGFzdF9jcHUNCj4gPiA+ID4gKyArIDEpIHsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICAgICAg
ICAgIGlmIChpbGJfY3B1ID09IHNtcF9wcm9jZXNzb3JfaWQoKSkNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgIGlmIChpbGJfY3B1ID09IHNtcF9wcm9jZXNzb3JfaWQoKSB8fA0KPiA+ID4gPiArICFj
cHVtYXNrX3Rlc3RfY3B1KGlsYl9jcHUsIGhrX21hc2spKQ0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICAgICAgICAgIGlm
IChpZGxlX2NwdShpbGJfY3B1KSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChpZGxlX2Nw
dShpbGJfY3B1KSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBub2h6Lmxhc3Rf
Y3B1ID0gaWxiX2NwdTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGls
Yl9jcHU7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+
ID4gPg0KPiA+ID4gPiAgICAgICAgIHJldHVybiAtMTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi40
My4wDQo+ID4gPiA+DQo=

