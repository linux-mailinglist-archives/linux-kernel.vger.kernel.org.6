Return-Path: <linux-kernel+bounces-314668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38696B69A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3068F1C20894
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59651CC8AD;
	Wed,  4 Sep 2024 09:26:36 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 638411CCED2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441996; cv=none; b=JLGhQd1iijaTkN5RTcRPnDro8cWelranO36AK13XrGNbD8gJs8war2ZjgOkmd2+zrdvABSNAITbLGYuJRwOmgt52AOp+NI/jEFE7RHp5ieD+OfseH58dJziXXUBjylfxSVYcdbLKv1jQNHYD1eRp7bz5OeMsW3wvM1pgoJiKPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441996; c=relaxed/simple;
	bh=l1LJbb+jnoRKiguEHTZ+PIrf6eKrm+KdvWK2ZfouHdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=tY6+zYlHPHDbjaZ3dheO0OKYWQhDtXUOiOF5lNGZ3HePRa6QS6L7Z6BgoFnvCgrBrmuij1w2zRWhNRiuymf0bs0BygTFgWg6Nv3tBy2ycw8lwJaXtgMtHtE9dRKDgc5bs7jcdYNaKALNCKNvlXrTabnpk0vI8C7mW5HVEJ1WFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.21])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 6D5DB1806EFD15;
	Wed,  4 Sep 2024 17:23:09 +0800 (CST)
Received: from BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) by
 BJ01-ACTMBX-02.didichuxing.com (10.79.64.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 17:23:18 +0800
Received: from BJ02-ACTMBX-01.didichuxing.com ([fe80::1940:f84a:5d5b:d320]) by
 BJ02-ACTMBX-01.didichuxing.com ([fe80::1940:f84a:5d5b:d320%7]) with mapi id
 15.02.1544.011; Wed, 4 Sep 2024 17:23:18 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.64.21
From: =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dianders@chromium.org" <dianders@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "zyhtheonly@gmail.com"
	<zyhtheonly@gmail.com>, "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>,
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>,
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>,
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "linux@weissschuh.net" <linux@weissschuh.net>,
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "bristot@redhat.com" <bristot@redhat.com>,
	"vschneid@redhat.com" <vschneid@redhat.com>
Subject: Re: [PATCH] watchdog: when watchdog_enabled is 0, let
 (soft,nmi)switch remain 1 after we read them in proc
Thread-Topic: [PATCH] watchdog: when watchdog_enabled is 0, let
 (soft,nmi)switch remain 1 after we read them in proc
Thread-Index: AQHa9GJIs09z5PYqV0ORdqYDyCF53rJHb2IA
Date: Wed, 4 Sep 2024 09:23:18 +0000
Message-ID: <720FE0AC-FFB4-4236-9A29-9BE8C5D27C07@didiglobal.com>
In-Reply-To: <20240822070944.GA13716@didi-ThinkCentre-M930t-N000>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <57485333DB5CE54C89AA64971E30D6C7@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksIA0KDQpQaW5nIDopDQoNCi8vIGdldF9tYWludGFpbmVyLnBsIGRvZXMgbm90IHRlbGwgd2hv
IGFyZSB0aGUgbWFpbnRhaW5lcnMgb3IgcmV2aWV3ZXJzIG9mIGtlcm5lbC93YXRjaGRvZy5jDQpB
ZGQgY29tbWl0IHNpZ25lcnMgYW5kIHNjaGVkIG1haW50YWluZXJzIHRvIHRoZSBDQyBsaXN0Lg0K
DQrvu79PbiA4LzIyLzI0IOS4i+WNiDM6MDksICLlvKDlhYPngJogVGlvIFpoYW5nIiA8dGlvemhh
bmdAZGlkaWdsb2JhbC5jb20gPG1haWx0bzp0aW96aGFuZ0BkaWRpZ2xvYmFsLmNvbT4+IHdyb3Rl
Og0KDQoNCkZvciB1c2VycyBzZXQgIndhdGNoZG9nX3VzZXJfZW5hYmxlZD0wIiBidXQgcmVtYWlu
aW5nDQoiKHNvZnQsbm1pKXdhdGNoZG9nX3VzZXJfZW5hYmxlZD0xIi4gV2F0Y2hkb2cgdGhyZWFk
cygsbm1pIHdhdGNoZG9nKQ0KcmV3b3JrIG9ubHkgaWYgdXNlcnMgcmVzZXQgIndhdGNoZG9nX3Vz
ZXJfZW5hYmxlZD0xIiB3aXRob3V0IHByaW50aW5nDQp0aG9zZSB3YXRjaGRvZyBzd2ljdGhlcy4g
T3RoZXJ3aXNlIChzb2Z0LG5taSl3YXRjaGRvZ191c2VyX2VuYWJsZWQNCndpbGwgdHVybiB0byAw
IGJlY2F1c2Ugb2YgcHJpbnRpbmcgdGhlaXIgdmFsdWVzIChJdCBtYWtlcyBzZW5zZSB0byBwcmlu
dCAwDQpzaW5jZSB0aGV5IGRvIG5vdCB3b3JrIGFueSBtb3JlLCBidXQgaXQgZG9lcyBub3QgbWFr
ZSBzZW5zZSB0byBsZXQgdXNlcidzDQpzd2ljdGhlcyBjaGFuZ2UgdG8gMCBvbmx5IGJ5IHByaW50
cykuDQoNCg0KQW5kIGFmdGVyIHRoYXQsIHdhdGNoZG9nIG9ubHkgc2hvdWxkIHdvcmsgYWdhaW4g
YnkgZG9pbmc6DQooc29mdCxubWkpd2F0Y2hkb2dfdXNlcl9lbmFibGVkPTENCioqKiBjYW4ndCBw
cmludCwgb3IgZXZlcnl0aGluZyBnbyBiYWNrIHRvIDAgYWdhaW4gKioqDQp3YXRjaGRvZ191c2Vy
X2VuYWJsZWQ9MQ0KDQoNClNvIHRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBzaXR1YXRpb246DQoNCg0K
fCBuYW1lIHwgdmFsdWUNCnwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQp8IHdhdGNoZG9nX2VuYWJsZWQgfCAwDQp8LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KfCBubWlfd2F0Y2hkb2df
dXNlcl9lbmFibGVkIHwgMQ0KfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCnwgc29mdF93YXRjaGRvZ191c2VyX2VuYWJsZWQgfCAxDQp8LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KfCB3
YXRjaGRvZ191c2VyX2VuYWJsZWQgfCAwDQp8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQoNCmNhdCAvcHJvYy9zeXMva2VybmVsLyp3YXRj
aGRvZw0KfA0KfA0KVg0KfCBuYW1lIHwgdmFsdWUNCnwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQp8IHdhdGNoZG9nX2VuYWJsZWQgfCAwDQp8
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
fCBubWlfd2F0Y2hkb2dfdXNlcl9lbmFibGVkIHwgMA0KfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCnwgc29mdF93YXRjaGRvZ191c2VyX2Vu
YWJsZWQgfCAwDQp8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KfCB3YXRjaGRvZ191c2VyX2VuYWJsZWQgfCAwDQp8LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQoNCg0KDQpTaWduZWQt
b2ZmLWJ5OiBUaW8gWmhhbmcgPHRpb3poYW5nQGRpZGlnbG9iYWwuY29tIDxtYWlsdG86dGlvemhh
bmdAZGlkaWdsb2JhbC5jb20+Pg0KLS0tDQprZXJuZWwvd2F0Y2hkb2cuYyB8IDEwICsrKysrKysr
KysNCjEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQoNCg0KZGlmZiAtLWdpdCBhL2tl
cm5lbC93YXRjaGRvZy5jIGIva2VybmVsL3dhdGNoZG9nLmMNCmluZGV4IDUxOTE1YjQ0YWM3My4u
NDJlNjllODNlNzZkIDEwMDY0NA0KLS0tIGEva2VybmVsL3dhdGNoZG9nLmMNCisrKyBiL2tlcm5l
bC93YXRjaGRvZy5jDQpAQCAtOTk1LDggKzk5NSwxOCBAQCBzdGF0aWMgaW50IHByb2Nfd2F0Y2hk
b2dfY29tbW9uKGludCB3aGljaCwgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwN
CiogT24gcmVhZCBzeW5jaHJvbml6ZSB0aGUgdXNlcnNwYWNlIGludGVyZmFjZS4gVGhpcyBpcyBh
DQoqIHJhY3kgc25hcHNob3QuDQoqLw0KKyBvbGQgPSBSRUFEX09OQ0UoKnBhcmFtKTsNCipwYXJh
bSA9ICh3YXRjaGRvZ19lbmFibGVkICYgd2hpY2gpICE9IDA7DQplcnIgPSBwcm9jX2RvaW50dmVj
X21pbm1heCh0YWJsZSwgd3JpdGUsIGJ1ZmZlciwgbGVucCwgcHBvcyk7DQorIC8qDQorICogV2hl
biAib2xkIiBpcyAxIGFuZCB3YXRjaGRvZ19lbmFibGVkIGlzIDAsDQorICogaXQgc2hvdWxkIG5v
dCBiZSBjaGFuZ2UgdG8gMCBmb3IgcHJpbnRpbmcNCisgKiBubWlfd2F0Y2hkb2dfdXNlcl9lbmFi
bGVkIG9yIHNvZnRfd2F0Y2hkb2dfdXNlcl9lbmFibGVkLg0KKyAqIFNvIGFmdGVyIHdlIHByaW50
IGl0IGFzIDAsDQorICogd2Ugc2hvdWxkIHJlY292ZXIgaXQgdG8gMS4NCisgKi8NCisgaWYgKG9s
ZCAmJiAhd2F0Y2hkb2dfZW5hYmxlZCkNCisgKnBhcmFtID0gb2xkOw0KfSBlbHNlIHsNCm9sZCA9
IFJFQURfT05DRSgqcGFyYW0pOw0KZXJyID0gcHJvY19kb2ludHZlY19taW5tYXgodGFibGUsIHdy
aXRlLCBidWZmZXIsIGxlbnAsIHBwb3MpOw0KLS0gDQoyLjE3LjENCg0KDQoNCg0KDQo=

