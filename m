Return-Path: <linux-kernel+bounces-535760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FDBA476D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0A7188EB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9387225403;
	Thu, 27 Feb 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY6DULZ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A15213E71
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642520; cv=none; b=YisJwiNvjlQPu+0MjQSp0fQwVnJzxAe0XdX0yjO7KOaYK0/xSL22vS4orG6mhJzaKh5puhpSyuMvLMckjUiPBhWCbQcIuJGuKB8Q5lnUY67PKTb30/6F7lZYRstBbUS0xUmTsTEFcP2qywpXlAshwVEgETXLh0R9W2vbaz+hMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642520; c=relaxed/simple;
	bh=zVv3lwoQypP9GhGsEWRbM2RS3LTiYuyDpjvImkENqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZzocETWeYzjFzBhMsdQSok2d4HHjnTeO8rTXXRFoZK3nYD1X5p302Lz7ZIfIMKnmkAkgyymSb8S37T7UmThiCH1sEX8+BIJKWhfqpPNDqJ0VhvAeBK15Y6WAN0sMcASKd7MndYLTLqN11zDxIIwpVx3OFg7CY2IVc5ijwXL7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY6DULZ8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740642518; x=1772178518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVv3lwoQypP9GhGsEWRbM2RS3LTiYuyDpjvImkENqgg=;
  b=VY6DULZ8PrJSz34rp3+xgtCrfBI7gPH2XFspdecF0a5iH2RfPoKFCfIV
   6EAhBPBJgJMY15zFCT3hk6r54/0eZGzq2rIFxD7IO9nYTTaA/HsDKnQ8c
   MCDx2sPmRu6+HH0TAOdjKpCeltjfcQE36zX1i7pfOfS9OD4N7yEpDr/C/
   JQZApmW4FRpHS+Uitkz3Ax9RpOwKeYLLgGGKaL8b1QRaQbUH1jhxObT0+
   6UmrsUyKf5oU62bhztLV7vMv7c9FV4W2lgiIKC6ZgOI1H7XUqG+/WO1Vp
   yuhFFKe1UBZW5ORmgtiPbpI3BjL4tj8py5MQHvL6j3nRFzuc+lKqgr2M+
   A==;
X-CSE-ConnectionGUID: 8qH+RqPoSx+QxjtfJnQvXQ==
X-CSE-MsgGUID: 9ylglISQR7mFoVOY3LUU0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41402195"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41402195"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:48:37 -0800
X-CSE-ConnectionGUID: Hx67Dpd8TlCI+6q2ns7Lsw==
X-CSE-MsgGUID: pILmId1eSASgc4RrSxsUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117123532"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2025 23:48:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnYdF-000D2S-0D;
	Thu, 27 Feb 2025 07:48:33 +0000
Date: Thu, 27 Feb 2025 15:48:12 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 2/3] sched: Move task_mm_cid_work to mm work_struct
Message-ID: <202502271546.WRb9VN4H-lkp@intel.com>
References: <20250226070202.95062-3-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226070202.95062-3-gmonaco@redhat.com>

Hi Gabriele,

kernel test robot noticed the following build errors:

[auto build test ERROR on ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Add-prev_sum_exec_runtime-support-for-RT-DL-and-SCX-classes/20250226-150508
base:   ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
patch link:    https://lore.kernel.org/r/20250226070202.95062-3-gmonaco%40redhat.com
patch subject: [PATCH v10 2/3] sched: Move task_mm_cid_work to mm work_struct
config: arc-randconfig-002-20250227 (https://download.01.org/0day-ci/archive/20250227/202502271546.WRb9VN4H-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271546.WRb9VN4H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271546.WRb9VN4H-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/core.c: In function 'sched_tick':
>> kernel/sched/core.c:5667:21: error: 'RSEQ_UNPREEMPTED_THRESHOLD' undeclared (first use in this function)
    5667 |         if (rtime > RSEQ_UNPREEMPTED_THRESHOLD)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5667:21: note: each undeclared identifier is reported only once for each function it appears in


vim +/RSEQ_UNPREEMPTED_THRESHOLD +5667 kernel/sched/core.c

  5629	
  5630	/*
  5631	 * This function gets called by the timer code, with HZ frequency.
  5632	 * We call it with interrupts disabled.
  5633	 */
  5634	void sched_tick(void)
  5635	{
  5636		int cpu = smp_processor_id();
  5637		struct rq *rq = cpu_rq(cpu);
  5638		/* accounting goes to the donor task */
  5639		struct task_struct *donor;
  5640		struct rq_flags rf;
  5641		unsigned long hw_pressure;
  5642		u64 resched_latency, rtime;
  5643	
  5644		if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
  5645			arch_scale_freq_tick();
  5646	
  5647		sched_clock_tick();
  5648	
  5649		rq_lock(rq, &rf);
  5650		donor = rq->donor;
  5651		rtime = donor->se.sum_exec_runtime - donor->se.prev_sum_exec_runtime;
  5652	
  5653		psi_account_irqtime(rq, donor, NULL);
  5654	
  5655		update_rq_clock(rq);
  5656		hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
  5657		update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
  5658	
  5659		if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
  5660			resched_curr(rq);
  5661	
  5662		donor->sched_class->task_tick(rq, donor, 0);
  5663		if (sched_feat(LATENCY_WARN))
  5664			resched_latency = cpu_resched_latency(rq);
  5665		calc_global_load_tick(rq);
  5666		sched_core_tick(rq);
> 5667		if (rtime > RSEQ_UNPREEMPTED_THRESHOLD)
  5668			rseq_preempt(donor);
  5669		scx_tick(rq);
  5670	
  5671		rq_unlock(rq, &rf);
  5672	
  5673		if (sched_feat(LATENCY_WARN) && resched_latency)
  5674			resched_latency_warn(cpu, resched_latency);
  5675	
  5676		perf_event_task_tick();
  5677	
  5678		if (donor->flags & PF_WQ_WORKER)
  5679			wq_worker_tick(donor);
  5680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

