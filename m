Return-Path: <linux-kernel+bounces-254411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE39332EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158BE1C22DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1081A01DB;
	Tue, 16 Jul 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwNj2cmY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F719E7D0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161521; cv=none; b=jIMcfE7BFp2zKcNp1yBVEaNH4bRH9npY506z5+IYrK2aa4CX+Mt/qbV6n9ZWPvh32TBJcBi69xn+YcEvCUSr30rwEKi7NBID2g7Ysg7x0fSQvhv0Tg4el5jd1F/t9Wn4wOPjK+tooiOFLKB6TpzWmIUgdnbM3d5lv5svrpy60Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161521; c=relaxed/simple;
	bh=QpaZz6ytjX6EJQg4Em95+XJTsWe3wnfYygOTIZxYC4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNatB0kdP78/lIIvCyNCAC7O4af2pB9Y9BVXc0k0VWlfF9jz4C0AFFRIBnBA3Bra+qJ6AZ6HsOA666cDq7MGo6BwuhWL6pscSfYLQcL3pUncEhVBlq7Dkru7BsmfZV25tUtk2ekD+uFXsuhCn3ui9Gf+FXGmOFiCBUNLrTo1rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwNj2cmY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721161519; x=1752697519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QpaZz6ytjX6EJQg4Em95+XJTsWe3wnfYygOTIZxYC4E=;
  b=SwNj2cmYsYycPA9RD9u61ta83qGePpZ6IqjoLtzMYUcYutuLI9l6emjP
   B1m1D6FqSzZU7ki1hQ8KI2Lqefes3P0eh0+nkZ8VofbDTOXRCBMyyXkdB
   C+IavF9qXGQJ4nVGNcF2nZEBezk6OKrEVVingwTcg2ZSbaNhx1A+VCGzs
   HcO6mghVG9phy+56mewi+RjSVg6YVBC7sWR/Vl9lWB/bh9rD6lFDxDgXH
   dKM34CdS65iXtG/u6ra68JZmSdbuvrfD7n51WlJY2JNoZVQlSwMZY0A5/
   8VDwU7lXFrvwa+VDiRGnURP+FXzZeH/zU1yOMp9st5VINXAJ2lzg+sWv0
   Q==;
X-CSE-ConnectionGUID: R8MlY2eBSCm29HmKxgHBpw==
X-CSE-MsgGUID: bU0lkYDGTvqp7KBRVhY1gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18497097"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="18497097"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 13:25:18 -0700
X-CSE-ConnectionGUID: QZuiX99WQlmZj1oBFGcykQ==
X-CSE-MsgGUID: H9whyyPCQ+aeZmGf/ARFtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="50209182"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jul 2024 13:25:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTojZ-000fdw-17;
	Tue, 16 Jul 2024 20:25:13 +0000
Date: Wed, 17 Jul 2024 04:24:21 +0800
From: kernel test robot <lkp@intel.com>
To: Xavier <xavier_qy@163.com>, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, oliver.sang@intel.com,
	Xavier <xavier_qy@163.com>
Subject: Re: [PATCH-RT sched v3 1/2] RT SCHED: Optimize the enqueue and
 dequeue operations for rt_se
Message-ID: <202407170411.vRtOCOzx-lkp@intel.com>
References: <20240716060514.304324-2-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716060514.304324-2-xavier_qy@163.com>

Hi Xavier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on shuah-kselftest/next shuah-kselftest/fixes peterz-queue/sched/core linus/master v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xavier/RT-SCHED-Optimize-the-enqueue-and-dequeue-operations-for-rt_se/20240716-140932
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240716060514.304324-2-xavier_qy%40163.com
patch subject: [PATCH-RT sched v3 1/2] RT SCHED: Optimize the enqueue and dequeue operations for rt_se
config: x86_64-randconfig-121-20240716 (https://download.01.org/0day-ci/archive/20240717/202407170411.vRtOCOzx-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240717/202407170411.vRtOCOzx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407170411.vRtOCOzx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/debug.c:469:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/debug.c:469:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/debug.c:469:17: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/debug.c:715:6: sparse: sparse: symbol 'print_rt_se' was not declared. Should it be static?
   kernel/sched/debug.c:842:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:842:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:842:9: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/debug.c:842:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:842:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:842:9: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/stats.c:148:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/stats.c:148:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/stats.c:148:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:107:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:107:56: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:107:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:126:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:126:60: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:126:60: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:149:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:149:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:149:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:454:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_domain *[assigned] tmp @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:454:13: sparse:     expected struct perf_domain *[assigned] tmp
   kernel/sched/topology.c:454:13: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:463:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_domain *[assigned] tmp @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:463:13: sparse:     expected struct perf_domain *[assigned] tmp
   kernel/sched/topology.c:463:13: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:484:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct perf_domain *[assigned] pd @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:484:19: sparse:     expected struct perf_domain *[assigned] pd
   kernel/sched/topology.c:484:19: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:646:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:646:49: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:646:49: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:731:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:731:50: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:731:50: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:739:55: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child @@     got struct sched_domain *[assigned] tmp @@
   kernel/sched/topology.c:739:55: sparse:     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child
   kernel/sched/topology.c:739:55: sparse:     got struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:752:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:752:29: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:752:29: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:757:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:757:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:757:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:778:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *sd @@
   kernel/sched/topology.c:778:13: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:778:13: sparse:     got struct sched_domain [noderef] __rcu *sd
   kernel/sched/topology.c:940:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:940:70: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:940:70: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:969:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:969:59: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:969:59: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1015:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1015:57: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1015:57: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1017:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1017:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1017:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1025:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1025:55: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1025:55: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1027:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1027:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1097:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1097:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1097:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1201:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1201:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1201:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1629:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1629:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1629:43: sparse:     got struct sched_domain *child
   kernel/sched/topology.c:2328:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2328:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2328:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2430:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2430:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2430:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2451:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2451:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2451:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:2450:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2450:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2450:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2505:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2505:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2505:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/core_sched.c:276:37: sparse: sparse: incompatible types in conditional expression (different address spaces):
   kernel/sched/core_sched.c:276:37: sparse:    struct task_struct *
   kernel/sched/core_sched.c:276:37: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/build_utility.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/sched/topology.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:2175:25: sparse: sparse: incompatible types in comparison expression (different address spaces):

vim +/print_rt_se +715 kernel/sched/debug.c

   714	
 > 715	void print_rt_se(struct seq_file *m, struct sched_rt_entity *rt_se)
   716	{
   717		struct task_struct *task;
   718	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

