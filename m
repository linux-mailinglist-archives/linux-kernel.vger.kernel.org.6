Return-Path: <linux-kernel+bounces-206910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C91900FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17101B2266C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753713E404;
	Sat,  8 Jun 2024 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I77gq5aT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93271C2E9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717825042; cv=none; b=qqPYbfir+u/DtHqzovENfaMT6Q5KHAC3RDWaE0XwMXuu/aRn4er9FUzvlfpG+Ujc7XEbF1aC2Q+oMnlN3ntXVgzBtqoRvI4hLEs+GzCe3BICsjfmdSTngW5JSUdAyE334wRDScyeFHao9XR0/LdgT7tMJHxsNw0ceECq6KIp56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717825042; c=relaxed/simple;
	bh=HurGivzqMGbyXk94VJYVehHdPgh4Jcc2iHK5u3WdZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I1ieSJ+ABd1VdOznSl8uhg6M6HWgCLSNZDAjKxhTJhdvczSyxAOBgdtJ41+MsJUQ6qUNg8V0+YSQbcR2IQNUuY+0FBONqza5yTwY7oKe9HpPa4te9ukXLB6R115stoshSugUkUv999vC5nt3tT4+tns7ZKQBvAO0+UkyPqpVuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I77gq5aT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717825039; x=1749361039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HurGivzqMGbyXk94VJYVehHdPgh4Jcc2iHK5u3WdZvk=;
  b=I77gq5aTYNxHjPvBbDYx/uCU5cJxhEEpAreiuBZRls/3j/BFZ6wUFPcm
   9EXOzo07jcsoKkbk41qWMjnGQ0vEzi/9rmXC0OELVX9fEMaR+R1NT50km
   vD7rMuzLsRgpLTJLlLvfVpQ07Mi/VsyFsR69K2aNNUdCpBNu+Vlr0GV1O
   EqRVHOAZ2y+2dSjzAT8o1uXFA2M6GRde0DPBBsKbPZxTsPYdOD85AoUe0
   LGt3p9EviaSHN1Kd8rzM7S2OktFUAvmR2DPY2U0NdT1xazau2sDek8beG
   kDrNQVDs2+THng39g7IlV69GQRi5Xt9LNFnae/yzrxjpz1yLzTyCPRfb+
   w==;
X-CSE-ConnectionGUID: qCsfwV0AQeq7vS1PZGWK4A==
X-CSE-MsgGUID: M9ZIGQGuTs2fZyoI592FuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14692591"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="14692591"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 22:37:18 -0700
X-CSE-ConnectionGUID: UKU3i2tGT1CboTroAagsyA==
X-CSE-MsgGUID: v6CDJsfMQEeM0nDPFeZtMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="69709376"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jun 2024 22:37:17 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFolO-00017S-1Q;
	Sat, 08 Jun 2024 05:37:14 +0000
Date: Sat, 8 Jun 2024 13:37:06 +0800
From: kernel test robot <lkp@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
 (graph_child_address): /soc/video@10830000/ports/port@1: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Message-ID: <202406081329.snoMrZsJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
commit: 971c17f879352adc719ff215e0769f8e0a49d7c4 arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
date:   4 months ago
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081329.snoMrZsJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081329.snoMrZsJ-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning (graph_child_address): /soc/video@10830000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:120.11-129.6: Warning (graph_child_address): /soc/csi2@10830400/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary

vim +85 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi

    60	
    61	&soc {
    62		interrupt-parent = <&gic>;
    63	
    64		cru: video@10830000 {
    65			compatible = "renesas,r9a07g043-cru", "renesas,rzg2l-cru";
    66			reg = <0 0x10830000 0 0x400>;
    67			clocks = <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
    68				 <&cpg CPG_MOD R9A07G043_CRU_PCLK>,
    69				 <&cpg CPG_MOD R9A07G043_CRU_ACLK>;
    70			clock-names = "video", "apb", "axi";
    71			interrupts = <SOC_PERIPHERAL_IRQ(167) IRQ_TYPE_LEVEL_HIGH>,
    72				     <SOC_PERIPHERAL_IRQ(168) IRQ_TYPE_LEVEL_HIGH>,
    73				     <SOC_PERIPHERAL_IRQ(169) IRQ_TYPE_LEVEL_HIGH>;
    74			interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
    75			resets = <&cpg R9A07G043_CRU_PRESETN>,
    76				 <&cpg R9A07G043_CRU_ARESETN>;
    77			reset-names = "presetn", "aresetn";
    78			power-domains = <&cpg>;
    79			status = "disabled";
    80	
    81			ports {
    82				#address-cells = <1>;
    83				#size-cells = <0>;
    84	
  > 85				port@1 {
    86					#address-cells = <1>;
    87					#size-cells = <0>;
    88	
    89					reg = <1>;
    90					crucsi2: endpoint@0 {
    91						reg = <0>;
    92						remote-endpoint = <&csi2cru>;
    93					};
    94				};
    95			};
    96		};
    97	
    98		csi2: csi2@10830400 {
    99			compatible = "renesas,r9a07g043-csi2", "renesas,rzg2l-csi2";
   100			reg = <0 0x10830400 0 0xfc00>;
   101			interrupts = <SOC_PERIPHERAL_IRQ(166) IRQ_TYPE_LEVEL_HIGH>;
   102			clocks = <&cpg CPG_MOD R9A07G043_CRU_SYSCLK>,
   103				 <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
   104				 <&cpg CPG_MOD R9A07G043_CRU_PCLK>;
   105			clock-names = "system", "video", "apb";
   106			resets = <&cpg R9A07G043_CRU_PRESETN>,
   107				 <&cpg R9A07G043_CRU_CMN_RSTB>;
   108			reset-names = "presetn", "cmn-rstb";
   109			power-domains = <&cpg>;
   110			status = "disabled";
   111	
   112			ports {
   113				#address-cells = <1>;
   114				#size-cells = <0>;
   115	
   116				port@0 {
   117					reg = <0>;
   118				};
   119	
 > 120				port@1 {
   121					#address-cells = <1>;
   122					#size-cells = <0>;
   123					reg = <1>;
   124	
   125					csi2cru: endpoint@0 {
   126						reg = <0>;
   127						remote-endpoint = <&crucsi2>;
   128					};
   129				};
   130			};
   131		};
   132	
   133		irqc: interrupt-controller@110a0000 {
   134			compatible = "renesas,r9a07g043u-irqc",
   135				     "renesas,rzg2l-irqc";
   136			reg = <0 0x110a0000 0 0x10000>;
   137			#interrupt-cells = <2>;
   138			#address-cells = <0>;
   139			interrupt-controller;
   140			interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
   141				     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
   142				     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
   143				     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
   144				     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
   145				     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
   146				     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
   147				     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
   148				     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
   149				     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
   150				     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
   151				     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
   152				     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
   153				     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
   154				     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
   155				     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
   156				     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
   157				     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
   158				     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
   159				     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
   160				     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
   161				     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
   162				     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
   163				     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
   164				     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
   165				     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
   166				     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
   167				     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
   168				     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
   169				     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
   170				     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
   171				     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
   172				     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
   173				     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
   174				     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
   175				     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
   176				     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
   177				     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
   178				     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
   179				     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
   180				     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
   181				     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
   182			interrupt-names = "nmi",
   183					  "irq0", "irq1", "irq2", "irq3",
   184					  "irq4", "irq5", "irq6", "irq7",
   185					  "tint0", "tint1", "tint2", "tint3",
   186					  "tint4", "tint5", "tint6", "tint7",
   187					  "tint8", "tint9", "tint10", "tint11",
   188					  "tint12", "tint13", "tint14", "tint15",
   189					  "tint16", "tint17", "tint18", "tint19",
   190					  "tint20", "tint21", "tint22", "tint23",
   191					  "tint24", "tint25", "tint26", "tint27",
   192					  "tint28", "tint29", "tint30", "tint31",
   193					  "bus-err";
   194			clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
   195				<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
   196			clock-names = "clk", "pclk";
   197			power-domains = <&cpg>;
   198			resets = <&cpg R9A07G043_IA55_RESETN>;
   199		};
   200	
   201		gic: interrupt-controller@11900000 {
   202			compatible = "arm,gic-v3";
   203			#interrupt-cells = <3>;
   204			#address-cells = <0>;
   205			interrupt-controller;
   206			reg = <0x0 0x11900000 0 0x40000>,
   207			      <0x0 0x11940000 0 0x60000>;
   208			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
   209		};
   210	};
   211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

