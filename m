Return-Path: <linux-kernel+bounces-174141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A156D8C0ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16981C21C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21495149006;
	Thu,  9 May 2024 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="G1RLaI/F"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D028373
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230872; cv=none; b=VWNGrVPX1NvF5MEHAY6u6Z4FtmhnomKJVPUL94Q0XiGQXahptAhxAgYeeYPP64S22Ipz7Kp/0Y1X6r2wXfgXOvSrI50zi+//etjqFfIqAPHgqzuVCEOUQWIhieeqZiApGe5gpDI7aPdf02gElVrza9GXsEwNRsPzjkvc4qgvG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230872; c=relaxed/simple;
	bh=4x0gsReYDFDPrW0BFz65xuSmqH37neQnQ6EMuel0kXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/A6kO5yTfN4r4daXbdTG2aejgFOkWT0Fdy4lAwjStAS4mxEgY+MZwuIvGM8sF60zhj+S65LMcIvJhu3Qt0X/cJ8vcOPxcHqnvlJGne4eIWoKQNohZCFpXeNgG12T8ug7Wg+wjaW/a1kI8W5Xkxf7LRKAwXI4SHT8yv9Y1btDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=G1RLaI/F; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715230816; x=1715835616; i=efault@gmx.de;
	bh=UuxZzsTEELEHmQYULWtJiXtg8qSf5xzPaKf1Cp0y3CM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G1RLaI/FO7jzkt+V2FbbUBc7KynjNaITLCCJUqqJAJj3A5QgRfbqRkWC+HIW7ILX
	 V2Ul2ALLFa593INGH9FakjCQ/V9Th7KTWkTo6CI+WodwjdM2XuX6eiKWgZqF8eCal
	 Rqw8a8xEO8kd3ZIfhGHoPTe8Tnp1iOqxsB47TY/ri0l6bkH+viajIq28HGtJcVgY8
	 Hp9Z76bTlRvnQJpm5CrXUKnuZr540es6rdBXegOatGgk/pgixLMj8g2I4jMOSqL/P
	 pVsvqkQjp+GC98ZrQLOpgEm6w65B9Z8pNAQM17ggHzZyHGCqDZC+O8yrao6j/0JF1
	 f0Z7nA9O2lCKpWttOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.253]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1sI2t544ci-00PIof; Thu, 09
 May 2024 07:00:16 +0200
Message-ID: <ae4545e2004395f345ac030635ba72a1e16ec2fe.camel@gmx.de>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime
 to set request/slice suggestion
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
 wuyun.abel@bytedance.com, tglx@linutronix.de, tim.c.chen@intel.com, 
 yu.c.chen.y@gmail.com
Date: Thu, 09 May 2024 07:00:13 +0200
In-Reply-To: <ZjxHlLQv1WuFq+SC@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.934104715@infradead.org> <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
	 <9c360c0d337b124c71095f06889d1c69279a7c06.camel@gmx.de>
	 <ZjxHlLQv1WuFq+SC@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:km7XOlV+iZTX5Pbj0mzycx9dHsKyHRgmw3Fzp554IWSdRIYgGmx
 PwiphjC48ndCXjI7Ww2hHcx3psPVvr4+2OTHLM6uPfVRjYqGjFtTtmvRAw+TUOTC+e6eF65
 GBAa9vcOdz1uEW1w6MlysWnKCXfHOqSyx7IipAzNwQsh9rbVlUtHRw4ky3x0sST7dDaoEIZ
 jw71wMp9CJJGiMaoeydpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LuImmvoTdTw=;r6EDsHiqRYcZ1+UZD8fAbq0VGcv
 /oUkkMeYizoWIGWzB2rx5GxlqY/tYbnENXOAQfmFlHpM7fZ88h1YkpaAhErRySdwtDIMwn/Re
 jFpQQQzIrnEu1HqLtc6MCEWrssHm/vDRc5zk0CrGOVBKTIpc1y6UAyPBujZTxANcUGoSCX7ob
 sBQm8n2ri8Vw4VbSQ4TjrjqbPTw3P/Cr6zf0N7SDjrlyUj4G9fsUpV79yyxx1BUN+I2cjYQdi
 16f5ObqME0ERky0ROZ4av6hPZ1VEYEPtB+MlaYCehHnhYxE0Tv4K+FbIWfhRv88rmljNVlqKO
 8OC5F3iNJPHbWza95mMSTQ04cW3ixhLB3FGcMneez8fM/BJt7pQsFLeV+zbBafc1WMvLd5WBK
 qz19R6YtGxz+9pNya99ZWZS8/ncQm1plAsGyyPypfnEuPaki8dLx38olkAIaoVQxziLTPGngs
 xi8mOZv5IZpFX7vjpc52lQcsbIKyew97hkzckwdDxKwqlnJq2F1+1n3NELHszFRVrjfoKnI3K
 AtEaEgh/R0Ls1NdW6W58LIUgamnFfMVuWR6tzaVvCcbWVftWwOKuwQd6SYF1CPlKe8mHpo68L
 ajEtVpmc1oF1XVFDn6FhljhCzAzT9kaKY4xBdrI++2UStYLy6Th8QUIc7yN+K3TyzVhzUM8Ly
 WER1CRRH1MSYdBz4fy6DT0NKxxjaiK17bZzTRVORLbYN/NS2+UkT+XOH7jANgpfuFaThvs9rt
 5F/WTkxg7nu2SAiM8b+LxkuBT1c0EObRy3RwKuZ1CQ93IRaxWYjjmApSvv3MnVQJzthv/lp8c
 ZuCAwM195FSjDjKreZmExKutYtjjrgo0vOltIWHreieYM=

On Thu, 2024-05-09 at 11:48 +0800, Chen Yu wrote:

> And I agree we should take the platform size(such
> as CPU number) into consideration.

I think you'll need more that that, because size agnostic, when it
comes to latency, an idle CPU is damn hard to beat, making migration
restrictions (traditional and obvious target) tend to leave highly
annoying piles of collateral damage in their wake.

(spoken from BTDT perspective, have t-shirt, got butt kicked;)

	-Mike

