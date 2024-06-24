Return-Path: <linux-kernel+bounces-227147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C191490B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223071F24D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B713A878;
	Mon, 24 Jun 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KbPieSv+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B00139D03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229410; cv=none; b=RffSYBpdSsqh0JN1Wm2s7cmf6go3Gc6UPF7h/uhu3X5eKV0GuKE0hCsQ77LObB5y7j6ybgNIbmXLX7AhtBvF8uKVeMZpeiQv4DCVrotF48E/5EXrSkoekR4/oEDJb8yj0rHGJO153q1tpnBu24h6G5yAioy/X4npWahUX8/bqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229410; c=relaxed/simple;
	bh=SciTnTEbsnJfT0rVQqYl7Yj98yDLsD7kqr/o0jvFwCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3xeiu8Eb0Kva1myWw15Yq6Xh4Z4kCv9T3CIDAqzXRftQ0VnIgUGNgXdxQdml809hkiVxaItnEAoIB/1EvMQjU+HVVn2TMLq7VVekLQ5gVtwwXFEjQk2IsXIbVteOoa2JVRNega4rftuAJSEGGSNB+tluek2yv9ByfmdDG4ZDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KbPieSv+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45OBgChm044887;
	Mon, 24 Jun 2024 06:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719229332;
	bh=SciTnTEbsnJfT0rVQqYl7Yj98yDLsD7kqr/o0jvFwCQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=KbPieSv+fyXaLDsPihsQE+lhanZhEXOxmogN3J+6C+/jSM+vyMjVts3na99KzvAUj
	 oyH6k1ob3+uGbVD/5yL8VtFYSgAtq1eFKFTEMea8O0OxI/5nVBDk9H7E51U3G07C9G
	 iNRAUItZeS5fLPdF3HaeNEy71I6DY/aOOHf9iHGg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45OBgCJx004871
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 06:42:12 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 06:42:11 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Mon, 24 Jun 2024 06:42:11 -0500
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
        "judyhsiao@google.com" <judyhsiao@google.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Salazar, Ivan"
	<i-salazar@ti.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Chadha, Jasjot Singh" <j-chadha@ti.com>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "bard.liao@intel.com" <bard.liao@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "Rao,
 Dipa" <dipa@ti.com>, "yuhsuan@google.com" <yuhsuan@google.com>,
        "tiwai@suse.de" <tiwai@suse.de>, "Xu, Baojun" <baojun.xu@ti.com>,
        "soyer@irl.hu" <soyer@irl.hu>, "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "cujomalainey@google.com"
	<cujomalainey@google.com>,
        "Kutty, Aanya" <aanya@ti.com>,
        "Mahmud, Nayeem"
	<nayeem.mahmud@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add Calibration
 Kcontrols and tas2563 digtial gain for Chromebook
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add Calibration
 Kcontrols and tas2563 digtial gain for Chromebook
Thread-Index: AQHarDtfp06/EgvZKUCy2VuueNkSubGjev+AgDOBclA=
Date: Mon, 24 Jun 2024 11:42:11 +0000
Message-ID: <6b6a0af1e55241c4b2acde42e9966e3b@ti.com>
References: <20240522112942.994-1-shenghao-ding@ti.com>
 <Zk3eq0k2Eq-gtejq@smile.fi.intel.com>
In-Reply-To: <Zk3eq0k2Eq-gtejq@smile.fi.intel.com>
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

SGkgQW5keQ0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBGb2xsb3dpbmcgYXJlIG15IGFuc3dl
cnMuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hl
bmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgTWF5IDIyLCAyMDI0IDg6MDIgUE0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1k
aW5nQHRpLmNvbT4NCj4gQ2M6IGJyb29uaWVAa2VybmVsLm9yZzsgbGdpcmR3b29kQGdtYWlsLmNv
bTsgcGVyZXhAcGVyZXguY3o7IHBpZXJyZS0NCj4gbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5j
b207IDEzOTE2Mjc1MjA2QDEzOS5jb207DQo+IGp1ZHloc2lhb0Bnb29nbGUuY29tOyBhbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmc7IFNhbGF6YXIsIEl2YW4gPGktDQo+IHNhbGF6YXJAdGkuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2hhZGhhLCBKYXNqb3QgU2luZ2ggPGot
DQo+IGNoYWRoYUB0aS5jb20+OyBsaWFtLnIuZ2lyZHdvb2RAaW50ZWwuY29tOyBiYXJkLmxpYW9A
aW50ZWwuY29tOyB5dW5nLQ0KPiBjaHVhbi5saWFvQGxpbnV4LmludGVsLmNvbTsgUmFvLCBEaXBh
IDxkaXBhQHRpLmNvbT47IEx1LCBLZXZpbiA8a2V2aW4tDQo+IGx1QHRpLmNvbT47IHl1aHN1YW5A
Z29vZ2xlLmNvbTsgdGl3YWlAc3VzZS5kZTsgWHUsIEJhb2p1bg0KPiA8YmFvanVuLnh1QHRpLmNv
bT47IHNveWVyQGlybC5odTsgQmFvanVuLlh1QGZwdC5jb207IE5hdmFkYSBLYW55YW5hLA0KPiBN
dWt1bmQgPG5hdmFkYUB0aS5jb20+OyBjdWpvbWFsYWluZXlAZ29vZ2xlLmNvbTsgS3V0dHksIEFh
bnlhDQo+IDxhYW55YUB0aS5jb20+OyBNYWhtdWQsIE5heWVlbSA8bmF5ZWVtLm1haG11ZEB0aS5j
b20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MV0gQVNvYzogdGFzMjc4MTog
QWRkIENhbGlicmF0aW9uIEtjb250cm9scw0KPiBhbmQgdGFzMjU2MyBkaWd0aWFsIGdhaW4gZm9y
IENocm9tZWJvb2sNCj4gDQo+IE9uIFdlZCwgTWF5IDIyLCAyMDI0IGF0IDA3OuKAijI5OuKAijQx
UE0gKzA4MDAsIFNoZW5naGFvIERpbmcgd3JvdGU6ID4NCj4gQ2FsaWJyYXRlZCBkYXRhIHdpbGwg
YmUgc2V0IHRvIGRlZmF1bHQgYWZ0ZXIgbG9hZGluZyBEU1AgY29uZmlnIHBhcmFtcywgPg0KPiB3
aGljaCB3aWxsIGNhdXNlIHNwZWFrZXIgcHJvdGVjdGlvbiB3b3JrIGFibm9ybWFsbHkuIFJlbG9h
ZCBjYWxpYnJhdGVkID4NCj4gZGF0YSBhZnRlciBsb2FkaW5nIFpqUWNtUVJZRnBmcHRCYW5uZXJT
dGFydCBUaGlzIG1lc3NhZ2Ugd2FzIHNlbnQgZnJvbQ0KPiBvdXRzaWRlIG9mIFRleGFzIEluc3Ry
dW1lbnRzLg0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc291cmNlIG9mIHRoaXMNCj4gZW1haWwgYW5kIGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZS4gSWYgeW91IHdpc2ggdG8gcmVwb3J0IHRoaXMgbWVzc2FnZSB0byBJVA0K
PiBTZWN1cml0eSwgcGxlYXNlIGZvcndhcmQgdGhlIG1lc3NhZ2UgYXMgYW4gYXR0YWNobWVudCB0
bw0KPiBwaGlzaGluZ0BsaXN0LnRpLmNvbQ0KPiANCi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0K
PiA+ICsJd2hpbGUgKHIgPiAxICsgbCkgew0KPiA+ICsJCW1pZCA9IChsICsgcikgLyAyOw0KPiA+
ICsJCWFyX21pZCA9IGdldF91bmFsaWduZWRfYmUzMih0YXMyNTYzX2R2Y190YWJsZVttaWRdKTsN
Cj4gPiArCQlpZiAodGFyZ2V0IDwgYXJfbWlkKQ0KPiA+ICsJCQlyID0gbWlkOw0KPiA+ICsJCWVs
c2UNCj4gPiArCQkJbCA9IG1pZDsNCj4gPiArCX0NCj4gDQo+IEhtbS4uLiBJJ20gd29uZGVyaW5n
IGlmIGJzZWFyY2goKSBjYW4gYmUgdXRpbGlzZWQgaGVyZS4NCkJzZWFyY2ggaXMgdG8gZmluZCBv
dXQgdGhlIHZhbHVlLCBpbiB0aGlzIGZ1bmN0aW9uIGlzIHRvIGZpbmQgb3V0IHRoZSBtZW1iZXIg
c2FtZSBhcyBvciBjbG9zZXIgdG8gdGhlIGlucHV0IHZhbHVlLg0KDQo+IA0KPiAuLi4NCj4gDQo+
ID4gKwl1Y29udHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVswXSA9DQo+ID4gKwkJYWJzKHRhcmdl
dCAtIGFyX2wpIDw9IGFicyh0YXJnZXQgLSBhcl9yKSA/IGwgOiByOw0KPiANCj4gSSBkb24ndCB1
bmRlcnN0YW5kIHdoeSBkbyB5b3UgbmVlZCAndGFyZ2V0JyB0byBiZSBpbiB0aGlzIGNoZWNrLg0K
PiANCj4gLi4uDQo+IA0KPiA+ICsJdWluZm8tPnZhbHVlLmludGVnZXIubWF4ID0gKGludCl0YXNf
cHJpdi0+bmRldiAtIDE7DQo+IA0KPiBXaHkgY2FzdGluZz8NCj4gDQo+IC4uLg0KPiANCj4gPiAr
CXNjbnByaW50ZihhY3RpdmVfZGV2X25hbWUsIFNORFJWX0NUTF9FTEVNX0lEX05BTUVfTUFYTEVO
LA0KPiANCj4gV2h5ICdjJyB2YXJpYW50IGluIHVzZT8gWW91IGFyZSBpZ25vcmluZyB0aGUgcmV0
dXJuZWQgdmFsdWUuIElzbid0IHN0cnNjcHkoKSB5b3UNCj4gd2FudCBvciBtZW10b3N0cigpIChp
biBib3RoIGNhc2VzIDIgcGFyYW1ldGVycyB2YXJpYW50KT8NCj4gDQo+ID4gKwkJIkFjdGl2YXRl
IFRhc2RldmljZSBJZCIpOw0KPiANCj4gU2FtZSBRIHRvIGFsbCBzY25wcmludGYoKSBjYWxscy4N
Cj4gDQo+IC4uLg0KPiANCj4gPiArCWNhbGlfZGF0YS0+ZGF0YSA9IGRldm1fa3phbGxvYyh0YXNf
cHJpdi0+ZGV2LCB0YXNfcHJpdi0+bmRldiAqDQo+ID4gKwkJKGNhbGlfZGF0YS0+cmVnX2FycmF5
X3N6ICogNCArIDEpLCBHRlBfS0VSTkVMKTsNCj4gDQo+IE5vIHdheS4gRmlyc3Qgb2YgYWxsLCB3
ZSBoYXZlIGtjYWxsb2MoKSwgc2Vjb25kLCB0aGVyZSBpcyBhbiBvdmVyZmxvdy5oIHRoYXQgaGFz
DQo+IG5lY2Vzc2FyeSBtYWNyb3MgdG8gY2FsY3VsYXRlIHNpemVzIGZvciBtZW1vcnkgYWxsb2Nh
dGlvbnMuDQpNZW1vcnkgYWxsb2NhdGVkIHdpdGggZGV2bV9remFsbG9jIGlzIGF1dG9tYXRpY2Fs
bHkgZnJlZWQgb24gZHJpdmVyIGRldGFjaCB3aGlsZSBrY2FsbG9jIGNhbuKAmXQNCj4gDQo+ID4g
KwlpZiAoIWNhbGlfZGF0YS0+ZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gDQo+IC4u
Lg0KDQpCUg0KU2hlbmdoYW8gRGluZw0K

