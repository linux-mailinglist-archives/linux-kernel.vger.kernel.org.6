Return-Path: <linux-kernel+bounces-430620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1619E339C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189A9283FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720218872F;
	Wed,  4 Dec 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGl68+lr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE16187858
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294593; cv=none; b=CQvMI+tPA3GBa+nhddCP+9S1qEt9ncqNlv8BgSQLwSj5QvpwWUtD5xjvNto1oUX4gkM1iArRZsUJTTx/+Lc3msIAkf/+PN5y8zUvwa192rm65GWNUjsJUww98zmV3ASy2qkVAlUkUiggmLFIGfMi2rlS5GY8fs5n4+9sAXrMGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294593; c=relaxed/simple;
	bh=fqqG73XwFCvTGJ4c82NLgng5ayihNxg9MWkqhGyy1Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFq6mCQ08AtiJ37jwIL34TKywIWO8elDAzwKx8I8V0YjtKu/J0tl/XZi8C7PItxInyrensCN6Zu+W1ZnhKhzZ0fg5/J/qS72GqnXlzEhNDHY5KS3v6J1RX9vD8GDYr6gmMQ3GmFoe69f3fxxXvJEx8i44N2QGZ699UrFl8nwzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGl68+lr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733294591; x=1764830591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqqG73XwFCvTGJ4c82NLgng5ayihNxg9MWkqhGyy1Zs=;
  b=mGl68+lrfQiDvmwKzclBMSJ680OaHIzO/mAgQyla0maWclWJl1ZpWNwa
   SewHNrWz1MXz4mLdN7Oob1f7qTthZ4UXwDShquq62+mMGDBjXWb9m1XFv
   ntKufEhd/Lze02boXmOYyOxclVTbb2vEqpkr2koR+KcnRHl8xUBDxxRBw
   Xeg4evl0WaKfOm96E5NL7Q212fPx4sUd/j03fKs1yCf/U3GyLaPdIZR+9
   OIM5YOaJ+UFlE8akccTM/3WMD2+/QireYpKdAgHfdjR1sclR5yWC+4PZf
   LzqZBcEPUbyRyOs+FSYuAFbLVZEdCeKVHRJbTe4z2Vvks5HkYtonlcxgs
   w==;
X-CSE-ConnectionGUID: CdW4+0GUTY2NHPdbiMkHYg==
X-CSE-MsgGUID: NMyXmOG6SHGBI8AGpAvvAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32885434"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32885434"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 22:43:11 -0800
X-CSE-ConnectionGUID: q1NPSO0gS4mdcusKJ0rY6w==
X-CSE-MsgGUID: noI9eRa3S9WhlfU0186WDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="124602675"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2024 22:43:08 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIj6H-0002fp-1C;
	Wed, 04 Dec 2024 06:43:05 +0000
Date: Wed, 4 Dec 2024 14:42:17 +0800
From: kernel test robot <lkp@intel.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, suzuki.poulose@arm.com,
	mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org
Cc: oe-kbuild-all@lists.linux.dev, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH v2 2/9] coresight-etm4x: change etmv4_drvdata spinlock
 type to raw_spinlock_t
Message-ID: <202412041452.KCrCJWWm-lkp@intel.com>
References: <20241203114942.697188-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203114942.697188-3-yeoreum.yun@arm.com>

Hi Yeoreum,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yeoreum-Yun/coresight-change-coresight_device-lock-type-to-raw_spinlock_t/20241203-203214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241203114942.697188-3-yeoreum.yun%40arm.com
patch subject: [PATCH v2 2/9] coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
config: arm64-randconfig-001-20241204 (https://download.01.org/0day-ci/archive/20241204/202412041452.KCrCJWWm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041452.KCrCJWWm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041452.KCrCJWWm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-etm4x-core.c: In function 'etm4_starting_cpu':
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:1666:19: error: passing argument 1 of 'spin_lock' from incompatible pointer type [-Wincompatible-pointer-types]
    1666 |         spin_lock(&etmdrvdata[cpu]->spinlock);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                   |
         |                   raw_spinlock_t * {aka struct raw_spinlock *}
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/hwtracing/coresight/coresight-etm4x-core.c:6:
   include/linux/spinlock.h:349:51: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'raw_spinlock_t *' {aka 'struct raw_spinlock *'}
     349 | static __always_inline void spin_lock(spinlock_t *lock)
         |                                       ~~~~~~~~~~~~^~~~
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:1672:21: error: passing argument 1 of 'spin_unlock' from incompatible pointer type [-Wincompatible-pointer-types]
    1672 |         spin_unlock(&etmdrvdata[cpu]->spinlock);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                     |
         |                     raw_spinlock_t * {aka struct raw_spinlock *}
   include/linux/spinlock.h:389:53: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'raw_spinlock_t *' {aka 'struct raw_spinlock *'}
     389 | static __always_inline void spin_unlock(spinlock_t *lock)
         |                                         ~~~~~~~~~~~~^~~~
   drivers/hwtracing/coresight/coresight-etm4x-core.c: In function 'etm4_dying_cpu':
   drivers/hwtracing/coresight/coresight-etm4x-core.c:1681:19: error: passing argument 1 of 'spin_lock' from incompatible pointer type [-Wincompatible-pointer-types]
    1681 |         spin_lock(&etmdrvdata[cpu]->spinlock);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                   |
         |                   raw_spinlock_t * {aka struct raw_spinlock *}
   include/linux/spinlock.h:349:51: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'raw_spinlock_t *' {aka 'struct raw_spinlock *'}
     349 | static __always_inline void spin_lock(spinlock_t *lock)
         |                                       ~~~~~~~~~~~~^~~~
   drivers/hwtracing/coresight/coresight-etm4x-core.c:1684:21: error: passing argument 1 of 'spin_unlock' from incompatible pointer type [-Wincompatible-pointer-types]
    1684 |         spin_unlock(&etmdrvdata[cpu]->spinlock);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                     |
         |                     raw_spinlock_t * {aka struct raw_spinlock *}
   include/linux/spinlock.h:389:53: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'raw_spinlock_t *' {aka 'struct raw_spinlock *'}
     389 | static __always_inline void spin_unlock(spinlock_t *lock)
         |                                         ~~~~~~~~~~~~^~~~


vim +/spin_lock +1666 drivers/hwtracing/coresight/coresight-etm4x-core.c

2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1660  
58eb457be0283d drivers/hwtracing/coresight/coresight-etm4x.c      Sebastian Andrzej Siewior 2016-07-13  1661  static int etm4_starting_cpu(unsigned int cpu)
58eb457be0283d drivers/hwtracing/coresight/coresight-etm4x.c      Sebastian Andrzej Siewior 2016-07-13  1662  {
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1663  	if (!etmdrvdata[cpu])
58eb457be0283d drivers/hwtracing/coresight/coresight-etm4x.c      Sebastian Andrzej Siewior 2016-07-13  1664  		return 0;
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1665  
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13 @1666  	spin_lock(&etmdrvdata[cpu]->spinlock);
6d7651015c16e1 drivers/hwtracing/coresight/coresight-etm4x.c      Andrew Murray             2019-08-29  1667  	if (!etmdrvdata[cpu]->os_unlock)
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1668  		etm4_os_unlock(etmdrvdata[cpu]);
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1669  
c95c2733e5feb1 drivers/hwtracing/coresight/coresight-etm4x-core.c James Clark               2024-01-29  1670  	if (coresight_get_mode(etmdrvdata[cpu]->csdev))
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1671  		etm4_enable_hw(etmdrvdata[cpu]);
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13 @1672  	spin_unlock(&etmdrvdata[cpu]->spinlock);
58eb457be0283d drivers/hwtracing/coresight/coresight-etm4x.c      Sebastian Andrzej Siewior 2016-07-13  1673  	return 0;
58eb457be0283d drivers/hwtracing/coresight/coresight-etm4x.c      Sebastian Andrzej Siewior 2016-07-13  1674  }
2e1cdfe184b520 drivers/hwtracing/coresight/coresight-etm4x.c      Pratik Patel              2015-05-13  1675  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

