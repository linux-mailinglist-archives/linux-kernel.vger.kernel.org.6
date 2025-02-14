Return-Path: <linux-kernel+bounces-514753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB1A35B17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FCA16F1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193EA2566C9;
	Fri, 14 Feb 2025 10:04:41 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB13202C43
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527480; cv=none; b=XlrZfM+UepwWIR8Y01xT859o6MtILWQ3aCaKFEKUxX/YhkeDKiFFIunzW6ga5CrE9kVjkU7Em4S7fGbRB3XaCv1fQQsml3yGFGOCMKexMelhsRnXtX1yZQBWZl7Ktqg7VJK8kGGqTRsUj3O6byU3QFL0AKgIKNJ2uV587S/SKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527480; c=relaxed/simple;
	bh=sYCsC4QVsS62ZZoGPyT+of3+OgswiwVgXuNWBsHjT44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IA2pZvT10HSAjWmSzG262q5IqSzxc0078RB85inOgaTn4UAQdJzFvKixaQutjBAwYSc176A5QugGc28wRl0IPlM6jt1L/plSMy2aHoK8es2wVnqLM0BkA/tmvUvfK2uY2JWd+uW//En1DNXNg88kPHtchxZOi4BisHvCekGVBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4YvSKw6nGqzYl1j9;
	Fri, 14 Feb 2025 18:03:16 +0800 (CST)
Received: from a006.hihonor.com (10.68.23.242) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Feb
 2025 18:04:20 +0800
Received: from a007.hihonor.com (10.68.22.31) by a006.hihonor.com
 (10.68.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Feb
 2025 18:04:20 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Fri, 14 Feb 2025 18:04:20 +0800
From: gaoxu <gaoxu2@honor.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, Barry
 Song <21cnbao@gmail.com>, yipengxiang <yipengxiang@honor.com>, "Hugh Dickins"
	<hughd@google.com>, Chris Li <chrisl@kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gbW06IEZpeCBwb3NzaWJsZSBOVUxM?=
 =?utf-8?B?IHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gX19zd2FwX2R1cGxpY2F0ZQ==?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOiBGaXggcG9zc2libGUgTlVMTCBwb2ludGVy?=
 =?utf-8?B?IGRlcmVmZXJlbmNlIGluIF9fc3dhcF9kdXBsaWNhdGU=?=
Thread-Index: Adt8+0GogoLTL6hgQfOcUIXDGgpBSQAbnlYAACsSnkAABbtDgAAmkrFA
Date: Fri, 14 Feb 2025 10:04:20 +0000
Message-ID: <f023968c870e42f3b32e5038d393163f@honor.com>
References: <44655569e3a1419f800952004f07e714@honor.com>
 <20250212161820.4fda79a3333d2345b60cef72@linux-foundation.org>
 <da7e1ee115454cf8898b4bbe228a5a9c@honor.com> <Z66B0T125JhdWo1n@google.com>
In-Reply-To: <Z66B0T125JhdWo1n@google.com>
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

PiA+ID4NCj4gPiA+ID4gc3dwX3N3YXBfaW5mbygpIG1heSByZXR1cm4gbnVsbDsgaXQgaXMgbmVj
ZXNzYXJ5IHRvIGNoZWNrIHRoZQ0KPiA+ID4gPiByZXR1cm4gdmFsdWUgdG8gYXZvaWQgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlLiBUaGUgY29kZSBmb3Igb3RoZXINCj4gPiA+ID4gY2FsbHMgdG8N
Cj4gPiA+ID4gc3dwX3N3YXBfaW5mbygpIGluY2x1ZGVzIGNoZWNrcywgYW5kIF9fc3dhcF9kdXBs
aWNhdGUoKSBzaG91bGQNCj4gPiA+ID4gYWxzbyBpbmNsdWRlIGNoZWNrcy4NCj4gPiA+DQo+ID4g
PiBBY3R1YWxseSB2ZXJ5IGZldyBvZiB0aGUgc3dwX3N3YXBfaW5mbygpIGNhbGxlcnMgY2hlY2sg
Zm9yIGEgTlVMTCByZXR1cm4uDQo+ID4gVGhlIHN3YXBmaWxlLmMgZmlsZSBjb250YWlucyB0aHJl
ZSBpbnN0YW5jZXMgd2hlcmUgdGhlIHJldHVybiB2YWx1ZSBvZg0KPiA+IHN3cF9zd2FwX2luZm8o
KSBpcyBjaGVja2VkIGZvciBhIE5VTEwgcmV0dXJuLiBJbiBvdGhlciBmaWxlcyB0aGF0IGNhbGwN
Cj4gPiBzd3Bfc3dhcF9pbmZvKCksIEkgaGF2ZSBjb25maXJtZWQgdGhhdCB0aGVyZSBhcmUgbm8g
c3VjaCBjaGVja3MuDQo+ID4gVGhlIGRlc2NyaXB0aW9uIGluIHRoZSBwYXRjaCBpcyBpbmFjY3Vy
YXRlLCBhbmQgSSBoYXZlIG1hZGUNCj4gPiBtb2RpZmljYXRpb25zIGluIHBhdGNoIHYyLg0KPiA+
ID4NCj4gPiA+ID4gVGhlIHJlYXNvbiB3aHkgc3dwX3N3YXBfaW5mbygpIHJldHVybnMgTlVMTCBp
cyB1bmNsZWFyOyBpdCBtYXkgYmUNCj4gPiA+ID4gZHVlIHRvIENQVSBjYWNoZSBpc3N1ZXMgb3Ig
RERSIGJpdCBmbGlwcy4NCj4gPiA+DQo+ID4gPiBRdWl0ZSBwb3NzaWJseSBpdCdzIGEga2VybmVs
IGJ1Zy4NCj4gPiA+DQo+ID4gPiA+IFRoZSBwcm9iYWJpbGl0eSBvZiB0aGlzIGlzc3VlIGlzIHZl
cnkgc21hbGwsIGFuZCB0aGUgc3RhY2sgaW5mbyB3ZQ0KPiA+ID4gPiBlbmNvdW50ZXJlZCBpcyBh
cyBmb2xsb3dz77yaDQo+ID4gPiA+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsDQo+ID4gPiA+IGFkZHJlc3MNCj4gPiA+ID4gMDAwMDAw
MDAwMDAwMDA1OA0KPiA+ID4gPg0KPiA+ID4gPiAuLi4NCj4gPiA+ID4NCj4gPiA+ID4gLS0tIGEv
bW0vc3dhcGZpbGUuYw0KPiA+ID4gPiArKysgYi9tbS9zd2FwZmlsZS5jDQo+ID4gPiA+IEBAIC0z
NTIxLDYgKzM1MjEsOCBAQCBzdGF0aWMgaW50IF9fc3dhcF9kdXBsaWNhdGUoc3dwX2VudHJ5X3QN
Cj4gPiA+ID4gZW50cnksDQo+ID4gPiB1bnNpZ25lZCBjaGFyIHVzYWdlLCBpbnQgbnIpDQo+ID4g
PiA+ICAJaW50IGVyciwgaTsNCj4gPiA+ID4NCj4gPiA+ID4gIAlzaSA9IHN3cF9zd2FwX2luZm8o
ZW50cnkpOw0KPiA+ID4gPiArCWlmICh1bmxpa2VseSghc2kpKQ0KPiA+ID4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiA+ID4NCj4gPiA+ID4gIAlvZmZzZXQgPSBzd3Bfb2Zmc2V0KGVudHJ5KTsN
Cj4gPiA+ID4gIAlWTV9XQVJOX09OKG5yID4gU1dBUEZJTEVfQ0xVU1RFUiAtIG9mZnNldCAlDQo+
IFNXQVBGSUxFX0NMVVNURVIpOw0KPiA+ID4NCj4gPiA+IE9LLCBJIGd1ZXNzIGF2b2lkaW5nIHRo
ZSBjcmFzaCBpcyBnb29kLiAgQnV0IHBsZWFzZSBsZXQncyBpbmNsdWRlIGENCj4gPiA+IFdBUk4g
c28gdGhhdCB3ZSBjYW4gcGVyaGFwcyBmaXggdGhlIGJ1ZywgaWYgb25lIGlzIHRoZXJlLg0KPiA+
IEdvb2QuIEknbGwgY2hhbmdlIGl0IGFzIG1lbnRpb25lZCBhbmQgc2VuZCBhIG5ldyBwYXRjaC4N
Cj4gPiAJc2kgPSBzd3Bfc3dhcF9pbmZvKGVudHJ5KTsNCj4gPiArCWlmICh1bmxpa2VseSghc2kp
KSB7DQo+ID4gKwkJV0FSTigxLCBLRVJOX0VSUiAiJXM6ICVzJTA4bHhcbiIsIF9fZnVuY19fLCBC
YWRfZmlsZSwgZW50cnkudmFsKTsNCj4gDQo+IFdBUk4oKSBhbHJlYWR5IGNvbnRhaW5zIHVubGlr
ZWx5KCkuIEFsc28sIG5vIG5lZWQgdG8gcHJpbnQgdGhlIGZ1bmN0aW9uIG5hbWUgaXQncw0KPiBh
bHJlYWR5IGluIHRoZSBzdGFjayB0cmFjZS4NCj4gDQo+IFdlIHNob3VsZCBwcm9iYWJseSBqdXN0
IGRvIGlmIChXQVJOX09OX09OQ0UoIXNpKSkuDQo+IA0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0K
PiA+ICsJfQ0KWWVzLCB0aGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gVGhpcyBtb2RpZmlj
YXRpb24gbWFrZXMgdGhlIGNvZGUgc2ltcGxlci4NCglzaSA9IHN3cF9zd2FwX2luZm8oZW50cnkp
Ow0KKwlpZiAoV0FSTl9PTl9PTkNFKCFzaSkpDQorCQlyZXR1cm4gLUVJTlZBTDsNCg0KPiA+DQo+
ID4NCg==

