Return-Path: <linux-kernel+bounces-373160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B47B9A5315
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC761C20D22
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF357823DD;
	Sun, 20 Oct 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwG69csA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C080BEC
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729412310; cv=none; b=TsexZFUKi+SQ0IsfmDIlQPOvLszUxOUTRdvHhbqtK1/fsY4jtDwjyKYmkRBsk5FkNyoR1TMrITZiUWoe2UNxESkZFPwTcTNe1DNdYxyFmg1JfD+m/VEAqgT0qADevBNsJPifEQ7tSabXdGUf5SL8B+C45vHq+j76ko2cGFIRDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729412310; c=relaxed/simple;
	bh=3NzxkVGrO7pPIUNKeNwCxXAscAC8AJ361OHZMCTFBgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/CMU74ELf3LmDqM8jmREpH/BKtXkbehbGoPmpn+r3d/DS8N7UhwuQail3b9V1R77hAgn5gullg5HxvgiAC/FArhGEQRIy66GtdcVfsBSlownCpjeelcCuXMtteFUYPRw96bpOfxIOONesagrVEMf+3w8FjNxvehqqDDxoj4mTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwG69csA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729412308; x=1760948308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3NzxkVGrO7pPIUNKeNwCxXAscAC8AJ361OHZMCTFBgU=;
  b=jwG69csAZYFxzhFjCHZLnanszC2kRqWdoQOxRZhRKzFJ5W6is9/r+zjN
   2zm15/JPNvlioe9TVkQ2HZGGWNOG7LT0uCWP6sIA2eGLiDOp6YWQtUsxH
   4ay9EXFhkswyQZWC27Ybv2AdSb2hz9fIMZpQb+3qdyZnm3R37QwWbI0u+
   GM1VFo0NfW0QKYNkXMKt/O9X1bs16UhICrrFG/+jARIgsbGBBpjuxCWcl
   ckjXyYhShnk8guOcZmkOb31vzoZYgAzR0stPtB8QJMsL/xUwrDlPvZBXB
   /qtsMfjUdWM6h3aP2Bm9/pwea3y+FQPcaV0a2fOT/HPe3eaFZftyX26Ti
   A==;
X-CSE-ConnectionGUID: mIBQtQCaRXCLs6n12bmpIA==
X-CSE-MsgGUID: q4D/EWqvTlCRVExnj7yFQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="28361619"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="28361619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 01:18:27 -0700
X-CSE-ConnectionGUID: KjTrDEsfSZWMY1QYC8/Ysg==
X-CSE-MsgGUID: 8ZXgqKwxRHyt13se9GOPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="116712262"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Oct 2024 01:18:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2R8o-000Q4f-2B;
	Sun, 20 Oct 2024 08:18:22 +0000
Date: Sun, 20 Oct 2024 16:17:59 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Sanket.Goswami@amd.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH 3/6] i3c: master: Add ACPI support to i3c subsystem
Message-ID: <202410201553.RtPfO9pR-lkp@intel.com>
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
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241020/202410201553.RtPfO9pR-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201553.RtPfO9pR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201553.RtPfO9pR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/i3c/master/dw-i3c-master.c: In function 'dw_i3c_common_probe':
   drivers/i3c/master/dw-i3c-master.c:1606:32: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_fwnode_handle'? [-Wimplicit-function-declaration]
    1606 |         master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
         |                                ^~~~~~~~~~~~~~~~~~
         |                                acpi_fwnode_handle
>> drivers/i3c/master/dw-i3c-master.c:1606:30: error: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1606 |         master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
         |                              ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


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

