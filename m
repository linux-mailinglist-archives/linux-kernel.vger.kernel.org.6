Return-Path: <linux-kernel+bounces-548384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F00A54416
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB303A77A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C911C84B8;
	Thu,  6 Mar 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiRLBWEe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788B1A23BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247846; cv=none; b=TUSIfegY1V1yPjeThOeB1cAdwvzPPdCRc618x0K2RxbTZXHUegYLhibbtBZoZyX9EAYtoiTVcHL1vo3T1F7LOD26k/VrPDGX1Ve5JfwhJX0WE7eUUepPxzy1NXpwyY/1NTX3SmzhKHdv+8Xc77VaFZEYZjOvzzRSOUZ0iOgxD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247846; c=relaxed/simple;
	bh=zVPvZQ7PAFxemO7wsuaqhKE3MZicJEH1Tq8aPPDVuxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcLjIGT8a673Uj3Wgkxu6aUJV2r8yuNQR87NDGNIC1n2lGDLIEEJ51dro+325le6n4vincl1nFIkEr4k+SnPOuZ0Cff7W2WSwz4Oi72MV7NM+L1aBrzPH7ST85opTvPIV6jFjmtNj/PTY+6YdxU2spTDvLWBTEVBpyurz4tpII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiRLBWEe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741247844; x=1772783844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVPvZQ7PAFxemO7wsuaqhKE3MZicJEH1Tq8aPPDVuxU=;
  b=TiRLBWEew2u1xJtvMq5D+//0ajgOQt+HRHx0M5frDxMQ4weNnsOOofO7
   CBng8Y8qfOwp6iz3J4BpyjKIS5/Ojunb+fSWGwlIlKDK7sB77Sfcpepwm
   6e91nGy3k4GWfhdGiGJH6AX+AxLsXXJptWbfWz6CzDztIaFzF117jeZXq
   jycmKWpR1RiU0HE9Bzy88HhuJqhWkT1sRs8QSY1YrDQMK8CJTVwn874SN
   Zm+bwEpyti6cumTBXO+cfvZ4o5kWhGgDiButhyVpLa9qdrCl/5fG4wv0N
   1I4Kt8Xplbaw9qRssjNaoUPM+V5N9Ojb1902GDBp2EnkVqQl3Liz+4F/D
   Q==;
X-CSE-ConnectionGUID: UjYkZiTKSymyDxcGwJG2NQ==
X-CSE-MsgGUID: iKki5NH9SqOHu2UneVEZVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53653581"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53653581"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:57:23 -0800
X-CSE-ConnectionGUID: vjNLyz0AT9q/BQjgJFN3kQ==
X-CSE-MsgGUID: Ml/XdwouThWuSOTExhSsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123103850"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:57:20 -0800
Date: Thu, 6 Mar 2025 15:57:38 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH 04/19] perf: Simplify perf_event_alloc() error path
Message-ID: <Z8lVchtSX/w/atEU@ly-workstation>
References: <20241104133909.669111662@infradead.org>
 <20241104135517.967889521@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104135517.967889521@infradead.org>

On Mon, Nov 04, 2024 at 02:39:13PM +0100, Peter Zijlstra wrote:
> The error cleanup sequence in perf_event_alloc() is a subset of the
> existing _free_event() function (it must of course be).
> 
> Split this out into __free_event() and simplify the error path.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/perf_event.h |   16 +++--
>  kernel/events/core.c       |  134 ++++++++++++++++++++++-----------------------
>  2 files changed, 76 insertions(+), 74 deletions(-)
> 
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -652,13 +652,15 @@ struct swevent_hlist {
>  	struct rcu_head			rcu_head;
>  };
>  
> -#define PERF_ATTACH_CONTEXT	0x01
> -#define PERF_ATTACH_GROUP	0x02
> -#define PERF_ATTACH_TASK	0x04
> -#define PERF_ATTACH_TASK_DATA	0x08
> -#define PERF_ATTACH_ITRACE	0x10
> -#define PERF_ATTACH_SCHED_CB	0x20
> -#define PERF_ATTACH_CHILD	0x40
> +#define PERF_ATTACH_CONTEXT	0x0001
> +#define PERF_ATTACH_GROUP	0x0002
> +#define PERF_ATTACH_TASK	0x0004
> +#define PERF_ATTACH_TASK_DATA	0x0008
> +#define PERF_ATTACH_ITRACE	0x0010
> +#define PERF_ATTACH_SCHED_CB	0x0020
> +#define PERF_ATTACH_CHILD	0x0040
> +#define PERF_ATTACH_EXCLUSIVE	0x0080
> +#define PERF_ATTACH_CALLCHAIN	0x0100
>  
>  struct bpf_prog;
>  struct perf_cgroup;
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5246,6 +5246,8 @@ static int exclusive_event_init(struct p
>  			return -EBUSY;
>  	}
>  
> +	event->attach_state |= PERF_ATTACH_EXCLUSIVE;
> +
>  	return 0;
>  }
>  
> @@ -5253,14 +5255,13 @@ static void exclusive_event_destroy(stru
>  {
>  	struct pmu *pmu = event->pmu;
>  
> -	if (!is_exclusive_pmu(pmu))
> -		return;
> -
>  	/* see comment in exclusive_event_init() */
>  	if (event->attach_state & PERF_ATTACH_TASK)
>  		atomic_dec(&pmu->exclusive_cnt);
>  	else
>  		atomic_inc(&pmu->exclusive_cnt);
> +
> +	event->attach_state &= ~PERF_ATTACH_EXCLUSIVE;
>  }
>  
>  static bool exclusive_event_match(struct perf_event *e1, struct perf_event *e2)
> @@ -5319,40 +5320,20 @@ static void perf_pending_task_sync(struc
>  	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
>  }
>  
> -static void _free_event(struct perf_event *event)
> +/* vs perf_event_alloc() error */
> +static void __free_event(struct perf_event *event)
>  {
> -	irq_work_sync(&event->pending_irq);
> -	irq_work_sync(&event->pending_disable_irq);
> -	perf_pending_task_sync(event);
> -
> -	unaccount_event(event);
> +	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
> +		put_callchain_buffers();
>  
> -	security_perf_event_free(event);
> +	kfree(event->addr_filter_ranges);
>  
> -	if (event->rb) {
> -		/*
> -		 * Can happen when we close an event with re-directed output.
> -		 *
> -		 * Since we have a 0 refcount, perf_mmap_close() will skip
> -		 * over us; possibly making our ring_buffer_put() the last.
> -		 */
> -		mutex_lock(&event->mmap_mutex);
> -		ring_buffer_attach(event, NULL);
> -		mutex_unlock(&event->mmap_mutex);
> -	}
> +	if (event->attach_state & PERF_ATTACH_EXCLUSIVE)
> +		exclusive_event_destroy(event);
>  
>  	if (is_cgroup_event(event))
>  		perf_detach_cgroup(event);
>  
> -	if (!event->parent) {
> -		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> -			put_callchain_buffers();
> -	}
> -
> -	perf_event_free_bpf_prog(event);
> -	perf_addr_filters_splice(event, NULL);
> -	kfree(event->addr_filter_ranges);
> -
>  	if (event->destroy)
>  		event->destroy(event);
>  
> @@ -5363,22 +5344,58 @@ static void _free_event(struct perf_even
>  	if (event->hw.target)
>  		put_task_struct(event->hw.target);
>  
> -	if (event->pmu_ctx)
> +	if (event->pmu_ctx) {
> +		/*
> +		 * put_pmu_ctx() needs an event->ctx reference, because of
> +		 * epc->ctx.
> +		 */
> +		WARN_ON_ONCE(!event->ctx);
> +		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
>  		put_pmu_ctx(event->pmu_ctx);
> +	}
>  
>  	/*
> -	 * perf_event_free_task() relies on put_ctx() being 'last', in particular
> -	 * all task references must be cleaned up.
> +	 * perf_event_free_task() relies on put_ctx() being 'last', in
> +	 * particular all task references must be cleaned up.
>  	 */
>  	if (event->ctx)
>  		put_ctx(event->ctx);
>  
> -	exclusive_event_destroy(event);
> -	module_put(event->pmu->module);
> +	if (event->pmu)
> +		module_put(event->pmu->module);
>  
>  	call_rcu(&event->rcu_head, free_event_rcu);
>  }
>  
> +/* vs perf_event_alloc() success */
> +static void _free_event(struct perf_event *event)
> +{
> +	irq_work_sync(&event->pending_irq);
> +	irq_work_sync(&event->pending_disable_irq);
> +	perf_pending_task_sync(event);
> +
> +	unaccount_event(event);
> +
> +	security_perf_event_free(event);
> +
> +	if (event->rb) {
> +		/*
> +		 * Can happen when we close an event with re-directed output.
> +		 *
> +		 * Since we have a 0 refcount, perf_mmap_close() will skip
> +		 * over us; possibly making our ring_buffer_put() the last.
> +		 */
> +		mutex_lock(&event->mmap_mutex);
> +		ring_buffer_attach(event, NULL);
> +		mutex_unlock(&event->mmap_mutex);
> +	}
> +
> +	perf_event_free_bpf_prog(event);
> +	perf_addr_filters_splice(event, NULL);
> +
> +	__free_event(event);
> +}
> +
>  /*
>   * Used to free events which have a known refcount of 1, such as in error paths
>   * where the event isn't exposed yet and inherited events.
> @@ -11922,8 +11939,10 @@ static int perf_try_init_event(struct pm
>  			event->destroy(event);
>  	}
>  
> -	if (ret)
> +	if (ret) {
> +		event->pmu = NULL;
>  		module_put(pmu->module);
> +	}
>  
>  	return ret;
>  }
> @@ -12251,7 +12270,7 @@ perf_event_alloc(struct perf_event_attr
>  	 * See perf_output_read().
>  	 */
>  	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
> -		goto err_ns;
> +		goto err;
>  
>  	if (!has_branch_stack(event))
>  		event->attr.branch_sample_type = 0;
> @@ -12259,7 +12278,7 @@ perf_event_alloc(struct perf_event_attr
>  	pmu = perf_init_event(event);
>  	if (IS_ERR(pmu)) {
>  		err = PTR_ERR(pmu);
> -		goto err_ns;
> +		goto err;
>  	}
>  
>  	/*
> @@ -12269,24 +12288,24 @@ perf_event_alloc(struct perf_event_attr
>  	 */
>  	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
>  		err = -EINVAL;
> -		goto err_pmu;
> +		goto err;
>  	}
>  
>  	if (event->attr.aux_output &&
>  	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
>  		err = -EOPNOTSUPP;
> -		goto err_pmu;
> +		goto err;
>  	}
>  
>  	if (cgroup_fd != -1) {
>  		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
>  		if (err)
> -			goto err_pmu;
> +			goto err;
>  	}
>  
>  	err = exclusive_event_init(event);
>  	if (err)
> -		goto err_pmu;
> +		goto err;
>  
>  	if (has_addr_filter(event)) {
>  		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
> @@ -12294,7 +12313,7 @@ perf_event_alloc(struct perf_event_attr
>  						    GFP_KERNEL);
>  		if (!event->addr_filter_ranges) {
>  			err = -ENOMEM;
> -			goto err_per_task;
> +			goto err;
>  		}
>  
>  		/*
> @@ -12319,41 +12338,22 @@ perf_event_alloc(struct perf_event_attr
>  		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
>  			err = get_callchain_buffers(attr->sample_max_stack);
>  			if (err)
> -				goto err_addr_filters;
> +				goto err;
> +			event->attach_state |= PERF_ATTACH_CALLCHAIN;
>  		}
>  	}
>  
>  	err = security_perf_event_alloc(event);
>  	if (err)
> -		goto err_callchain_buffer;
> +		goto err;
>  
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  
>  	return event;
>  
> -err_callchain_buffer:
> -	if (!event->parent) {
> -		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> -			put_callchain_buffers();
> -	}
> -err_addr_filters:
> -	kfree(event->addr_filter_ranges);
> -
> -err_per_task:
> -	exclusive_event_destroy(event);
> -
> -err_pmu:
> -	if (is_cgroup_event(event))
> -		perf_detach_cgroup(event);
> -	if (event->destroy)
> -		event->destroy(event);
> -	module_put(pmu->module);
> -err_ns:
> -	if (event->hw.target)
> -		put_task_struct(event->hw.target);
> -	call_rcu(&event->rcu_head, free_event_rcu);
> -
> +err:
> +	__free_event(event);
>  	return ERR_PTR(err);
>  }
>
Hi Peter Zijlstra ,

Greetings!

I used Syzkaller and found that in linux-next (tag: next-20250303), there are two issues and the first bad commit for both issues is

"
02be310c2d24 perf/core: Simplify the perf_event_alloc() error path
"

Issue 1: There is WARNING in __unregister_ftrace_function 
repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/repro1.c
repro binary:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/repro1
bzImage:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/bzImage_1
dmesg:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/dmesg_1.log

"
[   25.925933] ------------[ cut here ]------------
[   25.926631] WARNING: CPU: 1 PID: 729 at kernel/trace/ftrace.c:378 __unregister_ftrace_function+0x2dc/0x410
[   25.927470] Modules linked in:
[   25.927743] CPU: 1 UID: 0 PID: 729 Comm: repro Not tainted 6.14.0-rc5-next-20250303-cd3215bbcb9d #1
[   25.928370] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   25.929147] RIP: 0010:__unregister_ftrace_function+0x2dc/0x410
[   25.929614] Code: 5f 06 49 81 fc 00 91 ed 87 0f 84 bb 00 00 00 e8 3a 90 fa ff 4c 39 e3 0f 84 b9 00 00 00 4c 89 e3 e9 c0 fd ff ff e8 24 90 fa ff <0f> 0b 41 bc f0 ff ff ff e9 b9 fe ff ff e8 12 90 fa ff be ff ff ff
[   25.930905] RSP: 0018:ffff888013ecfb10 EFLAGS: 00010293
[   25.931285] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff818da8fa
[   25.931782] RDX: ffff88801341ca80 RSI: ffffffff818dab8c RDI: 0000000000000007
[   25.932281] RBP: ffff888013ecfb30 R08: 0000000000000000 R09: fffffbfff0fdafcc
[   25.932775] R10: 0000000000000001 R11: 1ffffffff1485d7d R12: 0000000000000000
[   25.933272] R13: ffff88800dd48d70 R14: ffffffff87e3fc20 R15: 0000000000000000
[   25.933848] FS:  00007f4f0f1f8600(0000) GS:ffff8880e36a9000(0000) knlGS:0000000000000000
[   25.934414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.934823] CR2: 00007f28ac627120 CR3: 0000000014c3c004 CR4: 0000000000770ef0
[   25.935325] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   25.935825] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   25.936320] PKRU: 55555554
[   25.936523] Call Trace:
[   25.936708]  <TASK>
[   25.936874]  ? show_regs+0x6d/0x80
[   25.937148]  ? __warn+0xf3/0x390
[   25.937402]  ? report_bug+0x25e/0x4b0
[   25.937734]  ? __unregister_ftrace_function+0x2dc/0x410
[   25.938118]  ? report_bug+0x2cb/0x4b0
[   25.938393]  ? __unregister_ftrace_function+0x2dc/0x410
[   25.938773]  ? __unregister_ftrace_function+0x2dc/0x410
[   25.939151]  ? handle_bug+0x2cd/0x510
[   25.939428]  ? __unregister_ftrace_function+0x2de/0x410
[   25.939811]  ? exc_invalid_op+0x3c/0x80
[   25.940098]  ? asm_exc_invalid_op+0x1f/0x30
[   25.940413]  ? __unregister_ftrace_function+0x4a/0x410
[   25.940786]  ? __unregister_ftrace_function+0x2dc/0x410
[   25.941162]  ? __unregister_ftrace_function+0x2dc/0x410
[   25.941550]  unregister_ftrace_function+0x52/0x400
[   25.941937]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   25.942315]  perf_ftrace_event_register+0x1af/0x260
[   25.942679]  perf_trace_destroy+0xa1/0x1d0
[   25.942986]  tp_perf_event_destroy+0x1f/0x30
[   25.943302]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[   25.943659]  __free_event+0x1e2/0x8a0
[   25.943931]  ? __kasan_check_write+0x18/0x20
[   25.944257]  perf_event_alloc.part.0+0x21be/0x3710
[   25.944619]  ? perf_event_alloc.part.0+0xff9/0x3710
[   25.944980]  __do_sys_perf_event_open+0x672/0x2bc0
[   25.945341]  ? __pfx___do_sys_perf_event_open+0x10/0x10
[   25.945765]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   25.946220]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   25.946571]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   25.946942]  __x64_sys_perf_event_open+0xc7/0x150
[   25.947285]  ? syscall_trace_enter+0x14d/0x280
[   25.947615]  x64_sys_call+0x1ea2/0x2150
[   25.947901]  do_syscall_64+0x6d/0x140
[   25.948183]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.948547] RIP: 0033:0x7f4f0ee3ee5d
[   25.948819] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   25.950110] RSP: 002b:00007ffe7bb958f8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   25.950641] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f0ee3ee5d
[   25.951143] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020002240
[   25.951640] RBP: 00007ffe7bb95900 R08: 0000000000000000 R09: 00007ffe7bb95930
[   25.952138] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe7bb95a58
[   25.952637] R13: 0000000000401b4f R14: 0000000000403e08 R15: 00007f4f0f241000
[   25.953154]  </TASK>
[   25.953326] irq event stamp: 851735
[   25.953596] hardirqs last  enabled at (851743): [<ffffffff81664ea5>] __up_console_sem+0x95/0xb0
[   25.954245] hardirqs last disabled at (851752): [<ffffffff81664e8a>] __up_console_sem+0x7a/0xb0
[   25.954851] softirqs last  enabled at (851498): [<ffffffff8148c93e>] __irq_exit_rcu+0x10e/0x170
[   25.955456] softirqs last disabled at (851493): [<ffffffff8148c93e>] __irq_exit_rcu+0x10e/0x170
[   25.956059] ---[ end trace 0000000000000000 ]---
[   27.413792] ------------[ cut here ]------------
[   27.414477] WARNING: CPU: 1 PID: 730 at kernel/trace/ftrace.c:378 __unregister_ftrace_function+0x2dc/0x410
[   27.415894] Modules linked in:
[   27.416310] CPU: 1 UID: 0 PID: 730 Comm: repro Tainted: G        W          6.14.0-rc5-next-20250303-cd3215bbcb9d #1
[   27.417646] Tainted: [W]=WARN
[   27.418122] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   27.419521] RIP: 0010:__unregister_ftrace_function+0x2dc/0x410
[   27.420266] Code: 5f 06 49 81 fc 00 91 ed 87 0f 84 bb 00 00 00 e8 3a 90 fa ff 4c 39 e3 0f 84 b9 00 00 00 4c 89 e3 e9 c0 fd ff ff e8 24 90 fa ff <0f> 0b 41 bc f0 ff ff ff e9 b9 fe ff ff e8 12 90 fa ff be ff ff ff
[   27.422583] RSP: 0018:ffff888012677b10 EFLAGS: 00010293
[   27.423255] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff818da8fa
[   27.424141] RDX: ffff88800ed48000 RSI: ffffffff818dab8c RDI: 0000000000000007
[   27.425024] RBP: ffff888012677b30 R08: 0000000000000000 R09: fffffbfff0fdafcc
[   27.425829] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   27.426546] R13: ffff88801264dc80 R14: ffffffff87e3fc20 R15: 0000000000000000
[   27.427258] FS:  00007f4f0f1f8600(0000) GS:ffff8880e36a9000(0000) knlGS:0000000000000000
[   27.427966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.428472] CR2: 0000000020002240 CR3: 000000000ebf6001 CR4: 0000000000770ef0
[   27.429092] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.429741] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   27.430366] PKRU: 55555554
[   27.430617] Call Trace:
[   27.430846]  <TASK>
[   27.431052]  ? show_regs+0x6d/0x80
[   27.431375]  ? __warn+0xf3/0x390
[   27.431697]  ? report_bug+0x25e/0x4b0
[   27.432076]  ? __unregister_ftrace_function+0x2dc/0x410
[   27.432568]  ? report_bug+0x2cb/0x4b0
[   27.432916]  ? __unregister_ftrace_function+0x2dc/0x410
[   27.433387]  ? __unregister_ftrace_function+0x2dc/0x410
[   27.433911]  ? handle_bug+0x2cd/0x510
[   27.434252]  ? __unregister_ftrace_function+0x2de/0x410
"

Issue 2:
repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/repro2.c
repro binary:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/repro2
bzImage:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/bzImage_2
dmesg:
https://github.com/laifryiee/syzkaller_logs/tree/main/250306_simplify_the_perf_event_alloc_error_path/dmesg_2.log

"
[   22.332967] ------------------------------------------------------
[   22.332970] repro/738 is trying to acquire lock:
[   22.332975] ffffffff87050e58 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x1c/0x80
[   22.333021]
[   22.333021] but task is already holding lock:
[   22.333024] ff11000012331818 (&ctx->lock){....}-{2:2}, at: __perf_install_in_context+0xf8/0xc90
[   22.333050]
[   22.333050] which lock already depends on the new lock.
[   22.333050]
[   22.333052]
[   22.333052] the existing dependency chain (in reverse order) is:
[   22.333055]
[   22.333055] -> #3 (&ctx->lock){....}-{2:2}:
[   22.333068]        _raw_spin_lock+0x38/0x50
[   22.333080]        __perf_event_task_sched_out+0x466/0x1930
[   22.333090]        __schedule+0x1403/0x3510
[   22.333098]        preempt_schedule_common+0x49/0xd0
[   22.333106]        __cond_resched+0x37/0x50
[   22.333114]        dput.part.0+0x2e/0x9e0
[   22.333128]        dput+0x29/0x40
[   22.333136]        __fput+0x535/0xb70
[   22.333145]        ____fput+0x22/0x30
[   22.333154]        task_work_run+0x19c/0x2b0
[   22.333166]        do_exit+0xb0f/0x2a30
[   22.333176]        do_group_exit+0xe4/0x2c0
[   22.333185]        __x64_sys_exit_group+0x4d/0x60
[   22.333196]        x64_sys_call+0xf81/0x2140
[   22.333211]        do_syscall_64+0x6d/0x140
[   22.333220]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.333235]
[   22.333235] -> #2 (&rq->__lock){-.-.}-{2:2}:
[   22.333248]        _raw_spin_lock_nested+0x3e/0x60
[   22.333263]        __task_rq_lock+0xe6/0x480
[   22.333274]        wake_up_new_task+0x72d/0xe70
[   22.333284]        kernel_clone+0x203/0x8c0
[   22.333293]        user_mode_thread+0xe0/0x120
[   22.333302]        rest_init+0x2e/0x2b0
[   22.333314]        start_kernel+0x42b/0x560
[   22.333324]        x86_64_start_reservations+0x1c/0x30
[   22.333339]        x86_64_start_kernel+0xa0/0xb0
[   22.333353]        common_startup_64+0x13e/0x141
[   22.333367]
[   22.333367] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[   22.333380]        _raw_spin_lock_irqsave+0x52/0x80
[   22.333396]        try_to_wake_up+0xc6/0x1650
[   22.333413]        wake_up_process+0x19/0x20
[   22.333423]        __up.isra.0+0xec/0x130
[   22.333433]        up+0x90/0xc0
[   22.333443]        __up_console_sem+0x8b/0xb0
[   22.333457]        console_unlock+0x1db/0x200
[   22.333472]        con_font_op+0xc6f/0x1090
[   22.333483]        vt_ioctl+0x63a/0x2dc0
[   22.333496]        tty_ioctl+0x7ca/0x1790
[   22.333508]        __x64_sys_ioctl+0x1ba/0x220
[   22.333520]        x64_sys_call+0x1227/0x2140
[   22.333533]        do_syscall_64+0x6d/0x140
[   22.333542]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.333556]
[   22.333556] -> #0 ((console_sem).lock){-...}-{2:2}:
[   22.333568]        __lock_acquire+0x2ff8/0x5d60
[   22.333578]        lock_acquire+0x1bd/0x550
[   22.333587]        _raw_spin_lock_irqsave+0x52/0x80
[   22.333603]        down_trylock+0x1c/0x80
[   22.333614]        __down_trylock_console_sem+0x4f/0xe0
[   22.333627]        vprintk_emit+0x72b/0x930
[   22.333641]        vprintk_default+0x2f/0x40
[   22.333656]        vprintk+0x6e/0x100
[   22.333664]        _printk+0xc4/0x100
[   22.333675]        __warn_printk+0x131/0x2e0
[   22.333684]        arch_install_hw_breakpoint+0x157/0x400
[   22.333700]        hw_breakpoint_add+0xb0/0x140
[   22.333716]        event_sched_in+0x3eb/0x9e0
[   22.333729]        merge_sched_in+0x877/0x1470
[   22.333744]        visit_groups_merge.constprop.0.isra.0+0x8e8/0x13a0
[   22.333761]        ctx_sched_in+0x5e3/0xa20
[   22.333776]        perf_event_sched_in+0x67/0xa0
[   22.333791]        ctx_resched+0x3a3/0x830
[   22.333806]        __perf_install_in_context+0x49b/0xc90
[   22.333823]        remote_function+0x135/0x1b0
[   22.333838]        generic_exec_single+0x1e5/0x2e0
[   22.333851]        smp_call_function_single+0x196/0x470
[   22.333864]        task_function_call+0x10e/0x1b0
[   22.333877]        perf_install_in_context+0x2eb/0x5a0
[   22.333889]        __do_sys_perf_event_open+0x1915/0x2be0
[   22.333900]        __x64_sys_perf_event_open+0xc7/0x150
[   22.333910]        x64_sys_call+0x1e96/0x2140
[   22.333924]        do_syscall_64+0x6d/0x140
[   22.333932]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.333946]
[   22.333946] other info that might help us debug this:
[   22.333946]
[   22.333949] Chain exists of:
[   22.333949]   (console_sem).lock --> &rq->__lock --> &ctx->lock
[   22.333949]
[   22.333963]  Possible unsafe locking scenario:
[   22.333963]
[   22.333965]        CPU0                    CPU1
[   22.333968]        ----                    ----
[   22.333971]   lock(&ctx->lock);
[   22.333976]                                lock(&rq->__lock);
[   22.333983]                                lock(&ctx->lock);
[   22.333989]   lock((console_sem).lock);
[   22.333995]
[   22.333995]  *** DEADLOCK ***
[   22.333995]
[   22.333997] 4 locks held by repro/738:
[   22.334002]  #0: ff1100000bd68ca8 (&sig->exec_update_lock){++++}-{4:4}, at: __do_sys_perf_event_open+0x83a/0x2be0
[   22.334027]  #1: ff110000123318a8 (&ctx->mutex){+.+.}-{4:4}, at: __do_sys_perf_event_open+0xd2f/0x2be0
[   22.334050]  #2: ff1100006c83d238 (&cpuctx_lock){....}-{2:2}, at: __perf_install_in_context+0xb7/0xc90
[   22.334080]  #3: ff11000012331818 (&ctx->lock){....}-{2:2}, at: __perf_install_in_context+0xf8/0xc90
[   22.334109]
[   22.334109] stack backtrace:
[   22.334114] CPU: 0 UID: 0 PID: 738 Comm: repro Tainted: G        W          6.14.0-rc4-02be310c2d24+ #1
[   22.334128] Tainted: [W]=WARN
[   22.334131] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/014
[   22.334138] Call Trace:
[   22.334140]  <TASK>
[   22.334144]  dump_stack_lvl+0xea/0x150
[   22.334163]  dump_stack+0x19/0x20
[   22.334178]  print_circular_bug+0x47f/0x750
[   22.334199]  check_noncircular+0x2f4/0x3e0
[   22.334217]  ? __pfx_check_noncircular+0x10/0x10
[   22.334233]  ? __pfx__prb_read_valid+0x10/0x10
[   22.334251]  ? lockdep_lock+0xd0/0x1d0
[   22.334265]  ? __pfx_lockdep_lock+0x10/0x10
[   22.334283]  __lock_acquire+0x2ff8/0x5d60
[   22.334301]  ? __pfx___lock_acquire+0x10/0x10
[   22.334312]  ? prb_final_commit+0x42/0x60
[   22.334324]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.334342]  ? vprintk_store+0x1c5/0xb20
[   22.334359]  lock_acquire+0x1bd/0x550
[   22.334369]  ? down_trylock+0x1c/0x80
[   22.334383]  ? __pfx_lock_acquire+0x10/0x10
[   22.334397]  ? mark_lock.part.0+0xf3/0x17b0
[   22.334414]  ? kernel_text_address+0xd3/0xe0
[   22.334426]  ? vprintk_default+0x2f/0x40
[   22.334444]  _raw_spin_lock_irqsave+0x52/0x80
[   22.334460]  ? down_trylock+0x1c/0x80
[   22.334473]  down_trylock+0x1c/0x80
[   22.334484]  ? vprintk_default+0x2f/0x40
[   22.334500]  __down_trylock_console_sem+0x4f/0xe0
[   22.334515]  vprintk_emit+0x72b/0x930
[   22.334533]  ? __pfx_vprintk_emit+0x10/0x10
[   22.334550]  ? __kasan_check_read+0x15/0x20
[   22.334564]  vprintk_default+0x2f/0x40
[   22.334580]  vprintk+0x6e/0x100
[   22.334590]  _printk+0xc4/0x100
[   22.334602]  ? __pfx__printk+0x10/0x10
[   22.334614]  ? __kasan_check_read+0x15/0x20
[   22.334628]  ? __warn_printk+0x125/0x2e0
[   22.334638]  ? __warn_printk+0x118/0x2e0
[   22.334650]  __warn_printk+0x131/0x2e0
[   22.334661]  ? __pfx___warn_printk+0x10/0x10
[   22.334677]  ? arch_install_hw_breakpoint+0x144/0x400
[   22.334692]  ? arch_install_hw_breakpoint+0x137/0x400
[   22.334709]  arch_install_hw_breakpoint+0x157/0x400
[   22.334728]  hw_breakpoint_add+0xb0/0x140
[   22.334744]  event_sched_in+0x3eb/0x9e0
[   22.334762]  merge_sched_in+0x877/0x1470
[   22.334782]  visit_groups_merge.constprop.0.isra.0+0x8e8/0x13a0
[   22.334800]  ? perf_event_set_state+0x37f/0x480
[   22.334815]  ? __pfx_visit_groups_merge.constprop.0.isra.0+0x10/0x10
[   22.334834]  ? __this_cpu_preempt_check+0x21/0x30
[   22.334846]  ? lock_is_held_type+0xef/0x150
[   22.334859]  ctx_sched_in+0x5e3/0xa20
[   22.334875]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   22.334891]  ? __pmu_ctx_sched_out+0xfa/0x720
[   22.334908]  ? __pfx_ctx_sched_in+0x10/0x10
[   22.334930]  perf_event_sched_in+0x67/0xa0
[   22.334947]  ctx_resched+0x3a3/0x830
[   22.334967]  __perf_install_in_context+0x49b/0xc90
[   22.334984]  ? __pfx_remote_function+0x10/0x10
[   22.335001]  ? __pfx___perf_install_in_context+0x10/0x10
[   22.335020]  remote_function+0x135/0x1b0
[   22.335034]  ? trace_csd_function_entry+0x6a/0x1b0
[   22.335047]  ? __pfx_remote_function+0x10/0x10
[   22.335063]  generic_exec_single+0x1e5/0x2e0
[   22.335078]  smp_call_function_single+0x196/0x470
[   22.335092]  ? __pfx_remote_function+0x10/0x10
[   22.335108]  ? __pfx_smp_call_function_single+0x10/0x10
[   22.335123]  ? __pfx_remote_function+0x10/0x10
[   22.335138]  ? debug_mutex_init+0x3c/0x80
[   22.335152]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   22.335169]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   22.335188]  task_function_call+0x10e/0x1b0
[   22.335202]  ? __pfx_task_function_call+0x10/0x10
[   22.335217]  ? __pfx___perf_install_in_context+0x10/0x10
[   22.335235]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   22.335252]  ? exclusive_event_installable+0x25c/0x330
[   22.335268]  ? lock_is_held_type+0xef/0x150
[   22.335280]  perf_install_in_context+0x2eb/0x5a0
[   22.335295]  ? __pfx_perf_install_in_context+0x10/0x10
[   22.335308]  ? __anon_inode_getfile+0x191/0x370
[   22.335320]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.335337]  ? __perf_event_read_size+0xc7/0xe0
[   22.335351]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.335368]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.335387]  __do_sys_perf_event_open+0x1915/0x2be0
[   22.335403]  ? __pfx___do_sys_perf_event_open+0x10/0x10
[   22.335430]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   22.335448]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   22.335464]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   22.335485]  __x64_sys_perf_event_open+0xc7/0x150
[   22.335497]  ? syscall_trace_enter+0x14f/0x280
[   22.335512]  x64_sys_call+0x1e96/0x2140
[   22.335527]  do_syscall_64+0x6d/0x140
[   22.335537]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.335552] RIP: 0033:0x7f2565a3ee5d
[   22.335560] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c88
[   22.335570] RSP: 002b:00007ffd557ea4f8 EFLAGS: 00000297 ORIG_RAX: 000000000000012a
[   22.335580] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2565a3ee5d
[   22.335586] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020002ac0
[   22.335593] RBP: 00007ffd557ea510 R08: 0000000000000000 R09: 00007ffd557ea510
[   22.335599] R10: 00000000ffffffff R11: 0000000000000297 R12: 00007ffd557ea668
[   22.335606] R13: 0000000000402018 R14: 0000000000404e08 R15: 00007f2565cde000
[   22.335621]  </TASK>
[   22.436551] Can't find any breakpoint slot
[   22.436575] WARNING: CPU: 0 PID: 738 at arch/x86/kernel/hw_breakpoint.c:113 arch_install_hw_breakpoint+0x157/0x400
[   22.437972] Modules linked in:
[   22.438281] CPU: 0 UID: 0 PID: 738 Comm: repro Tainted: G        W          6.14.0-rc4-02be310c2d24+ #1
[   22.439174] Tainted: [W]=WARN
[   22.439477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/014
[   22.440600] RIP: 0010:arch_install_hw_breakpoint+0x157/0x400
[   22.441154] Code: ff ff ff 89 de e8 49 8d 57 00 84 db 0f 85 c3 01 00 00 e8 4c 93 57 00 48 c7 c7 60 09 c3 85 c6 05 03 e3 937
[   22.442901] RSP: 0018:ff1100000bd27648 EFLAGS: 00010092
[   22.443410] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8146b573
[   22.444149] RDX: ff11000011fdabc0 RSI: ffffffff8146b580 RDI: 0000000000000001
[   22.444828] RBP: ff1100000bd27690 R08: 0000000000000001 R09: ffe21c000d905b21
[   22.445515] R10: 0000000000000000 R11: 3030303030302052 R12: 00000000fffffff0
[   22.446189] R13: ff1100000ad73758 R14: 000000000002c940 R15: dffffc0000000000
[   22.446871] FS:  00007f2565c93740(0000) GS:ff1100006c800000(0000) knlGS:0000000000000000
[   22.447642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.448252] CR2: 0000000020002ac0 CR3: 000000001104e003 CR4: 0000000000771ef0
[   22.448939] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.449625] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000006aa
[   22.450298] PKRU: 55555554
[   22.450577] Call Trace:
[   22.450827]  <TASK>
[   22.451047]  ? show_regs+0x6d/0x80
[   22.451394]  ? __warn+0xf3/0x390
[   22.451731]  ? find_bug+0x32e/0x4b0
[   22.452137]  ? arch_install_hw_breakpoint+0x157/0x400
[   22.452643]  ? report_bug+0x2cb/0x4b0
[   22.453017]  ? arch_install_hw_breakpoint+0x157/0x400
[   22.453520]  ? arch_install_hw_breakpoint+0x158/0x400
[   22.454015]  ? handle_bug+0xf1/0x190
[   22.454376]  ? exc_invalid_op+0x3c/0x80
[   22.454766]  ? asm_exc_invalid_op+0x1f/0x30
[   22.455184]  ? __warn_printk+0x173/0x2e0
[   22.455578]  ? __warn_printk+0x180/0x2e0
[   22.456021]  ? arch_install_hw_breakpoint+0x157/0x400
[   22.456524]  ? arch_install_hw_breakpoint+0x157/0x400
[   22.457027]  hw_breakpoint_add+0xb0/0x140
[   22.457434]  event_sched_in+0x3eb/0x9e0
[   22.457820]  merge_sched_in+0x877/0x1470
[   22.458221]  visit_groups_merge.constprop.0.isra.0+0x8e8/0x13a0
[   22.458805]  ? perf_event_set_state+0x37f/0x480
[   22.459257]  ? __pfx_visit_groups_merge.constprop.0.isra.0+0x10/0x10
[   22.459876]  ? __this_cpu_preempt_check+0x21/0x30
[   22.460380]  ? lock_is_held_type+0xef/0x150
[   22.460797]  ctx_sched_in+0x5e3/0xa20
[   22.461169]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   22.461705]  ? __pmu_ctx_sched_out+0xfa/0x720
[   22.462149]  ? __pfx_ctx_sched_in+0x10/0x10
[   22.462578]  perf_event_sched_in+0x67/0xa0
[   22.462988]  ctx_resched+0x3a3/0x830
[   22.463355]  __perf_install_in_context+0x49b/0xc90
[   22.463839]  ? __pfx_remote_function+0x10/0x10
[   22.464342]  ? __pfx___perf_install_in_context+0x10/0x10
[   22.464875]  remote_function+0x135/0x1b0
[   22.465266]  ? trace_csd_function_entry+0x6a/0x1b0
[   22.465743]  ? __pfx_remote_function+0x10/0x10
[   22.466189]  generic_exec_single+0x1e5/0x2e0
[   22.466621]  smp_call_function_single+0x196/0x470
[   22.467085]  ? __pfx_remote_function+0x10/0x10
[   22.467534]  ? __pfx_smp_call_function_single+0x10/0x10
[   22.468108]  ? __pfx_remote_function+0x10/0x10
[   22.468553]  ? debug_mutex_init+0x3c/0x80
[   22.468952]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   22.469485]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   22.470016]  task_function_call+0x10e/0x1b0
[   22.470437]  ? __pfx_task_function_call+0x10/0x10
[   22.470900]  ? __pfx___perf_install_in_context+0x10/0x10
[   22.471425]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   22.472019]  ? exclusive_event_installable+0x25c/0x330
[   22.472538]  ? lock_is_held_type+0xef/0x150
[   22.472956]  perf_install_in_context+0x2eb/0x5a0
[   22.473416]  ? __pfx_perf_install_in_context+0x10/0x10
[   22.473919]  ? __anon_inode_getfile+0x191/0x370
[   22.474363]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.474903]  ? __perf_event_read_size+0xc7/0xe0
[   22.475355]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.475948]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   22.476488]  __do_sys_perf_event_open+0x1915/0x2be0
[   22.476969]  ? __pfx___do_sys_perf_event_open+0x10/0x10
[   22.477489]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   22.478095]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   22.478583]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   22.479076]  __x64_sys_perf_event_open+0xc7/0x150
[   22.479544]  ? syscall_trace_enter+0x14f/0x280
[   22.480059]  x64_sys_call+0x1e96/0x2140
[   22.480450]  do_syscall_64+0x6d/0x140
[   22.480816]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.481312] RIP: 0033:0x7f2565a3ee5d
[   22.481678] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c88
[   22.483409] RSP: 002b:00007ffd557ea4f8 EFLAGS: 00000297 ORIG_RAX: 000000000000012a
[   22.484192] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2565a3ee5d
[   22.484876] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020002ac0
[   22.485560] RBP: 00007ffd557ea510 R08: 0000000000000000 R09: 00007ffd557ea510
[   22.486243] R10: 00000000ffffffff R11: 0000000000000297 R12: 00007ffd557ea668
[   22.486925] R13: 0000000000402018 R14: 0000000000404e08 R15: 00007f2565cde000
[   22.487612]  </TASK>
[   22.487840] irq event stamp: 496
[   22.488224] hardirqs last  enabled at (495): [<ffffffff81f86bac>] mod_objcg_state+0x42c/0x9c0
[   22.489037] hardirqs last disabled at (496): [<ffffffff817bbd75>] generic_exec_single+0x1d5/0x2e0
[   22.489891] softirqs last  enabled at (0): [<ffffffff81463afe>] copy_process+0x1d4e/0x6a40
[   22.490683] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   22.491278] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

> 
> 

