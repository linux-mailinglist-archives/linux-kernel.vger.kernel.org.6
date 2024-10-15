Return-Path: <linux-kernel+bounces-366624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802299F7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C284283CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA421F6695;
	Tue, 15 Oct 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmOaEHRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E31CB9E2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023144; cv=none; b=tuRyJ1PpmtF7EutFNY/eqRoi9UOkTG+wO1PywDTFJ/GYNDJNgfsWeznalJviBpwI7ou1joPLhcO5EFt/+MEW0ACmVGAi+80wcFViVviuhsktvPLY5dNA3/Dw2sdI2YZP6gzcRN/YIkkQrM3kET9Ej7Er/AGYKHZH73yIF9P6/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023144; c=relaxed/simple;
	bh=M1SCTXMr+b5zr2yyOrBn6ATbPhggJJgPeqPGJJ87fck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFRH2ChXDeoxUhsahu2jWnQdfY2rlnBLP4tQYL2Zw7w59/ppbPijcF9WkE7kB5M1zeeAwos7RqT0573UeArew49rmBKXPgl+4HQjxNgVLsKntcjMG/vEO6+qvh/CoWnHiKOmiDnRbdWEOoZByDRq+wyjIdEyIDOXvcC24Jtb2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmOaEHRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED074C4CEC6;
	Tue, 15 Oct 2024 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729023144;
	bh=M1SCTXMr+b5zr2yyOrBn6ATbPhggJJgPeqPGJJ87fck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmOaEHRT8+gCJK850xGADQn1L/R8rKVUJv/k0jHmu6BwRunF95BP+cOWNKj6P7vLH
	 p1kHEzQIndWzF6XvpC3+KZ1pnB0vYzlB6JSJwLmgasctR5SAvb539ZXB7jkZWjFv7z
	 0muIWJIZDFNwEqfTAhp0+qvMmClejlUgs1WOXyo0cgAd+iqCJpGPawM2CImLzt6dU0
	 sYvtonn3Ou31F3VfMBGoERe9lZXUhRQPoz+6XFjp3h3SRZoFDZCGKXxJeD3oevvxgz
	 D11JKLLuu+yz3vM1Tse14NQHaDv5PLBM/3OEHxuqW9h1YleWJ47RccffQp1cgxFvqb
	 yCqhoRr8SJjyg==
Date: Tue, 15 Oct 2024 10:12:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix missing unlock in consume_dispatch_q()
Message-ID: <Zw7MpoDcKmX9mGlK@slm.duckdns.org>
References: <20241015142917.83397-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015142917.83397-1-zhangqiao22@huawei.com>

Hello,

On Tue, Oct 15, 2024 at 10:29:17PM +0800, Zhang Qiao wrote:
> When the function consume_dispatch_q() returns true, the dsq lock may
> remains held and is not unlocked.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/sched/ext.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 410a4df8a121..4d80aa3de00e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2377,7 +2377,8 @@ static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p
>  static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
>  {
>  	struct task_struct *p;
> -retry:
> +	bool ret = false;
> +
>  	/*
>  	 * The caller can't expect to successfully consume a task if the task's
>  	 * addition to @dsq isn't guaranteed to be visible somehow. Test
> @@ -2394,19 +2395,20 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
>  		if (rq == task_rq) {
>  			task_unlink_from_dsq(p, dsq);
>  			move_local_task_to_local_dsq(p, 0, dsq, rq);
> -			raw_spin_unlock(&dsq->lock);
> -			return true;
> +			ret = true;
> +			break;
>  		}
>  
>  		if (task_can_run_on_remote_rq(p, rq, false)) {
> -			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
> -				return true;
> -			goto retry;
> +			if (likely(consume_remote_task(rq, p, dsq, task_rq))) {
> +				ret = true;
> +				break;
> +			}
>  		}
>  	}
>  
>  	raw_spin_unlock(&dsq->lock);
> -	return false;
> +	return ret;

Has this change been tested at all? There's quite a bit of lock dancing
happening in the remote consumption path because the task needs to get
hot-migrated to the local CPU - consume_remote_task() calls
unlink_dsq_and_lock_src_rq() which drops the DSQ lock among other things.

Thanks.

-- 
tejun

