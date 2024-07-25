Return-Path: <linux-kernel+bounces-262525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D393C834
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA43283843
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76821350;
	Thu, 25 Jul 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMke6YWU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64251E528
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931383; cv=none; b=dMQDUQEBu1BoHR3svRIePGymUIVHrPi9fSwxVx7yqbCAJjXwsqfwyMGGZtCykzS5MKJcArxFhMsVUfnlGyaDJ2G5oQWoiNruR6lv+K0TXclFSL0w6NS4r/yJ5uhN+HKZmhUtma+N8hk8zwmDoiqcTq10sDKWxZLwaD7eGJy3DUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931383; c=relaxed/simple;
	bh=6jhxNOlrJsl8D5quO+IfMn76L5sqpLqYfZSQGj+KA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGaqm3pp7gL0f4xaw9Hv5eMSLTs4C5sjxMhgNnbGfLEaCk2Q7n8/B5Pez2FbNhpWg807pEJHWLyLk3aksv/PpWE9Dv1lb6KQfXfDHFkJ7Qrh6f2X1oUJ1vzgkRZ7MKhid1LmNlUsp2+UfWR2ZXKDRAfY93dIOP/ERbqJ/2q91gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMke6YWU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721931381; x=1753467381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jhxNOlrJsl8D5quO+IfMn76L5sqpLqYfZSQGj+KA2k=;
  b=XMke6YWUd4lP6RCjWiS/iI0/wdqelQtZ0GLo4nRieIi0/juL+DNV/Iw5
   oI+yCGfel/R2LoMwgTKdr8wdruUqHd8GR4ySjTSVo6dMa5rW1LhjelksO
   oiFCwoE5XS55dIBdxsIDAnqz3AYGzi2gam/WQy42S+VKA0Wa1jr0ER+XN
   9LzmF1Rvvcbva4YxZsjJ6IVs0DCe3lf4Fg/0+OtOlEH0k+OeYasLaSxMe
   YkiGjI5hSE2vo9Imob2PYSgNoAnluqPb5fvRKgAHynX9aAZp35c/TfJCS
   HTd9noLsbqdTI6XSUMwEO27Fjn9ttZQesbdmdS2vf7iBsX9xQMgzZwBIh
   Q==;
X-CSE-ConnectionGUID: F69B28qLQ9SYADmjZNfABA==
X-CSE-MsgGUID: p4ROfNkHR1+Vej7y/K629A==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="12715083"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="12715083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 11:16:20 -0700
X-CSE-ConnectionGUID: mxpGtCa4T42/9gL4rff6MA==
X-CSE-MsgGUID: tUMrmPMrT3KdduO5P3+AKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="90480364"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Jul 2024 11:16:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX30i-000oLE-0R;
	Thu, 25 Jul 2024 18:16:16 +0000
Date: Fri, 26 Jul 2024 02:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: Kinsey Ho <kinseyho@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kinsey Ho <kinseyho@google.com>
Subject: Re: [PATCH mm-unstable v1 4/4] mm: clean up mem_cgroup_iter()
Message-ID: <202407260248.CBU1JMb1-lkp@intel.com>
References: <20240724190214.1108049-5-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724190214.1108049-5-kinseyho@google.com>

Hi Kinsey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.10 next-20240725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kinsey-Ho/mm-don-t-hold-css-refcnt-during-traversal/20240725-030750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240724190214.1108049-5-kinseyho%40google.com
patch subject: [PATCH mm-unstable v1 4/4] mm: clean up mem_cgroup_iter()
config: x86_64-randconfig-121-20240725 (https://download.01.org/0day-ci/archive/20240726/202407260248.CBU1JMb1-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240726/202407260248.CBU1JMb1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260248.CBU1JMb1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/memcontrol.c:1049:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mem_cgroup [noderef] __rcu *__old @@     got struct mem_cgroup *[assigned] pos @@
   mm/memcontrol.c:1049:21: sparse:     expected struct mem_cgroup [noderef] __rcu *__old
   mm/memcontrol.c:1049:21: sparse:     got struct mem_cgroup *[assigned] pos
>> mm/memcontrol.c:1049:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mem_cgroup [noderef] __rcu *__new @@     got struct mem_cgroup *[assigned] next @@
   mm/memcontrol.c:1049:21: sparse:     expected struct mem_cgroup [noderef] __rcu *__new
   mm/memcontrol.c:1049:21: sparse:     got struct mem_cgroup *[assigned] next
   mm/memcontrol.c:1049:57: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:1049:57: sparse:    struct mem_cgroup [noderef] __rcu *
   mm/memcontrol.c:1049:57: sparse:    struct mem_cgroup *
   mm/memcontrol.c:1101:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mem_cgroup [noderef] __rcu *__old @@     got struct mem_cgroup *dead_memcg @@
   mm/memcontrol.c:1101:17: sparse:     expected struct mem_cgroup [noderef] __rcu *__old
   mm/memcontrol.c:1101:17: sparse:     got struct mem_cgroup *dead_memcg
   mm/memcontrol.c: note: in included file (through include/linux/cgroup-defs.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   mm/memcontrol.c: note: in included file:
   include/linux/memcontrol.h:747:9: sparse: sparse: context imbalance in 'folio_lruvec_lock' - wrong count at exit
   include/linux/memcontrol.h:747:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irq' - wrong count at exit
   include/linux/memcontrol.h:747:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irqsave' - wrong count at exit
   mm/memcontrol.c: note: in included file (through include/linux/cgroup-defs.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +1049 mm/memcontrol.c

   974	
   975	/**
   976	 * mem_cgroup_iter - iterate over memory cgroup hierarchy
   977	 * @root: hierarchy root
   978	 * @prev: previously returned memcg, NULL on first invocation
   979	 * @reclaim: cookie for shared reclaim walks, NULL for full walks
   980	 *
   981	 * Returns references to children of the hierarchy below @root, or
   982	 * @root itself, or %NULL after a full round-trip.
   983	 *
   984	 * Caller must pass the return value in @prev on subsequent
   985	 * invocations for reference counting, or use mem_cgroup_iter_break()
   986	 * to cancel a hierarchy walk before the round-trip is complete.
   987	 *
   988	 * Reclaimers can specify a node in @reclaim to divide up the memcgs
   989	 * in the hierarchy among all concurrent reclaimers operating on the
   990	 * same node.
   991	 */
   992	struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
   993					   struct mem_cgroup *prev,
   994					   struct mem_cgroup_reclaim_cookie *reclaim)
   995	{
   996		struct mem_cgroup_reclaim_iter *iter;
   997		struct cgroup_subsys_state *css;
   998		struct mem_cgroup *pos;
   999		struct mem_cgroup *next = NULL;
  1000	
  1001		if (mem_cgroup_disabled())
  1002			return NULL;
  1003	
  1004		if (!root)
  1005			root = root_mem_cgroup;
  1006	
  1007		rcu_read_lock();
  1008	restart:
  1009		if (reclaim) {
  1010			int gen;
  1011			int nid = reclaim->pgdat->node_id;
  1012	
  1013			iter = &root->nodeinfo[nid]->iter;
  1014			gen = atomic_read(&iter->generation);
  1015	
  1016			/*
  1017			 * On start, join the current reclaim iteration cycle.
  1018			 * Exit when a concurrent walker completes it.
  1019			 */
  1020			if (!prev)
  1021				reclaim->generation = gen;
  1022			else if (reclaim->generation != gen)
  1023				goto out_unlock;
  1024	
  1025			pos = rcu_dereference(iter->position);
  1026		} else
  1027			pos = prev;
  1028	
  1029		css = pos ? &pos->css : NULL;
  1030	
  1031		while ((css = css_next_descendant_pre(css, &root->css))) {
  1032			/*
  1033			 * Verify the css and acquire a reference.  The root
  1034			 * is provided by the caller, so we know it's alive
  1035			 * and kicking, and don't take an extra reference.
  1036			 */
  1037			if (css == &root->css || css_tryget(css))
  1038				break;
  1039		}
  1040	
  1041		next = mem_cgroup_from_css(css);
  1042	
  1043		if (reclaim) {
  1044			/*
  1045			 * The position could have already been updated by a competing
  1046			 * thread, so check that the value hasn't changed since we read
  1047			 * it to avoid reclaiming from the same cgroup twice.
  1048			 */
> 1049			if (cmpxchg(&iter->position, pos, next) != pos) {
  1050				if (css && css != &root->css)
  1051					css_put(css);
  1052				goto restart;
  1053			}
  1054	
  1055			if (!next) {
  1056				atomic_inc(&iter->generation);
  1057	
  1058				/*
  1059				 * Reclaimers share the hierarchy walk, and a
  1060				 * new one might jump in right at the end of
  1061				 * the hierarchy - make sure they see at least
  1062				 * one group and restart from the beginning.
  1063				 */
  1064				if (!prev)
  1065					goto restart;
  1066			}
  1067		}
  1068	
  1069	out_unlock:
  1070		rcu_read_unlock();
  1071		if (prev && prev != root)
  1072			css_put(&prev->css);
  1073	
  1074		return next;
  1075	}
  1076	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

