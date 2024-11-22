Return-Path: <linux-kernel+bounces-418760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203C9D655F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DF5161466
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C81185935;
	Fri, 22 Nov 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/2LAu4e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E5156F3A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732310542; cv=none; b=OkRtw7a49yDjdSJNqfI5XjHcKTa/UjEd52L3518WOz1XAceGs+cG7urJPMnnNEhakI1x2ORVRLQmb5NuL9zAVIba6cmtCwe0H14cFthFSHe2nu445bRrGtPfItWIol/bH0KFg7P4yC4CzdOr1+CFlRRQq9dy8wra2HO3IQF4l3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732310542; c=relaxed/simple;
	bh=4u7RAtQSbTcULeSxj/GmNjVcxSSefkweVa9EF+BRk3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GBx2LNaOFl4urf0otLgaXIyGSFczEktOZAcRAPuJV6wY6GpYfBhqEDjZuDHxK3saa71vR1SBqXsZYruv5XTP14AeXhFEUeur3A7lpiUMZcdQJhpVKkVGFs4cEDxVw9Fxwqj+6Q/VsZnOnFgLFVvsaKaSKM9jtC4Rb09dWeHiA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/2LAu4e; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732310540; x=1763846540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4u7RAtQSbTcULeSxj/GmNjVcxSSefkweVa9EF+BRk3Y=;
  b=L/2LAu4eeMAG9i/Wlh2/PCHZ+D1H1mEmJuLIxK5vu1zGnqQdY4eJmfuK
   VWi4EGpwuo2fRojiyxcNBWMLpXWG7a1JH7DGg5jq7tXKZJDftz+CyFj58
   2M2CZtEBGLDyEVgHXuV+0wYOO7SDXBkqSIG5u2KgCPntxVNXNQ+P/fTN1
   ibjwKbE7J7xMLa6hyHsMLlDgIjbj4ks/+5bhMzpPCFJqaMo5UVusmLcXx
   rn8BMlCot3ZfMalpJJdf2ESb4bXHGTObxXJWOaFnHc+9lUM6TBPxuDUo7
   FQAjOJYCwGq2LAJRIGUJQ8sI9oiG2Jnca6YeZ0wdWpPF9b0YEZteXOic/
   Q==;
X-CSE-ConnectionGUID: PbVwMgaLSAGsZIvCcPtuwQ==
X-CSE-MsgGUID: YMf1EKsjQYqpOEf9RAYjOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="49899500"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="49899500"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:22:20 -0800
X-CSE-ConnectionGUID: cpt9aIFfRm2e+NJMxnhH3w==
X-CSE-MsgGUID: +xPNyZCcSnSJqE6TV9DCnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90867778"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Nov 2024 13:22:17 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEb6V-0004Df-1K;
	Fri, 22 Nov 2024 21:22:15 +0000
Date: Sat, 23 Nov 2024 05:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/tty/serial/8250/8250_aspeed_vuart.c:497:1: warning: the
 frame size of 1040 bytes is larger than 1024 bytes
Message-ID: <202411230501.cnNCWLnq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28eb75e178d389d325f1666e422bc13bbbb9804c
commit: e0830dbf71f191851ed3772d2760f007b7c5bc3a serial: core: fix console port-lock regression
date:   4 years, 2 months ago
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20241123/202411230501.cnNCWLnq-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411230501.cnNCWLnq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411230501.cnNCWLnq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_aspeed_vuart.c: In function 'aspeed_vuart_probe':
>> drivers/tty/serial/8250/8250_aspeed_vuart.c:497:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     497 | }
         | ^


vim +497 drivers/tty/serial/8250/8250_aspeed_vuart.c

8d310c9107a2a3 Oskar Senft        2019-09-05  369  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  370  static int aspeed_vuart_probe(struct platform_device *pdev)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  371  {
8d310c9107a2a3 Oskar Senft        2019-09-05  372  	struct of_phandle_args sirq_polarity_sense_args;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  373  	struct uart_8250_port port;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  374  	struct aspeed_vuart *vuart;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  375  	struct device_node *np;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  376  	struct resource *res;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  377  	u32 clk, prop;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  378  	int rc;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  379  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  380  	np = pdev->dev.of_node;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  381  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  382  	vuart = devm_kzalloc(&pdev->dev, sizeof(*vuart), GFP_KERNEL);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  383  	if (!vuart)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  384  		return -ENOMEM;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  385  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  386  	vuart->dev = &pdev->dev;
5909c0bf9c7a17 Jeremy Kerr        2018-03-27  387  	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  388  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  389  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  390  	vuart->regs = devm_ioremap_resource(&pdev->dev, res);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  391  	if (IS_ERR(vuart->regs))
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  392  		return PTR_ERR(vuart->regs);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  393  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  394  	memset(&port, 0, sizeof(port));
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  395  	port.port.private_data = vuart;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  396  	port.port.membase = vuart->regs;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  397  	port.port.mapbase = res->start;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  398  	port.port.mapsize = resource_size(res);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  399  	port.port.startup = aspeed_vuart_startup;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  400  	port.port.shutdown = aspeed_vuart_shutdown;
989983ea849d94 Jeremy Kerr        2018-03-27  401  	port.port.throttle = aspeed_vuart_throttle;
989983ea849d94 Jeremy Kerr        2018-03-27  402  	port.port.unthrottle = aspeed_vuart_unthrottle;
989983ea849d94 Jeremy Kerr        2018-03-27  403  	port.port.status = UPSTAT_SYNC_FIFO;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  404  	port.port.dev = &pdev->dev;
9b614afe6c8048 Dmitry Safonov     2019-12-13  405  	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  406  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  407  	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  408  	if (rc < 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  409  		return rc;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  410  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  411  	if (of_property_read_u32(np, "clock-frequency", &clk)) {
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  412  		vuart->clk = devm_clk_get(&pdev->dev, NULL);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  413  		if (IS_ERR(vuart->clk)) {
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  414  			dev_warn(&pdev->dev,
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  415  				"clk or clock-frequency not defined\n");
cbafe9d5c34673 Alexey Khoroshilov 2017-07-28  416  			rc = PTR_ERR(vuart->clk);
cbafe9d5c34673 Alexey Khoroshilov 2017-07-28  417  			goto err_sysfs_remove;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  418  		}
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  419  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  420  		rc = clk_prepare_enable(vuart->clk);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  421  		if (rc < 0)
cbafe9d5c34673 Alexey Khoroshilov 2017-07-28  422  			goto err_sysfs_remove;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  423  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  424  		clk = clk_get_rate(vuart->clk);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  425  	}
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  426  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  427  	/* If current-speed was set, then try not to change it. */
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  428  	if (of_property_read_u32(np, "current-speed", &prop) == 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  429  		port.port.custom_divisor = clk / (16 * prop);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  430  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  431  	/* Check for shifted address mapping */
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  432  	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  433  		port.port.mapbase += prop;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  434  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  435  	/* Check for registers offset within the devices address range */
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  436  	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  437  		port.port.regshift = prop;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  438  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  439  	/* Check for fifo size */
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  440  	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  441  		port.port.fifosize = prop;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  442  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  443  	/* Check for a fixed line number */
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  444  	rc = of_alias_get_id(np, "serial");
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  445  	if (rc >= 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  446  		port.port.line = rc;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  447  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  448  	port.port.irq = irq_of_parse_and_map(np, 0);
5909c0bf9c7a17 Jeremy Kerr        2018-03-27  449  	port.port.handle_irq = aspeed_vuart_handle_irq;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  450  	port.port.iotype = UPIO_MEM;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  451  	port.port.type = PORT_16550A;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  452  	port.port.uartclk = clk;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  453  	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  454  		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  455  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  456  	if (of_property_read_bool(np, "no-loopback-test"))
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  457  		port.port.flags |= UPF_SKIP_TEST;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  458  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  459  	if (port.port.fifosize)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  460  		port.capabilities = UART_CAP_FIFO;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  461  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  462  	if (of_property_read_bool(np, "auto-flow-control"))
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  463  		port.capabilities |= UART_CAP_AFE;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  464  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  465  	rc = serial8250_register_8250_port(&port);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  466  	if (rc < 0)
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  467  		goto err_clk_disable;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  468  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  469  	vuart->line = rc;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  470  
8d310c9107a2a3 Oskar Senft        2019-09-05  471  	rc = of_parse_phandle_with_fixed_args(
8d310c9107a2a3 Oskar Senft        2019-09-05  472  		np, "aspeed,sirq-polarity-sense", 2, 0,
8d310c9107a2a3 Oskar Senft        2019-09-05  473  		&sirq_polarity_sense_args);
8d310c9107a2a3 Oskar Senft        2019-09-05  474  	if (rc < 0) {
8d310c9107a2a3 Oskar Senft        2019-09-05  475  		dev_dbg(&pdev->dev,
8d310c9107a2a3 Oskar Senft        2019-09-05  476  			"aspeed,sirq-polarity-sense property not found\n");
8d310c9107a2a3 Oskar Senft        2019-09-05  477  	} else {
8d310c9107a2a3 Oskar Senft        2019-09-05  478  		aspeed_vuart_auto_configure_sirq_polarity(
8d310c9107a2a3 Oskar Senft        2019-09-05  479  			vuart, sirq_polarity_sense_args.np,
8d310c9107a2a3 Oskar Senft        2019-09-05  480  			sirq_polarity_sense_args.args[0],
8d310c9107a2a3 Oskar Senft        2019-09-05  481  			BIT(sirq_polarity_sense_args.args[1]));
8d310c9107a2a3 Oskar Senft        2019-09-05  482  		of_node_put(sirq_polarity_sense_args.np);
8d310c9107a2a3 Oskar Senft        2019-09-05  483  	}
8d310c9107a2a3 Oskar Senft        2019-09-05  484  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  485  	aspeed_vuart_set_enabled(vuart, true);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  486  	aspeed_vuart_set_host_tx_discard(vuart, true);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  487  	platform_set_drvdata(pdev, vuart);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  488  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  489  	return 0;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  490  
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  491  err_clk_disable:
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  492  	clk_disable_unprepare(vuart->clk);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  493  	irq_dispose_mapping(port.port.irq);
cbafe9d5c34673 Alexey Khoroshilov 2017-07-28  494  err_sysfs_remove:
cbafe9d5c34673 Alexey Khoroshilov 2017-07-28  495  	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  496  	return rc;
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02 @497  }
7fbcf3afe6e8e1 Jeremy Kerr        2017-05-02  498  

:::::: The code at line 497 was first introduced by commit
:::::: 7fbcf3afe6e8e180bfc39fb3f41657fa6e4af55c drivers/serial: Add driver for Aspeed virtual UART

:::::: TO: Jeremy Kerr <jk@ozlabs.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

