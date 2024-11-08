Return-Path: <linux-kernel+bounces-401661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0B9C1DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80481C22F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351B1EABA9;
	Fri,  8 Nov 2024 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWpSmnWn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3E1E6DE1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071350; cv=none; b=fiMI7XLROa2QL8bhDQ3pEFuTPZqboQNY3YVUAuGj2kFlQERPElfvCI3C8XtQOICtSaX29v5k8Xd7kMgg4PtvQ3NyQMl16y+48EUwShWmQmESYZshuYjEH7AlgZ2ff9GGg3CWMy0ktD0oaZSTXWlecXU9RU1VAuLVsMBQIH8qJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071350; c=relaxed/simple;
	bh=61vvWGL0UpYowW9YO69YIiDWIsi7Qdruyw3F3U/nxTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuZAAwPawtbUDep+hWocrfxGN8aiVuLukbRHdN40nTL39aXSHY+R1c4FA2i0ww1mHIFAtziuOqlYSN026Ia7+y8Xd+92sL5TimJjNE9MtdY0B+vMQTwFoB92bLbApMZwGHJpczEbiEq/NQ6UsN6uIhI+EQIGG2e7K5lW/EksS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWpSmnWn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731071350; x=1762607350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=61vvWGL0UpYowW9YO69YIiDWIsi7Qdruyw3F3U/nxTo=;
  b=jWpSmnWnVBvq5ROK2cuv3IyUMMCXR97VwLTkTOgWroJNBrQJfwFMwW5W
   sqro+tZ9+YwerCsV/GQikJ+CsX0H/LP2hmqqsdF5rx/erzKx3YEEokXmp
   mwIytDLCsXX01T6RYZ1d6obKCNPqcJzuw6WFMNxufNcu5X/Ncq+USjJRu
   GqvSujnuWWsKxtvqMqi3sadw/juKkyXzlBB1KqA6i+6iK2o426OVEihew
   VJjA6j6dXwPjsSUHBNBIV3+JeVWP8dRKHoEE7vV5nmV8Gs2Js8m6g9ahk
   g2uuBtzxhTKi8Q+ceer1FrsFiC3F8wfTY/KD7Kpa0U/WvLi92VWiQogQ6
   g==;
X-CSE-ConnectionGUID: 5WT3fEvjQHGUj/P6eRJBzg==
X-CSE-MsgGUID: P2fnW0HVTlevBJCwcPkvng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53514379"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53514379"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 05:09:09 -0800
X-CSE-ConnectionGUID: hcTWoXcFRGmvNlip2Riz+Q==
X-CSE-MsgGUID: K4ZycnqFTMKtahPn8K5cyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85652998"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Nov 2024 05:09:05 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9OjW-000rRa-2c;
	Fri, 08 Nov 2024 13:09:02 +0000
Date: Fri, 8 Nov 2024 21:08:30 +0800
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
Subject: Re: [PATCH v7 3/7] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <202411082034.Lnxy55Wm-lkp@intel.com>
References: <20241108082025.1004653-4-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108082025.1004653-4-jfalempe@redhat.com>

Hi Jocelyn,

kernel test robot noticed the following build errors:

[auto build test ERROR on baf4afc5831438b35de4b0e951b9cd58435a6d99]

url:    https://github.com/intel-lab-lkp/linux/commits/Jocelyn-Falempe/drm-panic-Move-drawing-functions-to-drm_draw/20241108-162222
base:   baf4afc5831438b35de4b0e951b9cd58435a6d99
patch link:    https://lore.kernel.org/r/20241108082025.1004653-4-jfalempe%40redhat.com
patch subject: [PATCH v7 3/7] drm/log: Introduce a new boot logger to draw the kmsg on the screen
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241108/202411082034.Lnxy55Wm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411082034.Lnxy55Wm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411082034.Lnxy55Wm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_client_setup.c:11:38: error: 'CONFIG_DRM_CLIENT_DEFAULT' undeclared here (not in a function); did you mean 'CONFIG_DRM_CLIENT_LIB'?
      11 | static char drm_client_default[16] = CONFIG_DRM_CLIENT_DEFAULT;
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      CONFIG_DRM_CLIENT_LIB
   In file included from include/linux/module.h:22,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/drm/drm_print.h:31,
                    from drivers/gpu/drm/drm_client_setup.c:7:
>> drivers/gpu/drm/drm_client_setup.c:15:18: error: expected ',' or ';' before 'CONFIG_DRM_CLIENT_DEFAULT'
      15 |                  CONFIG_DRM_CLIENT_DEFAULT "]");
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:26:61: note: in definition of macro '__MODULE_INFO'
      26 |                 = __MODULE_INFO_PREFIX __stringify(tag) "=" info
         |                                                             ^~~~
   drivers/gpu/drm/drm_client_setup.c:13:1: note: in expansion of macro 'MODULE_PARM_DESC'
      13 | MODULE_PARM_DESC(client,
         | ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_client_setup.c:33:6: error: redefinition of 'drm_client_setup'
      33 | void drm_client_setup(struct drm_device *dev, const struct drm_format_info *format)
         |      ^~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_client_setup.c:3:
   include/drm/drm_client_setup.h:16:20: note: previous definition of 'drm_client_setup' with type 'void(struct drm_device *, const struct drm_format_info *)'
      16 | static inline void drm_client_setup(struct drm_device *dev,
         |                    ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_client_setup.c:55:6: error: redefinition of 'drm_client_setup_with_fourcc'
      55 | void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_client_setup.c:3:
   include/drm/drm_client_setup.h:19:20: note: previous definition of 'drm_client_setup_with_fourcc' with type 'void(struct drm_device *, u32)' {aka 'void(struct drm_device *, unsigned int)'}
      19 | static inline void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_client_setup.c:72:6: error: redefinition of 'drm_client_setup_with_color_mode'
      72 | void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_client_setup.c:3:
   include/drm/drm_client_setup.h:21:20: note: previous definition of 'drm_client_setup_with_color_mode' with type 'void(struct drm_device *, unsigned int)'
      21 | static inline void drm_client_setup_with_color_mode(struct drm_device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +11 drivers/gpu/drm/drm_client_setup.c

    10	
  > 11	static char drm_client_default[16] = CONFIG_DRM_CLIENT_DEFAULT;
    12	module_param_string(client, drm_client_default, sizeof(drm_client_default), 0444);
    13	MODULE_PARM_DESC(client,
    14			 "Choose which drm client to start, default is"
  > 15			 CONFIG_DRM_CLIENT_DEFAULT "]");
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

