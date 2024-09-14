Return-Path: <linux-kernel+bounces-329470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8D9791C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187081C212C8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732C1D0163;
	Sat, 14 Sep 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1BVokNa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46B1CFEB5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726326789; cv=none; b=mDcBhFGHUeAVeX26OGaYMtR/MNToF3XmadzI2EB4MWvTVFc94HsAQ1tQN/rbsIE25rBnvWY9yk2im1zoKWBF39ewwF05PvhUUEhwIPsxXAVenV/uq6QrHAQ4V1CpEttwa1/aAzbCLnZP9k4IdsHSpiTcgucN1Vb4CZZ3b5XncQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726326789; c=relaxed/simple;
	bh=M63WjdnzS1vanjNN0Ut26pFyhIL+utQ33M2kJCw6RFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kNA7ETSc5BZ+Zht4YXcDoylwVHKMpjL7SRPCn9z0WXmUYd/jkvMCCJCGFRDEP5hrvY1GSxZu1GtxPm6r5pFRlu6LaO7LyW5suzOvjNDRfuaaeVsRqY1sP+IqOQJLgGdT4YgRuzfIiCEr7Grgabtv7Ufu+5EpuY1CVQxHWjm8Ims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1BVokNa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726326787; x=1757862787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M63WjdnzS1vanjNN0Ut26pFyhIL+utQ33M2kJCw6RFs=;
  b=K1BVokNagJWv38JP+xdtMpaSG/X+KlCEyK55GmLbGQxl50oxtg+Gyp1e
   Od833xPj1M30ZbsrAwwlL2OMonwJmE7LhoCPA44WF3qfSCIWdMMjwBzWd
   WQcu34ARNw9OI0BBeWmagn+erh9iqmwnQU8F1ijAe8XD64ZEAdLq+IDg+
   bEPqUexQd3zgLzolmlTN96Cj9DLzGdZMiktVUba4XPzjetHcClFnd+Aom
   BEiTxGt6+V4ERPlpVEjKwUQn5dBGNimiiUpQTMdMKg4j4ljA00NPlqmKo
   SokJwWhuaqpo87dRkJTlgDLarjPHtHNy/NpLmIRH7tlqv0CDV0IZqIU6w
   A==;
X-CSE-ConnectionGUID: bB/5gKRBS8eXLCs6GXchBA==
X-CSE-MsgGUID: L9NLXijyR4uUR1Abk9XvCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25103796"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25103796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 08:13:06 -0700
X-CSE-ConnectionGUID: VaO8mIOlRj+sUYzyVCxy1A==
X-CSE-MsgGUID: QMwG1qLgSZGgvB5zdA3xzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68412482"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Sep 2024 08:13:05 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spUSN-0007sU-0C;
	Sat, 14 Sep 2024 15:13:03 +0000
Date: Sat, 14 Sep 2024 23:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240912 6/15]
 include/linux/compiler_types.h:517:45: error: call to
 '__compiletime_assert_838' declared with attribute error: BUILD_BUG_ON
 failed: conf->keylen < WLAN_KEY_LEN_CCMP
Message-ID: <202409142323.Q2pWjem4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240912
head:   f2ca068393cf1157c12ab08556b05824eec16511
commit: 7256c015db0178a6e2221d8f03b0d2fea660d9ea [6/15] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20240914/202409142323.Q2pWjem4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142323.Q2pWjem4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409142323.Q2pWjem4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_gtk_rekey':
>> include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_838' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:498:25: note: in definition of macro '__compiletime_assert'
     498 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:9: note: in expansion of macro 'BUILD_BUG_ON'
    2148 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
         |         ^~~~~~~~~~~~
>> include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_839' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:498:25: note: in definition of macro '__compiletime_assert'
     498 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:9: note: in expansion of macro 'BUILD_BUG_ON'
    2149 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
         |         ^~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [y]:
   - TI_K3_M4_REMOTEPROC [=y] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


vim +/__compiletime_assert_838 +517 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  503  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  504  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  505  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  506  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  507  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  508   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  509   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  510   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  512   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  513   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  514   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  515   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  516  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @517  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  518  

:::::: The code at line 517 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

