Return-Path: <linux-kernel+bounces-395973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66B9BC5E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC861F22DD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C251CCED9;
	Tue,  5 Nov 2024 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Wuue8+18"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261181714A0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789216; cv=none; b=CV9JsXcRWk/j64L73yI6vg3uuu8xhjta8fDLg0EbUvnxenh4gCmHzVgmKEn8Fu/TD+loZ9vJmVOtyp4RsPp/Pztpoaz0j7vFVg+MXZuMg0g4VEk5dJPOQTkD928nIG7HqlU8ZCknZ22840356GKuOcvXy334wXkcZUx6ctGaiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789216; c=relaxed/simple;
	bh=qaKQec+Hpnn+oHpC4YJdaaTjHNfzeO7F59lm8xAy3N0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ee04HZ5P5kxYDX1p1G9wN9A4Y8kiRDSX2rdbVuKcsQIcoJ3lNUAiuIC/DGOWcgjDhPYis+3gH5Q3A51L2yqjOTuZ6voeqP8y22e+qDk14NYT9uSU3Cy7I+aqN62xR1WlagVcbwV4qoHHqJ2KI/XYJm+iwDiYr3Dk1lK4d6WA1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Wuue8+18; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730789178; x=1731393978; i=efault@gmx.de;
	bh=eADb/3ydFIgEAEkCv8/GG4rik3uXL2FZIS39X5p7CsI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wuue8+18+WIhCiqvq7CCo2f9GJaSOPA2IJ/s/ZLoWuAd4n1fGNuplLqQmQNAKJtN
	 kFG3B5LtSthz42FRr7AtTAkIyp0y0BLOajadwGfGgqKtZ4B/HTlVDyvbaObacjaMy
	 ThPJTXlrxk3PdyoGRtFSRsWiIx8YlBPPh8nZZjQQGFxDSTXb2cEep3/8BD2iHnpIH
	 47NaoJIrv2pQruwwJKqCEFC/g2fPDaWqqLkWJn3JkKgFrp3YQYzPKBdgMhrvDudAD
	 C4xXSCpqfDPwm780IM6T0T3C7E5IiFxaO5JCxf5wTSqTZxZvkoRjAokziphVBv9PE
	 4UjIQo4nmsImFMt7UA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.240]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1tIPoT2tJ1-00Ngyz; Tue, 05
 Nov 2024 07:46:18 +0100
Message-ID: <9af1bc3d9b0ddd5a4d672004cd9182017c320ec0.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Tue, 05 Nov 2024 07:46:16 +0100
In-Reply-To: <b8ed9d5d-4186-4b2a-aabf-d027d183c44a@amd.com>
References: <20240727102732.960974693@infradead.org>
	 <20240727105030.226163742@infradead.org>
	 <20241101124715.GA689589@pauld.westford.csb>
	 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <b8ed9d5d-4186-4b2a-aabf-d027d183c44a@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wRuUUkHZ0KaVZoRcXYpKffXTta119ydZNKjDdF1w9VWw6kVRWTI
 +XqmgEtyFDzcKQaYWhvct1ohq+BEc8Gkw1UTyHLedki1QJWBJXo6rN21LEMHWbuARj6ND25
 8kMPvH5uaMngbzJCwZhtAeflT1w9RhPX3FvZeERu1fXbTGY/xkXbB8ZsKFljioOVsPCoD8w
 yO3Xp45KlAYW7Ol99lVIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p9MLAXM0Tz8=;oLkw2EQH7O6ZE1FZve7YR1DN/Kp
 Pso8E9df55+iI6aibPLtybLFnrG7n7P/R+bhpBwAHlxnEEDBIOqTTSDn783nMGVI1wIoDhYsY
 Vx0eGhHmPSCGn5Rb/32HKEuM2jyIkSsWz+cNX6xNRapcK4ryll60xkS3hRmW5LBdFpv+mowCM
 PEtFuavK+HTWUTJkAPMmJ+gJOasRFhm7BmNhorgjNXyOHlWZgtjy4NL0xLGLrKdhDwXW7+Kqv
 hcQz5jWT4LYK9qpgnApiNron7q2ZHdIGyKJJ29mmJKkoIS7psRM8bdiEJGNskifPJTXVSzXx+
 VJL/4JIJNz26LZ3EOFluXwiNDaO0BQzwdILCG9tJ7AAsT8mFFU9QUphWgrEeH0LO+F5TnQKng
 ZUUT8qReLytvYb/A6beXYwz2ov2mFyW6lnQlqcVwA1fvWg0+/uqHUTHOZUNLFg0mpLool9A5E
 GeMucxWhXF1zLT19z9UJ7T7YgM9D6wpfyQaDEioJxHzS0r9e9b9ZabsnEQ3IlLgW15p6FoYmF
 e3YDREC49wj4LYckwfZaJb82RGXFklsfu7XVxvP+Cp8o1uoD6nthGrEfsO0zkCf2sIBJJsubE
 0BXnq2i0rUgnjSH44Phl/xzd+eBpFV73bzWTNm/7CQ0Sh2CtT1ChAbetc8IZiu5sEFJRV1ldm
 OPumIYEA0VtaxYXq0xWm/ZuPwdSt7qy8q3R5J/knsoUPub5Zl0DX1o4ZosbRHN0lyExwwK1GV
 BAOoRmSu2eg6gBLo5F+HCoVmzaI7WFyUUyO0rhMjErZ0fqwGwH7cSpX4AwHsCk0y5YDxWtxws
 i5GUjKqcMLKezvgF0tGgqQ3A==

On Tue, 2024-11-05 at 09:52 +0530, K Prateek Nayak wrote:
> Hello Mike,

Greetings,

> Would checking "p->nr_cpus_allowed > 1" be enough instead of doing a
> "cpumask_weight(p->cpus_ptr) > 1"?

Yeah (thwap).

> I was thinking, since the task is indeed delayed, there has to be more
> than one task on the runqueue right since a single task by itself cannot
> be ineligible and be marked for delayed dequeue?

But they migrate via LB, and idle balance unlocks the rq.
trace_printk() just verified that they do still both land with
sched_delayed intact and with nr_running =3D 1.

> The only time we
> encounter a delayed task with "rq->nr_running =3D=3D 1" is if the other
> tasks have been fully dequeued and pick_next_task() is in the process of
> picking off all the delayed task, but since that is done with the rq
> lock held in schedule(), it is even possible for the
> "rq->nr_running > 1" to be false here?

I don't see how, the rq being looked at is locked.

	-Mike

