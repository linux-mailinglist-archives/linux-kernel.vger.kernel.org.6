Return-Path: <linux-kernel+bounces-564271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB7A651A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176D97A3DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7023E227;
	Mon, 17 Mar 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="crZIQWPa"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182C33CFC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219330; cv=none; b=QparxHcuwVTE2Pj9AVdcKXZfsH+2s33M1vSke1yK2XQiwopUj0WeFt12ky1iNVV2iV7T97/a4BK5RS6Acmxr6VOgGpbSp4z+FlsSs9fD2IWom7gg3Ys++5r1ETyQsv0OLndijzOWUbKnsd195KZsAiJzhPmWjtgxBd7gRybT1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219330; c=relaxed/simple;
	bh=X5kQlAe6V0IWV3AfX/1cpge5j9TR7mJMVFfQqAnFVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK2oaDDspfIvb9gp/q2wAb5xvz0Exq0Mm0ex2h/ZtNrkyXKOhjSbnjczdV/nN1rvxc5AGmyZklJMqQlhbmXohYNp80lZ253X5v+jqGu/j3mymg187iIshPWXj0NtO4NNf8YhBAhhfgIM6BbRIRYa45Fz89wcKecf5JE7yrz6LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=crZIQWPa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VU7NEXsrVVZw4RIK+G8nYDaRoOUrahZLuONfHBtRehY=; b=crZIQWPa+dKSJQxpTyf4cXG/E3
	OoApJM4XIOdWlJxX+YcJERbADaUd7sG17rufN2h65SYZBwzDURtl3iwByt0h+O9bay2y0ZSRwNMX+
	BJnfybRDWRcduN2LhxKANN/HYl2bMXBnoZ0pbNAD0KYkUhI056BaUsCox5xJiWu9PDUHC/B6Kd+E8
	6dfJDNd0iyZbYpHJRNGhhOaL2V5wDVW42kJTHgdz98wveOGEblNLl33VIa9oSGiHIto+XekXSzdV/
	/YwGhFeJFTz0/Q9whqebq19frcoNqbibMprG2JwVmBh6+1Cbp/NtrjDm/5i9XeVYBCKkulX811CiB
	o4sqcqHw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuApZ-00000003SiA-49VO;
	Mon, 17 Mar 2025 13:48:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D136300783; Mon, 17 Mar 2025 14:48:37 +0100 (CET)
Date: Mon, 17 Mar 2025 14:48:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH v15 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
Message-ID: <20250317134837.GC36386@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-6-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221147.1865364-6-jstultz@google.com>

On Wed, Mar 12, 2025 at 03:11:35PM -0700, John Stultz wrote:
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b12..2d418e0efecc5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1479,8 +1479,19 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  
>  	enqueue_rt_entity(rt_se, flags);
>  
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> -		enqueue_pushable_task(rq, p);
> +	/*
> +	 * Current can't be pushed away. Selected is tied to current,
> +	 * so don't push it either.
> +	 */
> +	if (task_current(rq, p) || task_current_donor(rq, p))
> +		return;
> +	/*
> +	 * Pinned tasks can't be pushed.
> +	 */
> +	if (p->nr_cpus_allowed == 1)
> +		return;
> +
> +	enqueue_pushable_task(rq, p);
>  }
>  

As per always, deadline.c will have the exact same logic.

