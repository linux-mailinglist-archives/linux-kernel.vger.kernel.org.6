Return-Path: <linux-kernel+bounces-296458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348A95AB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36D1B22E31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843B1C287;
	Thu, 22 Aug 2024 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwQFboZJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2B1B970
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294540; cv=none; b=r2vkFinSiXLjBM/Jg8HPtjnu9cey+SLeUaSyGcyZJvYph0mWsq7K8oiK2weQUSliUqXD2c/lk6eUGjZRdcZJe+jQnp6C+0+6CcvIA1wujc7GfnxNQ8J/Vvp2QlaYFXD+zGxeVt9oPtvfyU9kTmxZ3OpQlpurbYB6sWnvOIhAA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294540; c=relaxed/simple;
	bh=5nli8WndBJpedHicO5hZ6v2U8LcqbwxYkPoOZkOQglI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd+IRUW10FMUHni8yxf9D+dDcZekXXUxdQZ8N1nm0+Zc86ujCKQiXVkJYEZDzIvKunYvQMOM/anzWeajy3JNNjiMFuZpcEGiAtYoNpJvqRYUxxzFxo84zkmCQ4/l/nqdJbrRfE8U1b6NgQjb1e32Y1ByfaW5VPbuK4vyUxeCbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwQFboZJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724294538; x=1755830538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5nli8WndBJpedHicO5hZ6v2U8LcqbwxYkPoOZkOQglI=;
  b=GwQFboZJTSHvTV70LAa2Alzm4zYi9lVjPSkgj86uUPOcUkfxpou9oy43
   8zA4R6JTJp5nHG+vFITGnxiCZwM8Owjk7Z+HO2qmqrMPAlt+6UCAnRxPA
   JkJWlATGP+QJuKpTrzImAFkT+Jys12/Yx9uuUiQskH047Nsm65d3KRVdi
   kDFUC6L1D5dhgKgLxNL3T4XXWizbIX2x2JJPBAOqc9iflvfyDuTA+Xbh9
   xDmuODmAHkfRrXJiEh961MDlFKDnEn1QKB33t7oind3ldATFF5hM6+zAS
   7C9ONnBaU/lwkax64SgsQeneo9WJOfSaSwZ1VzNo5PTHIGkFuf5jJCr0N
   w==;
X-CSE-ConnectionGUID: CmKPfQDHQ7KH1O/XibR6Rw==
X-CSE-MsgGUID: Ps23PaSMQL6CFH56g5Q38w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22821447"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22821447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 19:42:18 -0700
X-CSE-ConnectionGUID: P8E22KYVS3ucOTgOZ/JLgg==
X-CSE-MsgGUID: 97P68gC9RFGFCRbQ97TSGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61282999"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 19:42:14 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgxm7-000CBk-1z;
	Thu, 22 Aug 2024 02:42:11 +0000
Date: Thu, 22 Aug 2024 10:42:06 +0800
From: kernel test robot <lkp@intel.com>
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Warn against unbalanced util_est during
 dequeue
Message-ID: <202408221018.b3g39QVN-lkp@intel.com>
References: <752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com>

Hi Hongyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master peterz-queue/sched/core next-20240821]
[cannot apply to tip/auto-latest linus/master v6.11-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongyan-Xia/sched-fair-Warn-against-unbalanced-util_est-during-dequeue/20240821-210618
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2%40arm.com
patch subject: [PATCH] sched/fair: Warn against unbalanced util_est during dequeue
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240822/202408221018.b3g39QVN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221018.b3g39QVN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221018.b3g39QVN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:27:
   In file included from include/linux/mm_api.h:1:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/sched/fair.c:7180:26: error: no member named 'avg' in 'struct cfs_rq'
    7180 |                         SCHED_WARN_ON(rq->cfs.avg.util_est);
         |                                       ~~~~~~~ ^
   kernel/sched/sched.h:97:42: note: expanded from macro 'SCHED_WARN_ON'
      97 | # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
         |                                          ^
   kernel/sched/fair.c:7186:25: error: no member named 'avg' in 'struct cfs_rq'
    7186 |                 SCHED_WARN_ON(rq->cfs.avg.util_est);
         |                               ~~~~~~~ ^
   kernel/sched/sched.h:97:42: note: expanded from macro 'SCHED_WARN_ON'
      97 | # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
         |                                          ^
   1 warning and 2 errors generated.


vim +7180 kernel/sched/fair.c

  7168	
  7169	/*
  7170	 * The dequeue_task method is called before nr_running is
  7171	 * decreased. We remove the task from the rbtree and
  7172	 * update the fair scheduling stats:
  7173	 */
  7174	static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
  7175	{
  7176		util_est_dequeue(&rq->cfs, p);
  7177	
  7178		if (dequeue_entities(rq, &p->se, flags) < 0) {
  7179			if (!rq->cfs.h_nr_running)
> 7180				SCHED_WARN_ON(rq->cfs.avg.util_est);
  7181			util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
  7182			return false;
  7183		}
  7184	
  7185		if (!rq->cfs.h_nr_running)
  7186			SCHED_WARN_ON(rq->cfs.avg.util_est);
  7187		util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
  7188		hrtick_update(rq);
  7189		return true;
  7190	}
  7191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

