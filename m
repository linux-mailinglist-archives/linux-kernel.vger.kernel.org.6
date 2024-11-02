Return-Path: <linux-kernel+bounces-393438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8319BA0A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6963E28253F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60F199384;
	Sat,  2 Nov 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyVj1yQI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCD15884A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730555624; cv=none; b=Z3pGcTqu3QE/kfD+9TV8dxPNWNUHFjjDlKVDIsgNM1DkT4bbkPFxUkvBlvBlG0S1+akaAjGp+VgECrqB0RzrdftI0Crw7XLi5aHQDetBRb3SEN1B2UHQBjYsEE1+ii0XYn9wasTAfZjxfS64BencVleXTO0Frp9dDqPkMznCaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730555624; c=relaxed/simple;
	bh=PCJU3Hhf4qqMWg1P5DqMlKhJk1+68gubtERPbc0fCUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YZfDgq6UsnaiXBHZyl9EtPrutPnJwjHUBRkQNLXVuj8BRJk41opbxzwW2ihMpeRSOHAkfPJJrWuFtGcF8+QNA9Eb+/QuhaVFOx6CZkkAcsRWkVQCjjxRlNveFmNJvq3ylaOhA3u7m5cNFwKmwr5kHOVR5mv89YyUlveQvbpekWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyVj1yQI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730555621; x=1762091621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PCJU3Hhf4qqMWg1P5DqMlKhJk1+68gubtERPbc0fCUI=;
  b=AyVj1yQIGHSCUVfxqqMl8Fx9RKHtQNJfOIpNQQNICMPhzDnd37M330+l
   nRJTjYvLkJgdeI2nEuSDXbjNaeSba7gw9m+nXP8WPRLX6h/JDaf2IY/9i
   SkuULEqM87n5lG7DrKqc6HdRfzz8ooSsG3na8OEg+msBhqEmLzXLr4Krp
   8IAokXGIqEZuWctj3wYMAq1mzNdk4Ifpg9ACgVvss41dAK6xEDKe50zTC
   TfL4yMFg6XfchBSCXGRPQhPSuKElp/8u5IBQ+ltGeK7OB5yoSs+s4cxM2
   yt8XqV0clBTK5kMOTLNYZP+xAVEar3y/z5Xawi+tQ3LqpDzsQez7vZfAW
   A==;
X-CSE-ConnectionGUID: hvTtkYCJRI+nXdo6NMXF8A==
X-CSE-MsgGUID: o6T/BXZqTAmYrAdFwje++Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40847577"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40847577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 06:53:41 -0700
X-CSE-ConnectionGUID: 8qFh7d9LR7aM3LMXH5FGCg==
X-CSE-MsgGUID: DVgtg/h4QHC3stvtnbOJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87981139"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Nov 2024 06:53:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7EZM-000j2V-2r;
	Sat, 02 Nov 2024 13:53:36 +0000
Date: Sat, 2 Nov 2024 21:53:29 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/vdso 33/41] arch/x86/include/asm/vdso/vsyscall.h:16:10:
 fatal error: 'asm/vvar.h' file not found
Message-ID: <202411022159.vUVrHGcm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
head:   3bf96deae5ad9664bdf2db95599e52221f9ddc33
commit: 915c1d9df1f757b0979283b6e50da9b3ccc4d826 [33/41] x86/vdso: Split virtual clock pages into dedicated mapping
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241102/202411022159.vUVrHGcm-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411022159.vUVrHGcm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411022159.vUVrHGcm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vma.c:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/entry/vdso/vma.c:27:
>> arch/x86/include/asm/vdso/vsyscall.h:16:10: fatal error: 'asm/vvar.h' file not found
      16 | #include <asm/vvar.h>
         |          ^~~~~~~~~~~~
   4 warnings and 1 error generated.


vim +16 arch/x86/include/asm/vdso/vsyscall.h

7ac8707479886c Vincenzo Frascino 2019-06-21  13  
7ac8707479886c Vincenzo Frascino 2019-06-21  14  #include <vdso/datapage.h>
7ac8707479886c Vincenzo Frascino 2019-06-21  15  #include <asm/vgtod.h>
7ac8707479886c Vincenzo Frascino 2019-06-21 @16  #include <asm/vvar.h>
7ac8707479886c Vincenzo Frascino 2019-06-21  17  

:::::: The code at line 16 was first introduced by commit
:::::: 7ac8707479886c75f353bfb6a8273f423cfccb23 x86/vdso: Switch to generic vDSO implementation

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

