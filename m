Return-Path: <linux-kernel+bounces-399306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88A9BFD2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140C8B2286A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4118FDDF;
	Thu,  7 Nov 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="kmdR20TA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994218FDA3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952275; cv=none; b=oKLM9vixuskE/yYv4VWWhVgIDHUIC9EytAuHhwKbPHn7Anof2tGTPLfx3C4zqanV9HWjihq80X4jV61wxRHtWYXNZcpEnSCckRAeEWaTLwM4RSsfMsWmkE3HmGu1qF4vayRMji/uFMaokkuV6xX0Pp+cVbmNJw/8C2wxtE829PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952275; c=relaxed/simple;
	bh=27tTQU34NjaE5CtqewEl6SGPHLgY5q1n0RMT5Wz6yn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CU2G4YTK4Us5e6ObaQJGPVzIY6wRZTB+C8H4nxhOc3X6ow5AoMEEwIPOkL5wVR8O8To/F6meTo40ziftTAbs0scB2LmTIOAte0Y5CXoktVbK87FCaNfQlhNRxroJuK9qEYzTyPHMCEe9geVg7AuOARHYnjGlyRVvdy7zN0LSEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=kmdR20TA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730952230; x=1731557030; i=efault@gmx.de;
	bh=I7GZsvRdDLC/Y4aETXsL4gaFGf8/Kwwk5pLerMnWhV8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kmdR20TAmwkRZs1Zyllaxh3H94E1WJRw5aRu9EKUfbhean6sEUw32VwBwhERoi2l
	 tL+UfvbJSe2UMEuP2r2Y/QoE+DE+iMy92DaUuDNVx9WOF7Yj9nE+JTw9NbALaB6X5
	 8rs9Hw9FnrQeje2M54j2dzkxOdIQWhh+dDrP9yhC5v/3CkPtGDyNatEaTy4m5VnEc
	 AJS+tXGn2obykrWjjJ4QV8Xc0bF70zZWtDxVf5WvWzlXUz5fk298mD1Cb0C8MwPMy
	 v9635eNjABxuUi0yrx/d62Zw+FT+tcl8+Ue0GdPXusz/qj8LGDVifYbzKxQPjAQ6d
	 gpRadwcG98ObUT43FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.61]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1t7WAf26bD-00EcdL; Thu, 07
 Nov 2024 05:03:50 +0100
Message-ID: <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Thu, 07 Nov 2024 05:03:49 +0100
In-Reply-To: <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
References: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
	 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EomAJGyprbJXddmBsrCJ50FDwlMbd/BuTiVIRK/4MR9/atRKU8y
 OQutsLt0seXtCnUmZr1RLu0t2UE9sCFTQ2txfGdx2L4LImjlDeaXtoabcQQmN2/i4O9kixW
 GHZFgc0zFi791jTAesZNdC0dGidiCDC05/KQWBepafDje41fY38o1jORc2UKnXiRAwn14ho
 ZzSs6XdXk9VC6yki9DHeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:efSZEt1cm2E=;ZRtiXivjKz3L6x9yWYeGcZA7Je6
 fZ4wukKjduxHoTbU7xKn/JSTsfE5yc8kOzkBma6F3r/7KwBZLr3yQxJcaVxjdcvpb24nmZRYL
 Jv69kS9V66xuslpQSRhlofIme4jO+YPUQwDem6paGhHc9aAs3Oe6EG21G2ckOL5u+mf8LBm3h
 HJUac5MxtwkePp/odemK6NtFZd6FXbPtzAyoPLFfyerPf30bmm1LXUZErgJZPGapScFZCpLEY
 6KDfZq48ERUKK+QLJC6RqSgbD50biNj6NQvMA3haSnhopmqxCYgQQjnFa4X2pTRXe2IGO8LZ6
 1JVvQ3t3u8zQi/LaZvTOD5rvAvWLTPtvZt9Mdk1aA033vKcCkmE8krMSyxCgSjkboR9F6PjmR
 glxeeC73YP80fQWUL/JGqP4akNbgd4cL6Yz2CQkExGmhbvHt72R2EQJ0KCkq2glajsfhJdnP8
 TSNwocEOvdNyOF2KjUQp4guyiigh0jrCJp0mgF6wESuPzsT1QCb3ULY5XQPiWgB5zKbHcBtXd
 bjMRbj8QhOwsa9ShmGRQQ1LaKDv4zbUUNVq9fE7XSLVRMBItjtCl1GQkqElCH9JOAA9W0nqYB
 EFKxPPK34QKSJmzF+rO5Jk4mpFasguez+eJQC2dWIzrNEIw1mOlJkOfFW9LzPP9JWk2wIVPs0
 +KOmeYCq8Y7YjNjMxKYHO3f0S0XZiDcaa5eJhq3G1NxO8vBim08dfTl7Tol+4iijiPipbiaB6
 YGISfyof4esCaFElSvHyKT9SO/hvMEY9Rfks/0SzwWGIeOank0BoPfCcsHTe1sgfmU0xQNc/5
 LZedcnf6yhYkJRDJXfcI1GdYVQyxEz9qM20plT8YRInK6T5oGI6ur9hUO2b5gXDEbDPKjE++O
 Xxy1cAwYEih9cgHlXNTOh5LlnUGwqCsdSZu7FmCSbV569JI+raDghHajQ

On Wed, 2024-11-06 at 16:22 +0100, Mike Galbraith wrote:
>
> Hm, if we try to bounce a preempted task and fail, the wakeup_preempt()
> call won't happen.

Zzzt, wrong, falling through still leads to the bottom of a wakeup with
its preempt check...

> Bouncing preempted tasks is double edged sword..

..but that bit is pretty intriguing.  From the service latency and
utilization perspective only at decision time (prime mission), it's an
obvious win to migrate to an idle CPU.

It's also a clear win for communication latency when buddies are NOT
popular but misused end to end latency measurement tools ala TCP_RR
with only microscopic concurrency. For the other netperf modes of
operation, there's no shortage of concurrency to salvage *and get out
of the communication stream*, and I think that applies to wide swaths
of the real world.  What makes it intriguing is the cross-over point
where "stacking is the stupidest idea ever" becomes "stacking may put
my and my buddy's wide butts directly in our own communication stream,
but that's less pain than what unrelated wide butts inflict on top of
higher LLC vs L2 latency".

For UDP_STREAM (async to the bone), there is no such a point, it would
seemingly prefer its buddy call from orbit, but for its more reasonable
TCP brother and ilk, there is.

Sample numbers (talk), interference is 8 unbound 88% compute instances,
box is crusty ole 8 rq i7-4790.

UDP_STREAM-1    unbound    Avg:  47135  Sum:    47135
UDP_STREAM-1    stacked    Avg:  39602  Sum:    39602
UDP_STREAM-1    cross-smt  Avg:  61599  Sum:    61599
UDP_STREAM-1    cross-core Avg:  67680  Sum:    67680

(distancia muy bueno!)

TCP_STREAM-1    unbound    Avg:  26299  Sum:    26299
TCP_STREAM-1    stacked    Avg:  27893  Sum:    27893
TCP_STREAM-1    cross-smt  Avg:  16728  Sum:    16728
TCP_STREAM-1    cross-core Avg:  13877  Sum:    13877

(idiota, distancia NO bueno, castillo inflable muy bueno!)

Service latency dominates.. not quite always, and bouncing tasks about
is simultaneously the only sane thing to do and pure evil... like
everything else in sched land, making it a hard game to win :)

I built that patch out of curiosity, and yeah, set_next_task_fair()
finding a cfs_rq->curr ends play time pretty quickly.  Too bad my
service latency is a bit dinged up, bouncing preempted wakees about
promises to be interesting.

	-Mike

