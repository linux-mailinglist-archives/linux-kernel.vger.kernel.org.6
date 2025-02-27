Return-Path: <linux-kernel+bounces-537506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776EA48CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2506C16B3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7708276D0E;
	Thu, 27 Feb 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZkpXWTA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF99276D02
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698646; cv=none; b=W94s7SsV3xwjB1pSNdTW2I11QjleZKKkPNraiJ9zo6TgY6qgjnYcPJWRlJEuQ/goEJsYmXqKJUhddRAhvgThyahpYuwwIjb07XsQplhcL7uNb5TfKLNbGRPrmmPhXYdxhpaHak0uM3HWSmFYlrSla6VWwZvqYgh6s0dhRDg+I6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698646; c=relaxed/simple;
	bh=9qqsIcFHcWeelKsEhLOKTawkuw3WGIYSVSE+zevFptA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIx/wlO/DmmKUhqMkfg6zeZ7rGSwWiY7f5qXfDvtHuEP5zk/sOG7U1eul1bRb3KhHhVKki6UozqyeB27045jHtL242uO6JasRn7XEOqyhQwZ8gh85tbCIdA0JFv7+Sl99tI80MO+Lfjjz7zNcxn+52RelCxHVy9jaV2uUikB8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZkpXWTA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740698644; x=1772234644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qqsIcFHcWeelKsEhLOKTawkuw3WGIYSVSE+zevFptA=;
  b=VZkpXWTAKZILQ+4c22IHcxL5tttvuzd5A9FiZ10KGgjvKRLZagMDm7lW
   kUtaHnWELvj+rAss4tJujmuWcQqupMCn+DIq0yXDfMgKzsWC76Y486Z2s
   6y9kTizp34aIdOblsc3TfhI2417Ygn7BNiOxmWj94wIO0SirSIWmzUTqN
   BSRvFwQgzkZe2MdlUdIfaHYxDrRiCvaZIqTgf7FBa7qLi502YMvLdUbxs
   KTRXgK77TlrtSMUlviZLUfPVOdx1O2nYFmmCjRM6tZ8J50I5sWVmpKkP8
   5p2jveRQ+C8u1zRllK7mQtgcG3jthcqiWPw4+tw3i49JRUHO1TFOm689R
   g==;
X-CSE-ConnectionGUID: A3dvNpdAQpaZZjhHvWDz7A==
X-CSE-MsgGUID: 8OJ/lgLoT+GyhJKv2EtIhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45264202"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45264202"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:24:01 -0800
X-CSE-ConnectionGUID: DXt2oDOUQYahVXJS996/xw==
X-CSE-MsgGUID: 3811Ks0VT4Wl/K5AktfhlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154353473"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 27 Feb 2025 15:23:58 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnnEM-000EAQ-37;
	Thu, 27 Feb 2025 23:23:51 +0000
Date: Fri, 28 Feb 2025 07:22:47 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Garg <gargaditya08@live.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <202502280740.4ffoKiLx-lkp@intel.com>
References: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>

Hi Aditya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/drm-format-helper-Add-conversion-from-XRGB8888-to-BGR888/20250224-214352
base:   linus/master
patch link:    https://lore.kernel.org/r/844C1D39-4891-4DC2-8458-F46FA1B59FA0%40live.com
patch subject: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86 Macs
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280740.4ffoKiLx-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280740.4ffoKiLx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280740.4ffoKiLx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/tiny/appletbdrm.c:13:
   drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_send_request':
>> include/drm/drm_print.h:589:54: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     589 |         dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt, ##__VA_ARGS__)
         |                                                      ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/drm/drm_print.h:589:9: note: in expansion of macro 'dev_err'
     589 |         dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:602:9: note: in expansion of macro '__drm_printk'
     602 |         __drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/tiny/appletbdrm.c:173:17: note: in expansion of macro 'drm_err'
     173 |                 drm_err(drm, "Actual size (%d) doesn't match expected size (%lu)\n",
         |                 ^~~~~~~
   drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_read_response':
>> include/drm/drm_print.h:589:54: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     589 |         dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt, ##__VA_ARGS__)
         |                                                      ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/drm/drm_print.h:589:9: note: in expansion of macro 'dev_err'
     589 |         dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:602:9: note: in expansion of macro '__drm_printk'
     602 |         __drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/tiny/appletbdrm.c:214:17: note: in expansion of macro 'drm_err'
     214 |                 drm_err(drm, "Actual size (%d) doesn't match expected size (%lu)\n",
         |                 ^~~~~~~
   drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_primary_plane_duplicate_state':
   drivers/gpu/drm/tiny/appletbdrm.c:524:40: warning: variable 'old_appletbdrm_state' set but not used [-Wunused-but-set-variable]
     524 |         struct appletbdrm_plane_state *old_appletbdrm_state;
         |                                        ^~~~~~~~~~~~~~~~~~~~


vim +589 include/drm/drm_print.h

e820f52577b14c6 Jim Cromie            2022-09-11  549  
02c9656b2f0d699 Haneen Mohammed       2017-10-17  550  /**
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  551   * DRM_DEV_DEBUG() - Debug output for generic drm code
02c9656b2f0d699 Haneen Mohammed       2017-10-17  552   *
306589856399e18 Douglas Anderson      2021-09-21  553   * NOTE: this is deprecated in favor of drm_dbg_core().
306589856399e18 Douglas Anderson      2021-09-21  554   *
091756bbb1a9613 Haneen Mohammed       2017-10-17  555   * @dev: device pointer
091756bbb1a9613 Haneen Mohammed       2017-10-17  556   * @fmt: printf() like format string.
02c9656b2f0d699 Haneen Mohammed       2017-10-17  557   */
db87086492581c8 Joe Perches           2018-03-16  558  #define DRM_DEV_DEBUG(dev, fmt, ...)					\
db87086492581c8 Joe Perches           2018-03-16  559  	drm_dev_dbg(dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  560  /**
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  561   * DRM_DEV_DEBUG_DRIVER() - Debug output for vendor specific part of the driver
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  562   *
306589856399e18 Douglas Anderson      2021-09-21  563   * NOTE: this is deprecated in favor of drm_dbg() or dev_dbg().
306589856399e18 Douglas Anderson      2021-09-21  564   *
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  565   * @dev: device pointer
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  566   * @fmt: printf() like format string.
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  567   */
db87086492581c8 Joe Perches           2018-03-16  568  #define DRM_DEV_DEBUG_DRIVER(dev, fmt, ...)				\
db87086492581c8 Joe Perches           2018-03-16  569  	drm_dev_dbg(dev, DRM_UT_DRIVER,	fmt, ##__VA_ARGS__)
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  570  /**
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  571   * DRM_DEV_DEBUG_KMS() - Debug output for modesetting code
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  572   *
306589856399e18 Douglas Anderson      2021-09-21  573   * NOTE: this is deprecated in favor of drm_dbg_kms().
306589856399e18 Douglas Anderson      2021-09-21  574   *
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  575   * @dev: device pointer
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  576   * @fmt: printf() like format string.
b52817e9de06a3a Mauro Carvalho Chehab 2020-10-27  577   */
db87086492581c8 Joe Perches           2018-03-16  578  #define DRM_DEV_DEBUG_KMS(dev, fmt, ...)				\
db87086492581c8 Joe Perches           2018-03-16  579  	drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
a18b21929453af7 Lyude Paul            2018-07-16  580  
fb6c7ab8718eb25 Jani Nikula           2019-12-10  581  /*
fb6c7ab8718eb25 Jani Nikula           2019-12-10  582   * struct drm_device based logging
fb6c7ab8718eb25 Jani Nikula           2019-12-10  583   *
fb6c7ab8718eb25 Jani Nikula           2019-12-10  584   * Prefer drm_device based logging over device or prink based logging.
fb6c7ab8718eb25 Jani Nikula           2019-12-10  585   */
fb6c7ab8718eb25 Jani Nikula           2019-12-10  586  
fb6c7ab8718eb25 Jani Nikula           2019-12-10  587  /* Helper for struct drm_device based logging. */
fb6c7ab8718eb25 Jani Nikula           2019-12-10  588  #define __drm_printk(drm, level, type, fmt, ...)			\
e04d24c4e8062b5 Luben Tuikov          2023-11-16 @589  	dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt, ##__VA_ARGS__)
fb6c7ab8718eb25 Jani Nikula           2019-12-10  590  
fb6c7ab8718eb25 Jani Nikula           2019-12-10  591  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

