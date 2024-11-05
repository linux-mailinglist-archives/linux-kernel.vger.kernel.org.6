Return-Path: <linux-kernel+bounces-396369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C309BCC43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581B72828E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404C1D5141;
	Tue,  5 Nov 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wf3tXxy2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AF1D47BB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807970; cv=none; b=GKTLx/MhJhdFajuR825yLCSEMkDiaiBDL1GxCYBc4L+IjTwZpSn3h1UI/5Au6Bywqg+7EWCuegckhyv7BdT/nuaaOSiRhHI7dA49YKCQA4/IDDp350G3WzgTomxdaMtV4fBSuBt/h/JrvG3UYYqVNpESKsSHcuHuK/xEjJ5OenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807970; c=relaxed/simple;
	bh=iYxQvThTulFNhTxYIClRL9WZNYpwyg57I7kQicsNez4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN1jVONcmSiQ/cQcMbPSauZCB57kGn7xPSWuewIIvru78xIMc3zU+e8uno8/yKP/clt0/Ncw3PSAct31f2y2T3aUj2wK1VAhxu8zpI4Z1Obnd5R+tRPzBmD1cCW7JG+oFucQV3nevZQvxd399FzPYS+Wwsi6rE0Qg3ku2NQQoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wf3tXxy2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730807969; x=1762343969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iYxQvThTulFNhTxYIClRL9WZNYpwyg57I7kQicsNez4=;
  b=Wf3tXxy2J4tIfPBP+jVrZvyc/94sUK1Xh/bzhkMC+7KRJOE8bBn7BjqE
   qPTgEu7PMXgTZEfYjGESrBOlgq7u7DScy1RYRmT4qIe4pB8VceYZxLJ0W
   iJtFSK1Hc4+IgwvqbpZwXAXuwzEBvh38DSGVhvNIqAuikiKnXE91XpFbJ
   foZfrRACBaqtDG0NY/APeOw7+iaQnUyqJeec+JupkXObzKPYTRCJ5dkSp
   u48xC3DWf0ndKvATRjePQGajm/5bgkUbo8wvbmcEFTYTMW4DLDgQs1duU
   3EldpYqT0MXHv9uaqDeoqeZXthyHRMxqpq8ta363x9oPGwyWQibY1zKsH
   g==;
X-CSE-ConnectionGUID: FCgV3zaxRbWCdLZXQ3VoMQ==
X-CSE-MsgGUID: ZR9rXS+BTfy9ZwuqfuDCdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34334325"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="34334325"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 03:59:29 -0800
X-CSE-ConnectionGUID: g137h1dwRHqce1kdrFxOZw==
X-CSE-MsgGUID: xyBxIVTPSwmvbT0BCkpeLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="83885424"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Nov 2024 03:59:26 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8IDT-000m1L-36;
	Tue, 05 Nov 2024 11:59:23 +0000
Date: Tue, 5 Nov 2024 19:58:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
Message-ID: <202411051924.dZP9MxDH-lkp@intel.com>
References: <20241105060531.3503788-3-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105060531.3503788-3-Jiqian.Chen@amd.com>

Hi Jiqian,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiqian-Chen/drm-amdgpu-set-passthrough-mode-for-xen-pvh-hvm/20241105-141716
base:   linus/master
patch link:    https://lore.kernel.org/r/20241105060531.3503788-3-Jiqian.Chen%40amd.com
patch subject: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
config: arc-randconfig-002-20241105 (https://download.01.org/0day-ci/archive/20241105/202411051924.dZP9MxDH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051924.dZP9MxDH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411051924.dZP9MxDH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from include/linux/power_supply.h:15,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:28:
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function 'amdgpu_device_resize_fb_bar':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1542:13: error: implicit declaration of function 'xen_initial_domain' [-Werror=implicit-function-declaration]
    1542 |         if (xen_initial_domain() && xen_pvh_domain())
         |             ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1542:9: note: in expansion of macro 'if'
    1542 |         if (xen_initial_domain() && xen_pvh_domain())
         |         ^~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1542:37: error: implicit declaration of function 'xen_pvh_domain' [-Werror=implicit-function-declaration]
    1542 |         if (xen_initial_domain() && xen_pvh_domain())
         |                                     ^~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1542:9: note: in expansion of macro 'if'
    1542 |         if (xen_initial_domain() && xen_pvh_domain())
         |         ^~
   cc1: some warnings being treated as errors


vim +/xen_initial_domain +1542 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

  1519	
  1520	/**
  1521	 * amdgpu_device_resize_fb_bar - try to resize FB BAR
  1522	 *
  1523	 * @adev: amdgpu_device pointer
  1524	 *
  1525	 * Try to resize FB BAR to make all VRAM CPU accessible. We try very hard not
  1526	 * to fail, but if any of the BARs is not accessible after the size we abort
  1527	 * driver loading by returning -ENODEV.
  1528	 */
  1529	int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
  1530	{
  1531		int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
  1532		struct pci_bus *root;
  1533		struct resource *res;
  1534		unsigned int i;
  1535		u16 cmd;
  1536		int r;
  1537	
  1538		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
  1539			return 0;
  1540	
  1541		/* Bypass for PVH dom0 which doesn't support resizable bar */
> 1542		if (xen_initial_domain() && xen_pvh_domain())
  1543			return 0;
  1544	
  1545		/* Bypass for VF */
  1546		if (amdgpu_sriov_vf(adev))
  1547			return 0;
  1548	
  1549		/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
  1550		if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
  1551			DRM_WARN("System can't access extended configuration space, please check!!\n");
  1552	
  1553		/* skip if the bios has already enabled large BAR */
  1554		if (adev->gmc.real_vram_size &&
  1555		    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
  1556			return 0;
  1557	
  1558		/* Check if the root BUS has 64bit memory resources */
  1559		root = adev->pdev->bus;
  1560		while (root->parent)
  1561			root = root->parent;
  1562	
  1563		pci_bus_for_each_resource(root, res, i) {
  1564			if (res && res->flags & (IORESOURCE_MEM | IORESOURCE_MEM_64) &&
  1565			    res->start > 0x100000000ull)
  1566				break;
  1567		}
  1568	
  1569		/* Trying to resize is pointless without a root hub window above 4GB */
  1570		if (!res)
  1571			return 0;
  1572	
  1573		/* Limit the BAR size to what is available */
  1574		rbar_size = min(fls(pci_rebar_get_possible_sizes(adev->pdev, 0)) - 1,
  1575				rbar_size);
  1576	
  1577		/* Disable memory decoding while we change the BAR addresses and size */
  1578		pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
  1579		pci_write_config_word(adev->pdev, PCI_COMMAND,
  1580				      cmd & ~PCI_COMMAND_MEMORY);
  1581	
  1582		/* Free the VRAM and doorbell BAR, we most likely need to move both. */
  1583		amdgpu_doorbell_fini(adev);
  1584		if (adev->asic_type >= CHIP_BONAIRE)
  1585			pci_release_resource(adev->pdev, 2);
  1586	
  1587		pci_release_resource(adev->pdev, 0);
  1588	
  1589		r = pci_resize_resource(adev->pdev, 0, rbar_size);
  1590		if (r == -ENOSPC)
  1591			DRM_INFO("Not enough PCI address space for a large BAR.");
  1592		else if (r && r != -ENOTSUPP)
  1593			DRM_ERROR("Problem resizing BAR0 (%d).", r);
  1594	
  1595		pci_assign_unassigned_bus_resources(adev->pdev->bus);
  1596	
  1597		/* When the doorbell or fb BAR isn't available we have no chance of
  1598		 * using the device.
  1599		 */
  1600		r = amdgpu_doorbell_init(adev);
  1601		if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
  1602			return -ENODEV;
  1603	
  1604		pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
  1605	
  1606		return 0;
  1607	}
  1608	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

