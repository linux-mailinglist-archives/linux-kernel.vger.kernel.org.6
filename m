Return-Path: <linux-kernel+bounces-412319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E939D078A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978611F2146B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E4D2FB;
	Mon, 18 Nov 2024 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bet+va/p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EED360
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892971; cv=none; b=UhH33k6N/BZ5ZrftA7aSJLIcS3IOLSxjzma82xSChnn/S9pubAKavyfaStDGL4r0B2LQNg0e5SjLEbrBiDL6ZTC5diaiuxEpknnq4mPKdeSd1Ew61gqdoDIIdF8UmJlvr+c1kXTzbk6L0uN6Q78nqjdkCDWuCYWjFgPXQ3D4m58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892971; c=relaxed/simple;
	bh=99x8lfyQ+g2O/mcjSWdPRx8rz59R7f5P39DGWnF93hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dcqbOag9K4/5s4/oOiICpaEwgE3fgW/HpPIKnQLFtOOTb+Fw5NKVzyvL0Qr94XsWYZKCDeXOFA+ZD1RP7U15RrEPuuE8Viii3iG4LWTHYCyR9bMYQoXr0GwblyVk6l0yPGKTFvsqbEfCU0RPIQwl+ITP4fMHL8VSad76850f4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bet+va/p; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731892970; x=1763428970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=99x8lfyQ+g2O/mcjSWdPRx8rz59R7f5P39DGWnF93hg=;
  b=bet+va/prPuUpLRdqdxf8saox+OtvuvRQmRQdEVVt6uYgNA5J1nnGaqF
   N1NqO6JpYiH6Q8JIYykDza3QsTmPEa0Xv4k7xdV17GD2OwTqh5b5i/RYZ
   hnnfdzgbwOxiIHMktNjkBiIIcz0in9Odna6/Lv+4O7e+8yiYm2H5oz5ci
   eMEovwqtaiwepKCjsqqq1Xo3BXb3AaG1TS1OddR4AQpig3r8ytY6Yu5hd
   S0sDDeMOGkaSOA1GA8micZOhEBvhNRLoyLlzj4/Oll67D9NeJsPmxxI9e
   vHrcOyLnIr8FQ00fh8nZmahzejbnAQxmifmjTORrSqQTtW67Owbu80Mwg
   g==;
X-CSE-ConnectionGUID: uag9Za9VRqywhOySb49vww==
X-CSE-MsgGUID: s5xI/mx/T2mTONJP2jJCAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42354796"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42354796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 17:22:47 -0800
X-CSE-ConnectionGUID: fkbpHW3aSfKmTBADjLfTXw==
X-CSE-MsgGUID: EROWQInNTSOpcLhcySuCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89510917"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2024 17:22:38 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCqTG-0002B9-2F;
	Mon, 18 Nov 2024 01:22:30 +0000
Date: Mon, 18 Nov 2024 09:22:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241114 1/22]
 kernel/sched/ext.c:3765:10: error: incompatible pointer types returning
 'struct cgroup_hdr *' from a function with result type 'struct cgroup *'
Message-ID: <202411180931.Jr9Zovhz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241114
head:   ffa0ea7cd2216fa4db0e24844e1675e94b7db1aa
commit: 0fd0709da703a3bd95ed738a114858aa57e3d712 [1/22] cgroup: Avoid -Wflex-array-member-not-at-end warnings
config: powerpc64-randconfig-001-20241118 (https://download.01.org/0day-ci/archive/20241118/202411180931.Jr9Zovhz-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241118/202411180931.Jr9Zovhz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411180931.Jr9Zovhz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:63:
>> kernel/sched/ext.c:3765:10: error: incompatible pointer types returning 'struct cgroup_hdr *' from a function with result type 'struct cgroup *' [-Werror,-Wincompatible-pointer-types]
                   return &cgrp_dfl_root.cgrp;
                          ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/ext.c:7533:17: error: incompatible pointer types initializing 'struct cgroup *' with an expression of type 'struct cgroup_hdr *' [-Werror,-Wincompatible-pointer-types]
           struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
                          ^      ~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +3765 kernel/sched/ext.c

f0e1a0643a59bf Tejun Heo 2024-06-18  3753  
8195136669661f Tejun Heo 2024-09-04  3754  #ifdef CONFIG_EXT_GROUP_SCHED
8195136669661f Tejun Heo 2024-09-04  3755  static struct cgroup *tg_cgrp(struct task_group *tg)
8195136669661f Tejun Heo 2024-09-04  3756  {
8195136669661f Tejun Heo 2024-09-04  3757  	/*
8195136669661f Tejun Heo 2024-09-04  3758  	 * If CGROUP_SCHED is disabled, @tg is NULL. If @tg is an autogroup,
8195136669661f Tejun Heo 2024-09-04  3759  	 * @tg->css.cgroup is NULL. In both cases, @tg can be treated as the
8195136669661f Tejun Heo 2024-09-04  3760  	 * root cgroup.
8195136669661f Tejun Heo 2024-09-04  3761  	 */
8195136669661f Tejun Heo 2024-09-04  3762  	if (tg && tg->css.cgroup)
8195136669661f Tejun Heo 2024-09-04  3763  		return tg->css.cgroup;
8195136669661f Tejun Heo 2024-09-04  3764  	else
8195136669661f Tejun Heo 2024-09-04 @3765  		return &cgrp_dfl_root.cgrp;
8195136669661f Tejun Heo 2024-09-04  3766  }
8195136669661f Tejun Heo 2024-09-04  3767  

:::::: The code at line 3765 was first introduced by commit
:::::: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

