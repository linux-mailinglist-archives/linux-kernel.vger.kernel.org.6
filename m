Return-Path: <linux-kernel+bounces-292977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A71957757
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD63282576
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4231DC49B;
	Mon, 19 Aug 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hg/fM5N6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27461D54CA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105948; cv=none; b=mLc6fxJbJlumQd+ZqCeBB5A/QfyO/36XUbsAqyw14OJfhLD1UZN9YI4XJDy70l+DJ0RRJ9SOqZWG6j0ZeXwe/94v0FtQFB47DSA7hPuP+BXGSCJ/Lf1QwZUY73h+HVGzpozVn3wxX8QSBrnXrXabxfqTWBvl/cVzYvrdK5DpHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105948; c=relaxed/simple;
	bh=Z+tskT3uy5KR6/GeJqDdUC9AMjp73PmYsp8BD98iEC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TOAniOxiRrRShUUGbkntKJqkNQjqbJGjlrYJTrUDsgihvepmzm7WJw+2zOTcsZS0VmMxaz7YYtCJkcl7gkbK5FoxXe6KMcyNgtZDfN0fqWokiX4XfZTJcfB3dAtBUZHal3uukV8jGDtUNK4HtUNTzx5Iin58xhUQg7J2Xog1iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hg/fM5N6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724105946; x=1755641946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z+tskT3uy5KR6/GeJqDdUC9AMjp73PmYsp8BD98iEC4=;
  b=hg/fM5N6UtC8Rl8Uzt+URvXMceBwNEFdATjMq9ixuDRb2W6YnBVen9LB
   z6h5fBhzcn5XnEcmub/gWLwtzwztfoU/QUL/he80k3oLsn0zrQGSsIx31
   c+RW32w3nVW2qbtNRc1vL8L/v06b29tiFGjOswqCT9dE3Ws8VD4C5ItC9
   9lG8cCx5vLZHXMxomSLxFZbevf9iK/uvdC9WrbWDbVfEBEbsMznAUUOV0
   gWUtPOkjfNHYGHlCmO0TYg3aCt3NQqZ8jbt12tHyqLhL0tex/SROu6Gp9
   cD9eN6O04pDxJgW+dkKUdEaKWTNjM5GUzREUloN3q+xcRvC9Q/PWwJGER
   g==;
X-CSE-ConnectionGUID: +f2z9KabS96xYlebw8F6Rw==
X-CSE-MsgGUID: j40XiCajSVGas3Vx7vQCbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22001648"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22001648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:19:06 -0700
X-CSE-ConnectionGUID: usG+uN5nR3a+M9HsRiV4zw==
X-CSE-MsgGUID: PB1tFKewTDGfKGvVMo/4ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="91283108"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 15:19:05 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgAiN-0009UE-0M;
	Mon, 19 Aug 2024 22:19:03 +0000
Date: Tue, 20 Aug 2024 06:18:45 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/fs.h:3645:15: error: unexpected token, expected comma
Message-ID: <202408200611.zhKlMvry-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e4436539ae182dc86d57d13849862bcafaa4709
commit: 27a2d0cb2f38c67b58285e6124b14f7fff3fd1a8 stat: use vfs_empty_path() helper
date:   8 weeks ago
config: mips-randconfig-r111-20240819 (https://download.01.org/0day-ci/archive/20240820/202408200611.zhKlMvry-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce: (https://download.01.org/0day-ci/archive/20240820/202408200611.zhKlMvry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200611.zhKlMvry-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/stat.c:8:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/mips/include/asm/cacheflush.h:13:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/stat.c:8:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
>> include/linux/fs.h:3645:15: error: unexpected token, expected comma
    3645 |         if (unlikely(get_user(c, path)))
         |                      ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:177:23: note: expanded from macro '__get_user'
     177 |                 __get_data_asm((x), user_lb, __gu_ptr);                 \
         |                                     ^
   <inline asm>:3:10: note: instantiated into assembly here
       3 |         .set    eva
         |                    ^
   In file included from fs/stat.c:8:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
>> include/linux/fs.h:3645:15: error: invalid operand for instruction
    3645 |         if (unlikely(get_user(c, path)))
         |                      ^
   arch/mips/include/asm/uaccess.h:97:33: note: expanded from macro 'get_user'
      97 |         access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
         |                                        ^
   arch/mips/include/asm/uaccess.h:177:23: note: expanded from macro '__get_user'
     177 |                 __get_data_asm((x), user_lb, __gu_ptr);                 \
         |                                     ^
   <inline asm>:4:11: note: instantiated into assembly here
       4 |         lbe $21, 0($18)
         |                  ^
   1 warning and 2 errors generated.


vim +3645 include/linux/fs.h

90f8572b0f021f Eric W. Biederman 2015-06-29  3627  
45cd0faae3715e Amir Goldstein    2018-08-27  3628  /* mm/fadvise.c */
45cd0faae3715e Amir Goldstein    2018-08-27  3629  extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
45cd0faae3715e Amir Goldstein    2018-08-27  3630  		       int advice);
cf1ea0592dbf10 Jan Kara          2019-08-29  3631  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
cf1ea0592dbf10 Jan Kara          2019-08-29  3632  			   int advice);
45cd0faae3715e Amir Goldstein    2018-08-27  3633  
1bc6d4452d5c91 Christian Brauner 2024-04-30  3634  static inline bool vfs_empty_path(int dfd, const char __user *path)
1bc6d4452d5c91 Christian Brauner 2024-04-30  3635  {
1bc6d4452d5c91 Christian Brauner 2024-04-30  3636  	char c;
1bc6d4452d5c91 Christian Brauner 2024-04-30  3637  
1bc6d4452d5c91 Christian Brauner 2024-04-30  3638  	if (dfd < 0)
1bc6d4452d5c91 Christian Brauner 2024-04-30  3639  		return false;
1bc6d4452d5c91 Christian Brauner 2024-04-30  3640  
1bc6d4452d5c91 Christian Brauner 2024-04-30  3641  	/* We now allow NULL to be used for empty path. */
1bc6d4452d5c91 Christian Brauner 2024-04-30  3642  	if (!path)
1bc6d4452d5c91 Christian Brauner 2024-04-30  3643  		return true;
1bc6d4452d5c91 Christian Brauner 2024-04-30  3644  
1bc6d4452d5c91 Christian Brauner 2024-04-30 @3645  	if (unlikely(get_user(c, path)))
1bc6d4452d5c91 Christian Brauner 2024-04-30  3646  		return false;
1bc6d4452d5c91 Christian Brauner 2024-04-30  3647  
1bc6d4452d5c91 Christian Brauner 2024-04-30  3648  	return !c;
1bc6d4452d5c91 Christian Brauner 2024-04-30  3649  }
1bc6d4452d5c91 Christian Brauner 2024-04-30  3650  

:::::: The code at line 3645 was first introduced by commit
:::::: 1bc6d4452d5c91beb09e37a98a590808e1997b79 fs: new helper vfs_empty_path()

:::::: TO: Christian Brauner <brauner@kernel.org>
:::::: CC: Christian Brauner <brauner@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

