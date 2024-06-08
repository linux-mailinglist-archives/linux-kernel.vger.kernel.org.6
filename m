Return-Path: <linux-kernel+bounces-206855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F8900EDE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04881F22507
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC74F441F;
	Sat,  8 Jun 2024 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSJfp6gd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812C7F;
	Sat,  8 Jun 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717806360; cv=none; b=F/lSEhAtonviz0sfYG8xArq5aQd+R6qFI1tr1YiLoIIxo3KUvl3Zu4x6lswSe1+Fips7xHVfzGrbKHRBJI9PftXE5sMTxInKd/YMHuNqKDoUoJaLYptyIOEol4xG0VjbcQIeWp5ikqjl/qgv3o/n7A9lFiM6b/wOXaWPOdHHYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717806360; c=relaxed/simple;
	bh=o+bfSGIhSKcrsC0aVSNfuzKPiL+TuK12bReoBYVOmR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0KQiHFusRNCuKegOOK+HJMaBAK+kedpzQjunVJBItwX/MKolkYtZPRrptFS8JEutNSoYtItPBOhzRFF4dKwxKssgwbqbFsz2q63qS4VDa5jnN5zWl76LTgyzzccZkbkISLq6o1OUX9FfvJyAdInyJfKQxDWRZzSFB4KDFbiVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSJfp6gd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717806357; x=1749342357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+bfSGIhSKcrsC0aVSNfuzKPiL+TuK12bReoBYVOmR8=;
  b=mSJfp6gdTrDmYNyhNQKBoe/YcfcB7WZAUyfAp+npBJP+d8VI7whjkECm
   XL73JC11LIgyMBb4aiQEjf4Cid8GO4SKMz0hdz0TKfJ8NN6vJNaiWxKQi
   Ur7e4HBmGpp8KnarliuOx7SzfA9SmW3hqXI4npF8n2Ac42fomvGyH4/sq
   GEYj7RqeQ9j6+hLWhYRAXlZHnM1EFadl9eRITb2jQoCrzHh/E9iVxUFIH
   5lGrQ0dHncbHF5iwpLrN83HcGttMXLDDSVL0FDW4i0bnHk/QRo/VxsPUl
   5I2cYP5c2e6wL8nAa6Q214501pUedfzEnsCFJRkr8YheVZN1enyFw9nFP
   w==;
X-CSE-ConnectionGUID: h+MM+yEDT7+KvSc2x7t3nw==
X-CSE-MsgGUID: 6mZXMSYzRceor1f6mdb6tQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14349934"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14349934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 17:25:57 -0700
X-CSE-ConnectionGUID: R7ES9qkiRXyZJ+GfK8IsXg==
X-CSE-MsgGUID: +1lnDy8KQDOFOV2Yo+PYqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38582912"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2024 17:25:54 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFju3-0000l0-2w;
	Sat, 08 Jun 2024 00:25:51 +0000
Date: Sat, 8 Jun 2024 08:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5,
 related memory region
Message-ID: <202406081020.qpqcI5FG-lkp@intel.com>
References: <20240605202703.1220203-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605202703.1220203-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/arm64-dts-imx8dxl-evk-add-imx8dxl_cm4-lsio-mu5-related-memory-region/20240606-043044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20240605202703.1220203-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5, related memory region
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081020.qpqcI5FG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081020.qpqcI5FG-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/freescale/imx8dxl-evk.dts:93.33-97.5: Warning (unit_address_vs_reg): /reserved-memory/memory-vdevbuffer: node has a reg or ranges property, but no unit name

vim +93 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts

     9	
    10	/ {
    11		model = "Freescale i.MX8DXL EVK";
    12		compatible = "fsl,imx8dxl-evk", "fsl,imx8dxl";
    13	
    14		aliases {
    15			i2c2 = &i2c2;
    16			mmc0 = &usdhc1;
    17			mmc1 = &usdhc2;
    18			serial0 = &lpuart0;
    19			serial1 = &lpuart1;
    20			serial6 = &cm40_lpuart;
    21		};
    22	
    23		chosen {
    24			stdout-path = &lpuart0;
    25		};
    26	
    27		imx8dxl-cm4 {
    28			compatible = "fsl,imx8qxp-cm4";
    29			clocks = <&clk_dummy>;
    30			mbox-names = "tx", "rx", "rxdb";
    31			mboxes = <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
    32			memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
    33					<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
    34			power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
    35			fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
    36			fsl,entry-address = <0x34fe0000>;
    37		};
    38	
    39	
    40		memory@80000000 {
    41			device_type = "memory";
    42			reg = <0x00000000 0x80000000 0 0x40000000>;
    43		};
    44	
    45		reserved-memory {
    46			#address-cells = <2>;
    47			#size-cells = <2>;
    48			ranges;
    49	
    50			/*
    51			 * Memory reserved for optee usage. Please do not use.
    52			 * This will be automatically added to dtb if OP-TEE is installed.
    53			 * optee@96000000 {
    54			 *     reg = <0 0x96000000 0 0x2000000>;
    55			 *     no-map;
    56			 * };
    57			 */
    58	
    59			/* global autoconfigured region for contiguous allocations */
    60			linux,cma {
    61				compatible = "shared-dma-pool";
    62				reusable;
    63				size = <0 0x14000000>;
    64				alloc-ranges = <0 0x98000000 0 0x14000000>;
    65				linux,cma-default;
    66			};
    67	
    68			vdev0vring0: memory0@90000000 {
    69				reg = <0 0x90000000 0 0x8000>;
    70				no-map;
    71			};
    72	
    73			vdev0vring1: memory@90008000 {
    74				reg = <0 0x90008000 0 0x8000>;
    75				no-map;
    76			};
    77	
    78			vdev1vring0: memory@90010000 {
    79				reg = <0 0x90010000 0 0x8000>;
    80				no-map;
    81			};
    82	
    83			vdev1vring1: memory@90018000 {
    84				reg = <0 0x90018000 0 0x8000>;
    85				no-map;
    86			};
    87	
    88			rsc_table: memory-rsc-table@900ff000 {
    89				reg = <0 0x900ff000 0 0x1000>;
    90				no-map;
    91			};
    92	
  > 93			vdevbuffer: memory-vdevbuffer {
    94				compatible = "shared-dma-pool";
    95				reg = <0 0x90400000 0 0x100000>;
    96				no-map;
    97			};
    98		};
    99	
   100		m2_uart1_sel: regulator-m2uart1sel {
   101			compatible = "regulator-fixed";
   102			regulator-min-microvolt = <3300000>;
   103			regulator-max-microvolt = <3300000>;
   104			regulator-name = "m2_uart1_sel";
   105			gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
   106			enable-active-high;
   107			regulator-always-on;
   108		};
   109	
   110		mux3_en: regulator-0 {
   111			compatible = "regulator-fixed";
   112			regulator-min-microvolt = <3300000>;
   113			regulator-max-microvolt = <3300000>;
   114			regulator-name = "mux3_en";
   115			gpio = <&pca6416_2 8 GPIO_ACTIVE_LOW>;
   116			regulator-always-on;
   117		};
   118	
   119		reg_fec1_sel: regulator-1 {
   120			compatible = "regulator-fixed";
   121			regulator-name = "fec1_supply";
   122			regulator-min-microvolt = <3300000>;
   123			regulator-max-microvolt = <3300000>;
   124			gpio = <&pca6416_1 11 GPIO_ACTIVE_LOW>;
   125			regulator-always-on;
   126			status = "disabled";
   127		};
   128	
   129		reg_fec1_io: regulator-2 {
   130			compatible = "regulator-fixed";
   131			regulator-name = "fec1_io_supply";
   132			regulator-min-microvolt = <1800000>;
   133			regulator-max-microvolt = <1800000>;
   134			gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
   135			enable-active-high;
   136			regulator-always-on;
   137			status = "disabled";
   138		};
   139	
   140		reg_can0_stby: regulator-4 {
   141			compatible = "regulator-fixed";
   142			regulator-name = "can0-stby";
   143			regulator-min-microvolt = <3300000>;
   144			regulator-max-microvolt = <3300000>;
   145			gpio = <&pca6416_3 0 GPIO_ACTIVE_HIGH>;
   146			enable-active-high;
   147		};
   148	
   149		reg_can1_stby: regulator-5 {
   150			compatible = "regulator-fixed";
   151			regulator-name = "can1-stby";
   152			regulator-min-microvolt = <3300000>;
   153			regulator-max-microvolt = <3300000>;
   154			gpio = <&pca6416_3 1 GPIO_ACTIVE_HIGH>;
   155			enable-active-high;
   156		};
   157	
   158		reg_usdhc2_vmmc: regulator-3 {
   159			compatible = "regulator-fixed";
   160			regulator-name = "SD1_SPWR";
   161			regulator-min-microvolt = <3000000>;
   162			regulator-max-microvolt = <3000000>;
   163			gpio = <&lsio_gpio4 30 GPIO_ACTIVE_HIGH>;
   164			enable-active-high;
   165			off-on-delay-us = <3480>;
   166		};
   167	
   168		reg_vref_1v8: regulator-adc-vref {
   169			compatible = "regulator-fixed";
   170			regulator-name = "vref_1v8";
   171			regulator-min-microvolt = <1800000>;
   172			regulator-max-microvolt = <1800000>;
   173		};
   174	
   175		mii_select: regulator-4 {
   176			compatible = "regulator-fixed";
   177			regulator-name = "mii-select";
   178			regulator-min-microvolt = <3300000>;
   179			regulator-max-microvolt = <3300000>;
   180			gpio = <&scu_gpio 6 GPIO_ACTIVE_HIGH>;
   181			enable-active-high;
   182			regulator-always-on;
   183		};
   184	
   185		bt_sco_codec: audio-codec-bt {
   186			compatible = "linux,bt-sco";
   187			#sound-dai-cells = <1>;
   188		};
   189	
   190		sound-bt-sco {
   191			compatible = "simple-audio-card";
   192			simple-audio-card,name = "bt-sco-audio";
   193			simple-audio-card,format = "dsp_a";
   194			simple-audio-card,bitclock-inversion;
   195			simple-audio-card,frame-master = <&btcpu>;
   196			simple-audio-card,bitclock-master = <&btcpu>;
   197	
   198			btcpu: simple-audio-card,cpu {
   199				sound-dai = <&sai0>;
   200				dai-tdm-slot-num = <2>;
   201				dai-tdm-slot-width = <16>;
   202			};
   203	
   204			simple-audio-card,codec {
   205				sound-dai = <&bt_sco_codec 1>;
   206			};
   207		};
   208	
   209		sound-wm8960-1 {
   210			compatible = "fsl,imx-audio-wm8960";
   211			model = "wm8960-audio";
   212			audio-cpu = <&sai1>;
   213			audio-codec = <&wm8960_1>;
   214			audio-asrc = <&asrc0>;
   215			audio-routing = "Headphone Jack", "HP_L",
   216					"Headphone Jack", "HP_R",
   217					"Ext Spk", "SPK_LP",
   218					"Ext Spk", "SPK_LN",
   219					"Ext Spk", "SPK_RP",
   220					"Ext Spk", "SPK_RN",
   221					"LINPUT1", "Mic Jack",
   222					"Mic Jack", "MICB";
   223		};
   224	
   225		sound-wm8960-2 {
   226			compatible = "fsl,imx-audio-wm8960";
   227			model = "wm8960-audio-2";
   228			audio-cpu = <&sai2>;
   229			audio-codec = <&wm8960_2>;
   230			audio-routing = "Headphone Jack", "HP_L",
   231					"Headphone Jack", "HP_R",
   232					"Ext Spk", "SPK_LP",
   233					"Ext Spk", "SPK_LN",
   234					"Ext Spk", "SPK_RP",
   235					"Ext Spk", "SPK_RN",
   236					"LINPUT1", "Mic Jack",
   237					"Mic Jack", "MICB";
   238		};
   239	
   240		sound-wm8960-3 {
   241			compatible = "fsl,imx-audio-wm8960";
   242			model = "wm8960-audio-3";
   243			audio-cpu = <&sai3>;
   244			audio-codec = <&wm8960_3>;
   245			audio-routing = "Headphone Jack", "HP_L",
   246					"Headphone Jack", "HP_R",
   247					"Ext Spk", "SPK_LP",
   248					"Ext Spk", "SPK_LN",
   249					"Ext Spk", "SPK_RP",
   250					"Ext Spk", "SPK_RN",
   251					"LINPUT1", "Mic Jack",
   252					"Mic Jack", "MICB";
   253		};
   254	};
   255	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

