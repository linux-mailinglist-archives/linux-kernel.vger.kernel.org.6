Return-Path: <linux-kernel+bounces-187320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29B8CD026
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C431F23611
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9322F13E3F9;
	Thu, 23 May 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKRxmt/e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0813CF85
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459586; cv=none; b=OaZXVI1r6EbpSalxcOFnSQcSFFVzT0HI5wOWtRoWUIsoeis/ohzBHa/x5IybgPzFPkLmYh6fXnI+ZYiKsKlJ1G23Xphd12s8T0Y5VyG/5FQzLW72B8bp3v8n1nbp+GuEDi1jPIMOjKKGkZsIwO9tTkpmNTcbphS4/Oy9EdsLX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459586; c=relaxed/simple;
	bh=N4LEMgC7ZouVgBmNHgbKIroD3zqM4XwKXUsvc7ER1Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9zx0miGxUSbgERSso8GKp/xufpLXujDOgNowRnmEJRjVx9juK0gR8yzvxoCPfpivSppenlhijuvY+UPyrUoMHDpLjvG8kVt8aRalArij6gmgmLCZ6JDs98W746/J9NKWOVicMxYUuZYIVk+mxZbptq0wJ7V+dR3nROBcvCNSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKRxmt/e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716459584; x=1747995584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4LEMgC7ZouVgBmNHgbKIroD3zqM4XwKXUsvc7ER1Zc=;
  b=oKRxmt/eM4TcHL7BzUh5b1eZUlSelmBd/6H48IbP1MEFUbT6D/H2Amrc
   5Rg1Xuk+P9PUqjNUXLieyz4tHplOsQsgh+4Qdqsg4clrmgAl5vtfsjz/R
   thBpd1i/uM8s/C3aPoxkZnYsE6z+ZWnrmSLZ2nRSN9sm0er0mWWOFkT/z
   Ok2YBRXi0JqjU3Q6mRrQY/UusqmhgBKoJjvWPmDx7XmcBHz/DOdepZFor
   F2zWY9Kfil/Z90wgpqBGeyWQuoZtSufVJHW4U7E8h/qEYi+vLcemNsTcn
   WOke3MwuZrnfWo+fq3jpuwcula7oJGtsyit4ZDp45A91cVzDB8AVAJ10u
   w==;
X-CSE-ConnectionGUID: FjlgNtaLS8GtCQ22w4Ii2g==
X-CSE-MsgGUID: rUI0LgMlRRSEPexETHI65Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16555082"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="16555082"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:19:44 -0700
X-CSE-ConnectionGUID: LxSOPhMoThm4T6BxahFjBg==
X-CSE-MsgGUID: Dr8/8z2ZSOabTu1S86sDgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38450817"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 May 2024 03:19:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA5Xq-0002il-26;
	Thu, 23 May 2024 10:19:37 +0000
Date: Thu, 23 May 2024 18:19:02 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
Message-ID: <202405231834.Xi3hn3rT-lkp@intel.com>
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
config: arm-randconfig-002-20240523 (https://download.01.org/0day-ci/archive/20240523/202405231834.Xi3hn3rT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231834.Xi3hn3rT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405231834.Xi3hn3rT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spmi/spmi-pmic-arb.c: In function 'spmi_pmic_arb_bus_init':
>> drivers/spmi/spmi-pmic-arb.c:1740:49: error: incompatible type for argument 2 of 'irq_domain_add_tree'
    1740 |         bus->domain = irq_domain_add_tree(node, pmic_arb_irq_domain_ops, bus);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 struct irq_domain_ops
   In file included from drivers/spmi/spmi-pmic-arb.c:11:
   include/linux/irqdomain.h:369:71: note: expected 'const struct irq_domain_ops *' but argument is of type 'struct irq_domain_ops'
     369 |                                          const struct irq_domain_ops *ops,
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +/irq_domain_add_tree +1740 drivers/spmi/spmi-pmic-arb.c

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

