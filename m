Return-Path: <linux-kernel+bounces-293068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AB957A58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AA2837CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951423BF;
	Tue, 20 Aug 2024 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWgt+4O9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AE1849
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112789; cv=none; b=tdHnZJO63Pu2QZrYH/aSVZQscCCuBbbaXjt/39zlQkpHio0IQbAf9P+3IMNzGc9jngvEfmfbCdPjzGmjxAq44riJAbnzpQLti29x4YSVOk/Dz+wNV2pZQBnBo6Q4xZnQ7WPuk/N9TNV5LU3w4x07/6YDZLU8OPtK2kC3edngKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112789; c=relaxed/simple;
	bh=PQcpwzFXlaUF1+Qiw2IFkbZ5mtiByJZRwaoq5MGixlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EXsva05C9rmWZIeg/c+Ww/s8RzmAWC1NMX+xKB52or6iY3iw6FdmVML1BrLvTtSCeLAdaETyUrvt3XR5ZApKpmsZL8GcwhIc1AgopC/PNS7fxhHKTn3k8w2ngIemyKBmC7QoihM0PoZBDGPKWwO4BOUiWvqJY2WZKJx0cGvvDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWgt+4O9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724112788; x=1755648788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PQcpwzFXlaUF1+Qiw2IFkbZ5mtiByJZRwaoq5MGixlY=;
  b=LWgt+4O9Tb1TTFSBkww2zQ4bmLPWZ0ZDUtmqJmgxU8u7sRMqC9V9n8qs
   RM8+9t2wc9WIVNxESRwQzYdI3M9lYn76kdltymE453HhwTxkAtp0j1LAV
   AnmEMI8zhHqQKV3/eqE204DUHsHu1gICehSDDSbAHpViczVg8R2UkDOYI
   mEPn0xKHEEWIMS6j4VdScJnGEgPrP3WMGpghGStCgImTfAyFmF99bcZgX
   ECS/V9MktB0TIrSBomwV/6U5He93tfi4Rnv+fcLrBZbNY3qOdKHTj/G6b
   p3Eo3rOi2xDSb9o0XXPcMtDiTLvJARKLwsBDnA/y90aXz3C8mDzgcfOaS
   w==;
X-CSE-ConnectionGUID: 8VlGT9DNTQCofEVq9dlSPA==
X-CSE-MsgGUID: EOaW5OZqT2Geme7Syaf0rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39847260"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="39847260"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:12:32 -0700
X-CSE-ConnectionGUID: Zvv+FUi/Ro+7+YYeTvaqLg==
X-CSE-MsgGUID: 2RHaeq6kQhGN+HhHAtttAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="91304307"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 17:12:08 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgCTm-0009YO-09;
	Tue, 20 Aug 2024 00:12:06 +0000
Date: Tue, 20 Aug 2024 08:11:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/sched/syscalls.c:979:8: error: unexpected token, expected
 comma
Message-ID: <202408200858.vCxqGpji-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e4436539ae182dc86d57d13849862bcafaa4709
commit: 04746ed80bcf3130951ed4d5c1bc5b0bcabdde22 sched/syscalls: Split out kernel/sched/syscalls.c from kernel/sched/core.c
date:   3 months ago
config: mips-randconfig-r111-20240819 (https://download.01.org/0day-ci/archive/20240820/202408200858.vCxqGpji-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce: (https://download.01.org/0day-ci/archive/20240820/202408200858.vCxqGpji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200858.vCxqGpji-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:24:
   In file included from include/linux/livepatch.h:13:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/sched/build_policy.c:55:
>> kernel/sched/syscalls.c:979:8: error: unexpected token, expected comma
     979 |         ret = get_user(size, &uattr->size);
         |               ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:183:23: note: expanded from macro '__get_user'
     183 |                 __get_data_asm((x), user_lw, __gu_ptr);                 \
         |                                     ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
   In file included from kernel/sched/build_policy.c:55:
>> kernel/sched/syscalls.c:979:8: error: invalid operand for instruction
     979 |         ret = get_user(size, &uattr->size);
         |               ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:183:23: note: expanded from macro '__get_user'
     183 |                 __get_data_asm((x), user_lw, __gu_ptr);                 \
         |                                     ^
   <inline asm>:4:10: note: instantiated into assembly here
       4 |         lwe $2, 0($17)
         |                 ^
   In file included from kernel/sched/build_policy.c:55:
   kernel/sched/syscalls.c:1009:2: error: unexpected token, expected comma
    1009 |         put_user(sizeof(*attr), &uattr->size);
         |         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:136:18: note: expanded from macro '__put_user'
     136 |                 __put_data_asm(user_sw, __pu_ptr);                      \
         |                                ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
   In file included from kernel/sched/build_policy.c:55:
   kernel/sched/syscalls.c:1009:2: error: invalid operand for instruction
    1009 |         put_user(sizeof(*attr), &uattr->size);
         |         ^
   arch/mips/include/asm/uaccess.h:71:33: note: expanded from macro 'put_user'
      71 |         access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
         |                                        ^
   arch/mips/include/asm/uaccess.h:136:18: note: expanded from macro '__put_user'
     136 |                 __put_data_asm(user_sw, __pu_ptr);                      \
         |                                ^
   <inline asm>:4:10: note: instantiated into assembly here
       4 |         swe $2, 0($17)
         |                 ^
   1 warning and 4 errors generated.


vim +979 kernel/sched/syscalls.c

   967	
   968	/*
   969	 * Mimics kernel/events/core.c perf_copy_attr().
   970	 */
   971	static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
   972	{
   973		u32 size;
   974		int ret;
   975	
   976		/* Zero the full structure, so that a short copy will be nice: */
   977		memset(attr, 0, sizeof(*attr));
   978	
 > 979		ret = get_user(size, &uattr->size);
   980		if (ret)
   981			return ret;
   982	
   983		/* ABI compatibility quirk: */
   984		if (!size)
   985			size = SCHED_ATTR_SIZE_VER0;
   986		if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
   987			goto err_size;
   988	
   989		ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
   990		if (ret) {
   991			if (ret == -E2BIG)
   992				goto err_size;
   993			return ret;
   994		}
   995	
   996		if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
   997		    size < SCHED_ATTR_SIZE_VER1)
   998			return -EINVAL;
   999	
  1000		/*
  1001		 * XXX: Do we want to be lenient like existing syscalls; or do we want
  1002		 * to be strict and return an error on out-of-bounds values?
  1003		 */
  1004		attr->sched_nice = clamp(attr->sched_nice, MIN_NICE, MAX_NICE);
  1005	
  1006		return 0;
  1007	
  1008	err_size:
  1009		put_user(sizeof(*attr), &uattr->size);
  1010		return -E2BIG;
  1011	}
  1012	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

