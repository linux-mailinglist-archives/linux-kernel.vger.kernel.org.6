Return-Path: <linux-kernel+bounces-445986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1B9F1E30
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09C71678D1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED24176AC8;
	Sat, 14 Dec 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ig5l4dCK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2767E1
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734174185; cv=none; b=iGrS2UIEuv1q1OImQ4qbRhl91Ep6oraVFNZwX9PieKXG+8qFZqHvtxe4tj2JvgVhnPhAkIPNbDhSSGreNKQ7lGsaCdqtiI8nK0hN+uaDys79Y5e5zUqbqEdJGQ/+VY62We7hb6Sz6TAj/Gdr6iDxpp6Qnn8NMoGE0ELJK4F1Agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734174185; c=relaxed/simple;
	bh=QdRw9fPUCPidFKoi1cGdFfjBJVaqNyeFj/S6MN1bIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CBS7cd2qyzBL5Mc488lJH1054P77Yj7JZ4xDJC2SXNespecUOp7L9JW2kjsJiol2yPiJVpmXzhqLQ2hnaoLRymj/J81ZKngpdXw6MNM/I1z57aJTqS8uy8x3qsKu4tqreKjaU2EZwQ2EV0kM3WbqYXlsrgRZmyrLZIO8nEEY2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ig5l4dCK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734174184; x=1765710184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QdRw9fPUCPidFKoi1cGdFfjBJVaqNyeFj/S6MN1bIzM=;
  b=ig5l4dCKjDbwK1oCAWy+awGLCGrjPHitB3qxx8Roz3ecDvHXoWyULinM
   AVDEAteHHQ2GVuoR3cs4cKttrKfXKUijjUd2eSJkX4a/iUZyjYrpNUxJC
   vLtYQBOQB7C/VEXfESQa3Yfg9eaMjPUR20ccpVDxnTIvTTlIzHSe882Kh
   gdRAmZNX0cU0wqDRNBsMMdcoj1mkMs5G9UgnfgKtKy+OPj4nYwCDc/gpt
   pSLIE/wBQk3Hvm4Tb2tjPjkeHXhDJqGVC6TkgxNqNi1UCa9STZjY2/5hQ
   TqMxsAcHJxxMC9uMRNaf9IohsV9KKdX8i2aS/xF8JbkyUkmoaWsAcVvcI
   Q==;
X-CSE-ConnectionGUID: Y7lM29kXT8uaNwOUK7n24g==
X-CSE-MsgGUID: GtV+4pObSQ60yVegzzl5jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34494896"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="34494896"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 03:03:04 -0800
X-CSE-ConnectionGUID: ZfQNOrmrTEG+tfuQ7aStrw==
X-CSE-MsgGUID: +HyV8KuTR8KaMYL+KEGBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="96509774"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Dec 2024 03:03:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMPvH-000CrW-1E;
	Sat, 14 Dec 2024 11:02:59 +0000
Date: Sat, 14 Dec 2024 19:02:02 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: include/linux/ftrace.h:138:16: error: implicit declaration of
 function 'arch_ftrace_get_regs'; did you mean 'ftrace_get_regs'?
Message-ID: <202412141827.Xzmgi9eg-lkp@intel.com>
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
head:   a446e965a188ee8f745859e63ce046fe98577d45
commit: 7caa9765465f60b6d88e22264892cee12d971888 ftrace: riscv: move from REGS to ARGS
date:   7 months ago
config: riscv-randconfig-r133-20241214 (https://download.01.org/0day-ci/archive/20241214/202412141827.Xzmgi9eg-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241214/202412141827.Xzmgi9eg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412141827.Xzmgi9eg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
   include/linux/ftrace.h: In function 'ftrace_get_regs':
>> include/linux/ftrace.h:138:16: error: implicit declaration of function 'arch_ftrace_get_regs'; did you mean 'ftrace_get_regs'? [-Wimplicit-function-declaration]
     138 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                ftrace_get_regs
>> include/linux/ftrace.h:138:16: error: returning 'int' from a function with return type 'struct pt_regs *' makes pointer from integer without a cast [-Wint-conversion]
     138 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +138 include/linux/ftrace.h

d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  132) 
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  133) static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  134) {
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  135) 	if (!fregs)
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  136) 		return NULL;
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  137) 
02a474ca266a47e Steven Rostedt (VMware  2020-10-27 @138) 	return arch_ftrace_get_regs(fregs);
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  139) }
d19ad0775dcd64b Steven Rostedt (VMware  2020-10-28  140) 

:::::: The code at line 138 was first introduced by commit
:::::: 02a474ca266a47ea8f4d5a11f4ffa120f83730ad ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

