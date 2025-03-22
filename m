Return-Path: <linux-kernel+bounces-572641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFEA6CC93
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F1D3B544A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0725233D99;
	Sat, 22 Mar 2025 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ao6jD+ma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BM/cU9Wt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4A6AAD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742677446; cv=none; b=PAVpHJbIivsGGePn4GMAaKWO5fEsIFZyz0HHMfhgkUAd46jDXG38FkwIA1cFqlklv73eZ639gi14qqLdVP+CAVR9qczanEWPlOnep4FVT+PKFMq127z0yY1Fxn0UNfEkptqH5u45bMlxDox0o6OjGM3nWiQZfcV95cO9AF4vKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742677446; c=relaxed/simple;
	bh=yDUCWyiLRUUKAJJ5jKAuhTCJG2rZwkqVO6tul24XQYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyor66dIPcqKL5iLSpBZn6ERpFLa1Ou1NZENlJtpWlTjHPjOSmZ03wFlyrD6/pvMlRUflQeiLDYJ/IDTsb1smbyl/yqF9hTneEu/m2yJfnNECqQXYVGvWamPqyYxvpHVItwnj0VLDbhWLe9Cxzo2ii2rSjXmZbrcSCiJ5Bmvf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ao6jD+ma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BM/cU9Wt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742677442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pM9vLebllQghQbND97wqUp00Uf5kZppdIdNy+FWYMvc=;
	b=Ao6jD+maG2AyhVkdqyHx3qauJvKFaFcrIhpgCwPf5nmg1yS78gC235uTL4d5HSMUbG/yQI
	pYPbsAYhP5Qfdf2t8/8qboWrglX6BPuzpvVofQYzvOSa9q657oMHicigOuSVCJiXuUpXBP
	ZAXwaXms3vHvjpq7u2ld8t0aX00304j4pGEKb00RLgT1qpJPPoRCGSUmz3m7BZOwS69v8L
	AN5Tvt9mTX+cGf1jzbJ8pHV8nAg8i6n0ChgZ3c/6sOKNNYUwSR748CRvmdEPAcbClDgwEZ
	l0FpPV0lz4vVtY3m1L6m+wguEs4lk1ozR73sTEISmE+YnBm4jQSBJfqj5KdgNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742677442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pM9vLebllQghQbND97wqUp00Uf5kZppdIdNy+FWYMvc=;
	b=BM/cU9Wt+vkTnRYv0tA6Cf+1FrYUmvuD0rM+IU4rojWTWleWpdLMDnAnH7gs8vbgzCjLoh
	w/cJHDZ4LFFJN9Dw==
To: richard clark <richard.xnu.clark@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hrtimer precision issue/question??
In-Reply-To: <CAJNi4rPaPeVWzBve6Toi8hhrxP6GROAGRug7+c3zg1crDeOt7Q@mail.gmail.com>
References: <CAJNi4rPaPeVWzBve6Toi8hhrxP6GROAGRug7+c3zg1crDeOt7Q@mail.gmail.com>
Date: Sat, 22 Mar 2025 22:04:01 +0100
Message-ID: <875xk022wu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 22 2025 at 11:20, richard clark wrote:
> With diff below under the 'cyclictest -a 0 -t 1 -m -p99' trigger from
> the arm64-based linux box, the interval is 1000us and the arch_timer
> in the system is: arch_timer: cp15 timer(s) running at 31.25MHz
> (phys).  1tick = 32ns for the arch timer, I am not sure if those
> durations less than 1000us are expected?

With your method of measurement yes. There is a german saying, which
describes this. It roughly translates to:

   "Who measures a lot, might measure a lot of garbage."

But it accurately describes, what you are measuring here. You do:

    t1 = ktime_get();
    arm_timer(T);
    schedule();
    t2 = ktime_get();

and then look at t2 - t1. That only tells you how long the task actually
slept. But that's ignoring the most important information here:

    arm_timer(T);

cyclictest uses:

           clock_nanosleep(clockid, ABSTIME, &T);

and T is maintained in absolute time on a periodic time line.

    T = starttime + N * interval;

So the only interesting information here is at which time the task
returns from schedule(), i.e. you want to look at:

        t2 - T

Why? Because that gives you the latency of the wakeup. That's what
cyclictest is looking at in user space:

           clock_nanosleep(... &T);
           clock_gettime(..., &T2);
           latency = T2 - T;

Now what you are looking at is the time at which the cyclictest task
comes back into the kernel to sleep, which is obviously

           t1 = T[N] + latency[N-1] + execution_time;

But the timer is armed for T[N], so your t2 is:

           t2 = T[N] + latency[N];

You surely can do the remaining math and map that to the output:

> [  165.555795] [ 0- 0]t0=165550399226,t1=165551394303,d=995 us
> [  165.556802] [ 0- 0]t0=165551398751,t1=165552400997,d=1002 us

Right?

Thanks,

        tglx

