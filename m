Return-Path: <linux-kernel+bounces-310138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C811D96756E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84540282994
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED92142904;
	Sun,  1 Sep 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgF7X3e5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FB13B5A0
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725175783; cv=none; b=hittQwQVaburfyk7j45TA9IQir5sd9qIM7bhU4LdyqXj6khGYZ+ArOFLbZTbi3lQkNUXeNWBOjolwM24dassOqOUAzdVnkuFzOdodHapbPkzziJFQw+VqwLdBmsm6M/6ERyjP4P0JvFRn1jSmPBkMlLUssSPL/wd203U5NGRm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725175783; c=relaxed/simple;
	bh=SQt4JagV+lhS329kwX26vxDV+oV+80PNCFXXzVPsA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQy1FXKw2LePs2WtqdB39FIQ8m0kFtk9taafFk+wGGJqR9ezjgboJt3b7yuwvKC7HD/40KlMuEI+YyK9zXemaTG/ySwRt4tc21p3WUMs0fVU840yNRMjPs8O/dviSOijKT0U2aaTqtRSf3cZBuWssv568CBQmSNbM7YKD3H6Af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgF7X3e5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725175781; x=1756711781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQt4JagV+lhS329kwX26vxDV+oV+80PNCFXXzVPsA2s=;
  b=UgF7X3e5plAaMR3PhS2ePXkcZG9jsJoG8ohyFQMEPGKxfkdcV2SCjpzi
   XrChSM3w5gSHU8jV1Kn7nOzWOIejrwipzbmRqg58J6SaIR1z4K2p5lAzO
   uaTyedVyX4YohBi5WW+C9PWBnCtZh+cvIgc6FC5wgCQ5F2bUmMxKYeK03
   OY5iBNW3pPfjzgta4tZoeP73ODwJyVtZQe4Sfm6HPPE4xUer5rrOUmXMs
   BceDSBqVeZbFujbzSH9iGoFKVRoFJ9UVbr9/OONiMSXcO2TU/f7ubfljq
   OTYgV5+X3xtx7q3hTy/wNdPZrre5imlHq5BecXKenxOHY0x3NYm9HTObO
   g==;
X-CSE-ConnectionGUID: sJTJXrIsTki5MWto0JObmA==
X-CSE-MsgGUID: x4FpvJ17QAavhkx3TknQ8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23638523"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="23638523"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 00:29:41 -0700
X-CSE-ConnectionGUID: Aj8pqp2PS3yVenm/GXAe2w==
X-CSE-MsgGUID: cW04QgowQM6PP7wDj0yJqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64644994"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2024 00:29:37 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skf1j-0003W6-00;
	Sun, 01 Sep 2024 07:29:35 +0000
Date: Sun, 1 Sep 2024 15:28:35 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, manikandan.m@microchip.com,
	dharma.b@microchip.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, hari.prasathge@microchip.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH 2/3] drm/bridge: microchip-lvds: Drop unused headers
Message-ID: <202409011412.DQVmnHIW-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240901/202409011412.DQVmnHIW-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409011412.DQVmnHIW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409011412.DQVmnHIW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/microchip-lvds.c:62:9: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      62 |         return readl_relaxed(lvds->regs + offset);
         |                ^
>> drivers/gpu/drm/bridge/microchip-lvds.c:67:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      67 |         writel_relaxed(val, lvds->regs + offset);
         |         ^
   2 errors generated.


vim +/readl_relaxed +62 drivers/gpu/drm/bridge/microchip-lvds.c

179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  59  
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  60  static inline u32 lvds_readl(struct mchp_lvds *lvds, u32 offset)
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  61  {
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21 @62  	return readl_relaxed(lvds->regs + offset);
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  63  }
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  64  
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  65  static inline void lvds_writel(struct mchp_lvds *lvds, u32 offset, u32 val)
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  66  {
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21 @67  	writel_relaxed(val, lvds->regs + offset);
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  68  }
179b0769fc5fc19 Dharma Balasubiramani 2024-04-21  69  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

