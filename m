Return-Path: <linux-kernel+bounces-358872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745439984F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB382B21887
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7531C2DD0;
	Thu, 10 Oct 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WCieGJKD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8BF9CB;
	Thu, 10 Oct 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559777; cv=none; b=gfZc/szv3Cw1onUoua6JGXfWLjSaDFvxF40lQf6jQbLwrNFLLM51UnOTYqzUdyy0bwZUcDccxjZi+6/ApH57CF2vuD6pxLpc1jwz//nHo1rH5ovqRIJl2t2+xUQK1HiqDQ6C1Uyb3ZRocBOpXLn2msx9SVmr0it60L21yVQnLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559777; c=relaxed/simple;
	bh=KMk+GsJubql3OxQoN/o6uiwjvaKjSDie6UzXe+7HzIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eP72kHOgPFBXmhJhJ3Wj17oq0Rx24KhfD0USWMtKMiAJErOl9rVJANXmGKnc4n3YtyGSg4PPM2v4bKpO9i/4pxMKa2WGqnkPUNMxSjLnkmHWZBcLXFO8mThMl+qrVoxCGYXOI/5VSS99PcEmecVs8+8Vkd/R8HS4emwo76wtQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WCieGJKD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ABT3KV050502;
	Thu, 10 Oct 2024 06:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728559743;
	bh=KMk+GsJubql3OxQoN/o6uiwjvaKjSDie6UzXe+7HzIs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=WCieGJKD+93u5GTZYFpCgXT2q2XcTmlvRzwlber0GwKiExzpwssRIhmQb0A+Wim7Q
	 Qcxl2C0aiNifvrtVOCln1FwAh3WJQbDiNCuTNMlHYzDF+noBep2eDKf/tlCHOGu0Xr
	 Mdb3l5wL7cKLnVZkC5/MG7RaPH9IM+kd+0i4cHzU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ABT3UU094511;
	Thu, 10 Oct 2024 06:29:03 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 06:29:02 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 10 Oct 2024 06:29:02 -0500
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
Thread-Index: AQHbGjSPgBpES4OxR0Wqg73tQY9Yj7J/oi0AgAA01PA=
Date: Thu, 10 Oct 2024 11:29:02 +0000
Message-ID: <7e138a1c8b6d4ace8c759bb2266216da@ti.com>
References: <20241009101807.1473-1-shenghao-ding@ti.com>
 <d1941b10-0549-4a0e-a3fe-a8d7c50c175b@gmail.com>
In-Reply-To: <d1941b10-0549-4a0e-a3fe-a8d7c50c175b@gmail.com>
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

SGkgTWFyaW8NClRoYW5rcyBmb3IgcmV2aWV3LCBJIG1ldCBzb21lIHRyb3VibGUgb24gIm1ha2Ug
Y2hlY2siLiAgS2luZGx5IGRvIG1lIGEgZmF2b3IuDQpUaGUgZGV0YWlsIGlzIGlubGluZS4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8
c3VwZXJtMUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDEwLCAyMDI0IDEx
OjA2IEFNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+OyBsaW51
eC1maXJtd2FyZUBrZXJuZWwub3JnDQo+IENjOiBYdSwgQmFvanVuIDxiYW9qdW4ueHVAdGkuY29t
PjsgZGVyZWtqb2huLmNsYXJrQGdtYWlsLmNvbTsNCj4gMTM5MTYyNzUyMDZAMTM5LmNvbTsgcm9t
YW5nZ0BtYW5qYXJvLm9yZzsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOw0KPiBDaGVuLCBS
b2JpbiA8cm9iaW5jaGVuQHRpLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFlp
LCBLZW4gPGstDQo+IHlpQHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0
aS5jb20+OyBwaGlsbUBtYW5qYXJvLm9yZzsNCj4gamxvYnVlMTBAZ21haWwuY29tOyBsdWtlQGxq
b25lcy5kZXY7IGFudGhlYXMuZGtAZ21haWwuY29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6
IFtQQVRDSCB2MV0gVXBsb2FkIGRzcCBmaXJtd2FyZSBmb3IgQVNVUyBsYXB0b3ANCj4gMUVCMzAg
JiAxRUIzMSBhbmQgVXBkYXRlIFdIRU5DRSBmb3IgYm90aA0KPiANCj4gDQo+IE9uIDEwLzkvMjQg
MDU6MTgsIFNoZW5naGFvIERpbmcgd3JvdGU6DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmdoYW8g
RGluZyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+DQo+ID4gLS0tDQo+ID4gICBXSEVOQ0UgICAgICAg
ICAgICAgICAgICAgICB8ICAgNCArKysrDQo+ID4gICB0aS90YXMyNzgxL1RBUzJYWFgyMjM0LmJp
biB8IEJpbg0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiAgIG1v
ZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgdGkvdGFzMjc4MS9UQVMyWFhYMjIzNC5iaW4NCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9XSEVOQ0UgYi9XSEVOQ0UNCj4gPiBpbmRleCBhOWM4YmI1Li4w
MDA5NmViIDEwMDY0NA0KPiA+IC0tLSBhL1dIRU5DRQ0KPiA+ICsrKyBiL1dIRU5DRQ0KPiA+IEBA
IC03NDg3LDYgKzc0ODcsOCBAQCBPcmlnaW5hdGVzIGZyb20NCj4gSGVsbG8sDQo+IA0KPiBJIHRy
aWVkIHRvIHByb2Nlc3MgdGhpcyBpbnRvIGEgTVIgb24gR2l0bGFiIGFuZCBpdCBmYWlsZWQgQ0ku
DQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRsYWIuY29tL2tl
cm5lbC1maXJtd2FyZS9saW51eC0NCj4gZmlybXdhcmUvLQ0KPiAvbWVyZ2VfcmVxdWVzdHMvMzEx
X187ISFHM3ZLIVRfZl9JR1hodG1TRlI3UDZVWVoxNDgwNVhfazhzZXFrM0c1Mzg2DQo+IDJsWFJK
c3NJd0tMczFIZWdjbjhOS01ucUM5VUdTUEdDWl9sWU9wb0RvJA0KPiANCj4gUGxlYXNlIHJ1biAn
bWFrZSBjaGVjaycgYmVmb3JlIHN1Ym1pdHRpbmcuDQpBbHRob3VnaCBUQVMyWFhYMUVCMzAuYmlu
IGFuZCBUQVMyWFhYMUVCMzEuYmluIGFyZSBib3RoIGluIHRpL3RhczI3ODEsIHlldCBpdCByZXBv
cnRlZCAiZG9lcyBub3QgZXhpc3QiLg0KSSBoYXZlIG5vIGlkZWEgd2h5IHRoZSBmaWxlIGlzIHRo
ZXJlIHdoaWxlIHJlcG9ydCAiZG9lcyBub3QgZXhpc3QiLiBBZnRlciBJIHJlbW92ZWQgdGhlIG5l
d2x5LW1lcmdlZCwgbm8gc3VjaCByZXBvcnQuDQoNCkZvbGxvd2luZyBpcyB0aGUgbG9nLiANCg0K
cm9vdEBMQVBUT1AtNzBSSjVCOFE6L3Vzci9sb2NhbC9zcmMvZndfbmV3IyBtYWtlIGNoZWNrDQpD
aGVjayB0aGF0IGV4ZWN1dGFibGVzIGhhdmUgc2hlYmFuZ3MuLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uUGFzc2VkDQpGb3JiaWQgbmV3IHN1Ym1vZHVsZXMuLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uUGFzc2VkDQpDaGVjayBZYW1s
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uUGFzc2VkDQpDaGVjayBmb3IgYnJva2VuIHN5bWxpbmtzLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLihubyBmaWxlcyB0byBjaGVjaylTa2lwcGVkDQpEZXRlY3QgRGVzdHJveWVkIFN5
bWxpbmtzLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uUGFz
c2VkDQpzaGVsbGNoZWNrLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uUGFzc2VkDQpibGFjay4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uUGFzc2VkDQptYXJr
ZG93bmxpbnQuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uRmFpbGVkDQotIGhvb2sgaWQ6IG1hcmtkb3dubGludA0KLSBleGl0IGNvZGU6
IDENCg0KaW50ZXJuYWwvbW9kdWxlcy9janMvbG9hZGVyLmpzOjgxOA0KICB0aHJvdyBlcnI7DQog
IF4NCg0KRXJyb3I6IENhbm5vdCBmaW5kIG1vZHVsZSAnbm9kZTpmcycNClJlcXVpcmUgc3RhY2s6
DQotIC9yb290Ly5jYWNoZS9wcmUtY29tbWl0L3JlcG94bDU5YzB1ei9ub2RlX2Vudi1zeXN0ZW0v
bGliL25vZGVfbW9kdWxlcy9tYXJrZG93bmxpbnQtY2xpL21hcmtkb3dubGludC5qcw0KICAgIGF0
IEZ1bmN0aW9uLk1vZHVsZS5fcmVzb2x2ZUZpbGVuYW1lIChpbnRlcm5hbC9tb2R1bGVzL2Nqcy9s
b2FkZXIuanM6ODE1OjE1KQ0KICAgIGF0IEZ1bmN0aW9uLk1vZHVsZS5fbG9hZCAoaW50ZXJuYWwv
bW9kdWxlcy9janMvbG9hZGVyLmpzOjY2NzoyNykNCiAgICBhdCBNb2R1bGUucmVxdWlyZSAoaW50
ZXJuYWwvbW9kdWxlcy9janMvbG9hZGVyLmpzOjg4NzoxOSkNCiAgICBhdCByZXF1aXJlIChpbnRl
cm5hbC9tb2R1bGVzL2Nqcy9oZWxwZXJzLmpzOjg1OjE4KQ0KICAgIGF0IE9iamVjdC48YW5vbnlt
b3VzPiAoL3Jvb3QvLmNhY2hlL3ByZS1jb21taXQvcmVwb3hsNTljMHV6L25vZGVfZW52LXN5c3Rl
bS9saWIvbm9kZV9tb2R1bGVzL21hcmtkb3dubGludC1jbGkvbWFya2Rvd25saW50LmpzOjU6MTIp
DQogICAgYXQgTW9kdWxlLl9jb21waWxlIChpbnRlcm5hbC9tb2R1bGVzL2Nqcy9sb2FkZXIuanM6
OTk5OjMwKQ0KICAgIGF0IE9iamVjdC5Nb2R1bGUuX2V4dGVuc2lvbnMuLmpzIChpbnRlcm5hbC9t
b2R1bGVzL2Nqcy9sb2FkZXIuanM6MTAyNzoxMCkNCiAgICBhdCBNb2R1bGUubG9hZCAoaW50ZXJu
YWwvbW9kdWxlcy9janMvbG9hZGVyLmpzOjg2MzozMikNCiAgICBhdCBGdW5jdGlvbi5Nb2R1bGUu
X2xvYWQgKGludGVybmFsL21vZHVsZXMvY2pzL2xvYWRlci5qczo3MDg6MTQpDQogICAgYXQgRnVu
Y3Rpb24uZXhlY3V0ZVVzZXJFbnRyeVBvaW50IFthcyBydW5NYWluXSAoaW50ZXJuYWwvbW9kdWxl
cy9ydW5fbWFpbi5qczo2MDoxMikgew0KICBjb2RlOiAnTU9EVUxFX05PVF9GT1VORCcsDQogIHJl
cXVpcmVTdGFjazogWw0KICAgICcvcm9vdC8uY2FjaGUvcHJlLWNvbW1pdC9yZXBveGw1OWMwdXov
bm9kZV9lbnYtc3lzdGVtL2xpYi9ub2RlX21vZHVsZXMvbWFya2Rvd25saW50LWNsaS9tYXJrZG93
bmxpbnQuanMnDQogIF0NCn0NCg0KQ2hlY2sgd2hlbmNlLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLkZhaWxlZA0KLSBob29rIGlkOiBj
aGVjay13aGVuY2UNCi0gZXhpdCBjb2RlOiAxDQoNCkU6IHRpL3RhczI3ODEvVEFTMlhYWDFFQjMw
LmJpbiBsaXN0ZWQgaW4gV0hFTkNFIGRvZXMgbm90IGV4aXN0DQpFOiB0aS90YXMyNzgxL1RBUzJY
WFgxRUIzMS5iaW4gbGlzdGVkIGluIFdIRU5DRSBkb2VzIG5vdCBleGlzdA0KRTogdGFyZ2V0IHRp
L3RhczI3ODEvVEFTMlhYWDFFQjMwLmJpbiBvZiBsaW5rIFRBUzJYWFgxRUIzMC5iaW4gaW4gV0hF
TkNFIGRvZXMgbm90IGV4aXN0DQpFOiB0YXJnZXQgdGkvdGFzMjc4MS9UQVMyWFhYMUVCMzEuYmlu
IG9mIGxpbmsgVEFTMlhYWDFFQjMxLmJpbiBpbiBXSEVOQ0UgZG9lcyBub3QgZXhpc3QNCg0KbWFr
ZTogKioqIFtNYWtlZmlsZToxMDogY2hlY2tdIEVycm9yIDENCnJvb3RATEFQVE9QLTcwUko1QjhR
Oi91c3IvbG9jYWwvc3JjL2Z3X25ldyMgbHMgdGkvdGFzMjc4MS9UQVMyWFhYMSogLWFsDQotcnct
ci0tci0tIDEgcm9vdCByb290IDM1MjIwIFNlcCAyOCAyMTo1NCB0aS90YXMyNzgxL1RBUzJYWFgx
RUIzMC5iaW4NCi1ydy1yLS1yLS0gMSByb290IHJvb3QgMzUyMjAgU2VwIDI4IDIxOjU1IHRpL3Rh
czI3ODEvVEFTMlhYWDFFQjMxLmJpbg0Kcm9vdEBMQVBUT1AtNzBSSjVCOFE6L3Vzci9sb2NhbC9z
cmMvZndfbmV3Iw0KPiANCj4gVGhhbmtzLA0K

