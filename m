Return-Path: <linux-kernel+bounces-512974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B258A33FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF94A3AB986
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2223F41C;
	Thu, 13 Feb 2025 13:09:06 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063123F414
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452146; cv=none; b=UsEd2ORm8txI1qqNIfuZ4lD9m2l7k9UiQ7mWPPpsLBAaABUQuxsEjaNUAF6tuCQfS8oL0HbNQVUUfUFp2NL6nKkhFSYGdpdwwoBep5kCf73bOxqylfURowheKNk5ZHKTsfNjjt8ZspmuAXf40BtlfKTQIEzqHrYFrfyg8nX4ZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452146; c=relaxed/simple;
	bh=ntM782/2jzL/G23Vl7z0e6iSOMLQDb1SW0hS+eVSL0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AzWjBkQprYfYDtrgdXmxYRmfGORLmbpI67e+VL5/lia7OKe729WZ1hI9HdlLvbsWfSfoTCPlpwz8XzwpXVP8Ht/gCy1dXLLiPMZgPvg1mQrqgSgsHSwEAFb/93oA6pE+eK0HyX/auJN2SSf82itOe5Q7Qfp61iKNj1kdaUVqlmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4YtwTM24NfzYmW0V;
	Thu, 13 Feb 2025 21:07:51 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 21:08:54 +0800
Received: from a007.hihonor.com (10.68.22.31) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 21:08:54 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Thu, 13 Feb 2025 21:08:54 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, Barry
 Song <21cnbao@gmail.com>, yipengxiang <yipengxiang@honor.com>, "Hugh Dickins"
	<hughd@google.com>, Chris Li <chrisl@kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOiBGaXggcG9zc2libGUgTlVMTCBwb2ludGVy?=
 =?utf-8?B?IGRlcmVmZXJlbmNlIGluIF9fc3dhcF9kdXBsaWNhdGU=?=
Thread-Topic: [PATCH] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: Adt8+0GogoLTL6hgQfOcUIXDGgpBSQAbnlYAACsSnkA=
Date: Thu, 13 Feb 2025 13:08:54 +0000
Message-ID: <da7e1ee115454cf8898b4bbe228a5a9c@honor.com>
References: <44655569e3a1419f800952004f07e714@honor.com>
 <20250212161820.4fda79a3333d2345b60cef72@linux-foundation.org>
In-Reply-To: <20250212161820.4fda79a3333d2345b60cef72@linux-foundation.org>
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

PiANCj4gT24gV2VkLCAxMiBGZWIgMjAyNSAwMzoxMzo0NiArMDAwMCBnYW94dSA8Z2FveHUyQGhv
bm9yLmNvbT4gd3JvdGU6DQo+IA0KPiA+IHN3cF9zd2FwX2luZm8oKSBtYXkgcmV0dXJuIG51bGw7
IGl0IGlzIG5lY2Vzc2FyeSB0byBjaGVjayB0aGUgcmV0dXJuDQo+ID4gdmFsdWUgdG8gYXZvaWQg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLiBUaGUgY29kZSBmb3Igb3RoZXIgY2FsbHMgdG8NCj4g
PiBzd3Bfc3dhcF9pbmZvKCkgaW5jbHVkZXMgY2hlY2tzLCBhbmQgX19zd2FwX2R1cGxpY2F0ZSgp
IHNob3VsZCBhbHNvDQo+ID4gaW5jbHVkZSBjaGVja3MuDQo+IA0KPiBBY3R1YWxseSB2ZXJ5IGZl
dyBvZiB0aGUgc3dwX3N3YXBfaW5mbygpIGNhbGxlcnMgY2hlY2sgZm9yIGEgTlVMTCByZXR1cm4u
DQpUaGUgc3dhcGZpbGUuYyBmaWxlIGNvbnRhaW5zIHRocmVlIGluc3RhbmNlcyB3aGVyZSB0aGUg
cmV0dXJuIHZhbHVlIG9mDQpzd3Bfc3dhcF9pbmZvKCkgaXMgY2hlY2tlZCBmb3IgYSBOVUxMIHJl
dHVybi4gSW4gb3RoZXIgZmlsZXMgdGhhdCBjYWxsDQpzd3Bfc3dhcF9pbmZvKCksIEkgaGF2ZSBj
b25maXJtZWQgdGhhdCB0aGVyZSBhcmUgbm8gc3VjaCBjaGVja3MuDQpUaGUgZGVzY3JpcHRpb24g
aW4gdGhlIHBhdGNoIGlzIGluYWNjdXJhdGUsIGFuZCBJIGhhdmUgbWFkZSBtb2RpZmljYXRpb25z
DQppbiBwYXRjaCB2Mi4NCj4gDQo+ID4gVGhlIHJlYXNvbiB3aHkgc3dwX3N3YXBfaW5mbygpIHJl
dHVybnMgTlVMTCBpcyB1bmNsZWFyOyBpdCBtYXkgYmUgZHVlDQo+ID4gdG8gQ1BVIGNhY2hlIGlz
c3VlcyBvciBERFIgYml0IGZsaXBzLg0KPiANCj4gUXVpdGUgcG9zc2libHkgaXQncyBhIGtlcm5l
bCBidWcuDQo+IA0KPiA+IFRoZSBwcm9iYWJpbGl0eSBvZiB0aGlzIGlzc3VlIGlzIHZlcnkNCj4g
PiBzbWFsbCwgYW5kIHRoZSBzdGFjayBpbmZvIHdlIGVuY291bnRlcmVkIGlzIGFzIGZvbGxvd3Pv
vJoNCj4gPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
YXQgdmlydHVhbCBhZGRyZXNzDQo+ID4gMDAwMDAwMDAwMDAwMDA1OA0KPiA+DQo+ID4gLi4uDQo+
ID4NCj4gPiAtLS0gYS9tbS9zd2FwZmlsZS5jDQo+ID4gKysrIGIvbW0vc3dhcGZpbGUuYw0KPiA+
IEBAIC0zNTIxLDYgKzM1MjEsOCBAQCBzdGF0aWMgaW50IF9fc3dhcF9kdXBsaWNhdGUoc3dwX2Vu
dHJ5X3QgZW50cnksDQo+IHVuc2lnbmVkIGNoYXIgdXNhZ2UsIGludCBucikNCj4gPiAgCWludCBl
cnIsIGk7DQo+ID4NCj4gPiAgCXNpID0gc3dwX3N3YXBfaW5mbyhlbnRyeSk7DQo+ID4gKwlpZiAo
dW5saWtlbHkoIXNpKSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAJb2Zmc2V0
ID0gc3dwX29mZnNldChlbnRyeSk7DQo+ID4gIAlWTV9XQVJOX09OKG5yID4gU1dBUEZJTEVfQ0xV
U1RFUiAtIG9mZnNldCAlIFNXQVBGSUxFX0NMVVNURVIpOw0KPiANCj4gT0ssIEkgZ3Vlc3MgYXZv
aWRpbmcgdGhlIGNyYXNoIGlzIGdvb2QuICBCdXQgcGxlYXNlIGxldCdzIGluY2x1ZGUgYSBXQVJO
IHNvIHRoYXQNCj4gd2UgY2FuIHBlcmhhcHMgZml4IHRoZSBidWcsIGlmIG9uZSBpcyB0aGVyZS4N
Ckdvb2QuIEknbGwgY2hhbmdlIGl0IGFzIG1lbnRpb25lZCBhbmQgc2VuZCBhIG5ldyBwYXRjaC4N
CglzaSA9IHN3cF9zd2FwX2luZm8oZW50cnkpOw0KKwlpZiAodW5saWtlbHkoIXNpKSkgew0KKwkJ
V0FSTigxLCBLRVJOX0VSUiAiJXM6ICVzJTA4bHhcbiIsIF9fZnVuY19fLCBCYWRfZmlsZSwgZW50
cnkudmFsKTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQoNCg0K

