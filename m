Return-Path: <linux-kernel+bounces-207599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D4901982
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16544281BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02D7482;
	Mon, 10 Jun 2024 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tso34vRF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39B3C0C;
	Mon, 10 Jun 2024 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717988979; cv=none; b=V/tj1Nb0wQMFZgJOQZaWLmyck6y/3S4C8c2e+OMzdu47QvkMYzLh+C1pW2iL4b5gqUbEDqlWvT1TWjPR9nD/m3OZh99U3/Dwq84HsNv2feQzSeDx+XUAPs2a0GBf+ocFAUKZx9xXZ/i77+J6hhGzEfXQ7TzuAjxt1KdjvvDaOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717988979; c=relaxed/simple;
	bh=Wj11lGYu3WhMhBwkounnR1AUHlkuhFRRPVG9yWN6Bms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLmwx+sw5vd07brpNAuc35+cHtluXwXir3Tctqj3Ga5VexcxskUAXbjsz2x00yTONKZlvwKgBDxBa4D3xI9IS2E3+flGh4wQQbRpP0+n32AXEzjUqy8lar6E4mm0vQIGQzCz8nwGh6WLh6hMRrBw80tB3S9kFkQPoNllLASlRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tso34vRF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717988977; x=1749524977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wj11lGYu3WhMhBwkounnR1AUHlkuhFRRPVG9yWN6Bms=;
  b=Tso34vRFDCsjnG1D7j9dczPUYkwaB09cIzsHlvk0ZcFHD0qHrmiPxTtX
   /+fr1kpVrq9rpRCyVSY3YF+WWYF9KJhniSl6Yq6O12lXuarld4rYg2xHW
   z2UpE+tH6r0l7PXbXqo6pYAmHnXS+asEyDP1QrPqV1xYJeCXk6mN478AZ
   ve4uNQXElc7lBmESrbqUMj4hV6JaUn48adSSx9379Oa9jUeLb5vXCUeAc
   UOOIe48lFuI88vjXkT6EiqvydJcy+0luYntr2ASHMiN84af0KglqcLLc4
   cph/KO/xUnpATeu45HcIr911OIDFwjtbuXd/0xMookwvwSVvRmoTnPlg8
   w==;
X-CSE-ConnectionGUID: A2GS6remTDCx8lvD0WT3zg==
X-CSE-MsgGUID: L6I7MHU0Tyqn0RrqGzNh2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14813717"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="14813717"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 20:09:36 -0700
X-CSE-ConnectionGUID: DOrcTPmaQCSduc8ZxamjnQ==
X-CSE-MsgGUID: uO0dE4BRQO204xwXNkATKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="38844834"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2024 20:09:34 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGVPY-0001nu-0F;
	Mon, 10 Jun 2024 03:09:32 +0000
Date: Mon, 10 Jun 2024 11:09:04 +0800
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
Message-ID: <202406101035.nanF90LS-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240610/202406101035.nanF90LS-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406101035.nanF90LS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406101035.nanF90LS-lkp@intel.com/

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

