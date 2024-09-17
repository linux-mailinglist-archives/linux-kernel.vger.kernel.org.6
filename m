Return-Path: <linux-kernel+bounces-331938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F46A97B32D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9BC285C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4BA18800E;
	Tue, 17 Sep 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQBt2kgT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDF175D33;
	Tue, 17 Sep 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592133; cv=none; b=SQ9BtKfbMR4Mcv4qJypRUaxXRkU5ln0augoDNjdBRPvbo/r4oBJoD/b8RMdsTpVSvtk94ahg51maUTHk6YXY4QvRPysQ0PEgMBDLOgqbnc84RrkUpbqxuKKxwPzaxqXBQDYjxNo1BflVpW0lk+mw8ef7jmJxzMhpc7zKeE+wabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592133; c=relaxed/simple;
	bh=xrIuqx88CYKFBr/iCYfr2KFzW3LqRlqmcrPi/TbPBfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkIwutI7v6QmT9aC6itefFLtRLs+7A8f5Ic2WjzykVbrkPL+Mqd8mqWkN5KywxPOuLSC2dudAOhmPkt4OGpZzcPPIPaD5yc7/ni6Z2GCs8LJLPln7RMQPkeReeKmZgpWJa27yH8khFsMvK02rR3qS3XRJ0VyfvZXdVfC6r+YNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQBt2kgT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726592131; x=1758128131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xrIuqx88CYKFBr/iCYfr2KFzW3LqRlqmcrPi/TbPBfA=;
  b=PQBt2kgTXj5wpt7tv5+3oBV0OMmH3dKmjPunTAXhU/Xwz98ljzSV2q12
   nIorrsWuRNrfKklkaPQgKfbXpGY5z4GyqjUUQCWS2OBz++cNlTyPhi8nZ
   BsggfiDxPrqG0FbeQkCWSnAPueqkRPgv6GlHF9ADaAh2s9XHFwIt/ZSB9
   CXWXuxouXB/8ysLQj9PT374l7N+W6AwJ3FyFknzauN4YnQpaUwkbn8VZe
   natdgFi89ZvspSFVfO615qbFISPXlp0Zym9z/DDGQ6ChLLAYnTWzuBxeM
   SRBM1JBWhR0zmXkwiyHjr7RkGD9bWc5zLxvp5tjsDGTbrzpym16uF6WzI
   w==;
X-CSE-ConnectionGUID: lYc1roZhSvGHdsbTrsSKOg==
X-CSE-MsgGUID: psyxL/rfRWWa9kPbdqe/+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25585476"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25585476"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 09:55:30 -0700
X-CSE-ConnectionGUID: nrpI2RLAQmOtgjFRLrvICg==
X-CSE-MsgGUID: kkYh9TPuQ6+Kha9oiPdqMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69122449"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Sep 2024 09:55:26 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqbU3-000BLq-30;
	Tue, 17 Sep 2024 16:55:23 +0000
Date: Wed, 18 Sep 2024 00:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: r8a66597-udc: Fix double free in
 r8a66597_probe
Message-ID: <202409180012.odbJn3M3-lkp@intel.com>
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
config: arc-randconfig-002-20240917 (https://download.01.org/0day-ci/archive/20240918/202409180012.odbJn3M3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409180012.odbJn3M3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409180012.odbJn3M3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/udc/r8a66597-udc.c: In function 'r8a66597_probe':
>> drivers/usb/gadget/udc/r8a66597-udc.c:1960:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1960 |         if (r8a66597->ep0_req)
         |         ^~
   drivers/usb/gadget/udc/r8a66597-udc.c:1962:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1962 |                 r8a66597->ep0_req = NULL;
         |                 ^~~~~~~~


vim +/if +1960 drivers/usb/gadget/udc/r8a66597-udc.c

b8a56e17e18cca drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2011-09-30  1832  
dad833823f842b drivers/usb/gadget/r8a66597-udc.c     Peter Chen                2014-05-18  1833  static int r8a66597_probe(struct platform_device *pdev)
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1834  {
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1835  	struct device *dev = &pdev->dev;
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1836  	char clk_name[8];
3c60e959fa3543 drivers/usb/gadget/udc/r8a66597-udc.c YueHaibing                2019-09-04  1837  	struct resource *ires;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1838  	int irq;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1839  	void __iomem *reg = NULL;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1840  	struct r8a66597 *r8a66597 = NULL;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1841  	int ret = 0;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1842  	int i;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1843  	unsigned long irq_trigger;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1844  
3c60e959fa3543 drivers/usb/gadget/udc/r8a66597-udc.c YueHaibing                2019-09-04  1845  	reg = devm_platform_ioremap_resource(pdev, 0);
4b11f88821aff3 drivers/usb/gadget/udc/r8a66597-udc.c Wei Yongjun               2014-07-20  1846  	if (IS_ERR(reg))
4b11f88821aff3 drivers/usb/gadget/udc/r8a66597-udc.c Wei Yongjun               2014-07-20  1847  		return PTR_ERR(reg);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1848  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1849  	ires = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
9c2076090c2815 drivers/usb/gadget/udc/r8a66597-udc.c Colin Ian King            2021-04-06  1850  	if (!ires)
9c2076090c2815 drivers/usb/gadget/udc/r8a66597-udc.c Colin Ian King            2021-04-06  1851  		return -EINVAL;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1852  	irq = ires->start;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1853  	irq_trigger = ires->flags & IRQF_TRIGGER_MASK;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1854  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1855  	if (irq < 0) {
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1856  		dev_err(dev, "platform_get_irq error.\n");
776976a67ae25d drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1857  		return -ENODEV;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1858  	}
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1859  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1860  	/* initialize ucd */
531bc938f9c54c drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1861  	r8a66597 = devm_kzalloc(dev, sizeof(struct r8a66597), GFP_KERNEL);
531bc938f9c54c drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1862  	if (r8a66597 == NULL)
531bc938f9c54c drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1863  		return -ENOMEM;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1864  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1865  	spin_lock_init(&r8a66597->lock);
dae8eadf2a8a12 drivers/usb/gadget/r8a66597-udc.c     Jingoo Han                2013-05-23  1866  	platform_set_drvdata(pdev, r8a66597);
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1867  	r8a66597->pdata = dev_get_platdata(dev);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1868  	r8a66597->irq_sense_low = irq_trigger == IRQF_TRIGGER_LOW;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1869  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1870  	r8a66597->gadget.ops = &r8a66597_gadget_ops;
d327ab5b6d660d drivers/usb/gadget/r8a66597-udc.c     Michal Nazarewicz         2011-11-19  1871  	r8a66597->gadget.max_speed = USB_SPEED_HIGH;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1872  	r8a66597->gadget.name = udc_name;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1873  
e99e88a9d2b067 drivers/usb/gadget/udc/r8a66597-udc.c Kees Cook                 2017-10-16  1874  	timer_setup(&r8a66597->timer, r8a66597_timer, 0);
e8b48669de54d3 drivers/usb/gadget/r8a66597-udc.c     Paul Mundt                2010-06-02  1875  	r8a66597->reg = reg;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1876  
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1877  	if (r8a66597->pdata->on_chip) {
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1878  		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
3d7037b76ba81a drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1879  		r8a66597->clk = devm_clk_get(dev, clk_name);
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1880  		if (IS_ERR(r8a66597->clk)) {
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1881  			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
3d7037b76ba81a drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1882  			return PTR_ERR(r8a66597->clk);
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1883  		}
989c78dd56307c drivers/usb/gadget/r8a66597-udc.c     Laurent Pinchart          2013-10-28  1884  		clk_prepare_enable(r8a66597->clk);
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1885  	}
569a50da7fe514 drivers/usb/gadget/r8a66597-udc.c     Viresh Kumar              2012-07-30  1886  
b8a56e17e18cca drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2011-09-30  1887  	if (r8a66597->pdata->sudmac) {
b8a56e17e18cca drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2011-09-30  1888  		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
b8a56e17e18cca drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2011-09-30  1889  		if (ret < 0)
b8a56e17e18cca drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2011-09-30  1890  			goto clean_up2;
b8a56e17e18cca drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2011-09-30  1891  	}
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1892  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1893  	disable_controller(r8a66597); /* make sure controller is disabled */
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1894  
4b526951c356c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1895  	ret = devm_request_irq(dev, irq, r8a66597_irq, IRQF_SHARED,
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1896  			       udc_name, r8a66597);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1897  	if (ret < 0) {
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1898  		dev_err(dev, "request_irq error (%d)\n", ret);
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1899  		goto clean_up2;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1900  	}
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1901  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1902  	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1903  	r8a66597->gadget.ep0 = &r8a66597->ep[0].ep;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1904  	INIT_LIST_HEAD(&r8a66597->gadget.ep0->ep_list);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1905  	for (i = 0; i < R8A66597_MAX_NUM_PIPE; i++) {
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1906  		struct r8a66597_ep *ep = &r8a66597->ep[i];
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1907  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1908  		if (i != 0) {
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1909  			INIT_LIST_HEAD(&r8a66597->ep[i].ep.ep_list);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1910  			list_add_tail(&r8a66597->ep[i].ep.ep_list,
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1911  					&r8a66597->gadget.ep_list);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1912  		}
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1913  		ep->r8a66597 = r8a66597;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1914  		INIT_LIST_HEAD(&ep->queue);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1915  		ep->ep.name = r8a66597_ep_name[i];
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1916  		ep->ep.ops = &r8a66597_ep_ops;
e117e742d31068 drivers/usb/gadget/r8a66597-udc.c     Robert Baldyga            2013-12-13  1917  		usb_ep_set_maxpacket_limit(&ep->ep, 512);
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1918  
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1919  		if (i == 0) {
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1920  			ep->ep.caps.type_control = true;
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1921  		} else {
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1922  			ep->ep.caps.type_iso = true;
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1923  			ep->ep.caps.type_bulk = true;
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1924  			ep->ep.caps.type_int = true;
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1925  		}
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1926  		ep->ep.caps.dir_in = true;
0ec8026d7afee6 drivers/usb/gadget/udc/r8a66597-udc.c Robert Baldyga            2015-07-31  1927  		ep->ep.caps.dir_out = true;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1928  	}
e117e742d31068 drivers/usb/gadget/r8a66597-udc.c     Robert Baldyga            2013-12-13  1929  	usb_ep_set_maxpacket_limit(&r8a66597->ep[0].ep, 64);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1930  	r8a66597->ep[0].pipenum = 0;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1931  	r8a66597->ep[0].fifoaddr = CFIFO;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1932  	r8a66597->ep[0].fifosel = CFIFOSEL;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1933  	r8a66597->ep[0].fifoctr = CFIFOCTR;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1934  	r8a66597->ep[0].pipectr = get_pipectr_addr(0);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1935  	r8a66597->pipenum2ep[0] = &r8a66597->ep[0];
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1936  	r8a66597->epaddr2ep[0] = &r8a66597->ep[0];
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1937  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1938  	r8a66597->ep0_req = r8a66597_alloc_request(&r8a66597->ep[0].ep,
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1939  							GFP_KERNEL);
f3423d3258cd99 drivers/usb/gadget/r8a66597-udc.c     Wei Yongjun               2013-05-07  1940  	if (r8a66597->ep0_req == NULL) {
f3423d3258cd99 drivers/usb/gadget/r8a66597-udc.c     Wei Yongjun               2013-05-07  1941  		ret = -ENOMEM;
885162d171841e drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1942  		goto clean_up2;
f3423d3258cd99 drivers/usb/gadget/r8a66597-udc.c     Wei Yongjun               2013-05-07  1943  	}
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1944  	r8a66597->ep0_req->complete = nop_completion;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1945  
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1946  	ret = usb_add_gadget_udc(dev, &r8a66597->gadget);
0f91349b89f37d drivers/usb/gadget/r8a66597-udc.c     Sebastian Andrzej Siewior 2011-06-28  1947  	if (ret)
0f91349b89f37d drivers/usb/gadget/r8a66597-udc.c     Sebastian Andrzej Siewior 2011-06-28  1948  		goto err_add_udc;
0f91349b89f37d drivers/usb/gadget/r8a66597-udc.c     Sebastian Andrzej Siewior 2011-06-28  1949  
f390f57c91c9c9 drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1950  	dev_info(dev, "version %s\n", DRIVER_VERSION);
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1951  	return 0;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1952  
0f91349b89f37d drivers/usb/gadget/r8a66597-udc.c     Sebastian Andrzej Siewior 2011-06-28  1953  err_add_udc:
0f91349b89f37d drivers/usb/gadget/r8a66597-udc.c     Sebastian Andrzej Siewior 2011-06-28  1954  	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
63c2ed15c3efd6 drivers/usb/gadget/udc/r8a66597-udc.c Mikhail Arkhipov          2024-09-17  1955  	r8a66597->ep0_req = NULL;
d2e27bdf2870e5 drivers/usb/gadget/r8a66597-udc.c     Magnus Damm               2009-08-19  1956  clean_up2:
3d7037b76ba81a drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1957  	if (r8a66597->pdata->on_chip)
989c78dd56307c drivers/usb/gadget/r8a66597-udc.c     Laurent Pinchart          2013-10-28  1958  		clk_disable_unprepare(r8a66597->clk);
885162d171841e drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1959  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19 @1960  	if (r8a66597->ep0_req)
776976a67ae25d drivers/usb/gadget/r8a66597-udc.c     Ben Dooks                 2014-06-17  1961  		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
63c2ed15c3efd6 drivers/usb/gadget/udc/r8a66597-udc.c Mikhail Arkhipov          2024-09-17  1962  		r8a66597->ep0_req = NULL;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1963  
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1964  	return ret;
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1965  }
c41442474a2698 drivers/usb/gadget/r8a66597-udc.c     Yoshihiro Shimoda         2009-08-19  1966  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

