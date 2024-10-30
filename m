Return-Path: <linux-kernel+bounces-388506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3479B607E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA02AB22CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A41E3793;
	Wed, 30 Oct 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LDkAlUBy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1C1E22FF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285381; cv=none; b=QVPfqKPXDantpK0SQa8mxczJiZtcmUrkB47Hw4b2G6bqEpx3mf1eUBeeikeQSVnAqUnYOeJdvVEf3K//GWPYlzJU9DRbjgVvpTPKoceLezikMgnjaM3h5MalwDb4c20GTYFbeHlFq6Ehuf8vrzffN4UYSmvn7zGf+7Bl6y+dx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285381; c=relaxed/simple;
	bh=8LmggMcA3iJvkIizqn/QhPi+okCV4u6V3O6ZKqxKu0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWlxARCW59m7RQCWiA3WsSQPAyVqf3K4oWGM4vOHij8i2HIpM5/t7JtwL4ZRWYDjYVgpHA7GCRYTFMvq2PTM0+ARJYDqVKCOLbew26/mn15pAs/tStttsL93GRblMyKjyeoUEfYzDms9GPkHGCcB4wEnHT2n8kz54tZYDi5p+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LDkAlUBy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dIUEzd6BZuXDcMm8npr84vTskgiLgfMpgYyCGQDUBc4=; b=LDkAlUByCdjMfVtQUiI09VhH2F
	iU7+A6SZQ6h76zJpoJuXXAj+KCrBuRkkCgjwb7nbSq/i0mibbfDnu3MIkWRuMkkr5CwkcAk+/2PQM
	n1KZrXaUFD1Mo/IpY136R0d4l/agp0NMOwUaXEABZd5uL9PLs1NbQwyRdpS+PtOBjA2ZPYuEHP6fT
	LhrBjtCCGRvReBwWDtvYS+z1X1YVmvmu0iKGhHCDztY4XWs16akecq+K1VVie0Ty0NWmDHt0uscPN
	a5TfWnF9KFHLIvWnoUhh8fWchJroDnFLlyAJa4FCNoKZlp3AnJDHpYtJeu9C1eA1fhuBBauLQ6MvI
	9mwVjLcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t66Gd-0000000AE4k-0DCk;
	Wed, 30 Oct 2024 10:49:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 153F3300ABE; Wed, 30 Oct 2024 11:49:34 +0100 (CET)
Date: Wed, 30 Oct 2024 11:49:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	sched-ext@meta.com
Subject: Re: [RFC PATCH sched/urgent] sched: Task still delay-dequeued after
 switched from fair
Message-ID: <20241030104934.GK14555@noisy.programming.kicks-ass.net>
References: <ZyF4rw_nvfpHfouv@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyF4rw_nvfpHfouv@slm.duckdns.org>

On Tue, Oct 29, 2024 at 02:07:11PM -1000, Tejun Heo wrote:
> On the current tip/sched/urgent, the following can be easily triggered by
> running `tools/testing/selftests/sched_ext/runner -t reload_loop`:

> The problem is that when tasks are switched from fair to ext, it can
> remain delay-dequeued triggering the above warning when the task goes
> back to fair. 

> I can work around with the following patch but it
> doesn't seem like the right way to handle it. Shouldn't e.g.
> fair->switched_from() cancel delayed dequeue?

->switched_from() used to do this, but it is too late. I have a TODO
item fairly high on the todo list to rework the whole
switch{ing,ed}_{from,to} hookery to make all this more sane.

But yeah, it seems I missed the below case where we are switching class.

> ---
>  kernel/sched/ext.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 65334c13ffa5..601aad1a2625 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5205,8 +5205,12 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	while ((p = scx_task_iter_next_locked(&sti))) {
>  		const struct sched_class *old_class = p->sched_class;
>  		struct sched_enq_and_set_ctx ctx;
> +		int deq_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
>  
> -		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
> +		if (p->se.sched_delayed)
> +			deq_flags |= DEQUEUE_SLEEP | DEQUEUE_DELAYED;
> +
> +		sched_deq_and_put_task(p, deq_flags, &ctx);

I don't think this is quite right, the problem is that in this case
ctx.queued is reporting true, even though you want it false.

This is why 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
adds a second dequeue.

Also, you seem to have a second instance of all that.

Does the below work for you? I suppose I might as well go work on that
TODO item now.

---
 kernel/sched/ext.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 40bdfe84e4f0..587e7d1a1e96 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class =
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		p->sched_class = __setscheduler_class(p->policy, p->prio);
+		p->sched_class = new_class;
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
@@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class =
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
 		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = __setscheduler_class(p->policy, p->prio);
+		p->sched_class = new_class;
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);

