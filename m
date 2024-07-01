Return-Path: <linux-kernel+bounces-235520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9B91D610
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81F21F218F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9751125C1;
	Mon,  1 Jul 2024 02:30:22 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09E3D62;
	Mon,  1 Jul 2024 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801022; cv=none; b=m38Dnf1aC3/OtTp/A+lDosIkrO+xHW4I9WERwiy9JeJ/1YaP8X+B8lxV/zsm7p6XdQJpR0eqcBa1Z+8ubclMvvinueojdNrm6HzBaNe29KEQcx6BwXRLDJkNxMNUgPs6fjf7kG3fmj/hDa4IyZUMeNCqpMCA1zq22s7Rx4b9S/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801022; c=relaxed/simple;
	bh=qrlXGefNSwJ6CnsqN4vISC6TiT0BaEznj7czWXAoTNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pCiziHRBBig7VNPIvFdFYEncKZlxOb0I1m7xJIK3RTmP2IKZNp5JCt/mJ5khWK2QiXE2HVMQtslvJi5kJgK0vUqY5xCychHnSmtaZJhkUf7aE4x2lkeg45kpnQ8z9kLEBR9giIgaMzSTzrEHctq2a6C97hVxbXK8WpVpwbKZB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WC92Z4hh5z1xt9K;
	Mon,  1 Jul 2024 10:28:38 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 410161402CC;
	Mon,  1 Jul 2024 10:30:10 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 1 Jul 2024 10:30:09 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Mon, 1 Jul 2024 10:30:09 +0800
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
Thread-Index: AQHaxrEVrjKiye8CdEijfxK9i0rUjrHX8X6AgAFhooCAAAG7AIACcgQAgADRDICAAFWcgIABHkeAgACKMgCAApm2AA==
Date: Mon, 1 Jul 2024 02:30:09 +0000
Message-ID: <ce5e2367c7e2401db6bd71843f4608ab@huawei.com>
References: <20240625033740.223009-1-changbin.du@huawei.com>
 <20240625033740.223009-2-changbin.du@huawei.com>
 <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
 <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
 <05f95eb8-9b4c-4327-a97f-a15654278c41@intel.com>
 <Zn37bj4LER_A1bX1@google.com> <1599b5defa46422eb66885e7430cc70f@huawei.com>
 <18d0ae92-d764-4151-a2d6-f017b22b4c92@intel.com>
 <88e192fb4b82454bbb008b65be94ffae@huawei.com>
 <d7b48d48-1bea-4dec-bf04-ed65602f4c4a@intel.com>
In-Reply-To: <d7b48d48-1bea-4dec-bf04-ed65602f4c4a@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <7702C0ECB6C378449F98437C28D36326@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU2F0LCBKdW4gMjksIDIwMjQgYXQgMDk6NDc6MTBQTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3
cm90ZToNCj4gT24gMjkvMDYvMjQgMDU6MzIsIGR1Y2hhbmdiaW4gd3JvdGU6DQo+ID4gT24gRnJp
LCBKdW4gMjgsIDIwMjQgYXQgMDg6Mjc6NTVQTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3cm90ZToN
Cj4gPj4gT24gMjgvMDYvMjQgMDc6MjEsIGR1Y2hhbmdiaW4gd3JvdGU6DQo+ID4+PiBPbiBUaHUs
IEp1biAyNywgMjAyNCBhdCAwNDo1MzoxOFBNIC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
ID4+Pj4gSGVsbG8gZ3V5cywNCj4gPj4+Pg0KPiA+Pj4+IE9uIFdlZCwgSnVuIDI2LCAyMDI0IGF0
IDAxOjMyOjQyUE0gKzAzMDAsIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+ID4+Pj4+IE9uIDI2LzA2
LzI0IDA1OjI2LCBkdWNoYW5nYmluIHdyb3RlOg0KPiA+Pj4+Pj4gT24gVHVlLCBKdW4gMjUsIDIw
MjQgYXQgMDQ6MjA6NDlQTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3cm90ZToNCj4gPj4+Pj4+PiBP
biAyNS8wNi8yNCAwNjozNywgQ2hhbmdiaW4gRHUgd3JvdGU6DQo+ID4+Pj4+Pj4+IFRoZSB2ZHNv
IGR1bXBlZCBmcm9tIHByb2Nlc3MgbWVtb3J5IChpbiBidWlsZGlkLWNhY2hlKSBsYWNrcyBkZWJ1
Z2dpbmcNCj4gPj4+Pj4+Pj4gaW5mby4gVG8gYW5ub3RhdGUgdmRzbyBzeW1ib2xzIHdpdGggc291
cmNlIGxpbmVzIHdlIG5lZWQgc3BlY2lmeSBhDQo+ID4+Pj4+Pj4+IGRlYnVnZ2luZyB2ZXJzaW9u
Lg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBGb3IgeDg2LCB3ZSBjYW4gZmluZCB0aGVtIGZyb20g
eW91ciBsb2NhbCBidWlsZCBhcw0KPiA+Pj4+Pj4+PiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc297
MzIsNjR9LnNvLmRiZy4gT3IgdGhleSBtYXkgcmVzaWRlIGluDQo+ID4+Pj4+Pj4+IC9saWIvbW9k
dWxlcy88dmVyc2lvbj4vdmRzby92ZHNvezMyLDY0fS5zbyBvbiBVYnVudHUuIEJ1dCBub3RpY2Ug
dGhhdA0KPiA+Pj4+Pj4+PiB0aGUgYnVpbGRpZCBoYXMgdG8gbWF0Y2guDQo+ID4+Pj4+Pj4+DQo+
ID4+Pj4+Pj4+ICQgc3VkbyBwZXJmIHJlY29yZCAtYQ0KPiA+Pj4+Pj4+PiAkIHN1ZG8gcGVyZiBy
ZXBvcnQgLS1vYmpkdW1wPWxsdm0tb2JqZHVtcCBcDQo+ID4+Pj4+Pj4+ICAgLS12ZHNvIGFyY2gv
eDg2L2VudHJ5L3Zkc28vdmRzbzY0LnNvLmRiZyxhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi5z
by5kYmcNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gU2FtcGxlczogMTdLIG9mIGV2ZW50ICdjeWNs
ZXM6UCcsIDQwMDAgSHosIEV2ZW50IGNvdW50IChhcHByb3guKTogMTc2MA0KPiA+Pj4+Pj4+PiBf
X3Zkc29fY2xvY2tfZ2V0dGltZSAgL3dvcmsvbGludXgtaG9zdC9hcmNoL3g4Ni9lbnRyeS92ZHNv
L3Zkc282NC5zby5kDQo+ID4+Pj4+Pj4+IFBlcmNlbnTilIIgICAgICAgbW92cSAgICAtNDgoJXJi
cCksJXJzaQ0KPiA+Pj4+Pj4+PiAgICAgICAg4pSCICAgICAgIHRlc3RxICAgJXJheCwlcmF4DQo+
ID4+Pj4+Pj4+ICAgICAgICDilIIgICAgIDsgICAgICAgICAgICAgICByZXR1cm4gdnJlYWRfaHZj
bG9jaygpOw0KPiA+Pj4+Pj4+PiAgICAgICAg4pSCICAgICAgIG1vdnEgICAgJXJheCwlcmR4DQo+
ID4+Pj4+Pj4+ICAgICAgICDilIIgICAgIDsgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIXZk
c29fY3ljbGVzX29rKGN5Y2xlcykpKQ0KPiA+Pj4+Pj4+PiAgICAgICAg4pSCICAgICDihpEganMg
ICAgICBlYg0KPiA+Pj4+Pj4+PiAgICAgICAg4pSCICAgICDihpEgam1wICAgICA3NA0KPiA+Pj4+
Pj4+PiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAgICAgdHMtPnR2X3NlYyA9IHZkc29fdHMt
PnNlYzsNCj4gPj4+Pj4+Pj4gICAwLjAyIOKUgjE0NzogICBsZWFxICAgIDIoJXJieCksJXJheA0K
PiA+Pj4+Pj4+PiAgICAgICAg4pSCICAgICAgIHNobHEgICAgJDQsICVyYXgNCj4gPj4+Pj4+Pj4g
ICAgICAgIOKUgiAgICAgICBhZGRxICAgICVyMTAsJXJheA0KPiA+Pj4+Pj4+PiAgICAgICAg4pSC
ICAgICA7ICAgICAgICAgICAgICAgd2hpbGUgKChzZXEgPSBSRUFEX09OQ0UodmQtPnNlcSkpICYg
MSkgew0KPiA+Pj4+Pj4+PiAgIDkuMzgg4pSCMTUyOiAgIG1vdmwgICAgKCVyMTApLCVlY3gNCj4g
Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gV2hlbiBkb2luZyBjcm9zcyBwbGF0Zm9ybSBhbmFseXNpcywg
d2UgYWxzbyBuZWVkIHNwZWNpZnkgdGhlIHZkc28gcGF0aCBpZg0KPiA+Pj4+Pj4+PiB3ZSBhcmUg
aW50ZXJlc3RlZCBpbiBpdHMgc3ltYm9scy4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFdvdWxkIGl0
IGJlIHBvc3NpYmxlIHRvIGFkZCB2ZHNvIGFuZCB2ZHNvIGRlYnVnIHRvIHRoZSBidWlsZC1pZA0K
PiA+Pj4+Pj4+IGNhY2hlIGFuZCBlbnN1cmUgcGVyZiBjYW4gZmluZCBpdCB0aGVyZT8NCj4gPj4+
Pj4+Pg0KPiA+Pj4+Pj4+IFR5cGljYWxseSwgZ2V0dGluZyBkc29zIGZyb20gYW5vdGhlciBtYWNo
aW5lIGlzIGhhbmRsZWQgdmlhDQo+ID4+Pj4+Pj4gYnVpbGQtaWQgY2FjaGUgZS5nLiB3aGF0IHBl
cmYtYXJjaGl2ZSBkb2VzDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+IEhtbS4gSSBhZ3JlZSB0aGlzIGlz
IGJldHRlciBhbHRlcm5hdGl2ZSBhcHByb2FjaCBmb3IgY3Jvc3MtbWFjaGluZSBhbmFseXNpcy4N
Cj4gPj4+Pj4+IFdoZW4gY29sbGVjdGluZyB2ZHNvcyB0byBidWlsZGlkIGNhY2hlLCBJIHRoaW5r
IHdlIGNhbiB1c2UgdGhlIGxvY2FsIHNlYXJjaGVkDQo+ID4+Pj4+PiBvYmplY3RzICh3aXRoIGRl
YnVnIHN5bWJvbHMpIGluc3RlYWQgaWYgaXRzIGJ1aWxkLWlkIG1hdGNoZXMgdmRzb3MgZnJvbSBw
cm9jZXNzDQo+ID4+Pj4+PiBkdW1waW5nICh0aGUgcmVhbCBjb2RlIHJhbikuDQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gQ3VycmVudGx5IEkganVzdCBmb2xsb3cgd2hhdCBwZXJmIGRvZXMgZm9yIHZtbGlu
dXggc28gdG8gcmV1c2UgbW9zdCBvZiBleGlzdGluZw0KPiA+Pj4+Pj4gY29kZS4gTWF5YmUgdm1s
aW51eCBpcyB0b28gYmlnIHRvIGFkZCB0byBidWlsZGlkLWNhaGNlPw0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+IENhbiB3ZSBrZWVwIG91ciBjdXJyZW50IHN0cmF0ZWd5IGZvciBub3c/IEknbGwgdGhpbmsg
YWJvdXQgYWJvdmUgb3B0aW9ucyB3aGVuDQo+ID4+Pj4+PiBJIGhhdmUgbW9yZSB0aW1lLg0KPiA+
Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSB0cmllZCBhZGRpbmcgdmRzbyB2aWEgcGVyZiBidWls
ZGlkLWNhY2hlLiAgSXQgZG9lc24ndCB3b3JrIG9ubHkNCj4gPj4+Pj4gYmVjYXVzZSB0aGUgbG9v
a3VwIGV4cGVjdHMgdGhlIGJhc2VuYW1lIHRvIGJlICJ2ZHNvIiBidXQgaXQgaXMNCj4gPj4+Pj4g
ImVsZiIuDQo+ID4+Pj4+DQo+ID4+Pj4+IEFkZGluZyBhIGxpbmsgZnJvbSAidmRzbyIgdG8gImVs
ZiIgbWFkZSBpdCB3b3JrIGUuZy4NCj4gPj4+Pj4NCj4gPj4+Pj4gJCBjYXQgZ2V0dGltZW9mZGF5
LXRlc3QuYw0KPiA+Pj4+PiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4gPj4+Pj4gI2luY2x1ZGUgPHN5
cy90aW1lLmg+DQo+ID4+Pj4+DQo+ID4+Pj4+IGludCBtYWluKCkNCj4gPj4+Pj4gew0KPiA+Pj4+
PiAgICAgICAgIHN0cnVjdCB0aW1ldmFsIHR2Ow0KPiA+Pj4+PiAgICAgICAgIGludCByZXQ7DQo+
ID4+Pj4+DQo+ID4+Pj4+ICAgICAgICAgcmV0ID0gZ2V0dGltZW9mZGF5KCZ0diwgTlVMTCk7DQo+
ID4+Pj4+ICAgICAgICAgaWYgKHJldCA9PSAtMSkgew0KPiA+Pj4+PiAgICAgICAgICAgICAgICAg
ZnByaW50ZihzdGRlcnIsICJnZXR0aW1lb2ZkYXkgZmFpbGVkXG4iKTsNCj4gPj4+Pj4gICAgICAg
ICAgICAgICAgIHJldHVybiAxOw0KPiA+Pj4+PiAgICAgICAgIH0NCj4gPj4+Pj4NCj4gPj4+Pj4g
ICAgICAgICBwcmludGYoIiVsdS4lbHVcbiIsICh1bnNpZ25lZCBsb25nKXR2LnR2X3NlYywgKHVu
c2lnbmVkIGxvbmcpdHYudHZfdXNlYyk7DQo+ID4+Pj4+DQo+ID4+Pj4+ICAgICAgICAgcmV0dXJu
IDA7DQo+ID4+Pj4+ICQgcGVyZiByZWNvcmQgLWUgaW50ZWxfcHQvL3UgLi9nZXR0aW1lb2ZkYXkt
dGVzdA0KPiA+Pj4+PiAxNzE5Mzk3MDQyLjg5MjgzNw0KPiA+Pj4+PiBbIHBlcmYgcmVjb3JkOiBX
b2tlbiB1cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXQ0KPiA+Pj4+PiBbIHBlcmYgcmVjb3JkOiBD
YXB0dXJlZCBhbmQgd3JvdGUgMC4wMjYgTUIgcGVyZi5kYXRhIF0NCj4gPj4+Pj4gJCBwZXJmIHNj
cmlwdCAtLWl0cmFjZT1lDQo+ID4+Pj4+ICQgcGVyZiBidWlsZGlkLWNhY2hlIC0tcmVtb3ZlIC9s
aWIvbW9kdWxlcy82LjUuMC00MS1nZW5lcmljL3Zkc28vdmRzbzY0LnNvDQo+ID4+Pj4+ICQgcGVy
ZiBzY3JpcHQgLS1pdHJhY2U9ZQ0KPiA+Pj4+PiBXYXJuaW5nOg0KPiA+Pj4+PiAyIGluc3RydWN0
aW9uIHRyYWNlIGVycm9ycw0KPiA+Pj4+PiAgaW5zdHJ1Y3Rpb24gdHJhY2UgZXJyb3IgdHlwZSAx
IHRpbWUgNTI1MzQ1LjM4NjQyNDIwNCBjcHUgNCBwaWQgMTk4OTc2IHRpZCAxOTg5NzYgaXAgMHg3
ZmZkZGIwZThlMDAgY29kZSA1OiBGYWlsZWQgdG8gZ2V0IGluc3RydWN0aW9uDQo+ID4+Pj4+ICBp
bnN0cnVjdGlvbiB0cmFjZSBlcnJvciB0eXBlIDEgdGltZSA1MjUzNDUuMzg2NDI0ODI5IGNwdSA0
IHBpZCAxOTg5NzYgdGlkIDE5ODk3NiBpcCAweDdmZmRkYjBlODg0ZCBjb2RlIDU6IEZhaWxlZCB0
byBnZXQgaW5zdHJ1Y3Rpb24NCj4gPj4+Pj4gJCBwZXJmIGJ1aWxkaWQtY2FjaGUgLS1hZGQgL2xp
Yi9tb2R1bGVzLzYuNS4wLTQxLWdlbmVyaWMvdmRzby92ZHNvNjQuc28NCj4gPj4+Pj4gJCBwZXJm
IHNjcmlwdCAtLWl0cmFjZT1lDQo+ID4+Pj4+IFdhcm5pbmc6DQo+ID4+Pj4+IDIgaW5zdHJ1Y3Rp
b24gdHJhY2UgZXJyb3JzDQo+ID4+Pj4+ICBpbnN0cnVjdGlvbiB0cmFjZSBlcnJvciB0eXBlIDEg
dGltZSA1MjUzNDUuMzg2NDI0MjA0IGNwdSA0IHBpZCAxOTg5NzYgdGlkIDE5ODk3NiBpcCAweDdm
ZmRkYjBlOGUwMCBjb2RlIDU6IEZhaWxlZCB0byBnZXQgaW5zdHJ1Y3Rpb24NCj4gPj4+Pj4gIGlu
c3RydWN0aW9uIHRyYWNlIGVycm9yIHR5cGUgMSB0aW1lIDUyNTM0NS4zODY0MjQ4MjkgY3B1IDQg
cGlkIDE5ODk3NiB0aWQgMTk4OTc2IGlwIDB4N2ZmZGRiMGU4ODRkIGNvZGUgNTogRmFpbGVkIHRv
IGdldCBpbnN0cnVjdGlvbg0KPiA+Pj4+PiAkIGNkIH4vLmRlYnVnLy5idWlsZC1pZC9jMy81MzBh
ZWQ2NmU3MWJmZDEwYWY2NjAzOWY1OGNjN2M0ZDJlYWJhOA0KPiA+Pj4+PiB+Ly5kZWJ1Zy8uYnVp
bGQtaWQvYzMvNTMwYWVkNjZlNzFiZmQxMGFmNjYwMzlmNThjYzdjNGQyZWFiYTgkIGxuIC1zIGVs
ZiB2ZHNvDQo+ID4+Pj4+IH4vLmRlYnVnLy5idWlsZC1pZC9jMy81MzBhZWQ2NmU3MWJmZDEwYWY2
NjAzOWY1OGNjN2M0ZDJlYWJhOCQgbHMgLWwNCj4gPj4+Pj4gdG90YWwgMzYNCj4gPj4+Pj4gLXJ3
LXItLXItLSAxIGFodW50ZXIgYWh1bnRlciAzMzI3MiBKdW4gMjYgMTM6MTcgZWxmDQo+ID4+Pj4+
IC1ydy1yLS0tLS0gMSBhaHVudGVyIGFodW50ZXIgICAgIDAgSnVuIDI2IDEzOjE3IHByb2Jlcw0K
PiA+Pj4+PiBscnd4cnd4cnd4IDEgYWh1bnRlciBhaHVudGVyICAgICAzIEp1biAyNiAxMzoxOCB2
ZHNvIC0+IGVsZg0KPiA+Pj4+PiAvLmRlYnVnLy5idWlsZC1pZC9jMy81MzBhZWQ2NmU3MWJmZDEw
YWY2NjAzOWY1OGNjN2M0ZDJlYWJhOCQgY2QNCj4gPj4+Pj4gJCBwZXJmIHNjcmlwdCAtLWl0cmFj
ZT1lDQo+ID4+Pj4+ICQgDQo+ID4+Pj4+DQo+ID4+Pj4+IFNvIG1heWJlIGEgY2hhbmdlIGNvdWxk
IGJlIG1hZGUgdG8gYnVpbGRfaWRfY2FjaGVfX2FkZCgpIHRvIGFkZA0KPiA+Pj4+PiB0aGUgZXh0
cmEgbGluayBpZiB0aGUgZmlsZSBuYW1lIG1hdGNoZXMgdmRzbw0KPiA+Pj4+ICANCj4gPj4+PiBU
aGFua3MgZm9yIGRvaW5nIHRoaXMhICBJIG5vdGljZWQgYnVpbGRpZF9jYWNoZV9fYmFzZW5hbWUo
KSB3aWxsIGhhbmRsZQ0KPiA+Pj4+IHRoZSBuYW1lIHByb3Blcmx5IG9uY2UgaXQgcmVhbGl6ZXMg
dGhlIGZpbGUgaXMgYSB2ZHNvLiAgTWF5YmUgd2UgY2FuDQo+ID4+Pj4gY2hlY2sgdGhlIGZpbGVw
YXRoIHdpdGggc29tZSBwYXR0ZXJucywgb3Igc2ltcGx5IGFkZCBhbiBjb21tYW5kIGxpbmUNCj4g
Pj4+PiBvcHRpb24gdG8gc2F5IGl0J3MgYSB2ZHNvLg0KPiA+Pj4+DQo+ID4+Pj4gVGhhbmtzLA0K
PiA+Pj4+IE5hbWh5dW5nDQo+ID4+Pj4NCj4gPj4+IEkgYWRkZWQgc29tZSB0cmlja3MgZm9yIHZk
c28gaW4gYnVpbGRfaWRfY2FjaGVfX2FkZCgpLiBJdCByZXBsYWNlIHZkc28gb2JqZWN0DQo+ID4+
PiB3aXRoIGRlYnVnZ2luZyBvbmUgaWYgZm91bmQuIElzIHRoaXMgb2theT8NCj4gPj4NCj4gPj4g
cGVyZiBoYXMgc3VwcG9ydCBmb3Igc3RvcmluZyBkZWJ1ZyBmaWxlcyBpbiB0aGUgYnVpbGQtaWQN
Cj4gPj4gY2FjaGUgdXNpbmcgdGhlIGJhc2UgbmFtZSAiZGVidWciIGluc3RlYWQgb2YgImVsZiIs
IHNvIHJlYWxseQ0KPiA+PiBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbWFrZSB0aGF0IHdvcmsNCj4g
Pj4NCj4gPiBNeSB0aG91Z2h0cyBhcmU6DQo+ID4gICAxLiBhZGQgZGVidWdnaW5nIHZkc28gZmls
ZSBhcyAiZGVidWciIGluIGJ1aWxkaWQgY2FjaGUuDQo+ID4gICAyLiBhZGQgYSBuZXcgcGVyZiBj
b25maWcgaXRlbSAnYW5ub3RhdGUucHJlZmVyX2RlYnVnX2ZpbGUnIChkZWZhdWx0IGZhbHNlKSB0
bw0KPiA+ICAgICAgYW5ub3RhdGUgd2l0aCBkZWJ1Z2dpbmcgb2JqZWN0IGZpbGVzLg0KPiANCj4g
SXMgdGhhdCBuZWVkZWQ/ICBJc24ndCB0aGUgZGVidWcgaW5mb3JtYXRpb24gcmVhZCBmcm9tDQo+
IHRoZSAiZGVidWciIGZpbGU/ICBJZiBub3QsIGRvZXMgdGhhdCBuZWVkIGZpeGluZz8NCj4NCg0K
SXMgaXQgYnkgZGVzaWduIGFzIHlvdSBtZW50aW9uZWQgYmVmb3JlPw0KDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yL2FsbC8zOTVjZmZmNy05NjkyLTQxMjMtOTZiNi0zNTM3NTIwMDdmNDZAaW50
ZWwuY29tLzoNCg0KIkluIHRoZSBwYXN0LCB0aGVyZSBoYXZlIGJlZW4gY2FzZXMgd2hlcmUgdGhl
IGRlYnVnZ2luZyB2ZXJzaW9uIGhhcyBub3QNCndvcmtlZCBmb3IgcmVhZGluZyBvYmplY3QgY29k
ZS4gIEkgZG9uJ3QgcmVtZW1iZXIgdGhlIGRldGFpbHMsIGJ1dCB0aGUNCnN5bWJvbHMgYW5kIGRl
YnVnZ2luZyBpbmZvcm1hdGlvbiB3YXMgT0sgd2hpbGUgdGhlIG9iamVjdCBjb2RlIHdhcyBub3Qu
DQoNCkluIGdlbmVyYWwsIHVzaW5nIGFueXRoaW5nIG90aGVyIHRoYW4gdGhlIGZpbGUgdGhhdCB3
YXMgYWN0dWFsbHkgZXhlY3V0ZWQNCmZvciByZWFkaW5nIG9iamVjdCBjb2RlIHNlZW1zIGxpa2Ug
YSBiYWQgaWRlYS4iDQoNCg0KSSBkb24ndCBrbm93IHdoZXRoZXIgdGhpcyByZWFsbHkgbWF0dGVy
IG1vc3RseS4gSSBjYW4gZml4IGl0IGlmIGl0J3MgYSBidWcuDQoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvYWxsLzM5NWNmZmY3LTk2OTItNDEyMy05NmI2LTM1Mzc1MjAwN2Y0NkBpbnRlbC5j
b20vDQoNCj4gDQoNCi0tIA0KQ2hlZXJzLA0KQ2hhbmdiaW4gRHUNCg==

