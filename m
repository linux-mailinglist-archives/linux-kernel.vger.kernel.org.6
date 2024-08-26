Return-Path: <linux-kernel+bounces-301291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BD95EEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CE1280A15
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05414A62F;
	Mon, 26 Aug 2024 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D20c+IbN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DF56B72
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669099; cv=none; b=KKsPUtL2UJNMSVr3NfUmCb8p0F9TT1vy5J9iyyWwEtKSm/b2IR7ZoqS/kTol1lWfeBWX9syP4RnOxOCbCnj74SDlktGczteKHO3Ee33uN2IfzKQMZ9Mv3ShRLjRQxgyW/Ze874Oq5TlvcGU66b04COHxHedpPrQI5GTgMr2aWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669099; c=relaxed/simple;
	bh=LAx3o7BI1oPkRwwdv4LldmT3Ey1D+edrru4HQfbSZBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lYkg5Lys2PmN9xq8ss5TCFz77W+l94JpcB0CKuVpBrKWt9465NKwGOK41UiXWwSfz6EsJZgC+e/ZMWnIb3we1EQOZPgjgSD9QK9qHy6YQx81/FhkigMdW0gbqOdj4n8xDOTDW5ILGwaH/EO/+//6XMnrKiqJZw1UhzNAfk2o7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D20c+IbN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724669098; x=1756205098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LAx3o7BI1oPkRwwdv4LldmT3Ey1D+edrru4HQfbSZBk=;
  b=D20c+IbN7g67QVErOLEI3Ug/Jg5MXvzI8mA5Oq642zi4f7oki26Ne9QD
   ZC5oxnVoWi7VRLsFXJY+QF/fRqCOhuvaGx3H08YXnl0NpR+DnYPvkPrm2
   Ev+L6XHRSJynB4nMaIb4jnpi1V7eG28gRnTdEWiXFRqdtK6kCteSQptQh
   iInZR0XnPOjH5XtP4A5Awuw/IFhdZj5fj2QTghcVN5SLKkeuU49Vt2Brp
   tm0A4fSolqdiqaM6PreGp5jQAoxmssDRvAlE6ioIQfqtpoJN5Ob9EgJOX
   t4Cppp+0CeeB5KB2oFxIT3OvyhEgTiOQ7PZUai2Q5Xbuh0uIlCjbbPy3Q
   A==;
X-CSE-ConnectionGUID: 2IKc87kLQxmt+uADsgyANQ==
X-CSE-MsgGUID: nG/pZ0qMSRabB1UctJbXGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33650097"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33650097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:44:58 -0700
X-CSE-ConnectionGUID: 9P0FTUsDReq2CAcg+/XU7g==
X-CSE-MsgGUID: +BvNdt9uRi2dSnLwo2ltFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62443088"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 03:44:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siXDR-000Gvn-2k;
	Mon, 26 Aug 2024 10:44:53 +0000
Date: Mon, 26 Aug 2024 18:44:17 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: include/linux/ftrace.h:138:16: error: returning 'int' from a
 function with return type 'struct pt_regs *' makes pointer from integer
 without a cast
Message-ID: <202408261838.hdkvXgaI-lkp@intel.com>
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
head:   5be63fc19fcaa4c236b307420483578a56986a37
commit: 7caa9765465f60b6d88e22264892cee12d971888 ftrace: riscv: move from REGS to ARGS
date:   3 months ago
config: riscv-randconfig-002-20240826 (https://download.01.org/0day-ci/archive/20240826/202408261838.hdkvXgaI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261838.hdkvXgaI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261838.hdkvXgaI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
   include/linux/ftrace.h: In function 'ftrace_get_regs':
   include/linux/ftrace.h:138:16: error: implicit declaration of function 'arch_ftrace_get_regs'; did you mean 'ftrace_get_regs'? [-Wimplicit-function-declaration]
     138 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                ftrace_get_regs
>> include/linux/ftrace.h:138:16: error: returning 'int' from a function with return type 'struct pt_regs *' makes pointer from integer without a cast [-Wint-conversion]
     138 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1 shuffle=2197832773
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2 shuffle=2197832773
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=2197832773
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=2197832773
   make: Target 'prepare' not remade because of errors.


vim +138 include/linux/ftrace.h

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

