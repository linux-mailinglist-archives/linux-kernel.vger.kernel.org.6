Return-Path: <linux-kernel+bounces-191672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8658D1271
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711F61C21480
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184E13FEE;
	Tue, 28 May 2024 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fR08/BQr"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8E33C8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865902; cv=none; b=DERmpcsdHF/hFiSTQi1d8bHKzIQSHQMUQolMIcXFqnRi9Pw6TeJUU6YFmR7YI6VLqovYfC1IErlaU3sNH3C7ng2YSG6TxsUPuwo9CUnqOW8aZw7DShZHO6ttQrpFzAHc0o8kPsyDu2DoDGRsDyfIiKmX7oAcR/fH0tPbk0Z6sv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865902; c=relaxed/simple;
	bh=eEsT4srTKRGe7+Ko1C0Nkp4GuVM6zi/qIdwWkNqxv9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1Md09ODE5BTdbVy+vWNJsCOgdms43Jzdwbi+rZJFqb46HrCaL1RyeuEkMjfIvILmvito7JwBq+81SnTS/X+VFkMnsvrnbJBRg79iJpdsCuoH4iruKNTh8KfhYKQH9jFz06QlTTmm1B61H5yNOLmdZXCceUJ+iJY5hSU5iMM4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fR08/BQr; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S3ALGB027334;
	Mon, 27 May 2024 22:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716865821;
	bh=eEsT4srTKRGe7+Ko1C0Nkp4GuVM6zi/qIdwWkNqxv9M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=fR08/BQrpOqaEF4dHN8UYTDRRhmjUhwfQweBtwBN3RqINxzL4zg7DIACKR4GX5Jb3
	 gk7FGT40SxL8oiP7l3LnbHFft0rFYeDNGyI0CqEniSVnF9EPRWKa9/apCyGbvNSlWk
	 yyZu249yoRwfbLS2ar4JUxgv6611Ha96fZDvl5eQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S3ALK4126245
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 22:10:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 22:10:21 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Mon, 27 May 2024 22:10:21 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "13916275206@139.com" <13916275206@139.com>,
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
        "Rao, Dipa" <dipa@ti.com>, "Lu, Kevin"
	<kevin-lu@ti.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        "tiwai@suse.de"
	<tiwai@suse.de>, "Xu, Baojun" <baojun.xu@ti.com>,
        "soyer@irl.hu"
	<soyer@irl.hu>,
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
        "judyhsiao@google.com" <judyhsiao@google.com>,
        "cujomalainey@google.com"
	<cujomalainey@google.com>,
        "Kutty, Aanya" <aanya@ti.com>,
        "Mahmud, Nayeem"
	<nayeem.mahmud@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] ASoc: tas2781: Playback can work when
 only RCA binary loading without dsp firmware loading
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ASoc: tas2781: Playback can work when
 only RCA binary loading without dsp firmware loading
Thread-Index: AQHarkWK7iKbbU+59EqlRKOrGPAfoLGrbykAgABlWfA=
Date: Tue, 28 May 2024 03:10:21 +0000
Message-ID: <a9c424859b8544fa8ae56b7a30150317@ti.com>
References: <20240525014727.197-1-shenghao-ding@ti.com>
 <6a8ab4f6-63be-4284-814a-d853faf000b5@linux.intel.com>
In-Reply-To: <6a8ab4f6-63be-4284-814a-d853faf000b5@linux.intel.com>
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

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51
eC5pbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDI3LCAyMDI0IDk6NDQgUE0NCj4gVG86
IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1kaW5nQHRpLmNvbT47IGJyb29uaWVAa2VybmVsLm9y
Zw0KPiBDYzogYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBsZ2lyZHdvb2RAZ21h
aWwuY29tOw0KPiBwZXJleEBwZXJleC5jejsgMTM5MTYyNzUyMDZAMTM5LmNvbTsgYWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnOw0KPiBTYWxhemFyLCBJdmFuIDxpLXNhbGF6YXJAdGkuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2hhZGhhLA0KPiBKYXNqb3QgU2luZ2ggPGot
Y2hhZGhhQHRpLmNvbT47IGxpYW0uci5naXJkd29vZEBpbnRlbC5jb207IFl1ZSwgSmFkZW4NCj4g
PGphZGVuLXl1ZUB0aS5jb20+OyB5dW5nLWNodWFuLmxpYW9AbGludXguaW50ZWwuY29tOyBSYW8s
IERpcGENCj4gPGRpcGFAdGkuY29tPjsgTHUsIEtldmluIDxrZXZpbi1sdUB0aS5jb20+OyB5dWhz
dWFuQGdvb2dsZS5jb207DQo+IHRpd2FpQHN1c2UuZGU7IFh1LCBCYW9qdW4gPGJhb2p1bi54dUB0
aS5jb20+OyBzb3llckBpcmwuaHU7DQo+IEJhb2p1bi5YdUBmcHQuY29tOyBqdWR5aHNpYW9AZ29v
Z2xlLmNvbTsgTmF2YWRhIEthbnlhbmEsIE11a3VuZA0KPiA8bmF2YWRhQHRpLmNvbT47IGN1am9t
YWxhaW5leUBnb29nbGUuY29tOyBLdXR0eSwgQWFueWENCj4gPGFhbnlhQHRpLmNvbT47IE1haG11
ZCwgTmF5ZWVtIDxuYXllZW0ubWFobXVkQHRpLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIHYyXSBBU29jOiB0YXMyNzgxOiBQbGF5YmFjayBjYW4gd29yayB3aGVuDQo+IG9u
bHkgUkNBIGJpbmFyeSBsb2FkaW5nIHdpdGhvdXQgZHNwIGZpcm13YXJlIGxvYWRpbmcNCj4gDQo+
IA0KPiANCj4gT24gNS8yNC8yNCAyMDo0NywgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPiBJbiBv
bmx5IFJDQSBiaW5hcnkgbG9hZGluZyBjYXNlLCBvbmx5IGRlZmF1bHQgZHNwIHByb2dyYW0gaW5z
aWRlIHRoZQ0KPiA+IGNoaXAgd2lsbCBiZSB3b3JrLg0KPiANCj4gV2hhdCBkb2VzICdSQ0EnIHN0
YW5kIGZvcj8NClJlY29uZmlndXJhYmxlIGFyY2hpdGVjdHVyZSBiaW5hcnkgZmlsZQ0KPiANCj4g
QWxzbyBjbGFyaWZ5IHRoZSBjb21taXQgdGl0bGUgd2l0aG91dCBkb3VibGUgbmVnYXRpdmVzLCBl
LmcuDQo+IA0KPiAiRW5hYmxlIFJDQS1iYXNlZCBwbGF5YmFjayB3aXRob3V0IERTUCBmaXJtd2Fy
ZSBkb3dubG9hZCINCj4gPiAtCWlmICh0YXNfcHJpdi0+Zndfc3RhdGUgPT0gVEFTREVWSUNFX0RT
UF9GV19GQUlMKSB7DQo+ID4gLQkJZGV2X2Vycih0YXNfcHJpdi0+ZGV2LCAiRFNQIGJpbiBmaWxl
IG5vdCBsb2FkZWRcbiIpOw0KPiA+ICsJLyoNCj4gPiArCSAqIE9ubHkgUkNBIGZpbGUgbG9hZGVk
IGNhbiBzdGlsbCB3b3JrIHdpdGggZGVmYXVsdCBkc3AgcHJvZ3JhbSBpbnNpZGUNCj4gPiArCSAq
IHRoZSBjaGlwPw0KPiANCj4gcmV3b3JkIHRoZSBjb21taXQgYW5kIHJlbW92ZSBxdWVzdGlvbiBt
YXJrLg0KYWNjZXB0DQo+IA0KPiA+ICsJICovDQo+ID4gKwlpZiAoISh0YXNfcHJpdi0+Zndfc3Rh
dGUgPT0gVEFTREVWSUNFX1JDQV9GV19PSyB8fA0KPiA+ICsJCXRhc19wcml2LT5md19zdGF0ZSA9
PSBUQVNERVZJQ0VfRFNQX0ZXX0FMTF9PSykpIHsNCj4gPiArCQlkZXZfZXJyKHRhc19wcml2LT5k
ZXYsICJObyBmaXJtd2FyZSBsb2FkZWRcbiIpOw0KPiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4g
Pg0KPiA+ICAJaWYgKHN0YXRlID09IDApIHsNCj4gPiAtCQlpZiAodGFzX3ByaXYtPmN1cl9wcm9n
IDwgdGFzX2Ztdy0+bnJfcHJvZ3JhbXMpIHsNCj4gPiArCQlpZiAodGFzX2ZtdyAmJiB0YXNfcHJp
di0+Y3VyX3Byb2cgPCB0YXNfZm13LT5ucl9wcm9ncmFtcykNCj4gew0KPiA+ICAJCQkvKmRzcCBt
b2RlIG9yIHR1bmluZyBtb2RlKi8NCj4gDQo+IHNwYWNlcyBpbiBjb21tZW50cw0KYWNjZXB0DQo+
IA0KPiA+ICAJCQlwcm9maWxlX2NmZ19pZCA9IHRhc19wcml2LT5yY2FiaW4ucHJvZmlsZV9jZmdf
aWQ7DQo+ID4gIAkJCXRhc2RldmljZV9zZWxlY3RfdHVuaW5ncHJtX2NmZyh0YXNfcHJpdiwNCj4g
PiBAQCAtMjM0MCw5ICsyMzQ1LDEwIEBAIHZvaWQgdGFzZGV2aWNlX3R1bmluZ19zd2l0Y2godm9p
ZCAqY29udGV4dCwgaW50DQo+ID4gc3RhdGUpDQo+ID4NCj4gPiAgCQl0YXNkZXZpY2Vfc2VsZWN0
X2NmZ19ibGsodGFzX3ByaXYsIHByb2ZpbGVfY2ZnX2lkLA0KPiA+ICAJCQlUQVNERVZJQ0VfQklO
X0JMS19QUkVfUE9XRVJfVVApOw0KPiA+IC0JfSBlbHNlDQo+ID4gKwl9IGVsc2Ugew0KPiA+ICAJ
CXRhc2RldmljZV9zZWxlY3RfY2ZnX2Jsayh0YXNfcHJpdiwgcHJvZmlsZV9jZmdfaWQsDQo+ID4g
IAkJCVRBU0RFVklDRV9CSU5fQkxLX1BSRV9TSFVURE9XTik7DQo+ID4gKwl9DQo+ID4gIH0NCj4g
PiAgRVhQT1JUX1NZTUJPTF9OU19HUEwodGFzZGV2aWNlX3R1bmluZ19zd2l0Y2gsDQo+ID4gIAlT
TkRfU09DX1RBUzI3ODFfRk1XTElCKTsNCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVj
cy90YXMyNzgxLWkyYy5jDQo+ID4gYi9zb3VuZC9zb2MvY29kZWNzL3RhczI3ODEtaTJjLmMgaW5k
ZXggOTM1MDk3MmRmZWZlLi5jY2I5MzEzYWRhOWINCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9zb3Vu
ZC9zb2MvY29kZWNzL3RhczI3ODEtaTJjLmMNCj4gPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3Rh
czI3ODEtaTJjLmMNCj4gPiBAQCAtMzgwLDIzICszODAsMzAgQEAgc3RhdGljIHZvaWQgdGFzZGV2
aWNlX2Z3X3JlYWR5KGNvbnN0IHN0cnVjdA0KPiBmaXJtd2FyZSAqZm13LA0KPiA+ICAJbXV0ZXhf
bG9jaygmdGFzX3ByaXYtPmNvZGVjX2xvY2spOw0KPiA+DQo+ID4gIAlyZXQgPSB0YXNkZXZpY2Vf
cmNhX3BhcnNlcih0YXNfcHJpdiwgZm13KTsNCj4gPiAtCWlmIChyZXQpDQo+ID4gKwlpZiAocmV0
KSB7DQo+ID4gKwkJdGFzZGV2aWNlX2NvbmZpZ19pbmZvX3JlbW92ZSh0YXNfcHJpdik7DQo+ID4g
IAkJZ290byBvdXQ7DQo+ID4gKwl9DQo+ID4gIAl0YXNkZXZpY2VfY3JlYXRlX2NvbnRyb2wodGFz
X3ByaXYpOw0KPiA+DQo+ID4gIAl0YXNkZXZpY2VfZHNwX3JlbW92ZSh0YXNfcHJpdik7DQo+ID4g
IAl0YXNkZXZpY2VfY2FsYmluX3JlbW92ZSh0YXNfcHJpdik7DQo+ID4gLQl0YXNfcHJpdi0+Zndf
c3RhdGUgPSBUQVNERVZJQ0VfRFNQX0ZXX1BFTkRJTkc7DQo+ID4gKwl0YXNfcHJpdi0+Zndfc3Rh
dGUgPSBUQVNERVZJQ0VfUkNBX0ZXX09LOw0KPiA+ICAJc2NucHJpbnRmKHRhc19wcml2LT5jb2Vm
X2JpbmFyeW5hbWUsIDY0LCAiJXNfY29lZi5iaW4iLA0KPiA+ICAJCXRhc19wcml2LT5kZXZfbmFt
ZSk7DQo+ID4gKw0KPiA+ICAJcmV0ID0gdGFzZGV2aWNlX2RzcF9wYXJzZXIodGFzX3ByaXYpOw0K
PiA+ICAJaWYgKHJldCkgew0KPiA+ICAJCWRldl9lcnIodGFzX3ByaXYtPmRldiwgImRzcGZ3IGxv
YWQgJXMgZXJyb3JcbiIsDQo+ID4gIAkJCXRhc19wcml2LT5jb2VmX2JpbmFyeW5hbWUpOw0KPiA+
IC0JCXRhc19wcml2LT5md19zdGF0ZSA9IFRBU0RFVklDRV9EU1BfRldfRkFJTDsNCj4gPiAgCQln
b3RvIG91dDsNCj4gPiAgCX0NCj4gPiAtCXRhc2RldmljZV9kc3BfY3JlYXRlX2N0cmxzKHRhc19w
cml2KTsNCj4gPiArDQo+ID4gKwlyZXQgPSB0YXNkZXZpY2VfZHNwX2NyZWF0ZV9jdHJscyh0YXNf
cHJpdik7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2Vycih0YXNfcHJpdi0+ZGV2LCAi
ZHNwIGNvbnRyb2xzIGVycm9yXG4iKTsNCj4gPiArCQlnb3RvIG91dDsNCj4gPiArCX0NCj4gDQo+
IHRoaXMgc2VlbXMgdW5yZWxhdGVkIHRvIHRoZSBib290IHByb2Nlc3M/IE1vdmUgdG8gYSBkaWZm
ZXJlbnQgcGF0Y2g/DQpJdCBpcyBhIHBhcnQgb2YgYm9vdCBwcm9jZXNzLCBpZiBubyBkc3AtcmVs
YXRlZCBrY29udHJvbCBjcmVhdGVkLCB0aGUgZHNwIHJlc291cmNlIHdpbGwgYmUgZnJlZWQuDQo+
IA0KPiA+DQo+ID4gIAl0YXNfcHJpdi0+Zndfc3RhdGUgPSBUQVNERVZJQ0VfRFNQX0ZXX0FMTF9P
SzsNCj4gPg0KPiA+IEBAIC00MTcsOSArNDI0LDggQEAgc3RhdGljIHZvaWQgdGFzZGV2aWNlX2Z3
X3JlYWR5KGNvbnN0IHN0cnVjdA0KPiBmaXJtd2FyZSAqZm13LA0KPiA+ICAJdGFzZGV2aWNlX3By
bWdfbG9hZCh0YXNfcHJpdiwgMCk7DQo+ID4gIAl0YXNfcHJpdi0+Y3VyX3Byb2cgPSAwOw0KPiA+
ICBvdXQ6DQo+ID4gLQlpZiAodGFzX3ByaXYtPmZ3X3N0YXRlID09IFRBU0RFVklDRV9EU1BfRldf
RkFJTCkgew0KPiA+IC0JCS8qSWYgRFNQIEZXIGZhaWwsIGtjb250cm9sIHdvbid0IGJlIGNyZWF0
ZWQgKi8NCj4gPiAtCQl0YXNkZXZpY2VfY29uZmlnX2luZm9fcmVtb3ZlKHRhc19wcml2KTsNCj4g
PiArCWlmICh0YXNfcHJpdi0+Zndfc3RhdGUgPT0gVEFTREVWSUNFX1JDQV9GV19PSykgew0KPiA+
ICsJCS8qSWYgRFNQIEZXIGZhaWwsIERTUCBrY29udHJvbCB3b24ndCBiZSBjcmVhdGVkICovDQo+
IA0KPiBJdCBsb29rcyBsaWtlIHlvdSdyZSBubyBsb25nZXIgdXNpbmcgUEVORElORyBhbmQgRkFJ
TCBzdGF0ZXM/DQo+IFRoZSBzdGF0ZSBtYWNoaW5lIGlzIGJlY29taW5nIHJlYWxseSBoYXJkIHRv
IGZvbGxvdy4NClJlbW92ZSB1bnVzZWQgc3RhdGVzLg0KPiANCj4gPiAgCQl0YXNkZXZpY2VfZHNw
X3JlbW92ZSh0YXNfcHJpdik7DQo+ID4gIAl9DQo+ID4gIAltdXRleF91bmxvY2soJnRhc19wcml2
LT5jb2RlY19sb2NrKTsNCj4gPiBAQCAtNDY2LDE0ICs0NzIsMTQgQEAgc3RhdGljIGludCB0YXNk
ZXZpY2Vfc3RhcnR1cChzdHJ1Y3QNCj4gPiBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCAg
ew0KPiA+ICAJc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb2RlYyA9IGRhaS0+Y29tcG9uZW50
Ow0KPiA+ICAJc3RydWN0IHRhc2RldmljZV9wcml2ICp0YXNfcHJpdiA9DQo+IHNuZF9zb2NfY29t
cG9uZW50X2dldF9kcnZkYXRhKGNvZGVjKTsNCj4gPiAtCWludCByZXQgPSAwOw0KPiA+DQo+ID4g
LQlpZiAodGFzX3ByaXYtPmZ3X3N0YXRlICE9IFRBU0RFVklDRV9EU1BfRldfQUxMX09LKSB7DQo+
ID4gLQkJZGV2X2Vycih0YXNfcHJpdi0+ZGV2LCAiRFNQIGJpbiBmaWxlIG5vdCBsb2FkZWRcbiIp
Ow0KPiA+IC0JCXJldCA9IC1FSU5WQUw7DQo+ID4gKwlpZiAoISh0YXNfcHJpdi0+Zndfc3RhdGUg
PT0gVEFTREVWSUNFX0RTUF9GV19BTExfT0sgfHwNCj4gPiArCQl0YXNfcHJpdi0+Zndfc3RhdGUg
PT0gVEFTREVWSUNFX1JDQV9GV19PSykpIHsNCj4gPiArCQlkZXZfZXJyKHRhc19wcml2LT5kZXYs
ICJCaW4gZmlsZSBub3QgbG9hZGVkXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAg
CX0NCj4gPg0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiArCXJldHVybiAwOw0KPiA+ICB9DQo+ID4N
Cj4gPiAgc3RhdGljIGludCB0YXNkZXZpY2VfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLA0K

