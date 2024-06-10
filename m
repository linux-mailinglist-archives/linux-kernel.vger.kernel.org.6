Return-Path: <linux-kernel+bounces-207967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2F901E98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C93285C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D1A745F4;
	Mon, 10 Jun 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lvv6SsuB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE24CA62
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013279; cv=none; b=CksYkxDo0svu30urRb0EmJo95FRHP27jiWxZNCivFsFDyLJxamnOn42f2zJmJHQgpcu+qlflT6COxaadpW8kSidyXNn+jXN6cSnS3y2nByQTYeVrL35w1DF4+4VyGx/Z4pn9onTTmZVU3dwEADNwinP330Vm2/MtML6ZQEPFPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013279; c=relaxed/simple;
	bh=yGdh2DgY5dbRPihxx4eSyhu1F2/ygbWCIoyyX/MAbWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUtFyJ6NKBDROYXihEJFyL3X5JWI+EmBqmAQjYhZMHbwOgv1ksmp3xQF356WHVGiATnXEvmMgNw2vj/9uI+snfolwEGcreFXjb//aI7R1eqxjtBVv7y1raEvIY0QPz4e1vkSzCafo0q5TK9i54FWF+ksYVp884AQJMMEFjy2DlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lvv6SsuB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718013277; x=1749549277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yGdh2DgY5dbRPihxx4eSyhu1F2/ygbWCIoyyX/MAbWQ=;
  b=Lvv6SsuBZLDJxt5QH4sOELzuxQOCpDSw1YxfaK1Xou/JS3G4Ptw0wqjc
   AvVC6IFtktY2qwj7YgyyBN8I2ASru8MUk4IxOlG7b49OHivmBzLYesN+J
   deaWslLhHm5+Yd6pl439VqALMFtINn3ORYZdRdpke3UQdYx67Z2moGSJZ
   4JeP+aPmAue2Mkx47H6fPISNEPIi7dKNBYKfsRBVVbSIYhvc72zz/rZ4G
   Jo4kRlirNpKaT/t9AVwNlyafpRaROEhCAWgOg7K/IxgeoAW8PUyPVDOm7
   v3xqMrh/aLvDEr47wawojjFg3JFz82ESg7kKU8IEBIlQbZ+nkvviHYpER
   g==;
X-CSE-ConnectionGUID: slFSvtyoQLSv8u8AMYEzmg==
X-CSE-MsgGUID: e2iZRVDATEugN5wX1n4F4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14818097"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14818097"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:54:36 -0700
X-CSE-ConnectionGUID: epjzt1QBSXWXDm/6gQpdhA==
X-CSE-MsgGUID: E+67wbjFTGe7ZAIo23ieyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39129952"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jun 2024 02:54:33 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGbjT-00022n-1H;
	Mon, 10 Jun 2024 09:54:31 +0000
Date: Mon, 10 Jun 2024 17:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: Re: [PATCH] xen: xen-pciback: Export a bridge and all its children
 as per TODO
Message-ID: <202406101933.49pM50Ii-lkp@intel.com>
References: <20240609184410.53500-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609184410.53500-1-jain.abhinav177@gmail.com>

Hi Abhinav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xen-tip/linux-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhinav-Jain/xen-xen-pciback-Export-a-bridge-and-all-its-children-as-per-TODO/20240610-024623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20240609184410.53500-1-jain.abhinav177%40gmail.com
patch subject: [PATCH] xen: xen-pciback: Export a bridge and all its children as per TODO
config: x86_64-randconfig-006-20240610 (https://download.01.org/0day-ci/archive/20240610/202406101933.49pM50Ii-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406101933.49pM50Ii-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406101933.49pM50Ii-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/xen/xen-pciback/xenbus.c:262:21: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
     262 |         if ((dev->hdr_type && PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
         |                            ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/xen/xen-pciback/xenbus.c:262:21: note: use '&' for a bitwise operation
     262 |         if ((dev->hdr_type && PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
         |                            ^~
         |                            &
   drivers/xen/xen-pciback/xenbus.c:262:21: note: remove constant to silence this warning
     262 |         if ((dev->hdr_type && PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/xen/xen-pciback/xenbus.c:270:12: error: no member named 'domain' in 'struct pci_dev'
     270 |                                 child->domain, child->bus->number,
         |                                 ~~~~~  ^
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                                             ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                                ^~~~~~~~~~~
   drivers/xen/xen-pciback/xenbus.c:275:20: error: no member named 'domain' in 'struct pci_dev'
     275 |                                                       child->domain,
         |                                                       ~~~~~  ^
   drivers/xen/xen-pciback/xenbus.c:284:13: error: no member named 'domain' in 'struct pci_dev'
     284 |                                         child->domain,
         |                                         ~~~~~  ^
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   1 warning and 3 errors generated.


vim +262 drivers/xen/xen-pciback/xenbus.c

   225	
   226	static int xen_pcibk_export_device(struct xen_pcibk_device *pdev,
   227					 int domain, int bus, int slot, int func,
   228					 int devid)
   229	{
   230		struct pci_dev *dev;
   231		int err = 0;
   232	
   233		dev_dbg(&pdev->xdev->dev, "exporting dom %x bus %x slot %x func %x\n",
   234			domain, bus, slot, func);
   235	
   236		dev = pcistub_get_pci_dev_by_slot(pdev, domain, bus, slot, func);
   237		if (!dev) {
   238			err = -EINVAL;
   239			xenbus_dev_fatal(pdev->xdev, err,
   240					 "Couldn't locate PCI device "
   241					 "(%04x:%02x:%02x.%d)! "
   242					 "perhaps already in-use?",
   243					 domain, bus, slot, func);
   244			goto out;
   245		}
   246	
   247		err = xen_pcibk_add_pci_dev(pdev, dev, devid,
   248					    xen_pcibk_publish_pci_dev);
   249		if (err)
   250			goto out;
   251	
   252		dev_info(&dev->dev, "registering for %d\n", pdev->xdev->otherend_id);
   253		if (xen_register_device_domain_owner(dev,
   254						     pdev->xdev->otherend_id) != 0) {
   255			dev_err(&dev->dev, "Stealing ownership from dom%d.\n",
   256				xen_find_device_domain_owner(dev));
   257			xen_unregister_device_domain_owner(dev);
   258			xen_register_device_domain_owner(dev, pdev->xdev->otherend_id);
   259		}
   260	
   261		/* Check if the device is a bridge and export all its children */
 > 262		if ((dev->hdr_type && PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
   263			struct pci_dev *child = NULL;
   264	
   265			/* Iterate over all the devices in this bridge */
   266			list_for_each_entry(child, &dev->subordinate->devices,
   267					bus_list) {
   268				dev_dbg(&pdev->xdev->dev,
   269					"exporting child device %04x:%02x:%02x.%d\n",
   270					child->domain, child->bus->number,
   271					PCI_SLOT(child->devfn),
   272					PCI_FUNC(child->devfn));
   273	
   274				err = xen_pcibk_export_device(pdev,
   275							      child->domain,
   276							      child->bus->number,
   277							      PCI_SLOT(child->devfn),
   278							      PCI_FUNC(child->devfn),
   279							      devid);
   280				if (err) {
   281					dev_err(&pdev->xdev->dev,
   282						"failed to export child device : "
   283						"%04x:%02x:%02x.%d\n",
   284						child->domain,
   285						child->bus->number,
   286						PCI_SLOT(child->devfn),
   287						PCI_FUNC(child->devfn));
   288					goto out;
   289				}
   290			}
   291		}
   292	out:
   293		return err;
   294	}
   295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

