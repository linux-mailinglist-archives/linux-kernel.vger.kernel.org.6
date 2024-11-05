Return-Path: <linux-kernel+bounces-397023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF229BD5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF67C1F230F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71D1E766D;
	Tue,  5 Nov 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WryrFrYX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CF1D9359;
	Tue,  5 Nov 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834149; cv=none; b=gcCjDKgkwOlXQKnmf8aa1LTeARmeIqZrJNd13UKdEz7e7uJELLdFN9OiRgXwxn3JVGPft2h0mQRXJAZgkCtKOkU8cUm2X9tb4B/gfiRkdOsI65vhVen70IZue5cpWl75mwmlk9QXKDF7jT78zqvVMi/xNNwyvDS+2uJk1MnbVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834149; c=relaxed/simple;
	bh=9Shq7F5zshytH1TIeEjlYPA2wyJYy7tpdhCPane9pqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJFmFbiEj9yo2byFNVnAlS+A9O53bKQB8dynq8nk+YZWpJ6z620UlSgai9NmlrZlkdBYdzHYdJDS2++nzeu/y1ibtt7/L8iVJ2dQXdIkZMm3sDkTPn2EDBlvdA86lY4BseZ3SrPmQSFUiWn4px3Txz2mrJtNyPe15EUhkZx77/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WryrFrYX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730834148; x=1762370148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Shq7F5zshytH1TIeEjlYPA2wyJYy7tpdhCPane9pqc=;
  b=WryrFrYX8fCMtpDIeMS33iCYyJoWPUY2FvXHKnGTZ7kcGd2saPq2v159
   IN5SjdwOxT7wR+HJWh/dm8EON+iEvwVttHsgE6Aj3ysrxJVLsmwiqP5IC
   PO/eO/sNTmq6EAwqWuJ3SNbEGdVpz8n15tX7MY5wT8ia1qG62ww4jluQP
   ThwAVccvCJ+JkWUJMXp7cfJId9pIdm9Z0Rqlvh1qFl6EJgAo2ffwSjtI7
   t3xwvZ1w26eFsOLC2OpVa2DJ+UnTG203BV78+XpZtfveBBwxoM4z3fECB
   4/UOPnIrHsm3AD8YwWpKc46Rhgt3B0Ckd7qi73KXn8dE8FCi1rEDbLKgU
   g==;
X-CSE-ConnectionGUID: 98igRwAeSiir2EpbrcNHrw==
X-CSE-MsgGUID: oFhoLP0PT9W60PzGSzSDTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42002000"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="42002000"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:15:47 -0800
X-CSE-ConnectionGUID: wR4K5R08S7SJ1rmt0i2Ouw==
X-CSE-MsgGUID: ktw9GgY6Tl2VnQ74Ya5blg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84248501"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Nov 2024 11:15:44 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8P1h-000mNN-2I;
	Tue, 05 Nov 2024 19:15:41 +0000
Date: Wed, 6 Nov 2024 03:14:50 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, quentin.schulz@cherry.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	heiko@sntech.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung CSI/DSI Combo DCPHY
 driver
Message-ID: <202411060336.yBL7jGAs-lkp@intel.com>
References: <20241104111121.99274-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104111121.99274-3-heiko@sntech.de>

Hi Heiko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on robh/for-next linus/master v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/dt-bindings-phy-Add-Rockchip-MIPI-CSI-DSI-PHY-schema/20241104-193646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20241104111121.99274-3-heiko%40sntech.de
patch subject: [PATCH v2 2/2] phy: rockchip: Add Samsung CSI/DSI Combo DCPHY driver
config: m68k-randconfig-r113-20241105 (https://download.01.org/0day-ci/archive/20241106/202411060336.yBL7jGAs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241106/202411060336.yBL7jGAs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060336.yBL7jGAs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:1630:34: warning: 'samsung_mipi_dcphy_of_match' defined but not used [-Wunused-const-variable=]
    1630 | static const struct of_device_id samsung_mipi_dcphy_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/samsung_mipi_dcphy_of_match +1630 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

  1629	
> 1630	static const struct of_device_id samsung_mipi_dcphy_of_match[] = {
  1631		{
  1632			.compatible = "rockchip,rk3576-mipi-dcphy",
  1633			.data = &rk3576_samsung_mipi_dcphy_plat_data,
  1634		}, {
  1635			.compatible = "rockchip,rk3588-mipi-dcphy",
  1636			.data = &rk3588_samsung_mipi_dcphy_plat_data,
  1637		},
  1638		{ /* sentinel */ }
  1639	};
  1640	MODULE_DEVICE_TABLE(of, samsung_mipi_dcphy_of_match);
  1641	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

