Return-Path: <linux-kernel+bounces-382709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EEC9B1283
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5DB22A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CA1C878B;
	Fri, 25 Oct 2024 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPTAydZB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3220C333
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894779; cv=none; b=h7qUfdh4O03jpUS2kB5ZtJQzf5Mz97Zrt5qLQXpuFjlW01bX03lCN6RxAvMU3H0mmSx23/0jgGnI0n4LsXHbS2dONBHgGUdyYH2xFiqUtdzRWK3MxJUEcOiTpA3X64xybA18OOCQxmeUfV7sYggV6Z2mFXOeu/GVR5gh00DDhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894779; c=relaxed/simple;
	bh=0/459/syNSQRNBZgjUqEy7WtBIAbvR/sS0pAvu33TJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K98xpZ9CB/y7pB0j4cKH2mqRqjWrIIjI2FLuuYjrwLWj7kDF3P7NkJj5M7cfDfzrS+WpATyUvhsW6mgAEXSHf8O39NNgw3ao1z7p51luzW5jDoQoCb95Ieol7UR4wu57pedmWNEIaIzDFd32e3YRJVq22kL/m2N4MYBiTbleKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPTAydZB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729894777; x=1761430777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/459/syNSQRNBZgjUqEy7WtBIAbvR/sS0pAvu33TJA=;
  b=JPTAydZBsOY6EMHlRiUt/8Jo4hW8OYskvse9MqHmN+sSXA47FFRpgSFQ
   yHPVfgmvOmRtXT1BvMzFa6M7pbMR53pSxdpP+rZjXyFyRuducavjFIjYJ
   cFVx1HoWyPEt0Dxq3KnfMRS6YtSttaPyWEgOzYbCqAyzeauw9tWT1/FAJ
   zybefJDXqEf1SrbBNm/Bld4lMw6rtkhLaSH72qExTFFyH1wUgGZwmXZT4
   Pik9VK8YqwCweOL7aUrrP2v/7zRhnmXiHtG3fvFeBOhamhWebAEmsD0ts
   2eR1kTDEXfJDLKSVJlhYBryd+3QXnUjsrNuV28zxj3JctWOzzicbSmKjF
   w==;
X-CSE-ConnectionGUID: gAHbsO7HTFmuoAEwrHdFhA==
X-CSE-MsgGUID: SEF477fQR56nZZkqQ9ihdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40967555"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40967555"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:19:36 -0700
X-CSE-ConnectionGUID: WwN45uqAQmeE6oZOF6gk7g==
X-CSE-MsgGUID: umcbQBlpR9m5MlOgF0AitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85650534"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2024 15:19:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4SeY-000YyI-1h;
	Fri, 25 Oct 2024 22:19:30 +0000
Date: Sat, 26 Oct 2024 06:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Xi <xiqi2@huawei.com>, kernel@openeuler.org,
	bobo.shaobowang@huawei.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, patrick.bellasi@arm.com,
	mkoutny@suse.com, tj@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix compile warning about variable 'uclamp_mutex'
Message-ID: <202410260638.VpY4j0AB-lkp@intel.com>
References: <20241025034740.546570-1-xiqi2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025034740.546570-1-xiqi2@huawei.com>

Hi Qi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Xi/sched-Fix-compile-warning-about-variable-uclamp_mutex/20241025-115315
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20241025034740.546570-1-xiqi2%40huawei.com
patch subject: [PATCH] sched: Fix compile warning about variable 'uclamp_mutex'
config: i386-randconfig-053-20241026 (https://download.01.org/0day-ci/archive/20241026/202410260638.VpY4j0AB-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260638.VpY4j0AB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260638.VpY4j0AB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/sched/core.c:1865:16: error: use of undeclared identifier 'uclamp_mutex'; did you mean 'uclamp_none'?
    1865 |         guard(mutex)(&uclamp_mutex);
         |                       ^~~~~~~~~~~~
         |                       uclamp_none
   kernel/sched/sched.h:3377:28: note: 'uclamp_none' declared here
    3377 | static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
         |                            ^
   1 warning and 1 error generated.


vim +1865 kernel/sched/core.c

494dcdf46e5cde YueHaibing        2022-04-27  1857  
78eb4ea25cd5fd Joel Granados     2024-07-24  1858  static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
32927393dc1ccd Christoph Hellwig 2020-04-24  1859  				void *buffer, size_t *lenp, loff_t *ppos)
e8f14172c6b11e Patrick Bellasi   2019-06-21  1860  {
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1861  	bool update_root_tg = false;
13685c4a08fca9 Qais Yousef       2020-07-16  1862  	int old_min, old_max, old_min_rt;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1863  	int result;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1864  
0f92cdf36f848f Peter Zijlstra    2023-08-01 @1865  	guard(mutex)(&uclamp_mutex);
0f92cdf36f848f Peter Zijlstra    2023-08-01  1866  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1867  	old_min = sysctl_sched_uclamp_util_min;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1868  	old_max = sysctl_sched_uclamp_util_max;
13685c4a08fca9 Qais Yousef       2020-07-16  1869  	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1870  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1871  	result = proc_dointvec(table, write, buffer, lenp, ppos);
e8f14172c6b11e Patrick Bellasi   2019-06-21  1872  	if (result)
e8f14172c6b11e Patrick Bellasi   2019-06-21  1873  		goto undo;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1874  	if (!write)
0f92cdf36f848f Peter Zijlstra    2023-08-01  1875  		return 0;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1876  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1877  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
13685c4a08fca9 Qais Yousef       2020-07-16  1878  	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE	||
13685c4a08fca9 Qais Yousef       2020-07-16  1879  	    sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
13685c4a08fca9 Qais Yousef       2020-07-16  1880  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1881  		result = -EINVAL;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1882  		goto undo;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1883  	}
e8f14172c6b11e Patrick Bellasi   2019-06-21  1884  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1885  	if (old_min != sysctl_sched_uclamp_util_min) {
e8f14172c6b11e Patrick Bellasi   2019-06-21  1886  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
a509a7cd797470 Patrick Bellasi   2019-06-21  1887  			      sysctl_sched_uclamp_util_min, false);
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1888  		update_root_tg = true;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1889  	}
e8f14172c6b11e Patrick Bellasi   2019-06-21  1890  	if (old_max != sysctl_sched_uclamp_util_max) {
e8f14172c6b11e Patrick Bellasi   2019-06-21  1891  		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
a509a7cd797470 Patrick Bellasi   2019-06-21  1892  			      sysctl_sched_uclamp_util_max, false);
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1893  		update_root_tg = true;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1894  	}
e8f14172c6b11e Patrick Bellasi   2019-06-21  1895  
46609ce227039f Qais Yousef       2020-06-30  1896  	if (update_root_tg) {
46609ce227039f Qais Yousef       2020-06-30  1897  		static_branch_enable(&sched_uclamp_used);
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1898  		uclamp_update_root_tg();
46609ce227039f Qais Yousef       2020-06-30  1899  	}
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1900  
13685c4a08fca9 Qais Yousef       2020-07-16  1901  	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
13685c4a08fca9 Qais Yousef       2020-07-16  1902  		static_branch_enable(&sched_uclamp_used);
13685c4a08fca9 Qais Yousef       2020-07-16  1903  		uclamp_sync_util_min_rt_default();
13685c4a08fca9 Qais Yousef       2020-07-16  1904  	}
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1905  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1906  	/*
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1907  	 * We update all RUNNABLE tasks only when task groups are in use.
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1908  	 * Otherwise, keep it simple and do just a lazy update at each next
7274a5c1bbec45 Patrick Bellasi   2019-08-22  1909  	 * task enqueue time.
e8f14172c6b11e Patrick Bellasi   2019-06-21  1910  	 */
0f92cdf36f848f Peter Zijlstra    2023-08-01  1911  	return 0;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1912  
e8f14172c6b11e Patrick Bellasi   2019-06-21  1913  undo:
e8f14172c6b11e Patrick Bellasi   2019-06-21  1914  	sysctl_sched_uclamp_util_min = old_min;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1915  	sysctl_sched_uclamp_util_max = old_max;
13685c4a08fca9 Qais Yousef       2020-07-16  1916  	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1917  	return result;
e8f14172c6b11e Patrick Bellasi   2019-06-21  1918  }
494dcdf46e5cde YueHaibing        2022-04-27  1919  #endif
e8f14172c6b11e Patrick Bellasi   2019-06-21  1920  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

