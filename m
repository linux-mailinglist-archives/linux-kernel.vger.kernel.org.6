Return-Path: <linux-kernel+bounces-331937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2497B32B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83A21C2315F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD89186E37;
	Tue, 17 Sep 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3G8Z0wd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAA185B52;
	Tue, 17 Sep 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592132; cv=none; b=MfctsWsnCuCi5KlQXh/pgQBBmDJ0vCtznW0WOPDTbsMxkqN1R7gajs2ogZLlVH+xZ6PNDIp5y0SRJhCg4NiOgTbep9TpA8HAZjGMrqSPrSZIj5oWim7ww1JJmXVOFBZ0fkLwD8AfULXc+Yoc9a0kRUqXnYKdNN8Sd4O2XfsZapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592132; c=relaxed/simple;
	bh=lP9S9e+EzwnDZQH6Bj/Kq/7vJZU9JrPQw578263Kois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvRg1qZOQY8aDtq+V6cd8aloNMMtGrCrcRipx3FSLu0hM5ug8yF3I9AqP3vUH1JDg1tHITCY1mN+C5nE02ZLwQ5jXj+va2ULQ/GG0B7PBjWC2VMsP3h2WgwYov+gfGupt66BaCemP8too1IdtC58ymIkDEzQ4oIDMSnxeEk7Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3G8Z0wd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726592130; x=1758128130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lP9S9e+EzwnDZQH6Bj/Kq/7vJZU9JrPQw578263Kois=;
  b=R3G8Z0wdsur2eL6ETRtca0gc0Gq/5LlTdZwA2FsKaNEGgc1HE/e9vBSP
   M/BG9PkoSJUPYhjWlhpzGA96+PqKobA8g0kUcALC2B6TYd3A4zqUgOJxS
   KnosSILVO/r9+HXRqPhbdp+Z3gpQQj5GKmfYyo4BHTAS8q5M48DZJWQwC
   VKl4JWuMKLiZM7JGJZRi5w9E5DWS1SfLBvZFPm0kuhTg/fbPwns4qrm5S
   WQMRK4AvKDbEGn2DnyPm8pU8EG2mKtW5xyX0OX1G5NR8t6d+i1sZLTwyv
   gFcHuJToIOlOtqpISGAcL9DiTLSY2PXHJNWgGVIAp5BIzdhdrLr5iWojU
   A==;
X-CSE-ConnectionGUID: o/jSAKIPTwye9Lve/UlfbA==
X-CSE-MsgGUID: IOkqT6PvQly9jOxUzAO7cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="36598794"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="36598794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 09:55:29 -0700
X-CSE-ConnectionGUID: GMrVelZQTHy0ufxFJv8/TA==
X-CSE-MsgGUID: JWsbMOPAR1K+WwmzPQIFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69467773"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Sep 2024 09:55:26 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqbU3-000BLs-35;
	Tue, 17 Sep 2024 16:55:23 +0000
Date: Wed, 18 Sep 2024 00:55:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: r8a66597-udc: Fix double free in
 r8a66597_probe
Message-ID: <202409180041.GEhgD6dC-lkp@intel.com>
References: <20240916222937.12878-1-m.arhipov@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916222937.12878-1-m.arhipov@rosa.ru>

Hi Mikhail,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.11 next-20240917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikhail-Arkhipov/usb-gadget-r8a66597-udc-Fix-double-free-in-r8a66597_probe/20240917-063133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240916222937.12878-1-m.arhipov%40rosa.ru
patch subject: [PATCH] usb: gadget: r8a66597-udc: Fix double free in r8a66597_probe
config: i386-buildonly-randconfig-001-20240917 (https://download.01.org/0day-ci/archive/20240918/202409180041.GEhgD6dC-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409180041.GEhgD6dC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409180041.GEhgD6dC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/udc/r8a66597-udc.c:1962:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
    1962 |                 r8a66597->ep0_req = NULL;
         |                 ^
   drivers/usb/gadget/udc/r8a66597-udc.c:1960:2: note: previous statement is here
    1960 |         if (r8a66597->ep0_req)
         |         ^
   1 warning generated.


vim +/if +1962 drivers/usb/gadget/udc/r8a66597-udc.c

  1832	
  1833	static int r8a66597_probe(struct platform_device *pdev)
  1834	{
  1835		struct device *dev = &pdev->dev;
  1836		char clk_name[8];
  1837		struct resource *ires;
  1838		int irq;
  1839		void __iomem *reg = NULL;
  1840		struct r8a66597 *r8a66597 = NULL;
  1841		int ret = 0;
  1842		int i;
  1843		unsigned long irq_trigger;
  1844	
  1845		reg = devm_platform_ioremap_resource(pdev, 0);
  1846		if (IS_ERR(reg))
  1847			return PTR_ERR(reg);
  1848	
  1849		ires = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
  1850		if (!ires)
  1851			return -EINVAL;
  1852		irq = ires->start;
  1853		irq_trigger = ires->flags & IRQF_TRIGGER_MASK;
  1854	
  1855		if (irq < 0) {
  1856			dev_err(dev, "platform_get_irq error.\n");
  1857			return -ENODEV;
  1858		}
  1859	
  1860		/* initialize ucd */
  1861		r8a66597 = devm_kzalloc(dev, sizeof(struct r8a66597), GFP_KERNEL);
  1862		if (r8a66597 == NULL)
  1863			return -ENOMEM;
  1864	
  1865		spin_lock_init(&r8a66597->lock);
  1866		platform_set_drvdata(pdev, r8a66597);
  1867		r8a66597->pdata = dev_get_platdata(dev);
  1868		r8a66597->irq_sense_low = irq_trigger == IRQF_TRIGGER_LOW;
  1869	
  1870		r8a66597->gadget.ops = &r8a66597_gadget_ops;
  1871		r8a66597->gadget.max_speed = USB_SPEED_HIGH;
  1872		r8a66597->gadget.name = udc_name;
  1873	
  1874		timer_setup(&r8a66597->timer, r8a66597_timer, 0);
  1875		r8a66597->reg = reg;
  1876	
  1877		if (r8a66597->pdata->on_chip) {
  1878			snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
  1879			r8a66597->clk = devm_clk_get(dev, clk_name);
  1880			if (IS_ERR(r8a66597->clk)) {
  1881				dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
  1882				return PTR_ERR(r8a66597->clk);
  1883			}
  1884			clk_prepare_enable(r8a66597->clk);
  1885		}
  1886	
  1887		if (r8a66597->pdata->sudmac) {
  1888			ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
  1889			if (ret < 0)
  1890				goto clean_up2;
  1891		}
  1892	
  1893		disable_controller(r8a66597); /* make sure controller is disabled */
  1894	
  1895		ret = devm_request_irq(dev, irq, r8a66597_irq, IRQF_SHARED,
  1896				       udc_name, r8a66597);
  1897		if (ret < 0) {
  1898			dev_err(dev, "request_irq error (%d)\n", ret);
  1899			goto clean_up2;
  1900		}
  1901	
  1902		INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
  1903		r8a66597->gadget.ep0 = &r8a66597->ep[0].ep;
  1904		INIT_LIST_HEAD(&r8a66597->gadget.ep0->ep_list);
  1905		for (i = 0; i < R8A66597_MAX_NUM_PIPE; i++) {
  1906			struct r8a66597_ep *ep = &r8a66597->ep[i];
  1907	
  1908			if (i != 0) {
  1909				INIT_LIST_HEAD(&r8a66597->ep[i].ep.ep_list);
  1910				list_add_tail(&r8a66597->ep[i].ep.ep_list,
  1911						&r8a66597->gadget.ep_list);
  1912			}
  1913			ep->r8a66597 = r8a66597;
  1914			INIT_LIST_HEAD(&ep->queue);
  1915			ep->ep.name = r8a66597_ep_name[i];
  1916			ep->ep.ops = &r8a66597_ep_ops;
  1917			usb_ep_set_maxpacket_limit(&ep->ep, 512);
  1918	
  1919			if (i == 0) {
  1920				ep->ep.caps.type_control = true;
  1921			} else {
  1922				ep->ep.caps.type_iso = true;
  1923				ep->ep.caps.type_bulk = true;
  1924				ep->ep.caps.type_int = true;
  1925			}
  1926			ep->ep.caps.dir_in = true;
  1927			ep->ep.caps.dir_out = true;
  1928		}
  1929		usb_ep_set_maxpacket_limit(&r8a66597->ep[0].ep, 64);
  1930		r8a66597->ep[0].pipenum = 0;
  1931		r8a66597->ep[0].fifoaddr = CFIFO;
  1932		r8a66597->ep[0].fifosel = CFIFOSEL;
  1933		r8a66597->ep[0].fifoctr = CFIFOCTR;
  1934		r8a66597->ep[0].pipectr = get_pipectr_addr(0);
  1935		r8a66597->pipenum2ep[0] = &r8a66597->ep[0];
  1936		r8a66597->epaddr2ep[0] = &r8a66597->ep[0];
  1937	
  1938		r8a66597->ep0_req = r8a66597_alloc_request(&r8a66597->ep[0].ep,
  1939								GFP_KERNEL);
  1940		if (r8a66597->ep0_req == NULL) {
  1941			ret = -ENOMEM;
  1942			goto clean_up2;
  1943		}
  1944		r8a66597->ep0_req->complete = nop_completion;
  1945	
  1946		ret = usb_add_gadget_udc(dev, &r8a66597->gadget);
  1947		if (ret)
  1948			goto err_add_udc;
  1949	
  1950		dev_info(dev, "version %s\n", DRIVER_VERSION);
  1951		return 0;
  1952	
  1953	err_add_udc:
  1954		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
  1955		r8a66597->ep0_req = NULL;
  1956	clean_up2:
  1957		if (r8a66597->pdata->on_chip)
  1958			clk_disable_unprepare(r8a66597->clk);
  1959	
  1960		if (r8a66597->ep0_req)
  1961			r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
> 1962			r8a66597->ep0_req = NULL;
  1963	
  1964		return ret;
  1965	}
  1966	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

