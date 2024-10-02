Return-Path: <linux-kernel+bounces-346909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EBE98CADF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ABD1C22A26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA323C9;
	Wed,  2 Oct 2024 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKZSiCKj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF215227
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833125; cv=none; b=dG/VCDaaINTwnEj3WQ1ze3ubJQLBqx/+bY6jbD1QaZbS1Lahxh4K8a61I4uV72FwzWQLSZN/LvWuBUjXqcZjtqWXiFn2g4zmNNznFg0x/1MATbiZauEeu0jEypcGCT+9h5oH9uC+S66eJ/BXg7/tIFsN4BtXFvwjdg4xZOcLppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833125; c=relaxed/simple;
	bh=VlMDUhGezddFGK3zvzBYkUJshgD6H+tbIwYM1nbV7gA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J/ZvqgtntbAoCQVt7DIspx+IEb44Ssx/LaPWkGXe/5D7tF2dvMmndrFk60qadTKkbOPqjoa453wanfKqNWclv5DRLRS3Hjt7wIWhttjcZl86L4Okwsagjk3glLcXW+OBHk09cIK7v1e3KP0grlUH9hiDxcu1VmZ+d6AwZexzEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKZSiCKj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727833123; x=1759369123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VlMDUhGezddFGK3zvzBYkUJshgD6H+tbIwYM1nbV7gA=;
  b=WKZSiCKj7gYObk2aKEe9sJHTSxiAcZOWOGwKof30eEl6HFY8qvsSv/gO
   mMJxbCwOxS4hZIvg6sbZYH/cJtxq3rESYt/A79RokFLBd8I3i2zSgMT3R
   KAQ9jSQ2Ry3yfz9EywoCAU3SEETFvEBQVuCCjdA5NUrfS0fq1FQyA95vY
   JjMRb1vOILdUc0arPGwJQ9mF87eZpn51XtMjdfzWwiz3KqZeQn1svLsGs
   kkpWR8jSavGpoMpbm4f1+2zgiBShSQZSrEGkLAGmwoWMrgCyehwHSkGIt
   SxbclMjTdjy2nhK9FvAWQ/AAUGC2zcbm5v+sWmORDhJvglLuc1n4i2zSN
   A==;
X-CSE-ConnectionGUID: zooizQKLT5OqzmxbxAjgVA==
X-CSE-MsgGUID: fh6eutC5QB6dRF5plFkawA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27126855"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="27126855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 18:38:42 -0700
X-CSE-ConnectionGUID: lYZ3989+TE2hmH2JDVVImg==
X-CSE-MsgGUID: Toys9hT1RYm2o273qkwg2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="74177240"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Oct 2024 18:38:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svoK7-000RPf-09;
	Wed, 02 Oct 2024 01:38:39 +0000
Date: Wed, 2 Oct 2024 09:38:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Hutchings <bwh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/usb/host/xhci-pci-renesas.c:655:25: error:
 'usb_hcd_pci_shutdown' undeclared here (not in a function); did you mean
 'usb_hcd_platform_shutdown'?
Message-ID: <202410020925.sc8EitKi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: 25f51b76f90f10f9bf2fbc05fc51cf685da7ccad xhci-pci: Make xhci-pci-renesas a proper modular driver
date:   8 weeks ago
config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020925.sc8EitKi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020925.sc8EitKi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020925.sc8EitKi-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mm_types.h:5,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/usb/host/xhci-pci-renesas.c:4:
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
    2888 | #if USE_SPLIT_PTE_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
      20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
    3010 | #if USE_SPLIT_PMD_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-pci-renesas.c:655:25: error: 'usb_hcd_pci_shutdown' undeclared here (not in a function); did you mean 'usb_hcd_platform_shutdown'?
     655 |         .shutdown =     usb_hcd_pci_shutdown,
         |                         ^~~~~~~~~~~~~~~~~~~~
         |                         usb_hcd_platform_shutdown
   In file included from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8:
>> drivers/usb/host/xhci-pci-renesas.c:657:31: error: 'usb_hcd_pci_pm_ops' undeclared here (not in a function)
     657 |                 .pm = pm_ptr(&usb_hcd_pci_pm_ops),
         |                               ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/usb/host/xhci-pci-renesas.c:657:23: note: in expansion of macro 'pm_ptr'
     657 |                 .pm = pm_ptr(&usb_hcd_pci_pm_ops),
         |                       ^~~~~~
>> drivers/usb/host/xhci-pci-renesas.c:660:1: warning: data definition has no type or storage class
     660 | module_pci_driver(xhci_renesas_pci_driver);
         | ^~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-pci-renesas.c:660:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>> drivers/usb/host/xhci-pci-renesas.c:660:1: warning: parameter names (without types) in function declaration
>> drivers/usb/host/xhci-pci-renesas.c:648:26: warning: 'xhci_renesas_pci_driver' defined but not used [-Wunused-variable]
     648 | static struct pci_driver xhci_renesas_pci_driver = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +655 drivers/usb/host/xhci-pci-renesas.c

   647	
 > 648	static struct pci_driver xhci_renesas_pci_driver = {
   649		.name =		"xhci-pci-renesas",
   650		.id_table =	pci_ids,
   651	
   652		.probe =	xhci_pci_renesas_probe,
   653		.remove =	xhci_pci_remove,
   654	
 > 655		.shutdown = 	usb_hcd_pci_shutdown,
   656		.driver = {
 > 657			.pm = pm_ptr(&usb_hcd_pci_pm_ops),
   658		},
   659	};
 > 660	module_pci_driver(xhci_renesas_pci_driver);
   661	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

