Return-Path: <linux-kernel+bounces-292853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1AB957546
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EA91F22955
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC018E0E;
	Mon, 19 Aug 2024 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0e1jQRX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3D17837E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098025; cv=none; b=fxu+KD6xfz95KJVbRI8nT1I6dlLzFFQnZKN06NUx7b7thV0QXyFMSG9QV0K/9+INuwEnj/0SIP8YBDQSZ4XwpuyS3OqF0qJUzTto3XU8Z4SCXwYVOPbbHXS+nPYi5rZeb6DjLQp2S+UXm7yocSdrzgDMP04dg15Nvyj4Q3lotl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098025; c=relaxed/simple;
	bh=0ev9mPI2krLYItOT7qf8DVewhtCJwdLKCP8duyfGv1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZHQUiadEjHyJvo5UZ0rKX20Ib3Z6R/1AQ2DFUlXexypuicP4I6z1d8T7HYhz+H5CnY1BrJtHt489k0nNCrD0RpnO3ADdgsrerSeILWp5loRS72B8Fn9dDCpg4aEpioOQg5O+dMQLFg7VIgT/Mv+BqnxhmzimI4JqAHgB4RIH9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0e1jQRX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724098023; x=1755634023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ev9mPI2krLYItOT7qf8DVewhtCJwdLKCP8duyfGv1s=;
  b=P0e1jQRXYs7jLi/w9AHGPxtsln6GHM6Zj2ZoIhKw5m09ApOMiRwx0Wsr
   QZlFEFDSY5CuJOlJ55NheM8pf2qijcVbhpEIiibtvpMs7tfTOwRZcFOTt
   6Rhx3HnwCkcv+BN+BWYkxycf6U7NkLC1WEfzWNH+Uow7EBYoW+QEuW43d
   R9HfP1d55W3JVhn5BvImH8IvILwYQSP++ryQ7aELMIQbwj9SBOWRDI0eD
   Khq+YdvdT727UiU01w+IUzA/UT8nUWmdgB0HMN4VAdS53iL7iMLjw8R9j
   lFFs861eeJ+COVmJV4t3QHVOqCEE6TjxdHDmIk7eE2T1gBVVDnfTRhDat
   Q==;
X-CSE-ConnectionGUID: 8JSZ6KDiQsiYA9Q6cYG9WA==
X-CSE-MsgGUID: +1zDyaSeRCysfkgUrplH/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="32990208"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="32990208"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 13:07:03 -0700
X-CSE-ConnectionGUID: sUX7hVRnS56HqsVc7SIpNg==
X-CSE-MsgGUID: /8pBWARzSm6a/jMfHBFoIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="91254200"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 13:07:01 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg8eZ-0009OQ-0w;
	Mon, 19 Aug 2024 20:06:59 +0000
Date: Tue, 20 Aug 2024 04:06:08 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Kaechele <felix@kaechele.ca>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/touchscreen/himax_hx83112b.c:125:42-48: ERROR:
 application of sizeof to pointer
Message-ID: <202408200301.Ujpj7Vov-lkp@intel.com>
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
commit: 0944829d491e0f342924154d2e58c6b2e61e3595 Input: himax_hx83112b - implement MCU register reading
date:   6 weeks ago
config: sparc64-randconfig-r051-20240819 (https://download.01.org/0day-ci/archive/20240820/202408200301.Ujpj7Vov-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200301.Ujpj7Vov-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/himax_hx83112b.c:125:42-48: ERROR: application of sizeof to pointer

vim +125 drivers/input/touchscreen/himax_hx83112b.c

   120	
   121	static int himax_read_mcu(struct himax_ts_data *ts, u32 address, u32 *dst)
   122	{
   123		int error;
   124	
 > 125		error = himax_bus_read(ts, address, dst, sizeof(dst));
   126		if (error)
   127			return error;
   128	
   129		return 0;
   130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

