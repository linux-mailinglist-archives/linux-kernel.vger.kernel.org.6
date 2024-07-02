Return-Path: <linux-kernel+bounces-237442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAB923849
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C671C21FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6E14F10E;
	Tue,  2 Jul 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tfwy/TLx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED2140E50
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909887; cv=none; b=D/BcoIfa+2rpNET0/yGTQvRTNZNo59+RQ+DbDOqeqmjWEmjqZXE7p+Y2TML3VXleE9uZ/BZiNSho7TnWWeFjnL0nWtqCd/TGGuq7DCXFBr516G/CqIyiPmOCzK+FRfs3V3TM65lsJpdUCIo6jj9HpXO8VIx4SSh+dV4/yUJS9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909887; c=relaxed/simple;
	bh=60QjJI9sV9oq/vKSPgdEtiwZDP/48WWCMT3emPVn/4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU7ROx3xWqoMKwDpOl/cbPkyO64iHNxGKw11vgN3zwnsfJ66a7VZNT9YwR63M9wX0GtzjdECxr87BHF6KYXWxYBqxuETEZ1MwfbE4gtGxcQ9LtGvSNnVIErMciYHOjw3S1AXoP8Gj12N+XEBS5QoJ7JCOlP0bzOV9Kx6guIGzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tfwy/TLx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hFTJNhWR0aF+dKAF+AxPr4I3/8i8Q+f8RjkFBxYhUMM=; b=Tfwy/TLxJsSaQ0NSxnySq51LIP
	/e+6OqEa13KbTcDdw7uUQlVNel04CbOpqCGeiCtt2JUkmR8kWR81bqzfNHsMkpkdzg0GTuk/oodkG
	9yFR4oXdZ6mkx59Aq3NWtm0wo9ePcexCHQ63+R8p5AEDOfqNOUxPKyHNqIwQamVFXShJnwYTDqaCv
	p3mC4oo4AWxZxnfvZF6XVFu1yGo936Te6hcPDzz/oWYvM/+K+/NHku/+PB7tVNtioWMGLozq9ph+a
	v8FT/xaGB6B/od8XiL1T/8N/2TaN/55PVBe3X3Bh9VBaVGWOaeIdwRSfsk1BFsZ1EfhBfI7/UnE73
	foRLqQVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZ7a-00000009n7e-2ZRf;
	Tue, 02 Jul 2024 08:44:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 32A3A300694; Tue,  2 Jul 2024 10:44:18 +0200 (CEST)
Date: Tue, 2 Jul 2024 10:44:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, tglx@linutronix.de,
	yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
	yangyingliang@huawei.com, liwei391@huawei.com
Subject: Re: [PATCH resend] sched/smt: fix unbalance sched_smt_present dec/inc
Message-ID: <20240702084418.GB11386@noisy.programming.kicks-ass.net>
References: <20240702081128.4008011-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702081128.4008011-1-yangyingliang@huaweicloud.com>

On Tue, Jul 02, 2024 at 04:11:28PM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> I got the following warn report while doing stress test:
> 
> jump label: negative count!
> WARNING: CPU: 3 PID: 38 at kernel/jump_label.c:263 static_key_slow_try_dec+0x9d/0xb0
> Call Trace:
>  <TASK>
>  __static_key_slow_dec_cpuslocked+0x16/0x70
>  sched_cpu_deactivate+0x26e/0x2a0
>  cpuhp_invoke_callback+0x3ad/0x10d0
>  cpuhp_thread_fun+0x3f5/0x680
>  smpboot_thread_fn+0x56d/0x8d0
>  kthread+0x309/0x400
>  ret_from_fork+0x41/0x70
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> Because when cpuset_cpu_inactive() fails in sched_cpu_deactivate(),
> the cpu offline failed, but sched_smt_present is decremented before
> calling sched_cpu_deactivate(), it leads to unbalanced dec/inc, so
> fix it by incrementing sched_smt_present in the error path.
> 
> Fixes: c5511d03ec09 ("sched/smt: Make sched_smt_present track topology")
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bcf2c4cc0522..5ab6717b57e0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9756,6 +9756,10 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	sched_update_numa(cpu, false);
>  	ret = cpuset_cpu_inactive(cpu);
>  	if (ret) {
> +#ifdef CONFIG_SCHED_SMT
> +		if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +			static_branch_inc_cpuslocked(&sched_smt_present);
> +#endif
>  		balance_push_set(cpu, false);
>  		set_cpu_active(cpu, true);
>  		sched_update_numa(cpu, true);

Yes, does indeed appear needed, however!, when I look at
what else goes before this failure, should we not also call
set_rq_online() and things like that?

That is, can we rework things to be less fragile by sharing code between
this error path and sched_cpu_activate() ?

