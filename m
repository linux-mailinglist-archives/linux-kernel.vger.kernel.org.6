Return-Path: <linux-kernel+bounces-362088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319BB99B0D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5033B1C217FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D612D1FA;
	Sat, 12 Oct 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efZo6oX7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4382CA9
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728708057; cv=none; b=t6bfXgt0XUR1zGYFrJZSeLXYwNMn5jqigqgTPBQayqd3dRyEADeDMMoWyH+ir5Lucd429KPsIZAtiOkSZhXMB+FnlfSZ37dATyIinTHbeRxoO0gvCc81/tp4ZSP3lp6bUMSmEE6GIrPZ5Iebznu5+3SYU+v9U931G7ZuQ7mLBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728708057; c=relaxed/simple;
	bh=jf6c82u62MQDwGz8W0XwGyc4X53uxcOJOCNghOwP+Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QO78I4DkogF56CxKQth3lk0y7nHJu3qIHvRjq2wWCO2gQwZFFAWLSXZvq7ZwSnPCT4LTYPTZ4T2TKUc8aVRpoN0YidSir8xRcsiResMaEBQI/JAb2Za6bN74CW0QDKOQiuuCCuhUy9rPg+ElTziQoAoAR4eHKIlz95LkvPTwrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efZo6oX7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728708055; x=1760244055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jf6c82u62MQDwGz8W0XwGyc4X53uxcOJOCNghOwP+Lc=;
  b=efZo6oX7d/4bP8cA6Whaa3LHOFBe+ojFv+v6qhk8P97gO+ZL5k0cG7fe
   MpTXTYtfrjEpxH58puibr1kAQxbbvJRFg2pPpAIfXLv6x5wI2DRhNAZew
   zccokz8VaG+plXeLh1tVuVe5FrsA9AAMJovURleNjWmVSEN/uvJmh00kG
   VZhVpQNiJQa1CgSmzuZ25vR16wJqRut6c70fRYgXg0TZDzkEq9XDhzHNd
   ToPWCSbQyJWGNOscTMpmrFfotqXsGx2X/7Z8yAK4HcnsXw2QpUeJWG9rW
   0YMlJH851cKZP3ZsafLY1SUhJ/wv4D13DUmdHy/kP0a4RAhcjcqFAY7uK
   A==;
X-CSE-ConnectionGUID: QnvyEAUEQoCGI3J4+s1Z0Q==
X-CSE-MsgGUID: s/Oev5muTImwOZlVTHlXqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30993611"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="30993611"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 21:40:54 -0700
X-CSE-ConnectionGUID: 3ltNeWnDQPmwFyCHQf2XhA==
X-CSE-MsgGUID: /kasZiV3QHa/AHMMbCZ5MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="81712678"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Oct 2024 21:40:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szTvu-000D3h-1O;
	Sat, 12 Oct 2024 04:40:50 +0000
Date: Sat, 12 Oct 2024 12:40:42 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: include/linux/ftrace.h:138:9: error: call to undeclared function
 'arch_ftrace_get_regs'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202410121234.0HjqU4Ie-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Puranjay,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
commit: 7caa9765465f60b6d88e22264892cee12d971888 ftrace: riscv: move from REGS to ARGS
date:   5 months ago
config: riscv-randconfig-r053-20241012 (https://download.01.org/0day-ci/archive/20241012/202410121234.0HjqU4Ie-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410121234.0HjqU4Ie-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410121234.0HjqU4Ie-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from arch/riscv/kernel/asm-offsets.c:12:
>> include/linux/ftrace.h:138:9: error: call to undeclared function 'arch_ftrace_get_regs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     138 |         return arch_ftrace_get_regs(fregs);
         |                ^
   include/linux/ftrace.h:138:9: note: did you mean 'ftrace_get_regs'?
   include/linux/ftrace.h:133:40: note: 'ftrace_get_regs' declared here
     133 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^
     134 | {
     135 |         if (!fregs)
     136 |                 return NULL;
     137 | 
     138 |         return arch_ftrace_get_regs(fregs);
         |                ~~~~~~~~~~~~~~~~~~~~
         |                ftrace_get_regs
>> include/linux/ftrace.h:138:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct pt_regs *' [-Wint-conversion]
     138 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.
   make[3]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/arch_ftrace_get_regs +138 include/linux/ftrace.h

d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  132) 
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  133) static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  134) {
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  135) 	if (!fregs)
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  136) 		return NULL;
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  137) 
02a474ca266a47 Steven Rostedt (VMware  2020-10-27 @138) 	return arch_ftrace_get_regs(fregs);
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  139) }
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  140) 

:::::: The code at line 138 was first introduced by commit
:::::: 02a474ca266a47ea8f4d5a11f4ffa120f83730ad ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

