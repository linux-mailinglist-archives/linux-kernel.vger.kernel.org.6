Return-Path: <linux-kernel+bounces-309777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD847967052
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B149284010
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DAC17084F;
	Sat, 31 Aug 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9H7H2FS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189713A885
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092337; cv=none; b=GJyvOO7oimh1pGaxubGCf4TsCrX17/rebMjkd2ev7/FHuprpnOn7G610OOda+3l7yRHUf5UJ9uXSkayWbXYz/NM+drI4CPsOef+NiuiK0vlGieJ1+XGYrMPN14xEbF2UscDIA18MiXbx0SE0PD7uZZy8aF+Ehpb9eqANrr09i0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092337; c=relaxed/simple;
	bh=npobd54TNh7s8xPDmegUER6qbR94JOCTdgYkJQKkgzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKQHZ3emdpM223n3b+657HskEiP18CSQFKpFtVrKfKtfI9gLpTBSzQ/KCIFkEKSbHFUzjc8K2LyOsOYPO6yrJT2Jn/SYyOo7TNEXFoKZWnjdiMgsGhXdycJtUVNHkTfe8YgoS5KQ7mIyMRD+vzL+tOZcNWDwBhw15E/miSO6+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9H7H2FS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725092336; x=1756628336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=npobd54TNh7s8xPDmegUER6qbR94JOCTdgYkJQKkgzI=;
  b=i9H7H2FSKUJLtsq5qYbLXx5KzjKrllQKbc4JKmuOo6l4nBtfATdN4OK8
   vcPL4cKlyxHcqd1bIxuE2+mEDL+fQ1Mn4yMlFqWHmIOe5gpeoHMw+/rLS
   6n7zVKbwNG+0YzysT6+4pnCS8nCt9gcJjQWrSmJKv7ZhqScINbuYTQU55
   fKmcE3Ye1vMnW7s6w+xB456/OJdGPEG+07EcP0ua+pRdBo4whvP38SIUa
   jN5O514K3mReXX1EQwnEiY6hDqe3bDJbNLg3Jcpv03cC4FVrD+IdWzDYH
   lP0LXQrmRP0qBdN1no7fefJai7C2Xtpsj9j9WHoBZbL0NkZ+BVK9Mosb8
   Q==;
X-CSE-ConnectionGUID: OB8JbqFETGyUcBYgYXlUgA==
X-CSE-MsgGUID: i4rQ1f96QcWMDukTNVi6fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34899139"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="34899139"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 01:18:55 -0700
X-CSE-ConnectionGUID: Mlbj9nIKSxWJ3+kSWBhW8w==
X-CSE-MsgGUID: H4JuTJDIRJWpolmtC0T6xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="87356865"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 Aug 2024 01:18:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJJp-0002S4-0N;
	Sat, 31 Aug 2024 08:18:49 +0000
Date: Sat, 31 Aug 2024 16:18:12 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, manikandan.m@microchip.com,
	dharma.b@microchip.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, hari.prasathge@microchip.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, claudiu.beznea@tuxon.dev
Subject: Re: [PATCH 2/3] drm/bridge: microchip-lvds: Drop unused headers
Message-ID: <202408311600.HvIve8JU-lkp@intel.com>
References: <20240827161223.4152195-3-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827161223.4152195-3-claudiu.beznea@tuxon.dev>

Hi Claudiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu-Beznea/drm-bridge-microchip-lvds-Revert-clk_prepare_enable-in-case-of-failure/20240828-001456
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240827161223.4152195-3-claudiu.beznea%40tuxon.dev
patch subject: [PATCH 2/3] drm/bridge: microchip-lvds: Drop unused headers
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240831/202408311600.HvIve8JU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311600.HvIve8JU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311600.HvIve8JU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/microchip-lvds.c: In function 'lvds_readl':
>> drivers/gpu/drm/bridge/microchip-lvds.c:62:16: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
      62 |         return readl_relaxed(lvds->regs + offset);
         |                ^~~~~~~~~~~~~
   drivers/gpu/drm/bridge/microchip-lvds.c: In function 'lvds_writel':
>> drivers/gpu/drm/bridge/microchip-lvds.c:67:9: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
      67 |         writel_relaxed(val, lvds->regs + offset);
         |         ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/readl_relaxed +62 drivers/gpu/drm/bridge/microchip-lvds.c

179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  59  
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  60  static inline u32 lvds_readl(struct mchp_lvds *lvds, u32 offset)
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  61  {
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21 @62  	return readl_relaxed(lvds->regs + offset);
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  63  }
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  64  
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  65  static inline void lvds_writel(struct mchp_lvds *lvds, u32 offset, u32 val)
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  66  {
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21 @67  	writel_relaxed(val, lvds->regs + offset);
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  68  }
179b0769fc5fc1 Dharma Balasubiramani 2024-04-21  69  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

