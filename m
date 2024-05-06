Return-Path: <linux-kernel+bounces-169429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4482D8BC888
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4833BB20E90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D914037E;
	Mon,  6 May 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZCDzeUQt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70FE140370
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981537; cv=none; b=G6IrNuk2saz2yi2SYr5JWkpIZkgvfLb4uiZ1KVAkdyJs9VGn5p28bnSJI/a5DqRFMYdot4dtNZjfJvsA18lbivR7NK7koZCJS2hwFOiQ5lpbOg7cCK+/xnxBbdnUpqtkI1jFo0IuTcdWwyBovzqCOGIeULp1YWBPQaJENfTdc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981537; c=relaxed/simple;
	bh=6TAT1+n58JucEKjWCrV75WkhFXklBUPwfthOxea0vBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxyvcJ/RixQCOIY/hej1WUgOLxMdt2NdCg9lpGsu26DcpzqL9ZMqzJWfmI/4KgLigXn23BUNL+um840uG9muze+NiHkpZMNDOGjkvcuBvEM3UnWqPxvaNLPlqE3Yw/XIn7UvERomYJz94yhqSw858lWlomedZw86Z7FEHlkRRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZCDzeUQt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4467ig53095759;
	Mon, 6 May 2024 02:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714981482;
	bh=6TAT1+n58JucEKjWCrV75WkhFXklBUPwfthOxea0vBc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=ZCDzeUQtx/oOXKTf2ZrmL//ClDQ6l0OICmso0wKPdSSCtXB6M478K3ltrlpYOvZSC
	 ZFfDtmoPUiCRrIGYBlTZyBSkxxOL8OXq0Xc1XEOAWUGy2LKYl7md41Vjq/xUdNgjKh
	 jMLNplDArbtwMNoDihtZ2tNm+Xgy+lTDEFC/zZho=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4467igug118570
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 May 2024 02:44:42 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 May 2024 02:44:41 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Mon, 6 May 2024 02:44:41 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Takashi Iwai
	<tiwai@suse.de>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>,
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
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/3] ALSA: hda/tas2781: Add tas2781 hda
 driver based on SPI
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/3] ALSA: hda/tas2781: Add tas2781 hda
 driver based on SPI
Thread-Index: AQHams/AyRoBFLmXZEetT//IO/HlOrGBGk0AgAANNwCACLNAfA==
Date: Mon, 6 May 2024 07:44:41 +0000
Message-ID: <5832318882b14f5cb171ce2ecde1fc93@ti.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
 <20240430072544.1877-2-baojun.xu@ti.com>
 <87jzkfm2hp.wl-tiwai@suse.de>,<ZjD1-NSC3X_7JcQg@smile.fi.intel.com>
In-Reply-To: <ZjD1-NSC3X_7JcQg@smile.fi.intel.com>
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
Pg0KPiBTZW50OiAzMCBBcHJpbCAyMDI0IDIxOjQ1DQo+IFRvOiBUYWthc2hpIEl3YWkNCj4gQ2M6
IFh1LCBCYW9qdW47IHJvYmgrZHRAa2VybmVsLm9yZzsgbGdpcmR3b29kQGdtYWlsLmNvbTsgcGVy
ZXhAcGVyZXguY3o7IHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbTsgTHUsIEtl
dmluOyBEaW5nLCBTaGVuZ2hhbzsgTmF2YWRhIEthbnlhbmEsIE11a3VuZDsgMTM5MTYyNzUyMDZA
MTM5LmNvbTsgUCBPLCBWaWpldGg7IEhvbGFsdSBZb2dlbmRyYSwgTmlyYW5qYW47IGFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlhbS5y
LmdpcmR3b29kQGludGVsLmNvbTsgeXVuZy1jaHVhbi5saWFvQGxpbnV4LmludGVsLmNvbTsgYnJv
b25pZUBrZXJuZWwub3JnOyBzb3llckBpcmwuaHUNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTog
W1BBVENIIHY0IDEvM10gQUxTQTogaGRhL3RhczI3ODE6IEFkZCB0YXMyNzgxIGhkYSBkcml2ZXIg
YmFzZWQgb24gU1BJDQo+IA0KPiBPbiBUdWUsIEFwciAzMCwgMjAyNCBhdCAwMjrigIo1ODrigIox
MFBNICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6ID4gT24gVHVlLCAzMCBBcHIgMjAyNCAwOTri
gIoyNTrigIo0MiArMDIwMCwgQmFvanVuIFh1IHdyb3RlOiAuLuKAii4gPiA+IHNuZC1oZGEtY3Mt
ZHNwLWN0bHMtb2JqcyA6PSBoZGFfY3NfZHNwX2N0bC7igIpvID4gPiBzbmQtaGRhLXNjb2RlYy1j
b21wb25lbnQtb2JqcyA6PSBoZGFfY29tcG9uZW50LuKAim8gPg0KPiBaalFjbVFSWUZwZnB0QmFu
bmVyU3RhcnQNCj4gVGhpcyBtZXNzYWdlIHdhcyBzZW50IGZyb20gb3V0c2lkZSBvZiBUZXhhcyBJ
bnN0cnVtZW50cy4NCj4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSByZWNvZ25pemUgdGhlIHNvdXJjZSBvZiB0aGlzIGVtYWlsIGFuZCBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUuIElmIHlvdSB3aXNoIHRvIHJlcG9ydCB0aGlzIG1lc3NhZ2UgdG8gSVQg
U2VjdXJpdHksIHBsZWFzZSBmb3J3YXJkIHRoZSBtZXNzYWdlIGFzIGFuIGF0dGFjaG1lbnQgdG8g
cGhpc2hpbmdAbGlzdC50aS5jb20NCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gDQo+
IE9uIFR1ZSwgQXByIDMwLCAyMDI0IGF0IDAyOjU4OjEwUE0gKzAyMDAsIFRha2FzaGkgSXdhaSB3
cm90ZToNCj4gPiBPbiBUdWUsIDMwIEFwciAyMDI0IDA5OjI1OjQyICswMjAwLCBCYW9qdW4gWHUg
d3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiAgc25kLWhkYS1jcy1kc3AtY3Rscy1vYmpzIDo9
ICAgICAgICAgICAgICAgIGhkYV9jc19kc3BfY3RsLm8NCj4gPiA+ICBzbmQtaGRhLXNjb2RlYy1j
b21wb25lbnQtb2JqcyA6PSAgIGhkYV9jb21wb25lbnQubw0KPiA+ID4gIHNuZC1oZGEtc2NvZGVj
LXRhczI3ODEtaTJjLW9ianMgOj0gdGFzMjc4MV9oZGFfaTJjLm8NCj4gPiA+ICtzbmQtaGRhLXNj
b2RlYy10YXMyNzgxLXNwaS15IDo9ICAgIHRhczI3ODFfaGRhX3NwaS5vIHRhczI3ODFfc3BpX2Z3
bGliLm8NCj4gPg0KPiA+IEEgbml0cGlja2luZzogYmV0dGVyIHRvIGFsaWduIHdpdGggb3RoZXIg
bGluZXMgKGkuZS4gd2l0aCAqLW9ianMNCj4gPiBpbnN0ZWFkIG9mICoteSkuDQo+IA0KPiBJIG9i
amVjdCB0aGlzLiBUaGUgYmV0dGVyIGFwcHJvYWNoIGlzIHRvIGhhdmUgYSBwcmVjdXJzb3IgcGF0
Y2ggdGhhdCBzd2l0Y2hlcw0KPiB0byB5IG92ZXIgb2JqcyAodGhlIGxhdHRlciBpcyBmb3IgdXNl
ciBzcGFjZSBjb2RlIC8gdG9vbHMpLg0KDQpJIGFsc28gZG8gbm90IGZ1bGx5IHVuZGVyc3RhbmQg
d2h5IHNldCBpdCBhcyAieSIsIGFzIHlvdSBrbm93LCBJIGZvbGxvdw0KQ09ORklHX1NORF9IREFf
U0NPREVDX1RBUzI3ODFfSTJDLCBhcyBpdCBkbyBub3Qgc2V0IHRvICJ5Ii4NCg0KPiANCj4gLS0N
Cj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQo+IA==

