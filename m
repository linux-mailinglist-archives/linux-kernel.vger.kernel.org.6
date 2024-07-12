Return-Path: <linux-kernel+bounces-250104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296292F44A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A440A1F23E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E00125D6;
	Fri, 12 Jul 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEmg8zVP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A46D53F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753868; cv=none; b=YeSY5PEr5yvo6yzsCRUTKy1k5MvfiNrEAG5WVJNUZUu2Rr5jcNTeseUevJz3b0cGThTkFjD5aBsj33V5qen7GmAhyByw+Yi5mJqFR00+7r0ML+fd3qiRvgGscr8x5OftBJsJXRl/rHIBk6tqTC0N/KzQIMV0jG1oboQTDBBh64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753868; c=relaxed/simple;
	bh=aJVkxQ/xVk5L53c2YF4SBrKRia2Lv9rlLl7UvJoTx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2hPUle0DFK3nQgiAA0hf8vr22L1IlNyyJsppcFO8Q7vTwHKkHQVnk4hJw9WW53Q2hsChIaeNr+9CGCYZa3jhhQusp7xCdHJvhZp/IQ+6G7e3iItpRpGuYZ2h8upXDeT1XWX0hluYilRUbv02vVZnxB2pHLAntVpUmR8N8WeFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEmg8zVP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720753866; x=1752289866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJVkxQ/xVk5L53c2YF4SBrKRia2Lv9rlLl7UvJoTx7Q=;
  b=nEmg8zVPI+wHZSHCCNOX4OsPINN9uLAyiIoYSMxpWp0EJ33aiCPhPg1D
   9BJRalnKJbm78AGf5ABmmaAHHG02wqZM2lkuhWMK8yDRAMMrvVa8qaMIC
   DJaWckJl1GSn0Fzytev487edwMssX7Hk3rMFFgJGQYxbehFckz2LgoIl6
   fKFPrbmLyEyf80UdhegC+9GTmJkhX5tcVOce0MujPwPiFBpYMwdCUsaiC
   AVsrq0kR7uKco9UhUo6t2DJ9QxwO719Xz7mJDD1vTh8a94jaOTzWOoGTO
   xGh3N3Ac/iYjmyaZ2owgS4ohpQWFIFjpcKrLpLaWlU5mZJV01JOxpygtt
   w==;
X-CSE-ConnectionGUID: Fy8JFZzrSF+/u9WOiHRTfA==
X-CSE-MsgGUID: gf6/qaf7S1CPb+AFVKzJwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17888788"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="17888788"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:11:05 -0700
X-CSE-ConnectionGUID: 6GUNPpf2QqC6fMK+LkQWvQ==
X-CSE-MsgGUID: psOZ6S2lSDSga1uTussQJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48853841"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 20:11:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sS6gW-000aHm-2i;
	Fri, 12 Jul 2024 03:11:00 +0000
Date: Fri, 12 Jul 2024 11:10:59 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
	ryan.roberts@arm.com, ziy@nvidia.com, ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
Message-ID: <202407121052.Jbq6PSIi-lkp@intel.com>
References: <6e5858d345304d0428c1c2c2a25c289c062b4ea8.1720668581.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5858d345304d0428c1c2c2a25c289c062b4ea8.1720668581.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20240711]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-shmem-simplify-the-suitable-huge-orders-validation-for-tmpfs/20240711-134512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/6e5858d345304d0428c1c2c2a25c289c062b4ea8.1720668581.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH 3/3] mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240712/202407121052.Jbq6PSIi-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407121052.Jbq6PSIi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407121052.Jbq6PSIi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/shmem.c:1160:6: error: call to undeclared function 'shmem_huge_global_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1160 |         if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
         |             ^
   1 error generated.


vim +/shmem_huge_global_enabled +1160 mm/shmem.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  1138  
b74d24f7a74ffd Christian Brauner 2023-01-13  1139  static int shmem_getattr(struct mnt_idmap *idmap,
549c7297717c32 Christian Brauner 2021-01-21  1140  			 const struct path *path, struct kstat *stat,
a528d35e8bfcc5 David Howells     2017-01-31  1141  			 u32 request_mask, unsigned int query_flags)
44a30220bc0a17 Yu Zhao           2015-09-08  1142  {
a528d35e8bfcc5 David Howells     2017-01-31  1143  	struct inode *inode = path->dentry->d_inode;
44a30220bc0a17 Yu Zhao           2015-09-08  1144  	struct shmem_inode_info *info = SHMEM_I(inode);
44a30220bc0a17 Yu Zhao           2015-09-08  1145  
3c1b7528d8969a Hugh Dickins      2023-08-03  1146  	if (info->alloced - info->swapped != inode->i_mapping->nrpages)
3c1b7528d8969a Hugh Dickins      2023-08-03  1147  		shmem_recalc_inode(inode, 0, 0);
3c1b7528d8969a Hugh Dickins      2023-08-03  1148  
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1149  	if (info->fsflags & FS_APPEND_FL)
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1150  		stat->attributes |= STATX_ATTR_APPEND;
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1151  	if (info->fsflags & FS_IMMUTABLE_FL)
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1152  		stat->attributes |= STATX_ATTR_IMMUTABLE;
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1153  	if (info->fsflags & FS_NODUMP_FL)
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1154  		stat->attributes |= STATX_ATTR_NODUMP;
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1155  	stat->attributes_mask |= (STATX_ATTR_APPEND |
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1156  			STATX_ATTR_IMMUTABLE |
e408e695f5f1f6 Theodore Ts'o     2022-07-14  1157  			STATX_ATTR_NODUMP);
0d72b92883c651 Jeff Layton       2023-08-07  1158  	generic_fillattr(idmap, request_mask, inode, stat);
89fdcd262fd407 Yang Shi          2018-06-07  1159  
dca7b12ffe751b Baolin Wang       2024-07-11 @1160  	if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
89fdcd262fd407 Yang Shi          2018-06-07  1161  		stat->blksize = HPAGE_PMD_SIZE;
89fdcd262fd407 Yang Shi          2018-06-07  1162  
f7cd16a55837f3 Xavier Roche      2022-03-22  1163  	if (request_mask & STATX_BTIME) {
f7cd16a55837f3 Xavier Roche      2022-03-22  1164  		stat->result_mask |= STATX_BTIME;
f7cd16a55837f3 Xavier Roche      2022-03-22  1165  		stat->btime.tv_sec = info->i_crtime.tv_sec;
f7cd16a55837f3 Xavier Roche      2022-03-22  1166  		stat->btime.tv_nsec = info->i_crtime.tv_nsec;
f7cd16a55837f3 Xavier Roche      2022-03-22  1167  	}
f7cd16a55837f3 Xavier Roche      2022-03-22  1168  
44a30220bc0a17 Yu Zhao           2015-09-08  1169  	return 0;
44a30220bc0a17 Yu Zhao           2015-09-08  1170  }
44a30220bc0a17 Yu Zhao           2015-09-08  1171  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

