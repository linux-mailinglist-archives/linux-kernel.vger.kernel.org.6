Return-Path: <linux-kernel+bounces-369206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F49A1A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FF0B24BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0816FF26;
	Thu, 17 Oct 2024 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFeBewxO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5716DC28
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144684; cv=none; b=YpJ7ezaCCMrdEZrY6y3hdT3lSlC5qgaVOg1s70fCdlchnOyP/IRT22Ir3yzQTkgPJSRsdQ9mdhLfwQ6chuES5puOvYwsEm1Fc/2dhaZG8zEX28PtCVOyHrv9oTczDcomCcystVVU+bflGXYWlIu1uq5/MdOc9kpu4VrXNMBXc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144684; c=relaxed/simple;
	bh=7WGbA3PFXNlP2WRPHXjStDQq4aIrBsORJow5PEnGhaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L/7knNz0oQGlwQ5uN8B0dKgY1hxmzptGgFlqdNmZjdQhiNNopAP7C6oJoWyDXlWw40KOpazYSC4TvKmKbl5uxGVhtwzRMPbbEQ95H6W+LKCceZPzV/yE4egZfiV119zEm+orZ+pQnuBBfiKqfC3iYfjrBfIU3eQjG1EVuD1Ost4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFeBewxO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729144681; x=1760680681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7WGbA3PFXNlP2WRPHXjStDQq4aIrBsORJow5PEnGhaA=;
  b=fFeBewxOYGQ1bOpZ7+0uV0e//bP5QbmEWz5cT3rFNffEf2T7KS1VBKD9
   WupHyPRWqwcbzUiqpt6FqoI05P3uTTL8iGuWyfCKkfAUxKBZbyU55SoS6
   8TPzOcPLU/MRgHZbQu8gHAprpo8apFJHuv4i38B0UKr5Dl7FWOaPjcokz
   AdI+8ip63F1TwINUHUlQ9pFRnZ0o63EzQIZt4ey+eSLcqhi82B07hICwS
   Rvw85Ni7msSpaQcIgjzq8uee4CqnEX76xixzBdDSUin526dxYY6IpVrLM
   rkRK/1rfob2VmcIEVuJEeoPh8h4cHKIE52FpspEloVZHNBnEQN1mSrnle
   w==;
X-CSE-ConnectionGUID: LXGZ63bWRqOIPmRD24j6VQ==
X-CSE-MsgGUID: ++7+LDn3Qn+CZqfhffaBHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28821008"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28821008"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 22:58:00 -0700
X-CSE-ConnectionGUID: BCUVYuMwQXGv0hG4Z/JSFA==
X-CSE-MsgGUID: Ccyra/gyTyy9G5H5pNQBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83273201"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Oct 2024 22:57:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1JWG-000Lmf-1E;
	Thu, 17 Oct 2024 05:57:56 +0000
Date: Thu, 17 Oct 2024 13:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2 6/18]
 include/linux/compiler_types.h:517:45: error: call to
 '__compiletime_assert_854' declared with attribute error: BUILD_BUG_ON
 failed: conf->keylen < WLAN_KEY_LEN_CCMP
Message-ID: <202410171314.IhaS4oSI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
head:   41fe8a04339b3781dca5a8ba323ba77022acc441
commit: a1882510f2c31c9e3a9db8c138f5fa4b90eda0c8 [6/18] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20241017/202410171314.IhaS4oSI-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171314.IhaS4oSI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171314.IhaS4oSI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_gtk_rekey':
>> include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_854' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
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
>> include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_855' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
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


vim +/__compiletime_assert_854 +517 include/linux/compiler_types.h

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

