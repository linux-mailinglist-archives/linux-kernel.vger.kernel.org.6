Return-Path: <linux-kernel+bounces-252451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FCD93133C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB4D1C2188B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239A18A921;
	Mon, 15 Jul 2024 11:39:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070B189F58;
	Mon, 15 Jul 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043545; cv=none; b=qgScwSYus3enzNmzYnrToBMBng+v0AgWy/+CF3GRG2sdtWm6ysdBLXELwCfw1fxtMmQiqyCH96c9c2bZZkswaplV962EPI+rt4gaWluG8/p/C30u9ZxUPJeiELHRgn9vWrhKETQgBz36mcB5/tm9J+MUqC2n6nkBWajpPlvn/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043545; c=relaxed/simple;
	bh=lCeC4gmfTQRuoltTtc3HF5WSdisu5ByxU/qRss5sHQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Axf+OLEYDTenioz6Z6F+8Fffg2XAdoBavXe0EL9d8bLDGoY8fnwWAheoY75gtMIdK9tzjLlboyN5dqp+8Rgvw9gATHp68dipuvGE/lqBs56WZoiirCwvRgg9Ktc17HBtKR6OxmDBMfRPE9P/Vb7KzthMwRUi2cG/+cERbpbQSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WN0Y76Sd8zdhQg;
	Mon, 15 Jul 2024 19:37:15 +0800 (CST)
Received: from kwepemd100010.china.huawei.com (unknown [7.221.188.107])
	by mail.maildlp.com (Postfix) with ESMTPS id AF525180064;
	Mon, 15 Jul 2024 19:38:58 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100010.china.huawei.com (7.221.188.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 15 Jul 2024 19:38:58 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Mon, 15 Jul 2024 19:38:58 +0800
From: duchangbin <changbin.du@huawei.com>
To: duchangbin <changbin.du@huawei.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "Wanghui (OS Kernel Lab, Beijing)"
	<hw.huiwang@huawei.com>
Subject: Re: [PATCH v5 0/8] perf: support specify vdso path in cmdline
Thread-Topic: [PATCH v5 0/8] perf: support specify vdso path in cmdline
Thread-Index: AQHazDbzI6rzmwQCM0CRTliZqIB/KrH3vp4A
Date: Mon, 15 Jul 2024 11:38:58 +0000
Message-ID: <5b4a83c1a1614e23985a10e669d78eda@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
In-Reply-To: <20240702041837.5306-1-changbin.du@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F3DD7C628C5C24AA96E5083F621F819@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8sIGFyZSB0aGVyZSBhbnkgbW9yZSBjb21tZW50cyBhYm91dCB0aGlzIHJldmlzaW9uPw0K
DQpPbiBUdWUsIEp1bCAwMiwgMjAyNCBhdCAxMjoxODoyOVBNICswODAwLCBDaGFuZ2JpbiBEdSB3
cm90ZToNCj4gVGhlIHZkc28gZHVtcGVkIGZyb20gcHJvY2VzcyBtZW1vcnkgKGluIGJ1aWxkaWQt
Y2FjaGUpIGxhY2tzIGRlYnVnZ2luZw0KPiBpbmZvLiBUbyBhbm5vdGF0ZSB2ZHNvIHN5bWJvbHMg
d2l0aCBzb3VyY2UgbGluZXMgd2UgbmVlZCBhIGRlYnVnZ2luZw0KPiB2ZXJzaW9uLg0KPiANCj4g
Rm9yIHg4Niwgd2UgY2FuIGZpbmQgdGhlbSBmcm9tIHlvdXIgbG9jYWwgYnVpbGQgYXMNCj4gJ2Fy
Y2gveDg2L2VudHJ5L3Zkc28vdmRzb3szMiw2NH0uc28uZGJnJy4gT3IgdGhleSBtYXkgcmVzaWRl
cyBpbg0KPiAnL2xpYi9tb2R1bGVzLzx2ZXJzaW9uPi92ZHNvL3Zkc297MzIsNjR9LnNvJyBvbiBV
YnVudHUuIEJ1dCBub3RpY2UgdGhhdCB0aGUNCj4gYnVpbGlkIGhhcyB0byBtYXRjaC4gDQo+IA0K
PiBJZiB1c2VyIGRvZXNuJ3Qgc3BlY2lmeSB0aGUgcGF0aCwgcGVyZiB3aWxsIHNlYXJjaCB0aGVt
IGludGVybmFsbHkgYXMgbG9uZw0KPiBhcyB2bWxpbnV4IHdoZW4gcmVjb3JkaW5nIHNhbXBsZXMu
IFRoZSBzZWFyY2hlZCBkZWJ1Z2dpbmcgdmRzbyB3aWxsIGFkZCB0bw0KPiBidWlsZGlkIGNhY2hl
Lg0KPiANCj4gQmVsb3cgc2FtcGxlcyBhcmUgY2FwdHVyZWQgb24gbXkgbG9jYWwgYnVpbGQga2Vy
bmVsLiBwZXJmIHN1Y2Nlc2Z1bGx5DQo+IGZpbmQgZGVidWdnaW5nIHZlcnNpb24gdmRzbyBhbmQg
d2UgY2FuIGFubm90YXRlIHdpdGggc291cmNlIHdpdGhvdXQNCj4gc3BlY2lmeWluZyB2ZHNvIHBh
dGguDQo+IA0KPiAkIHN1ZG8gcGVyZiByZWNvcmQgLWENCj4gJCBzdWRvIHBlcmYgcmVwb3J0IC0t
b2JqZHVtcD1sbHZtLW9iamR1bXANCj4gDQo+IFNhbXBsZXM6IDE3SyBvZiBldmVudCAnY3ljbGVz
OlAnLCA0MDAwIEh6LCBFdmVudCBjb3VudCAoYXBwcm94Lik6IDE3NjANCj4gX192ZHNvX2Nsb2Nr
X2dldHRpbWUgIC93b3JrL2xpbnV4LWhvc3QvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvNjQuc28u
ZA0KPiBQZXJjZW504pSCICAgICAgIG1vdnEgICAgLTQ4KCVyYnApLCVyc2kNCj4gICAgICAgIOKU
giAgICAgICB0ZXN0cSAgICVyYXgsJXJheA0KPiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAg
ICAgcmV0dXJuIHZyZWFkX2h2Y2xvY2soKTsNCj4gICAgICAgIOKUgiAgICAgICBtb3ZxICAgICVy
YXgsJXJkeA0KPiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCF2
ZHNvX2N5Y2xlc19vayhjeWNsZXMpKSkNCj4gICAgICAgIOKUgiAgICAg4oaRIGpzICAgICAgZWIN
Cj4gICAgICAgIOKUgiAgICAg4oaRIGptcCAgICAgNzQNCj4gICAgICAgIOKUgiAgICAgOyAgICAg
ICAgICAgICAgIHRzLT50dl9zZWMgPSB2ZHNvX3RzLT5zZWM7DQo+ICAgMC4wMiDilIIxNDc6ICAg
bGVhcSAgICAyKCVyYngpLCVyYXgNCj4gICAgICAgIOKUgiAgICAgICBzaGxxICAgICQ0LCAlcmF4
DQo+ICAgICAgICDilIIgICAgICAgYWRkcSAgICAlcjEwLCVyYXgNCj4gICAgICAgIOKUgiAgICAg
OyAgICAgICAgICAgICAgIHdoaWxlICgoc2VxID0gUkVBRF9PTkNFKHZkLT5zZXEpKSAmIDEpIHsN
Cj4gICA5LjM4IOKUgjE1MjogICBtb3ZsICAgICglcjEwKSwlZWN4DQo+IA0KPiBXaGVuIGRvaW5n
IGNyb3NzIHBsYXRmb3JtIGFuYWx5c2lzLCB3ZSBuZWVkIHRvIHNwZWNpZnkgdGhlIHZkc28gcGF0
aCBpZg0KPiB3ZSBhcmUgaW50ZXJlc3RlZCBpbiBpdHMgc3ltYm9scy4gQXQgbW9zdCB0d28gdmRz
byBjYW4gYmUgZ2l2ZW4uIEFsc28geW91DQo+IGNhbiBwYWNrIHlvdXIgYnVpbGRpZCBjYWNoZSB3
aXRoIHBlcmYtYXJjaGl2ZSBpZiB0aGUgZGVidWdnaW5nIHZkc28gY2FuIGJlDQo+IGZvdW5kIG9u
IHRoZSBzYW1wbGVkIG1hY2hpbmUuDQo+IA0KPiAkIHN1ZG8gcGVyZiByZXBvcnQgLS1vYmpkdW1w
PWxsdm0tb2JqZHVtcCBcDQo+ICAgICAgIC0tdmRzbyBhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc282
NC5zby5kYmcsYXJjaC94ODYvZW50cnkvdmRzby92ZHNvMzIuc28uZGJnDQo+IA0KPiBJIGFsc28g
aW1wcm92ZWQgcGVyZi1idWlsZGlkLWNhY2hlIGNvbW1hbmQgcmVjb2duaXplIHZkc28gd2hlbiBh
ZGRpbmcgZmlsZXMsIHRoZW4NCj4gcGxhY2UgaXQgYXQgY29ycmVjdCBwbGFjZS4NCj4gDQo+IHY1
Og0KPiAgIC0gU2VhcmNoaW5nIHRoZSB2ZHNvIGluIHJlY29yZCBzdGFnZSBpbnN0ZWFkIG9mIHJl
cG9ydC4gU28gdGhlIGRlYnVnZ2luZw0KPiAgICAgdmRzbyB3aWxsIGJlIGluIGJ1aWxkLWlkIGNh
Y2hlLiBUaGlzIGlzIGZyaWVuZGx5IGZvciBjcm9zcy1tYWNoaW5lIGFuYWx5c2lzLg0KPiAgIC0g
SW1wcm92ZSBwZXJmLWJ1aWxkaWQtY2FjaGUgY29tbWFuZCByZWNvZ25pemUgdmRzbyB3aGVuIGFk
ZGluZyBmaWxlcw0KPiB2NDoNCj4gICAtIHNwbGl0IHRoZSByZWZhY3RvcmluZyBmcm9tIHRoZSBh
Y3R1YWwgY2hhbmdlLg0KPiB2MzoNCj4gICAtIHVwZGF0ZSBkb2N1bWVudGF0aW9uLg0KPiB2MjoN
Cj4gICAtIG5vdyBzZWFyY2ggdmRzbyBhdXRvbWF0aWNhbGx5IGFzIGxvbmcgYXMgdm1saW51eCwg
YXMgc3VnZ2VzdGVkIGJ5IEFkcmlhbi4NCj4gICAtIHJlbW92ZSBjaGFuZ2UgJ3ByZWZlciBzeW1z
cmNfZmlsZW5hbWUgZm9yIGZpbGVuYW1lJy4NCj4gDQo+IA0KPiBDaGFuZ2JpbiBEdSAoOCk6DQo+
ICAgcGVyZjogc3VwcG9ydCBzcGVjaWZ5IHZkc28gcGF0aCBpbiBjbWRsaW5lDQo+ICAgcGVyZjog
ZGlzYXNtOiByZWZhY3RvciBmdW5jdGlvbiBkc29fX2Rpc2Fzc2VtYmxlX2ZpbGVuYW1lDQo+ICAg
cGVyZjogZGlzYXNtOiB1c2UgYnVpbGRfaWRfcGF0aCBpZiBmYWxsYmFjayBmYWlsZWQNCj4gICBw
ZXJmOiBidWlsZC1pZDogbmFtZSBkZWJ1Z2dpbmcgdmRzbyBhcyAiZGVidWciDQo+ICAgcGVyZjog
c3ltYm9sOiBnZW5lcmFsaXplIHZtbGludXggcGF0aCBzZWFyY2hpbmcNCj4gICBwZXJmOiBidWls
ZC1pZDogdHJ5IHRvIHNlYXJjaCBkZWJ1Z2dpbmcgdmRzbyBhbmQgYWRkIHRvIGNhY2hlDQo+ICAg
cGVyZjogZGlzYXNtOiBwcmVmZXIgZGVidWdnaW5nIGZpbGVzIGluIGJ1aWxkLWlkIGNhY2hlDQo+
ICAgcGVyZiBidWlsZGlkLWNhY2hlOiByZWNvZ25pemUgdmRzbyB3aGVuIGFkZGluZyBmaWxlcw0K
PiANCj4gIHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLWFubm90YXRlLnR4dCB8ICAgMyAr
DQo+ICB0b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1jMmMudHh0ICAgICAgfCAgIDMgKw0K
PiAgdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtaW5qZWN0LnR4dCAgIHwgICAzICsNCj4g
IHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLXJlcG9ydC50eHQgICB8ICAgMyArDQo+ICB0
b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1zY3JpcHQudHh0ICAgfCAgIDMgKw0KPiAgdG9v
bHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtdG9wLnR4dCAgICAgIHwgICAzICsNCj4gIHRvb2xz
L3BlcmYvYnVpbHRpbi1hbm5vdGF0ZS5jICAgICAgICAgICAgICB8ICAgMiArDQo+ICB0b29scy9w
ZXJmL2J1aWx0aW4tYnVpbGRpZC1jYWNoZS5jICAgICAgICAgfCAgMjYgKystDQo+ICB0b29scy9w
ZXJmL2J1aWx0aW4tYzJjLmMgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgdG9vbHMvcGVy
Zi9idWlsdGluLWluamVjdC5jICAgICAgICAgICAgICAgIHwgICAyICsNCj4gIHRvb2xzL3BlcmYv
YnVpbHRpbi1yZXBvcnQuYyAgICAgICAgICAgICAgICB8ICAgMiArDQo+ICB0b29scy9wZXJmL2J1
aWx0aW4tc2NyaXB0LmMgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgdG9vbHMvcGVyZi9idWls
dGluLXRvcC5jICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gIHRvb2xzL3BlcmYvdXRpbC9i
dWlsZC1pZC5jICAgICAgICAgICAgICAgICB8ICA1NyArKysrKy0NCj4gIHRvb2xzL3BlcmYvdXRp
bC9kaXNhc20uYyAgICAgICAgICAgICAgICAgICB8IDEzMSArKysrKysrKy0tLS0tDQo+ICB0b29s
cy9wZXJmL3V0aWwvbWFjaGluZS5jICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gIHRvb2xz
L3BlcmYvdXRpbC9zeW1ib2wuYyAgICAgICAgICAgICAgICAgICB8IDIwOSArKysrKysrKysrKysr
KysrLS0tLS0NCj4gIHRvb2xzL3BlcmYvdXRpbC9zeW1ib2wuaCAgICAgICAgICAgICAgICAgICB8
ICAgOSArLQ0KPiAgdG9vbHMvcGVyZi91dGlsL3N5bWJvbF9jb25mLmggICAgICAgICAgICAgIHwg
ICA1ICsNCj4gIDE5IGZpbGVzIGNoYW5nZWQsIDM1OSBpbnNlcnRpb25zKCspLCAxMTIgZGVsZXRp
b25zKC0pDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQotLSANCkNoZWVycywNCkNoYW5nYmlu
IER1DQo=

