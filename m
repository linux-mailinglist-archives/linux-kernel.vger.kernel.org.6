Return-Path: <linux-kernel+bounces-524577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A9A3E4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5092189F5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D72641EB;
	Thu, 20 Feb 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNkYQmGm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D01F4E47
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078608; cv=none; b=FuVMmkPG63e0JLbdTzU0vasUgjVGSx3PzBFPaYVdegQgpxmV+kgiBvN0gmPblI1t+cDl5vosMUEGr0U5MzfIRLx7KtbkuCJT1npkZAfQS1vu0B4BNbeb+qxNX18EZ0BK+QVfkiZbmOS0XDiF4S0/qOQSs5GLBhK3AGKNMUoNBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078608; c=relaxed/simple;
	bh=1tQ9o+uMocsNfZfr+QWymv2tkD3cqVaa0pAMpmvmaKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cPBrgzr96wBI09KmUEouMhPbZTrvT9RCL6IA5cHxMLK1EohDchdUE/93s827TafpQ2g1VeQEEHkNDt7/Nx2univD6vZXt6uVUPJADIok+gzTYjRYez2yL6Yqdi2s+ZvQUorP0CTjXrQHi8OwPSkqHnPqQ/a8mIA+rMQzEwbj9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNkYQmGm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740078607; x=1771614607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1tQ9o+uMocsNfZfr+QWymv2tkD3cqVaa0pAMpmvmaKM=;
  b=RNkYQmGmuxi5wcHNQoFnlA/KBnrTVNeYB7VDTdozZbKeDC/pDAGJaj3i
   hbpUsusjzPJ6s14Gh3N/ObCjBZ+Y1tT3yBAiiXGnRKGz6PEKiJOcoNS/t
   8umU+8Gx1eL+cvIztzriu5Jwo4KEKZS1DddhJTeAlWAn8FbTGhqD20nYp
   GGIOE6mIcSemisaSz2MaZAXe3Ykk/d0i3DnSVCqE6vmwfR9b8uDGcuc8l
   IRwA6VuP0nc0rQ5ChNcd2NhurJmTi6oxz/DG8KRZPQ3NAO7SncI4tw+nZ
   XNzMjrBytjDAiy6mNuc++OyXTUq/eEtBvCxof9UsxZXi3hexFQ/R48yBL
   Q==;
X-CSE-ConnectionGUID: c9pT0HBvTiC+vYizYujn8g==
X-CSE-MsgGUID: oVfhKj9aTPmRbe+NyQomag==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40799634"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40799634"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 11:10:07 -0800
X-CSE-ConnectionGUID: cD+YAbxPS+qCXilJIL1H8g==
X-CSE-MsgGUID: v3ueY5nBQKymx7OJY0ZPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="119747548"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 20 Feb 2025 11:10:04 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlBvu-0004fZ-23;
	Thu, 20 Feb 2025 19:10:02 +0000
Date: Fri, 21 Feb 2025 03:09:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: include/linux/build_bug.h:78:41: error: static assertion failed:
 "XFS: sizeof(struct xfs_attr_sf_entry) is wrong, expected 3"
Message-ID: <202502210336.e9x8ZTh5-lkp@intel.com>
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
head:   e9a8cac0bf895efe0bc7b11d174e8dae9b195da8
commit: 13877bc79d81354c53e91f3c86ac0f7bafe3ba7b xfs: port ondisk structure checks from xfs/122 to the kernel
date:   4 months ago
config: arm-randconfig-003-20250221 (https://download.01.org/0day-ci/archive/20250221/202502210336.e9x8ZTh5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502210336.e9x8ZTh5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502210336.e9x8ZTh5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bitfield.h:10,
                    from include/linux/fortify-string.h:5,
                    from include/linux/string.h:390,
                    from include/linux/uuid.h:11,
                    from fs/xfs/xfs_linux.h:10,
                    from fs/xfs/xfs.h:26,
                    from fs/xfs/xfs_super.c:7:
   fs/xfs/libxfs/xfs_ondisk.h: In function 'xfs_check_ondisk_structs':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "XFS: sizeof(struct xfs_attr_sf_entry) is wrong, expected 3"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:10:9: note: in expansion of macro 'static_assert'
      10 |         static_assert(sizeof(structname) == (size), \
         |         ^~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:133:9: note: in expansion of macro 'XFS_CHECK_STRUCT_SIZE'
     133 |         XFS_CHECK_STRUCT_SIZE(struct xfs_attr_sf_entry,         3);
         |         ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "XFS: sizeof(struct xfs_dir2_data_unused) is wrong, expected 6"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:10:9: note: in expansion of macro 'static_assert'
      10 |         static_assert(sizeof(structname) == (size), \
         |         ^~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_ondisk.h:136:9: note: in expansion of macro 'XFS_CHECK_STRUCT_SIZE'
     136 |         XFS_CHECK_STRUCT_SIZE(struct xfs_dir2_data_unused,      6);
         |         ^~~~~~~~~~~~~~~~~~~~~


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

