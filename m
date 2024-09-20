Return-Path: <linux-kernel+bounces-334626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB997D9BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6356B22769
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB91C683;
	Fri, 20 Sep 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nareAHyU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE0291E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858993; cv=none; b=jAOvbhOLVNYVY57OK9IVC51jxLPnkFtpqwiGQL850ahLihtKvCOCsomnlYu0akcyMUywejgKFacc9I8geGpwhF/y2J1GM8HQt5p8bK1XFVTVRP7E+VB9xbaFzm7wViY3KOqTHPH6AHUzkVT4WMAnUw+NFmN5yEmXvTvQPDsE1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858993; c=relaxed/simple;
	bh=7Q7+KeVGkXMtge0WI5A4RFOfCVgyPMwcsJdLT75EXB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK0jMVQpB/oiRHiIIBKPilwlMN6fJPMQefvBf6dYK2ydtCj9t4pzMFPiyZuHZqoNGBZ8HGXiebo1mInkF8UkYpSJm9HYAfVfFLBHlSunhtU+eG/819piUmJMW5qOH36qsOJThZFHcExNEDJrQWgNfun+cx3YTV3qsigfUcvSvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nareAHyU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726858991; x=1758394991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Q7+KeVGkXMtge0WI5A4RFOfCVgyPMwcsJdLT75EXB4=;
  b=nareAHyU35mmLu2zyUYsyDBVi3RLcat/Y9Z34ajittFa3opBsBAhbztf
   c2R3GXBiJwVv5SqgY9ddFD44wB6TEaqNoxvQw9WAzuHb5OlO9fWSVjN5C
   fhtbZD8+XJMX7KkQJ4tr1LKluwxYxQw6lhqpzUOvcrbjsDmbglMo2zjqY
   rrXssCCO6JCgzdBvZmCWvvptFkhP5DZ15PDY2emT7dNYw0Xsj4yecfTPW
   jslIjmtS/Q4a2dgJVtKoQ9WF5495IyMWDp9j2Wd7TxL4udPkOqx8gJ7JK
   xMx3phkK+MRqnLzbW5zeEbZH6DGm5VEfCNU68fIz1x4YVyVY7uBvTHuz7
   w==;
X-CSE-ConnectionGUID: uRF5qyvrR5CMAOSh0FTA8w==
X-CSE-MsgGUID: 9gxztpkMTY65/RE+kRRfgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="37249733"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="37249733"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 12:03:10 -0700
X-CSE-ConnectionGUID: +B+NGknoT/OGQilQiesp3A==
X-CSE-MsgGUID: iXgwZvuoRBuoGDh2y5jPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="74950412"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2024 12:03:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sriuH-000EmT-1n;
	Fri, 20 Sep 2024 19:03:05 +0000
Date: Sat, 21 Sep 2024 03:03:04 +0800
From: kernel test robot <lkp@intel.com>
To: Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
	jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
	ninad@linux.ibm.com
Subject: Re: [PATCH 12/15] fsi: occ: Get device number from FSI minor number
 API
Message-ID: <202409210200.8czVX7S4-lkp@intel.com>
References: <20240917171647.1403910-13-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917171647.1403910-13-eajames@linux.ibm.com>

Hi Eddie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/fsi-hub-Set-master-index-to-link-number-plus-one/20240918-012109
base:   linus/master
patch link:    https://lore.kernel.org/r/20240917171647.1403910-13-eajames%40linux.ibm.com
patch subject: [PATCH 12/15] fsi: occ: Get device number from FSI minor number API
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240921/202409210200.8czVX7S4-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409210200.8czVX7S4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210200.8czVX7S4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/fsi/fsi-occ.c:3:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2237:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/fsi/fsi-occ.c:708:2: warning: void function 'occ_remove' should not return a value [-Wreturn-mismatch]
     708 |         return 0;
         |         ^      ~
   5 warnings generated.


vim +/occ_remove +708 drivers/fsi/fsi-occ.c

   689	
   690	static void occ_remove(struct platform_device *pdev)
   691	{
   692		struct occ *occ = platform_get_drvdata(pdev);
   693	
   694		misc_deregister(&occ->mdev);
   695	
   696		mutex_lock(&occ->occ_lock);
   697		kvfree(occ->buffer);
   698		occ->buffer = NULL;
   699		mutex_unlock(&occ->occ_lock);
   700	
   701		if (occ->platform_hwmon)
   702			device_for_each_child(&pdev->dev, NULL, occ_unregister_platform_child);
   703		else
   704			device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
   705	
   706		fsi_free_minor(occ->devt);
   707	
 > 708		return 0;
   709	}
   710	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

