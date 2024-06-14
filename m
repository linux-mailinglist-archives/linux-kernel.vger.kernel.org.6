Return-Path: <linux-kernel+bounces-215399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47190922D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB53B282E88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24619DF47;
	Fri, 14 Jun 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEW7y6MH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA51854;
	Fri, 14 Jun 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389220; cv=none; b=KJg0pSwR+BqBDBkuYwD7BHNkieDmO7vf41FlfmXFTjvGXsRA0PFhYy01zQRAAdIo0AY9dL+ps4GcQWkQGZmsRFQjM/kpDd3GAMggPuJZrV09/WGDngKyyyYsEqSfviC73HZEGktUukSg/tvD8hjNGqaq1GXYGyQguOtregC31FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389220; c=relaxed/simple;
	bh=loCV41uufcUxVbIBke73AHmqNwkG7/6xmqlzylzRWQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyvWJYeOuodwSvw1OdJUzVxcaznTLQ1OluUTUsmQuHSQXPrzTWLeTVkDn1VF31mae8vEA2rtb/jag4Tju/jbpd3VIZNnAkt+HvsmfFdP6znXzX1RjNj72JEzaWb5jwy1YhYFvUXoP+774GH0NW1z1lrZoepuDmceOBqNB0yf7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEW7y6MH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718389219; x=1749925219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=loCV41uufcUxVbIBke73AHmqNwkG7/6xmqlzylzRWQI=;
  b=KEW7y6MHvboZ4e7wDyesUi+EqHtMXb/z8KeA/g/r0O04caj/AEj5p6VD
   UOlAuQg58nD+U4KORikOc1ZgKs/gccGd9C7En/c1LOVWTMoYqNe/EdT50
   MXHgNBJfhv7xfdKHoZlwITvLwtBe4LFpbubkE+g41Cdbe3S66nNr1Kzvv
   vs4qfkmRBjBK60LXLUFwgBKqoS/vzNa7vRyl0cdWCmmC7V8X97gZhBQ1P
   3Q8DXgFG+sr0iTJ+4u80+44k2PAojoeftrosyzSMFG7fUmkqiUmwGXXgR
   s4L5IfF78gu/KyxYHfBK9OnWv7HZR1KNhbwiUWgZ8oIHIjttCUACjf6tV
   Q==;
X-CSE-ConnectionGUID: /mGVgu4mSH+JURRMm1hYHg==
X-CSE-MsgGUID: jsPITykcQA+fvcNi5mUwQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32833274"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="32833274"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:20:18 -0700
X-CSE-ConnectionGUID: NgrLhIalQlyBtIDbxfhV8Q==
X-CSE-MsgGUID: 3GUQ2JlbS8Wb5b0qMHyZFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="41253636"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Jun 2024 11:20:14 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIBX2-0001dD-2B;
	Fri, 14 Jun 2024 18:20:12 +0000
Date: Sat, 15 Jun 2024 02:20:00 +0800
From: kernel test robot <lkp@intel.com>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: realtek,rt5514: Convert to
 dtschema
Message-ID: <202406150259.fFugFRJx-lkp@intel.com>
References: <20240614033812.51312-2-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614033812.51312-2-animeshagarwal28@gmail.com>

Hi Animesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Animesh-Agarwal/ASoC-dt-bindings-realtek-rt5514-Convert-to-dtschema/20240614-114128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240614033812.51312-2-animeshagarwal28%40gmail.com
patch subject: [PATCH 1/2] ASoC: dt-bindings: realtek,rt5514: Convert to dtschema
config: arm64-randconfig-051-20240614 (https://download.01.org/0day-ci/archive/20240615/202406150259.fFugFRJx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406150259.fFugFRJx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406150259.fFugFRJx-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: pcie@0,0: wifi@0,0:interrupts:0:0: 8 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: pcie@0,0: wifi@0,0:interrupts:0: [8, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: usb@fe900000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
>> arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: spi2@0: 'spi-max-frequency', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5514.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /ppvar-bigcpu: failed to match any schema with compatible: ['vctrl-regulator']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /ppvar-litcpu: failed to match any schema with compatible: ['vctrl-regulator']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /ppvar-gpu: failed to match any schema with compatible: ['vctrl-regulator']
--
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: pcie@0,0: wifi@0,0:interrupts:0:0: 8 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: pcie@0,0: wifi@0,0:interrupts:0: [8, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: usb@fe900000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
>> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: spi2@0: 'spi-max-frequency', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5514.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /ppvar-bigcpu: failed to match any schema with compatible: ['vctrl-regulator']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /ppvar-litcpu: failed to match any schema with compatible: ['vctrl-regulator']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /ppvar-gpu: failed to match any schema with compatible: ['vctrl-regulator']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

