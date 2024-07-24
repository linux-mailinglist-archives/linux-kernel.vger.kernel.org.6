Return-Path: <linux-kernel+bounces-260901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C193B000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C999FB20D95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B1156861;
	Wed, 24 Jul 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LtSXE9iJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C346156F20
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818441; cv=none; b=B89+al2JQbkr1CPa8Sdb4XvXYqKRZeGEKcOF8mOvJ+eXaDdahfM7Ri3jPMbE+9Qqpv//6ZLFMvHjqJBw7ojSQ0zmQ2wHMubq21ML+DGCaqHTqmH7Owdub4KQWuAHuXlu0r/Zfn8w6c2z6IxCud9zYJ5BjAQWUV9c4lBt3uhJRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818441; c=relaxed/simple;
	bh=SUSZ50lr25Yi6ulBf8yO+0sn5rK7c/a5twcJJAH63uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuhWduxnCXP8l3VHne92PSAXvHc5MLFyD4MxJwZ20XEGQyNXKmcAPKVhEs3qTP0w+CZ4qcTjHE3QEOtfNjh9yQ5uSZXIDNTYhifNSSOuT/LvxmQWJBfWNDvOwNKofYqAhqZWvWDNh93OOCU9cL02i+/mvyYekbTCqPfhNG7JbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LtSXE9iJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vh7Huajjy7AtMHNARk3EpmfPPGZu0XxTHnxYJdBV2yw=; b=LtSXE9iJxbbLXzHJGBr3ZMaGOa
	1qow5CPzs5PwIH3VKTRudTQdP4MYHa207KExoc33G0X6ita2XaMlWGucq1qNXi1WWVdCkDn2Ey1pP
	cCI9ENW9AvjVQL6bHfT/XjL7cubdPUIzVwBqBMOy0zHUlnl8HgUMinx4sro+r8bCNeKVVwMQxhAc4
	dC/d8UFwXuy3Y39zUCC+GRpZ2m7AeBBVjW3mSiiCw77bLjxCPHF35c9nVqfIn8HciX0c5XVFUeqRy
	7fpr3rXL/cwnOYMsenV4T1HiVNg38f7JFo95IJcrrGaZXeqrr9WgV7WAlmraYEwHlzb5q4P2hSFYY
	Qptkcs+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWZcq-00000003ovF-0CTW;
	Wed, 24 Jul 2024 10:53:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10F2B3003EA; Wed, 24 Jul 2024 12:53:39 +0200 (CEST)
Date: Wed, 24 Jul 2024 12:53:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, zhangqiao22@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/fair: inline cpu_util_without and cpu_util
 to improve performance
Message-ID: <20240724105338.GA13387@noisy.programming.kicks-ass.net>
References: <20240723073607.568819-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723073607.568819-1-lizetao1@huawei.com>

On Tue, Jul 23, 2024 at 03:36:07PM +0800, Li Zetao wrote:
> The commit 3eb6d6ececca ("sched/fair: Refactor CPU utilization functions")
> refactored cpu_util_without and cpu_util functions. Since the size of
> cpu_util function has increased, the inline cpu_util is dropped. This had
> a negative impact on performance, in the scenario of updating
> sched_group's statistics, cpu_util_without and cpu_util functions are on
> the hotspot path.
> 
> Inlining cpu_util_without and cpu_util functions have been shown to
> significantly improve performance in lmbench as follow:
> 
>   Machine: Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz
>                      before          after          diff
>   fork+exit          317.0625        303.6667       -4.22%
>   fork+execve        1482.5000       1407.0000      -5.09%
>   fork+/bin/sh       2096.0000       2020.3333      -3.61%

That's quite significant. Did you look at what exactly was causing this?

> This patch introduces inlining to cpu_util_without and cpu_util functions.
> While this increases the size of kernel/sched/fair.o, the performance
> gains in critical workloads make this an acceptable trade-off.
> 
> Size comparison before and after patch:
>      text	   data	    bss	    dec	    hex	filename
>    0x1264a	 0x1506	   0xb0	  80896	  13c00	kernel/sched/fair.o.before
>    0x12672	 0x14fe	   0xb0	  80928	  13c20	kernel/sched/fair.o.after
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

This SoB chain is not valid. Please review the documentation we have
on this.

> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5904405ffc59..677b78fa65b6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7706,7 +7706,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   *
>   * Return: (Boosted) (estimated) utilization for the specified CPU.
>   */
> -static unsigned long
> +static __always_inline unsigned long
>  cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  {
>  	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> @@ -7794,7 +7794,7 @@ unsigned long cpu_util_cfs_boost(int cpu)
>   * utilization of the specified task, whenever the task is currently
>   * contributing to the CPU utilization.
>   */
> -static unsigned long cpu_util_without(int cpu, struct task_struct *p)
> +static __always_inline unsigned long cpu_util_without(int cpu, struct task_struct *p)
>  {
>  	/* Task has no contribution or is new */
>  	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> -- 
> 2.34.1
> 

