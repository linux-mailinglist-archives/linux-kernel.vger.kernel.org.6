Return-Path: <linux-kernel+bounces-189900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D278CF6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C7BB21351
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A77139D0C;
	Sun, 26 May 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7ihNR/3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C348494
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716766462; cv=none; b=WFGC9jqaKQWqTe6SCKk/mNuXoSEsZvI9m4QLUuk47SxXXm/45mVOED4iIjRx8mo+uQDXQOqcqlulIncXR8Mwmu8DgwOtbdMglMezFuSDPbXnmUWzPtyK7AdrKUtJFaRw5P4Y5KJ9lMNFscq/vggayeLZmK76oDOK5dQlwYsYrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716766462; c=relaxed/simple;
	bh=YQOuh/heB2ECjajHc+hfb5AhWWtp9iWjRbj78w+1CBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRXmAJh2GS4rb07VST0s0O1nzp/n9HjnOmjNM5TlDqFfeClzFdH+9nBUiBpi7XGWnV77Vm5I8D37A9VX8mfuXj3DUl/pU8t4Ji0E88wEal5we2CAmNJevRWdThO20M1yHXYy8UGBB5gOEO9WkRWyWeGk+9nrH/OvIcb+kdNSdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7ihNR/3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716766461; x=1748302461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YQOuh/heB2ECjajHc+hfb5AhWWtp9iWjRbj78w+1CBs=;
  b=R7ihNR/3+Zyc3PQsihdWDOxbcFe1fvc5Lo8isbCTnnS/xoImMXHGkCQ5
   YIh6BfsnhTcoqjvzrkA/W1b+9KmBFRKf3zO4X6Rp2zm94pAN7vQ838Hpw
   ZoTmPUV9+fdzL+gVN7cHxBGeD6zK9eYr7qtJEbOV2/ax22lDmIPSTb07k
   ggtaf/TcgKlB3TpoOU80F/m+yoxyQkGSGH5nT5ap9qbZAn/5jb7zgZE2U
   A1E7m5ADdvvqY3giUirPYayrcfgG4e+GjyCs1rA/vCC5pCJPSLu/GOele
   l+JU96vO+r3W+iQ0PzbOrDc1ug3QzMrBrByHjOiU+JLHqvQxtUtPenOLk
   g==;
X-CSE-ConnectionGUID: abjGPGbFQjOUzjxZung2ow==
X-CSE-MsgGUID: C6NgNZz9QLGmHflIBNCG6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="35585949"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="35585949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 16:34:21 -0700
X-CSE-ConnectionGUID: 8PV7+unKQ12ZKoBXrzU2mg==
X-CSE-MsgGUID: rKWAxDmSRmiheDPISxCmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39547247"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 May 2024 16:34:19 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBNNW-0008qr-2t;
	Sun, 26 May 2024 23:34:15 +0000
Date: Mon, 27 May 2024 07:33:22 +0800
From: kernel test robot <lkp@intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v6 02/10] drm/bridge: Set firmware node of drm_bridge
 instances automatically
Message-ID: <202405270622.VDMbp9FR-lkp@intel.com>
References: <20240526202115.129049-3-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526202115.129049-3-sui.jingfeng@linux.dev>

Hi Sui,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-exynos/exynos-drm-next]
[also build test ERROR on linus/master v6.10-rc1 next-20240523]
[cannot apply to shawnguo/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-bridge-Allow-using-fwnode-APIs-to-get-the-next-bridge/20240527-042402
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20240526202115.129049-3-sui.jingfeng%40linux.dev
patch subject: [PATCH v6 02/10] drm/bridge: Set firmware node of drm_bridge instances automatically
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240527/202405270622.VDMbp9FR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405270622.VDMbp9FR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405270622.VDMbp9FR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/omapdrm/dss/hdmi5.c:487:49: error: expected identifier
           drm_bridge_add(&hdmi->bridge, &hdmi->pdev->dev.);
                                                          ^
   1 error generated.


vim +487 drivers/gpu/drm/omapdrm/dss/hdmi5.c

   480	
   481	static void hdmi5_bridge_init(struct omap_hdmi *hdmi)
   482	{
   483		hdmi->bridge.funcs = &hdmi5_bridge_funcs;
   484		hdmi->bridge.ops = DRM_BRIDGE_OP_EDID;
   485		hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
   486	
 > 487		drm_bridge_add(&hdmi->bridge, &hdmi->pdev->dev.);
   488	}
   489	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

