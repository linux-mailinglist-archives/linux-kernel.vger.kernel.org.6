Return-Path: <linux-kernel+bounces-206193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F090057A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7A728C325
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFF195804;
	Fri,  7 Jun 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIG4J86z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759E194AD9;
	Fri,  7 Jun 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768155; cv=none; b=uDABSbtg43WYKLcgCxPh2dy4qM1QezjgkvuK60wW8Iz5GCzMScGZI4mGI5YcXFcyAIcw0S2YZq6zE2UcMue2tfiqWGdXHl+xJ9Gpnm/pdSwWCBy+Ev4uIXnMU+PDjxnK53nKxyeO+SWPbPKH85zbUkQdeu/jhr5kdfN4/+oxoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768155; c=relaxed/simple;
	bh=6tBWrLoq2JL/28m9DOqPDcuz6HYtkpUgfLGc+DHWGcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpngrxgQaah+Y+KI6BEpa0L33UgSNU7SDXoPv6c89ro8Elusp+dSv3KLHJ1wNFNxDwHUKo0fv/37Ts2DBQJf0QAOAmsI2WAela3YWtlW82zRl1jE8uci5OIocHBBM4zw/mCRN0r/9eqP/uJVnxrFDQzUZWND1v+WIR0daSHbdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIG4J86z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717768154; x=1749304154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6tBWrLoq2JL/28m9DOqPDcuz6HYtkpUgfLGc+DHWGcU=;
  b=IIG4J86zXEGiWeYW3COnS/03FEhMd/6ijKHz3B9RgEukWTgPREKuAc3Y
   zS/oJoCGXBZpZHsg+uqnWEiahItMnUO6X/2cSQnDW1coFwWD6ATOZzMkB
   euT81tB0HjFE/+T93nTqPtfVrHI/YppAbiWL5/+QaR0Q1Vfne187LhCC7
   8x31K1Nr5Wr5tlXhiOkI/sxvJDk7KZl3b0Z/PC5JOoqRWV8PrXu4uoESZ
   UlPXAqadZwlHRhaa1jHWySg42Qx+Yyn1y+UUghM21OUVZYD+O+KFIko9U
   4cGb/d2sBSYmTYad95YVvztso3V6dHmTASkz2NVzckbcduPwSnxpaZLhQ
   w==;
X-CSE-ConnectionGUID: WnVOrRkaRX6d9Ebr3Y/fKw==
X-CSE-MsgGUID: DK7TNwmwSh+O3idpor3m6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25062199"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25062199"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:49:14 -0700
X-CSE-ConnectionGUID: 7je1gDvWQ/WAxzEUj89UdA==
X-CSE-MsgGUID: fyC2pXJJSAyqBmvvqdheaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69495146"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jun 2024 06:49:10 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFZxs-0004se-12;
	Fri, 07 Jun 2024 13:49:08 +0000
Date: Fri, 7 Jun 2024 21:48:52 +0800
From: kernel test robot <lkp@intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, mka@chromium.org,
	gregkh@linuxfoundation.org, javier.carrasco@wolfvision.net,
	benjamin.bara@skidata.com, m.felsch@pengutronix.de,
	jbrunet@baylibre.com, frieder.schrempf@kontron.de,
	stefan.eichenberger@toradex.com, michal.simek@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] usb: misc: add Microchip usb5744 SMBus programming
 support
Message-ID: <202406072150.57XLel7f-lkp@intel.com>
References: <1717676883-2876611-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717676883-2876611-1-git-send-email-radhey.shyam.pandey@amd.com>

Hi Radhey,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radhey-Shyam-Pandey/usb-misc-add-Microchip-usb5744-SMBus-programming-support/20240606-203028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1717676883-2876611-1-git-send-email-radhey.shyam.pandey%40amd.com
patch subject: [PATCH] usb: misc: add Microchip usb5744 SMBus programming support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240607/202406072150.57XLel7f-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072150.57XLel7f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072150.57XLel7f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: onboard_dev_5744_i2c_init
   >>> referenced by onboard_usb_dev_pdevs.c
   >>>               drivers/usb/misc/onboard_usb_dev_pdevs.o:(microchip_usb5744_data) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

