Return-Path: <linux-kernel+bounces-235532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2B91D646
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE571F213E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1487C13B;
	Mon,  1 Jul 2024 02:49:43 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DD15E88
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802183; cv=none; b=NDC5DhxSUcV/Fl/xq+ZI1iS1nBGSoAKBFfWCakRkdRVCiKFikf3fKvWMMYvhOIpTBfSK4outSsrZOzEkmnMcgz+Q3UXNrmN5Dd5n34C8dQGeEjjWRMOx8IWkdZbUJFfWvyXPHqT5Q8wnjlyHLNmKwrGFWUw7t4wEywK2WcGvOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802183; c=relaxed/simple;
	bh=K+txfgIBDiC5EBu9Tyu6qcr21MebyAoTXTIWB1FfFmA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AgOTgmCPrn5rO129XIfNFE7EZsWi7taEf3KJQTCdEOoleRv/gUDzYGfCmbWR+udZ9vdzhnLRdNV0eK2/jJkzadKbLc/zqPe03lZb9bjyEW8SCsHPZl1jZm+8jf3WNKkrRNhcY1zARhGvwMCvM4ZJJzWuDb3xIGVNxhX7QTK7sWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 4611lFwP029898
	for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2024 09:47:15 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4611jvHJ024589;
	Mon, 1 Jul 2024 09:45:57 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX11-BJD.srv.huawei-3com.com (unknown [10.153.34.13])
	by mail.maildlp.com (Postfix) with ESMTP id 07A032004BBD;
	Mon,  1 Jul 2024 09:49:59 +0800 (CST)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) by
 DAG6EX11-BJD.srv.huawei-3com.com (10.153.34.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Mon, 1 Jul 2024 09:45:58 +0800
Received: from DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5])
 by DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5%4]) with mapi
 id 15.02.1258.027; Mon, 1 Jul 2024 09:45:58 +0800
From: Zhangchun <zhang.chunA@h3c.com>
To: "shaohaojize@126.com" <shaohaojize@126.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaoxupo
	<jiaoxupo@h3c.com>, Bailin <berlin@h3c.com>,
        Zhangzhansheng
	<zhang.zhansheng@h3c.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, wangyu
	<wang.yuI@h3c.com>
Subject: [PATCH] mm: fix kmap_high deadlock
Thread-Topic: [PATCH] mm: fix kmap_high deadlock
Thread-Index: AdrLWGWcTXIJ41leRoK9JQLjgSju3w==
Date: Mon, 1 Jul 2024 01:45:57 +0000
Message-ID: <079f7b0b129f4fbc86d5f5ee8795fd1b@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 4611lFwP029898

DQpGcm9tOiAiemhhbmcuY2h1biIgPHpoYW5nLmNodW5hQGgzYy5jb20+DQoNCkkgd29yayB3aXRo
IHpoYW5nemhhbnNoZW5nKGZyb20gaDNjKSBmaW5kIHRoYXQgc29tZSBzaXR1YXRpb24gbWF5IGNh
c3VlIGRlYWRsb2NrIHdoZW4gd2UgdXNlIGttYXBfaGlnaGFuZCBrbWFwX1hYWCBvciBrdW1hcF94
eHggYmV0d2VlbiAgZGlmZmVydCBjb3JlcyBhdCB0aGUgc2FtZSB0aW1lLmttYXBfaGlnaC0+bWFw
X25ld192aXJ0dWFsLT4gZmx1c2hfYWxsX3plcm9fcGttYXBzLT5mbHVzaF90bGJfa2VybmVsX3Jh
bmdlLT5vbl9lYWNoX2NwdSwNCk9uIHRoaXMgY29uZGl0aW9uLCBrbWFwX2hpZ2gNCmhvbGQgdGhl
IGttYXBfbG9ja++8jCB3YWl0IHRoZSBvdGhlciBjb3JlcyBhY2suIEJ1dCB0aGUgb3RoZXJzIG1h
eSBkaXNhYmxlIGlycSBhbmQgd2FpdCBrbWFwX2xvY2vvvIwgdGhpcyBpcyBzb21lIGRlYWRsb2Nr
IGNvbmRpdGlvbi4NCkkgdGhpbmsgaXQncyBuZWNlc3NhcnkgdG8gZ2l2ZSBrbWFwX2xvY2sgYmVm
b3JlIGNhbGwgZmx1c2hfdGxiX2tlcm5lbF9yYW5nZS4NCkxpa2UgdGhpczoNCnNwaW5fdW5sb2Nr
KCZrbWFwX2xvY2spOw0KZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSh4eHgpOw0Kc3Bpbl9sb2NrKCZr
bWFwX2xvY2spOw0KDQpTaWduZWQtb2ZmLWJ5OiB6aGFuZy5jaHVuIDx6aGFuZy5jaHVuYUBoM2Mu
Y29tPg0KLS0tDQogbW0vaGlnaG1lbS5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL21tL2hpZ2htZW0uYyBiL21tL2hpZ2htZW0uYyBpbmRl
eCBiZDQ4YmE0NDVkZDQuLjEyZDIwZTU1MTU3OSAxMDA2NDQNCi0tLSBhL21tL2hpZ2htZW0uYw0K
KysrIGIvbW0vaGlnaG1lbS5jDQpAQCAtMjIxLDcgKzIyMSw5IEBAIHN0YXRpYyB2b2lkIGZsdXNo
X2FsbF96ZXJvX3BrbWFwcyh2b2lkKQ0KIG5lZWRfZmx1c2ggPSAxOw0KIH0NCiBpZiAobmVlZF9m
bHVzaCkNCitzcGluX3VubG9jaygma21hcF9sb2NrKTsNCiBmbHVzaF90bGJfa2VybmVsX3Jhbmdl
KFBLTUFQX0FERFIoMCksIFBLTUFQX0FERFIoTEFTVF9QS01BUCkpOw0KK3NwaW5fbG9jaygma21h
cF9sb2NrKTsNCiB9DQoNCiB2b2lkIF9fa21hcF9mbHVzaF91bnVzZWQodm9pZCkNCi0tDQoyLjM0
LjENCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5paw
5Y2O5LiJ6ZuG5Zui55qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw
5Z2A5Lit5YiX5Ye6DQrnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrk
u6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIbl
nLDms4TpnLLjgIHlpI3liLbjgIENCuaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OA
guWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7
tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrA0K6YKu5Lu277yBDQpUaGlzIGUtbWFpbCBhbmQg
aXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTmV3
IEgzQywgd2hpY2ggaXMNCmludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdo
b3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZQ0KaW5mb3JtYXRpb24g
Y29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0
bywgdG90YWwgb3IgcGFydGlhbA0KZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1p
bmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkDQpyZWNpcGllbnQocykg
aXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFz
ZSBub3RpZnkgdGhlIHNlbmRlcg0KYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRl
bGV0ZSBpdCENCg==

