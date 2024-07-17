Return-Path: <linux-kernel+bounces-254591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54862933505
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7A41F232ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81A2F2C;
	Wed, 17 Jul 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mue8cotQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065F1109
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721180496; cv=none; b=NSPRfMp4lsEZQD8dIinL03o3b0o43ruTQjr5fN6a/RNMnVf1wpnzteOE0ne+ToXSmqPIt4El51z2gfIaxPXTplQP48wCCLp8pYGH50KGd5kuJkadUONaL+wjn2xkZ9t4lgI6cat+rB3tapOelADsIjpYmy3JcPreS9VH5yK/b4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721180496; c=relaxed/simple;
	bh=fzLSUTqxwjcfRfcffYQUr5fxvHk9MR3q4ngjyYn566M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mhaVgN+t8GZymfqnZAXJvgGDNa3Snjt1xlfFAukYWTeAqsw5KaPDmIPy87+pnb4oFFa8dDa1ZRod69uyjJ/Ask4xPAOzG6BM2geKtllXpxwcid51Qvnrr0sPehEKyNlDtqtvchM/f3ZRN7l8rWPn3eV3GfyDfc/3K7P4umoBTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mue8cotQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721180495; x=1752716495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fzLSUTqxwjcfRfcffYQUr5fxvHk9MR3q4ngjyYn566M=;
  b=mue8cotQJMNs+R7hxR99kawUV6WQFTVhAPc/CF+qe8y08K6tOWA6NwQ/
   Dhp4Oxo0ZbTtTQwA8uFyKULwWmxlO6Nswbds2mejPoI6MzvYltVDkkeJY
   e2S1N0rXEOrwEmpr7ikoh056TkZK39BXgyKm7g5NEJ1BtSdbWsg4F5tvg
   eTpXQFsw81Az1C2fC9KrB6gH8zbUFY370/bhRfv7TqCinuR3/DdE2gQkj
   RzWHWEp/v4OpF+HAfPK/IS1FMqOZLAMCdKKQfrbCEH9JPd7kGhCAPf0qu
   7vIEkoySud3rcKhTeLM9gt9RG0tiYmrSFRJ95gIvWt5ntCIRZNwejNtSf
   g==;
X-CSE-ConnectionGUID: Co5geEiXSkaarPQtFEimXw==
X-CSE-MsgGUID: RElqOwemSY2VMnU+DJE/kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29266612"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="29266612"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 18:41:34 -0700
X-CSE-ConnectionGUID: B3yQyggpR0m68MpGWnZlVA==
X-CSE-MsgGUID: X08upnRMSnqiOyHN2+8NNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="50276621"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Jul 2024 18:41:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTtfd-000frO-1k;
	Wed, 17 Jul 2024 01:41:29 +0000
Date: Wed, 17 Jul 2024 09:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: include/linux/ftrace.h:138:9: error: call to undeclared function
 'arch_ftrace_get_regs'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202407170916.Z28Cvmp1-lkp@intel.com>
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
head:   0434dbe32053d07d658165be681505120c6b1abc
commit: 7caa9765465f60b6d88e22264892cee12d971888 ftrace: riscv: move from REGS to ARGS
date:   8 weeks ago
config: riscv-randconfig-001-20240717 (https://download.01.org/0day-ci/archive/20240717/202407170916.Z28Cvmp1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240717/202407170916.Z28Cvmp1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407170916.Z28Cvmp1-lkp@intel.com/

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
   make[3]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1 shuffle=1354650548
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2 shuffle=1354650548
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=1354650548
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=1354650548
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

