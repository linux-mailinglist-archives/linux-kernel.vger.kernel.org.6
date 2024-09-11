Return-Path: <linux-kernel+bounces-324561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C455C974E38
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC91F22A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A4185B6C;
	Wed, 11 Sep 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="it2aQgQX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3E1714CF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045904; cv=none; b=JdLuPtHKEqY30Dc4/gCpmncLGxokfkgKdpmk3hnCqkAMlPlyWc+jzXXHwC769Lzk8Nh17W52Ycgln4TC//dX9KQpdJADM5d/HH8PmJVhNY0k0D8o7j3xjjX3xqWHHA9fukg3cj+CDGVam8Uzfu/RfImxTrPmXUmIWZI/7YPjLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045904; c=relaxed/simple;
	bh=H+603tEzyK5UWJBwkzHI8z6R1iyYgg0Og9F9QKsUN00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8SkXgeF5+hJndPZaNrO1ITWkOGL+AqTJVPhrgVfmJedP12hL8+3YLFhkkmFsrda66HrQMQPd7OCiWsDNLw7grwbBkVCH0zw0jN4N87eK7bbi+ySC2bmDS8F9wrv/IeK+XK4AXVZb3S0fhX2/unH/pj37Iw6QoUNqu53N782yFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=it2aQgQX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726045829; x=1726650629; i=efault@gmx.de;
	bh=H+603tEzyK5UWJBwkzHI8z6R1iyYgg0Og9F9QKsUN00=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=it2aQgQXYArsM/0or9JpWXVZ4F4UoT6OZEXkwYt4MzWBWFm1LQNCcWGeyo2+16Eo
	 JvW+1dw2bWYEIvVki+ol/STiBenflep4ajS++UYA5TobOgwI6blpNtaS1PocRrX6P
	 +JlZqKnI39ZjuAMtmaqwR0YBkdrlL2yEMztIRCYy6bOwOVc54rzX+5mpXE5OwPOng
	 FYkqzrGK9yHPO3a59C4LVzNTdRThgm9mte05Gbb9tvW3XUffm4nvccCWI+q/eQtLC
	 3ynmRP7/ACgfSEa4tyPQHE7R1wcBCjdnuT+a6Eg0yjZ9ko7ipvERV+1CC6roWO2nH
	 44Eh3CtCRpRpkVmMZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1sfXwT1mtM-007o5m; Wed, 11
 Sep 2024 11:10:29 +0200
Message-ID: <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, Luis Machado
 <luis.machado@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Hongyan Xia <hongyan.xia2@arm.com>, 
 mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com,  mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org,  kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org,  tglx@linutronix.de
Date: Wed, 11 Sep 2024 11:10:26 +0200
In-Reply-To: <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
References: 
	<CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
	 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
	 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
	 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
	 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
	 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
	 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
	 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
	 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
	 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
	 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:1lZdyoTVx/4slT6EIdj54rBcuoFSu6bUknNNn/1Lun6zfhlYPgL
 rwz5C94DJORDLZfjcbRed1NHHOQ7tpUqL7vWbzY0y07voJPmZ1p6VrP4GM8wFfQei0avIxE
 rQrsAtCEcDdj4NqzG12OPR4E01pEz9pGzQwsrBCxQIpMLAYKzbnVl9+Sbb1kMdH4/ulRKZ0
 9nVF0CpzpBLsixVGJuU3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u6ejEXcjJBM=;QLHNTxCtVY8JdvisqBOPq01WKe6
 MNZLQSBYSZAIZfRvwSMo8tLJgSuLjh/ntNXggD1LlpJzFMbww/FjvCYhNHkvls3eoj1WvJr2q
 shonCKrc3AAi1TmViK50hZDQ3YDm7wbkgnNcK7u9i5OzCxFsjEplidweAxfUjTBvnRxoYKUow
 WtWidRRN/ww7MhjzZw5bYl0SCIs1NIgJgqz2bK6gMBEy1BmoqhdXKrGkmqMmBru530bM3ugEy
 BVPeWWdn0MUB4wisxD+qH3GMjx49ZiLSgSUbFYArkbUfiR/Z7ZtqdOjHxKEM+0/6bK1nM/mSe
 JIwY8TOoe1jFz3oNSG8fKho8k8FRqzPJRiTsBpkzYk/K1M9yupGmBg5a6myPrQivpG/rqyshG
 uwOsGzojw7n/O1bEtgsDbtEOCj2WBj7LqJDXyh9y4eaD7QRmgjzP1ZBkeUq2F6pFIJuWnXA/k
 OQmrUt1TGznHjqnscZyyTKTzWfcXW7sWJlwxe+BX3qt3Mye+T3LYXrdWIBxT60diYRMuvYCv4
 2GsFihRw5K9c2C5JnuJajRBOYELUl0z4xRCSSrna2idsKreW2oL9gK4q+yVmo+J14tcQL5v7Z
 efK8teVndgJnpMaoWqWyB6JXO/KNbzvJybQsrsLCokCC0F++5xuDEIO7mDzHEXdDg9B/Zk2IG
 xS3b22Zh/6eNJNnA5BehKXjGnO4NizJyrWwEd7a+mmH0rMRxUvCDE4HK5xjuga2EOKLPwV0wu
 RAP5B+PHBkWk6laxEPUFw/g7GUVbHbOHH10/ExhHgsKqbiUlzQUCtYegTiVAizOfcWAmeb1DU
 EP3YXo3EBfySZsIeF9JIlI4g==

T24gV2VkLCAyMDI0LTA5LTExIGF0IDEwOjQ1ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMDk6MzU6MTZBTSArMDEwMCwgTHVpcyBNYWNoYWRv
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBJJ20gYXNzdW1pbmcgdGhhdCByZW1vdmluZyB0aGUgdXNh
Z2Ugc2l0ZXMgcmVzdG9yZXMgZnVuY3Rpb24/DQo+ID4gDQo+ID4gSXQgZG9lcyByZXN0b3JlIGZ1
bmN0aW9uIGlmIHdlIHJlbW92ZSB0aGUgdXNhZ2UuDQo+ID4gDQo+ID4gRnJvbSBhbiBpbml0aWFs
IGxvb2s6DQo+ID4gDQo+ID4gY2F0IC9zeXMva2VybmVsL2RlYnVnL3NjaGVkL2RlYnVnIHwgZ3Jl
cCAtaSBkZWxhecKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIA0KPiA+
IMKgIC5oX25yX2RlbGF5ZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogLTQN
Cj4gPiDCoCAuaF9ucl9kZWxheWVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6
IC02DQo+ID4gwqAgLmhfbnJfZGVsYXllZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgOiAtMQ0KPiA+IMKgIC5oX25yX2RlbGF5ZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDogLTYNCj4gPiDCoCAuaF9ucl9kZWxheWVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA6IC0xDQo+ID4gwqAgLmhfbnJfZGVsYXllZMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgOiAtMQ0KPiA+IMKgIC5oX25yX2RlbGF5ZWTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDogLTUNCj4gPiDCoCAuaF9ucl9kZWxheWVkwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IC02DQo+ID4gDQo+ID4gU28gcHJvYmFibHkgYW4gdW5l
eHBlY3RlZCBkZWNyZW1lbnQgb3IgbGFjayBvZiBhbiBpbmNyZW1lbnQgc29tZXdoZXJlLg0KPiAN
Cj4gWWVhaCwgdGhhdCdzIGJ1Z2dlcmVkLiBPaywgSSdsbCBnbyByZWJhc2Ugc2NoZWQvY29yZSBh
bmQgdGFrZSB0aGlzIHBhdGNoDQo+IG91dC4gSSdsbCBzZWUgaWYgSSBjYW4gcmVwcm9kdWNlIHRo
YXQuDQoNCkhtLCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0byBrbm93IGhvdyB0aGUgaGVjayBoZSdz
IHRyaWdnZXJpbmcgdGhhdC4NCg0KTXkgeDg2XzY0IGJveCByZWZ1c2VzIHRvIHByb2R1Y2UgYW55
IHN1Y2ggYXJ0aWZhY3RzIHdpdGggYW55dGhpbmcgSSd2ZQ0KdG9zc2VkIGF0IGl0LCBpbmNsdWRp
bmcgZnVsbCBMVFAgd2l0aCBlbnRlcnByaXNlIFJUIGFuZCAhUlQgY29uZmlncywNCmJvdGggaW4g
bWFzdGVyIGFuZCBteSBsb2NhbCBTTEUxNS1TUDcgYnJhbmNoLiAgSG9odW0uDQoNCgktTWlrZQ0K

