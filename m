Return-Path: <linux-kernel+bounces-392647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B89B96AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A705B216B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703321CCB36;
	Fri,  1 Nov 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt+3OVk3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502851CC178
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482795; cv=none; b=kdyYEZqCVj944ZBNkm6V+NQoq7KfxQ4pEa6tq8ayil2dKxxvylDK5y3OwA2qwYQmM9VUyhgGHNDW2ccmsY0FiMKY7I3xV7ORpLh27k/fQqYZ1EoG9qgiRMTs0srl0jLwuXqOkv5hVwnP1hMSzUjV607dbrz813hzo7yHtmdsqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482795; c=relaxed/simple;
	bh=v89+g/DTQWGhLe4cuYjs1XO0sK/w/oIh3Cy6SzSuvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUrLg7xOUk9LVugTWBtuBkEqLR6BYIxLv5uR8Y7dBm6+AXa2GDbnXjgNqNTArGSTAcrwFHsrOS3/pgRWKwGlaI6iCWQDNPu1qt9rb0GKozMKBrHWIjXI/PZ8Ks6IDrkWIfEnQP+wEx8p87QYULyMJFs9IUwR+dwfPm+3nGzGXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt+3OVk3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730482795; x=1762018795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v89+g/DTQWGhLe4cuYjs1XO0sK/w/oIh3Cy6SzSuvQI=;
  b=Rt+3OVk300pOCfpjs6AFEe0YY3Vi+9ZfyswzqsxqVrcfxVOF3P5P3JAb
   M+mqSM8OmsVdT6IMavfHzIPeUFyKj5cQyHCkEr/fAGpEwpOo38Uf/vsUV
   vbLr4D6/F2oqwSGqiHdc05CJxScXcq5jCEFpqnbgyOc4jcFoZpscaVI4n
   0Js5C7zdBtKD2H6c4C6HYK+nhB+JuExpuTZOgM6zEGzMLnFYhIggoUbO9
   4RNI1eNwARolKs6Qii9SJrNBxuY+lIO8EvyLLKtlsLM+gR7Azp22cLS4n
   hf1Y3GBZy3l8trOc4SHOxH84XV5im5GW6tLa49vf8vn5sbvdcllMVVU70
   g==;
X-CSE-ConnectionGUID: 2tIWiQVvT+ujoM9IjPnl/w==
X-CSE-MsgGUID: 3swk+s+5RT2pb6T5zL7ydA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33946101"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33946101"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:39:54 -0700
X-CSE-ConnectionGUID: ZtWAP1PfRSWO5BFUYHZlbg==
X-CSE-MsgGUID: lL6wqBWATWWj/rbYsPrCXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="88155105"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Nov 2024 10:39:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6vcj-000how-0i;
	Fri, 01 Nov 2024 17:39:49 +0000
Date: Sat, 2 Nov 2024 01:39:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, steven.price@arm.com,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
	gshan@redhat.com, sami.mujawar@arm.com,
	linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
Message-ID: <202411020124.OBmJyKCY-lkp@intel.com>
References: <20241029141114.7207-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029141114.7207-1-jeremy.linton@arm.com>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on next-20241101]
[cannot apply to kvmarm/next soc/for-next linus/master arm/for-next arm/fixes v6.12-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-rsi-Add-automatic-arm-cca-guest-module-loading/20241029-221213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20241029141114.7207-1-jeremy.linton%40arm.com
patch subject: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
config: arm64-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020124.OBmJyKCY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020124.OBmJyKCY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020124.OBmJyKCY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:223:40: warning: 'arm_cca_match' defined but not used [-Wunused-const-variable=]
     223 | static const struct platform_device_id arm_cca_match[] = {
         |                                        ^~~~~~~~~~~~~


vim +/arm_cca_match +223 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c

   222	
 > 223	static const struct platform_device_id arm_cca_match[] = {
   224		{ ARMV9_RSI_PDEV_NAME, 0},
   225		{ }
   226	};
   227	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

