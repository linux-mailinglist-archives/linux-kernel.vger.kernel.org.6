Return-Path: <linux-kernel+bounces-301610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2995F325
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60471F257BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD117B51A;
	Mon, 26 Aug 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjQzWRDq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA539ACC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679671; cv=none; b=Ao8WkAgfjwrFb93asnS/xRh+gSvc01RJDV4fk4+ffqirTCcLshZWX71Z1TXoGh2HUENu8sMPBzcYbMvpokTAaXJ0NTo6V/aGpmIlwOF6rP25kMOtpviJKhvD/c1TkwFmRWpqqDF7mn9Vwm2nMC0Bylg82fdha3kCWr3Tyq5GTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679671; c=relaxed/simple;
	bh=QjiuMEY23AtkS1V1uCfTFZCcmenzK+Ss7tEr0SEksHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD7lTjzU0IGB/PWrL0lRCb+E0kR+eW+vCApG8kAYUrrfXoA9f7m82QIhWXCt7cSDRpBCOYhDLZCwj8nr5saOri8aTtfKfUBJpgyjuttt6mJKxPU1q2gxNwmkAruRg3rK7uk5C1AehPZtXKQnXcEhynhpwiEzNjibllnlDzNIa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjQzWRDq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724679670; x=1756215670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QjiuMEY23AtkS1V1uCfTFZCcmenzK+Ss7tEr0SEksHQ=;
  b=HjQzWRDqYfZpG+9B4fcxlOWl/jVNTB0KqMiI3TYqBHSastHxOizvjCSt
   o1/rZNPLCCf22i0nBgqQjQfF7ElZW3zvEzVIAVVSLdakdnq5kRdvKtNDm
   LKN7Czs5DGn0Wq7Q8MU8mW+2KbNTu6gKvCfUg5y9GaC25BqXin8Vd96Ix
   fiOcZ+RsX6G8hEGv5Dt5vDSrbJpuXnS1GiLKq5flbONB17Q0fGJQWPc75
   c4PMpbh1QtxHz8HZtMzIFV5bMYH0WAWDLsS8xeWWhM3CUIXULX6t9MiSo
   WfiWoM6NG3514G+UvqhXwWvHznncJfIwHnOPLeR6jHSBVpTh9xiCj+zEm
   A==;
X-CSE-ConnectionGUID: ZH7v9JizQDeH4O6yKlI+QA==
X-CSE-MsgGUID: BZktonuUR/6+OWsQ5gYTsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34512881"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="34512881"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:41:09 -0700
X-CSE-ConnectionGUID: 8YJN0S8uTc6HOF/BW4FTeQ==
X-CSE-MsgGUID: kNYjS9Z3R36eZNkt/t7TGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62483237"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 06:41:07 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siZxw-000H9C-2C;
	Mon, 26 Aug 2024 13:41:04 +0000
Date: Mon, 26 Aug 2024 21:41:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kunwu Chan <kunwu.chan@linux.dev>, nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] cdx: make cdx_bus_type constant
Message-ID: <202408262114.VRSL0Knh-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kunwu-Chan/cdx-make-cdx_bus_type-constant/20240826-123621
base:   linus/master
patch link:    https://lore.kernel.org/r/20240823071412.130246-1-kunwu.chan%40linux.dev
patch subject: [PATCH] cdx: make cdx_bus_type constant
config: arm64-randconfig-002-20240826 (https://download.01.org/0day-ci/archive/20240826/202408262114.VRSL0Knh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408262114.VRSL0Knh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408262114.VRSL0Knh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cdx/cdx.c: In function 'rescan_store':
>> drivers/cdx/cdx.c:615:32: warning: passing argument 1 of 'cdx_unregister_devices' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     615 |         cdx_unregister_devices(&cdx_bus_type);
         |                                ^~~~~~~~~~~~~
   drivers/cdx/cdx.c:173:53: note: expected 'struct bus_type *' but argument is of type 'const struct bus_type *'
     173 | static void cdx_unregister_devices(struct bus_type *bus)
         |                                    ~~~~~~~~~~~~~~~~~^~~


vim +615 drivers/cdx/cdx.c

cf60af04edfe51f Abhijit Gangurde 2023-12-22  597  
d06f5a3f7140921 Linus Torvalds   2023-04-27  598  static ssize_t rescan_store(const struct bus_type *bus,
2959ab247061e67 Nipun Gupta      2023-03-13  599  			    const char *buf, size_t count)
2959ab247061e67 Nipun Gupta      2023-03-13  600  {
2959ab247061e67 Nipun Gupta      2023-03-13  601  	struct cdx_controller *cdx;
54b406e10f0334e Abhijit Gangurde 2023-10-17  602  	struct platform_device *pd;
54b406e10f0334e Abhijit Gangurde 2023-10-17  603  	struct device_node *np;
2959ab247061e67 Nipun Gupta      2023-03-13  604  	bool val;
2959ab247061e67 Nipun Gupta      2023-03-13  605  
2959ab247061e67 Nipun Gupta      2023-03-13  606  	if (kstrtobool(buf, &val) < 0)
2959ab247061e67 Nipun Gupta      2023-03-13  607  		return -EINVAL;
2959ab247061e67 Nipun Gupta      2023-03-13  608  
2959ab247061e67 Nipun Gupta      2023-03-13  609  	if (!val)
2959ab247061e67 Nipun Gupta      2023-03-13  610  		return -EINVAL;
2959ab247061e67 Nipun Gupta      2023-03-13  611  
f0af816834667b6 Abhijit Gangurde 2023-10-17  612  	mutex_lock(&cdx_controller_lock);
f0af816834667b6 Abhijit Gangurde 2023-10-17  613  
2959ab247061e67 Nipun Gupta      2023-03-13  614  	/* Unregister all the devices on the bus */
2959ab247061e67 Nipun Gupta      2023-03-13 @615  	cdx_unregister_devices(&cdx_bus_type);
2959ab247061e67 Nipun Gupta      2023-03-13  616  
2959ab247061e67 Nipun Gupta      2023-03-13  617  	/* Rescan all the devices */
54b406e10f0334e Abhijit Gangurde 2023-10-17  618  	for_each_compatible_node(np, NULL, compat_node_name) {
54b406e10f0334e Abhijit Gangurde 2023-10-17  619  		pd = of_find_device_by_node(np);
87736ae12e1427b Dan Carpenter    2024-01-02  620  		if (!pd) {
87736ae12e1427b Dan Carpenter    2024-01-02  621  			of_node_put(np);
1960932eef9183e Dan Carpenter    2024-01-02  622  			count = -EINVAL;
1960932eef9183e Dan Carpenter    2024-01-02  623  			goto unlock;
87736ae12e1427b Dan Carpenter    2024-01-02  624  		}
54b406e10f0334e Abhijit Gangurde 2023-10-17  625  
54b406e10f0334e Abhijit Gangurde 2023-10-17  626  		cdx = platform_get_drvdata(pd);
54b406e10f0334e Abhijit Gangurde 2023-10-17  627  		if (cdx && cdx->controller_registered && cdx->ops->scan)
54b406e10f0334e Abhijit Gangurde 2023-10-17  628  			cdx->ops->scan(cdx);
54b406e10f0334e Abhijit Gangurde 2023-10-17  629  
54b406e10f0334e Abhijit Gangurde 2023-10-17  630  		put_device(&pd->dev);
2959ab247061e67 Nipun Gupta      2023-03-13  631  	}
2959ab247061e67 Nipun Gupta      2023-03-13  632  
1960932eef9183e Dan Carpenter    2024-01-02  633  unlock:
f0af816834667b6 Abhijit Gangurde 2023-10-17  634  	mutex_unlock(&cdx_controller_lock);
f0af816834667b6 Abhijit Gangurde 2023-10-17  635  
2959ab247061e67 Nipun Gupta      2023-03-13  636  	return count;
2959ab247061e67 Nipun Gupta      2023-03-13  637  }
2959ab247061e67 Nipun Gupta      2023-03-13  638  static BUS_ATTR_WO(rescan);
2959ab247061e67 Nipun Gupta      2023-03-13  639  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

