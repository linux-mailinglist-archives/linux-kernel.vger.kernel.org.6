Return-Path: <linux-kernel+bounces-250132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6E92F48E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36611F24257
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356710A1F;
	Fri, 12 Jul 2024 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f6GpwcBK"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CD17BBE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756896; cv=none; b=mQxKc8BtTVsQ+IX1F7zmFS2N73+LWl/AvbhQWC/3K/3KpqsilP+tjBkB5hWh91TS0YttSCF8l639R44TSIzKvqi+nQ5pXcWJxoKxVXqJ9v/ZVj701TliPhW7r0eFVtzEItYRFYcjWyZy9Fw10sEec0Kx5EvUNpfvmfn1YhySU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756896; c=relaxed/simple;
	bh=l+375qjFAlOcrYjjqUkYaatLjPzeqnc6eSRZyjn17LQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIvoWcnjUsT503rVUZ5VV5Er3IPHDwk9aDWIFeggYxGOOS6Jq/Ju9uI6USkYr2nWSKEfLuwLqF7NOwAYJkifrR1/ROxmZwhS87xed/2oKy1BSg7sPE5XbWQh5MY+Ag79s+RlR/lWPT/eKPHhIiRzLAFhqDawxYQffOL7B8xXRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f6GpwcBK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46C40LCw125747;
	Thu, 11 Jul 2024 23:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720756821;
	bh=l+375qjFAlOcrYjjqUkYaatLjPzeqnc6eSRZyjn17LQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=f6GpwcBKWjlRawF+nvLz1kgCBvqyAI6MflujmHXJsG+HGETZhhcQJs6ATujG5yuA3
	 2cc19N5ApLtC1VVi1Sg9zZ3LysR3DBwWjvHi2Wep+STXQ9lPZlcEWuKt6i/oAEtLG3
	 SfrkzOxPZiYiXEHpeAGQaPc+sHBzvld9aWaKoeWE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46C40Lcs031923
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 23:00:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 23:00:21 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Thu, 11 Jul 2024 23:00:21 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "tiwai@suse.de" <tiwai@suse.de>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [EXTERNAL] Re: [PATCH v9] ALSA: hda/tas2781: Add tas2781 hda SPI
 driver
Thread-Topic: [EXTERNAL] Re: [PATCH v9] ALSA: hda/tas2781: Add tas2781 hda SPI
 driver
Thread-Index: AQHa05Ud48ZHQfBRCUONBa6azT1FcrHyWMqAgAAd04o=
Date: Fri, 12 Jul 2024 04:00:21 +0000
Message-ID: <8f1389fd3d8a4e26953643e10ab7a33d@ti.com>
References: <20240711132001.2792-1-baojun.xu@ti.com>,<CAMuHMdUw+KEGuAOWApfiLJF6b1M8pkoX+u+Q2dEVMqjV0_K34g@mail.gmail.com>
In-Reply-To: <CAMuHMdUw+KEGuAOWApfiLJF6b1M8pkoX+u+Q2dEVMqjV0_K34g@mail.gmail.com>
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

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIGFuc3dlciBpbiBsaW5lLg0KDQpC
ZXN0IFJlZ2FyZHMNCkppbQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBT
ZW50OiAxMiBKdWx5IDIwMjQgMDU6MDUNCj4gVG86IFh1LCBCYW9qdW4NCj4gQ2M6IHRpd2FpQHN1
c2UuZGU7IHJvYmgrZHRAa2VybmVsLm9yZzsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBwZXJleEBwZXJleC5jejsgcGllcnJlLWxvdWlzLmJv
c3NhcnRAbGludXguaW50ZWwuY29tOyBMdSwgS2V2aW47IERpbmcsIFNoZW5naGFvOyBOYXZhZGEg
S2FueWFuYSwgTXVrdW5kOyAxMzkxNjI3NTIwNkAxMzkuY29tOyBIYW1waWhvbGksIFZhbGxhYmhh
OyBQIE8sIFZpamV0aDsgSG9sYWx1IFlvZ2VuZHJhLCBOaXJhbmphbjsgYWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaWFtLnIuZ2lyZHdv
b2RAaW50ZWwuY29tOyB5dW5nLWNodWFuLmxpYW9AbGludXguaW50ZWwuY29tOyBicm9vbmllQGtl
cm5lbC5vcmc7IHNveWVyQGlybC5odQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0gg
djldIEFMU0E6IGhkYS90YXMyNzgxOiBBZGQgdGFzMjc4MSBoZGEgU1BJIGRyaXZlcg0KPiANCj4g
SGkgQmFvanVuLCBPbiBUaHUsIEp1bCAxMSwgMjAyNCBhdCAzOuKAijIyIFBNIEJhb2p1biBYdSA8
YmFvanVuLuKAinh1QOKAinRpLuKAimNvbT4gd3JvdGU6ID4gVGhpcyBwYXRjaCB3YXMgdXNlZCB0
byBhZGQgVEFTMjc4MSBkZXZpY2VzIG9uIFNQSSBzdXBwb3J0IGluIHNvdW5kL3BjaS9oZGEuID4g
SXQgdXNlIEFDUEkgbm9kZSBkZXNjcmlwdCBhYm91dCBwYXJhbWV0ZXJzIG9mIFRBUzI3ODEgb24g
U1BJLCBpdCBsaWtlOuKAig0KPiBaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQNCj4gVGhpcyBtZXNz
YWdlIHdhcyBzZW50IGZyb20gb3V0c2lkZSBvZiBUZXhhcyBJbnN0cnVtZW50cy4NCj4gRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhl
IHNvdXJjZSBvZiB0aGlzIGVtYWlsIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuIElmIHlv
dSB3aXNoIHRvIHJlcG9ydCB0aGlzIG1lc3NhZ2UgdG8gSVQgU2VjdXJpdHksIHBsZWFzZSBmb3J3
YXJkIHRoZSBtZXNzYWdlIGFzIGFuIGF0dGFjaG1lbnQgdG8gcGhpc2hpbmdAbGlzdC50aS5jb20N
Cj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gDQo+IEhpIEJhb2p1biwNCj4gDQo+IE9u
IFRodSwgSnVsIDExLCAyMDI0IGF0IDM6MjLigK9QTSBCYW9qdW4gWHUgPGJhb2p1bi54dUB0aS5j
b20+IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggd2FzIHVzZWQgdG8gYWRkIFRBUzI3ODEgZGV2aWNl
cyBvbiBTUEkgc3VwcG9ydCBpbiBzb3VuZC9wY2kvaGRhLg0KPiA+IEl0IHVzZSBBQ1BJIG5vZGUg
ZGVzY3JpcHQgYWJvdXQgcGFyYW1ldGVycyBvZiBUQVMyNzgxIG9uIFNQSSwgaXQgbGlrZToNCj4g
PiAgICAgU2NvcGUgKF9TQi5QQzAwLlNQSTApDQo+ID4gICAgIHsNCj4gPiAgICAgICAgIERldmlj
ZSAoR1NQSykNCj4gPiAgICAgICAgIHsNCj4gPiAgICAgICAgICAgICBOYW1lIChfSElELCAiVFhO
VzI3ODEiKSAgLy8gX0hJRDogSGFyZHdhcmUgSUQNCj4gPiAgICAgICAgICAgICBNZXRob2QgKF9D
UlMsIDAsIE5vdFNlcmlhbGl6ZWQpDQo+ID4gICAgICAgICAgICAgew0KPiA+ICAgICAgICAgICAg
ICAgICBOYW1lIChSQlVGLCBSZXNvdXJjZVRlbXBsYXRlICgpDQo+ID4gICAgICAgICAgICAgICAg
IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgIFNwaVNlcmlhbEJ1c1YyICguLi4pDQo+ID4gICAg
ICAgICAgICAgICAgICAgICBTcGlTZXJpYWxCdXNWMiAoLi4uKQ0KPiA+ICAgICAgICAgICAgICAg
ICB9DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4NCj4g
PiBBbmQgaW4gcGxhdGZvcm0veDg2L3NlcmlhbC1tdWx0aS1pbnN0YW50aWF0ZS5jLCB0aG9zZSBz
cGkgZGV2aWNlcyB3aWxsIGJlDQo+ID4gYWRkZWQgaW50byBzeXN0ZW0gYXMgYSBzaW5nbGUgU1BJ
IGRldmljZSwgc28gVEFTMjc4MSBTUEkgZHJpdmVyIHdpbGwNCj4gPiBwcm9iZSB0d2ljZSBmb3Ig
ZXZlcnkgc2luZ2xlIFNQSSBkZXZpY2UuIEFuZCBkcml2ZXIgd2lsbCBhbHNvIHBhcnNlcg0KPiA+
IG1vbm8gRFNQIGZpcm13YXJlIGJpbmFyeSBhbmQgUkNBIGJpbmFyeSBmb3IgaXRzZWxmLg0KPiA+
IFRoZSBjb2RlIHN1cHBvcnQgUmVhbHRlayBhcyB0aGUgcHJpbWFyeSBjb2RlYy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJhb2p1biBYdSA8YmFvanVuLnh1QHRpLmNvbT4NCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvc291bmQvcGNpL2hkYS90YXMyNzgxX2hkYV9zcGkuYw0KPiANCj4g
VGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiArLyogZml4ZWQgbTY4ayBjb21waWxpbmcg
aXNzdWU6IG1hcHBpbmcgdGFibGUgY2FuIHNhdmUgY29kZSBmaWVsZCAqLw0KPiA+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGJsa3R5cF9kZXZpZHhfbWFwIHBwYzNfdGFzMjc4MV9tYXBwaW5nX3RhYmxl
W10gPSB7DQo+IA0KPiA+ICsvKiBmaXhlZCBtNjhrIGNvbXBpbGluZyBpc3N1ZTogbWFwcGluZyB0
YWJsZSBjYW4gc2F2ZSBjb2RlIGZpZWxkICovDQo+ID4gK3N0YXRpYyB1bnNpZ25lZCBjaGFyIG1h
cF9kZXZfaWR4KHN0cnVjdCB0YXNkZXZpY2VfZncgKnRhc19mbXcsDQo+ID4gKyAgICAgICBzdHJ1
Y3QgdGFzZGV2X2JsayAqYmxvY2spDQo+IA0KPiA+ICsvKiBCbG9jayBwYXJzZXIgZnVuY3Rpb24u
ICovDQo+ID4gK3N0YXRpYyBpbnQgZndfcGFyc2VfYmxvY2tfZGF0YV9rZXJuZWwoc3RydWN0IHRh
c2RldmljZV9mdyAqdGFzX2ZtdywNCj4gPiArICAgICAgIHN0cnVjdCB0YXNkZXZfYmxrICpibG9j
aywgY29uc3Qgc3RydWN0IGZpcm13YXJlICpmbXcsIGludCBvZmZzZXQpDQo+ID4gK3sNCj4gDQo+
ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogRml4ZWQgbTY4ayBjb21waWxpbmcgaXNzdWU6
DQo+ID4gKyAgICAgICAgKiAxLiBtYXBwaW5nIHRhYmxlIGNhbiBzYXZlIGNvZGUgZmllbGQuDQo+
ID4gKyAgICAgICAgKiAyLiBzdG9yaW5nIHRoZSBkZXZfaWR4IGFzIGEgbWVtYmVyIG9mIGJsb2Nr
IGNhbiByZWR1Y2UgdW5uZWNlc3NhcnkNCj4gPiArICAgICAgICAqICAgIHRpbWUgYW5kIHN5c3Rl
bSByZXNvdXJjZSBjb21zdW1wdGlvbiBvZiBkZXZfaWR4IG1hcHBpbmcgZXZlcnkNCj4gPiArICAg
ICAgICAqICAgIHRpbWUgdGhlIGJsb2NrIGRhdGEgd3JpdGluZyB0byB0aGUgZHNwLg0KPiA+ICsg
ICAgICAgICovDQo+IA0KPiBEbyB3ZSByZWFsbHkgbmVlZCBtb3JlIGNvcGllcyBvZiB0aGlzPw0K
PiBTZWUgc291bmQvc29jL2NvZGVjcy90YXMyNzgxLWZtd2xpYi5jLg0KPiANCg0KWWVzLCBpdCdz
IHBhcnNlciBpcyBzaW1pbGFyLCBidXQgZm9yIFNQSSBkZXZpY2UsIHdpbGwgcGFyc2VyIHNpbmds
ZSBkZXZpY2UNCmZpcm13YXJlIGJpbmFyeSBmaWxlIGZvciBvd24gb25seSwgYW5kIGZvciBJMkMs
IHBhcnNlciBzdXBwb3J0IG11bHRpIGRldmljZXMNCmZpcm13YXJlIGJpbmFyeSBmaWxlLCBpZiB1
c2Ugc2FtZSBsaWIgZnVuY3Rpb25zLCBuZWVkIGFkZCBtYW55IGNvZGUgZm9yIGNoZWNrLg0KDQo+
IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQN
Cj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXgg
YmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNv
bnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2Vy
LiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9n
cmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo+IA0KPiANCg==

