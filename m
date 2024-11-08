Return-Path: <linux-kernel+bounces-401580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309699C1C80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCCB239A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FF1E3DEC;
	Fri,  8 Nov 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l18ylfOQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DC7462
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067027; cv=none; b=I97nkXo+DRd80OD9gR++HaZzjduSgttojtVXVGANmJHzFwgZcJrcT2dDLVep3lKolA48OG5W7ScWp0Dq4cAPOfSpOY5SohAhwIJzwxLnS0MG+F9CBPU5iafEATQqfGboU7Y8h0l8odTmmXfG4GFp5cMWmjDKElQ+krLTeFeIq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067027; c=relaxed/simple;
	bh=EveuqbByIvqeTP/6ObYua5o0CjnfvPp/1xNR6BVpaRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/WlAWxeDUMKMST78BX52odrAbeQvSujlHXFb7xvidDjHQJMwdYriv7jzaNoP3JKXC2C0Qvm0NibnW7FZfTWc2OSNfMh4wnfWlA2kG0gZX0lhnZaZ/5VO3WIF4ahY1K7WPV9vXNSTQ+aoHss72U2HgPIpvTFwCFiTFhjvTTyn9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l18ylfOQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067026; x=1762603026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EveuqbByIvqeTP/6ObYua5o0CjnfvPp/1xNR6BVpaRo=;
  b=l18ylfOQULh5dugGVyRHQcmxcJo1qU6h4V6tvLSTy4eK0EkZ3xHAIUpm
   U7+ap1jsuNrEOiA42bQ1Xj/z+6MKOjoeAmcL9WmOZ+CyIqnLhPa6LPnA9
   cmpcMlDPfrDkJdrppbiFZWHtdU5VA/nhX+qTAxeumBa5hiisnscqRcvHk
   JxTzVOnKSiENVYYTlQrVdTZG0R7oW71fdv7sXWIllkdmc9U3QyQ/01Wx/
   Q7tCYiKR9ovBfn4C19jwHNTG8kxmIXsqQITWne6fGLOgIBFRMdO+fcl+5
   DjXptCdJuwd7B6jWwr++4wgf8FXtQvAwcmm87PvaVFaTcoTPvNAmxkNb5
   w==;
X-CSE-ConnectionGUID: I3dKgH8lRrWH7fYerawMGg==
X-CSE-MsgGUID: /JNaBAVWSLCBn+svP78OOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30802188"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30802188"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 03:57:06 -0800
X-CSE-ConnectionGUID: /EEMz8mmTO++jIhQBgkzKQ==
X-CSE-MsgGUID: 7rX4ZepGT3G09oCq+RqpOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85756919"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Nov 2024 03:57:02 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9Nbn-000rNy-0H;
	Fri, 08 Nov 2024 11:56:59 +0000
Date: Fri, 8 Nov 2024 19:56:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v7 2/7] drm/client: Always select DRM_CLIENT_LIB
Message-ID: <202411081923.vkZSFxL2-lkp@intel.com>
References: <20241108082025.1004653-3-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108082025.1004653-3-jfalempe@redhat.com>

Hi Jocelyn,

kernel test robot noticed the following build errors:

[auto build test ERROR on baf4afc5831438b35de4b0e951b9cd58435a6d99]

url:    https://github.com/intel-lab-lkp/linux/commits/Jocelyn-Falempe/drm-panic-Move-drawing-functions-to-drm_draw/20241108-162222
base:   baf4afc5831438b35de4b0e951b9cd58435a6d99
patch link:    https://lore.kernel.org/r/20241108082025.1004653-3-jfalempe%40redhat.com
patch subject: [PATCH v7 2/7] drm/client: Always select DRM_CLIENT_LIB
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241108/202411081923.vkZSFxL2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081923.vkZSFxL2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081923.vkZSFxL2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_client_setup.c:25:6: error: redefinition of 'drm_client_setup'
      25 | void drm_client_setup(struct drm_device *dev, const struct drm_format_info *format)
         |      ^~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_client_setup.c:3:
   include/drm/drm_client_setup.h:16:20: note: previous definition of 'drm_client_setup' with type 'void(struct drm_device *, const struct drm_format_info *)'
      16 | static inline void drm_client_setup(struct drm_device *dev,
         |                    ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_client_setup.c:43:6: error: redefinition of 'drm_client_setup_with_fourcc'
      43 | void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_client_setup.c:3:
   include/drm/drm_client_setup.h:19:20: note: previous definition of 'drm_client_setup_with_fourcc' with type 'void(struct drm_device *, u32)' {aka 'void(struct drm_device *, unsigned int)'}
      19 | static inline void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_client_setup.c:60:6: error: redefinition of 'drm_client_setup_with_color_mode'
      60 | void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_client_setup.c:3:
   include/drm/drm_client_setup.h:21:20: note: previous definition of 'drm_client_setup_with_color_mode' with type 'void(struct drm_device *, unsigned int)'
      21 | static inline void drm_client_setup_with_color_mode(struct drm_device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_client_setup +25 drivers/gpu/drm/drm_client_setup.c

d07fdf9225922d Thomas Zimmermann 2024-09-24   8  
d07fdf9225922d Thomas Zimmermann 2024-09-24   9  /**
d07fdf9225922d Thomas Zimmermann 2024-09-24  10   * drm_client_setup() - Setup in-kernel DRM clients
d07fdf9225922d Thomas Zimmermann 2024-09-24  11   * @dev: DRM device
d07fdf9225922d Thomas Zimmermann 2024-09-24  12   * @format: Preferred pixel format for the device. Use NULL, unless
d07fdf9225922d Thomas Zimmermann 2024-09-24  13   *          there is clearly a driver-preferred format.
d07fdf9225922d Thomas Zimmermann 2024-09-24  14   *
d07fdf9225922d Thomas Zimmermann 2024-09-24  15   * This function sets up the in-kernel DRM clients. Restore, hotplug
d07fdf9225922d Thomas Zimmermann 2024-09-24  16   * events and teardown are all taken care of.
d07fdf9225922d Thomas Zimmermann 2024-09-24  17   *
d07fdf9225922d Thomas Zimmermann 2024-09-24  18   * Drivers should call drm_client_setup() after registering the new
d07fdf9225922d Thomas Zimmermann 2024-09-24  19   * DRM device with drm_dev_register(). This function is safe to call
d07fdf9225922d Thomas Zimmermann 2024-09-24  20   * even when there are no connectors present. Setup will be retried
d07fdf9225922d Thomas Zimmermann 2024-09-24  21   * on the next hotplug event.
d07fdf9225922d Thomas Zimmermann 2024-09-24  22   *
d07fdf9225922d Thomas Zimmermann 2024-09-24  23   * The clients are destroyed by drm_dev_unregister().
d07fdf9225922d Thomas Zimmermann 2024-09-24  24   */
d07fdf9225922d Thomas Zimmermann 2024-09-24 @25  void drm_client_setup(struct drm_device *dev, const struct drm_format_info *format)
d07fdf9225922d Thomas Zimmermann 2024-09-24  26  {
d07fdf9225922d Thomas Zimmermann 2024-09-24  27  	int ret;
d07fdf9225922d Thomas Zimmermann 2024-09-24  28  
d07fdf9225922d Thomas Zimmermann 2024-09-24  29  	ret = drm_fbdev_client_setup(dev, format);
d07fdf9225922d Thomas Zimmermann 2024-09-24  30  	if (ret)
d07fdf9225922d Thomas Zimmermann 2024-09-24  31  		drm_warn(dev, "Failed to set up DRM client; error %d\n", ret);
d07fdf9225922d Thomas Zimmermann 2024-09-24  32  }
d07fdf9225922d Thomas Zimmermann 2024-09-24  33  EXPORT_SYMBOL(drm_client_setup);
d07fdf9225922d Thomas Zimmermann 2024-09-24  34  
d07fdf9225922d Thomas Zimmermann 2024-09-24  35  /**
d07fdf9225922d Thomas Zimmermann 2024-09-24  36   * drm_client_setup_with_fourcc() - Setup in-kernel DRM clients for color mode
d07fdf9225922d Thomas Zimmermann 2024-09-24  37   * @dev: DRM device
d07fdf9225922d Thomas Zimmermann 2024-09-24  38   * @fourcc: Preferred pixel format as 4CC code for the device
d07fdf9225922d Thomas Zimmermann 2024-09-24  39   *
d07fdf9225922d Thomas Zimmermann 2024-09-24  40   * This function sets up the in-kernel DRM clients. It is equivalent
d07fdf9225922d Thomas Zimmermann 2024-09-24  41   * to drm_client_setup(), but expects a 4CC code as second argument.
d07fdf9225922d Thomas Zimmermann 2024-09-24  42   */
d07fdf9225922d Thomas Zimmermann 2024-09-24 @43  void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
d07fdf9225922d Thomas Zimmermann 2024-09-24  44  {
d07fdf9225922d Thomas Zimmermann 2024-09-24  45  	drm_client_setup(dev, drm_format_info(fourcc));
d07fdf9225922d Thomas Zimmermann 2024-09-24  46  }
d07fdf9225922d Thomas Zimmermann 2024-09-24  47  EXPORT_SYMBOL(drm_client_setup_with_fourcc);
d07fdf9225922d Thomas Zimmermann 2024-09-24  48  
d07fdf9225922d Thomas Zimmermann 2024-09-24  49  /**
d07fdf9225922d Thomas Zimmermann 2024-09-24  50   * drm_client_setup_with_color_mode() - Setup in-kernel DRM clients for color mode
d07fdf9225922d Thomas Zimmermann 2024-09-24  51   * @dev: DRM device
d07fdf9225922d Thomas Zimmermann 2024-09-24  52   * @color_mode: Preferred color mode for the device
d07fdf9225922d Thomas Zimmermann 2024-09-24  53   *
d07fdf9225922d Thomas Zimmermann 2024-09-24  54   * This function sets up the in-kernel DRM clients. It is equivalent
d07fdf9225922d Thomas Zimmermann 2024-09-24  55   * to drm_client_setup(), but expects a color mode as second argument.
d07fdf9225922d Thomas Zimmermann 2024-09-24  56   *
d07fdf9225922d Thomas Zimmermann 2024-09-24  57   * Do not use this function in new drivers. Prefer drm_client_setup() with a
d07fdf9225922d Thomas Zimmermann 2024-09-24  58   * format of NULL.
d07fdf9225922d Thomas Zimmermann 2024-09-24  59   */
d07fdf9225922d Thomas Zimmermann 2024-09-24 @60  void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode)
d07fdf9225922d Thomas Zimmermann 2024-09-24  61  {
d07fdf9225922d Thomas Zimmermann 2024-09-24  62  	u32 fourcc = drm_driver_color_mode_format(dev, color_mode);
d07fdf9225922d Thomas Zimmermann 2024-09-24  63  
d07fdf9225922d Thomas Zimmermann 2024-09-24  64  	drm_client_setup_with_fourcc(dev, fourcc);
d07fdf9225922d Thomas Zimmermann 2024-09-24  65  }
d07fdf9225922d Thomas Zimmermann 2024-09-24  66  EXPORT_SYMBOL(drm_client_setup_with_color_mode);
dadd28d4142f9a Thomas Zimmermann 2024-10-14  67  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

