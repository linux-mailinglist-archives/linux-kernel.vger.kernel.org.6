Return-Path: <linux-kernel+bounces-302554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C6960030
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150052823C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841DE7604F;
	Tue, 27 Aug 2024 04:08:09 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820EEAF6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731688; cv=none; b=uFlyFH275p9IzT8ofFq527tAf7+eA5FY2uSrMzfnjiRYqdkMJCLcxLzJxfiqcnvmZPMl+U7l3O0Mx5f/b7IoiWKugN914X5ZLkyOwmtsS6MYDXpyS5OJPFGpSQ8YozWBhgiYqgO8YUKJkyD1mhukhf2p4WAuH7dQtMWbiDv/Xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731688; c=relaxed/simple;
	bh=+PHmkpcwTDwx4FRgq1RZhXGKEGoB+Z442RTwtLg9f4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4sB/bP4rQ+iLN+TJmkWXzQvd8WYIjV+y+n79MqWqfmYisfe8jynvhsmXIpIkSaGFdGTiSASemg0RDFwRvppchZcJvW+bGBawt15snyLXGVG+kjfgQ20CuRqGM3A27iFmV+ARDsLMT8xX1rKEGzbS3NOOpZ1AQpx5m4qvns1qII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4WtDXs3YHczYl9gW;
	Tue, 27 Aug 2024 12:07:57 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 12:07:58 +0800
Received: from a007.hihonor.com (10.68.22.31) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 12:07:57 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Tue, 27 Aug 2024 12:07:57 +0800
From: gaoxu <gaoxu2@honor.com>
To: Lokesh Gidra <lokeshgidra@google.com>, Barry Song <21cnbao@gmail.com>,
	Minchan Kim <minchan@kernel.org>
CC: Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray
	<ngeoffray@google.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li
	<shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
	<fengbaopeng@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG1tOiBhZGQgbGF6eWZyZWUgZm9saW8gdG8g?=
 =?utf-8?Q?lru_tail?=
Thread-Topic: [PATCH v2] mm: add lazyfree folio to lru tail
Thread-Index: Adrvp/sHXyayf1r5TQG6pnGY8/qB0AD3RoCAABLl9gAAaIAOAACIH48AAAbl74AACPvZgAAYZiHA
Date: Tue, 27 Aug 2024 04:07:57 +0000
Message-ID: <1757d01334ee4391beba1ea3dcdfed7c@honor.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
 <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
 <CAGsJ_4zAf7LuJNOrUSG=kvFQf5Px1mYLMvCyF=q31uwghGY-wA@mail.gmail.com>
 <CA+EESO4MsRxMcTA-_g55rtLE0QTfB3=E53eW8+MSfncwmDx5OQ@mail.gmail.com>
In-Reply-To: <CA+EESO4MsRxMcTA-_g55rtLE0QTfB3=E53eW8+MSfncwmDx5OQ@mail.gmail.com>
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

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IExva2VzaCBHaWRyYSA8
bG9rZXNoZ2lkcmFAZ29vZ2xlLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0OOaciDI35pel
IDg6MTINCj4g5pS25Lu25Lq6OiBCYXJyeSBTb25nIDwyMWNuYmFvQGdtYWlsLmNvbT4NCj4g5oqE
6YCBOiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29tPjsgTmljb2xhcyBHZW9m
ZnJheQ0KPiA8bmdlb2ZmcmF5QGdvb2dsZS5jb20+OyBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNl
LmNvbT47IGdhb3h1DQo+IDxnYW94dTJAaG9ub3IuY29tPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz47DQo+IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU2hhb2h1YSBMaSA8c2hsaUBmYi5jb20+Ow0KPiB5aXBlbmd4aWFu
ZyA8eWlwZW5neGlhbmdAaG9ub3IuY29tPjsgZmVuZ2Jhb3BlbmcNCj4gPGZlbmdiYW9wZW5nQGhv
bm9yLmNvbT47IEthbGVzaCBTaW5naCA8a2FsZXNoc2luZ2hAZ29vZ2xlLmNvbT4NCj4g5Li76aKY
OiBSZTogW1BBVENIIHYyXSBtbTogYWRkIGxhenlmcmVlIGZvbGlvIHRvIGxydSB0YWlsDQo+IA0K
PiBPbiBNb24sIEF1ZyAyNiwgMjAyNCBhdCAxMjo1NeKAr1BNIEJhcnJ5IFNvbmcgPDIxY25iYW9A
Z21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgQXVnIDI3LCAyMDI0IGF0IDQ6Mzfi
gK9BTSBMb2tlc2ggR2lkcmEgPGxva2VzaGdpZHJhQGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IFRoYW5rcyBTdXJlbiBmb3IgbG9vcGluZyBpbg0KPiA+ID4NCj4gPiA+IE9uIEZy
aSwgQXVnIDIzLCAyMDI0IGF0IDQ6MznigK9QTSBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBn
b29nbGUuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gV2VkLCBBdWcgMjEsIDIw
MjQgYXQgMjo0N+KAr1BNIEJhcnJ5IFNvbmcgPDIxY25iYW9AZ21haWwuY29tPg0KPiB3cm90ZToN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFdlZCwgQXVnIDIxLCAyMDI0IGF0IDg6NDbigK9QTSBN
aWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gT24gRnJpIDE2LTA4LTI0IDA3OjQ4OjAxLCBnYW94dSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gUmVwbGFjZSBscnV2ZWNfYWRkX2ZvbGlvIHdpdGggbHJ1dmVjX2FkZF9mb2xpb190YWls
IGluIHRoZQ0KPiBscnVfbGF6eWZyZWVfZm46DQo+ID4gPiA+ID4gPiA+IDEuIFRoZSBsYXp5LWZy
ZWUgZm9saW8gaXMgYWRkZWQgdG8gdGhlIExSVV9JTkFDVElWRV9GSUxFIGxpc3QuIElmIGl0J3MN
Cj4gPiA+ID4gPiA+ID4gICAgbW92ZWQgdG8gdGhlIExSVSB0YWlsLCBpdCBhbGxvd3MgZm9yIGZh
c3RlciByZWxlYXNlIGxhenktZnJlZSBmb2xpbw0KPiBhbmQNCj4gPiA+ID4gPiA+ID4gICAgcmVk
dWNlcyB0aGUgaW1wYWN0IG9uIGZpbGUgcmVmYXVsdC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiBUaGlzIGhhcyBiZWVuIGRpc2N1c3NlZCB3aGVuIE1BRFZfRlJFRSB3YXMgaW50cm9kdWNlZC4g
VGhlDQo+IHF1ZXN0aW9uIHdhcw0KPiA+ID4gPiA+ID4gd2hldGhlciB0aGlzIG1lbW9yeSBoYXMg
YSBsb3dlciBwcmlvcml0eSB0aGFuIG90aGVyIGluYWN0aXZlIG1lbW9yeQ0KPiB0aGF0DQo+ID4g
PiA+ID4gPiBoYXMgYmVlbiBtYXJrZWQgdGhhdCB3YXkgbG9uZ2VyIGFnby4gQWxzbyBjb25zaWRl
ciBzZXZlcmFsDQo+IE1BRFZfRlJFRQ0KPiA+ID4gPiA+ID4gdXNlcnMgc2hvdWxkIHRoZXkgYmUg
TElGTyBmcm9tIHRoZSByZWNsYWltIFBPVj8NCj4gPiA+DQo+ID4gPiBUaGlua2luZyBmcm9tIHRo
ZSB1c2VyJ3MgcGVyc3BlY3RpdmUsIGl0IHNlZW1zIHRvIG1lIHRoYXQgRklGTyB3aXRoaW4NCj4g
PiA+IE1BRFZfRlJFRSdlZCBwYWdlcyBtYWtlcyBtb3JlIHNlbnNlLiBBcyBhIHVzZXIgSSBleHBl
Y3QgdGhlIGxvbmdlciBhDQo+ID4gPiBNQURWX0ZSRUUnZWQgcGFnZSBoYXNuJ3QgYmVlbiB0b3Vj
aGVkLCB0aGUgY2hhbmNlcyBhcmUgaGlnaGVyIHRoYXQgaXQNCj4gPiA+IG1heSBub3QgYmUgYXJv
dW5kIGFueW1vcmUuDQo+ID4gPiA+ID4NCj4gPg0KPiA+IEhpIExva2VzaCwNCj4gPiBUaGFua3Mh
DQo+ID4NCj4gPiA+ID4gPiBUaGUgcHJpb3JpdHkgb2YgdGhpcyBtZW1vcnkgY29tcGFyZWQgdG8g
b3RoZXIgaW5hY3RpdmUgbWVtb3J5IHRoYXQgaGFzDQo+IGJlZW4NCj4gPiA+ID4gPiBtYXJrZWQg
Zm9yIGEgbG9uZ2VyIHRpbWUgbGlrZWx5IGRlcGVuZHMgb24gdGhlIHVzZXIncyBleHBlY3RhdGlv
bnMgLSBIb3cNCj4gc29vbg0KPiA+ID4gPiA+IGRvIHVzZXJzIGV4cGVjdCBNQURWX0ZSRUUgdG8g
YmUgcmVjbGFpbWVkIGNvbXBhcmVkIHdpdGggb2xkIGZpbGUNCj4gZm9saW9zLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gYXJ0IGd1eXMgbW92ZWQgdG8gTUFEVl9GUkVFIGZyb20gTUFEVl9ET05UTkVF
RCB3aXRob3V0IGFueQ0KPiA+ID4gPiA+IHVzZWZ1bCBwZXJmb3JtYW5jZSBkYXRhIGFuZCByZWFz
b24gaW4gdGhlIGNoYW5nZWxvZzoNCj4gPiA+ID4gPiBodHRwczovL2FuZHJvaWQtcmV2aWV3Lmdv
b2dsZXNvdXJjZS5jb20vYy9wbGF0Zm9ybS9hcnQvKy8yNjMzMTMyDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBTaW5jZSBhcnQgaXMgdGhlIEFuZHJvaWQgSmF2YSBoZWFwLCBpdCBjYW4gYmUgcXVpdGUg
bGFyZ2UuIFRoaXMgaW5jcmVhc2VzIHRoZQ0KPiA+ID4gPiA+IGxpa2VsaWhvb2Qgb2YgcGFja2lu
ZyB0aGUgZmlsZSBMUlUgYW5kIHJlZHVjZXMgdGhlIGNoYW5jZXMgb2YgcmVjbGFpbWluZw0KPiA+
ID4gPiA+IGFub255bW91cyBtZW1vcnksIHdoaWNoIGNvdWxkIHJlc3VsdCBpbiBtb3JlIGZpbGUg
cmUtZmF1bHRzIHdoaWxlDQo+IGhlbHBpbmcNCj4gPiA+ID4gPiBhbm9ueW1vdXMgZm9saW8gcGVy
c2lzdCBsb25nZXIgaW4gbWVtb3J5Lg0KPiA+ID4NCj4gPiA+IEluZGl2aWR1YWwgaGVhcHMgb2Yg
YW5kcm9pZCBhcHBzIGFyZSBub3QgYmlnLCBhbmQgZXZlbiBpbiB0aGVyZSB3ZQ0KPiA+ID4gZG9u
J3QgY2FsbCBNQURWX0ZSRUUgb24gdGhlIGVudGlyZSBoZWFwLg0KPiA+DQo+ID4gSG93IGRvIHlv
dSBkZWZpbmUgIkluZGl2aWR1YWwgaGVhcHMgb2YgYW5kcm9pZCBhcHBzIiwgZG8geW91IGtub3cg
dGhlIHVzdWFsDQo+ID4gdG90YWxfc2l6ZSBmb3IgYSBwaG9uZSB3aXRoIG1lbW9yeSBwcmVzc3Vy
ZSBieSBydW5uaW5nIG11bHRpcGxlIGFwcHMgYW5kDQo+IGhvdw0KPiA+IG11Y2ggZm9yIGVhY2gg
YXBwPw0KPiA+DQo+IEV2ZXJ5IGFwcCBpcyBhIHNlcGFyYXRlIHByb2Nlc3MgYW5kIHRoZXJlZm9y
ZSBoYXMgaXRzIG93biBwcml2YXRlIEFSVA0KPiBoZWFwLiBUaG9zZSBudW1iZXJzIHRoYXQgeW91
IGFyZSBhc2tpbmcgdmFyeSBkcmFzdGljYWxseS4gQnV0IGhlcmUncw0KPiB3aGF0IEkgY2FuIHRl
bGwgeW91Og0KPiANCj4gTWF4IGhlYXAgc2l6ZSBmb3IgYW4gYXBwIGlzIDUxMk1CIHR5cGljYWxs
eS4gQnV0IGl0IGlzIHJhcmVseSBlbnRpcmVseQ0KPiB1c2VkLiBUeXBpY2FsIGhlYXAgdXNhZ2Ug
aXMgNTBNQiB0byAyNTBNQi4gQnV0IGFzIEkgc2FpZCwgbm90IGFsbCBvZg0KPiBpdCBpcyBNQURW
X0ZSRUUnZWQuIE9ubHkgdGhvc2UgcGFnZXMgd2hpY2ggYXJlIGZyZWVkIGFmdGVyIEdDDQo+IGNv
bXBhY3Rpb24gYXJlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBhbSByZWFsbHkgY3VyaW91cyB3
aHkgYXJ0IGd1eXMgaGF2ZSBtb3ZlZCB0byBNQURWX0ZSRUUgaWYgd2UgaGF2ZQ0KPiA+ID4gPiA+
IGFuIGFwcHJvYWNoIHRvIHJlYWNoIHRoZW0uDQo+ID4gPg0KPiA+ID4gSG9uZXN0bHksIGl0IG1h
a2VzIGxpdHRsZSBzZW5zZSBhcyBhIHVzZXIgdGhhdCBjYWxsaW5nIE1BRFZfRlJFRSBvbiBhbg0K
PiA+ID4gYW5vbnltb3VzIG1hcHBpbmcgd2lsbCBpbXBhY3QgZmlsZSBMUlUuIFRoYXQgd2FzIG5l
dmVyIHRoZSBpbnRlbnRpb24NCj4gPiA+IHdpdGggb3VyIEFSVCBjaGFuZ2UuDQo+ID4gPg0KPiA+
DQo+ID4gVGhpcyBpcyBqdXN0IGhvdyBNQURWX0ZSRUUgaXMgaW1wbGVtZW50ZWQgaW4gdGhlIGtl
cm5lbCwgdGhpcyBraW5kIG9mIGxhenlmcmVlDQo+ID4gYW5vbiBmb2xpb3MgYXJlIG1vdmVkIHRv
IGZpbGUgYnV0ICpOT1QqIGFub24gTFJVLg0KPiA+DQo+ID4gPiBGcm9tIG91ciBwZXJzcGVjdGl2
ZSwgb25jZSBhIHNldCBvZiBwYWdlcyBhcmUgTUFEVl9GUkVFJ2VkLCB0aGV5IGFyZQ0KPiA+ID4g
bGlrZSBhIHBhZ2UtY2FjaGUuIEl0IGdpdmVzIGFuIG9wcG9ydHVuaXR5LCB3aXRob3V0IGh1cnRp
bmcgbWVtb3J5DQo+ID4gPiB1c2UsIHRvIGF2b2lkIG92ZXJoZWFkIG9mIHBhZ2UtZmF1bHRzLCB3
aGljaCBoYXBwZW4gZnJlcXVlbnRseSBhZnRlcg0KPiA+ID4gR0MgaXMgZG9uZSBvbiBydW5uaW5n
IGFwcHMuDQo+ID4gPg0KPiA+ID4gSU1ITywgd2l0aGluIExSVV9JTkFDVElWRV9GSUxFLCBNQURW
X0ZSRUUnZWQgcGFnZXMgc2hvdWxkIGJlDQo+ID4gPiBwcmlvcml0aXplZCBmb3IgcmVjbGFtYXRp
b24gb3ZlciBmaWxlIG9uZXMuDQo+ID4NCj4gPiBUaGlzIGlzIGV4YWN0bHkgd2hhdCB0aGlzIHBh
dGNoIGlzIGRvaW5nLCBwdXR0aW5nIGxhenlmcmVlIGFub24gZm9saW9zDQo+ID4gdG8gdGhlIHRh
aWwgb2YgZmlsZSBMUlUgc28gdGhhdCB0aGV5IGNhbiBiZSByZWNsYWltZWQgZWFybGllciB0aGFu
IGZpbGUNCj4gPiBmb2xpb3MuIEJ1dCB0aGUgcXVlc3Rpb24gaXM6IGlzIHRoZSByZXF1aXJlbWVu
dCAiTUFEVl9GUkVFJ2VkIHBhZ2VzDQo+ID4gc2hvdWxkIGJlIHByaW9yaXRpemVkIGZvciByZWNs
YW1hdGlvbiBvdmVyIGZpbGUgb25lcyIgdW5pdmVyc2FsbHkgdHJ1ZSBmb3INCj4gPiBhbGwgb3Ro
ZXIgbm9uLUFuZHJvaWQgdXNlcnM/DQo+ID4NCj4gVGhhdCdzIGRlZmluaXRlbHkgYW4gaW1wb3J0
YW50IHF1ZXN0aW9uIHRvIGdldCBhbnN3ZXJlZC4gQnV0IHB1dHRpbmcNCj4gbXkgdXNlcnMgaGF0
IG9uIGFnYWluLCBieSBleHBsaWNpdGx5IE1BRFZfRlJFRSdpbmcgd2UgYXNrIGZvciB0aGF0DQo+
IGJlaGF2aW9yLiBJTUhPLCBNQURWX0ZSRUUnZWQgcGFnZXMgc2hvdWxkIGJlIHRoZSBmaXJzdCBv
bmVzIHRvIGJlDQo+IHJlY2xhaW1lZCBvbiBtZW1vcnkgcHJlc3N1cmUuDQpGb3Igbm9uLUFuZHJv
aWQgc3lzdGVtcywgcGVyaGFwcyB0aGUgYXV0aG9yIG9mIE1BRFZfRlJFRSBjYW4gcHJvdmlkZSBh
IG1vcmUNCnJlYXNvbmFibGUgb3BpbmlvbjsNCiANCkFkZCBNaW5jaGFuIEtpbS4NClBsZWFzZSBm
b3JnaXZlIG1lIGZvciBmb3JnZXR0aW5nIHRvIGFkZCB5b3Ugd2hlbiBzZW5kaW5nIHRoZSBwYXRj
aC4NCj4gPiA+ID4NCj4gPiA+ID4gQWRkaW5nIExva2VzaC4NCj4gPiA+ID4gTG9rZXNoLCBjb3Vs
ZCB5b3UgcGxlYXNlIGNvbW1lbnQgb24gdGhlIHJlYXNvbmluZyBiZWhpbmQgdGhlIGFib3ZlDQo+
ID4gPiA+IG1lbnRpb25lZCBjaGFuZ2U/DQo+ID4gPg0KPiA+ID4gQWRkaW5nIE5pY29sYXMgYXMg
d2VsbCwgaW4gY2FzZSBoZSB3YW50cyB0byBhZGQgc29tZXRoaW5nLg0KPiA+ID4gPg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+IE1pY2hhbCBIb2Nr
bw0KPiA+ID4gPiA+ID4gU1VTRSBMYWJzDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4NCj4g
PiBUaGFua3MNCj4gPiBCYXJyeQ0K

