Return-Path: <linux-kernel+bounces-249253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3997692E903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF76B2A7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9616C6B1;
	Thu, 11 Jul 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cm/2qWjL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618916B3B4;
	Thu, 11 Jul 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703016; cv=none; b=ei1mA2MxJX6RFtkj7v3Z3fNqatGUbOJaz35Vlalhg70F8HRhB/w2zkF6MAjDHL3Trh5wyh3fXxXbCHX2RJyXH6O2FmEmOSH4eJX9acy2ojcymImbbk6szMgiDvAPv4Vdp9oIgOg3nEXXbrU7ThFzg4hlpBwbvumTkvKjHR2C4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703016; c=relaxed/simple;
	bh=WksQQhS1iN4+Nz2CYL8nDdFPIRpmNFBZK+rD9iwIP3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFTdibYZlY040dgfHZ+w7Wumdubr/3PiFf/Knt964PE3sOsYyFCUnQGrFhX86CSfcUPAlKq76+JiYQAzJHb3IVmVmCOsN/gshty4fMF9vEHIs6n85MwIeBetHiMaJMHNhj6GGkdqV/SDSNtGjZIU06onmxgsI9so/+wKIfhXr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cm/2qWjL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720703014; x=1752239014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WksQQhS1iN4+Nz2CYL8nDdFPIRpmNFBZK+rD9iwIP3c=;
  b=cm/2qWjLJChBa1TJGJVBMDiPUHT89pW9fheMCkkPNSFfsjH/0vYSOk63
   MCJQwpAKIiiBg8DpUqd0pNpH4Safx2V1whKFSCzbUn9XYaIG08bJBqOEI
   zSGHLBZNWPw0YuBYYd/Bk7iA1LsRzbCdp/LVcp34SgaV+w05muNi1qiBr
   MDcsBVjuPvgaIFLlaO4G+8cMMXggoMhs2B0mlGehPDKQZjUiqDzhO0K7w
   osEfKa2CgyQdxj8ueymJfzJazn/qoIISNRmXvazuZ+ViZTLxgABM082hW
   txmm6RGa9iQa37i+MKxsm0kA6BlXUQmpxIn/lP9RMNXZktGUfXQdLsIXc
   g==;
X-CSE-ConnectionGUID: RyJbTQRTQDuRSP195BF7iA==
X-CSE-MsgGUID: X8lpw7RHTs+nqjHcsyQ3Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17923979"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17923979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:02:28 -0700
X-CSE-ConnectionGUID: Wm7DtgDwQxmo22zAtIckZA==
X-CSE-MsgGUID: ayBCDhSSQ1WDtC8+CHE8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48626124"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 06:02:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRtRG-000ZIM-3D;
	Thu, 11 Jul 2024 13:02:23 +0000
Date: Thu, 11 Jul 2024 21:02:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
Message-ID: <202407112023.ixKkILn7-lkp@intel.com>
References: <20240710162526.2341399-8-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710162526.2341399-8-jbrunet@baylibre.com>

Hi Jerome,

kernel test robot noticed the following build errors:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on clk/clk-next linus/master v6.10-rc7 next-20240711]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/reset-amlogic-convert-driver-to-regmap/20240711-055833
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20240710162526.2341399-8-jbrunet%40baylibre.com
patch subject: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
config: i386-buildonly-randconfig-005-20240711 (https://download.01.org/0day-ci/archive/20240711/202407112023.ixKkILn7-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407112023.ixKkILn7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407112023.ixKkILn7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/auxiliary_bus.h:11,
                    from drivers/reset/reset-meson.c:8:
   include/linux/module.h:131:42: error: redefinition of '__inittest'
     131 |  static inline initcall_t __maybe_unused __inittest(void)  \
         |                                          ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/auxiliary_bus.h:245:2: note: in expansion of macro 'module_driver'
     245 |  module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:272:1: note: in expansion of macro 'module_auxiliary_driver'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:42: note: previous definition of '__inittest' was here
     131 |  static inline initcall_t __maybe_unused __inittest(void)  \
         |                                          ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:2: note: in expansion of macro 'module_driver'
     303 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:232:1: note: in expansion of macro 'module_platform_driver'
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:6: error: redefinition of 'init_module'
     133 |  int init_module(void) __copy(initfn)   \
         |      ^~~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/auxiliary_bus.h:245:2: note: in expansion of macro 'module_driver'
     245 |  module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:272:1: note: in expansion of macro 'module_auxiliary_driver'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:6: note: previous definition of 'init_module' was here
     133 |  int init_module(void) __copy(initfn)   \
         |      ^~~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:2: note: in expansion of macro 'module_driver'
     303 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:232:1: note: in expansion of macro 'module_platform_driver'
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:139:42: error: redefinition of '__exittest'
     139 |  static inline exitcall_t __maybe_unused __exittest(void)  \
         |                                          ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/auxiliary_bus.h:245:2: note: in expansion of macro 'module_driver'
     245 |  module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:272:1: note: in expansion of macro 'module_auxiliary_driver'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:139:42: note: previous definition of '__exittest' was here
     139 |  static inline exitcall_t __maybe_unused __exittest(void)  \
         |                                          ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:2: note: in expansion of macro 'module_driver'
     303 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:232:1: note: in expansion of macro 'module_platform_driver'
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:141:7: error: redefinition of 'cleanup_module'
     141 |  void cleanup_module(void) __copy(exitfn)  \
         |       ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/auxiliary_bus.h:245:2: note: in expansion of macro 'module_driver'
     245 |  module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:272:1: note: in expansion of macro 'module_auxiliary_driver'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:141:7: note: previous definition of 'cleanup_module' was here
     141 |  void cleanup_module(void) __copy(exitfn)  \
         |       ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:2: note: in expansion of macro 'module_driver'
     303 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/reset/reset-meson.c:232:1: note: in expansion of macro 'module_platform_driver'
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/reset/reset-meson.c:292:5: error: redefinition of 'devm_meson_rst_aux_register'
     292 | int devm_meson_rst_aux_register(struct device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/reset/reset-meson.c:20:
   include/soc/amlogic/meson-auxiliary-reset.h:15:19: note: previous definition of 'devm_meson_rst_aux_register' was here
      15 | static inline int devm_meson_rst_aux_register(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/devm_meson_rst_aux_register +292 drivers/reset/reset-meson.c

   224	
   225	static struct platform_driver meson_reset_pltf_driver = {
   226		.probe	= meson_reset_pltf_probe,
   227		.driver = {
   228			.name		= "meson_reset",
   229			.of_match_table	= meson_reset_dt_ids,
   230		},
   231	};
 > 232	module_platform_driver(meson_reset_pltf_driver);
   233	
   234	static const struct meson_reset_param meson_g12a_audio_param = {
   235		.reset_ops	= &meson_reset_toggle_ops,
   236		.reset_num	= 26,
   237		.level_offset	= 0x24,
   238	};
   239	
   240	static const struct meson_reset_param meson_sm1_audio_param = {
   241		.reset_ops	= &meson_reset_toggle_ops,
   242		.reset_num	= 39,
   243		.level_offset	= 0x28,
   244	};
   245	
   246	static const struct auxiliary_device_id meson_reset_aux_ids[] = {
   247		{
   248			.name = "axg-audio-clkc.rst-g12a",
   249			.driver_data = (kernel_ulong_t)&meson_g12a_audio_param,
   250		}, {
   251			.name = "axg-audio-clkc.rst-sm1",
   252			.driver_data = (kernel_ulong_t)&meson_sm1_audio_param,
   253		},
   254	};
   255	MODULE_DEVICE_TABLE(auxiliary, meson_reset_aux_ids);
   256	
   257	static int meson_reset_aux_probe(struct auxiliary_device *adev,
   258					 const struct auxiliary_device_id *id)
   259	{
   260		const struct meson_reset_param *param =
   261			(const struct meson_reset_param *)(id->driver_data);
   262		struct meson_reset_adev *raux =
   263			to_meson_reset_adev(adev);
   264	
   265		return meson_reset_probe(&adev->dev, raux->map, param);
   266	}
   267	
   268	static struct auxiliary_driver meson_reset_aux_driver = {
   269		.probe		= meson_reset_aux_probe,
   270		.id_table	= meson_reset_aux_ids,
   271	};
   272	module_auxiliary_driver(meson_reset_aux_driver);
   273	
   274	static void meson_rst_aux_release(struct device *dev)
   275	{
   276		struct auxiliary_device *adev = to_auxiliary_dev(dev);
   277		struct meson_reset_adev *raux =
   278			to_meson_reset_adev(adev);
   279	
   280		ida_free(&meson_rst_aux_ida, adev->id);
   281		kfree(raux);
   282	}
   283	
   284	static void meson_rst_aux_unregister_adev(void *_adev)
   285	{
   286		struct auxiliary_device *adev = _adev;
   287	
   288		auxiliary_device_delete(adev);
   289		auxiliary_device_uninit(adev);
   290	}
   291	
 > 292	int devm_meson_rst_aux_register(struct device *dev,
   293					struct regmap *map,
   294					const char *adev_name)
   295	{
   296		struct meson_reset_adev *raux;
   297		struct auxiliary_device *adev;
   298		int ret;
   299	
   300		raux = kzalloc(sizeof(*raux), GFP_KERNEL);
   301		if (!raux)
   302			return -ENOMEM;
   303	
   304		ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
   305		if (ret < 0)
   306			goto raux_free;
   307	
   308		raux->map = map;
   309	
   310		adev = &raux->adev;
   311		adev->id = ret;
   312		adev->name = adev_name;
   313		adev->dev.parent = dev;
   314		adev->dev.release = meson_rst_aux_release;
   315		device_set_of_node_from_dev(&adev->dev, dev);
   316	
   317		ret = auxiliary_device_init(adev);
   318		if (ret)
   319			goto ida_free;
   320	
   321		ret = __auxiliary_device_add(adev, dev->driver->name);
   322		if (ret) {
   323			auxiliary_device_uninit(adev);
   324			return ret;
   325		}
   326	
   327		return devm_add_action_or_reset(dev, meson_rst_aux_unregister_adev,
   328						adev);
   329	
   330	ida_free:
   331		ida_free(&meson_rst_aux_ida, adev->id);
   332	raux_free:
   333		kfree(raux);
   334		return ret;
   335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

