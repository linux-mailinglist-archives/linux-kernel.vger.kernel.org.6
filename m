Return-Path: <linux-kernel+bounces-206829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2101900E5C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0466A282FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54A74E11;
	Fri,  7 Jun 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9UOmWtR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761914EB38;
	Fri,  7 Jun 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717802035; cv=none; b=F4+96QW8iZvylShbj80M3GHyl4WzOcLJTs4her3T2oh3S7sXRezlN6DTtNDyP+GB7YKF0xRL1IXP6imEhrFPfIAFCuBdKILUAeW4NQgpcJQGiV0ALv2ec6SKwLiwDNqbvwmMF+Gtry19A0IEjJp99TEV/ZYpbiLL+Kcx+arBIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717802035; c=relaxed/simple;
	bh=2q2MxS0PnAoB7ta6Xve9stwAf+iHBMYFHvuKsBomFdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubV4p4FAZbrJ9Y9YAztTjPK0LXH6EByXgY2Ja3N6wov0b8ImA483s71xb5STzN+AaGaJmWIm47C+thl1OJxmsNqGyytIA8eQVUpmk3kWJJ3u6h3ccWowJ7Pb+As3KjvNukgSxarsSxLadr8lPnrYbFu10rHZOn+mzKCLcXLjct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9UOmWtR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717802033; x=1749338033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2q2MxS0PnAoB7ta6Xve9stwAf+iHBMYFHvuKsBomFdo=;
  b=U9UOmWtRjtg/fPW4q397VyAU8O54g5GmBLaIZpEzV4QJtY+xKrJ5W+q3
   f5ZaKIowPMzD00/K3sq+soh3si6JowkfyZ0nYylkkakVzCZCoRdkAIjxe
   99qg7tYRpwgPWRrBrK+l/YLRsfK/RozMNUxmP8nazKTtq54+9gXzYjD+U
   lOaaqrcj6+xjeVFsy1QcBxzpkDMuNWqkvZf3jGIceE6UrGsOkI34IedKK
   mRRz9YkraxIBuR87tFNEpSGQpi9M/3B3ljJJauM46l/3KKGfW2sJ/SQw/
   UX5eGAyN7QoP55o3Yq69nXZ1q5RHkAsr5+hueBtFz19Q3bbPaZZ5xdwCJ
   Q==;
X-CSE-ConnectionGUID: XgxktWHkQvCTH/NzAvGoeg==
X-CSE-MsgGUID: I4JLj3aQQRWBWjOJfxOvvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14779161"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14779161"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 16:13:53 -0700
X-CSE-ConnectionGUID: gS9eduv5R+2Zina7itibXA==
X-CSE-MsgGUID: huPaYgdESsWna5lAxNy27Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75957644"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Jun 2024 16:13:50 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFimK-0000g2-0A;
	Fri, 07 Jun 2024 23:13:48 +0000
Date: Sat, 8 Jun 2024 07:13:47 +0800
From: kernel test robot <lkp@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: convert tas571x.txt to dt-schema
Message-ID: <202406080603.d9mWzFV2-lkp@intel.com>
References: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>

Hi Neil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3f38fa61af77b49866b006939479069cd451173]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/ASoC-dt-bindings-convert-tas571x-txt-to-dt-schema/20240607-175726
base:   c3f38fa61af77b49866b006939479069cd451173
patch link:    https://lore.kernel.org/r/20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1%40linaro.org
patch subject: [PATCH] ASoC: dt-bindings: convert tas571x.txt to dt-schema
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce: (https://download.01.org/0day-ci/archive/20240608/202406080603.d9mWzFV2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406080603.d9mWzFV2-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:263.22-266.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@3: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:268.22-273.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@4: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:275.24-278.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@5: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:280.22-283.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@6: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:285.22-288.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@7: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:290.29-293.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@8: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:305.11-309.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:311.11-315.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@1: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts:71.10-75.5: Warning (unit_address_vs_reg): /spdif-out/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts:82.10-86.5: Warning (unit_address_vs_reg): /comp-spdif-out/port@0: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: audio-codec@1d: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/ti,tas57xx.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: /soc@0/smpctrl@59801000: failed to match any schema with compatible: ['socionext,uniphier-smpctrl']
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: comp-spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:396.22-399.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@3: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:401.22-406.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@4: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:408.24-411.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@5: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:413.22-416.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@6: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:418.22-421.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@7: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:423.29-426.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@8: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:438.11-442.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:444.11-448.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@1: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts:71.10-75.5: Warning (unit_address_vs_reg): /spdif-out/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts:82.10-86.5: Warning (unit_address_vs_reg): /comp-spdif-out/port@0: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: audio-codec@1b: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/ti,tas57xx.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: /soc@0/smpctrl@59801000: failed to match any schema with compatible: ['socionext,uniphier-smpctrl']
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: /soc@0/usb@65a00000: failed to match any schema with compatible: ['socionext,uniphier-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: comp-spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

