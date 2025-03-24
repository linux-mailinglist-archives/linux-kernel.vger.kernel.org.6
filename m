Return-Path: <linux-kernel+bounces-574590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC2A6E736
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EA23B64A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0572F1F1506;
	Mon, 24 Mar 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DX0Q9zcq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA02199EA2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742859313; cv=none; b=q26MCr/TsHTQGDSemOgbWrdTp7/Qz0ZAKaVrusrczkvCP+NoKfdAfUg4oQSkN1IUoIoyCG8xWcVmfuroSwmghiwn1G2G0RXInItbzGAkwM2DarO7k4IhZ2BTUxZ/Vu7Xfkltc86Furi+wpMZuIJIN8R+JUzTYkrRoOtXzkOJJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742859313; c=relaxed/simple;
	bh=bkLgouj19yZCUsj65gv0jmAJVuM5mYupi4nBEP4cPcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WjgFtUS/XZ5r4z47Eo0V2yi99BUBV55uAvGZzNDjcfHl0QUcyaRh39aU4cDv5Nt6zXzd0yOWmTYDr8xyb8v97pf22Fum0/ePGkI34feHD9OYBzVR2bPvDA5LrOjHQ/VPAgmumy+umpGBzLKbdEbM2Wegd126va6SDuRA5YPuAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DX0Q9zcq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742859311; x=1774395311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bkLgouj19yZCUsj65gv0jmAJVuM5mYupi4nBEP4cPcY=;
  b=DX0Q9zcqdsbjFFxT/ePKBbzI6+D9vTQzPJ5Emkp344JIcgFHh3aT5kVq
   jFxVmIj1wtmNl860IM24nSc4h0Z009hllxm1Iea7EIqC8tELVZTHmL6IH
   RXfWLZ27zU3Xg5AtTTRrc/WPdw7ICOgy3LkSxWRZaZg7/MEi+GA7QVL8W
   h5Vb33J5ueBBvokgtSQImcUmfUcL/MBv3UYN9j8i4zIPdfwRxdJjrmnOE
   gbzYfGIHVyjGdXwuGlTS6qsh72uKX3fp4wMQIQJFqshb63pUFymzjp1D/
   DMgkkNlA7CjsDKYpu7bbL35JC6IghnE9xsPwFffx5A3gCp7sxg/UK4OmG
   A==;
X-CSE-ConnectionGUID: mSHnO+LfQd2sVbaqxZiiZw==
X-CSE-MsgGUID: Yhsg5msOSpG0AxHI/YibPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="69441437"
X-IronPort-AV: E=Sophos;i="6.14,273,1736841600"; 
   d="scan'208";a="69441437"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 16:35:10 -0700
X-CSE-ConnectionGUID: BUV/r4XlR1u4rCilas7M4Q==
X-CSE-MsgGUID: IZkpwdwnRhytrbkZFRvzJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,273,1736841600"; 
   d="scan'208";a="161411983"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Mar 2025 16:35:08 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twrJt-00040p-2V;
	Mon, 24 Mar 2025 23:35:02 +0000
Date: Tue, 25 Mar 2025 07:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
Subject: drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:347:8: error: call to
 __compiletime_assert_586 declared with 'error' attribute: FIELD_PREP: value
 too large for the field
Message-ID: <202503250754.qfYSEP7S-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b0cb56cbbdb4754918c28d6d7c294d56e28a3dd5
commit: 9f1e1e14f59de8e5a62226840abecbcdbd50221a drm/rockchip: Add MIPI DSI2 glue driver for RK3588
date:   3 months ago
config: s390-randconfig-002-20250325 (https://download.01.org/0day-ci/archive/20250325/202503250754.qfYSEP7S-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250325/202503250754.qfYSEP7S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503250754.qfYSEP7S-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:347:8: error: call to __compiletime_assert_586 declared with 'error' attribute: FIELD_PREP: value too large for the field
                        PHY_SYS_RATIO(tmp));
                        ^
   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:90:27: note: expanded from macro 'PHY_SYS_RATIO'
   #define PHY_SYS_RATIO(x)                FIELD_PREP(GENMASK(16, 0), x)
                                           ^
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
                   ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:530:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:523:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:36:1: note: expanded from here
   __compiletime_assert_586
   ^
   1 error generated.


vim +/error +347 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c

0d6d86253fef1e Heiko Stuebner 2024-12-10  319  
0d6d86253fef1e Heiko Stuebner 2024-12-10  320  static void dw_mipi_dsi2_phy_ratio_cfg(struct dw_mipi_dsi2 *dsi2)
0d6d86253fef1e Heiko Stuebner 2024-12-10  321  {
0d6d86253fef1e Heiko Stuebner 2024-12-10  322  	struct drm_display_mode *mode = &dsi2->mode;
0d6d86253fef1e Heiko Stuebner 2024-12-10  323  	u64 sys_clk = clk_get_rate(dsi2->sys_clk);
0d6d86253fef1e Heiko Stuebner 2024-12-10  324  	u64 pixel_clk, ipi_clk, phy_hsclk;
0d6d86253fef1e Heiko Stuebner 2024-12-10  325  	u64 tmp;
0d6d86253fef1e Heiko Stuebner 2024-12-10  326  
0d6d86253fef1e Heiko Stuebner 2024-12-10  327  	/*
0d6d86253fef1e Heiko Stuebner 2024-12-10  328  	 * in DPHY mode, the phy_hstx_clk is exactly 1/16 the Lane high-speed
0d6d86253fef1e Heiko Stuebner 2024-12-10  329  	 * data rate; In CPHY mode, the phy_hstx_clk is exactly 1/7 the trio
0d6d86253fef1e Heiko Stuebner 2024-12-10  330  	 * high speed symbol rate.
0d6d86253fef1e Heiko Stuebner 2024-12-10  331  	 */
0d6d86253fef1e Heiko Stuebner 2024-12-10  332  	phy_hsclk = DIV_ROUND_CLOSEST_ULL(dsi2->lane_mbps * USEC_PER_SEC, 16);
0d6d86253fef1e Heiko Stuebner 2024-12-10  333  
0d6d86253fef1e Heiko Stuebner 2024-12-10  334  	/* IPI_RATIO_MAN_CFG = PHY_HSTX_CLK / IPI_CLK */
0d6d86253fef1e Heiko Stuebner 2024-12-10  335  	pixel_clk = mode->crtc_clock * MSEC_PER_SEC;
0d6d86253fef1e Heiko Stuebner 2024-12-10  336  	ipi_clk = pixel_clk / 4;
0d6d86253fef1e Heiko Stuebner 2024-12-10  337  
0d6d86253fef1e Heiko Stuebner 2024-12-10  338  	tmp = DIV_ROUND_CLOSEST_ULL(phy_hsclk << 16, ipi_clk);
0d6d86253fef1e Heiko Stuebner 2024-12-10  339  	regmap_write(dsi2->regmap, DSI2_PHY_IPI_RATIO_MAN_CFG,
0d6d86253fef1e Heiko Stuebner 2024-12-10  340  		     PHY_IPI_RATIO(tmp));
0d6d86253fef1e Heiko Stuebner 2024-12-10  341  
0d6d86253fef1e Heiko Stuebner 2024-12-10  342  	/*
0d6d86253fef1e Heiko Stuebner 2024-12-10  343  	 * SYS_RATIO_MAN_CFG = MIPI_DCPHY_HSCLK_Freq / MIPI_DCPHY_HSCLK_Freq
0d6d86253fef1e Heiko Stuebner 2024-12-10  344  	 */
0d6d86253fef1e Heiko Stuebner 2024-12-10  345  	tmp = DIV_ROUND_CLOSEST_ULL(phy_hsclk << 16, sys_clk);
0d6d86253fef1e Heiko Stuebner 2024-12-10  346  	regmap_write(dsi2->regmap, DSI2_PHY_SYS_RATIO_MAN_CFG,
0d6d86253fef1e Heiko Stuebner 2024-12-10 @347  		     PHY_SYS_RATIO(tmp));
0d6d86253fef1e Heiko Stuebner 2024-12-10  348  }
0d6d86253fef1e Heiko Stuebner 2024-12-10  349  

:::::: The code at line 347 was first introduced by commit
:::::: 0d6d86253fef1e6b1e38a54db14bcbea9d0d9ca4 drm/bridge/synopsys: Add MIPI DSI2 host controller bridge

:::::: TO: Heiko Stuebner <heiko.stuebner@cherry.de>
:::::: CC: Heiko Stuebner <heiko@sntech.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

