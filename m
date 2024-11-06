Return-Path: <linux-kernel+bounces-398348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEEC9BEFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638B61C2332E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5B1DFE31;
	Wed,  6 Nov 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="L4v3UGQB"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CB18C035
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902545; cv=none; b=FuKO+1k45HhOLkWpvkJfi2iVYTKmY5J1/NEm1R0/f4o3MQhlIwXmz6N2cuWHRKXAxKxmsabq8S7R2WxlfXo1Ftm3lMiwMQza+kr/58HpsuijDSuugi8s77MBV116RTy2GZzmpUSZZuCqUCwO/KccPyjs+P5ymnkMR/agfbkiGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902545; c=relaxed/simple;
	bh=MV76variIS+DOg9n3+bZjINEvlYyJAWdyPvzgJ8iAC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5L8JiNZ5nqTFPCNWmNGRFfHC52zoOTNFSFRTJ6ARlEsluPRcTcI6EA/n4kwCbGOkFQ/oZjp4yXSgW25uQ1t+oM6wUe9tog39ulQaDBEgwCqwB4mxHZmaPwr5DWXPyC4KEeoIlPnqz05oVA4S7aVfEATw6DVX0/IT+jA/RYgxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=L4v3UGQB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730902502; x=1731507302; i=efault@gmx.de;
	bh=MV76variIS+DOg9n3+bZjINEvlYyJAWdyPvzgJ8iAC8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L4v3UGQB4s3RdHIkyuB/nHsQU82E1D0pcODqdULtOxRYQPBpzxRgDsxxCoourBid
	 //vZ98ws9u4/2oCkznVdVLVDHQ+ZND47eiaYzjDD/zCcPt40hyj1WfKV6ksl+2cHc
	 vI0KKPeq0iDihuWtT4i/LGrKT4Bl6VbQhAmwvUdQuFFXYBygSsqOHOu3n25V0MXMo
	 aUvM+pifBvphfO/pX6OoCaqAqu6NBCUgBbD0zvBeyhMjEkeeA3+kntogTRX9jzwZK
	 J+iUjKz1mE3FcUQw7cNg0Xyr0S/Clc9ylSZI5YBx5tEbRQg/p07OZyfn/2SwKQuq4
	 Dr4AtUtbsmtpcsJfHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.144]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1t6Clz12XB-00FA2W; Wed, 06
 Nov 2024 15:15:02 +0100
Message-ID: <843833bfb0fe7ac12e7b2314aa9debfe066c6bba.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Wed, 06 Nov 2024 15:14:58 +0100
In-Reply-To: <20241106135346.GL24862@noisy.programming.kicks-ass.net>
References: <20241101124715.GA689589@pauld.westford.csb>
	 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:q/1N+X5ATlIR2w9jSc60JRfXX72bWBDnVs+QTk+61Grk1ZjGwaq
 Ei825e+kTip/diX/ziFeCMIefi4vrPTsnF8iroDlvyysVxtVK71SxTDW61gMKkvCuKsK1vP
 XCyUTAn0s4IGqr+Ol54mllpRba97RkFuwq7HGlr98KnfvDnF7tGkMbqCp7OFx4/9DMN/uDc
 6NN24xj4lurkhZXebuoIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vcaNXAhk9KU=;AarTrAAzWpA+S47NsmiIuwJr9xO
 g6Nxk4mSP3kXrTL12CyTDVaBvqWSB+S4MmF3AsGZBM6tsw/gNsoAIjBPtjlxfnxLvar2nijwl
 BuD4tit9w5gIMtypqIHGwu7zbAZrPLw1Ee9fmo/8yZiTj+SQxe6vJMT+I3r9u5/NcXPTEbenh
 4odY7HGxiay3SLo+wj7QNBqlKVfmoZtctKmtDDxC6gCbqZxkrhkP1bpJfRBu5OlAFRxnMvtAl
 DTLnIXObroyI6c7U9rvyF62yoRVT9UOE9iXcOULyE6quw2wRgI3hBGFf8pnbI3v6Exh6/Uu9z
 LiPEkfrvITmuld4Aj8Av3CIa81M2eGFGlX/XTEySGHlDyyQzKUq/PjQHmxStV9UWNT7ed0RuT
 mkGYiECquB1BmtS2iRnwfM48iCk2girTLyckwiYRgKtAAXpxn+pvw4ej0ZrA2eQtPowEpxEkG
 /rjbSG+4PuWLS7W1I1RS0EktSyWumJOdzQhCHI1lfqR6kiIPV3LcR+OWxkY7iMtRh9y8aAUas
 URj5/gq4+uPTJCyuOrBdzuhMoglRuQ672+f0F+kZoN9JQc9db6vsy/ajXNSL6zrEzskHkgXa/
 d7Nw0p5marlDtNKUnYmHF1UpCXChK7AyH77Jd8MPYiwcZr4B5AvBw8nJEvt5yDU5zWrlsNuCG
 GR950FQMbzrhT2JaiAJfL+f9GaDcfWtPynJAwOy9KML/1/4BUGmBBJL9mGtiqViN53xOUGxkt
 1hGCzceEEVD3wS9g6gkGWLwVC+wRtDqaA2sFw/1dFezcqBX1Wn0AB4LQwlgFsd5ttkicwWQ+2
 Y/pRReZHylib5cMVTJooMiMVLwcnO3QWmxjyHHVVqLxuNqBRBSXjZXZ2e3Ra5V5QHa3yV9lc8
 DzZusxxl/zKPvElFc5FmAU/8Z6oMJMoLTuMIIetms1HFnQqO+Nsf6ln/a

T24gV2VkLCAyMDI0LTExLTA2IGF0IDE0OjUzICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gDQo+IFNvLi4uIEkgd2FzIHRyeWluZyB0byBtYWtlIHRoYXQgcHJldHRpZXIgYW5kIGVuZGVk
IHVwIHdpdGggc29tZXRoaW5nDQo+IGxpa2UgdGhpczoNCg0KUGFzc2luZyBFTlFVRVVFX0RFTEFZ
RUQgdG8gZGVxdWV1ZV90YXNrKCkgbG9va3MgZnVua3kgdW50aWwgeW91IGNoZWNrDQp0aGUgdmFs
dWUsIGJ1dCBvdGhlcndpc2UgeWVhaCwgd2hlbiBhcHBsaWVkIHRoYXQgbG9va3MgYmV0dGVyIHRv
IG1lLg0KDQo+IA0KPiAtLS0NCj4gwqBrZXJuZWwvc2NoZWQvY29yZS5jwqAgfCA0NiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+IMKga2VybmVsL3NjaGVk
L3NjaGVkLmggfMKgIDUgKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMo
KyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3Jl
LmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IGluZGV4IDU0ZDgyYzIxZmM4ZS4uYjA4M2M2Mzg1
ZTg4IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvY29yZS5jDQo+ICsrKyBiL2tlcm5lbC9z
Y2hlZC9jb3JlLmMNCj4gQEAgLTM3NzQsMjggKzM3NzQsMzggQEAgdHR3dV9kb19hY3RpdmF0ZShz
dHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCB3YWtlX2ZsYWdzLA0KPiDC
oCAqLw0KPiDCoHN0YXRpYyBpbnQgdHR3dV9ydW5uYWJsZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAs
IGludCB3YWtlX2ZsYWdzKQ0KPiDCoHsNCj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHJxX2ZsYWdz
IHJmOw0KPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcnEgKnJxOw0KPiAtwqDCoMKgwqDCoMKgwqBp
bnQgcmV0ID0gMDsNCj4gK8KgwqDCoMKgwqDCoMKgQ0xBU1MoX190YXNrX3JxX2xvY2ssIHJxX2d1
YXJkKShwKTsNCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJxICpycSA9IHJxX2d1YXJkLnJxOw0K
PiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBycSA9IF9fdGFza19ycV9sb2NrKHAsICZyZik7DQo+IC3C
oMKgwqDCoMKgwqDCoGlmICh0YXNrX29uX3JxX3F1ZXVlZChwKSkgew0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdXBkYXRlX3JxX2Nsb2NrKHJxKTsNCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChwLT5zZS5zY2hlZF9kZWxheWVkKQ0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVucXVldWVfdGFzayhycSwgcCwgRU5R
VUVVRV9OT0NMT0NLIHwgRU5RVUVVRV9ERUxBWUVEKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmICghdGFza19vbl9jcHUocnEsIHApKSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXaGVuIG9uX3JxICYmICFvbl9jcHUgdGhlIHRh
c2sgaXMgcHJlZW1wdGVkLCBzZWUgaWYNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBpdCBzaG91bGQgcHJlZW1wdCB0aGUgdGFzayB0aGF0IGlzIGN1
cnJlbnQgbm93Lg0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqLw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHdha2V1cF9wcmVlbXB0KHJxLCBwLCB3YWtlX2ZsYWdzKTsNCj4gK8KgwqDCoMKgwqDCoMKgaWYg
KCF0YXNrX29uX3JxX3F1ZXVlZChwKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiAwOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoHVwZGF0ZV9ycV9jbG9jayhycSk7DQo+
ICvCoMKgwqDCoMKgwqDCoGlmIChwLT5zZS5zY2hlZF9kZWxheWVkKSB7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgcXVldWVfZmxhZ3MgPSBFTlFVRVVFX0RFTEFZRUQgfCBF
TlFVRVVFX05PQ0xPQ0s7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBTaW5jZSBzY2hlZF9kZWxheWVk
IG1lYW5zIHdlIGNhbm5vdCBiZSBjdXJyZW50IGFueXdoZXJlLA0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogZGVxdWV1ZSBpdCBoZXJlIGFuZCBoYXZlIGl0IGZhbGwgdGhyb3Vn
aCB0byB0aGUNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHNlbGVjdF90YXNr
X3JxKCkgY2FzZSBmdXJ0aGVyIGFsb25nIHRoZSB0dHd1KCkgcGF0aC4NCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKHJxLT5ucl9ydW5uaW5nID4gMSAmJiBwLT5ucl9jcHVzX2FsbG93ZWQgPiAxKSB7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVxdWV1ZV90YXNr
KHJxLCBwLCBERVFVRVVFX1NMRUVQIHwgcXVldWVfZmxhZ3MpOw0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHR0
d3VfZG9fd2FrZXVwKHApOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0g
MTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW5xdWV1ZV90YXNrKHJx
LCBwLCBxdWV1ZV9mbGFncyk7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IC3CoMKgwqDCoMKgwqDC
oF9fdGFza19ycV91bmxvY2socnEsICZyZik7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICghdGFza19v
bl9jcHUocnEsIHApKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKg0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogV2hlbiBvbl9ycSAmJiAhb25fY3B1IHRo
ZSB0YXNrIGlzIHByZWVtcHRlZCwgc2VlIGlmDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBpdCBzaG91bGQgcHJlZW1wdCB0aGUgdGFzayB0aGF0IGlzIGN1cnJlbnQgbm93Lg0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB3YWtldXBfcHJlZW1wdChycSwgcCwgd2FrZV9mbGFncyk7DQo+ICvCoMKg
wqDCoMKgwqDCoH0NCj4gK8KgwqDCoMKgwqDCoMKgdHR3dV9kb193YWtldXAocCk7DQo+IMKgDQo+
IC3CoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAxOw0K
PiDCoH0NCj4gwqANCj4gwqAjaWZkZWYgQ09ORklHX1NNUA0KPiBkaWZmIC0tZ2l0IGEva2VybmVs
L3NjaGVkL3NjaGVkLmggYi9rZXJuZWwvc2NoZWQvc2NoZWQuaA0KPiBpbmRleCAyMWIxNzgwYzY2
OTUuLjE3MTRhYzM4NTAwZiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL3NjaGVkLmgNCj4g
KysrIGIva2VybmVsL3NjaGVkL3NjaGVkLmgNCj4gQEAgLTE3ODcsNiArMTc4NywxMSBAQCB0YXNr
X3JxX3VubG9jayhzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBy
cV9mbGFncyAqcmYpDQo+IMKgwqDCoMKgwqDCoMKgwqByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmcC0+cGlfbG9jaywgcmYtPmZsYWdzKTsNCj4gwqB9DQo+IMKgDQo+ICtERUZJTkVfTE9DS19H
VUFSRF8xKF9fdGFza19ycV9sb2NrLCBzdHJ1Y3QgdGFza19zdHJ1Y3QsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX1QtPnJxID0gX190YXNrX3JxX2xvY2soX1QtPmxv
Y2ssICZfVC0+cmYpLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9f
dGFza19ycV91bmxvY2soX1QtPnJxLCAmX1QtPnJmKSwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnEgKnJxOyBzdHJ1Y3QgcnFfZmxhZ3MgcmYpDQo+ICsN
Cj4gwqBERUZJTkVfTE9DS19HVUFSRF8xKHRhc2tfcnFfbG9jaywgc3RydWN0IHRhc2tfc3RydWN0
LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfVC0+cnEgPSB0YXNr
X3JxX2xvY2soX1QtPmxvY2ssICZfVC0+cmYpLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0YXNrX3JxX3VubG9jayhfVC0+cnEsIF9ULT5sb2NrLCAmX1QtPnJmKSwN
Cg0K

