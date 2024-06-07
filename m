Return-Path: <linux-kernel+bounces-206345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D67900830
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B36528EE23
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BDB19B5A8;
	Fri,  7 Jun 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg/RNT3d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6419B588
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772586; cv=none; b=C+EOoDfXvNsg7OTKZsFaQMp0XxuoepfH6tXptM1uHYtZmXAqydb9iJTY5uM7L9v4oIcf76jAZT1kGUr1Xlw0R5WKz91XlaismlIJvMfxPynmwbGjU2X5AuuUv7GqBR84yDbPLj7Km9vrkowCRD0w8YKWj2ttHk4IoqtDySMmfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772586; c=relaxed/simple;
	bh=YGM8+3KuJ+zh/edD2xC5qy7bOzKiD0fgj36ARbE70MI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/Mttc1pr3Cm/3jMQ6fWBjnchRv/ZoE9a+Kp17CvZp0x24ckZvw133HBpHnQnu4nRMShcGEFMiw3zQr5RwAQHHgqxdRGXrZv5KrPYWegX7FeyZCA3Hww3NVm02soTktJ17y98S39aD9RO10y4qbkGlK6xCNi1dfGKFeqVJv16jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg/RNT3d; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717772584; x=1749308584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YGM8+3KuJ+zh/edD2xC5qy7bOzKiD0fgj36ARbE70MI=;
  b=Zg/RNT3ded68XbXZKEeW8rRGRaRWENFf1WdrEgC7WWVTizSlAGQb0otM
   NjvtKPvwmYg1/6KvgdhyRjqc7NKg/063Sa3IwUEpOViMT0CTGapx0TXGr
   /8hZUJxKqwGuUVi5Yb3cn51tlbRGn+hAHFJ+VHaXB2JEBBjX1Enn6QJEh
   B/KQSE/MXlHL+zN2kdMVzFc4A/PMmwnO3kChl/bRjhNLE7dy3rpUnPLmP
   iWt0wVLHlJFY6b+MBLI6I2/8Z+4CNE44xZeBsXLVyFHVMVdgzMU4xiQOR
   ybVzTO6UjGPyySsrdS5QRluldcPAmfdhNMWPKspi3/GHN7MPMYdnaXfKj
   w==;
X-CSE-ConnectionGUID: 1pSMf3sERnu/s8nQzIFWzw==
X-CSE-MsgGUID: CzS6uFgvQOe9gwQeLDnUMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18351967"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18351967"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:03:03 -0700
X-CSE-ConnectionGUID: DKfz199ASJe9moCeWrhgUg==
X-CSE-MsgGUID: KzmciF7hTFeyFWErr2UGZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38196913"
Received: from lkp-server01.sh.intel.com (HELO b4d3d4be9bbf) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Jun 2024 08:03:02 -0700
Received: from kbuild by b4d3d4be9bbf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFb7M-000017-0C;
	Fri, 07 Jun 2024 15:03:00 +0000
Date: Fri, 7 Jun 2024 23:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: arch/arm64/boot/dts/renesas/r9a07g054.dtsi:647.12-655.7: Warning
 (graph_child_address): /soc/video@10830000/ports/port@0: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Message-ID: <202406072242.9uUQPGXc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a92980606e3585d72d510a03b59906e96755b8a
commit: a3c95a54727a81a4f3bd65b05c2e8542b2821ec3 arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
date:   1 year, 1 month ago
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072242.9uUQPGXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072242.9uUQPGXc-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/renesas/r9a07g054.dtsi:647.12-655.7: Warning (graph_child_address): /soc/video@10830000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r9a07g054.dtsi:657.12-666.7: Warning (graph_child_address): /soc/video@10830000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r9a07g054.dtsi:692.12-701.7: Warning (graph_child_address): /soc/csi2@10830400/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary

vim +647 arch/arm64/boot/dts/renesas/r9a07g054.dtsi

    10	
    11	/ {
    12		compatible = "renesas,r9a07g054";
    13		#address-cells = <2>;
    14		#size-cells = <2>;
    15	
    16		audio_clk1: audio1-clk {
    17			compatible = "fixed-clock";
    18			#clock-cells = <0>;
    19			/* This value must be overridden by boards that provide it */
    20			clock-frequency = <0>;
    21		};
    22	
    23		audio_clk2: audio2-clk {
    24			compatible = "fixed-clock";
    25			#clock-cells = <0>;
    26			/* This value must be overridden by boards that provide it */
    27			clock-frequency = <0>;
    28		};
    29	
    30		/* External CAN clock - to be overridden by boards that provide it */
    31		can_clk: can-clk {
    32			compatible = "fixed-clock";
    33			#clock-cells = <0>;
    34			clock-frequency = <0>;
    35		};
    36	
    37		/* clock can be either from exclk or crystal oscillator (XIN/XOUT) */
    38		extal_clk: extal-clk {
    39			compatible = "fixed-clock";
    40			#clock-cells = <0>;
    41			/* This value must be overridden by the board */
    42			clock-frequency = <0>;
    43		};
    44	
    45		cluster0_opp: opp-table-0 {
    46			compatible = "operating-points-v2";
    47			opp-shared;
    48	
    49			opp-150000000 {
    50				opp-hz = /bits/ 64 <150000000>;
    51				opp-microvolt = <1100000>;
    52				clock-latency-ns = <300000>;
    53			};
    54			opp-300000000 {
    55				opp-hz = /bits/ 64 <300000000>;
    56				opp-microvolt = <1100000>;
    57				clock-latency-ns = <300000>;
    58			};
    59			opp-600000000 {
    60				opp-hz = /bits/ 64 <600000000>;
    61				opp-microvolt = <1100000>;
    62				clock-latency-ns = <300000>;
    63			};
    64			opp-1200000000 {
    65				opp-hz = /bits/ 64 <1200000000>;
    66				opp-microvolt = <1100000>;
    67				clock-latency-ns = <300000>;
    68				opp-suspend;
    69			};
    70		};
    71	
    72		cpus {
    73			#address-cells = <1>;
    74			#size-cells = <0>;
    75	
    76			cpu-map {
    77				cluster0 {
    78					core0 {
    79						cpu = <&cpu0>;
    80					};
    81					core1 {
    82						cpu = <&cpu1>;
    83					};
    84				};
    85			};
    86	
    87			cpu0: cpu@0 {
    88				compatible = "arm,cortex-a55";
    89				reg = <0>;
    90				device_type = "cpu";
    91				#cooling-cells = <2>;
    92				next-level-cache = <&L3_CA55>;
    93				enable-method = "psci";
    94				clocks = <&cpg CPG_CORE R9A07G054_CLK_I>;
    95				operating-points-v2 = <&cluster0_opp>;
    96			};
    97	
    98			cpu1: cpu@100 {
    99				compatible = "arm,cortex-a55";
   100				reg = <0x100>;
   101				device_type = "cpu";
   102				next-level-cache = <&L3_CA55>;
   103				enable-method = "psci";
   104				clocks = <&cpg CPG_CORE R9A07G054_CLK_I>;
   105				operating-points-v2 = <&cluster0_opp>;
   106			};
   107	
   108			L3_CA55: cache-controller-0 {
   109				compatible = "cache";
   110				cache-unified;
   111				cache-size = <0x40000>;
   112				cache-level = <3>;
   113			};
   114		};
   115	
   116		gpu_opp_table: opp-table-1 {
   117			compatible = "operating-points-v2";
   118	
   119			opp-500000000 {
   120				opp-hz = /bits/ 64 <500000000>;
   121				opp-microvolt = <1100000>;
   122			};
   123	
   124			opp-400000000 {
   125				opp-hz = /bits/ 64 <400000000>;
   126				opp-microvolt = <1100000>;
   127			};
   128	
   129			opp-250000000 {
   130				opp-hz = /bits/ 64 <250000000>;
   131				opp-microvolt = <1100000>;
   132			};
   133	
   134			opp-200000000 {
   135				opp-hz = /bits/ 64 <200000000>;
   136				opp-microvolt = <1100000>;
   137			};
   138	
   139			opp-125000000 {
   140				opp-hz = /bits/ 64 <125000000>;
   141				opp-microvolt = <1100000>;
   142			};
   143	
   144			opp-100000000 {
   145				opp-hz = /bits/ 64 <100000000>;
   146				opp-microvolt = <1100000>;
   147			};
   148	
   149			opp-62500000 {
   150				opp-hz = /bits/ 64 <62500000>;
   151				opp-microvolt = <1100000>;
   152			};
   153	
   154			opp-50000000 {
   155				opp-hz = /bits/ 64 <50000000>;
   156				opp-microvolt = <1100000>;
   157			};
   158		};
   159	
   160		pmu {
   161			compatible = "arm,cortex-a55-pmu";
   162			interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
   163		};
   164	
   165		psci {
   166			compatible = "arm,psci-1.0", "arm,psci-0.2";
   167			method = "smc";
   168		};
   169	
   170		soc: soc {
   171			compatible = "simple-bus";
   172			interrupt-parent = <&gic>;
   173			#address-cells = <2>;
   174			#size-cells = <2>;
   175			ranges;
   176	
   177			ssi0: ssi@10049c00 {
   178				compatible = "renesas,r9a07g054-ssi",
   179					     "renesas,rz-ssi";
   180				reg = <0 0x10049c00 0 0x400>;
   181				interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
   182					     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
   183					     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
   184				interrupt-names = "int_req", "dma_rx", "dma_tx";
   185				clocks = <&cpg CPG_MOD R9A07G054_SSI0_PCLK2>,
   186					 <&cpg CPG_MOD R9A07G054_SSI0_PCLK_SFR>,
   187					 <&audio_clk1>, <&audio_clk2>;
   188				clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
   189				resets = <&cpg R9A07G054_SSI0_RST_M2_REG>;
   190				dmas = <&dmac 0x2655>, <&dmac 0x2656>;
   191				dma-names = "tx", "rx";
   192				power-domains = <&cpg>;
   193				#sound-dai-cells = <0>;
   194				status = "disabled";
   195			};
   196	
   197			ssi1: ssi@1004a000 {
   198				compatible = "renesas,r9a07g054-ssi",
   199					     "renesas,rz-ssi";
   200				reg = <0 0x1004a000 0 0x400>;
   201				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
   202					     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
   203					     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>;
   204				interrupt-names = "int_req", "dma_rx", "dma_tx";
   205				clocks = <&cpg CPG_MOD R9A07G054_SSI1_PCLK2>,
   206					 <&cpg CPG_MOD R9A07G054_SSI1_PCLK_SFR>,
   207					 <&audio_clk1>, <&audio_clk2>;
   208				clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
   209				resets = <&cpg R9A07G054_SSI1_RST_M2_REG>;
   210				dmas = <&dmac 0x2659>, <&dmac 0x265a>;
   211				dma-names = "tx", "rx";
   212				power-domains = <&cpg>;
   213				#sound-dai-cells = <0>;
   214				status = "disabled";
   215			};
   216	
   217			ssi2: ssi@1004a400 {
   218				compatible = "renesas,r9a07g054-ssi",
   219					     "renesas,rz-ssi";
   220				reg = <0 0x1004a400 0 0x400>;
   221				interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
   222					     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
   223				interrupt-names = "int_req", "dma_rt";
   224				clocks = <&cpg CPG_MOD R9A07G054_SSI2_PCLK2>,
   225					 <&cpg CPG_MOD R9A07G054_SSI2_PCLK_SFR>,
   226					 <&audio_clk1>, <&audio_clk2>;
   227				clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
   228				resets = <&cpg R9A07G054_SSI2_RST_M2_REG>;
   229				dmas = <&dmac 0x265f>;
   230				dma-names = "rt";
   231				power-domains = <&cpg>;
   232				#sound-dai-cells = <0>;
   233				status = "disabled";
   234			};
   235	
   236			ssi3: ssi@1004a800 {
   237				compatible = "renesas,r9a07g054-ssi",
   238					     "renesas,rz-ssi";
   239				reg = <0 0x1004a800 0 0x400>;
   240				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
   241					     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
   242					     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
   243				interrupt-names = "int_req", "dma_rx", "dma_tx";
   244				clocks = <&cpg CPG_MOD R9A07G054_SSI3_PCLK2>,
   245					 <&cpg CPG_MOD R9A07G054_SSI3_PCLK_SFR>,
   246					 <&audio_clk1>, <&audio_clk2>;
   247				clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
   248				resets = <&cpg R9A07G054_SSI3_RST_M2_REG>;
   249				dmas = <&dmac 0x2661>, <&dmac 0x2662>;
   250				dma-names = "tx", "rx";
   251				power-domains = <&cpg>;
   252				#sound-dai-cells = <0>;
   253				status = "disabled";
   254			};
   255	
   256			spi0: spi@1004ac00 {
   257				compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
   258				reg = <0 0x1004ac00 0 0x400>;
   259				interrupts = <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
   260					     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
   261					     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
   262				interrupt-names = "error", "rx", "tx";
   263				clocks = <&cpg CPG_MOD R9A07G054_RSPI0_CLKB>;
   264				resets = <&cpg R9A07G054_RSPI0_RST>;
   265				dmas = <&dmac 0x2e95>, <&dmac 0x2e96>;
   266				dma-names = "tx", "rx";
   267				power-domains = <&cpg>;
   268				num-cs = <1>;
   269				#address-cells = <1>;
   270				#size-cells = <0>;
   271				status = "disabled";
   272			};
   273	
   274			spi1: spi@1004b000 {
   275				compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
   276				reg = <0 0x1004b000 0 0x400>;
   277				interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
   278					     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
   279					     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
   280				interrupt-names = "error", "rx", "tx";
   281				clocks = <&cpg CPG_MOD R9A07G054_RSPI1_CLKB>;
   282				resets = <&cpg R9A07G054_RSPI1_RST>;
   283				dmas = <&dmac 0x2e99>, <&dmac 0x2e9a>;
   284				dma-names = "tx", "rx";
   285				power-domains = <&cpg>;
   286				num-cs = <1>;
   287				#address-cells = <1>;
   288				#size-cells = <0>;
   289				status = "disabled";
   290			};
   291	
   292			spi2: spi@1004b400 {
   293				compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
   294				reg = <0 0x1004b400 0 0x400>;
   295				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
   296					     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
   297					     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
   298				interrupt-names = "error", "rx", "tx";
   299				clocks = <&cpg CPG_MOD R9A07G054_RSPI2_CLKB>;
   300				resets = <&cpg R9A07G054_RSPI2_RST>;
   301				dmas = <&dmac 0x2e9d>, <&dmac 0x2e9e>;
   302				dma-names = "tx", "rx";
   303				power-domains = <&cpg>;
   304				num-cs = <1>;
   305				#address-cells = <1>;
   306				#size-cells = <0>;
   307				status = "disabled";
   308			};
   309	
   310			scif0: serial@1004b800 {
   311				compatible = "renesas,scif-r9a07g054",
   312					     "renesas,scif-r9a07g044";
   313				reg = <0 0x1004b800 0 0x400>;
   314				interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
   315					     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
   316					     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
   317					     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
   318					     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
   319					     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
   320				interrupt-names = "eri", "rxi", "txi",
   321						  "bri", "dri", "tei";
   322				clocks = <&cpg CPG_MOD R9A07G054_SCIF0_CLK_PCK>;
   323				clock-names = "fck";
   324				power-domains = <&cpg>;
   325				resets = <&cpg R9A07G054_SCIF0_RST_SYSTEM_N>;
   326				status = "disabled";
   327			};
   328	
   329			scif1: serial@1004bc00 {
   330				compatible = "renesas,scif-r9a07g054",
   331					     "renesas,scif-r9a07g044";
   332				reg = <0 0x1004bc00 0 0x400>;
   333				interrupts = <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
   334					     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
   335					     <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>,
   336					     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
   337					     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>,
   338					     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
   339				interrupt-names = "eri", "rxi", "txi",
   340						  "bri", "dri", "tei";
   341				clocks = <&cpg CPG_MOD R9A07G054_SCIF1_CLK_PCK>;
   342				clock-names = "fck";
   343				power-domains = <&cpg>;
   344				resets = <&cpg R9A07G054_SCIF1_RST_SYSTEM_N>;
   345				status = "disabled";
   346			};
   347	
   348			scif2: serial@1004c000 {
   349				compatible = "renesas,scif-r9a07g054",
   350					     "renesas,scif-r9a07g044";
   351				reg = <0 0x1004c000 0 0x400>;
   352				interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
   353					     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
   354					     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
   355					     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
   356					     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
   357					     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
   358				interrupt-names = "eri", "rxi", "txi",
   359						  "bri", "dri", "tei";
   360				clocks = <&cpg CPG_MOD R9A07G054_SCIF2_CLK_PCK>;
   361				clock-names = "fck";
   362				power-domains = <&cpg>;
   363				resets = <&cpg R9A07G054_SCIF2_RST_SYSTEM_N>;
   364				status = "disabled";
   365			};
   366	
   367			scif3: serial@1004c400 {
   368				compatible = "renesas,scif-r9a07g054",
   369					     "renesas,scif-r9a07g044";
   370				reg = <0 0x1004c400 0 0x400>;
   371				interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
   372					     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
   373					     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
   374					     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
   375					     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
   376					     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>;
   377				interrupt-names = "eri", "rxi", "txi",
   378						  "bri", "dri", "tei";
   379				clocks = <&cpg CPG_MOD R9A07G054_SCIF3_CLK_PCK>;
   380				clock-names = "fck";
   381				power-domains = <&cpg>;
   382				resets = <&cpg R9A07G054_SCIF3_RST_SYSTEM_N>;
   383				status = "disabled";
   384			};
   385	
   386			scif4: serial@1004c800 {
   387				compatible = "renesas,scif-r9a07g054",
   388					     "renesas,scif-r9a07g044";
   389				reg = <0 0x1004c800 0 0x400>;
   390				interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
   391					     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
   392					     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
   393					     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
   394					     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
   395					     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
   396				interrupt-names = "eri", "rxi", "txi",
   397						  "bri", "dri", "tei";
   398				clocks = <&cpg CPG_MOD R9A07G054_SCIF4_CLK_PCK>;
   399				clock-names = "fck";
   400				power-domains = <&cpg>;
   401				resets = <&cpg R9A07G054_SCIF4_RST_SYSTEM_N>;
   402				status = "disabled";
   403			};
   404	
   405			sci0: serial@1004d000 {
   406				compatible = "renesas,r9a07g054-sci", "renesas,sci";
   407				reg = <0 0x1004d000 0 0x400>;
   408				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
   409					     <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
   410					     <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
   411					     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
   412				interrupt-names = "eri", "rxi", "txi", "tei";
   413				clocks = <&cpg CPG_MOD R9A07G054_SCI0_CLKP>;
   414				clock-names = "fck";
   415				power-domains = <&cpg>;
   416				resets = <&cpg R9A07G054_SCI0_RST>;
   417				status = "disabled";
   418			};
   419	
   420			sci1: serial@1004d400 {
   421				compatible = "renesas,r9a07g054-sci", "renesas,sci";
   422				reg = <0 0x1004d400 0 0x400>;
   423				interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
   424					     <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
   425					     <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
   426					     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
   427				interrupt-names = "eri", "rxi", "txi", "tei";
   428				clocks = <&cpg CPG_MOD R9A07G054_SCI1_CLKP>;
   429				clock-names = "fck";
   430				power-domains = <&cpg>;
   431				resets = <&cpg R9A07G054_SCI1_RST>;
   432				status = "disabled";
   433			};
   434	
   435			canfd: can@10050000 {
   436				compatible = "renesas,r9a07g054-canfd", "renesas,rzg2l-canfd";
   437				reg = <0 0x10050000 0 0x8000>;
   438				interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
   439					     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
   440					     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
   441					     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
   442					     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
   443					     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
   444					     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
   445					     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
   446				interrupt-names = "g_err", "g_recc",
   447						  "ch0_err", "ch0_rec", "ch0_trx",
   448						  "ch1_err", "ch1_rec", "ch1_trx";
   449				clocks = <&cpg CPG_MOD R9A07G054_CANFD_PCLK>,
   450					 <&cpg CPG_CORE R9A07G054_CLK_P0_DIV2>,
   451					 <&can_clk>;
   452				clock-names = "fck", "canfd", "can_clk";
   453				assigned-clocks = <&cpg CPG_CORE R9A07G054_CLK_P0_DIV2>;
   454				assigned-clock-rates = <50000000>;
   455				resets = <&cpg R9A07G054_CANFD_RSTP_N>,
   456					 <&cpg R9A07G054_CANFD_RSTC_N>;
   457				reset-names = "rstp_n", "rstc_n";
   458				power-domains = <&cpg>;
   459				status = "disabled";
   460	
   461				channel0 {
   462					status = "disabled";
   463				};
   464				channel1 {
   465					status = "disabled";
   466				};
   467			};
   468	
   469			i2c0: i2c@10058000 {
   470				#address-cells = <1>;
   471				#size-cells = <0>;
   472				compatible = "renesas,riic-r9a07g054", "renesas,riic-rz";
   473				reg = <0 0x10058000 0 0x400>;
   474				interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
   475					     <GIC_SPI 348 IRQ_TYPE_EDGE_RISING>,
   476					     <GIC_SPI 349 IRQ_TYPE_EDGE_RISING>,
   477					     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
   478					     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
   479					     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
   480					     <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
   481					     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
   482				interrupt-names = "tei", "ri", "ti", "spi", "sti",
   483						  "naki", "ali", "tmoi";
   484				clocks = <&cpg CPG_MOD R9A07G054_I2C0_PCLK>;
   485				clock-frequency = <100000>;
   486				resets = <&cpg R9A07G054_I2C0_MRST>;
   487				power-domains = <&cpg>;
   488				status = "disabled";
   489			};
   490	
   491			i2c1: i2c@10058400 {
   492				#address-cells = <1>;
   493				#size-cells = <0>;
   494				compatible = "renesas,riic-r9a07g054", "renesas,riic-rz";
   495				reg = <0 0x10058400 0 0x400>;
   496				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
   497					     <GIC_SPI 356 IRQ_TYPE_EDGE_RISING>,
   498					     <GIC_SPI 357 IRQ_TYPE_EDGE_RISING>,
   499					     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
   500					     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
   501					     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
   502					     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
   503					     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
   504				interrupt-names = "tei", "ri", "ti", "spi", "sti",
   505						  "naki", "ali", "tmoi";
   506				clocks = <&cpg CPG_MOD R9A07G054_I2C1_PCLK>;
   507				clock-frequency = <100000>;
   508				resets = <&cpg R9A07G054_I2C1_MRST>;
   509				power-domains = <&cpg>;
   510				status = "disabled";
   511			};
   512	
   513			i2c2: i2c@10058800 {
   514				#address-cells = <1>;
   515				#size-cells = <0>;
   516				compatible = "renesas,riic-r9a07g054", "renesas,riic-rz";
   517				reg = <0 0x10058800 0 0x400>;
   518				interrupts = <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
   519					     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
   520					     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
   521					     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
   522					     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
   523					     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
   524					     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
   525					     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
   526				interrupt-names = "tei", "ri", "ti", "spi", "sti",
   527						  "naki", "ali", "tmoi";
   528				clocks = <&cpg CPG_MOD R9A07G054_I2C2_PCLK>;
   529				clock-frequency = <100000>;
   530				resets = <&cpg R9A07G054_I2C2_MRST>;
   531				power-domains = <&cpg>;
   532				status = "disabled";
   533			};
   534	
   535			i2c3: i2c@10058c00 {
   536				#address-cells = <1>;
   537				#size-cells = <0>;
   538				compatible = "renesas,riic-r9a07g054", "renesas,riic-rz";
   539				reg = <0 0x10058c00 0 0x400>;
   540				interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
   541					     <GIC_SPI 372 IRQ_TYPE_EDGE_RISING>,
   542					     <GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
   543					     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
   544					     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
   545					     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
   546					     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
   547					     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
   548				interrupt-names = "tei", "ri", "ti", "spi", "sti",
   549						  "naki", "ali", "tmoi";
   550				clocks = <&cpg CPG_MOD R9A07G054_I2C3_PCLK>;
   551				clock-frequency = <100000>;
   552				resets = <&cpg R9A07G054_I2C3_MRST>;
   553				power-domains = <&cpg>;
   554				status = "disabled";
   555			};
   556	
   557			adc: adc@10059000 {
   558				compatible = "renesas,r9a07g054-adc", "renesas,rzg2l-adc";
   559				reg = <0 0x10059000 0 0x400>;
   560				interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
   561				clocks = <&cpg CPG_MOD R9A07G054_ADC_ADCLK>,
   562					 <&cpg CPG_MOD R9A07G054_ADC_PCLK>;
   563				clock-names = "adclk", "pclk";
   564				resets = <&cpg R9A07G054_ADC_PRESETN>,
   565					 <&cpg R9A07G054_ADC_ADRST_N>;
   566				reset-names = "presetn", "adrst-n";
   567				power-domains = <&cpg>;
   568				status = "disabled";
   569	
   570				#address-cells = <1>;
   571				#size-cells = <0>;
   572	
   573				channel@0 {
   574					reg = <0>;
   575				};
   576				channel@1 {
   577					reg = <1>;
   578				};
   579				channel@2 {
   580					reg = <2>;
   581				};
   582				channel@3 {
   583					reg = <3>;
   584				};
   585				channel@4 {
   586					reg = <4>;
   587				};
   588				channel@5 {
   589					reg = <5>;
   590				};
   591				channel@6 {
   592					reg = <6>;
   593				};
   594				channel@7 {
   595					reg = <7>;
   596				};
   597			};
   598	
   599			tsu: thermal@10059400 {
   600				compatible = "renesas,r9a07g054-tsu",
   601					     "renesas,rzg2l-tsu";
   602				reg = <0 0x10059400 0 0x400>;
   603				clocks = <&cpg CPG_MOD R9A07G054_TSU_PCLK>;
   604				resets = <&cpg R9A07G054_TSU_PRESETN>;
   605				power-domains = <&cpg>;
   606				#thermal-sensor-cells = <1>;
   607			};
   608	
   609			sbc: spi@10060000 {
   610				compatible = "renesas,r9a07g054-rpc-if",
   611					     "renesas,rzg2l-rpc-if";
   612				reg = <0 0x10060000 0 0x10000>,
   613				      <0 0x20000000 0 0x10000000>,
   614				      <0 0x10070000 0 0x10000>;
   615				reg-names = "regs", "dirmap", "wbuf";
   616				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
   617				clocks = <&cpg CPG_MOD R9A07G054_SPI_CLK2>,
   618					 <&cpg CPG_MOD R9A07G054_SPI_CLK>;
   619				resets = <&cpg R9A07G054_SPI_RST>;
   620				power-domains = <&cpg>;
   621				#address-cells = <1>;
   622				#size-cells = <0>;
   623				status = "disabled";
   624			};
   625	
   626			cru: video@10830000 {
   627				compatible = "renesas,r9a07g054-cru", "renesas,rzg2l-cru";
   628				reg = <0 0x10830000 0 0x400>;
   629				clocks = <&cpg CPG_MOD R9A07G054_CRU_VCLK>,
   630					 <&cpg CPG_MOD R9A07G054_CRU_PCLK>,
   631					 <&cpg CPG_MOD R9A07G054_CRU_ACLK>;
   632				clock-names = "video", "apb", "axi";
   633				interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
   634					     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
   635					     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
   636				interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
   637				resets = <&cpg R9A07G054_CRU_PRESETN>,
   638					 <&cpg R9A07G054_CRU_ARESETN>;
   639				reset-names = "presetn", "aresetn";
   640				power-domains = <&cpg>;
   641				status = "disabled";
   642	
   643				ports {
   644					#address-cells = <1>;
   645					#size-cells = <0>;
   646	
 > 647					port@0 {
   648						#address-cells = <1>;
   649						#size-cells = <0>;
   650	
   651						reg = <0>;
   652						cruparallel: endpoint@0 {
   653							reg = <0>;
   654						};
   655					};
   656	
   657					port@1 {
   658						#address-cells = <1>;
   659						#size-cells = <0>;
   660	
   661						reg = <1>;
   662						crucsi2: endpoint@0 {
   663							reg = <0>;
   664							remote-endpoint = <&csi2cru>;
   665						};
   666					};
   667				};
   668			};
   669	
   670			csi2: csi2@10830400 {
   671				compatible = "renesas,r9a07g054-csi2", "renesas,rzg2l-csi2";
   672				reg = <0 0x10830400 0 0xfc00>;
   673				interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
   674				clocks = <&cpg CPG_MOD R9A07G054_CRU_SYSCLK>,
   675					 <&cpg CPG_MOD R9A07G054_CRU_VCLK>,
   676					 <&cpg CPG_MOD R9A07G054_CRU_PCLK>;
   677				clock-names = "system", "video", "apb";
   678				resets = <&cpg R9A07G054_CRU_PRESETN>,
   679					 <&cpg R9A07G054_CRU_CMN_RSTB>;
   680				reset-names = "presetn", "cmn-rstb";
   681				power-domains = <&cpg>;
   682				status = "disabled";
   683	
   684				ports {
   685					#address-cells = <1>;
   686					#size-cells = <0>;
   687	
   688					port@0 {
   689						reg = <0>;
   690					};
   691	
 > 692					port@1 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

