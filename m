Return-Path: <linux-kernel+bounces-554769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCAA59C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990F9188CE42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F023236E;
	Mon, 10 Mar 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctmerySW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19506230BD5;
	Mon, 10 Mar 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626664; cv=none; b=qDAPqs1JX10vlAxnDdM9C2Z6Sy8C9V/K/u6m2PUO+jb2U+2rCSV9rlqk6kxTumY97SLJvWQvjBMNYkc15n/wC+bUIRcEjfRrp34X2Y8nOIQhHCG0VOdPOArHvTMFRUrPLVqAmIR7UZ3tUgI644KzKlQljiDr03gW0NRQY4dGozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626664; c=relaxed/simple;
	bh=voNjo21o3BJ1yoO1GHLS+0pcetuEukpGtYife/kyYB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmGJ/6biqPPF8NUV2Mp7OHegWLXuouw2DQiYyqqPa1FwTgR3rg8D81Q6VxjdhxtqdExTXXHFhVdHU82nBon349+wS+77xHkbjOChdEvwkBB7XLc/iI4dhSaRf46abwEJ06GNB04lv80nFg0u/B2Qt1oxXqKqqtM1HaSlBI0VV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctmerySW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741626663; x=1773162663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=voNjo21o3BJ1yoO1GHLS+0pcetuEukpGtYife/kyYB8=;
  b=ctmerySWfqAOXNCtX/1QgqLRv/JJ2q1M2AdIop2VcxyskJjVE7ADTbgA
   wj4ShXt2hTS7Rq3HMFChprnBVkY2QN5WEXFIaJ2BytbjRvDto0QOiurUW
   G5F2DZTXCl1rPCy+nIkOoGwYdx4GnBgXfEYTFklVsVRJpBlu4PhWFm/n4
   FHGMCmjieYGyjowfOwlKqkNxAfM+IXORkZ8Pv1yXSA9QCT4uzmKgSaS++
   xCzX/668lDzmuGFvabn5HJKz50jBuuVXlHQ4V8lLM+PFeIYMyjJFa46LY
   PPf7BXZiEQt+2TlMHUhIKxl3R/EuaKrdKtjoIXZPkvhQ165qZTba+NJpS
   Q==;
X-CSE-ConnectionGUID: ETqQ2FItReCItU23gBHlqA==
X-CSE-MsgGUID: zgTfJ9d3TcKUPIAa62W1FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="45427063"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="45427063"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:11:02 -0700
X-CSE-ConnectionGUID: rcALvII3SWuG40FzH3koiw==
X-CSE-MsgGUID: ZncTHJjsQEyr2ybwv6q34A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120070023"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 10:10:59 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trgeT-0004W8-1G;
	Mon, 10 Mar 2025 17:10:54 +0000
Date: Tue, 11 Mar 2025 01:10:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/4] clk: meson: a1: add the audio clock controller
 driver
Message-ID: <202503110016.L1KdYGVj-lkp@intel.com>
References: <20250309180940.1322531-4-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309180940.1322531-4-jan.dakinevich@salutedevices.com>

Hi Jan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next krzk/for-next krzk-dt/for-next linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Dakinevich/clk-meson-axg-share-the-set-of-audio-helper-macros/20250310-022012
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250309180940.1322531-4-jan.dakinevich%40salutedevices.com
patch subject: [PATCH v6 3/4] clk: meson: a1: add the audio clock controller driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250311/202503110016.L1KdYGVj-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503110016.L1KdYGVj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503110016.L1KdYGVj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/meson/a1-audio.c:807:11: error: call to undeclared function '__devm_auxiliary_device_create'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     807 |         auxdev = __devm_auxiliary_device_create(dev, dev->driver->name,
         |                  ^
   drivers/clk/meson/a1-audio.c:807:11: note: did you mean '__auxiliary_device_add'?
   include/linux/auxiliary_bus.h:221:5: note: '__auxiliary_device_add' declared here
     221 | int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
         |     ^
>> drivers/clk/meson/a1-audio.c:807:9: error: incompatible integer to pointer conversion assigning to 'struct auxiliary_device *' from 'int' [-Wint-conversion]
     807 |         auxdev = __devm_auxiliary_device_create(dev, dev->driver->name,
         |                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     808 |                                                 data->rst_drvname, NULL, 0);
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/__devm_auxiliary_device_create +807 drivers/clk/meson/a1-audio.c

   748	
   749	static int a1_audio_clkc_probe(struct platform_device *pdev)
   750	{
   751		struct device *dev = &pdev->dev;
   752		const struct a1_audio_data *data;
   753		struct auxiliary_device *auxdev;
   754		struct regmap *map;
   755		void __iomem *base;
   756		struct clk *clk;
   757		unsigned int i;
   758		int ret;
   759	
   760		data = device_get_match_data(dev);
   761		if (!data)
   762			return -EINVAL;
   763	
   764		clk = devm_clk_get_enabled(dev, "pclk");
   765		if (IS_ERR(clk))
   766			return PTR_ERR(clk);
   767	
   768		base = devm_platform_ioremap_resource(pdev, 0);
   769		if (IS_ERR(base))
   770			return PTR_ERR(base);
   771	
   772		map = devm_regmap_init_mmio(dev, base, &a1_audio_regmap_cfg);
   773		if (IS_ERR(map))
   774			return PTR_ERR(map);
   775	
   776		ret = device_reset(dev);
   777		if (ret)
   778			return ret;
   779	
   780		for (i = 0; i < data->hw_clks.num; i++) {
   781			struct clk_hw *hw = data->hw_clks.hws[i];
   782			struct clk_regmap *clk_regmap = to_clk_regmap(hw);
   783	
   784			if (!hw)
   785				continue;
   786	
   787			clk_regmap->map = map;
   788		}
   789	
   790		for (i = 0; i < data->hw_clks.num; i++) {
   791			struct clk_hw *hw;
   792	
   793			hw = data->hw_clks.hws[i];
   794			if (!hw)
   795				continue;
   796	
   797			ret = devm_clk_hw_register(dev, hw);
   798			if (ret)
   799				return ret;
   800		}
   801	
   802		ret = devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
   803						  (void *)&data->hw_clks);
   804		if (ret)
   805			return ret;
   806	
 > 807		auxdev = __devm_auxiliary_device_create(dev, dev->driver->name,
   808							data->rst_drvname, NULL, 0);
   809		if (!auxdev)
   810			return -ENODEV;
   811	
   812		return 0;
   813	}
   814	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

