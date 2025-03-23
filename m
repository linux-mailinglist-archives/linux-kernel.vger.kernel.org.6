Return-Path: <linux-kernel+bounces-572791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F2A6CEC9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A116D16E379
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2861FFC40;
	Sun, 23 Mar 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXf2jfCu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6F203719
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726041; cv=none; b=KyQdKvDPUn0O0lN2gWemDXrw93oh57Jo8aoLDWsJDaDYe/jrI9kPAd/qqP6BVJwAGqEXy7OOdVkwXzySXhGReX+WpH7HWIisOnz1LBbxRZs1qPN8fI6VWMC9Y6vGdFUuo1aB2uHI7feTgsutKFdnuZjtfvwLZtmvIPLxQzYJ7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726041; c=relaxed/simple;
	bh=GO2wdXrNPwEnpCN/dm5FDzfFQZbTCOavrxttmHtx0i8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+Dofv5WHbjECSpUd2M/nlF9lwPF248O86gWvXr6Q6rcLW8udhvG2FAHH/ODBxEXVAuIOoG0s2koSu7K5J8wASFRpb6F2NS70w2mj3B7SFpPuhD90UdEJqgpI4nQPaI5TdMbeEqHEmga2w1tnYFwYi6KB6Oubg4MlRTwwn3tyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXf2jfCu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742726038; x=1774262038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GO2wdXrNPwEnpCN/dm5FDzfFQZbTCOavrxttmHtx0i8=;
  b=gXf2jfCuXOuULGKK8+ZeEf99hDsRJIo3wrvLgCkFhqv7+BLwc3o/IPcA
   vKGcm0oHIsA5JUbjrztiMIU/4whXcMCBPV8DKqlu09jhEOKN3KGBF+aJv
   A/HwMYp5MxB7pT0pYIzo0qM9aLE3WuRiifEDvPiI0zkfs0wdVnBrSc0QV
   oOEuJWAHgdno8tr5RhGV49BDBX5xPvsaInfnxnX+w+vfDJwgeRvwabvAb
   Sd6tZAf4BwoDfQWSRSzbvtxdqFr/zJxX4Me/WSCxGYWMhXqGIVBW6x0JK
   +xImx/AHMKvKWnEUKdGck0I0sGMlZWFCU9OO7g/WFM34UpSV09FMd1Whk
   w==;
X-CSE-ConnectionGUID: gA65eO7bQ1KHNXADkGqIkA==
X-CSE-MsgGUID: xTlFwSNCRwqU17FYa4Urww==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="44052327"
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="44052327"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 03:33:58 -0700
X-CSE-ConnectionGUID: EjvZ8jEZToWXW1rU2unyYA==
X-CSE-MsgGUID: yB9qrIIAQBqgotnVTIhALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="123959134"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2025 03:33:56 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twIeQ-0002iB-0b;
	Sun, 23 Mar 2025 10:33:54 +0000
Date: Sun, 23 Mar 2025 18:33:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: include/linux/build_bug.h:78:41: error: static assertion failed:
 "XFS: sizeof(struct xfs_attr_sf_entry) is wrong, expected 3"
Message-ID: <202503231821.9gzWIqqd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Darrick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   586de92313fcab8ed84ac5f78f4d2aae2db92c59
commit: 13877bc79d81354c53e91f3c86ac0f7bafe3ba7b xfs: port ondisk structure checks from xfs/122 to the kernel
date:   5 months ago
config: arm-randconfig-r051-20250323 (https://download.01.org/0day-ci/archive/20250323/202503231821.9gzWIqqd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503231821.9gzWIqqd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503231821.9gzWIqqd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5:0,
                    from include/linux/list.h:5,
                    from include/linux/semaphore.h:11,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:26,
                    from fs/xfs/xfs_super.c:7:
   fs/xfs/libxfs/xfs_ondisk.h: In function 'xfs_check_ondisk_structs':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "XFS: sizeof(struct xfs_attr_sf_entry) is wrong, expected 3"
    #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                            ^
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
    #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                     ^~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:10:2: note: in expansion of macro 'static_assert'
     static_assert(sizeof(structname) == (size), \
     ^~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:133:2: note: in expansion of macro 'XFS_CHECK_STRUCT_SIZE'
     XFS_CHECK_STRUCT_SIZE(struct xfs_attr_sf_entry,  3);
     ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "XFS: sizeof(struct xfs_dir2_data_unused) is wrong, expected 6"
    #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                            ^
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
    #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                     ^~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:10:2: note: in expansion of macro 'static_assert'
     static_assert(sizeof(structname) == (size), \
     ^~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:136:2: note: in expansion of macro 'XFS_CHECK_STRUCT_SIZE'
     XFS_CHECK_STRUCT_SIZE(struct xfs_dir2_data_unused, 6);
     ^~~~~~~~~~~~~~~~~~~~~


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  
07a368b3f55a79 Maxim Levitsky   2022-10-25  80  

:::::: The code at line 78 was first introduced by commit
:::::: 6bab69c65013bed5fce9f101a64a84d0385b3946 build_bug.h: add wrapper for _Static_assert

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

