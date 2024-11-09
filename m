Return-Path: <linux-kernel+bounces-402740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED949C2B59
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1FAB21E36
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC64146D78;
	Sat,  9 Nov 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+hXbHPz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EA145A16;
	Sat,  9 Nov 2024 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144228; cv=none; b=H3O0hFUIQfWeSZp8evnoNHtRLeUklwFdo9h0ROkEkBOX0Mmjw2KhQPNIP2pw5x8mwST97TQ483LazDvS6F9FCRa9VoAMakARKcvZY0U7xXCMZUzEUhKjqadZcYUnEjEK5bXPHmhuNkEv7arAsWHk5K0SBx/s73EhVC3QtvXnurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144228; c=relaxed/simple;
	bh=NWdc6EMsUXB5/nOupnFQ13csT4S7r9lLYnX2BdCkLTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF9+mdIYtB1RIYrc4q9EMCvs5/fmcRxWiWWZNICw9msskLBGQknCnG4zyLprwuvy2zL/rvVOzFptISDWTucMXAHoObaZ95qRk4T2SDn0BP4p+kwbY3JSABd+q+M0stiOOU5/L47k1S60H6lUbQ5Kwqwfbf2/6iLRVNqtHTwyW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+hXbHPz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731144226; x=1762680226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NWdc6EMsUXB5/nOupnFQ13csT4S7r9lLYnX2BdCkLTc=;
  b=L+hXbHPzf3IQUWX41uNqpbsZz3kl2SNdGUHtpHixiT8fbjVZ+iC8AgBh
   u2No9yCjbgUhTSCMY3hyO9mVPGP7+zDEII7tbYt5MILv0hMs4ISuHhRED
   7vv+grQ75DItPLcFZ08Xr4eoSv4ZLipEQ3NJQUJFAmYN2DiHGRYwIzpNm
   siuQJR5DB6PquCGwBAqOYwKWVU9WE9E9kC+a5AbrDHLMs4TpzztXdG1np
   dJXaXYG8vdi2Au3BlDAvGSlAiJZFBZoGinKTeUMBPnvY/thYR5vaEEtY0
   ASe7wAiqLNcNNp48bsNASNn7sUFZ9mWGN7ZYlrhy2blBbchzWB9+/oOmJ
   Q==;
X-CSE-ConnectionGUID: YO14ONnsQSuKtSwRlavaEQ==
X-CSE-MsgGUID: XdqulBiQRI2TH+MnO63u7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34710219"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34710219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 01:23:45 -0800
X-CSE-ConnectionGUID: WPJGY4SmQYexEQ3sCXycWA==
X-CSE-MsgGUID: YQftMoKgQumenDTFwfWP/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="116837805"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Nov 2024 01:23:40 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9hgv-000sFU-2j;
	Sat, 09 Nov 2024 09:23:37 +0000
Date: Sat, 9 Nov 2024 17:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux@armlinux.org.uk,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, varshini.rajendran@microchip.com,
	dharma.b@microchip.com, arnd@arndb.de,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, manikandan.m@microchip.com
Subject: Re: [PATCH v5 2/4] drm/bridge: add Microchip DSI controller support
 for sam9x7 SoC series
Message-ID: <202411091737.48zajeBW-lkp@intel.com>
References: <20241106093429.157131-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106093429.157131-3-manikandan.m@microchip.com>

Hi Manikandan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on drm-misc/drm-misc-next linus/master v6.12-rc6 next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikandan-Muralidharan/dt-bindings-display-bridge-add-sam9x75-mipi-dsi-binding/20241106-173638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241106093429.157131-3-manikandan.m%40microchip.com
patch subject: [PATCH v5 2/4] drm/bridge: add Microchip DSI controller support for sam9x7 SoC series
config: nios2-randconfig-r133-20241109 (https://download.01.org/0day-ci/archive/20241109/202411091737.48zajeBW-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241109/202411091737.48zajeBW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411091737.48zajeBW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c:532:24: sparse: sparse: symbol 'dw_mipi_dsi_mchp_driver' was not declared. Should it be static?

vim +/dw_mipi_dsi_mchp_driver +532 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c

   531	
 > 532	struct platform_driver dw_mipi_dsi_mchp_driver = {
   533		.probe		= dw_mipi_dsi_mchp_probe,
   534		.remove		= dw_mipi_dsi_mchp_remove,
   535		.driver		= {
   536			.of_match_table = dw_mipi_dsi_mchp_dt_ids,
   537			.name		= "dw-mipi-dsi-mchp",
   538			.pm		= &dw_mipi_dsi_mchp_pm_ops,
   539		},
   540	};
   541	module_platform_driver(dw_mipi_dsi_mchp_driver);
   542	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

