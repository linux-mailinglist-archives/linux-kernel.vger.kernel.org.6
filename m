Return-Path: <linux-kernel+bounces-557355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A268A5D7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ACC18978E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDE22E40A;
	Wed, 12 Mar 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/ScKAp4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D33595E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766474; cv=none; b=sqlguLCglKqGsWBGaC6xRZmzi3rV2v+5WuQtfHiKBvJkXHrbmPPhVFWkQS7B1PF65a39PoZ0JyK89Zs9FudXZEdZs1CCUdkshDxzwJ6YVBGZpDrkCgYrt518KoAerdhfRj9sJz0MsD1JZFfHD2c81Qduyj/iPDAV13FLCUE8n0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766474; c=relaxed/simple;
	bh=cV03ESb0BZFSnHGOdvbKkOjLSRJ8MayLsViiXqoCGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kij6RImTr97zA/Ob2fNbwQHSmYCvBCx787PyZbB+cdfl9tEA0Q3lrxyDSYBQ+4vKk2cv/4rm6Au6zJwk89DnoLvdjmzPjMjM4HznfjpvN/iHfH8aqREXTGFUisbldbfnZYsSRddbrD+4erYc1/lo3EqcEz7NB39vv4SumvHULC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B/ScKAp4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0yfgPQW3aVyZ3pxPAQkcuvzAyczIEDG/1UyKLgZ5UfM=; b=B/ScKAp4tU84syqN+XKwFwCjEJ
	IRlrFurAKUV4+IKP6C5tYhyofag/DcH2bt7Mv9fkRoi/gDRg85NsaVpz0QZ7pQbvV4FuAorkguMLH
	uFvpGoTCZ0Zdve0qoP5XvyP7DyPzGldZq4Sn+xXSZXe8eeglCAmo5D0HF6wWBdWLeDl5bPUY1jy4y
	EOMoAix1Pa3+jDuKHXxTBsglztJtRGiuCi7xcr6/Fj4f8s9ynv1N1M6o+nYTm7+EMYQ1bM+q9SW5w
	15fJRqVhC0LZG5DFP2bK4qF8w3C/FKSWrQlG6zDpyXCUzoqUA2VMK0D2KZJyzw2Fb+cbd40K47txC
	2iwice+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsH1T-00000002KjG-3jNP;
	Wed, 12 Mar 2025 08:01:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81CEE300599; Wed, 12 Mar 2025 09:01:02 +0100 (CET)
Date: Wed, 12 Mar 2025 09:01:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tj@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, akpm@linux-foundation.org,
	longman@redhat.com, lorenzo.stoakes@oracle.com
Subject: Re: [PATCH] sched/numa: skip VMA scanning on memory pinned to one
 NUMA node via cpuset.mems
Message-ID: <20250312080102.GF19424@noisy.programming.kicks-ass.net>
References: <20250311160447.2813222-1-libo.chen@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311160447.2813222-1-libo.chen@oracle.com>

On Tue, Mar 11, 2025 at 09:04:47AM -0700, Libo Chen wrote:
> When the memory of the current task is pinned to one NUMA node by cgroup,
> there is no point in continuing the rest of VMA scanning and hinting page
> faults as they will just be overhead. With this change, there will be no
> more unnecessary PTE updates or page faults in this scenario.

Its been a while since I looked at all this, but if we don't scan these
pages, then it will not account for these pages, and the pinned memory
will not become an attractor for the tasks that use this memory, right?

> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d27952431..ec4749a7be33a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3315,6 +3315,13 @@ static void task_numa_work(struct callback_head *work)
>  	if (p->flags & PF_EXITING)
>  		return;
>  
> +	/*
> +	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
> +	 * no page can be migrated.
> +	 */
> +	if (nodes_weight(cpuset_current_mems_allowed) == 1)
> +		return;
> +
>  	if (!mm->numa_next_scan) {
>  		mm->numa_next_scan = now +
>  			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
> -- 
> 2.43.5
> 

