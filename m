Return-Path: <linux-kernel+bounces-348569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5298E92F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8819C1F2461B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFD38DE0;
	Thu,  3 Oct 2024 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="XyF7mBXJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D40139D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727930518; cv=none; b=ZyzKfRAoWyF3Ap8xQeXU6lJD1bufFud8xrc1sboDdPWYnwJLUXV5PSj7uXEQSwMLXchokIoQI+HO9VcrEE/krvLTWpXLB4UYclef5lFdRYzU2/b/ktMRGH4aEah0WouONiEIRFpWU7G1vDnxeGp5swRheGCLEPE4Ar+LNufpkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727930518; c=relaxed/simple;
	bh=Pskid+wvRaqb4YWO/VvKibGzqord9+mWoc5IYdV9inc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2q8ixpfVQHI00cYu+12VXroCsBz1sOxWY2I3KUQhNGoMa7jauVxwJt1HPvktEIb/N+IHsFQFd8R+ardLpSiIytLEEwJxjnpV9UAsS5DN0kRPDPyyNMcbapZ5+DTZ4oHpv9Dlmbq5Tr1XDiT4ttylLxtPBbksb0zBz26RYxpt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=XyF7mBXJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727930489; x=1728535289; i=efault@gmx.de;
	bh=Pskid+wvRaqb4YWO/VvKibGzqord9+mWoc5IYdV9inc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XyF7mBXJQ6J8pWq/7S6Z9FzDThP5qOn/xCVk0lCQwdy8eYRCfJGi5ux/BkuH/cph
	 wR/Ekf8belFfvpXH5G86m99mnjqMlBH89mjqxDFc9vAEY4j1aNfKQUiRqiQKJa5w2
	 wDK2xeturCucIq6Xs4PibIynRC4dbqnZD6Spu5TIsm71L2fERmd22Nn88hyFZH3FX
	 c9VYVTbPSSG/ysVKYx7pSOek9HAJp9NrRtZq2+8ehTeHBa4NNHa6g2wZYcv2Upw7X
	 7CDM1p79uhZ0qCaK2kIEsEfdS515f+FnotL5ikAWRWgLHSc+wXNi88eBN2v/HZZO5
	 /DXZ7oCNv3YUqHpXfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1s0yUs2H6h-00ygv2; Thu, 03
 Oct 2024 06:41:29 +0200
Message-ID: <2ffbd642407a2bc51a387b6f89e74f0f9c9f85cf.camel@gmx.de>
Subject: Re: sched/fair: Kernel panics in pick_next_entity
From: Mike Galbraith <efault@gmx.de>
To: Benjamin Segall <bsegall@google.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri
 Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, luis.machado@arm.com
Date: Thu, 03 Oct 2024 06:41:27 +0200
In-Reply-To: <xm26msjmm91q.fsf@bsegall.svl.corp.google.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
	 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
	 <Zvr2bLBEYyu1gtNz@linux.ibm.com> <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
	 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
	 <xm26msjmm91q.fsf@bsegall.svl.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XocQmXif/l0rU7RM1fgtl5fW6Y9JmSnDY6yC3G5rQQ2Eqw+QvuC
 DIqgYPuZKl/dgmlUARz44OAcEErYlzLBNEOrc0ZsCeFJpKvsr7Wj1XpOaE6M4g3t1fccy6c
 mgua0uYcknxVIhcD2RXlaYPH+TGMmGHEKmdEX/yvV2az2ElmTH5M8pSEYjnpp/iAQU8EXl1
 f6z7N87F9U9zdry9KnS3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8jyHNBya2EI=;Hg7b5epOI6rvNIiacOynEL7c7jQ
 Gkh31mlVPvAtM9CnO8L+B4/z/KZwUhcvwRtqgOPD+SMVm69hv0fMU6Tl4ZLUWPxQMdKyqD+Zk
 vt9eTZiBtdFgQxGNm0NYCfc9T2T7Wt1I/9mhay91mLwffCZpFzCjMXLhxmLyM92sOwHFidUQ0
 StwPGNUhFPNdY/QicvHu2xZ81DkWZt03NjhhntMCRnx8lOpCp1sOTZc7YXY+ujLmpwRxyLAUs
 +QtMHBmc5V6SR7U55tn2PD6CKk2F7ZGkGvw9uKIJumuzGzjUc0xVXcLXNGdO5khr5ab8JOPYg
 Cg2C8xeyan1p9lwb8ZqHznpNXVpDPS+cZaM5lJrNIL6dOO+ot7/+F6pkvMXls/GRcHr3bB0sM
 MgsswgVSiOEhB3+EGyQt1v/ZmBTrRuLotXkRn3Nbs255e5Nciy77P3G2YaVpKEBQL5n+NSEH1
 jiQ0yHeXiW+7CHE3EpMgJL7EVXzC8eGLDDZkRIVBAwy/L9XoMD7jYoEQ6RqHlPwxo4v2xIpO7
 I71l4K22NFNEhvjbUGklmukzqXgvZO/bw5pBoQnPF//JF69SUK6N0WvHWkZYzvc+wLJ91cj5T
 PjT0qg9Eiw+8ayyZqB5XS5JaJto+RtDAeg4hKzo92H0crmi7DILJ2SCj+Tgc/OwBvvPgYtiT5
 S/hwI17zyQujm3t3/gtpNIGNAWnyI/4wZmIWJKGuYLtgTRrUFeN/BhJzR+uwH2zLXJTTq7H1O
 sVgAzT5ikA5nIEKTs1sAzWKB9o4cR+UxF1CKIIlGjYwrgYOHN4dxC1XvFVt2kZUKGO4kx6Tsd
 o0HoBYhro2cAKhxLwfs6ocjA==

T24gV2VkLCAyMDI0LTEwLTAyIGF0IDE1OjMxIC0wNzAwLCBCZW5qYW1pbiBTZWdhbGwgd3JvdGU6
DQo+IE1pa2UgR2FsYnJhaXRoIDxlZmF1bHRAZ214LmRlPiB3cml0ZXM6DQo+ID4gDQo+ID4gLS0t
DQo+ID4gwqBrZXJuZWwvc2NoZWQvZmFpci5jIHzCoMKgwqAgOSArKysrKystLS0NCj4gPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
LS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMN
Cj4gPiBAQCAtNjA1OCwxMCArNjA1OCwxMyBAQCB2b2lkIHVudGhyb3R0bGVfY2ZzX3JxKHN0cnVj
dCBjZnNfcnEgKmNmDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX3NjaGVkX2VudGl0eShz
ZSkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGNmc19ycSAq
cWNmc19ycSA9IGNmc19ycV9vZihzZSk7DQo+ID4gDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmIChzZS0+b25fcnEpIHsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoFNDSEVEX1dBUk5fT04oc2UtPnNjaGVkX2RlbGF5ZWQpOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBIYW5kbGUgYW55IHVuZmluaXNo
ZWQgREVMQVlfREVRVUVVRSBidXNpbmVzcyBmaXJzdC4gKi8NCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHNlLT5zY2hlZF9kZWxheWVkKSB7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgZmxhZ3MgPSBERVFVRVVFX1NM
RUVQIHwgREVRVUVVRV9ERUxBWUVEOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlcXVldWVfZW50aXR5KHFjZnNfcnEsIHNlLCBmbGFn
cyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoc2UtPm9u
X3JxKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGJyZWFrOw0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbnF1ZXVlX2VudGl0eShxY2ZzX3JxLCBzZSwgRU5R
VUVVRV9XQUtFVVApOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKGNmc19ycV9pc19pZGxlKGdyb3VwX2Nmc19ycShzZSkpKQ0KPiANCj4gWWVhaCwgaWYgd2Ug
Y2FuIHdpbmQgdXAgaGVyZSB0byBoaXQgdGhhdCB3YXJuaW5nLCB0aGVuIHdlIG5lZWQgdG8gZ2V0
IGl0DQo+IG91dCBvZiBkZWxheSBzdGF0ZSwgbm90IGp1c3QgbGVhdmUgaXQuIFdoZXRoZXIgZGVx
dWV1ZV9lbnRpdHkgKw0KPiBlbnF1ZXVlX2VudGl0eSBpcyBiZXR0ZXIgb3Igd29yc2UgdGhhbiBy
ZXF1ZXVlX2RlbGF5ZWRfZW50aXR5ICgrIGJyZWFrKSwgSSByZWFsbHkNCj4gZG9uJ3Qga25vdy4N
Cg0KSG0sIEknZCBzYXkgcmVxdWV1ZV9kZWxheWVkX2VudGl0eSgpIG5vdCBvbmx5IGZpdHMgYmV0
dGVyLCBpdCB1c2luZw0KbGVzcyBsaW5lcyBnaXZlcyBpdCBhbiBleHRyYSBicm93bmllIHBvaW50
Lg0KDQoJLU1pa2UNCg==

