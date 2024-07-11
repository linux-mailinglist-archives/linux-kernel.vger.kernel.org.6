Return-Path: <linux-kernel+bounces-248876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20E92E309
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC4281749
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42A6156F4C;
	Thu, 11 Jul 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O8BeM2Hg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3E156C40
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688630; cv=none; b=DPQCm5HzvPf7qFY0khexCCBFUjQYizPhbVwnjCpDdDYOleM7XHvw7nhMvw2u8WrM5DSUR0C47pzHfpwXV90ia+cm4iK3k6lrNZYUerqNvdW1L1LAytkLJOCNxPU0LEDb74R37ed6Ln3MFVi5cXBrh31r6/1OL2rZDweT5yRVFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688630; c=relaxed/simple;
	bh=WEDuDSNQ9m/uB5n4fvxunG5m+kS+rSCd6kNLddKcIHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPmzs7qLgHPgnVAnZtkTD4YD+4mK1Kk4F1pKTbkJI9kc8vWw6IZISDO5tTPvclzxrsvwjR9mvHIVAd5CR3giCbt8rbCb/vmySt5N9l7+0DKicj8piB6HXo2fyl6rtgZC3DgyhDPWsHYxOS17sLyaGGAXCNOWmlcsmNFbtLHPGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O8BeM2Hg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46B92jsk115679;
	Thu, 11 Jul 2024 04:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720688565;
	bh=WEDuDSNQ9m/uB5n4fvxunG5m+kS+rSCd6kNLddKcIHw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=O8BeM2Hg2G8MwZM7aIRPeymEOlngamRzyN5QoQvLfFuqgl/5cnaSjsZ7hqhGrNUZq
	 jBm8Y2xmpyGhzhvc5SZcDD2vcgHPeubL3ldj/NMS2JQCxJicfixoDcIczbM7vAPXCt
	 yIFS3YZcp+yBxCG97xtlewOFZvE9v8Lgaq40HNME=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46B92jmH102157
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 04:02:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 04:02:45 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Thu, 11 Jul 2024 04:02:45 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Simon Trimmer <simont@opensource.cirrus.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "Ding,
 Shenghao" <shenghao-ding@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "Hampiholi, Vallabha"
	<v-hampiholi@ti.com>,
        "P O, Vijeth" <v-po@ti.com>,
        "Holalu Yogendra,
 Niranjan" <niranjan.hy@ti.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de" <tiwai@suse.de>
Subject: Re: [EXTERNAL] RE: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI
 driver
Thread-Topic: [EXTERNAL] RE: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI
 driver
Thread-Index: AQHavhA+LICoIavOaEyXrK6TRE4VxrHNtVUAgCOvEuk=
Date: Thu, 11 Jul 2024 09:02:45 +0000
Message-ID: <9facad7a2baa414baf2989ad6ee1cd0e@ti.com>
References: <20240614040554.610-1-baojun.xu@ti.com>,<000701dac16e$d31b8390$79528ab0$@opensource.cirrus.com>
In-Reply-To: <000701dac16e$d31b8390$79528ab0$@opensource.cirrus.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24sDQoNCkFuc3dlciBpbiBsaW5lLg0KDQpCZXN0IFJlZ2FyZHMNCkppbQ0KDQo+IEZy
b206IFNpbW9uIFRyaW1tZXIgPHNpbW9udEBvcGVuc291cmNlLmNpcnJ1cy5jb20+DQo+IFNlbnQ6
IDE4IEp1bmUgMjAyNCAxOTowMQ0KPiBUbzogWHUsIEJhb2p1bg0KPiBDYzogcm9iaCtkdEBrZXJu
ZWwub3JnOyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IGxnaXJkd29vZEBnbWFp
bC5jb207IHBlcmV4QHBlcmV4LmN6OyBwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5j
b207IEx1LCBLZXZpbjsgRGluZywgU2hlbmdoYW87IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQ7IDEz
OTE2Mjc1MjA2QDEzOS5jb207IEhhbXBpaG9saSwgVmFsbGFiaGE7IFAgTywgVmlqZXRoOyBIb2xh
bHUgWW9nZW5kcmEsIE5pcmFuamFuOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpYW0uci5naXJkd29vZEBpbnRlbC5jb207IHl1bmct
Y2h1YW4ubGlhb0BsaW51eC5pbnRlbC5jb207IGJyb29uaWVAa2VybmVsLm9yZzsgc295ZXJAaXJs
Lmh1OyB0aXdhaUBzdXNlLmRlDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUkU6IFtQQVRDSCB2OF0g
QUxTQTogaGRhL3RhczI3ODE6IEFkZCB0YXMyNzgxIGhkYSBTUEkgZHJpdmVyDQo+IA0KPiA+IEZy
b206IEJhb2p1biBYdSA8YmFvanVuLuKAinh1QOKAinRpLuKAimNvbT4gPiBTZW50OiBGcmlkYXks
IEp1bmUgMTQsIDIwMjQgNTrigIowNiBBTSA+ICtzdGF0aWMgaW50IHRhczI3ODFfaGRhX2JpbmQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsID4gKyB2b2lkICptYXN0
ZXJfZGF0YSkgPiAreyA+ICsgc3RydWN0IHRhczI3ODFfaGRhICp0YXNfaGRhID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydA0KPiBUaGlzIG1lc3NhZ2Ug
d2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIFRleGFzIEluc3RydW1lbnRzLg0KPiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc291
cmNlIG9mIHRoaXMgZW1haWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4gSWYgeW91IHdp
c2ggdG8gcmVwb3J0IHRoaXMgbWVzc2FnZSB0byBJVCBTZWN1cml0eSwgcGxlYXNlIGZvcndhcmQg
dGhlIG1lc3NhZ2UgYXMgYW4gYXR0YWNobWVudCB0byBwaGlzaGluZ0BsaXN0LnRpLmNvbQ0KPiAN
Cj4gWmpRY21RUllGcGZwdEJhbm5lckVuZA0KPiANCj4gPiBGcm9tOiBCYW9qdW4gWHUgPGJhb2p1
bi54dUB0aS5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBKdW5lIDE0LCAyMDI0IDU6MDYgQU0NCj4g
PiArc3RhdGljIGludCB0YXMyNzgxX2hkYV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGRldmljZSAqbWFzdGVyLA0KPiA+ICsgICAgIHZvaWQgKm1hc3Rlcl9kYXRhKQ0KPiA+ICt7DQo+
ID4gKyAgICAgc3RydWN0IHRhczI3ODFfaGRhICp0YXNfaGRhID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ID4gKyAgICAgc3RydWN0IGhkYV9jb21wb25lbnQgKmNvbXBzID0gbWFzdGVyX2RhdGE7
DQo+ID4gKyAgICAgc3RydWN0IGhkYV9jb2RlYyAqY29kZWM7DQo+ID4gKyAgICAgaW50IHJldDsN
Cj4gPiArDQo+ID4gKyAgICAgaWYgKHRhc19oZGEtPnByaXYtPmluZGV4IDwgMCB8fA0KPiA+ICsg
ICAgICAgICB0YXNfaGRhLT5wcml2LT5pbmRleCA+PSBIREFfTUFYX0NPTVBPTkVOVFMgfHwNCj4g
PiArICAgICAgICAgKCFjb21wcykpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gPiArDQo+ID4gKyAgICAgY29tcHMgPSAmY29tcHNbdGFzX2hkYS0+cHJpdi0+aW5kZXhdOw0K
PiA+ICsgICAgIGlmIChjb21wcy0+ZGV2KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FQlVT
WTsNCj4gPiArDQo+ID4gKyAgICAgY29kZWMgPSBjb21wcy0+Y29kZWM7DQo+ID4gKw0KPiA+ICsg
ICAgIHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gPiArDQo+ID4gKyAgICAgY29tcHMtPmRl
diA9IGRldjsNCj4gPiArDQo+ID4gKyAgICAgc3Ryc2NweShjb21wcy0+bmFtZSwgZGV2X25hbWUo
ZGV2KSwgc2l6ZW9mKGNvbXBzLT5uYW1lKSk7DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9IHRhc2Nv
ZGVjX3NwaV9pbml0KHRhc19oZGEtPnByaXYsIGNvZGVjLCBUSElTX01PRFVMRSwNCj4gPiArICAg
ICAgICAgICAgIHRhc2Rldl9md19yZWFkeSk7DQo+ID4gKyAgICAgaWYgKCFyZXQpDQo+ID4gKyAg
ICAgICAgICAgICBjb21wcy0+cGxheWJhY2tfaG9vayA9IHRhczI3ODFfaGRhX3BsYXliYWNrX2hv
b2s7DQo+ID4gKw0KPiAuLi4NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHRhczI3ODFfaGRhX3Vu
YmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3RlciwNCj4gPiArICAg
ICB2b2lkICptYXN0ZXJfZGF0YSkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCB0YXMyNzgxX2hk
YSAqdGFzX2hkYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICAgIHN0cnVjdCBoZGFf
Y29tcG9uZW50ICpjb21wcyA9IG1hc3Rlcl9kYXRhOw0KPiA+ICsNCj4gPiArICAgICBjb21wcyA9
ICZjb21wc1t0YXNfaGRhLT5wcml2LT5pbmRleF07DQo+ID4gKw0KPiA+ICsgICAgIGlmIChjb21w
cy0+ZGV2ID09IGRldikgew0KPiA+ICsgICAgICAgICAgICAgY29tcHMtPmRldiA9IE5VTEw7DQo+
ID4gKyAgICAgICAgICAgICBtZW1zZXQoY29tcHMtPm5hbWUsIDAsIHNpemVvZihjb21wcy0+bmFt
ZSkpOw0KPiA+ICsgICAgICAgICAgICAgY29tcHMtPnBsYXliYWNrX2hvb2sgPSBOVUxMOw0KPiA+
ICsgICAgIH0NCj4gPiArDQo+ID4gDQo+ID4gSSdkIGJlZW4gbWFraW5nIHN1cmUgeW91J3JlIG9u
IENDIGJ1dCBpbiBhZGRpdGlvbiB0byB0aGUgb3RoZXIgcmV2aWV3DQo+IGNvbW1lbnRzIEkgd2Fu
dGVkIHRvIGhpZ2hsaWdodCB0aGF0IHRoaXMgaW4gZm9yLW5leHQgd2lsbCBhZmZlY3QgdGhpcyBw
YXRjaA0KPiBhbmQgcmVxdWlyZSBzaW1pbGFyIGNoYW5nZXMgdG8gdGhlc2UgaW4gdGhlIGkyYyBk
cml2ZXI6DQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxzYS1kZXZlbC84N2xlMzI3ZjI5LndsLXRpd2FpQHN1c2UuZGUvVC8qWjJlLjou
LjoyMF9fO0l3ISFHM3ZLIVVHVW9Ga1lQOGpiak5ibnZpbmJzc2ZSaFpRcTUyR0VmZzFvOXRkUjA3
Yi1YUEZVOGx5ZXdORFhDb2M0c3VLN0hQUlh3b0szcklQcUpLeFhMbEZuRSQNCj4gMjQwNjE3MTU0
MTA1LjEwODYzNS0zLXNpbW9udDo6NDBvcGVuc291cmNlLmNpcnJ1cy5jb206MXNvdW5kOnBjaTpo
ZGE6dGFzMjc4MQ0KPiBfaGRhX2kyYy5jDQo+IA0KDQpJIG1lcmdlIGNvZGUgdG8gbWFzdGVyIG9m
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC4NClRpbGwgbm93LCBzZWVtIHlvdXIgcGF0Y2ggbm90IGFwcGxpZWQgeWV0LCBzbyBJIGNh
bid0IHBhc3MgdGhlIGNvbXBpbGUgaWYgSSBhcHBseSB5b3VyIHBhdGNoLg0KDQo+IC1TaW1vbg0K
PiANCj4gDQo=

