Return-Path: <linux-kernel+bounces-189587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE78CF278
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 04:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B5A2813B1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F6184D;
	Sun, 26 May 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1ZVDAUL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06117D2
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716692017; cv=none; b=CnNYTtfnaJq8dQgRDbMxR7xDspzJbNhldpbDULCrZM5IfYABhlQxtX6+AHpZe3URfRGTfr4LpiQIu743I6XX0q427JvEfX3C9/smJzq/RpalrutoTT0mxQRcU1RF8KZnm6CWSgjuxy8LUwn9cSumTCYCes1e/kuBTY3W67tGHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716692017; c=relaxed/simple;
	bh=/PZRYrQ8v15jSw1d79EUdiPU5x6HMmFuaUFSPW+aGC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RyAyUBbHP8FYQYFczlbNL7BQUas1o/ai6r8WdBgBLL2BsYVChheEKSBQnPBBIhWu+3AcispgH4+uOIMjlpKC+1p5fL2WNBCRIXn9sKiw21mgdOoCJnKaD/k/UGRf+piUWi3ruPi8tpQpTCWOTwKt/slxHdllHqqbD+kJ8VBby1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1ZVDAUL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716692016; x=1748228016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/PZRYrQ8v15jSw1d79EUdiPU5x6HMmFuaUFSPW+aGC8=;
  b=i1ZVDAULO8a/KofxwwUZgP7XK6D/4wQrVKGKQbN0e/v4ezRMP2c7Qbq4
   LxmPXg8crodyXyFkV4u+LRojynmPy/CsZIEZQ5F2bJFbgUYgupDWpLhrU
   r5JglzxISLcWc4zoCtyBMlDl7cuV2vFcvVl78+6FEycK1dV6jUN7abZr0
   9Cf88g9DOOQV2wjMQq5FOhq7wSNYOwagYStmg69d2BrpquzGOlN0JmGEJ
   ep+oOSzkBdzuWkOi3C2HGNAryv849ECY8hrRiQXVT6u5xKD7w7uG5Bwkt
   polTWAu1y04jVINBr1dHVUL0uIeDQlZ7/XlgDrSW+48ZTdVP1KxcFTZ49
   Q==;
X-CSE-ConnectionGUID: uESW/56ITnCrTfU9tazOGA==
X-CSE-MsgGUID: 0MCwhSorRfOs9fuloeeP5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="12872696"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="12872696"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 19:53:36 -0700
X-CSE-ConnectionGUID: 5R3s3wLjQCyxGOwXIYGdng==
X-CSE-MsgGUID: dV7LNIHsRUyOZIgs3eNj0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="34394717"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 May 2024 19:53:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB40p-0007fV-0z;
	Sun, 26 May 2024 02:53:31 +0000
Date: Sun, 26 May 2024 10:53:15 +0800
From: kernel test robot <lkp@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data757'
 from `drivers/cxl/core/mbox.o' being placed in section
 `.bss..Lubsan_data757'
Message-ID: <202405261005.ijPG0W0y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b62e02e63363f5678d5598ee7372064301587f7
commit: 6aec00139d3a83e2394d4bcb0084e872b4036e8f cxl/core: Add region info to cxl_general_media and cxl_dram events
date:   4 weeks ago
config: powerpc-randconfig-r001-20220109 (https://download.01.org/0day-ci/archive/20240526/202405261005.ijPG0W0y-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240526/202405261005.ijPG0W0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405261005.ijPG0W0y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data770' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data770'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data762' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data762'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data757' from `drivers/cxl/core/mbox.o' being placed in section `.bss..Lubsan_data757'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data756' from `drivers/cxl/core/mbox.o' being placed in section `.bss..Lubsan_data756'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data770' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data770'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data762' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data762'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data757' from `drivers/cxl/core/mbox.o' being placed in section `.bss..Lubsan_data757'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data756' from `drivers/cxl/core/mbox.o' being placed in section `.bss..Lubsan_data756'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data770' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data770'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data762' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data762'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data757' from `drivers/cxl/core/mbox.o' being placed in section `.bss..Lubsan_data757'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data756' from `drivers/cxl/core/mbox.o' being placed in section `.bss..Lubsan_data756'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

