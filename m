Return-Path: <linux-kernel+bounces-334379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC997D67D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AF11F21897
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94738156F2B;
	Fri, 20 Sep 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnvYpfsV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF414A618
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840499; cv=none; b=neCzrZQU70W1rK+2k6qM9x0ghry0W12I8wUJIl4uCVLz/HbtHqh/lRfh2mANMSNL/fm3iUUuN2M+33xNZsJ0q9Zd2MlhK9GMpGigrGu4aLPlyDOm2Q/eFUf2A2IWOlxY+0HD7Mgq05VKskmDFC0eDzaTnQtkzyVnSriVg2mAYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840499; c=relaxed/simple;
	bh=qb2hC0taGiBjUR5pi70+wEaxIEI5qazJe0bWIKogfmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMp0F9X0LL+99flPIuWyUibirOhwb9FF6EoQ8tfc+q5Rs3g6K7Rt5lewS/laRf+PFzHr7rHtt0v5tK+RWoc7B4rRXjHYwu59C/yefIoKQNKjYJSEjotDqKnUSGqWaRq50TRtxY9P8MRZzWEsn6AFdYL8CUlYU1GI4OhJW5c+LAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnvYpfsV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726840497; x=1758376497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qb2hC0taGiBjUR5pi70+wEaxIEI5qazJe0bWIKogfmM=;
  b=DnvYpfsVD1m61BAh/htBK6CxrFzM205Hi9L2yX3UsHZl2vbNBeQ25DbC
   8S7ejgTzYB2eKMeOEpyh6o7mZIXDnB4TLVuMsH+joaQd8S60Ntf6sWiai
   UVfoxqkXX8Etx4nSKgN+ELa9QlKNSjAYG/UY2aVU482iSri8aKRYN+enJ
   0YIO154pBkk5bqoJ6r1BK9TEWlvE1sokjNPETH9NKeTkLhrW3tGjEP0sB
   A3rkrYlKxw97kpOIwqDFpgjqHoVzL6WMzHJcclegHL8t2LbJFR9R5oMtf
   OOSai1Csp7vfmRNvdwMdNVFNP8LASz9jxYBj7KElSSBPfwiS6vLpWPwjT
   w==;
X-CSE-ConnectionGUID: j0hEx+N1Q2CMsATycXtQ9Q==
X-CSE-MsgGUID: pB9SWUhQSFChl/aeHFB/dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48376787"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="48376787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:54:57 -0700
X-CSE-ConnectionGUID: WekKVMJjTVS6VbG25XjO1A==
X-CSE-MsgGUID: C/lDr2GdRPKKn7zl0fv3Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="71149158"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Sep 2024 06:54:55 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sre5z-000EVZ-2O;
	Fri, 20 Sep 2024 13:54:51 +0000
Date: Fri, 20 Sep 2024 21:54:27 +0800
From: kernel test robot <lkp@intel.com>
To: Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
	andrew@codeconstruct.com.au, eajames@linux.ibm.com,
	ninad@linux.ibm.com
Subject: Re: [PATCH 12/15] fsi: occ: Get device number from FSI minor number
 API
Message-ID: <202409202101.tu2dHrK3-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/fsi-hub-Set-master-index-to-link-number-plus-one/20240918-012109
base:   linus/master
patch link:    https://lore.kernel.org/r/20240917171647.1403910-13-eajames%40linux.ibm.com
patch subject: [PATCH 12/15] fsi: occ: Get device number from FSI minor number API
config: arm-randconfig-002-20240920 (https://download.01.org/0day-ci/archive/20240920/202409202101.tu2dHrK3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409202101.tu2dHrK3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409202101.tu2dHrK3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/fsi/fsi-occ.c: In function 'occ_remove':
>> drivers/fsi/fsi-occ.c:708:16: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     708 |         return 0;
         |                ^
   drivers/fsi/fsi-occ.c:690:13: note: declared here
     690 | static void occ_remove(struct platform_device *pdev)
         |             ^~~~~~~~~~


vim +/return +708 drivers/fsi/fsi-occ.c

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

