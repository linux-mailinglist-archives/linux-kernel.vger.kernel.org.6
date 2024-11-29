Return-Path: <linux-kernel+bounces-426005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008CF9DEDAF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BDDDB21215
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF715530F;
	Fri, 29 Nov 2024 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUpHrD9t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5974189B8F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924390; cv=none; b=Tp8LiKDHvYtXGSEE0l0F9ntCtRIVVu/EBRr2eqyizIYPZJQU5EAJ83Qhq5s2Fuqa4WVFS+MrCrTM9pm6xgHaSlgZUOqzKKGBohIjXePqBRiouKjaxs0BEydcIoqFowBPrruz509CU8bi3gFG3UefHDmav/fF+mPCzIyt6FWRdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924390; c=relaxed/simple;
	bh=dMojtd1hKJIh3YUnjd/dXONV6TFdwZwQm6greqURNnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RtG2ITv3tZzxozCAIUcH+LQeBeQUibNYj3W5JHp8wmduXzWZVLgqqaDW00D4Sn952ca2bqCJ2WEDagsjKEx10zZZAix61i+EbrB82+VXIEkMOz0gt8I8YaWe/fWT26r+Ta2y/ctVOx3q4mizpy4HNZ9rtGbiKiF6oH0P1HJVm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUpHrD9t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732924389; x=1764460389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dMojtd1hKJIh3YUnjd/dXONV6TFdwZwQm6greqURNnQ=;
  b=hUpHrD9tM365YvgpvmS07ZUJlMZ6kRtxpMGIXLfcbT6oE4yV6pHu6E/X
   7SWltgiTrb8HbRvK4mBZ5JKC6tYbEgeUAERByo7bzBkpwYMF8yGSxjlBt
   Mh6TIuWNb3gFmdpBiHBdKuABCcvWGhY3Ws/TIfquGMeG1rb7fDtX9po0x
   isM/M2Fg0NQhSsq6GB7G17UuynCVPXq4ElresoJCpLp/2QQmEQd2g0GJS
   W+rRibhbjPxEtWlYkOjx7+R0XwVAXwwrj3WiS4DbZpYJwvbGxwkSpRmKq
   IJkLgdRYfCNJTiK/CU0UEQHzGH4FhvGID2fgQdosw/IWeqvni/YYV78R7
   Q==;
X-CSE-ConnectionGUID: f64Dz6cCSeGk+0Vcqgbuaw==
X-CSE-MsgGUID: tVLRFaVEQjWWio6PZ93YAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36019812"
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="36019812"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 15:53:08 -0800
X-CSE-ConnectionGUID: j+faet0cR6mdqtIIg5nmDg==
X-CSE-MsgGUID: 9n8EXdejTZerldv0VCBg0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="92760198"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Nov 2024 15:53:07 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHAnI-0000m5-0w;
	Fri, 29 Nov 2024 23:53:04 +0000
Date: Sat, 30 Nov 2024 07:52:54 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>
Subject: error: ran out of registers during register allocation
Message-ID: <202411300710.sjbtlh3s-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Saurabh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: f83705a51275ed29117d46e1d68e8b16dcb40507 Driver: VMBus: Add Devicetree support
date:   1 year, 7 months ago
config: i386-buildonly-randconfig-002-20241130 (https://download.01.org/0day-ci/archive/20241130/202411300710.sjbtlh3s-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411300710.sjbtlh3s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411300710.sjbtlh3s-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/hyperv/mmu.c:3:
   In file included from include/linux/hyperv.h:17:
   In file included from include/linux/mm.h:1970:
   include/linux/vmstat.h:516:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     516 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
   1 warning and 5 errors generated.
--
   In file included from arch/x86/hyperv/ivm.c:10:
   In file included from include/linux/hyperv.h:17:
   In file included from include/linux/mm.h:1970:
   include/linux/vmstat.h:516:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     516 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> error: ran out of registers during register allocation
   1 warning and 1 error generated.
--
   In file included from arch/x86/hyperv/irqdomain.c:11:
   In file included from include/linux/pci.h:1970:
   In file included from arch/x86/include/asm/pci.h:5:
   In file included from include/linux/mm.h:1970:
   include/linux/vmstat.h:516:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     516 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
   1 warning and 2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

