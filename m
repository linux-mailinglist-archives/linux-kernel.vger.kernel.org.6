Return-Path: <linux-kernel+bounces-539729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A474A4A7DA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AA03B487B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB414B08A;
	Sat,  1 Mar 2025 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwW1N7Xz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741F2E630
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794840; cv=none; b=SnW0ypOvUyc1LHkxAWnUHyexzN76fpvp6C9PH9Rnkf/n3sjoCxizGPKV1m/gelC8NW5oQtgvp9Oo+y3AyP92v7lWIbE9tH+Z0cRCqRGlvZyiyPXZNy+IhbaIc5NmWbA+e1NXj7detZSdgLqF2oUQSfIFDp2V2HYI0SxW00FjI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794840; c=relaxed/simple;
	bh=Fun3c2HmM01uE1jqmAUsfi8iqLHrsJHnU575A8aVb+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JhBU4FlYiRF5Rdj4oZckMTcvuwkxFqrYHG55r9gdtp6pJxdWXlFZ2q0sw1iSXLPsZDwj53Da1n3PjHHR1u1q723qsDPrCWze9kTMq1zv78bvDfr7VItSrWNQQleDHii2FWQh6V4YGKVpwHRfAvESvSenjxjcycystH3JN6/vAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwW1N7Xz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740794838; x=1772330838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fun3c2HmM01uE1jqmAUsfi8iqLHrsJHnU575A8aVb+0=;
  b=fwW1N7XzKMRdhBvf3j1Jc43UoB5NCe57zKyvmo60YRQPlsgu+5a7IJm6
   XAgswYLIKIGxrymtXKP5MQpJ5983dakKcL7QN4ezGue0Pi1RtCq0fd7hA
   ZDW+Wt3+3em5p+wmD71QBw2pbUIv7QoWlf0yk9ooLI+BVgksF8bA/mUId
   BQwM1sZY4eUA6scgkhK85RlrkqXRTpwylmYcdQC6lO/7icdrZUdO8S1vk
   VbNizuvmMHtLfbAyJtJ92zvaJluwcm7XZYRgaNuB2nrdqcChdkzPq/7Px
   lMR3PfROvBK/zNdHYV4f3qFvV7++4IwqdjPNIraTwNVYts4uaDU7vvwBZ
   w==;
X-CSE-ConnectionGUID: c7z0RvLlTOCcQ+lc+XY7nA==
X-CSE-MsgGUID: QglLO5zNQCm51VvnXvpkKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="40974929"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="40974929"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:07:17 -0800
X-CSE-ConnectionGUID: WcLB7NvWQYybUgAduPkCQA==
X-CSE-MsgGUID: lggFUKs9R1CXlgf7841lcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="122448726"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2025 18:07:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toCG1-000Fju-2i;
	Sat, 01 Mar 2025 02:07:13 +0000
Date: Sat, 1 Mar 2025 10:06:51 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/rtc/rtc-pl031.c:85: warning: Function parameter or struct
 member 'range_min' not described in 'pl031_vendor_data'
Message-ID: <202503011015.SYvdddTc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexandre,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c44ddaf7df3a06391684dde65083a092e06052b
commit: 03f2a0e45f395bc34b0a44105bc7e935bfd40c27 rtc: pl031: set range
date:   5 years ago
config: arm-randconfig-002-20240719 (https://download.01.org/0day-ci/archive/20250301/202503011015.SYvdddTc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503011015.SYvdddTc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503011015.SYvdddTc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-pl031.c:85: warning: Function parameter or struct member 'range_min' not described in 'pl031_vendor_data'
>> drivers/rtc/rtc-pl031.c:85: warning: Function parameter or struct member 'range_max' not described in 'pl031_vendor_data'


vim +85 drivers/rtc/rtc-pl031.c

8ae6e163c1b637 Deepak Saxena     2006-06-25  68  
aff05ed5d10352 Linus Walleij     2012-07-30  69  /**
aff05ed5d10352 Linus Walleij     2012-07-30  70   * struct pl031_vendor_data - per-vendor variations
aff05ed5d10352 Linus Walleij     2012-07-30  71   * @ops: the vendor-specific operations used on this silicon version
1bb457fc9268bb Linus Walleij     2012-07-30  72   * @clockwatch: if this is an ST Microelectronics silicon version with a
1bb457fc9268bb Linus Walleij     2012-07-30  73   *	clockwatch function
1bb457fc9268bb Linus Walleij     2012-07-30  74   * @st_weekday: if this is an ST Microelectronics silicon version that need
1bb457fc9268bb Linus Walleij     2012-07-30  75   *	the weekday fix
559a6fc0508392 Mattias Wallin    2012-07-30  76   * @irqflags: special IRQ flags per variant
aff05ed5d10352 Linus Walleij     2012-07-30  77   */
aff05ed5d10352 Linus Walleij     2012-07-30  78  struct pl031_vendor_data {
aff05ed5d10352 Linus Walleij     2012-07-30  79  	struct rtc_class_ops ops;
1bb457fc9268bb Linus Walleij     2012-07-30  80  	bool clockwatch;
1bb457fc9268bb Linus Walleij     2012-07-30  81  	bool st_weekday;
559a6fc0508392 Mattias Wallin    2012-07-30  82  	unsigned long irqflags;
03f2a0e45f395b Alexandre Belloni 2020-03-06  83  	time64_t range_min;
03f2a0e45f395b Alexandre Belloni 2020-03-06  84  	timeu64_t range_max;
aff05ed5d10352 Linus Walleij     2012-07-30 @85  };
aff05ed5d10352 Linus Walleij     2012-07-30  86  

:::::: The code at line 85 was first introduced by commit
:::::: aff05ed5d103524bd69bd9d7b621c5c8a6c63198 rtc: pl031: encapsulate per-vendor ops

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

