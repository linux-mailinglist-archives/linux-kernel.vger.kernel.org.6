Return-Path: <linux-kernel+bounces-425367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5799DC113
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F72CB22A09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB616DEDF;
	Fri, 29 Nov 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HLdjdZLc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA3143C40
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871341; cv=none; b=GN/MNVa6wPiuaoH9vqiU9rMpiLr82pMs+A4IV+wZtSiIovoorRg/X6pAg50OYRPMXezTYhSQT6HPvDHcIWvd8pRqrIZ7VIMaq57aPqOyoXsncIYYe/TxgDZ2/xYFVysolWQgQyEEbfnbqgOvDcHpbFhvgBH6DCeD0p+vfKKJiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871341; c=relaxed/simple;
	bh=0KV/6sgaRCPqFlWWzf7raGuQK8c96l+Vji3eaKES2DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBWK6kE8xwBhXGcWaYo0FIFIphNZezMrRrVHShUNODJDTWCgRB1YE8tZYe/bXuL6EPm0DHrtUGW9IB4ED7ALRqS9v07xo9zrVqFvOKFNmP8Dv7qYqT/MliwcMmSvkKGbjNYL4tj3dnWANBtQ5XK8ee9Alz4P1g3fOkCctrdzd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HLdjdZLc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hC/g7AItvhILdVbRfVfGKx21OYJI1KMTMLqWl+3vl/c=; b=HLdjdZLceWzevsaxPn/QTChSNc
	e/8ujp8pQI75yadgQL2NaPcxIWKZ0cQRxldaPCtefA1PDW2cZoWw1hp0UxxTXelZVLkkGVtYEzQzx
	VihnTg8chVcP8pnOiDr7kbjQdfqDPABpxfoGmxpZEmyo8MwpxxqdxuMLqougNNh9KNbbVXVJ7av3I
	NIPeeA2Dm9MqQKHcGdYXnyeis3NNx5lWGTsBoFuu0Omw3UEWIadwrTL4dSEf4lMLqF2RiVfFknfUZ
	F7jVK860v0edf/fIHzzlzUQXsZG1p5+pfI4mTGRFQLTgV4rjohuWluQK/kp3NiuTDGZXbrnaucJqJ
	ln5DvEjQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGwzS-00000003oMC-3qav;
	Fri, 29 Nov 2024 09:08:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0E3C30026A; Fri, 29 Nov 2024 10:08:43 +0100 (CET)
Date: Fri, 29 Nov 2024 10:08:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20241129090843.GB15382@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
 <20241128105817.GC35539@noisy.programming.kicks-ass.net>
 <4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>

On Thu, Nov 28, 2024 at 12:37:14PM +0100, Marcel Ziswiler wrote:

> > Oooh, that's something. So far the few reports have not been (easily)
> > reproducible. If this is readily reproducible on arm64 that would
> > help a lot. Juri, do you have access to an arm64 test box?
> 
> As mentioned above, so far our scheduler stress test is not yet open source but Codethink is eager to share
> anything which helps in resolving this.

I was hoping you could perhaps share a binary with Juri privately or
with RHT (same difference etc), such that he can poke at it too.

Anyway, if you don't mind a bit of back and forth, would you mind adding
the below patch to your kernel and doing:

(all assuming your kernel has ftrace enabled)

  echo 1 > /sys/kernel/debug/tracing/options/stacktrace
  echo 1 > /proc/sys/kernel/traceoff_on_warning

running your test to failure and then dumping the trace into a file
like:

  cat /sys/kernel/debug/tracing/trace > ~/trace

Then compress the file (bzip2 or whatever is popular these days) and
send it my way along with a dmesg dump (private is fine -- these things
tend to be large-ish).

Hopefully, this will give us a little clue as to where the double
enqueue happens.

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..b9cd9b40a19f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1203,6 +1203,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 	scoped_guard (rq_lock, rq) {
 		struct rq_flags *rf = &scope.rf;
 
+		if (dl_se == &rq->fair_server) {
+			trace_printk("timer fair server %d throttled %d\n",
+				     cpu_of(rq), dl_se->dl_throttled);
+		}
+
 		if (!dl_se->dl_throttled || !dl_se->dl_runtime)
 			return HRTIMER_NORESTART;
 
@@ -1772,6 +1777,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		rq_lock(rq, &rf);
 	}
 
+	if (dl_se == &rq->fair_server)
+		trace_printk("inactive fair server %d\n", cpu_of(rq));
+
 	sched_clock_tick();
 	update_rq_clock(rq);
 
@@ -1967,6 +1975,12 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
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
 
@@ -1978,6 +1992,12 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
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

