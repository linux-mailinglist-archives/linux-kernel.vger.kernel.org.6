Return-Path: <linux-kernel+bounces-234760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7A91CAAD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1660B2115D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE041BC39;
	Sat, 29 Jun 2024 02:32:59 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485518AEA;
	Sat, 29 Jun 2024 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719628379; cv=none; b=KpWegCiqDBaLmbXq4e09eYuplbgyQa5dcP7Sd0ejML81gCRGWGwg84sqE/XKUI66HIY1/NZd/pZvkZngzaCj7aa070NEyTJamOLdSJ7rBshSLf4AkSVOJ5B4zdZJ0ZOzv6VHPtJIhBkFHFUnulIY+WdBzchnZZQJ/n+SugO1zns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719628379; c=relaxed/simple;
	bh=S2SwpFlzAQq1YdY+vvPS8iRCEeDJ2+iYusLejfFmGR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRXn0RUN2SNodR0cFyo/Jsf3dKRzReVy6rc6lvvgph0YtI866uUWDgZfP+4KmYCFYNdi0mDvUDctVgO9fE2VX6l2uIAqNggM/XMXCNKJtOrBBivXMqHF6ZPlSDWAA2sGqYeQzvze/Gkin8QijXhM8D58Aq7lxnna5q9yiC2HSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W9x856tLWzMrJC;
	Sat, 29 Jun 2024 10:29:09 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EB16180087;
	Sat, 29 Jun 2024 10:32:53 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 29 Jun 2024 10:32:52 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Sat, 29 Jun 2024 10:32:52 +0800
From: duchangbin <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: duchangbin <changbin.du@huawei.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v4 1/5] perf: support specify vdso path in cmdline
Thread-Topic: [PATCH v4 1/5] perf: support specify vdso path in cmdline
Thread-Index: AQHaxrEVrjKiye8CdEijfxK9i0rUjrHX8X6AgAFhooCAAAG7AIACcgQAgADRDICAAFWcgIABHkeA
Date: Sat, 29 Jun 2024 02:32:52 +0000
Message-ID: <88e192fb4b82454bbb008b65be94ffae@huawei.com>
References: <20240625033740.223009-1-changbin.du@huawei.com>
 <20240625033740.223009-2-changbin.du@huawei.com>
 <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
 <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
 <05f95eb8-9b4c-4327-a97f-a15654278c41@intel.com>
 <Zn37bj4LER_A1bX1@google.com> <1599b5defa46422eb66885e7430cc70f@huawei.com>
 <18d0ae92-d764-4151-a2d6-f017b22b4c92@intel.com>
In-Reply-To: <18d0ae92-d764-4151-a2d6-f017b22b4c92@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0649849058B3A49ADFC135019D595DD@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCBKdW4gMjgsIDIwMjQgYXQgMDg6Mjc6NTVQTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3
cm90ZToNCj4gT24gMjgvMDYvMjQgMDc6MjEsIGR1Y2hhbmdiaW4gd3JvdGU6DQo+ID4gT24gVGh1
LCBKdW4gMjcsIDIwMjQgYXQgMDQ6NTM6MThQTSAtMDcwMCwgTmFtaHl1bmcgS2ltIHdyb3RlOg0K
PiA+PiBIZWxsbyBndXlzLA0KPiA+Pg0KPiA+PiBPbiBXZWQsIEp1biAyNiwgMjAyNCBhdCAwMToz
Mjo0MlBNICswMzAwLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+Pj4gT24gMjYvMDYvMjQgMDU6
MjYsIGR1Y2hhbmdiaW4gd3JvdGU6DQo+ID4+Pj4gT24gVHVlLCBKdW4gMjUsIDIwMjQgYXQgMDQ6
MjA6NDlQTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3cm90ZToNCj4gPj4+Pj4gT24gMjUvMDYvMjQg
MDY6MzcsIENoYW5nYmluIER1IHdyb3RlOg0KPiA+Pj4+Pj4gVGhlIHZkc28gZHVtcGVkIGZyb20g
cHJvY2VzcyBtZW1vcnkgKGluIGJ1aWxkaWQtY2FjaGUpIGxhY2tzIGRlYnVnZ2luZw0KPiA+Pj4+
Pj4gaW5mby4gVG8gYW5ub3RhdGUgdmRzbyBzeW1ib2xzIHdpdGggc291cmNlIGxpbmVzIHdlIG5l
ZWQgc3BlY2lmeSBhDQo+ID4+Pj4+PiBkZWJ1Z2dpbmcgdmVyc2lvbi4NCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBGb3IgeDg2LCB3ZSBjYW4gZmluZCB0aGVtIGZyb20geW91ciBsb2NhbCBidWlsZCBhcw0K
PiA+Pj4+Pj4gYXJjaC94ODYvZW50cnkvdmRzby92ZHNvezMyLDY0fS5zby5kYmcuIE9yIHRoZXkg
bWF5IHJlc2lkZSBpbg0KPiA+Pj4+Pj4gL2xpYi9tb2R1bGVzLzx2ZXJzaW9uPi92ZHNvL3Zkc297
MzIsNjR9LnNvIG9uIFVidW50dS4gQnV0IG5vdGljZSB0aGF0DQo+ID4+Pj4+PiB0aGUgYnVpbGRp
ZCBoYXMgdG8gbWF0Y2guDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gJCBzdWRvIHBlcmYgcmVjb3JkIC1h
DQo+ID4+Pj4+PiAkIHN1ZG8gcGVyZiByZXBvcnQgLS1vYmpkdW1wPWxsdm0tb2JqZHVtcCBcDQo+
ID4+Pj4+PiAgIC0tdmRzbyBhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc282NC5zby5kYmcsYXJjaC94
ODYvZW50cnkvdmRzby92ZHNvMzIuc28uZGJnDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gU2FtcGxlczog
MTdLIG9mIGV2ZW50ICdjeWNsZXM6UCcsIDQwMDAgSHosIEV2ZW50IGNvdW50IChhcHByb3guKTog
MTc2MA0KPiA+Pj4+Pj4gX192ZHNvX2Nsb2NrX2dldHRpbWUgIC93b3JrL2xpbnV4LWhvc3QvYXJj
aC94ODYvZW50cnkvdmRzby92ZHNvNjQuc28uZA0KPiA+Pj4+Pj4gUGVyY2VudOKUgiAgICAgICBt
b3ZxICAgIC00OCglcmJwKSwlcnNpDQo+ID4+Pj4+PiAgICAgICAg4pSCICAgICAgIHRlc3RxICAg
JXJheCwlcmF4DQo+ID4+Pj4+PiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAgICAgcmV0dXJu
IHZyZWFkX2h2Y2xvY2soKTsNCj4gPj4+Pj4+ICAgICAgICDilIIgICAgICAgbW92cSAgICAlcmF4
LCVyZHgNCj4gPj4+Pj4+ICAgICAgICDilIIgICAgIDsgICAgICAgICAgICAgICBpZiAodW5saWtl
bHkoIXZkc29fY3ljbGVzX29rKGN5Y2xlcykpKQ0KPiA+Pj4+Pj4gICAgICAgIOKUgiAgICAg4oaR
IGpzICAgICAgZWINCj4gPj4+Pj4+ICAgICAgICDilIIgICAgIOKGkSBqbXAgICAgIDc0DQo+ID4+
Pj4+PiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAgICAgdHMtPnR2X3NlYyA9IHZkc29fdHMt
PnNlYzsNCj4gPj4+Pj4+ICAgMC4wMiDilIIxNDc6ICAgbGVhcSAgICAyKCVyYngpLCVyYXgNCj4g
Pj4+Pj4+ICAgICAgICDilIIgICAgICAgc2hscSAgICAkNCwgJXJheA0KPiA+Pj4+Pj4gICAgICAg
IOKUgiAgICAgICBhZGRxICAgICVyMTAsJXJheA0KPiA+Pj4+Pj4gICAgICAgIOKUgiAgICAgOyAg
ICAgICAgICAgICAgIHdoaWxlICgoc2VxID0gUkVBRF9PTkNFKHZkLT5zZXEpKSAmIDEpIHsNCj4g
Pj4+Pj4+ICAgOS4zOCDilIIxNTI6ICAgbW92bCAgICAoJXIxMCksJWVjeA0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+IFdoZW4gZG9pbmcgY3Jvc3MgcGxhdGZvcm0gYW5hbHlzaXMsIHdlIGFsc28gbmVlZCBz
cGVjaWZ5IHRoZSB2ZHNvIHBhdGggaWYNCj4gPj4+Pj4+IHdlIGFyZSBpbnRlcmVzdGVkIGluIGl0
cyBzeW1ib2xzLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBhZGQg
dmRzbyBhbmQgdmRzbyBkZWJ1ZyB0byB0aGUgYnVpbGQtaWQNCj4gPj4+Pj4gY2FjaGUgYW5kIGVu
c3VyZSBwZXJmIGNhbiBmaW5kIGl0IHRoZXJlPw0KPiA+Pj4+Pg0KPiA+Pj4+PiBUeXBpY2FsbHks
IGdldHRpbmcgZHNvcyBmcm9tIGFub3RoZXIgbWFjaGluZSBpcyBoYW5kbGVkIHZpYQ0KPiA+Pj4+
PiBidWlsZC1pZCBjYWNoZSBlLmcuIHdoYXQgcGVyZi1hcmNoaXZlIGRvZXMNCj4gPj4+Pj4NCj4g
Pj4+PiBIbW0uIEkgYWdyZWUgdGhpcyBpcyBiZXR0ZXIgYWx0ZXJuYXRpdmUgYXBwcm9hY2ggZm9y
IGNyb3NzLW1hY2hpbmUgYW5hbHlzaXMuDQo+ID4+Pj4gV2hlbiBjb2xsZWN0aW5nIHZkc29zIHRv
IGJ1aWxkaWQgY2FjaGUsIEkgdGhpbmsgd2UgY2FuIHVzZSB0aGUgbG9jYWwgc2VhcmNoZWQNCj4g
Pj4+PiBvYmplY3RzICh3aXRoIGRlYnVnIHN5bWJvbHMpIGluc3RlYWQgaWYgaXRzIGJ1aWxkLWlk
IG1hdGNoZXMgdmRzb3MgZnJvbSBwcm9jZXNzDQo+ID4+Pj4gZHVtcGluZyAodGhlIHJlYWwgY29k
ZSByYW4pLg0KPiA+Pj4+DQo+ID4+Pj4gQ3VycmVudGx5IEkganVzdCBmb2xsb3cgd2hhdCBwZXJm
IGRvZXMgZm9yIHZtbGludXggc28gdG8gcmV1c2UgbW9zdCBvZiBleGlzdGluZw0KPiA+Pj4+IGNv
ZGUuIE1heWJlIHZtbGludXggaXMgdG9vIGJpZyB0byBhZGQgdG8gYnVpbGRpZC1jYWhjZT8NCj4g
Pj4+Pg0KPiA+Pj4+IENhbiB3ZSBrZWVwIG91ciBjdXJyZW50IHN0cmF0ZWd5IGZvciBub3c/IEkn
bGwgdGhpbmsgYWJvdXQgYWJvdmUgb3B0aW9ucyB3aGVuDQo+ID4+Pj4gSSBoYXZlIG1vcmUgdGlt
ZS4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEkgdHJpZWQgYWRkaW5nIHZkc28gdmlhIHBlcmYgYnVp
bGRpZC1jYWNoZS4gIEl0IGRvZXNuJ3Qgd29yayBvbmx5DQo+ID4+PiBiZWNhdXNlIHRoZSBsb29r
dXAgZXhwZWN0cyB0aGUgYmFzZW5hbWUgdG8gYmUgInZkc28iIGJ1dCBpdCBpcw0KPiA+Pj4gImVs
ZiIuDQo+ID4+Pg0KPiA+Pj4gQWRkaW5nIGEgbGluayBmcm9tICJ2ZHNvIiB0byAiZWxmIiBtYWRl
IGl0IHdvcmsgZS5nLg0KPiA+Pj4NCj4gPj4+ICQgY2F0IGdldHRpbWVvZmRheS10ZXN0LmMNCj4g
Pj4+ICNpbmNsdWRlIDxzdGRpby5oPg0KPiA+Pj4gI2luY2x1ZGUgPHN5cy90aW1lLmg+DQo+ID4+
Pg0KPiA+Pj4gaW50IG1haW4oKQ0KPiA+Pj4gew0KPiA+Pj4gICAgICAgICBzdHJ1Y3QgdGltZXZh
bCB0djsNCj4gPj4+ICAgICAgICAgaW50IHJldDsNCj4gPj4+DQo+ID4+PiAgICAgICAgIHJldCA9
IGdldHRpbWVvZmRheSgmdHYsIE5VTEwpOw0KPiA+Pj4gICAgICAgICBpZiAocmV0ID09IC0xKSB7
DQo+ID4+PiAgICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJnZXR0aW1lb2ZkYXkgZmFp
bGVkXG4iKTsNCj4gPj4+ICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gPj4+ICAgICAgICAg
fQ0KPiA+Pj4NCj4gPj4+ICAgICAgICAgcHJpbnRmKCIlbHUuJWx1XG4iLCAodW5zaWduZWQgbG9u
Zyl0di50dl9zZWMsICh1bnNpZ25lZCBsb25nKXR2LnR2X3VzZWMpOw0KPiA+Pj4NCj4gPj4+ICAg
ICAgICAgcmV0dXJuIDA7DQo+ID4+PiAkIHBlcmYgcmVjb3JkIC1lIGludGVsX3B0Ly91IC4vZ2V0
dGltZW9mZGF5LXRlc3QNCj4gPj4+IDE3MTkzOTcwNDIuODkyODM3DQo+ID4+PiBbIHBlcmYgcmVj
b3JkOiBXb2tlbiB1cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXQ0KPiA+Pj4gWyBwZXJmIHJlY29y
ZDogQ2FwdHVyZWQgYW5kIHdyb3RlIDAuMDI2IE1CIHBlcmYuZGF0YSBdDQo+ID4+PiAkIHBlcmYg
c2NyaXB0IC0taXRyYWNlPWUNCj4gPj4+ICQgcGVyZiBidWlsZGlkLWNhY2hlIC0tcmVtb3ZlIC9s
aWIvbW9kdWxlcy82LjUuMC00MS1nZW5lcmljL3Zkc28vdmRzbzY0LnNvDQo+ID4+PiAkIHBlcmYg
c2NyaXB0IC0taXRyYWNlPWUNCj4gPj4+IFdhcm5pbmc6DQo+ID4+PiAyIGluc3RydWN0aW9uIHRy
YWNlIGVycm9ycw0KPiA+Pj4gIGluc3RydWN0aW9uIHRyYWNlIGVycm9yIHR5cGUgMSB0aW1lIDUy
NTM0NS4zODY0MjQyMDQgY3B1IDQgcGlkIDE5ODk3NiB0aWQgMTk4OTc2IGlwIDB4N2ZmZGRiMGU4
ZTAwIGNvZGUgNTogRmFpbGVkIHRvIGdldCBpbnN0cnVjdGlvbg0KPiA+Pj4gIGluc3RydWN0aW9u
IHRyYWNlIGVycm9yIHR5cGUgMSB0aW1lIDUyNTM0NS4zODY0MjQ4MjkgY3B1IDQgcGlkIDE5ODk3
NiB0aWQgMTk4OTc2IGlwIDB4N2ZmZGRiMGU4ODRkIGNvZGUgNTogRmFpbGVkIHRvIGdldCBpbnN0
cnVjdGlvbg0KPiA+Pj4gJCBwZXJmIGJ1aWxkaWQtY2FjaGUgLS1hZGQgL2xpYi9tb2R1bGVzLzYu
NS4wLTQxLWdlbmVyaWMvdmRzby92ZHNvNjQuc28NCj4gPj4+ICQgcGVyZiBzY3JpcHQgLS1pdHJh
Y2U9ZQ0KPiA+Pj4gV2FybmluZzoNCj4gPj4+IDIgaW5zdHJ1Y3Rpb24gdHJhY2UgZXJyb3JzDQo+
ID4+PiAgaW5zdHJ1Y3Rpb24gdHJhY2UgZXJyb3IgdHlwZSAxIHRpbWUgNTI1MzQ1LjM4NjQyNDIw
NCBjcHUgNCBwaWQgMTk4OTc2IHRpZCAxOTg5NzYgaXAgMHg3ZmZkZGIwZThlMDAgY29kZSA1OiBG
YWlsZWQgdG8gZ2V0IGluc3RydWN0aW9uDQo+ID4+PiAgaW5zdHJ1Y3Rpb24gdHJhY2UgZXJyb3Ig
dHlwZSAxIHRpbWUgNTI1MzQ1LjM4NjQyNDgyOSBjcHUgNCBwaWQgMTk4OTc2IHRpZCAxOTg5NzYg
aXAgMHg3ZmZkZGIwZTg4NGQgY29kZSA1OiBGYWlsZWQgdG8gZ2V0IGluc3RydWN0aW9uDQo+ID4+
PiAkIGNkIH4vLmRlYnVnLy5idWlsZC1pZC9jMy81MzBhZWQ2NmU3MWJmZDEwYWY2NjAzOWY1OGNj
N2M0ZDJlYWJhOA0KPiA+Pj4gfi8uZGVidWcvLmJ1aWxkLWlkL2MzLzUzMGFlZDY2ZTcxYmZkMTBh
ZjY2MDM5ZjU4Y2M3YzRkMmVhYmE4JCBsbiAtcyBlbGYgdmRzbw0KPiA+Pj4gfi8uZGVidWcvLmJ1
aWxkLWlkL2MzLzUzMGFlZDY2ZTcxYmZkMTBhZjY2MDM5ZjU4Y2M3YzRkMmVhYmE4JCBscyAtbA0K
PiA+Pj4gdG90YWwgMzYNCj4gPj4+IC1ydy1yLS1yLS0gMSBhaHVudGVyIGFodW50ZXIgMzMyNzIg
SnVuIDI2IDEzOjE3IGVsZg0KPiA+Pj4gLXJ3LXItLS0tLSAxIGFodW50ZXIgYWh1bnRlciAgICAg
MCBKdW4gMjYgMTM6MTcgcHJvYmVzDQo+ID4+PiBscnd4cnd4cnd4IDEgYWh1bnRlciBhaHVudGVy
ICAgICAzIEp1biAyNiAxMzoxOCB2ZHNvIC0+IGVsZg0KPiA+Pj4gLy5kZWJ1Zy8uYnVpbGQtaWQv
YzMvNTMwYWVkNjZlNzFiZmQxMGFmNjYwMzlmNThjYzdjNGQyZWFiYTgkIGNkDQo+ID4+PiAkIHBl
cmYgc2NyaXB0IC0taXRyYWNlPWUNCj4gPj4+ICQgDQo+ID4+Pg0KPiA+Pj4gU28gbWF5YmUgYSBj
aGFuZ2UgY291bGQgYmUgbWFkZSB0byBidWlsZF9pZF9jYWNoZV9fYWRkKCkgdG8gYWRkDQo+ID4+
PiB0aGUgZXh0cmEgbGluayBpZiB0aGUgZmlsZSBuYW1lIG1hdGNoZXMgdmRzbw0KPiA+PiAgDQo+
ID4+IFRoYW5rcyBmb3IgZG9pbmcgdGhpcyEgIEkgbm90aWNlZCBidWlsZGlkX2NhY2hlX19iYXNl
bmFtZSgpIHdpbGwgaGFuZGxlDQo+ID4+IHRoZSBuYW1lIHByb3Blcmx5IG9uY2UgaXQgcmVhbGl6
ZXMgdGhlIGZpbGUgaXMgYSB2ZHNvLiAgTWF5YmUgd2UgY2FuDQo+ID4+IGNoZWNrIHRoZSBmaWxl
cGF0aCB3aXRoIHNvbWUgcGF0dGVybnMsIG9yIHNpbXBseSBhZGQgYW4gY29tbWFuZCBsaW5lDQo+
ID4+IG9wdGlvbiB0byBzYXkgaXQncyBhIHZkc28uDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4g
TmFtaHl1bmcNCj4gPj4NCj4gPiBJIGFkZGVkIHNvbWUgdHJpY2tzIGZvciB2ZHNvIGluIGJ1aWxk
X2lkX2NhY2hlX19hZGQoKS4gSXQgcmVwbGFjZSB2ZHNvIG9iamVjdA0KPiA+IHdpdGggZGVidWdn
aW5nIG9uZSBpZiBmb3VuZC4gSXMgdGhpcyBva2F5Pw0KPiANCj4gcGVyZiBoYXMgc3VwcG9ydCBm
b3Igc3RvcmluZyBkZWJ1ZyBmaWxlcyBpbiB0aGUgYnVpbGQtaWQNCj4gY2FjaGUgdXNpbmcgdGhl
IGJhc2UgbmFtZSAiZGVidWciIGluc3RlYWQgb2YgImVsZiIsIHNvIHJlYWxseQ0KPiBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gbWFrZSB0aGF0IHdvcmsNCj4NCk15IHRob3VnaHRzIGFyZToNCiAgMS4g
YWRkIGRlYnVnZ2luZyB2ZHNvIGZpbGUgYXMgImRlYnVnIiBpbiBidWlsZGlkIGNhY2hlLg0KICAy
LiBhZGQgYSBuZXcgcGVyZiBjb25maWcgaXRlbSAnYW5ub3RhdGUucHJlZmVyX2RlYnVnX2ZpbGUn
IChkZWZhdWx0IGZhbHNlKSB0bw0KICAgICBhbm5vdGF0ZSB3aXRoIGRlYnVnZ2luZyBvYmplY3Qg
ZmlsZXMuDQoNCi0tIA0KQ2hlZXJzLA0KQ2hhbmdiaW4gRHUNCg==

