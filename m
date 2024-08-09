Return-Path: <linux-kernel+bounces-280238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141DD94C78B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863901F24A86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B87442C;
	Fri,  9 Aug 2024 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDTiBRb5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3A8C1A;
	Fri,  9 Aug 2024 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723162900; cv=none; b=kADSPLE91FE+jzBpHit6qIjc2S8GcEAQOczW721aDK3RfOr5H79rAeN0AO4ZpNzmEa9JR4IsK3HdgemmVpJgBXt1TFBZiFFTDlzusPJyVtVPhz1mRIcUjClwXKq/JqMgEaN+75j+cJw+Dj7L1sT6SXO27TJjToflnZl8bxVryL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723162900; c=relaxed/simple;
	bh=oAMsox2iOiKuFVbjdoW1TX6kfgDcgDkm5muwzOynBwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr+bCUhjo1IMYcbkUQ4tlnA+6vps07BoLwol/Me6zAzF8Q17MTWD7+0W2CFONAfrxcXmGMXdANKfag0v30enICE7xSO2gj9kKqzGVmBSZubtPywPOvAdfQh8ZRTsF3vuwwjzc8lHSTG1LBs58awjl7Brp96YjuLsn/TWYI2AUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDTiBRb5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723162899; x=1754698899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAMsox2iOiKuFVbjdoW1TX6kfgDcgDkm5muwzOynBwI=;
  b=UDTiBRb5huIjYRq2+6mTvp2/4Vjrzb3ly8wikh3Bd0DMkRSVI4dS+yT+
   shmZGtUda+1xm4loiqFqPagRVx2LtD8LMudXBL6+Yrd82YJwieO5oPzzT
   IJVNyMgMV81Fpu5kpZntyNXKrLUcYs3j7YYCbks+axCTidwhfPO6ZRMH5
   4BSuDuYowIpNhy6dBL+Th714fR+oCG4hLaCOYRFLBhDhJW131H5fp67s+
   +C4yPG0qpQCMO6v3W2n+OxP9jzIcg6dvY1cRs2K+AO3j1A9LtYiZxnDhp
   F98n7CkpxLmYDHDckvZHYB8sCsMwfZecTqYdpqYAmgjr+v3BoiXExkFjj
   g==;
X-CSE-ConnectionGUID: L8V+kXM8T1+mDcAGmUssnw==
X-CSE-MsgGUID: TgqzlRkhQL2CuCF9tYYJ/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21180406"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="21180406"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 17:21:36 -0700
X-CSE-ConnectionGUID: vAnM1invTz+WbJscvIw2LQ==
X-CSE-MsgGUID: 3JEffboCSbS58Fuq0k9IDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="62035468"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 17:21:32 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scDNh-0006fk-1T;
	Fri, 09 Aug 2024 00:21:23 +0000
Date: Fri, 9 Aug 2024 08:20:25 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: Re: [PATCH v2] of/irq: Consider device address size in interrupt map
 walk
Message-ID: <202408090801.AcBWUFAJ-lkp@intel.com>
References: <20240807134032.1364503-2-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807134032.1364503-2-stefan.wiehler@nokia.com>

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on powerpc/next pci/next pci/for-linus linus/master v6.11-rc2 next-20240808]
[cannot apply to powerpc/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Wiehler/of-irq-Consider-device-address-size-in-interrupt-map-walk/20240807-215113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240807134032.1364503-2-stefan.wiehler%40nokia.com
patch subject: [PATCH v2] of/irq: Consider device address size in interrupt map walk
config: i386-buildonly-randconfig-003-20240809 (https://download.01.org/0day-ci/archive/20240809/202408090801.AcBWUFAJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408090801.AcBWUFAJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408090801.AcBWUFAJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/of_property.c: In function 'of_pci_prop_intr_map':
   drivers/pci/of_property.c:234:47: warning: passing argument 2 of 'of_irq_parse_raw' makes integer from pointer without a cast [-Wint-conversion]
     234 |                 ret = of_irq_parse_raw(laddr, &out_irq[i]);
         |                                               ^~~~~~~~~~~
         |                                               |
         |                                               struct of_phandle_args *
   In file included from drivers/pci/of_property.c:8:
   include/linux/of_irq.h:35:53: note: expected 'u32' {aka 'unsigned int'} but argument is of type 'struct of_phandle_args *'
      35 | extern int of_irq_parse_raw(const __be32 *addr, u32 addrsize,
         |                                                 ~~~~^~~~~~~~
>> drivers/pci/of_property.c:234:23: error: too few arguments to function 'of_irq_parse_raw'
     234 |                 ret = of_irq_parse_raw(laddr, &out_irq[i]);
         |                       ^~~~~~~~~~~~~~~~
   In file included from drivers/pci/of_property.c:8:
   include/linux/of_irq.h:35:12: note: declared here
      35 | extern int of_irq_parse_raw(const __be32 *addr, u32 addrsize,
         |            ^~~~~~~~~~~~~~~~


vim +/of_irq_parse_raw +234 drivers/pci/of_property.c

dc12273fa3d8a8 Herve Codina 2024-05-27  205  
407d1a51921e9f Lizhi Hou    2023-08-15  206  static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
407d1a51921e9f Lizhi Hou    2023-08-15  207  				struct device_node *np)
407d1a51921e9f Lizhi Hou    2023-08-15  208  {
33efa29e825636 Lizhi Hou    2023-09-29  209  	u32 i, addr_sz[OF_PCI_MAX_INT_PIN] = { 0 }, map_sz = 0;
407d1a51921e9f Lizhi Hou    2023-08-15  210  	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
407d1a51921e9f Lizhi Hou    2023-08-15  211  	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
407d1a51921e9f Lizhi Hou    2023-08-15  212  	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
407d1a51921e9f Lizhi Hou    2023-08-15  213  	struct device_node *pnode;
407d1a51921e9f Lizhi Hou    2023-08-15  214  	struct pci_dev *child;
407d1a51921e9f Lizhi Hou    2023-08-15  215  	u32 *int_map, *mapp;
407d1a51921e9f Lizhi Hou    2023-08-15  216  	int ret;
407d1a51921e9f Lizhi Hou    2023-08-15  217  	u8 pin;
407d1a51921e9f Lizhi Hou    2023-08-15  218  
407d1a51921e9f Lizhi Hou    2023-08-15  219  	pnode = pci_device_to_OF_node(pdev->bus->self);
407d1a51921e9f Lizhi Hou    2023-08-15  220  	if (!pnode)
407d1a51921e9f Lizhi Hou    2023-08-15  221  		pnode = pci_bus_to_OF_node(pdev->bus);
407d1a51921e9f Lizhi Hou    2023-08-15  222  
407d1a51921e9f Lizhi Hou    2023-08-15  223  	if (!pnode) {
407d1a51921e9f Lizhi Hou    2023-08-15  224  		pci_err(pdev, "failed to get parent device node");
407d1a51921e9f Lizhi Hou    2023-08-15  225  		return -EINVAL;
407d1a51921e9f Lizhi Hou    2023-08-15  226  	}
407d1a51921e9f Lizhi Hou    2023-08-15  227  
407d1a51921e9f Lizhi Hou    2023-08-15  228  	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
407d1a51921e9f Lizhi Hou    2023-08-15  229  	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
407d1a51921e9f Lizhi Hou    2023-08-15  230  		i = pin - 1;
407d1a51921e9f Lizhi Hou    2023-08-15  231  		out_irq[i].np = pnode;
407d1a51921e9f Lizhi Hou    2023-08-15  232  		out_irq[i].args_count = 1;
407d1a51921e9f Lizhi Hou    2023-08-15  233  		out_irq[i].args[0] = pin;
407d1a51921e9f Lizhi Hou    2023-08-15 @234  		ret = of_irq_parse_raw(laddr, &out_irq[i]);
407d1a51921e9f Lizhi Hou    2023-08-15  235  		if (ret) {
33efa29e825636 Lizhi Hou    2023-09-29  236  			out_irq[i].np = NULL;
33efa29e825636 Lizhi Hou    2023-09-29  237  			pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
407d1a51921e9f Lizhi Hou    2023-08-15  238  			continue;
407d1a51921e9f Lizhi Hou    2023-08-15  239  		}
33efa29e825636 Lizhi Hou    2023-09-29  240  		of_property_read_u32(out_irq[i].np, "#address-cells",
407d1a51921e9f Lizhi Hou    2023-08-15  241  				     &addr_sz[i]);
407d1a51921e9f Lizhi Hou    2023-08-15  242  	}
407d1a51921e9f Lizhi Hou    2023-08-15  243  
407d1a51921e9f Lizhi Hou    2023-08-15  244  	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
407d1a51921e9f Lizhi Hou    2023-08-15  245  		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
407d1a51921e9f Lizhi Hou    2023-08-15  246  			i = pci_swizzle_interrupt_pin(child, pin) - 1;
33efa29e825636 Lizhi Hou    2023-09-29  247  			if (!out_irq[i].np)
33efa29e825636 Lizhi Hou    2023-09-29  248  				continue;
407d1a51921e9f Lizhi Hou    2023-08-15  249  			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
407d1a51921e9f Lizhi Hou    2023-08-15  250  		}
407d1a51921e9f Lizhi Hou    2023-08-15  251  	}
407d1a51921e9f Lizhi Hou    2023-08-15  252  
33efa29e825636 Lizhi Hou    2023-09-29  253  	/*
33efa29e825636 Lizhi Hou    2023-09-29  254  	 * Parsing interrupt failed for all pins. In this case, it does not
33efa29e825636 Lizhi Hou    2023-09-29  255  	 * need to generate interrupt-map property.
33efa29e825636 Lizhi Hou    2023-09-29  256  	 */
33efa29e825636 Lizhi Hou    2023-09-29  257  	if (!map_sz)
33efa29e825636 Lizhi Hou    2023-09-29  258  		return 0;
33efa29e825636 Lizhi Hou    2023-09-29  259  
407d1a51921e9f Lizhi Hou    2023-08-15  260  	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
e6f7d27df5d208 Duoming Zhou 2024-03-03  261  	if (!int_map)
e6f7d27df5d208 Duoming Zhou 2024-03-03  262  		return -ENOMEM;
407d1a51921e9f Lizhi Hou    2023-08-15  263  	mapp = int_map;
407d1a51921e9f Lizhi Hou    2023-08-15  264  
407d1a51921e9f Lizhi Hou    2023-08-15  265  	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
407d1a51921e9f Lizhi Hou    2023-08-15  266  		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
33efa29e825636 Lizhi Hou    2023-09-29  267  			i = pci_swizzle_interrupt_pin(child, pin) - 1;
33efa29e825636 Lizhi Hou    2023-09-29  268  			if (!out_irq[i].np)
33efa29e825636 Lizhi Hou    2023-09-29  269  				continue;
33efa29e825636 Lizhi Hou    2023-09-29  270  
407d1a51921e9f Lizhi Hou    2023-08-15  271  			*mapp = (child->bus->number << 16) |
407d1a51921e9f Lizhi Hou    2023-08-15  272  				(child->devfn << 8);
407d1a51921e9f Lizhi Hou    2023-08-15  273  			mapp += OF_PCI_ADDRESS_CELLS;
407d1a51921e9f Lizhi Hou    2023-08-15  274  			*mapp = pin;
407d1a51921e9f Lizhi Hou    2023-08-15  275  			mapp++;
407d1a51921e9f Lizhi Hou    2023-08-15  276  			*mapp = out_irq[i].np->phandle;
407d1a51921e9f Lizhi Hou    2023-08-15  277  			mapp++;
407d1a51921e9f Lizhi Hou    2023-08-15  278  			if (addr_sz[i]) {
407d1a51921e9f Lizhi Hou    2023-08-15  279  				ret = of_property_read_u32_array(out_irq[i].np,
407d1a51921e9f Lizhi Hou    2023-08-15  280  								 "reg", mapp,
407d1a51921e9f Lizhi Hou    2023-08-15  281  								 addr_sz[i]);
407d1a51921e9f Lizhi Hou    2023-08-15  282  				if (ret)
407d1a51921e9f Lizhi Hou    2023-08-15  283  					goto failed;
407d1a51921e9f Lizhi Hou    2023-08-15  284  			}
407d1a51921e9f Lizhi Hou    2023-08-15  285  			mapp += addr_sz[i];
407d1a51921e9f Lizhi Hou    2023-08-15  286  			memcpy(mapp, out_irq[i].args,
407d1a51921e9f Lizhi Hou    2023-08-15  287  			       out_irq[i].args_count * sizeof(u32));
407d1a51921e9f Lizhi Hou    2023-08-15  288  			mapp += out_irq[i].args_count;
407d1a51921e9f Lizhi Hou    2023-08-15  289  		}
407d1a51921e9f Lizhi Hou    2023-08-15  290  	}
407d1a51921e9f Lizhi Hou    2023-08-15  291  
407d1a51921e9f Lizhi Hou    2023-08-15  292  	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map", int_map,
407d1a51921e9f Lizhi Hou    2023-08-15  293  					      map_sz);
407d1a51921e9f Lizhi Hou    2023-08-15  294  	if (ret)
407d1a51921e9f Lizhi Hou    2023-08-15  295  		goto failed;
407d1a51921e9f Lizhi Hou    2023-08-15  296  
407d1a51921e9f Lizhi Hou    2023-08-15  297  	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
407d1a51921e9f Lizhi Hou    2023-08-15  298  	if (ret)
407d1a51921e9f Lizhi Hou    2023-08-15  299  		goto failed;
407d1a51921e9f Lizhi Hou    2023-08-15  300  
407d1a51921e9f Lizhi Hou    2023-08-15  301  	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map-mask",
407d1a51921e9f Lizhi Hou    2023-08-15  302  					      int_map_mask,
407d1a51921e9f Lizhi Hou    2023-08-15  303  					      ARRAY_SIZE(int_map_mask));
407d1a51921e9f Lizhi Hou    2023-08-15  304  	if (ret)
407d1a51921e9f Lizhi Hou    2023-08-15  305  		goto failed;
407d1a51921e9f Lizhi Hou    2023-08-15  306  
407d1a51921e9f Lizhi Hou    2023-08-15  307  	kfree(int_map);
407d1a51921e9f Lizhi Hou    2023-08-15  308  	return 0;
407d1a51921e9f Lizhi Hou    2023-08-15  309  
407d1a51921e9f Lizhi Hou    2023-08-15  310  failed:
407d1a51921e9f Lizhi Hou    2023-08-15  311  	kfree(int_map);
407d1a51921e9f Lizhi Hou    2023-08-15  312  	return ret;
407d1a51921e9f Lizhi Hou    2023-08-15  313  }
407d1a51921e9f Lizhi Hou    2023-08-15  314  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

