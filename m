Return-Path: <linux-kernel+bounces-178911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D08C5962
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E799F1C2205D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD52217F389;
	Tue, 14 May 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="sph/s51b"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098617F36E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702841; cv=none; b=qrpr85HD3Dy+A+8jyzEtXeGvMjJwyA8iWJHRhBe9pxZVArL+A3wDFh3ba8MrDzrKggI0filzIyA/dFMiET2FFqKl5uPrv/66WZbwRS1iEWgVhLV9W/EGRGqogaeLlLYIvh0ZAVQvQN8/dIKyeVrw7Se7aEVPQBPEiejjunxU30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702841; c=relaxed/simple;
	bh=3bPZpiw6sYnrMRXFm91ZSL+fpul0Ew+mYWwQfHYgkFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd/y9OWPjR73mWHR3J6FB/BOG9JsWt752YlkXfdyOWps052C/Dm0RIwLZXq4GVgvoR+iasqfJIhIw8eTPZTDUiPu5rUgklVMKSwrVSRBO6jEfEaroJbNQgcsYalGCby8EUlEhjlxb8FKok4aE0plkA9TnABtc5+Ex83bG0KjuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=sph/s51b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420180b5898so14844125e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715702838; x=1716307638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75KiU4oeuzu7iVkCIPjkrAQJruCJwe65UaXG4IWuXwI=;
        b=sph/s51b93XsJGNv5wlkE5FYRk/nifhMSq9FQS4Ig1zqPArtGr95T2c1O45ljFHcKs
         RWZc5e0T/mTfEvm1oXRWxf2OEhLoayMsGyUO2036hbLhA8m1GfmEd9Yf2wQBz0nYZHOz
         JNWeWefpREoKA/q8CK+tt/ZLrkC3ZKEJpX7iV2XBxzweraXI8GCFqgEHgOaXRvfNIiy2
         WDigByclpkOESc9HbMb9cVba5ABnx5rHcRNRhaTypf57HPkqw9ROCr0/YZ/2i0Y93frA
         HjbBd1k/hioGLxdmMl7fQ4Es/cBcyTCyumswYVGm62Bwlf+JQYHtQek/qEbXvUeM1boI
         iwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702838; x=1716307638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75KiU4oeuzu7iVkCIPjkrAQJruCJwe65UaXG4IWuXwI=;
        b=MHWyxfHKNbdByYOAGNSLz6qNhQ27P2PJCp5jZmA+OnhqNwXtzW25aJJOJwSEDWQ20q
         oUPUneHN7IqmdWMCZ31YTDidQFy7vlNGC6yklKHS1eJ5ZZI6VnR19r4CglM/z8pmwtSv
         HeibTyWHvF8FDQNE2Lb8cfFoV2x4FH0ZOofYLvKuHuv6lcjKbDE/L2iygpAdXH8yHMGJ
         uGqYDggDMMyBBn8u2St2WEdij2N+K4CAmfOwW49AtPgj49/yIb7BAjtx4WkxWrkO3lZA
         sl/eGTiBwnyjA04dxsnLjwZYvobQDuaqswkCnMhKD21s8pE7uK0MqQsohP0VQgBmTtsJ
         TRqA==
X-Forwarded-Encrypted: i=1; AJvYcCVQyjrhT6E2+sF/8ZG4L90PO7ERXrOqqkThT0LMvzdHrRqCFElL0vkEZLD4MWnnVcE6AgO3PAtAyx8OFdJLUK0k2Ufv7ve9jJdVVh8w
X-Gm-Message-State: AOJu0YwCYJDuseAKE/DH9Pw7eiQqz2jvavbvV9bQag/QcCsTQPzVAvG1
	LEsLIXeLBIOX8YSJ2qdYWC7NKA2k7Pl4D+/cw1NmhjiWpHDTrINSh3Bw+L72JVU=
X-Google-Smtp-Source: AGHT+IGeIDpIe1Gw4WtfF9XBxW2JKvbrw1HVvqxzapA/0W1cZ3rY7TexTC3+DXQ1MaTEr762+Lg1sw==
X-Received: by 2002:adf:f791:0:b0:343:8e85:dd7c with SMTP id ffacd0b85a97d-3504a9580bamr9823757f8f.55.1715702837792;
        Tue, 14 May 2024 09:07:17 -0700 (PDT)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be1dsm14127770f8f.10.2024.05.14.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:07:17 -0700 (PDT)
Date: Tue, 14 May 2024 17:07:11 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240514160711.hpdg64grdwc43ux7@airbuntu>
References: <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
 <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
 <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
 <20240409061909.tb3vxc27h2eawiwg@airbuntu>
 <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>
 <20240410065901.ruzhjsmtmpsnl4qe@airbuntu>
 <CAKfTPtD-J37Q1SL2HqZLvfNtW9LY34C-d-t6-0KU4DxkUmvHzQ@mail.gmail.com>
 <20240410154727.4yh5tcnpb6zwxuub@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410154727.4yh5tcnpb6zwxuub@airbuntu>

On 04/10/24 16:47, Qais Yousef wrote:
> On 04/10/24 11:13, Vincent Guittot wrote:
> 
> > > > Without cgroup, the solution could be straightforward but android uses
> > > > extensively cgroup AFAICT and update_cfs_group() makes impossible to
> > > > track the top cfs waiter and its "prio"
> > >
> > > :(
> > >
> > > IIUC the issue is that we can't easily come up with a single number of
> > > 'effective prio' for N level hierarchy and compare it with another M level
> > > hierarchy..
> > 
> > And then how do you apply it on the hierarchy ?
> 
> (I am not disagreeing with you, just trying to state the reasons more
> explicitly)
> 
> I think the application is easy, attach to the leaf cfs_rq? Which IIUC
> correctly what should happen with proxy execution, but by consuming the context
> of the donor directly without having explicitly to move the lock owner.
> 
> Finding out which hierarchy actually has the highest effective share is not
> straightforward I agree. And if we combine a potential operation of something
> that could move any waiting task to a different hierarchy at anytime, this gets
> even more complex.
> 
> I need to go and find more info, but seems Windows has some kind of boost
> mechanism to help the lock owner to release the lock faster. I wonder if
> something like that could help as interim solution. What we could do is move
> the task to root group as a boost with the simple reweight operation proposed
> here applied. As soon as it releases the lock we should restore it.
> 
> From what I heard in Windows this boost happens randomly (don't quote me on
> this). I am not sure could be our trigger mechanism. We sure don't want to do
> this unconditionally otherwise we break fairness.
> 
> Maybe there are easier ways to introduce a simple such boost mechanism..

FWIW, trying to find the top-fair-waiter and that wasn't as trivial. I needed
to refactor a fair bit of the code that expects the top-waiter to be the
leftmost..

And I haven't looked at that temporary boost mechanism for cfs. Maybe I'll try
that if I get a chance. For the time being, I got this bandaid if anybody is
interested in a temporary 'solution'

--->8---

From 7169519792f11a73f861a41dd7d5c9151dc44dd7 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qyousef@layalina.io>
Date: Mon, 1 Apr 2024 03:04:00 +0100
Subject: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio

For fair tasks inheriting the priority (nice) without reweighting is
a NOP as the task's share won't change.

This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
with low priority values are susceptible to starvation leading to PI
like impact on lock contention.

The logic in rt_mutex will reset these low priority fair tasks into nice
0, but without the additional reweight operation to actually update the
weights, it doesn't have the desired impact of boosting them to allow
them to run sooner/longer to release the lock.

Apply the reweight for fair_policy() tasks to achieve the desired boost
for those low nice values tasks. Note that boost here means resetting
their nice to 0; as this is what the current logic does for fair tasks.

We need to re-instate ordering fair tasks by their priority order on the
waiter tree to ensure we inherit the top_waiter properly.

Handling of idle_policy() requires more code refactoring and is not
handled yet. idle_policy() are treated specially and only run when the
CPU is idle and get a hardcoded low weight value. Changing weights won't
be enough without a promotion first to SCHED_OTHER.

Tested with a test program that creates three threads.

	1. main thread that spawns high prio and low prio task and busy
	   loops

	2. low priority thread that holds a pthread_mutex() with
	   PTHREAD_PRIO_INHERIT protocol. Runs at nice +10. Busy loops
	   after holding the lock.

	3. high priority thread that holds a pthread_mutex() with
	   PTHREADPTHREAD_PRIO_INHERIT, but made to start after the low
	   priority thread. Runs at nice 0. Should remain blocked by the
	   low priority thread.

All tasks are pinned to CPU0.

Without the patch I can see the low priority thread running only for
~10% of the time which is what expected without it being boosted.

With the patch the low priority thread runs for ~50% which is what
expected if it gets boosted to nice 0.

I modified the test program logic afterwards to ensure that after
releasing the lock the low priority thread goes back to running for 10%
of the time, and it does.

Reported-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/locking/rtmutex.c | 7 +------
 kernel/sched/core.c      | 4 +++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..4e155862aba1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -345,12 +345,7 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 
 static __always_inline int __waiter_prio(struct task_struct *task)
 {
-	int prio = task->prio;
-
-	if (!rt_prio(prio))
-		return DEFAULT_PRIO;
-
-	return prio;
+	return task->prio;
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a914388144a..f22db270b0d9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7242,8 +7242,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
-		if (rt_prio(oldprio))
+		else if (rt_prio(oldprio))
 			p->rt.timeout = 0;
+		else if (!task_has_idle_policy(p))
+			reweight_task(p, prio - MAX_RT_PRIO);
 	}
 
 	__setscheduler_prio(p, prio);
-- 
2.34.1


