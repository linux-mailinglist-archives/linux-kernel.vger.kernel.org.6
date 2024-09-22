Return-Path: <linux-kernel+bounces-335035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520497E02B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226561C2097A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A43175D5E;
	Sun, 22 Sep 2024 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2TlOz22"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C813F43E
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726980799; cv=none; b=YqrYuTWRaqB/rYL2MCia0UsidzaDxSMDa4b1qa7sE0twoEktoVShS3enWPomZ3IbqDyMvkew1HqCgIWDqfY8VQ+kFA921VphvXgv6TPnyhnXilrz1MB0XizU1kVYSottqLo3AymGBfHU6m37sk98g/RdIqPdGuwXGN5va9wyAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726980799; c=relaxed/simple;
	bh=5sPAcp14oAGaMblHFYuYSWG6YFrLMixhPDa5MzibQiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oTCsnFtyLD3zq3VaLDahDBJlxK0RlTD0kxPColoWkkkCHYYhPG/va1C1Xu3177otY9BOHlPITyeF5MFBGQf2w8coFM9gcUvx3Shs3Dg/apHFK2dBmSp4r6o8NL7Tsa++HWQGimzXXlyMIkNbkeuOusZPJ3bLjnOUrWsHi1aAWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2TlOz22; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726980798; x=1758516798;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5sPAcp14oAGaMblHFYuYSWG6YFrLMixhPDa5MzibQiY=;
  b=J2TlOz222nftDVp7nX632qUUgQUrT/srRaRY8ZRJ4GU7OhXSSngunQcq
   0Su1yVirMXJ10qQZGZEeWkqLh3Vk1r6bGQgQkQrLsWLgEzTZ25EyCJC/z
   pHrtE3BGiN15q1mb1lpctxzAQIAoSZX5piGmB0yBv3Ki9Kf080+AiEuMs
   RHaijQU+F5ffOYFAA4Hl78F6da7PgUAL6Kghwud9mSGP9hfgf1rFROjH1
   t1CTmWpb295Kvc9znTYU4TMiAWAb5SY7cwmYFaDqkRnQH7Z/S055ofMw2
   RRcmXv0/kcQRUclXY5wg3GqbFM3fdFkCvC07D+bDezTlxoCkrdoX22a8j
   A==;
X-CSE-ConnectionGUID: prmrPelOS2qQrMDA2zB46g==
X-CSE-MsgGUID: 7TfwuY9BRJ2wq0IIIdkeTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43417182"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="43417182"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 21:53:17 -0700
X-CSE-ConnectionGUID: /umQf+ypQyaq6gRJQQE18Q==
X-CSE-MsgGUID: COQ3buR6SZKuBfdET9hvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="94055201"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Sep 2024 21:53:16 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssEav-000G2g-1C;
	Sun, 22 Sep 2024 04:53:13 +0000
Date: Sun, 22 Sep 2024 12:52:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240919 1/14]
 kernel/sched/ext.c:3351:24: error: returning 'struct cgroup_hdr *' from a
 function with incompatible return type 'struct cgroup *'
Message-ID: <202409221235.gxUlE6Vm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gustavo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240919
head:   c4fe76eb6cabd44e576f30024974d06c9bd5d6ca
commit: f86858bda9d881af35ad0e29d88afc58a02d0f09 [1/14] cgroup: Avoid -Wflex-array-member-not-at-end warnings
config: sparc-randconfig-002-20240922 (https://download.01.org/0day-ci/archive/20240922/202409221235.gxUlE6Vm-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409221235.gxUlE6Vm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409221235.gxUlE6Vm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:63:
   kernel/sched/ext.c: In function 'tg_cgrp':
>> kernel/sched/ext.c:3351:24: error: returning 'struct cgroup_hdr *' from a function with incompatible return type 'struct cgroup *' [-Wincompatible-pointer-types]
    3351 |                 return &cgrp_dfl_root.cgrp;
         |                        ^~~~~~~~~~~~~~~~~~~
   kernel/sched/ext.c: In function 'scx_cgroup_warn_missing_idle':
   kernel/sched/ext.c:3709:16: error: 'struct task_group' has no member named 'idle'
    3709 |         if (!tg->idle)
         |                ^~
   kernel/sched/ext.c: In function 'scx_ops_disable_workfn':
   kernel/sched/ext.c:4473:17: error: implicit declaration of function 'stack_trace_print'; did you mean 'event_trace_printk'? [-Wimplicit-function-declaration]
    4473 |                 stack_trace_print(ei->bt, ei->bt_len, 2);
         |                 ^~~~~~~~~~~~~~~~~
         |                 event_trace_printk
   kernel/sched/ext.c: In function 'scx_ops_exit_kind':
   kernel/sched/ext.c:4852:30: error: implicit declaration of function 'stack_trace_save'; did you mean 'stack_tracer_enable'? [-Wimplicit-function-declaration]
    4852 |                 ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
         |                              ^~~~~~~~~~~~~~~~
         |                              stack_tracer_enable
   kernel/sched/ext.c: In function 'scx_bpf_task_cgroup':
>> kernel/sched/ext.c:7052:31: error: initialization of 'struct cgroup *' from incompatible pointer type 'struct cgroup_hdr *' [-Wincompatible-pointer-types]
    7052 |         struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
         |                               ^
>> kernel/sched/ext.c:7065:22: error: assignment to 'struct cgroup *' from incompatible pointer type 'struct cgroup_hdr *' [-Wincompatible-pointer-types]
    7065 |                 cgrp = &cgrp_dfl_root.cgrp;
         |                      ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +3351 kernel/sched/ext.c

f0e1a0643a59bf Tejun Heo 2024-06-18  3339  
8195136669661f Tejun Heo 2024-09-04  3340  #ifdef CONFIG_EXT_GROUP_SCHED
8195136669661f Tejun Heo 2024-09-04  3341  static struct cgroup *tg_cgrp(struct task_group *tg)
8195136669661f Tejun Heo 2024-09-04  3342  {
8195136669661f Tejun Heo 2024-09-04  3343  	/*
8195136669661f Tejun Heo 2024-09-04  3344  	 * If CGROUP_SCHED is disabled, @tg is NULL. If @tg is an autogroup,
8195136669661f Tejun Heo 2024-09-04  3345  	 * @tg->css.cgroup is NULL. In both cases, @tg can be treated as the
8195136669661f Tejun Heo 2024-09-04  3346  	 * root cgroup.
8195136669661f Tejun Heo 2024-09-04  3347  	 */
8195136669661f Tejun Heo 2024-09-04  3348  	if (tg && tg->css.cgroup)
8195136669661f Tejun Heo 2024-09-04  3349  		return tg->css.cgroup;
8195136669661f Tejun Heo 2024-09-04  3350  	else
8195136669661f Tejun Heo 2024-09-04 @3351  		return &cgrp_dfl_root.cgrp;
8195136669661f Tejun Heo 2024-09-04  3352  }
8195136669661f Tejun Heo 2024-09-04  3353  

:::::: The code at line 3351 was first introduced by commit
:::::: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

