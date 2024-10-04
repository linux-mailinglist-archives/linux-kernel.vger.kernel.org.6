Return-Path: <linux-kernel+bounces-351485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E729911DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193BF1C22BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573F71B4F29;
	Fri,  4 Oct 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VymJ0TiF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E51AE01B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078948; cv=none; b=PghMqf18YxEJoUbWLi2ItrqUi0b9ftyxT/TZ7CikyEg2jKbTY/QdoCP3hSiE8peQDxk2gEB0/K1RXX4cVycHtid/fAKKAsPiWnm3kzBiuMP0D79XcFE2gug+fn6vr4X0btRIymoHES8yXqUThvdR3GROR+BNtcAXbVyWVuTORLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078948; c=relaxed/simple;
	bh=3L1EAFUCpy1XkhePsBGVZmANkMvxggeQrV7dmfN/Yg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ProI4HdVWyNWvr34Z36bwa4DfOa72LBicNMIddyjBZzgB5xy3D/ZOsJwG7OD1v80BZqPImF9mPYSoJSAD1eiEXc7NXyVN9yWm17k2HPj+AKyu6F6C1DOV7L8E2H2AzFF9pnaggCh5PaTuIhs0uB8bsSdqy0GHt5vryuFLIu4yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VymJ0TiF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728078947; x=1759614947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3L1EAFUCpy1XkhePsBGVZmANkMvxggeQrV7dmfN/Yg8=;
  b=VymJ0TiFc6TzlSvf1CCAhWyub+JwcKfN3710pqFPw1D4624y1PimP/kY
   V8LvdRI1gZGG1O/h+TwQWQeEuPSXVsl0l3/ezvdEH/qKLaaK+o2LT8XYB
   JvUzBXqpuaLzWncXGisR3O6EOMCfgHI4XY13JD2YeV4bgTSgiuVbo+QOk
   0yRUvwjZKulTHFvMIvyZUDN6hQ4zxXRImv0s8jMOrSDFP3+HWRM42+4rW
   zYJ/DtdxWWU0YaYSt7JaKVlLkKOL/msL1EBg/KC7mMoVC2pvdXZ7VPq7Q
   RWZ/n8BM1iW14g1WqdiORN0hopMJuc23iJR4ynvqlJoAr8C69B7D4Yhn1
   g==;
X-CSE-ConnectionGUID: cV7/I/W2SQ+vPrNIdOQPPQ==
X-CSE-MsgGUID: GEkiqMjURSCcIT4/CsK6eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27199047"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27199047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:55:44 -0700
X-CSE-ConnectionGUID: wP/fCRm4TZmHmkRVzJTvcg==
X-CSE-MsgGUID: /jR8oDpdTjW2zqyhGN2JdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="98145789"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Oct 2024 14:55:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swqGz-0002G4-02;
	Fri, 04 Oct 2024 21:55:41 +0000
Date: Sat, 5 Oct 2024 05:55:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241003 6/14]
 include/linux/compiler_types.h:517:45: error: call to
 '__compiletime_assert_851' declared with attribute error: BUILD_BUG_ON
 failed: conf->keylen < WLAN_KEY_LEN_CCMP
Message-ID: <202410050539.6IQmNBHb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241003
head:   ec64acf2dce7577a42c01241e78b24afebc26e96
commit: e99409254091557e1e28e56900da37395bed8163 [6/14] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20241005/202410050539.6IQmNBHb-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050539.6IQmNBHb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050539.6IQmNBHb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_gtk_rekey':
>> include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_851' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
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
>> include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_852' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
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


vim +/__compiletime_assert_851 +517 include/linux/compiler_types.h

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

