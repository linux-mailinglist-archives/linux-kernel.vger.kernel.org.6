Return-Path: <linux-kernel+bounces-287466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDA952817
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509611F22E50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3723776;
	Thu, 15 Aug 2024 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BWk1cIt4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332ABC144
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691022; cv=none; b=O4hWFNsI9PdbiX+3onwMBkManIep2zdgCajRp1uwng7GdTetmL8VDDDqd3UAx7Iz8iLD3uxjSV2X+W59wjGlIrLSxUBLPlSYMwDUNtPQy/eLYH6AC65pJECB5Dvm4T8+RUA4mO+7gXBy2FLJ5GNXW3sKl2hQz0tiTgdmT72djPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691022; c=relaxed/simple;
	bh=T61tpL0k8XFvnc41zEeJo40tmPwQjZpEvy5wwd416NU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsE4tyTDd2UATxk/C8P+X2Ab+zG9hciE/9uW1g2sGfegOgojBHQdJDyMETmt/ypnpfJYJ8h3N5b36c5qJahi/Hrd0flqidrNrYNNJ3fyKBxkkzhrSqCe90SEmpTD60D43jHrIn1+o0n05t79ZDgbqNk6Y6CH3KMg+ryMJsPl/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BWk1cIt4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47F322bm086667;
	Wed, 14 Aug 2024 22:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723690922;
	bh=T61tpL0k8XFvnc41zEeJo40tmPwQjZpEvy5wwd416NU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=BWk1cIt4I9BGRq3wLEj97opTnTFK1nMdg3OkkEx9ZNmM6qzpOFNQ2K0kAZRWWLx1X
	 RT8zk7X0YCD2CourdNPVQFb1c6mcmEBc+UYduZRYYwfdBEDr8LPPXxacdJavHMU+Nj
	 5nAoXp2wJjhJKhT67UtjCZgnyqr3rggE7DnKR+fs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47F32269065026
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 22:02:02 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 22:02:01 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 14 Aug 2024 22:02:01 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "zhourui@huaqin.com" <zhourui@huaqin.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Salazar, Ivan"
	<i-salazar@ti.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Chadha, Jasjot Singh" <j-chadha@ti.com>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "Yue, Jaden"
	<jaden-yue@ti.com>,
        "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>,
        "Rao, Dipa" <dipa@ti.com>, "yuhsuan@google.com" <yuhsuan@google.com>,
        "Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
        "judyhsiao@google.com" <judyhsiao@google.com>,
        "Navada Kanyana, Mukund"
	<navada@ti.com>,
        "cujomalainey@google.com" <cujomalainey@google.com>,
        "Kutty,
 Aanya" <aanya@ti.com>,
        "Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
        "savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
        "flaviopr@microsoft.com" <flaviopr@microsoft.com>,
        "Ji, Jesse"
	<jesse-ji@ti.com>,
        "darren.ye@mediatek.com" <darren.ye@mediatek.com>,
        "antheas.dk@gmail.com" <antheas.dk@gmail.com>,
        "Jerry2.Huang@lcfuturecenter.com" <Jerry2.Huang@lcfuturecenter.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name
 to unify the name between TAS2563 and TAS2781
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name
 to unify the name between TAS2563 and TAS2781
Thread-Index: AQHa5VUVVJh0PH35uk6MrsBIXoZO8rIkKEGAgAOLIdA=
Date: Thu, 15 Aug 2024 03:02:01 +0000
Message-ID: <9ec30bafdec441078828cb0d7be93342@ti.com>
References: <20240803032717.175-1-shenghao-ding@ti.com>
 <ZrovmRCPN7pc0n40@smile.fi.intel.com>
In-Reply-To: <ZrovmRCPN7pc0n40@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
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

SGkgQW5keQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZj
aGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBBdWd1c3QgMTIsIDIwMjQgMTE6NTIgUE0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hh
by1kaW5nQHRpLmNvbT4NCj4gQ2M6IGJyb29uaWVAa2VybmVsLm9yZzsgbGdpcmR3b29kQGdtYWls
LmNvbTsgcGVyZXhAcGVyZXguY3o7IHBpZXJyZS0NCj4gbG91aXMuYm9zc2FydEBsaW51eC5pbnRl
bC5jb207IDEzOTE2Mjc1MjA2QDEzOS5jb207IHpob3VydWlAaHVhcWluLmNvbTsNCj4gYWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnOyBTYWxhemFyLCBJdmFuIDxpLXNhbGF6YXJAdGkuY29tPjsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENoYWRoYSwgSmFzam90IFNpbmdoIDxq
LWNoYWRoYUB0aS5jb20+Ow0KPiBsaWFtLnIuZ2lyZHdvb2RAaW50ZWwuY29tOyBZdWUsIEphZGVu
IDxqYWRlbi15dWVAdGkuY29tPjsgeXVuZy0NCj4gY2h1YW4ubGlhb0BsaW51eC5pbnRlbC5jb207
IFJhbywgRGlwYSA8ZGlwYUB0aS5jb20+OyB5dWhzdWFuQGdvb2dsZS5jb207DQo+IExvLCBIZW5y
eSA8aGVucnkubG9AdGkuY29tPjsgdGl3YWlAc3VzZS5kZTsgWHUsIEJhb2p1biA8YmFvanVuLnh1
QHRpLmNvbT47DQo+IHNveWVyQGlybC5odTsgQmFvanVuLlh1QGZwdC5jb207IGp1ZHloc2lhb0Bn
b29nbGUuY29tOyBOYXZhZGEgS2FueWFuYSwNCj4gTXVrdW5kIDxuYXZhZGFAdGkuY29tPjsgY3Vq
b21hbGFpbmV5QGdvb2dsZS5jb207IEt1dHR5LCBBYW55YQ0KPiA8YWFueWFAdGkuY29tPjsgTWFo
bXVkLCBOYXllZW0gPG5heWVlbS5tYWhtdWRAdGkuY29tPjsNCj4gc2F2eWFzYW5jaGkuc2h1a2xh
QG5ldHJhZHluZS5jb207IGZsYXZpb3ByQG1pY3Jvc29mdC5jb207IEppLCBKZXNzZSA8amVzc2Ut
DQo+IGppQHRpLmNvbT47IGRhcnJlbi55ZUBtZWRpYXRlay5jb207IGFudGhlYXMuZGtAZ21haWwu
Y29tOw0KPiBKZXJyeTIuSHVhbmdAbGNmdXR1cmVjZW50ZXIuY29tDQo+IFN1YmplY3Q6IFtFWFRF
Uk5BTF0gUmU6IFtQQVRDSCB2MV0gQVNvYzogdGFzMjc4MTogUmVuYW1lIGRhaV9kcml2ZXIgbmFt
ZQ0KPiB0byB1bmlmeSB0aGUgbmFtZSBiZXR3ZWVuIFRBUzI1NjMgYW5kIFRBUzI3ODENCj4gDQo+
IE9uIFNhdCwgQXVnIDAzLCAyMDI0IGF0IDExOuKAijI3OuKAijE0QU0gKzA4MDAsIFNoZW5naGFv
IERpbmcgd3JvdGU6ID4gUmVuYW1lDQo+IGRhaV9kcml2ZXIgbmFtZSB0byB1bmlmeSB0aGUgbmFt
ZSBiZXR3ZWVuIFRBUzI1NjMgYW5kID4gVEFTMjc4MSwgcmVtb3ZlDQo+IHVubmVjZXNzYXJ5IGxp
bmUgZmVlZCwgc3Ryc2NweSByZXBsYWNlIHNjbnByaW50Zi4gLi7igIouID4gKyBzdHJzY3B5KG5h
bWUsICJTcGVha2VyDQo+IFByb2ZpbGUgWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFRoaXMgbWVz
c2FnZSB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YNCj4gVGV4YXMgSW5zdHJ1bWVudHMuDQo+IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzb3VyY2Ugb2YgdGhpcw0KPiBlbWFpbCBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPiA8aHR0cHM6Ly91cy1waGlzaGFsYXJtLQ0KPiBld3QucHJvb2Zwb2ludC5jb20vRVdUL3Yx
L0czdkshdUJkblZWeG52Y0ZWUmdtazFObmoxOWhnUnZkS0JMR3pPMA0KPiBmT0Z0SVBIZ2FNeTdz
TU5iSno5SXE2Sk52cEpHYWgzODZNdldxUTBWU3lfWHhoVmxvJD4NCj4gUmVwb3J0IFN1c3BpY2lv
dXMNCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gT24gU2F0LCBBdWcgMDMsIDIwMjQg
YXQgMTE6Mjc6MTRBTSArMDgwMCwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPiBSZW5hbWUgZGFp
X2RyaXZlciBuYW1lIHRvIHVuaWZ5IHRoZSBuYW1lIGJldHdlZW4gVEFTMjU2MyBhbmQgVEFTMjc4
MSwNCj4gPiByZW1vdmUgdW5uZWNlc3NhcnkgbGluZSBmZWVkLCBzdHJzY3B5IHJlcGxhY2Ugc2Nu
cHJpbnRmLg0KPiANCj4gLi4uDQo+IA0KPiA+ICsJc3Ryc2NweShuYW1lLCAiU3BlYWtlciBQcm9m
aWxlIElkIiwNCj4gU05EUlZfQ1RMX0VMRU1fSURfTkFNRV9NQVhMRU4pOw0KPiANCj4gPiArCXN0
cnNjcHkocHJvZ19uYW1lLCAiU3BlYWtlciBQcm9ncmFtIElkIiwNCj4gPiArCQlTTkRSVl9DVExf
RUxFTV9JRF9OQU1FX01BWExFTik7DQo+IA0KPiA+ICsJc3Ryc2NweShjb25mX25hbWUsICJTcGVh
a2VyIENvbmZpZyBJZCIsDQo+ID4gK1NORFJWX0NUTF9FTEVNX0lEX05BTUVfTUFYTEVOKTsNCj4g
DQo+IFdoeSBub3QgMi1wYXJhbWV0ZXIgc3Ryc2NweSgpPw0Kc3Ryc2NweSBzZWVtZWQgbm90IHN1
cHBvcnQgMiBwYXJhbXMuIERvIHlvdSBtZWFuIHN0cmNweT8gDQo+IA0KPiAtLQ0KPiBXaXRoIEJl
c3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQo=

