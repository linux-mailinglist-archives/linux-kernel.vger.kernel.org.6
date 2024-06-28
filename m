Return-Path: <linux-kernel+bounces-233911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57391BF33
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE571C21ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7B1BE25D;
	Fri, 28 Jun 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6nRYzvj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EC194C67;
	Fri, 28 Jun 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580027; cv=none; b=AIDNVTvubl7ZhGNDi3IB4sh+gSkGJoTseNik60lv3XTOUo7wzQm0hv1TZ7diuzzAyRLRc3M99KyzSwIrNelezyDLw42hjVJRMbVp37+Y7Pnq40yL+MmauUYccYy8ajcsM6XLjp/W/1T6s6SRnwz1n0/k0alCw/AJ7dgV46Ja+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580027; c=relaxed/simple;
	bh=qWEehPSVEYKhPzyWJRgf6X298EwczVbvcUE/LXyT/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTBmMWwmziGj2VnB7fU1Xid8RAlWzFlyQeYYAK3FnnD9KkAKayVUJLdygFh7sHy7aCK8gQlO6q1r/ThQdVnVodEK31zkiU/ftPXK85cxpBysMoLfMa5uPMi8b2uwaLfCXpQiMm2l21kFCamPzkMyM/X/5rhlX0AoOed1hTyoqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6nRYzvj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719580025; x=1751116025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWEehPSVEYKhPzyWJRgf6X298EwczVbvcUE/LXyT/GI=;
  b=f6nRYzvjLHGihGzxGR27WgfHx8kw/rWRqqySD7WcS7L1q98PXBJQo1yA
   8eCT1UGxQ29OFzwt0ZRVBXX+epuSRMnwj7VRddN49s3Up5JdIuMsmntgb
   G57D0+jB0wMWo/KJ02XF0cUuTI9xly+KujYYEy5XkpM4WjDQlzYkLn7S3
   5S6RzbMDN+4Hamz8ST7lWUUEzrA8HxaOxZCZYhUhxR5RNxE/h2wjciuC1
   1BO75lT91HoW20Yeva//qQokQh74knQ4YZm1AGJSTd6A+XgdpOLbCUDOE
   GBX4tGAkCLGiMX22HLJYqXsybQdXauaxbl5KHWAGe9KcRrvKZxZD6E/Y7
   A==;
X-CSE-ConnectionGUID: +h3YyPi1RnSC1fPxNjhTvQ==
X-CSE-MsgGUID: KATHcaE3Q/qgiOgLYDE1IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16892492"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16892492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 06:07:04 -0700
X-CSE-ConnectionGUID: jTneSz1ORgig3jYbLChAEg==
X-CSE-MsgGUID: oJGYvT0HTLKjr8IzXshXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75470390"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jun 2024 06:07:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNBJb-000H7i-3D;
	Fri, 28 Jun 2024 13:06:59 +0000
Date: Fri, 28 Jun 2024 21:06:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Liu <net147@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Liu <net147@gmail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable RK809 audio codec for Radxa
 ROCK 4C+
Message-ID: <202406282049.ZRM6qCDn-lkp@intel.com>
References: <20240621130903.2572986-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621130903.2572986-1-net147@gmail.com>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on krzk/for-next krzk-dt/for-next linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Liu/arm64-dts-rockchip-Enable-RK809-audio-codec-for-Radxa-ROCK-4C/20240625-210156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20240621130903.2572986-1-net147%40gmail.com
patch subject: [PATCH] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+
config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406282049.ZRM6qCDn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev3+g650bf2d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406282049.ZRM6qCDn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406282049.ZRM6qCDn-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('snps,txpbl' was unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
>> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic@20: '#sound-dai-cells', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: regulator@40: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: regulator@41: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic: vsel1-gpio: {'rockchip,pins': [[1, 17, 0, 194]], 'phandle': [[138]]} is not of type 'array'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

