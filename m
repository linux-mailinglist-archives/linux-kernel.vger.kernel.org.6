Return-Path: <linux-kernel+bounces-216624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDF90A259
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8A6281A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCE17625D;
	Mon, 17 Jun 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDCqdvaC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815F16F0DA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590353; cv=none; b=ggT+DDfjXufJ4hEeeKviSgTiECbmlV7rF4CDDaDHMe2JHvTeJl7Ezaxnb4B3V2VZvS/QRqBXQNSPDaYfCTP7xx6UKsmhQt9eCJ19G4NC3ZAoN+jfeYFDaBKBgavRohuCjTLgv1wh+Qn6dpgNngEVcw/mETBAIvaXRY665nJ7xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590353; c=relaxed/simple;
	bh=sgJetUG4mTd4t3CWRj3r9ak7xbompSVGiifN933H8FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IUE27Ezz6rZdvo/OPgSm3WNgs/QXZ1Z9d74xW49e/lCSvb7KUmmzoclRf6p+hXKqc3fl577lD+jTDM7WZL9O/BQlSleQE3dxfQFH4M/QJ9BGZrKQWuJhxE0OFvC21VyzDtmNkgaTHsjuGrGq931QMwF6OEFxrJOxT6lxPT2KHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDCqdvaC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718590349; x=1750126349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sgJetUG4mTd4t3CWRj3r9ak7xbompSVGiifN933H8FQ=;
  b=XDCqdvaCFadDpmFFgw6NEVxn0ftvh9kddmj4xxfhJYE9lXvcL4KWHuhQ
   ubr5NIHPozrrJ51RAPcNWXvClav5REnrMgHoRJQaNblULZuisQp8KoE4Q
   KuQKiZi6CrHUAhUkubLB2hbTuEH/weRFyYqSl/k1i54VBElEtk827NdCX
   UHzvTPg512PcRCqLx64WfEyixCw0/uGyzGbG8fJi1F3LUEre08luQPZ9b
   NTwfD+AgdLn7EPttNg9W5O5oTtqgrGcIilpi3y5293I33HZuMTbN2/asd
   Q5jcY6YQb9/kJ5PgIXqLk1zRDmEf3htYABIYRbZPCFmGoX4CrD1i5wRlY
   g==;
X-CSE-ConnectionGUID: 1WcNcFXgSHeuL3/cn2gQ6A==
X-CSE-MsgGUID: qpulMOh5SaCg7VzzSIMKvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15636435"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15636435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 19:12:28 -0700
X-CSE-ConnectionGUID: C3K/vvSWTkmv9jS1aAYxlA==
X-CSE-MsgGUID: b5CaTYgWTnKb8KFScL8hSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45599886"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Jun 2024 19:12:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJ1r6-0003f8-0K;
	Mon, 17 Jun 2024 02:12:24 +0000
Date: Mon, 17 Jun 2024 10:11:28 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/msm8998.dtsi:2862.27-2917.6: Warning
 (avoid_unnecessary_addr_size): /soc@0/display-subsystem@c900000/dsi@c994000:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406171053.H2OgENfh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6ba59ff4227927d3a8530fc2973b80e94b54d58f
commit: ff88e1c9dd8cbdbf5487a0e807866049cc5bb4d9 arm64: dts: qcom: msm8998: Add DPU1 nodes
date:   10 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240617/202406171053.H2OgENfh-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240617/202406171053.H2OgENfh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406171053.H2OgENfh-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/pm8005.dtsi:26.23-35.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@800f000/pmic@5: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/msm8998.dtsi:2862.27-2917.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@c900000/dsi@c994000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/msm8998.dtsi:2938.27-2993.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@c900000/dsi@c996000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

vim +2862 arch/arm64/boot/dts/qcom/msm8998.dtsi

    11	
    12	/ {
    13		interrupt-parent = <&intc>;
    14	
    15		qcom,msm-id = <292 0x0>;
    16	
    17		#address-cells = <2>;
    18		#size-cells = <2>;
    19	
    20		chosen { };
    21	
    22		memory@80000000 {
    23			device_type = "memory";
    24			/* We expect the bootloader to fill in the reg */
    25			reg = <0x0 0x80000000 0x0 0x0>;
    26		};
    27	
    28		reserved-memory {
    29			#address-cells = <2>;
    30			#size-cells = <2>;
    31			ranges;
    32	
    33			hyp_mem: memory@85800000 {
    34				reg = <0x0 0x85800000 0x0 0x600000>;
    35				no-map;
    36			};
    37	
    38			xbl_mem: memory@85e00000 {
    39				reg = <0x0 0x85e00000 0x0 0x100000>;
    40				no-map;
    41			};
    42	
    43			smem_mem: smem-mem@86000000 {
    44				reg = <0x0 0x86000000 0x0 0x200000>;
    45				no-map;
    46			};
    47	
    48			tz_mem: memory@86200000 {
    49				reg = <0x0 0x86200000 0x0 0x2d00000>;
    50				no-map;
    51			};
    52	
    53			rmtfs_mem: memory@88f00000 {
    54				compatible = "qcom,rmtfs-mem";
    55				reg = <0x0 0x88f00000 0x0 0x200000>;
    56				no-map;
    57	
    58				qcom,client-id = <1>;
    59				qcom,vmid = <15>;
    60			};
    61	
    62			spss_mem: memory@8ab00000 {
    63				reg = <0x0 0x8ab00000 0x0 0x700000>;
    64				no-map;
    65			};
    66	
    67			adsp_mem: memory@8b200000 {
    68				reg = <0x0 0x8b200000 0x0 0x1a00000>;
    69				no-map;
    70			};
    71	
    72			mpss_mem: memory@8cc00000 {
    73				reg = <0x0 0x8cc00000 0x0 0x7000000>;
    74				no-map;
    75			};
    76	
    77			venus_mem: memory@93c00000 {
    78				reg = <0x0 0x93c00000 0x0 0x500000>;
    79				no-map;
    80			};
    81	
    82			mba_mem: memory@94100000 {
    83				reg = <0x0 0x94100000 0x0 0x200000>;
    84				no-map;
    85			};
    86	
    87			slpi_mem: memory@94300000 {
    88				reg = <0x0 0x94300000 0x0 0xf00000>;
    89				no-map;
    90			};
    91	
    92			ipa_fw_mem: memory@95200000 {
    93				reg = <0x0 0x95200000 0x0 0x10000>;
    94				no-map;
    95			};
    96	
    97			ipa_gsi_mem: memory@95210000 {
    98				reg = <0x0 0x95210000 0x0 0x5000>;
    99				no-map;
   100			};
   101	
   102			gpu_mem: memory@95600000 {
   103				reg = <0x0 0x95600000 0x0 0x100000>;
   104				no-map;
   105			};
   106	
   107			wlan_msa_mem: memory@95700000 {
   108				reg = <0x0 0x95700000 0x0 0x100000>;
   109				no-map;
   110			};
   111	
   112			mdata_mem: mpss-metadata {
   113				alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
   114				size = <0x0 0x4000>;
   115				no-map;
   116			};
   117		};
   118	
   119		clocks {
   120			xo: xo-board {
   121				compatible = "fixed-clock";
   122				#clock-cells = <0>;
   123				clock-frequency = <19200000>;
   124				clock-output-names = "xo_board";
   125			};
   126	
   127			sleep_clk: sleep-clk {
   128				compatible = "fixed-clock";
   129				#clock-cells = <0>;
   130				clock-frequency = <32764>;
   131			};
   132		};
   133	
   134		cpus {
   135			#address-cells = <2>;
   136			#size-cells = <0>;
   137	
   138			CPU0: cpu@0 {
   139				device_type = "cpu";
   140				compatible = "qcom,kryo280";
   141				reg = <0x0 0x0>;
   142				enable-method = "psci";
   143				capacity-dmips-mhz = <1024>;
   144				cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   145				next-level-cache = <&L2_0>;
   146				L2_0: l2-cache {
   147					compatible = "cache";
   148					cache-level = <2>;
   149					cache-unified;
   150				};
   151			};
   152	
   153			CPU1: cpu@1 {
   154				device_type = "cpu";
   155				compatible = "qcom,kryo280";
   156				reg = <0x0 0x1>;
   157				enable-method = "psci";
   158				capacity-dmips-mhz = <1024>;
   159				cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   160				next-level-cache = <&L2_0>;
   161			};
   162	
   163			CPU2: cpu@2 {
   164				device_type = "cpu";
   165				compatible = "qcom,kryo280";
   166				reg = <0x0 0x2>;
   167				enable-method = "psci";
   168				capacity-dmips-mhz = <1024>;
   169				cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   170				next-level-cache = <&L2_0>;
   171			};
   172	
   173			CPU3: cpu@3 {
   174				device_type = "cpu";
   175				compatible = "qcom,kryo280";
   176				reg = <0x0 0x3>;
   177				enable-method = "psci";
   178				capacity-dmips-mhz = <1024>;
   179				cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   180				next-level-cache = <&L2_0>;
   181			};
   182	
   183			CPU4: cpu@100 {
   184				device_type = "cpu";
   185				compatible = "qcom,kryo280";
   186				reg = <0x0 0x100>;
   187				enable-method = "psci";
   188				capacity-dmips-mhz = <1536>;
   189				cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
   190				next-level-cache = <&L2_1>;
   191				L2_1: l2-cache {
   192					compatible = "cache";
   193					cache-level = <2>;
   194					cache-unified;
   195				};
   196			};
   197	
   198			CPU5: cpu@101 {
   199				device_type = "cpu";
   200				compatible = "qcom,kryo280";
   201				reg = <0x0 0x101>;
   202				enable-method = "psci";
   203				capacity-dmips-mhz = <1536>;
   204				cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
   205				next-level-cache = <&L2_1>;
   206			};
   207	
   208			CPU6: cpu@102 {
   209				device_type = "cpu";
   210				compatible = "qcom,kryo280";
   211				reg = <0x0 0x102>;
   212				enable-method = "psci";
   213				capacity-dmips-mhz = <1536>;
   214				cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
   215				next-level-cache = <&L2_1>;
   216			};
   217	
   218			CPU7: cpu@103 {
   219				device_type = "cpu";
   220				compatible = "qcom,kryo280";
   221				reg = <0x0 0x103>;
   222				enable-method = "psci";
   223				capacity-dmips-mhz = <1536>;
   224				cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
   225				next-level-cache = <&L2_1>;
   226			};
   227	
   228			cpu-map {
   229				cluster0 {
   230					core0 {
   231						cpu = <&CPU0>;
   232					};
   233	
   234					core1 {
   235						cpu = <&CPU1>;
   236					};
   237	
   238					core2 {
   239						cpu = <&CPU2>;
   240					};
   241	
   242					core3 {
   243						cpu = <&CPU3>;
   244					};
   245				};
   246	
   247				cluster1 {
   248					core0 {
   249						cpu = <&CPU4>;
   250					};
   251	
   252					core1 {
   253						cpu = <&CPU5>;
   254					};
   255	
   256					core2 {
   257						cpu = <&CPU6>;
   258					};
   259	
   260					core3 {
   261						cpu = <&CPU7>;
   262					};
   263				};
   264			};
   265	
   266			idle-states {
   267				entry-method = "psci";
   268	
   269				LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
   270					compatible = "arm,idle-state";
   271					idle-state-name = "little-retention";
   272					/* CPU Retention (C2D), L2 Active */
   273					arm,psci-suspend-param = <0x00000002>;
   274					entry-latency-us = <81>;
   275					exit-latency-us = <86>;
   276					min-residency-us = <504>;
   277				};
   278	
   279				LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
   280					compatible = "arm,idle-state";
   281					idle-state-name = "little-power-collapse";
   282					/* CPU + L2 Power Collapse (C3, D4) */
   283					arm,psci-suspend-param = <0x40000003>;
   284					entry-latency-us = <814>;
   285					exit-latency-us = <4562>;
   286					min-residency-us = <9183>;
   287					local-timer-stop;
   288				};
   289	
   290				BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
   291					compatible = "arm,idle-state";
   292					idle-state-name = "big-retention";
   293					/* CPU Retention (C2D), L2 Active */
   294					arm,psci-suspend-param = <0x00000002>;
   295					entry-latency-us = <79>;
   296					exit-latency-us = <82>;
   297					min-residency-us = <1302>;
   298				};
   299	
   300				BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
   301					compatible = "arm,idle-state";
   302					idle-state-name = "big-power-collapse";
   303					/* CPU + L2 Power Collapse (C3, D4) */
   304					arm,psci-suspend-param = <0x40000003>;
   305					entry-latency-us = <724>;
   306					exit-latency-us = <2027>;
   307					min-residency-us = <9419>;
   308					local-timer-stop;
   309				};
   310			};
   311		};
   312	
   313		firmware {
   314			scm {
   315				compatible = "qcom,scm-msm8998", "qcom,scm";
   316			};
   317		};
   318	
   319		dsi_opp_table: opp-table-dsi {
   320			compatible = "operating-points-v2";
   321	
   322			opp-131250000 {
   323				opp-hz = /bits/ 64 <131250000>;
   324				required-opps = <&rpmpd_opp_low_svs>;
   325			};
   326	
   327			opp-210000000 {
   328				opp-hz = /bits/ 64 <210000000>;
   329				required-opps = <&rpmpd_opp_svs>;
   330			};
   331	
   332			opp-312500000 {
   333				opp-hz = /bits/ 64 <312500000>;
   334				required-opps = <&rpmpd_opp_nom>;
   335			};
   336		};
   337	
   338		psci {
   339			compatible = "arm,psci-1.0";
   340			method = "smc";
   341		};
   342	
   343		rpm: remoteproc {
   344			compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
   345	
   346			glink-edge {
   347				compatible = "qcom,glink-rpm";
   348	
   349				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
   350				qcom,rpm-msg-ram = <&rpm_msg_ram>;
   351				mboxes = <&apcs_glb 0>;
   352	
   353				rpm_requests: rpm-requests {
   354					compatible = "qcom,rpm-msm8998";
   355					qcom,glink-channels = "rpm_requests";
   356	
   357					rpmcc: clock-controller {
   358						compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
   359						clocks = <&xo>;
   360						clock-names = "xo";
   361						#clock-cells = <1>;
   362					};
   363	
   364					rpmpd: power-controller {
   365						compatible = "qcom,msm8998-rpmpd";
   366						#power-domain-cells = <1>;
   367						operating-points-v2 = <&rpmpd_opp_table>;
   368	
   369						rpmpd_opp_table: opp-table {
   370							compatible = "operating-points-v2";
   371	
   372							rpmpd_opp_ret: opp1 {
   373								opp-level = <RPM_SMD_LEVEL_RETENTION>;
   374							};
   375	
   376							rpmpd_opp_ret_plus: opp2 {
   377								opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
   378							};
   379	
   380							rpmpd_opp_min_svs: opp3 {
   381								opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
   382							};
   383	
   384							rpmpd_opp_low_svs: opp4 {
   385								opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
   386							};
   387	
   388							rpmpd_opp_svs: opp5 {
   389								opp-level = <RPM_SMD_LEVEL_SVS>;
   390							};
   391	
   392							rpmpd_opp_svs_plus: opp6 {
   393								opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
   394							};
   395	
   396							rpmpd_opp_nom: opp7 {
   397								opp-level = <RPM_SMD_LEVEL_NOM>;
   398							};
   399	
   400							rpmpd_opp_nom_plus: opp8 {
   401								opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
   402							};
   403	
   404							rpmpd_opp_turbo: opp9 {
   405								opp-level = <RPM_SMD_LEVEL_TURBO>;
   406							};
   407	
   408							rpmpd_opp_turbo_plus: opp10 {
   409								opp-level = <RPM_SMD_LEVEL_BINNING>;
   410							};
   411						};
   412					};
   413				};
   414			};
   415		};
   416	
   417		smem {
   418			compatible = "qcom,smem";
   419			memory-region = <&smem_mem>;
   420			hwlocks = <&tcsr_mutex 3>;
   421		};
   422	
   423		smp2p-lpass {
   424			compatible = "qcom,smp2p";
   425			qcom,smem = <443>, <429>;
   426	
   427			interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
   428	
   429			mboxes = <&apcs_glb 10>;
   430	
   431			qcom,local-pid = <0>;
   432			qcom,remote-pid = <2>;
   433	
   434			adsp_smp2p_out: master-kernel {
   435				qcom,entry-name = "master-kernel";
   436				#qcom,smem-state-cells = <1>;
   437			};
   438	
   439			adsp_smp2p_in: slave-kernel {
   440				qcom,entry-name = "slave-kernel";
   441	
   442				interrupt-controller;
   443				#interrupt-cells = <2>;
   444			};
   445		};
   446	
   447		smp2p-mpss {
   448			compatible = "qcom,smp2p";
   449			qcom,smem = <435>, <428>;
   450			interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
   451			mboxes = <&apcs_glb 14>;
   452			qcom,local-pid = <0>;
   453			qcom,remote-pid = <1>;
   454	
   455			modem_smp2p_out: master-kernel {
   456				qcom,entry-name = "master-kernel";
   457				#qcom,smem-state-cells = <1>;
   458			};
   459	
   460			modem_smp2p_in: slave-kernel {
   461				qcom,entry-name = "slave-kernel";
   462				interrupt-controller;
   463				#interrupt-cells = <2>;
   464			};
   465		};
   466	
   467		smp2p-slpi {
   468			compatible = "qcom,smp2p";
   469			qcom,smem = <481>, <430>;
   470			interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
   471			mboxes = <&apcs_glb 26>;
   472			qcom,local-pid = <0>;
   473			qcom,remote-pid = <3>;
   474	
   475			slpi_smp2p_out: master-kernel {
   476				qcom,entry-name = "master-kernel";
   477				#qcom,smem-state-cells = <1>;
   478			};
   479	
   480			slpi_smp2p_in: slave-kernel {
   481				qcom,entry-name = "slave-kernel";
   482				interrupt-controller;
   483				#interrupt-cells = <2>;
   484			};
   485		};
   486	
   487		thermal-zones {
   488			cpu0-thermal {
   489				polling-delay-passive = <250>;
   490				polling-delay = <1000>;
   491	
   492				thermal-sensors = <&tsens0 1>;
   493	
   494				trips {
   495					cpu0_alert0: trip-point0 {
   496						temperature = <75000>;
   497						hysteresis = <2000>;
   498						type = "passive";
   499					};
   500	
   501					cpu0_crit: cpu-crit {
   502						temperature = <110000>;
   503						hysteresis = <2000>;
   504						type = "critical";
   505					};
   506				};
   507			};
   508	
   509			cpu1-thermal {
   510				polling-delay-passive = <250>;
   511				polling-delay = <1000>;
   512	
   513				thermal-sensors = <&tsens0 2>;
   514	
   515				trips {
   516					cpu1_alert0: trip-point0 {
   517						temperature = <75000>;
   518						hysteresis = <2000>;
   519						type = "passive";
   520					};
   521	
   522					cpu1_crit: cpu-crit {
   523						temperature = <110000>;
   524						hysteresis = <2000>;
   525						type = "critical";
   526					};
   527				};
   528			};
   529	
   530			cpu2-thermal {
   531				polling-delay-passive = <250>;
   532				polling-delay = <1000>;
   533	
   534				thermal-sensors = <&tsens0 3>;
   535	
   536				trips {
   537					cpu2_alert0: trip-point0 {
   538						temperature = <75000>;
   539						hysteresis = <2000>;
   540						type = "passive";
   541					};
   542	
   543					cpu2_crit: cpu-crit {
   544						temperature = <110000>;
   545						hysteresis = <2000>;
   546						type = "critical";
   547					};
   548				};
   549			};
   550	
   551			cpu3-thermal {
   552				polling-delay-passive = <250>;
   553				polling-delay = <1000>;
   554	
   555				thermal-sensors = <&tsens0 4>;
   556	
   557				trips {
   558					cpu3_alert0: trip-point0 {
   559						temperature = <75000>;
   560						hysteresis = <2000>;
   561						type = "passive";
   562					};
   563	
   564					cpu3_crit: cpu-crit {
   565						temperature = <110000>;
   566						hysteresis = <2000>;
   567						type = "critical";
   568					};
   569				};
   570			};
   571	
   572			cpu4-thermal {
   573				polling-delay-passive = <250>;
   574				polling-delay = <1000>;
   575	
   576				thermal-sensors = <&tsens0 7>;
   577	
   578				trips {
   579					cpu4_alert0: trip-point0 {
   580						temperature = <75000>;
   581						hysteresis = <2000>;
   582						type = "passive";
   583					};
   584	
   585					cpu4_crit: cpu-crit {
   586						temperature = <110000>;
   587						hysteresis = <2000>;
   588						type = "critical";
   589					};
   590				};
   591			};
   592	
   593			cpu5-thermal {
   594				polling-delay-passive = <250>;
   595				polling-delay = <1000>;
   596	
   597				thermal-sensors = <&tsens0 8>;
   598	
   599				trips {
   600					cpu5_alert0: trip-point0 {
   601						temperature = <75000>;
   602						hysteresis = <2000>;
   603						type = "passive";
   604					};
   605	
   606					cpu5_crit: cpu-crit {
   607						temperature = <110000>;
   608						hysteresis = <2000>;
   609						type = "critical";
   610					};
   611				};
   612			};
   613	
   614			cpu6-thermal {
   615				polling-delay-passive = <250>;
   616				polling-delay = <1000>;
   617	
   618				thermal-sensors = <&tsens0 9>;
   619	
   620				trips {
   621					cpu6_alert0: trip-point0 {
   622						temperature = <75000>;
   623						hysteresis = <2000>;
   624						type = "passive";
   625					};
   626	
   627					cpu6_crit: cpu-crit {
   628						temperature = <110000>;
   629						hysteresis = <2000>;
   630						type = "critical";
   631					};
   632				};
   633			};
   634	
   635			cpu7-thermal {
   636				polling-delay-passive = <250>;
   637				polling-delay = <1000>;
   638	
   639				thermal-sensors = <&tsens0 10>;
   640	
   641				trips {
   642					cpu7_alert0: trip-point0 {
   643						temperature = <75000>;
   644						hysteresis = <2000>;
   645						type = "passive";
   646					};
   647	
   648					cpu7_crit: cpu-crit {
   649						temperature = <110000>;
   650						hysteresis = <2000>;
   651						type = "critical";
   652					};
   653				};
   654			};
   655	
   656			gpu-bottom-thermal {
   657				polling-delay-passive = <250>;
   658				polling-delay = <1000>;
   659	
   660				thermal-sensors = <&tsens0 12>;
   661	
   662				trips {
   663					gpu1_alert0: trip-point0 {
   664						temperature = <90000>;
   665						hysteresis = <2000>;
   666						type = "hot";
   667					};
   668				};
   669			};
   670	
   671			gpu-top-thermal {
   672				polling-delay-passive = <250>;
   673				polling-delay = <1000>;
   674	
   675				thermal-sensors = <&tsens0 13>;
   676	
   677				trips {
   678					gpu2_alert0: trip-point0 {
   679						temperature = <90000>;
   680						hysteresis = <2000>;
   681						type = "hot";
   682					};
   683				};
   684			};
   685	
   686			clust0-mhm-thermal {
   687				polling-delay-passive = <250>;
   688				polling-delay = <1000>;
   689	
   690				thermal-sensors = <&tsens0 5>;
   691	
   692				trips {
   693					cluster0_mhm_alert0: trip-point0 {
   694						temperature = <90000>;
   695						hysteresis = <2000>;
   696						type = "hot";
   697					};
   698				};
   699			};
   700	
   701			clust1-mhm-thermal {
   702				polling-delay-passive = <250>;
   703				polling-delay = <1000>;
   704	
   705				thermal-sensors = <&tsens0 6>;
   706	
   707				trips {
   708					cluster1_mhm_alert0: trip-point0 {
   709						temperature = <90000>;
   710						hysteresis = <2000>;
   711						type = "hot";
   712					};
   713				};
   714			};
   715	
   716			cluster1-l2-thermal {
   717				polling-delay-passive = <250>;
   718				polling-delay = <1000>;
   719	
   720				thermal-sensors = <&tsens0 11>;
   721	
   722				trips {
   723					cluster1_l2_alert0: trip-point0 {
   724						temperature = <90000>;
   725						hysteresis = <2000>;
   726						type = "hot";
   727					};
   728				};
   729			};
   730	
   731			modem-thermal {
   732				polling-delay-passive = <250>;
   733				polling-delay = <1000>;
   734	
   735				thermal-sensors = <&tsens1 1>;
   736	
   737				trips {
   738					modem_alert0: trip-point0 {
   739						temperature = <90000>;
   740						hysteresis = <2000>;
   741						type = "hot";
   742					};
   743				};
   744			};
   745	
   746			mem-thermal {
   747				polling-delay-passive = <250>;
   748				polling-delay = <1000>;
   749	
   750				thermal-sensors = <&tsens1 2>;
   751	
   752				trips {
   753					mem_alert0: trip-point0 {
   754						temperature = <90000>;
   755						hysteresis = <2000>;
   756						type = "hot";
   757					};
   758				};
   759			};
   760	
   761			wlan-thermal {
   762				polling-delay-passive = <250>;
   763				polling-delay = <1000>;
   764	
   765				thermal-sensors = <&tsens1 3>;
   766	
   767				trips {
   768					wlan_alert0: trip-point0 {
   769						temperature = <90000>;
   770						hysteresis = <2000>;
   771						type = "hot";
   772					};
   773				};
   774			};
   775	
   776			q6-dsp-thermal {
   777				polling-delay-passive = <250>;
   778				polling-delay = <1000>;
   779	
   780				thermal-sensors = <&tsens1 4>;
   781	
   782				trips {
   783					q6_dsp_alert0: trip-point0 {
   784						temperature = <90000>;
   785						hysteresis = <2000>;
   786						type = "hot";
   787					};
   788				};
   789			};
   790	
   791			camera-thermal {
   792				polling-delay-passive = <250>;
   793				polling-delay = <1000>;
   794	
   795				thermal-sensors = <&tsens1 5>;
   796	
   797				trips {
   798					camera_alert0: trip-point0 {
   799						temperature = <90000>;
   800						hysteresis = <2000>;
   801						type = "hot";
   802					};
   803				};
   804			};
   805	
   806			multimedia-thermal {
   807				polling-delay-passive = <250>;
   808				polling-delay = <1000>;
   809	
   810				thermal-sensors = <&tsens1 6>;
   811	
   812				trips {
   813					multimedia_alert0: trip-point0 {
   814						temperature = <90000>;
   815						hysteresis = <2000>;
   816						type = "hot";
   817					};
   818				};
   819			};
   820		};
   821	
   822		timer {
   823			compatible = "arm,armv8-timer";
   824			interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
   825				     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
   826				     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
   827				     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
   828		};
   829	
   830		soc: soc@0 {
   831			#address-cells = <1>;
   832			#size-cells = <1>;
   833			ranges = <0 0 0 0xffffffff>;
   834			compatible = "simple-bus";
   835	
   836			gcc: clock-controller@100000 {
   837				compatible = "qcom,gcc-msm8998";
   838				#clock-cells = <1>;
   839				#reset-cells = <1>;
   840				#power-domain-cells = <1>;
   841				reg = <0x00100000 0xb0000>;
   842	
   843				clock-names = "xo", "sleep_clk";
   844				clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
   845	
   846				/*
   847				 * The hypervisor typically configures the memory region where these clocks
   848				 * reside as read-only for the HLOS. If the HLOS tried to enable or disable
   849				 * these clocks on a device with such configuration (e.g. because they are
   850				 * enabled but unused during boot-up), the device will most likely decide
   851				 * to reboot.
   852				 * In light of that, we are conservative here and we list all such clocks
   853				 * as protected. The board dts (or a user-supplied dts) can override the
   854				 * list of protected clocks if it differs from the norm, and it is in fact
   855				 * desired for the HLOS to manage these clocks
   856				 */
   857				protected-clocks = <AGGRE2_SNOC_NORTH_AXI>,
   858						   <SSC_XO>,
   859						   <SSC_CNOC_AHBS_CLK>;
   860			};
   861	
   862			rpm_msg_ram: sram@778000 {
   863				compatible = "qcom,rpm-msg-ram";
   864				reg = <0x00778000 0x7000>;
   865			};
   866	
   867			qfprom: qfprom@784000 {
   868				compatible = "qcom,msm8998-qfprom", "qcom,qfprom";
   869				reg = <0x00784000 0x621c>;
   870				#address-cells = <1>;
   871				#size-cells = <1>;
   872	
   873				qusb2_hstx_trim: hstx-trim@23a {
   874					reg = <0x23a 0x1>;
   875					bits = <0 4>;
   876				};
   877			};
   878	
   879			tsens0: thermal@10ab000 {
   880				compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
   881				reg = <0x010ab000 0x1000>, /* TM */
   882				      <0x010aa000 0x1000>; /* SROT */
   883				#qcom,sensors = <14>;
   884				interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
   885					     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
   886				interrupt-names = "uplow", "critical";
   887				#thermal-sensor-cells = <1>;
   888			};
   889	
   890			tsens1: thermal@10ae000 {
   891				compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
   892				reg = <0x010ae000 0x1000>, /* TM */
   893				      <0x010ad000 0x1000>; /* SROT */
   894				#qcom,sensors = <8>;
   895				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
   896					     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
   897				interrupt-names = "uplow", "critical";
   898				#thermal-sensor-cells = <1>;
   899			};
   900	
   901			anoc1_smmu: iommu@1680000 {
   902				compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
   903				reg = <0x01680000 0x10000>;
   904				#iommu-cells = <1>;
   905	
   906				#global-interrupts = <0>;
   907				interrupts =
   908					<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
   909					<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
   910					<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
   911					<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
   912					<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
   913					<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
   914			};
   915	
   916			anoc2_smmu: iommu@16c0000 {
   917				compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
   918				reg = <0x016c0000 0x40000>;
   919				#iommu-cells = <1>;
   920	
   921				#global-interrupts = <0>;
   922				interrupts =
   923					<GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
   924					<GIC_SPI 374 IRQ_TYPE_EDGE_RISING>,
   925					<GIC_SPI 375 IRQ_TYPE_EDGE_RISING>,
   926					<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>,
   927					<GIC_SPI 377 IRQ_TYPE_EDGE_RISING>,
   928					<GIC_SPI 378 IRQ_TYPE_EDGE_RISING>,
   929					<GIC_SPI 462 IRQ_TYPE_EDGE_RISING>,
   930					<GIC_SPI 463 IRQ_TYPE_EDGE_RISING>,
   931					<GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
   932					<GIC_SPI 465 IRQ_TYPE_EDGE_RISING>;
   933			};
   934	
   935			pcie0: pci@1c00000 {
   936				compatible = "qcom,pcie-msm8998", "qcom,pcie-msm8996";
   937				reg = <0x01c00000 0x2000>,
   938				      <0x1b000000 0xf1d>,
   939				      <0x1b000f20 0xa8>,
   940				      <0x1b100000 0x100000>;
   941				reg-names = "parf", "dbi", "elbi", "config";
   942				device_type = "pci";
   943				linux,pci-domain = <0>;
   944				bus-range = <0x00 0xff>;
   945				#address-cells = <3>;
   946				#size-cells = <2>;
   947				num-lanes = <1>;
   948				phys = <&pciephy>;
   949				phy-names = "pciephy";
   950				status = "disabled";
   951	
   952				ranges = <0x01000000 0x0 0x00000000 0x1b200000 0x0 0x100000>,
   953					 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
   954	
   955				#interrupt-cells = <1>;
   956				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
   957				interrupt-names = "msi";
   958				interrupt-map-mask = <0 0 0 0x7>;
   959				interrupt-map = <0 0 0 1 &intc 0 0 135 IRQ_TYPE_LEVEL_HIGH>,
   960						<0 0 0 2 &intc 0 0 136 IRQ_TYPE_LEVEL_HIGH>,
   961						<0 0 0 3 &intc 0 0 138 IRQ_TYPE_LEVEL_HIGH>,
   962						<0 0 0 4 &intc 0 0 139 IRQ_TYPE_LEVEL_HIGH>;
   963	
   964				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
   965					 <&gcc GCC_PCIE_0_AUX_CLK>,
   966					 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
   967					 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
   968					 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
   969				clock-names = "pipe", "aux", "cfg", "bus_master", "bus_slave";
   970	
   971				power-domains = <&gcc PCIE_0_GDSC>;
   972				iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
   973				perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
   974			};
   975	
   976			pcie_phy: phy@1c06000 {
   977				compatible = "qcom,msm8998-qmp-pcie-phy";
   978				reg = <0x01c06000 0x18c>;
   979				#address-cells = <1>;
   980				#size-cells = <1>;
   981				status = "disabled";
   982				ranges;
   983	
   984				clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
   985					 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
   986					 <&gcc GCC_PCIE_CLKREF_CLK>;
   987				clock-names = "aux", "cfg_ahb", "ref";
   988	
   989				resets = <&gcc GCC_PCIE_0_PHY_BCR>, <&gcc GCC_PCIE_PHY_BCR>;
   990				reset-names = "phy", "common";
   991	
   992				vdda-phy-supply = <&vreg_l1a_0p875>;
   993				vdda-pll-supply = <&vreg_l2a_1p2>;
   994	
   995				pciephy: phy@1c06800 {
   996					reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
   997					#phy-cells = <0>;
   998	
   999					clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
  1000					clock-names = "pipe0";
  1001					clock-output-names = "pcie_0_pipe_clk_src";
  1002					#clock-cells = <0>;
  1003				};
  1004			};
  1005	
  1006			ufshc: ufshc@1da4000 {
  1007				compatible = "qcom,msm8998-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
  1008				reg = <0x01da4000 0x2500>;
  1009				interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
  1010				phys = <&ufsphy_lanes>;
  1011				phy-names = "ufsphy";
  1012				lanes-per-direction = <2>;
  1013				power-domains = <&gcc UFS_GDSC>;
  1014				status = "disabled";
  1015				#reset-cells = <1>;
  1016	
  1017				clock-names =
  1018					"core_clk",
  1019					"bus_aggr_clk",
  1020					"iface_clk",
  1021					"core_clk_unipro",
  1022					"ref_clk",
  1023					"tx_lane0_sync_clk",
  1024					"rx_lane0_sync_clk",
  1025					"rx_lane1_sync_clk";
  1026				clocks =
  1027					<&gcc GCC_UFS_AXI_CLK>,
  1028					<&gcc GCC_AGGRE1_UFS_AXI_CLK>,
  1029					<&gcc GCC_UFS_AHB_CLK>,
  1030					<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
  1031					<&rpmcc RPM_SMD_LN_BB_CLK1>,
  1032					<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
  1033					<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
  1034					<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
  1035				freq-table-hz =
  1036					<50000000 200000000>,
  1037					<0 0>,
  1038					<0 0>,
  1039					<37500000 150000000>,
  1040					<0 0>,
  1041					<0 0>,
  1042					<0 0>,
  1043					<0 0>;
  1044	
  1045				resets = <&gcc GCC_UFS_BCR>;
  1046				reset-names = "rst";
  1047			};
  1048	
  1049			ufsphy: phy@1da7000 {
  1050				compatible = "qcom,msm8998-qmp-ufs-phy";
  1051				reg = <0x01da7000 0x18c>;
  1052				#address-cells = <1>;
  1053				#size-cells = <1>;
  1054				status = "disabled";
  1055				ranges;
  1056	
  1057				clock-names =
  1058					"ref",
  1059					"ref_aux";
  1060				clocks =
  1061					<&gcc GCC_UFS_CLKREF_CLK>,
  1062					<&gcc GCC_UFS_PHY_AUX_CLK>;
  1063	
  1064				reset-names = "ufsphy";
  1065				resets = <&ufshc 0>;
  1066	
  1067				ufsphy_lanes: phy@1da7400 {
  1068					reg = <0x01da7400 0x128>,
  1069					      <0x01da7600 0x1fc>,
  1070					      <0x01da7c00 0x1dc>,
  1071					      <0x01da7800 0x128>,
  1072					      <0x01da7a00 0x1fc>;
  1073					#phy-cells = <0>;
  1074				};
  1075			};
  1076	
  1077			tcsr_mutex: hwlock@1f40000 {
  1078				compatible = "qcom,tcsr-mutex";
  1079				reg = <0x01f40000 0x20000>;
  1080				#hwlock-cells = <1>;
  1081			};
  1082	
  1083			tcsr_regs_1: syscon@1f60000 {
  1084				compatible = "qcom,msm8998-tcsr", "syscon";
  1085				reg = <0x01f60000 0x20000>;
  1086			};
  1087	
  1088			tlmm: pinctrl@3400000 {
  1089				compatible = "qcom,msm8998-pinctrl";
  1090				reg = <0x03400000 0xc00000>;
  1091				interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
  1092				gpio-ranges = <&tlmm 0 0 150>;
  1093				gpio-controller;
  1094				#gpio-cells = <2>;
  1095				interrupt-controller;
  1096				#interrupt-cells = <2>;
  1097	
  1098				sdc2_on: sdc2-on-state {
  1099					clk-pins {
  1100						pins = "sdc2_clk";
  1101						drive-strength = <16>;
  1102						bias-disable;
  1103					};
  1104	
  1105					cmd-pins {
  1106						pins = "sdc2_cmd";
  1107						drive-strength = <10>;
  1108						bias-pull-up;
  1109					};
  1110	
  1111					data-pins {
  1112						pins = "sdc2_data";
  1113						drive-strength = <10>;
  1114						bias-pull-up;
  1115					};
  1116				};
  1117	
  1118				sdc2_off: sdc2-off-state {
  1119					clk-pins {
  1120						pins = "sdc2_clk";
  1121						drive-strength = <2>;
  1122						bias-disable;
  1123					};
  1124	
  1125					cmd-pins {
  1126						pins = "sdc2_cmd";
  1127						drive-strength = <2>;
  1128						bias-pull-up;
  1129					};
  1130	
  1131					data-pins {
  1132						pins = "sdc2_data";
  1133						drive-strength = <2>;
  1134						bias-pull-up;
  1135					};
  1136				};
  1137	
  1138				sdc2_cd: sdc2-cd-state {
  1139					pins = "gpio95";
  1140					function = "gpio";
  1141					bias-pull-up;
  1142					drive-strength = <2>;
  1143				};
  1144	
  1145				blsp1_uart3_on: blsp1-uart3-on-state {
  1146					tx-pins {
  1147						pins = "gpio45";
  1148						function = "blsp_uart3_a";
  1149						drive-strength = <2>;
  1150						bias-disable;
  1151					};
  1152	
  1153					rx-pins {
  1154						pins = "gpio46";
  1155						function = "blsp_uart3_a";
  1156						drive-strength = <2>;
  1157						bias-disable;
  1158					};
  1159	
  1160					cts-pins {
  1161						pins = "gpio47";
  1162						function = "blsp_uart3_a";
  1163						drive-strength = <2>;
  1164						bias-disable;
  1165					};
  1166	
  1167					rfr-pins {
  1168						pins = "gpio48";
  1169						function = "blsp_uart3_a";
  1170						drive-strength = <2>;
  1171						bias-disable;
  1172					};
  1173				};
  1174	
  1175				blsp1_i2c1_default: blsp1-i2c1-default-state {
  1176					pins = "gpio2", "gpio3";
  1177					function = "blsp_i2c1";
  1178					drive-strength = <2>;
  1179					bias-disable;
  1180				};
  1181	
  1182				blsp1_i2c1_sleep: blsp1-i2c1-sleep-state-state {
  1183					pins = "gpio2", "gpio3";
  1184					function = "blsp_i2c1";
  1185					drive-strength = <2>;
  1186					bias-pull-up;
  1187				};
  1188	
  1189				blsp1_i2c2_default: blsp1-i2c2-default-state {
  1190					pins = "gpio32", "gpio33";
  1191					function = "blsp_i2c2";
  1192					drive-strength = <2>;
  1193					bias-disable;
  1194				};
  1195	
  1196				blsp1_i2c2_sleep: blsp1-i2c2-sleep-state-state {
  1197					pins = "gpio32", "gpio33";
  1198					function = "blsp_i2c2";
  1199					drive-strength = <2>;
  1200					bias-pull-up;
  1201				};
  1202	
  1203				blsp1_i2c3_default: blsp1-i2c3-default-state {
  1204					pins = "gpio47", "gpio48";
  1205					function = "blsp_i2c3";
  1206					drive-strength = <2>;
  1207					bias-disable;
  1208				};
  1209	
  1210				blsp1_i2c3_sleep: blsp1-i2c3-sleep-state {
  1211					pins = "gpio47", "gpio48";
  1212					function = "blsp_i2c3";
  1213					drive-strength = <2>;
  1214					bias-pull-up;
  1215				};
  1216	
  1217				blsp1_i2c4_default: blsp1-i2c4-default-state {
  1218					pins = "gpio10", "gpio11";
  1219					function = "blsp_i2c4";
  1220					drive-strength = <2>;
  1221					bias-disable;
  1222				};
  1223	
  1224				blsp1_i2c4_sleep: blsp1-i2c4-sleep-state {
  1225					pins = "gpio10", "gpio11";
  1226					function = "blsp_i2c4";
  1227					drive-strength = <2>;
  1228					bias-pull-up;
  1229				};
  1230	
  1231				blsp1_i2c5_default: blsp1-i2c5-default-state {
  1232					pins = "gpio87", "gpio88";
  1233					function = "blsp_i2c5";
  1234					drive-strength = <2>;
  1235					bias-disable;
  1236				};
  1237	
  1238				blsp1_i2c5_sleep: blsp1-i2c5-sleep-state {
  1239					pins = "gpio87", "gpio88";
  1240					function = "blsp_i2c5";
  1241					drive-strength = <2>;
  1242					bias-pull-up;
  1243				};
  1244	
  1245				blsp1_i2c6_default: blsp1-i2c6-default-state {
  1246					pins = "gpio43", "gpio44";
  1247					function = "blsp_i2c6";
  1248					drive-strength = <2>;
  1249					bias-disable;
  1250				};
  1251	
  1252				blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
  1253					pins = "gpio43", "gpio44";
  1254					function = "blsp_i2c6";
  1255					drive-strength = <2>;
  1256					bias-pull-up;
  1257				};
  1258	
  1259				blsp1_spi_b_default: blsp1-spi-b-default-state {
  1260					pins = "gpio23", "gpio28";
  1261					function = "blsp1_spi_b";
  1262					drive-strength = <6>;
  1263					bias-disable;
  1264				};
  1265	
  1266				blsp1_spi1_default: blsp1-spi1-default-state {
  1267					pins = "gpio0", "gpio1", "gpio2", "gpio3";
  1268					function = "blsp_spi1";
  1269					drive-strength = <6>;
  1270					bias-disable;
  1271				};
  1272	
  1273				blsp1_spi2_default: blsp1-spi2-default-state {
  1274					pins = "gpio31", "gpio34", "gpio32", "gpio33";
  1275					function = "blsp_spi2";
  1276					drive-strength = <6>;
  1277					bias-disable;
  1278				};
  1279	
  1280				blsp1_spi3_default: blsp1-spi3-default-state {
  1281					pins = "gpio45", "gpio46", "gpio47", "gpio48";
  1282					function = "blsp_spi2";
  1283					drive-strength = <6>;
  1284					bias-disable;
  1285				};
  1286	
  1287				blsp1_spi4_default: blsp1-spi4-default-state {
  1288					pins = "gpio8", "gpio9", "gpio10", "gpio11";
  1289					function = "blsp_spi4";
  1290					drive-strength = <6>;
  1291					bias-disable;
  1292				};
  1293	
  1294				blsp1_spi5_default: blsp1-spi5-default-state {
  1295					pins = "gpio85", "gpio86", "gpio87", "gpio88";
  1296					function = "blsp_spi5";
  1297					drive-strength = <6>;
  1298					bias-disable;
  1299				};
  1300	
  1301				blsp1_spi6_default: blsp1-spi6-default-state {
  1302					pins = "gpio41", "gpio42", "gpio43", "gpio44";
  1303					function = "blsp_spi6";
  1304					drive-strength = <6>;
  1305					bias-disable;
  1306				};
  1307	
  1308	
  1309				/* 6 interfaces per QUP, BLSP2 indexes are numbered (n)+6 */
  1310				blsp2_i2c1_default: blsp2-i2c1-default-state {
  1311					pins = "gpio55", "gpio56";
  1312					function = "blsp_i2c7";
  1313					drive-strength = <2>;
  1314					bias-disable;
  1315				};
  1316	
  1317				blsp2_i2c1_sleep: blsp2-i2c1-sleep-state {
  1318					pins = "gpio55", "gpio56";
  1319					function = "blsp_i2c7";
  1320					drive-strength = <2>;
  1321					bias-pull-up;
  1322				};
  1323	
  1324				blsp2_i2c2_default: blsp2-i2c2-default-state {
  1325					pins = "gpio6", "gpio7";
  1326					function = "blsp_i2c8";
  1327					drive-strength = <2>;
  1328					bias-disable;
  1329				};
  1330	
  1331				blsp2_i2c2_sleep: blsp2-i2c2-sleep-state {
  1332					pins = "gpio6", "gpio7";
  1333					function = "blsp_i2c8";
  1334					drive-strength = <2>;
  1335					bias-pull-up;
  1336				};
  1337	
  1338				blsp2_i2c3_default: blsp2-i2c3-default-state {
  1339					pins = "gpio51", "gpio52";
  1340					function = "blsp_i2c9";
  1341					drive-strength = <2>;
  1342					bias-disable;
  1343				};
  1344	
  1345				blsp2_i2c3_sleep: blsp2-i2c3-sleep-state {
  1346					pins = "gpio51", "gpio52";
  1347					function = "blsp_i2c9";
  1348					drive-strength = <2>;
  1349					bias-pull-up;
  1350				};
  1351	
  1352				blsp2_i2c4_default: blsp2-i2c4-default-state {
  1353					pins = "gpio67", "gpio68";
  1354					function = "blsp_i2c10";
  1355					drive-strength = <2>;
  1356					bias-disable;
  1357				};
  1358	
  1359				blsp2_i2c4_sleep: blsp2-i2c4-sleep-state {
  1360					pins = "gpio67", "gpio68";
  1361					function = "blsp_i2c10";
  1362					drive-strength = <2>;
  1363					bias-pull-up;
  1364				};
  1365	
  1366				blsp2_i2c5_default: blsp2-i2c5-default-state {
  1367					pins = "gpio60", "gpio61";
  1368					function = "blsp_i2c11";
  1369					drive-strength = <2>;
  1370					bias-disable;
  1371				};
  1372	
  1373				blsp2_i2c5_sleep: blsp2-i2c5-sleep-state {
  1374					pins = "gpio60", "gpio61";
  1375					function = "blsp_i2c11";
  1376					drive-strength = <2>;
  1377					bias-pull-up;
  1378				};
  1379	
  1380				blsp2_i2c6_default: blsp2-i2c6-default-state {
  1381					pins = "gpio83", "gpio84";
  1382					function = "blsp_i2c12";
  1383					drive-strength = <2>;
  1384					bias-disable;
  1385				};
  1386	
  1387				blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
  1388					pins = "gpio83", "gpio84";
  1389					function = "blsp_i2c12";
  1390					drive-strength = <2>;
  1391					bias-pull-up;
  1392				};
  1393	
  1394				blsp2_spi1_default: blsp2-spi1-default-state {
  1395					pins = "gpio53", "gpio54", "gpio55", "gpio56";
  1396					function = "blsp_spi7";
  1397					drive-strength = <6>;
  1398					bias-disable;
  1399				};
  1400	
  1401				blsp2_spi2_default: blsp2-spi2-default-state {
  1402					pins = "gpio4", "gpio5", "gpio6", "gpio7";
  1403					function = "blsp_spi8";
  1404					drive-strength = <6>;
  1405					bias-disable;
  1406				};
  1407	
  1408				blsp2_spi3_default: blsp2-spi3-default-state {
  1409					pins = "gpio49", "gpio50", "gpio51", "gpio52";
  1410					function = "blsp_spi9";
  1411					drive-strength = <6>;
  1412					bias-disable;
  1413				};
  1414	
  1415				blsp2_spi4_default: blsp2-spi4-default-state {
  1416					pins = "gpio65", "gpio66", "gpio67", "gpio68";
  1417					function = "blsp_spi10";
  1418					drive-strength = <6>;
  1419					bias-disable;
  1420				};
  1421	
  1422				blsp2_spi5_default: blsp2-spi5-default-state {
  1423					pins = "gpio58", "gpio59", "gpio60", "gpio61";
  1424					function = "blsp_spi11";
  1425					drive-strength = <6>;
  1426					bias-disable;
  1427				};
  1428	
  1429				blsp2_spi6_default: blsp2-spi6-default-state {
  1430					pins = "gpio81", "gpio82", "gpio83", "gpio84";
  1431					function = "blsp_spi12";
  1432					drive-strength = <6>;
  1433					bias-disable;
  1434				};
  1435			};
  1436	
  1437			remoteproc_mss: remoteproc@4080000 {
  1438				compatible = "qcom,msm8998-mss-pil";
  1439				reg = <0x04080000 0x100>, <0x04180000 0x20>;
  1440				reg-names = "qdsp6", "rmb";
  1441	
  1442				interrupts-extended =
  1443					<&intc GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
  1444					<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
  1445					<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
  1446					<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
  1447					<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
  1448					<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
  1449				interrupt-names = "wdog", "fatal", "ready",
  1450						  "handover", "stop-ack",
  1451						  "shutdown-ack";
  1452	
  1453				clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
  1454					 <&gcc GCC_BIMC_MSS_Q6_AXI_CLK>,
  1455					 <&gcc GCC_BOOT_ROM_AHB_CLK>,
  1456					 <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
  1457					 <&gcc GCC_MSS_SNOC_AXI_CLK>,
  1458					 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
  1459					 <&rpmcc RPM_SMD_QDSS_CLK>,
  1460					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
  1461				clock-names = "iface", "bus", "mem", "gpll0_mss",
  1462					      "snoc_axi", "mnoc_axi", "qdss", "xo";
  1463	
  1464				qcom,smem-states = <&modem_smp2p_out 0>;
  1465				qcom,smem-state-names = "stop";
  1466	
  1467				resets = <&gcc GCC_MSS_RESTART>;
  1468				reset-names = "mss_restart";
  1469	
  1470				qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
  1471	
  1472				power-domains = <&rpmpd MSM8998_VDDCX>,
  1473						<&rpmpd MSM8998_VDDMX>;
  1474				power-domain-names = "cx", "mx";
  1475	
  1476				status = "disabled";
  1477	
  1478				mba {
  1479					memory-region = <&mba_mem>;
  1480				};
  1481	
  1482				mpss {
  1483					memory-region = <&mpss_mem>;
  1484				};
  1485	
  1486				metadata {
  1487					memory-region = <&mdata_mem>;
  1488				};
  1489	
  1490				glink-edge {
  1491					interrupts = <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>;
  1492					label = "modem";
  1493					qcom,remote-pid = <1>;
  1494					mboxes = <&apcs_glb 15>;
  1495				};
  1496			};
  1497	
  1498			adreno_gpu: gpu@5000000 {
  1499				compatible = "qcom,adreno-540.1", "qcom,adreno";
  1500				reg = <0x05000000 0x40000>;
  1501				reg-names = "kgsl_3d0_reg_memory";
  1502	
  1503				clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
  1504					<&gpucc RBBMTIMER_CLK>,
  1505					<&gcc GCC_BIMC_GFX_CLK>,
  1506					<&gcc GCC_GPU_BIMC_GFX_CLK>,
  1507					<&gpucc RBCPR_CLK>,
  1508					<&gpucc GFX3D_CLK>;
  1509				clock-names = "iface",
  1510					"rbbmtimer",
  1511					"mem",
  1512					"mem_iface",
  1513					"rbcpr",
  1514					"core";
  1515	
  1516				interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
  1517				iommus = <&adreno_smmu 0>;
  1518				operating-points-v2 = <&gpu_opp_table>;
  1519				power-domains = <&rpmpd MSM8998_VDDMX>;
  1520				status = "disabled";
  1521	
  1522				gpu_opp_table: opp-table {
  1523					compatible = "operating-points-v2";
  1524					opp-710000097 {
  1525						opp-hz = /bits/ 64 <710000097>;
  1526						opp-level = <RPM_SMD_LEVEL_TURBO>;
  1527						opp-supported-hw = <0xff>;
  1528					};
  1529	
  1530					opp-670000048 {
  1531						opp-hz = /bits/ 64 <670000048>;
  1532						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
  1533						opp-supported-hw = <0xff>;
  1534					};
  1535	
  1536					opp-596000097 {
  1537						opp-hz = /bits/ 64 <596000097>;
  1538						opp-level = <RPM_SMD_LEVEL_NOM>;
  1539						opp-supported-hw = <0xff>;
  1540					};
  1541	
  1542					opp-515000097 {
  1543						opp-hz = /bits/ 64 <515000097>;
  1544						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
  1545						opp-supported-hw = <0xff>;
  1546					};
  1547	
  1548					opp-414000000 {
  1549						opp-hz = /bits/ 64 <414000000>;
  1550						opp-level = <RPM_SMD_LEVEL_SVS>;
  1551						opp-supported-hw = <0xff>;
  1552					};
  1553	
  1554					opp-342000000 {
  1555						opp-hz = /bits/ 64 <342000000>;
  1556						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
  1557						opp-supported-hw = <0xff>;
  1558					};
  1559	
  1560					opp-257000000 {
  1561						opp-hz = /bits/ 64 <257000000>;
  1562						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
  1563						opp-supported-hw = <0xff>;
  1564					};
  1565				};
  1566			};
  1567	
  1568			adreno_smmu: iommu@5040000 {
  1569				compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
  1570				reg = <0x05040000 0x10000>;
  1571				clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
  1572					 <&gcc GCC_BIMC_GFX_CLK>,
  1573					 <&gcc GCC_GPU_BIMC_GFX_CLK>;
  1574				clock-names = "iface", "mem", "mem_iface";
  1575	
  1576				#global-interrupts = <0>;
  1577				#iommu-cells = <1>;
  1578				interrupts =
  1579					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
  1580					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
  1581					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
  1582				/*
  1583				 * GPU-GX GDSC's parent is GPU-CX. We need to bring up the
  1584				 * GPU-CX for SMMU but we need both of them up for Adreno.
  1585				 * Contemporarily, we also need to manage the VDDMX rpmpd
  1586				 * domain in the Adreno driver.
  1587				 * Enable GPU CX/GX GDSCs here so that we can manage the
  1588				 * SoC VDDMX RPM Power Domain in the Adreno driver.
  1589				 */
  1590				power-domains = <&gpucc GPU_GX_GDSC>;
  1591				status = "disabled";
  1592			};
  1593	
  1594			gpucc: clock-controller@5065000 {
  1595				compatible = "qcom,msm8998-gpucc";
  1596				#clock-cells = <1>;
  1597				#reset-cells = <1>;
  1598				#power-domain-cells = <1>;
  1599				reg = <0x05065000 0x9000>;
  1600	
  1601				clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
  1602					 <&gcc GCC_GPU_GPLL0_CLK>;
  1603				clock-names = "xo",
  1604					      "gpll0";
  1605			};
  1606	
  1607			remoteproc_slpi: remoteproc@5800000 {
  1608				compatible = "qcom,msm8998-slpi-pas";
  1609				reg = <0x05800000 0x4040>;
  1610	
  1611				interrupts-extended = <&intc GIC_SPI 390 IRQ_TYPE_EDGE_RISING>,
  1612						      <&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
  1613						      <&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
  1614						      <&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
  1615						      <&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
  1616				interrupt-names = "wdog", "fatal", "ready",
  1617						  "handover", "stop-ack";
  1618	
  1619				px-supply = <&vreg_lvs2a_1p8>;
  1620	
  1621				clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
  1622					 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
  1623				clock-names = "xo", "aggre2";
  1624	
  1625				memory-region = <&slpi_mem>;
  1626	
  1627				qcom,smem-states = <&slpi_smp2p_out 0>;
  1628				qcom,smem-state-names = "stop";
  1629	
  1630				power-domains = <&rpmpd MSM8998_SSCCX>;
  1631				power-domain-names = "ssc_cx";
  1632	
  1633				status = "disabled";
  1634	
  1635				glink-edge {
  1636					interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
  1637					label = "dsps";
  1638					qcom,remote-pid = <3>;
  1639					mboxes = <&apcs_glb 27>;
  1640				};
  1641			};
  1642	
  1643			stm: stm@6002000 {
  1644				compatible = "arm,coresight-stm", "arm,primecell";
  1645				reg = <0x06002000 0x1000>,
  1646				      <0x16280000 0x180000>;
  1647				reg-names = "stm-base", "stm-stimulus-base";
  1648				status = "disabled";
  1649	
  1650				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1651				clock-names = "apb_pclk", "atclk";
  1652	
  1653				out-ports {
  1654					port {
  1655						stm_out: endpoint {
  1656							remote-endpoint = <&funnel0_in7>;
  1657						};
  1658					};
  1659				};
  1660			};
  1661	
  1662			funnel1: funnel@6041000 {
  1663				compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
  1664				reg = <0x06041000 0x1000>;
  1665				status = "disabled";
  1666	
  1667				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1668				clock-names = "apb_pclk", "atclk";
  1669	
  1670				out-ports {
  1671					port {
  1672						funnel0_out: endpoint {
  1673							remote-endpoint =
  1674							  <&merge_funnel_in0>;
  1675						};
  1676					};
  1677				};
  1678	
  1679				in-ports {
  1680					#address-cells = <1>;
  1681					#size-cells = <0>;
  1682	
  1683					port@7 {
  1684						reg = <7>;
  1685						funnel0_in7: endpoint {
  1686							remote-endpoint = <&stm_out>;
  1687						};
  1688					};
  1689				};
  1690			};
  1691	
  1692			funnel2: funnel@6042000 {
  1693				compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
  1694				reg = <0x06042000 0x1000>;
  1695				status = "disabled";
  1696	
  1697				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1698				clock-names = "apb_pclk", "atclk";
  1699	
  1700				out-ports {
  1701					port {
  1702						funnel1_out: endpoint {
  1703							remote-endpoint =
  1704							  <&merge_funnel_in1>;
  1705						};
  1706					};
  1707				};
  1708	
  1709				in-ports {
  1710					#address-cells = <1>;
  1711					#size-cells = <0>;
  1712	
  1713					port@6 {
  1714						reg = <6>;
  1715						funnel1_in6: endpoint {
  1716							remote-endpoint =
  1717							  <&apss_merge_funnel_out>;
  1718						};
  1719					};
  1720				};
  1721			};
  1722	
  1723			funnel3: funnel@6045000 {
  1724				compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
  1725				reg = <0x06045000 0x1000>;
  1726				status = "disabled";
  1727	
  1728				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1729				clock-names = "apb_pclk", "atclk";
  1730	
  1731				out-ports {
  1732					port {
  1733						merge_funnel_out: endpoint {
  1734							remote-endpoint =
  1735							  <&etf_in>;
  1736						};
  1737					};
  1738				};
  1739	
  1740				in-ports {
  1741					#address-cells = <1>;
  1742					#size-cells = <0>;
  1743	
  1744					port@0 {
  1745						reg = <0>;
  1746						merge_funnel_in0: endpoint {
  1747							remote-endpoint =
  1748							  <&funnel0_out>;
  1749						};
  1750					};
  1751	
  1752					port@1 {
  1753						reg = <1>;
  1754						merge_funnel_in1: endpoint {
  1755							remote-endpoint =
  1756							  <&funnel1_out>;
  1757						};
  1758					};
  1759				};
  1760			};
  1761	
  1762			replicator1: replicator@6046000 {
  1763				compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
  1764				reg = <0x06046000 0x1000>;
  1765				status = "disabled";
  1766	
  1767				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1768				clock-names = "apb_pclk", "atclk";
  1769	
  1770				out-ports {
  1771					port {
  1772						replicator_out: endpoint {
  1773							remote-endpoint = <&etr_in>;
  1774						};
  1775					};
  1776				};
  1777	
  1778				in-ports {
  1779					port {
  1780						replicator_in: endpoint {
  1781							remote-endpoint = <&etf_out>;
  1782						};
  1783					};
  1784				};
  1785			};
  1786	
  1787			etf: etf@6047000 {
  1788				compatible = "arm,coresight-tmc", "arm,primecell";
  1789				reg = <0x06047000 0x1000>;
  1790				status = "disabled";
  1791	
  1792				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1793				clock-names = "apb_pclk", "atclk";
  1794	
  1795				out-ports {
  1796					port {
  1797						etf_out: endpoint {
  1798							remote-endpoint =
  1799							  <&replicator_in>;
  1800						};
  1801					};
  1802				};
  1803	
  1804				in-ports {
  1805					port {
  1806						etf_in: endpoint {
  1807							remote-endpoint =
  1808							  <&merge_funnel_out>;
  1809						};
  1810					};
  1811				};
  1812			};
  1813	
  1814			etr: etr@6048000 {
  1815				compatible = "arm,coresight-tmc", "arm,primecell";
  1816				reg = <0x06048000 0x1000>;
  1817				status = "disabled";
  1818	
  1819				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1820				clock-names = "apb_pclk", "atclk";
  1821				arm,scatter-gather;
  1822	
  1823				in-ports {
  1824					port {
  1825						etr_in: endpoint {
  1826							remote-endpoint =
  1827							  <&replicator_out>;
  1828						};
  1829					};
  1830				};
  1831			};
  1832	
  1833			etm1: etm@7840000 {
  1834				compatible = "arm,coresight-etm4x", "arm,primecell";
  1835				reg = <0x07840000 0x1000>;
  1836				status = "disabled";
  1837	
  1838				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1839				clock-names = "apb_pclk", "atclk";
  1840	
  1841				cpu = <&CPU0>;
  1842	
  1843				out-ports {
  1844					port {
  1845						etm0_out: endpoint {
  1846							remote-endpoint =
  1847							  <&apss_funnel_in0>;
  1848						};
  1849					};
  1850				};
  1851			};
  1852	
  1853			etm2: etm@7940000 {
  1854				compatible = "arm,coresight-etm4x", "arm,primecell";
  1855				reg = <0x07940000 0x1000>;
  1856				status = "disabled";
  1857	
  1858				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1859				clock-names = "apb_pclk", "atclk";
  1860	
  1861				cpu = <&CPU1>;
  1862	
  1863				out-ports {
  1864					port {
  1865						etm1_out: endpoint {
  1866							remote-endpoint =
  1867							  <&apss_funnel_in1>;
  1868						};
  1869					};
  1870				};
  1871			};
  1872	
  1873			etm3: etm@7a40000 {
  1874				compatible = "arm,coresight-etm4x", "arm,primecell";
  1875				reg = <0x07a40000 0x1000>;
  1876				status = "disabled";
  1877	
  1878				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1879				clock-names = "apb_pclk", "atclk";
  1880	
  1881				cpu = <&CPU2>;
  1882	
  1883				out-ports {
  1884					port {
  1885						etm2_out: endpoint {
  1886							remote-endpoint =
  1887							  <&apss_funnel_in2>;
  1888						};
  1889					};
  1890				};
  1891			};
  1892	
  1893			etm4: etm@7b40000 {
  1894				compatible = "arm,coresight-etm4x", "arm,primecell";
  1895				reg = <0x07b40000 0x1000>;
  1896				status = "disabled";
  1897	
  1898				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1899				clock-names = "apb_pclk", "atclk";
  1900	
  1901				cpu = <&CPU3>;
  1902	
  1903				out-ports {
  1904					port {
  1905						etm3_out: endpoint {
  1906							remote-endpoint =
  1907							  <&apss_funnel_in3>;
  1908						};
  1909					};
  1910				};
  1911			};
  1912	
  1913			funnel4: funnel@7b60000 { /* APSS Funnel */
  1914				compatible = "arm,coresight-etm4x", "arm,primecell";
  1915				reg = <0x07b60000 0x1000>;
  1916				status = "disabled";
  1917	
  1918				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  1919				clock-names = "apb_pclk", "atclk";
  1920	
  1921				out-ports {
  1922					port {
  1923						apss_funnel_out: endpoint {
  1924							remote-endpoint =
  1925							  <&apss_merge_funnel_in>;
  1926						};
  1927					};
  1928				};
  1929	
  1930				in-ports {
  1931					#address-cells = <1>;
  1932					#size-cells = <0>;
  1933	
  1934					port@0 {
  1935						reg = <0>;
  1936						apss_funnel_in0: endpoint {
  1937							remote-endpoint =
  1938							  <&etm0_out>;
  1939						};
  1940					};
  1941	
  1942					port@1 {
  1943						reg = <1>;
  1944						apss_funnel_in1: endpoint {
  1945							remote-endpoint =
  1946							  <&etm1_out>;
  1947						};
  1948					};
  1949	
  1950					port@2 {
  1951						reg = <2>;
  1952						apss_funnel_in2: endpoint {
  1953							remote-endpoint =
  1954							  <&etm2_out>;
  1955						};
  1956					};
  1957	
  1958					port@3 {
  1959						reg = <3>;
  1960						apss_funnel_in3: endpoint {
  1961							remote-endpoint =
  1962							  <&etm3_out>;
  1963						};
  1964					};
  1965	
  1966					port@4 {
  1967						reg = <4>;
  1968						apss_funnel_in4: endpoint {
  1969							remote-endpoint =
  1970							  <&etm4_out>;
  1971						};
  1972					};
  1973	
  1974					port@5 {
  1975						reg = <5>;
  1976						apss_funnel_in5: endpoint {
  1977							remote-endpoint =
  1978							  <&etm5_out>;
  1979						};
  1980					};
  1981	
  1982					port@6 {
  1983						reg = <6>;
  1984						apss_funnel_in6: endpoint {
  1985							remote-endpoint =
  1986							  <&etm6_out>;
  1987						};
  1988					};
  1989	
  1990					port@7 {
  1991						reg = <7>;
  1992						apss_funnel_in7: endpoint {
  1993							remote-endpoint =
  1994							  <&etm7_out>;
  1995						};
  1996					};
  1997				};
  1998			};
  1999	
  2000			funnel5: funnel@7b70000 {
  2001				compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
  2002				reg = <0x07b70000 0x1000>;
  2003				status = "disabled";
  2004	
  2005				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  2006				clock-names = "apb_pclk", "atclk";
  2007	
  2008				out-ports {
  2009					port {
  2010						apss_merge_funnel_out: endpoint {
  2011							remote-endpoint =
  2012							  <&funnel1_in6>;
  2013						};
  2014					};
  2015				};
  2016	
  2017				in-ports {
  2018					port {
  2019						apss_merge_funnel_in: endpoint {
  2020							remote-endpoint =
  2021							  <&apss_funnel_out>;
  2022						};
  2023					};
  2024				};
  2025			};
  2026	
  2027			etm5: etm@7c40000 {
  2028				compatible = "arm,coresight-etm4x", "arm,primecell";
  2029				reg = <0x07c40000 0x1000>;
  2030				status = "disabled";
  2031	
  2032				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  2033				clock-names = "apb_pclk", "atclk";
  2034	
  2035				cpu = <&CPU4>;
  2036	
  2037				port {
  2038					etm4_out: endpoint {
  2039						remote-endpoint = <&apss_funnel_in4>;
  2040					};
  2041				};
  2042			};
  2043	
  2044			etm6: etm@7d40000 {
  2045				compatible = "arm,coresight-etm4x", "arm,primecell";
  2046				reg = <0x07d40000 0x1000>;
  2047				status = "disabled";
  2048	
  2049				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  2050				clock-names = "apb_pclk", "atclk";
  2051	
  2052				cpu = <&CPU5>;
  2053	
  2054				port {
  2055					etm5_out: endpoint {
  2056						remote-endpoint = <&apss_funnel_in5>;
  2057					};
  2058				};
  2059			};
  2060	
  2061			etm7: etm@7e40000 {
  2062				compatible = "arm,coresight-etm4x", "arm,primecell";
  2063				reg = <0x07e40000 0x1000>;
  2064				status = "disabled";
  2065	
  2066				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  2067				clock-names = "apb_pclk", "atclk";
  2068	
  2069				cpu = <&CPU6>;
  2070	
  2071				port {
  2072					etm6_out: endpoint {
  2073						remote-endpoint = <&apss_funnel_in6>;
  2074					};
  2075				};
  2076			};
  2077	
  2078			etm8: etm@7f40000 {
  2079				compatible = "arm,coresight-etm4x", "arm,primecell";
  2080				reg = <0x07f40000 0x1000>;
  2081				status = "disabled";
  2082	
  2083				clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
  2084				clock-names = "apb_pclk", "atclk";
  2085	
  2086				cpu = <&CPU7>;
  2087	
  2088				port {
  2089					etm7_out: endpoint {
  2090						remote-endpoint = <&apss_funnel_in7>;
  2091					};
  2092				};
  2093			};
  2094	
  2095			sram@290000 {
  2096				compatible = "qcom,rpm-stats";
  2097				reg = <0x00290000 0x10000>;
  2098			};
  2099	
  2100			spmi_bus: spmi@800f000 {
  2101				compatible = "qcom,spmi-pmic-arb";
  2102				reg = <0x0800f000 0x1000>,
  2103				      <0x08400000 0x1000000>,
  2104				      <0x09400000 0x1000000>,
  2105				      <0x0a400000 0x220000>,
  2106				      <0x0800a000 0x3000>;
  2107				reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
  2108				interrupt-names = "periph_irq";
  2109				interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
  2110				qcom,ee = <0>;
  2111				qcom,channel = <0>;
  2112				#address-cells = <2>;
  2113				#size-cells = <0>;
  2114				interrupt-controller;
  2115				#interrupt-cells = <4>;
  2116			};
  2117	
  2118			usb3: usb@a8f8800 {
  2119				compatible = "qcom,msm8998-dwc3", "qcom,dwc3";
  2120				reg = <0x0a8f8800 0x400>;
  2121				status = "disabled";
  2122				#address-cells = <1>;
  2123				#size-cells = <1>;
  2124				ranges;
  2125	
  2126				clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
  2127					 <&gcc GCC_USB30_MASTER_CLK>,
  2128					 <&gcc GCC_AGGRE1_USB3_AXI_CLK>,
  2129					 <&gcc GCC_USB30_SLEEP_CLK>,
  2130					 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
  2131				clock-names = "cfg_noc",
  2132					      "core",
  2133					      "iface",
  2134					      "sleep",
  2135					      "mock_utmi";
  2136	
  2137				assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
  2138						  <&gcc GCC_USB30_MASTER_CLK>;
  2139				assigned-clock-rates = <19200000>, <120000000>;
  2140	
  2141				interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
  2142					     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
  2143				interrupt-names = "hs_phy_irq", "ss_phy_irq";
  2144	
  2145				power-domains = <&gcc USB_30_GDSC>;
  2146	
  2147				resets = <&gcc GCC_USB_30_BCR>;
  2148	
  2149				usb3_dwc3: usb@a800000 {
  2150					compatible = "snps,dwc3";
  2151					reg = <0x0a800000 0xcd00>;
  2152					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
  2153					snps,dis_u2_susphy_quirk;
  2154					snps,dis_enblslpm_quirk;
  2155					phys = <&qusb2phy>, <&usb1_ssphy>;
  2156					phy-names = "usb2-phy", "usb3-phy";
  2157					snps,has-lpm-erratum;
  2158					snps,hird-threshold = /bits/ 8 <0x10>;
  2159				};
  2160			};
  2161	
  2162			usb3phy: phy@c010000 {
  2163				compatible = "qcom,msm8998-qmp-usb3-phy";
  2164				reg = <0x0c010000 0x18c>;
  2165				status = "disabled";
  2166				#address-cells = <1>;
  2167				#size-cells = <1>;
  2168				ranges;
  2169	
  2170				clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
  2171					 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
  2172					 <&gcc GCC_USB3_CLKREF_CLK>;
  2173				clock-names = "aux", "cfg_ahb", "ref";
  2174	
  2175				resets = <&gcc GCC_USB3_PHY_BCR>,
  2176					 <&gcc GCC_USB3PHY_PHY_BCR>;
  2177				reset-names = "phy", "common";
  2178	
  2179				usb1_ssphy: phy@c010200 {
  2180					reg = <0xc010200 0x128>,
  2181					      <0xc010400 0x200>,
  2182					      <0xc010c00 0x20c>,
  2183					      <0xc010600 0x128>,
  2184					      <0xc010800 0x200>;
  2185					#phy-cells = <0>;
  2186					#clock-cells = <0>;
  2187					clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
  2188					clock-names = "pipe0";
  2189					clock-output-names = "usb3_phy_pipe_clk_src";
  2190				};
  2191			};
  2192	
  2193			qusb2phy: phy@c012000 {
  2194				compatible = "qcom,msm8998-qusb2-phy";
  2195				reg = <0x0c012000 0x2a8>;
  2196				status = "disabled";
  2197				#phy-cells = <0>;
  2198	
  2199				clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
  2200					 <&gcc GCC_RX1_USB2_CLKREF_CLK>;
  2201				clock-names = "cfg_ahb", "ref";
  2202	
  2203				resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
  2204	
  2205				nvmem-cells = <&qusb2_hstx_trim>;
  2206			};
  2207	
  2208			sdhc2: mmc@c0a4900 {
  2209				compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
  2210				reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
  2211				reg-names = "hc", "core";
  2212	
  2213				interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
  2214					     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
  2215				interrupt-names = "hc_irq", "pwr_irq";
  2216	
  2217				clock-names = "iface", "core", "xo";
  2218				clocks = <&gcc GCC_SDCC2_AHB_CLK>,
  2219					 <&gcc GCC_SDCC2_APPS_CLK>,
  2220					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
  2221				bus-width = <4>;
  2222				status = "disabled";
  2223			};
  2224	
  2225			blsp1_dma: dma-controller@c144000 {
  2226				compatible = "qcom,bam-v1.7.0";
  2227				reg = <0x0c144000 0x25000>;
  2228				interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
  2229				clocks = <&gcc GCC_BLSP1_AHB_CLK>;
  2230				clock-names = "bam_clk";
  2231				#dma-cells = <1>;
  2232				qcom,ee = <0>;
  2233				qcom,controlled-remotely;
  2234				num-channels = <18>;
  2235				qcom,num-ees = <4>;
  2236			};
  2237	
  2238			blsp1_uart3: serial@c171000 {
  2239				compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
  2240				reg = <0x0c171000 0x1000>;
  2241				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
  2242				clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
  2243					 <&gcc GCC_BLSP1_AHB_CLK>;
  2244				clock-names = "core", "iface";
  2245				dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
  2246				dma-names = "tx", "rx";
  2247				pinctrl-names = "default";
  2248				pinctrl-0 = <&blsp1_uart3_on>;
  2249				status = "disabled";
  2250			};
  2251	
  2252			blsp1_i2c1: i2c@c175000 {
  2253				compatible = "qcom,i2c-qup-v2.2.1";
  2254				reg = <0x0c175000 0x600>;
  2255				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
  2256	
  2257				clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
  2258					 <&gcc GCC_BLSP1_AHB_CLK>;
  2259				clock-names = "core", "iface";
  2260				dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
  2261				dma-names = "tx", "rx";
  2262				pinctrl-names = "default", "sleep";
  2263				pinctrl-0 = <&blsp1_i2c1_default>;
  2264				pinctrl-1 = <&blsp1_i2c1_sleep>;
  2265				clock-frequency = <400000>;
  2266	
  2267				status = "disabled";
  2268				#address-cells = <1>;
  2269				#size-cells = <0>;
  2270			};
  2271	
  2272			blsp1_i2c2: i2c@c176000 {
  2273				compatible = "qcom,i2c-qup-v2.2.1";
  2274				reg = <0x0c176000 0x600>;
  2275				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
  2276	
  2277				clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
  2278					 <&gcc GCC_BLSP1_AHB_CLK>;
  2279				clock-names = "core", "iface";
  2280				dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
  2281				dma-names = "tx", "rx";
  2282				pinctrl-names = "default", "sleep";
  2283				pinctrl-0 = <&blsp1_i2c2_default>;
  2284				pinctrl-1 = <&blsp1_i2c2_sleep>;
  2285				clock-frequency = <400000>;
  2286	
  2287				status = "disabled";
  2288				#address-cells = <1>;
  2289				#size-cells = <0>;
  2290			};
  2291	
  2292			blsp1_i2c3: i2c@c177000 {
  2293				compatible = "qcom,i2c-qup-v2.2.1";
  2294				reg = <0x0c177000 0x600>;
  2295				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
  2296	
  2297				clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
  2298					 <&gcc GCC_BLSP1_AHB_CLK>;
  2299				clock-names = "core", "iface";
  2300				dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
  2301				dma-names = "tx", "rx";
  2302				pinctrl-names = "default", "sleep";
  2303				pinctrl-0 = <&blsp1_i2c3_default>;
  2304				pinctrl-1 = <&blsp1_i2c3_sleep>;
  2305				clock-frequency = <400000>;
  2306	
  2307				status = "disabled";
  2308				#address-cells = <1>;
  2309				#size-cells = <0>;
  2310			};
  2311	
  2312			blsp1_i2c4: i2c@c178000 {
  2313				compatible = "qcom,i2c-qup-v2.2.1";
  2314				reg = <0x0c178000 0x600>;
  2315				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
  2316	
  2317				clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
  2318					 <&gcc GCC_BLSP1_AHB_CLK>;
  2319				clock-names = "core", "iface";
  2320				dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
  2321				dma-names = "tx", "rx";
  2322				pinctrl-names = "default", "sleep";
  2323				pinctrl-0 = <&blsp1_i2c4_default>;
  2324				pinctrl-1 = <&blsp1_i2c4_sleep>;
  2325				clock-frequency = <400000>;
  2326	
  2327				status = "disabled";
  2328				#address-cells = <1>;
  2329				#size-cells = <0>;
  2330			};
  2331	
  2332			blsp1_i2c5: i2c@c179000 {
  2333				compatible = "qcom,i2c-qup-v2.2.1";
  2334				reg = <0x0c179000 0x600>;
  2335				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
  2336	
  2337				clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
  2338					 <&gcc GCC_BLSP1_AHB_CLK>;
  2339				clock-names = "core", "iface";
  2340				dmas = <&blsp1_dma 14>, <&blsp1_dma 15>;
  2341				dma-names = "tx", "rx";
  2342				pinctrl-names = "default", "sleep";
  2343				pinctrl-0 = <&blsp1_i2c5_default>;
  2344				pinctrl-1 = <&blsp1_i2c5_sleep>;
  2345				clock-frequency = <400000>;
  2346	
  2347				status = "disabled";
  2348				#address-cells = <1>;
  2349				#size-cells = <0>;
  2350			};
  2351	
  2352			blsp1_i2c6: i2c@c17a000 {
  2353				compatible = "qcom,i2c-qup-v2.2.1";
  2354				reg = <0x0c17a000 0x600>;
  2355				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
  2356	
  2357				clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
  2358					 <&gcc GCC_BLSP1_AHB_CLK>;
  2359				clock-names = "core", "iface";
  2360				dmas = <&blsp1_dma 16>, <&blsp1_dma 17>;
  2361				dma-names = "tx", "rx";
  2362				pinctrl-names = "default", "sleep";
  2363				pinctrl-0 = <&blsp1_i2c6_default>;
  2364				pinctrl-1 = <&blsp1_i2c6_sleep>;
  2365				clock-frequency = <400000>;
  2366	
  2367				status = "disabled";
  2368				#address-cells = <1>;
  2369				#size-cells = <0>;
  2370			};
  2371	
  2372			blsp1_spi1: spi@c175000 {
  2373				compatible = "qcom,spi-qup-v2.2.1";
  2374				reg = <0x0c175000 0x600>;
  2375				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
  2376	
  2377				clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
  2378					 <&gcc GCC_BLSP1_AHB_CLK>;
  2379				clock-names = "core", "iface";
  2380				dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
  2381				dma-names = "tx", "rx";
  2382				pinctrl-names = "default";
  2383				pinctrl-0 = <&blsp1_spi1_default>;
  2384	
  2385				status = "disabled";
  2386				#address-cells = <1>;
  2387				#size-cells = <0>;
  2388			};
  2389	
  2390			blsp1_spi2: spi@c176000 {
  2391				compatible = "qcom,spi-qup-v2.2.1";
  2392				reg = <0x0c176000 0x600>;
  2393				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
  2394	
  2395				clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
  2396					 <&gcc GCC_BLSP1_AHB_CLK>;
  2397				clock-names = "core", "iface";
  2398				dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
  2399				dma-names = "tx", "rx";
  2400				pinctrl-names = "default";
  2401				pinctrl-0 = <&blsp1_spi2_default>;
  2402	
  2403				status = "disabled";
  2404				#address-cells = <1>;
  2405				#size-cells = <0>;
  2406			};
  2407	
  2408			blsp1_spi3: spi@c177000 {
  2409				compatible = "qcom,spi-qup-v2.2.1";
  2410				reg = <0x0c177000 0x600>;
  2411				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
  2412	
  2413				clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
  2414					 <&gcc GCC_BLSP1_AHB_CLK>;
  2415				clock-names = "core", "iface";
  2416				dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
  2417				dma-names = "tx", "rx";
  2418				pinctrl-names = "default";
  2419				pinctrl-0 = <&blsp1_spi3_default>;
  2420	
  2421				status = "disabled";
  2422				#address-cells = <1>;
  2423				#size-cells = <0>;
  2424			};
  2425	
  2426			blsp1_spi4: spi@c178000 {
  2427				compatible = "qcom,spi-qup-v2.2.1";
  2428				reg = <0x0c178000 0x600>;
  2429				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
  2430	
  2431				clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
  2432					 <&gcc GCC_BLSP1_AHB_CLK>;
  2433				clock-names = "core", "iface";
  2434				dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
  2435				dma-names = "tx", "rx";
  2436				pinctrl-names = "default";
  2437				pinctrl-0 = <&blsp1_spi4_default>;
  2438	
  2439				status = "disabled";
  2440				#address-cells = <1>;
  2441				#size-cells = <0>;
  2442			};
  2443	
  2444			blsp1_spi5: spi@c179000 {
  2445				compatible = "qcom,spi-qup-v2.2.1";
  2446				reg = <0x0c179000 0x600>;
  2447				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
  2448	
  2449				clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
  2450					 <&gcc GCC_BLSP1_AHB_CLK>;
  2451				clock-names = "core", "iface";
  2452				dmas = <&blsp1_dma 14>, <&blsp1_dma 15>;
  2453				dma-names = "tx", "rx";
  2454				pinctrl-names = "default";
  2455				pinctrl-0 = <&blsp1_spi5_default>;
  2456	
  2457				status = "disabled";
  2458				#address-cells = <1>;
  2459				#size-cells = <0>;
  2460			};
  2461	
  2462			blsp1_spi6: spi@c17a000 {
  2463				compatible = "qcom,spi-qup-v2.2.1";
  2464				reg = <0x0c17a000 0x600>;
  2465				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
  2466	
  2467				clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
  2468					 <&gcc GCC_BLSP1_AHB_CLK>;
  2469				clock-names = "core", "iface";
  2470				dmas = <&blsp1_dma 16>, <&blsp1_dma 17>;
  2471				dma-names = "tx", "rx";
  2472				pinctrl-names = "default";
  2473				pinctrl-0 = <&blsp1_spi6_default>;
  2474	
  2475				status = "disabled";
  2476				#address-cells = <1>;
  2477				#size-cells = <0>;
  2478			};
  2479	
  2480			blsp2_dma: dma-controller@c184000 {
  2481				compatible = "qcom,bam-v1.7.0";
  2482				reg = <0x0c184000 0x25000>;
  2483				interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
  2484				clocks = <&gcc GCC_BLSP2_AHB_CLK>;
  2485				clock-names = "bam_clk";
  2486				#dma-cells = <1>;
  2487				qcom,ee = <0>;
  2488				qcom,controlled-remotely;
  2489				num-channels = <18>;
  2490				qcom,num-ees = <4>;
  2491			};
  2492	
  2493			blsp2_uart1: serial@c1b0000 {
  2494				compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
  2495				reg = <0x0c1b0000 0x1000>;
  2496				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
  2497				clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
  2498					 <&gcc GCC_BLSP2_AHB_CLK>;
  2499				clock-names = "core", "iface";
  2500				status = "disabled";
  2501			};
  2502	
  2503			blsp2_i2c1: i2c@c1b5000 {
  2504				compatible = "qcom,i2c-qup-v2.2.1";
  2505				reg = <0x0c1b5000 0x600>;
  2506				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
  2507	
  2508				clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
  2509					 <&gcc GCC_BLSP2_AHB_CLK>;
  2510				clock-names = "core", "iface";
  2511				dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
  2512				dma-names = "tx", "rx";
  2513				pinctrl-names = "default", "sleep";
  2514				pinctrl-0 = <&blsp2_i2c1_default>;
  2515				pinctrl-1 = <&blsp2_i2c1_sleep>;
  2516				clock-frequency = <400000>;
  2517	
  2518				status = "disabled";
  2519				#address-cells = <1>;
  2520				#size-cells = <0>;
  2521			};
  2522	
  2523			blsp2_i2c2: i2c@c1b6000 {
  2524				compatible = "qcom,i2c-qup-v2.2.1";
  2525				reg = <0x0c1b6000 0x600>;
  2526				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
  2527	
  2528				clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
  2529					 <&gcc GCC_BLSP2_AHB_CLK>;
  2530				clock-names = "core", "iface";
  2531				dmas = <&blsp2_dma 8>, <&blsp2_dma 9>;
  2532				dma-names = "tx", "rx";
  2533				pinctrl-names = "default", "sleep";
  2534				pinctrl-0 = <&blsp2_i2c2_default>;
  2535				pinctrl-1 = <&blsp2_i2c2_sleep>;
  2536				clock-frequency = <400000>;
  2537	
  2538				status = "disabled";
  2539				#address-cells = <1>;
  2540				#size-cells = <0>;
  2541			};
  2542	
  2543			blsp2_i2c3: i2c@c1b7000 {
  2544				compatible = "qcom,i2c-qup-v2.2.1";
  2545				reg = <0x0c1b7000 0x600>;
  2546				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
  2547	
  2548				clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
  2549					 <&gcc GCC_BLSP2_AHB_CLK>;
  2550				clock-names = "core", "iface";
  2551				dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
  2552				dma-names = "tx", "rx";
  2553				pinctrl-names = "default", "sleep";
  2554				pinctrl-0 = <&blsp2_i2c3_default>;
  2555				pinctrl-1 = <&blsp2_i2c3_sleep>;
  2556				clock-frequency = <400000>;
  2557	
  2558				status = "disabled";
  2559				#address-cells = <1>;
  2560				#size-cells = <0>;
  2561			};
  2562	
  2563			blsp2_i2c4: i2c@c1b8000 {
  2564				compatible = "qcom,i2c-qup-v2.2.1";
  2565				reg = <0x0c1b8000 0x600>;
  2566				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
  2567	
  2568				clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
  2569					 <&gcc GCC_BLSP2_AHB_CLK>;
  2570				clock-names = "core", "iface";
  2571				dmas = <&blsp2_dma 12>, <&blsp2_dma 13>;
  2572				dma-names = "tx", "rx";
  2573				pinctrl-names = "default", "sleep";
  2574				pinctrl-0 = <&blsp2_i2c4_default>;
  2575				pinctrl-1 = <&blsp2_i2c4_sleep>;
  2576				clock-frequency = <400000>;
  2577	
  2578				status = "disabled";
  2579				#address-cells = <1>;
  2580				#size-cells = <0>;
  2581			};
  2582	
  2583			blsp2_i2c5: i2c@c1b9000 {
  2584				compatible = "qcom,i2c-qup-v2.2.1";
  2585				reg = <0x0c1b9000 0x600>;
  2586				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
  2587	
  2588				clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>,
  2589					 <&gcc GCC_BLSP2_AHB_CLK>;
  2590				clock-names = "core", "iface";
  2591				dmas = <&blsp2_dma 14>, <&blsp2_dma 15>;
  2592				dma-names = "tx", "rx";
  2593				pinctrl-names = "default", "sleep";
  2594				pinctrl-0 = <&blsp2_i2c5_default>;
  2595				pinctrl-1 = <&blsp2_i2c5_sleep>;
  2596				clock-frequency = <400000>;
  2597	
  2598				status = "disabled";
  2599				#address-cells = <1>;
  2600				#size-cells = <0>;
  2601			};
  2602	
  2603			blsp2_i2c6: i2c@c1ba000 {
  2604				compatible = "qcom,i2c-qup-v2.2.1";
  2605				reg = <0x0c1ba000 0x600>;
  2606				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
  2607	
  2608				clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>,
  2609					 <&gcc GCC_BLSP2_AHB_CLK>;
  2610				clock-names = "core", "iface";
  2611				dmas = <&blsp2_dma 16>, <&blsp2_dma 17>;
  2612				dma-names = "tx", "rx";
  2613				pinctrl-names = "default", "sleep";
  2614				pinctrl-0 = <&blsp2_i2c6_default>;
  2615				pinctrl-1 = <&blsp2_i2c6_sleep>;
  2616				clock-frequency = <400000>;
  2617	
  2618				status = "disabled";
  2619				#address-cells = <1>;
  2620				#size-cells = <0>;
  2621			};
  2622	
  2623			blsp2_spi1: spi@c1b5000 {
  2624				compatible = "qcom,spi-qup-v2.2.1";
  2625				reg = <0x0c1b5000 0x600>;
  2626				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
  2627	
  2628				clocks = <&gcc GCC_BLSP2_QUP1_SPI_APPS_CLK>,
  2629					 <&gcc GCC_BLSP2_AHB_CLK>;
  2630				clock-names = "core", "iface";
  2631				dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
  2632				dma-names = "tx", "rx";
  2633				pinctrl-names = "default";
  2634				pinctrl-0 = <&blsp2_spi1_default>;
  2635	
  2636				status = "disabled";
  2637				#address-cells = <1>;
  2638				#size-cells = <0>;
  2639			};
  2640	
  2641			blsp2_spi2: spi@c1b6000 {
  2642				compatible = "qcom,spi-qup-v2.2.1";
  2643				reg = <0x0c1b6000 0x600>;
  2644				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
  2645	
  2646				clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>,
  2647					 <&gcc GCC_BLSP2_AHB_CLK>;
  2648				clock-names = "core", "iface";
  2649				dmas = <&blsp2_dma 8>, <&blsp2_dma 9>;
  2650				dma-names = "tx", "rx";
  2651				pinctrl-names = "default";
  2652				pinctrl-0 = <&blsp2_spi2_default>;
  2653	
  2654				status = "disabled";
  2655				#address-cells = <1>;
  2656				#size-cells = <0>;
  2657			};
  2658	
  2659			blsp2_spi3: spi@c1b7000 {
  2660				compatible = "qcom,spi-qup-v2.2.1";
  2661				reg = <0x0c1b7000 0x600>;
  2662				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
  2663	
  2664				clocks = <&gcc GCC_BLSP2_QUP3_SPI_APPS_CLK>,
  2665					 <&gcc GCC_BLSP2_AHB_CLK>;
  2666				clock-names = "core", "iface";
  2667				dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
  2668				dma-names = "tx", "rx";
  2669				pinctrl-names = "default";
  2670				pinctrl-0 = <&blsp2_spi3_default>;
  2671	
  2672				status = "disabled";
  2673				#address-cells = <1>;
  2674				#size-cells = <0>;
  2675			};
  2676	
  2677			blsp2_spi4: spi@c1b8000 {
  2678				compatible = "qcom,spi-qup-v2.2.1";
  2679				reg = <0x0c1b8000 0x600>;
  2680				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
  2681	
  2682				clocks = <&gcc GCC_BLSP2_QUP4_SPI_APPS_CLK>,
  2683					 <&gcc GCC_BLSP2_AHB_CLK>;
  2684				clock-names = "core", "iface";
  2685				dmas = <&blsp2_dma 12>, <&blsp2_dma 13>;
  2686				dma-names = "tx", "rx";
  2687				pinctrl-names = "default";
  2688				pinctrl-0 = <&blsp2_spi4_default>;
  2689	
  2690				status = "disabled";
  2691				#address-cells = <1>;
  2692				#size-cells = <0>;
  2693			};
  2694	
  2695			blsp2_spi5: spi@c1b9000 {
  2696				compatible = "qcom,spi-qup-v2.2.1";
  2697				reg = <0x0c1b9000 0x600>;
  2698				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
  2699	
  2700				clocks = <&gcc GCC_BLSP2_QUP5_SPI_APPS_CLK>,
  2701					 <&gcc GCC_BLSP2_AHB_CLK>;
  2702				clock-names = "core", "iface";
  2703				dmas = <&blsp2_dma 14>, <&blsp2_dma 15>;
  2704				dma-names = "tx", "rx";
  2705				pinctrl-names = "default";
  2706				pinctrl-0 = <&blsp2_spi5_default>;
  2707	
  2708				status = "disabled";
  2709				#address-cells = <1>;
  2710				#size-cells = <0>;
  2711			};
  2712	
  2713			blsp2_spi6: spi@c1ba000 {
  2714				compatible = "qcom,spi-qup-v2.2.1";
  2715				reg = <0x0c1ba000 0x600>;
  2716				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
  2717	
  2718				clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
  2719					 <&gcc GCC_BLSP2_AHB_CLK>;
  2720				clock-names = "core", "iface";
  2721				dmas = <&blsp2_dma 16>, <&blsp2_dma 17>;
  2722				dma-names = "tx", "rx";
  2723				pinctrl-names = "default";
  2724				pinctrl-0 = <&blsp2_spi6_default>;
  2725	
  2726				status = "disabled";
  2727				#address-cells = <1>;
  2728				#size-cells = <0>;
  2729			};
  2730	
  2731			mmcc: clock-controller@c8c0000 {
  2732				compatible = "qcom,mmcc-msm8998";
  2733				#clock-cells = <1>;
  2734				#reset-cells = <1>;
  2735				#power-domain-cells = <1>;
  2736				reg = <0xc8c0000 0x40000>;
  2737	
  2738				clock-names = "xo",
  2739					      "gpll0",
  2740					      "dsi0dsi",
  2741					      "dsi0byte",
  2742					      "dsi1dsi",
  2743					      "dsi1byte",
  2744					      "hdmipll",
  2745					      "dplink",
  2746					      "dpvco",
  2747					      "gpll0_div";
  2748				clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
  2749					 <&gcc GCC_MMSS_GPLL0_CLK>,
  2750					 <&mdss_dsi0_phy 1>,
  2751					 <&mdss_dsi0_phy 0>,
  2752					 <&mdss_dsi1_phy 1>,
  2753					 <&mdss_dsi1_phy 0>,
  2754					 <0>,
  2755					 <0>,
  2756					 <0>,
  2757					 <&gcc GCC_MMSS_GPLL0_DIV_CLK>;
  2758			};
  2759	
  2760			mdss: display-subsystem@c900000 {
  2761				compatible = "qcom,msm8998-mdss";
  2762				reg = <0x0c900000 0x1000>;
  2763				reg-names = "mdss";
  2764	
  2765				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
  2766				interrupt-controller;
  2767				#interrupt-cells = <1>;
  2768	
  2769				clocks = <&mmcc MDSS_AHB_CLK>,
  2770					 <&mmcc MDSS_AXI_CLK>,
  2771					 <&mmcc MDSS_MDP_CLK>;
  2772				clock-names = "iface",
  2773					      "bus",
  2774					      "core";
  2775	
  2776				power-domains = <&mmcc MDSS_GDSC>;
  2777				iommus = <&mmss_smmu 0>;
  2778	
  2779				#address-cells = <1>;
  2780				#size-cells = <1>;
  2781				ranges;
  2782	
  2783				status = "disabled";
  2784	
  2785				mdss_mdp: display-controller@c901000 {
  2786					compatible = "qcom,msm8998-dpu";
  2787					reg = <0x0c901000 0x8f000>,
  2788					      <0x0c9a8e00 0xf0>,
  2789					      <0x0c9b0000 0x2008>,
  2790					      <0x0c9b8000 0x1040>;
  2791					reg-names = "mdp",
  2792						    "regdma",
  2793						    "vbif",
  2794						    "vbif_nrt";
  2795	
  2796					interrupt-parent = <&mdss>;
  2797					interrupts = <0>;
  2798	
  2799					clocks = <&mmcc MDSS_AHB_CLK>,
  2800						 <&mmcc MDSS_AXI_CLK>,
  2801						 <&mmcc MNOC_AHB_CLK>,
  2802						 <&mmcc MDSS_MDP_CLK>,
  2803						 <&mmcc MDSS_VSYNC_CLK>;
  2804					clock-names = "iface",
  2805						      "bus",
  2806						      "mnoc",
  2807						      "core",
  2808						      "vsync";
  2809	
  2810					assigned-clocks = <&mmcc MDSS_VSYNC_CLK>;
  2811					assigned-clock-rates = <19200000>;
  2812	
  2813					operating-points-v2 = <&mdp_opp_table>;
  2814					power-domains = <&rpmpd MSM8998_VDDMX>;
  2815	
  2816					mdp_opp_table: opp-table {
  2817						compatible = "operating-points-v2";
  2818	
  2819						opp-171430000 {
  2820							opp-hz = /bits/ 64 <171430000>;
  2821							required-opps = <&rpmpd_opp_low_svs>;
  2822						};
  2823	
  2824						opp-275000000 {
  2825							opp-hz = /bits/ 64 <275000000>;
  2826							required-opps = <&rpmpd_opp_svs>;
  2827						};
  2828	
  2829						opp-330000000 {
  2830							opp-hz = /bits/ 64 <330000000>;
  2831							required-opps = <&rpmpd_opp_nom>;
  2832						};
  2833	
  2834						opp-412500000 {
  2835							opp-hz = /bits/ 64 <412500000>;
  2836							required-opps = <&rpmpd_opp_turbo>;
  2837						};
  2838					};
  2839	
  2840					ports {
  2841						#address-cells = <1>;
  2842						#size-cells = <0>;
  2843	
  2844						port@0 {
  2845							reg = <0>;
  2846	
  2847							dpu_intf1_out: endpoint {
  2848								remote-endpoint = <&mdss_dsi0_in>;
  2849							};
  2850						};
  2851	
  2852						port@1 {
  2853							reg = <1>;
  2854	
  2855							dpu_intf2_out: endpoint {
  2856								remote-endpoint = <&mdss_dsi1_in>;
  2857							};
  2858						};
  2859					};
  2860				};
  2861	
> 2862				mdss_dsi0: dsi@c994000 {
  2863					compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
  2864					reg = <0x0c994000 0x400>;
  2865					reg-names = "dsi_ctrl";
  2866	
  2867					interrupt-parent = <&mdss>;
  2868					interrupts = <4>;
  2869	
  2870					clocks = <&mmcc MDSS_BYTE0_CLK>,
  2871						 <&mmcc MDSS_BYTE0_INTF_CLK>,
  2872						 <&mmcc MDSS_PCLK0_CLK>,
  2873						 <&mmcc MDSS_ESC0_CLK>,
  2874						 <&mmcc MDSS_AHB_CLK>,
  2875						 <&mmcc MDSS_AXI_CLK>;
  2876					clock-names = "byte",
  2877						      "byte_intf",
  2878						      "pixel",
  2879						      "core",
  2880						      "iface",
  2881						      "bus";
  2882					assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
  2883							  <&mmcc PCLK0_CLK_SRC>;
  2884					assigned-clock-parents = <&mdss_dsi0_phy 0>,
  2885								 <&mdss_dsi0_phy 1>;
  2886	
  2887					operating-points-v2 = <&dsi_opp_table>;
  2888					power-domains = <&rpmpd MSM8998_VDDCX>;
  2889	
  2890					phys = <&mdss_dsi0_phy>;
  2891					phy-names = "dsi";
  2892	
  2893					#address-cells = <1>;
  2894					#size-cells = <0>;
  2895	
  2896					status = "disabled";
  2897	
  2898					ports {
  2899						#address-cells = <1>;
  2900						#size-cells = <0>;
  2901	
  2902						port@0 {
  2903							reg = <0>;
  2904	
  2905							mdss_dsi0_in: endpoint {
  2906								remote-endpoint = <&dpu_intf1_out>;
  2907							};
  2908						};
  2909	
  2910						port@1 {
  2911							reg = <1>;
  2912	
  2913							mdss_dsi0_out: endpoint {
  2914							};
  2915						};
  2916					};
  2917				};
  2918	
  2919				mdss_dsi0_phy: phy@c994400 {
  2920					compatible = "qcom,dsi-phy-10nm-8998";
  2921					reg = <0x0c994400 0x200>,
  2922					      <0x0c994600 0x280>,
  2923					      <0x0c994a00 0x1e0>;
  2924					reg-names = "dsi_phy",
  2925						    "dsi_phy_lane",
  2926						    "dsi_pll";
  2927	
  2928					clocks = <&mmcc MDSS_AHB_CLK>,
  2929						 <&rpmcc RPM_SMD_XO_CLK_SRC>;
  2930					clock-names = "iface", "ref";
  2931	
  2932					#clock-cells = <1>;
  2933					#phy-cells = <0>;
  2934	
  2935					status = "disabled";
  2936				};
  2937	
> 2938				mdss_dsi1: dsi@c996000 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

