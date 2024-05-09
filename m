Return-Path: <linux-kernel+bounces-174613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236338C1195
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A7283C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4514B083;
	Thu,  9 May 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klGyd6SO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1D3F8E2;
	Thu,  9 May 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266750; cv=none; b=FThwP1kWDNSsOJvX85Gj4glFMexO3srt97TbhZGCI7LtZ6GShnj06Tcs5kdTphX05kwf6BQ1/s4vBlTqYRAvnsyF6gkvliTAylwMzDmYgTVlrRVjI5h+Kia9ku8tuhP+wOX9b9Q2/venkGPXIRtN5lHNAwoC9R8zRN4y6kpy8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266750; c=relaxed/simple;
	bh=ONQFfxoq6nX3ZjhRvSjEIkGU69Pv5KZ5idzzML/ed/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFR9IVineg/K4n4or/JLDd6bL/KKWY8I3gCj0UgAU6jWlsFKtmm1W7sXAbfJoIgeXUAdjmy1K46ZiclkSAcsCMH67wBTWYJfYHU+fjxhCcq1KvkhTsV3PpY4gAX7+bdBHeERxKLCJMMP4lpdwuAMQt5AAXPEF6KMnsZq1QxuNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klGyd6SO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715266748; x=1746802748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ONQFfxoq6nX3ZjhRvSjEIkGU69Pv5KZ5idzzML/ed/0=;
  b=klGyd6SORqRLKqC10sMA7+yhZfaHxNxAGgze81kRRk3YVCiQ/Kk7I2nV
   G7q6tfHQ5hMXUIb/HDoTMi3x5AlAUtWFXVIhxEkloVZKzMu3WPlUNpLq2
   L5kSQ2YyIpnWL83JXJhpkTfdfVN8eoSTsAKkD2U3wHSJS78aXHTJla8ZB
   2IAKqNonJSmeIZ5T4E+PqIbPDbZ0zVEfddt5nJizT4sIqs8Pts+DRl/z5
   zAc/5i4LGSqRvqZ4PanRNKtwtNQZvSuQhlvpL7JE9MuX8BqYhddh99clF
   jPRQedcGbcFufe1x6prkDqiJmyxZ8PC48uoAEUTipxnablz9sdh3mDfW9
   A==;
X-CSE-ConnectionGUID: oeihvIf+RP+nAVNp/IQplw==
X-CSE-MsgGUID: G+nFu1QvQA6t11Kwwkwp9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28677324"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="28677324"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 07:59:08 -0700
X-CSE-ConnectionGUID: fgiAiV85R3CU3d12Foc8fw==
X-CSE-MsgGUID: ktwK0UUDTsOZwYSX6PfqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29340923"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 May 2024 07:59:05 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s55Ed-00050y-1G;
	Thu, 09 May 2024 14:59:03 +0000
Date: Thu, 9 May 2024 22:58:23 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] usb: fotg210: Add missing kernel doc description
Message-ID: <202405092220.8mfNBVyo-lkp@intel.com>
References: <20240508150335.1378629-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508150335.1378629-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.9-rc7 next-20240509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/usb-fotg210-Add-missing-kernel-doc-description/20240508-230440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240508150335.1378629-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] usb: fotg210: Add missing kernel doc description
config: arc-randconfig-001-20240509 (https://download.01.org/0day-ci/archive/20240509/202405092220.8mfNBVyo-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405092220.8mfNBVyo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405092220.8mfNBVyo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/fotg210/fotg210-core.c:102: warning: Function parameter or struct member 'fotg' not described in 'fotg210_vbus'
>> drivers/usb/fotg210/fotg210-core.c:102: warning: Excess function parameter 'fotg210' description in 'fotg210_vbus'


vim +102 drivers/usb/fotg210/fotg210-core.c

00fb05ff87bc63 Linus Walleij   2022-11-09   95  
3e679bde529e89 Linus Walleij   2023-01-18   96  /**
3e679bde529e89 Linus Walleij   2023-01-18   97   * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
16544cb7676b90 Andy Shevchenko 2024-05-08   98   * @fotg210: pointer to a private fotg210 object
3e679bde529e89 Linus Walleij   2023-01-18   99   * @enable: true to enable VBUS, false to disable VBUS
3e679bde529e89 Linus Walleij   2023-01-18  100   */
3e679bde529e89 Linus Walleij   2023-01-18  101  void fotg210_vbus(struct fotg210 *fotg, bool enable)
3e679bde529e89 Linus Walleij   2023-01-18 @102  {
3e679bde529e89 Linus Walleij   2023-01-18  103  	u32 mask;
3e679bde529e89 Linus Walleij   2023-01-18  104  	u32 val;
3e679bde529e89 Linus Walleij   2023-01-18  105  	int ret;
3e679bde529e89 Linus Walleij   2023-01-18  106  
3e679bde529e89 Linus Walleij   2023-01-18  107  	switch (fotg->port) {
3e679bde529e89 Linus Walleij   2023-01-18  108  	case GEMINI_PORT_0:
3e679bde529e89 Linus Walleij   2023-01-18  109  		mask = GEMINI_MISC_USB0_VBUS_ON;
3e679bde529e89 Linus Walleij   2023-01-18  110  		val = enable ? GEMINI_MISC_USB0_VBUS_ON : 0;
3e679bde529e89 Linus Walleij   2023-01-18  111  		break;
3e679bde529e89 Linus Walleij   2023-01-18  112  	case GEMINI_PORT_1:
3e679bde529e89 Linus Walleij   2023-01-18  113  		mask = GEMINI_MISC_USB1_VBUS_ON;
3e679bde529e89 Linus Walleij   2023-01-18  114  		val = enable ? GEMINI_MISC_USB1_VBUS_ON : 0;
3e679bde529e89 Linus Walleij   2023-01-18  115  		break;
3e679bde529e89 Linus Walleij   2023-01-18  116  	default:
3e679bde529e89 Linus Walleij   2023-01-18  117  		return;
3e679bde529e89 Linus Walleij   2023-01-18  118  	}
3e679bde529e89 Linus Walleij   2023-01-18  119  	ret = regmap_update_bits(fotg->map, GEMINI_GLOBAL_MISC_CTRL, mask, val);
3e679bde529e89 Linus Walleij   2023-01-18  120  	if (ret)
3e679bde529e89 Linus Walleij   2023-01-18  121  		dev_err(fotg->dev, "failed to %s VBUS\n",
3e679bde529e89 Linus Walleij   2023-01-18  122  			enable ? "enable" : "disable");
3e679bde529e89 Linus Walleij   2023-01-18  123  	dev_info(fotg->dev, "%s: %s VBUS\n", __func__, enable ? "enable" : "disable");
3e679bde529e89 Linus Walleij   2023-01-18  124  }
3e679bde529e89 Linus Walleij   2023-01-18  125  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

