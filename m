Return-Path: <linux-kernel+bounces-302341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CF95FCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A828319D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4519D07B;
	Mon, 26 Aug 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKzWni60"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97119AA4E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711915; cv=none; b=W6b9NuB8pm56bDihN97gPjyD+TCxQr8SIECVAAp4ZS4VMWcfwnV1loZLigGad9zOJHyB2YLEUeI0YPmM/3pXy5eaHt5zYGEBn1/3tSNxnK6qRryo02PmsrGe9JOE+NTX1IndhyD+3Axd7VkNFrhALIQ/V9WLOPEgerGcl0LMMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711915; c=relaxed/simple;
	bh=IcfDBNU1XMYr6kUAKgn4NRrZgFHytBg+0l+87kEgNyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls9lEDIQTvvq9RqQqxaAFCvFOR8lprgpp5ZxScauFDLNj3h5ad1pqeaUt/LSbo/77YlaXY7dEVVus2Dz3CbS32jwMryjB8SZ5kVGM3yhjN2yXHnKBXNdwsYMNigDTrelQe1laM7QU0dSuGWBClv0kmvnRWO89LbNBUgn/GXMCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKzWni60; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724711914; x=1756247914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IcfDBNU1XMYr6kUAKgn4NRrZgFHytBg+0l+87kEgNyE=;
  b=bKzWni60CgE5CDjPSsIqxXz5ni5udZaMYUGFpBGBTc8ULs/+iE6qknlc
   bSR6FwDn7cTKy4M61CrU0g0ESkf0oZYh3ukcz1HhaCmkNRm+QwWdi7Wrp
   7XtqwLQ6E2Tr2gH/U/cplkiJSbPftnFtLtO21fEUHYgz7Xn4WHCtj+xS5
   GDVWsQddZlgWbl2dHqQWUrnO4FkZIFfApR219lNBrqLdGHHB/GVv3/m1l
   R4ArX+FvKugb7E78PVvL/IYsMsFQCV+UNe+EJfewSTMLd0aB1gwvObC1s
   mZF8BgeM99hDm7+vSCGg9zVcSXXPzUnJq90JPOeYBzyxtSuvP8LA3/TBV
   A==;
X-CSE-ConnectionGUID: yUbMwQVASOeCc/lQBA6rqw==
X-CSE-MsgGUID: eot31DQtQmCWOkRZDaqfww==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26956208"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="26956208"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:38:34 -0700
X-CSE-ConnectionGUID: h1c1iO/IR4iTJCTa5+9muw==
X-CSE-MsgGUID: 8C5xr0etTjOsB11IyaiXHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="63382603"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2024 15:38:32 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siiM2-000HfM-04;
	Mon, 26 Aug 2024 22:38:30 +0000
Date: Tue, 27 Aug 2024 06:38:24 +0800
From: kernel test robot <lkp@intel.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: Re: [PATCH] staging: vme_user: Added static to image_desc and
 vme_user_vma_priv struct
Message-ID: <202408270655.m9x8rJA5-lkp@intel.com>
References: <20240825035514.40095-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825035514.40095-1-riyandhiman14@gmail.com>

Hi Riyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Riyan-Dhiman/staging-vme_user-Added-static-to-image_desc-and-vme_user_vma_priv-struct/20240826-142747
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240825035514.40095-1-riyandhiman14%40gmail.com
patch subject: [PATCH] staging: vme_user: Added static to image_desc and vme_user_vma_priv struct
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240827/202408270655.m9x8rJA5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270655.m9x8rJA5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270655.m9x8rJA5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/vme_user/vme_user.c:99:1: warning: useless storage class specifier in empty declaration
      99 | };
         | ^
   drivers/staging/vme_user/vme_user.c:120:1: warning: useless storage class specifier in empty declaration
     120 | };
         | ^


vim +99 drivers/staging/vme_user/vme_user.c

f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   87  
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   88  /*
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   89   * Structure to handle image related parameters.
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   90   */
e2d30086b6cc13 drivers/staging/vme_user/vme_user.c    Riyan Dhiman    2024-08-25   91  static struct image_desc {
0a81a0f768e5bb drivers/staging/vme/devices/vme_user.c Emilio G. Cota  2010-11-12   92  	void *kern_buf;	/* Buffer address in kernel space */
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   93  	dma_addr_t pci_buf;	/* Buffer address in PCI address space */
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   94  	unsigned long long size_buf;	/* Buffer size */
ecb3b80ff968f1 drivers/staging/vme/devices/vme_user.c Santosh Nayak   2012-04-03   95  	struct mutex mutex;	/* Mutex for locking image */
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   96  	struct device *device;	/* Sysfs device */
f00a86d98a1ec3 drivers/staging/vme/devices/vme_user.c Martyn Welch    2009-07-31   97  	struct vme_resource *resource;	/* VME resource */
c74a804f115bde drivers/staging/vme/devices/vme_user.c Dmitry Kalinkin 2015-02-26   98  	int mmap_count;		/* Number of current mmap's */
584721cab2bdd2 drivers/staging/vme/devices/vme_user.c Vincent Bossier 2011-06-03  @99  };
cd974d35ab784d drivers/staging/vme/devices/vme_user.c Dmitry Kalinkin 2015-06-26  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

