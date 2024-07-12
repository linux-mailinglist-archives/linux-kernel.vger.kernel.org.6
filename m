Return-Path: <linux-kernel+bounces-250142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D392F4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C1F1C22793
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64DE1401B;
	Fri, 12 Jul 2024 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwmt9NdV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71424EADA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758490; cv=none; b=D24PBC8EDwXQgF/tAUyYqftBmfDk3gJtlqZ2F5J+oEXj70MbZwldwchJktgVm77HWxJClOp0CRHzbqBsbfZC7iS0+JToa2W24f+q3RW8kuOh8L/8b7Dt8cUZqKqOJ9zK3fHX+yN5sj0IgKNnxOfTB5e8SumUtHTapx0grEE49Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758490; c=relaxed/simple;
	bh=N+lG9PWVr5+B+GjIxsQ/8mEOh/EEPQLyJSD/1VbiLqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVlbvR6XXdzx4LrmzwlsW8qku3hiGGaVPBT02edLt/2vxCSuq8c0rmx7we4uGTIVgTRBh9lZPIqr8VwoB0hANHSFPeCTWyH0Xwj0hafW4FdKGvEO5G97xEyKeAGU2/nIZw4S50Q3LkwZ7uvnV84uj+6bETBvJafbirir7K2M8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwmt9NdV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720758488; x=1752294488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N+lG9PWVr5+B+GjIxsQ/8mEOh/EEPQLyJSD/1VbiLqs=;
  b=fwmt9NdVPG5sPnN0Kb3C90sFjXn+UyGUmQjG0RhWdwGHV+wTuMdyai9s
   VwtgcNyNkhSfSPA1++0K+zRL0RFfIbb9bTJ1Ipa3/9YhUVFckutv9QPCH
   hnpVr1Uu6F9/9/HHPvxr6eFfGpSxbU3ekFnwcAqFFvWfCDASG7RK1+GnV
   RguYWtTQCOxFNSUVp/e889k5G2xmtJSqrEPfWsDss2Kf6ecH79q/cd6em
   yOIivpWMnhYQWe1iy1wkpOyho3N5qXFIECljlVsLhUyUGReGHWQI0Ek3X
   5ALuz5ljeA0Onpu1JbfF+bpxVcDO80txwaqsdJVT4DWVKaU7P/W5RDkt2
   Q==;
X-CSE-ConnectionGUID: Smm5hkOPSAGPCmT/LVND8Q==
X-CSE-MsgGUID: WdYWHMkQT/qKdxubP5roFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29591608"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29591608"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 21:28:08 -0700
X-CSE-ConnectionGUID: Pewe7ZzLS5e782WAzyjfGA==
X-CSE-MsgGUID: uLDUAOgGT+Kmteh62fAFSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53980131"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Jul 2024 21:28:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sS7t4-000aK6-13;
	Fri, 12 Jul 2024 04:28:02 +0000
Date: Fri, 12 Jul 2024 12:27:21 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org, david@redhat.com,
	21cnbao@gmail.com, ryan.roberts@arm.com, ziy@nvidia.com,
	ioworker0@gmail.com, baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
Message-ID: <202407121206.GWdo7NlT-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240712/202407121206.GWdo7NlT-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407121206.GWdo7NlT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407121206.GWdo7NlT-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/shmem.c: In function 'shmem_getattr':
>> mm/shmem.c:1160:13: error: implicit declaration of function 'shmem_huge_global_enabled' [-Werror=implicit-function-declaration]
    1160 |         if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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

