Return-Path: <linux-kernel+bounces-432204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC59E476A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DB2163052
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68900191F7E;
	Wed,  4 Dec 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0sEMyxy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DD191F6C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349898; cv=none; b=C+UL+HoC5fiDptZXYdWoWP+JljAPJxKWnmmkL+qdVEFK0GrFZxOnSLOfnyfblajnRGbVT9ogV0aK1ijhYod+BqwrfLyLzkCFGe63IKjmXpruYSvcGQSBsWmb0X2XFIgnnhB+tbuRvgUsK8ejOOw+UA1OKv9XtZxWUjc6EtwxoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349898; c=relaxed/simple;
	bh=yjtLRtRCKWAPsgc1vT8YYp8ipR0xLKwjHOr2+Rn5rZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlT0jccGtkbH1ywlGmtZpP0Wcas9uM2quyrgpGwQFbeMGoh2uyK4cDO1j/mFKHm+rkC9FXOh0lvO83/9RZf2EYI+WQpPLXf3LjqdDlVBXC3APk45GAtJtwfXTe9SAaU3r/B5/Ix2FgWvs8UFI0wn9Eir+RRj8nUvvLE10jQOrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0sEMyxy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733349897; x=1764885897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjtLRtRCKWAPsgc1vT8YYp8ipR0xLKwjHOr2+Rn5rZw=;
  b=d0sEMyxyxY86A3DXBkExC64VyEtwvJn53bmWYaIK9JaoA00gfx750KVO
   +LZJq3CLPwlMxP7axaBNPtS/TtiR8jfr9tqpq5BZqVlAgZ3o4GgWwCzaR
   +9d56+LgnWtBQRQdMRw21Iv2TE/VUc2VJsRZ2bQnG3kiz/K/03GfioV3d
   QWY5p6/oVu2OGkp2IemSBD9iyfGX0QVsHsPzflYhO+sDKBitwneThC8BE
   64JSFmSyN8WMYSAUv9ugXeEpjI6vlpYkbG/NMPP05JPzOBik6s+hC6dcs
   CDKZZdt9l0aj7/Pk8JYq8Ny3ifeIerQRZYvBo9KKxo4+vECKuVns2ewhs
   w==;
X-CSE-ConnectionGUID: QVTM6EfgQiqpdI5DvCCrmA==
X-CSE-MsgGUID: C9HiPdTeSR6b+JZde8cjFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33558907"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33558907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 14:04:56 -0800
X-CSE-ConnectionGUID: 3jwPoGqFTvO0TbolozmAfA==
X-CSE-MsgGUID: gLTI/H5tTDC51CHZk4Mscg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="124711614"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 04 Dec 2024 14:04:52 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIxUH-0003XN-0w;
	Wed, 04 Dec 2024 22:04:49 +0000
Date: Thu, 5 Dec 2024 06:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolaus Voss <nv@vosn.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Liu Ying <victor.liu@nxp.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	miquel.raynal@bootlin.com, nikolaus.voss@haag-streit.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
Message-ID: <202412050521.d87GwldA-lkp@intel.com>
References: <20241203191111.47B56F7@mail.steuer-voss.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203191111.47B56F7@mail.steuer-voss.de>

Hi Nikolaus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip v6.13-rc1 next-20241204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolaus-Voss/drm-bridge-fsl-ldb-fixup-mode-on-freq-mismatch/20241204-115306
base:   linus/master
patch link:    https://lore.kernel.org/r/20241203191111.47B56F7%40mail.steuer-voss.de
patch subject: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241205/202412050521.d87GwldA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050521.d87GwldA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050521.d87GwldA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/bridge/fsl-ldb.c:9:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
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
>> drivers/gpu/drm/bridge/fsl-ldb.c:125:30: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     125 |                                 struct drm_bridge_state *,
         |                                                          ^
   drivers/gpu/drm/bridge/fsl-ldb.c:127:33: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     127 |                                 struct drm_connector_state *)
         |                                                             ^
   6 warnings generated.


vim +125 drivers/gpu/drm/bridge/fsl-ldb.c

   123	
   124	static int fsl_ldb_atomic_check(struct drm_bridge *bridge,
 > 125					struct drm_bridge_state *,
   126					struct drm_crtc_state *crtc_state,
   127					struct drm_connector_state *)
   128	{
   129		struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
   130		const struct drm_display_mode *mode = &crtc_state->mode;
   131		unsigned long requested_link_freq =
   132			fsl_ldb_link_frequency(fsl_ldb, mode->clock);
   133		unsigned long freq = clk_round_rate(fsl_ldb->clk, requested_link_freq);
   134	
   135		if (freq != requested_link_freq) {
   136			/*
   137			 * this will lead to flicker and incomplete lines on
   138			 * the attached display, adjust the CRTC clock
   139			 * accordingly.
   140			 */
   141			struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
   142			int pclk = freq / fsl_ldb_link_frequency(fsl_ldb, 1);
   143	
   144			if (adjusted_mode->clock != pclk) {
   145				dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d kHz -> %d kHz)!\n",
   146					 adjusted_mode->clock, pclk);
   147	
   148				adjusted_mode->clock = pclk;
   149				adjusted_mode->crtc_clock = pclk;
   150			}
   151		}
   152	
   153		return 0;
   154	}
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

