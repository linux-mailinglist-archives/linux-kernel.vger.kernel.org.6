Return-Path: <linux-kernel+bounces-525133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3914BA3EB3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA5519C5DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F81F427D;
	Fri, 21 Feb 2025 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKgFIzzA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC986347
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108174; cv=none; b=URi+HamyKlghTi4t4fjRCOfJgoNKFsV9BVT5r+Sq9X77BYdCrswDVXlfoXPHmGv7Yk1fkMh0/BQmbIAdbTbwSIxokO7WkqzPzOqqqsffGVKfWVyEPDlxQy3kx993dx3WCOcUkrkcEUOXXgxVBH59uXv+m3PAbWbZXX/O5Qhhi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108174; c=relaxed/simple;
	bh=eOaUX2jxhFsGUZlrmXt3butQF1UC0A1TChXKbzzXMiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VASizZiB0S8cgCekZBkzZCSkJBZ0zv/8v9D/LeQOEr+/LysfvGU6hjgPYRRj2ColeZDCC369aTSbsrHmpYcEIelSUYcQnmSAl5cnIUQfJYCzEGWajUDrSkb9NwNmFg9TFtckrA90k74tRBzy9fuxUgLrbsbH+YSaonUadAF12zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKgFIzzA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740108173; x=1771644173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eOaUX2jxhFsGUZlrmXt3butQF1UC0A1TChXKbzzXMiI=;
  b=PKgFIzzAJJhS+iP0K8A5gwffjHob+bdte1VTIjpWnQKLr9BqSeF98Wkx
   bFeiixevmJYIAx7YOvw219JO6xauf0JmcgrsSszPXyHT2KlnNk/8GUoud
   dHcsBO4YxXYgmi0Qa3leY/+CXrprYhqKUoU2pX/QApZiYORdIJtmHNB04
   rUkCNe32XXyaYbF+vHH9+UmR2mehXdksjno3Fjh7unNXpMx5p4zGjATU0
   z9hkNNVqlA/WDdUnaWPLrIpGjx43ucCKzXZd/Sn6isMh5bqskorKaaRQ/
   wesxrcyorgJ4nFYywm8eHR53Yay44j5EPSiEXjtdZu73CV6tz9N4elk5b
   A==;
X-CSE-ConnectionGUID: bBSW7BBiQ9+IlfubYNufFg==
X-CSE-MsgGUID: FTiVlCt8Ry2HTzOjfn9v2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51906641"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="51906641"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 19:22:52 -0800
X-CSE-ConnectionGUID: 1WQAM2cqSCKs3A+wj/OHmw==
X-CSE-MsgGUID: tRkP6OGUSPys2oYbJejRpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="119872698"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 20 Feb 2025 19:22:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlJcl-00053j-2s;
	Fri, 21 Feb 2025 03:22:47 +0000
Date: Fri, 21 Feb 2025 11:22:38 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1] io.h: drop unused headers
Message-ID: <202502211137.IRE8qrlR-lkp@intel.com>
References: <20250220173305.2752125-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220173305.2752125-1-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build errors:

[auto build test ERROR on b16e9f8547a328b19af59afc213ce323124d11e9]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/io-h-drop-unused-headers/20250221-013530
base:   b16e9f8547a328b19af59afc213ce323124d11e9
patch link:    https://lore.kernel.org/r/20250220173305.2752125-1-raag.jadav%40intel.com
patch subject: [PATCH v1] io.h: drop unused headers
config: nios2-randconfig-001-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211137.IRE8qrlR-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211137.IRE8qrlR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502211137.IRE8qrlR-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/drm_draw.c: In function 'drm_draw_color_from_xrgb8888':
   drivers/gpu/drm/drm_draw.c:130:17: error: implicit declaration of function 'WARN_ONCE' [-Wimplicit-function-declaration]
     130 |                 WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
         |                 ^~~~~~~~~
   drivers/gpu/drm/drm_draw.c: At top level:
>> drivers/gpu/drm/drm_draw.c:134:1: warning: data definition has no type or storage class
     134 | EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
         | ^~~~~~~~~~~~~
>> drivers/gpu/drm/drm_draw.c:134:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
>> drivers/gpu/drm/drm_draw.c:134:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/gpu/drm/drm_draw.c:151:1: warning: data definition has no type or storage class
     151 | EXPORT_SYMBOL(drm_draw_blit16);
         | ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_draw.c:151:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
   drivers/gpu/drm/drm_draw.c:151:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/gpu/drm/drm_draw.c:173:1: warning: data definition has no type or storage class
     173 | EXPORT_SYMBOL(drm_draw_blit24);
         | ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_draw.c:173:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
   drivers/gpu/drm/drm_draw.c:173:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/gpu/drm/drm_draw.c:187:1: warning: data definition has no type or storage class
     187 | EXPORT_SYMBOL(drm_draw_blit32);
         | ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_draw.c:187:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
   drivers/gpu/drm/drm_draw.c:187:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/gpu/drm/drm_draw.c:202:1: warning: data definition has no type or storage class
     202 | EXPORT_SYMBOL(drm_draw_fill16);
         | ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_draw.c:202:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
   drivers/gpu/drm/drm_draw.c:202:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/gpu/drm/drm_draw.c:221:1: warning: data definition has no type or storage class
     221 | EXPORT_SYMBOL(drm_draw_fill24);
         | ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_draw.c:221:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
   drivers/gpu/drm/drm_draw.c:221:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/gpu/drm/drm_draw.c:233:1: warning: data definition has no type or storage class
     233 | EXPORT_SYMBOL(drm_draw_fill32);
         | ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_draw.c:233:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
   drivers/gpu/drm/drm_draw.c:233:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]


vim +134 drivers/gpu/drm/drm_draw.c

31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   93  
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   94  /**
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   95   * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   96   * @color: input color, in xrgb8888 format
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   97   * @format: output format
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   98   *
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04   99   * Returns:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  100   * Color in the format specified, casted to u32.
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  101   * Or 0 if the format is not supported.
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  102   */
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  103  u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  104  {
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  105  	switch (format) {
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  106  	case DRM_FORMAT_RGB565:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  107  		return convert_xrgb8888_to_rgb565(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  108  	case DRM_FORMAT_RGBA5551:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  109  		return convert_xrgb8888_to_rgba5551(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  110  	case DRM_FORMAT_XRGB1555:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  111  		return convert_xrgb8888_to_xrgb1555(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  112  	case DRM_FORMAT_ARGB1555:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  113  		return convert_xrgb8888_to_argb1555(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  114  	case DRM_FORMAT_RGB888:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  115  	case DRM_FORMAT_XRGB8888:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  116  		return color;
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  117  	case DRM_FORMAT_ARGB8888:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  118  		return convert_xrgb8888_to_argb8888(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  119  	case DRM_FORMAT_XBGR8888:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  120  		return convert_xrgb8888_to_xbgr8888(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  121  	case DRM_FORMAT_ABGR8888:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  122  		return convert_xrgb8888_to_abgr8888(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  123  	case DRM_FORMAT_XRGB2101010:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  124  		return convert_xrgb8888_to_xrgb2101010(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  125  	case DRM_FORMAT_ARGB2101010:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  126  		return convert_xrgb8888_to_argb2101010(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  127  	case DRM_FORMAT_ABGR2101010:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  128  		return convert_xrgb8888_to_abgr2101010(color);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  129  	default:
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04 @130  		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  131  		return 0;
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  132  	}
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  133  }
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04 @134  EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  135  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

