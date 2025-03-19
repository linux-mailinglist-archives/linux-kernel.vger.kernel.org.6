Return-Path: <linux-kernel+bounces-567673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F3A688E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CED887C76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F42F254873;
	Wed, 19 Mar 2025 09:48:22 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE025486A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377702; cv=none; b=k4ufCFgwvzlAUPdESPKn9R7rXVcNzh+UeZB4yv1jy5A/27CJpg5cUm2g9ocOSX4OVXiIycKWrSQWNW0RADKpsbo/lpl+JZ6OTxD/cbdfIjTlDEFfbipYk2bJzoXu0yBlpKjc+Rr0QgRfBxUl1YKgttN/BxLELQKCvsNPMecM8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377702; c=relaxed/simple;
	bh=/Cn/kV3e7jBYNECw5Bfi0Nqy17XabU2b+WM/I7IKFK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAlGOQ32wb85NSktLGJ3YgHH14BW1m6Op1VcfNK0Eez6xEyfIP/OYgdLR/gjHXG0uVhReGDwaRE696tcIT5fOa8jd5+0/t6lI0z9mNu4TyYPmQkH1CwQ91i6YvQc6/OAF+wXZ6AIsNVQBmiAjA4pRWb8+iSUsTE12wCRRGT3Vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZHkL46vKNz1f0xB;
	Wed, 19 Mar 2025 17:43:40 +0800 (CST)
Received: from kwepemh100014.china.huawei.com (unknown [7.202.181.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 015FF1A016C;
	Wed, 19 Mar 2025 17:48:12 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (7.202.181.122) by
 kwepemh100014.china.huawei.com (7.202.181.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 17:48:11 +0800
Received: from kwepemh200013.china.huawei.com ([7.202.181.122]) by
 kwepemh200013.china.huawei.com ([7.202.181.122]) with mapi id 15.02.1544.011;
 Wed, 19 Mar 2025 17:48:11 +0800
From: "zhangxiaomeng (A)" <zhangxiaomeng13@huawei.com>
To: Carlos Llamas <cmllamas@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, "J. R.
 Okajima" <hooanon05g@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon
	<will@kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBsb2NrZGVwOiBGaXggdXBwZXIgbGltaXQgZm9yIExP?=
 =?gb2312?Q?CKDEP=5FBITS_configs?=
Thread-Topic: [PATCH] lockdep: Fix upper limit for LOCKDEP_BITS configs
Thread-Index: AQHblQ+Mg9urffhKmkWt6/ItPII61rN6PVxQ
Date: Wed, 19 Mar 2025 09:48:11 +0000
Message-ID: <629305cc0e6b433d90354fb22d3bacf1@huawei.com>
References: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>
 <Z9R2a_dX4YtK4jJ9@google.com>
In-Reply-To: <Z9R2a_dX4YtK4jJ9@google.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

VGhhbmsgeW91IGZvciB0aGUgcmVzcG9uc2UuIEkgc2hvdWxkIGNsYXJpZnkgdGhhdCB0aGUgaXNz
dWUgb2NjdXJzIHdoZW4gbW9kaWZ5aW5nIGFkZGl0aW9uYWwgY29uZmlnIHZhbHVlcy4gU3BlY2lm
aWNhbGx5LCB3aGVuIExPQ0tERVBfQklUUyBpcyBzZXQgdG8gMjQgYWxvbmcgd2l0aCBzZXR0aW5n
IExPQ0tERVBfQ0hBSU5TX0JJVFMgYW5kIExPQ0tERVBfU1RBQ0tfVFJBQ0VfQklUUyB0byB0aGVp
ciBtYXhpbXVtIHVwcGVyIGxpbWl0cywgdGhlIGJ1aWxkIGZhaWxzLg0KDQpIZXJlIGFyZSB0aGUg
ZXhhY3Qgc3RlcHMgdG8gcmVwcm9kdWNlOg0KDQpSdW4gbWFrZSBtZW51Y29uZmlnDQpFbmFibGUg
Q09ORklHX1BST1ZFX0xPQ0tJTkcNClNldCB0aGUgZm9sbG93aW5nIHZhbHVlczoNCkxPQ0tERVBf
Q0hBSU5TX0JJVFMgPSAyMQ0KTE9DS0RFUF9CSVRTID0gMjQNCkxPQ0tERVBfU1RBQ0tfVFJBQ0Vf
QklUUyA9IDI2DQpCdWlsZCBrZXJuZWwgNi42IHdpdGggbWFrZSAtajEyMg0KDQotLS0tLdPKvP7U
rbz+LS0tLS0NCreivP7IyzogQ2FybG9zIExsYW1hcyA8Y21sbGFtYXNAZ29vZ2xlLmNvbT4gDQq3
osvNyrG85DogMjAyNcTqM9TCMTXI1SAyOjMzDQrK1bz+yMs6IHpoYW5neGlhb21lbmcgKEEpIDx6
aGFuZ3hpYW9tZW5nMTNAaHVhd2VpLmNvbT4NCrOty806IEFuZHJldyBNb3J0b24gPGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBCb3F1biBG
ZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT47IEouIFIuIE9rYWppbWEgPGhvb2Fub24wNWdAZ21h
aWwuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgV2FpbWFuIExv
bmcgPGxvbmdtYW5AcmVkaGF0LmNvbT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsg
V2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCtb3zOI6IFJlOiBbUEFUQ0hdIGxvY2tkZXA6
IEZpeCB1cHBlciBsaW1pdCBmb3IgTE9DS0RFUF9CSVRTIGNvbmZpZ3MNCg0KT24gRnJpLCBNYXIg
MTQsIDIwMjUgYXQgMDY6NDc6MjlBTSArMDAwMCwgWGlhb21lbmcgWmhhbmcgd3JvdGU6DQo+IFRo
ZSB1cHBlciBsaW1pdCB0aGF0IHdhcyBpbml0aWFsbHkgc2V0dXAgZm9yIExPQ0tERVBfQklUUyBj
b25maWdzIGlzIA0KPiB0b28gaGlnaCAoMjQgYml0IHNoaWZ0KSwgd2hpY2ggY2F1c2VzIHRoZSBr
ZXJuZWwgaW1hZ2Ugc2l6ZSB0byBleGNlZWQgDQo+IEtFUk5FTF9JTUFHRV9TSVpFICgxMDI0TUIp
IGxpbWl0LiBXaGVuIExPQ0tERVBfQklUUyBpcyBzZXQgdG8gMjQsIHRoZSANCj4ga2VybmVsIGlt
YWdlIHNpemUgZ3Jvd3MgdG8gMTU2Mi4xOU1CLg0KDQpUaGlzIGlzIG5vdCBlbnRpcmVseSBhY2N1
cmF0ZS4gTG9vayBhdCBfaG93XyB0aGUgbmV3IHVwcGVyIGxpbWl0cyB3aGVyZSBkZXRlcm1pbmVk
IGluIGNvbW1pdCBlNjM4MDcyZTYxNzIuIFRoaXMgc2hvdWxkIGJ1aWxkIGp1c3QgZmluZToNCg0K
CSQgbWFrZSBkZWZjb25maWcNCgkkIC4vc2NyaXB0cy9jb25maWcgLWUgUFJPVkVfTE9DS0lORyAt
LXNldC12YWwgTE9DS0RFUF9CSVRTIDI0DQoJJCBtYWtlIC1zIG9sZGRlZmNvbmZpZyBhbGwNCg0K
SXMgaXQgbm90IHRoZSBjYXNlIGZvciB5b3U/IE15IGd1ZXNzIGlzIHRoYXQgeW91J3ZlIGFsc28g
Y2hhbmdlZCBfb3RoZXJfIGNvbmZpZ3MgYW5kIGNvbWJpbmVkIHdpdGggdGhhdCB5b3UgaGl0IHRo
ZSBsaW1pdC4gSWYgbm90LCBjYW4geW91IHBsZWFzZSBwcm92aWRlIHRoZSBzdGVwcyBhbmQgY29t
bWl0IHlvdSBhcmUgdXNpbmc/DQoNClRoYW5rcywNCi0tDQpDYXJsb3MgTGxhbWFzDQo=

