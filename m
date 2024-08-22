Return-Path: <linux-kernel+bounces-296574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2401B95AC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9031281723
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51537165;
	Thu, 22 Aug 2024 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJyCvNd7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D41CFB9;
	Thu, 22 Aug 2024 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298988; cv=none; b=gZZsjXa5sH6QtmQbKj5gwsSbJNUOn1tFY74LTq25qFlxQXz3JVxXURIzv6T4btDdwVKDFvljmlpHQhdxWwWnRkG+AW/LUCc/TOfIMYwsUWTvqUbgZB9G3GscTwIv2Dw+pT1aFQViW4tI6UjcsJIh7ERZ0ajohUQq3OBnwbXxlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298988; c=relaxed/simple;
	bh=67Bel21jv6hBWlgoQQSJs1O2C0veB/Hwe5bH9yClc8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eoirn3kfE2uAfjBUm7MQvrRNTnojps3wfo5oSH6OdIo99Z81abF/LA7oF65M5T1bMmY5ueDzKgDHdpj5prvMa4Rh5F8Kl/w8nZzH2SmvphMI/aseNajjjVeM7cxFxvPLBaTqWMV5RVmqpYaSlbwpK4uagOCpPNIYYKCdFWKzDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJyCvNd7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724298986; x=1755834986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=67Bel21jv6hBWlgoQQSJs1O2C0veB/Hwe5bH9yClc8k=;
  b=kJyCvNd7DORtD8BgHaGnnMgHd6mo1Bv9VAAOTcw9iIV0q92TasndHTLA
   h53vwZLof3Av1Ys4eifln+1AifUgk7dWCTWxRcYhC4h77Aftpdqe5Nkzx
   mjS0Siq3y50jmhA4UUWR8V5LnWQGkoO3A4Dov11syAHePNMCA88d/jIHk
   4ZZOe+WM/3aaaqs+FtFuBmCCY2qa4rQVG4QB/xJKcVimWRGJs1A/z+/0C
   KmY8XYM0Gu5U2SGFadhP0bZZWB3fiMva9Tuokxhyu1kGBontJkC4UEQif
   pLebltSkHj1J5SusE4w8GSDgHOltkGnKz7y1pFrq02lRLkhRkrElY4Qsr
   Q==;
X-CSE-ConnectionGUID: ZKYq2Vm3TXONVjoGDwgN+A==
X-CSE-MsgGUID: 4u/UOii+Tx+ni3r+5vq7TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25586267"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25586267"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 20:56:25 -0700
X-CSE-ConnectionGUID: 953bsQieS0uirvWSphoJ2w==
X-CSE-MsgGUID: W5kDMKzfRiixYZMrvLsMHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="60971752"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Aug 2024 20:56:21 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgyvr-000CGW-0t;
	Thu, 22 Aug 2024 03:56:19 +0000
Date: Thu, 22 Aug 2024 11:55:51 +0800
From: kernel test robot <lkp@intel.com>
To: Lei Liu <liulei.rjpt@vivo.com>, Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com
Subject: Re: [PATCH 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
Message-ID: <202408221155.UveHbLu0-lkp@intel.com>
References: <20240821121048.31566-3-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821121048.31566-3-liulei.rjpt@vivo.com>

Hi Lei,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lei-Liu/usb-aspeed_udc-Use-devm_clk_get_enabled-helpers/20240821-201358
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240821121048.31566-3-liulei.rjpt%40vivo.com
patch subject: [PATCH 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
config: x86_64-randconfig-161-20240822 (https://download.01.org/0day-ci/archive/20240822/202408221155.UveHbLu0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221155.UveHbLu0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221155.UveHbLu0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/gadget/udc/pxa27x_udc.c:2401:44: error: too many arguments to function call, expected single argument 'clk', have 2 arguments
    2401 |         udc->clk = clk_prepare_enable(&pdev->dev, NULL);
         |                    ~~~~~~~~~~~~~~~~~~             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
   include/linux/clk.h:1107:19: note: 'clk_prepare_enable' declared here
    1107 | static inline int clk_prepare_enable(struct clk *clk)
         |                   ^                  ~~~~~~~~~~~~~~~
   1 error generated.


vim +/clk +2401 drivers/usb/gadget/udc/pxa27x_udc.c

  2345	
  2346	/**
  2347	 * pxa_udc_probe - probes the udc device
  2348	 * @pdev: platform device
  2349	 *
  2350	 * Perform basic init : allocates udc clock, creates sysfs files, requests
  2351	 * irq.
  2352	 */
  2353	static int pxa_udc_probe(struct platform_device *pdev)
  2354	{
  2355		struct pxa_udc *udc = &memory;
  2356		int retval = 0, gpio;
  2357		struct pxa2xx_udc_mach_info *mach = dev_get_platdata(&pdev->dev);
  2358		unsigned long gpio_flags;
  2359	
  2360		if (mach) {
  2361			gpio_flags = mach->gpio_pullup_inverted ? GPIOF_ACTIVE_LOW : 0;
  2362			gpio = mach->gpio_pullup;
  2363			if (gpio_is_valid(gpio)) {
  2364				retval = devm_gpio_request_one(&pdev->dev, gpio,
  2365							       gpio_flags,
  2366							       "USB D+ pullup");
  2367				if (retval)
  2368					return retval;
  2369				udc->gpiod = gpio_to_desc(mach->gpio_pullup);
  2370			}
  2371			udc->udc_command = mach->udc_command;
  2372		} else {
  2373			udc->gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_ASIS);
  2374		}
  2375	
  2376		udc->regs = devm_platform_ioremap_resource(pdev, 0);
  2377		if (IS_ERR(udc->regs))
  2378			return PTR_ERR(udc->regs);
  2379		udc->irq = platform_get_irq(pdev, 0);
  2380		if (udc->irq < 0)
  2381			return udc->irq;
  2382	
  2383		udc->dev = &pdev->dev;
  2384		if (of_have_populated_dt()) {
  2385			udc->transceiver =
  2386				devm_usb_get_phy_by_phandle(udc->dev, "phys", 0);
  2387			if (IS_ERR(udc->transceiver))
  2388				return PTR_ERR(udc->transceiver);
  2389		} else {
  2390			udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
  2391		}
  2392	
  2393		if (IS_ERR(udc->gpiod)) {
  2394			dev_err(&pdev->dev, "Couldn't find or request D+ gpio : %ld\n",
  2395				PTR_ERR(udc->gpiod));
  2396			return PTR_ERR(udc->gpiod);
  2397		}
  2398		if (udc->gpiod)
  2399			gpiod_direction_output(udc->gpiod, 0);
  2400	
> 2401		udc->clk = clk_prepare_enable(&pdev->dev, NULL);
  2402		if (IS_ERR(udc->clk))
  2403			return PTR_ERR(udc->clk);
  2404	
  2405		udc->vbus_sensed = 0;
  2406	
  2407		the_controller = udc;
  2408		platform_set_drvdata(pdev, udc);
  2409		udc_init_data(udc);
  2410	
  2411		/* irq setup after old hardware state is cleaned up */
  2412		retval = devm_request_irq(&pdev->dev, udc->irq, pxa_udc_irq,
  2413					  IRQF_SHARED, driver_name, udc);
  2414		if (retval != 0) {
  2415			dev_err(udc->dev, "%s: can't get irq %i, err %d\n",
  2416				driver_name, udc->irq, retval);
  2417			goto err;
  2418		}
  2419	
  2420		if (!IS_ERR_OR_NULL(udc->transceiver))
  2421			usb_register_notifier(udc->transceiver, &pxa27x_udc_phy);
  2422		retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
  2423		if (retval)
  2424			goto err_add_gadget;
  2425	
  2426		pxa_init_debugfs(udc);
  2427		if (should_enable_udc(udc))
  2428			udc_enable(udc);
  2429		return 0;
  2430	
  2431	err_add_gadget:
  2432		if (!IS_ERR_OR_NULL(udc->transceiver))
  2433			usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
  2434	err:
  2435		clk_unprepare(udc->clk);
  2436		return retval;
  2437	}
  2438	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

