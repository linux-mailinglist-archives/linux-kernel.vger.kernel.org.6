Return-Path: <linux-kernel+bounces-185473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48C8CB54A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09001C20A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34614A08A;
	Tue, 21 May 2024 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S534v9LZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADA1494CD
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326009; cv=none; b=daYAUueKkYAZKbf31yE8khlQt4yDhfY4VDXseWDGpVRLCKwoUkU0DgScjOQ62UDYJ4aaqWRZsaEX91GDaojBpFQwREt8W8Hc/hUdVrs05VrMF609oFUb33LExLK2UdvXMuopBYhSES1x4Fo4ZQEc/h+pYzpHL4XDjfJXXVfoBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326009; c=relaxed/simple;
	bh=jU/KIs1yxidfflnv5CSKB5RJvZIBfuN7UKBuEXcylFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNfDuaQiCOd6ylp2Nc2l6v76ORsiMFGxvdRznv8qT5ZJGaWpQQDyMh4lh6kAJdMQGM2kBBJICWxoMSZ+7QC71xRNa9x1lo2ha8pBSVjgEINqYm8Rvnsmv6sCNITh/36UGT8Mdck8Pn1fA6Cc5YH4C692ejHgmZ8FBzERT5F9WVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S534v9LZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716326007; x=1747862007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jU/KIs1yxidfflnv5CSKB5RJvZIBfuN7UKBuEXcylFc=;
  b=S534v9LZzdI19LJcuaOFlOJZbcIp/etuytwRQJuM89JomXgy8tYYPvQU
   /QphiIAR9ZS2kAOQ/rEquznZqY9a0Euieo/4zWpJZpVHbafwzG+l4KvyZ
   K6CcND5PIUvgizBNKCcecnGV4Pbise0ce0izAPrWlW7ZW/ekrpftwFT1L
   4alWQsl5TaZDq5JgtxdBPydC3FwGrsrn2XNTzyk52E1hzRg3LatHpus/+
   /Hu57oyhIQja7xgFiQ4yrkSqBmLbl46UupNbw5jyZQMjc26wm3Fae4IPL
   /Qteh9JUXgTyuPz8ipMqFL6UmppiC44ngmCFsKa8Eiagn8Rzz2krrtuYM
   g==;
X-CSE-ConnectionGUID: GNGw3EfcRqytQ+nOmSVqoQ==
X-CSE-MsgGUID: 6wyr2ZXnQ9mSf87ICF5NYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12386863"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12386863"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 14:13:26 -0700
X-CSE-ConnectionGUID: T+/OAt9fSpiQPz7u2tDMSA==
X-CSE-MsgGUID: cFVMG8jZRSib6lotqrC9nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32971104"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 14:13:22 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9Wmo-0000kX-2V;
	Tue, 21 May 2024 21:13:06 +0000
Date: Wed, 22 May 2024 05:12:07 +0800
From: kernel test robot <lkp@intel.com>
To: Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmitry.baryshkov@linaro.org, ictor.liu@nxp.com,
	sui.jingfeng@linux.dev, aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: adv7511:  Fix Intermittent EDID failures
Message-ID: <202405220445.DW2U7DXR-lkp@intel.com>
References: <20240521011614.496421-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521011614.496421-1-aford173@gmail.com>

Hi Adam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-tip/drm-tip linus/master drm-intel/for-linux-next-fixes v6.9 next-20240521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adam-Ford/drm-bridge-adv7511-Fix-Intermittent-EDID-failures/20240521-091841
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240521011614.496421-1-aford173%40gmail.com
patch subject: [PATCH] drm/bridge: adv7511:  Fix Intermittent EDID failures
config: i386-buildonly-randconfig-002-20240521 (https://download.01.org/0day-ci/archive/20240522/202405220445.DW2U7DXR-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240522/202405220445.DW2U7DXR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405220445.DW2U7DXR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:507:35: warning: variable 'cec_status' is uninitialized when used here [-Wuninitialized]
     507 |         if (irq_status == IRQ_HANDLED || cec_status == IRQ_HANDLED)
         |                                          ^~~~~~~~~~
   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:472:16: note: initialize the variable 'cec_status' to silence this warning
     472 |         int cec_status;
         |                       ^
         |                        = 0
   1 warning generated.


vim +/cec_status +507 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c

   505	
   506		/* If there is no IRQ to handle, exit indicating no IRQ data */
 > 507		if (irq_status == IRQ_HANDLED || cec_status == IRQ_HANDLED)
   508			return IRQ_HANDLED;
   509	
   510		return IRQ_NONE;
   511	}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

