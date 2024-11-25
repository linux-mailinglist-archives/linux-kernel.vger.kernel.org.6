Return-Path: <linux-kernel+bounces-421286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686369D8A36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D70B6408B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A01B412E;
	Mon, 25 Nov 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMtKi5wv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F51B2196
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548067; cv=none; b=WiAoFgKLbAz4ATBhzB1dvXTxERYtRAcCSXBLjDIMNTfY0aR0R0h3R+Xvi1oIsWkOaas7aizrQ6pNAKmzZmW65w61lvxh+0ssSQMloIBDPahXccNFauZtUSoJmrQBjmsQbzpBvPGcxR4uhJiyzvCsMbk0MuMqJRd3n/d7SAA7lYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548067; c=relaxed/simple;
	bh=mZ7UmNGbQH6LAVjtDpB+Pzdf5fPMUu96wEc0ilJxwmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nWbO+VMw7CK3Y+7Gg9BsCapoGTAw+MmG3qpeA3Jay4V1eaSSk6BXrz+Y0g87/7eBVWVZWbtD/BNuO1KenPGI4CcOmS31BZLKnn4iFKqgZDBwPcOfImCWSaCARm49sO1CmK0WovuShd+1V93JPxSzObSJdLU1rHljOuoB75VNu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMtKi5wv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732548064; x=1764084064;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mZ7UmNGbQH6LAVjtDpB+Pzdf5fPMUu96wEc0ilJxwmU=;
  b=SMtKi5wvGGIFeSvRoC/MKXK0uBmPcFxOggr6aIq37+jsWpQqPZi3/F/f
   IjgoHtinU8wjFx6n3dNBVrDv20lBEe0T2m5Rxs5xWJAdqH2uPopFXn/2E
   6SHz5CqZpqcG7cSX2Zj15Pi4p5I+jxY9UAHFNYsDu8cT/S5SBKvfB+0Ge
   V1s8zUho7et0Hm8Uk8I9WKx0vymmz+mUT/A5HLmG5LjHg2B78QK0MZtKU
   ezXmUnYgma9p9WWa9pdf00qifDciNKx4s86Lgqm+rUdIU4iJl8iQ08sgM
   9wIgVz5AeQWFpLzufgfEpbWhO0s4wRmtUFj9Jy2njgEabeuLvHuQga/Yy
   w==;
X-CSE-ConnectionGUID: juqHosLuTb6ghDN4AxEoaQ==
X-CSE-MsgGUID: zeAjI0CUTyGU+x0D2FNkCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32519457"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32519457"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:21:04 -0800
X-CSE-ConnectionGUID: sVADAHU8QgqfFugyvPMIEw==
X-CSE-MsgGUID: lELuTLA4QWWJGKKm8SesxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="96361315"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2024 07:21:04 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFatZ-0006Xl-17;
	Mon, 25 Nov 2024 15:21:01 +0000
Date: Mon, 25 Nov 2024 23:20:58 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Makefile:63: warning: overriding recipe for target 'emit_tests'
Message-ID: <202411252319.jeYGwDJ4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f16d5e6f220661f73b36a4be1b21575651d8833
commit: 58b33e78a31782ffe25d404d5eba9a45fe636e27 selftests/powerpc: Fix emit_tests to work with run_kselftest.sh
date:   1 year, 2 months ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411252319.jeYGwDJ4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411252319.jeYGwDJ4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Makefile:63: warning: overriding recipe for target 'emit_tests'
   ../lib.mk:145: warning: ignoring old recipe for target 'emit_tests'
   make[1]: *** No targets.  Stop.
   make[1]: *** No targets specified and no makefile found.  Stop.


vim +/emit_tests +63 Makefile

3812b8c5c5d527 Masahiro Yamada 2019-02-22  59  
066b7ed9558087 Michal Marek    2014-07-04  60  # Beautify output
066b7ed9558087 Michal Marek    2014-07-04  61  # ---------------------------------------------------------------------------
066b7ed9558087 Michal Marek    2014-07-04  62  #
8962b6b475bddc Masahiro Yamada 2022-12-23 @63  # Most of build commands in Kbuild start with "cmd_". You can optionally define
8962b6b475bddc Masahiro Yamada 2022-12-23  64  # "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
8962b6b475bddc Masahiro Yamada 2022-12-23  65  # that command is printed by default.
066b7ed9558087 Michal Marek    2014-07-04  66  #
8962b6b475bddc Masahiro Yamada 2022-12-23  67  # e.g.)
8962b6b475bddc Masahiro Yamada 2022-12-23  68  #    quiet_cmd_depmod = DEPMOD  $(MODLIB)
8962b6b475bddc Masahiro Yamada 2022-12-23  69  #          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
066b7ed9558087 Michal Marek    2014-07-04  70  #
066b7ed9558087 Michal Marek    2014-07-04  71  # A simple variant is to prefix commands with $(Q) - that's useful
066b7ed9558087 Michal Marek    2014-07-04  72  # for commands that shall be hidden in non-verbose mode.
066b7ed9558087 Michal Marek    2014-07-04  73  #
8962b6b475bddc Masahiro Yamada 2022-12-23  74  #    $(Q)$(MAKE) $(build)=scripts/basic
066b7ed9558087 Michal Marek    2014-07-04  75  #
6ae4b9868a8f72 Masahiro Yamada 2022-12-23  76  # If KBUILD_VERBOSE contains 1, the whole command is echoed.
6ae4b9868a8f72 Masahiro Yamada 2022-12-23  77  # If KBUILD_VERBOSE contains 2, the reason for rebuilding is printed.
066b7ed9558087 Michal Marek    2014-07-04  78  #
^1da177e4c3f41 Linus Torvalds  2005-04-16  79  # To put more focus on warnings, be less verbose as default
^1da177e4c3f41 Linus Torvalds  2005-04-16  80  # Use 'make V=1' to see the full commands
^1da177e4c3f41 Linus Torvalds  2005-04-16  81  

:::::: The code at line 63 was first introduced by commit
:::::: 8962b6b475bddc011c414f40ffd02f0ed4e02771 kbuild: print short log in addition to the whole command with V=1

:::::: TO: Masahiro Yamada <masahiroy@kernel.org>
:::::: CC: Masahiro Yamada <masahiroy@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

