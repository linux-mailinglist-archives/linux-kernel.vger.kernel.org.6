Return-Path: <linux-kernel+bounces-178347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B338C4C56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3097B28216C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029FE541;
	Tue, 14 May 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="euQya6Xp"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4FAD49
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668367; cv=none; b=Zpp37LjikmadPIz2pXW7pMuWwf62abJPSldchZNWZE19AB3LS6LssoJbvASHeNqXYMF3tWL7M3Xb1KkPx8YqufxA7BbxQTT1hZXI7voCEgYkdAhoLz6VgACdx+uTcQUbXJizKM+QdXG19E0S09yBmRtElpI1a9KYs4IkiUKi/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668367; c=relaxed/simple;
	bh=kBAcps8nyWv/1jmLqIvu/lxyDrTrvBsKKoN14C+MCRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BIqyHv0EVj7rTKYL9AUoyLi8kmhwoegDLPFGCghOxz4DXSgx7X8eHAl4ZmUauKjQXnw+gLnO2QQRLW1Atoxu6h1/bCHdAj/uV7gkF8kBah3A/6ulR01uC0+wuNei9A3sEn/oHCMhsHHQSA/pSsEN250SEIDXRx/zV7jqmJGTwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=euQya6Xp; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E6VMF9027337;
	Tue, 14 May 2024 01:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715668282;
	bh=kBAcps8nyWv/1jmLqIvu/lxyDrTrvBsKKoN14C+MCRU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=euQya6XpMYTG5ptwemU6BB43YtzDjBM2NtHxsHyFiCADBQhytzV+bgaVkEfSy8SL1
	 cyqzDt4uuoLViXhu4zTUq3pc11/UTV2WXYRlhp9YiVT/Izge+DRPNXOaaJtWxBl0NC
	 TKc4eSwj+e6Qj8aaFVgVg3aGsHzgvHlUsOT5R3CI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E6VMpD011074
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 01:31:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 01:31:22 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 14 May 2024 01:31:22 -0500
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
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "bard.liao@intel.com" <bard.liao@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "Lu,
 Kevin" <kevin-lu@ti.com>,
        "cameron.berkenpas@gmail.com"
	<cameron.berkenpas@gmail.com>,
        "tiwai@suse.de" <tiwai@suse.de>, "Xu, Baojun"
	<baojun.xu@ti.com>,
        "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com"
	<Baojun.Xu@fpt.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 2/3] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Thread-Topic: [EXTERNAL] Re: [PATCH v5 2/3] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Thread-Index: AQHapBc5leN0axZoFUGYCdnWILUBZLGVRDAAgAEC+0A=
Date: Tue, 14 May 2024 06:31:22 +0000
Message-ID: <d9dd889f18ec4265a50a2490d80999c2@ti.com>
References: <20240512025040.1276-1-shenghao-ding@ti.com>
 <20240512025040.1276-2-shenghao-ding@ti.com>
 <ZkHkjhxIZ8I0s3-D@smile.fi.intel.com>
In-Reply-To: <ZkHkjhxIZ8I0s3-D@smile.fi.intel.com>
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

SGkgQW5keQ0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDEzLCAyMDI0IDY6MDAgUE0NCj4gVG86
IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1kaW5nQHRpLmNvbT4NCj4gQ2M6IGJyb29uaWVAa2Vy
bmVsLm9yZzsgbGdpcmR3b29kQGdtYWlsLmNvbTsgcGVyZXhAcGVyZXguY3o7IHBpZXJyZS0NCj4g
bG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb207IDEzOTE2Mjc1MjA2QDEzOS5jb207IGFsc2Et
ZGV2ZWxAYWxzYS0NCj4gcHJvamVjdC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpYW0uci5naXJkd29vZEBpbnRlbC5jb207DQo+IGJhcmQubGlhb0BpbnRlbC5jb207IHl1bmct
Y2h1YW4ubGlhb0BsaW51eC5pbnRlbC5jb207IEx1LCBLZXZpbiA8a2V2aW4tDQo+IGx1QHRpLmNv
bT47IGNhbWVyb24uYmVya2VucGFzQGdtYWlsLmNvbTsgdGl3YWlAc3VzZS5kZTsgWHUsIEJhb2p1
bg0KPiA8YmFvanVuLnh1QHRpLmNvbT47IHNveWVyQGlybC5odTsgQmFvanVuLlh1QGZwdC5jb20N
Cj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHY1IDIvM10gQVNvQzogdGFzMjc4MTog
Rml4IHdyb25nIGxvYWRpbmcNCj4gY2FsaWJyYXRlZCBkYXRhIHNlcXVlbmNlDQo+IA0KPiBPbiBT
dW4sIE1heSAxMiwgMjAyNCBhdCAxMDo1MDozOEFNICswODAwLCBTaGVuZ2hhbyBEaW5nIHdyb3Rl
Og0KPiA+IENhbGlicmF0ZWQgZGF0YSB3aWxsIGJlIHNldCB0byBkZWZhdWx0IGFmdGVyIGxvYWRp
bmcgRFNQIGNvbmZpZw0KPiA+IHBhcmFtcywgd2hpY2ggd2lsbCBjYXVzZSBzcGVha2VyIHByb3Rl
Y3Rpb24gd29yayBhYm5vcm1hbGx5LiBSZWxvYWQNCj4gPiBjYWxpYnJhdGVkIGRhdGEgYWZ0ZXIg
bG9hZGluZyBEU1AgY29uZmlnIHBhcmFtcy4NCj4gDQo+IC4uLg0KPiANCj4gPiAtaW50IHRhc2Rl
dmljZV9wcm1nX2NhbGliZGF0YV9sb2FkKHZvaWQgKmNvbnRleHQsIGludCBwcm1fbm8pDQo+IA0K
PiA+IC1FWFBPUlRfU1lNQk9MX05TX0dQTCh0YXNkZXZpY2VfcHJtZ19jYWxpYmRhdGFfbG9hZCwN
Cj4gPiAtCVNORF9TT0NfVEFTMjc4MV9GTVdMSUIpOw0KPiANCj4gQUZBSUNTIHRoZSBpMmMgZ2x1
ZSBkcml2ZXIgc3RpbGwgdXNlcyB0aGlzLCBob3cgY2FuJ3QgdGhpcyBicmVhayB0aGUgYnVpbGQ/
DQpbUEFUQ0ggdjUgMy8zXSBoYXMgcmVtb3ZlZCB0YXNkZXZpY2VfcHJtZ19jYWxpYmRhdGFfbG9h
ZCwgYW5kIA0KdGFzZGV2aWNlX3BybWdfbG9hZCh0YXNfcHJpdiwgMCkgaGFzIGJlZW4gY2FsbGVk
IGluc3RlYWQgb2YgDQp0YXNkZXZpY2VfcHJtZ19jYWxpYmRhdGFfbG9hZA0KPiANCj4gLS0NCj4g
V2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCg0K

