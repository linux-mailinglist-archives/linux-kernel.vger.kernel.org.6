Return-Path: <linux-kernel+bounces-248908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1792E3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CF7B221B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E215746A;
	Thu, 11 Jul 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WGUTuNvU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D976034
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690992; cv=none; b=bDr1B2hdEyIFB/fXs4VGuZuR3x31pSG99xXcQjWa8fZOzCeaPEHCPFtGjKpAcbP18Xi5Kqv3kEwMjN9nOJYj28Zb//JMYe7g0Dw6kOsQjRQ9dPa4jXJNm/M5ZHZJEWzLvYPVPM1USMhvQ94pXJct85jB5Xwu5GfX1VzyXN8UDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690992; c=relaxed/simple;
	bh=clYmUUuAhN2wNLGXaTFFUk3J+PcRGxA81IYyrDlzf04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Di/5XHA28PqpnxsnegoPv3Uocainzgur3EVHgup30olPuE8sBuHbeKo5fmVmtyvERLuzYKM5pVnqra5CcLi0WeBscI+p1lR0jxDFLlctELcDjyV/NrIKBM9lWVSyf62Ic4uiVNJJrSvtEPQSpbKToVWO8H5Oeo/b9PxgxJZvTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WGUTuNvU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46B9g8Nc067340;
	Thu, 11 Jul 2024 04:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720690928;
	bh=clYmUUuAhN2wNLGXaTFFUk3J+PcRGxA81IYyrDlzf04=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=WGUTuNvUYX7YunCIu3Rj0WfvQWCRYdWHFWysA0JOU1xb3X+/Zsld+wB2LiwsUvRyE
	 w7r5WDQGNnLAmv422bgoeQGmp8oLK7Cxkw/OzieHw70sfz0EPQXXkn3+CBdWFkGG9M
	 jWRw6VmkMcUcdXI369OOHxAku727UxQP4J/t8yMg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46B9g8sI027625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 04:42:08 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 04:42:08 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Thu, 11 Jul 2024 04:42:08 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Takashi Iwai <tiwai@suse.de>
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
        "soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI
 driver
Thread-Topic: [EXTERNAL] Re: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI
 driver
Thread-Index: AQHavhA+LICoIavOaEyXrK6TRE4VxrHHkvGAgCncvSA=
Date: Thu, 11 Jul 2024 09:42:08 +0000
Message-ID: <cedb99db542a41178a5f1b09c9ef5cf3@ti.com>
References: <20240614040554.610-1-baojun.xu@ti.com>,<874j9v8xuq.wl-tiwai@suse.de>
In-Reply-To: <874j9v8xuq.wl-tiwai@suse.de>
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

SGkgVGFrYXNoaSwNCg0KQW5zd2VyIGluIGxpbmUuDQoNCkJlc3QgUmVnYXJkcw0KSmltDQoNCj4g
RnJvbTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPg0KPiBTZW50OiAxNCBKdW5lIDIwMjQg
MjE6MjANCj4gVG86IFh1LCBCYW9qdW4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgYW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBwZXJleEBw
ZXJleC5jejsgcGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tOyBMdSwgS2V2aW47
IERpbmcsIFNoZW5naGFvOyBOYXZhZGEgS2FueWFuYSwgTXVrdW5kOyAxMzkxNjI3NTIwNkAxMzku
Y29tOyBIYW1waWhvbGksIFZhbGxhYmhhOyBQIE8sIFZpamV0aDsgSG9sYWx1IFlvZ2VuZHJhLCBO
aXJhbmphbjsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaWFtLnIuZ2lyZHdvb2RAaW50ZWwuY29tOyB5dW5nLWNodWFuLmxpYW9AbGlu
dXguaW50ZWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7IHNveWVyQGlybC5odQ0KPiBTdWJqZWN0
OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjhdIEFMU0E6IGhkYS90YXMyNzgxOiBBZGQgdGFzMjc4
MSBoZGEgU1BJIGRyaXZlcg0KPiANCj4gT24gRnJpLCAxNCBKdW4gMjAyNCAwNjrigIowNTrigIo1
NCArMDIwMCwgQmFvanVuIFh1IHdyb3RlOiA+ICtzdGF0aWMgc3RydWN0IHRhc2RldmljZV9jb25m
aWdfaW5mbyAqdGFzZGV2aWNlX2FkZF9jb25maWcoID4gKyBzdHJ1Y3QgdGFzZGV2aWNlX3ByaXYg
KnRhc19wcml2LCB1bnNpZ25lZCBjaGFyICpjb25maWdfZGF0YSwgPiArIHVuc2lnbmVkIGludCBj
b25maWdfc2l6ZSwgaW50ICpzdGF0dXMpID4gK3sNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0
DQo+IFRoaXMgbWVzc2FnZSB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgVGV4YXMgSW5zdHJ1bWVu
dHMuDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
cmVjb2duaXplIHRoZSBzb3VyY2Ugb2YgdGhpcyBlbWFpbCBhbmQga25vdyB0aGUgY29udGVudCBp
cyBzYWZlLiBJZiB5b3Ugd2lzaCB0byByZXBvcnQgdGhpcyBtZXNzYWdlIHRvIElUIFNlY3VyaXR5
LCBwbGVhc2UgZm9yd2FyZCB0aGUgbWVzc2FnZSBhcyBhbiBhdHRhY2htZW50IHRvIHBoaXNoaW5n
QGxpc3QudGkuY29tDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+IA0KPiBPbiBGcmks
IDE0IEp1biAyMDI0IDA2OjA1OjU0ICswMjAwLA0KPiBCYW9qdW4gWHUgd3JvdGU6DQo+ID4gK3N0
YXRpYyBzdHJ1Y3QgdGFzZGV2aWNlX2NvbmZpZ19pbmZvICp0YXNkZXZpY2VfYWRkX2NvbmZpZygN
Cj4gPiArICAgICBzdHJ1Y3QgdGFzZGV2aWNlX3ByaXYgKnRhc19wcml2LCB1bnNpZ25lZCBjaGFy
ICpjb25maWdfZGF0YSwNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgY29uZmlnX3NpemUsIGludCAq
c3RhdHVzKQ0KPiA+ICt7DQo+IChzbmlwKQ0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogY29u
dmVydCBkYXRhW29mZnNldF0sIGRhdGFbb2Zmc2V0ICsgMV0sIGRhdGFbb2Zmc2V0ICsgMl0gYW5k
DQo+ID4gKyAgICAgICogZGF0YVtvZmZzZXQgKyAzXSBpbnRvIGhvc3QNCj4gPiArICAgICAgKi8N
Cj4gPiArICAgICBjZmdfaW5mby0+bmJsb2NrcyA9IGdldF91bmFsaWduZWRfYmUzMigmY29uZmln
X2RhdGFbY29uZmlnX29mZnNldF0pOw0KPiA+ICsgICAgIGNvbmZpZ19vZmZzZXQgKz0gNDsNCj4g
PiArDQo+ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBTZXZlcmFsIGtpbmRzIG9mIGRzcC9hbGdv
cml0aG0gZmlybXdhcmVzIGNhbiBydW4gb24gdGFzMjc4MSwNCj4gPiArICAgICAgKiB0aGUgbnVt
YmVyIGFuZCBzaXplIG9mIGJsayBhcmUgbm90IGZpeGVkIGFuZCBkaWZmZXJlbnQgYW1vbmcNCj4g
PiArICAgICAgKiB0aGVzZSBmaXJtd2FyZXMuDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgYmtf
ZGEgPSBjZmdfaW5mby0+YmxrX2RhdGEgPSBrY2FsbG9jKGNmZ19pbmZvLT5uYmxvY2tzLA0KPiA+
ICsgICAgICAgICAgICAgc2l6ZW9mKCpia19kYSksIEdGUF9LRVJORUwpOw0KPiANCj4gU28gdGhl
IGFsbG9jYXRpb24gc2l6ZSByZWxpZXMgb24gdGhlIGZpcm13YXJlIGRhdGEgY29udGVudCwgYW5k
IGl0IGNhbg0KPiBwcmFjdGljYWxseSBhbnkgdmFsdWUuICBJdCdkIGJlIHNhZmVyIHRvIGhhdmUg
c29tZSBzYW5pdHkgY2hlY2sgZm9yDQo+IGF2b2lkaW5nIHRoZSBhbGxvY2F0aW9uIG9mIHRvbyBs
YXJnZSBwYWdlcy4NCj4gRGl0dG8gZm9yIG90aGVyIGFsbG9jYXRpb25zIGluIHRoaXMgY29kZTsg
eW91IHNob3VsZCBuZXZlciB0cnVzdCB0aGUNCj4gZmlybXdhcmUgYmluYXJ5Lg0KDQpJdCdzIGp1
c3Qgc2l6ZSBvZiBzdHJ1Y3QgdGFzZGV2X2Jsa19kYXRhLCBub3QgdmFyaWFibGUgZnJvbSBmaXJt
d2FyZS4NCkluIG90aGVyIGtjYWxsb2MoKSwgaXQncyBhbHNvIGFsbG9jYXRlIG1lbW9yeSBmb3Ig
c3RydWN0dXJlLg0KDQo+IA0KPiBBbHNvLCBpbiBnZW5lcmFsLCB0aGUgY29tbWVudHMgYXJlIG1p
c3NpbmcgZm9yIGZ1bmN0aW9ucyBpbg0KPiB0YXMyNzgxX3NwaV9md2xpYi5jIGNvbXBsZXRlbHku
ICBBIGJyaWVmIGNvbW1lbnQgZm9yIGVhY2ggZnVuY3Rpb24NCj4gd291bGQgYmUgaGVscGZ1bCBm
b3IgcmVhZGVycy4NCj4gDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBUYWthc2hpDQo+IA0KPiANCj4g

