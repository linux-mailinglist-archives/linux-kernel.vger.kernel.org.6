Return-Path: <linux-kernel+bounces-548383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1969A54411
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EFE171A69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D031FCCF3;
	Thu,  6 Mar 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbZWke5b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EE1FC7D9;
	Thu,  6 Mar 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247720; cv=none; b=aWosuyK0AfXczVOjZfCZ30lqBxPdAvEOH//Rnmr+xXhMInMJGjWaHilwnSDB94vcGk4BROXwWCQlttzJOS2M6yMyFCPuxok+7yZuPcMsoHyviXp65J9PuJPTrrCyCbWtTpDP31RJYy3/ui19XeqjxDdmyBjTASXncqc/ObIPSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247720; c=relaxed/simple;
	bh=axrHsvIoToNXtK0iAOYLE5adm2QDP3djMRMvBFQ4YJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZLQniPktb+3mJVuXdd/GAq1GKiH+w84hYmHuTGawJPZfICof7tzngR2nfhUCLZfHoqYUzIdYbWhC3sHrbsOc7YAwDUhhLwP2l+XlNMvIVT/sCdRAhTywubUcGLMDJaNowYrW/yHaxF3zIRHh1VfX+4wozyacjtgTco2FvbN1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbZWke5b; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741247718; x=1772783718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axrHsvIoToNXtK0iAOYLE5adm2QDP3djMRMvBFQ4YJA=;
  b=GbZWke5b11pxlEVGz6JpVd4x9Kdl3rw6468gbZEOSomPPn02jMIAtrmP
   4yf35/gexKZt1oucyHJSNcXJPC2caj3UDK8yrrnYtCSpPSuLGBAOE7J6l
   7Lc6sum24ZilxZit4W4TKQoGBKcFq2cLJs/owF5vRdbZkzTOpYl2zmASR
   tOAJXhyW4fZrKGLEddE9iGrS6RKOBCAI4hOuEdAC4vig0JqNXjrvoLdfG
   Swf2F24bomLUFOP3R1Pr+RKTXyfDaad7Ceu9eexn8XKDWWncNvHDhClV1
   fKk+rpyTfmFi9I7W2L79uHotoE17gb0UrFFZRkFGFs3+8oK00FCWTZPjP
   w==;
X-CSE-ConnectionGUID: BJJFbI8lTtyybWZzrCxrQg==
X-CSE-MsgGUID: 0dw2IPq3S96IxecHnYf90Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42381286"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42381286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:55:17 -0800
X-CSE-ConnectionGUID: Ue34cYsHQjixUvWidGjgIw==
X-CSE-MsgGUID: puAi2faCRquha8QEsWnO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123893882"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 05 Mar 2025 23:55:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq64L-000MjA-1j;
	Thu, 06 Mar 2025 07:55:05 +0000
Date: Thu, 6 Mar 2025 15:53:36 +0800
From: kernel test robot <lkp@intel.com>
To: Hironori KIKUCHI <kikuchan98@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm: panel: Add a driver for Generic
 MIPI-DSI/DPI(+SPI) panels
Message-ID: <202503061541.2JX2lTlc-lkp@intel.com>
References: <20250226112552.52494-4-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226112552.52494-4-kikuchan98@gmail.com>

Hi Hironori,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hironori-KIKUCHI/dt-bindings-vendor-prefixes-Add-hothmi-vendor-prefix/20250226-192724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250226112552.52494-4-kikuchan98%40gmail.com
patch subject: [PATCH v2 3/3] drm: panel: Add a driver for Generic MIPI-DSI/DPI(+SPI) panels
config: csky-randconfig-r112-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061541.2JX2lTlc-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503061541.2JX2lTlc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061541.2JX2lTlc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/panel/panel-mipi.c:407:26: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:408:27: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:410:20: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:424:29: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:425:28: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:426:29: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:427:33: sparse: sparse: cast to restricted __be16
>> drivers/gpu/drm/panel/panel-mipi.c:429:27: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/panel/panel-mipi.c:854:23: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/panel/panel-mipi.c:856:26: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:857:46: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:858:47: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:859:42: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:861:26: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:862:46: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:863:47: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:864:42: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:866:23: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/panel/panel-mipi.c:1047:22: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:1048:23: sparse: sparse: cast to restricted __be16
   drivers/gpu/drm/panel/panel-mipi.c:1049:27: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/panel/panel-mipi.c: note: in included file (through include/linux/mutex.h, include/drm/drm_mipi_dbi.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +407 drivers/gpu/drm/panel/panel-mipi.c

   392	
   393	static int panel_mipi_read_firmware(const struct device *dev,
   394					    struct panel_mipi *mipi,
   395					    const struct panel_firmware *firmware)
   396	{
   397		int rotation;
   398		int err;
   399	
   400		err = panel_mipi_load_commands(mipi, firmware->commands.data,
   401					       firmware->commands.size);
   402		if (err) {
   403			dev_err(dev, "firmware: Malformed command sequence\n");
   404			return err;
   405		}
   406	
 > 407		mipi->width_mm = be16_to_cpu(firmware->config->width_mm);
   408		mipi->height_mm = be16_to_cpu(firmware->config->height_mm);
   409	
   410		rotation = be16_to_cpu(firmware->config->rotation);
   411		if (rotation == 0)
   412			mipi->orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
   413		else if (rotation == 90)
   414			mipi->orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
   415		else if (rotation == 180)
   416			mipi->orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
   417		else if (rotation == 270)
   418			mipi->orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
   419		else {
   420			dev_err(dev, "firmware: Invalid rotation %u\n", rotation);
   421			return -EINVAL;
   422		}
   423	
   424		mipi->reset_delay = be16_to_cpu(firmware->config->reset_delay);
   425		mipi->init_delay = be16_to_cpu(firmware->config->init_delay);
   426		mipi->sleep_delay = be16_to_cpu(firmware->config->sleep_delay);
   427		mipi->backlight_delay = be16_to_cpu(firmware->config->backlight_delay);
   428	
 > 429		mipi->bus_flags = be32_to_cpu(firmware->config->bus_flags);
   430	
   431		return 0;
   432	}
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

