Return-Path: <linux-kernel+bounces-198251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 166DE8D7599
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F60CB21073
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B63BBC1;
	Sun,  2 Jun 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ODN9Sujw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097410795
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333981; cv=none; b=M0KSTnISTZ9sCtVqLcCExiNYEXVvbiN+gNKIn1Q3zJqexCStq85J9wu7phSECeWKwkaKWO60Leb7p4omyg/Ci35EfA+DBoAzOMmqzb3kUm4PItQ7IneZbo82ptpx48Lo4MQq0hTWxvAh5gNe+Dfvk2OChZbo7Yho0m4acx/QYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333981; c=relaxed/simple;
	bh=R/MS50cxneOyPgLypSlTlanwb/Hbu1+mxf+65n/qBIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DX9We9j6kS+g3bIcLQfLLZ/LP/oAv9fa8MlA7GhFMrrzPOmvPPQbV5cHJEMm2QkIzOyT8NlL7lqq+sHNkfgYL7SUEKDV7VnBe5QilCiSDkx+JfEqhdwn94qozJf5jGOACRfjngfl1RnlyR5xgxzaYGA5bNiNGwQFyP3CA3Ijgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ODN9Sujw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 452DBe7I128155;
	Sun, 2 Jun 2024 08:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717333900;
	bh=R/MS50cxneOyPgLypSlTlanwb/Hbu1+mxf+65n/qBIg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=ODN9SujwZjd63tBgqBx13NPWEjtE7XSE43INcnk1eAnOKVu9CYcTzMUzdti73RLiW
	 scW4oOi1QzcPLh0UN2MxnsXOLAl9sK3JfEqgCMBSpve67IKSO1xcn78CXsAG0oFr4R
	 nZULGEVtUibpzf8MURnXd4gnvz0X28nPAmXaN37c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 452DBeWx029626
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Jun 2024 08:11:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Jun 2024 08:11:40 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Sun, 2 Jun 2024 08:11:40 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
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
        "tiwai@suse.de" <tiwai@suse.de>, "Xu, Baojun"
	<baojun.xu@ti.com>,
        "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com"
	<Baojun.Xu@fpt.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        "Yue, Jaden"
	<jaden-yue@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
        "Navada Kanyana, Mukund"
	<navada@ti.com>, "Hari, Raj" <s-hari@ti.com>,
        "zhourui@huaqin.com"
	<zhourui@huaqin.com>
Subject: RE: [EXTERNAL] Re: [PATCH v6] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Thread-Topic: [EXTERNAL] Re: [PATCH v6] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Thread-Index: AQHaqS31kPp1+e8rVkmNZkec74ALOLGg2NiAgBOuXWA=
Date: Sun, 2 Jun 2024 13:11:39 +0000
Message-ID: <138b621eeccc47329ec5fc808790667f@ti.com>
References: <20240518141546.1742-1-shenghao-ding@ti.com>
 <171623322336.94469.13172149100331733795.b4-ty@kernel.org>
In-Reply-To: <171623322336.94469.13172149100331733795.b4-ty@kernel.org>
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

SGkgQnJvd24NCk9uZSBvZiBteSBjdXN0b21lcnMgcmVxdWVzdGVkIHRhczI3ODEgZHJpdmVyIGlu
IGtlcm5lbCA2LjEwIHRvIGJlIG1lcmdlZCBpbnRvIGtlcm5lbCA2LjEuIA0KSSB3b25kZXJlZCBo
b3cgSSAgY2FuIGhhbmRsZSB0aGlzLiBNYXkgSSByZXN1Ym1pdCB0aGUgd2hvbGUgY29kZSBpbnRv
IGxhdGVzdCA2LjEgYnJhbmNoPw0KTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkuIFRoYW5r
cy4NCg0KQlINClNoZW5naGFvIERpbmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXkgMjEsIDIwMjQgMzoyNyBBTQ0KPiBUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRpbmdA
dGkuY29tPg0KPiBDYzogYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBsZ2lyZHdv
b2RAZ21haWwuY29tOw0KPiBwZXJleEBwZXJleC5jejsgcGllcnJlLWxvdWlzLmJvc3NhcnRAbGlu
dXguaW50ZWwuY29tOw0KPiAxMzkxNjI3NTIwNkAxMzkuY29tOyBhbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaWFtLnIuZ2lyZHdv
b2RAaW50ZWwuY29tOyBiYXJkLmxpYW9AaW50ZWwuY29tOw0KPiB5dW5nLWNodWFuLmxpYW9AbGlu
dXguaW50ZWwuY29tOyBMdSwgS2V2aW4gPGtldmluLWx1QHRpLmNvbT47DQo+IGNhbWVyb24uYmVy
a2VucGFzQGdtYWlsLmNvbTsgdGl3YWlAc3VzZS5kZTsgWHUsIEJhb2p1bg0KPiA8YmFvanVuLnh1
QHRpLmNvbT47IHNveWVyQGlybC5odTsgQmFvanVuLlh1QGZwdC5jb20NCj4gU3ViamVjdDogW0VY
VEVSTkFMXSBSZTogW1BBVENIIHY2XSBBU29DOiB0YXMyNzgxOiBGaXggd3JvbmcgbG9hZGluZw0K
PiBjYWxpYnJhdGVkIGRhdGEgc2VxdWVuY2UNCj4gDQouLi4NCj4gSWYgYW55IHVwZGF0ZXMgYXJl
IHJlcXVpcmVkIG9yIHlvdSBhcmUgc3VibWl0dGluZyBmdXJ0aGVyIGNoYW5nZXMgdGhleQ0KPiBz
aG91bGQgYmUgc2VudCBhcyBpbmNyZW1lbnRhbCB1cGRhdGVzIGFnYWluc3QgY3VycmVudCBnaXQs
IGV4aXN0aW5nIHBhdGNoZXMNCj4gd2lsbCBub3QgYmUgcmVwbGFjZWQuDQo+IA0KPiBQbGVhc2Ug
YWRkIGFueSByZWxldmFudCBsaXN0cyBhbmQgbWFpbnRhaW5lcnMgdG8gdGhlIENDcyB3aGVuIHJl
cGx5aW5nIHRvIHRoaXMNCj4gbWFpbC4NCj4gDQo+IFRoYW5rcywNCj4gTWFyaw0KDQo=

