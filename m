Return-Path: <linux-kernel+bounces-365534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81A99E3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB965283982
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2A1E572C;
	Tue, 15 Oct 2024 10:23:19 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E121E3DE8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987798; cv=none; b=RaATI9oxUS+hR/kSU3CCVhNbfsgBbVWbOClMpcKl1LAlk1IkIT5lSTidGSlpNPJdJisRpwTRH+SBozA+dWC1+jFG3AqD7sV5/6LkSBdjxqU0cnLPTX2hSf0Z6wOQ/tYjA42e45CSe/yOMpoiDp/DEp+65TCfEbuQCXE6/Axh/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987798; c=relaxed/simple;
	bh=Hz+ZLsRuWT+3mXwHB1+T6Y3VoHaFmDdffMk2nGBf/xU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5h+VmebiCTvNWCw0yYkmjNqBVcrrCX2dfNxYzUVle3tLAmTga8pgP4BBdy5nU/zKQKbOCsbZtKBc86BKg7fSDqKeXUUb95fFHI1xCtBZtlp1dupf4ZTTnTLz4fu0EfTqduW+XPpxWyprgU8B974DhnaFpGbOb/PWnRv5LMniBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4XSV3X0S1GzYl25Z;
	Tue, 15 Oct 2024 18:00:56 +0800 (CST)
Received: from a001.hihonor.com (10.68.28.182) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 18:03:11 +0800
Received: from a007.hihonor.com (10.68.22.31) by a001.hihonor.com
 (10.68.28.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 18:03:11 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 18:03:11 +0800
From: gaoxu <gaoxu2@honor.com>
To: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@suse.com"
	<mhocko@suse.com>, "hailong.liu@oppo.com" <hailong.liu@oppo.com>,
	"kaleshsingh@google.com" <kaleshsingh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lokeshgidra@google.com" <lokeshgidra@google.com>, "ngeoffray@google.com"
	<ngeoffray@google.com>, "shli@fb.com" <shli@fb.com>, "surenb@google.com"
	<surenb@google.com>, "yuzhao@google.com" <yuzhao@google.com>,
	"minchan@kernel.org" <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkZDXSBtbTogbWdscnU6IHByb3ZpZGUgYSBzZXBh?=
 =?utf-8?Q?rate_list_for_lazyfree_anon_folios?=
Thread-Topic: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon
 folios
Thread-Index: AQHbBnCmShcKECBep0eJF+tvIkpJDLJbX+UAgAQEpICAKFfioA==
Date: Tue, 15 Oct 2024 10:03:11 +0000
Message-ID: <7dcd3446cd8c4da69242e5d6680c1429@honor.com>
References: <20240914063746.46290-1-21cnbao@gmail.com>
 <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
 <CAGsJ_4zdqXtvUS8fHzUhM=iGrPpC8X7uw8wt4sSfCvsrh7um3w@mail.gmail.com>
In-Reply-To: <CAGsJ_4zdqXtvUS8fHzUhM=iGrPpC8X7uw8wt4sSfCvsrh7um3w@mail.gmail.com>
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

PiANCj4gT24gV2VkLCBTZXAgMTgsIDIwMjQgYXQgMTI6MDLigK9BTSBEYXZpZCBIaWxkZW5icmFu
ZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiAxNC4wOS4yNCAwODoz
NywgQmFycnkgU29uZyB3cm90ZToNCj4gPiA+IEZyb206IEJhcnJ5IFNvbmcgPHYtc29uZ2Jhb2h1
YUBvcHBvLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIGZvbGxvd3MgdXAgb24gdGhlIGRpc2N1c3Np
b24gcmVnYXJkaW5nIEdhb3h1J3Mgd29ya1sxXS4gSXQncw0KPiA+ID4gdW5jbGVhciBpZiB0aGVy
ZSdzIHN0aWxsIGludGVyZXN0IGluIGltcGxlbWVudGluZyBhIHNlcGFyYXRlIExSVQ0KPiA+ID4g
bGlzdCBmb3IgbGF6eWZyZWUgZm9saW9zLCBidXQgSSBkZWNpZGVkIHRvIGV4cGxvcmUgaXQgb3V0
IG9mDQo+ID4gPiBjdXJpb3NpdHkuDQo+ID4gPg0KPiA+ID4gQWNjb3JkaW5nIHRvIExva2VzaCwg
TUFEVl9GUkVFJ2QgYW5vbiBmb2xpb3MgYXJlIGV4cGVjdGVkIHRvIGJlDQo+ID4gPiByZWxlYXNl
ZCBlYXJsaWVyIHRoYW4gZmlsZSBmb2xpb3MuIE9uZSBvcHRpb24sIGFzIGltcGxlbWVudGVkIGJ5
IEdhbw0KPiA+ID4gWHUsIGlzIHRvIHBsYWNlIGxhenlmcmVlIGFub24gZm9saW9zIGF0IHRoZSB0
YWlsIG9mIHRoZSBmaWxlJ3MNCj4gPiA+IGBtaW5fc2VxYCBnZW5lcmF0aW9uLiBIb3dldmVyLCB0
aGlzIGFwcHJvYWNoIHJlc3VsdHMgaW4gbGF6eWZyZWUNCj4gPiA+IGZvbGlvcyBiZWluZyByZWxl
YXNlZCBpbiBhIExJRk8gbWFubmVyLCB3aGljaCBjb25mbGljdHMgd2l0aCBMUlUNCj4gPiA+IGJl
aGF2aW9yLCBhcyBub3RlZCBieSBNaWNoYWwuDQo+ID4gPg0KPiA+ID4gVG8gYWRkcmVzcyB0aGlz
LCB0aGlzIHBhdGNoIHByb3Bvc2VzIG1haW50YWluaW5nIGEgc2VwYXJhdGUgbGlzdCBmb3INCj4g
PiA+IGxhenlmcmVlIGFub24gZm9saW9zIHdoaWxlIGtlZXBpbmcgdGhlbSBjbGFzc2lmaWVkIHVu
ZGVyIHRoZSAiZmlsZSINCj4gPiA+IExSVSB0eXBlIHRvIG1pbmltaXplIGNvZGUgY2hhbmdlcy4g
VGhlc2UgbGF6eWZyZWUgYW5vbiBmb2xpb3Mgd2lsbA0KPiA+ID4gc3RpbGwgYmUgY291bnRlZCBh
cyBmaWxlIGZvbGlvcyBhbmQgc2hhcmUgdGhlIHNhbWUgZ2VuZXJhdGlvbiB3aXRoDQo+ID4gPiBy
ZWd1bGFyIGZpbGVzLiBJbiB0aGUgZXZpY3Rpb24gcGF0aCwgdGhlIGxhenlmcmVlIGxpc3Qgd2ls
bCBiZQ0KPiA+ID4gcHJpb3JpdGl6ZWQgZm9yIHNjYW5uaW5nIGJlZm9yZSB0aGUgYWN0dWFsIGZp
bGUgTFJVIGxpc3QuDQo+ID4gPg0KPiA+DQo+ID4gV2hhdCdzIHRoZSBkb3duc2lkZSBvZiBhbm90
aGVyIExSVSBsaXN0PyBEbyB3ZSBoYXZlIGFueSBleHBlcmllbmNlIG9uIHRoYXQ/DQo+IA0KPiBF
c3NlbnRpYWxseSwgdGhlIGdvYWwgaXMgdG8gYWRkcmVzcyB0aGUgZG93bnNpZGVzIG9mIHVzaW5n
IGEgc2luZ2xlIExSVSBsaXN0IGZvciBmaWxlcw0KPiBhbmQgbGF6eWZyZWUgYW5vbnltb3VzIHBh
Z2VzIC0gc2VyaW91c2x5IG1vcmUgZmlsZXMgcmUtZmF1bHRzLg0KPiANCj4gSSdtIG5vdCBlbnRp
cmVseSBjbGVhciBvbiB0aGUgZG93bnNpZGVzIG9mIGhhdmluZyBhbiBhZGRpdGlvbmFsIExSVSBs
aXN0LiBXaGlsZSBpdA0KPiBkb2VzIGluY3JlYXNlIGNvbXBsZXhpdHksIGl0IGRvZXNuJ3Qgc2Vl
bSB0byBiZSBzaWduaWZpY2FudC4NCj4gDQo+IExldCdzIHdhaXQgZm9yIEdhb3h1J3MgdGVzdCBy
ZXN1bHRzIGJlZm9yZSBkZWNpZGluZyBvbiB0aGUgbmV4dCBzdGVwcy4NCj4gSSB3YXMganVzdA0K
PiBjdXJpb3VzIGFib3V0IGhvdyBkaWZmaWN1bHQgaXQgd291bGQgYmUgdG8gYWRkIGEgc2VwYXJh
dGUgbGlzdCwgc28gSSB0b29rIHR3byBob3Vycw0KPiB0byBleHBsb3JlIGl0IDotKQ0KSGkgc29u
ZywNCkknbSB2ZXJ5IHNvcnJ5LCB2YXJpb3VzIHJlYXNvbnMgY29tYmluZWQgaGF2ZSBjYXVzZWQg
dGhlIGRlbGF5IGluIHRoZSByZXN1bHRzLg0KDQpCYXNpYyB2ZXJzaW9u77yaYW5kcm9pZCBWIChl
bmFibGUgQW5kcm9pZCBBUlQgdXNlIE1BRFZfRlJFRSkNClRlc3QgY2FzZXM6IDYwIGFwcHMgcmVw
ZWF0ZWRseSByZXN0YXJ0ZWQsIHRlc3RlZCBmb3IgOCBob3VyczsNClRoZSB0ZXN0IHJlc3VsdHMg
YXJlIGFzIGZvbGxvd3M6DQogICAgICAgIHdvcmtpbmdzZXRfcmVmYXVsdF9hbm9uICAgd29ya2lu
Z3NldF9yZWZhdWx0X2ZpbGUNCmJhc2UgICAgICAgIDQyMDE2ODA1ICAgICAgICAgICAgICAgIDky
MDEwNTQyDQpwYXRjaCAgICAgICAxOTgzNDg3MyAgICAgICAgICAgICAgICA0OTM4MzU3Mg0KJSBk
aWZmICAgICAgIC01Mi43OSUgICAgICAgICAgICAgICAgICAtNDYuMzMlDQoNCkFkZGl0aW9uYWxs
eSwgYSBjb21wYXJhdGl2ZSB0ZXN0IHdhcyBjb25kdWN0ZWQgb24NCmFkZC1sYXp5ZnJlZS1mb2xp
by10by1scnUtdGFpbC5wYXRjaFsxXSwgYW5kIHRoZSByZXN1bHRzIGFyZSBhcyBmb2xsb3dzOg0K
ICAgICAgICAgICAgICAgd29ya2luZ3NldF9yZWZhdWx0X2Fub24gICB3b3JraW5nc2V0X3JlZmF1
bHRfZmlsZQ0KbGF6eWZyZWUtdGFpbCAgICAgICAgMjAzMTMzOTUgICAgICAgICAgICAgICAgIDUy
MjAzMDYxDQpwYXRjaCAgICAgICAgICAgICAxOTgzNDg3MyAgICAgICAgICAgICAgICAgNDkzODM1
NzINCiUgZGlmZiAgICAgICAgICAgICAgLTIuMzYlICAgICAgICAgICAgICAgICAgICAtNS40MCUN
Cg0KRnJvbSB0aGUgcmVzdWx0cywgaXQgY2FuIGJlIHNlZW4gdGhhdCB0aGlzIHBhdGNoIGlzIHZl
cnkgYmVuZWZpY2lhbCBhbmQNCmJldHRlciB0aGFuIHRoZSByZXN1bHRzIGluIFsxXTsgaXQgY2Fu
IHNvbHZlIHRoZSBwZXJmb3JtYW5jZSBpc3N1ZSBvZiBoaWdoDQpJTyBjYXVzZWQgYnkgZXh0ZW5z
aXZlIHVzZSBvZiBNQURWX0ZSRUUgb24gdGhlIEFuZHJvaWQgcGxhdGZvcm0uDQoNClRlc3QgY2Fz
ZSBub3RlczogVGhlcmUgaXMgYSBkaXNjcmVwYW5jeSBiZXR3ZWVuIHRoZSB0ZXN0IHJlc3VsdHMg
bWVudGlvbmVkIGluDQpbMV0gYW5kIHRoZSBjdXJyZW50IHRlc3QgcmVzdWx0cyBiZWNhdXNlIHRo
ZSB0ZXN0IGNhc2VzIGFyZSBkaWZmZXJlbnQuIFRoZSB0ZXN0DQpjYXNlIHVzZWQgaW4gWzFdIGlu
dm9sdmVzIGFjdGlvbnMgc3VjaCBhcyBjbGlja2luZyBhbmQgc3dpcGluZyB3aXRoaW4gdGhlIGFw
cA0KYWZ0ZXIgaXQgc3RhcnRzOyBGb3IgdGhlIHNha2Ugb2YgY29udmVuaWVuY2UgYW5kIHJlc3Vs
dCBzdGFiaWxpdHksIHRoZSBjdXJyZW50DQp0ZXN0IGNhc2Ugb25seSBpbnZvbHZlcyBhcHAgc3Rh
cnR1cCB3aXRob3V0IGNsaWNraW5nIGFuZCBzd2lwaW5nLCBhbmQgdGhlIG51bWJlcg0Kb2YgYXBw
cyBoYXMgYmVlbiBpbmNyZWFzZWQgKDMwLT42MCkuDQoNCjEuIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9mMjlmNjRlMjljMDg0MjdiOTVlM2RmMzBhNTc3MDA1NkBob25vci5jb20vVC8jdQ0K
PiANCj4gPg0KPiA+IC0tDQo+ID4gQ2hlZXJzLA0KPiA+DQo+ID4gRGF2aWQgLyBkaGlsZGVuYg0K
PiA+DQo+IA0KPiBUaGFua3MNCj4gQmFycnkNCg==

