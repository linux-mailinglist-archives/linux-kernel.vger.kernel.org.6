Return-Path: <linux-kernel+bounces-214286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A821F908246
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5200D1F23518
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E018309B;
	Fri, 14 Jun 2024 03:05:22 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E48145323
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334322; cv=none; b=el6+f5Nt8N5wamNDtTqGLgCJ6MZjmgiofuzIOPq5VuxtLTmBUb6p1Vc9ZV1o4yLPmCcu+e3BhpxoOMQ8B186/jUUDmQ8y4+tjbCUArXmrsQSQ1avWYVIYcYbvhC3WaWNNRlkVpbHc5e/qd+JLIA+XrR9m4GNpH7IkF1NCEMhUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334322; c=relaxed/simple;
	bh=wIXKkRgiuC3dpWHjJSCo863yvm5lyxP6YsjBHdpKL4c=;
	h=Date:From:To:Cc:Subject:Mime-Version:Message-ID:Content-Type:
	 Content-Disposition; b=H3hIp96PzHU/CB7uXHIc1oQnI6tQeW+YBphg4rz99Tcuum8kOOfNfcLxc/+WCJnFo3nU0U2Vb4MTVG/vxwTEMA5HrEoe0Z9kKah4KHC9YYQiHYNtjba2gD+M8rrussZKnKuC/mivGb8XJbmfSRBcE25Kj6oN5hzhSqYPm46SexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: webmail.sinamail.sina.com.cn
Received: from webmail-23-148.pop3.fmail.yf.sinanode.com (HELO webmail.sinamail.sina.com.cn)([10.2.23.148])
	by sina.com (172.16.235.25) with SMTP
	id 666BB34600004062; Fri, 14 Jun 2024 11:04:38 +0800 (CST)
X-Sender: ghostxavier@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=ghostxavier@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=ghostxavier@sina.com
X-SMAIL-MID: 54883034210562
Received: by webmail.sinamail.sina.com.cn (Postfix, from userid 993)
	id 776662AFC; Fri, 14 Jun 2024 11:04:38 +0800 (CST)
Date: Fri, 14 Jun 2024 11:04:38 +0800
Received: from ghostxavier@sina.com ([59.82.45.115]) by m1.mail.sina.com.cn via HTTP;
 Fri, 14 Jun 2024 11:04:38 +0800
From: "Xavier" <ghostxavier@sina.com>
Reply-To: ghostxavier@sina.com
To: =?utf-8?B?Ik1pY2hhbCBLb3V0bsO9Ig==?= <mkoutny@suse.com>
Cc: "Waiman Long" <longman@redhat.com>, "lizefan.x" <lizefan.x@bytedance.com>,
 "tj" <tj@kernel.org>, "hannes" <hannes@cmpxchg.org>,
 "cgroups" <cgroups@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v3] cpuset: use Union-Find to optimize the merging
 of cpumasks
X-Priority: 3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <666bb346733087.27442573.c05259ad@m1.mail.sina.com.cn>
X-MessageID: 026af4711e9dcd09ae064dbed576796b_202406
X-SMAIL-UIID: A38F4B7A5441FC35D08E867605198EC6-20240614-110438-2
X-Mailer: Sina WebMail 4.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGkgTWljaGFsIEtvdXRuw70sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSB0aGlu
ayB5b3VyIGlkZWEgaXMgZ29vZCwgYW5kIEkgd2lsbCByZXN1Ym1pdCBpdCBhZnRlciBMb25nbWFu
J3MgbmV3IHBhdGNoIG9mIGNwdXNldCBpcyBtZXJnZWQuDQoNCkJlc3QgcmVnYXJkcywNClhhdmll
cg0KDQo+DQo+LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQ0KPkZyb206IE1pY2hhbCBLb3V0
bsO9IDxta291dG55QHN1c2UuY29tPg0KPlRvOiBYYXZpZXIgPGdob3N0eGF2aWVyQHNpbmEuY29t
Pg0KPkNjOiBsb25nbWFuQHJlZGhhdC5jb20sIGxpemVmYW4ueEBieXRlZGFuY2UuY29tLCB0akBr
ZXJuZWwub3JnLCAgaGFubmVzQGNtcHhjaGcub3JnLCBjZ3JvdXBzQHZnZXIua2VybmVsLm9yZywg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGNw
dXNldDogdXNlIFVuaW9uLUZpbmQgdG8gb3B0aW1pemUgdGhlIG1lcmdpbmcgb2YgY3B1bWFza3MN
Cj5EYXRlOiAyMDI0LTA2LTExIDAxOjE5DQo+DQo+SGVsbG8uDQo+T24gTW9uLCBKdW4gMDMsIDIw
MjQgYXQgMDg6MzE6MDFQTSBHTVQsIFhhdmllciA8Z2hvc3R4YXZpZXJAc2luYS5jb20+IHdyb3Rl
Og0KPj4gVGhlIHByb2Nlc3Mgb2YgY29uc3RydWN0aW5nIHNjaGVkdWxpbmcgZG9tYWlucyBpbnZv
bHZlcyBtdWx0aXBsZSBsb29wcw0KPj4gYW5kIHJlcGVhdGVkIGV2YWx1YXRpb25zLCBsZWFkaW5n
IHRvIG51bWVyb3VzIHJlZHVuZGFudCBhbmQgaW5lZmZlY3RpdmUNCj4+IGFzc2Vzc21lbnRzIHRo
YXQgaW1wYWN0IGNvZGUgZWZmaWNpZW5jeS4NCj4+IA0KPj4gSGVyZSwgd2UgdXNlIFVuaW9uLUZp
bmQgdG8gb3B0aW1pemUgdGhlIG1lcmdpbmcgb2YgY3B1bWFza3MuIEJ5IGVtcGxveWluZw0KPj4g
cGF0aCBjb21wcmVzc2lvbiBhbmQgdW5pb24gYnkgcmFuaywgd2UgZWZmZWN0aXZlbHkgcmVkdWNl
IHRoZSBudW1iZXIgb2YNCj4+IGxvb2t1cHMgYW5kIG1lcmdlIGNvbXBhcmlzb25zLg0KPk5pY2Ug
dGhhdCB5b3UgZm91bmQgc3VjaCBhbiBhcHBsaWNhdGlvbi4gKEFzIFdhaW1hbiB3cm90ZSwgdGhl
DQo+ZWZmaWNpZW5jeSBpcyBub3Qgc28gaW1wb3J0YW50IGhlcmUgYW5kIGl0IG1heSBub3QgYmUg
ZGVuY3JlYXNlZCBidXQgSQ0KPnN0aWxsIHRoaW5rIGl0IG1ha2VzIHRoZSBjb2RlIG1vcmUgdW5k
ZXJzdGFuZGFibGUgYnkgdXNpbmcgc3RhbmRhcmQgZGF0YQ0KPnN0cnVjdHVyZXMuKQ0KPkhhdmUg
eW91IGxvb2tlZCB3aGV0aGVyIHRoZXJlIGFyZSBvdGhlciBpbnN0YW5jZXMgb2YgVS1GIGluIHRo
ZSBrZXJuZWw/DQo+KE15IHF1aWNrIHNlYXJjaCBkaWRuJ3Qgc2hvdyBhbnkuKSBTdGlsbCwgSSB0
aGluayBpdCdkIGJlIGEgZ29vZCBpZGVhIHRvDQo+ZGVjb3VwbGUgdGhpcyBpbnRvIHR3byBjb21t
aXRzIC0tIDEpIGltcGxlbWVudGF0aW9uIG9mIHRoZSBuZXcgVS1GIChpbnRvDQo+bGliLyksIDIp
IGFwcGxpY2F0aW9uIHdpdGhpbiBjcHVzZXQuDQo+PiArLypkZWZpbmUgYSB1bmlvbiBmaW5kIG5v
ZGUgc3RydWN0Ki8NCj4+ICtzdHJ1Y3QgdWZfbm9kZSB7DQo+PiArCWludCBwYXJlbnQ7DQo+SSB0
aGluayB0aGlzIHdvdWxkIGJlIGJldHRlciBhcyBgc3RydWN0IHVmX25vZGUgKmAuDQo+PiArCWlu
dCByYW5rOw0KPj4gK307DQo+YHVuc2lnbmVkIGludGAgaWYgcmFuayBjYW5ub3QgYmUgbmVnYXRp
dmU/DQo+PiArCS8qIEVhY2ggbm9kZSBpcyBpbml0aWFsbHkgaXRzIG93biBwYXJlbnQgKi8NCj4+
ICsJZm9yIChpID0gMDsgaSA8IGNzbjsgaSsrKSB7DQo+PiArCQlub2Rlc1tpXS5wYXJlbnQgPSBp
Ow0KPj4gKwkJbm9kZXNbaV0ucmFuayA9IDA7DQo+PiArCX0NCj5XaXRoIHRoZSBzdWdnZXN0aW9u
IGFib3ZlLCBub2RlcyBjb3VsZCBzdGFydCB3aXRoIHBhcmVudCA9IE5VTEwgYW5kDQo+c2VsZi1w
YXJlbnQgYmUgY29ycmVjdGVkIGR1cmluZyB0aGUgZmlyc3QgZmluZF9yb290IC0tIHRodXMgd2hv
bGUgYXJyYXkNCj5jb3VsZCBiZSBzaW1wbHkgaW5pdCdkIHRvIHplcm9lcyB3aXRoIGt6YWxsb2Mu
DQo+TXkgMC4wMuKCrCwNCj5NaWNoYWw=


