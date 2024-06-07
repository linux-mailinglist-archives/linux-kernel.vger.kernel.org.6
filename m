Return-Path: <linux-kernel+bounces-205588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA618FFDD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5757C1C232B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBB915ADB4;
	Fri,  7 Jun 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eftwMiAl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F115ADA3;
	Fri,  7 Jun 2024 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747877; cv=none; b=P1YzF1ZBsoTcvhDWiiqzYLI79Scu97Xok+z38pN2HE/3JH6P+ks+qJffk2usgjoMwtcxZsF/X6DN5vfUown/x8Kmq+mj04MkIdCmVYGlHgQHLgoWbqYzBoTAao/iW9lWEiK6DgFer+Nxe+5TYxlQNWw7VOiF3vSS2dnypqnYBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747877; c=relaxed/simple;
	bh=BjHvlPpsf1JuNh8voewB5kjC1cJt74iMWbnPuF3HdpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNwWXm3Fad7B9kZ+VjjIZ3ZiCT4QTrcnWxzdeDTLw1WOCYGli4i3hRIWXnntn3W58jNy2p1KfhbW2sUtGjbGUcJgayW81SliEY9+l6ojTvIUjIQ39pKyZJgfLlINYAT8Wl9KbNUrhDnJ9EZGi/sfvc7q9MPQhatLE3YAfkTZuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eftwMiAl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717747874; x=1749283874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BjHvlPpsf1JuNh8voewB5kjC1cJt74iMWbnPuF3HdpY=;
  b=eftwMiAlE+t6gMWr6LCZsJiwTgLfU99ZMiuh/QzkOpdB4lyJF+cId7SI
   FCyKjM3bMIUtcxxRCXyU3i6kx5fNxZqOuB/Jfb+kMJv+2iFwkAT4FS56x
   X8gwbOfOy+dhBj9klOAg2baEArDOIdNtIFh4h3FQe01/XkC7SzgbgWFoe
   HodiXj/B/qfivtQ4SrvweRB023rxVMFON6W1cIcVqU7OZYIOEn/5cv5A2
   vYy/u2GN+Yli5Dp1decumSy/P4Wse+RSl6HBo7yc2eflKv2P7OLmRWece
   pPZ688i0T67npMmskJIAQz3kJ/ShKemaYdFwfCPRgCNMs0jjqCoE1MSOj
   A==;
X-CSE-ConnectionGUID: Rzx1xobmROq98wE6FKfg1w==
X-CSE-MsgGUID: 5jZMsFoSQE65Zj7mqp/Rlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14614616"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14614616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 01:11:14 -0700
X-CSE-ConnectionGUID: Yo/IX92zTnuTcmNSHjv5bA==
X-CSE-MsgGUID: frMbXn5QSte5GkD02fumGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="43185517"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 07 Jun 2024 01:11:10 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFUgm-0004F4-08;
	Fri, 07 Jun 2024 08:11:08 +0000
Date: Fri, 7 Jun 2024 16:10:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hewitt <christianshewitt@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: add initial support for Dreambox
 One/Two
Message-ID: <202406071527.fnfhnkUL-lkp@intel.com>
References: <20240606094513.3949323-3-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606094513.3949323-3-christianshewitt@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk/for-next linus/master v6.10-rc2 next-20240606]
[cannot apply to krzk-dt/for-next krzk-mem-ctrl/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/dt-bindings-arm-amlogic-add-support-for-Dreambox-One-Two/20240606-175427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240606094513.3949323-3-christianshewitt%40gmail.com
patch subject: [PATCH 3/3] arm64: dts: meson: add initial support for Dreambox One/Two
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce: (https://download.01.org/0day-ci/archive/20240607/202406071527.fnfhnkUL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071527.fnfhnkUL-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
     also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
     also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
     also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: /soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any schema with compatible: ['amlogic,g12a-audio-clkc']
   arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: /soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any schema with compatible: ['amlogic,g12a-tohdmitx']
>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
--
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
     also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
     also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
     also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: /soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any schema with compatible: ['amlogic,g12a-audio-clkc']
   arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: /soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any schema with compatible: ['amlogic,g12a-tohdmitx']
>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

