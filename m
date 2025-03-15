Return-Path: <linux-kernel+bounces-562402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FCA62606
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 05:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C3917CE52
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DE18DB3C;
	Sat, 15 Mar 2025 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkdt1GGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D95367;
	Sat, 15 Mar 2025 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742013560; cv=none; b=fmeB07OYJ3sa1CLaTA18dTEB/26S3pdQcxWnGQrro+4bYI34GojWqibiMV6IB6cfUwyjYFJv/hi3/zbz4HggnkQx1hHwnmIyFBncIBYVIXBjH+EIUd70TwjhVgpbOJYQ9N8o8xEMvtSEQYu2HwQUZ86IRw2ptl/nQnP4Mc23wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742013560; c=relaxed/simple;
	bh=3myg1hpVWJxR5nRoATO+eP9LPenG5O3E2m7goMghwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUa9XPYtolIc0cOn5E8RyoZLpDndyz0rbx0Rich+f2lv+H4+1lwMBnvOA/Z6ARLH6Ve1kErGXoIPv5v6wiHFMIVOTuRhZ7C9lXIWx2aWjHjth5AlGMNvQzKR/mK3ft890hmTeJGozPmjJr+do4A7RxTd4yNK7nGkt9IVi4HqDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkdt1GGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF397C4CEE5;
	Sat, 15 Mar 2025 04:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742013559;
	bh=3myg1hpVWJxR5nRoATO+eP9LPenG5O3E2m7goMghwX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rkdt1GGQswMWC8GzuM4KTHgnxz9e/komg90L9bLmg1LJA0w0RBaBWfbANGRIXTIrx
	 b67dFepTuOrhbgV7erL00/v3/4yYFxf09tOK7NwU/28WlR/FbWSTrk38q3+vv9nJxI
	 5ZmTBCPx/2v3jLqaucxcgbB28O7f0tGt1nWoqn9tJSO/zPCEJyREYly/FXtDLK0ybw
	 QxOHrk5pZshwHFu3uMAVNUo7uFpCV2o7DFghMAb/N47OkqBrS/05z7+SUQ8kq/UFcK
	 f8IKkmSvqjMdxouWfVcpSDlo83Aj4/6cDtkTv7sFSnlKrdeDVXz30oh6KLcFDJ6cVG
	 Lsb+W1o8hYpOA==
Date: Fri, 14 Mar 2025 21:39:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3 4/8] perf sched stats: Add support for report
 subcommand
Message-ID: <Z9UEdbcTwVyNuHI9@google.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-5-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311120230.61774-5-swapnil.sapkal@amd.com>

On Tue, Mar 11, 2025 at 12:02:26PM +0000, Swapnil Sapkal wrote:
> `perf sched stats record` captures two sets of samples. For workload
> profile, first set right before workload starts and second set after
> workload finishes. For the systemwide profile, first set at the
> beginning of profile and second set on receiving SIGINT signal.
> 
> Add `perf sched stats report` subcommand that will read both the set
> of samples, get the diff and render a final report. Final report prints
> scheduler stat at cpu granularity as well as sched domain granularity.
> 
> Example usage:
> 
>   # perf sched stats record
>   # perf sched stats report
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/lib/perf/include/perf/event.h         |  12 +-
>  tools/lib/perf/include/perf/schedstat-v15.h | 180 +++++--
>  tools/lib/perf/include/perf/schedstat-v16.h | 182 +++++--
>  tools/lib/perf/include/perf/schedstat-v17.h | 209 +++++---
>  tools/perf/builtin-sched.c                  | 504 +++++++++++++++++++-
>  tools/perf/util/event.c                     |   4 +-
>  tools/perf/util/synthetic-events.c          |   4 +-
>  7 files changed, 938 insertions(+), 157 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 0d1983ad9a41..5e2c56c9b038 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -458,19 +458,19 @@ struct perf_record_compressed {
>  };
>  
>  struct perf_record_schedstat_cpu_v15 {
> -#define CPU_FIELD(_type, _name, _ver)		_type _name
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
>  #include "schedstat-v15.h"
>  #undef CPU_FIELD
>  };
>  
>  struct perf_record_schedstat_cpu_v16 {
> -#define CPU_FIELD(_type, _name, _ver)		_type _name
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
>  #include "schedstat-v16.h"
>  #undef CPU_FIELD
>  };
>  
>  struct perf_record_schedstat_cpu_v17 {
> -#define CPU_FIELD(_type, _name, _ver)		_type _name
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
>  #include "schedstat-v17.h"
>  #undef CPU_FIELD
>  };
> @@ -488,19 +488,19 @@ struct perf_record_schedstat_cpu {
>  };
>  
>  struct perf_record_schedstat_domain_v15 {
> -#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
>  #include "schedstat-v15.h"
>  #undef DOMAIN_FIELD
>  };
>  
>  struct perf_record_schedstat_domain_v16 {
> -#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
>  #include "schedstat-v16.h"
>  #undef DOMAIN_FIELD
>  };
>  
>  struct perf_record_schedstat_domain_v17 {
> -#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
>  #include "schedstat-v17.h"
>  #undef DOMAIN_FIELD
>  };
> diff --git a/tools/lib/perf/include/perf/schedstat-v15.h b/tools/lib/perf/include/perf/schedstat-v15.h
> index 43f8060c5337..011411ac0f7e 100644
> --- a/tools/lib/perf/include/perf/schedstat-v15.h
> +++ b/tools/lib/perf/include/perf/schedstat-v15.h
> @@ -1,52 +1,142 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  #ifdef CPU_FIELD
> -CPU_FIELD(__u32, yld_count, v15);
> -CPU_FIELD(__u32, array_exp, v15);
> -CPU_FIELD(__u32, sched_count, v15);
> -CPU_FIELD(__u32, sched_goidle, v15);
> -CPU_FIELD(__u32, ttwu_count, v15);
> -CPU_FIELD(__u32, ttwu_local, v15);
> -CPU_FIELD(__u64, rq_cpu_time, v15);
> -CPU_FIELD(__u64, run_delay, v15);
> -CPU_FIELD(__u64, pcount, v15);
> +CPU_FIELD(__u32, yld_count, "sched_yield() count",
> +	  "%11u", false, yld_count, v15);
> +CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
> +	  "%11u", false, array_exp, v15);
> +CPU_FIELD(__u32, sched_count, "schedule() called",
> +	  "%11u", false, sched_count, v15);
> +CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
> +	  "%11u", true, sched_count, v15);
> +CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
> +	  "%11u", false, ttwu_count, v15);
> +CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
> +	  "%11u", true, ttwu_count, v15);
> +CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
> +	  "%11llu", false, rq_cpu_time, v15);
> +CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
> +	  "%11llu", true, rq_cpu_time, v15);
> +CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
> +	  "%11llu", false, pcount, v15);
>  #endif
>  
>  #ifdef DOMAIN_FIELD
> -DOMAIN_FIELD(__u32, idle_lb_count, v15);
> -DOMAIN_FIELD(__u32, idle_lb_balanced, v15);
> -DOMAIN_FIELD(__u32, idle_lb_failed, v15);
> -DOMAIN_FIELD(__u32, idle_lb_imbalance, v15);
> -DOMAIN_FIELD(__u32, idle_lb_gained, v15);
> -DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15);
> -DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15);
> -DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15);
> -DOMAIN_FIELD(__u32, busy_lb_count, v15);
> -DOMAIN_FIELD(__u32, busy_lb_balanced, v15);
> -DOMAIN_FIELD(__u32, busy_lb_failed, v15);
> -DOMAIN_FIELD(__u32, busy_lb_imbalance, v15);
> -DOMAIN_FIELD(__u32, busy_lb_gained, v15);
> -DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15);
> -DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15);
> -DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_count, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_balanced, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_failed, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_gained, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15);
> -DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15);
> -DOMAIN_FIELD(__u32, alb_count, v15);
> -DOMAIN_FIELD(__u32, alb_failed, v15);
> -DOMAIN_FIELD(__u32, alb_pushed, v15);
> -DOMAIN_FIELD(__u32, sbe_count, v15);
> -DOMAIN_FIELD(__u32, sbe_balanced, v15);
> -DOMAIN_FIELD(__u32, sbe_pushed, v15);
> -DOMAIN_FIELD(__u32, sbf_count, v15);
> -DOMAIN_FIELD(__u32, sbf_balanced, v15);
> -DOMAIN_FIELD(__u32, sbf_pushed, v15);
> -DOMAIN_FIELD(__u32, ttwu_wake_remote, v15);
> -DOMAIN_FIELD(__u32, ttwu_move_affine, v15);
> -DOMAIN_FIELD(__u32, ttwu_move_balance, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category idle> ");
>  #endif
> +DOMAIN_FIELD(__u32, idle_lb_count,
> +	     "load_balance() count on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_balanced,
> +	     "load_balance() found balanced on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_failed,
> +	     "load_balance() move task failed on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance,
> +	     "imbalance sum on cpu idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, idle_lb_gained,
> +	     "pull_task() count on cpu idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v15);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v15);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v15);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category busy> ");
> +#endif
> +DOMAIN_FIELD(__u32, busy_lb_count,
> +	     "load_balance() count on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_balanced,
> +	     "load_balance() found balanced on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_failed,
> +	     "load_balance() move task failed on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance,
> +	     "imbalance sum on cpu busy", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, busy_lb_gained,
> +	     "pull_task() count on cpu busy", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v15);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v15);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v15);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category newidle> ");
> +#endif
> +DOMAIN_FIELD(__u32, newidle_lb_count,
> +	     "load_balance() count on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced,
> +	     "load_balance() found balanced on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_failed,
> +	     "load_balance() move task failed on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance,
> +	     "imbalance sum on cpu newly idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_gained,
> +	     "pull_task() count on cpu newly idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v15);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v15);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v15);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category active_load_balance()> ");
> +#endif
> +DOMAIN_FIELD(__u32, alb_count,
> +	     "active_load_balance() count", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, alb_failed,
> +	     "active_load_balance() move task failed", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, alb_pushed,
> +	     "active_load_balance() successfully moved a task", "%11u", false, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbe_count,
> +	     "sbe_count is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbe_balanced,
> +	     "sbe_balanced is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbe_pushed,
> +	     "sbe_pushed is not used", "%11u", false, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbf_count,
> +	     "sbf_count is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbf_balanced,
> +	     "sbf_balanced is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbf_pushed,
> +	     "sbf_pushed is not used", "%11u", false, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Wakeup Info> ");
> +#endif
> +DOMAIN_FIELD(__u32, ttwu_wake_remote,
> +	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, ttwu_move_affine,
> +	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, ttwu_move_balance,
> +	     "try_to_wake_up() started passive balancing", "%11u", false, v15);
> +#endif /* DOMAIN_FIELD */
> diff --git a/tools/lib/perf/include/perf/schedstat-v16.h b/tools/lib/perf/include/perf/schedstat-v16.h
> index d6a4691b2fd5..5ba53bd7d61a 100644
> --- a/tools/lib/perf/include/perf/schedstat-v16.h
> +++ b/tools/lib/perf/include/perf/schedstat-v16.h
> @@ -1,52 +1,142 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  #ifdef CPU_FIELD
> -CPU_FIELD(__u32, yld_count, v16);
> -CPU_FIELD(__u32, array_exp, v16);
> -CPU_FIELD(__u32, sched_count, v16);
> -CPU_FIELD(__u32, sched_goidle, v16);
> -CPU_FIELD(__u32, ttwu_count, v16);
> -CPU_FIELD(__u32, ttwu_local, v16);
> -CPU_FIELD(__u64, rq_cpu_time, v16);
> -CPU_FIELD(__u64, run_delay, v16);
> -CPU_FIELD(__u64, pcount, v16);
> -#endif
> +CPU_FIELD(__u32, yld_count, "sched_yield() count",
> +	  "%11u", false, yld_count, v16);
> +CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
> +	  "%11u", false, array_exp, v16);
> +CPU_FIELD(__u32, sched_count, "schedule() called",
> +	  "%11u", false, sched_count, v16);
> +CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
> +	  "%11u", true, sched_count, v16);
> +CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
> +	  "%11u", false, ttwu_count, v16);
> +CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
> +	  "%11u", true, ttwu_count, v16);
> +CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
> +	  "%11llu", false, rq_cpu_time, v16);
> +CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
> +	  "%11llu", true, rq_cpu_time, v16);
> +CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
> +	  "%11llu", false, pcount, v16);
> +#endif /* CPU_FIELD */
>  
>  #ifdef DOMAIN_FIELD
> -DOMAIN_FIELD(__u32, busy_lb_count, v16);
> -DOMAIN_FIELD(__u32, busy_lb_balanced, v16);
> -DOMAIN_FIELD(__u32, busy_lb_failed, v16);
> -DOMAIN_FIELD(__u32, busy_lb_imbalance, v16);
> -DOMAIN_FIELD(__u32, busy_lb_gained, v16);
> -DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16);
> -DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16);
> -DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16);
> -DOMAIN_FIELD(__u32, idle_lb_count, v16);
> -DOMAIN_FIELD(__u32, idle_lb_balanced, v16);
> -DOMAIN_FIELD(__u32, idle_lb_failed, v16);
> -DOMAIN_FIELD(__u32, idle_lb_imbalance, v16);
> -DOMAIN_FIELD(__u32, idle_lb_gained, v16);
> -DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16);
> -DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16);
> -DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_count, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_balanced, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_failed, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_gained, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16);
> -DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16);
> -DOMAIN_FIELD(__u32, alb_count, v16);
> -DOMAIN_FIELD(__u32, alb_failed, v16);
> -DOMAIN_FIELD(__u32, alb_pushed, v16);
> -DOMAIN_FIELD(__u32, sbe_count, v16);
> -DOMAIN_FIELD(__u32, sbe_balanced, v16);
> -DOMAIN_FIELD(__u32, sbe_pushed, v16);
> -DOMAIN_FIELD(__u32, sbf_count, v16);
> -DOMAIN_FIELD(__u32, sbf_balanced, v16);
> -DOMAIN_FIELD(__u32, sbf_pushed, v16);
> -DOMAIN_FIELD(__u32, ttwu_wake_remote, v16);
> -DOMAIN_FIELD(__u32, ttwu_move_affine, v16);
> -DOMAIN_FIELD(__u32, ttwu_move_balance, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category busy> ");
> +#endif
> +DOMAIN_FIELD(__u32, busy_lb_count,
> +	     "load_balance() count on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_balanced,
> +	     "load_balance() found balanced on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_failed,
> +	     "load_balance() move task failed on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance,
> +	     "imbalance sum on cpu busy", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, busy_lb_gained,
> +	     "pull_task() count on cpu busy", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v16);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v16);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v16);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category idle> ");
> +#endif
> +DOMAIN_FIELD(__u32, idle_lb_count,
> +	     "load_balance() count on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_balanced,
> +	     "load_balance() found balanced on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_failed,
> +	     "load_balance() move task failed on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance,
> +	     "imbalance sum on cpu idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, idle_lb_gained,
> +	     "pull_task() count on cpu idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v16);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v16);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v16);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category newidle> ");
> +#endif
> +DOMAIN_FIELD(__u32, newidle_lb_count,
> +	     "load_balance() count on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced,
> +	     "load_balance() found balanced on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_failed,
> +	     "load_balance() move task failed on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance,
> +	     "imbalance sum on cpu newly idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_gained,
> +	     "pull_task() count on cpu newly idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v16);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v16);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v16);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category active_load_balance()> ");
> +#endif
> +DOMAIN_FIELD(__u32, alb_count,
> +	     "active_load_balance() count", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, alb_failed,
> +	     "active_load_balance() move task failed", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, alb_pushed,
> +	     "active_load_balance() successfully moved a task", "%11u", false, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbe_count,
> +	     "sbe_count is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbe_balanced,
> +	     "sbe_balanced is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbe_pushed,
> +	     "sbe_pushed is not used", "%11u", false, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbf_count,
> +	     "sbf_count is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbf_balanced,
> +	     "sbf_balanced is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbf_pushed,
> +	     "sbf_pushed is not used", "%11u", false, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Wakeup Info> ");
>  #endif
> +DOMAIN_FIELD(__u32, ttwu_wake_remote,
> +	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, ttwu_move_affine,
> +	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, ttwu_move_balance,
> +	     "try_to_wake_up() started passive balancing", "%11u", false, v16);
> +#endif /* DOMAIN_FIELD */
> diff --git a/tools/lib/perf/include/perf/schedstat-v17.h b/tools/lib/perf/include/perf/schedstat-v17.h
> index 851d4f1f4ecb..00009bd5f006 100644
> --- a/tools/lib/perf/include/perf/schedstat-v17.h
> +++ b/tools/lib/perf/include/perf/schedstat-v17.h
> @@ -1,61 +1,160 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  #ifdef CPU_FIELD
> -CPU_FIELD(__u32, yld_count, v17);
> -CPU_FIELD(__u32, array_exp, v17);
> -CPU_FIELD(__u32, sched_count, v17);
> -CPU_FIELD(__u32, sched_goidle, v17);
> -CPU_FIELD(__u32, ttwu_count, v17);
> -CPU_FIELD(__u32, ttwu_local, v17);
> -CPU_FIELD(__u64, rq_cpu_time, v17);
> -CPU_FIELD(__u64, run_delay, v17);
> -CPU_FIELD(__u64, pcount, v17);
> -#endif
> +CPU_FIELD(__u32, yld_count, "sched_yield() count",
> +	  "%11u", false, yld_count, v17);
> +CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
> +	  "%11u", false, array_exp, v17);
> +CPU_FIELD(__u32, sched_count, "schedule() called",
> +	  "%11u", false, sched_count, v17);
> +CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
> +	  "%11u", true, sched_count, v17);
> +CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
> +	  "%11u", false, ttwu_count, v17);
> +CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
> +	  "%11u", true, ttwu_count, v17);
> +CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
> +	  "%11llu", false, rq_cpu_time, v17);
> +CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
> +	  "%11llu", true, rq_cpu_time, v17);
> +CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
> +	  "%11llu", false, pcount, v17);
> +#endif /* CPU_FIELD */
>  
>  #ifdef DOMAIN_FIELD
> -DOMAIN_FIELD(__u32, busy_lb_count, v17);
> -DOMAIN_FIELD(__u32, busy_lb_balanced, v17);
> -DOMAIN_FIELD(__u32, busy_lb_failed, v17);
> -DOMAIN_FIELD(__u32, busy_lb_imbalance_load, v17);
> -DOMAIN_FIELD(__u32, busy_lb_imbalance_util, v17);
> -DOMAIN_FIELD(__u32, busy_lb_imbalance_task, v17);
> -DOMAIN_FIELD(__u32, busy_lb_imbalance_misfit, v17);
> -DOMAIN_FIELD(__u32, busy_lb_gained, v17);
> -DOMAIN_FIELD(__u32, busy_lb_hot_gained, v17);
> -DOMAIN_FIELD(__u32, busy_lb_nobusyq, v17);
> -DOMAIN_FIELD(__u32, busy_lb_nobusyg, v17);
> -DOMAIN_FIELD(__u32, idle_lb_count, v17);
> -DOMAIN_FIELD(__u32, idle_lb_balanced, v17);
> -DOMAIN_FIELD(__u32, idle_lb_failed, v17);
> -DOMAIN_FIELD(__u32, idle_lb_imbalance_load, v17);
> -DOMAIN_FIELD(__u32, idle_lb_imbalance_util, v17);
> -DOMAIN_FIELD(__u32, idle_lb_imbalance_task, v17);
> -DOMAIN_FIELD(__u32, idle_lb_imbalance_misfit, v17);
> -DOMAIN_FIELD(__u32, idle_lb_gained, v17);
> -DOMAIN_FIELD(__u32, idle_lb_hot_gained, v17);
> -DOMAIN_FIELD(__u32, idle_lb_nobusyq, v17);
> -DOMAIN_FIELD(__u32, idle_lb_nobusyg, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_count, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_balanced, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_failed, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_imbalance_load, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_imbalance_util, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_imbalance_task, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_imbalance_misfit, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_gained, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v17);
> -DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v17);
> -DOMAIN_FIELD(__u32, alb_count, v17);
> -DOMAIN_FIELD(__u32, alb_failed, v17);
> -DOMAIN_FIELD(__u32, alb_pushed, v17);
> -DOMAIN_FIELD(__u32, sbe_count, v17);
> -DOMAIN_FIELD(__u32, sbe_balanced, v17);
> -DOMAIN_FIELD(__u32, sbe_pushed, v17);
> -DOMAIN_FIELD(__u32, sbf_count, v17);
> -DOMAIN_FIELD(__u32, sbf_balanced, v17);
> -DOMAIN_FIELD(__u32, sbf_pushed, v17);
> -DOMAIN_FIELD(__u32, ttwu_wake_remote, v17);
> -DOMAIN_FIELD(__u32, ttwu_move_affine, v17);
> -DOMAIN_FIELD(__u32, ttwu_move_balance, v17);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category busy> ");
> +#endif
> +DOMAIN_FIELD(__u32, busy_lb_count,
> +	     "load_balance() count on cpu busy", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, busy_lb_balanced,
> +	     "load_balance() found balanced on cpu busy", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, busy_lb_failed,
> +	     "load_balance() move task failed on cpu busy", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_load,
> +	     "imbalance in load on cpu busy", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_util,
> +	     "imbalance in utilization on cpu busy", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_task,
> +	     "imbalance in number of tasks on cpu busy", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_misfit,
> +	     "imbalance in misfit tasks on cpu busy", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, busy_lb_gained,
> +	     "pull_task() count on cpu busy", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v17);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v17);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v17);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category idle> ");
> +#endif
> +DOMAIN_FIELD(__u32, idle_lb_count,
> +	     "load_balance() count on cpu idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, idle_lb_balanced,
> +	     "load_balance() found balanced on cpu idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, idle_lb_failed,
> +	     "load_balance() move task failed on cpu idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_load,
> +	     "imbalance in load on cpu idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_util,
> +	     "imbalance in utilization on cpu idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_task,
> +	     "imbalance in number of tasks on cpu idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_misfit,
> +	     "imbalance in misfit tasks on cpu idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, idle_lb_gained,
> +	     "pull_task() count on cpu idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v17);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v17);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v17);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category newidle> ");
> +#endif
> +DOMAIN_FIELD(__u32, newidle_lb_count,
> +	     "load_balance() count on cpu newly idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced,
> +	     "load_balance() found balanced on cpu newly idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_failed,
> +	     "load_balance() move task failed on cpu newly idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_load,
> +	     "imbalance in load on cpu newly idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_util,
> +	     "imbalance in utilization on cpu newly idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_task,
> +	     "imbalance in number of tasks on cpu newly idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_misfit,
> +	     "imbalance in misfit tasks on cpu newly idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_gained,
> +	     "pull_task() count on cpu newly idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v17);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v17);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v17);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category active_load_balance()> ");
> +#endif
> +DOMAIN_FIELD(__u32, alb_count,
> +	     "active_load_balance() count", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, alb_failed,
> +	     "active_load_balance() move task failed", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, alb_pushed,
> +	     "active_load_balance() successfully moved a task", "%11u", false, v17);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbe_count,
> +	     "sbe_count is not used", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, sbe_balanced,
> +	     "sbe_balanced is not used", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, sbe_pushed,
> +	     "sbe_pushed is not used", "%11u", false, v17);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbf_count,
> +	     "sbf_count is not used", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, sbf_balanced,
> +	     "sbf_balanced is not used", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, sbf_pushed,
> +	     "sbf_pushed is not used", "%11u", false, v17);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Wakeup Info> ");
>  #endif
> +DOMAIN_FIELD(__u32, ttwu_wake_remote,
> +	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, ttwu_move_affine,
> +	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v17);
> +DOMAIN_FIELD(__u32, ttwu_move_balance,
> +	     "try_to_wake_up() started passive balancing", "%11u", false, v17);
> +#endif /* DOMAIN_FIELD */

Probably better to put in the previous commits.


> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 1c3b56013164..e2e7dbc4f0aa 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3869,6 +3869,501 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
>  	return err;
>  }
>  
> +struct schedstat_domain {
> +	struct perf_record_schedstat_domain *domain_data;
> +	struct schedstat_domain *next;
> +};
> +
> +struct schedstat_cpu {
> +	struct perf_record_schedstat_cpu *cpu_data;
> +	struct schedstat_domain *domain_head;
> +	struct schedstat_cpu *next;
> +};
> +
> +struct schedstat_cpu *cpu_head = NULL, *cpu_tail = NULL, *cpu_second_pass = NULL;
> +struct schedstat_domain *domain_tail = NULL, *domain_second_pass = NULL;

No need to reset to NULL.  Also please add some comments how those
structs and lists are used.


> +bool after_workload_flag;
> +
> +static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
> +{
> +	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
> +	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
> +	__u16 version = after_workload->cpu_data->version;
> +
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
> +	(before->_ver._name = after->_ver._name - before->_ver._name)
> +
> +	if (version == 15) {
> +#include <perf/schedstat-v15.h>
> +	} else if (version == 16) {
> +#include <perf/schedstat-v16.h>
> +	} else if (version == 17) {
> +#include <perf/schedstat-v17.h>
> +	}
> +
> +#undef CPU_FIELD
> +}
> +
> +static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
> +{
> +	struct perf_record_schedstat_domain *before = domain_second_pass->domain_data;
> +	struct perf_record_schedstat_domain *after = after_workload->domain_data;
> +	__u16 version = after_workload->domain_data->version;
> +
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
> +	(before->_ver._name = after->_ver._name - before->_ver._name)
> +
> +	if (version == 15) {
> +#include <perf/schedstat-v15.h>
> +	} else if (version == 16) {
> +#include <perf/schedstat-v16.h>
> +	} else if (version == 17) {
> +#include <perf/schedstat-v17.h>
> +	}
> +#undef DOMAIN_FIELD
> +}
> +
> +static void print_separator(size_t pre_dash_cnt, const char *s, size_t post_dash_cnt)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < pre_dash_cnt; ++i)
> +		printf("-");
> +
> +	printf("%s", s);
> +
> +	for (i = 0; i < post_dash_cnt; ++i)
> +		printf("-");
> +
> +	printf("\n");

This can be simplified:

	printf("%.*s%s%.*s\n", pre_dash_cnt, graph_dotted_line, s,
		post_dash_cnt, graph_dotted_line);

> +}
> +
> +static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
> +{
> +	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
> +	print_separator(100, "", 0);

	printf("%.*s\n", 100, graph_dotted_line);

You can define a macro for the length (100) as it's used in other places
too.

> +
> +#define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
> +
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
> +	do {									\
> +		printf("%-65s: " _format, _desc, cs->_ver._name);		\
> +		if (_is_pct) {							\
> +			printf("  ( %8.2lf%% )",				\
> +			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
> +		}								\
> +		printf("\n");							\
> +	} while (0)
> +
> +	if (cs->version == 15) {
> +#include <perf/schedstat-v15.h>
> +	} else if (cs->version == 16) {
> +#include <perf/schedstat-v16.h>
> +	} else if (cs->version == 17) {
> +#include <perf/schedstat-v17.h>
> +	}
> +
> +#undef CPU_FIELD
> +#undef CALC_PCT
> +}
> +
> +static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
> +				      __u64 jiffies)
> +{
> +	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
> +
> +#define DOMAIN_CATEGORY(_desc)							\
> +	do {									\
> +		size_t _len = strlen(_desc);					\
> +		size_t _pre_dash_cnt = (100 - _len) / 2;			\
> +		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
> +		print_separator(_pre_dash_cnt, _desc, _post_dash_cnt);		\

This can be useful in other places, can you please factor it out as a
function somewhere in util.c?


> +	} while (0)
> +
> +#define CALC_AVG(_x, _y)	((_y) ? (long double)(_x) / (_y) : 0.0)
> +
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
> +	do {									\
> +		printf("%-65s: " _format, _desc, ds->_ver._name);		\
> +		if (_is_jiffies) {						\
> +			printf("  $ %11.2Lf $",					\
> +			       CALC_AVG(jiffies, ds->_ver._name));		\
> +		}								\
> +		printf("\n");							\
> +	} while (0)
> +
> +#define DERIVED_CNT_FIELD(_desc, _format, _x, _y, _z, _ver)			\
> +	printf("*%-64s: " _format "\n", _desc,					\
> +	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
> +
> +#define DERIVED_AVG_FIELD(_desc, _format, _x, _y, _z, _w, _ver)			\
> +	printf("*%-64s: " _format "\n", _desc, CALC_AVG(ds->_ver._w,		\
> +	       ((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
> +
> +	if (ds->version == 15) {
> +#include <perf/schedstat-v15.h>
> +	} else if (ds->version == 16) {
> +#include <perf/schedstat-v16.h>
> +	} else if (ds->version == 17) {
> +#include <perf/schedstat-v17.h>
> +	}
> +
> +#undef DERIVED_AVG_FIELD
> +#undef DERIVED_CNT_FIELD
> +#undef DOMAIN_FIELD
> +#undef CALC_AVG
> +#undef DOMAIN_CATEGORY
> +}
> +
> +static void print_domain_cpu_list(struct perf_record_schedstat_domain *ds)
> +{
> +	char bin[16][5] = {"0000", "0001", "0010", "0011",
> +			   "0100", "0101", "0110", "0111",
> +			   "1000", "1001", "1010", "1011",
> +			   "1100", "1101", "1110", "1111"};
> +	bool print_flag = false, low = true;
> +	int cpu = 0, start, end, idx;
> +
> +	idx = ((ds->nr_cpus + 7) >> 3) - 1;
> +
> +	printf("<");
> +	while (idx >= 0) {
> +		__u8 index;
> +
> +		if (low)
> +			index = ds->cpu_mask[idx] & 0xf;
> +		else
> +			index = (ds->cpu_mask[idx--] & 0xf0) >> 4;

Isn't ds->cpu_mask a bitmap?  Can we use bitmap_scnprintf() or
something?

> +
> +		for (int i = 3; i >= 0; i--) {
> +			if (!print_flag && bin[index][i] == '1') {
> +				start = cpu;
> +				print_flag = true;
> +			} else if (print_flag && bin[index][i] == '0') {
> +				end = cpu - 1;
> +				print_flag = false;
> +				if (start == end)
> +					printf("%d, ", start);
> +				else
> +					printf("%d-%d, ", start, end);
> +			}
> +			cpu++;
> +		}
> +
> +		low = !low;
> +	}
> +
> +	if (print_flag) {
> +		if (start == cpu-1)
> +			printf("%d, ", start);
> +		else
> +			printf("%d-%d, ", start, cpu-1);
> +	}
> +	printf("\b\b>\n");
> +}
> +
> +static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
> +				    struct schedstat_cpu *cptr,
> +				    int cnt, bool is_last)
> +{
> +	struct perf_record_schedstat_cpu *summary_cs = summary_cpu->cpu_data,
> +					 *temp_cs = cptr->cpu_data;
> +
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
> +	do {									\
> +		summary_cs->_ver._name += temp_cs->_ver._name;			\
> +		if (is_last)							\
> +			summary_cs->_ver._name /= cnt;				\
> +	} while (0)
> +
> +	if (cptr->cpu_data->version == 15) {
> +#include <perf/schedstat-v15.h>
> +	} else if (cptr->cpu_data->version == 16) {
> +#include <perf/schedstat-v16.h>
> +	} else if (cptr->cpu_data->version == 17) {
> +#include <perf/schedstat-v17.h>
> +	}
> +#undef CPU_FIELD
> +}
> +
> +static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
> +				       struct schedstat_domain *dptr,
> +				       int cnt, bool is_last)
> +{
> +	struct perf_record_schedstat_domain *summary_ds = summary_domain->domain_data,
> +					    *temp_ds = dptr->domain_data;
> +
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
> +	do {									\
> +		summary_ds->_ver._name += temp_ds->_ver._name;			\
> +		if (is_last)							\
> +			summary_ds->_ver._name /= cnt;				\
> +	} while (0)
> +
> +	if (dptr->domain_data->version == 15) {
> +#include <perf/schedstat-v15.h>
> +	} else if (dptr->domain_data->version == 16) {
> +#include <perf/schedstat-v16.h>
> +	} else if (dptr->domain_data->version == 17) {
> +#include <perf/schedstat-v17.h>
> +	}
> +#undef DOMAIN_FIELD
> +}
> +
> +static void get_all_cpu_stats(struct schedstat_cpu **cptr)
> +{
> +	struct schedstat_domain *dptr = NULL, *tdptr = NULL, *dtail = NULL;
> +	struct schedstat_cpu *tcptr = *cptr, *summary_head = NULL;
> +	struct perf_record_schedstat_domain *ds = NULL;
> +	struct perf_record_schedstat_cpu *cs = NULL;
> +	bool is_last = false;
> +	int cnt = 0;
> +
> +	if (tcptr) {
> +		summary_head = zalloc(sizeof(*summary_head));
> +		summary_head->cpu_data = zalloc(sizeof(*cs));

No error handlings.


> +		memcpy(summary_head->cpu_data, tcptr->cpu_data, sizeof(*cs));
> +		summary_head->next = NULL;
> +		summary_head->domain_head = NULL;
> +		dptr = tcptr->domain_head;
> +
> +		while (dptr) {
> +			size_t cpu_mask_size = (dptr->domain_data->nr_cpus + 7) >> 3;
> +
> +			tdptr = zalloc(sizeof(*tdptr));
> +			tdptr->domain_data = zalloc(sizeof(*ds) + cpu_mask_size);

Ditto.


> +			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds) + cpu_mask_size);
> +
> +			tdptr->next = NULL;
> +			if (!dtail) {
> +				summary_head->domain_head = tdptr;
> +				dtail = tdptr;
> +			} else {
> +				dtail->next = tdptr;
> +				dtail = dtail->next;
> +			}
> +			dptr = dptr->next;

Hmm.. can we just use list_head?


> +		}
> +	}
> +
> +	tcptr = (*cptr)->next;
> +	while (tcptr) {
> +		if (!tcptr->next)
> +			is_last = true;
> +
> +		cnt++;
> +		summarize_schedstat_cpu(summary_head, tcptr, cnt, is_last);
> +		tdptr = summary_head->domain_head;
> +		dptr = tcptr->domain_head;
> +
> +		while (tdptr) {
> +			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> +			tdptr = tdptr->next;
> +			dptr = dptr->next;
> +		}
> +		tcptr = tcptr->next;
> +	}
> +
> +	tcptr = *cptr;
> +	summary_head->next = tcptr;
> +	*cptr = summary_head;
> +}
> +
> +/* FIXME: The code fails (segfaults) when one or ore cpus are offline. */

Sounds scary..  Do you have any clue?


> +static void show_schedstat_data(struct schedstat_cpu *cptr)
> +{
> +	struct perf_record_schedstat_domain *ds = NULL;
> +	struct perf_record_schedstat_cpu *cs = NULL;
> +	__u64 jiffies = cptr->cpu_data->timestamp;
> +	struct schedstat_domain *dptr = NULL;
> +	bool is_summary = true;
> +
> +	printf("Columns description\n");
> +	print_separator(100, "", 0);
> +	printf("DESC\t\t\t-> Description of the field\n");
> +	printf("COUNT\t\t\t-> Value of the field\n");
> +	printf("PCT_CHANGE\t\t-> Percent change with corresponding base value\n");
> +	printf("AVG_JIFFIES\t\t-> Avg time in jiffies between two consecutive occurrence of event\n");
> +
> +	print_separator(100, "", 0);
> +	printf("Time elapsed (in jiffies)                                        : %11llu\n",

Probably better to use printf("%-*s: %11llu\n", ...).


> +	       jiffies);
> +	print_separator(100, "", 0);
> +
> +	get_all_cpu_stats(&cptr);
> +
> +	while (cptr) {
> +		cs = cptr->cpu_data;
> +		printf("\n");
> +		print_separator(100, "", 0);
> +		if (is_summary)
> +			printf("CPU <ALL CPUS SUMMARY>\n");
> +		else
> +			printf("CPU %d\n", cs->cpu);
> +
> +		print_separator(100, "", 0);
> +		print_cpu_stats(cs);
> +		print_separator(100, "", 0);
> +
> +		dptr = cptr->domain_head;
> +
> +		while (dptr) {
> +			ds = dptr->domain_data;
> +			if (is_summary)
> +				if (ds->name[0])
> +					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", ds->name);
> +				else
> +					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", ds->domain);
> +			else {
> +				if (ds->name[0])
> +					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, ds->name);
> +				else
> +					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, ds->domain);
> +
> +				print_domain_cpu_list(ds);
> +			}
> +			print_separator(100, "", 0);
> +			print_domain_stats(ds, jiffies);
> +			print_separator(100, "", 0);
> +
> +			dptr = dptr->next;
> +		}
> +		is_summary = false;
> +		cptr = cptr->next;
> +	}
> +}
> +
> +static int perf_sched__process_schedstat(struct perf_session *session __maybe_unused,
> +					 union perf_event *event)
> +{
> +	struct perf_cpu this_cpu;
> +	static __u32 initial_cpu;
> +
> +	switch (event->header.type) {
> +	case PERF_RECORD_SCHEDSTAT_CPU:
> +		this_cpu.cpu = event->schedstat_cpu.cpu;
> +		break;
> +	case PERF_RECORD_SCHEDSTAT_DOMAIN:
> +		this_cpu.cpu = event->schedstat_domain.cpu;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
> +		return 0;
> +
> +	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
> +		struct schedstat_cpu *temp = zalloc(sizeof(struct schedstat_cpu));
> +
> +		temp->cpu_data = zalloc(sizeof(struct perf_record_schedstat_cpu));

No error checks.


> +		memcpy(temp->cpu_data, &event->schedstat_cpu,
> +		       sizeof(struct perf_record_schedstat_cpu));
> +		temp->next = NULL;
> +		temp->domain_head = NULL;
> +
> +		if (cpu_head && temp->cpu_data->cpu == initial_cpu)
> +			after_workload_flag = true;
> +
> +		if (!after_workload_flag) {
> +			if (!cpu_head) {
> +				initial_cpu = temp->cpu_data->cpu;
> +				cpu_head = temp;
> +			} else
> +				cpu_tail->next = temp;
> +
> +			cpu_tail = temp;
> +		} else {
> +			if (temp->cpu_data->cpu == initial_cpu) {
> +				cpu_second_pass = cpu_head;
> +				cpu_head->cpu_data->timestamp =
> +					temp->cpu_data->timestamp - cpu_second_pass->cpu_data->timestamp;
> +			} else {
> +				cpu_second_pass = cpu_second_pass->next;
> +			}
> +			domain_second_pass = cpu_second_pass->domain_head;
> +			store_schedtstat_cpu_diff(temp);

Is 'temp' used after this?


> +		}
> +	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
> +		size_t cpu_mask_size = (event->schedstat_domain.nr_cpus + 7) >> 3;
> +		struct schedstat_domain *temp = zalloc(sizeof(struct schedstat_domain));
> +
> +		temp->domain_data = zalloc(sizeof(struct perf_record_schedstat_domain) + cpu_mask_size);

No error checks.


> +		memcpy(temp->domain_data, &event->schedstat_domain,
> +		       sizeof(struct perf_record_schedstat_domain) + cpu_mask_size);
> +		temp->next = NULL;
> +
> +		if (!after_workload_flag) {
> +			if (cpu_tail->domain_head == NULL) {
> +				cpu_tail->domain_head = temp;
> +				domain_tail = temp;
> +			} else {
> +				domain_tail->next = temp;
> +				domain_tail = temp;
> +			}
> +		} else {
> +			store_schedstat_domain_diff(temp);
> +			domain_second_pass = domain_second_pass->next;

Is 'temp' leaking?


> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void free_schedstat(struct schedstat_cpu *cptr)
> +{
> +	struct schedstat_domain *dptr = NULL, *tmp_dptr;
> +	struct schedstat_cpu *tmp_cptr;
> +
> +	while (cptr) {
> +		tmp_cptr = cptr;
> +		dptr = cptr->domain_head;
> +
> +		while (dptr) {
> +			tmp_dptr = dptr;
> +			dptr = dptr->next;
> +			free(tmp_dptr);
> +		}
> +		cptr = cptr->next;
> +		free(tmp_cptr);
> +	}
> +}
> +
> +static int perf_sched__schedstat_report(struct perf_sched *sched)
> +{
> +	struct perf_session *session;
> +	struct perf_data data = {
> +		.path  = input_name,
> +		.mode  = PERF_DATA_MODE_READ,
> +	};
> +	int err;
> +
> +	if (cpu_list) {
> +		user_requested_cpus = perf_cpu_map__new(cpu_list);
> +		if (!user_requested_cpus)
> +			return -EINVAL;
> +	}
> +
> +	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
> +	sched->tool.schedstat_domain = perf_sched__process_schedstat;
> +
> +	session = perf_session__new(&data, &sched->tool);
> +	if (IS_ERR(session)) {
> +		pr_err("Perf session creation failed.\n");
> +		return PTR_ERR(session);
> +	}
> +
> +	err = perf_session__process_events(session);
> +
> +	perf_session__delete(session);

Quite unusual location to do this. :)  Probably better to call it after
finishing the actual logic as you might need some session data later.


> +	if (!err) {
> +		setup_pager();
> +		show_schedstat_data(cpu_head);
> +		free_schedstat(cpu_head);
> +	}

	perf_cpu_map__put(user_requested_cpus);

> +	return err;
> +}
> +
>  static bool schedstat_events_exposed(void)
>  {
>  	/*
> @@ -4046,6 +4541,8 @@ int cmd_sched(int argc, const char **argv)
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option stats_options[] = {
> +	OPT_STRING('i', "input", &input_name, "file",
> +		   "`stats report` with input filename"),
>  	OPT_STRING('o', "output", &output_name, "file",
>  		   "`stats record` with output filename"),
>  	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
> @@ -4171,7 +4668,7 @@ int cmd_sched(int argc, const char **argv)
>  
>  		return perf_sched__timehist(&sched);
>  	} else if (!strcmp(argv[0], "stats")) {
> -		const char *const stats_subcommands[] = {"record", NULL};
> +		const char *const stats_subcommands[] = {"record", "report", NULL};
>  
>  		argc = parse_options_subcommand(argc, argv, stats_options,
>  						stats_subcommands,
> @@ -4183,6 +4680,11 @@ int cmd_sched(int argc, const char **argv)
>  				argc = parse_options(argc, argv, stats_options,
>  						     stats_usage, 0);
>  			return perf_sched__schedstat_record(&sched, argc, argv);
> +		} else if (argv[0] && !strcmp(argv[0], "report")) {
> +			if (argc)
> +				argc = parse_options(argc, argv, stats_options,
> +						     stats_usage, 0);
> +			return perf_sched__schedstat_report(&sched);
>  		}
>  		usage_with_options(stats_usage, stats_options);
>  	} else {
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index d09c3c99ab48..4071bd95192d 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -560,7 +560,7 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
>  
>  	size = fprintf(fp, "\ncpu%u ", cs->cpu);
>  
> -#define CPU_FIELD(_type, _name, _ver)						\
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
>  	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
>  
>  	if (version == 15) {
> @@ -641,7 +641,7 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
>  	size += fprintf(fp, "%s ", cpu_mask);
>  	free(cpu_mask);
>  
> -#define DOMAIN_FIELD(_type, _name, _ver)					\
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
>  	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name)
>  
>  	if (version == 15) {
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index fad0c472f297..495ed8433c0c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2538,7 +2538,7 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
>  	if (io__get_dec(io, (__u64 *)cpu) != ' ')
>  		goto out_cpu;
>  
> -#define CPU_FIELD(_type, _name, _ver)					\
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
>  	do {								\
>  		__u64 _tmp;						\
>  		ch = io__get_dec(io, &_tmp);				\
> @@ -2662,7 +2662,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  	free(d_name);
>  	free(cpu_mask);
>  
> -#define DOMAIN_FIELD(_type, _name, _ver)				\
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
>  	do {								\
>  		__u64 _tmp;						\
>  		ch = io__get_dec(io, &_tmp);				\
> -- 
> 2.43.0
> 

