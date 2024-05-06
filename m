Return-Path: <linux-kernel+bounces-169428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7C8BC887
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52702B20D07
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D07140E47;
	Mon,  6 May 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i5pcXv27"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B213FD91
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981514; cv=none; b=rrdbWELLIHGVR2XMXn6MEJ/Z+Nw47hzrc9DnjM2Djf/BFaclrMZCR5LZUf3sZwkLXx9pyYz+BtXFsdymkXPDfH948jqd3KQsjD/PthUUtB0m/Om5tap5yPrSHIa3qXZ1M5giArzFKYKUbYJsiqvc7lO2jS7c51/XpOYGP04/mrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981514; c=relaxed/simple;
	bh=wFO1Q3+eNIHJz3HRsu33RvMMo9hn2HylVuWXmz288kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVzOoYjlDLx9ffhGgJ+es781R7a4PCBKuyurDJe/sHjnVA3H00bdxQ4eUB2BqhNSeFOiihAmdHgkY+AyZCBaSKCqg/J7QYunBpR24ZLXa7847F8+ks7nl+gG0bWT/IIlTHMg5S/VH9+o4DwFbBSiQ6L2x3zbeoIpuIQ7znaKOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i5pcXv27; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4467i5kr095658;
	Mon, 6 May 2024 02:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714981445;
	bh=wFO1Q3+eNIHJz3HRsu33RvMMo9hn2HylVuWXmz288kw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=i5pcXv27umM2ROuLLndeYZGMKBYxaXQ9XEoEXcUEuIYqR4VsWF9JLiMqzb/s3EHdy
	 MRJObDbMjPAIJYRyXE/8hB+qEqtxVr9O7d0c5X0mQAqt+7/I2F1xjPkmaHe7W+WVK/
	 2b1TeWTJAopoL04/yPXOcr2nHQZpNI6peCSSgbqI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4467i5LR118272
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 May 2024 02:44:05 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 May 2024 02:44:05 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Mon, 6 May 2024 02:44:05 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "tiwai@suse.de" <tiwai@suse.de>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "Ding,
 Shenghao" <shenghao-ding@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "P O, Vijeth" <v-po@ti.com>,
        "Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification for
 add tas2781 driver for SPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification
 for add tas2781 driver for SPI
Thread-Index: AQHakUValxtzw4HJGk6cPNX38MLKCLFuQDOAgApofQGAC33VgIAFxDWQ
Date: Mon, 6 May 2024 07:44:05 +0000
Message-ID: <d96bea0bacc842e0b30a100f43ff264f@ti.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
 <20240418040240.2337-2-baojun.xu@ti.com>
 <ZiEKc4OTVlOt8llU@smile.fi.intel.com>
 <0c7b29075dc347299602668660adb4b6@ti.com>,<ZjNpX6TvB4Vv1akq@smile.fi.intel.com>
In-Reply-To: <ZjNpX6TvB4Vv1akq@smile.fi.intel.com>
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

SGkgQW5keQ0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIGFuc3dlciBpbiBsaW5lOg0KDQo+
IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
Pg0KPiBTZW50OiAwMiBNYXkgMjAyNCAxODoyMg0KPiBUbzogWHUsIEJhb2p1bg0KPiBDYzogdGl3
YWlAc3VzZS5kZTsgcm9iaCtkdEBrZXJuZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBwZXJl
eEBwZXJleC5jejsgcGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tOyBMdSwgS2V2
aW47IERpbmcsIFNoZW5naGFvOyBOYXZhZGEgS2FueWFuYSwgTXVrdW5kOyAxMzkxNjI3NTIwNkAx
MzkuY29tOyBQIE8sIFZpamV0aDsgSG9sYWx1IFlvZ2VuZHJhLCBOaXJhbmphbjsgYWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaWFtLnIu
Z2lyZHdvb2RAaW50ZWwuY29tOyB5dW5nLWNodWFuLmxpYW9AbGludXguaW50ZWwuY29tOyBicm9v
bmllQGtlcm5lbC5vcmc7IHNveWVyQGlybC5odQ0KPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIHYzIDEvM10gQUxTQTogaGRhL3RhczI3ODE6IE1vZGlmaWNhdGlvbiBmb3IgYWRk
IHRhczI3ODEgZHJpdmVyIGZvciBTUEkNCj4gDQo+IE9uIFRodSwgQXByIDI1LCAyMDI0IGF0IDA3
OuKAijU0OuKAijQxQU0gKzAwMDAsIFh1LCBCYW9qdW4gd3JvdGU6ID4gPiBGcm9tOiBBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS7igIpzaGV2Y2hlbmtvQOKAimxpbnV4LuKAimludGVsLuKAimNvbT4g
PiA+IFNlbnQ6IDE4IEFwcmlsIDIwMjQgMTk64oCKNTYgPiA+IE9uIFRodSwgQXByIDE4LCAyMDI0
IGF0IDEyOiAwMjogMzdQTSArMDgwMCwgQmFvanVuIFh1IHdyb3RlOuKAig0KPiBaalFjbVFSWUZw
ZnB0QmFubmVyU3RhcnQNCj4gVGhpcyBtZXNzYWdlIHdhcyBzZW50IGZyb20gb3V0c2lkZSBvZiBU
ZXhhcyBJbnN0cnVtZW50cy4NCj4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNvdXJjZSBvZiB0aGlzIGVtYWlsIGFuZCBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuIElmIHlvdSB3aXNoIHRvIHJlcG9ydCB0aGlzIG1lc3NhZ2Ug
dG8gSVQgU2VjdXJpdHksIHBsZWFzZSBmb3J3YXJkIHRoZSBtZXNzYWdlIGFzIGFuIGF0dGFjaG1l
bnQgdG8gcGhpc2hpbmdAbGlzdC50aS5jb20NCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQN
Cj4gDQo+IE9uIFRodSwgQXByIDI1LCAyMDI0IGF0IDA3OjU0OjQxQU0gKzAwMDAsIFh1LCBCYW9q
dW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNlbnQ6IDE4IEFwcmlsIDIwMjQgMTk6NTYNCj4gPiA+
IE9uIFRodSwgQXByIDE4LCAyMDI0IGF0IDEyOuKAijAyOuKAijM3UE0gKzA4MDAsIEJhb2p1biBY
dSB3cm90ZToNCj4gPiA+IE9uIFRodSwgQXByIDE4LCAyMDI0IGF0IDEyOjAyOjM3UE0gKzA4MDAs
IEJhb2p1biBYdSB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gIHNvdW5kL3BjaS9oZGEv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKysrDQo+
ID4gPiA+ICBzb3VuZC9wY2kvaGRhL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyICsrDQo+ID4gPg0KPiA+IElzIHRoaXMgY29ycmVjdD8gWW91IGFyZSBhZGRpbmcgYSBkZWFk
ICJjb2RlIiwgaXNuJ3QgaXQ/DQo+ID4NCj4gPiBXaGF0J3MgbWVhbiAiZGVhZCBjb2RlIj8gQWZ0
ZXIgYWRkIENPTkZJR19TTkRfSERBX1NDT0RFQ19UQVMyNzgxX1NQST1tDQo+ID4gaW4gbXkgY29u
ZmlnIGZpbGUsIHRoZSB3aG9sZSBwYXRjaCBjb2RlIGhhcyB3b3JrZWQuDQo+IA0KPiBJcyB0aGF0
IGZpbGUgYWxyZWFkeSBpbiB0aGUgcmVwb3NpdG9yeT8NCj4gSWYgbm90LCBJIGRvbid0IHNlZSBp
dCBpbiB0aGlzIHBhdGNoIGVpdGhlciAtLT4gZGVhZCBjb2RlLg0KDQpXaGVuIEkgaW50ZWdyYXRl
ZCBDT05GSUdfU05EX0hEQV9TQ09ERUNfVEFTMjc4MV9TUEkgYW5kIGNvbXBpbGVkIHRoZSB3aG9s
ZSBrZXJuZWwsDQppdCB1c2VkIHRvIHBvcHVwIHRoZSBmb2xsb3dpbmcgbWVzc2FnZSBmb3IgVEFT
Mjc4MSBTUEkgbW9kdWxlIGluIGZpcnN0IGNvbXBpbGU6DQogDQogQnVpbGQgVEFTMjc4MSBIRC1h
dWRpbyBzaWRlIGNvZGVjIHN1cHBvcnQgZm9yIFNQSSBCdXMgKFNORF9IREFfU0NPREVDX1RBUzI3
ODFfU1BJKSBbTi9tLz9dIChORVcpIA0KDQpOb3JtYWxseSwgc2VsZWN0ZWQgbS4gQW5kIFRBUzI3
ODEgU1BJIG1vZHVsZSB3b3VsZCBiZSBjb21waWxlZC4NCg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0
IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQo=

