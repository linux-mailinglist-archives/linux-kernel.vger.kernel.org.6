Return-Path: <linux-kernel+bounces-302417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D608E95FE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F9F1C21C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4374A31;
	Tue, 27 Aug 2024 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMB9BT1V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823F23CE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724720505; cv=none; b=mlPdTlN4i+EsvbCxuprO+HuQV8JoCZT76ZuU/RoMqJC/1mIRUG7wY2iqXF/TD+qCqlLVccMATWK51Oybnam2G5Y8+fRbmOWECl1POGV7vpFK5E/jlkaGgDEp7zpLiwdEnXMcs+E/spNx0AhWtvNcAjF+phMUo6/c0xWeupJGOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724720505; c=relaxed/simple;
	bh=rFufEXOcqmHihXud+JM7yUDTs+ayr54truiXZ9jdepM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urr/cQ27UaSgh8ow1EQqAQfBQNa3+GyzzApoBbjUun0f64snmM+Ra6azJlzab3Hs7NNNFlhrI8mbN5BE6ryJzG9g7iFLZzL8NgL/RJ+xeekROmFPa76evFiyxW0wpmBaDdtbRE+ZtNyGlW7PltgbDbJhzV2CGGSyt6mlvRVx0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMB9BT1V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724720503; x=1756256503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rFufEXOcqmHihXud+JM7yUDTs+ayr54truiXZ9jdepM=;
  b=CMB9BT1V1g6GWFeykjE9S1SmwZT3TJiMnGjjoJth9oNeYB1m6yd7vaLs
   4/u+UeEg8CQd7HZE1zo+ZAOVbrgTY38zhMnpFDPWr5kC4cp798VbgNWUV
   04wFd4CWlrZJ/lO1R7BjqLE67obF+B8AO6TqEaeX4mPEWn/37UugUKqxy
   E7D6o4rfPE4dxRngzOpL3/VN/IUhHZbhlGtZpDgXCRLyj57XU0B7A4U9u
   bIeyXIzUKimX7XMNEFUJBiOdPShn4mP8Wk5+YCBKx1YVTtJfpBx9qJzzX
   MaxobgBRU2+BQKuraLoQrvFjLaIxsZqa3HUHlON0qUhVSyUJ6HGUEa03A
   A==;
X-CSE-ConnectionGUID: 8sHO8qn4TQ6FlWzICp1QXw==
X-CSE-MsgGUID: 6XFPzyO2S4qCxTeTpNgaQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26966846"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="26966846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 18:01:42 -0700
X-CSE-ConnectionGUID: HTA7rQF+RV6Q3r4UgQjoiA==
X-CSE-MsgGUID: CoFx0FOYREmguxYzLdTD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62364145"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2024 18:01:39 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sikaX-000Hjn-17;
	Tue, 27 Aug 2024 01:01:37 +0000
Date: Tue, 27 Aug 2024 09:01:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kunwu Chan <kunwu.chan@linux.dev>, nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] cdx: make cdx_bus_type constant
Message-ID: <202408270946.gKlAW6oT-lkp@intel.com>
References: <20240823071412.130246-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823071412.130246-1-kunwu.chan@linux.dev>

Hi Kunwu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kunwu-Chan/cdx-make-cdx_bus_type-constant/20240826-123621
base:   linus/master
patch link:    https://lore.kernel.org/r/20240823071412.130246-1-kunwu.chan%40linux.dev
patch subject: [PATCH] cdx: make cdx_bus_type constant
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408270946.gKlAW6oT-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270946.gKlAW6oT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270946.gKlAW6oT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cdx/cdx.c:66:
   In file included from include/linux/mm.h:2228:
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
>> drivers/cdx/cdx.c:615:25: error: passing 'const struct bus_type *' to parameter of type 'struct bus_type *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     615 |         cdx_unregister_devices(&cdx_bus_type);
         |                                ^~~~~~~~~~~~~
   drivers/cdx/cdx.c:173:53: note: passing argument to parameter 'bus' here
     173 | static void cdx_unregister_devices(struct bus_type *bus)
         |                                                     ^
   4 warnings and 1 error generated.


vim +615 drivers/cdx/cdx.c

cf60af04edfe51 Abhijit Gangurde 2023-12-22  597  
d06f5a3f714092 Linus Torvalds   2023-04-27  598  static ssize_t rescan_store(const struct bus_type *bus,
2959ab247061e6 Nipun Gupta      2023-03-13  599  			    const char *buf, size_t count)
2959ab247061e6 Nipun Gupta      2023-03-13  600  {
2959ab247061e6 Nipun Gupta      2023-03-13  601  	struct cdx_controller *cdx;
54b406e10f0334 Abhijit Gangurde 2023-10-17  602  	struct platform_device *pd;
54b406e10f0334 Abhijit Gangurde 2023-10-17  603  	struct device_node *np;
2959ab247061e6 Nipun Gupta      2023-03-13  604  	bool val;
2959ab247061e6 Nipun Gupta      2023-03-13  605  
2959ab247061e6 Nipun Gupta      2023-03-13  606  	if (kstrtobool(buf, &val) < 0)
2959ab247061e6 Nipun Gupta      2023-03-13  607  		return -EINVAL;
2959ab247061e6 Nipun Gupta      2023-03-13  608  
2959ab247061e6 Nipun Gupta      2023-03-13  609  	if (!val)
2959ab247061e6 Nipun Gupta      2023-03-13  610  		return -EINVAL;
2959ab247061e6 Nipun Gupta      2023-03-13  611  
f0af816834667b Abhijit Gangurde 2023-10-17  612  	mutex_lock(&cdx_controller_lock);
f0af816834667b Abhijit Gangurde 2023-10-17  613  
2959ab247061e6 Nipun Gupta      2023-03-13  614  	/* Unregister all the devices on the bus */
2959ab247061e6 Nipun Gupta      2023-03-13 @615  	cdx_unregister_devices(&cdx_bus_type);
2959ab247061e6 Nipun Gupta      2023-03-13  616  
2959ab247061e6 Nipun Gupta      2023-03-13  617  	/* Rescan all the devices */
54b406e10f0334 Abhijit Gangurde 2023-10-17  618  	for_each_compatible_node(np, NULL, compat_node_name) {
54b406e10f0334 Abhijit Gangurde 2023-10-17  619  		pd = of_find_device_by_node(np);
87736ae12e1427 Dan Carpenter    2024-01-02  620  		if (!pd) {
87736ae12e1427 Dan Carpenter    2024-01-02  621  			of_node_put(np);
1960932eef9183 Dan Carpenter    2024-01-02  622  			count = -EINVAL;
1960932eef9183 Dan Carpenter    2024-01-02  623  			goto unlock;
87736ae12e1427 Dan Carpenter    2024-01-02  624  		}
54b406e10f0334 Abhijit Gangurde 2023-10-17  625  
54b406e10f0334 Abhijit Gangurde 2023-10-17  626  		cdx = platform_get_drvdata(pd);
54b406e10f0334 Abhijit Gangurde 2023-10-17  627  		if (cdx && cdx->controller_registered && cdx->ops->scan)
54b406e10f0334 Abhijit Gangurde 2023-10-17  628  			cdx->ops->scan(cdx);
54b406e10f0334 Abhijit Gangurde 2023-10-17  629  
54b406e10f0334 Abhijit Gangurde 2023-10-17  630  		put_device(&pd->dev);
2959ab247061e6 Nipun Gupta      2023-03-13  631  	}
2959ab247061e6 Nipun Gupta      2023-03-13  632  
1960932eef9183 Dan Carpenter    2024-01-02  633  unlock:
f0af816834667b Abhijit Gangurde 2023-10-17  634  	mutex_unlock(&cdx_controller_lock);
f0af816834667b Abhijit Gangurde 2023-10-17  635  
2959ab247061e6 Nipun Gupta      2023-03-13  636  	return count;
2959ab247061e6 Nipun Gupta      2023-03-13  637  }
2959ab247061e6 Nipun Gupta      2023-03-13  638  static BUS_ATTR_WO(rescan);
2959ab247061e6 Nipun Gupta      2023-03-13  639  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

