Return-Path: <linux-kernel+bounces-537757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D138A49038
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF0A1893126
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7119D882;
	Fri, 28 Feb 2025 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isPcQ/+p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3C191F6C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716192; cv=none; b=ZLWIQ50zNA9DfttmHuxiHBesFJ9x8sr0WeZ2LGiPWuDdkL35UtwHQvywxax7ccwIBe8dchzdgkEtj6ezj4SO40fwRas9av8zdW/PMPTxxIwvs6ka6+YD5bWVSkPk4lxVmIE5HYaYH+CpbbsemZWW1tzihjIfA0J+mGdXLQhAnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716192; c=relaxed/simple;
	bh=hok8XXIzZUYscf79mdY2nfNctL4SVdz5biFoV5dfhFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W0zpO4OWc5DtRoTv8ev4jp2YDBZq2uvwFfsXntR84ikBVkB7gIah4U5qTvSFARzMOhqE4Cq0dhyl4h7kEmuZs4574sggKvmV1LFaXQyezfIMsIXEgt1n0R7i/0P4AVChYb7sb8hg1vq5f8va3gWnhUs+8ETTyTvrJkedmffgzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isPcQ/+p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740716190; x=1772252190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hok8XXIzZUYscf79mdY2nfNctL4SVdz5biFoV5dfhFQ=;
  b=isPcQ/+pDTgm78OmBDOqPu0qPIjR4FeckUQ+/S609SQ4p3jUVNOMQZNO
   ngcRl65+wnqi0Fwq2LeaH4LOgliEp/Y2+cCOeLjoMN8dIZCNNBBl8izdx
   82gdCknVBw1e/dllZCgo21UwnwFjhNfrM2Jvr4tle6CWQHsBkpL1ABA0j
   I6nfSu9WZlMBq1hsV5cVTb8g/Y5pO5ra70rl4AGi6LQVHAcmttEmgm0fU
   FiShCDLthVTpEdGXpwANut4op84yLxNoBTMuiQUO/BrUt+R4kolKcTJfs
   hRmYYtdfDcC5Q9tvMO7XNJpB2/fO6rw3a8cELQWlVMNk18tfzH8YnfffN
   A==;
X-CSE-ConnectionGUID: pxzIvkgdTHu/Vb2qwKGejA==
X-CSE-MsgGUID: j1eGAY17QBGuPMtcIq6hQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41763793"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41763793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 20:16:29 -0800
X-CSE-ConnectionGUID: k3iSfP8aRt+KXvWUJaDC6g==
X-CSE-MsgGUID: BdZRCuE9SaqKB+4ZA5Amtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122453657"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 27 Feb 2025 20:16:28 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnrnV-000EP6-16;
	Fri, 28 Feb 2025 04:16:25 +0000
Date: Fri, 28 Feb 2025 12:16:07 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: include/linux/kern_levels.h:5:25: warning: '%s' directive argument
 is null
Message-ID: <202502281256.H66NjDMW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e15510b71c99c6e49134d756df91069f7d18141
commit: 59833696442c674acbbd297772ba89e7ad8c753d iommu/vt-d: dmar: replace WARN_TAINT with pr_warn + add_taint
date:   5 years ago
config: x86_64-randconfig-161-20230920 (https://download.01.org/0day-ci/archive/20250228/202502281256.H66NjDMW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502281256.H66NjDMW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502281256.H66NjDMW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:15,
                    from include/asm-generic/bug.h:19,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/jump_label.h:250,
                    from arch/x86/include/asm/string_64.h:6,
                    from arch/x86/include/asm/string.h:5,
                    from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from include/linux/pci.h:27,
                    from drivers/iommu/dmar.c:19:
   drivers/iommu/dmar.c: In function 'dmar_parse_one_andd':
>> include/linux/kern_levels.h:5:25: warning: '%s' directive argument is null [-Wformat-overflow=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:306:16: note: in expansion of macro 'KERN_WARNING'
     306 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/iommu/dmar.c:444:17: note: in expansion of macro 'pr_warn'
     444 |                 pr_warn(FW_BUG
         |                 ^~~~~~~
   drivers/iommu/dmar.c: In function 'warn_invalid_dmar':
>> include/linux/kern_levels.h:5:25: warning: '%s' directive argument is null [-Wformat-overflow=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:356:24: note: in definition of macro 'printk_once'
     356 |                 printk(fmt, ##__VA_ARGS__);                     \
         |                        ^~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:387:21: note: in expansion of macro 'KERN_WARNING'
     387 |         printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                     ^~~~~~~~~~~~
   drivers/iommu/dmar.c:832:9: note: in expansion of macro 'pr_warn_once'
     832 |         pr_warn_once(FW_BUG
         |         ^~~~~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

