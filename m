Return-Path: <linux-kernel+bounces-540920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20586A4B672
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E362416B8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C0B19ADA4;
	Mon,  3 Mar 2025 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkQaCxBB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94ED17C210
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740971955; cv=none; b=S7HNyc5evrWeb5d4m/tSqMJlPbjPe6tmMXkaNzVwPp7l9A1YUqj45S61h5MowTHG2gu/9s1Fr09F05g8G5SQXMCi3NoUQdTNPdMwGAXJKc20izetAptEiQkxVHEnNzwiPDMKRYCgK4Z56HzloUzbq6yiEoJ0crZOZXBfJbDci8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740971955; c=relaxed/simple;
	bh=LpbJaumBcgre4NBn4OhRtfHLMsAu9iuCRYQuxGfvQF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I04aEhmbAoNicRTos5nuemwF1vu7pn55diSui+5bFx32iBff7RRMWBShi8QxL8JPXESqm/tog21YvPlf1wQrwF/pM4A9DDrwElPR9wKsylTTq1PFAfgV5lnl4Syuli97OGXT+N8b+ZAUVC0Elg2aUv1e+2w7vTQSXkcfgJkZ5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkQaCxBB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740971954; x=1772507954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpbJaumBcgre4NBn4OhRtfHLMsAu9iuCRYQuxGfvQF8=;
  b=JkQaCxBBHYIVC45+g18FmZOdDnXEsgXy5pu0TwGjzw00jcU0vVLVvu1F
   fui3IsdBWcOgxf985TT1kEdykPDGJQkckYqS8ux9hvo1RbmwgY6oFV5Ug
   A9o7zVGfU7S3sBuTI82SrwD+hsarvFm6Mmh85P4IhloXNULa47UYvNmm1
   R7XcqomMDfsuj9bW5nEapviiHHgqXKgfAONtLpZXzraYSTwb64w1gkbYR
   QKwbzgsbr5XuSZyb5KeHHGrUcUlsUgzyu4oZ76c9EgjBH0uLv9p4LBfs1
   xTkPks25p6ffmu8nVLQyU3AiZQeDyZNap+w6nlt6WhZ6IGPje5gYHLLzd
   g==;
X-CSE-ConnectionGUID: ww1kjCzLQMCQlGMq7fvZRA==
X-CSE-MsgGUID: aHi82wXnQmOyB2SMSQS83w==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="45761604"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="45761604"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:19:13 -0800
X-CSE-ConnectionGUID: K6c59+FjQxiurRjuHKDVCw==
X-CSE-MsgGUID: nL3hLtZISvanyYlJjmZreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122012073"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Mar 2025 19:19:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1towKi-000HsF-2X;
	Mon, 03 Mar 2025 03:19:08 +0000
Date: Mon, 3 Mar 2025 11:19:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>,
	parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: Re: [PATCH] staging: most: Remove unused spinlock from most_video_dev
Message-ID: <202503031028.7ZRlzYcI-lkp@intel.com>
References: <20250221163444.57492-3-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163444.57492-3-kumarkairiravi@gmail.com>

Hi Ravi,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Ravi-Kumar-kairi/staging-most-Remove-unused-spinlock-from-most_video_dev/20250222-004552
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250221163444.57492-3-kumarkairiravi%40gmail.com
patch subject: [PATCH] staging: most: Remove unused spinlock from most_video_dev
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250303/202503031028.7ZRlzYcI-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503031028.7ZRlzYcI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503031028.7ZRlzYcI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/most/video/video.c:130:23: error: no member named 'list_lock' in 'struct most_video_dev'
     130 |         spin_lock_irq(&mdev->list_lock);
         |                        ~~~~  ^
   drivers/staging/most/video/video.c:134:26: error: no member named 'list_lock' in 'struct most_video_dev'
     134 |                 spin_unlock_irq(&mdev->list_lock);
         |                                  ~~~~  ^
   drivers/staging/most/video/video.c:136:24: error: no member named 'list_lock' in 'struct most_video_dev'
     136 |                 spin_lock_irq(&mdev->list_lock);
         |                                ~~~~  ^
   drivers/staging/most/video/video.c:138:25: error: no member named 'list_lock' in 'struct most_video_dev'
     138 |         spin_unlock_irq(&mdev->list_lock);
         |                          ~~~~  ^
   drivers/staging/most/video/video.c:191:25: error: no member named 'list_lock' in 'struct most_video_dev'
     191 |                         spin_lock_irq(&mdev->list_lock);
         |                                        ~~~~  ^
   drivers/staging/most/video/video.c:193:27: error: no member named 'list_lock' in 'struct most_video_dev'
     193 |                         spin_unlock_irq(&mdev->list_lock);
         |                                          ~~~~  ^
   drivers/staging/most/video/video.c:392:27: error: no member named 'list_lock' in 'struct most_video_dev'
     392 |         spin_lock_irqsave(&mdev->list_lock, flags);
         |                            ~~~~  ^
   include/linux/spinlock.h:381:39: note: expanded from macro 'spin_lock_irqsave'
     381 |         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
         |                                              ^~~~
   include/linux/spinlock.h:244:34: note: expanded from macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   drivers/staging/most/video/video.c:394:33: error: no member named 'list_lock' in 'struct most_video_dev'
     394 |                 spin_unlock_irqrestore(&mdev->list_lock, flags);
         |                                         ~~~~  ^
   drivers/staging/most/video/video.c:399:32: error: no member named 'list_lock' in 'struct most_video_dev'
     399 |         spin_unlock_irqrestore(&mdev->list_lock, flags);
         |                                 ~~~~  ^
   drivers/staging/most/video/video.c:477:24: error: no member named 'list_lock' in 'struct most_video_dev'
     477 |         spin_lock_init(&mdev->list_lock);
         |                         ~~~~  ^
   include/linux/spinlock.h:335:38: note: expanded from macro 'spin_lock_init'
     335 |         __raw_spin_lock_init(spinlock_check(lock),              \
         |                                             ^~~~
   10 errors generated.


vim +130 drivers/staging/most/video/video.c

3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  114  
1b10a0316e2d5e drivers/staging/most/video/video.c    Christian Gromm 2017-11-21  115  static int comp_vdev_close(struct file *filp)
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  116  {
1b10a0316e2d5e drivers/staging/most/video/video.c    Christian Gromm 2017-11-21  117  	struct comp_fh *fh = filp->private_data;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  118  	struct most_video_dev *mdev = fh->mdev;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  119  	struct mbo *mbo, *tmp;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  120  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  121  	/*
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  122  	 * We need to put MBOs back before we call most_stop_channel()
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  123  	 * to deallocate MBOs.
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  124  	 * From the other hand mostcore still calling rx_completion()
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  125  	 * to deliver MBOs until most_stop_channel() is called.
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  126  	 * Use mute to work around this issue.
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  127  	 * This must be implemented in core.
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  128  	 */
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  129  
e494df039df0fc drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06 @130  	spin_lock_irq(&mdev->list_lock);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  131  	mdev->mute = true;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  132  	list_for_each_entry_safe(mbo, tmp, &mdev->pending_mbos, list) {
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  133  		list_del(&mbo->list);
e494df039df0fc drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  134  		spin_unlock_irq(&mdev->list_lock);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  135  		most_put_mbo(mbo);
e494df039df0fc drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  136  		spin_lock_irq(&mdev->list_lock);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  137  	}
e494df039df0fc drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  138  	spin_unlock_irq(&mdev->list_lock);
1b10a0316e2d5e drivers/staging/most/video/video.c    Christian Gromm 2017-11-21  139  	most_stop_channel(mdev->iface, mdev->ch_idx, &comp);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  140  	mdev->mute = false;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  141  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  142  	v4l2_fh_del(&fh->fh);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  143  	v4l2_fh_exit(&fh->fh);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  144  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  145  	atomic_dec(&mdev->access_ref);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  146  	kfree(fh);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  147  	return 0;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  148  }
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  149  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

