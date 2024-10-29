Return-Path: <linux-kernel+bounces-387375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 988F69B501A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0531F22AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74611DC18F;
	Tue, 29 Oct 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsnW6QQV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C991D63F1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221586; cv=none; b=j8GW96KjacjIf/Yhh/zCrriVWlZDyt1UiXFo/lCNnv/VMozg95Xk8X4QE2pCjHULAzqVh/cKD/lZjUevQbxdMrqotKHfho6hTx33QeI4f6/JGrr78RCCwykmpBbhpNEebGnjDrFgTPaR1MtMtl72Ixr3I/wBnKhz07F/PwNmBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221586; c=relaxed/simple;
	bh=GFsoyu+gSq/aSU9jlBlwuMAGi0F5EJzjk+vasvk+KMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKbcyeAE+IA/xDpTnLMeC8ZKtOmh0k9hKNkgZHB2t0mtGMOB3cwcBxSR44sVxJawOREYaFFUO1JMOvCLvzmlTcx1lbqg2+8KHI+NnSClZObrpljC5mFUVG2AM0IQ5osXLVe/J4/dBpIaPS4GkL1aaY5AE17kLQP1wIyItQk7nn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsnW6QQV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730221584; x=1761757584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFsoyu+gSq/aSU9jlBlwuMAGi0F5EJzjk+vasvk+KMY=;
  b=UsnW6QQVRPte0zXdXPck0Bre5z+IRctqw3t1OZeakz8DWpTg9P5C1LZZ
   E+MFBW+6iwAm/yDVjePR8hRfaC6FHVO5GvqaS4ijVLgNAUz+VN0jopKYT
   sSsF3OyGcIIWGLZt/cDBU0nm26EAsp3cJMZfMfEEZJkntBV9oRf1u7pAq
   ssTMluLxE08BZ0DqEmnGrlcgoWUm41mDCw7ANZugBsBvIb8skawf+YUU1
   WSpU62unp1SLykZoK+PnP15DMikuXBcTbbhObC/1OOVhCfha6uQtSV1EZ
   e3SOUR7eXAguT/+lPURjC7BN77J5aX6V14FEzABK5JadB3WI8fy85N9+f
   A==;
X-CSE-ConnectionGUID: KkcFxZYxQ3SLu90culnRGg==
X-CSE-MsgGUID: nwmsexS9SGaeS2UF9tj/aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52435496"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52435496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:06:23 -0700
X-CSE-ConnectionGUID: 7q9ZxRnpTnuEDnhZdkCFQg==
X-CSE-MsgGUID: WNsgyM8oS1ez1aK6WXHuiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81945398"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2024 10:06:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5pfc-000dvO-0Q;
	Tue, 29 Oct 2024 17:06:16 +0000
Date: Wed, 30 Oct 2024 01:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: alice.guo@oss.nxp.com, wahrenst@gmx.net, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: Re: [PATCH v2] soc: imx: Add SoC device register for i.MX9
Message-ID: <202410300019.uWGJaR4m-lkp@intel.com>
References: <20241029083406.3888861-1-alice.guo@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029083406.3888861-1-alice.guo@oss.nxp.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v6.12-rc5 next-20241029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alice-guo-oss-nxp-com/soc-imx-Add-SoC-device-register-for-i-MX9/20241029-163718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20241029083406.3888861-1-alice.guo%40oss.nxp.com
patch subject: [PATCH v2] soc: imx: Add SoC device register for i.MX9
config: arm-randconfig-002-20241029 (https://download.01.org/0day-ci/archive/20241030/202410300019.uWGJaR4m-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410300019.uWGJaR4m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300019.uWGJaR4m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/soc/imx/soc-imx9.c:8:
   drivers/soc/imx/soc-imx9.c: In function 'imx9_soc_device_register':
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:462:25: note: in definition of macro 'printk_index_wrap'
     462 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:533:9: note: in expansion of macro 'printk'
     533 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:533:16: note: in expansion of macro 'KERN_ERR'
     533 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/soc/imx/soc-imx9.c:48:17: note: in expansion of macro 'pr_err'
      48 |                 pr_err("%s: SMC failed: %d\n", __func__, res.a0);
         |                 ^~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a7 Joe Perches 2012-07-30  4  
04d2c8c83d0e3ac Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3ac Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3ac Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

