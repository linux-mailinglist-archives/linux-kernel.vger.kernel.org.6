Return-Path: <linux-kernel+bounces-558361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F7A5E4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D1816266C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE289258CEB;
	Wed, 12 Mar 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k849Rvsf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73F1E8346
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809142; cv=none; b=Lm3eHvIhmErS7oyFnQhM25w4d85/PAgdBMz9YGQuIqX7W263N1oVRbI2LMl0JQ11pI1ulA075sbdpGKjB3+9j5FYtqCXoWdMndjAIrvHqSm9dGevmiJA9iPf0uPfL4PFs+17p9r2qmOvyTeK671L60znoTyhdzZRZUPRMy0wgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809142; c=relaxed/simple;
	bh=wMBJKRI1jgs1UA7UuLcMi4YOteNf8/9ao2RduXR/UMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djYuYonEBAcz6yqv8rVipbGF6gkcBHKOFsivmguU0/owsKwy1U9t1IWtkVIRI7rZQo93i7Gh2DYNsUavnq4KGiFmcaLXfnhTiF5+3FwS5sX3+ttkye2HE1hN1obchbw8lAEw8KgEHIR972fvSj1Mke0bkWxVY8sLAFIeXPA2+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k849Rvsf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741809140; x=1773345140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wMBJKRI1jgs1UA7UuLcMi4YOteNf8/9ao2RduXR/UMo=;
  b=k849RvsfL3c4Rrz4o7u1RH2odfQrQHzja/WgLZ7ub358dbRSr4fwqroF
   soKQl+wlLolcNfiS0BZvmq9dvb0PrRRv6W9H6IXfpz10FLIYt90dweKKh
   X/jNm9TTzrJPcKraNHfxa4Lz6p53kmVkQ77eI7LQJOTgw7rRMR7FG8nja
   9YT5GFXSCOjae+/fAVdDbOlYVSJpCpAmuga623u0G1Ktt6dX6WNcpa+pa
   C/VOsB17FYeH/R98NgqTqw5+WiSSXSeFqxszyTm9uyZysQalV+u6j3O3y
   Qp+ljHePJSn1qBl6fUX9uoiZXRkY4RImnHj+XzzwkJzXEimJQrTIG3rCS
   A==;
X-CSE-ConnectionGUID: GAeboWCIQ4606JBU0OmhyQ==
X-CSE-MsgGUID: g3GeQZ16SrO8h0uvVTWKwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60450188"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60450188"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:52:18 -0700
X-CSE-ConnectionGUID: 0DfzXucPTiaNc46tXUS6/A==
X-CSE-MsgGUID: qMkYS50FQBS/F1qU19ZHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121236045"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:52:09 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 41B4F20B5736;
	Wed, 12 Mar 2025 12:52:07 -0700 (PDT)
Message-ID: <29655aae-e1fd-4f3a-88f9-033034943ddd@linux.intel.com>
Date: Wed, 12 Mar 2025 15:52:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 2/6] perf: attach/detach PMU specific data
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20250312182525.4078433-1-kan.liang@linux.intel.com>
 <20250312182525.4078433-2-kan.liang@linux.intel.com>
 <20250312191823.GB10453@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250312191823.GB10453@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-12 3:18 p.m., Peter Zijlstra wrote:
> On Wed, Mar 12, 2025 at 11:25:21AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +static int
>> +attach_global_ctx_data(struct kmem_cache *ctx_cache)
>> +{
>> +	if (refcount_inc_not_zero(&global_ctx_data_ref))
>> +		return 0;
>> +
>> +	percpu_down_write(&global_ctx_data_rwsem);
>> +	if (!refcount_inc_not_zero(&global_ctx_data_ref)) {
>> +		struct task_struct *g, *p;
>> +		struct perf_ctx_data *cd;
>> +		int ret;
>> +
>> +again:
>> +		/* Allocate everything */
>> +		rcu_read_lock();
>> +		for_each_process_thread(g, p) {
>> +			cd = rcu_dereference(p->perf_ctx_data);
>> +			if (cd && !cd->global) {
>> +				cd->global = 1;
>> +				if (!refcount_inc_not_zero(&cd->refcount))
>> +					cd = NULL;
>> +			}
>> +			if (!cd) {
>> +				get_task_struct(p);
>> +				rcu_read_unlock();
>> +
>> +				ret = attach_task_ctx_data(p, ctx_cache, true);
>> +				put_task_struct(p);
>> +				if (ret) {
>> +					__detach_global_ctx_data();
>> +					return ret;
> 
> AFAICT this returns with global_ctx_data_rwsem taken, no?

Ah, yes

> 
>> +				}
>> +				goto again;
>> +			}
>> +		}
>> +		rcu_read_unlock();
>> +
>> +		refcount_set(&global_ctx_data_ref, 1);
>> +	}
>> +	percpu_up_write(&global_ctx_data_rwsem);
>> +
>> +	return 0;
>> +}
> 
> Can we rework this with guards? A little something like so?
> 

Yes. I will do more test and send a V9.

Thanks,
Kan

> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5233,18 +5233,20 @@ static refcount_t global_ctx_data_ref;
>  static int
>  attach_global_ctx_data(struct kmem_cache *ctx_cache)
>  {
> +	struct task_struct *g, *p;
> +	struct perf_ctx_data *cd;
> +	int ret;
> +
>  	if (refcount_inc_not_zero(&global_ctx_data_ref))
>  		return 0;
>  
> -	percpu_down_write(&global_ctx_data_rwsem);
> -	if (!refcount_inc_not_zero(&global_ctx_data_ref)) {
> -		struct task_struct *g, *p;
> -		struct perf_ctx_data *cd;
> -		int ret;
> +	guard(percpu_write)(&global_ctx_data_rwsem);
> +	if (refcount_inc_not_zero(&global_ctx_data_ref))
> +		return 0;
>  
>  again:
> -		/* Allocate everything */
> -		rcu_read_lock();
> +	/* Allocate everything */
> +	scoped_guard (rcu) {
>  		for_each_process_thread(g, p) {
>  			cd = rcu_dereference(p->perf_ctx_data);
>  			if (cd && !cd->global) {
> @@ -5254,24 +5256,23 @@ attach_global_ctx_data(struct kmem_cache
>  			}
>  			if (!cd) {
>  				get_task_struct(p);
> -				rcu_read_unlock();
> -
> -				ret = attach_task_ctx_data(p, ctx_cache, true);
> -				put_task_struct(p);
> -				if (ret) {
> -					__detach_global_ctx_data();
> -					return ret;
> -				}
> -				goto again;
> +				goto alloc;
>  			}
>  		}
> -		rcu_read_unlock();
> -
> -		refcount_set(&global_ctx_data_ref, 1);
>  	}
> -	percpu_up_write(&global_ctx_data_rwsem);
> +
> +	refcount_set(&global_ctx_data_ref, 1);
>  
>  	return 0;
> +
> +alloc:
> +	ret = attach_task_ctx_data(p, ctx_cache, true);
> +	put_task_struct(p);
> +	if (ret) {
> +		__detach_global_ctx_data();
> +		return ret;
> +	}
> +	goto again;
>  }
>  
>  static int
> @@ -5338,15 +5339,12 @@ static void detach_global_ctx_data(void)
>  	if (refcount_dec_not_one(&global_ctx_data_ref))
>  		return;
>  
> -	percpu_down_write(&global_ctx_data_rwsem);
> +	guard(perpcu_write)(&global_ctx_data_rwsem);
>  	if (!refcount_dec_and_test(&global_ctx_data_ref))
> -		goto unlock;
> +		return;
>  
>  	/* remove everything */
>  	__detach_global_ctx_data();
> -
> -unlock:
> -	percpu_up_write(&global_ctx_data_rwsem);
>  }
>  
>  static void detach_perf_ctx_data(struct perf_event *event)
> @@ -8776,9 +8774,9 @@ perf_event_alloc_task_data(struct task_s
>  	if (!ctx_cache)
>  		return;
>  
> -	percpu_down_read(&global_ctx_data_rwsem);
> +	guard(percpu_read)(&global_ctx_data_rwsem);
> +	guard(rcu)();
>  
> -	rcu_read_lock();
>  	cd = rcu_dereference(child->perf_ctx_data);
>  
>  	if (!cd) {
> @@ -8787,21 +8785,16 @@ perf_event_alloc_task_data(struct task_s
>  		 * when attaching the perf_ctx_data.
>  		 */
>  		if (!refcount_read(&global_ctx_data_ref))
> -			goto rcu_unlock;
> +			return;
>  		rcu_read_unlock();
>  		attach_task_ctx_data(child, ctx_cache, true);
> -		goto up_rwsem;
> +		return;
>  	}
>  
>  	if (!cd->global) {
>  		cd->global = 1;
>  		refcount_inc(&cd->refcount);
>  	}
> -
> -rcu_unlock:
> -	rcu_read_unlock();
> -up_rwsem:
> -	percpu_up_read(&global_ctx_data_rwsem);
>  }
>  
>  void perf_event_fork(struct task_struct *task)
> @@ -13845,9 +13838,8 @@ void perf_event_exit_task(struct task_st
>  	/*
>  	 * Detach the perf_ctx_data for the system-wide event.
>  	 */
> -	percpu_down_read(&global_ctx_data_rwsem);
> +	guard(percpu_read)(&global_ctx_data_rwsem);
>  	detach_task_ctx_data(child);
> -	percpu_up_read(&global_ctx_data_rwsem);
>  }
>  
>  static void perf_free_event(struct perf_event *event,
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index c012df33a9f0..36f3082f2d82 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -8,6 +8,7 @@
>  #include <linux/wait.h>
>  #include <linux/rcu_sync.h>
>  #include <linux/lockdep.h>
> +#include <linux/cleanup.h>
>  
>  struct percpu_rw_semaphore {
>  	struct rcu_sync		rss;
> @@ -125,6 +126,13 @@ extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
>  extern void percpu_down_write(struct percpu_rw_semaphore *);
>  extern void percpu_up_write(struct percpu_rw_semaphore *);
>  
> +DEFINE_GUARD(percpu_read, struct perpcu_rw_semaphore *,
> +	     perpcu_down_read(_T), percpu_up_read(_T))
> +DEFINE_GUARD_COND(perpcu_read, _try, percpu_down_read_trylock(_T))
> +
> +DEFINE_GUARD(percpu_write, struct percpu_rw_semaphore *,
> +	     percpu_down_write(_T), perpcu_up_write(_T))
> +
>  static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
>  {
>  	return atomic_read(&sem->block);
> 



