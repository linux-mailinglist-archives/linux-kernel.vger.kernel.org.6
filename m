Return-Path: <linux-kernel+bounces-422187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1707B9D95A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FDB2840AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806EA1B6CE6;
	Tue, 26 Nov 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPoj7Ew6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A218FDBA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617326; cv=none; b=XC0bfcCKby2sMnBQAiaqBDfpfwqte1poaQM5ftqRnAR+TQz+g/xEh60WL3WCVWHcyt+yCzeRlTMXUzK43wXLGLaVQOh0nOx+Z/Gb/L96yaQ122bX0HBbOzLdVtLQU7PWln9v0mOxzWMeKXibLe9QxziG/XYc8bQUvjphmzlV81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617326; c=relaxed/simple;
	bh=y93tEDv5fAv1KkU3Qza4g5+eIlFj915qWP77fp4NLrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j669jXCyg3OuI0nSaQ/6qH7XEKnuVvVlDZSjJ1dKzMIgwqs/fQ5vO12HFs8Tc1m7CFzyP15XwPbRNCKBlIi/qV3a9G7ssilY0+SzRQJ157NwJbCOYLuBFyHpkDoG8regCAeoqdXAeAJpa606Bo5/j6d1O6yq6yN8Ady9JoxKYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rPoj7Ew6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z5lZ2GvZn3dj2gon3+Y9QLrft5m3fyX3gDJoTynvWEA=; b=rPoj7Ew6ImsFI1zUw5rmSMGloA
	Ue+NzTk0uvZDi6Rp9jLx3/Dh/mHR9JT7atxr+3hyXbJ1gkwDzy6HscTuqnmIBjheI4UVyoqVUOEEl
	CdLMBlRynLR1IZ0iT/vXwfINn8+J4dJ6gx5Fznx9Uezdvloer0CDGJhoNUwiP4OyXamECULmoolUp
	rZ5Bjk7hvo/O6kDBNOyhrWtskVZRlbkh765gJg8vjI/FvCu64DeZ9yqPUlNgnGFXW+blLgbypeA+u
	Xa+7Rr6gxmYtY6Kqy2R9GI6qOTrsxEIL892ulZHGeXb/oQVWhnZTu/6oNCt21401E5BmB+oirh1x4
	tvb1qPnQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFsuW-0000000DQQq-3d1Q;
	Tue, 26 Nov 2024 10:35:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3CDA23002A2; Tue, 26 Nov 2024 11:35:13 +0100 (CET)
Date: Tue, 26 Nov 2024 11:35:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: zhouzihan30 <15645113830zzh@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	zhouzihan30 <zhouzihan30@jd.com>, yaozhenguo <yaozhenguo@jd.com>
Subject: Re: [PATCH] sched: Forward deadline for early tick
Message-ID: <20241126103513.GK38837@noisy.programming.kicks-ass.net>
References: <20241126062350.88183-1-zhouzihan30@jd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126062350.88183-1-zhouzihan30@jd.com>

On Tue, Nov 26, 2024 at 02:23:50PM +0800, zhouzihan30 wrote:
> Due to the problem of tick time accuracy, 
> the eevdf scheduler exhibits unexpected behavior.
> For example, a machine with sysctl_sched_base_slice=3ms, CONFIG_HZ=1000
>  should trigger a tick every 1ms. 
> A se (sched_entity) with default weight 1024 should
>  theoretically reach its deadline on the third tick. 
> However, the tick often arrives a little faster than expected. 
> In this case, the se can only wait until the next tick to
>  consider that it has reached its deadline, and will run 1ms longer.
> 
> vruntime + sysctl_sched_base_slice =     deadline
>         |-----------|-----------|-----------|-----------|
>              1ms          1ms         1ms         1ms
>                    ^           ^           ^           ^
>                  tick1       tick2       tick3       tick4(nearly 4ms)
> 
> Here is a simple example of this scenario, 
> where sysctl_sched_base_slice=3ms, CONFIG_HZ=1000, 
> the CPU is Intel(R) Xeon(R) Platinum 8338C CPU @ 2.60GHz, 
> and "while :; do :; done &" is run twice with pids 72112 and 72113.
> According to the design of eevdf,
> both should run for 3ms each, but often they run for 4ms.

> 
> The reason for this problem is that
>  the actual time of each tick is less than 1ms.
> We believe there are two reasons:
> Reason 1:
> Hardware error. 
> The clock of an ordinary computer cannot guarantee its own accurate time.
> Reason 2:
> Calculation error.
> Many clocks calculate time indirectly through the number of cycles, 
> which will definitely have errors and be smaller than the actual value,
>  the kernel code is:
> 
> clc= ((unsignedlonglong) delta*dev->mult) >>dev->shift;
> dev->set_next_event((unsignedlong) clc, dev);
> 
> To solve this problem,
> we add a sched feature FORWARD_DEADLINE,
> consider forwarding the deadline appropriately. 
> When vruntime is very close to the deadline,
> we consider that the deadline has been reached.
> This tolerance is set to vslice/128.
> On our machine, the tick error will not be greater than this tolerance,
> and an error of less than 1%
>  should not affect the fairness of the scheduler.

*sigh*

So yeah, discrete system, we get to quantize things. Timing has an
error proportional to the quantum chosen.

Current setup is the trivial whole integer or floor function. As such
the absolute error e is 0<e<q -- for a reason, see below.

You then introduce an additional error of: r/128 in order to minimize
the total error, except you made it worse. Consider case where r/128>q.

The only semi sane thing to do here is to replace floor with rounding,
then the absolute error changes to 0<e<q/2.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..d01b73e3f5aa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1006,7 +1006,9 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  */
 static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
+	s64 v_half_tick = calc_delta_fair(TICK_NSEC/2, se);
+
+	if ((s64)(se->vruntime - se->deadline) < -v_half_tick)
 		return false;
 
 	/*

Now the consequence of doing this are that you will end up pushing a
task's (virtual) deadline into the future before it will have had time
to consume its full request, meaning its effective priority drops before
completion.

While it does not harm fairness, it does harm to the guarantees provided
by EEVDF such as they are.

Additionally, since update_deadline() is not proper (see its comment),
you're making the cumulative error significantly worse. A better version
would be something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..377e61be2cf6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1000,13 +1000,12 @@ int sched_update_scaling(void)
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
-/*
- * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
- * this is probably good enough.
- */
 static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
+	s64 v_half_tick = calc_delta_fair(TICK_NSEC/2, se);
+	s64 v_slice;
+
+	if ((s64)(se->vruntime - se->deadline) < -v_half_tick)
 		return false;
 
 	/*
@@ -1017,10 +1016,14 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (!se->custom_slice)
 		se->slice = sysctl_sched_base_slice;
 
+	v_slice = calc_delta_fair(se->slice, se);
+
 	/*
-	 * EEVDF: vd_i = ve_i + r_i / w_i
+	 * EEVDF: vd_i += r_i / w_i
 	 */
-	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+	do {
+		se->deadline += v_slice;
+	} while ((s64)(se->vruntime - se->deadline) < v_half_tick);
 
 	/*
 	 * The task has consumed its request, reschedule.


Now, if all this is worth it I've no idea.

Since you clearly do not care about the request size, your simplest
solution is to simply decrease it.


Also, none of this has been near a compiler, and please double check the
math if you want to proceed with any of this, I've given that about as
much thought as compile time :-)



