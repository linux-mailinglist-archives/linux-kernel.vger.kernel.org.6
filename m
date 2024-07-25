Return-Path: <linux-kernel+bounces-262289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DD93C384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F3283AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1046719B3D7;
	Thu, 25 Jul 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZrz71yD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC716DEA8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916323; cv=none; b=LmVOZqtwPZoav/PDYQDbnvm7/Y/5aFuddC9wIBd7P+BV2M6s/bkv9SiZ5VA6v2a6SZ+NFrVaPmkI0uNYibnevA2CT7BMjQTWA3z36Do9qwhLPCK7mcMR+0XISj+fJJ4IfHerIFo5Q+wrPv0RF5c+s5G+CuTEyQD/RK+OekvvF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916323; c=relaxed/simple;
	bh=/j3cLWVUUurIj6DUx8kFKcBKB3rD7S/2BPFrT3456Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJxuuf1fYQS+i5EcTklReimvL+svoqViHVJt2ujgNMHiLtmpMXtkzBIsleEyo9qLHB+VChnFkPQ7AO4yu1NlFg3fySI7WdTZK6EKp1JmPXpgrf2v5XadKjbYsqPqb3Bx1x9AA5fRXOQQhpmibrQ0xJSkoKodxFhsznAHhzK3h4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZrz71yD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=su7rRU8Prh+iCWqV89aHbmQnzeO0tWuKHYFW3mKdf9k=; b=dZrz71yDwGuecLAEUCxRJFmbRA
	LvTHWbwd5maAiTE1jnCikHcEJGA7Iw3jWSs+pRmbR0JYHzahXUj8iswhGB49MqX2U4LfPSdVHZhtP
	4No3aLySK6EkYWQ5aPwah/qCv1TAG3wv0XRwxIVnk34wwJPhsWj6UjO5rQtXCeBEdd23Ri19zbIQN
	DVZjCh1qLzKeoBYdq9d0rQEhLS3CvJlAyugn8c7ABC8oPmWMA2UAPuzkZxPI1wfQvvXysTVfAcGi3
	sqgVwIFacic4R0y4q6cZBmrFS/R9OMMakD/Ky3LgdU/F/AFYO8hpOeRZsZq804LoWrslA+4oaHpny
	Y1CflxTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWz5g-000000041wy-3l2s;
	Thu, 25 Jul 2024 14:05:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8668A30037B; Thu, 25 Jul 2024 16:05:08 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:05:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zheng Zucheng <zhengzucheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/cputime: Fix mul_u64_u64_div_u64() precision
 for cputime
Message-ID: <20240725140508.GH13387@noisy.programming.kicks-ass.net>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725120315.212428-1-zhengzucheng@huawei.com>

On Thu, Jul 25, 2024 at 12:03:15PM +0000, Zheng Zucheng wrote:
> In extreme test scenarios:
> the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
> utime = 18446744073709518790 ns, rtime = 135989749728000 ns
> 
> In cputime_adjust() process, stime is greater than rtime due to
> mul_u64_u64_div_u64() precision problem.
> before call mul_u64_u64_div_u64(),
> stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
> after call mul_u64_u64_div_u64(),
> stime = 135989949653530
> 
> unsigned reversion occurs because rtime is less than stime.
> utime = rtime - stime = 135989749728000 - 135989949653530
> 		      = -199925530
> 		      = (u64)18446744073709518790
> 
> Trigger scenario:
> 1. User task run in kernel mode most of time.
> 2. The ARM64 architecture && CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y &&
>    TICK_CPU_ACCOUNTING=y
> 
> Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime
> 
> Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
> Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
> ---
>  kernel/sched/cputime.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index aa48b2ec879d..365c74e95537 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -582,6 +582,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	}
>  
>  	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> +	if (unlikely(stime > rtime))
> +		stime = rtime;

But but but... for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y the code you're
patching is not compiled!


