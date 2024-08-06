Return-Path: <linux-kernel+bounces-275545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F494870C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5771F2337E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C46DA94D;
	Tue,  6 Aug 2024 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CW4mAufi"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F4AD2F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722908285; cv=none; b=B0ECXZn4FMLRhdqg+gsHEml/XAPFXiCg1ocml22/n3u6G06rSx1TeWY1g7I6W+opriaDLbHx5M44ttVetuFgBzCmV58LrN67bbTcMAp9m5buoAzE/0SXU3ork5VmZxdImWsTHSQL8bg4KWiFJvyKEwfr/bLI/2oJU88U5CGtXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722908285; c=relaxed/simple;
	bh=62OR+osmhvVrRkCCGmpJ2k4DKFgK6QrQu5cBNt2dBOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHSecg6PAhXPcR5enA26AhvoiwmLrkKrpbsfeca0FdDO6YO6jGaNTvkpccQYctcdrhFXa7ccBsB5lqPyE76hVKxQHuc4wlk6FuyXPanY8rSFyHrlxpUlUf2SCx72Uv4IgSq+iZdRg8IVok0WR/t3EWBB8eXpclAHROSBi+pYdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CW4mAufi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfadf3c5-f504-49ef-b3fc-123e8959d21e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722908279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp/xSLic9DLbASNSnuSbbFY/ITMYMwm6d+Z54faE6Ig=;
	b=CW4mAufihRQIFkcgoPFg88uOFaHUQEkhwD1fsv2wc0M8NjQr0qa8whDj4I2eRikIY8T2S2
	WNHqGCKmaqd3AdViU3X/TyWQKuD5wZdKKXCw+xbnzh2NjwqGVBvpU/RLU4BZDHj+r1gfqK
	hxK47HjKhDk3wtnrRz0xc+9R3HwxKyE=
Date: Tue, 6 Aug 2024 09:37:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 sched_ext/for-6.12] sched/fair: Make balance_fair()
 test sched_fair_runnable() instead of rq->nr_running
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, David Vernet <void@manifault.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
 <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/6 06:39, Tejun Heo wrote:
> balance_fair() skips newidle balancing if rq->nr_running - there are already
> tasks on the rq, so no need to try to pull tasks. This tests the total
> number of queued tasks on the CPU instead of only the fair class, but is
> still correct as the rq can currently only have fair class tasks while
> balance_fair() is running.
> 
> However, with the addition of sched_ext below the fair class, this will not
> hold anymore and make put_prev_task_balance() skip sched_ext's balance()
> incorrectly as, when a CPU has only lower priority class tasks,
> rq->nr_running would still be positive and balance_fair() would return 1
> even when fair doesn't have any tasks to run.
> 
> Update balance_fair() to use sched_fair_runnable() which tests
> rq->cfs.nr_running which is updated by bandwidth throttling. Note that
> pick_next_task_fair() already uses sched_fair_runnable() in its optimized
> path for the same purpose.
> 
> v2: K Prateek Nayak pointed out that the bw control issue described in v1
>      was incorrect. Patch description updated. As this makes the patch only
>      relevant for sched_ext, I'll carry this through the sched_ext tree
>      unless there are objections.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>

Looks good to me.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   kernel/sched/fair.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8323,7 +8323,7 @@ static void set_cpus_allowed_fair(struct
>   static int
>   balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   {
> -	if (rq->nr_running)
> +	if (sched_fair_runnable(rq))
>   		return 1;
>   
>   	return sched_balance_newidle(rq, rf) != 0;

