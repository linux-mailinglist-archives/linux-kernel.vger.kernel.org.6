Return-Path: <linux-kernel+bounces-369861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F939A23BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A19B24EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D611DDC21;
	Thu, 17 Oct 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbUQ5E6D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9C1DDC07
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171354; cv=none; b=hOLp3+x5qF7EKWButrRf71RgUzFScuyfKfxoRTtr7RO7NNB5Mx32oDta0MbdUq65kptztluhvxdF779EXFGQGhMwtke2od8DCBmVaiLxk1RZ/GpLNtbIJEao1+KxpCoV/9ZlVYZmQ8K+1mUcisE42bTkAIc05wFQHD6q2BA53D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171354; c=relaxed/simple;
	bh=8xd1OpG5nxp6NH/FQhHvMCZMfE+1UsN1G1aunJtc8yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qri31OdtstObay6GotHrguEiJfDyDFahhJYJwSKzdpt0LDA3GFwlWFB3pxF/yp89ICOlFBoL0mVfNCW4bSeX8VRdpCVnP0Qb65IixbdtLu2ZIq5pHNLn/7WQjavMgymRJct2ddRN6F6JLOmmqxil68mHrmW0stVqGHd0RWAg9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbUQ5E6D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729171350; x=1760707350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8xd1OpG5nxp6NH/FQhHvMCZMfE+1UsN1G1aunJtc8yo=;
  b=TbUQ5E6D0ToU+5/iOBfa86cU4+o8EA35uQjI3TFp9yj5NdQ0DiPbRgR6
   nkb4zlHpHjzMA//iu6Fr7Zzn62FBZuhpK0FbYdzCwtcLkfH70mDYv94F1
   kYJe/6Cb7KTIyi5gA6EM+5NoNdEvbB/+5hkQ70oWGZJlv59KUWhNMQy9D
   JZ0aMHyLwlTv2jWWNYX4/46gitAYu9yOtF77WrQXDV6qmZjkAdeijppEL
   o8wAnGNvXPp7uoAjN0bNdeGcOVwnyINBWaMw601mkI2A3Qhb6cji7ukkH
   PJjYBITm+IZYMIq9E227IUSyXNTaUC3edSsk1aee3GYbyXcJKyfCBWGH8
   g==;
X-CSE-ConnectionGUID: HMG9aABYSqGk/RwYDL3zQQ==
X-CSE-MsgGUID: 28G4b5yZSYyEN0XdFF4fxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="54069274"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="54069274"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:22:30 -0700
X-CSE-ConnectionGUID: Et5xQTGqQ3+53gYqyZWmqg==
X-CSE-MsgGUID: 6bjV5x8lQtKSTDDmZDfCIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78689368"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Oct 2024 06:22:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1QSM-000MOH-2D;
	Thu, 17 Oct 2024 13:22:22 +0000
Date: Thu, 17 Oct 2024 21:22:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, christian.koenig@amd.com, ray.huang@amd.com,
	dmitry.baryshkov@linaro.org, dave.stevenson@raspberrypi.com,
	mcanal@igalia.com, quic_jjohnson@quicinc.com,
	karolina.stolarek@intel.com, Arunpravin.PaneerSelvam@amd.com,
	thomas.hellstrom@linux.intel.com, asomalap@amd.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ruanjinjie@huawei.com
Subject: Re: [PATCH 1/3] drm/connector: hdmi: Fix memory leak in
 drm_display_mode_from_cea_vic()
Message-ID: <202410172046.2W97YGlm-lkp@intel.com>
References: <20241014071632.989108-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014071632.989108-2-ruanjinjie@huawei.com>

Hi Jinjie,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.12-rc3 next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/drm-connector-hdmi-Fix-memory-leak-in-drm_display_mode_from_cea_vic/20241014-152022
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241014071632.989108-2-ruanjinjie%40huawei.com
patch subject: [PATCH 1/3] drm/connector: hdmi: Fix memory leak in drm_display_mode_from_cea_vic()
config: arm-randconfig-002-20241017 (https://download.01.org/0day-ci/archive/20241017/202410172046.2W97YGlm-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410172046.2W97YGlm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410172046.2W97YGlm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/tests/drm_connector_test.c:1008:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1031:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1051:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1074:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1094:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1117:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1142:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1182:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1209:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1233:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1257:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   drivers/gpu/drm/tests/drm_connector_test.c:1281:24: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           drm_mode_destroy(drm, mode);
                                 ^~~~
   include/drm/drm_modes.h:456:72: note: passing argument to parameter 'mode' here
   void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
                                                                          ^
   12 errors generated.


vim +1008 drivers/gpu/drm/tests/drm_connector_test.c

   987	
   988	/*
   989	 * Test that for a given mode, with 8bpc and an RGB output the TMDS
   990	 * character rate is equal to the mode pixel clock.
   991	 */
   992	static void drm_test_drm_hdmi_compute_mode_clock_rgb(struct kunit *test)
   993	{
   994		struct drm_connector_init_priv *priv = test->priv;
   995		const struct drm_display_mode *mode;
   996		unsigned long long rate;
   997		struct drm_device *drm = &priv->drm;
   998	
   999		mode = drm_display_mode_from_cea_vic(drm, 16);
  1000		KUNIT_ASSERT_NOT_NULL(test, mode);
  1001	
  1002		KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
  1003	
  1004		rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
  1005		KUNIT_ASSERT_GT(test, rate, 0);
  1006		KUNIT_EXPECT_EQ(test, mode->clock * 1000ULL, rate);
  1007	
> 1008		drm_mode_destroy(drm, mode);
  1009	}
  1010	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

