Return-Path: <linux-kernel+bounces-436735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32A9E8A13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B57163916
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569277F477;
	Mon,  9 Dec 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrmF43l5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CA320B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716927; cv=none; b=QLE87si7OuRqb44lYpajuhEG2pY1DJH0/bx19++TYuSCieK8WGBIrpICBmMHSOduDWAp8no7YzEMpyl2SSWkYANOWvMZFJyxyyAtJKp+TibpfDyz0UfAmqvj778rv5sxlZ9fE4jXso8Voa1DEVSc0q051SfXr9lEjU7XrBoVywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716927; c=relaxed/simple;
	bh=IbpLkYT0aO8MIeYJ8GdwcF7td7B6R3AWyISPloTHf6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pQ+J73rZ5pDIUihZidwEmRa2qTsyJRGI22SdDUdvI2lMiNeJVR24q+66yhRH7zAz9DM7wzdymdGQBZsYwX9m6pP0pPtWyq3wOyKUrQQ1v/+WkCLNA1bvrO0z2aQISxEDo8/2ueByij/UePMZZ52edZV7MbkllhKMYb7VtoAjB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrmF43l5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733716926; x=1765252926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IbpLkYT0aO8MIeYJ8GdwcF7td7B6R3AWyISPloTHf6Y=;
  b=GrmF43l5zqr2V7HBRlzQx0v/Efb+hRsI5tKABmvw2weoJrqYrpI7xkM5
   HBDXkcKKTjX8qmg02ilYVT9xGBW9fynxb0/IulqaX5J7jhk/9IY6RuDJp
   nnkHGmhnz2PZIQvhsvjB69WF8mrF+BIVhW4gDGBjwdE81LVCYoqFhVS83
   CzoKFxVPBqo0xgnZ0I5Rnwkh4yCIm6/idT6x8tX1y/TKF8eCDXD4aCiA/
   roP3GBjtUyQDHVS/Kr/CRH4UwY9uJ2e9HhOm25QUzS304PPCdVk/sNOPS
   qqPux0Is1YsazQdt1GTWuC3MyAiKXSvTwiT0QyEnxyGZewyZI4PQ+e5zT
   g==;
X-CSE-ConnectionGUID: 1UbLfGCLQi2anoAp6FSyug==
X-CSE-MsgGUID: A8Ev52ENTOiDewzIrnDeOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34235125"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34235125"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:02:06 -0800
X-CSE-ConnectionGUID: DYmFgp7jSOS9zASxft3kbg==
X-CSE-MsgGUID: nboRWYJCSMavK3D43A7ulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94822159"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2024 20:02:04 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUy9-0003mH-2Y;
	Mon, 09 Dec 2024 04:02:01 +0000
Date: Mon, 9 Dec 2024 12:01:10 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Rob Herring <robh@kernel.org>
Subject: arch/powerpc/kernel/prom_init.c:2897:22: sparse: sparse: incorrect
 type in initializer (different base types)
Message-ID: <202412071026.URGzioD6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: cf89c9434af122f28a3552e6f9cc5158c33ce50a powerpc/prom_init: Fixup missing powermac #size-cells
date:   10 days ago
config: powerpc64-randconfig-r113-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071026.URGzioD6-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412071026.URGzioD6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071026.URGzioD6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/prom_init.c:2897:22: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 [usertype] val @@     got int @@
   arch/powerpc/kernel/prom_init.c:2897:22: sparse:     expected restricted __be32 [usertype] val
   arch/powerpc/kernel/prom_init.c:2897:22: sparse:     got int

vim +2897 arch/powerpc/kernel/prom_init.c

  2893	
  2894	#ifdef CONFIG_PPC_PMAC
  2895	static void __init fixup_device_tree_pmac(void)
  2896	{
> 2897		__be32 val = 1;
  2898		char type[8];
  2899		phandle node;
  2900	
  2901		// Some pmacs are missing #size-cells on escc nodes
  2902		for (node = 0; prom_next_node(&node); ) {
  2903			type[0] = '\0';
  2904			prom_getprop(node, "device_type", type, sizeof(type));
  2905			if (prom_strcmp(type, "escc"))
  2906				continue;
  2907	
  2908			if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
  2909				continue;
  2910	
  2911			prom_setprop(node, NULL, "#size-cells", &val, sizeof(val));
  2912		}
  2913	}
  2914	#else
  2915	static inline void fixup_device_tree_pmac(void) { }
  2916	#endif
  2917	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

