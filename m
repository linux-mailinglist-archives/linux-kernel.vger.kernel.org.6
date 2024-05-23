Return-Path: <linux-kernel+bounces-187395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D948CD132
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF81F28195B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360101474C2;
	Thu, 23 May 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfio/S6P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA01474A8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463535; cv=none; b=MQwp4SLdRWAeKNUV9Ty7HWNbYzYTXnCbBHnPuI/BrpsQFg24EoyiXsU0BaLIpT8JtbeNtHiaEsg9I613Cr7rUBj+eJ76tUeUWPRRdM+FmXU4VffQ3N1AJOo06p4KFaXrkcM2LEPjp8YTJGMkY7OwmA2XXfZXycKwiNlQe2WZ2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463535; c=relaxed/simple;
	bh=5d7gBEEtqgoJFSVtfgG8pmQVA8NzkEGPyrNimcZ2liU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJVpWgjfq9+dfYwMHbSYFH4bQIudgjU5zB59gM8PSCf+Jkb4ViFrusWnNC2NLOzkvWo89XQyXVlKSEDD8XbqHj+l4lNmMyn4U0ys4FT6Gxgf0YxEiAVTegaMNLUTcSvMSCnwoiiDbOdNxXWB/HOgcIXs5+tVdL6eGgaaTtz+5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfio/S6P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716463533; x=1747999533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5d7gBEEtqgoJFSVtfgG8pmQVA8NzkEGPyrNimcZ2liU=;
  b=jfio/S6PIcu9JkH3mDP0a7pPnmSd3miLMKaYgEp/ki03dSwt6RXbnF2b
   kYtra7HIcCxAe7j32thP/XAua8oFNOPGDPXKI8AMMI76OMMoQubNWpyGS
   M/xkVfJveqyMNGexrxwHyJhvyMFnCtx/sx/EoUqMqC2fMrwZMyejsIuFP
   DsMwhVP75tvbyyYpnvM4gZ5nbb6PCmKfQCgcEV6T14wpYKZX8yN9yFlKs
   +CqptCEOZgDJuYEKEbQQ4QlCjrhTTsl62uyjfRd+Jstr0QxFZmjiD1EpI
   Be4Dq+es/RoX9A+wo3jCikOh9mYiiHy9RFVUYIlpYcOL2onxolfFtJXDb
   Q==;
X-CSE-ConnectionGUID: xl9gTKsqQdGHN/T5I9AayQ==
X-CSE-MsgGUID: aylrbCHjSUy5DTIXBOpEbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="24180432"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="24180432"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 04:25:32 -0700
X-CSE-ConnectionGUID: 8ziTzgasTdCrAFe7Ed/iOA==
X-CSE-MsgGUID: YLt+ERgsR5mmtUZRDeKyWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="56870927"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 23 May 2024 04:25:30 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA6Zb-0002mn-37;
	Thu, 23 May 2024 11:25:27 +0000
Date: Thu, 23 May 2024 19:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
Message-ID: <202405231902.xK5xVGdb-lkp@intel.com>
References: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/spmi-pmic-arb-Pass-the-correct-of_node-to-irq_domain_add_tree/20240522-194023
base:   8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
patch link:    https://lore.kernel.org/r/20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804%40linaro.org
patch subject: [PATCH] spmi: pmic-arb: Pass the correct of_node to irq_domain_add_tree
config: arm64-randconfig-001-20240523 (https://download.01.org/0day-ci/archive/20240523/202405231902.xK5xVGdb-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231902.xK5xVGdb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405231902.xK5xVGdb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spmi/spmi-pmic-arb.c:1740:42: error: passing 'const struct irq_domain_ops' to parameter of incompatible type 'const struct irq_domain_ops *'; take the address with &
    1740 |         bus->domain = irq_domain_add_tree(node, pmic_arb_irq_domain_ops, bus);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                                 &
   include/linux/irqdomain.h:369:36: note: passing argument to parameter 'ops' here
     369 |                                          const struct irq_domain_ops *ops,
         |                                                                       ^
   1 error generated.


vim +1740 drivers/spmi/spmi-pmic-arb.c

  1663	
  1664	static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
  1665					  struct device_node *node,
  1666					  struct spmi_pmic_arb *pmic_arb)
  1667	{
  1668		int bus_index = pmic_arb->buses_available;
  1669		struct spmi_pmic_arb_bus *bus;
  1670		struct device *dev = &pdev->dev;
  1671		struct spmi_controller *ctrl;
  1672		void __iomem *intr;
  1673		void __iomem *cnfg;
  1674		int index, ret;
  1675		int irq;
  1676	
  1677		ctrl = devm_spmi_controller_alloc(dev, sizeof(*bus));
  1678		if (IS_ERR(ctrl))
  1679			return PTR_ERR(ctrl);
  1680	
  1681		ctrl->cmd = pmic_arb_cmd;
  1682		ctrl->read_cmd = pmic_arb_read_cmd;
  1683		ctrl->write_cmd = pmic_arb_write_cmd;
  1684	
  1685		bus = spmi_controller_get_drvdata(ctrl);
  1686	
  1687		pmic_arb->buses[bus_index] = bus;
  1688	
  1689		raw_spin_lock_init(&bus->lock);
  1690	
  1691		bus->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
  1692						 sizeof(*bus->ppid_to_apid),
  1693						 GFP_KERNEL);
  1694		if (!bus->ppid_to_apid)
  1695			return -ENOMEM;
  1696	
  1697		bus->apid_data = devm_kcalloc(dev, pmic_arb->max_periphs,
  1698					      sizeof(*bus->apid_data),
  1699					      GFP_KERNEL);
  1700		if (!bus->apid_data)
  1701			return -ENOMEM;
  1702	
  1703		index = of_property_match_string(node, "reg-names", "cnfg");
  1704		if (index < 0) {
  1705			dev_err(dev, "cnfg reg region missing");
  1706			return -EINVAL;
  1707		}
  1708	
  1709		cnfg = devm_of_iomap(dev, node, index, NULL);
  1710		if (IS_ERR(cnfg))
  1711			return PTR_ERR(cnfg);
  1712	
  1713		index = of_property_match_string(node, "reg-names", "intr");
  1714		if (index < 0) {
  1715			dev_err(dev, "intr reg region missing");
  1716			return -EINVAL;
  1717		}
  1718	
  1719		intr = devm_of_iomap(dev, node, index, NULL);
  1720		if (IS_ERR(intr))
  1721			return PTR_ERR(intr);
  1722	
  1723		irq = of_irq_get_byname(node, "periph_irq");
  1724		if (irq <= 0)
  1725			return irq ?: -ENXIO;
  1726	
  1727		bus->pmic_arb = pmic_arb;
  1728		bus->intr = intr;
  1729		bus->cnfg = cnfg;
  1730		bus->irq = irq;
  1731		bus->spmic = ctrl;
  1732		bus->id = bus_index;
  1733	
  1734		ret = pmic_arb->ver_ops->init_apid(bus, bus_index);
  1735		if (ret)
  1736			return ret;
  1737	
  1738		dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
  1739	
> 1740		bus->domain = irq_domain_add_tree(node, pmic_arb_irq_domain_ops, bus);
  1741		if (!bus->domain) {
  1742			dev_err(&pdev->dev, "unable to create irq_domain\n");
  1743			return -ENOMEM;
  1744		}
  1745	
  1746		irq_set_chained_handler_and_data(bus->irq,
  1747						 pmic_arb_chained_irq, bus);
  1748	
  1749		ctrl->dev.of_node = node;
  1750		dev_set_name(&ctrl->dev, "spmi-%d", bus_index);
  1751	
  1752		ret = devm_spmi_controller_add(dev, ctrl);
  1753		if (ret)
  1754			return ret;
  1755	
  1756		pmic_arb->buses_available++;
  1757	
  1758		return 0;
  1759	}
  1760	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

