Return-Path: <linux-kernel+bounces-428757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC379E12FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C001629A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E1184523;
	Tue,  3 Dec 2024 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXtLLDPK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5916FF4E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204627; cv=none; b=JR+NdesA+KcfRN1k69QfDfuZ+lYOQARYgRtbe51w9ViIylrXIwBAlWdH4Oj4HMtnCOqlukDShICAhdvnb1qydGlWFvjAv+aOjZOCgWeHLaCmPkJsZ3Lmc126vVkkU4TJKvxPGRwSXK0NKyICjLxzio9MSzDyrlhFro2aR/+R+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204627; c=relaxed/simple;
	bh=TBaw6U370tnIdeZ/reivCRWw+2bV9ozrdLvqRIr9cjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzao5EhlTayrm5MajZTlpP6gQ+Jfo93ITCZFDhD2XLRHITGlG49/Qim+ScHcXy7YKJICWQO9BloXAHjruU9H8r5B9fpVEufrcjhUEOhcVXH9dZiq6Wx1csrJRHtSu9DgWNKg+v6lqoAuNQEdQcV+ESmaL1Z88EzbQeq7q9IOEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXtLLDPK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733204626; x=1764740626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TBaw6U370tnIdeZ/reivCRWw+2bV9ozrdLvqRIr9cjg=;
  b=JXtLLDPK0z0Qcy1cQtt8kL9zMwJCJiiUPrvJSPJR2jCpOandvLLfAnxg
   Ijh2Q7bpQy/gIRUj8ZF9caZQfezruDPE/xWMQPk7AZxzTs8jVYMvy1aLC
   I2kVQsLW+HifSaFO7Z7voj9ROEiYNqgJ3KFG9EIrNfTM8l7kQky4JeTFl
   GbsbomtBevYM4OP/ihk5kNru4skL9XysUTtzxTUoAASTePxfjy3DhJSsv
   eXt94fRHFOSoWoZZcWJkpTqUuvYLYvwHu+HK4TKZNkrH+1ahlbnmXDJ0r
   R12+7XjkBlI7YksUib3C0R9LsYJ/kimAvfY6rnrkoul/ZCn7DqYOsAGRK
   w==;
X-CSE-ConnectionGUID: UAiLJ+4FR0+H9JV4G/71AQ==
X-CSE-MsgGUID: +MWGg/hqRTi/mzXQTf0/nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44784705"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44784705"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 21:43:45 -0800
X-CSE-ConnectionGUID: HD/+TMo9Q0CBPjRWw7SDRg==
X-CSE-MsgGUID: yr15CWHsQU27wGKvnmVdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93789906"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Dec 2024 21:43:41 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tILhD-0000At-0S;
	Tue, 03 Dec 2024 05:43:39 +0000
Date: Tue, 3 Dec 2024 13:42:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
Message-ID: <202412031318.6qeKIH6u-lkp@intel.com>
References: <20241202184154.19321-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-2-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-memcontrol-avoid-duplicated-memcg-enable-check/20241203-024957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241202184154.19321-2-ryncsn%40gmail.com
patch subject: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
config: i386-buildonly-randconfig-003-20241203 (https://download.01.org/0day-ci/archive/20241203/202412031318.6qeKIH6u-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031318.6qeKIH6u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031318.6qeKIH6u-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/memcontrol.c:30:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/memcontrol.c:56:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/memcontrol.c:4618:3: error: call to undeclared function '__mem_cgroup_uncharge_swap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4618 |                 __mem_cgroup_uncharge_swap(entry, nr_pages);
         |                 ^
   mm/memcontrol.c:4618:3: note: did you mean 'mem_cgroup_uncharge_swap'?
   include/linux/swap.h:687:20: note: 'mem_cgroup_uncharge_swap' declared here
     687 | static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
         |                    ^
   3 warnings and 1 error generated.


vim +/__mem_cgroup_uncharge_swap +4618 mm/memcontrol.c

  4587	
  4588	/*
  4589	 * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
  4590	 * @entry: the first swap entry for which the pages are charged
  4591	 * @nr_pages: number of pages which will be uncharged
  4592	 *
  4593	 * Call this function after successfully adding the charged page to swapcache.
  4594	 *
  4595	 * Note: This function assumes the page for which swap slot is being uncharged
  4596	 * is order 0 page.
  4597	 */
  4598	void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
  4599	{
  4600		/*
  4601		 * Cgroup1's unified memory+swap counter has been charged with the
  4602		 * new swapcache page, finish the transfer by uncharging the swap
  4603		 * slot. The swap slot would also get uncharged when it dies, but
  4604		 * it can stick around indefinitely and we'd count the page twice
  4605		 * the entire time.
  4606		 *
  4607		 * Cgroup2 has separate resource counters for memory and swap,
  4608		 * so this is a non-issue here. Memory and swap charge lifetimes
  4609		 * correspond 1:1 to page and swap slot lifetimes: we charge the
  4610		 * page to memory here, and uncharge swap when the slot is freed.
  4611		 */
  4612		if (!mem_cgroup_disabled() && do_memsw_account()) {
  4613			/*
  4614			 * The swap entry might not get freed for a long time,
  4615			 * let's not wait for it.  The page already received a
  4616			 * memory+swap charge, drop the swap entry duplicate.
  4617			 */
> 4618			__mem_cgroup_uncharge_swap(entry, nr_pages);
  4619		}
  4620	}
  4621	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

