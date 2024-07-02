Return-Path: <linux-kernel+bounces-237249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D1E91EDE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBCC285E16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE9364A0;
	Tue,  2 Jul 2024 04:27:29 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B46372
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894449; cv=none; b=AF3uKESgZxQsMeQ5kJ2CebP6MbBG9PXav30rSD+aKhOuLk8mFFFVCPH02x1vGlRoR450Cjlm2F11dba9xiMF16+AxbcxR21NIR6ZyZwX/IpTh05liIWppgN4NdnwSrU5GwPd+xQ2buTTGCm1tBfcgDn+GlRm7QH9jREw1cDtNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894449; c=relaxed/simple;
	bh=r66APsfbuZwhaGtdICg8m8ISseHQCJgnvESBj7Fq7W0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IvaoTP9KARM1x5oJNFtjExnE5m12M5hrc18zTDVn7Qz4FZ23ltRstyFnNeX9eWSBxfqf5L4cFoeNk9K+coLIx86MtC9uO8XZlO7NUN9GF5rEXAb6WRngzXtUf++1CEOe0ghkQp1mUHRMJLALNCod0bOIVbkKhM+4N8hFrARriDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4624QwPG039760;
	Tue, 2 Jul 2024 12:26:58 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX11-BJD.srv.huawei-3com.com (unknown [10.153.34.13])
	by mail.maildlp.com (Postfix) with ESMTP id 630F62004BA2;
	Tue,  2 Jul 2024 12:31:02 +0800 (CST)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) by
 DAG6EX11-BJD.srv.huawei-3com.com (10.153.34.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 2 Jul 2024 12:26:59 +0800
Received: from DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5])
 by DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5%4]) with mapi
 id 15.02.1258.027; Tue, 2 Jul 2024 12:26:59 +0800
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
        "shaohaojize@126.com" <shaohaojize@126.com>,
        Zhangzhengming <zhang.zhengming@h3c.com>
Subject: [PATCH] mm: fix kmap_high deadlock V2
Thread-Topic: [PATCH] mm: fix kmap_high deadlock V2
Thread-Index: AdrMNwI2VvTxTh3MSgCT1mPrIo0cfgAAO7Gg
Date: Tue, 2 Jul 2024 04:26:59 +0000
Message-ID: <7caa255fa5fe4e8e9c6a05084a1faf72@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 4624QwPG039760

DQpGcm9tOiAiemhhbmcuY2h1biIgPHpoYW5nLmNodW5hQGgzYy5jb20+DQoNCkkgd29yayB3aXRo
IHpoYW5nemhhbnNoZW5nKGZyb20gaDNjKSBmaW5kIHRoYXQgc29tZSBzaXR1YXRpb24gbWF5IGNh
c3VlIGRlYWRsb2NrIHdoZW4gd2UgdXNlIGttYXBfaGlnaCBhbmQga21hcF9YWFggb3Iga3VtYXBf
eHh4IGJldHdlZW4gIGRpZmZlcnQgY29yZXMgYXQgdGhlIHNhbWUgdGltZSwgIGttYXBfaGlnaC0+
bWFwX25ld192aXJ0dWFsLT4gZmx1c2hfYWxsX3plcm9fcGttYXBzLT5mbHVzaF90bGJfa2VybmVs
X3JhbmdlLT5vbl9lYWNoX2NwdS4gT24gdGhpcyBjb25kaXRpb24sIGttYXBfaGlnaCBob2xkIHRo
ZSBrbWFwX2xvY2vvvIx3YWl0IHRoZSBvdGhlciBjb3JlcyByZXNwb25kIHRvIGlwaS4gQnV0IHRo
ZSBvdGhlcnMgbWF5IGRpc2FibGUgaXJxIGFuZCB3YWl0IGttYXBfbG9jaywgdGhpcyBpcyBzb21l
IGRlYWRsb2NrIGNvbmRpdGlvbi4gSSB0aGluayBpdCdzIG5lY2Vzc2FyeSB0byBnaXZlIGttYXBf
bG9jayBiZWZvcmUgY2FsbCBmbHVzaF90bGJfa2VybmVsX3JhbmdlLg0KTGlrZSB0aGlzOg0Kc3Bp
bl91bmxvY2soJmttYXBfbG9jayk7DQpmbHVzaF90bGJfa2VybmVsX3JhbmdlKHh4eCk7DQpzcGlu
X2xvY2soJmttYXBfbG9jayk7DQoNCkNQVSAwOiAgICAgICAgICAgICAgICBjcHUgMToNCiAgICAg
ICAgICAgICAgICAgICAgICAgIGttYXBfeHh4KCkgew0KeHh4ICAgICAgICAgICAgICAgICAgICAg
aXJxX2Rpc2FibGUoKTsNCmttYXBfaGlnaCgpOyAgICAgICAgICAgIHNwaW5fbG9jaygma21hcF9s
b2NrKQ0KeHh4ICAgICAgICAgICAgICAgICAgICAgeXl5eXl5eQ0KICAgICAgICAgICAgICAgICAg
ICAgICAgc3Bpbl91bmxvY2soJmttYXBfbG9jaykNCiAgICAgICAgICAgICAgICAgICAgICAgIGly
cV9lbmFibGUoKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIH0NCmttYXBfaGlnaCBkZXRhaWw6
DQprbWFwX2hpZ2goKSB7DQogICAgICAgIHp6eg0KICAgICAgICBzcGluX2xvY2soJmttYXBfbG9j
aykNCiAgICAgICAgbWFwX25ld192aXJ0dWFsLT4NCiAgICAgICAgICAgICAgICBmbHVzaF9hbGxf
emVyb19wa21hcHMtPg0KICAgICAgICAgICAgICAgICAgICAgICAgZmx1c2hfdGxiX2tlcm5lbF9y
YW5nZS0+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9uX2VhY2hfY3B1DQogICAg
ICAgIC8qDQogICAgICAgIGlmIGNwdSAxIGlycV9kaXNhYmxlZCwgdGhlIGNwdSAxDQogICAgICAg
IGNhbm5vdCBhY2ssIHRoZW4gY3B1IDAgYW5kIGNwdSAxIG1heSBoYW5ndXAuDQogICAgICAgICov
DQogICAgICAgIHNwaW5fdW5sb2NrKCZrbWFwX2xvY2spDQogICAgICAgIHp6eg0KfQ0KU2lnbmVk
LW9mZi1ieTogemhhbmdjaHVuIDx6aGFuZy5jaHVuYUBoM2MuY29tPg0KDQpSZXZpZXdlZC1ieTog
emhhbmd6aGVuZ21pbmcgPHpoYW5nLnpoZW5nbWluZ0BoM2MuY29tPg0KLS0tDQogbW0vaGlnaG1l
bS5jIHwgNSArKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL21tL2hpZ2htZW0uYyBiL21tL2hpZ2htZW0uYyBpbmRleCBi
ZDQ4YmE0Li44NDFiMzcwIDEwMDY0NA0KLS0tIGEvbW0vaGlnaG1lbS5jDQorKysgYi9tbS9oaWdo
bWVtLmMNCkBAIC0yMjAsOCArMjIwLDExIEBAIHN0YXRpYyB2b2lkIGZsdXNoX2FsbF96ZXJvX3Br
bWFwcyh2b2lkKQ0KICAgICAgICAgICAgICAgIHNldF9wYWdlX2FkZHJlc3MocGFnZSwgTlVMTCk7
DQogICAgICAgICAgICAgICAgbmVlZF9mbHVzaCA9IDE7DQogICAgICAgIH0NCi0gICAgICAgaWYg
KG5lZWRfZmx1c2gpDQorICAgICAgIGlmIChuZWVkX2ZsdXNoKSB7DQorICAgICAgICAgICAgICAg
c3Bpbl91bmxvY2soJmttYXBfbG9jayk7DQogICAgICAgICAgICAgICAgZmx1c2hfdGxiX2tlcm5l
bF9yYW5nZShQS01BUF9BRERSKDApLCBQS01BUF9BRERSKExBU1RfUEtNQVApKTsNCisgICAgICAg
ICAgICAgICBzcGluX2xvY2soJmttYXBfbG9jayk7DQorICAgICAgIH0NCiB9DQoNCiB2b2lkIF9f
a21hcF9mbHVzaF91bnVzZWQodm9pZCkNCi0tDQoyLjM0LjENCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5paw5Y2O5LiJ6ZuG5Zui55qE5L+d5a+G5L+h
5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye6DQrnmoTkuKrkurrm
iJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjl
jIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIENCuaI
luaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmC
ruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZ
pOacrA0K6YKu5Lu277yBDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4g
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTmV3IEgzQywgd2hpY2ggaXMNCmludGVuZGVk
IG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFi
b3ZlLiBBbnkgdXNlIG9mIHRoZQ0KaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkg
d2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbA0KZGlz
Y2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVy
IHRoYW4gdGhlIGludGVuZGVkDQpyZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJl
Y2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlcg0KYnkg
cGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCENCg==

