Return-Path: <linux-kernel+bounces-380620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5BE9AF3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4899C1F23154
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142C1F585D;
	Thu, 24 Oct 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYRFkB4C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1213CA97
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802124; cv=none; b=GqQgl5ZEaANsM+b+a9TWeLLdRJcg+V5uLOyY5fxibmUuUJllBOCUwK4o5UB0mR2f+A8lPPXeFINQ+6iqdaophuB+mN8TsyVWchvzlDCAYr65IrhpnSxQGriDQ7kH+OS/mq6zkboI4h42ctJgcMRqOhY1cQnj5B49SFwqwSRREvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802124; c=relaxed/simple;
	bh=lu4rn28L1RW9eZl2pMqeyfnPnDDAUfTZcMTDNRE3mtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=chuZwYVTDc7pAr7UETQyyY7if4pZ5m8JQNtJRfScsMYQYlXzIo5xfN97yHic7IwmMSP1wmOWl7JMoQXBCAh73Gr+4saZD/5ZZ1ynJOt08rrdZ3TjB83b9N7N+brmF1VZsFl4mHME+qZlckgo4W2SZKs03XIeO35X7jlK+WAd480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYRFkB4C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729802122; x=1761338122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lu4rn28L1RW9eZl2pMqeyfnPnDDAUfTZcMTDNRE3mtw=;
  b=AYRFkB4C0PRvC30zDPewQzUIPOmbDB5Qnz7Z8kIrIaMqU6m6EuHVSBGl
   Wg73RgrvHu5608+I1pUAAu1iNQGDFwMlrNYM1FWmagEIovK1JzZivc4Xo
   g+g4YHHsKPVhg55rfGiNUsSxW9qOpEJaV+56Z/B3ZWciWuSB1izum6oRk
   DVFuwPvstNeudT3L53JDL1dFYNCTk1L61bjlBag0uKIIBR/8c0c6vlGlH
   D9TaHrvsFNWLLVLDOn6Wsf5bJwGJLt2uTRzeoPOl3YaeMk182bssB4r/d
   eqg+GugQoLr/M/tEfCXkJoQeDQMchPBN9bcZa0Ma+cDrlttBYf9wnjM0a
   Q==;
X-CSE-ConnectionGUID: gmnWqdtTToW6s2sB/f5Xhw==
X-CSE-MsgGUID: uGG8t1/8TbOdLIja+OBLUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33260125"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="33260125"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 13:35:22 -0700
X-CSE-ConnectionGUID: vCSxoWGnSO2RWeWohMPHtg==
X-CSE-MsgGUID: daxuC6KhSo2K5eJTHtFZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80696527"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Oct 2024 13:35:20 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t44Y9-000X4k-2I;
	Thu, 24 Oct 2024 20:35:17 +0000
Date: Fri, 25 Oct 2024 04:34:37 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not
 used
Message-ID: <202410250459.EJe6PJI5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: d8fccd9ca5f905533dc6c26cfd1f91beb8691c95 arm64: Allow to enable PREEMPT_RT.
date:   5 weeks ago
config: arm64-randconfig-004-20241025 (https://download.01.org/0day-ci/archive/20241025/202410250459.EJe6PJI5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250459.EJe6PJI5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250459.EJe6PJI5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/seqlock.h:19,
                    from include/linux/dcache.h:11,
                    from include/linux/fs.h:8,
                    from include/linux/highmem.h:5,
                    from kernel/sched/core.c:10:
>> kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not used [-Wunused-variable]
    1361 | static DEFINE_MUTEX(uclamp_mutex);
         |                     ^~~~~~~~~~~~
   include/linux/mutex.h:101:22: note: in definition of macro 'DEFINE_MUTEX'
     101 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~


vim +/uclamp_mutex +1361 kernel/sched/core.c

71f8bd4600521fe kernel/sched.c      Ingo Molnar     2007-07-09  1349  
69842cba9ace848 kernel/sched/core.c Patrick Bellasi 2019-06-21  1350  #ifdef CONFIG_UCLAMP_TASK
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1351  /*
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1352   * Serializes updates of utilization clamp values
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1353   *
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1354   * The (slow-path) user-space triggers utilization clamp value updates which
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1355   * can require updates on (fast-path) scheduler's data structures used to
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1356   * support enqueue/dequeue operations.
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1357   * While the per-CPU rq lock protects fast-path update operations, user-space
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1358   * requests are serialized using a mutex to reduce the risk of conflicting
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1359   * updates or API abuses.
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1360   */
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22 @1361  static DEFINE_MUTEX(uclamp_mutex);
2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  1362  

:::::: The code at line 1361 was first introduced by commit
:::::: 2480c093130f64ac3a410504fa8b3db1fc4b87ce sched/uclamp: Extend CPU's cgroup controller

:::::: TO: Patrick Bellasi <patrick.bellasi@arm.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

