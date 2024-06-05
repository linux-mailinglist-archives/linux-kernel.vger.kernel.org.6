Return-Path: <linux-kernel+bounces-201649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F88FC15B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E8EB2508F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4E50A93;
	Wed,  5 Jun 2024 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWRgZIk0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3D347C2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717551280; cv=none; b=rgtb3xHrXJLGptX+PQRfUglksDwoLosO+/sdZlwDZ0SfgHeaQDSrzqgMAzBY5OVLJY/ud1qW+4aOeoPz245CeFZG7FC8q6CZwhzcWFwlDRVZY4GLK5aStHsAtILT/nYkeaiTzrC9Q8HXPxk2EIfx4Ks3xX46j7ufvm6gVDXBibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717551280; c=relaxed/simple;
	bh=9+rM/5HKztZ3XHOcKnoDMJ97EOLdst/cWA1TwQP/mJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q+UpXz6LjTv62Ets1qgnAsF5+2K5tZJcQd1Gf9RKqz/M1d2zC9Y9JNs8VycOYPO2nME30lgtqWrCGKINgpZI0JnGYaBPqVSQ/1wPf68bBCDXR5d1gN8IzfFwQsXkuTLYAY6lIsDzt8G5za5yCsD5I/9Z2RSw+R5n7vls/nFxmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWRgZIk0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717551278; x=1749087278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9+rM/5HKztZ3XHOcKnoDMJ97EOLdst/cWA1TwQP/mJs=;
  b=VWRgZIk0vfPo4aNBf6MCLD0ZO9W4Du94RXOkAA2VU5ZYG9jGpU2RyxTh
   /y00knaP9im/73e3Tfa+SdYCKXcSqcwt1ZXjlKpuPY0isc1/P00Ru/23A
   iZOAB6bcY9m+KvVK0AEp6/a1KQ6eYBCRYZ3IPb7eeV+fZ+ogU8QC4e9lf
   SGXsy1JPWyASXiU8PZGHLLqkrPKB+enz0796d9q6SQuPcjwoEdVaP8KVC
   pcZXBfSZzYqZ21qQTSvIFwB3QuGk3uWnx7KAPctcr+V6f8q5F5TsEjJ7c
   KicyR0oN3EMo9qVMSQ50rLWLjP41agof1R63fty07QOcgxaetTzSyO78P
   w==;
X-CSE-ConnectionGUID: 2aHu1SOVROyqtLGBiaMN5w==
X-CSE-MsgGUID: QCsSfn/OQZORZfvyWKlIGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24790960"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="24790960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 18:34:27 -0700
X-CSE-ConnectionGUID: uhmQxwGWT461MmOV2g0F/A==
X-CSE-MsgGUID: MZSoxDrFR1qQd26y/gyBhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="74906284"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Jun 2024 18:34:25 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEfXi-0000mF-2F;
	Wed, 05 Jun 2024 01:34:22 +0000
Date: Wed, 5 Jun 2024 09:33:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h:19:62:
 warning: omitting the parameter name in a function definition is a C23
 extension
Message-ID: <202406050908.1kL1C69p-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
commit: e22b4973ee201486a7147efaa80b6562d3a749d1 media: c8sectpfe: Do not depend on DEBUG_FS
date:   7 weeks ago
config: arm64-randconfig-004-20240605 (https://download.01.org/0day-ci/archive/20240605/202406050908.1kL1C69p-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050908.1kL1C69p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050908.1kL1C69p-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:16:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:38:
>> drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h:19:62: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
      19 | static inline void c8sectpfe_debugfs_init(struct c8sectpfei *) {};
         |                                                              ^
   drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h:20:62: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
      20 | static inline void c8sectpfe_debugfs_exit(struct c8sectpfei *) {};
         |                                                              ^
   7 warnings generated.


vim +19 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h

    14	
    15	#if defined(CONFIG_DEBUG_FS)
    16	void c8sectpfe_debugfs_init(struct c8sectpfei *);
    17	void c8sectpfe_debugfs_exit(struct c8sectpfei *);
    18	#else
  > 19	static inline void c8sectpfe_debugfs_init(struct c8sectpfei *) {};
    20	static inline void c8sectpfe_debugfs_exit(struct c8sectpfei *) {};
    21	#endif
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

