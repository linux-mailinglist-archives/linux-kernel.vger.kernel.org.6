Return-Path: <linux-kernel+bounces-525111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F807A3EAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F8519C5DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E31D63C7;
	Fri, 21 Feb 2025 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrK52dJL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95313C81B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106399; cv=none; b=jTkV3lOZhkjLQZ+dDoOyche04HGkQ3whRQWUg6Hqdu4Y0Vx2nowHQyyspQR2GEtLtrctHgU8BoreiIXSkrrJt8JFY5/bgb3JjyzeAiaOZSouDUiA+pD/69cm8tLMKN2VQ9Td1qivDcMpbfQqdoTKlHRwtaaN+kXt+V0N5GuxcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106399; c=relaxed/simple;
	bh=DO5+Tn4eszjaLI7lcqLuh0OXqTQsizaN0M6Ea3DROdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3tYiWkia/CcIsRkneh9Xoh0pYU2t3chpdiTob6Dg2BxuoZZmB7I4bzrA33VDa6d24KhupQkJjKVOoSDpvkjH4J81srhEc2scBeTfEst5VUmZo8wFMXoPmUHscQxT1/CmlDxvoWfcOZfG4I6MUERBQ8hrjBc/bcurjZsMsgvA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrK52dJL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740106396; x=1771642396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DO5+Tn4eszjaLI7lcqLuh0OXqTQsizaN0M6Ea3DROdU=;
  b=GrK52dJL9YfEbtpSuXeTV3zUqp9Ko/zrLFZUJ2K6qvSjkaBDsjkM3/R7
   msfwZXf0MeRu1wUeTjDan+d0BBcITb2JTJrhpzNwcg7iiAIFIZ1FnGqGL
   qq1P7rayHYk+7w96GpypBH5+pft6EjisGYZ654ujjumaxVdvXIqUuZvg/
   T8XTVDVdR/xkVI24a73CWMYkLug60QGNC6d/JsE/+AiOJdPG2w8Fubu76
   6WAX79/OhMtv9w2jPp5iuP/OeFD9AIM7AGJG77Ncd1qGeoFnF3KZLhNCA
   RLY9CNWJrgLAw4UfNK/ho0sBmbsKBGqIw7/fUj+cInjizA5WVehd3UQ9E
   g==;
X-CSE-ConnectionGUID: b3+kAcOXSAmd4H5HEYhi0w==
X-CSE-MsgGUID: QswmQYmwRAORTU/vTjlxXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58320398"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="58320398"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 18:53:16 -0800
X-CSE-ConnectionGUID: /TQ+oBo7QQG/+OhUF6UDYw==
X-CSE-MsgGUID: v6lKwnhaRZ6LmN4v/L3DWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="115434872"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 20 Feb 2025 18:53:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlJA7-00052R-2l;
	Fri, 21 Feb 2025 02:53:11 +0000
Date: Fri, 21 Feb 2025 10:52:12 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1] io.h: drop unused headers
Message-ID: <202502211009.s6xoWtae-lkp@intel.com>
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
config: sparc-randconfig-001-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211009.s6xoWtae-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211009.s6xoWtae-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502211009.s6xoWtae-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_draw.c: In function 'drm_draw_color_from_xrgb8888':
>> drivers/gpu/drm/drm_draw.c:130:17: error: implicit declaration of function 'WARN_ONCE' [-Wimplicit-function-declaration]
     130 |                 WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
         |                 ^~~~~~~~~


vim +/WARN_ONCE +130 drivers/gpu/drm/drm_draw.c

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
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  134  EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
31fa2c1ca0b239 Jocelyn Falempe 2024-12-04  135  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

