Return-Path: <linux-kernel+bounces-227220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE12914AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDDA1F239CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988613C9A1;
	Mon, 24 Jun 2024 12:43:43 +0000 (UTC)
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205813C677
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233023; cv=none; b=anuO3RzXp+x+QZ+pbsM055LsYXFAw0VUIFATk8+5kFIY3HOIl/6NGg9ops62q/pHJ14i0m2JKwUXPC8CtkGg8yYLVrVwNaN9HraFKtEK6bIbhCn1mCk9NN6FvhG42RbhVlwNDvntwR8oiSGzTsElBYihjzeYp450rDptHjhbwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233023; c=relaxed/simple;
	bh=7jMMB6TuHugW436Xe6O86T8myxeAiLD/fnDIpcb3ggg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O0rf5oGajsp98P+AviBeJaNLSb/8HxyBJKOf0uprQuGLEEqBZaQV+D5xAPkyKntd17MpIZ6r1O8dmjZXZSCLBu6cZslzzp1XTfJW1yslg9NfIYu5mVnwHxQwoN9J5JFdnK5+hny6K/LqGl/oWPDXdPcPyhRC1HD1EsUp/nS/c/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch02.asrmicro.com (exch02.asrmicro.com [10.1.24.122])
	by spam.asrmicro.com with ESMTPS id 45OCh0Ta002351
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Mon, 24 Jun 2024 20:43:00 +0800 (GMT-8)
	(envelope-from zhengyan@asrmicro.com)
Received: from exch03.asrmicro.com (10.1.24.118) by exch02.asrmicro.com
 (10.1.24.122) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 24 Jun
 2024 20:43:05 +0800
Received: from exch03.asrmicro.com ([::1]) by exch03.asrmicro.com ([::1]) with
 mapi id 15.00.0847.030; Mon, 24 Jun 2024 20:43:05 +0800
From: =?utf-8?B?WWFuIFpoZW5n77yI5Lil5pS/77yJ?= <zhengyan@asrmicro.com>
To: Nam Cao <namcao@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org"
	<maz@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>,
        "samuel.holland@sifive.com"
	<samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>,
        =?utf-8?B?WmhvdSBRaWFvKOWRqOS+qCk=?=
	<qiaozhou@asrmicro.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaXJxY2hpcC9zaWZpdmUtcGxpYzog?=
 =?utf-8?Q?ensure_interrupt_is_enable_before_EOI?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlycWNoaXAvc2lmaXZlLXBsaWM6IGVuc3VyZSBp?=
 =?utf-8?Q?nterrupt_is_enable_before_EOI?=
Thread-Index: AQHaxhQUdoMYNshWYUC/EJ5aDUOpkLHWIY8AgACb9jD//4tPgIAAkXNw
Date: Mon, 24 Jun 2024 12:43:04 +0000
Message-ID: <6f4787fe98374079b33427471ad715cb@exch03.asrmicro.com>
References: <20240624085341.3935-1-zhengyan@asrmicro.com>
 <20240624093556.ZcZgu2GF@linutronix.de>
 <69174a28eff44ad1b069887aa514971e@exch03.asrmicro.com>
 <20240624115629.6vSA6hQE@linutronix.de>
In-Reply-To: <20240624115629.6vSA6hQE@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
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
X-MAIL:spam.asrmicro.com 45OCh0Ta002351

PiBPbiBNb24sIEp1biAyNCwgMjAyNCBhdCAxMToxNDo0N0FNICswMDAwLCBZYW4gWmhlbmfvvIjk
uKXmlL/vvIkgd3JvdGU6DQo+ID4gPiBJIGhhdmUgbm8ga25vd2xlZGdlIGFib3V0IGFmZmluaXR5
IHN0dWZmLCBzbyBJIGRvbid0IHJlYWxseQ0KPiA+ID4gdW5kZXJzdGFuZCB0aGlzIHBhdGNoLiBC
dXQgdGhlcmUgaXMgYW5vdGhlciBpZGVhIHJlZ2FyZGluZyB0aGlzICJpZ25vcmVkDQo+IEVPSSIg
cHJvYmxlbToNCj4gPiA+IGFsd2F5cyAiY29tcGxldGUiIHRoZSBpbnRlcnJ1cHQgd2hpbGUgZW5h
YmxpbmcuIFRoYXQgd291bGQgbW92ZSB0aGlzDQo+ID4gPiBleHRyYSBjb21wbGljYXRpb24gb3V0
IG9mIHRoZSBob3QgcGF0aCwgYW5kIGFsc28gbG9va3Mgc2ltcGxlciBpbiBteQ0KPiBvcGluaW9u
Lg0KPiA+ID4NCj4gPiA+IFNvbWV0aGluZyBsaWtlIHRoZSBwYXRjaCBiZWxvdy4gV291bGQgdGhp
cyBzb2x2ZSB0aGlzICJhZmZpbml0eSBwcm9ibGVtIg0KPiA+ID4gdG9vPw0KPiA+ID4NCj4gPiBO
bywgSSdtIGFmcmFpZCB0aGUgZm9sbG93aW5nIHBhdGNoIGNhbid0IHNvbHZlIHRoaXMgY29ybmVy
IGNhc2UuIEkNCj4gPiB0aG91Z2h0IGl0J3MgYmVjYXVzZSB0aGUgY29yZSBXaG8gZXhlY3V0ZXMg
cGxpY19pcnFfZW5hYmxlIGlzIG5vdCB0aGUgY29yZQ0KPiB3aG8gbWlzc2luZyBhIHdyaXRlIGNs
YWltLg0KPiA+IFNvIGlmIHdlIHdhbnQgdG8gZG8gaXQgaW4gZW5hYmxlIGl0IG1pZ2h0IGJlIHNv
bWV0aGluZyBsaWtlIGZvbGxvd3MgOg0KPiA+IHN0YXRpYyB2b2lkIHBsaWNfdG9nZ2xlKHN0cnVj
dCBwbGljX2hhbmRsZXIgKmhhbmRsZXIsIGludCBod2lycSwgaW50DQo+ID4gZW5hYmxlKSAgew0K
PiA+ICAgICAgICAgcmF3X3NwaW5fbG9jaygmaGFuZGxlci0+ZW5hYmxlX2xvY2spOw0KPiA+IC0g
ICAgICAgX19wbGljX3RvZ2dsZShoYW5kbGVyLT5lbmFibGVfYmFzZSwgaHdpcnEsIGVuYWJsZSk7
DQo+ID4gKyAgICAgICBpZiAoZW5hYmxlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbCho
d2lycSwgaGFuZGxlci0+aGFydF9iYXNlICsgQ09OVEVYVF9DTEFJTSk7DQo+ID4gKyAgICAgICAg
ICAgICAgIF9fcGxpY190b2dnbGUoaGFuZGxlci0+ZW5hYmxlX2Jhc2UsIGh3aXJxLCBlbmFibGUp
Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICAgICAgICAgcmF3X3NwaW5fdW5sb2NrKCZoYW5kbGVyLT5l
bmFibGVfbG9jayk7DQo+ID4gIH0NCj4gDQo+IEFnYWluLCBJIGRvbid0IGtub3cgYW55dGhpbmcg
YWJvdXQgaW50ZXJydXB0IGFmZmluaXR5IHRoaW5neSwgc28gSSBtYXkgYmUNCj4gc2F5aW5nIHNv
bWV0aGluZyBkdW1iIGhlcmU6DQo+IA0KPiBJIHRoaW5rIHRoaXMgd291bGRuJ3Qgd29yayBlaXRo
ZXIuIEluIHBsaWNfc2V0X2FmZmluaXR5KCksIEkgc2VlIHRoZSBpbnRlcnJ1cHQgaXMNCj4gZGlz
YWJsZWQsIHRoZW4gZW5hYmxlZCBhZ2Fpbi4gV2l0aCB5b3VyIG5ldyBwcm9wb3NlZCBzb2x1dGlv
biwgdGhlDQo+IGludGVycnVwdCB3b3VsZCBhbHNvIGJlIG1hcmtlZCBjb21wbGV0ZWQgd2l0aGlu
IHBsaWNfc2V0X2FmZmluaXR5KCkuDQo+IFNvLCB0aGUgaW50ZXJydXB0IG1heSBiZSBhc3NlcnRl
ZCBhZ2FpbiwgZWFybGllciB0aGFuIGl0IGlzIHN1cHBvc2VkIHRvIChpdCBpcw0KPiBub3Qgc3Vw
cG9zZWQgdG8gYmUgYXNzZXJ0ZWQgYWdhaW4gdW50aWwgcGxpY19pcnFfZW9pKCkgaXMgY2FsbGVk
KS4gSXQncyByYXJlLCBidXQgSQ0KPiB0aGluayBpdCdzIGEgcG9zc2libGUgcmFjZS4NCj4gDQo+
IEkgZG9uJ3QgaGF2ZSBhIGJldHRlciBpZGVhLCBhdCBsZWFzdCBmb3Igbm93LiBTbyBwcm9iYWJs
eSB3ZSBzaG91bGQgc3RpY2sgdG8NCj4geW91ciBjdXJyZW50IHNvbHV0aW9uLg0KPiA+DQo+ID4g
QnV0IHRoZXJlIGlzIGEgbGl0dGxlIGRpZmZlcmVuY2U6DQo+ID4gYS4gY2hlY2sgd2hldGhlciBp
dCdzIGVuYWJsZWQgIHdoZW4gZG8gd3JpdGUgY2xhaW0gYi4gd3JpdGUgY2xhaW0NCj4gPiBhbnl3
YXkgYmVmb3JlIGVuYWJsZQ0KPiA+DQo+ID4gc291bmRzIGxpa2UgYS4gaXMgYmV0dGVyPw0KPiA+
DQo+ID4gQW5kIEknZCBsaWtlIHRvIGlsbHVzdHJhdGUgbW9yZSBhYm91dCB0aGlzIGNhc2U6DQo+
ID4gRm9yIGV4YW1wbGUsIGJyb2FkY2FzdCB0aWNrIGlzIHdvcmtpbmcsIGNwdTAgaXMgYWJvdXQg
dG8gcmVzcG9uc2UsDQo+ID4gY3B1MSBpcyB0aGUgbmV4dCAxLiBjcHUwICByZXNwb25zZSB0aGUg
dGltZXIgaXJxLCByZWFkIHRoZSBjbGFpbSBSRUcsDQo+ID4gYW5kIGRvIHRpbWVyIGlzciBldmVu
dCwgMi4gIGR1cmluZyB0aGUgdGltZXIgaXNyIGl0IHdpbGwgc2V0IG5leHQNCj4gPiBldmVudCB0
aWNrX2Jyb2FkY2FzdF9zZXRfZXZlbnQgLT4gIGlycV9zZXRfYWZmaW5pdHktPiB4eHgtPg0KPiA+
IHBsaWNfc2V0X2FmZmluaXR5IC0+IHBsaWNfaXJxX2VuYWJsZSAzLiBpbiBwbGljX3NldF9hZmZp
bml0eSAgZGlzYWJsZQ0KPiA+IGNwdTAncyBJRSBhbmQgZW5hYmxlIGNwdTEnSUUgNC4gY3B1MCBk
byB0aGUgd3JpdGUgY2xhaW0gdG8gZmluaXNoIHRoaXMNCj4gPiBpcnEsIHdoaWxlIGNwdTAncyBJ
RSBpcyBkaXNhYmxlZCAsIGxlZnQgYW4gYWN0aXZlIHN0YXRlIGluIHBsaWMNCj4gDQo+IFRoaXMg
aXMgdXNlZnVsIGluZm9ybWF0aW9uLCB5b3UgbWF5IHdhbnQgdG8gYWRkIGl0IGluIHlvdXIgY29t
bWl0IG1lc3NhZ2UuDQpZZXMsIEknZCBhbHJlYWR5IGFkZCBpdCBpbiB2MiBwYXRjaCwgdGh4Lg0K
PiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IHpoZW5neWFuDQo+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLXNpZml2ZS1wbGljLmMNCj4gPiA+IGIvZHJpdmVycy9p
cnFjaGlwL2lycS1zaWZpdmUtcGxpYy5jDQo+ID4gPiBpbmRleCAwYTIzM2U5ZDk2MDcuLjYzZjIx
MTFjZWQ0YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtc2lmaXZlLXBs
aWMuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1zaWZpdmUtcGxpYy5jDQo+ID4g
PiBAQCAtMTIyLDcgKzEyMiwxNSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGxpY19pcnFfdG9nZ2xl
KGNvbnN0IHN0cnVjdA0KPiA+ID4gY3B1bWFzayAqbWFzaywNCj4gPiA+DQo+ID4gPiAgc3RhdGlj
IHZvaWQgcGxpY19pcnFfZW5hYmxlKHN0cnVjdCBpcnFfZGF0YSAqZCkgIHsNCj4gPiA+ICsJc3Ry
dWN0IHBsaWNfcHJpdiAqcHJpdiA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGQpOw0KPiA+
IAlzdHJ1Y3QgcGxpY19oYW5kbGVyICpoYW5kbGVyID0gdGhpc19jcHVfcHRyKCZwbGljX2hhbmRs
ZXJzKTsgbWlzc2luZw0KPiA+IGEgZGVmaW5pdGlvbj8gSWYgYWRkcyBsaWtlIHRoaXMgd2lsbCBj
YXVzZSBhIHByb2JsZW0uDQo+IA0KPiBTb3JyeSwgc2hvdWxkIGhhdmUgbWVudGlvbmVkIEkgZGlk
bid0IGJ1aWxkIHRoaXMgcGF0Y2guIEp1c3Qgd2FudGVkIHRvIHRocm93DQo+IG91dCBpZGVhcy4u
DQo+IA0KTm8gcHJvYmxlbSwgSSB0aG91Z2h0IHlvdSBtaWdodCBub3QgaGF2ZSBjb21waWxlZCBp
dC4gDQpJIHdyb3RlIGl0IGRvd24ganVzdCB0byBlbnN1cmUgd2UgYXJlIG9uIHRoZSBzYW1lIHBh
Z2UuDQo+ID4gPiArDQo+ID4gPiArCXdyaXRlbCgwLCBwcml2LT5yZWdzICsgUFJJT1JJVFlfQkFT
RSArIGQtPmh3aXJxICoNCj4gPiA+ICtQUklPUklUWV9QRVJfSUQpOw0KPiA+ID4gKw0KPiA+ID4g
Kwl3cml0ZWwoZC0+aHdpcnEsIGhhbmRsZXItPmhhcnRfYmFzZSArIENPTlRFWFRfQ0xBSU0pOw0K
PiA+ID4gKw0KPiA+ID4gIAlwbGljX2lycV90b2dnbGUoaXJxX2RhdGFfZ2V0X2VmZmVjdGl2ZV9h
ZmZpbml0eV9tYXNrKGQpLCBkLCAxKTsNCj4gPiA+ICsNCj4gPiA+ICsJd3JpdGVsKDEsIHByaXYt
PnJlZ3MgKyBQUklPUklUWV9CQVNFICsgZC0+aHdpcnEgKg0KPiA+ID4gK1BSSU9SSVRZX1BFUl9J
RCk7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgdm9pZCBwbGljX2lycV9kaXNhYmxl
KHN0cnVjdCBpcnFfZGF0YSAqZCkgQEAgLTE0OCwxMyArMTU2LDcNCj4gPiA+IEBAIHN0YXRpYyB2
b2lkIHBsaWNfaXJxX2VvaShzdHJ1Y3QgaXJxX2RhdGEgKmQpICB7DQo+ID4gPiAgCXN0cnVjdCBw
bGljX2hhbmRsZXIgKmhhbmRsZXIgPSB0aGlzX2NwdV9wdHIoJnBsaWNfaGFuZGxlcnMpOw0KPiA+
ID4NCj4gPiA+IC0JaWYgKHVubGlrZWx5KGlycWRfaXJxX2Rpc2FibGVkKGQpKSkgew0KPiA+ID4g
LQkJcGxpY190b2dnbGUoaGFuZGxlciwgZC0+aHdpcnEsIDEpOw0KPiA+ID4gLQkJd3JpdGVsKGQt
Pmh3aXJxLCBoYW5kbGVyLT5oYXJ0X2Jhc2UgKyBDT05URVhUX0NMQUlNKTsNCj4gPiA+IC0JCXBs
aWNfdG9nZ2xlKGhhbmRsZXIsIGQtPmh3aXJxLCAwKTsNCj4gPiA+IC0JfSBlbHNlIHsNCj4gPiA+
IC0JCXdyaXRlbChkLT5od2lycSwgaGFuZGxlci0+aGFydF9iYXNlICsgQ09OVEVYVF9DTEFJTSk7
DQo+ID4gPiAtCX0NCj4gPiA+ICsJd3JpdGVsKGQtPmh3aXJxLCBoYW5kbGVyLT5oYXJ0X2Jhc2Ug
KyBDT05URVhUX0NMQUlNKTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gICNpZmRlZiBDT05GSUdf
U01QDQo=

