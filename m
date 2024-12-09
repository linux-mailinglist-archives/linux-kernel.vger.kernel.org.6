Return-Path: <linux-kernel+bounces-437103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B389B9E8F30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEDA281AC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13171216380;
	Mon,  9 Dec 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7BfH1Cl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED9215F60
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737796; cv=none; b=rv93qs4AAoA91flofK/pnJ/vRfpSXQzjVHAF2pBxsfJo/tsf3AloEBWgVfXMuAo5muGhAMzr9ZFwbu44zqXKIwzsiCRMnfrniiwZBce5QgNzsRLuRraB2xDLspNrCq9/sPCECmfUyJOz2w0dBQ7434Sq4ftw8AMheVAOOgz4f8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737796; c=relaxed/simple;
	bh=gjzP1jOWh+tLjI9woDgqu6zeAvUHesesAV1OB860O5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbynn/PglMWpqPdguCNtCzZ4W6F3D0fZIXAY2LKjNReNzAe3STpN7pChneT7iOEFAl1xt2uFv7vsq18x054a+WCHkpMenlZvNSD7sfrea5gwlWZnSvL/0y+zomfyV/VA1N8XtZwfoBC775oXO+4G882DIEGiGiXDY0Bi7Px/Vr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B7BfH1Cl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=we92yClgUcvthCKFM4LL8GZJey1rostJrjOGqYYFIIM=; b=B7BfH1ClqS09kvx8JR052Hxr8c
	9eOKcU8zPKDiEVMIPLBYCplJ4jy1tWsmiDXGlS+1ysLpBkim6hTy6BVn45Ej72aO2CEaDzVD3uBdz
	0gXpxpOkKQCz9QJcMNjnNA/RhTS4u59/4+BP3EN+j/a7EYId0jqTR0shLwtO5CsJKIW8koM7p5rx4
	lZarY8tjDnMO/WKO7CPOBYBw2uJDadVRdmcKYQ+LMh2GjfIj+XBgUP2lBvnRbvhYiHFwXqbrYuZB6
	DczN0XWxu9Q3SYyjZVzZgUEd/kGWGLTOC1YGFss0++W4WRb9qfb1IVObFYkjHgQV7kquokG1oFBz3
	jbWy5kZg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKaOc-00000003WMJ-05ku;
	Mon, 09 Dec 2024 09:49:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27EB13003FF; Mon,  9 Dec 2024 10:49:41 +0100 (CET)
Date: Mon, 9 Dec 2024 10:49:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20241209094941.GF21636@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
 <20241128105817.GC35539@noisy.programming.kicks-ass.net>
 <4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>
 <20241129090843.GB15382@noisy.programming.kicks-ass.net>
 <98294066b3a0a7a77220e18ab9db5d3c3cb57341.camel@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98294066b3a0a7a77220e18ab9db5d3c3cb57341.camel@codethink.co.uk>


Sorry for the delay, I got laid low by snot monsters :/

On Mon, Dec 02, 2024 at 07:46:21PM +0100, Marcel Ziswiler wrote:

> Unfortunately, once I trigger the failure the system is completely dead and won't allow me to dump the trace
> buffer any longer. So I did the following instead on the serial console terminal:
> 
> tail -f /sys/kernel/debug/tracing/trace
> 
> Not sure whether there is any better way to go about this. Plus even so we run the serial console at 1.5
> megabaud I am not fully sure whether it was able to keep up logging what you are looking for.

Ah, that is unfortunate. There is a ftrace_dump_on_oops option that
might be of help. And yes, dumping trace buffers over 1m5 serial lines
is tedious -- been there done that, got a t-shirt and all that.

Still, let me see if perhaps making that WARN in enqueue_dl_entity()
return makes the whole thing less fatal.

I've included the traceoff_on_warning and ftrace_dump in the code, so
all you really need to still do is enable the stacktrace option.

   echo 1 > /sys/kernel/debug/tracing/options/stacktrace

> Yes, and do not hesitate to ask for any additional information et. al. we are happy to help. Thanks!

Could I bother you to try again with the below patch?

There are two new hunks vs the previous one, the hunk in
enqueue_dl_entity() (the very last bit) will stop tracing and dump the
buffers when that condition is hit in addition to then aborting the
double enqueue, hopefully leaving the system is a slightly better state.

The other new hunk is the one for dl_server_stop() (second hunk), while
going over the code last week, I found that this might be a possible
hole leading to the observed double enqueue, so fingers crossed.

---

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 33b4646f8b24..bd1df7612482 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1223,6 +1223,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 	scoped_guard (rq_lock, rq) {
 		struct rq_flags *rf = &scope.rf;
 
+		if (dl_se == &rq->fair_server) {
+			trace_printk("timer fair server %d throttled %d\n",
+				     cpu_of(rq), dl_se->dl_throttled);
+		}
+
 		if (!dl_se->dl_throttled || !dl_se->dl_runtime)
 			return HRTIMER_NORESTART;
 
@@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	if (current->dl_server == dl_se) {
+		struct rq *rq = rq_of_dl_se(dl_se);
+		trace_printk("stop fair server %d\n", cpu_of(rq));
+		current->dl_server = NULL;
+	}
+
 	if (!dl_se->dl_runtime)
 		return;
 
@@ -1792,6 +1803,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		rq_lock(rq, &rf);
 	}
 
+	if (dl_se == &rq->fair_server)
+		trace_printk("inactive fair server %d\n", cpu_of(rq));
+
 	sched_clock_tick();
 	update_rq_clock(rq);
 
@@ -1987,6 +2001,12 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+	struct rq *rq = rq_of_dl_se(dl_se);
+
+	if (dl_se == &rq->fair_server) {
+		trace_printk("enqueue fair server %d h_nr_running %d\n",
+			     cpu_of(rq), rq->cfs.h_nr_running);
+	}
 
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node));
 
@@ -1998,6 +2018,12 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+	struct rq *rq = rq_of_dl_se(dl_se);
+
+	if (dl_se == &rq->fair_server) {
+		trace_printk("dequeue fair server %d h_nr_running %d\n",
+			     cpu_of(rq), rq->cfs.h_nr_running);
+	}
 
 	if (RB_EMPTY_NODE(&dl_se->rb_node))
 		return;
@@ -2012,7 +2038,11 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
 static void
 enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
-	WARN_ON_ONCE(on_dl_rq(dl_se));
+	if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
+		tracing_off();
+		ftrace_dump(DUMP_ALL);
+		return;
+	}
 
 	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
 

