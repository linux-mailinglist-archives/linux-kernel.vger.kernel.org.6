Return-Path: <linux-kernel+bounces-185904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F978CBCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C771C22048
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76A7F486;
	Wed, 22 May 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="NCn7RHvc"
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFD7E59A;
	Wed, 22 May 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365633; cv=none; b=AOA2q9vf62yMDw/3Ao0TSQ8Y2ZFAepLi2Ds0W3twJJtQnDLNyhGT+ssJqo8f+AXlfpQdMwkldrAqckCdW6gTd13SWcU6Wde+YnghyWh0vPe9p7edeJC73Y+pasUg2q3ynvSLMP0yij5X7mtZYJ5YxkPBNjc0VP/HVsve6nFG5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365633; c=relaxed/simple;
	bh=ZiwI6OIvKaKyBHKMufSx8eJ8Za80wY4V8fS07kcBPEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDc74XDEDf+FvKlF0K++qGDEI0FONdODQH/SgM8wpGQOkLD09/j1euegPtMHnpWYSWG8uxnzw700Efyc9mMLROcdepYvus4kql6WO3E/6oxMekgfQG/9GCCVfExN7e82JeRHUM9aHyLvxFlMXlY/KsCuIuuvyKxOOw8+rNCPfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=NCn7RHvc; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1716365632; x=1747901632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiwI6OIvKaKyBHKMufSx8eJ8Za80wY4V8fS07kcBPEk=;
  b=NCn7RHvchnLg7RxO/QCCBm41WJDKcs/XcOb+iSd1c30qS3+drWyyZKZn
   16R5WVjuxFxY/FaVlxLvDH4DHtYuWSNP01DEj0xVVoa9FZLUMTods0Bu2
   s2Kurm9BKhXcv8f87kTgqO1cWCCOGO//B+yR5OCENQRD3ZBL+kQrpCbuK
   w=;
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="19685922"
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="19685922"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:13:49 +0200
Received: from MUCSE838.infineon.com (172.23.7.110) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 May
 2024 10:13:47 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE838.infineon.com
 (172.23.7.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 May
 2024 10:13:47 +0200
Received: from MUCSE832.infineon.com ([fe80::6918:9b7d:1c9c:3175]) by
 MUCSE832.infineon.com ([fe80::6918:9b7d:1c9c:3175%15]) with mapi id
 15.02.1118.040; Wed, 22 May 2024 10:13:47 +0200
From: <Nobuaki.Tsunashima@infineon.com>
To: <pmenzel@molgen.mpg.de>
CC: <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gargaditya08@live.com>
Subject: RE: [PATCH v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
Thread-Topic: [PATCH v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
Thread-Index: AQHaq+df0FcXYabXTEC6nFtbx+/iX7Gii68AgABPWnA=
Date: Wed, 22 May 2024 08:13:46 +0000
Message-ID: <de33e3221ba349caa00303d751bd0915@infineon.com>
References: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
 <1c194c94-54f1-4dfe-a790-913e3d9529c6@molgen.mpg.de>
In-Reply-To: <1c194c94-54f1-4dfe-a790-913e3d9529c6@molgen.mpg.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IFBsZWFzZSBub3RlLCB0
aGF0IHRoZSB0aW1lIG9uIHRoZSBzeXN0ZW0geW91IHNlbnQgdGhlIHBhdGNoIGZyb20gaXMgaW4g
dGhlIGZ1dHVyZToNCj4NCj4gICAgIERhdGU6IFdlZCwgMjIgTWF5IDIwMjQgMTc6MTc6MzUgKzA5
MDANCg0KSXQgd2FzIGR1ZSB0byB3cm9uZyB0aW1lIHNldHRpbmcgb24gbXkgTGludXggc3lzdGVt
LiBJJ3ZlIGNvcnJlY3RlZCBpdC4NCg0KPiBJIGZvcmdvdCB0byBhZGQgYnRiY20gaW4gdGhlIHN1
bW1hcnk6DQo+IEJsdWV0b290aDogYnRiY206IOKApg0KU3VyZS4gSSB3aWxsIGFkZCBpbiBuZXh0
IHZlcnNpb24uDQoNCj4+IENZVzQzNzMgUk9NIEZXIGhhcyBhbiBpc3N1ZSB0aGF0IGl0IGNsYWlt
cyBMRV9SZWFkX1RyYW5zbWl0X1Bvd2VyIA0KPj4gIGNvbW1hbmQgYXMgc3VwcG9ydGVkIGluIGEg
cmVzcG9uc2Ugb2YgUmVhZF9Mb2NhbF9TdXBwb3J0ZWRfQ29tbWFuZCANCj4+ICBjb21tYW5kIGJ1
dCByZWplY3RzIHRoZSBMRV9SZWFkX1RyYW5zbWl0X1Bvd2VyIGNvbW1hbmQgd2l0aCAiVW5rbm93
biBIQ0kgQ29tbWFuZCINCj4+ICBzdGF0dXMuIER1ZSB0byB0aGUgaXNzdWUsIEJsdWV0b290aCBk
cml2ZXIgb2YgNS4xNSBhbmQgbGF0ZXIga2VybmVsIA0KPj4gIGZhaWxzIHRvIGhjaSB1cC4NCj4N
Cj4gQXMgd3JpdHRlbiBpbiB0aGUgb3RoZXIgdGhyZWFkLCBpdOKAmWQgYmUgZ3JlYXQgaWYgeW91
IGJpc2VjdGVkIHRoZSBjb21taXQuDQpBcyBJIHRhbGtlZCBpbiBhbm90aGVyIGVtYWlsLCB0aGUg
aXNzdWUgaGFwcGVuZWQgYWZ0ZXIgYmVsb3cgY29tbWl0LiBJbiB0aGlzIGNhc2UsIHNob3VsZCBJ
DQphZGQgIkZpeGVzOiAiIHRhZz8NCg0KPj4gRXNwZWNpYWxseSBpbiBVU0IgaS9mIGNhc2UsIGl0
IHdvdWxkIGJlIGRpZmZpY3VsdCB0byBkb3dubG9hZCBwYXRjaCBGVyANCj4+IHRoYXQgaW5jbHVk
ZXMgSXRzIGZpeCB1bmxlc3MgaGNpIGlzIHVwLg0KPg0KPmxvd2VyY2FzZTogaXRzDQpBY2tlZC4N
Cg0KPiBXaGljaCBmaXJtd2FyZSB2ZXJzaW9ucyBhcmUgZml4ZWQ/DQpDWVc0MzczQTBfMDAxLjAw
MS4wMjUuMDA4MS4qIGFuZCBsYXRlciB2ZXJzaW9uIGFyZSBmaXhlZC4NCg0KPj4gVGhlIHBhdGNo
IGZvcmNlcyB0aGUgZHJpdmVyIHRvIHNraXAgTEVfUmVhZF9UcmFuc21pdF9Qb3dlciBDb21tYW5k
IA0KPj4gd2hlbiBpdCBkZXRlY3RzIENZVzQzNzMgd2l0aCBST00gRlcgYnVpbGQuDQo+DQo+TWF5
YmUgYWRkIHNvbWV0aGluZyBsaWtlOg0KPg0KPlRoZSBkcml2ZXIgYWxyZWFkeSBjb250YWlucyBp
bmZyYXN0cnVjdHVyZSB0byBhcHBseSB0aGUgcXVpcmssIGJ1dCBjdXJyZW50bHkgaXQgb25seQ0K
PnN1cHBvcnRzIERNSSBiYXNlZCBtYXRjaGluZy4gQWRkIHN1cHBvcnQgdG8gbWF0Y2ggYnkgY2hp
cCBpZCBhbmQgYmFzZWxpbmUsIHdoaWNoIOKApi4NCkFja2VkLg0KDQo+PiAtLS0gYS9kcml2ZXJz
L2JsdWV0b290aC9idGJjbS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGJjbS5jDQo+
PiBAQCAtNDM3LDE4ICs0MzcsNDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lk
IGRpc2FibGVfYnJva2VuX3JlYWRfdHJhbnNtaXRfcG93ZXJbXSA9IHsNCj4+ICAgICAgIHsgfQ0K
Pj4gICB9Ow0KPj4NCj4+ICtzdHJ1Y3QgYmNtX2NoaXBfdmVyc2lvbl90YWJsZSB7DQo+PiArICAg
ICB1OCAgICAgIGNoaXBfaWQ7DQo+DQo+IFBsZWFzZSB1c2Ugb25lIHNwYWNlLiAoUGxlYXNlIGFs
c28gY2hlY2sgdGhlIGxpbmUgYmVsb3cuKQ0KQWNrZWQuDQoNCj4+ICsgICAgIHUxNiBiYXNlbGlu
ZTsNCj4NCj4gQWRkIGEgY29tbWVudCBhYm92ZSB0aGUgc3RydWN0LCB3aGF0IGJhc2VsaW5lIG1l
YW5zPw0KSXQgbWVhbnMgYmFzZWxpbmUgdmVyc2lvbiBvZiBwYXRjaCBGVy4gSSB3aWxsIGFkZCBh
IGNvbW1lbnQgdGhlcmUuDQoNCj4+ICt9Ow0KPj4gKyNkZWZpbmUgQkNNX1JPTUZXX0JBU0VMSU5F
X05VTSAgICAgICAweEZGRkYNCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGJjbV9jaGlwX3ZlcnNp
b25fdGFibGUgZGlzYWJsZV9icm9rZW5fcmVhZF90cmFuc21pdF9wb3dlcl9ieV9jaGlwX3Zlcltd
ID0gew0KPj4gKyAgICAgezB4ODcsIEJDTV9ST01GV19CQVNFTElORV9OVU19ICAgICAgICAgIC8q
IENZVzQzNzMvNDM3M0UgKi8NCj4NCj4gQWRkIG9uZSBzcGFjZSBhZnRlciB7IGFuZCBiZWZvcmUg
fT8NCkFja2VkLg0KDQo+PiArfTsNCj4+ICtzdGF0aWMgYm9vbCBidGJjbV9pc19kaXNhYmxlX2Jy
b2tlbl9yZWFkX3R4X3Bvd2VyX2J5X2NoaXBfdmVyKHU4IA0KPj4gK2NoaXBfaWQsIHUxNiBiYXNl
bGluZSkgew0KPj4gKyAgICAgaW50IGk7DQo+PiArICAgICBpbnQgdGFibGVfc2l6ZSA9IA0KPj4g
K0FSUkFZX1NJWkUoZGlzYWJsZV9icm9rZW5fcmVhZF90cmFuc21pdF9wb3dlcl9ieV9jaGlwX3Zl
cik7DQo+DQo+IFVzZSBzaXplX3Q/DQpBY2tlZC4NCg0KPj4gICBzdGF0aWMgaW50IGJ0YmNtX3Jl
YWRfaW5mbyhzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4+ICAgew0KPj4gICAgICAgc3RydWN0IHNr
X2J1ZmYgKnNrYjsNCj4+ICsgICAgIHU4IGNoaXBfaWQ7DQo+PiArICAgICB1MTYgYmFzZWxpbmU7
DQo+Pg0KPj4gICAgICAgLyogUmVhZCBWZXJib3NlIENvbmZpZyBWZXJzaW9uIEluZm8gKi8NCj4+
ICAgICAgIHNrYiA9IGJ0YmNtX3JlYWRfdmVyYm9zZV9jb25maWcoaGRldik7DQo+PiAgICAgICBp
ZiAoSVNfRVJSKHNrYikpDQo+PiAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHNrYik7DQo+
PiAtDQo+PiArICAgICBjaGlwX2lkID0gc2tiLT5kYXRhWzFdOw0KPj4gKyAgICAgYmFzZWxpbmUg
PSBza2ItPmRhdGFbM10gfCAoc2tiLT5kYXRhWzRdIDw8IDgpOw0KPj4gICAgICAgYnRfZGV2X2lu
Zm8oaGRldiwgIkJDTTogY2hpcCBpZCAldSIsIHNrYi0+ZGF0YVsxXSk7DQo+PiAgICAgICBrZnJl
ZV9za2Ioc2tiKTsNCj4+DQo+PiArICAgICAvKiBDaGVjayBDaGlwIElEIGFuZCBkaXNhYmxlIGJy
b2tlbiBSZWFkIExFIE1pbi9NYXggVHggUG93ZXIgKi8NCj4+ICsgICAgIGlmIChidGJjbV9pc19k
aXNhYmxlX2Jyb2tlbl9yZWFkX3R4X3Bvd2VyX2J5X2NoaXBfdmVyKGNoaXBfaWQsIGJhc2VsaW5l
KSkNCj4+ICsgICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfQlJPS0VOX1JFQURfVFJBTlNN
SVRfUE9XRVIsIA0KPj4gKyAmaGRldi0+cXVpcmtzKTsNCj4+ICsNCg0KPiBDb21taXQgODAxYjRj
MDI3YjQ0IChCbHVldG9vdGg6IGJ0YmNtOiBkaXNhYmxlIHJlYWQgdHggcG93ZXIgZm9yIHNvbWUg
TWFjcyB3aXRoIHRoZQ0KPiBUMiBTZWN1cml0eSBjaGlwKSBhZGRlZCB0aGUgY2hlY2sgaW4gYGJ0
YmNtX3ByaW50X2NvbnRyb2xsZXJfZmVhdHVyZXMoKWA/IE5vIGlkZWEsIHdoZXJlDQo+IHRoZSBi
ZXN0IHBsYWNlIGlzLg0KSSB3b25kZXJlZCBpdCB0b28gYnV0IGZpbmFsbHkgZGVjaWRlZCBzZXR0
aW5nIHRoZSBiaXQgaW5zaWRlIGJ0YmNtX3JlYWRfaW5mbygpIHRvIGF2b2lkDQpkdXBsaWNhdGVk
IGNhbGwgb2YgYnRiY21fcmVhZF92ZXJib3NlX2NvbmZpZygpLg0KDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgDQo+
PiBpbmRleCBkMzFlZGFkN2EwNTYuLjUyNTYxYzhkODgyOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMN
Cj4+IEBAIC0xNDIsNiArMTQyLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9p
ZCBidHVzYl90YWJsZVtdID0gew0KPj4gICAgICAgeyBVU0JfVkVORE9SX0FORF9JTlRFUkZBQ0Vf
SU5GTygweDA0Y2EsIDB4ZmYsIDB4MDEsIDB4MDEpLA0KPj4gICAgICAgICAuZHJpdmVyX2luZm8g
PSBCVFVTQl9CQ01fUEFUQ0hSQU0gfSwNCj4+DQo+PiArICAgICAvKiBDeXByZXNzIGRldmljZXMg
d2l0aCB2ZW5kb3Igc3BlY2lmaWMgaWQgKi8NCj4+ICsgICAgIHsgVVNCX1ZFTkRPUl9BTkRfSU5U
RVJGQUNFX0lORk8oMHgwNGI0LCAweGZmLCAweDAxLCAweDAxKSwNCj4+ICsgICAgICAgLmRyaXZl
cl9pbmZvID0gQlRVU0JfQkNNX1BBVENIUkFNIH0sDQo+PiArDQo+DQo+IE9yZGVyIDB4MDRiNCBi
ZWZvcmUgMHgwNGNhPw0KRW50aXJlIG9yZGVyIG9mIHRoZSB0YWJsZSBpcyBub3Qgc29ydGVkIGJ1
dCBsb29rcyBsaWtlIHJhbmRvbSBvcmRlci4NClRoZSByZWFzb24gb2YgdGhlIGVudHJ5IGxvY2F0
aW9uIGlzIGp1c3QgYmVmb3JlIG9mIEJyb2FkY29tIElEIGFzIG91ciBjaGlwDQp3YXMgZGVyaXZl
ZCBmcm9tIHRoZW0uDQoNCj4gICAgICAgLyogQnJvYWRjb20gZGV2aWNlcyB3aXRoIHZlbmRvciBz
cGVjaWZpYyBpZCAqLw0KPiAgICAgICB7IFVTQl9WRU5ET1JfQU5EX0lOVEVSRkFDRV9JTkZPKDB4
MGE1YywgMHhmZiwgMHgwMSwgMHgwMSksDQo+ICAgICAgICAgLmRyaXZlcl9pbmZvID0gQlRVU0Jf
QkNNX1BBVENIUkFNIH0sDQoNCj4gS2luZCByZWdhcmRzLA0KDQo+IFBhdWwNCg0KQmVzdCBSZWdh
cmRzLA0KTm9idWFraSBUc3VuYXNoaW1hDQo=

