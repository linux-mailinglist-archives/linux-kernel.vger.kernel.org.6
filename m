Return-Path: <linux-kernel+bounces-446336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690879F2303
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879AA16594D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E897A14A0B3;
	Sun, 15 Dec 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPMGzM6G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80BEBE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734255567; cv=none; b=pYh18+vpijoByTjnxYRYUO1+Z3l/JTNqP+hKk891CuA9oKYiBdhsTgVuzz34zJHRADk1m0IyG7C0K23712ZBh7YgrC8chDc5gje8uWP7z5AIVeNM7wZt7h1lyGd7nOXlcWZBAOZRc5Cf+2gUVvNnSR7whZCf9VjE2qzraBR7SZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734255567; c=relaxed/simple;
	bh=pWWXOa6+BN7t+okq6TWWWHok1k9uzAMr5Nhv0cFskRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n4yaeQiUqEgKYtoKmLHlM3ThKsuSVLoN+fHlz0T3kzZmzhyl6B5rCRb+kwX/WIRzO8fUkpTLbrbkh0bSu7cviDwQwNRtfSEN7naL5x/Ea9m8uAhNdVQnz0MlB9PyfboUkF6NZ4nMEz3rXXJId4inBjJew+8a02AGSDtfoADNEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPMGzM6G; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734255565; x=1765791565;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pWWXOa6+BN7t+okq6TWWWHok1k9uzAMr5Nhv0cFskRI=;
  b=LPMGzM6G5KcZ9Uk7JEB+W9ROlg9jrSD/3lb+wMjuV5jzA5I5stNDTQca
   xrHlPrNQ6c9D9ZRGtLhYbB1xoRkunluFcz1PwoMN2n2nRVjGj2wOqZ3rU
   zLUjIah/MAZw9Sqby9R3SznSTvum+wCTryTnukKOJrw1dIARO43UimCPv
   oNFqmeOS0re5GGr2g/B7EgzK/N7r8bDfSZ4UIO5QZ76pH+clbnHdH3zIM
   KTZpClksJ1Vj5rvG6brE9mooIaXmL/+W8tNP2arCpxJIwjrAEe/kNigCS
   y7UQ+lTuIcocGLSjqh7z8aREMJ6nkaFqDMhO9CfJTDQgz5wT+rU+fwSBQ
   g==;
X-CSE-ConnectionGUID: HC5BPwkVSU2rGq2DH7mHMw==
X-CSE-MsgGUID: Nbz7NCJGTxKFwM/V3exsLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="52177428"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="52177428"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 01:39:25 -0800
X-CSE-ConnectionGUID: AuajVq6AQKGk/3xha7T+Cw==
X-CSE-MsgGUID: p0oBrmLcR1+zmIiDxtHr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="101782092"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Dec 2024 01:39:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMl5s-000DXi-2w;
	Sun, 15 Dec 2024 09:39:20 +0000
Date: Sun, 15 Dec 2024 17:38:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: arch/x86/lib/usercopy_64.c:29: warning: Function parameter or struct
 member 'addr' not described in 'clean_cache_range'
Message-ID: <202412151701.yujios7D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
commit: 0c3ebff535956d2718594dc90aa9cc87521ec9fd scripts: kernel-doc: Clarify missing struct member description
date:   1 year ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241215/202412151701.yujios7D-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151701.yujios7D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412151701.yujios7D-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/lib/usercopy_64.c:29: warning: Function parameter or struct member 'addr' not described in 'clean_cache_range'
   arch/x86/lib/usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'
--
>> kernel/reboot.c:226: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:952: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
--
>> arch/x86/mm/pgtable.c:650: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
>> arch/x86/mm/pgtable.c:699: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:699: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:699: warning: Function parameter or struct member 'prot' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:709: warning: Function parameter or struct member 'p4d' not described in 'p4d_clear_huge'
>> arch/x86/mm/pgtable.c:726: warning: Function parameter or struct member 'pud' not described in 'pud_set_huge'
>> arch/x86/mm/pgtable.c:726: warning: Function parameter or struct member 'addr' not described in 'pud_set_huge'
>> arch/x86/mm/pgtable.c:726: warning: Function parameter or struct member 'prot' not described in 'pud_set_huge'
>> arch/x86/mm/pgtable.c:752: warning: Function parameter or struct member 'pmd' not described in 'pmd_set_huge'
>> arch/x86/mm/pgtable.c:752: warning: Function parameter or struct member 'addr' not described in 'pmd_set_huge'
>> arch/x86/mm/pgtable.c:752: warning: Function parameter or struct member 'prot' not described in 'pmd_set_huge'
>> arch/x86/mm/pgtable.c:779: warning: Function parameter or struct member 'pud' not described in 'pud_clear_huge'
>> arch/x86/mm/pgtable.c:794: warning: Function parameter or struct member 'pmd' not described in 'pmd_clear_huge'
--
>> arch/x86/kernel/apic/apic.c:2170: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
   arch/x86/kernel/apic/apic.c:2170: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
--
>> arch/x86/mm/pat/memtype.c:710: warning: Function parameter or struct member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'
--
>> kernel/time/tick-broadcast.c:1026: warning: Function parameter or struct member 'bc' not described in 'tick_broadcast_setup_oneshot'
>> kernel/time/tick-broadcast.c:1026: warning: Function parameter or struct member 'from_periodic' not described in 'tick_broadcast_setup_oneshot'


vim +29 arch/x86/lib/usercopy_64.c

^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  13  
^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  14  /*
^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  15   * Zero Userspace
^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  16   */
^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  17  
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  18  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  19  /**
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  20   * clean_cache_range - write back a cache range with CLWB
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  21   * @vaddr:	virtual start address
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  22   * @size:	number of bytes to write back
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  23   *
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  24   * Write back a cache range using the CLWB (cache line write back)
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  25   * instruction. Note that @size is internally rounded up to be cache
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  26   * line size aligned.
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  27   */
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  28  static void clean_cache_range(void *addr, size_t size)
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29 @29  {
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  30  	u16 x86_clflush_size = boot_cpu_data.x86_clflush_size;
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  31  	unsigned long clflush_mask = x86_clflush_size - 1;
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  32  	void *vend = addr + size;
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  33  	void *p;
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  34  
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  35  	for (p = (void *)((unsigned long)addr & ~clflush_mask);
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  36  	     p < vend; p += x86_clflush_size)
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  37  		clwb(p);
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  38  }
0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  39  

:::::: The code at line 29 was first introduced by commit
:::::: 0aed55af88345b5d673240f90e671d79662fb01e x86, uaccess: introduce copy_from_iter_flushcache for pmem / cache-bypass operations

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

