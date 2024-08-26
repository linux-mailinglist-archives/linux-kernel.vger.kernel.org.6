Return-Path: <linux-kernel+bounces-302162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD395FAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DB4B22149
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564C19B3C4;
	Mon, 26 Aug 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlpgbJJv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384A19AA53
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704415; cv=none; b=kHiLO1QX9YCBkSXyH20CHsVj06DPXSvW6AbnO/iQsBMSRtSEDcqnKr5jDkyqWXBs5YyVFLaH4uHveNYAEByqmY6KM//M4FnwnRaFBjSxyBPLI3pwM5wA8PXtKtWQkR3hnwOpDeb3sl1WQFBarN0zMffbDgepw4+1gyAkVTQAkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704415; c=relaxed/simple;
	bh=2++G5TFlPGtMjuHigKRpDGrLbf2Eqc9lo5+EAg8NCAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4pOeenWzM7CAK1VwS0lwkGbI+vONJDqg8fEnaHkE2VI2ojhuo9RuaCF3qTnjAA3Bbnuaai44Rb+Nz6vm7bslc5k+qI50iaz9JNhzKTwqFVDICTAqUMOmWyjznnuxN1iWU/Y6pevqcy8+XC2/W58uNyeYW/2Eydm+DnQa7Noc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlpgbJJv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724704414; x=1756240414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2++G5TFlPGtMjuHigKRpDGrLbf2Eqc9lo5+EAg8NCAM=;
  b=VlpgbJJv5xTdyvEFy360eUN8ZW6zjUSPxzWLzSB5tmljvIpRnXDwjKGo
   GvQGxxsoXn9DVCqNn2n/zjZe5Q5AWUC0KsI0UfO3yPGRWGj4dTZbSvucf
   ajXHuUVVx1hoSw9UTcxtJEutmY3dSkc3N74jeH4w0tuf1+fIe/6oEruqT
   LJLWJtTXUZQ5oDDJuPIoBO2fYYlF+u3dYYBWCtCluSYJomi7HxbHsVyIU
   w6d4EJz7r97vWamMxchi9hd/I+A+zkR4WngsLG5y1l9gKrk8oJO8fDg6N
   DBwQUzTdjAyN1gswZelxjkOK577Jmz2b+if8Tfx5A/CHnjgIyfHiL4I6c
   A==;
X-CSE-ConnectionGUID: LszhjYz+SHyffIwqnkGF8g==
X-CSE-MsgGUID: dX12DnyBS5icq323lQp93w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33718536"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33718536"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:33:33 -0700
X-CSE-ConnectionGUID: k/7FiudcQo2ky1jVVuMYnA==
X-CSE-MsgGUID: BRSQLwrQTSyMrd5Hh7M/zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66780976"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Aug 2024 13:33:29 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sigP0-000HZi-1U;
	Mon, 26 Aug 2024 20:33:26 +0000
Date: Tue, 27 Aug 2024 04:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Ehab <bottaawesome633@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Refactor switch_mm_cid() to avoid unnecessary checks
Message-ID: <202408270455.R85TrPfw-lkp@intel.com>
References: <20240824223132.11925-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824223132.11925-1-bottaawesome633@gmail.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Ehab/Refactor-switch_mm_cid-to-avoid-unnecessary-checks/20240826-153216
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240824223132.11925-1-bottaawesome633%40gmail.com
patch subject: [PATCH] Refactor switch_mm_cid() to avoid unnecessary checks
config: arm-ep93xx_defconfig (https://download.01.org/0day-ci/archive/20240827/202408270455.R85TrPfw-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270455.R85TrPfw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270455.R85TrPfw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:5232:4: error: implicit declaration of function 'switch_mm_cid_from_user_to_kernel' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           switch_mm_cid_from_user_to_kernel(rq, prev, next);
                           ^
>> kernel/sched/core.c:5257:4: error: implicit declaration of function 'switch_mm_cid_from_kernel_to_user' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           switch_mm_cid_from_kernel_to_user(rq, prev, next);
                           ^
>> kernel/sched/core.c:5259:4: error: implicit declaration of function 'switch_mm_cid_from_user_to_user' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           switch_mm_cid_from_user_to_user(rq, prev, next);
                           ^
   3 errors generated.


vim +/switch_mm_cid_from_user_to_kernel +5232 kernel/sched/core.c

  5199	
  5200	/*
  5201	 * context_switch - switch to the new MM and the new thread's register state.
  5202	 */
  5203	static __always_inline struct rq *
  5204	context_switch(struct rq *rq, struct task_struct *prev,
  5205		       struct task_struct *next, struct rq_flags *rf)
  5206	{
  5207		prepare_task_switch(rq, prev, next);
  5208	
  5209		/*
  5210		 * For paravirt, this is coupled with an exit in switch_to to
  5211		 * combine the page table reload and the switch backend into
  5212		 * one hypercall.
  5213		 */
  5214		arch_start_context_switch(prev);
  5215	
  5216		/*
  5217		 * kernel -> kernel   lazy + transfer active
  5218		 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
  5219		 *
  5220		 * kernel ->   user   switch + mmdrop_lazy_tlb() active
  5221		 *   user ->   user   switch
  5222		 *
  5223		 * switch_mm_cid() needs to be updated if the barriers provided
  5224		 * by context_switch() are modified.
  5225		 */
  5226		if (!next->mm) {                                // to kernel
  5227			enter_lazy_tlb(prev->active_mm, next);
  5228	
  5229			next->active_mm = prev->active_mm;
  5230			if (prev->mm) {                           // from user
  5231				mmgrab_lazy_tlb(prev->active_mm);
> 5232				switch_mm_cid_from_user_to_kernel(rq, prev, next);
  5233			}
  5234			else
  5235				/*
  5236				 * kernel -> kernel transition does not change rq->curr->mm
  5237				 * state. It stays NULL.
  5238				 */
  5239				prev->active_mm = NULL;
  5240		} else {                                        // to user
  5241			membarrier_switch_mm(rq, prev->active_mm, next->mm);
  5242			/*
  5243			 * sys_membarrier() requires an smp_mb() between setting
  5244			 * rq->curr / membarrier_switch_mm() and returning to userspace.
  5245			 *
  5246			 * The below provides this either through switch_mm(), or in
  5247			 * case 'prev->active_mm == next->mm' through
  5248			 * finish_task_switch()'s mmdrop().
  5249			 */
  5250			switch_mm_irqs_off(prev->active_mm, next->mm, next);
  5251			lru_gen_use_mm(next->mm);
  5252	
  5253			if (!prev->mm) {                        // from kernel
  5254				/* will mmdrop_lazy_tlb() in finish_task_switch(). */
  5255				rq->prev_mm = prev->active_mm;
  5256				prev->active_mm = NULL;
> 5257				switch_mm_cid_from_kernel_to_user(rq, prev, next);
  5258			} else
> 5259				switch_mm_cid_from_user_to_user(rq, prev, next);
  5260		}
  5261	
  5262		prepare_lock_switch(rq, next, rf);
  5263	
  5264		/* Here we just switch the register state and the stack. */
  5265		switch_to(prev, next, prev);
  5266		barrier();
  5267	
  5268		return finish_task_switch(prev);
  5269	}
  5270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

