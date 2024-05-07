Return-Path: <linux-kernel+bounces-170698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2B8BDAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EDBB23D68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D76BFA7;
	Tue,  7 May 2024 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Btuy94LV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AC6BB50
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060143; cv=none; b=DO2AaMGYqbAAhXfNnQrWaDrfZdYMrpIRy1kHmMfMP2VReujvUq/cr61+kZGjoeHbpRLqBF3MzoD1CvISSLje7qUlGyINikGzGQhzxt0Ma7sOWxJh8jNyNGHCewBu4rJ5QguqE2wosLWxL5yDwP0Hw90ZC+cpMxqJBS87km/Xa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060143; c=relaxed/simple;
	bh=FCL8YRhr+t+Cu9rZB953GTcRtfbRychip2bA3RN8D/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEq5tdcCQ6NomXGhkkj+p7dNvlo7u87npSWfBzM94+nqvMgaQbcqt55WrqF9EIzueBrU99II/sPOEQfSKX4CE6OGX0e0DximbYmESd6HqSs60fQ+Q2q5pKdpFR3pIYuPK51ooruVuRjVFwMdlje/MwsVjR3qnWoGOxM/oeJpVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Btuy94LV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715060097; x=1715664897; i=efault@gmx.de;
	bh=FCL8YRhr+t+Cu9rZB953GTcRtfbRychip2bA3RN8D/E=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Btuy94LVcy0nVCknj6pW+6JG0KRa9AvW/QA0CvUM4Pdwk95eALaNFjjUWISIgndj
	 VH5g8cxLwr7N2HMrUgRnemRT4xeRb32V4ulsERoqZ0zTSG4ffHkALw8fFUF7aiclf
	 8hINdKszlIagPXnNDIynJvUOokhGcy4GkXERd/ePfgllQuBh9vbBwXwEjVthP887/
	 SznrrauXHjeN9kOj1DEyZ1dMZimDV40LppDu4bRmowlExskm5R7YxY3u1UIFOcH19
	 79YrvtYWTXC08Zqk3R1Pb1sUHV0P+9DAb0ZN3wBmUZQFqhXGLiP8j2THfyVlBfRfd
	 wcPDpgWtqnncAIrJHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1sCm5A02QD-00SLVT; Tue, 07
 May 2024 07:34:57 +0200
Message-ID: <22b6408d96ce3913121a4a1b80f343657d1f66ae.camel@gmx.de>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime
 to set request/slice suggestion
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com, tglx@linutronix.de
Date: Tue, 07 May 2024 07:34:54 +0200
In-Reply-To: <20240405110010.934104715@infradead.org>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.934104715@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:5mj5n1yLcFNTG1aCLteABz1aSATq6hhZ+MG6l7nLfQPDFRy3m6o
 nifde8vBCdbq5dt3lqfEDqmZgzO5wvaeL1Fa+QG5pjRNpojEOePHdbDUMEEBpnz0tqo78az
 Oz38vWXnZWh8PiQf63EC/VrbtZ8Det00cvaLKjKOmyPDXr9LRgG1+5k0qLfqYLzo9hCG7o8
 aWqqPxW4phiJSdmwH8OAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aKprqdTMeWU=;pvbELLjuycRoIVJBBXGaKTOuYgj
 zRH76Xh4Yb9E0We7DmXkJw9wLD+eRrYe71lCaq/KvoUIPa/gUwVcDFXgrRRsznKbiNEI+ldvk
 gDY+Xl4E33psPs39dHO5P9ZFAxomhaFz3l4OtJIyprmnURTM8BLX+n7A68IjkMhdZbt8aGc5D
 efTG4ojOO3UOKtgnt4zkvgOjClg3JlxHH5CbC4c0g5wM70vXNySynf0js/HEhtASUmpy2kmeb
 aAXANMANC7jmNjqokjgiHhIGxs9o70sHogoHLyw3QaEy6QzAWP9kVwMCR6+7Iu410kOnpFnr/
 08LCrSRk0lkpHAOkMcALJCEKPsYYu9s/vRLrvKVWbszdOoxL/OKOiuez5PKrQEzix5uybvO0t
 OHLSKaLgYY/PhMGyLxAumS2a5zndd2dNgBPSxjy0CD8v0P7sGolduJQ8v+xHrSF39on5aaojJ
 J9yGWMcNNczr30rv9qraI2wWdWkiyDmJBvugVlzfMFoqpFo05gqF8rpL73Yb2abdpfe8gVkGB
 zLvYyVDYpX8+vRTLTdXtRL3/FprTIoIjQekbT4Ue7US3UzH/om6FZlGIWX/yBzXcAwTkYuHz2
 G2rx+AhEiJBxHuFx9PL/tnwfUD2LGnIOIdJZ8tx5UWcRtS21jb60SrHer1wQx4iOtapvPr6qm
 42OnpKMcnoZ4QWagm+G9D/p7hFGXA+yfBGTWk8AygkNWi7kKVffkCdqqXTdGJuroDO/a3zLGF
 MUzOjZ8ET9CkRR1yDtNIYVH1kIKer6iD9YtDN/zeBlKJee7VZu8VHmGvbUW1l/CBNj+6749Oe
 vj71sVqgPCmCxYnCiAv8vjkvkJegIkeRbtfF27NONS+aA=

T24gRnJpLCAyMDI0LTA0LTA1IGF0IDEyOjI4ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gDQo+IC0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2Nv
cmUuYw0KPiBAQCAtNzgxMiw3ICs3ODIzLDkgQEAgc3RhdGljIGludCBfX3NjaGVkX3NldHNjaGVk
dWxlcihzdHJ1Y3QgdA0KPiDCoMKgwqDCoMKgwqDCoMKgICogYnV0IHN0b3JlIGEgcG9zc2libGUg
bW9kaWZpY2F0aW9uIG9mIHJlc2V0X29uX2ZvcmsuDQo+IMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4g
wqDCoMKgwqDCoMKgwqDCoGlmICh1bmxpa2VseShwb2xpY3kgPT0gcC0+cG9saWN5KSkgew0KPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGZhaXJfcG9saWN5KHBvbGljeSkgJiYg
YXR0ci0+c2NoZWRfbmljZSAhPSB0YXNrX25pY2UocCkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAoZmFpcl9wb2xpY3kocG9saWN5KSAmJg0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChhdHRyLT5zY2hlZF9uaWNlICE9IHRhc2tfbmljZShwKSB8
fA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGF0dHItPnNjaGVk
X3J1bnRpbWUgJiYgYXR0ci0+c2NoZWRfcnVudGltZSAhPSBwLT5zZS5zbGljZSkpKQ0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGNoYW5nZTsN
Cg0KQ2FuIHdlIG1ha2UgdGhhdCBvbmx5IGxvb2sgYXQgYXR0ci0+c2NoZWRfcnVudGltZSAhPSBw
LT5zZS5zbGljZT8gDQpEb2luZyBzbyBsZXRzIHlvdSBjbGVhciBhIGN1c3RvbSBzbGljZSBieS4u
IGNsZWFyaW5nIGl0Li4gcmF0aGVyIHRoYW4NCm1ha2luZyB0b29scyBydW1tYWdlIGFib3V0IGZv
ciB0aGUgcHJvcGVyIHZhbHVlIHRvIG92ZXJ3cml0ZS4NCg0KCS1NaWtlDQo=

