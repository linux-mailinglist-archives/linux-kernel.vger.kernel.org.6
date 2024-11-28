Return-Path: <linux-kernel+bounces-424596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80A9DB684
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4701643E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F47198A10;
	Thu, 28 Nov 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGvu18Ft"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9222197A7A;
	Thu, 28 Nov 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793342; cv=none; b=ck9P2agSiJYokSQRRALsiIWdi6Mcbbia7Omup+AaRXzDCy77G/OEl50a1SR7EGM5HJ8EAWa42FYox0glnurj7Y1V4YRuW22mgp2/T/iNCNmI2y36a7Quyn0PUl53cj9phWpwHiFFXB7rknbhCQ6gH+ebQ0MXW5rBLyGwhK1jFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793342; c=relaxed/simple;
	bh=GOGSdHxhNEpjsOwO7lywxaLS0up1lx0fM8IsWbTEf+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ5ln/0oS7uZTSoMG3l7VGgOtVK+EUR094iY3YoaGjOBWYZ0N0gvrRvYEmZoSMSqeqFRlU6a5Zw/pkOvE5rnnbMJibTZgt5cLiHLq5X2k9KMgI2YjFSfS5/mi+LLrNZxREAMfW+qsquQEm6EZjXzQ+qn1q1OZ56ldN10tXKHQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGvu18Ft; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732793341; x=1764329341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOGSdHxhNEpjsOwO7lywxaLS0up1lx0fM8IsWbTEf+E=;
  b=VGvu18FtcZaf3wXaanWWZcAf1HPLRBbEBVyNZjoa1GZSXuIAm2vmT6nC
   s51RRwMEH1jn+fyxqkDu/PEFa7jyoVHAMAJWTUItaAeXm/l+zcqY/fppG
   l3rMz3yho5FktsfITxrUhZBiWhmVmfV4N2uUatwPDlw/50ipkwRmK9y/Y
   gH09IOOwkd+YR/k4gx8SuNrK7VjT+sfDKZRv8JkcwQ/iFmFYSvWdrAgbV
   RRZKpGPhyuq8IN4yi0sjJP+K4iHWXUnOhQWZx1RMYgg9RPxj3jPGOY67T
   2Yxz/fkluttygL6znedsYQH2wmIwJUOsCYSEluwCFqGDMQpKXxRK38gB1
   w==;
X-CSE-ConnectionGUID: J3C298eeScu8NXT0hMbQKQ==
X-CSE-MsgGUID: 6xlpNwGlS1WoTQVk/4mzHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33076889"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33076889"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 03:29:00 -0800
X-CSE-ConnectionGUID: Fa0PQXDvT92Zg4JrkfRbxA==
X-CSE-MsgGUID: TnVO9SYjSDuUlM2KNDH2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92020639"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Nov 2024 03:28:54 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGchX-0009WL-33;
	Thu, 28 Nov 2024 11:28:51 +0000
Date: Thu, 28 Nov 2024 19:28:15 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>,
	Daniel Semkowicz <dse@thaumatec.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: Add MIPI DSI2 glue driver for RK3588
Message-ID: <202411281937.QyowC5lv-lkp@intel.com>
References: <20241126201213.522753-4-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126201213.522753-4-heiko@sntech.de>

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12 next-20241128]
[cannot apply to rockchip/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/drm-bridge-synopsys-Add-MIPI-DSI2-host-controller-bridge/20241128-103709
base:   linus/master
patch link:    https://lore.kernel.org/r/20241126201213.522753-4-heiko%40sntech.de
patch subject: [PATCH v2 3/3] drm/rockchip: Add MIPI DSI2 glue driver for RK3588
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241128/202411281937.QyowC5lv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281937.QyowC5lv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281937.QyowC5lv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:20:
   In file included from include/drm/bridge/dw_mipi_dsi2.h:15:
   In file included from include/drm/drm_atomic.h:31:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:315:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     315 |         val |= PHY_LPTX_CLK_DIV(esc_clk_div);
         |                ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:72:30: note: expanded from macro 'PHY_LPTX_CLK_DIV'
      72 | #define PHY_LPTX_CLK_DIV(x)             FIELD_PREP(GENMASK(12, 8), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:340:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     340 |                    PHY_IPI_RATIO(tmp));
         |                    ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:88:27: note: expanded from macro 'PHY_IPI_RATIO'
      88 | #define PHY_IPI_RATIO(x)                FIELD_PREP(GENMASK(21, 0), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:361:53: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     361 |         regmap_write(dsi2->regmap, DSI2_PHY_LP2HS_MAN_CFG, PHY_LP2HS_TIME(timing.data_lp2hs));
         |                                                            ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:77:28: note: expanded from macro 'PHY_LP2HS_TIME'
      77 | #define PHY_LP2HS_TIME(x)               FIELD_PREP(GENMASK(28, 0), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:375:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     375 |                 val |= PPI_WIDTH(PPI_WIDTH_8_BITS);
         |                        ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:68:24: note: expanded from macro 'PPI_WIDTH'
      68 | #define PPI_WIDTH(x)                    FIELD_PREP(GENMASK(9, 8), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:388:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     388 |         val |= PHY_LANES(dsi2->lanes);
         |                ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:69:24: note: expanded from macro 'PHY_LANES'
      69 | #define PHY_LANES(x)                    FIELD_PREP(GENMASK(5, 4), (x) - 1)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:409:48: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     409 |         regmap_write(dsi2->regmap, DSI2_DSI_VCID_CFG, TX_VCID(dsi2->channel));
         |                                                       ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:96:22: note: expanded from macro 'TX_VCID'
      96 | #define TX_VCID(x)                      FIELD_PREP(GENMASK(1, 0), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:430:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     430 |         val = IPI_DEPTH(color_depth) |
         |               ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:116:24: note: expanded from macro 'IPI_DEPTH'
     116 | #define IPI_DEPTH(x)                    FIELD_PREP(GENMASK(7, 4), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:445:55: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     445 |         regmap_write(dsi2->regmap, DSI2_IPI_VID_VSA_MAN_CFG, VID_VSA_LINES(vsa));
         |                                                              ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:133:27: note: expanded from macro 'VID_VSA_LINES'
     133 | #define VID_VSA_LINES(x)                FIELD_PREP(GENMASK(9, 0), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:461:51: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     461 |         regmap_write(dsi2->regmap, DSI2_IPI_PIX_PKT_CFG, MAX_PIX_PKT(val));
         |                                                          ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:141:26: note: expanded from macro 'MAX_PIX_PKT'
     141 | #define MAX_PIX_PKT(x)                  FIELD_PREP(GENMASK(15, 0), x)
         |                                         ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:573:56: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     573 |         regmap_write(dsi2->regmap, DSI2_CRI_TX_HDR, hdr_val | CMD_TX_MODE(lpm));
         |                                                               ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:110:26: note: expanded from macro 'CMD_TX_MODE'
     110 | #define CMD_TX_MODE(x)                  FIELD_PREP(BIT(24), x)
         |                                         ^
   1 warning and 10 errors generated.


vim +/FIELD_PREP +315 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c

c55ecdf5f795ca Heiko Stuebner 2024-11-26  300  
c55ecdf5f795ca Heiko Stuebner 2024-11-26  301  static void dw_mipi_dsi2_phy_clk_mode_cfg(struct dw_mipi_dsi2 *dsi2)
c55ecdf5f795ca Heiko Stuebner 2024-11-26  302  {
c55ecdf5f795ca Heiko Stuebner 2024-11-26  303  	u32 sys_clk, esc_clk_div;
c55ecdf5f795ca Heiko Stuebner 2024-11-26  304  	u32 val = 0;
c55ecdf5f795ca Heiko Stuebner 2024-11-26  305  
c55ecdf5f795ca Heiko Stuebner 2024-11-26  306  	/*
c55ecdf5f795ca Heiko Stuebner 2024-11-26  307  	 * clk_type should be NON_CONTINUOUS_CLK before
c55ecdf5f795ca Heiko Stuebner 2024-11-26  308  	 * initial deskew calibration be sent.
c55ecdf5f795ca Heiko Stuebner 2024-11-26  309  	 */
c55ecdf5f795ca Heiko Stuebner 2024-11-26  310  	val |= NON_CONTINUOUS_CLK;
c55ecdf5f795ca Heiko Stuebner 2024-11-26  311  
c55ecdf5f795ca Heiko Stuebner 2024-11-26  312  	/* The maximum value of the escape clock frequency is 20MHz */
c55ecdf5f795ca Heiko Stuebner 2024-11-26  313  	sys_clk = clk_get_rate(dsi2->sys_clk) / USEC_PER_SEC;
c55ecdf5f795ca Heiko Stuebner 2024-11-26  314  	esc_clk_div = DIV_ROUND_UP(sys_clk, 20 * 2);
c55ecdf5f795ca Heiko Stuebner 2024-11-26 @315  	val |= PHY_LPTX_CLK_DIV(esc_clk_div);
c55ecdf5f795ca Heiko Stuebner 2024-11-26  316  
c55ecdf5f795ca Heiko Stuebner 2024-11-26  317  	regmap_write(dsi2->regmap, DSI2_PHY_CLK_CFG, val);
c55ecdf5f795ca Heiko Stuebner 2024-11-26  318  }
c55ecdf5f795ca Heiko Stuebner 2024-11-26  319  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

