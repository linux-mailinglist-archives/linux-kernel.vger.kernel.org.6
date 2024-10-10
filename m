Return-Path: <linux-kernel+bounces-358474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2B997FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C691F220E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F891C6884;
	Thu, 10 Oct 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipFRrr1v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QcngExWa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAE1552FC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546468; cv=none; b=NjL/dYDu3k6OHbZyXY2OHwULqC3sp9rSaobu4Z7soDCq1+hK/rJmueme7OVYIJy20OlhwxAFJv+Sng2ugoKFYpbrq7/yFs97HFH13WatSBRGTPVzT652r2f3p0yZ5OABBwrE8imuqk0mdQ1v+LB/UYSBaWGeOS5K4Ux2XCL1v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546468; c=relaxed/simple;
	bh=bmvSxtWkByJXS+Xt1drG0ZubkKNtyfuNSWwrWsYXD20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+QJwdxgn0ww0gY49HvUru7lvV7OiOFddRE96x0Ryn/wJX4xWZ10XpBxxGudUxCgr9gCWnFczz7LAjWyCUZkYxqSmnQA15jpDa7Di0hTnfOw/8GWxw0eqGi4QgRs2s3f/KufUTIqhb2JX1b+AL/rZNHJCgs2Kx3W9egswL4gx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipFRrr1v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QcngExWa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728546463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkA8zzob3Z4Ow4941/t3NkqJOGE310GZmzj7i1rHS2k=;
	b=ipFRrr1v5q+Jp2OAnxzyf/1YD12OQlqqyHa7XdbxCldYjRr7ocB3ZvGo46cBpihij1Osfi
	4xlybNlunwJH/xS4OVl7V3qsfZR94PkXXX02d0gKhAyoOu4a+xpeVrPR+U0dJt295tYxHN
	n/1iHQnEsQgmGEP4KKRbO+DKUXVKpGoZ907WGnjeQitffqPZQoUWfDluidUWJ6Kkig3WAH
	79GeMSGEntQiGylykxBToF84N/pSRrzVU0ecluupdcFwCN/6bLCcTb0wcw/A73waUdeSos
	Y95I7OZB0eb30B+vJa6xdpBi9MgnnXyXHXMNowMitEwFIUCP4jsCSvtW5dQDiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728546463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkA8zzob3Z4Ow4941/t3NkqJOGE310GZmzj7i1rHS2k=;
	b=QcngExWaHhp05sGxbsiUU55YJbItQxj8mLDCdsK0pBEvPDamB3GYY/gzAlyJp2j8fLUKqV
	ZkbIlhlH4773UpBQ==
To: Tianchen Ding <dtcccc@linux.alibaba.com>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <02bfe2cc-ee08-4c81-951f-9b7ab9de2b24@linux.alibaba.com>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home>
 <02bfe2cc-ee08-4c81-951f-9b7ab9de2b24@linux.alibaba.com>
Date: Thu, 10 Oct 2024 09:47:42 +0200
Message-ID: <87bjzsield.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 11:12, Tianchen Ding wrote:
> On 2024/10/10 04:43, Steven Rostedt wrote:
>> Perhaps these cond_resched() is proper? That is, the need_resched() /
>> cond_resched() is not something that is being done for PREEMPT_NONE, but
>> for preempt/voluntary kernels too. Maybe these cond_resched() should stay?
>> If we spin in the loop for one more tick, that is actually changing the
>> behavior of PREEMPT_NONE and PREEMPT_VOLUNTARY, as the need_resched()/cond_resched()
>> helps with latency. If we just wait for the next tick, these loops (and
>> there's a lot of them) will all now run for one tick longer than if
>> PREEMPT_NONE or PREEMPT_VOLUNTARY were set today.
>> 
>
> Agree.
>
> And for PREEMPT_LAZIEST, this becomes worse. The fair_class tasks will be 
> delayed more than 1 tick. They may be starved until a non-fair class task comes 
> to "save" them.

Everybody agreed already that PREEMPT_LAZIEST is silly and not going to
happen. Nothing to see here.

> cond_resched() is designed for NONE/VOLUNTARY to avoid spinning in kernel and 
> prevent softlockup. However, it is a nop in PREEMPT_LAZIEST, and things may be 
> broken...

cond_resched() is not designed. It's an ill-defined bandaid and the
purpose of LAZY is to remove it completely along with the preemption
models which depend on it.

Thanks,

        tglx




