Return-Path: <linux-kernel+bounces-576253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE66A70CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72A21898638
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418E269CE0;
	Tue, 25 Mar 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tmh3RtZZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BD1953AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941294; cv=none; b=CBEnzdK4/WoAgHOY5XNrWCjPvwtI2tdPyXlwaMGIegtoIqumYU/Pe50wW/Vlj6it4WWdwhN8IITPqZ4ooceCgWIaxWQn70s3MtH1UIpcAGpMq47Lb91gxDw/sNq5GgrFTXSNICEqNDS/6R2GRWieKn/xDDXW8Q67l75f8OVO+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941294; c=relaxed/simple;
	bh=im837Imixl1KL1QNTvKxK8rDMGmDl9LS2Q9ts/o0d0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pz0I9jbEt+FjDyMYUGodGXayY9KWciNH8CPc9S07Zu4KIine+uoLPJL4a3p1nuxMy4luo4gxG9zbhUd/jmn+W4BNxadOK/siuX61/CcCxQWtczV4V1G/y/0wJI+48u98fmnoxZ1liC/j6hezv8DgCxAGI4wrdMS0eUX6WZboayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tmh3RtZZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742941293; x=1774477293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=im837Imixl1KL1QNTvKxK8rDMGmDl9LS2Q9ts/o0d0w=;
  b=Tmh3RtZZ5hW2pJsCJOc2JNCaW6VRHvngiQb5zO+npJ5tNpxLHDBziiyr
   jKlV1XfkTGwk4UwO/3TGNRy1ImJr0F6os0YUOk020r4GzEEmFlsulqS8b
   QpubNhomsl9K2c7TYjPo72JczDJ/F3edkYW1eXfxOzYAU5Iu0AZJ/5DKf
   N3gIY+2W/disCVzwogTmuQ4Ce/P3gLpjCrQk4e8CiYOKNZFhrjaxtkQO6
   xNYCNQBI4Ybl0yvfxEJvAFrPKDXMSHyXXQU4xwy2nqAWOvqVD9GhlEsIB
   wsGB3LU1aVTlxO9EI8g4MQ36JZFQ586AMV2d/R0wP2sap/2fTS0Ef03Bg
   Q==;
X-CSE-ConnectionGUID: RMwCcQ2iRJaasyB4Kw0nLA==
X-CSE-MsgGUID: Z0nPm+f3SaWFG7rS9OY9Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54414163"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="54414163"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 15:21:32 -0700
X-CSE-ConnectionGUID: xNgYo2DgSMqyIQ5uSKGGAg==
X-CSE-MsgGUID: WM53YadeTSelBCF+4Tom9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="129184097"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 15:21:30 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txCeG-0005Em-1P;
	Tue, 25 Mar 2025 22:21:28 +0000
Date: Wed, 26 Mar 2025 06:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>
Subject: kernel/sched/isolation.c:50: undefined reference to
 `sched_numa_find_closest'
Message-ID: <202503260646.lrUqD3j5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d09a9449ecd9a2b9fdac62408c12ee20b6307d2
commit: 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e sched/isolation: Prevent boot crash when the boot CPU is nohz_full
date:   11 months ago
config: sh-randconfig-r132-20250326 (https://download.01.org/0day-ci/archive/20250326/202503260646.lrUqD3j5-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250326/202503260646.lrUqD3j5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503260646.lrUqD3j5-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: kernel/sched/build_utility.o: in function `housekeeping_any_cpu':
>> kernel/sched/isolation.c:50: undefined reference to `sched_numa_find_closest'


vim +50 kernel/sched/isolation.c

    38	
    39	int housekeeping_any_cpu(enum hk_type type)
    40	{
    41		int cpu;
    42	
    43		if (static_branch_unlikely(&housekeeping_overridden)) {
    44			if (housekeeping.flags & BIT(type)) {
    45				cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
    46				if (cpu < nr_cpu_ids)
    47					return cpu;
    48	
    49				cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
  > 50				if (likely(cpu < nr_cpu_ids))
    51					return cpu;
    52				/*
    53				 * Unless we have another problem this can only happen
    54				 * at boot time before start_secondary() brings the 1st
    55				 * housekeeping CPU up.
    56				 */
    57				WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
    58					     type != HK_TYPE_TIMER);
    59			}
    60		}
    61		return smp_processor_id();
    62	}
    63	EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
    64	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

