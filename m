Return-Path: <linux-kernel+bounces-403591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E6D9C379F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A291C21066
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BD145A07;
	Mon, 11 Nov 2024 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0ZOjaLI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FC36B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731300648; cv=none; b=dNK5ZqFNKzUmr7pODZ5UZAJln0xLkTve2VNoJevZA8CC97hnZYOLeM5SS4O5tbRb3Dre88gEMrM7aSQbsGt+UkB1utty+VWAwNGib3445RMWBjblbIzeiqfpJNEVm6WadFFyaq/3+vr5alM6npioToxlyv9JL7YRKhwMoNSYK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731300648; c=relaxed/simple;
	bh=RuazcIG+VDnyhGSj6Tb+4qNdqW9iMNJuooSwyNQQ2WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKAnbaCsgTA7QyaksIQ94o/eVlXjVzbA2cohkoeeDyTaUvsYsJ0Cq6L/KnZVD4ZJPLu+RwhuBnlMn0iRDrdTsrpmy045v4rdxbeUAvS+yNxfMLskWzHt8/BT+wHkaAZ9f6cNf0hPfYypEB6RGTx2NEr9wgCjTD7vxTHJjWDa9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0ZOjaLI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731300646; x=1762836646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RuazcIG+VDnyhGSj6Tb+4qNdqW9iMNJuooSwyNQQ2WU=;
  b=W0ZOjaLIMdzDxms+TUDV/FCremlyjTjhBnng8ngSzkB4LEanfq7BAEoj
   TBzKfFMNTJPm4ZvHA7aE/YxY0P7q/Ih4OQ9RpyGH5rBZRJuIiGjm1Mlt6
   eWT0SbyvW6gmBFuhjeOAIeskiGpr4cKHIxWEOAP788SFj5b/5qk65c/9b
   jwChOf6vGdvTaEmaP73I4Ymsm1AwK9fAIaK+4RpC8FsFiqZGwRFvjcEeR
   xYMKHmH/C+PbIu4muWDIIqhascN4fUbvMHqrr6ViOtUHfn8XHwm0sDl69
   TMbDSt+eec2tx+OR/ckTDr2p2MURhfkbp7CTr9i0q+fhkuFt9D5CL9r1L
   A==;
X-CSE-ConnectionGUID: KqimAA4iRrOkTo+PMZ5jQw==
X-CSE-MsgGUID: +2DPdrzwS32J8D1osM7RQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31056976"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31056976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 20:50:46 -0800
X-CSE-ConnectionGUID: 1bGUFPnhSq+CpdOqFcRtCw==
X-CSE-MsgGUID: cV/dLXKZSeqBYbj9LS4nMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117545126"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Nov 2024 20:50:43 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAMNs-0000iC-1U;
	Mon, 11 Nov 2024 04:50:40 +0000
Date: Mon, 11 Nov 2024 12:49:55 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
Message-ID: <202411111204.JebDWFvY-lkp@intel.com>
References: <20241108222406.n5azgO98@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108222406.n5azgO98@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.12-rc7 next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/kernfs-Use-RCU-for-kernfs_node-name-lookup/20241109-062450
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20241108222406.n5azgO98%40linutronix.de
patch subject: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
config: x86_64-randconfig-122-20241111 (https://download.01.org/0day-ci/archive/20241111/202411111204.JebDWFvY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241111/202411111204.JebDWFvY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411111204.JebDWFvY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/sysfs/dir.c:126:51: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *new_name @@     got char const [noderef] __rcu *name @@
   fs/sysfs/dir.c:126:51: sparse:     expected char const *new_name
   fs/sysfs/dir.c:126:51: sparse:     got char const [noderef] __rcu *name
--
>> arch/x86/kernel/cpu/resctrl/pseudo_lock.c:1363:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *name @@     got char const [noderef] __rcu *name @@
   arch/x86/kernel/cpu/resctrl/pseudo_lock.c:1363:65: sparse:     expected char const *name
   arch/x86/kernel/cpu/resctrl/pseudo_lock.c:1363:65: sparse:     got char const [noderef] __rcu *name
   arch/x86/kernel/cpu/resctrl/pseudo_lock.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
--
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:3654:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char const [noderef] __rcu *name @@
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3654:27: sparse:     expected char const *
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3654:27: sparse:     got char const [noderef] __rcu *name
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:3793:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const *name @@     got char const [noderef] __rcu *name @@
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3793:45: sparse:     expected char const *name
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3793:45: sparse:     got char const [noderef] __rcu *name
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3879:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const *name @@     got char const [noderef] __rcu *name @@
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3879:42: sparse:     expected char const *name
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:3879:42: sparse:     got char const [noderef] __rcu *name
   arch/x86/kernel/cpu/resctrl/rdtgroup.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +126 fs/sysfs/dir.c

ca1bab38195d66 Eric W. Biederman 2009-11-20  116  
e34ff4906199d2 Tejun Heo         2013-09-11  117  int sysfs_move_dir_ns(struct kobject *kobj, struct kobject *new_parent_kobj,
e34ff4906199d2 Tejun Heo         2013-09-11  118  		      const void *new_ns)
8a82472f86bf69 Cornelia Huck     2006-11-20  119  {
324a56e16e44ba Tejun Heo         2013-12-11  120  	struct kernfs_node *kn = kobj->sd;
324a56e16e44ba Tejun Heo         2013-12-11  121  	struct kernfs_node *new_parent;
8a82472f86bf69 Cornelia Huck     2006-11-20  122  
324a56e16e44ba Tejun Heo         2013-12-11  123  	new_parent = new_parent_kobj && new_parent_kobj->sd ?
324a56e16e44ba Tejun Heo         2013-12-11  124  		new_parent_kobj->sd : sysfs_root_kn;
51225039f3cf9d Tejun Heo         2007-06-14  125  
adc5e8b58f4886 Tejun Heo         2013-12-11 @126  	return kernfs_rename_ns(kn, new_parent, kn->name, new_ns);
8a82472f86bf69 Cornelia Huck     2006-11-20  127  }
87d2846fcf8811 Eric W. Biederman 2015-05-13  128  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

