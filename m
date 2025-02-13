Return-Path: <linux-kernel+bounces-512537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD3A33AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F843A2402
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E720C492;
	Thu, 13 Feb 2025 09:07:31 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5B20C021
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437651; cv=none; b=HOCK8VgWmoe4RrzKDck2jqi9lZAv+20eueBPUMh6mQ2v7LkBFJq1h922Zd++3j8ujQKi+T/8ncRrQVp3jYvhnPLvQW5CnWikOubztcGNF/5dh0W+wwVBg4iikjQPVjx6sSNrHb4sK2sm2VqRQo24PvKcZhAflGjbUFtifwTqUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437651; c=relaxed/simple;
	bh=Hw6IowBtLjlg/5mH7kGlh+2fXzdGZbe1BmyBSe/xScA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajHn5X1kJG3YGrZGbpg4/YKn7pEHaE6031AkYqzbkDuP6JoHWuTTluK1bvvXjWjnzIP0FCz3Ajz34DCI1GuI+uvTtivtF18PkdYwc443YM7a0G03+++4ieYlroWqSwZ/WMkTlLC90yWBFjnlAY4Y2q52EpenYiYoEuIXXM0wMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Ytpn92QmtzYlDsM;
	Thu, 13 Feb 2025 16:51:09 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w013.hihonor.com (10.68.26.19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 16:51:58 +0800
Received: from a007.hihonor.com (10.68.22.31) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 16:51:57 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Thu, 13 Feb 2025 16:51:57 +0800
From: gaoxu <gaoxu2@honor.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, Barry
 Song <21cnbao@gmail.com>, yipengxiang <yipengxiang@honor.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOiBGaXggcG9zc2libGUgTlVMTCBwb2ludGVy?=
 =?utf-8?B?IGRlcmVmZXJlbmNlIGluIF9fc3dhcF9kdXBsaWNhdGU=?=
Thread-Topic: [PATCH] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: Adt8+0GogoLTL6hgQfOcUIXDGgpBSQAehvKAAB6JUvA=
Date: Thu, 13 Feb 2025 08:51:56 +0000
Message-ID: <a67e670777474ae2ad1a29707f00ea3f@honor.com>
References: <44655569e3a1419f800952004f07e714@honor.com>
 <CAKEwX=NgTfnU8EzpPmC_h5mY1UePAPR6_W2rrBNGs3EZA96FsQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NgTfnU8EzpPmC_h5mY1UePAPR6_W2rrBNGs3EZA96FsQ@mail.gmail.com>
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

PiANCj4gT24gVHVlLCBGZWIgMTEsIDIwMjUgYXQgNzoxNOKAr1BNIGdhb3h1IDxnYW94dTJAaG9u
b3IuY29tPiB3cm90ZToNCj4gPg0KPiA+IHN3cF9zd2FwX2luZm8oKSBtYXkgcmV0dXJuIG51bGw7
IGl0IGlzIG5lY2Vzc2FyeSB0byBjaGVjayB0aGUgcmV0dXJuDQo+ID4gdmFsdWUgdG8gYXZvaWQg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLiBUaGUgY29kZSBmb3Igb3RoZXIgY2FsbHMgdG8NCj4g
PiBzd3Bfc3dhcF9pbmZvKCkgaW5jbHVkZXMgY2hlY2tzLCBhbmQgX19zd2FwX2R1cGxpY2F0ZSgp
IHNob3VsZCBhbHNvDQo+ID4gaW5jbHVkZSBjaGVja3MuDQo+ID4NCj4gPiBUaGUgcmVhc29uIHdo
eSBzd3Bfc3dhcF9pbmZvKCkgcmV0dXJucyBOVUxMIGlzIHVuY2xlYXI7IGl0IG1heSBiZSBkdWUN
Cj4gPiB0byBDUFUgY2FjaGUgaXNzdWVzIG9yIEREUiBiaXQgZmxpcHMuIFRoZSBwcm9iYWJpbGl0
eSBvZiB0aGlzIGlzc3VlIGlzDQo+ID4gdmVyeSBzbWFsbCwgYW5kIHRoZSBzdGFjayBpbmZvIHdl
IGVuY291bnRlcmVkIGlzIGFzIGZvbGxvd3PvvJoNCj4gPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzDQo+ID4gMDAwMDAw
MDAwMDAwMDA1OA0KPiA+IFtSQi9FXXJiX3NyZWFzb25fc3RyX3NldDogc3JlYXNvbl9zdHIgc2V0
IG51bGxfcG9pbnRlciBNZW0gYWJvcnQgaW5mbzoNCj4gPiAgIEVTUiA9IDB4MDAwMDAwMDA5NjAw
MDAwNQ0KPiA+ICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+
ID4gICBTRVQgPSAwLCBGblYgPSAwDQo+ID4gICBFQSA9IDAsIFMxUFRXID0gMA0KPiA+ICAgRlND
ID0gMHgwNTogbGV2ZWwgMSB0cmFuc2xhdGlvbiBmYXVsdCBEYXRhIGFib3J0IGluZm86DQo+ID4g
ICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA1LCBJU1MyID0gMHgwMDAwMDAwMA0KPiA+ICAgQ00g
PSAwLCBXblIgPSAwLCBUbkQgPSAwLCBUYWdBY2Nlc3MgPSAwDQo+ID4gICBHQ1MgPSAwLCBPdmVy
bGF5ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDAgdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywNCj4g
PiAzOS1iaXQgVkFzLCBwZ2RwPTAwMDAwMDA4YTgwZTUwMDAgWzAwMDAwMDAwMDAwMDAwNThdDQo+
ID4gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAwMDAwLA0KPiA+IHB1ZD0w
MDAwMDAwMDAwMDAwMDAwDQo+ID4gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAw
MDUgWyMxXSBQUkVFTVBUIFNNUCBTa2lwIG1kIGZ0cmFjZQ0KPiA+IGJ1ZmZlciBkdW1wIGZvcjog
MHgxNjA5ZTAgLi4uDQo+ID4gcGMgOiBzd2FwX2R1cGxpY2F0ZSsweDQ0LzB4MTY0DQo+ID4gbHIg
OiBjb3B5X3BhZ2VfcmFuZ2UrMHg1MDgvMHgxZTc4DQo+ID4gc3AgOiBmZmZmZmZjMGYyYTY5OWUw
DQo+ID4geDI5OiBmZmZmZmZjMGYyYTY5OWUwIHgyODogZmZmZmZmOGE1YjI4ZDM4OCB4Mjc6IGZm
ZmZmZjhiMDY2MDMzODgNCj4gPiB4MjY6IGZmZmZmZmRmNzI5MWZlNzAgeDI1OiAwMDAwMDAwMDAw
MDAwMDA2IHgyNDogMDAwMDAwMDAwMDEwMDA3Mw0KPiA+IHgyMzogMDAwMDAwMDAwMDJkMmQyZiB4
MjI6IDAwMDAwMDAwMDAwMDAwMDggeDIxOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4geDIwOiAwMDAw
MDAwMDAwMmQyZDJmIHgxOTogMTgwMDAwMDAwMDJkMmQyZiB4MTg6IGZmZmZmZmRmNzI2ZmFlYzAN
Cj4gPiB4MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiAwMDEwMDAwMDAwMDAwMDAxIHgxNTogMDA0
MDAwMDAwMDAwMDAwMQ0KPiA+IHgxNDogMDQwMDAwMDAwMDAwMDAwMSB4MTM6IGZmN2ZmZmZmZmZm
ZmZiN2YgeDEyOiBmZmVmZmZmZmZmZmZmYmZmDQo+ID4geDExOiBmZmZmZmY4YTVjN2UxODk4IHgx
MDogMDAwMDAwMDAwMDAwMDAxOCB4OSA6IDAwMDAwMDAwMDAwMDAwMDYNCj4gPiB4OCA6IDE4MDAw
MDAwMDAwMDAwMDAgeDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogZmZmZmZmODA1N2MwMWYxMA0K
PiA+IHg1IDogMDAwMDAwMDAwMDAwYTMxOCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiAwMDAw
MDAwMDAwMDAwMDAwDQo+ID4geDIgOiAwMDAwMDA2ZGFmMjAwMDAwIHgxIDogMDAwMDAwMDAwMDAw
MDAwMSB4MCA6IDE4MDAwMDAwMDAyZDJkMmYgQ2FsbA0KPiA+IHRyYWNlOg0KPiA+ICBzd2FwX2R1
cGxpY2F0ZSsweDQ0LzB4MTY0DQo+ID4gIGNvcHlfcGFnZV9yYW5nZSsweDUwOC8weDFlNzgNCj4g
PiAgY29weV9wcm9jZXNzKzB4MTI3OC8weDIxY2MNCj4gPiAga2VybmVsX2Nsb25lKzB4OTAvMHg0
MzgNCj4gPiAgX19hcm02NF9zeXNfY2xvbmUrMHg1Yy8weDhjDQo+ID4gIGludm9rZV9zeXNjYWxs
KzB4NTgvMHgxMTANCj4gPiAgZG9fZWwwX3N2YysweDhjLzB4ZTANCj4gPiAgZWwwX3N2YysweDM4
LzB4OWMNCj4gPiAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg0NC8weGVjDQo+ID4gIGVsMHRfNjRf
c3luYysweDFhOC8weDFhYw0KPiA+IENvZGU6IDkxMzljMzVhIDcxMDA2ZjNmIDU0MDAwNTY4IGY4
Nzk3YjU1IChmOTQwMmVhOCkgLS0tWyBlbmQgdHJhY2UNCj4gPiAwMDAwMDAwMDAwMDAwMDAwIF0t
LS0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsDQo+ID4gZXhjZXB0aW9u
DQo+ID4gU01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KPiA+DQo+ID4gVGhlIHBhdGNoIHNl
ZW1zIHRvIG9ubHkgcHJvdmlkZSBhIHdvcmthcm91bmQsIGJ1dCB0aGVyZSBhcmUgbm8gbW9yZQ0K
PiA+IGVmZmVjdGl2ZSBzb2Z0d2FyZSBzb2x1dGlvbnMgdG8gaGFuZGxlIHRoZSBiaXQgZmxpcHMg
cHJvYmxlbS4gVGhpcw0KPiA+IHBhdGggd2lsbCBjaGFuZ2UgdGhlIGlzc3VlIGZyb20gYSBzeXN0
ZW0gY3Jhc2ggdG8gYSBwcm9jZXNzIGV4Y2VwdGlvbiwNCj4gPiB0aGVyZWJ5IHJlZHVjaW5nIHRo
ZSBpbXBhY3Qgb24gdGhlIGVudGlyZSBtYWNoaW5lLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Z2FvIHh1IDxnYW94dTJAaG9ub3IuY29tPg0KPiANCj4gWWVhaCB0aGlzIHNtZWxscyBsaWtlIGEg
YnVnLiBBIGJpdCBzdHJhbmdlIHRob3VnaCAtIEkgaGF2ZSBleWViYWxsZWQgdGhlIGNvZGUsIGFu
ZA0KPiB3ZSAoc2hvdWxkIGhhdmU/KSBsb2NrZWQgdGhlIFBURSBiZWZvcmUgcmVzb2x2aW5nIGl0
IGludG8gdGhlIHN3YXAgZW50cnkgZm9ybWF0Lg0KPiBXaGljaCBzaG91bGQgaGF2ZSBiZWVuIGVu
b3VnaCB0byBwcmV2ZW50IHRoZSBzd2FwIGVudHJ5IGZyb20gYmVpbmcNCj4gdW5tYXBwZWQgYW5k
IGZyZWVkIHVwLiBXaGljaCBzaG91bGQgaGF2ZSBiZWVuIGVub3VnaCB0byBwcmV2ZW50IHN3YXBv
ZmYuLi4/DQo+IA0KPiAoYXJlIHlvdSBldmVuIGRvaW5nIGNvbmN1cnJlbnQgc3dhcG9mZj8pDQpO
bywgdGhlIHN3YXBvZmYgb3BlcmF0aW9uIHdhcyBub3QgZXhlY3V0ZWQuDQo+IA0KPiBDYW4geW91
IHByb3ZpZGUgbW9yZSBjb250ZXh0PyBXaGF0IGtlcm5lbCB2ZXJzaW9uIGlzIHRoaXMsIHdoYXQg
a2luZCBvZg0KPiB3b3JrbG9hZCBpcyB0aGlzLCBhbnkgcmVwcm9kdWNlciwgZXRjLj8NCmtlcm5l
bCB2ZXJzaW9uIGlzIGxpbnV4IDYuNiwgIEFuZHJvaWQxNSAtIGxpbnV4Ni42LjMwLg0KDQpUaGUg
aXNzdWVzIGVuY291bnRlcmVkIGJ5IG1vYmlsZSB1c2VycyBkdXJpbmcgdXNhZ2UuDQpUaGUgc3lz
dGVtIGxvYWQgc2hvdWxkIG5vdCBiZSBoaWdoLCBhcyB0aGVyZSBpcyBubyBpbmZvIHJlbGF0ZWQg
dG8gbG93DQptZW1vcnkgZm91bmQgaW4gdGhlIGxvZ3MuDQpUaGUgcHJvYmFiaWxpdHkgb2YgdGhp
cyBpc3N1ZSBvY2N1cnJpbmcgaXMgdmVyeSBsb3cgYW5kIGlycmVndWxhci4NCldlIGNhbm5vdCBy
ZXByb2R1Y2UgdGhlIHByb2JsZW0gZHVyaW5nIHN0cmVzcyB0ZXN0aW5nIGluIHRoZSBsYWJvcmF0
b3J5Lg0KDQpJIGZvdW5kIHNvbWVvbmUgcmVwb3J0aW5nIGEgc2ltaWxhciBpc3N1ZSBvbiB0aGUg
d2ViLCBzZWU6DQpodHRwczovL2xrbWwuaW5kaWFuYS5lZHUvaHlwZXJtYWlsL2xpbnV4L2tlcm5l
bC8yNDA2LjAvMDIzODAuaHRtbA0KaHR0cHM6Ly9mb3J1bS5wcm94bW94LmNvbS90aHJlYWRzL2dl
dF9zd2FwX2RldmljZS1iYWQtc3dhcC1maWxlLWVudHJ5LjE1NTU4MS8NCmh0dHBzOi8vZm9ydW1z
LnVucmFpZC5uZXQvdG9waWMvMTQ1NDk3LXNlcnZlci1jcmFzaGVzLXdpdGgtcmVwZWF0ZWQtZ2V0
X3N3YXBfZGV2aWNlLWJhZC1zd2FwLWZpbGUtZW50cnktM2ZmZmZmZmZmZmZmZi8NCg0KDQoNCg==

