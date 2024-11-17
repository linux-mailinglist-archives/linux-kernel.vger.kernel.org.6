Return-Path: <linux-kernel+bounces-411981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF29D01FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 04:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA1DB22F25
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248F11712;
	Sun, 17 Nov 2024 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FR/arTJ8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81ADDA9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731815330; cv=none; b=MuROWsBIanJ5S0KcQVNGi4eQGQhDFHpb87aXtrWz4I4AygOyyOMT2WPCbvUrrgq/DkiLFM/o1BK/P6r35NKgjXuhwuyjFV2Olduq1RMfLW4i+wq8izFH0zwLiDJwi0/hJAVS8odZPrpEk6t1u+Ar9zQ34YixieXehIVl8tQShAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731815330; c=relaxed/simple;
	bh=SU4ZxkobQzJFaYo6lLfeiNErr6NI3r+NOqva1u4xrZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuxTkq5dK+XXSdTJGOqaIQz1pLa3XMi+xtxB8oWk8jGdhlqWFZmETsYLkksYAXmwwr7qgsikGG54ljXOJ7hny43mL2Z4Cz42wvX5nIYUh4VY0g2zQZOxDnJQPPPpx2p4406Aemdv/SophVNWtbkEOtG/GAyOg+NENpTnzGbpEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FR/arTJ8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731815329; x=1763351329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SU4ZxkobQzJFaYo6lLfeiNErr6NI3r+NOqva1u4xrZ8=;
  b=FR/arTJ8nz28KBsAQ5V9sTgvKwqa6ACBJzmdJmzam5Lo9Av7ZdV72yUG
   A41sJ764oZDJq22sDDczJFoXawY6iZZ1a30ol9tf9e8zZa6ybsObDJIJ5
   OEo2QbAHVlIvjS2NIhLbjq0tIDHiu/iPMc9TNftt0fGV+D6ou3fBtaV+c
   ZcrERDRHvwGfCekUzRgPKT6XFf0hLwqpT/9JQnd4fXq1LU0OLMFIZYP3J
   5mOQX0B4L9q8DyCgpdqTk2P05aRheV1waK5OZuuXZJGJ0Wr3HLfCBaVNg
   IEy6akbAUc6uj9N9pK7b3m67dgHQT63VvdiQbg2t96/ePeX+DEQVwHffe
   Q==;
X-CSE-ConnectionGUID: j4iaNv1lShmyClgEWyFAdw==
X-CSE-MsgGUID: mIL6lrg8RXqGxHMolyLgDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="35466405"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="35466405"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 19:48:48 -0800
X-CSE-ConnectionGUID: VuS+mxuWT86DTBpM0pcc2A==
X-CSE-MsgGUID: h2jnVQGwSji8O1nIwLxjMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88906967"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Nov 2024 19:48:44 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCWHB-0001N7-2n;
	Sun, 17 Nov 2024 03:48:41 +0000
Date: Sun, 17 Nov 2024 11:48:06 +0800
From: kernel test robot <lkp@intel.com>
To: Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au,
	maddy@linux.ibm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com,
	gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/perf: Add perf interface to expose vpa
 counters
Message-ID: <202411171117.Eq9JtACb-lkp@intel.com>
References: <20241114084013.1140010-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114084013.1140010-1-kjain@linux.ibm.com>

Hi Kajol,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/topic/ppc-kvm]
[also build test WARNING on powerpc/next powerpc/fixes linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kajol-Jain/docs-ABI-sysfs-bus-event_source-devices-vpa-pmu-Document-sysfs-event-format-entries-for-vpa_pmu/20241114-164451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/ppc-kvm
patch link:    https://lore.kernel.org/r/20241114084013.1140010-1-kjain%40linux.ibm.com
patch subject: [PATCH 1/4] powerpc/perf: Add perf interface to expose vpa counters
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20241117/202411171117.Eq9JtACb-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171117.Eq9JtACb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171117.Eq9JtACb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/perf/vpa-pmu.c:10:
   In file included from include/linux/perf_event.h:50:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/perf/vpa-pmu.c:87:32: warning: overlapping comparisons always evaluate to false [-Wtautological-overlap-compare]
      87 |         if ((event->attr.config <= 0) && (event->attr.config > 3))
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   5 warnings generated.


vim +87 arch/powerpc/perf/vpa-pmu.c

    72	
    73	static int vpa_pmu_event_init(struct perf_event *event)
    74	{
    75		if (event->attr.type != event->pmu->type)
    76			return -ENOENT;
    77	
    78		/* it does not support event sampling mode */
    79		if (is_sampling_event(event))
    80			return -EOPNOTSUPP;
    81	
    82		/* no branch sampling */
    83		if (has_branch_stack(event))
    84			return -EOPNOTSUPP;
    85	
    86		/* Invalid event code */
  > 87		if ((event->attr.config <= 0) && (event->attr.config > 3))
    88			return -EINVAL;
    89	
    90		return 0;
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

