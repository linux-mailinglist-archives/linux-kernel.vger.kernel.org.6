Return-Path: <linux-kernel+bounces-335013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C887897DFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEF82818AA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8231917D4;
	Sun, 22 Sep 2024 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8aVp+mc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440A191496
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966997; cv=none; b=Ev7TuZWeLZSna/QjmbjR89ia+dbILQqoV6r2x6XvrDZpTBKni0UoSUOvZBB1D/65mNnuV0p4P4zGIkr4yc7kxCeGZ9GfjfyMTV9CVE1S0zb9S6egOTOtxsFg78go7s1HRXwevsy7Y2CIaQhc4h4ik/FmYhC01L3lKyu/Jwh+HFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966997; c=relaxed/simple;
	bh=H0IsrwFjVCT305wYMo1V/pgErnNTTuDG4Za4HOFuKe8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SSRenX5Q+Z+yKRMZpyMddHCgsC02Eoy+CWV6412GBSSv/B2B2A+dEf7xmZYoCCziaxppAG/LF1qfRoQCZJq5W0RomQnIG3t9gQHnGhq5xYERr7sec1lxi7/w0j1qdyFEsioqDb/nGvksPvQ4Vcfykq3GV1ZwusEybBXYgdnHf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8aVp+mc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726966996; x=1758502996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H0IsrwFjVCT305wYMo1V/pgErnNTTuDG4Za4HOFuKe8=;
  b=d8aVp+mcMEbjxjsyJr5HjQQgu0JyLABUjby+oxYnQtuJNZ87SU5i8M9T
   V348wnXKQSOQIDqyRLyo/NHIdHde9AQ13ZuATwGx4AdQGSdH7etI6iL8m
   DtHfAlQCdsBZTlYvWraGVZPOrT3UgZ3F7a5t3JL5LfMs0y4uWSn3n2Dz0
   cySc4gBW7v38J2HMsJbUG6iOmwYr5wuNyGwEGByVTP5I+Pv0V6OyD+wrG
   xg3kXHYry/W6oGrGayEAbr0wsWBObOHxmjC0anoI/qsmMay3nur+dQ1M9
   la08DpMGbpkvXNmrKVd+4Bct94lla7qEqWGPVqXhbKJlsagUeNT7mgE+G
   Q==;
X-CSE-ConnectionGUID: Q7fv2LIIQ0uBQJZ8PiJkvA==
X-CSE-MsgGUID: lWWdoCPLTcKwT5Kul76Qxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25459712"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="25459712"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 18:03:15 -0700
X-CSE-ConnectionGUID: qw0JEnpgREmt+qMStZ79Sg==
X-CSE-MsgGUID: vbq+IR0gSECzR1CS/YCZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70726277"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Sep 2024 18:03:11 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssB0G-000Fuo-1d;
	Sun, 22 Sep 2024 01:03:08 +0000
Date: Sun, 22 Sep 2024 09:02:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Vernet <dvernet@meta.com>
Subject: kernel/sched/ext.c:3701:16: error: 'struct task_group' has no member
 named 'idle'
Message-ID: <202409220859.UiCAoFOW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88264981f2082248e892a706b2c5004650faac54
commit: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support
date:   2 weeks ago
config: sparc-randconfig-002-20240922 (https://download.01.org/0day-ci/archive/20240922/202409220859.UiCAoFOW-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220859.UiCAoFOW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220859.UiCAoFOW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:63:
   kernel/sched/ext.c: In function 'scx_cgroup_warn_missing_idle':
>> kernel/sched/ext.c:3701:16: error: 'struct task_group' has no member named 'idle'
    3701 |         if (!tg->idle)
         |                ^~
   kernel/sched/ext.c: In function 'scx_ops_disable_workfn':
   kernel/sched/ext.c:4455:17: error: implicit declaration of function 'stack_trace_print'; did you mean 'event_trace_printk'? [-Wimplicit-function-declaration]
    4455 |                 stack_trace_print(ei->bt, ei->bt_len, 2);
         |                 ^~~~~~~~~~~~~~~~~
         |                 event_trace_printk
   kernel/sched/ext.c: In function 'scx_ops_exit_kind':
   kernel/sched/ext.c:4834:30: error: implicit declaration of function 'stack_trace_save'; did you mean 'stack_tracer_enable'? [-Wimplicit-function-declaration]
    4834 |                 ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
         |                              ^~~~~~~~~~~~~~~~
         |                              stack_tracer_enable
--
   kernel/sched/core.c: In function 'cpu_idle_read_s64':
>> kernel/sched/core.c:9626:27: error: 'struct task_group' has no member named 'idle'
    9626 |         return css_tg(css)->idle;
         |                           ^~
   kernel/sched/core.c: In function 'cpu_idle_write_s64':
>> kernel/sched/core.c:9634:15: error: implicit declaration of function 'sched_group_set_idle'; did you mean 'scx_group_set_idle'? [-Wimplicit-function-declaration]
    9634 |         ret = sched_group_set_idle(css_tg(css), idle);
         |               ^~~~~~~~~~~~~~~~~~~~
         |               scx_group_set_idle
   kernel/sched/core.c: In function 'cpu_idle_read_s64':
   kernel/sched/core.c:9627:1: warning: control reaches end of non-void function [-Wreturn-type]
    9627 | }
         | ^


vim +3701 kernel/sched/ext.c

  3694	
  3695	static void scx_cgroup_warn_missing_idle(struct task_group *tg)
  3696	{
  3697		if (scx_ops_enable_state() == SCX_OPS_DISABLED ||
  3698		    cgroup_warned_missing_idle)
  3699			return;
  3700	
> 3701		if (!tg->idle)
  3702			return;
  3703	
  3704		pr_warn("sched_ext: \"%s\" does not implement cgroup cpu.idle\n",
  3705			scx_ops.name);
  3706		cgroup_warned_missing_idle = true;
  3707	}
  3708	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

