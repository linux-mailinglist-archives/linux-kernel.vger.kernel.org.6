Return-Path: <linux-kernel+bounces-403030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA39C2FCC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C8F1F21957
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A81A0BE3;
	Sat,  9 Nov 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zpz0mNHF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F61A0BC3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192312; cv=none; b=fP9+aJU3Q6s7yl4ziOjnDyua4h+dccudTgW6MSYutxWuAm1JJ8/SQRVzd6nNdbwTj3EH0an884TMdZ9yU2DnSZhAZal68/yurdIBtR0dd19flqrmLMdyv4w+zYuhtYM883j9IbxXn9cj4ZsTP2eI74h3vpDLYym+C2eOAHeNnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192312; c=relaxed/simple;
	bh=7mZVdy4HvTPq5DFlYE3+ppI/UE45cLaflLdyjAdTgGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjVJWml4PbNrjOzitoLX1BVGIZMaZ0FMEvrJJs/ISiDdGjZVH6X4D6gKMNJu49R63sypWYuCHlp+NxzaPzgMSE8yE6J4NlYfaBAumi1tKA27kuC2bOFrjkynMBYoC9croD0Ip3qleJz4pguUsFjeO02tpOP7/auyJdoxy82oaq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zpz0mNHF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731192310; x=1762728310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7mZVdy4HvTPq5DFlYE3+ppI/UE45cLaflLdyjAdTgGM=;
  b=Zpz0mNHF8swXVcuYkcW2cPMVcaT5InpTXjP9AWhHTf6poUvEKep0tq8p
   YUz6cn/R8rkdFxVxU2UeYmMML0KCyHqTvzr//5HLHyJ7hx+86ZOEuz5ip
   t08kALlzIhwg+ofSe6nWwVhGzEYVwGo4DBwKnhsRijWoHPO6Q/46ajetx
   iUydREArwlt66+UAWQ7IasZfCY7LtcIppS9nAoel37NE0qGTBvYo08LTr
   iw7g8SCAP1SQE1KmpryktON1+kOYC5h9sWo9nL8dg0rDG75762Wfj0/cv
   BW1+Uxq2M/hOHGgMBZ12t5vI/UQYQh6zDGOqEVmS55X/r5Iflu53QDOTf
   g==;
X-CSE-ConnectionGUID: fc0lMeysRPi1m3go0rQkCA==
X-CSE-MsgGUID: MWXsJBVSRFGbNgcL3qoHVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="30446918"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="30446918"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 14:45:09 -0800
X-CSE-ConnectionGUID: 9EXFqZK0SOSAAMztvcJVtg==
X-CSE-MsgGUID: jlVcUIPeQmG/SAB0UbUEUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="91267949"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Nov 2024 14:45:04 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9uCT-000sk6-2X;
	Sat, 09 Nov 2024 22:45:01 +0000
Date: Sun, 10 Nov 2024 06:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 3/7] drm/vc4: use drm_hdmi_connector_mode_valid()
Message-ID: <202411100659.T6WKBFbI-lkp@intel.com>
References: <20241109-hdmi-mode-valid-v3-3-5348c2368076@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109-hdmi-mode-valid-v3-3-5348c2368076@linaro.org>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 929beafbe7acce3267c06115e13e03ff6e50548a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/drm-display-hdmi-add-generic-mode_valid-helper/20241109-203557
base:   929beafbe7acce3267c06115e13e03ff6e50548a
patch link:    https://lore.kernel.org/r/20241109-hdmi-mode-valid-v3-3-5348c2368076%40linaro.org
patch subject: [PATCH v3 3/7] drm/vc4: use drm_hdmi_connector_mode_valid()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241110/202411100659.T6WKBFbI-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241110/202411100659.T6WKBFbI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411100659.T6WKBFbI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/vc4/vc4_hdmi.c:37:
   In file included from include/drm/drm_atomic_helper.h:31:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/vc4/vc4_hdmi.c:1762:61: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    1762 |         return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
         |                                                                    ^~~~
   include/drm/display/drm_hdmi_state_helper.h:25:35: note: passing argument to parameter 'mode' here
      25 |                               struct drm_display_mode *mode);
         |                                                        ^
   4 warnings and 1 error generated.


vim +1762 drivers/gpu/drm/vc4/vc4_hdmi.c

  1749	
  1750	static enum drm_mode_status
  1751	vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
  1752				    const struct drm_display_mode *mode)
  1753	{
  1754		struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
  1755	
  1756		if (vc4_hdmi->variant->unsupported_odd_h_timings &&
  1757		    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
  1758		    ((mode->hdisplay % 2) || (mode->hsync_start % 2) ||
  1759		     (mode->hsync_end % 2) || (mode->htotal % 2)))
  1760			return MODE_H_ILLEGAL;
  1761	
> 1762		return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
  1763	}
  1764	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

