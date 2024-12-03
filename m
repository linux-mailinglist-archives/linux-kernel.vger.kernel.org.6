Return-Path: <linux-kernel+bounces-429814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F329E26BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814A2BE6249
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BC1F890A;
	Tue,  3 Dec 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UeWAMygi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42723CE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241927; cv=none; b=pw+dcFPMINlmpz19HLICmewzlXfkpaJfvbXpJYZiYEI/1Sp2zq6KXI0Di3Xo5ODDdw8mFowfgouofh5qoghmrBnqrbQhDg5QihCzMwJvBRob+0APULe4R1iZUghGhQCSwf+N6ViQN/6WVt8hhUjRP2+AYN9hZzPxUaEx8Ty+B+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241927; c=relaxed/simple;
	bh=zdcBbw8pyWJO38aQJ9QzdBb4RDftmfOhmk0cyKHJBOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T37LwksxULaij7VT4K+OZcyVp/qZ4bu3haniSdoIFzP9kBwG5VV6hq80LTL1YDamZpOe/LLpH2htJnJkqt12zN/V1bcLOy5hcke5bKvjY+J3tvBYxPzHKDB3LUGWdNAWdBctdG7Ghcrt1BQDJ6CreuRemYkmug2kA9bmG2Xo6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UeWAMygi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K599nb0UBNyArmt9tsmw1Nfk4bzClgOmVJA8qOoeeWM=; b=UeWAMygiIMWGOGgOS737sWTHn/
	Pq1kGx5TdU24ZOqQH8K1GZMJDJfosOM7wX6K17Z2Gq6u0ufgBeqic4jdPFaGXtA+KQupGs+Br1sNj
	3oELATykgT0DONyERJu+gR0Fv7TULMZF0BGwjSB7S2Sxb4R97bom61QAiZ7QvP6SIpXcqkIcV/MI4
	i88H8Om72Mngs3ZBeE/Pdyk789J6dBacOLamhHP8FypGTwGfp44taKB1+KRAInpE06w4aKXKsDtHb
	0EN2sr81E0MKRkRd/Bp2+MbMQswKyxw/Sb0hAMnRJMJdXg+892IK4eEd2BNA+N13FuTWPDNQznpe/
	LzlOfGuw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tIVOk-00000002PwD-339J;
	Tue, 03 Dec 2024 16:05:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 515C330031E; Tue,  3 Dec 2024 17:05:14 +0100 (CET)
Date: Tue, 3 Dec 2024 17:05:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
	vineethr@linux.ibm.com
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
Message-ID: <20241203160514.GI35539@noisy.programming.kicks-ass.net>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>

On Thu, Nov 28, 2024 at 12:59:54PM +0530, K Prateek Nayak wrote:

> Can you please try the following diff instead of the first two patches
> and see if you still hit these warnings, stalls, and pick_eevdf()
> returning NULL?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff7cae9274c5..61e74eb5af22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5478,6 +5478,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	bool sleep = flags & DEQUEUE_SLEEP;
>  	update_curr(cfs_rq);
> +	clear_buddies(cfs_rq, se);
>  	if (flags & DEQUEUE_DELAYED) {
>  		SCHED_WARN_ON(!se->sched_delayed);
> @@ -5520,8 +5521,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	update_stats_dequeue_fair(cfs_rq, se, flags);
> -	clear_buddies(cfs_rq, se);
> -
>  	update_entity_lag(cfs_rq, se);
>  	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
>  		se->deadline -= se->vruntime;
> @@ -8767,7 +8766,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
>  		return;
> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
> +	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
>  		set_next_buddy(pse);
>  	}


Prateek, I've presumed your SoB on this change:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/urgent&id=d1139307fe97ffefcf90212772f7516732a11034

Holler if you want it modified.

Thanks!

