Return-Path: <linux-kernel+bounces-262445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5E93C734
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A35B1C2208C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35819DF41;
	Thu, 25 Jul 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hu91//dl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FB1D68F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925198; cv=none; b=W55di/IEASnCBJS1jexV1Lo+u+pgnl2hvKCDvMFdaKaO+t/TUagGEInWlZhNzcc/shSk2jfCL+Q/VH8sOKhDN+6N1E4fFE4k8aGeYXy35WwXKTEUY12qzrjXV47Fd4ewNYgJNezMqsFZwp6G7L1KzXYmgi+ejDBDuzC4Hs7h0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925198; c=relaxed/simple;
	bh=YhMeQKtI4fdRJzymCqk4WemjTuqWXinoOJd0rboLbzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb80l0A+iJOhScwch52mnkSHn3SiFcW87bZrYPaMWtL7RewBcG6CiohiGgNcrgZ956gM0xzK5sGWWHHYs6oiviBfkUS4WkhuPeO6dg0GXhVAFQWYYfSsnR5uST+rlMDL/tLa/pyeosHqOlrhphM5jo2dNmQbFOx1WTcfXvLS6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hu91//dl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721925196; x=1753461196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YhMeQKtI4fdRJzymCqk4WemjTuqWXinoOJd0rboLbzs=;
  b=hu91//dlx6pXl6JHJMEtwuxkCBL2HhYcGrnBU0EVvZrVUya3WyzP3nzz
   0m4ozIZeNAZbk0x4m00yRfiXjccRrvd8o5AMhnRamlHVLCFh31bRjRdf2
   adEC6Y04TeKuDwtV5ru3Xnb1bzLlMrWBgzHLdkbOkD53DKirmiLcDxUDR
   1RCN3HBKdqW8yLnwPkPZGar7OTaQtochiPhepqb/hpFx8Pmcr97++WNce
   iD7cOgbx3JdFvtvl/sx+t7zEZAL5PDDOqBynK0BS+vqlotaAGpYxhhKqE
   ogQXUUtx5K8kfW85CJnj7uNoIDWxkpvuWRdO2ar3yn+XRnp8LFshuhTia
   w==;
X-CSE-ConnectionGUID: Yx7z1AU2TTqfVnIYh4AZMg==
X-CSE-MsgGUID: Us/+QmA6SXuqd8PxwDWNRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="12712878"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="12712878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 09:33:15 -0700
X-CSE-ConnectionGUID: SZH6upjTT3aAZB/FqqgIuw==
X-CSE-MsgGUID: KyVL0BCjT6Ox5BffK9Axsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52907637"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Jul 2024 09:33:13 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX1Ox-000oGq-04;
	Thu, 25 Jul 2024 16:33:11 +0000
Date: Fri, 26 Jul 2024 00:33:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kinsey Ho <kinseyho@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kinsey Ho <kinseyho@google.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during
 traversal
Message-ID: <202407260047.sIuRFLJE-lkp@intel.com>
References: <20240724190214.1108049-2-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724190214.1108049-2-kinseyho@google.com>

Hi Kinsey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.10 next-20240725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kinsey-Ho/mm-don-t-hold-css-refcnt-during-traversal/20240725-030750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240724190214.1108049-2-kinseyho%40google.com
patch subject: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during traversal
config: x86_64-randconfig-121-20240725 (https://download.01.org/0day-ci/archive/20240726/202407260047.sIuRFLJE-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240726/202407260047.sIuRFLJE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260047.sIuRFLJE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/memcontrol.c:1063:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mem_cgroup [noderef] __rcu *__old @@     got struct mem_cgroup *[assigned] pos @@
   mm/memcontrol.c:1063:23: sparse:     expected struct mem_cgroup [noderef] __rcu *__old
   mm/memcontrol.c:1063:23: sparse:     got struct mem_cgroup *[assigned] pos
   mm/memcontrol.c:1063:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mem_cgroup [noderef] __rcu *__new @@     got struct mem_cgroup *[assigned] memcg @@
   mm/memcontrol.c:1063:23: sparse:     expected struct mem_cgroup [noderef] __rcu *__new
   mm/memcontrol.c:1063:23: sparse:     got struct mem_cgroup *[assigned] memcg
>> mm/memcontrol.c:1101:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mem_cgroup [noderef] __rcu *__old @@     got struct mem_cgroup *dead_memcg @@
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

vim +1063 mm/memcontrol.c

4b569387c0d566 Nhat Pham         2023-10-06   974  
5660048ccac873 Johannes Weiner   2012-01-12   975  /**
5660048ccac873 Johannes Weiner   2012-01-12   976   * mem_cgroup_iter - iterate over memory cgroup hierarchy
5660048ccac873 Johannes Weiner   2012-01-12   977   * @root: hierarchy root
5660048ccac873 Johannes Weiner   2012-01-12   978   * @prev: previously returned memcg, NULL on first invocation
5660048ccac873 Johannes Weiner   2012-01-12   979   * @reclaim: cookie for shared reclaim walks, NULL for full walks
5660048ccac873 Johannes Weiner   2012-01-12   980   *
5660048ccac873 Johannes Weiner   2012-01-12   981   * Returns references to children of the hierarchy below @root, or
5660048ccac873 Johannes Weiner   2012-01-12   982   * @root itself, or %NULL after a full round-trip.
5660048ccac873 Johannes Weiner   2012-01-12   983   *
5660048ccac873 Johannes Weiner   2012-01-12   984   * Caller must pass the return value in @prev on subsequent
5660048ccac873 Johannes Weiner   2012-01-12   985   * invocations for reference counting, or use mem_cgroup_iter_break()
5660048ccac873 Johannes Weiner   2012-01-12   986   * to cancel a hierarchy walk before the round-trip is complete.
5660048ccac873 Johannes Weiner   2012-01-12   987   *
05bdc520b3ad39 Miaohe Lin        2020-10-13   988   * Reclaimers can specify a node in @reclaim to divide up the memcgs
05bdc520b3ad39 Miaohe Lin        2020-10-13   989   * in the hierarchy among all concurrent reclaimers operating on the
05bdc520b3ad39 Miaohe Lin        2020-10-13   990   * same node.
5660048ccac873 Johannes Weiner   2012-01-12   991   */
694fbc0fe78518 Andrew Morton     2013-09-24   992  struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
9f3a0d0933de07 Johannes Weiner   2012-01-12   993  				   struct mem_cgroup *prev,
694fbc0fe78518 Andrew Morton     2013-09-24   994  				   struct mem_cgroup_reclaim_cookie *reclaim)
7d74b06f240f1b KAMEZAWA Hiroyuki 2010-10-27   995  {
3f649ab728cda8 Kees Cook         2020-06-03   996  	struct mem_cgroup_reclaim_iter *iter;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10   997  	struct cgroup_subsys_state *css = NULL;
9f3a0d0933de07 Johannes Weiner   2012-01-12   998  	struct mem_cgroup *memcg = NULL;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10   999  	struct mem_cgroup *pos = NULL;
711d3d2c9bc3fb KAMEZAWA Hiroyuki 2010-10-27  1000  
694fbc0fe78518 Andrew Morton     2013-09-24  1001  	if (mem_cgroup_disabled())
694fbc0fe78518 Andrew Morton     2013-09-24  1002  		return NULL;
5660048ccac873 Johannes Weiner   2012-01-12  1003  
9f3a0d0933de07 Johannes Weiner   2012-01-12  1004  	if (!root)
9f3a0d0933de07 Johannes Weiner   2012-01-12  1005  		root = root_mem_cgroup;
9f3a0d0933de07 Johannes Weiner   2012-01-12  1006  
542f85f9ae4acd Michal Hocko      2013-04-29  1007  	rcu_read_lock();
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1008  
527a5ec9a53471 Johannes Weiner   2012-01-12  1009  	if (reclaim) {
ef8f2327996b5c Mel Gorman        2016-07-28  1010  		struct mem_cgroup_per_node *mz;
527a5ec9a53471 Johannes Weiner   2012-01-12  1011  
a3747b53b1771a Johannes Weiner   2021-04-29  1012  		mz = root->nodeinfo[reclaim->pgdat->node_id];
9da83f3fc74b80 Yafang Shao       2019-11-30  1013  		iter = &mz->iter;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1014  
a9320aae68a1cd Wei Yang          2022-04-28  1015  		/*
a9320aae68a1cd Wei Yang          2022-04-28  1016  		 * On start, join the current reclaim iteration cycle.
a9320aae68a1cd Wei Yang          2022-04-28  1017  		 * Exit when a concurrent walker completes it.
a9320aae68a1cd Wei Yang          2022-04-28  1018  		 */
a9320aae68a1cd Wei Yang          2022-04-28  1019  		if (!prev)
a9320aae68a1cd Wei Yang          2022-04-28  1020  			reclaim->generation = iter->generation;
a9320aae68a1cd Wei Yang          2022-04-28  1021  		else if (reclaim->generation != iter->generation)
542f85f9ae4acd Michal Hocko      2013-04-29  1022  			goto out_unlock;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1023  
fe6faac115aa89 Kinsey Ho         2024-07-24  1024  		pos = rcu_dereference(iter->position);
89d8330ccf2ad4 Wei Yang          2022-04-28  1025  	} else if (prev) {
89d8330ccf2ad4 Wei Yang          2022-04-28  1026  		pos = prev;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1027  	}
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1028  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1029  	if (pos)
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1030  		css = &pos->css;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1031  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1032  	for (;;) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1033  		css = css_next_descendant_pre(css, &root->css);
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1034  		if (!css) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1035  			/*
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1036  			 * Reclaimers share the hierarchy walk, and a
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1037  			 * new one might jump in right at the end of
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1038  			 * the hierarchy - make sure they see at least
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1039  			 * one group and restart from the beginning.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1040  			 */
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1041  			if (!prev)
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1042  				continue;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1043  			break;
542f85f9ae4acd Michal Hocko      2013-04-29  1044  		}
5f578161971863 Michal Hocko      2013-04-29  1045  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1046  		/*
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1047  		 * Verify the css and acquire a reference.  The root
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1048  		 * is provided by the caller, so we know it's alive
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1049  		 * and kicking, and don't take an extra reference.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1050  		 */
41555dadbff8d2 Wei Yang          2022-04-28  1051  		if (css == &root->css || css_tryget(css)) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1052  			memcg = mem_cgroup_from_css(css);
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1053  			break;
41555dadbff8d2 Wei Yang          2022-04-28  1054  		}
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1055  	}
9f3a0d0933de07 Johannes Weiner   2012-01-12  1056  
527a5ec9a53471 Johannes Weiner   2012-01-12  1057  	if (reclaim) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1058  		/*
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1059  		 * The position could have already been updated by a competing
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1060  		 * thread, so check that the value hasn't changed since we read
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1061  		 * it to avoid reclaiming from the same cgroup twice.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1062  		 */
6df38689e0e9a0 Vladimir Davydov  2015-12-29 @1063  		(void)cmpxchg(&iter->position, pos, memcg);
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1064  
19f39402864ea3 Michal Hocko      2013-04-29  1065  		if (!memcg)
527a5ec9a53471 Johannes Weiner   2012-01-12  1066  			iter->generation++;
527a5ec9a53471 Johannes Weiner   2012-01-12  1067  	}
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1068  
542f85f9ae4acd Michal Hocko      2013-04-29  1069  out_unlock:
542f85f9ae4acd Michal Hocko      2013-04-29  1070  	rcu_read_unlock();
c40046f3ad5e87 Michal Hocko      2013-04-29  1071  	if (prev && prev != root)
c40046f3ad5e87 Michal Hocko      2013-04-29  1072  		css_put(&prev->css);
c40046f3ad5e87 Michal Hocko      2013-04-29  1073  
9f3a0d0933de07 Johannes Weiner   2012-01-12  1074  	return memcg;
9f3a0d0933de07 Johannes Weiner   2012-01-12  1075  }
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1076  
5660048ccac873 Johannes Weiner   2012-01-12  1077  /**
5660048ccac873 Johannes Weiner   2012-01-12  1078   * mem_cgroup_iter_break - abort a hierarchy walk prematurely
5660048ccac873 Johannes Weiner   2012-01-12  1079   * @root: hierarchy root
5660048ccac873 Johannes Weiner   2012-01-12  1080   * @prev: last visited hierarchy member as returned by mem_cgroup_iter()
5660048ccac873 Johannes Weiner   2012-01-12  1081   */
5660048ccac873 Johannes Weiner   2012-01-12  1082  void mem_cgroup_iter_break(struct mem_cgroup *root,
9f3a0d0933de07 Johannes Weiner   2012-01-12  1083  			   struct mem_cgroup *prev)
9f3a0d0933de07 Johannes Weiner   2012-01-12  1084  {
711d3d2c9bc3fb KAMEZAWA Hiroyuki 2010-10-27  1085  	if (!root)
711d3d2c9bc3fb KAMEZAWA Hiroyuki 2010-10-27  1086  		root = root_mem_cgroup;
9f3a0d0933de07 Johannes Weiner   2012-01-12  1087  	if (prev && prev != root)
9f3a0d0933de07 Johannes Weiner   2012-01-12  1088  		css_put(&prev->css);
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1089  }
9f3a0d0933de07 Johannes Weiner   2012-01-12  1090  
54a83d6bcbf8f4 Miles Chen        2019-08-13  1091  static void __invalidate_reclaim_iterators(struct mem_cgroup *from,
54a83d6bcbf8f4 Miles Chen        2019-08-13  1092  					struct mem_cgroup *dead_memcg)
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1093  {
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1094  	struct mem_cgroup_reclaim_iter *iter;
ef8f2327996b5c Mel Gorman        2016-07-28  1095  	struct mem_cgroup_per_node *mz;
ef8f2327996b5c Mel Gorman        2016-07-28  1096  	int nid;
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1097  
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1098  	for_each_node(nid) {
a3747b53b1771a Johannes Weiner   2021-04-29  1099  		mz = from->nodeinfo[nid];
9da83f3fc74b80 Yafang Shao       2019-11-30  1100  		iter = &mz->iter;
9da83f3fc74b80 Yafang Shao       2019-11-30 @1101  		cmpxchg(&iter->position, dead_memcg, NULL);
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1102  	}
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1103  }
54a83d6bcbf8f4 Miles Chen        2019-08-13  1104  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

