Return-Path: <linux-kernel+bounces-289734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66319954B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECBBB224C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098151B8E84;
	Fri, 16 Aug 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkk6Caoo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F41B86DE;
	Fri, 16 Aug 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815366; cv=none; b=tjDDnlQr16MPNZeSEwz8m8lOJ4uE8WCXWUcppkeqnyGcgqot2IknkjYSYaKVuDSgpG5nhC4XJ9iNthiwZaf/LEMS6if71ZI6jz1bmrSdmXW6sbloMPy7n9Qanu7YR7dYEQ00w7Fg2rIVdikaVd9qoTkXEuXt/Hwq0KQsrvSWYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815366; c=relaxed/simple;
	bh=UdpgyUFrZAf8j3dkewoxOErRAvBtqhfOMgKE6Oyyyxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+8UMb8reUOQ614JpRGU/T604YpIFYX2klgv703gWYOSsY4s1FoS7l5vt+9/j545EF+3pt8f5+IrobNjpqj4jbvXLD59FaMld8TFXfAZo9d/xGVHbGLFv/G0vZpJJzPWqgNULToNJ1YbbCKDRpPG1AaaO+G5thzpBqZ1fF+/KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkk6Caoo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723815364; x=1755351364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UdpgyUFrZAf8j3dkewoxOErRAvBtqhfOMgKE6Oyyyxw=;
  b=mkk6Caoo/DuVouMVvip20SX+gMISskDW1D+9f2tD30C3CIwei0tjTdHR
   KKBhEIOWPsP0G5S2AMwBtTh+PHdgRH4NrR2Xd8yR4HExKaU6GIC+vFfbP
   /byNRyOzR6eBBIDMpFrfu5buhtqtga4DCQ4Ph6QNc5q/W3Nil7o6azkL2
   WJ9fCDgkLiygLbGsTokxQXUnGOUwx1A2VDatdKt+Bul18K8AYOERHbbuu
   fVDBL0YUsFcUfGdw5BxNB9z4VsPeaqQXEwdHLwbwMJnoXZteLetZxlPsh
   fEhwor8uQCy0+bnnYalQNRmNX+b58gWiwJdG+3ZcgUoCvcQlEmVlI1GOC
   g==;
X-CSE-ConnectionGUID: +RvBXLQrR+KLBEK2IF6mjw==
X-CSE-MsgGUID: nglskhIMTPScoGNiyg23Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22270470"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22270470"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:36:03 -0700
X-CSE-ConnectionGUID: 1xOv6KyARO2RyfklF3Cr2A==
X-CSE-MsgGUID: 0cQkTY5FT/OOy8Hc6ngyFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90404751"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Aug 2024 06:35:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sex7R-0006Sg-37;
	Fri, 16 Aug 2024 13:35:53 +0000
Date: Fri, 16 Aug 2024 21:35:28 +0800
From: kernel test robot <lkp@intel.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux@armlinux.org.uk,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, arnd@arndb.de, geert+renesas@glider.be,
	mpe@ellerman.id.au, rdunlap@infradead.org, dharma.b@microchip.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, manikandan.m@microchip.com
Subject: Re: [PATCH v3 2/4] drm/bridge: add Microchip DSI controller support
 for sam9x7 SoC series
Message-ID: <202408162158.TlOqyoUA-lkp@intel.com>
References: <20240814105256.177319-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814105256.177319-3-manikandan.m@microchip.com>

Hi Manikandan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on drm-misc/drm-misc-next linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikandan-Muralidharan/dt-bindings-display-bridge-add-sam9x75-mipi-dsi-binding/20240814-234923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240814105256.177319-3-manikandan.m%40microchip.com
patch subject: [PATCH v3 2/4] drm/bridge: add Microchip DSI controller support for sam9x7 SoC series
config: arm-randconfig-r071-20240816 (https://download.01.org/0day-ci/archive/20240816/202408162158.TlOqyoUA-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408162158.TlOqyoUA-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c:293 dw_mipi_dsi_mchp_get_lane_mbps() warn: unsigned 'bpp' is never less than zero.
drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c:293 dw_mipi_dsi_mchp_get_lane_mbps() warn: error code type promoted to positive: 'bpp'
drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c:314 dw_mipi_dsi_mchp_get_lane_mbps() error: uninitialized symbol 'target_mbps'.

vim +/bpp +293 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c

   276	
   277	static int dw_mipi_dsi_mchp_get_lane_mbps(void *priv_data,
   278						  const struct drm_display_mode *mode,
   279						  unsigned long mode_flags, u32 lanes,
   280						  u32 format, unsigned int *lane_mbps)
   281	{
   282		struct dw_mipi_dsi_mchp *dsi = priv_data;
   283		unsigned long best_freq, fvco_min, fvco_max, fin, fout;
   284		unsigned long min_delta = ULONG_MAX, delta;
   285		unsigned int mpclk, target_mbps, desired_mbps;
   286		unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
   287		unsigned int bpp, min_prediv, max_prediv;
   288		unsigned int _fbdiv, best_fbdiv, _prediv, best_prediv;
   289		u64 freq_factor;
   290	
   291		dsi->format = format;
   292		bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 > 293		if (bpp < 0) {
   294			dev_err(dsi->dev,
   295				"failed to get bpp for pixel format %d\n",
   296				dsi->format);
   297			return bpp;
   298		}
   299	
   300		mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
   301		if (mpclk) {
   302			/* take 1/0.8, since mbps must be bigger than bandwidth of RGB */
   303			desired_mbps = mpclk * (bpp / lanes) * 10 / 8;
   304			if (desired_mbps < max_mbps) {
   305				target_mbps = desired_mbps;
   306			} else {
   307				dev_err(dsi->dev,
   308					"DPHY clock frequency is out of range\n");
   309				return -ERANGE;
   310			}
   311		}
   312	
   313		fin = clk_get_rate(dsi->pllref_clk);
 > 314		fout = target_mbps * USEC_PER_SEC;
   315	
   316		/* constraint: 5Mhz <= Fref / N <= 40MHz */
   317		min_prediv = DIV_ROUND_UP(fin, 40 * USEC_PER_SEC);
   318		max_prediv = fin / (5 * USEC_PER_SEC);
   319	
   320		/* constraint: 80MHz <= Fvco <= 1000Mhz */
   321		fvco_min = 80 * USEC_PER_SEC;
   322		fvco_max = 1000 * USEC_PER_SEC;
   323	
   324		for (best_freq = 0, _prediv = min_prediv; _prediv <= max_prediv; _prediv++) {
   325			/* Fvco = Fref * M / N */
   326			freq_factor = fout * _prediv;
   327			do_div(freq_factor, fin);
   328			_fbdiv = freq_factor;
   329			/*
   330			 * Due to the use of a "by 2 pre-scaler," the range of the
   331			 * feedback multiplication value M is limited to even division
   332			 * numbers, and m must be greater than 6, not bigger than 512.
   333			 */
   334			if (_fbdiv < 6 || _fbdiv > 512)
   335				continue;
   336	
   337			_fbdiv += _fbdiv % 2;
   338	
   339			freq_factor = _fbdiv * fin;
   340			do_div(freq_factor, _prediv);
   341			if (freq_factor < fvco_min || freq_factor > fvco_max)
   342				continue;
   343	
   344			delta = abs(fout - freq_factor);
   345			if (delta < min_delta) {
   346				best_prediv = _prediv;
   347				best_fbdiv = _fbdiv;
   348				min_delta = delta;
   349				best_freq = freq_factor;
   350			}
   351		}
   352	
   353		if (best_freq) {
   354			dsi->lane_mbps = DIV_ROUND_UP(best_freq, USEC_PER_SEC);
   355			*lane_mbps = dsi->lane_mbps;
   356			dsi->input_div = best_prediv;
   357			dsi->feedback_div = best_fbdiv;
   358		} else {
   359			dev_err(dsi->dev, "Can not find best_freq for DPHY\n");
   360			return -EINVAL;
   361		}
   362	
   363		return 0;
   364	}
   365	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

