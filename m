Return-Path: <linux-kernel+bounces-541078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32438A4B827
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE2816D79C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC21E98F4;
	Mon,  3 Mar 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLWznx9Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6213D539
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985968; cv=none; b=flKnXi8DzvQ8JEoHwzHtgYbQvCngs3dI/WJuxdq86W8mFf6jyWRSZBLfjjC3BFEDyPdVldLaOlkd52xTtQ0Wczh+V9OvgNupLmFFzKsV1WQHdYFwIC3O2cZsM2fiW9RhVb24hzYMY8XVF342eGYC7E8GIcWA9ud5go4i6LmT08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985968; c=relaxed/simple;
	bh=Bm40aZPKh+7xNA+sXqZ7uh5Cs/1UdisbSRks9+IkP4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ0vkMbnIhA5NDM/rKjQQCR/TUnTB4jHfDE+pIHtk2jgUBcXYFedxP//Fy4lgxDL7Tz46qklROYoh/3H5q2F4KURx2UO25dJt4jH78bndceE3reybJCnfozSmFrzQ7BckGfrK9OEVfqprS1mDnpUehYrtn6S4V3V2h17LeZZdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLWznx9Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740985965; x=1772521965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bm40aZPKh+7xNA+sXqZ7uh5Cs/1UdisbSRks9+IkP4U=;
  b=mLWznx9ZFnk1ReyXCsXUOsL3/M38sP1C0dZr55Gfs3ZVjd6qLjPiH/TN
   ZeGM2Y3f3nqJ9K2xRN0wIQ2H1YCM6MMsKdllc0EkiApFjbLEzH+OyD2fv
   AAqNRfFGTSRjbOurLfVUR8TfFL2ThwaYk+I0eOKy1TIUTzj/TgCvDnu86
   n2VpSdXe46TGU5LQGyLdKGXFvGcYKtCvDQ20n94iTEawW/ZbOn6uRaZO1
   BViZWkILXs0yKVIlsMajwPd0D9zbfUM2+VNEiqsorFR5zgxE1xP52miPm
   mDKU3iTFCUjwZhMckWGZl8zVHxvZ55PtILLtKDPreQdQyXOwClgrfv/+W
   A==;
X-CSE-ConnectionGUID: yob2IyOuS/e2ou6jhtj7XA==
X-CSE-MsgGUID: bIh0bAUsSJ2qABXDydsOzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="59262029"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="59262029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:12:45 -0800
X-CSE-ConnectionGUID: eH7cdqHvTBCEWqu9TnH3Cw==
X-CSE-MsgGUID: JnDxc/ChS9+imSM3RQ0Pmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118467223"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Mar 2025 23:12:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tozyi-000I8v-2A;
	Mon, 03 Mar 2025 07:12:40 +0000
Date: Mon, 3 Mar 2025 15:12:03 +0800
From: kernel test robot <lkp@intel.com>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>,
	parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: Re: [PATCH] staging: most: Remove unused mutex from most_video_dev
Message-ID: <202503031448.eqB11EdG-lkp@intel.com>
References: <20250221163444.57492-2-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163444.57492-2-kumarkairiravi@gmail.com>

Hi Ravi,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Ravi-Kumar-kairi/staging-most-Remove-unused-mutex-from-most_video_dev/20250222-004322
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250221163444.57492-2-kumarkairiravi%40gmail.com
patch subject: [PATCH] staging: most: Remove unused mutex from most_video_dev
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250303/202503031448.eqB11EdG-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503031448.eqB11EdG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503031448.eqB11EdG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/most/video/video.c:417:28: error: no member named 'lock' in 'struct most_video_dev'
     417 |         mdev->vdev->lock = &mdev->lock;
         |                             ~~~~  ^
   drivers/staging/most/video/video.c:474:20: error: no member named 'lock' in 'struct most_video_dev'
     474 |         mutex_init(&mdev->lock);
         |                     ~~~~  ^
   include/linux/mutex.h:64:16: note: expanded from macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                       ^~~~~
   2 errors generated.


vim +417 drivers/staging/most/video/video.c

3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  402  
1b10a0316e2d5e drivers/staging/most/video/video.c    Christian Gromm 2017-11-21  403  static int comp_register_videodev(struct most_video_dev *mdev)
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  404  {
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  405  	int ret;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  406  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  407  	init_waitqueue_head(&mdev->wait_data);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  408  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  409  	/* allocate and fill v4l2 video struct */
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  410  	mdev->vdev = video_device_alloc();
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  411  	if (!mdev->vdev)
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  412  		return -ENOMEM;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  413  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  414  	/* Fill the video capture device struct */
1b10a0316e2d5e drivers/staging/most/video/video.c    Christian Gromm 2017-11-21  415  	*mdev->vdev = comp_videodev_template;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  416  	mdev->vdev->v4l2_dev = &mdev->v4l2_dev;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24 @417  	mdev->vdev->lock = &mdev->lock;
323977d5d33a8d drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  418  	snprintf(mdev->vdev->name, sizeof(mdev->vdev->name), "MOST: %s",
323977d5d33a8d drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  419  		 mdev->v4l2_dev.name);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  420  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  421  	/* Register the v4l2 device */
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  422  	video_set_drvdata(mdev->vdev, mdev);
e653614ee1832c drivers/staging/most/video/video.c    Hans Verkuil    2020-02-03  423  	ret = video_register_device(mdev->vdev, VFL_TYPE_VIDEO, -1);
b23e8e51e6dc40 drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  424  	if (ret) {
8f6f9ed15d679a drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  425  		v4l2_err(&mdev->v4l2_dev, "video_register_device failed (%d)\n",
b23e8e51e6dc40 drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  426  			 ret);
eab231c0398a91 drivers/staging/most/aim-v4l2/video.c Christian Gromm 2016-06-06  427  		video_device_release(mdev->vdev);
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  428  	}
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  429  
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  430  	return ret;
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  431  }
3d31c0cb6c127b drivers/staging/most/aim-v4l2/video.c Christian Gromm 2015-07-24  432  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

