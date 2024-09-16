Return-Path: <linux-kernel+bounces-330919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963097A61E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89727B2939D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01D15B572;
	Mon, 16 Sep 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiHimL7F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C301311A7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504401; cv=none; b=ctwA1rs599jqQ5OC/4VwXKJTKVDyMPR9iuzUufk6dPvc9aHyTSIKfrpDfWMHc3uO8gDQG/Lvxs40pfwzVzd8V4P566dl/rkK+O3VRLCehKUY7XxGVH8Yo5mEaVzbtTAskZ6HUQRFFodnYCOHWKlI0wizocdVPe0H5aLZthGhXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504401; c=relaxed/simple;
	bh=mq3rGkNnTrDHmMGqZYRWprW/DLnaAITvziTMVT5g5HE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GWv3R5aqaY9ARAo3X8RBrTkAISr/6qIjyQaHoI3Ph73F9l1zxzRk3QySA+NoIpsH719Ivdn3HsF/Li/YRjZuG+IvemXb0RMyiDv6DVW3yS/bNmzt97Dfb4nl6wFS1iISBxVNNLfR62x40mAkCnwi6eOUreqtkJDz+ic65QPWj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiHimL7F; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726504399; x=1758040399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mq3rGkNnTrDHmMGqZYRWprW/DLnaAITvziTMVT5g5HE=;
  b=TiHimL7FEVxACDKCf1KdkMKES0C5hj7pTu/dCaft3X0f3jlxSXLkj8e0
   vVo6i15zDhlaz/F/XtTd+VDgJJI3Air3ARXfr/DnYiDY3AFnT0sCIA6M5
   6j+VTgclgmZEM8Rd0GntQ1iZTrrzY93aEq5P5eB23UvDQ1qMU8aeSQTkE
   ljYmSRqZsWArGrxhABj4xFSZAVVTWtq4wXyn0WMsrtZkGxeTs8NEoa/VS
   QtrE8o4rauXHNAB1sKF/Gwc7FfjqSiMNSKxTB7SmaYxWmzwWIAZIvfqqL
   SWuqPDPRNfVU9OGah/2hpSmnB8nRRi1v3wVo/FEC+7RlU0Y9ZmVuJGiJ2
   g==;
X-CSE-ConnectionGUID: Swz7+ciWTZa9iI26N9GyEA==
X-CSE-MsgGUID: NuBoWJ3aTpyzs6xol40oXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="29125338"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="29125338"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:33:18 -0700
X-CSE-ConnectionGUID: jO5TMxdUQTmFjqIyEp+LDQ==
X-CSE-MsgGUID: 4KYDDckiSfOEpckrRJGtng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68547468"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Sep 2024 09:33:16 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqEf4-000AHy-0e;
	Mon, 16 Sep 2024 16:33:14 +0000
Date: Tue, 17 Sep 2024 00:32:20 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Scott Wood <oss@buserror.net>
Subject: powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:undefined reference
 to `cpm1_gpiochip_add16'
Message-ID: <202409170011.3W7RFE5J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
commit: c095ff93f901c1620b28dce4d813dd548bc5236b powerpc/sysdev: change CPM GPIO to platform_device
date:   7 years ago
config: powerpc-randconfig-r053-20240916 (https://download.01.org/0day-ci/archive/20240917/202409170011.3W7RFE5J-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240917/202409170011.3W7RFE5J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409170011.3W7RFE5J-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_export.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_extent_busy.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_extent_busy.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_file.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_file.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_filestream.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_filestream.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_fsmap.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_fsmap.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_fsops.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_fsops.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_icache.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_icache.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_ioctl.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_ioctl.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_iomap.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_iomap.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_iops.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_iops.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_inode.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_inode.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_itable.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_itable.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_message.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_message.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_mount.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_mount.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_mru_cache.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_mru_cache.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_reflink.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_reflink.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_stats.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_stats.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_super.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_super.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_symlink.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_symlink.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_sysfs.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_sysfs.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_xattr.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_xattr.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/kmem.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/kmem.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_log.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_log.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_log_cil.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_log_cil.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_bmap_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_bmap_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_buf_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_buf_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_extfree_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_extfree_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_icreate_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_icreate_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_inode_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_inode_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_refcount_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_refcount_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_rmap_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_rmap_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_log_recover.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_log_recover.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_ail.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_ail.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_bmap.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_bmap.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_buf.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_buf.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_extfree.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_extfree.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_inode.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_inode.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_refcount.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_refcount.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_rmap.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_rmap.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_dquot.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_dquot.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_dquot_item.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_dquot_item.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_trans_dquot.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_trans_dquot.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_qm_syscalls.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_qm_syscalls.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_qm_bhv.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_qm_bhv.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_qm.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_qm.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_quotaops.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_quotaops.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_rtalloc.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_rtalloc.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_sysctl.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_loclists' from `fs/xfs/xfs_pnfs.o' being placed in section `.debug_loclists'
   powerpc-linux-ld: warning: orphan section `.debug_rnglists' from `fs/xfs/xfs_pnfs.o' being placed in section `.debug_rnglists'
   powerpc-linux-ld: warning: drivers/of/unittest-data/testcases.dtb.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>> powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0xc0): undefined reference to `cpm1_gpiochip_add16'
>> powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x184): undefined reference to `cpm1_gpiochip_add32'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x248): undefined reference to `cpm1_gpiochip_add16'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x30c): undefined reference to `cpm1_gpiochip_add16'
>> powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x3d0): undefined reference to `cpm2_gpiochip_add32'
   powerpc-linux-ld: arch/powerpc/sysdev/cpm_gpio.o:(.rodata+0x494): undefined reference to `cpm2_gpiochip_add32'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `cpm_cascade':
   m8xx_setup.c:(.text+0x1c): undefined reference to `cpm_get_irq'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_set_rtc_time':
   m8xx_setup.c:(.text+0x5a): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: m8xx_setup.c:(.text+0x66): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_get_rtc_time':
   m8xx_setup.c:(.text+0xda): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: m8xx_setup.c:(.text+0xde): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_restart':
   m8xx_setup.c:(.text+0x13a): undefined reference to `mpc8xx_immr'
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o:m8xx_setup.c:(.text+0x13e): more undefined references to `mpc8xx_immr' follow
   powerpc-linux-ld: arch/powerpc/platforms/8xx/m8xx_setup.o: in function `mpc8xx_pics_init':
   m8xx_setup.c:(.init.text+0x22c): undefined reference to `cpm_pic_init'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

