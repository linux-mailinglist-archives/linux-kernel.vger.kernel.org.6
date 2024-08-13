Return-Path: <linux-kernel+bounces-284516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF009501D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27561C21F05
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468118B483;
	Tue, 13 Aug 2024 09:59:07 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3018733C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543146; cv=none; b=IR1D3vBhYRa/cbepCkUBqU8GopPyBG+++b9opeCj5/V5Yx9CBVyPrtsf7bQkdR5/Spi4isuzs/pzJtI8aQbo0nr/UMwxP4VNcwDoBa0yFXBjEbxjh2ezoQ2156W/fuLkf87ctVQ4Sc0pWEUVwhbVpL4OsBzInRP2vW810pSkxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543146; c=relaxed/simple;
	bh=XjZh52CNAR7VND5L0v/P0wMbM9KK9vG5G3XVeDPjcRk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CkSghU+RrI2NlbQ1Ecl+QA+3msGGvPtUDcpN/TTYkPL+MxWJBbOsgNlBG+HGAKQWo3++I6R3zfjl1wLv2QeI8/hwmjKupdRZv7RQdWY8FxujP02PmBwcvt4zij0rMmoyIFH80Lzd5Vw08wB5RQjdp/4nNF+ddnzB1RkZXAWACNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47D9wZIT099590;
	Tue, 13 Aug 2024 17:58:35 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Wjmrd12TDz2NDCCd;
	Tue, 13 Aug 2024 17:52:17 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 13 Aug
 2024 17:58:33 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Tue, 13 Aug 2024 17:58:33 +0800
From: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?=
	<zhaoyang.huang@unisoc.com>
To: Breno Leitao <leitao@debian.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim
	<minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?=
	<Ke.Wang@unisoc.com>,
        "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>,
        "nphamcs@gmail.com" <nphamcs@gmail.com>
Subject: reply: [PATCHv5] mm: skip CMA pages when they are not available
Thread-Topic: reply: [PATCHv5] mm: skip CMA pages when they are not available
Thread-Index: AdrtZ0VOCTv00WFPTjiUbqEdSEhXJg==
Date: Tue, 13 Aug 2024 09:58:32 +0000
Message-ID: <a74760bd1d81467db2a03b77d3aef7d3@BJMBX01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 47D9wZIT099590

Pg0KPk9uIFdlZCwgTWF5IDMxLCAyMDIzIGF0IDEwOjUxOjAxQU0gKzA4MDAsIHpoYW95YW5nLmh1
YW5nIHdyb3RlOg0KPj4gRnJvbTogWmhhb3lhbmcgSHVhbmcgPHpoYW95YW5nLmh1YW5nQHVuaXNv
Yy5jb20+DQo+Pg0KPj4gVGhpcyBwYXRjaCBmaXhlcyB1bnByb2R1Y3RpdmUgcmVjbGFpbWluZyBv
ZiBDTUEgcGFnZXMgYnkgc2tpcHBpbmcgdGhlbQ0KPj4gd2hlbiB0aGV5IGFyZSBub3QgYXZhaWxh
YmxlIGZvciBjdXJyZW50IGNvbnRleHQuIEl0IGlzIGFyaXNlIGZyb20NCj4+IGJlbGxvd2luZyBP
T00gaXNzdWUsIHdoaWNoIGNhdXNlZCBieSBsYXJnZSBwcm9wb3J0aW9uIG9mIE1JR1JBVEVfQ01B
DQo+cGFnZXMgYW1vbmcgZnJlZSBwYWdlcy4NCj4NCj5IZWxsbywNCj4NCj5JJ3ZlIGJlZW4gbG9v
a2luZyBpbnRvIGEgcHJvYmxlbSB3aXRoIGhpZ2ggbWVtb3J5IHByZXNzdXJlIGNhdXNpbmcgT09N
cyBpbg0KPnNvbWUgb2Ygb3VyIHdvcmtsb2FkcywgYW5kIGl0IHNlZW1zIHRoYXQgdGhpcyBjaGFu
Z2UgbWF5IGhhdmUgaW50cm9kdWNlZCBsb2NrDQo+Y29udGVudGlvbiB3aGVuIHRoZXJlIGlzIGhp
Z2ggbWVtb3J5IHByZXNzdXJlLg0KPg0KPkkndmUgY29sbGVjdGVkIHNvbWUgbWV0cmljcyBmb3Ig
bXkgc3BlY2lmaWMgd29ya2xvYWQgdGhhdCBzdWdnZXN0IHRoaXMgY2hhbmdlDQo+aGFzIGluY3Jl
YXNlZCB0aGUgbHJ1dmVjLT5scnVfbG9jayB3YWl0dGltZS1tYXggYnkgNTAweCBhbmQgdGhlDQo+
d2FpdHRpbWUtYXZnIGJ5IDIweC4NCj4NCj5FeHBlcmltZW50DQo+PT09PT09PT09PQ0KPg0KPlRo
ZSBleHBlcmltZW50IGludm9sdmVkIDEwMCBob3N0cywgZWFjaCB3aXRoIDY0R0Igb2YgbWVtb3J5
IGFuZCBhIHNpbmdsZQ0KPlhlb24gODMyMUhDIENQVS4gVGhlIGV4cGVyaW1lbnQgcmFuIGZvciBv
dmVyIDgwIGhvdXJzLg0KPg0KPkhhbGYgb2YgdGhlIGhvc3RzICg1MCkgd2VyZSBjb25maWd1cmVk
IHdpdGggdGhlIHBhdGNoIHJldmVydGVkIGFuZCBsb2NrIHN0YXQNCj5lbmFibGVkLCB3aGlsZSB0
aGUgb3RoZXIgaGFsZiB3YXMgcnVuIGFnYWluc3QgdGhlIHVwc3RyZWFtIHZlcnNpb24uDQo+QWxs
IG1hY2hpbmVzIGhhZCBodWdldGxiX2NtYT02RyBzZXQgYXMgYSBjb21tYW5kLWxpbmUgYXJndW1l
bnQuDQo+DQo+SW4gdGhpcyBjb250ZXh0LCAidXBzdHJlYW0iIHJlZmVycyB0byBrZXJuZWwgcmVs
ZWFzZSA2Ljkgd2l0aCBzb21lIG1pbm9yDQo+Y2hhbmdlcyB0aGF0IHNob3VsZCBub3QgaW1wYWN0
IHRoZSByZXN1bHRzLg0KPg0KPldvcmtsb2FkDQo+PT09PT09PT0NCj4NCj5UaGUgd29ya2xvYWQg
aXMgYSBKYXZhIGJhc2VkIGFwcGxpY2F0aW9uIHRoYXQgZnVsbHkgdXRpbGl6ZWQgdGhlIG1lbW9y
eSwgaW4gZmFjdCwNCj50aGUgSlZNIHJ1bnMgd2l0aCBgLVhtczUwNzM1bSAtWG14NTA3MzVtYCBh
cmd1bWVudHMuDQo+DQo+UmVzdWx0czoNCj49PT09PT09DQo+DQo+QSBmZXcgdmFsdWVzIGZyb20g
bG9ja3N0YXQ6DQo+DQo+ICAgICAgICAgICAgICAgICAgd2FpdHRpbWUtbWF4ICAgd2FpdHRpbWUt
dG90YWwgIHdhaXR0aW1lLWF2Zw0KPmhvbGR0aW1lLW1heA0KPjYuOTogICAgICAgICAgICAgICAg
ICAgIDI0Mjg4OSAgICAgIDE1NjE4ODczOTMzICAgICAgICAgICA3MTUNCj4xNzQ4NQ0KPjYuOS13
aXRoLXJldmVydDogICAgICAgICAgIDQ4NyAgICAgICAgNjg4NTYzMjk5ICAgICAgICAgICAgMzQN
Cj40NjQNCj4NCj5UaGUgZnVsbCBkYXRhIGNvdWxkIGJlIHNlZW4gYXQ6DQo+aHR0cHM6Ly9kb2Nz
Lmdvb2dsZS5jb20vc3ByZWFkc2hlZXRzL2QvMURsLThJbWxFNE9acmZLamJ5V0FJV1d1UXRnRDNm
DQo+d0VFbDlJTmFaUVo0ZTgvZWRpdD91c3A9c2hhcmluZw0KPg0KPlBvc3NpYmxlIGNhdXNlczoN
Cj49PT09PT09PT09PT09PT09DQo+DQo+SSd2ZSBiZWVuIGRpc2N1c3NpbmcgdGhpcyB3aXRoIGNv
bGxlYWd1ZXMgYW5kIHdlJ3JlIHNwZWN1bGF0aW5nIHRoYXQgdGhlIGhpZ2gNCj5jb250ZW50aW9u
IG1pZ2h0IGJlIGxpbmtlZCB0byB0aGUgZmFjdCB0aGF0IENNQSByZWdpb25zIGFyZSBub3cgYmVp
bmcgc2tpcHBlZC4NCj5UaGlzIGNvdWxkIHBvdGVudGlhbGx5IGV4dGVuZCB0aGUgZHVyYXRpb24g
b2YgdGhlDQo+aXNvbGF0ZV9scnVfZm9saW9zKCkgJ3doaWxlJyBsb29wLCByZXN1bHRpbmcgaW4g
aW5jcmVhc2VkIHByZXNzdXJlIG9uIHRoZSBsb2NrLg0KPg0KPkhvd2V2ZXIsIEkgd2FudCB0byBl
bXBoYXNpemUgdGhhdCBJJ20gbm90IGFuIGV4cGVydCBpbiB0aGlzIGFyZWEgYW5kIEkgYW0NCj5z
aW1wbHkgc2hhcmluZyB0aGUgZGF0YSBJIGNvbGxlY3RlZC4NCkNvdWxkIHlvdSBwbGVhc2UgdHJ5
IGJlbG93IHBhdGNoIHdoaWNoIGNvdWxkIGJlIGhlbHBmdWwNCg0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbW0vQ0FPVUh1ZmE3T0J0TkhLTWhmdTh3T09FNGYwdzNiMF8yS3p6VjctaHJj
OXJWTDhlPWl3QG1haWwuZ21haWwuY29tLw0KDQo=

