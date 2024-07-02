Return-Path: <linux-kernel+bounces-237246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D691EDDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E731C2137D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489414F1F8;
	Tue,  2 Jul 2024 04:26:02 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497E4CDF9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894361; cv=none; b=m8P3sh9Weg2YRrExi7JP6mtzrwt5YLW6cZaedIrPI+s2KFwBvNCmQ/8r39tUvSsiOhcEu+HVvhCJj6J9oVNKz2ECmnWezzz7hlL9HUVf1PBK99sXDS92miLyUqWne7R6I5ZCrlIzigCG4GawfJZTPVqrkVgMmcDwCZZHlHZUOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894361; c=relaxed/simple;
	bh=SuJc4OEyExGwACZMDCD/xYprfwvsJvTpP68zsYMaySc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JjEOEBX/GTENj9rudsssfGqCFYYfHO8RHvIaLUCskuZURSSwilV7lktNbxXg+7VKiglD1ILcewkJuTdKfB64bwfcRCL24oKI+qy0mlTwxQ7PP7FOKJGmWHLjjNcAmxXPkQIgMBVefXEPMhSb4NeHkn8SeXWtlDZpWJlwBBS0nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4624PGLn037323;
	Tue, 2 Jul 2024 12:25:16 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX12-BJD.srv.huawei-3com.com (unknown [10.153.34.14])
	by mail.maildlp.com (Postfix) with ESMTP id 472E02004BAA;
	Tue,  2 Jul 2024 12:29:20 +0800 (CST)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) by
 DAG6EX12-BJD.srv.huawei-3com.com (10.153.34.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 2 Jul 2024 12:25:17 +0800
Received: from DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5])
 by DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5%4]) with mapi
 id 15.02.1258.027; Tue, 2 Jul 2024 12:25:17 +0800
From: Zhangchun <zhang.chunA@h3c.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaoxupo
	<jiaoxupo@h3c.com>, Bailin <berlin@h3c.com>,
        Zhangzhansheng
	<zhang.zhansheng@h3c.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, wangyu
	<wang.yuI@h3c.com>,
        "shaohaojize@126.com" <shaohaojize@126.com>
Subject: =?utf-8?B?562U5aSNOiAgW1BBVENIXSBtbTogZml4IGttYXBfaGlnaCBkZWFkbG9jayBW?=
 =?utf-8?Q?2?=
Thread-Topic: [PATCH] mm: fix kmap_high deadlock V2
Thread-Index: AdrMNwI2VvTxTh3MSgCT1mPrIo0cfg==
Date: Tue, 2 Jul 2024 04:25:17 +0000
Message-ID: <7e855a8ff82743979be9bb15363f98dc@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4624PGLn037323

RnJvbTogInpoYW5nLmNodW4iIDx6aGFuZy5jaHVuYUBoM2MuY29tPg0KDQpJIHdvcmsgd2l0aCB6
aGFuZ3poYW5zaGVuZyhmcm9tIGgzYykgZmluZCB0aGF0IHNvbWUgc2l0dWF0aW9uDQptYXkgY2Fz
dWUgZGVhZGxvY2sgd2hlbiB3ZSB1c2Uga21hcF9oaWdoIGFuZCBrbWFwX1hYWCBvciBrdW1hcF94
eHgNCmJldHdlZW4gIGRpZmZlcnQgY29yZXMgYXQgdGhlIHNhbWUgdGltZSwgIGttYXBfaGlnaC0+
bWFwX25ld192aXJ0dWFsLT4NCmZsdXNoX2FsbF96ZXJvX3BrbWFwcy0+Zmx1c2hfdGxiX2tlcm5l
bF9yYW5nZS0+b25fZWFjaF9jcHUuIE9uIHRoaXMNCmNvbmRpdGlvbiwga21hcF9oaWdoIGhvbGQg
dGhlIGttYXBfbG9ja++8jHdhaXQgdGhlIG90aGVyIGNvcmVzIHJlc3BvbmQNCnRvIGlwaS4gQnV0
IHRoZSBvdGhlcnMgbWF5IGRpc2FibGUgaXJxIGFuZCB3YWl0IGttYXBfbG9jaywNCnRoaXMgaXMg
c29tZSBkZWFkbG9jayBjb25kaXRpb24uIEkgdGhpbmsgaXQncyBuZWNlc3NhcnkgdG8gZ2l2ZQ0K
a21hcF9sb2NrIGJlZm9yZSBjYWxsIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UuDQpMaWtlIHRoaXM6
DQpzcGluX3VubG9jaygma21hcF9sb2NrKTsNCmZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoeHh4KTsN
CnNwaW5fbG9jaygma21hcF9sb2NrKTsNCg0KQ1BVIDA6ICAgICAgICAgICAgICAgIGNwdSAxOg0K
ICAgICAgICAgICAgICAgICAgICAgICAga21hcF94eHgoKSB7DQp4eHggICAgICAgICAgICAgICAg
ICAgICBpcnFfZGlzYWJsZSgpOw0Ka21hcF9oaWdoKCk7ICAgICAgICAgICAgc3Bpbl9sb2NrKCZr
bWFwX2xvY2spDQp4eHggICAgICAgICAgICAgICAgICAgICB5eXl5eXl5DQogICAgICAgICAgICAg
ICAgICAgICAgICBzcGluX3VubG9jaygma21hcF9sb2NrKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgaXJxX2VuYWJsZSgpOw0KICAgICAgICAgICAgICAgICAgICAgICAgfQ0Ka21hcF9oaWdoIGRl
dGFpbDoNCmttYXBfaGlnaCgpIHsNCiAgICAgICAgenp6DQogICAgICAgIHNwaW5fbG9jaygma21h
cF9sb2NrKQ0KICAgICAgICBtYXBfbmV3X3ZpcnR1YWwtPg0KICAgICAgICAgICAgICAgIGZsdXNo
X2FsbF96ZXJvX3BrbWFwcy0+DQogICAgICAgICAgICAgICAgICAgICAgICBmbHVzaF90bGJfa2Vy
bmVsX3JhbmdlLT4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb25fZWFjaF9jcHUN
CiAgICAgICAgLyoNCiAgICAgICAgaWYgY3B1IDEgaXJxX2Rpc2FibGVkLCB0aGUgY3B1IDENCiAg
ICAgICAgY2Fubm90IGFjaywgdGhlbiBjcHUgMCBhbmQgY3B1IDEgbWF5IGhhbmd1cC4NCiAgICAg
ICAgKi8NCiAgICAgICAgc3Bpbl91bmxvY2soJmttYXBfbG9jaykNCiAgICAgICAgenp6DQp9DQpT
aWduZWQtb2ZmLWJ5OiB6aGFuZ2NodW4gPHpoYW5nLmNodW5hQGgzYy5jb20+DQoNClJldmlld2Vk
LWJ5OiB6aGFuZ3poZW5nbWluZyA8emhhbmcuemhlbmdtaW5nQGgzYy5jb20+DQotLS0NCiBtbS9o
aWdobWVtLmMgfCA1ICsrKystDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vaGlnaG1lbS5jIGIvbW0vaGlnaG1lbS5jDQpp
bmRleCBiZDQ4YmE0Li44NDFiMzcwIDEwMDY0NA0KLS0tIGEvbW0vaGlnaG1lbS5jDQorKysgYi9t
bS9oaWdobWVtLmMNCkBAIC0yMjAsOCArMjIwLDExIEBAIHN0YXRpYyB2b2lkIGZsdXNoX2FsbF96
ZXJvX3BrbWFwcyh2b2lkKQ0KICAgICAgICAgICAgICAgIHNldF9wYWdlX2FkZHJlc3MocGFnZSwg
TlVMTCk7DQogICAgICAgICAgICAgICAgbmVlZF9mbHVzaCA9IDE7DQogICAgICAgIH0NCi0gICAg
ICAgaWYgKG5lZWRfZmx1c2gpDQorICAgICAgIGlmIChuZWVkX2ZsdXNoKSB7DQorICAgICAgICAg
ICAgICAgc3Bpbl91bmxvY2soJmttYXBfbG9jayk7DQogICAgICAgICAgICAgICAgZmx1c2hfdGxi
X2tlcm5lbF9yYW5nZShQS01BUF9BRERSKDApLCBQS01BUF9BRERSKExBU1RfUEtNQVApKTsNCisg
ICAgICAgICAgICAgICBzcGluX2xvY2soJmttYXBfbG9jayk7DQorICAgICAgIH0NCiB9DQoNCiB2
b2lkIF9fa21hcF9mbHVzaF91bnVzZWQodm9pZCkNCi0tDQoyLjM0LjENCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5paw5Y2O5LiJ6ZuG5Zui55qE5L+d
5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye6DQrnmoTk
uKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/n
lKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbj
gIENCuaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6
huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5
tuWIoOmZpOacrA0K6YKu5Lu277yBDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNv
bnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTmV3IEgzQywgd2hpY2ggaXMNCmlu
dGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlz
dGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZQ0KaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBp
biBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlh
bA0KZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25z
IG90aGVyIHRoYW4gdGhlIGludGVuZGVkDQpyZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYg
eW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRl
cg0KYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCENCg==

