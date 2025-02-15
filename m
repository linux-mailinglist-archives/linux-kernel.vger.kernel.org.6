Return-Path: <linux-kernel+bounces-516071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096EAA36C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B654018900CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D79197A68;
	Sat, 15 Feb 2025 08:32:04 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E218B477
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608324; cv=none; b=SwDfhZAM/17dHkjlLh1juZcL686+VupF6Qpb7X0g3d/12tVH7PT+6wJ1F/60fZsEmHb74q0BOmoB69k8Om1xD6waPctL50vFNasz7+5RQ0UOUFOkLh7x1h2ytS+av8Tu+RraoPJ5LT+BUztqB8yzUDKHEKKDDiZKHLfRzBG5l0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608324; c=relaxed/simple;
	bh=JJSptrnjGAdciiuJNS4fjWaeNKENxtOCG7Eb8yMsNjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adScMZNqp4ZxwCVfxsEyoNPAq/rx2Yoyqd07sA1CvHJtQjfrSG9HR2BIoh4gAJM0dE8uSZeL1TGYDw0VITjsH27HGoXNHjAUXlbx+rGBKFTRiMRxRZGAteCX+wWjb6lUJqB/2Jqdd9lSBjUp0z7NaxLQmGMimR+Ws+n+HLCWa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Yw2Dk3bHTzYmJMc;
	Sat, 15 Feb 2025 16:30:46 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 16:31:51 +0800
Received: from a007.hihonor.com (10.68.22.31) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 16:31:50 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Sat, 15 Feb 2025 16:31:50 +0800
From: gaoxu <gaoxu2@honor.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Suren
  Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>,
	yipengxiang <yipengxiang@honor.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG1tOiBGaXggcG9zc2libGUgTlVMTCBwb2lu?=
 =?utf-8?B?dGVyIGRlcmVmZXJlbmNlIGluIF9fc3dhcF9kdXBsaWNhdGU=?=
Thread-Topic: [PATCH v2] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: Adt/c+jLXWIUvZ+8S8+6YIq3M7UYAf//mAiA//95OWA=
Date: Sat, 15 Feb 2025 08:31:50 +0000
Message-ID: <ca2a581c9601426abb3b29f2535956ab@honor.com>
References: <afecae337e5b4b2b8ce4e5a591957f89@honor.com>
 <8bda689f466f7426df696ec52648592f262091bb@linux.dev>
In-Reply-To: <8bda689f466f7426df696ec52648592f262091bb@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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

PiANCj4gRmVicnVhcnkgMTQsIDIwMjUgYXQgMTA6NTIgUE0sICJnYW94dSIgPGdhb3h1MkBob25v
ci5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiA+DQo+ID4gQWRkIGEgTlVMTCBjaGVjayBvbiB0
aGUgcmV0dXJuIHZhbHVlIG9mIHN3cF9zd2FwX2luZm8gaW4gX19zd2FwX2R1cGxpY2F0ZQ0KPiA+
DQo+ID4gdG8gcHJldmVudCBjcmFzaGVzIGNhdXNlZCBieSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UuDQo+ID4NCj4gPiBUaGUgcmVhc29uIHdoeSBzd3Bfc3dhcF9pbmZvKCkgcmV0dXJucyBOVUxM
IGlzIHVuY2xlYXI7IGl0IG1heSBiZSBkdWUgdG8NCj4gPg0KPiA+IENQVSBjYWNoZSBpc3N1ZXMg
b3IgRERSIGJpdCBmbGlwcy4gVGhlIHByb2JhYmlsaXR5IG9mIHRoaXMgaXNzdWUgaXMgdmVyeQ0K
PiA+DQo+ID4gc21hbGwsIGFuZCB0aGUgc3RhY2sgaW5mbyB3ZSBlbmNvdW50ZXJlZCBpcyBhcyBm
b2xsb3dz77yaDQo+ID4NCj4gPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzDQo+ID4NCj4gPiAwMDAwMDAwMDAwMDAwMDU4
DQo+ID4NCj4gPiBbUkIvRV1yYl9zcmVhc29uX3N0cl9zZXQ6IHNyZWFzb25fc3RyIHNldCBudWxs
X3BvaW50ZXINCj4gPg0KPiA+IE1lbSBhYm9ydCBpbmZvOg0KPiA+DQo+ID4gIEVTUiA9IDB4MDAw
MDAwMDA5NjAwMDAwNQ0KPiA+DQo+ID4gIEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElM
ID0gMzIgYml0cw0KPiA+DQo+ID4gIFNFVCA9IDAsIEZuViA9IDANCj4gPg0KPiA+ICBFQSA9IDAs
IFMxUFRXID0gMA0KPiA+DQo+ID4gIEZTQyA9IDB4MDU6IGxldmVsIDEgdHJhbnNsYXRpb24gZmF1
bHQNCj4gPg0KPiA+IERhdGEgYWJvcnQgaW5mbzoNCj4gPg0KPiA+ICBJU1YgPSAwLCBJU1MgPSAw
eDAwMDAwMDA1LCBJU1MyID0gMHgwMDAwMDAwMA0KPiA+DQo+ID4gIENNID0gMCwgV25SID0gMCwg
VG5EID0gMCwgVGFnQWNjZXNzID0gMA0KPiA+DQo+ID4gIEdDUyA9IDAsIE92ZXJsYXkgPSAwLCBE
aXJ0eUJpdCA9IDAsIFhzID0gMA0KPiA+DQo+ID4gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgMzkt
Yml0IFZBcywgcGdkcD0wMDAwMDAwOGE4MGU1MDAwDQo+ID4NCj4gPiBbMDAwMDAwMDAwMDAwMDA1
OF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAwMDAwLA0KPiA+DQo+ID4g
cHVkPTAwMDAwMDAwMDAwMDAwMDANCj4gPg0KPiA+IEludGVybmFsIGVycm9yOiBPb3BzOiAwMDAw
MDAwMDk2MDAwMDA1IFsjMV0gUFJFRU1QVCBTTVANCj4gPg0KPiA+IFNraXAgbWQgZnRyYWNlIGJ1
ZmZlciBkdW1wIGZvcjogMHgxNjA5ZTANCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gcGMgOiBzd2Fw
X2R1cGxpY2F0ZSsweDQ0LzB4MTY0DQo+ID4NCj4gPiBsciA6IGNvcHlfcGFnZV9yYW5nZSsweDUw
OC8weDFlNzgNCj4gPg0KPiA+IHNwIDogZmZmZmZmYzBmMmE2OTllMA0KPiA+DQo+ID4geDI5OiBm
ZmZmZmZjMGYyYTY5OWUwIHgyODogZmZmZmZmOGE1YjI4ZDM4OCB4Mjc6IGZmZmZmZjhiMDY2MDMz
ODgNCj4gPg0KPiA+IHgyNjogZmZmZmZmZGY3MjkxZmU3MCB4MjU6IDAwMDAwMDAwMDAwMDAwMDYg
eDI0OiAwMDAwMDAwMDAwMTAwMDczDQo+ID4NCj4gPiB4MjM6IDAwMDAwMDAwMDAyZDJkMmYgeDIy
OiAwMDAwMDAwMDAwMDAwMDA4IHgyMTogMDAwMDAwMDAwMDAwMDAwMA0KPiA+DQo+ID4geDIwOiAw
MDAwMDAwMDAwMmQyZDJmIHgxOTogMTgwMDAwMDAwMDJkMmQyZiB4MTg6IGZmZmZmZmRmNzI2ZmFl
YzANCj4gPg0KPiA+IHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMTAwMDAwMDAwMDAwMDEg
eDE1OiAwMDQwMDAwMDAwMDAwMDAxDQo+ID4NCj4gPiB4MTQ6IDA0MDAwMDAwMDAwMDAwMDEgeDEz
OiBmZjdmZmZmZmZmZmZmYjdmIHgxMjogZmZlZmZmZmZmZmZmZmJmZg0KPiA+DQo+ID4geDExOiBm
ZmZmZmY4YTVjN2UxODk4IHgxMDogMDAwMDAwMDAwMDAwMDAxOCB4OSA6IDAwMDAwMDAwMDAwMDAw
MDYNCj4gPg0KPiA+IHg4IDogMTgwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAg
eDYgOiBmZmZmZmY4MDU3YzAxZjEwDQo+ID4NCj4gPiB4NSA6IDAwMDAwMDAwMDAwMGEzMTggeDQg
OiAwMDAwMDAwMDAwMDAwMDAwIHgzIDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+DQo+ID4geDIgOiAw
MDAwMDA2ZGFmMjAwMDAwIHgxIDogMDAwMDAwMDAwMDAwMDAwMSB4MCA6IDE4MDAwMDAwMDAyZDJk
MmYNCj4gPg0KPiA+IENhbGwgdHJhY2U6DQo+ID4NCj4gPiAgc3dhcF9kdXBsaWNhdGUrMHg0NC8w
eDE2NA0KPiA+DQo+ID4gIGNvcHlfcGFnZV9yYW5nZSsweDUwOC8weDFlNzgNCj4gPg0KPiA+ICBj
b3B5X3Byb2Nlc3MrMHgxMjc4LzB4MjFjYw0KPiA+DQo+ID4gIGtlcm5lbF9jbG9uZSsweDkwLzB4
NDM4DQo+ID4NCj4gPiAgX19hcm02NF9zeXNfY2xvbmUrMHg1Yy8weDhjDQo+ID4NCj4gPiAgaW52
b2tlX3N5c2NhbGwrMHg1OC8weDExMA0KPiA+DQo+ID4gIGRvX2VsMF9zdmMrMHg4Yy8weGUwDQo+
ID4NCj4gPiAgZWwwX3N2YysweDM4LzB4OWMNCj4gPg0KPiA+ICBlbDB0XzY0X3N5bmNfaGFuZGxl
cisweDQ0LzB4ZWMNCj4gPg0KPiA+ICBlbDB0XzY0X3N5bmMrMHgxYTgvMHgxYWMNCj4gPg0KPiA+
IENvZGU6IDkxMzljMzVhIDcxMDA2ZjNmIDU0MDAwNTY4IGY4Nzk3YjU1IChmOTQwMmVhOCkNCj4g
Pg0KPiA+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+DQo+ID4gS2Vy
bmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbg0KPiA+DQo+ID4g
U01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KPiA+DQo+ID4gVGhlIHBhdGNoIHNlZW1zIHRv
IG9ubHkgcHJvdmlkZSBhIHdvcmthcm91bmQsIGJ1dCB0aGVyZSBhcmUgbm8gbW9yZQ0KPiA+DQo+
ID4gZWZmZWN0aXZlIHNvZnR3YXJlIHNvbHV0aW9ucyB0byBoYW5kbGUgdGhlIGJpdCBmbGlwcyBw
cm9ibGVtLiBUaGlzIHBhdGgNCj4gPg0KPiA+IHdpbGwgY2hhbmdlIHRoZSBpc3N1ZSBmcm9tIGEg
c3lzdGVtIGNyYXNoIHRvIGEgcHJvY2VzcyBleGNlcHRpb24sIHRoZXJlYnkNCj4gPg0KPiA+IHJl
ZHVjaW5nIHRoZSBpbXBhY3Qgb24gdGhlIGVudGlyZSBtYWNoaW5lLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogZ2FveHUgPGdhb3h1MkBob25vci5jb20+DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTog
WW9zcnkgQWhtZWQgPHlvc3J5LmFobWVkQGxpbnV4LmRldj4NCj4gDQo+IA0KPiBJIGRpZCBub3Qg
cmV2aWV3IHRoaXMgcGF0Y2gsIEkgb25seSBtYWRlIGEgc3VnZ2VzdGlvbi4gUGxlYXNlIG9ubHkg
YWRkIFJldmlldw0KPiB0YWdzIHdoZW4gZXhwbGljaXRseSBnaXZlbi4NCnNvcnJ5LCBJIHdpbGwg
cmVzZW5kIGEgcGF0Y2ggdGhhdCByZW1vdmVzIHRoZSBSZXZpZXcgdGFncy4NCg==

