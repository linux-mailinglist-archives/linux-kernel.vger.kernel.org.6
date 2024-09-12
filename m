Return-Path: <linux-kernel+bounces-326322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F81976684
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AEB284069
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9819F41E;
	Thu, 12 Sep 2024 10:09:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6F19F413;
	Thu, 12 Sep 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135751; cv=none; b=Jvx/yGpsPT7rot86+DEhTD0AJYIjU9o1GFpFRDc3QQbOLYUI6LZLqJ+W30uIX5qPmvsyRzzeygFGVdYQ4Ds4QDzh1Zq6rtFc0Xfvqz3CiHyKy/Q6fJnYf58OBeDt1S3+f6B9PB1rLdJdCRqXiHiG6MHhuWrby2RxCwa7NcWLEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135751; c=relaxed/simple;
	bh=YVbNELcneig7P7R7y9a9ioMEMlSkmhhp3E5PFWEP/V0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBqw0nVXke/KDjn4Ef/7XfUUSz4Bz8Pso0sup9vRqeQ655a2SaRcrWJGYOzNlbY0YNQeagX9kU5QU8gTKDVtk+aDmnkhniyotB5Elgp1wqKI0/aS+fPWA61Se+aRgyMdibHO01LGPY34U6nZoEDphaYOW0Igkqrhpfhm9lAIjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X4CnH362NzyRq5;
	Thu, 12 Sep 2024 18:08:19 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 390281800FF;
	Thu, 12 Sep 2024 18:09:06 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Sep 2024 18:09:05 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Thu, 12 Sep 2024 18:09:05 +0800
From: duchangbin <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Liang, Kan"
	<kan.liang@linux.intel.com>, "Nick Desaulniers" <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "Wanghui (OS Kernel Lab,
 Beijing)" <hw.huiwang@huawei.com>
Subject: Re: [PATCH v6 1/8] perf: support specify vdso path in cmdline
Thread-Topic: [PATCH v6 1/8] perf: support specify vdso path in cmdline
Thread-Index: AQHa3jigOgfsnRfGDE+ZRNuPjg5KbrJR/5WAgAI57QA=
Date: Thu, 12 Sep 2024 10:09:05 +0000
Message-ID: <a5334a37943a497a94b6fc9db8aced56@huawei.com>
References: <20240725021549.880167-1-changbin.du@huawei.com>
 <20240725021549.880167-2-changbin.du@huawei.com>
 <b13bcf7c-4d03-4b7d-8509-cebb64297a86@intel.com>
In-Reply-To: <b13bcf7c-4d03-4b7d-8509-cebb64297a86@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <605BF4EE365D3F4491E76F3F68D4BA2F@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksIEFkcmlhbiwNCg0KT24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMTE6MDM6MjFBTSArMDMwMCwg
QWRyaWFuIEh1bnRlciB3cm90ZToNCj4gT24gMjUvMDcvMjQgMDU6MTUsIENoYW5nYmluIER1IHdy
b3RlOg0KPiA+IFRoZSB2ZHNvIGR1bXBlZCBmcm9tIHByb2Nlc3MgbWVtb3J5IChpbiBidWlsZGlk
LWNhY2hlKSBsYWNrcyBkZWJ1Z2dpbmcNCj4gPiBpbmZvLiBUbyBhbm5vdGF0ZSB2ZHNvIHN5bWJv
bHMgd2l0aCBzb3VyY2UgbGluZXMgd2UgbmVlZCBzcGVjaWZ5IGENCj4gPiBkZWJ1Z2dpbmcgdmVy
c2lvbi4NCj4gPiANCj4gPiBGb3IgeDg2LCB3ZSBjYW4gZmluZCB0aGVtIGZyb20geW91ciBsb2Nh
bCBidWlsZCBhcw0KPiA+IGFyY2gveDg2L2VudHJ5L3Zkc28vdmRzb3szMiw2NH0uc28uZGJnLiBP
ciB0aGV5IG1heSByZXNpZGUgaW4NCj4gPiAvbGliL21vZHVsZXMvPHZlcnNpb24+L3Zkc28vdmRz
b3szMiw2NH0uc28gb24gVWJ1bnR1LiBCdXQgbm90aWNlIHRoYXQNCj4gPiB0aGUgYnVpbGRpZCBo
YXMgdG8gbWF0Y2guDQo+ID4gDQo+ID4gJCBzdWRvIHBlcmYgcmVjb3JkIC1hDQo+ID4gJCBzdWRv
IHBlcmYgcmVwb3J0IC0tb2JqZHVtcD1sbHZtLW9iamR1bXAgXA0KPiA+ICAgLS12ZHNvIGFyY2gv
eDg2L2VudHJ5L3Zkc28vdmRzbzY0LnNvLmRiZyxhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi5z
by5kYmcNCj4gPiANCj4gPiBTYW1wbGVzOiAxN0sgb2YgZXZlbnQgJ2N5Y2xlczpQJywgNDAwMCBI
eiwgRXZlbnQgY291bnQgKGFwcHJveC4pOiAxNzYwDQo+ID4gX192ZHNvX2Nsb2NrX2dldHRpbWUg
IC93b3JrL2xpbnV4LWhvc3QvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvNjQuc28uZA0KPiA+IFBl
cmNlbnTilIIgICAgICAgbW92cSAgICAtNDgoJXJicCksJXJzaQ0KPiA+ICAgICAgICDilIIgICAg
ICAgdGVzdHEgICAlcmF4LCVyYXgNCj4gPiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAgICAg
cmV0dXJuIHZyZWFkX2h2Y2xvY2soKTsNCj4gPiAgICAgICAg4pSCICAgICAgIG1vdnEgICAgJXJh
eCwlcmR4DQo+ID4gICAgICAgIOKUgiAgICAgOyAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSgh
dmRzb19jeWNsZXNfb2soY3ljbGVzKSkpDQo+ID4gICAgICAgIOKUgiAgICAg4oaRIGpzICAgICAg
ZWINCj4gPiAgICAgICAg4pSCICAgICDihpEgam1wICAgICA3NA0KPiA+ICAgICAgICDilIIgICAg
IDsgICAgICAgICAgICAgICB0cy0+dHZfc2VjID0gdmRzb190cy0+c2VjOw0KPiA+ICAgMC4wMiDi
lIIxNDc6ICAgbGVhcSAgICAyKCVyYngpLCVyYXgNCj4gPiAgICAgICAg4pSCICAgICAgIHNobHEg
ICAgJDQsICVyYXgNCj4gPiAgICAgICAg4pSCICAgICAgIGFkZHEgICAgJXIxMCwlcmF4DQo+ID4g
ICAgICAgIOKUgiAgICAgOyAgICAgICAgICAgICAgIHdoaWxlICgoc2VxID0gUkVBRF9PTkNFKHZk
LT5zZXEpKSAmIDEpIHsNCj4gPiAgIDkuMzgg4pSCMTUyOiAgIG1vdmwgICAgKCVyMTApLCVlY3gN
Cj4gPiANCj4gPiBXaGVuIGRvaW5nIGNyb3NzIHBsYXRmb3JtIGFuYWx5c2lzLCB3ZSBhbHNvIG5l
ZWQgc3BlY2lmeSB0aGUgdmRzbyBwYXRoIGlmDQo+ID4gd2UgYXJlIGludGVyZXN0ZWQgaW4gaXRz
IHN5bWJvbHMuDQo+ID4gDQo+ID4gdjI6IHVwZGF0ZSBkb2N1bWVudGF0aW9uLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IENoYW5nYmluIER1IDxjaGFuZ2Jpbi5kdUBodWF3ZWkuY29tPg0KPiA+
IC0tLQ0KPiA+ICB0b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1hbm5vdGF0ZS50eHQgfCAg
MyArDQo+ID4gIHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLWMyYy50eHQgICAgICB8ICAz
ICsNCj4gPiAgdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtaW5qZWN0LnR4dCAgIHwgIDMg
Kw0KPiA+ICB0b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1yZXBvcnQudHh0ICAgfCAgMyAr
DQo+ID4gIHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLXNjcmlwdC50eHQgICB8ICAzICsN
Cj4gPiAgdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtdG9wLnR4dCAgICAgIHwgIDMgKw0K
PiA+ICB0b29scy9wZXJmL2J1aWx0aW4tYW5ub3RhdGUuYyAgICAgICAgICAgICAgfCAgMiArDQo+
ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi1jMmMuYyAgICAgICAgICAgICAgICAgICB8ICAyICsNCj4g
PiAgdG9vbHMvcGVyZi9idWlsdGluLWluamVjdC5jICAgICAgICAgICAgICAgIHwgIDIgKw0KPiA+
ICB0b29scy9wZXJmL2J1aWx0aW4tcmVwb3J0LmMgICAgICAgICAgICAgICAgfCAgMiArDQo+ID4g
IHRvb2xzL3BlcmYvYnVpbHRpbi1zY3JpcHQuYyAgICAgICAgICAgICAgICB8ICAyICsNCj4gPiAg
dG9vbHMvcGVyZi9idWlsdGluLXRvcC5jICAgICAgICAgICAgICAgICAgIHwgIDIgKw0KPiA+ICB0
b29scy9wZXJmL3V0aWwvZGlzYXNtLmMgICAgICAgICAgICAgICAgICAgfCAgNyArLQ0KPiA+ICB0
b29scy9wZXJmL3V0aWwvc3ltYm9sLmMgICAgICAgICAgICAgICAgICAgfCA4MiArKysrKysrKysr
KysrKysrKysrKystDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9zeW1ib2xfY29uZi5oICAgICAgICAg
ICAgICB8ICA1ICsrDQo+ID4gIDE1IGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL0RvY3VtZW50
YXRpb24vcGVyZi1hbm5vdGF0ZS50eHQgYi90b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1h
bm5vdGF0ZS50eHQNCj4gPiBpbmRleCBiOTU1MjRiZWEwMjEuLjRiNjY5MmY5YTc5MyAxMDA2NDQN
Cj4gPiAtLS0gYS90b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1hbm5vdGF0ZS50eHQNCj4g
PiArKysgYi90b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1hbm5vdGF0ZS50eHQNCj4gPiBA
QCAtNTgsNiArNTgsOSBAQCBPUFRJT05TDQo+ID4gIC0taWdub3JlLXZtbGludXg6Og0KPiA+ICAJ
SWdub3JlIHZtbGludXggZmlsZXMuDQo+ID4gIA0KPiA+ICstLXZkc289PHZkc28xWyx2ZHNvMl0+
OjoNCj4gPiArCVNwZWNpZnkgdmRzbyBwYXRobmFtZXMuIFlvdSBjYW4gc3BlY2lmeSB1cCB0byB0
d28gZm9yIG11bHRpYXJjaC1zdXBwb3J0Lg0KPiA+ICsNCj4gPiAgLS1pdHJhY2U6Og0KPiA+ICAJ
T3B0aW9ucyBmb3IgZGVjb2RpbmcgaW5zdHJ1Y3Rpb24gdHJhY2luZyBkYXRhLiBUaGUgb3B0aW9u
cyBhcmU6DQo+ID4gIA0KPiANCj4gPFNOSVA+DQo+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9w
ZXJmL2J1aWx0aW4tYW5ub3RhdGUuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1hbm5vdGF0ZS5jDQo+
ID4gaW5kZXggYjEwYjdmMDA1NjU4Li5lMGFhNjU3ZTZjYTAgMTAwNjQ0DQo+ID4gLS0tIGEvdG9v
bHMvcGVyZi9idWlsdGluLWFubm90YXRlLmMNCj4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4t
YW5ub3RhdGUuYw0KPiA+IEBAIC03NDIsNiArNzQyLDggQEAgaW50IGNtZF9hbm5vdGF0ZShpbnQg
YXJnYywgY29uc3QgY2hhciAqKmFyZ3YpDQo+ID4gIAkJICAgImZpbGUiLCAidm1saW51eCBwYXRo
bmFtZSIpLA0KPiA+ICAJT1BUX0JPT0xFQU4oJ20nLCAibW9kdWxlcyIsICZzeW1ib2xfY29uZi51
c2VfbW9kdWxlcywNCj4gPiAgCQkgICAgImxvYWQgbW9kdWxlIHN5bWJvbHMgLSBXQVJOSU5HOiB1
c2Ugb25seSB3aXRoIC1rIGFuZCBMSVZFIGtlcm5lbCIpLA0KPiA+ICsJT1BUX0NBTExCQUNLKDAs
ICJ2ZHNvIiwgTlVMTCwgInZkc28xWyx2ZHNvMl0iLCAidmRzbyBwYXRobmFtZXMiLA0KPiA+ICsJ
CSAgICAgcGFyc2VfdmRzb19wYXRobmFtZXMpLA0KPiA+ICAJT1BUX0JPT0xFQU4oJ2wnLCAicHJp
bnQtbGluZSIsICZhbm5vdGF0ZV9vcHRzLnByaW50X2xpbmVzLA0KPiA+ICAJCSAgICAicHJpbnQg
bWF0Y2hpbmcgc291cmNlIGxpbmVzIChtYXkgYmUgc2xvdykiKSwNCj4gPiAgCU9QVF9CT09MRUFO
KCdQJywgImZ1bGwtcGF0aHMiLCAmYW5ub3RhdGVfb3B0cy5mdWxsX3BhdGgsDQo+IA0KPiA8U05J
UD4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9kaXNhc20uYyBiL3Rvb2xz
L3BlcmYvdXRpbC9kaXNhc20uYw0KPiA+IGluZGV4IGUxMDU1OGI3OTUwNC4uN2UyNmQ1MjE1NjQw
IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9kaXNhc20uYw0KPiA+ICsrKyBiL3Rv
b2xzL3BlcmYvdXRpbC9kaXNhc20uYw0KPiA+IEBAIC0xNiw2ICsxNiw3IEBADQo+ID4gICNpbmNs
dWRlICJkZWJ1Zy5oIg0KPiA+ICAjaW5jbHVkZSAiZGlzYXNtLmgiDQo+ID4gICNpbmNsdWRlICJk
c28uaCINCj4gPiArI2luY2x1ZGUgInZkc28uaCINCj4gPiAgI2luY2x1ZGUgImVudi5oIg0KPiA+
ICAjaW5jbHVkZSAiZXZzZWwuaCINCj4gPiAgI2luY2x1ZGUgIm1hcC5oIg0KPiA+IEBAIC0xMTI2
LDcgKzExMjcsNyBAQCBzdGF0aWMgaW50IGRzb19fZGlzYXNzZW1ibGVfZmlsZW5hbWUoc3RydWN0
IGRzbyAqZHNvLCBjaGFyICpmaWxlbmFtZSwgc2l6ZV90IGZpbA0KPiA+ICAJaWYgKHBvcyAmJiBz
dHJsZW4ocG9zKSA8IFNCVUlMRF9JRF9TSVpFIC0gMikNCj4gPiAgCQlkaXJuYW1lKGJ1aWxkX2lk
X3BhdGgpOw0KPiA+ICANCj4gPiAtCWlmIChkc29fX2lzX2tjb3JlKGRzbykpDQo+ID4gKwlpZiAo
ZHNvX19pc19rY29yZShkc28pIHx8IGRzb19faXNfdmRzbyhkc28pKQ0KPiANCj4gU29ycnkgZm9y
IHZlcnkgbG9uZyBkZWxheS4NCj4gDQo+IFRoaXMgcGF0Y2ggKHByb2JhYmx5IHRoaXMgYml0IGhl
cmUpIGJyZWFrcyBhbm5vdGF0aW9uIG9mIHZkc28uDQo+IFRvIGFsbG93IGZvciBiaXNlY3Rpb24s
IHlvdSBuZWVkIHRvIGFycmFuZ2UgY2hhbmdlcyBzbyB0aGF0IGVhY2gNCj4gcGF0Y2ggbGVhdmVz
IHRoaW5ncyBpbiBhIHdvcmtpbmcgc3RhdGUuDQo+IA0KPiBIb3dldmVyLCBJIGRpc2FncmVlIHdp
dGggYWRkaW5nIC0tdmRzbyBvcHRpb24gc2luY2Ugd2l0aCBqdXN0DQo+IHBhdGNoIDggYWxvbmUs
IGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIGRvOg0KPiANCj4gICBwZXJmIGJ1aWxkaWQtY2FjaGUg
LS1yZW1vdmUgL3dvcmsvbGludXgvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvNjQuc28uZGJnDQo+
ICAgcGVyZiBidWlsZGlkLWNhY2hlIC0tYWRkIC93b3JrL2xpbnV4L2FyY2gveDg2L2VudHJ5L3Zk
c28vdmRzbzY0LnNvLmRiZw0KPiANCj4gYW5kIHNhbWUgb2YgdmRzbzMyLg0KPiANCj4gVGhhdCB3
b3VsZCBsZWF2ZSB0aGUgYnVpbGRpZC1jYWNoZSBjb250YWluaW5nIG9ubHkgdGhlIGRlYnVnIHZl
cnNpb25zLA0KPiB3aGljaCB3b3VsZCBtZWFuIHlvdSB3aWxsIG9ubHkgZ2V0IHRoZSBkZWJ1ZyB2
ZXJzaW9ucywgYW5kIGl0IHdvdWxkIG9ubHkNCj4gbmVlZCB0byBiZSBkb25lIG9uY2UgcGVyIGtl
cm5lbCBpbnN0ZWFkIG9mIGhhdmluZyB0byBhZGQgLS12ZHNvIHRvDQo+IGV2ZXJ5IHBlcmYgY29t
bWFuZC4NCj4NCg0KSSBtYXkgc2VuZCBwYXRjaCA4IGFsb25lIGZpcnN0IGFuZCBzdXNwZW5kIHRo
ZSByZXN0LiBJIHN1cHBvc2UgbWFuYW5naW5nIGJ1aWxkaWQtY2FjaGUNCmZvciB2ZHNvIG1hbm51
YWxseSBpcyBlbm91Z2ggZm9yIG1vc3QgY2FzZS4gU28gbWF5YmUgaXQncyBiZXR0ZXIgbm90IGdl
dCB0aGluZ3MNCm1vcmUgY29tcGxleC4NCg0KPiANCg0KLS0gDQpDaGVlcnMsDQpDaGFuZ2JpbiBE
dQ0K

