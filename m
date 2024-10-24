Return-Path: <linux-kernel+bounces-379879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB959AE568
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7771C21386
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1631D63DE;
	Thu, 24 Oct 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/twMj9i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81B1D319B;
	Thu, 24 Oct 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774441; cv=none; b=ixYcbDfxi2FGJIZi1C4Duw1VBmcyzR69gT+JrEoM8n0J6609AYAKm2n6ITxNr4hLzffVXgACGq4nozpWHptk77+8V9DaGGlyy+CYu4dzj5vwYwI9EdYrjD09/Obt8mBqnAefDZicdoGHaOROwCq3zMlmLt14weno7dZZo9S1Gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774441; c=relaxed/simple;
	bh=HUuhAWk3dXLnQPMq/6w0jxdCVg118X9Z6g0zogfDEU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFyC3qiOh49w/G8MfbFg1YoCaSN0YZttz3pJJjfePXhlbNiEK3LVOyWKNMlRvtCWu6aFkQB5RXUtk0CQCKyre+DqJ3tetFgF1DqH4hte5F/AJaHBQEO/zHxV78Dk4SYmQiU2kBHwBRpFyWFpti7sZOcINfJLU/+jgzn2QdUPGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/twMj9i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729774439; x=1761310439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUuhAWk3dXLnQPMq/6w0jxdCVg118X9Z6g0zogfDEU8=;
  b=h/twMj9iyxDgIK1xNShcTxbYu34r8LmGLfm78Ks2T3pYSuMebxGYtMut
   r4YtSw4giXhKLSOnDnoihWQ3nYgMT5QYkKJ6CBmajl36rEzOSK/GUkqgn
   R80HQtXBoI0/XBP7sw6ZHwKbWDO1UUUjExtwnSRr1PCebc+iL7ko2n3Uc
   BhcvOev7c7HJsul3W9/4rlvU96o5Eh2QJOHxpbKMOhisBagPLYxibqL63
   HIAZYWOEprFpgrzdGbzgM9pictpkfYIbHoiBJsW8TwK1ijuEzjkLlUHMJ
   ZYp/kpfE+Z0sWadNVBgKldd1RVciw8QpBSgvKPUU86j8+hXHn/PM6xsp/
   Q==;
X-CSE-ConnectionGUID: Pt/EvxJ4RZGStFXH5FByHA==
X-CSE-MsgGUID: 696ex9sdQemjfC2gTK0fWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33305510"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33305510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:53:58 -0700
X-CSE-ConnectionGUID: CYQhb0LyQ/O314nR33NJFw==
X-CSE-MsgGUID: T60QwaPzQhGgKJLZPt2oiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="84560553"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Oct 2024 05:53:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3xLc-000WRA-04;
	Thu, 24 Oct 2024 12:53:52 +0000
Date: Thu, 24 Oct 2024 20:53:28 +0800
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
Message-ID: <202410242017.1valHJUC-lkp@intel.com>
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
config: arm64-randconfig-r133-20241024 (https://download.01.org/0day-ci/archive/20241024/202410242017.1valHJUC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce: (https://download.01.org/0day-ci/archive/20241024/202410242017.1valHJUC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242017.1valHJUC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/clk-ast2700.c:17:
>> include/soc/aspeed/reset-aspeed.h:14:5: warning: no previous prototype for function 'aspeed_reset_controller_register' [-Wmissing-prototypes]
      14 | int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
         |     ^
   include/soc/aspeed/reset-aspeed.h:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      14 | int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
         | ^
         | static 
   1 warning generated.


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

