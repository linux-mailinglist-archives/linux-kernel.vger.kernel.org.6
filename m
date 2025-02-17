Return-Path: <linux-kernel+bounces-516972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54066A37A66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2653E16B9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A65154C12;
	Mon, 17 Feb 2025 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlytBlLW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B542A96
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765862; cv=none; b=r9TuNYLNk9U6k5cl5i84a/3+Fro/C8BfE74WiEqy2EeERNy/OqHmiVrxcdzFeV85htllhYfe81XvkpLCxfC5j+K4OcKashhYEY4ehdCxYyuE7DFy6aFLsfQfoGc4jUQbndEeybiYSYpXv+/+CVFqQVRa6Hw8otsDMwQkTPSdM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765862; c=relaxed/simple;
	bh=qgUDd3/F1tTTTB6/od9suhzDHm1xNMQRc9pKyrhCIFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GHDG1C8J/d6fcF2VehORoRdyR1NfrLRIqWGhzleDbWeS2gfaiN19nuxHnCME1OtRkwCNtKWCABjiyVKWEvpS8RJD5sZvgRiSugesWr6U05h6JR9+hAPeMPcvG1wn/GGEKmVJK1l9h6uFybodwKfmtE06i24MO6cdXbvO903arzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlytBlLW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739765860; x=1771301860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qgUDd3/F1tTTTB6/od9suhzDHm1xNMQRc9pKyrhCIFA=;
  b=YlytBlLWjBIvcNmCottaY8bC6fli4FQo2FY89N3n4uVi6N02AYlMzVI8
   8o8vvMVCeUK7HXLuyWIFBAjwiGnHN6n1EopTN6jnvDzfVOHxl+uI3K/yh
   o9WddsVrd0IyLJSt8gb0Bmmh9CylTHXqOCcplS+yPSqu5WUJBILIv6hcW
   ITBJQ7rLO40S/SZGBuklqqt3xiiRRURrxBAJhQL/BBo6hhxPv4D0e8m4R
   YVj1ORfCLnrr8+awkvCh6kORbzZcpk5h7vxekhWw6yYg5xdnKut1/qnyD
   lgcVo+MZNNH3KPCr9C3Tyhizn6qQ+E763ef/GI/agjmn6WLNRQt5wnCaF
   g==;
X-CSE-ConnectionGUID: ytDdWahDTFaQ0zuTxEDZuQ==
X-CSE-MsgGUID: T663hgeIQ6GNUaB5ThG0VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51419579"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51419579"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 20:17:40 -0800
X-CSE-ConnectionGUID: 2u3BgYT1Q1CQjcYUjIXnXQ==
X-CSE-MsgGUID: NkhhI3KwTbCpvtYA/t1TZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="113748802"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Feb 2025 20:17:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjsZb-001CaF-2S;
	Mon, 17 Feb 2025 04:17:35 +0000
Date: Mon, 17 Feb 2025 12:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Shay Drory <shayd@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h:48:34: warning:
 '%s' directive argument is null
Message-ID: <202502171213.m2F5fqWs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shay,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0ad2507d5d93f39619fc42372c347d6006b64319
commit: 71e084e26414b0f27d8befa1c30b74d39d9cb2a1 net/mlx5: Allocating a pool of MSI-X vectors for SFs
date:   3 years, 8 months ago
config: mips-randconfig-r015-20230807 (https://download.01.org/0day-ci/archive/20250217/202502171213.m2F5fqWs-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250217/202502171213.m2F5fqWs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502171213.m2F5fqWs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/topology.h:33,
                    from include/linux/irq.h:19,
                    from include/asm-generic/hardirq.h:17,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:4:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1320:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1320 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1306:27: note: 'mem_section' declared here
    1306 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:17,
                    from include/linux/interrupt.h:6:
   In function 'irq_pool_alloc',
       inlined from 'irq_pools_init' at drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:332:19,
       inlined from 'mlx5_irq_table_create' at drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:437:8:
>> drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h:48:34: warning: '%s' directive argument is null [-Wformat-overflow=]
      48 |         dev_dbg((__dev)->device, "%s:%d:(pid %d): " format,             \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h:48:9: note: in expansion of macro 'dev_dbg'
      48 |         dev_dbg((__dev)->device, "%s:%d:(pid %d): " format,             \
         |         ^~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:307:9: note: in expansion of macro 'mlx5_core_dbg'
     307 |         mlx5_core_dbg(dev, "pool->name = %s, pool->size = %d, pool->start = %d",
         |         ^~~~~~~~~~~~~


vim +48 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h

e126ba97dba9ed Eli Cohen    2013-07-07  46  
5a7883989b1c57 Eli Cohen    2015-10-08  47  #define mlx5_core_dbg(__dev, format, ...)				\
27b942fbbd3107 Parav Pandit 2019-04-29 @48  	dev_dbg((__dev)->device, "%s:%d:(pid %d): " format,		\
9e5b2fc1d39b31 Kamal Heib   2016-12-06  49  		 __func__, __LINE__, current->pid,			\
1a91de28831a1b Joe Perches  2014-05-07  50  		 ##__VA_ARGS__)
e126ba97dba9ed Eli Cohen    2013-07-07  51  

:::::: The code at line 48 was first introduced by commit
:::::: 27b942fbbd3107d4e969ece133925cd646239ef4 net/mlx5: Get rid of storing copy of device name

:::::: TO: Parav Pandit <parav@mellanox.com>
:::::: CC: Saeed Mahameed <saeedm@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

