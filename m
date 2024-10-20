Return-Path: <linux-kernel+bounces-373153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B779A5307
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A05B227F1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290F2AF1D;
	Sun, 20 Oct 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlHw7KO4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F61C6B8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729410449; cv=none; b=D+c7gc1cabkON+vL7hOvNtZGmVGucjheT2npIM0rcPW3LtBgvX+r6EBvjDuoF0RwOzvVGYSAvvNNE9My6NbASNEof9F8yrlZWdaFW+FQWwyZCD/AQTEL50SBPv3dS/prmCJH+QHbG7tZN7ETt8Sli4aHjL/bdzpa9S8T71zVjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729410449; c=relaxed/simple;
	bh=kQxe1Cup7jyei8l0Dw3Lbx4I+4EA7ktrVDWZoH4gXaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6SINCq/6H8h8Af2XADrsoNL652jg0OVorclV6CfWT9g3NOtFPYY73W15jGSuXFuP3RmXqFocGy9unHjuXbSx13r8usUOYOTEkTZ4Ud6ZS4AC4S2FnTA4HS4HA1b5iKTyXK2IZgMEJ1/x/56kd4u1KTy1PSWJnAQqzPrQKJ+51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlHw7KO4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729410447; x=1760946447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kQxe1Cup7jyei8l0Dw3Lbx4I+4EA7ktrVDWZoH4gXaI=;
  b=dlHw7KO4LkmuUYuxHIGdrKtH8ZLRfWyLMmENTHGoVbb3h3HTRZqTHnkn
   aqenT9V6r/km+uAVj7vWM6tEqSA1paZbBhSyusFmgf07mb7CWaNxzRiwh
   1jg/fcFkqrLqTiRdIjLTKFyVg9PYSe4ITOaNuzgDkLeC5Aij7dAlujWYL
   1CbgozS8rO30fUEEULZNCDK7skEoOSqmflcUFGgr2jZqLz1oymxrtArj7
   77FcrlPtGTGLxJeATBnjW+xGDWT9Q3G1BmqcEOoa7ZY5EJTLqD04yF71Z
   /W5+PMm/FKq/ptSusbXbR7kSBH0h6IDKE2kb5ZklBzkq6Q0U9Jvc6Q9IS
   g==;
X-CSE-ConnectionGUID: ggJaWzp6SgOq0/avuB2/lA==
X-CSE-MsgGUID: F5kaeu1dSni4F8yaMYfZfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="40262277"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="40262277"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 00:47:26 -0700
X-CSE-ConnectionGUID: QWUUpMZGS1Ozr3fZ+zQ0Sg==
X-CSE-MsgGUID: VMayUi/4QbmM7gCW4K4WWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="79644112"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Oct 2024 00:47:24 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Qen-000Q3T-2r;
	Sun, 20 Oct 2024 07:47:21 +0000
Date: Sun, 20 Oct 2024 15:46:31 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Sanket.Goswami@amd.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH 3/6] i3c: master: Add ACPI support to i3c subsystem
Message-ID: <202410201515.SaOuSc9G-lkp@intel.com>
References: <20241017150330.3035568-4-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017150330.3035568-4-Shyam-sundar.S-k@amd.com>

Hi Shyam,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Sundar-S-K/i3c-dw-Add-support-for-AMDI0015-ACPI-ID/20241017-230810
base:   linus/master
patch link:    https://lore.kernel.org/r/20241017150330.3035568-4-Shyam-sundar.S-k%40amd.com
patch subject: [PATCH 3/6] i3c: master: Add ACPI support to i3c subsystem
config: arc-randconfig-001-20241020 (https://download.01.org/0day-ci/archive/20241020/202410201515.SaOuSc9G-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201515.SaOuSc9G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201515.SaOuSc9G-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/i3c/master/dw-i3c-master.c: In function 'dw_i3c_common_probe':
>> drivers/i3c/master/dw-i3c-master.c:1606:32: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_fwnode_handle'? [-Werror=implicit-function-declaration]
    1606 |         master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
         |                                ^~~~~~~~~~~~~~~~~~
         |                                acpi_fwnode_handle
>> drivers/i3c/master/dw-i3c-master.c:1606:30: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1606 |         master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
         |                              ^
   cc1: some warnings being treated as errors


vim +1606 drivers/i3c/master/dw-i3c-master.c

  1545	
  1546	int dw_i3c_common_probe(struct dw_i3c_master *master,
  1547				struct platform_device *pdev)
  1548	{
  1549		int ret, irq;
  1550	
  1551		if (!master->platform_ops)
  1552			master->platform_ops = &dw_i3c_platform_ops_default;
  1553	
  1554		master->dev = &pdev->dev;
  1555	
  1556		master->regs = devm_platform_ioremap_resource(pdev, 0);
  1557		if (IS_ERR(master->regs))
  1558			return PTR_ERR(master->regs);
  1559	
  1560		master->core_clk = devm_clk_get_enabled(&pdev->dev, NULL);
  1561		if (IS_ERR(master->core_clk))
  1562			return PTR_ERR(master->core_clk);
  1563	
  1564		master->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
  1565		if (IS_ERR(master->pclk))
  1566			return PTR_ERR(master->pclk);
  1567	
  1568		master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
  1569									    "core_rst");
  1570		if (IS_ERR(master->core_rst))
  1571			return PTR_ERR(master->core_rst);
  1572	
  1573		reset_control_deassert(master->core_rst);
  1574	
  1575		spin_lock_init(&master->xferqueue.lock);
  1576		INIT_LIST_HEAD(&master->xferqueue.list);
  1577	
  1578		writel(INTR_ALL, master->regs + INTR_STATUS);
  1579		irq = platform_get_irq(pdev, 0);
  1580		ret = devm_request_irq(&pdev->dev, irq,
  1581				       dw_i3c_master_irq_handler, IRQF_SHARED,
  1582				       dev_name(&pdev->dev), master);
  1583		if (ret)
  1584			goto err_assert_rst;
  1585	
  1586		platform_set_drvdata(pdev, master);
  1587	
  1588		pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
  1589		pm_runtime_use_autosuspend(&pdev->dev);
  1590		pm_runtime_set_active(&pdev->dev);
  1591		pm_runtime_enable(&pdev->dev);
  1592	
  1593		/* Information regarding the FIFOs/QUEUEs depth */
  1594		ret = readl(master->regs + QUEUE_STATUS_LEVEL);
  1595		master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
  1596	
  1597		ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
  1598		master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
  1599	
  1600		ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
  1601		master->datstartaddr = ret;
  1602		master->maxdevs = ret >> 16;
  1603		master->free_pos = GENMASK(master->maxdevs - 1, 0);
  1604	
  1605		ACPI_COMPANION_SET(&master->base.dev, ACPI_COMPANION(&pdev->dev));
> 1606		master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
  1607		if (!master->base.ahandle)
  1608			dev_err(&pdev->dev, "Failed to get acpi device handle\n");
  1609	
  1610		INIT_WORK(&master->hj_work, dw_i3c_hj_work);
  1611		ret = i3c_master_register(&master->base, &pdev->dev,
  1612					  &dw_mipi_i3c_ops, false);
  1613		if (ret)
  1614			goto err_disable_pm;
  1615	
  1616		return 0;
  1617	
  1618	err_disable_pm:
  1619		pm_runtime_disable(&pdev->dev);
  1620		pm_runtime_set_suspended(&pdev->dev);
  1621		pm_runtime_dont_use_autosuspend(&pdev->dev);
  1622	
  1623	err_assert_rst:
  1624		reset_control_assert(master->core_rst);
  1625	
  1626		return ret;
  1627	}
  1628	EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
  1629	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

