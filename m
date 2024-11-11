Return-Path: <linux-kernel+bounces-403559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DAA9C3732
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3B1F21FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C7B13B7A3;
	Mon, 11 Nov 2024 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="W/7QkhIJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF0184F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297262; cv=none; b=IJ7Vc/9Nh8UkfUlSuMIspSv40/YylsOJaKaTXVktWGsqMLtDtTwbtOkyAqwV18l7hL9Bq/rkb/PIzewTI4igGYYrDfgykWVKTL5nul0qyoErrDV9/svACows9Ehw4qwzcQE4G6fHQQXj7rdZU4rxyN/OeQI3FR6qmNHougQIexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297262; c=relaxed/simple;
	bh=ocO91ko0x3vs73x3Pcn2zy2W0f/DSu+IARh6RZkcquA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfhompoVhJnrwpD34lXg89kNxNF23HSb3JKTqKL6n6IIP/DeQGokJxTzpl4YtRLekXpwPCtPIa62+/1oQ4bS556uZ+aKtmuZbMnia3Nr22I11di2R3KG9E25v2MlUQrKdqKjFCJrcYIVqD1hxt3e1/mEeXpRlkIelA4yMKGmfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=W/7QkhIJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731297201; x=1731902001; i=efault@gmx.de;
	bh=ocO91ko0x3vs73x3Pcn2zy2W0f/DSu+IARh6RZkcquA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W/7QkhIJvBMdXl/NZ+3ExOlH6Y3soobqV46QYISRAZsYjj4aV8lzrv4RAZDhxiV3
	 m4JV5RPZlZ0maTNOvsww10q5VEc2Doa7p8tRhIsicRxvK+vMoS9dRaR8qrAsiZpqZ
	 Qe2NKzHmw7bmcqFuhPPZmIY21iEztlUQbugI4u0oiliuQRcG0MmarEUwnFtnD77dW
	 onu2+6BkWdBRdE6TvevpLsR9+aVCQTo0KUGa6zTw07m9yRL3X5E5/bDvHn1b8HROP
	 805UTbDdzDReyrz35uDBAeJFre8kIM6qa9uM1/d0x99Ar9heQ0F5eJc9Hmaeld1MB
	 LfEt3CwHuzjTgFU7pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.232]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1tQTCG28x3-00NCBP; Mon, 11
 Nov 2024 04:53:21 +0100
Message-ID: <77ecfc1eb73a1e9be098df3cccece76136bf07ca.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to
 a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>, 
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de,  vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com,  wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, Xuewen Yan
 <xuewen.yan@unisoc.com>, Qais Yousef <qyousef@layalina.io>
Date: Mon, 11 Nov 2024 04:53:18 +0100
In-Reply-To: <CAB8ipk-rE8+ayPE1ctGKZ=ft2d-Ck0K8KNb4nRiTjg+UpQB=xA@mail.gmail.com>
References: <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
	 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
	 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
	 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
	 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
	 <CAB8ipk-rE8+ayPE1ctGKZ=ft2d-Ck0K8KNb4nRiTjg+UpQB=xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:EnEsoMpy2Mc86iJ0iKbnyikYpnSJsom0NtFY5DiZqF3qSDlH9Xl
 nvX+YdTpSKLrNy2lqo+7Dc0YNcjLy7GpxZXTJrsY6mfbQFcQD9I7XkrFLinDpV0lWgZmvSW
 iGMTrY1ZCe/0wwdAbVWcgakhGvqT6vYqh6iWHClqnkShMFSzj41l66mBAbpE4n37Y2aJRcH
 QQ1C885eeP0u8sdZldPwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dzp0axOsSxY=;u7qoyDPcTum5n0DBo5SC2qJdNcy
 SwoeyGuyS1uXeOuIQY3wnK2OBEJhyEsTtkQmU74EDa2DBdUxVcqU8aaQ28xkxnoIKLOs6+ufu
 4B5P9/ERDoRZwat8zdH6weteboANbAkSyxMqNE8ghu2+3JaMQVhzgSE2hEzXYlQn+jAWCAPZq
 CaprJHSRRhNH63cWpuDoiwR6KRb9Give2+lTgpjl1OSVpd2u5qIaVVqYsQWf3nafOEIrkEyfZ
 L8eYfREL9Rto7hk25Sr1xcGd9E7Ikt5KA00QgtBgH/O1N2/0sFThyurvVf+zGcJ9y+xNSiD51
 tvA6EshHsQKBkXCS9w60M26N61p0+RchcJPLs8o7rU4pKTcJQpi/V/wYePM0qYdJvFbXCHf/7
 6G8xzDOhVBmik7wX3hFUvuKsHeqHWyJkSFtg3uMghEFFO71bvhan46BEYjdgxWHTs+Dr80YdZ
 vpqYLJOkkaSVvIyud+b+ou+nRP4oVsy+4M/0l3cCo/UDvG3YHAMEBbsODCK85lKhMlWKsIVKo
 In/OHTbWMxBabuJktNGAiEczs6oRm/JKb5zL1S0KI69R3RrZx55Wcj1tCuCElOlV9dM5Rqzgz
 wyMWSSPIjlcMikqPpgXUGoF+SDxQ/l407s9Kqdw7cs8Sn6LfH301sAK2vSxzv1M+bZXHilhyU
 4ZshyBu79jPoOAWv4Iq1dLyqM3J1NQFQbozfv/jbTwpmE3hBPpbjDotl2Tq4xJ3A4zVHYBrRt
 II3/Yzy0xSlWjUqD29oRCMrxYXI/lmg2S2FmmJ/Ig4o7OpuN+56sJ8h1jnAc/KQ4wmQQgU4YE
 nkGh79JM9u9Fj5sOAiyJgc2jgZ+03M1n93wtg+Gzb18ORr7aGvjffv72C1P87oHeVoS2ndFkh
 mbGIcR0i9LTxzPKLfG9ukSBwMeEOpzn8OocnrricMs+bSCCLOOAcHl8Qi

T24gTW9uLCAyMDI0LTExLTExIGF0IDEwOjQ2ICswODAwLCBYdWV3ZW4gWWFuIHdyb3RlOg0KPiA+
IA0KPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHAtPnNlLnNjaGVkX2RlbGF5ZWQpIHsNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgcXVldWVfZmxhZ3MgPSBFTlFVRVVFX0RFTEFZ
RUQgfCBFTlFVRVVFX05PQ0xPQ0s7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFNpbmNlIHNj
aGVkX2RlbGF5ZWQgbWVhbnMgd2UgY2Fubm90IGJlIGN1cnJlbnQgYW55d2hlcmUsDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRlcXVldWUgaXQgaGVyZSBhbmQgaGF2ZSBp
dCBmYWxsIHRocm91Z2ggdG8gdGhlDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIHNlbGVjdF90YXNrX3JxKCkgY2FzZSBmdXJ0aGVyIGFsb25nIHRoZSB0dHd1KCkgcGF0aC4N
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJxLT5ucl9ydW5uaW5nID4gMSAmJiBwLT5ucl9jcHVzX2Fs
bG93ZWQgPiAxKSB7DQo+IA0KPiBGb3Igc2NoZWRfYXN5bV9jcHVjYXBhY2l0eSBzeXN0ZW0sIG5l
ZWQgd2UgY29uc2lkZXIgdGhlDQo+IHRhc2tfZml0c19jcHVfY2FwYWNpdHkgdGhlcmU/DQoNCkkg
ZG9uJ3QgdGhpbmsgc28uICBXYWtldXAgcGxhY2VtZW50IGxvZ2ljIGlzIHdoYXQgd2UncmUgZGVm
bGVjdGluZyB0aGUNCndha2VlIHRvd2FyZCwgdGhpcyBpcyBub3QgdGhlIHJpZ2h0IHNwb3QgdG8g
YWRkIGFueSBjb21wbGV4aXR5Lg0KDQoNCgktTWlrZQ0K

