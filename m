Return-Path: <linux-kernel+bounces-314944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC796BB42
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FC82812C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970701D221F;
	Wed,  4 Sep 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW/jHjbm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622611D2224;
	Wed,  4 Sep 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450677; cv=none; b=Bt8ia0Re9hU+DIU3jPwPlZlX1KBExLiEC/DRFYNQgiM7D+F3lywzY6vHVVQfZSUiEJVKh80NUAFoFnONrMYOPWmob8d3NM/GqrwXVDp0bW7Wl7A7EAbqLFYNXoJLpiGhG7pz/q+M+TVmf21MXqDD+CRci7mOs4JcZ72VaNwRShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450677; c=relaxed/simple;
	bh=mhvDv83fUvlG0cQcDPPbM7mplZGVm4T7Ax6vDiwUhj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX3zajQ725sA7HpZBN3W1ecIXCXKPtLow8OhQwJgoqGJDn9aLJbRRVCQQMMyM8A5PXeaPXJD6TfMdae0MG+TjebJq0n9yw/mdky9emjEMamaY1BgnC+DZHYDXtXXO5g1KRIUfv+CJZDWweFSbSV0EUai7O0OLa9K5LujauX+vR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iW/jHjbm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725450675; x=1756986675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mhvDv83fUvlG0cQcDPPbM7mplZGVm4T7Ax6vDiwUhj4=;
  b=iW/jHjbmjlOcdjYHoHMpWi9SSSy+zR2KNOikUHfhs7l9RpgS06xPp2No
   jBL0kWAtqf9BOb9/aue3RraIkGcLv0QpzES5I8LEUhUjoT0CeZ3sT8f3B
   tjVh7zkO/dZyWaqYrLITFeNasXgnk4uWKlldQcmobsW3wvvZPO2y0EB7S
   Ox45BzuEy0xyRrf0biGW5gx42P70jd3GQEoIIK6mu/oWjWIbD/zAXOlpz
   09qFyidlr+ct7e4JqVqTcC8s2evv8udIZEEqG5aCcjJkKZsjeoZa7nnSH
   7g1G2PVg96oJAill6CQuu/kIcwe+cKgYK5Hqyw3pPCWBZm6Lp10TYtXrl
   Q==;
X-CSE-ConnectionGUID: Un9MjzhsSGGCxMTRK8SwrA==
X-CSE-MsgGUID: upNfyBRxRCi1EKSODS/+Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35466288"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35466288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:51:14 -0700
X-CSE-ConnectionGUID: 18+KqW5IQcqJSNRThSKdLw==
X-CSE-MsgGUID: CpGFRzsKQFyyGQGoWy5zNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="95976479"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Sep 2024 04:51:11 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sloXU-0007vj-2R;
	Wed, 04 Sep 2024 11:51:08 +0000
Date: Wed, 4 Sep 2024 19:50:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Bruel <christian.bruel@foss.st.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com,
	Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v5 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
Message-ID: <202409041913.v0xzfcJ2-lkp@intel.com>
References: <20240903121303.2953150-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903121303.2953150-3-christian.bruel@foss.st.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on robh/for-next linus/master v6.11-rc6 next-20240904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Bruel/dt-bindings-phy-Add-STM32MP25-COMBOPHY-bindings/20240903-201737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20240903121303.2953150-3-christian.bruel%40foss.st.com
patch subject: [PATCH v5 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240904/202409041913.v0xzfcJ2-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409041913.v0xzfcJ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409041913.v0xzfcJ2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/phy/st/phy-stm32-combophy.c:524:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     524 |                 return ret;
         |                        ^~~
   drivers/phy/st/phy-stm32-combophy.c:509:9: note: initialize the variable 'ret' to silence this warning
     509 |         int ret, irq;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +524 drivers/phy/st/phy-stm32-combophy.c

   503	
   504	static int stm32_combophy_probe(struct platform_device *pdev)
   505	{
   506		struct stm32_combophy *combophy;
   507		struct device *dev = &pdev->dev;
   508		struct phy_provider *phy_provider;
   509		int ret, irq;
   510	
   511		combophy = devm_kzalloc(dev, sizeof(*combophy), GFP_KERNEL);
   512		if (!combophy)
   513			return -ENOMEM;
   514	
   515		combophy->dev = dev;
   516	
   517		dev_set_drvdata(dev, combophy);
   518	
   519		combophy->base = devm_platform_ioremap_resource(pdev, 0);
   520		if (IS_ERR(combophy->base))
   521			return PTR_ERR(combophy->base);
   522	
   523		if (stm32_combophy_get_clocks(combophy))
 > 524			return ret;
   525	
   526		combophy->phy_reset = devm_reset_control_get(dev, "phy");
   527		if (IS_ERR(combophy->phy_reset))
   528			return dev_err_probe(dev, PTR_ERR(combophy->phy_reset),
   529					     "Failed to get PHY reset\n");
   530	
   531		combophy->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
   532		if (IS_ERR(combophy->regmap))
   533			return dev_err_probe(dev, PTR_ERR(combophy->regmap),
   534					     "No syscfg specified\n");
   535	
   536		combophy->phy = devm_phy_create(dev, NULL, &stm32_combophy_phy_data);
   537		if (IS_ERR(combophy->phy))
   538			return dev_err_probe(dev, PTR_ERR(combophy->phy),
   539					     "failed to create PCIe/USB3 ComboPHY\n");
   540	
   541		if (device_property_read_bool(dev, "wakeup-source")) {
   542			irq = platform_get_irq(pdev, 0);
   543			if (irq < 0)
   544				return dev_err_probe(dev, irq, "failed to get IRQ\n");
   545			combophy->irq_wakeup = irq;
   546	
   547			ret = devm_request_threaded_irq(dev, combophy->irq_wakeup, NULL,
   548							stm32_combophy_irq_wakeup_handler, IRQF_ONESHOT,
   549							NULL, NULL);
   550			if (ret)
   551				return dev_err_probe(dev, ret, "unable to request wake IRQ %d\n",
   552							 combophy->irq_wakeup);
   553		}
   554	
   555		ret = devm_pm_runtime_enable(dev);
   556		if (ret)
   557			return dev_err_probe(dev, ret, "Failed to enable pm runtime\n");
   558	
   559		phy_set_drvdata(combophy->phy, combophy);
   560	
   561		phy_provider = devm_of_phy_provider_register(dev, stm32_combophy_xlate);
   562	
   563		return PTR_ERR_OR_ZERO(phy_provider);
   564	}
   565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

