Return-Path: <linux-kernel+bounces-564303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021BA65252
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2B3AE6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3222E41D;
	Mon, 17 Mar 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EX0rE/E2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C02356D0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220487; cv=none; b=LUJ/Kgmo3b0cAiKACeKMQFvYLqMKCfkzl+bUJLhaMPiOyjR4rH5VEfVKRW0IqfDiZ2vbXWpId3opB6c4BjOFXIf3XOo66GmG3A5Q1a7HdDRlBYZw0JcT1tx5OIYEG9pM6WWYKejUr8JDdNCHlwzEYw0FsD38s0l03nlMaEAw92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220487; c=relaxed/simple;
	bh=7rm2A/Gtog+7Ev6egXDljiyoZqMU8HIiViSXYrJr/ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQSHlhCIB9KxSHZITtxKt7sSwOUW5o4i9Ccb7+VZjOFEZA28r/HAQGjRQRLi/CmmU2JHYKkQ6uHHJnggfckY16nES+ddg7J9t8OdajH+O0Xhr2O3OQUaj5XKjV5cPoQ3tWHHySy0Lj4hA6BxhhuF6D6BnnbmWWztsKTkgLmiqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EX0rE/E2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FNcwA8bqmFIbO0ByH7OYZYJEnoNhMEhuhycu16IpLfU=; b=EX0rE/E2YSBLxNDjZIO52ZgmsK
	H67wE2uWP+GVVTR8a3Kaim3d+jDF0l2K2id5UvnYiTQjDDpyPxam/Eoxl1Ug1CoAuEtRVGjWf/gOR
	0aXoE6lG7KeWKZwj3IOnvPwhYGcE9RsgegHsJ3rINwSV/ivM/egIlBmqlxY+kn/8iRFQF4EAxwYv9
	9MmQxoNPdi8LitES7tNzm5E3K1k/5bZ6Ujj1zNtRR24Rn0fIbzrPh0Fjn/SyJjxidlu1TCEFrHG+w
	YjJSwKx0mHUD0XxBv3Ik5RTTtVYOlsvn+ucrNcEBz8T96C+xnn5ZRxXwWNmemeAM/vFEKNDg/fXI2
	WOK2X1wA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuB8F-00000008qiV-2L5S;
	Mon, 17 Mar 2025 14:07:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17A72300783; Mon, 17 Mar 2025 15:07:55 +0100 (CET)
Date: Mon, 17 Mar 2025 15:07:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Valentin Schneider <valentin.schneider@arm.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH v15 6/7] sched: Fix proxy/current (push,pull)ability
Message-ID: <20250317140754.GD36386@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-7-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221147.1865364-7-jstultz@google.com>

On Wed, Mar 12, 2025 at 03:11:36PM -0700, John Stultz wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b4f7b14f62a24..3596244f613f8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6722,6 +6722,23 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  }
>  #endif /* SCHED_PROXY_EXEC */
>  
> +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *owner)
> +{
> +	if (!sched_proxy_exec())
> +		return;
> +	/*
> +	 * pick_next_task() calls set_next_task() on the chosen task
> +	 * at some point, which ensures it is not push/pullable.
> +	 * However, the chosen/donor task *and* the mutex owner form an
> +	 * atomic pair wrt push/pull.
> +	 *
> +	 * Make sure owner we run is not pushable. Unfortunately we can
> +	 * only deal with that by means of a dequeue/enqueue cycle. :-/
> +	 */
> +	dequeue_task(rq, owner, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> +	enqueue_task(rq, owner, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
> +}

So this is probably fine at this point; but we should eventually look at
fixing this.

We can probably look at (ab)using sched_class::set_cpus_allowed() for
this.

