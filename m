Return-Path: <linux-kernel+bounces-367069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A499FE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E918E288222
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252F13BAE2;
	Wed, 16 Oct 2024 01:26:04 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FA42AA4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041964; cv=none; b=HHw/JOZhh8L8JxkjjNzEPdff6Y3yKbnjXxjFHCL0IDe+HraTyAVJ35J3p588+tEf2+1PcE+2R9v7DgUuEncqH/XlMG0krGVS3t9hj5PuJ2ziqIoX5oeIV9+/nF4aZh2NbLY4dDOOmHUlyGrjcDdK36zlrnC5ZpH5wsj5+pmjJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041964; c=relaxed/simple;
	bh=Q9W3LBi3A2xDUrzi/h8CnwiUPgO0it3f4MLxrTV7zes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHdbIzGZT3psYtFyWifuWRRAL/+nvNzpWI3RjKFDcQWbpX7612edi87zJVKrkP7fYkKRK29NCVNUJDnoXTFK8w0RVbWhHfmb60NgXQHZ8Yv94xZ+oeq+9PJzdE5qqANK4XiWIn8T/nXdRwpW80fLIVZlRspJZCDE3TvXywK7KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4XStXH1fpxzYl0Dm;
	Wed, 16 Oct 2024 09:23:43 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 09:25:59 +0800
Received: from a007.hihonor.com (10.68.22.31) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 09:25:58 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Wed, 16 Oct 2024 09:25:58 +0800
From: gaoxu <gaoxu2@honor.com>
To: Barry Song <21cnbao@gmail.com>
CC: David Hildenbrand <david@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"mhocko@suse.com" <mhocko@suse.com>, "hailong.liu@oppo.com"
	<hailong.liu@oppo.com>, "kaleshsingh@google.com" <kaleshsingh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lokeshgidra@google.com" <lokeshgidra@google.com>, "ngeoffray@google.com"
	<ngeoffray@google.com>, "shli@fb.com" <shli@fb.com>, "surenb@google.com"
	<surenb@google.com>, "yuzhao@google.com" <yuzhao@google.com>,
	"minchan@kernel.org" <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkZDXSBtbTogbWdscnU6IHByb3ZpZGUgYSBzZXBh?=
 =?utf-8?Q?rate_list_for_lazyfree_anon_folios?=
Thread-Topic: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon
 folios
Thread-Index: AQHbBnCmShcKECBep0eJF+tvIkpJDLJbX+UAgAQEpICAKFfioIAALR2AgADcLyA=
Date: Wed, 16 Oct 2024 01:25:58 +0000
Message-ID: <8cbee57b2d7a44339372be8c7c4f25bd@honor.com>
References: <20240914063746.46290-1-21cnbao@gmail.com>
 <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
 <CAGsJ_4zdqXtvUS8fHzUhM=iGrPpC8X7uw8wt4sSfCvsrh7um3w@mail.gmail.com>
 <7dcd3446cd8c4da69242e5d6680c1429@honor.com>
 <CAGsJ_4xF6FuncfErMmMotkOYNGZcqPXqS20zORAyVZ4LYbO0_w@mail.gmail.com>
In-Reply-To: <CAGsJ_4xF6FuncfErMmMotkOYNGZcqPXqS20zORAyVZ4LYbO0_w@mail.gmail.com>
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

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEJhcnJ5IFNvbmcgPDIx
Y25iYW9AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQxMOaciDE25pelIDQ6MTAN
Cj4g5pS25Lu25Lq6OiBnYW94dSA8Z2FveHUyQGhvbm9yLmNvbT4NCj4g5oqE6YCBOiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
DQo+IGxpbnV4LW1tQGt2YWNrLm9yZzsgbWhvY2tvQHN1c2UuY29tOyBoYWlsb25nLmxpdUBvcHBv
LmNvbTsNCj4ga2FsZXNoc2luZ2hAZ29vZ2xlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gbG9rZXNoZ2lkcmFAZ29vZ2xlLmNvbTsgbmdlb2ZmcmF5QGdvb2dsZS5jb207IHNo
bGlAZmIuY29tOw0KPiBzdXJlbmJAZ29vZ2xlLmNvbTsgeXV6aGFvQGdvb2dsZS5jb207IG1pbmNo
YW5Aa2VybmVsLm9yZzsgQmFycnkgU29uZw0KPiA8di1zb25nYmFvaHVhQG9wcG8uY29tPg0KPiDk
uLvpopg6IFJlOiBbUEFUQ0ggUkZDXSBtbTogbWdscnU6IHByb3ZpZGUgYSBzZXBhcmF0ZSBsaXN0
IGZvciBsYXp5ZnJlZSBhbm9uIGZvbGlvcw0KPiANCj4gT24gVHVlLCBPY3QgMTUsIDIwMjQgYXQg
MTE6MDPigK9QTSBnYW94dSA8Z2FveHUyQGhvbm9yLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+DQo+
ID4gPiBPbiBXZWQsIFNlcCAxOCwgMjAyNCBhdCAxMjowMuKAr0FNIERhdmlkIEhpbGRlbmJyYW5k
DQo+ID4gPiA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBPbiAxNC4wOS4yNCAwODozNywgQmFycnkgU29uZyB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBC
YXJyeSBTb25nIDx2LXNvbmdiYW9odWFAb3Bwby5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBU
aGlzIGZvbGxvd3MgdXAgb24gdGhlIGRpc2N1c3Npb24gcmVnYXJkaW5nIEdhb3h1J3Mgd29ya1sx
XS4NCj4gPiA+ID4gPiBJdCdzIHVuY2xlYXIgaWYgdGhlcmUncyBzdGlsbCBpbnRlcmVzdCBpbiBp
bXBsZW1lbnRpbmcgYQ0KPiA+ID4gPiA+IHNlcGFyYXRlIExSVSBsaXN0IGZvciBsYXp5ZnJlZSBm
b2xpb3MsIGJ1dCBJIGRlY2lkZWQgdG8gZXhwbG9yZQ0KPiA+ID4gPiA+IGl0IG91dCBvZiBjdXJp
b3NpdHkuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBY2NvcmRpbmcgdG8gTG9rZXNoLCBNQURWX0ZS
RUUnZCBhbm9uIGZvbGlvcyBhcmUgZXhwZWN0ZWQgdG8gYmUNCj4gPiA+ID4gPiByZWxlYXNlZCBl
YXJsaWVyIHRoYW4gZmlsZSBmb2xpb3MuIE9uZSBvcHRpb24sIGFzIGltcGxlbWVudGVkIGJ5DQo+
ID4gPiA+ID4gR2FvIFh1LCBpcyB0byBwbGFjZSBsYXp5ZnJlZSBhbm9uIGZvbGlvcyBhdCB0aGUg
dGFpbCBvZiB0aGUNCj4gPiA+ID4gPiBmaWxlJ3MgYG1pbl9zZXFgIGdlbmVyYXRpb24uIEhvd2V2
ZXIsIHRoaXMgYXBwcm9hY2ggcmVzdWx0cyBpbg0KPiA+ID4gPiA+IGxhenlmcmVlIGZvbGlvcyBi
ZWluZyByZWxlYXNlZCBpbiBhIExJRk8gbWFubmVyLCB3aGljaCBjb25mbGljdHMNCj4gPiA+ID4g
PiB3aXRoIExSVSBiZWhhdmlvciwgYXMgbm90ZWQgYnkgTWljaGFsLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVG8gYWRkcmVzcyB0aGlzLCB0aGlzIHBhdGNoIHByb3Bvc2VzIG1haW50YWluaW5nIGEg
c2VwYXJhdGUgbGlzdA0KPiA+ID4gPiA+IGZvciBsYXp5ZnJlZSBhbm9uIGZvbGlvcyB3aGlsZSBr
ZWVwaW5nIHRoZW0gY2xhc3NpZmllZCB1bmRlciB0aGUgImZpbGUiDQo+ID4gPiA+ID4gTFJVIHR5
cGUgdG8gbWluaW1pemUgY29kZSBjaGFuZ2VzLiBUaGVzZSBsYXp5ZnJlZSBhbm9uIGZvbGlvcw0K
PiA+ID4gPiA+IHdpbGwgc3RpbGwgYmUgY291bnRlZCBhcyBmaWxlIGZvbGlvcyBhbmQgc2hhcmUg
dGhlIHNhbWUNCj4gPiA+ID4gPiBnZW5lcmF0aW9uIHdpdGggcmVndWxhciBmaWxlcy4gSW4gdGhl
IGV2aWN0aW9uIHBhdGgsIHRoZQ0KPiA+ID4gPiA+IGxhenlmcmVlIGxpc3Qgd2lsbCBiZSBwcmlv
cml0aXplZCBmb3Igc2Nhbm5pbmcgYmVmb3JlIHRoZSBhY3R1YWwgZmlsZSBMUlUgbGlzdC4NCj4g
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBXaGF0J3MgdGhlIGRvd25zaWRlIG9mIGFub3RoZXIg
TFJVIGxpc3Q/IERvIHdlIGhhdmUgYW55IGV4cGVyaWVuY2Ugb24NCj4gdGhhdD8NCj4gPiA+DQo+
ID4gPiBFc3NlbnRpYWxseSwgdGhlIGdvYWwgaXMgdG8gYWRkcmVzcyB0aGUgZG93bnNpZGVzIG9m
IHVzaW5nIGEgc2luZ2xlDQo+ID4gPiBMUlUgbGlzdCBmb3IgZmlsZXMgYW5kIGxhenlmcmVlIGFu
b255bW91cyBwYWdlcyAtIHNlcmlvdXNseSBtb3JlIGZpbGVzIHJlLWZhdWx0cy4NCj4gPiA+DQo+
ID4gPiBJJ20gbm90IGVudGlyZWx5IGNsZWFyIG9uIHRoZSBkb3duc2lkZXMgb2YgaGF2aW5nIGFu
IGFkZGl0aW9uYWwgTFJVDQo+ID4gPiBsaXN0LiBXaGlsZSBpdCBkb2VzIGluY3JlYXNlIGNvbXBs
ZXhpdHksIGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBzaWduaWZpY2FudC4NCj4gPiA+DQo+ID4gPiBM
ZXQncyB3YWl0IGZvciBHYW94dSdzIHRlc3QgcmVzdWx0cyBiZWZvcmUgZGVjaWRpbmcgb24gdGhl
IG5leHQgc3RlcHMuDQo+ID4gPiBJIHdhcyBqdXN0DQo+ID4gPiBjdXJpb3VzIGFib3V0IGhvdyBk
aWZmaWN1bHQgaXQgd291bGQgYmUgdG8gYWRkIGEgc2VwYXJhdGUgbGlzdCwgc28gSQ0KPiA+ID4g
dG9vayB0d28gaG91cnMgdG8gZXhwbG9yZSBpdCA6LSkNCj4gPiBIaSBzb25nLA0KPiA+IEknbSB2
ZXJ5IHNvcnJ5LCB2YXJpb3VzIHJlYXNvbnMgY29tYmluZWQgaGF2ZSBjYXVzZWQgdGhlIGRlbGF5
IGluIHRoZSByZXN1bHRzLg0KPiA+DQo+ID4gQmFzaWMgdmVyc2lvbu+8mmFuZHJvaWQgViAoZW5h
YmxlIEFuZHJvaWQgQVJUIHVzZSBNQURWX0ZSRUUpIFRlc3QgY2FzZXM6DQo+ID4gNjAgYXBwcyBy
ZXBlYXRlZGx5IHJlc3RhcnRlZCwgdGVzdGVkIGZvciA4IGhvdXJzOyBUaGUgdGVzdCByZXN1bHRz
IGFyZQ0KPiA+IGFzIGZvbGxvd3M6DQo+ID4gICAgICAgICB3b3JraW5nc2V0X3JlZmF1bHRfYW5v
biAgIHdvcmtpbmdzZXRfcmVmYXVsdF9maWxlDQo+ID4gYmFzZSAgICAgICAgNDIwMTY4MDUgICAg
ICAgICAgICAgICAgOTIwMTA1NDINCj4gPiBwYXRjaCAgICAgICAxOTgzNDg3MyAgICAgICAgICAg
ICAgICA0OTM4MzU3Mg0KPiA+ICUgZGlmZiAgICAgICAtNTIuNzklICAgICAgICAgICAgICAgICAg
LTQ2LjMzJQ0KPiA+DQo+ID4gQWRkaXRpb25hbGx5LCBhIGNvbXBhcmF0aXZlIHRlc3Qgd2FzIGNv
bmR1Y3RlZCBvbg0KPiA+IGFkZC1sYXp5ZnJlZS1mb2xpby10by1scnUtdGFpbC5wYXRjaFsxXSwg
YW5kIHRoZSByZXN1bHRzIGFyZSBhcyBmb2xsb3dzOg0KPiA+ICAgICAgICAgICAgICAgIHdvcmtp
bmdzZXRfcmVmYXVsdF9hbm9uICAgd29ya2luZ3NldF9yZWZhdWx0X2ZpbGUNCj4gPiBsYXp5ZnJl
ZS10YWlsICAgICAgICAyMDMxMzM5NSAgICAgICAgICAgICAgICAgNTIyMDMwNjENCj4gPiBwYXRj
aCAgICAgICAgICAgICAxOTgzNDg3MyAgICAgICAgICAgICAgICAgNDkzODM1NzINCj4gPiAlIGRp
ZmYgICAgICAgICAgICAgIC0yLjM2JSAgICAgICAgICAgICAgICAgICAgLTUuNDAlDQo+ID4NCj4g
PiBGcm9tIHRoZSByZXN1bHRzLCBpdCBjYW4gYmUgc2VlbiB0aGF0IHRoaXMgcGF0Y2ggaXMgdmVy
eSBiZW5lZmljaWFsDQo+ID4gYW5kIGJldHRlciB0aGFuIHRoZSByZXN1bHRzIGluIFsxXTsgaXQg
Y2FuIHNvbHZlIHRoZSBwZXJmb3JtYW5jZSBpc3N1ZQ0KPiA+IG9mIGhpZ2ggSU8gY2F1c2VkIGJ5
IGV4dGVuc2l2ZSB1c2Ugb2YgTUFEVl9GUkVFIG9uIHRoZSBBbmRyb2lkIHBsYXRmb3JtLg0KPiA+
DQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSB0ZXN0aW5nIGFuZCBkYXRhLiBUaGUgcmVzdWx0cyBs
b29rIHByb21pc2luZy4gV291bGQgeW91IG1pbmQNCj4gaWYgSSBzZW5kIGEgdjIgd2l0aCB0aGUg
dGVzdCBkYXRhIGFuZCB5b3VyIHRhZyBpbmNsdWRlZCBpbiB0aGUgY2hhbmdlbG9nPw0KPiBJIG1l
YW46DQo+IA0KPiBUZXN0ZWQtYnk6IEdhbyBYdSA8Z2FveHUyQGhpaG9ub3IuY29tPg0KT2YgY291
cnNlIG5vdCwgSSdkIGJlIGhhcHB5IHRvLg0KDQpEdWUgdG8gSU8gcGVyZm9ybWFuY2UgaXNzdWVz
LCBBbmRyb2lkIGhhcyByZXZlcnRlZCB0aGUgQVJUIHVzZSBvZiBNQURWX0ZSRUU7DQppdCBpcyBl
eHBlY3RlZCB0aGF0IG9uY2UgdGhlIGlzc3VlIGlzIHJlc29sdmVkLCBBbmRyb2lkIEFSVCB3aWxs
IHJlLWVuYWJsZSBNQURWX0ZSRUUgDQphbmQgcHJvbW90ZSB0aGUgdXNlIG9mIE1BRFZfRlJFRSBp
biBtb3JlIG1vZHVsZXMuDQo+IA0KPiA+IFRlc3QgY2FzZSBub3RlczogVGhlcmUgaXMgYSBkaXNj
cmVwYW5jeSBiZXR3ZWVuIHRoZSB0ZXN0IHJlc3VsdHMNCj4gPiBtZW50aW9uZWQgaW4gWzFdIGFu
ZCB0aGUgY3VycmVudCB0ZXN0IHJlc3VsdHMgYmVjYXVzZSB0aGUgdGVzdCBjYXNlcw0KPiA+IGFy
ZSBkaWZmZXJlbnQuIFRoZSB0ZXN0IGNhc2UgdXNlZCBpbiBbMV0gaW52b2x2ZXMgYWN0aW9ucyBz
dWNoIGFzDQo+ID4gY2xpY2tpbmcgYW5kIHN3aXBpbmcgd2l0aGluIHRoZSBhcHAgYWZ0ZXIgaXQg
c3RhcnRzOyBGb3IgdGhlIHNha2Ugb2YNCj4gPiBjb252ZW5pZW5jZSBhbmQgcmVzdWx0IHN0YWJp
bGl0eSwgdGhlIGN1cnJlbnQgdGVzdCBjYXNlIG9ubHkgaW52b2x2ZXMNCj4gPiBhcHAgc3RhcnR1
cCB3aXRob3V0IGNsaWNraW5nIGFuZCBzd2lwaW5nLCBhbmQgdGhlIG51bWJlciBvZiBhcHBzIGhh
cyBiZWVuDQo+IGluY3JlYXNlZCAoMzAtPjYwKS4NCj4gPg0KPiA+IDEuDQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsL2YyOWY2NGUyOWMwODQyN2I5NWUzZGYzMGE1NzcwMDU2QGhvbm9y
LmNvbQ0KPiA+IC9ULyN1DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiBDaGVl
cnMsDQo+ID4gPiA+DQo+ID4gPiA+IERhdmlkIC8gZGhpbGRlbmINCj4gPiA+ID4NCj4gPiA+DQo+
IA0KPiBUaGFua3MNCj4gQmFycnkNCg==

