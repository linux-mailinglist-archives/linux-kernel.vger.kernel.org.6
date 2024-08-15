Return-Path: <linux-kernel+bounces-287490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01597952856
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265E41C2118A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC134545;
	Thu, 15 Aug 2024 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZOL7tqd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC442032A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693077; cv=none; b=UztKi3AlSwXBd0+bqKqrYU1rWA8P7qXebfeO92mjzNvVcTYcrBVB4Zlxu475NteCSLaWA9F+lLZcX6DYMvGp5msz9t52k56ZdtYYfnEMivrReq5fv1XaC9ao9tYPKKE2vPUU/CIg1wsnieLJ+Q76oJ509Alz2RCkIuvQqUOB3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693077; c=relaxed/simple;
	bh=RUsSzefQLL5RIfWA58S2AELi2vV5CEh7fOcoNvMJO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrGVZ79L9guZxCUpUPAqKN6KVy5EgDFKNX9JLeCFqV+4tMznd8iGpJqwHLT4A0A2jaA6BlrCZgsBUUFvOeiNfhg4tReSe4FKkXudS4WBtEaQoBbUY+eCQe6xxpELizXrRQo/LT060jpgDrC89o8Cmg+GfuXaqOsQy1XXsO9fPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZOL7tqd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723693076; x=1755229076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RUsSzefQLL5RIfWA58S2AELi2vV5CEh7fOcoNvMJO0k=;
  b=mZOL7tqdo+8aeXk7U6dzxrMPCztC2sfFAzffsVTXoDFwSfDQAQvav+/5
   kUZ3ggMGbqrqDszvlzdG5GVPLkndvMCUmGsdDRbfjFU50OpyQwI0Gilqd
   s13s3D/45pM9LS7meF8NQq1ZqqxBVpL/Adve7eOQ6TQFr5b8Q4GN5qchN
   zfWHUNvRGpZxKZEBitVhnRj+Rsbqv65ACJxQeAw8oHHF9Z1uOP4o7BWZN
   pjRIUDATOTdRh0JVivb4K+t8RhHz6/9A+BxzyGjwBEOKoV+77rB1UxKcM
   UiAhFB1Mw9eRogMiMIal6HCfFUN+Pp6A5HPWh+i/JYUHfMjkel+12TViG
   A==;
X-CSE-ConnectionGUID: WVeGYdDbQwizl7s8+Q5Vug==
X-CSE-MsgGUID: 8zjVjANqTEK428TOMfmZBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21585524"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21585524"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 20:37:55 -0700
X-CSE-ConnectionGUID: RmMIUmLJTZO8j0qFQEYi3Q==
X-CSE-MsgGUID: /DMoub1oTq29BheBM+yWCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59208691"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Aug 2024 20:37:53 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seRJ9-00038w-0O;
	Thu, 15 Aug 2024 03:37:51 +0000
Date: Thu, 15 Aug 2024 11:37:05 +0800
From: kernel test robot <lkp@intel.com>
To: Shanker Donthineni <sdonthineni@nvidia.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
Message-ID: <202408151138.JtTxkiQ6-lkp@intel.com>
References: <20240813033925.925947-1-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813033925.925947-1-sdonthineni@nvidia.com>

Hi Shanker,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/irq/core soc/for-next linus/master v6.11-rc3 next-20240814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/irqchip-gic-v3-Allow-unused-SGIs-for-drivers-modules/20240814-221122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240813033925.925947-1-sdonthineni%40nvidia.com
patch subject: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
config: arm-randconfig-004-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151138.JtTxkiQ6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151138.JtTxkiQ6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151138.JtTxkiQ6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3.c: In function 'gic_irq_domain_translate':
>> drivers/irqchip/irq-gic-v3.c:1658:40: error: 'MAX_IPI' undeclared (first use in this function); did you mean 'MAX_INPUT'?
    1658 |                 if (fwspec->param[0] < MAX_IPI) {
         |                                        ^~~~~~~
         |                                        MAX_INPUT
   drivers/irqchip/irq-gic-v3.c:1658:40: note: each undeclared identifier is reported only once for each function it appears in


vim +1658 drivers/irqchip/irq-gic-v3.c

  1600	
  1601	static int gic_irq_domain_translate(struct irq_domain *d,
  1602					    struct irq_fwspec *fwspec,
  1603					    unsigned long *hwirq,
  1604					    unsigned int *type)
  1605	{
  1606		if (fwspec->param_count == 1 && fwspec->param[0] < 16) {
  1607			*hwirq = fwspec->param[0];
  1608			*type = IRQ_TYPE_EDGE_RISING;
  1609			return 0;
  1610		}
  1611	
  1612		if (is_of_node(fwspec->fwnode)) {
  1613			if (fwspec->param_count < 3)
  1614				return -EINVAL;
  1615	
  1616			switch (fwspec->param[0]) {
  1617			case 0:			/* SPI */
  1618				*hwirq = fwspec->param[1] + 32;
  1619				break;
  1620			case 1:			/* PPI */
  1621				*hwirq = fwspec->param[1] + 16;
  1622				break;
  1623			case 2:			/* ESPI */
  1624				*hwirq = fwspec->param[1] + ESPI_BASE_INTID;
  1625				break;
  1626			case 3:			/* EPPI */
  1627				*hwirq = fwspec->param[1] + EPPI_BASE_INTID;
  1628				break;
  1629			case GIC_IRQ_TYPE_LPI:	/* LPI */
  1630				*hwirq = fwspec->param[1];
  1631				break;
  1632			case GIC_IRQ_TYPE_PARTITION:
  1633				*hwirq = fwspec->param[1];
  1634				if (fwspec->param[1] >= 16)
  1635					*hwirq += EPPI_BASE_INTID - 16;
  1636				else
  1637					*hwirq += 16;
  1638				break;
  1639			default:
  1640				return -EINVAL;
  1641			}
  1642	
  1643			*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
  1644	
  1645			/*
  1646			 * Make it clear that broken DTs are... broken.
  1647			 * Partitioned PPIs are an unfortunate exception.
  1648			 */
  1649			WARN_ON(*type == IRQ_TYPE_NONE &&
  1650				fwspec->param[0] != GIC_IRQ_TYPE_PARTITION);
  1651			return 0;
  1652		}
  1653	
  1654		if (is_fwnode_irqchip(fwspec->fwnode)) {
  1655			if(fwspec->param_count != 2)
  1656				return -EINVAL;
  1657	
> 1658			if (fwspec->param[0] < MAX_IPI) {
  1659				pr_err(FW_BUG "Illegal GSI%d translation request\n",
  1660				       fwspec->param[0]);
  1661				return -EINVAL;
  1662			}
  1663	
  1664			*hwirq = fwspec->param[0];
  1665			*type = fwspec->param[1];
  1666	
  1667			WARN_ON(*type == IRQ_TYPE_NONE);
  1668			return 0;
  1669		}
  1670	
  1671		return -EINVAL;
  1672	}
  1673	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

