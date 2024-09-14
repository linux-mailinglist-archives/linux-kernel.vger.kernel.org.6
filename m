Return-Path: <linux-kernel+bounces-329088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FEE978D26
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FDD1C220CF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9717741;
	Sat, 14 Sep 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="kpleViQN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2CD268
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726285270; cv=none; b=Gj07Mojv+AmTVwg3t8D/uHWagKcmk7uCgiKWEMIKUpZSGeih6ZqlAeuC52af0qkQVVjjfDMxiWkTG2VqaNedfrTdip7pWryU+jBVk7ykTvXbI6THRR0r4rVV11NQHb311ANMfibqexWmkOf5chnT5Jy/FRhOWD3f7Tt96bwd+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726285270; c=relaxed/simple;
	bh=fwEWE2ixhTG0xRs19wQLcbBEa0V9BDR4kEp5L6g95U0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=laXJZ4BCLrXAHBrNr/BEB6DJTPcIFyez3q5O32H+EL9FGKCqmuP2POGyIrZNRYgUZ+vChos2Pnn1K/QLvhhXT6zpEvnSn4O44Nw6DTWqFoDS+WRxQQlKU2VsBfK72f+UyhSdKhv81jtLyUiPNv0RYmwhMscoCrNmZHSvSEVQRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=kpleViQN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726285217; x=1726890017; i=efault@gmx.de;
	bh=dB4Skh2UtkDhTwFcsFU4sqXbROwgN8lZZpycnWZy6mw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kpleViQNk//Lq+8oiJ2CtYIqzN57tglJ3iNyr7fj6H33HRouvdIIqC9515fBNNeO
	 rtMoXRs88tqey7o5VYcYhmhdroxc3mEaxKTdOb+X0LXm8v55a5QJkjGHrIBYPaRt6
	 dGM/c/wo9e7Rf1iB1/CKunHJM/n/ePo/JMktQJYGUrgYjvpcZg/ZTV2jUfPI8jxW+
	 lHSj5avleqmenoP4qCyz9EldnqoFnnSEUmUFhbIHYv7lquJ92zioeAnD0wfS5AuA8
	 U0p24PhikNodYgCdIKJmRDJStpdWCA4wcnlAJ0cbX73DheItOTPmsQ4FolwcNwIMI
	 28bzphcBJpz28zY9Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.246]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1rwJFA2jUH-00sN25; Sat, 14
 Sep 2024 05:40:17 +0200
Message-ID: <1e89e5bcbd43934c65f8da23e7fbd59da950a0a3.camel@gmx.de>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Luis Machado <luis.machado@arm.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org,  bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Sat, 14 Sep 2024 05:40:15 +0200
In-Reply-To: <627e37090198cee91bf79c41b1cd8c20c2e2d71f.camel@gmx.de>
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
	 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
	 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
	 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
	 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
	 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
	 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
	 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
	 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
	 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
	 <20240911091328.GM4723@noisy.programming.kicks-ass.net>
	 <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
	 <a96858374fb06ba38dd5eea5561cc7542220416e.camel@gmx.de>
	 <627e37090198cee91bf79c41b1cd8c20c2e2d71f.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1G0+yAZH9N0NvtqvLAWJFzRfWmjmAMkXKOnZmsqm92uYXLvBtUd
 A2dX17PBjOTaHafWOzpPkQh7C+iIcD91zOTqkEHDrvDyRix1QwBB/6x0e8NNzGuHfsO3hkF
 d+ZUfqM150KTHE9tSLG/WqRCn+ymrWTXACHm6d3dSIWAz9R0d8Twyfu+G6fxzEA7fuDL3wg
 CMTgtOzghLrWgojf0TAQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nDaIsrao4sY=;BVUq64ONfTNA6IS/VhoS1WRFfKd
 9g0XMPyeRpkyxzkEpqGtPYJYBHROa2QaR0YGwPqblnp24YY6SllST6fU0X7xEfWFYB5q3Z0ZF
 LhS3EoVEmBllaSLzxbJd/04xUHr3DoF4FN2B05lGmIFMc0viKkDx3aTqhXTtlfF2DizkCku/Z
 oDIi3G4ySX5uzYdnUTHKAD8ti3eJPy6jmUTrRdKr3vTEQTU/FJ+TXFwOVCCq/YnIIjS5CsXo8
 cwK+3JJIVY2yPY9x+hZpL7WQvuq3vTHF+AxTw3UHWKcwhqJzg2hg9GbZXSV1M9xjVSvDkWcnS
 EdrdIqbkbM0BTr00zEfJ9c0ceMkzStqDqP6f0yJqk2B8zyqZjUt5SMfrhiIV/TORvT6IrN8fj
 N4CNsseCH2b25PxXWzd7Ptq1jhqaT3M84IJf6OWj5k9JOMd5UJDoW1NFUUnkaRsxufsosXNxr
 kDDxQChHbSQCJU0RcoDDBAA2N9Qrl1roYGLB+qznJ7RedCqXymH6Lq71bxkcy8S/kH/QBXvvN
 /jC9kb76et09voz47+zkqUmCqXTaSxrbOvshRpYeIpdolxxuQdJZpE2aHd2oAFVyD9UwNLwcS
 nQXY8u5wyvWLSAxBlm1cRSZTZvwzjH11SNGfeEV4TUAnbuRzmroTm1ay2/sJFVZSn9lKV2uFP
 ypjZuYd8C0+Nf1yp191uebGk+6iGLOPH10QBa5JDA4hnirMF+TrvMY28CGP9c8a4bhj3cwfeK
 aTlxqmjXXGLq+9Mpc0Ld1SaATUMm+zfDQeTR8ruHJmiQyGatg//Q2ILpiAY5wxX5BKEzJWKD6
 fHxZ+B5p79fzAJp7G72fi4rQ==

On Fri, 2024-09-13 at 18:39 +0200, Mike Galbraith wrote:
> tip 4c293d0fa315 (sans sched/eevdf: More PELT vs DELAYED_DEQUEUE) seems
> to be stable.

Belay that, it went boom immediately this morning while trying to
trigger a warning I met elsewhere.

	-Mike

