Return-Path: <linux-kernel+bounces-428776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B19E1347
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55566B218B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A22175D39;
	Tue,  3 Dec 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1C3Y38w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449A154430
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733206612; cv=none; b=KB/D4pyiiCUQpb1twYbgSOJ5XIcE1b3dIJNxSZ74Y7MpHIo8E1alouecv1ZdCKVvSyzaBgz2mEHYaohdLORVdnkkMWUzs9+/nlH4kO/Vt9B5IjT6R5xr1mDgtXfhuDLshlO7g3ffHW7/EHDP3v/1PHptY4zFWXS+z4C2PO420Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733206612; c=relaxed/simple;
	bh=oA6ewBaY6R0hItmwM5cpBRuJjIHcJ1qxRSBhvF4GLcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPS7EyQHhWUCWa0P/VOtckzGh49hEAWmS1Od6GX73QliidVRqZd7fuetn2W4IgJGTtGgxPpT1dz8zALwijvj+wmxiky1GQXHyutsxqpBab6h4pv0xNZxsktI9xwOnTSIQ8oGpOcrTwkVpFa64Og/hTnONqWyNiuV1LXRANPBUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1C3Y38w; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733206611; x=1764742611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oA6ewBaY6R0hItmwM5cpBRuJjIHcJ1qxRSBhvF4GLcs=;
  b=k1C3Y38wGK/KcdQ++ONoMbHZhiTKHyBclfMcT9eF7kQGWp51fT5huhRW
   WgglbG9fhMLuZdQz5Jf4W+JBxXHjUvuEpbu7ZYI+d2k1V7cvTXljd8aPY
   DZSJpjDA5zh2H7o8P5EgEdPRVO69I3bovwO79tbKNtmFI391/mN1eEzxA
   XyFbwEj0YjL2K+8Aa2As6kMrErRV3ZfGwtbJ1kXXxa92c6ww7FdfDquA8
   o7Q2iomrbT8peVuDS8fnGRCwYjPMpK47rf4y5qzX+mGMLjFIQDjG9iHyr
   SARnrETqV7nPIMrgSUeiuWMgOubLxFKpTtEoIy7feQ3gjNtZxpJeTyTsl
   g==;
X-CSE-ConnectionGUID: dxSo6vZHS7eqsFl8kMx7vg==
X-CSE-MsgGUID: GhwlqI+5S1mVCIQCHWkHfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33323964"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33323964"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:16:50 -0800
X-CSE-ConnectionGUID: m7bSA4OnTsu/ivmR3USEIg==
X-CSE-MsgGUID: qJWVHbb8RI6rUa9aO/NjJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97396964"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 Dec 2024 22:16:47 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIMDE-0000D5-1f;
	Tue, 03 Dec 2024 06:16:44 +0000
Date: Tue, 3 Dec 2024 14:16:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, gshan@redhat.com, steven.price@arm.com,
	sami.mujawar@arm.com, suzuki.poulose@arm.com, will@kernel.org,
	catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
Message-ID: <202412031328.ybzEAJ4U-lkp@intel.com>
References: <20241203000156.72451-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203000156.72451-2-jeremy.linton@arm.com>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on linus/master v6.13-rc1 next-20241128]
[cannot apply to kvmarm/next soc/for-next arm/for-next arm/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-rsi-Add-automatic-arm-cca-guest-module-loading/20241203-080347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20241203000156.72451-2-jeremy.linton%40arm.com
patch subject: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest module loading
config: arm64-randconfig-001-20241203 (https://download.01.org/0day-ci/archive/20241203/202412031328.ybzEAJ4U-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031328.ybzEAJ4U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031328.ybzEAJ4U-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:224:55: warning: 'arm_cca_match' defined but not used [-Wunused-const-variable=]
     224 | static const struct __maybe_unused platform_device_id arm_cca_match[] = {
         |                                                       ^~~~~~~~~~~~~


vim +/arm_cca_match +224 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c

   222	
   223	/* modalias, so userspace can autoload this module when RSI is available */
 > 224	static const struct __maybe_unused platform_device_id arm_cca_match[] = {
   225		{ RSI_PDEV_NAME, 0},
   226		{ }
   227	};
   228	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

