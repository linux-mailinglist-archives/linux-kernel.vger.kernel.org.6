Return-Path: <linux-kernel+bounces-380642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207B9AF401
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F11C21E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878122B665;
	Thu, 24 Oct 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVinYR4s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A54216A1D;
	Thu, 24 Oct 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802729; cv=none; b=qwfE+TA2NDxpq8sscj9mM00gZHiAgWQ6mWXMiCPiWvXzRvQqeao6WBCaVpRw4glRa+ACCfC03GHJHHu8DRAHZwTtgZ537gvczMafA+5orXCXZztuZL98QpUTI+zwdI+6PGh6+X83eipCqx4shqL11eFOqPHaHcCMAliIMx8z2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802729; c=relaxed/simple;
	bh=ucJbwvBiLsWRpla8htTc6H7ChqcVCWNJxbQadeAGzmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/ssx7V3Sab8KNzFC+D1ZKvqGKV1lVpwObQfKqalfwSe9bnjB7j95QZ1zY5IjnyjkZx+NaDUEV3hYYMZSfqHM9UbG2XW8hEyhZ9KYf7SLljhpfxb5K4A18c7OYxQQMh350YCqrAN/Ezxd8JxGKXySUtFYuPEU1m6utyk1X0nGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVinYR4s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729802727; x=1761338727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ucJbwvBiLsWRpla8htTc6H7ChqcVCWNJxbQadeAGzmY=;
  b=TVinYR4s/DVqyj1gfF8k2dw3Td54e+NUZx7QsmcMSxdp2tpbq98qYFZH
   BZMbB/6yWEkB4f+Jqt1MYd6o76dbhvm5Vz43LxQp9G5B2HdDzNEovTmFB
   KPepVEv8DpXYE7l0ryRvHRIweSuQYVgLJ33wLhTqkn7ZPNZHweIyGdUlC
   5OkrQDk1dqbEJgRjndQ6nOKzoWyUxTGwvdBGsRs2nPklmME922/cmz8Kj
   Y78VmkT6La0yhiIzzx/8OxQ4ddKmhtib+eqv0ct4/cULeid5lCeqeKvj0
   TaSZ8xBrKHuGV+VyL2VXtV1fNHFeb++kmCWjB7ZzY8iLub2gPwEfWDtIe
   Q==;
X-CSE-ConnectionGUID: dfzQuyv3RcGEEEZvSCYqlA==
X-CSE-MsgGUID: 3UCrxSycTTOWINBUkdwiwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40076652"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40076652"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 13:45:26 -0700
X-CSE-ConnectionGUID: a80PQk+CTeWoZxyfSaCU0Q==
X-CSE-MsgGUID: A2lUjMM7QYCvJ0mjQUtLcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="84668190"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Oct 2024 13:45:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t44hr-000X8a-2u;
	Thu, 24 Oct 2024 20:45:19 +0000
Date: Fri, 25 Oct 2024 04:44:50 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
Message-ID: <202410250433.GvMiJrDV-lkp@intel.com>
References: <20241023090153.1395220-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023090153.1395220-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on pza/reset/next lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.12-rc4 next-20241024]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mfd-aspeed-support-for-AST2700/20241023-170434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20241023090153.1395220-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
config: loongarch-randconfig-r054-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250433.GvMiJrDV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250433.GvMiJrDV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250433.GvMiJrDV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/clk-ast2700.c:17:
>> include/soc/aspeed/reset-aspeed.h:14:5: warning: no previous prototype for 'aspeed_reset_controller_register' [-Wmissing-prototypes]
      14 | int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/aspeed_reset_controller_register +14 include/soc/aspeed/reset-aspeed.h

1476d29e4461f6 Ryan Chen 2024-10-23   9  
1476d29e4461f6 Ryan Chen 2024-10-23  10  #if IS_ENABLED(CONFIG_RESET_ASPEED)
1476d29e4461f6 Ryan Chen 2024-10-23  11  int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
1476d29e4461f6 Ryan Chen 2024-10-23  12  				     const char *adev_name);
1476d29e4461f6 Ryan Chen 2024-10-23  13  #else
1476d29e4461f6 Ryan Chen 2024-10-23 @14  int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
1476d29e4461f6 Ryan Chen 2024-10-23  15  				     const char *adev_name)
1476d29e4461f6 Ryan Chen 2024-10-23  16  {
1476d29e4461f6 Ryan Chen 2024-10-23  17  	return -ENODEV;
1476d29e4461f6 Ryan Chen 2024-10-23  18  }
1476d29e4461f6 Ryan Chen 2024-10-23  19  #endif /* if IS_ENABLED(CONFIG_RESET_ASPEED) */
1476d29e4461f6 Ryan Chen 2024-10-23  20  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

