Return-Path: <linux-kernel+bounces-332944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780397C123
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25582282D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642801CA69E;
	Wed, 18 Sep 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdElycyT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98014D6E6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693316; cv=none; b=XZr7YzTsE17D3rlXaMup6oMVPf6hEtyqWuhwbI/gURECGydOTMmWQ+i50AHZwN7Rvx9TcilqGG+7H5e9eeWcx4LiTSgTGZkNwkp7NCcPhrKp+5hTNCCVvvIFBaD2hJGpezIDsOJgM4iuvKyIzipfBfwA7vA2hFtpZ9aFvmhzdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693316; c=relaxed/simple;
	bh=mP0UQuMeE4aT8P8yDhPZX1+uNY2tnPXLkGTfwOMs9/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vaa4tFwNEJyLmmNBbQIotkY+j2aoOejNqQgeRkdjahmNfeQBn3OqMKJRqvXuyT9jrHPc3U9y/RSEb38DugBjvhxCBRcP05hcoXlO76Znj7rEB/q7W8zQeFqo3SCSACkpHUKby6ATlVvHEEnVbWASf6jlyJ6NDImRHpAkE2H3n+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdElycyT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726693315; x=1758229315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mP0UQuMeE4aT8P8yDhPZX1+uNY2tnPXLkGTfwOMs9/E=;
  b=VdElycyTsT5rCXLTATQNkiYzDU3UZyY2XezIPeECj3iE5qi4QALCtNjA
   gcUiq36f8cED7tt+vkkYbpCZoZMRCX0GwaplpuleBYPqz5lc8CKA0XXSD
   YRxsOpncsKVRNiGQ9Fo0izBGv/azDlLMMgQFJx2rX0VXQP/k+DDvVNzpT
   ngu4pOKWnXxvtta0qLPWKgyvCDvPzGGy2RERVED1aOND9m9sGzjiW7RPo
   TpEl03QC44dTAAngms2Vej7lgf267SegFgGFLNG9d+XfMA5RbRuwHVNlC
   Ut/ojVeZ3/kVk66y4fm3IzS80Mvm53clKdXl7RyfS3+/+qkPH2Oumie5w
   w==;
X-CSE-ConnectionGUID: H/12HPUAT/CzBAJa4DFCTg==
X-CSE-MsgGUID: NTfNwvdOR2iprRQp/OfoLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29370639"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="29370639"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 14:01:54 -0700
X-CSE-ConnectionGUID: UzXge7D0T6G3o7i4y9EBiQ==
X-CSE-MsgGUID: a02/E3R9RZO8fMfCrg/Qcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="70005166"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 14:01:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr1o5-000CdM-02;
	Wed, 18 Sep 2024 21:01:49 +0000
Date: Thu, 19 Sep 2024 05:01:27 +0800
From: kernel test robot <lkp@intel.com>
To: David Wang <00107082@163.com>, surenb@google.com,
	kent.overstreet@linux.dev, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH v2] lib/alloc_tag: Add accumulative call counter for
 memory allocation profiling
Message-ID: <202409190453.pe1HrGL0-lkp@intel.com>
References: <20240913055729.7208-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913055729.7208-1-00107082@163.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.11 next-20240918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wang/lib-alloc_tag-Add-accumulative-call-counter-for-memory-allocation-profiling/20240913-140040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240913055729.7208-1-00107082%40163.com
patch subject: [PATCH v2] lib/alloc_tag: Add accumulative call counter for memory allocation profiling
config: arm-randconfig-002-20240919 (https://download.01.org/0day-ci/archive/20240919/202409190453.pe1HrGL0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190453.pe1HrGL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409190453.pe1HrGL0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/hwtracing/coresight/coresight-tpiu.c:8:
   In file included from include/linux/acpi.h:13:
   In file included from include/linux/resource_ext.h:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:21:
   In file included from include/linux/percpu_counter.h:14:
   In file included from include/linux/percpu.h:5:
>> include/linux/alloc_tag.h:108:39: warning: missing field 'accu_calls' initializer [-Wmissing-field-initializers]
     108 |         struct alloc_tag_counters v = { 0, 0 };
         |                                              ^
   In file included from drivers/hwtracing/coresight/coresight-tpiu.c:9:
   In file included from include/linux/amba/bus.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   2 warnings generated.


vim +/accu_calls +108 include/linux/alloc_tag.h

22d407b164ff79 Suren Baghdasaryan 2024-03-21  105  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  106  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
22d407b164ff79 Suren Baghdasaryan 2024-03-21  107  {
22d407b164ff79 Suren Baghdasaryan 2024-03-21 @108  	struct alloc_tag_counters v = { 0, 0 };
38770cdc292e9e David Wang         2024-09-13  109  #ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
38770cdc292e9e David Wang         2024-09-13  110  	v.accu_calls = 0;
38770cdc292e9e David Wang         2024-09-13  111  #endif
22d407b164ff79 Suren Baghdasaryan 2024-03-21  112  	struct alloc_tag_counters *counter;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  113  	int cpu;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  114  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  115  	for_each_possible_cpu(cpu) {
22d407b164ff79 Suren Baghdasaryan 2024-03-21  116  		counter		= per_cpu_ptr(tag->counters, cpu);
22d407b164ff79 Suren Baghdasaryan 2024-03-21  117  		v.bytes		+= counter->bytes;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  118  		v.calls		+= counter->calls;
38770cdc292e9e David Wang         2024-09-13  119  #ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
38770cdc292e9e David Wang         2024-09-13  120  		v.accu_calls	+= counter->accu_calls;
38770cdc292e9e David Wang         2024-09-13  121  #endif
22d407b164ff79 Suren Baghdasaryan 2024-03-21  122  	}
22d407b164ff79 Suren Baghdasaryan 2024-03-21  123  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  124  	return v;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  125  }
22d407b164ff79 Suren Baghdasaryan 2024-03-21  126  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

