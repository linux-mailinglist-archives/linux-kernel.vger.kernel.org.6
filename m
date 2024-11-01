Return-Path: <linux-kernel+bounces-392683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB079B9702
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7C41C216CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F961CDA27;
	Fri,  1 Nov 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRbsEF/3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE291AA7BF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484118; cv=none; b=OouKbK4HlaXEepP3+bQZITOSprY5QzSZUH5LmVGQeXq4O3pnkfDZavEgCVCp6wDWVudSF6XCo8oKmFRElCQKSXPelj+09K5Ghb6yebpqmoJHbkvo7kRUIXISsH25NFZxL38vJaHec7QYwiewwFDjkcGspnWtoR61Bol/2rw/nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484118; c=relaxed/simple;
	bh=L6URiYCoXpopiknFDUGt7k++aqPsAhuBO3pNbeASb0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXDAIji6lrOgvpsRWvLscn/pJ0FgIjMX/W5bjdU2HXPxS8BvOZcUyOwWPnkGqfr0mupHvDGXySFCNa9tvrSehk+u8Lg/K5jVcXKqV9RQef5wBGzyOZGbC7WNdSYEdTIRSsIuvaoBOTBpIaS5wh65rO/3Y9EtmJNTjmAHSiaBiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRbsEF/3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730484117; x=1762020117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L6URiYCoXpopiknFDUGt7k++aqPsAhuBO3pNbeASb0g=;
  b=GRbsEF/3qUkZlcJpI3oh8okivIsGEK1omiUzQJL4jlX0TF2DAa/Q61+L
   5X+7a19itAwR+jAp/Sl8oMDwbjUcNvw504fTiHAoniMLS15uilj13DJNX
   hkHzcw+qVSPQ1Izvroerug0JI4rVskgH15MKShHwg3XcSqJ/6P/9psUlx
   P3l14EqXVJyYB8pJA3kSmAE1/jEa6Y3woTU0PlAZ+i4Z2WcfM/hpk3i8f
   Y863b+3uEgxCkWUic06Ni8WMLM87dm39R+0er6pLGTR7uQ8gEcKEbSkcg
   tQ8frdAcRCWjaIpmVQn2oToPvbxMqigNwKCVXk/zSkhd+lCIQwMNRKE83
   Q==;
X-CSE-ConnectionGUID: XC+vdpYQSeqo9wjDx3Vafg==
X-CSE-MsgGUID: HHhRkuPXSeSraAto9iC4Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="17886442"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="17886442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:01:56 -0700
X-CSE-ConnectionGUID: cci1yP8SQi2+tg5zQFYffw==
X-CSE-MsgGUID: SvnGqoF9T9290lHTWh9Erw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="87852661"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 11:01:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6vy2-000hrH-1J;
	Fri, 01 Nov 2024 18:01:50 +0000
Date: Sat, 2 Nov 2024 02:01:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	steven.price@arm.com, suzuki.poulose@arm.com,
	catalin.marinas@arm.com, will@kernel.org, gshan@redhat.com,
	sami.mujawar@arm.com, linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
Message-ID: <202411020102.mnsnqAiD-lkp@intel.com>
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
config: arm64-randconfig-002-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020102.mnsnqAiD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020102.mnsnqAiD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020102.mnsnqAiD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:223:40: warning: unused variable 'arm_cca_match' [-Wunused-const-variable]
     223 | static const struct platform_device_id arm_cca_match[] = {
         |                                        ^~~~~~~~~~~~~
   1 warning generated.


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

