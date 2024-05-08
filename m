Return-Path: <linux-kernel+bounces-172645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B18BF4D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A06B1F2583E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1C1427B;
	Wed,  8 May 2024 03:03:01 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2886913FE7
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715137380; cv=none; b=s0pHWTGTL0frXwK5t+FJSyXHtPtWUmZExvYZW0PArEOraJPVglctnS0XOrctfjrUo7Mgr6PCvoNZevXs5gY9x5y6yQBGvFPvAInOAmANlqNkzdU/yb6ZeTDmA3ux5z8ilbnx2WUaltuK8y44dqyyxJVHjt5YKhsbK7JijRXH4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715137380; c=relaxed/simple;
	bh=rySDbCtREjIZNsee5bXcu4onjyg8VjGzTCq/Dd5cSts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=YK3d+/WdhI6Imaf6jhPVj2viD+H6ZdPUBuJBizN6o+kJtFgw+fT/Ir7n77+iI5hu9af2wdOQXowH7pW425/xU/3kDFhuRfcbNHhIAl4Jbs2S7g0gtlrAqI7TX7wAtUZaqVigpIZXZdahHMwQaT8dNp+MrXBRwJRU4khiatlqlGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.11])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 9F0BB186186C16;
	Wed,  8 May 2024 11:02:48 +0800 (CST)
Received: from ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) by
 ZJY02-ACTMBX-01.didichuxing.com (10.79.65.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 11:02:49 +0800
Received: from ZJY02-ACTMBX-02.didichuxing.com ([fe80::98e9:1ba4:7aed:409f])
 by ZJY02-ACTMBX-02.didichuxing.com ([fe80::98e9:1ba4:7aed:409f%4]) with mapi
 id 15.01.2507.035; Wed, 8 May 2024 11:02:49 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.11
From: =?utf-8?B?5LuY5YWD5YqbIEplcnJ5IEZ1?= <fuyuanli@didiglobal.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "bristot@redhat.com"
	<bristot@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"kolyshkin@gmail.com" <kolyshkin@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "frederic@kernel.org" <frederic@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "CruzZhao@linux.alibaba.com"
	<CruzZhao@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Introduce task_struct::latency_sensi_flag.
Thread-Topic: [PATCH] sched: Introduce task_struct::latency_sensi_flag.
Thread-Index: AQHanpk0GOnQJDnKi0yunFEc6isNrrGJuTGAgALxmAA=
Date: Wed, 8 May 2024 03:02:49 +0000
Message-ID: <6E852CFB-3D1B-4A3B-AFCA-8E0717DE343C@didiglobal.com>
In-Reply-To: <20240506070403.181b574d@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2E4D0E9ADD38F468F9496466DCD83A1@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

U3VyZSwgbXkgZmlyc3QgdGhvdWdodCBpcyBwcm92aWRpbmcgYSB3YXkgdG8gaGF2ZSBhDQpsb3ct
bGF0ZW5jeSB0YXNrIGlmIHVzZXIgZG9lcyBub3Qgd2FudCB0byBlbmFibGUgDQpuYXBpIHRocmVh
ZGVkLiBPbmNlIGl0IGlzIGVuYWJsZWQsIHdoaWNoIHdpbGwgYWZmZWN0DQphbGwgc3lzdGVtLiBJ
IHdhbnQgdG8gaGF2ZSBhIGxvdy1sYXRlbmN5IHRhc2sgd2hpbGUgDQptaW5pbWl6aW5nIHRoZSBp
bXBhY3Qgb24gdGhlIHN5c3RlbS4NCg0KVGhhbmtzDQpmdXl1YW5saQ0KDQrvu7/lnKggMjAyNC81
LzYg5LiL5Y2IMTA6MDTvvIzigJxKYWt1YiBLaWNpbnNraeKAnTxrdWJhQGtlcm5lbC5vcmcgPG1h
aWx0bzprdWJhQGtlcm5lbC5vcmc+PiDlhpnlhaU6DQoNCg0KT24gU3VuLCA1IE1heSAyMDI0IDEx
OjA2OjE1ICswODAwIGZ1eXVhbmxpIHdyb3RlOg0KPiBBIHRlc3QgaGFzIGJlZW4gbWFkZSBpbiB0
d28gaG9zdHMgbmFtZWQgQSBhbmQgQi4gSW4gQSwgc2V2ZXJhbCBjbGllbnRzDQo+IHNlbnQgdWRw
IHBhY2tldHMgdG8gYSBzaW5nbGUgc2VydmVyIGluIEIgY29uY3VycmVudGx5IGFzIGZhc3QgYXMN
Cj4gcG9zc2libGUuIEluIEIsIHRoZSBJUlFzIG9mIHRoZXNlIGZsb3dzIHdlcmUgYm91bmQgdG8g
Q1BVIDAgYnkgZmxvdw0KPiBkaXJlY3Rvciwgc28gdGhlcmUgd2FzIGFsd2F5cyBhIHRyaWdnZXJl
ZCBuZXRfcnggc29mdGlycSBvbiBDUFUgMC4gVGhlbg0KPiBhIHRlc3QgcHJvZ3JhbSB3YXMgc3Rh
cnRlZCBpbiBCLCB3aGljaCB3YXMgYWxzbyBib3VuZCB0byBDUFUgMCwgYW5kDQo+IGtlZXBlZCBj
YWxsaW5nIHNlbmR0bygpIGluIGEgbG9vcC4gU2FtcGxpbmcgd2l0aCBwZXJmLCByZXN1bHRzIHNo
b3dlZA0KPiB0aGF0IGFib3V0IDI1JSBvZiBydW5uaW5nIHRpbWUgb2YgdGVzdCBwcm9ncmFtIHdh
cyBzcGVudCBleGVjdXRpbmcNCj4gbG9jYWxfYmhfZW5hYmxlKCkgY29udGFpbmVkIGluIHN5c2Nh
bGwgc2VuZHRvKCksIGJ1dCBhZnRlciBzZXR0aW5nDQo+IGxhdGVuY3lfc2Vuc2lfZmxhZyB0byAx
LCB0aGlzIHByb3BvcnRpb24gaGFkIGJlZW4gcmVkdWNlZCB0byAwLjUlLg0KDQoNCkVuYWJsZSB0
aHJlYWRlZCBOQVBJLCBpdCB3aWxsIGhhdmUgdGhlIHNhbWUgZWZmZWN0Lg0KDQoNCg0K

