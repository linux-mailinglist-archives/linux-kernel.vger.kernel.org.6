Return-Path: <linux-kernel+bounces-287503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754A952887
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F201F236D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD741C65;
	Thu, 15 Aug 2024 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgDYT1fr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B413A8CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696200; cv=none; b=P9o5BBOxmrUjvcEFVijuxNlP3oE6IRaqT8OEWSV+CmmA2Ti9frOYmpL8ietH3z3ofmD2iCHr7aVM3wEG6VHnD5HLS//w/Vb7lQBbqvjFSKqLJSrqUoDxSnJr29R4IJaRKD/3HtIofsSQtq3hbRcnipcGKkUxLt6Bg3ErZr9jvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696200; c=relaxed/simple;
	bh=CPDaoJ64MA8oja2aEn10Ppdbuz5HP6TspRNHi2lAS8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKipdBsVPq77nNCD4PLfmaetnDWuvJH4lv1Kh4FvEVPSF7VrFG6zYH0eQqES1xFWNG3mPW54POxul8KQs1cvXjnsCZ4cpFR143/CY/cjOS7iS073yviWweBukKNIFiDfBUTXebIcemxY92gmBuB9I0Sb3RkeBhzE6QWkymRVRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgDYT1fr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723696198; x=1755232198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CPDaoJ64MA8oja2aEn10Ppdbuz5HP6TspRNHi2lAS8U=;
  b=hgDYT1fr1T05W9cUARm1ANfiIJOtOSwaUgnk1rGyaTbDb9K9iYq91Y8P
   RouP3PW9PqG/WkFg6zpM+R2DjYCCk9JoweaetX013hJX66Ng9DTJ7EToQ
   CFJ2/rgIu4+KAwIF+7VO31N/b30f/fgyquywHfLPUadfPb/pCBE/+Zt65
   4utqTgeKUbXMQsblTggxigSelyuKMHbiuIRX/D2SmKNvv/0d8sJNo74ZI
   jOh56MGultrFne11KzNhsCWra9VQaWOHf7Uk2H+dcEiLCm54fNqWbVDd/
   jcs0bPqKCfKb1tlCULNts+SolVkTVt6aZc+Bk/szpDxVXHB13Jyfqpa+e
   g==;
X-CSE-ConnectionGUID: ZLE3Ct3ESxaIPEogNKMtnA==
X-CSE-MsgGUID: GrpSdhlRTxKGNWxMxlNpZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22092480"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="22092480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:29:58 -0700
X-CSE-ConnectionGUID: LoD3C6ZFSrWtdm3hdSgkOg==
X-CSE-MsgGUID: s3Oumv5gQ420Qx5fMd49xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="63394766"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Aug 2024 21:29:55 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seS7U-0003Bu-2y;
	Thu, 15 Aug 2024 04:29:52 +0000
Date: Thu, 15 Aug 2024 12:29:40 +0800
From: kernel test robot <lkp@intel.com>
To: Shanker Donthineni <sdonthineni@nvidia.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
Message-ID: <202408151208.vuvL1AtV-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240815/202408151208.vuvL1AtV-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151208.vuvL1AtV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151208.vuvL1AtV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-gic-v3.c:1658:26: error: use of undeclared identifier 'MAX_IPI'
                   if (fwspec->param[0] < MAX_IPI) {
                                          ^
   1 error generated.


vim +/MAX_IPI +1658 drivers/irqchip/irq-gic-v3.c

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

