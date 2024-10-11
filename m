Return-Path: <linux-kernel+bounces-360815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315699A01A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8E1F243E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ED620C495;
	Fri, 11 Oct 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UpF11a/5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A26EBE;
	Fri, 11 Oct 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638630; cv=none; b=Xy1g6hL3U+rE0hxA7eOEA3GcHstjxuwfpZCJ7RGyij6+0iKTVl/nu4Edst/9dm4HEhxHH5KOMpfeiwuYveLjQzngXpCjAoXIcd2RpPrQ0omCso9D/7H6FkBdvV7TwvUY81ZNHk4zth10BdYcztcWQ81OuafWizeXTdDkm/N6hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638630; c=relaxed/simple;
	bh=bXJbkDqwkqFmxR36muuqYpYdZ8ye/jUd3pK/VvxWOfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OIREfyiUlVf6aVgOXmHxfn4zeoOiwpygQtO3KdJBl1WPDyEwilUYQM7VeS9PFJLDBvj8VwckhqUlqWkXFge+ppeVIpDEMq/gwYDbmhNxlYgFVfgxrvdOxgB8s0SYoypkvEKzP69wF/Hd1u9O4QiCfUSmyJ/vBoFr9CydFVChnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UpF11a/5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49B9NaO5007643;
	Fri, 11 Oct 2024 04:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728638616;
	bh=bXJbkDqwkqFmxR36muuqYpYdZ8ye/jUd3pK/VvxWOfY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=UpF11a/5OpzjJG70/W6c2IvFTRcKq1QgZLf+sgFtSb7EwWtRF/iAXOUg/rWRNzCH4
	 pFhOEXhq5cycRDjWVwBAmajj8NYhEIQQPv31HY1ExpHBGyxhBhYVLMCI5Oup3ne4D5
	 LoXpv2cO8tX+4YYgXaDiBfmbmorFs9zeZ712oStU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49B9NacU002914
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 04:23:36 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 04:23:36 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Fri, 11 Oct 2024 04:23:35 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mario Limonciello <superm1@gmail.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: "Xu, Baojun" <baojun.xu@ti.com>,
        "derekjohn.clark@gmail.com"
	<derekjohn.clark@gmail.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "romangg@manjaro.org" <romangg@manjaro.org>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "Chen, Robin" <robinchen@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yi, Ken"
	<k-yi@ti.com>, "philm@manjaro.org" <philm@manjaro.org>,
        "jlobue10@gmail.com"
	<jlobue10@gmail.com>,
        "luke@ljones.dev" <luke@ljones.dev>,
        "antheas.dk@gmail.com" <antheas.dk@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] Upload dsp firmware for ASUS laptop
 1EB30 & 1EB31 and Update WHENCE for both
Thread-Topic: [EXTERNAL] Re: [PATCH v1] Upload dsp firmware for ASUS laptop
 1EB30 & 1EB31 and Update WHENCE for both
Thread-Index: AQHbGjSPgBpES4OxR0Wqg73tQY9Yj7J/oi0AgAA01PCAAHmfgIAAAmyAgAD1aIA=
Date: Fri, 11 Oct 2024 09:23:35 +0000
Message-ID: <3dbebac5b8404d3082a45cbe5610471f@ti.com>
References: <20241009101807.1473-1-shenghao-ding@ti.com>
 <d1941b10-0549-4a0e-a3fe-a8d7c50c175b@gmail.com>
 <7e138a1c8b6d4ace8c759bb2266216da@ti.com>
 <3ef8a82f-5e71-4386-90e1-f34222a60bdf@gmail.com>
 <50daaa7a-d590-4ae5-b33f-8f51d0c2f457@gmail.com>
In-Reply-To: <50daaa7a-d590-4ae5-b33f-8f51d0c2f457@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTWFyaW8NClRoYW5rcyBmb3IgeW91ciBzdXBwb3J0LiBGaW5hbGx5ICJtYWtlIGNoZWNrIiB3
b3JrcywgZm9sbG93aW5nIGlzIHRoZSBsb2cuDQoNCnJvb3RATEFQVE9QLTcwUko1QjhROi91c3Iv
bG9jYWwvc3JjL2Z3X25ldyMgbWFrZSBjaGVjaw0KIENoZWNrIHRoYXQgZXhlY3V0YWJsZXMgaGF2
ZSBzaGViYW5ncy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5QYXNzZWQNCiBG
b3JiaWQgbmV3IHN1Ym1vZHVsZXMuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uUGFzc2VkDQogQ2hlY2sgWWFtbC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLlBhc3NlZA0KIENoZWNrIGZv
ciBicm9rZW4gc3ltbGlua3MuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uKG5vIGZpbGVzIHRv
IGNoZWNrKVNraXBwZWQNCiBEZXRlY3QgRGVzdHJveWVkIFN5bWxpbmtzLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uUGFzc2VkDQogc2hlbGxjaGVjay4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
LlBhc3NlZA0KIGJsYWNrLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5QYXNzZWQNCiBtYXJrZG93bmxpbnQuLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5Ta2lwcGVk
DQogQ2hlY2sgd2hlbmNlLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLlBhc3NlZA0KIHJvb3RATEFQVE9QLTcwUko1QjhROi91c3IvbG9j
YWwvc3JjL2Z3X25ldyMNCg0KPiBPbiAxMC8xMC8yNCAwODozMCwgTWFyaW8gTGltb25jaWVsbG8g
d3JvdGU6DQo+ID4+IEFsdGhvdWdoIFRBUzJYWFgxRUIzMC5iaW4gYW5kIFRBUzJYWFgxRUIzMS5i
aW4gYXJlIGJvdGggaW4NCj4gPj4gdGkvdGFzMjc4MSwgeWV0IGl0IHJlcG9ydGVkICJkb2VzIG5v
dCBleGlzdCIuDQo+ID4+IEkgaGF2ZSBubyBpZGVhIHdoeSB0aGUgZmlsZSBpcyB0aGVyZSB3aGls
ZSByZXBvcnQgImRvZXMgbm90IGV4aXN0Ii4NCj4gPj4gQWZ0ZXIgSSByZW1vdmVkIHRoZSBuZXds
eS1tZXJnZWQsIG5vIHN1Y2ggcmVwb3J0Lg0KPiA+DQo+ID4gSSB0aGluayB5b3UgZm9yZ290IHRv
IGdpdCBhZGQgdGhlbSB0byB0aGUgY29tbWl0Pw0KPiA+DQo+ID4+DQouLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLg0KPiBJJ2xsIG1lcmdlIHRoaXMgYW5kIGlmIHlvdSBoYXZlIGFueSBm
b2xsb3cgdXBzIHlvdSBjYW4gZG8gdGhlbSBvbiB0b3AgYXMgZnV0dXJlDQo+IE1SIChwcmVmZXJy
ZWQhKSBvciBwYXRjaGVzIHRvIE0vTC4NCg0KSXQgc2VlbWVkIHRoYXQgSSB3YXMgbm90IHVzZWQg
dG8gc3VibWl0dGluZyBwYXRjaCB2aWEgZ2l0bGFiLiANClNvLCBmaW5hbGx5IEkgaGF2ZSB0byBz
dWJtaXQgdGhlIHBhdGNoIHRvIHRoZSBnaXQua2VybmVsLmNvbQ0KSSdsbCB0cnkgc3VibWl0dGlu
ZyBuZXh0IGZpcm13YXJlIGJpbmFyeSBmaWxlIHZpYSBHaXRsYWIuIFRoYW5rcy4NCg0KPiANCj4g
VGhhbmtzIQ0KDQo=

