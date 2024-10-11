Return-Path: <linux-kernel+bounces-361629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EEA99AAA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A0728377A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CA91BDABD;
	Fri, 11 Oct 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKIaknYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932391BD4E7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668460; cv=none; b=rUtQ1kQzWLDZRV4FVDWCpXz78XxVOzY0drkP+waLs2zhzyNwteiYNSws9tJ8zwq0e8rhVpdf/gNn1UMvJKa3YWn9i9a1d4RI9dczj2mmxWHQzKz78CsdZtNa7YAuLIfbFlls5Ti5m3Cqy7sgGi+FwadRoArYHyvAe+62e15faVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668460; c=relaxed/simple;
	bh=xz0RSopNBkAdLmVw0yQrGaHpqLvVKkrN2wTYuQxr+r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOtpM3Fo2NGDTp5j8iMsI4rs2RVmzrUSZ5sDK01VMvxK9uQl6f+X9ROewEo49f60S0YKZ63ULzah8baJvqD3Da086R9JibsU1J/dIsRy3xI6R7+lv+TfQEDLkbOKA3lroI7n3NEIB1z4bz1gQOhi0mpK4CpR9cwQZr6PGnJpV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKIaknYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13872C4CEC3;
	Fri, 11 Oct 2024 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668460;
	bh=xz0RSopNBkAdLmVw0yQrGaHpqLvVKkrN2wTYuQxr+r0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vKIaknYL+Zyn7xZbEqf0yGVO6mg+dourUM7PD0OzAVkYSAxN8RrmntgBsyaH16Az7
	 bkvhj0XbhaWhYHNmt3EVCq0HbvAE1vk9VlvL6u0Av+vYytl2sP3qno/C1QQTbhT+ft
	 ZzxTzrIL7nEk6+2TnuGl1Faf8FTf7zXm2BB201p95hY8/IOtYwkUP7H7q7W0lkJKMy
	 GuGtjcbbAYvgCs3BPXiUQ9fttF8MaKyxCMkOFP61GkNXivLnhWlEQxz/9e/8DvIbZJ
	 N8PwmHs3SlxwqSABy0ZkMW2742U/N9k67xMaHk+QuHrlaF0pNZa9Uwcn3c+9AKWNPp
	 GZRTNzWWNrSbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B620BCE0BB1; Fri, 11 Oct 2024 10:40:59 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:40:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	leobras@redhat.com, tglx@linutronix.de, peterz@infradead.org,
	qiyuzhu2@amd.com
Subject: Re: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <7e5ab11f-f8f9-4e91-becf-09f3cb279c2f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
 <9ca16991fa83fb7c7baeee153666d70717be2b7a.camel@surriel.com>
 <ac55d9c8-efbc-4f2d-b178-f54f101313b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac55d9c8-efbc-4f2d-b178-f54f101313b0@paulmck-laptop>

On Thu, Oct 10, 2024 at 11:31:08AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 10, 2024 at 11:13:35AM -0400, Rik van Riel wrote:
> > On Wed, 2024-10-09 at 10:57 -0700, Paul E. McKenney wrote:
> > > Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
> > > to check for excessive CSD-lock wait times.  This works, but does not
> > > guarantee monotonic timestamps.  Therefore, switch from sched_clock()
> > > to ktime_get_mono_fast_ns(), which does guarantee monotonic
> > > timestamps,
> > > at least in the absence of calls from NMI handlers, which are not
> > > involved
> > > in this code path.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Leonardo Bras <leobras@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > 
> > The functional change here is that sched_clock() uses rdtsc(),
> > while ktime_get_mono_fast_ns() uses rdtsc_ordered().
> > 
> > I don't know if sched_clock() should also be using rdtsc_ordered().
> > 
> > Reviewed-by: Rik van Riel <riel@surriel.com>
> 
> Thank you!  I will apply this on my next rebase.

And please see below for the updated version.

							Thanx, Paul

------------------------------------------------------------------------

locking/csd-lock: Switch from sched_clock() to ktime_get_mono_fast_ns()

Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock() to check
for excessive CSD-lock wait times.  This works, but does not guarantee
monotonic timestamps on x86 due to the sched_clock() function's use of
the rdtsc instruction, which does not guarantee ordering.  This means
that, given successive calls to sched_clock(), the second might return
an earlier time than the second, that is, time might seem to go backwards.
This can (and does!) result in false-positive CSD-lock wait complaints
claiming almost 2^64 nanoseconds of delay.

Therefore, switch from sched_clock() to ktime_get_mono_fast_ns(), which
does guarantee monotonic timestamps via the rdtsc_ordered() function,
which as the name implies, does guarantee ordered timestamps, at least
in the absence of calls from NMI handlers, which are not involved in
this code path.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>

diff --git a/kernel/smp.c b/kernel/smp.c
index f25e20617b7eb..27dc31a146a35 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -246,7 +246,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		return true;
 	}
 
-	ts2 = sched_clock();
+	ts2 = ktime_get_mono_fast_ns();
 	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
 	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
@@ -321,7 +321,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	int bug_id = 0;
 	u64 ts0, ts1;
 
-	ts1 = ts0 = sched_clock();
+	ts1 = ts0 = ktime_get_mono_fast_ns();
 	for (;;) {
 		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
 			break;

