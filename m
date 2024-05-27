Return-Path: <linux-kernel+bounces-190381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C68CFD83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A5B1F21B49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989D13A899;
	Mon, 27 May 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="HfSRAI1u"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C922E3F7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803660; cv=none; b=lomrAygP/QfQ8DsaMJR6tJTujPS3hdFoDEpLkzUXBZawutcOgPJCzlP/bjpjR5HDd/E+CJft9NHMlAWcZ1ivXEfHTj415io4BB99uVcxU44SDnsoAthU0cUC8wU+cwKea6+/7FOgfBaK8ue+upx2QiJj8zTy0yT7+3Xc8wJHmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803660; c=relaxed/simple;
	bh=ZBcLdnlmiabCK64X9/erbBZoGJk+/iupRLNrgz6Wiw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYJcOXupZXil3X2QX92edape5SdzmlAtV/D415nsI3jb6mX4akFL0nVO+hui11qRKqDvX1QEJp46fJJHvqm+hPlrJne7xYuQL1RlnPMqhxayQxL3CfDQkGIw1YPmb8otGhr5vFcm2YGwux3ES/swOGY+NBsVYZzYJL79DMNmUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=HfSRAI1u; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716803610; x=1717408410; i=efault@gmx.de;
	bh=ZBcLdnlmiabCK64X9/erbBZoGJk+/iupRLNrgz6Wiw8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HfSRAI1usGVvF6tYlN/yQ8HW9oAbpjkmQUoC97at4pYpL1PF31SdR394XcjbIiPV
	 zTcZuaV2iFdyiVUQ8oOwKEMCBlelv6R5377vi4XSvFarsteWOmv/ij5Vpbr4oOSgd
	 SZcS80ioDWQbcN/7jKVcDjzYDufIn363cnk5IdOeWGZXg7xDOw8GdSEqbIUoqRZz6
	 LyaqBsZNpPX813hcnaqKMD5H7k/6HClCReA5YrqdY4tcT046TNLTRBZVAsjPs6/1z
	 i2Meh+ZNqptmw8/nbvW/rDdHWIiVElpnqjKohGJ8wxe3hf7V6kT9LcFMF6pL+DkEg
	 ut4YIfI1xPeNWlKI0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.51.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1sFPCO1fAk-00G3YN; Mon, 27
 May 2024 11:53:30 +0200
Message-ID: <c9bf8022b4bbeb0bbd06df0e81a8ca2ea2802e7b.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, kprateek.nayak@amd.com
Cc: Chunxin Zang <spring.cxz@gmail.com>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org, yu.c.chen@intel.com,  yangchen11@lixiang.com,
 zhouchunhua@lixiang.com, zangchunxin@lixiang.com
Date: Mon, 27 May 2024 11:53:28 +0200
In-Reply-To: <20240527080503.GU22557@noisy.programming.kicks-ass.net>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
	 <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>
	 <20240527080503.GU22557@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XJS5pE2E6t/4wSjbMgMradyDWIbXcacDsD32EvYE+BvBHGDgAe1
 liyG2t3tt+4ooSxcYeYX4gMID1NNzmvJG8JayNYJF8qKg/+3oen5clhNnd46+zwL80lSvOG
 V6G1u8L37MBMf73WJkHE6GQgy+Tl9E91lypbYTKKw+GBnn6CeqnfTD73fPm/2Kiz1qE1muu
 jE27BlkrWN7YLyba/DcWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zEHWhffaPO8=;lLXoHCDBnPKbQR4kGa5KFz2/9zA
 dW6Br7WHyoDpMMuVyDR32BUg+UQTtlfRV8bUo/sAEOXq6faqELaPh1ghm4PRAuNeabuYU0uQ4
 W83+b/SFLxI5lqrUutLDWVT53sP3ERal4J6lTKFO8g7U5XpfD/EnkgGcDAzfx0/6XmBUlM+uc
 xDUXsPMmMwWbwEvP7gL9FRTMxWT/uZm50NgfeHkuoEw71mHFMK3ZXECGf+zaodt6UZ4EWLqJX
 qM9yyXBVbX6EuhzdZlyCC8ZFUDuTxlFfc/1wOF0ke1HvDh2MEye/qnwHJrSAPLO3F8vrZICHU
 IjGBTDhJFuUmTs8Wntn2IdbrozZ2cmhyy748idGdDZo/tWIGT4Z1RDY5O+ihpB1l8eAh46sZg
 ug5Sbj+2b4Y0UJ/BJHs4zX/zsfHH08QUBHcMiXipqXK5Zt1Oac9f89CnGbooIDlOFPDIdnNsE
 CicKnfDf7npiEjsEp7fA4wPAjqUCZkT/qc5c/oA3se3T4/CfdV4fNHWLOd5xXAj+Mp8fHERa+
 I2cyT84JnfVdN+UMVeir12z1E49HK1l6MY5O5XZxF7ohS4J26sBqtB45x9FnH0EbS3Hld3qvU
 AUsJD33JfyIERLgw8R4NCX0Cx5FMkMApVqHkD5hppSda7runLZGy5ZuCMjBJr3PyQY0cLK7c/
 rKxqwsQhVa9lPMiM53s5oARmtenWwLLSP/9UIcK+YcmF2liuLYIyBL2loSE0SkmDKVEWtlbSz
 gY18t5zs0OZnbn9oJLgN3l5ou3iGbWAv/9v8GBEhiXrhaqQEQXEacoIsrF2a6FhzRc7CPwRrG
 4wTcLOvo88+D5rYglWm/uv2cLdZ0LZLoKpJej5lniyk78=

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDEwOjA1ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gU2F0LCBNYXkgMjUsIDIwMjQgYXQgMDg6NDE6MjhBTSArMDIwMCwgTWlrZSBHYWxicmFp
dGggd3JvdGU6DQo+IA0KPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChwaWNrX2VldmRmKGNmc19ycSkg
PT0gcHNlKQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHByZWVtcHQ7
DQo+ID4gLQ0KPiA+IC3CoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gPiArwqDCoMKgwqDCoMKgwqBp
ZiAocGlja19lZXZkZihjZnNfcnEpID09IHNlKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm47DQo+IA0KPiBSaWdodCwgdGhpcyB3aWxsIHByZWVtcHQgbW9yZS4NCg0K
WWVhaCwgYW5kIGZvciBubyB0YW5naWJsZSBiZW5lZml0IHRoYXQgSSBjYW4gc2VlLiAgUmVwZWF0
aW5nIHRoZSBtaXhlZA0KbG9hZCBHVUkgdnMgY29tcHV0ZSB0ZXN0aW5nIGEgYnVuY2ggb2YgdGlt
ZXMsIHRoZXJlJ3MgZW5vdWdoIHZhcmlhbmNlDQp0byBzd2FtcCBhbnkgc2lnbmFsLg0KDQoJLU1p
a2UNCg==

