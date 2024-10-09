Return-Path: <linux-kernel+bounces-356840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C199678C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7E3B216B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76814190049;
	Wed,  9 Oct 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbpCFnE/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE418E041
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470752; cv=none; b=Y9bmtg2LpzCm7f77JuAyJpOgy85GiPUrfdOHgyCzSGGN6x8hzIs3XMLaj4pp9gNxK7fc4OUT9fjWNMLLsKP/AvbmKAy3C7dKGH3hbV/19DFP0CWNnb5Jgni7nQFTnbCcUpvvj+/5emkQPS4sGoywoyVJMgRJlEq9Niz+EYUTbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470752; c=relaxed/simple;
	bh=Rz0400i01/18gf8WW+9D1OmW6L5UQVxYq75ozCXQxj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/CMeRVjujlDmPK9fJus4ch2doJbBvCXdjRx7+0D3Lstv/e+T9teIMk9ispYNXVcsdk0dHONvHWaVX8gcOvdsJ6SqrPMHc0H08mNt0y8vTp9PwACcK7p8/zv39Dpkog8hGpVHTfsNozSnrz1BbXjzuE84lMZpdpzo2JKREOwtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbpCFnE/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728470751; x=1760006751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rz0400i01/18gf8WW+9D1OmW6L5UQVxYq75ozCXQxj8=;
  b=FbpCFnE/sBBlpIJGlJFnPSkMRkf4mjX9Qq/who2iQ+Bex9kHQCgPbeB3
   SGmLmBCNNVg2dd/p8nV4029AnURY3DmFPd41Coas3trw5HdxLoxTK3XEX
   xkxPFaGFw6KkgNdxfiLDJbK+JNYSdulo7P3A0TbVpZJBYQupRCdVLy3Ox
   mR53KAiJ+aKWbJgOqUyzMamLLKp/7gK1wSH5Ibl/0hzYxWfXJLZvjKvot
   GnXt80Tg9E5zWnYVZ5gKsGqQR79mm0QLDp57ECU3hJFSnmXC3/F2wKFGI
   Jd8mwuVGzt/I+7oZeg3AcrcovYWMIsN30skufjXv7dhhpmMOwmiMRZeM4
   g==;
X-CSE-ConnectionGUID: cy2Ga/55Sv2QP3q/uJlszA==
X-CSE-MsgGUID: eAAVBwD4TSy1zDBJmSpiJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27921675"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27921675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 03:45:50 -0700
X-CSE-ConnectionGUID: XSgv+dTUS+uwWQv5VW0mDg==
X-CSE-MsgGUID: 5Bt0j+K+Tkm3V6T4ueyfmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76100543"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Oct 2024 03:45:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syUCP-00097M-2n;
	Wed, 09 Oct 2024 10:45:45 +0000
Date: Wed, 9 Oct 2024 18:44:52 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 3/5] perf: Add pmu get/put
Message-ID: <202410091848.aRUoRWWD-lkp@intel.com>
References: <20241008183501.1354695-4-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008183501.1354695-4-lucas.demarchi@intel.com>

Hi Lucas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[cannot apply to tip/perf/core perf-tools/perf-tools acme/perf/core linus/master v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-De-Marchi/perf-Add-dummy-pmu-module/20241009-023728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241008183501.1354695-4-lucas.demarchi%40intel.com
patch subject: [PATCH 3/5] perf: Add pmu get/put
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241009/202410091848.aRUoRWWD-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091848.aRUoRWWD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091848.aRUoRWWD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/events/core.c:5235:17: warning: unused variable 'module' [-Wunused-variable]
    5235 |         struct module *module;
         |                        ^~~~~~
   1 warning generated.


vim +/module +5235 kernel/events/core.c

  5232	
  5233	static void _free_event(struct perf_event *event)
  5234	{
> 5235		struct module *module;
  5236	
  5237		irq_work_sync(&event->pending_irq);
  5238		irq_work_sync(&event->pending_disable_irq);
  5239		perf_pending_task_sync(event);
  5240	
  5241		unaccount_event(event);
  5242	
  5243		security_perf_event_free(event);
  5244	
  5245		if (event->rb) {
  5246			/*
  5247			 * Can happen when we close an event with re-directed output.
  5248			 *
  5249			 * Since we have a 0 refcount, perf_mmap_close() will skip
  5250			 * over us; possibly making our ring_buffer_put() the last.
  5251			 */
  5252			mutex_lock(&event->mmap_mutex);
  5253			ring_buffer_attach(event, NULL);
  5254			mutex_unlock(&event->mmap_mutex);
  5255		}
  5256	
  5257		if (is_cgroup_event(event))
  5258			perf_detach_cgroup(event);
  5259	
  5260		if (!event->parent) {
  5261			if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
  5262				put_callchain_buffers();
  5263		}
  5264	
  5265		perf_event_free_bpf_prog(event);
  5266		perf_addr_filters_splice(event, NULL);
  5267		kfree(event->addr_filter_ranges);
  5268	
  5269		if (event->destroy)
  5270			event->destroy(event);
  5271	
  5272		/*
  5273		 * Must be after ->destroy(), due to uprobe_perf_close() using
  5274		 * hw.target.
  5275		 */
  5276		if (event->hw.target)
  5277			put_task_struct(event->hw.target);
  5278	
  5279		if (event->pmu_ctx)
  5280			put_pmu_ctx(event->pmu_ctx);
  5281	
  5282		/*
  5283		 * perf_event_free_task() relies on put_ctx() being 'last', in particular
  5284		 * all task references must be cleaned up.
  5285		 */
  5286		if (event->ctx)
  5287			put_ctx(event->ctx);
  5288	
  5289		exclusive_event_destroy(event);
  5290	
  5291		pmu_module_put(&event->pmu);
  5292	
  5293		call_rcu(&event->rcu_head, free_event_rcu);
  5294	}
  5295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

