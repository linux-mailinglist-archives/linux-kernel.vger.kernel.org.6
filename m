Return-Path: <linux-kernel+bounces-216337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90624909E16
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64561F215B4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8E12B73;
	Sun, 16 Jun 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH/jyop5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4012B82
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718550448; cv=none; b=f1aTHj02MC8vAf6dVymZzGPMYtBEA828ibgm0XC1T+M2B0/vRJ+wlE8A+0Bfep/4Ke+tVLyR29EpjxYgyVykzxJVoD26erBWMofcqnVUjkEnY0Ew6KjKomGT0wqM+FILMPcwBaXHKF3jp9tU9e07BkG9oET2QhTIIxRlKzPPvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718550448; c=relaxed/simple;
	bh=AlwXaSEB26BK9aDXkumCvXIlh9OTzsMYH6S617G1NHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m15Bm/5XBAfYyyQvLnY0c3V+y25O7zVOX/BN6zTHmzKtKfP81DaVQ76KoQEuuoN1END9TwRbUJfuu+LYPKsbzpm3ls0nWjmdm0ZHzHKTCJX1zCsXAvbdmO4596/davq1FX4fSxMx21ODIWIS6ePPcOoYxbPI0wDzxqYtQJLqeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH/jyop5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718550445; x=1750086445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AlwXaSEB26BK9aDXkumCvXIlh9OTzsMYH6S617G1NHQ=;
  b=BH/jyop5k6R86peDie2i6ZVzMnZRFFZYcqxzr/xgo+rf4pmB8Ne1lNiD
   hyGJYMeywDQ1Y1F19sCWpVpO8J03slkDnlp8v84tgpZ+cc4Bj4c04PF35
   k8gsHdGLkOAiHLQg68/FnNqQl97v+BmQQFL8YU0y7Dksuyv7NuEijAjfU
   /6iWUmSCPhjQpk/7TrAMqdLCDCNosZN2GpDXOrtpvm3hXD3Yj76eHdnSa
   eGsMR6dnGBs3EJ347TU1Ztui1bqNbB/t8+XXwpstRF+J3xpxnwvCjQ/Qg
   rP6UT2R20IR1swApYp0rpLg21uuEEJmzmPrcBPrGdTLN3vTeqBERJ9Zii
   w==;
X-CSE-ConnectionGUID: dOvM8QgUQWy7CgXKN13puw==
X-CSE-MsgGUID: azwoNRtmTnWYJ9gNhv6YAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15109031"
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="15109031"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 08:07:24 -0700
X-CSE-ConnectionGUID: dEtph3iUQ6mSQIbeUENUAw==
X-CSE-MsgGUID: qyV5oaMLQ4CwwD9W/WkngQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="64180522"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jun 2024 08:07:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIrTU-0002wK-1D;
	Sun, 16 Jun 2024 15:07:20 +0000
Date: Sun, 16 Jun 2024 23:07:18 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: arch/arm64/boot/dts/qcom/sm6350.dtsi:1974.27-2048.6: Warning
 (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406162310.7z6faJqE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3e18a540541325a8c8848171f71e0d45ad30b2c
commit: 26c71d31f8be3493006140961acf6be204004fdb arm64: dts: qcom: sm6350: Add DPU1 nodes
date:   11 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240616/202406162310.7z6faJqE-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240616/202406162310.7z6faJqE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406162310.7z6faJqE-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/qcom/sm6350.dtsi:1974.27-2048.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/sm6350.dtsi:1926.11-1937.7: Warning (graph_child_address): /soc@0/display-subsystem@ae00000/display-controller@ae01000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +1974 arch/arm64/boot/dts/qcom/sm6350.dtsi

    22	
    23	/ {
    24		interrupt-parent = <&intc>;
    25		#address-cells = <2>;
    26		#size-cells = <2>;
    27	
    28		clocks {
    29			xo_board: xo-board {
    30				compatible = "fixed-clock";
    31				#clock-cells = <0>;
    32				clock-frequency = <76800000>;
    33				clock-output-names = "xo_board";
    34			};
    35	
    36			sleep_clk: sleep-clk {
    37				compatible = "fixed-clock";
    38				clock-frequency = <32764>;
    39				#clock-cells = <0>;
    40			};
    41		};
    42	
    43		cpus {
    44			#address-cells = <2>;
    45			#size-cells = <0>;
    46	
    47			CPU0: cpu@0 {
    48				device_type = "cpu";
    49				compatible = "qcom,kryo560";
    50				reg = <0x0 0x0>;
    51				clocks = <&cpufreq_hw 0>;
    52				enable-method = "psci";
    53				capacity-dmips-mhz = <1024>;
    54				dynamic-power-coefficient = <100>;
    55				next-level-cache = <&L2_0>;
    56				qcom,freq-domain = <&cpufreq_hw 0>;
    57				operating-points-v2 = <&cpu0_opp_table>;
    58				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
    59						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
    60						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
    61				power-domains = <&CPU_PD0>;
    62				power-domain-names = "psci";
    63				#cooling-cells = <2>;
    64				L2_0: l2-cache {
    65					compatible = "cache";
    66					cache-level = <2>;
    67					cache-unified;
    68					next-level-cache = <&L3_0>;
    69					L3_0: l3-cache {
    70						compatible = "cache";
    71						cache-level = <3>;
    72						cache-unified;
    73					};
    74				};
    75			};
    76	
    77			CPU1: cpu@100 {
    78				device_type = "cpu";
    79				compatible = "qcom,kryo560";
    80				reg = <0x0 0x100>;
    81				clocks = <&cpufreq_hw 0>;
    82				enable-method = "psci";
    83				capacity-dmips-mhz = <1024>;
    84				dynamic-power-coefficient = <100>;
    85				next-level-cache = <&L2_100>;
    86				qcom,freq-domain = <&cpufreq_hw 0>;
    87				operating-points-v2 = <&cpu0_opp_table>;
    88				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
    89						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
    90						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
    91				power-domains = <&CPU_PD1>;
    92				power-domain-names = "psci";
    93				#cooling-cells = <2>;
    94				L2_100: l2-cache {
    95					compatible = "cache";
    96					cache-level = <2>;
    97					cache-unified;
    98					next-level-cache = <&L3_0>;
    99				};
   100			};
   101	
   102			CPU2: cpu@200 {
   103				device_type = "cpu";
   104				compatible = "qcom,kryo560";
   105				reg = <0x0 0x200>;
   106				clocks = <&cpufreq_hw 0>;
   107				enable-method = "psci";
   108				capacity-dmips-mhz = <1024>;
   109				dynamic-power-coefficient = <100>;
   110				next-level-cache = <&L2_200>;
   111				qcom,freq-domain = <&cpufreq_hw 0>;
   112				operating-points-v2 = <&cpu0_opp_table>;
   113				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
   114						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
   115						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
   116				power-domains = <&CPU_PD2>;
   117				power-domain-names = "psci";
   118				#cooling-cells = <2>;
   119				L2_200: l2-cache {
   120					compatible = "cache";
   121					cache-level = <2>;
   122					cache-unified;
   123					next-level-cache = <&L3_0>;
   124				};
   125			};
   126	
   127			CPU3: cpu@300 {
   128				device_type = "cpu";
   129				compatible = "qcom,kryo560";
   130				reg = <0x0 0x300>;
   131				clocks = <&cpufreq_hw 0>;
   132				enable-method = "psci";
   133				capacity-dmips-mhz = <1024>;
   134				dynamic-power-coefficient = <100>;
   135				next-level-cache = <&L2_300>;
   136				qcom,freq-domain = <&cpufreq_hw 0>;
   137				operating-points-v2 = <&cpu0_opp_table>;
   138				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
   139						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
   140						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
   141				power-domains = <&CPU_PD3>;
   142				power-domain-names = "psci";
   143				#cooling-cells = <2>;
   144				L2_300: l2-cache {
   145					compatible = "cache";
   146					cache-level = <2>;
   147					cache-unified;
   148					next-level-cache = <&L3_0>;
   149				};
   150			};
   151	
   152			CPU4: cpu@400 {
   153				device_type = "cpu";
   154				compatible = "qcom,kryo560";
   155				reg = <0x0 0x400>;
   156				clocks = <&cpufreq_hw 0>;
   157				enable-method = "psci";
   158				capacity-dmips-mhz = <1024>;
   159				dynamic-power-coefficient = <100>;
   160				next-level-cache = <&L2_400>;
   161				qcom,freq-domain = <&cpufreq_hw 0>;
   162				operating-points-v2 = <&cpu0_opp_table>;
   163				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
   164						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
   165						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
   166				power-domains = <&CPU_PD4>;
   167				power-domain-names = "psci";
   168				#cooling-cells = <2>;
   169				L2_400: l2-cache {
   170					compatible = "cache";
   171					cache-level = <2>;
   172					cache-unified;
   173					next-level-cache = <&L3_0>;
   174				};
   175			};
   176	
   177			CPU5: cpu@500 {
   178				device_type = "cpu";
   179				compatible = "qcom,kryo560";
   180				reg = <0x0 0x500>;
   181				clocks = <&cpufreq_hw 0>;
   182				enable-method = "psci";
   183				capacity-dmips-mhz = <1024>;
   184				dynamic-power-coefficient = <100>;
   185				next-level-cache = <&L2_500>;
   186				qcom,freq-domain = <&cpufreq_hw 0>;
   187				operating-points-v2 = <&cpu0_opp_table>;
   188				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
   189						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
   190						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
   191				power-domains = <&CPU_PD5>;
   192				power-domain-names = "psci";
   193				#cooling-cells = <2>;
   194				L2_500: l2-cache {
   195					compatible = "cache";
   196					cache-level = <2>;
   197					cache-unified;
   198					next-level-cache = <&L3_0>;
   199				};
   200			};
   201	
   202			CPU6: cpu@600 {
   203				device_type = "cpu";
   204				compatible = "qcom,kryo560";
   205				reg = <0x0 0x600>;
   206				clocks = <&cpufreq_hw 1>;
   207				enable-method = "psci";
   208				capacity-dmips-mhz = <1894>;
   209				dynamic-power-coefficient = <703>;
   210				next-level-cache = <&L2_600>;
   211				qcom,freq-domain = <&cpufreq_hw 1>;
   212				operating-points-v2 = <&cpu6_opp_table>;
   213				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
   214						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
   215						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
   216				power-domains = <&CPU_PD6>;
   217				power-domain-names = "psci";
   218				#cooling-cells = <2>;
   219				L2_600: l2-cache {
   220					compatible = "cache";
   221					cache-level = <2>;
   222					cache-unified;
   223					next-level-cache = <&L3_0>;
   224				};
   225			};
   226	
   227			CPU7: cpu@700 {
   228				device_type = "cpu";
   229				compatible = "qcom,kryo560";
   230				reg = <0x0 0x700>;
   231				clocks = <&cpufreq_hw 1>;
   232				enable-method = "psci";
   233				capacity-dmips-mhz = <1894>;
   234				dynamic-power-coefficient = <703>;
   235				next-level-cache = <&L2_700>;
   236				qcom,freq-domain = <&cpufreq_hw 1>;
   237				operating-points-v2 = <&cpu6_opp_table>;
   238				interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
   239						 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
   240						<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
   241				power-domains = <&CPU_PD7>;
   242				power-domain-names = "psci";
   243				#cooling-cells = <2>;
   244				L2_700: l2-cache {
   245					compatible = "cache";
   246					cache-level = <2>;
   247					cache-unified;
   248					next-level-cache = <&L3_0>;
   249				};
   250			};
   251	
   252			cpu-map {
   253				cluster0 {
   254					core0 {
   255						cpu = <&CPU0>;
   256					};
   257	
   258					core1 {
   259						cpu = <&CPU1>;
   260					};
   261	
   262					core2 {
   263						cpu = <&CPU2>;
   264					};
   265	
   266					core3 {
   267						cpu = <&CPU3>;
   268					};
   269	
   270					core4 {
   271						cpu = <&CPU4>;
   272					};
   273	
   274					core5 {
   275						cpu = <&CPU5>;
   276					};
   277	
   278					core6 {
   279						cpu = <&CPU6>;
   280					};
   281	
   282					core7 {
   283						cpu = <&CPU7>;
   284					};
   285				};
   286			};
   287	
   288			domain-idle-states {
   289				CLUSTER_SLEEP_PC: cluster-sleep-0 {
   290					compatible = "domain-idle-state";
   291					arm,psci-suspend-param = <0x41000044>;
   292					entry-latency-us = <2752>;
   293					exit-latency-us = <3048>;
   294					min-residency-us = <6118>;
   295				};
   296	
   297				CLUSTER_SLEEP_CX_RET: cluster-sleep-1 {
   298					compatible = "domain-idle-state";
   299					arm,psci-suspend-param = <0x41001244>;
   300					entry-latency-us = <3638>;
   301					exit-latency-us = <4562>;
   302					min-residency-us = <8467>;
   303				};
   304	
   305				CLUSTER_AOSS_SLEEP: cluster-sleep-2 {
   306					compatible = "domain-idle-state";
   307					arm,psci-suspend-param = <0x4100b244>;
   308					entry-latency-us = <3263>;
   309					exit-latency-us = <6562>;
   310					min-residency-us = <9987>;
   311				};
   312			};
   313	
   314			cpu_idle_states: idle-states {
   315				entry-method = "psci";
   316	
   317				LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
   318					compatible = "arm,idle-state";
   319					idle-state-name = "little-power-collapse";
   320					arm,psci-suspend-param = <0x40000003>;
   321					entry-latency-us = <549>;
   322					exit-latency-us = <901>;
   323					min-residency-us = <1774>;
   324					local-timer-stop;
   325				};
   326	
   327				LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
   328					compatible = "arm,idle-state";
   329					idle-state-name = "little-rail-power-collapse";
   330					arm,psci-suspend-param = <0x40000004>;
   331					entry-latency-us = <702>;
   332					exit-latency-us = <915>;
   333					min-residency-us = <4001>;
   334					local-timer-stop;
   335				};
   336	
   337				BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
   338					compatible = "arm,idle-state";
   339					idle-state-name = "big-power-collapse";
   340					arm,psci-suspend-param = <0x40000003>;
   341					entry-latency-us = <523>;
   342					exit-latency-us = <1244>;
   343					min-residency-us = <2207>;
   344					local-timer-stop;
   345				};
   346	
   347				BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
   348					compatible = "arm,idle-state";
   349					idle-state-name = "big-rail-power-collapse";
   350					arm,psci-suspend-param = <0x40000004>;
   351					entry-latency-us = <526>;
   352					exit-latency-us = <1854>;
   353					min-residency-us = <5555>;
   354					local-timer-stop;
   355				};
   356			};
   357		};
   358	
   359		firmware {
   360			scm: scm {
   361				compatible = "qcom,scm-sm6350", "qcom,scm";
   362				#reset-cells = <1>;
   363			};
   364		};
   365	
   366		memory@80000000 {
   367			device_type = "memory";
   368			/* We expect the bootloader to fill in the size */
   369			reg = <0x0 0x80000000 0x0 0x0>;
   370		};
   371	
   372		cpu0_opp_table: opp-table-cpu0 {
   373			compatible = "operating-points-v2";
   374			opp-shared;
   375	
   376			opp-300000000 {
   377				opp-hz = /bits/ 64 <300000000>;
   378				/* DDR: 4-wide, 2 channels, double data rate, L3: 16-wide, 2 channels */
   379				opp-peak-kBps = <(200000 * 4 * 2 * 2) (300000 * 16 * 2)>;
   380			};
   381	
   382			opp-576000000 {
   383				opp-hz = /bits/ 64 <576000000>;
   384				opp-peak-kBps = <(547000 * 4 * 2 * 2) (556800 * 16 * 2)>;
   385			};
   386	
   387			opp-768000000 {
   388				opp-hz = /bits/ 64 <768000000>;
   389				opp-peak-kBps = <(768000 * 4 * 2 * 2) (652800 * 16 * 2)>;
   390			};
   391	
   392			opp-1017600000 {
   393				opp-hz = /bits/ 64 <1017600000>;
   394				opp-peak-kBps = <(1017000 * 4 * 2 * 2) (940800 * 16 * 2)>;
   395			};
   396	
   397			opp-1248000000 {
   398				opp-hz = /bits/ 64 <1248000000>;
   399				opp-peak-kBps = <(1017000 * 4 * 2 * 2) (1209600 * 16 * 2)>;
   400			};
   401	
   402			opp-1324800000 {
   403				opp-hz = /bits/ 64 <1324800000>;
   404				opp-peak-kBps = <(1017000 * 4 * 2 * 2) (1286400 * 16 * 2)>;
   405			};
   406	
   407			opp-1516800000 {
   408				opp-hz = /bits/ 64 <1516800000>;
   409				opp-peak-kBps = <(1353000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   410			};
   411	
   412			opp-1612800000 {
   413				opp-hz = /bits/ 64 <1612800000>;
   414				opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   415			};
   416	
   417			opp-1708800000 {
   418				opp-hz = /bits/ 64 <1708800000>;
   419				opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   420			};
   421		};
   422	
   423		cpu6_opp_table: opp-table-cpu6 {
   424			compatible = "operating-points-v2";
   425			opp-shared;
   426	
   427			opp-300000000 {
   428				opp-hz = /bits/ 64 <300000000>;
   429				opp-peak-kBps = <(200000 * 4 * 2 * 2) (300000 * 16 * 2)>;
   430			};
   431	
   432			opp-787200000 {
   433				opp-hz = /bits/ 64 <787200000>;
   434				opp-peak-kBps = <(768000 * 4 * 2 * 2) (652800 * 16 * 2)>;
   435			};
   436	
   437			opp-979200000 {
   438				opp-hz = /bits/ 64 <979200000>;
   439				opp-peak-kBps = <(768000 * 4 * 2 * 2) (940800 * 16 * 2)>;
   440			};
   441	
   442			opp-1036800000 {
   443				opp-hz = /bits/ 64 <1036800000>;
   444				opp-peak-kBps = <(1017000 * 4 * 2 * 2) (940800 * 16 * 2)>;
   445			};
   446	
   447			opp-1248000000 {
   448				opp-hz = /bits/ 64 <1248000000>;
   449				opp-peak-kBps = <(1017000 * 4 * 2 * 2) (1209600 * 16 * 2)>;
   450			};
   451	
   452			opp-1401600000 {
   453				opp-hz = /bits/ 64 <1401600000>;
   454				opp-peak-kBps = <(1353000 * 4 * 2 * 2) (1401600 * 16 * 2)>;
   455			};
   456	
   457			opp-1555200000 {
   458				opp-hz = /bits/ 64 <1555200000>;
   459				opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   460			};
   461	
   462			opp-1766400000 {
   463				opp-hz = /bits/ 64 <1766400000>;
   464				opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   465			};
   466	
   467			opp-1900800000 {
   468				opp-hz = /bits/ 64 <1900800000>;
   469				opp-peak-kBps = <(1804000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   470			};
   471	
   472			opp-2073600000 {
   473				opp-hz = /bits/ 64 <2073600000>;
   474				opp-peak-kBps = <(2092000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
   475			};
   476		};
   477	
   478		qup_opp_table: opp-table-qup {
   479			compatible = "operating-points-v2";
   480	
   481			opp-75000000 {
   482				opp-hz = /bits/ 64 <75000000>;
   483				required-opps = <&rpmhpd_opp_low_svs>;
   484			};
   485	
   486			opp-100000000 {
   487				opp-hz = /bits/ 64 <100000000>;
   488				required-opps = <&rpmhpd_opp_svs>;
   489			};
   490	
   491			opp-128000000 {
   492				opp-hz = /bits/ 64 <128000000>;
   493				required-opps = <&rpmhpd_opp_nom>;
   494			};
   495		};
   496	
   497		pmu {
   498			compatible = "arm,armv8-pmuv3";
   499			interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
   500		};
   501	
   502		psci {
   503			compatible = "arm,psci-1.0";
   504			method = "smc";
   505	
   506			CPU_PD0: power-domain-cpu0 {
   507				#power-domain-cells = <0>;
   508				power-domains = <&CLUSTER_PD>;
   509				domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   510			};
   511	
   512			CPU_PD1: power-domain-cpu1 {
   513				#power-domain-cells = <0>;
   514				power-domains = <&CLUSTER_PD>;
   515				domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   516			};
   517	
   518			CPU_PD2: power-domain-cpu2 {
   519				#power-domain-cells = <0>;
   520				power-domains = <&CLUSTER_PD>;
   521				domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   522			};
   523	
   524			CPU_PD3: power-domain-cpu3 {
   525				#power-domain-cells = <0>;
   526				power-domains = <&CLUSTER_PD>;
   527				domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   528			};
   529	
   530			CPU_PD4: power-domain-cpu4 {
   531				#power-domain-cells = <0>;
   532				power-domains = <&CLUSTER_PD>;
   533				domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   534			};
   535	
   536			CPU_PD5: power-domain-cpu5 {
   537				#power-domain-cells = <0>;
   538				power-domains = <&CLUSTER_PD>;
   539				domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
   540			};
   541	
   542			CPU_PD6: power-domain-cpu6 {
   543				#power-domain-cells = <0>;
   544				power-domains = <&CLUSTER_PD>;
   545				domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
   546			};
   547	
   548			CPU_PD7: power-domain-cpu7 {
   549				#power-domain-cells = <0>;
   550				power-domains = <&CLUSTER_PD>;
   551				domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
   552			};
   553	
   554			CLUSTER_PD: power-domain-cpu-cluster0 {
   555				#power-domain-cells = <0>;
   556				domain-idle-states = <&CLUSTER_SLEEP_PC
   557						      &CLUSTER_SLEEP_CX_RET
   558						      &CLUSTER_AOSS_SLEEP>;
   559			};
   560		};
   561	
   562		reserved_memory: reserved-memory {
   563			#address-cells = <2>;
   564			#size-cells = <2>;
   565			ranges;
   566	
   567			hyp_mem: memory@80000000 {
   568				reg = <0 0x80000000 0 0x600000>;
   569				no-map;
   570			};
   571	
   572			xbl_aop_mem: memory@80700000 {
   573				reg = <0 0x80700000 0 0x160000>;
   574				no-map;
   575			};
   576	
   577			cmd_db: memory@80860000 {
   578				compatible = "qcom,cmd-db";
   579				reg = <0 0x80860000 0 0x20000>;
   580				no-map;
   581			};
   582	
   583			sec_apps_mem: memory@808ff000 {
   584				reg = <0 0x808ff000 0 0x1000>;
   585				no-map;
   586			};
   587	
   588			smem_mem: memory@80900000 {
   589				reg = <0 0x80900000 0 0x200000>;
   590				no-map;
   591			};
   592	
   593			cdsp_sec_mem: memory@80b00000 {
   594				reg = <0 0x80b00000 0 0x1e00000>;
   595				no-map;
   596			};
   597	
   598			pil_camera_mem: memory@86000000 {
   599				reg = <0 0x86000000 0 0x500000>;
   600				no-map;
   601			};
   602	
   603			pil_npu_mem: memory@86500000 {
   604				reg = <0 0x86500000 0 0x500000>;
   605				no-map;
   606			};
   607	
   608			pil_video_mem: memory@86a00000 {
   609				reg = <0 0x86a00000 0 0x500000>;
   610				no-map;
   611			};
   612	
   613			pil_cdsp_mem: memory@86f00000 {
   614				reg = <0 0x86f00000 0 0x1e00000>;
   615				no-map;
   616			};
   617	
   618			pil_adsp_mem: memory@88d00000 {
   619				reg = <0 0x88d00000 0 0x2800000>;
   620				no-map;
   621			};
   622	
   623			wlan_fw_mem: memory@8b500000 {
   624				reg = <0 0x8b500000 0 0x200000>;
   625				no-map;
   626			};
   627	
   628			pil_ipa_fw_mem: memory@8b700000 {
   629				reg = <0 0x8b700000 0 0x10000>;
   630				no-map;
   631			};
   632	
   633			pil_ipa_gsi_mem: memory@8b710000 {
   634				reg = <0 0x8b710000 0 0x5400>;
   635				no-map;
   636			};
   637	
   638			pil_modem_mem: memory@8b800000 {
   639				reg = <0 0x8b800000 0 0xf800000>;
   640				no-map;
   641			};
   642	
   643			cont_splash_memory: memory@a0000000 {
   644				reg = <0 0xa0000000 0 0x2300000>;
   645				no-map;
   646			};
   647	
   648			dfps_data_memory: memory@a2300000 {
   649				reg = <0 0xa2300000 0 0x100000>;
   650				no-map;
   651			};
   652	
   653			removed_region: memory@c0000000 {
   654				reg = <0 0xc0000000 0 0x3900000>;
   655				no-map;
   656			};
   657	
   658			pil_gpu_mem: memory@f0d00000 {
   659				reg = <0 0xf0d00000 0 0x1000>;
   660				no-map;
   661			};
   662	
   663			debug_region: memory@ffb00000 {
   664				reg = <0 0xffb00000 0 0xc0000>;
   665				no-map;
   666			};
   667	
   668			last_log_region: memory@ffbc0000 {
   669				reg = <0 0xffbc0000 0 0x40000>;
   670				no-map;
   671			};
   672	
   673			ramoops: ramoops@ffc00000 {
   674				compatible = "ramoops";
   675				reg = <0 0xffc00000 0 0x100000>;
   676				record-size = <0x1000>;
   677				console-size = <0x40000>;
   678				msg-size = <0x20000 0x20000>;
   679				ecc-size = <16>;
   680				no-map;
   681			};
   682	
   683			cmdline_region: memory@ffd00000 {
   684				reg = <0 0xffd00000 0 0x1000>;
   685				no-map;
   686			};
   687		};
   688	
   689		smem {
   690			compatible = "qcom,smem";
   691			memory-region = <&smem_mem>;
   692			hwlocks = <&tcsr_mutex 3>;
   693		};
   694	
   695		smp2p-adsp {
   696			compatible = "qcom,smp2p";
   697			qcom,smem = <443>, <429>;
   698			interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
   699						     IPCC_MPROC_SIGNAL_SMP2P
   700						     IRQ_TYPE_EDGE_RISING>;
   701			mboxes = <&ipcc IPCC_CLIENT_LPASS
   702					IPCC_MPROC_SIGNAL_SMP2P>;
   703	
   704			qcom,local-pid = <0>;
   705			qcom,remote-pid = <2>;
   706	
   707			smp2p_adsp_out: master-kernel {
   708				qcom,entry-name = "master-kernel";
   709				#qcom,smem-state-cells = <1>;
   710			};
   711	
   712			smp2p_adsp_in: slave-kernel {
   713				qcom,entry-name = "slave-kernel";
   714				interrupt-controller;
   715				#interrupt-cells = <2>;
   716			};
   717		};
   718	
   719		smp2p-cdsp {
   720			compatible = "qcom,smp2p";
   721			qcom,smem = <94>, <432>;
   722			interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
   723						     IPCC_MPROC_SIGNAL_SMP2P
   724						     IRQ_TYPE_EDGE_RISING>;
   725			mboxes = <&ipcc IPCC_CLIENT_CDSP
   726					IPCC_MPROC_SIGNAL_SMP2P>;
   727	
   728			qcom,local-pid = <0>;
   729			qcom,remote-pid = <5>;
   730	
   731			smp2p_cdsp_out: master-kernel {
   732				qcom,entry-name = "master-kernel";
   733				#qcom,smem-state-cells = <1>;
   734			};
   735	
   736			smp2p_cdsp_in: slave-kernel {
   737				qcom,entry-name = "slave-kernel";
   738				interrupt-controller;
   739				#interrupt-cells = <2>;
   740			};
   741		};
   742	
   743		smp2p-mpss {
   744			compatible = "qcom,smp2p";
   745			qcom,smem = <435>, <428>;
   746	
   747			interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
   748						     IPCC_MPROC_SIGNAL_SMP2P
   749						     IRQ_TYPE_EDGE_RISING>;
   750			mboxes = <&ipcc IPCC_CLIENT_MPSS
   751					IPCC_MPROC_SIGNAL_SMP2P>;
   752	
   753			qcom,local-pid = <0>;
   754			qcom,remote-pid = <1>;
   755	
   756			modem_smp2p_out: master-kernel {
   757				qcom,entry-name = "master-kernel";
   758				#qcom,smem-state-cells = <1>;
   759			};
   760	
   761			modem_smp2p_in: slave-kernel {
   762				qcom,entry-name = "slave-kernel";
   763				interrupt-controller;
   764				#interrupt-cells = <2>;
   765			};
   766	
   767			ipa_smp2p_out: ipa-ap-to-modem {
   768				qcom,entry-name = "ipa";
   769				#qcom,smem-state-cells = <1>;
   770			};
   771	
   772			ipa_smp2p_in: ipa-modem-to-ap {
   773				qcom,entry-name = "ipa";
   774				interrupt-controller;
   775				#interrupt-cells = <2>;
   776			};
   777		};
   778	
   779		soc: soc@0 {
   780			#address-cells = <2>;
   781			#size-cells = <2>;
   782			ranges = <0 0 0 0 0x10 0>;
   783			dma-ranges = <0 0 0 0 0x10 0>;
   784			compatible = "simple-bus";
   785	
   786			gcc: clock-controller@100000 {
   787				compatible = "qcom,gcc-sm6350";
   788				reg = <0 0x00100000 0 0x1f0000>;
   789				#clock-cells = <1>;
   790				#reset-cells = <1>;
   791				#power-domain-cells = <1>;
   792				clock-names = "bi_tcxo",
   793					      "bi_tcxo_ao",
   794					      "sleep_clk";
   795				clocks = <&rpmhcc RPMH_CXO_CLK>,
   796					 <&rpmhcc RPMH_CXO_CLK_A>,
   797					 <&sleep_clk>;
   798			};
   799	
   800			ipcc: mailbox@408000 {
   801				compatible = "qcom,sm6350-ipcc", "qcom,ipcc";
   802				reg = <0 0x00408000 0 0x1000>;
   803				interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
   804				interrupt-controller;
   805				#interrupt-cells = <3>;
   806				#mbox-cells = <2>;
   807			};
   808	
   809			qfprom: qfprom@784000 {
   810				compatible = "qcom,sm6350-qfprom", "qcom,qfprom";
   811				reg = <0 0x00784000 0 0x3000>;
   812				#address-cells = <1>;
   813				#size-cells = <1>;
   814	
   815				gpu_speed_bin: gpu-speed-bin@2015 {
   816					reg = <0x2015 0x1>;
   817					bits = <0 8>;
   818				};
   819			};
   820	
   821			rng: rng@793000 {
   822				compatible = "qcom,prng-ee";
   823				reg = <0 0x00793000 0 0x1000>;
   824				clocks = <&gcc GCC_PRNG_AHB_CLK>;
   825				clock-names = "core";
   826			};
   827	
   828			sdhc_1: mmc@7c4000 {
   829				compatible = "qcom,sm6350-sdhci", "qcom,sdhci-msm-v5";
   830				reg = <0 0x007c4000 0 0x1000>,
   831					<0 0x007c5000 0 0x1000>,
   832					<0 0x007c8000 0 0x8000>;
   833				reg-names = "hc", "cqhci", "ice";
   834	
   835				interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
   836					     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
   837				interrupt-names = "hc_irq", "pwr_irq";
   838				iommus = <&apps_smmu 0x60 0x0>;
   839	
   840				clocks = <&gcc GCC_SDCC1_AHB_CLK>,
   841					 <&gcc GCC_SDCC1_APPS_CLK>,
   842					 <&rpmhcc RPMH_CXO_CLK>;
   843				clock-names = "iface", "core", "xo";
   844				resets = <&gcc GCC_SDCC1_BCR>;
   845				qcom,dll-config = <0x000f642c>;
   846				qcom,ddr-config = <0x80040868>;
   847				power-domains = <&rpmhpd SM6350_CX>;
   848				operating-points-v2 = <&sdhc1_opp_table>;
   849				bus-width = <8>;
   850				non-removable;
   851				supports-cqe;
   852	
   853				status = "disabled";
   854	
   855				sdhc1_opp_table: opp-table {
   856					compatible = "operating-points-v2";
   857	
   858					opp-19200000 {
   859						opp-hz = /bits/ 64 <19200000>;
   860						required-opps = <&rpmhpd_opp_min_svs>;
   861					};
   862	
   863					opp-100000000 {
   864						opp-hz = /bits/ 64 <100000000>;
   865						required-opps = <&rpmhpd_opp_low_svs>;
   866					};
   867	
   868					opp-384000000 {
   869						opp-hz = /bits/ 64 <384000000>;
   870						required-opps = <&rpmhpd_opp_svs_l1>;
   871					};
   872				};
   873			};
   874	
   875			gpi_dma0: dma-controller@800000 {
   876				compatible = "qcom,sm6350-gpi-dma";
   877				reg = <0 0x00800000 0 0x60000>;
   878				interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
   879					     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
   880					     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
   881					     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
   882					     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
   883					     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
   884					     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
   885					     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
   886					     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
   887					     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>;
   888				dma-channels = <10>;
   889				dma-channel-mask = <0x1f>;
   890				iommus = <&apps_smmu 0x56 0x0>;
   891				#dma-cells = <3>;
   892				status = "disabled";
   893			};
   894	
   895			qupv3_id_0: geniqup@8c0000 {
   896				compatible = "qcom,geni-se-qup";
   897				reg = <0x0 0x008c0000 0x0 0x2000>;
   898				clock-names = "m-ahb", "s-ahb";
   899				clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
   900					 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
   901				#address-cells = <2>;
   902				#size-cells = <2>;
   903				iommus = <&apps_smmu 0x43 0x0>;
   904				ranges;
   905				status = "disabled";
   906	
   907				i2c0: i2c@880000 {
   908					compatible = "qcom,geni-i2c";
   909					reg = <0 0x00880000 0 0x4000>;
   910					clock-names = "se";
   911					clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
   912					pinctrl-names = "default";
   913					pinctrl-0 = <&qup_i2c0_default>;
   914					interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
   915					dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
   916					       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
   917					dma-names = "tx", "rx";
   918					#address-cells = <1>;
   919					#size-cells = <0>;
   920					interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
   921							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
   922							<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
   923					interconnect-names = "qup-core", "qup-config", "qup-memory";
   924					status = "disabled";
   925				};
   926	
   927				uart1: serial@884000 {
   928					compatible = "qcom,geni-uart";
   929					reg = <0 0x00884000 0 0x4000>;
   930					clock-names = "se";
   931					clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
   932					pinctrl-names = "default";
   933					pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;
   934					interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
   935					power-domains = <&rpmhpd SM6350_CX>;
   936					operating-points-v2 = <&qup_opp_table>;
   937					interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
   938							<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
   939					interconnect-names = "qup-core", "qup-config";
   940					status = "disabled";
   941				};
   942	
   943				i2c2: i2c@888000 {
   944					compatible = "qcom,geni-i2c";
   945					reg = <0 0x00888000 0 0x4000>;
   946					clock-names = "se";
   947					clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
   948					pinctrl-names = "default";
   949					pinctrl-0 = <&qup_i2c2_default>;
   950					interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
   951					dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
   952					       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
   953					dma-names = "tx", "rx";
   954					#address-cells = <1>;
   955					#size-cells = <0>;
   956					interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
   957							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
   958							<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
   959					interconnect-names = "qup-core", "qup-config", "qup-memory";
   960					status = "disabled";
   961				};
   962			};
   963	
   964			gpi_dma1: dma-controller@900000 {
   965				compatible = "qcom,sm6350-gpi-dma";
   966				reg = <0 0x00900000 0 0x60000>;
   967				interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH>,
   968					     <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>,
   969					     <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>,
   970					     <GIC_SPI 648 IRQ_TYPE_LEVEL_HIGH>,
   971					     <GIC_SPI 649 IRQ_TYPE_LEVEL_HIGH>,
   972					     <GIC_SPI 650 IRQ_TYPE_LEVEL_HIGH>,
   973					     <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH>,
   974					     <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
   975					     <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH>,
   976					     <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH>;
   977				dma-channels = <10>;
   978				dma-channel-mask = <0x3f>;
   979				iommus = <&apps_smmu 0x4d6 0x0>;
   980				#dma-cells = <3>;
   981				status = "disabled";
   982			};
   983	
   984			qupv3_id_1: geniqup@9c0000 {
   985				compatible = "qcom,geni-se-qup";
   986				reg = <0x0 0x009c0000 0x0 0x2000>;
   987				clock-names = "m-ahb", "s-ahb";
   988				clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
   989					 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
   990				#address-cells = <2>;
   991				#size-cells = <2>;
   992				iommus = <&apps_smmu 0x4c3 0x0>;
   993				ranges;
   994				status = "disabled";
   995	
   996				i2c6: i2c@980000 {
   997					compatible = "qcom,geni-i2c";
   998					reg = <0 0x00980000 0 0x4000>;
   999					clock-names = "se";
  1000					clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
  1001					pinctrl-names = "default";
  1002					pinctrl-0 = <&qup_i2c6_default>;
  1003					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
  1004					dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
  1005					       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
  1006					dma-names = "tx", "rx";
  1007					#address-cells = <1>;
  1008					#size-cells = <0>;
  1009					interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
  1010							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
  1011							<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
  1012					interconnect-names = "qup-core", "qup-config", "qup-memory";
  1013					status = "disabled";
  1014				};
  1015	
  1016				i2c7: i2c@984000 {
  1017					compatible = "qcom,geni-i2c";
  1018					reg = <0 0x00984000 0 0x4000>;
  1019					clock-names = "se";
  1020					clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
  1021					pinctrl-names = "default";
  1022					pinctrl-0 = <&qup_i2c7_default>;
  1023					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
  1024					dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
  1025					       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
  1026					dma-names = "tx", "rx";
  1027					#address-cells = <1>;
  1028					#size-cells = <0>;
  1029					interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
  1030							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
  1031							<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
  1032					interconnect-names = "qup-core", "qup-config", "qup-memory";
  1033					status = "disabled";
  1034				};
  1035	
  1036				i2c8: i2c@988000 {
  1037					compatible = "qcom,geni-i2c";
  1038					reg = <0 0x00988000 0 0x4000>;
  1039					clock-names = "se";
  1040					clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
  1041					pinctrl-names = "default";
  1042					pinctrl-0 = <&qup_i2c8_default>;
  1043					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
  1044					dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
  1045					       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
  1046					dma-names = "tx", "rx";
  1047					#address-cells = <1>;
  1048					#size-cells = <0>;
  1049					interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
  1050							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
  1051							<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
  1052					interconnect-names = "qup-core", "qup-config", "qup-memory";
  1053					status = "disabled";
  1054				};
  1055	
  1056				uart9: serial@98c000 {
  1057					compatible = "qcom,geni-debug-uart";
  1058					reg = <0 0x0098c000 0 0x4000>;
  1059					clock-names = "se";
  1060					clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
  1061					pinctrl-names = "default";
  1062					pinctrl-0 = <&qup_uart9_default>;
  1063					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
  1064					interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
  1065							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
  1066					interconnect-names = "qup-core", "qup-config";
  1067					status = "disabled";
  1068				};
  1069	
  1070				i2c10: i2c@990000 {
  1071					compatible = "qcom,geni-i2c";
  1072					reg = <0 0x00990000 0 0x4000>;
  1073					clock-names = "se";
  1074					clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
  1075					pinctrl-names = "default";
  1076					pinctrl-0 = <&qup_i2c10_default>;
  1077					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
  1078					dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
  1079					       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
  1080					dma-names = "tx", "rx";
  1081					#address-cells = <1>;
  1082					#size-cells = <0>;
  1083					interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
  1084							<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
  1085							<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
  1086					interconnect-names = "qup-core", "qup-config", "qup-memory";
  1087					status = "disabled";
  1088				};
  1089			};
  1090	
  1091			config_noc: interconnect@1500000 {
  1092				compatible = "qcom,sm6350-config-noc";
  1093				reg = <0 0x01500000 0 0x28000>;
  1094				#interconnect-cells = <2>;
  1095				qcom,bcm-voters = <&apps_bcm_voter>;
  1096			};
  1097	
  1098			system_noc: interconnect@1620000 {
  1099				compatible = "qcom,sm6350-system-noc";
  1100				reg = <0 0x01620000 0 0x17080>;
  1101				#interconnect-cells = <2>;
  1102				qcom,bcm-voters = <&apps_bcm_voter>;
  1103	
  1104				clk_virt: interconnect-clk-virt {
  1105					compatible = "qcom,sm6350-clk-virt";
  1106					#interconnect-cells = <2>;
  1107					qcom,bcm-voters = <&apps_bcm_voter>;
  1108				};
  1109			};
  1110	
  1111			aggre1_noc: interconnect@16e0000 {
  1112				compatible = "qcom,sm6350-aggre1-noc";
  1113				reg = <0 0x016e0000 0 0x15080>;
  1114				#interconnect-cells = <2>;
  1115				qcom,bcm-voters = <&apps_bcm_voter>;
  1116			};
  1117	
  1118			aggre2_noc: interconnect@1700000 {
  1119				compatible = "qcom,sm6350-aggre2-noc";
  1120				reg = <0 0x01700000 0 0x1f880>;
  1121				#interconnect-cells = <2>;
  1122				qcom,bcm-voters = <&apps_bcm_voter>;
  1123	
  1124				compute_noc: interconnect-compute-noc {
  1125					compatible = "qcom,sm6350-compute-noc";
  1126					#interconnect-cells = <2>;
  1127					qcom,bcm-voters = <&apps_bcm_voter>;
  1128				};
  1129			};
  1130	
  1131			mmss_noc: interconnect@1740000 {
  1132				compatible = "qcom,sm6350-mmss-noc";
  1133				reg = <0 0x01740000 0 0x1c100>;
  1134				#interconnect-cells = <2>;
  1135				qcom,bcm-voters = <&apps_bcm_voter>;
  1136			};
  1137	
  1138			ufs_mem_hc: ufs@1d84000 {
  1139				compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
  1140					     "jedec,ufs-2.0";
  1141				reg = <0 0x01d84000 0 0x3000>,
  1142				      <0 0x01d90000 0 0x8000>;
  1143				reg-names = "std", "ice";
  1144				interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
  1145				phys = <&ufs_mem_phy_lanes>;
  1146				phy-names = "ufsphy";
  1147				lanes-per-direction = <2>;
  1148				#reset-cells = <1>;
  1149				resets = <&gcc GCC_UFS_PHY_BCR>;
  1150				reset-names = "rst";
  1151	
  1152				power-domains = <&gcc UFS_PHY_GDSC>;
  1153	
  1154				iommus = <&apps_smmu 0x80 0x0>;
  1155	
  1156				clock-names = "core_clk",
  1157					      "bus_aggr_clk",
  1158					      "iface_clk",
  1159					      "core_clk_unipro",
  1160					      "ref_clk",
  1161					      "tx_lane0_sync_clk",
  1162					      "rx_lane0_sync_clk",
  1163					      "rx_lane1_sync_clk",
  1164					      "ice_core_clk";
  1165				clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
  1166					 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
  1167					 <&gcc GCC_UFS_PHY_AHB_CLK>,
  1168					 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
  1169					 <&rpmhcc RPMH_QLINK_CLK>,
  1170					 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
  1171					 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
  1172					 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
  1173					 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
  1174				freq-table-hz =
  1175					<50000000 200000000>,
  1176					<0 0>,
  1177					<0 0>,
  1178					<37500000 150000000>,
  1179					<75000000 300000000>,
  1180					<0 0>,
  1181					<0 0>,
  1182					<0 0>,
  1183					<0 0>;
  1184	
  1185				status = "disabled";
  1186			};
  1187	
  1188			ufs_mem_phy: phy@1d87000 {
  1189				compatible = "qcom,sm6350-qmp-ufs-phy";
  1190				reg = <0 0x01d87000 0 0x18c>;
  1191				#address-cells = <2>;
  1192				#size-cells = <2>;
  1193				ranges;
  1194	
  1195				clock-names = "ref",
  1196					      "ref_aux";
  1197				clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
  1198					 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
  1199	
  1200				resets = <&ufs_mem_hc 0>;
  1201				reset-names = "ufsphy";
  1202	
  1203				status = "disabled";
  1204	
  1205				ufs_mem_phy_lanes: phy@1d87400 {
  1206					reg = <0 0x01d87400 0 0x128>,
  1207					      <0 0x01d87600 0 0x1fc>,
  1208					      <0 0x01d87c00 0 0x1dc>,
  1209					      <0 0x01d87800 0 0x128>,
  1210					      <0 0x01d87a00 0 0x1fc>;
  1211					#phy-cells = <0>;
  1212				};
  1213			};
  1214	
  1215			ipa: ipa@1e40000 {
  1216				compatible = "qcom,sm6350-ipa";
  1217	
  1218				iommus = <&apps_smmu 0x440 0x0>,
  1219					 <&apps_smmu 0x442 0x0>;
  1220				reg = <0 0x01e40000 0 0x8000>,
  1221				      <0 0x01e50000 0 0x3000>,
  1222				      <0 0x01e04000 0 0x23000>;
  1223				reg-names = "ipa-reg",
  1224					    "ipa-shared",
  1225					    "gsi";
  1226	
  1227				interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
  1228						      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
  1229						      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
  1230						      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
  1231				interrupt-names = "ipa",
  1232						  "gsi",
  1233						  "ipa-clock-query",
  1234						  "ipa-setup-ready";
  1235	
  1236				clocks = <&rpmhcc RPMH_IPA_CLK>;
  1237				clock-names = "core";
  1238	
  1239				interconnects = <&aggre2_noc MASTER_IPA 0 &clk_virt SLAVE_EBI_CH0 0>,
  1240						<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_OCIMEM 0>,
  1241						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_IPA_CFG 0>;
  1242				interconnect-names = "memory", "imem", "config";
  1243	
  1244				qcom,smem-states = <&ipa_smp2p_out 0>,
  1245						   <&ipa_smp2p_out 1>;
  1246				qcom,smem-state-names = "ipa-clock-enabled-valid",
  1247							"ipa-clock-enabled";
  1248	
  1249				status = "disabled";
  1250			};
  1251	
  1252			tcsr_mutex: hwlock@1f40000 {
  1253				compatible = "qcom,tcsr-mutex";
  1254				reg = <0x0 0x01f40000 0x0 0x40000>;
  1255				#hwlock-cells = <1>;
  1256			};
  1257	
  1258			adsp: remoteproc@3000000 {
  1259				compatible = "qcom,sm6350-adsp-pas";
  1260				reg = <0 0x03000000 0 0x100>;
  1261	
  1262				interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
  1263						      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
  1264						      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
  1265						      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
  1266						      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
  1267				interrupt-names = "wdog", "fatal", "ready",
  1268						  "handover", "stop-ack";
  1269	
  1270				clocks = <&rpmhcc RPMH_CXO_CLK>;
  1271				clock-names = "xo";
  1272	
  1273				power-domains = <&rpmhpd SM6350_LCX>,
  1274						<&rpmhpd SM6350_LMX>;
  1275				power-domain-names = "lcx", "lmx";
  1276	
  1277				memory-region = <&pil_adsp_mem>;
  1278	
  1279				qcom,qmp = <&aoss_qmp>;
  1280	
  1281				qcom,smem-states = <&smp2p_adsp_out 0>;
  1282				qcom,smem-state-names = "stop";
  1283	
  1284				status = "disabled";
  1285	
  1286				glink-edge {
  1287					interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
  1288								     IPCC_MPROC_SIGNAL_GLINK_QMP
  1289								     IRQ_TYPE_EDGE_RISING>;
  1290					mboxes = <&ipcc IPCC_CLIENT_LPASS
  1291							IPCC_MPROC_SIGNAL_GLINK_QMP>;
  1292	
  1293					label = "lpass";
  1294					qcom,remote-pid = <2>;
  1295	
  1296					fastrpc {
  1297						compatible = "qcom,fastrpc";
  1298						qcom,glink-channels = "fastrpcglink-apps-dsp";
  1299						label = "adsp";
  1300						#address-cells = <1>;
  1301						#size-cells = <0>;
  1302	
  1303						compute-cb@3 {
  1304							compatible = "qcom,fastrpc-compute-cb";
  1305							reg = <3>;
  1306							iommus = <&apps_smmu 0x1003 0x0>;
  1307						};
  1308	
  1309						compute-cb@4 {
  1310							compatible = "qcom,fastrpc-compute-cb";
  1311							reg = <4>;
  1312							iommus = <&apps_smmu 0x1004 0x0>;
  1313						};
  1314	
  1315						compute-cb@5 {
  1316							compatible = "qcom,fastrpc-compute-cb";
  1317							reg = <5>;
  1318							iommus = <&apps_smmu 0x1005 0x0>;
  1319							qcom,nsessions = <5>;
  1320						};
  1321					};
  1322				};
  1323			};
  1324	
  1325			gpu: gpu@3d00000 {
  1326				compatible = "qcom,adreno-619.0", "qcom,adreno";
  1327				reg = <0 0x03d00000 0 0x40000>,
  1328				      <0 0x03d9e000 0 0x1000>;
  1329				reg-names = "kgsl_3d0_reg_memory",
  1330					    "cx_mem";
  1331				interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
  1332	
  1333				iommus = <&adreno_smmu 0>;
  1334				operating-points-v2 = <&gpu_opp_table>;
  1335				qcom,gmu = <&gmu>;
  1336				nvmem-cells = <&gpu_speed_bin>;
  1337				nvmem-cell-names = "speed_bin";
  1338	
  1339				status = "disabled";
  1340	
  1341				zap-shader {
  1342					memory-region = <&pil_gpu_mem>;
  1343				};
  1344	
  1345				gpu_opp_table: opp-table {
  1346					compatible = "operating-points-v2";
  1347	
  1348					opp-850000000 {
  1349						opp-hz = /bits/ 64 <850000000>;
  1350						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
  1351						opp-supported-hw = <0x02>;
  1352					};
  1353	
  1354					opp-800000000 {
  1355						opp-hz = /bits/ 64 <800000000>;
  1356						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
  1357						opp-supported-hw = <0x04>;
  1358					};
  1359	
  1360					opp-650000000 {
  1361						opp-hz = /bits/ 64 <650000000>;
  1362						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
  1363						opp-supported-hw = <0x08>;
  1364					};
  1365	
  1366					opp-565000000 {
  1367						opp-hz = /bits/ 64 <565000000>;
  1368						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
  1369						opp-supported-hw = <0x10>;
  1370					};
  1371	
  1372					opp-430000000 {
  1373						opp-hz = /bits/ 64 <430000000>;
  1374						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
  1375						opp-supported-hw = <0xff>;
  1376					};
  1377	
  1378					opp-355000000 {
  1379						opp-hz = /bits/ 64 <355000000>;
  1380						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
  1381						opp-supported-hw = <0xff>;
  1382					};
  1383	
  1384					opp-253000000 {
  1385						opp-hz = /bits/ 64 <253000000>;
  1386						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
  1387						opp-supported-hw = <0xff>;
  1388					};
  1389				};
  1390			};
  1391	
  1392			adreno_smmu: iommu@3d40000 {
  1393				compatible = "qcom,sm6350-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
  1394				reg = <0 0x03d40000 0 0x10000>;
  1395				#iommu-cells = <1>;
  1396				#global-interrupts = <2>;
  1397				interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
  1398					     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
  1399					     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
  1400					     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
  1401					     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
  1402					     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
  1403					     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
  1404					     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
  1405					     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
  1406					     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
  1407	
  1408				clocks = <&gpucc GPU_CC_AHB_CLK>,
  1409					 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
  1410					 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
  1411				clock-names = "ahb",
  1412					      "bus",
  1413					      "iface";
  1414	
  1415				power-domains = <&gpucc GPU_CX_GDSC>;
  1416			};
  1417	
  1418			gmu: gmu@3d6a000 {
  1419				compatible = "qcom,adreno-gmu-619.0", "qcom,adreno-gmu";
  1420				reg = <0 0x03d6a000 0 0x31000>,
  1421				      <0 0x0b290000 0 0x10000>,
  1422				      <0 0x0b490000 0 0x10000>;
  1423				reg-names = "gmu",
  1424					    "gmu_pdc",
  1425					    "gmu_pdc_seq";
  1426	
  1427				interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
  1428					     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
  1429				interrupt-names = "hfi",
  1430						  "gmu";
  1431	
  1432				clocks = <&gpucc GPU_CC_AHB_CLK>,
  1433					 <&gpucc GPU_CC_CX_GMU_CLK>,
  1434					 <&gpucc GPU_CC_CXO_CLK>,
  1435					 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
  1436					 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
  1437				clock-names = "ahb",
  1438					      "gmu",
  1439					      "cxo",
  1440					      "axi",
  1441					      "memnoc";
  1442	
  1443				power-domains = <&gpucc GPU_CX_GDSC>,
  1444						<&gpucc GPU_GX_GDSC>;
  1445				power-domain-names = "cx",
  1446						     "gx";
  1447	
  1448				iommus = <&adreno_smmu 5>;
  1449	
  1450				operating-points-v2 = <&gmu_opp_table>;
  1451	
  1452				status = "disabled";
  1453	
  1454				gmu_opp_table: opp-table {
  1455					compatible = "operating-points-v2";
  1456	
  1457					opp-200000000 {
  1458						opp-hz = /bits/ 64 <200000000>;
  1459						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
  1460					};
  1461				};
  1462			};
  1463	
  1464			gpucc: clock-controller@3d90000 {
  1465				compatible = "qcom,sm6350-gpucc";
  1466				reg = <0 0x03d90000 0 0x9000>;
  1467				clocks = <&rpmhcc RPMH_CXO_CLK>,
  1468					 <&gcc GCC_GPU_GPLL0_CLK>,
  1469					 <&gcc GCC_GPU_GPLL0_DIV_CLK>;
  1470				clock-names = "bi_tcxo",
  1471					      "gcc_gpu_gpll0_clk_src",
  1472					      "gcc_gpu_gpll0_div_clk_src";
  1473				#clock-cells = <1>;
  1474				#reset-cells = <1>;
  1475				#power-domain-cells = <1>;
  1476			};
  1477	
  1478			mpss: remoteproc@4080000 {
  1479				compatible = "qcom,sm6350-mpss-pas";
  1480				reg = <0x0 0x04080000 0x0 0x4040>;
  1481	
  1482				interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
  1483						      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
  1484						      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
  1485						      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
  1486						      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
  1487						      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
  1488				interrupt-names = "wdog", "fatal", "ready", "handover",
  1489						  "stop-ack", "shutdown-ack";
  1490	
  1491				clocks = <&rpmhcc RPMH_CXO_CLK>;
  1492				clock-names = "xo";
  1493	
  1494				power-domains = <&rpmhpd SM6350_CX>,
  1495						<&rpmhpd SM6350_MSS>;
  1496				power-domain-names = "cx", "mss";
  1497	
  1498				memory-region = <&pil_modem_mem>;
  1499	
  1500				qcom,qmp = <&aoss_qmp>;
  1501	
  1502				qcom,smem-states = <&modem_smp2p_out 0>;
  1503				qcom,smem-state-names = "stop";
  1504	
  1505				status = "disabled";
  1506	
  1507				glink-edge {
  1508					interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
  1509								     IPCC_MPROC_SIGNAL_GLINK_QMP
  1510								     IRQ_TYPE_EDGE_RISING>;
  1511					mboxes = <&ipcc IPCC_CLIENT_MPSS
  1512							IPCC_MPROC_SIGNAL_GLINK_QMP>;
  1513					label = "modem";
  1514					qcom,remote-pid = <1>;
  1515				};
  1516			};
  1517	
  1518			cdsp: remoteproc@8300000 {
  1519				compatible = "qcom,sm6350-cdsp-pas";
  1520				reg = <0 0x08300000 0 0x10000>;
  1521	
  1522				interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
  1523						      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
  1524						      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
  1525						      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
  1526						      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
  1527				interrupt-names = "wdog", "fatal", "ready",
  1528						  "handover", "stop-ack";
  1529	
  1530				clocks = <&rpmhcc RPMH_CXO_CLK>;
  1531				clock-names = "xo";
  1532	
  1533				power-domains = <&rpmhpd SM6350_CX>,
  1534						<&rpmhpd SM6350_MX>;
  1535				power-domain-names = "cx", "mx";
  1536	
  1537				memory-region = <&pil_cdsp_mem>;
  1538	
  1539				qcom,qmp = <&aoss_qmp>;
  1540	
  1541				qcom,smem-states = <&smp2p_cdsp_out 0>;
  1542				qcom,smem-state-names = "stop";
  1543	
  1544				status = "disabled";
  1545	
  1546				glink-edge {
  1547					interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
  1548								     IPCC_MPROC_SIGNAL_GLINK_QMP
  1549								     IRQ_TYPE_EDGE_RISING>;
  1550					mboxes = <&ipcc IPCC_CLIENT_CDSP
  1551							IPCC_MPROC_SIGNAL_GLINK_QMP>;
  1552	
  1553					label = "cdsp";
  1554					qcom,remote-pid = <5>;
  1555	
  1556					fastrpc {
  1557						compatible = "qcom,fastrpc";
  1558						qcom,glink-channels = "fastrpcglink-apps-dsp";
  1559						label = "cdsp";
  1560						#address-cells = <1>;
  1561						#size-cells = <0>;
  1562	
  1563						compute-cb@1 {
  1564							compatible = "qcom,fastrpc-compute-cb";
  1565							reg = <1>;
  1566							iommus = <&apps_smmu 0x1401 0x20>;
  1567						};
  1568	
  1569						compute-cb@2 {
  1570							compatible = "qcom,fastrpc-compute-cb";
  1571							reg = <2>;
  1572							iommus = <&apps_smmu 0x1402 0x20>;
  1573						};
  1574	
  1575						compute-cb@3 {
  1576							compatible = "qcom,fastrpc-compute-cb";
  1577							reg = <3>;
  1578							iommus = <&apps_smmu 0x1403 0x20>;
  1579						};
  1580	
  1581						compute-cb@4 {
  1582							compatible = "qcom,fastrpc-compute-cb";
  1583							reg = <4>;
  1584							iommus = <&apps_smmu 0x1404 0x20>;
  1585						};
  1586	
  1587						compute-cb@5 {
  1588							compatible = "qcom,fastrpc-compute-cb";
  1589							reg = <5>;
  1590							iommus = <&apps_smmu 0x1405 0x20>;
  1591						};
  1592	
  1593						compute-cb@6 {
  1594							compatible = "qcom,fastrpc-compute-cb";
  1595							reg = <6>;
  1596							iommus = <&apps_smmu 0x1406 0x20>;
  1597						};
  1598	
  1599						compute-cb@7 {
  1600							compatible = "qcom,fastrpc-compute-cb";
  1601							reg = <7>;
  1602							iommus = <&apps_smmu 0x1407 0x20>;
  1603						};
  1604	
  1605						compute-cb@8 {
  1606							compatible = "qcom,fastrpc-compute-cb";
  1607							reg = <8>;
  1608							iommus = <&apps_smmu 0x1408 0x20>;
  1609						};
  1610	
  1611						/* note: secure cb9 in downstream */
  1612					};
  1613				};
  1614			};
  1615	
  1616			sdhc_2: mmc@8804000 {
  1617				compatible = "qcom,sm6350-sdhci", "qcom,sdhci-msm-v5";
  1618				reg = <0 0x08804000 0 0x1000>;
  1619	
  1620				interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
  1621					     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
  1622				interrupt-names = "hc_irq", "pwr_irq";
  1623				iommus = <&apps_smmu 0x560 0x0>;
  1624	
  1625				clocks = <&gcc GCC_SDCC2_AHB_CLK>,
  1626					 <&gcc GCC_SDCC2_APPS_CLK>,
  1627					 <&rpmhcc RPMH_CXO_CLK>;
  1628				clock-names = "iface", "core", "xo";
  1629				resets = <&gcc GCC_SDCC2_BCR>;
  1630				interconnects = <&aggre2_noc MASTER_SDCC_2 0 &clk_virt SLAVE_EBI_CH0 0>,
  1631						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
  1632				interconnect-names = "sdhc-ddr", "cpu-sdhc";
  1633	
  1634				pinctrl-0 = <&sdc2_on_state>;
  1635				pinctrl-1 = <&sdc2_off_state>;
  1636				pinctrl-names = "default", "sleep";
  1637	
  1638				qcom,dll-config = <0x0007642c>;
  1639				qcom,ddr-config = <0x80040868>;
  1640				power-domains = <&rpmhpd SM6350_CX>;
  1641				operating-points-v2 = <&sdhc2_opp_table>;
  1642				bus-width = <4>;
  1643	
  1644				status = "disabled";
  1645	
  1646				sdhc2_opp_table: opp-table {
  1647					compatible = "operating-points-v2";
  1648	
  1649					opp-100000000 {
  1650						opp-hz = /bits/ 64 <100000000>;
  1651						required-opps = <&rpmhpd_opp_svs_l1>;
  1652						opp-peak-kBps = <790000 131000>;
  1653						opp-avg-kBps = <50000 50000>;
  1654					};
  1655	
  1656					opp-202000000 {
  1657						opp-hz = /bits/ 64 <202000000>;
  1658						required-opps = <&rpmhpd_opp_nom>;
  1659						opp-peak-kBps = <3190000 294000>;
  1660						opp-avg-kBps = <261438 300000>;
  1661					};
  1662				};
  1663			};
  1664	
  1665			usb_1_hsphy: phy@88e3000 {
  1666				compatible = "qcom,sm6350-qusb2-phy", "qcom,qusb2-v2-phy";
  1667				reg = <0 0x088e3000 0 0x400>;
  1668				status = "disabled";
  1669				#phy-cells = <0>;
  1670	
  1671				clocks = <&xo_board>, <&rpmhcc RPMH_CXO_CLK>;
  1672				clock-names = "cfg_ahb", "ref";
  1673	
  1674				resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
  1675			};
  1676	
  1677			usb_1_qmpphy: phy@88e8000 {
  1678				compatible = "qcom,sm6350-qmp-usb3-dp-phy";
  1679				reg = <0 0x088e8000 0 0x3000>;
  1680	
  1681				clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
  1682					 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
  1683					 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
  1684					 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
  1685				clock-names = "aux", "ref", "com_aux", "usb3_pipe";
  1686	
  1687				power-domains = <&gcc USB30_PRIM_GDSC>;
  1688	
  1689				resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
  1690					 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
  1691				reset-names = "phy", "common";
  1692	
  1693				#clock-cells = <1>;
  1694				#phy-cells = <1>;
  1695	
  1696				status = "disabled";
  1697			};
  1698	
  1699			dc_noc: interconnect@9160000 {
  1700				compatible = "qcom,sm6350-dc-noc";
  1701				reg = <0 0x09160000 0 0x3200>;
  1702				#interconnect-cells = <2>;
  1703				qcom,bcm-voters = <&apps_bcm_voter>;
  1704			};
  1705	
  1706			system-cache-controller@9200000 {
  1707				compatible = "qcom,sm6350-llcc";
  1708				reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
  1709				reg-names = "llcc0_base", "llcc_broadcast_base";
  1710			};
  1711	
  1712			gem_noc: interconnect@9680000 {
  1713				compatible = "qcom,sm6350-gem-noc";
  1714				reg = <0 0x09680000 0 0x3e200>;
  1715				#interconnect-cells = <2>;
  1716				qcom,bcm-voters = <&apps_bcm_voter>;
  1717			};
  1718	
  1719			npu_noc: interconnect@9990000 {
  1720				compatible = "qcom,sm6350-npu-noc";
  1721				reg = <0 0x09990000 0 0x1600>;
  1722				#interconnect-cells = <2>;
  1723				qcom,bcm-voters = <&apps_bcm_voter>;
  1724			};
  1725	
  1726			usb_1: usb@a6f8800 {
  1727				compatible = "qcom,sm6350-dwc3", "qcom,dwc3";
  1728				reg = <0 0x0a6f8800 0 0x400>;
  1729				status = "disabled";
  1730				#address-cells = <2>;
  1731				#size-cells = <2>;
  1732				ranges;
  1733	
  1734				clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
  1735					 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
  1736					 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
  1737					 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
  1738					 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
  1739				clock-names = "cfg_noc",
  1740					      "core",
  1741					      "iface",
  1742					      "sleep",
  1743					      "mock_utmi";
  1744	
  1745				interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
  1746						      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
  1747						      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
  1748						      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
  1749	
  1750				interrupt-names = "hs_phy_irq", "ss_phy_irq",
  1751						  "dm_hs_phy_irq", "dp_hs_phy_irq";
  1752	
  1753				power-domains = <&gcc USB30_PRIM_GDSC>;
  1754	
  1755				resets = <&gcc GCC_USB30_PRIM_BCR>;
  1756	
  1757				interconnects = <&aggre2_noc MASTER_USB3 0 &clk_virt SLAVE_EBI_CH0 0>,
  1758						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
  1759				interconnect-names = "usb-ddr", "apps-usb";
  1760	
  1761				usb_1_dwc3: usb@a600000 {
  1762					compatible = "snps,dwc3";
  1763					reg = <0 0x0a600000 0 0xcd00>;
  1764					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
  1765					iommus = <&apps_smmu 0x540 0x0>;
  1766					snps,dis_u2_susphy_quirk;
  1767					snps,dis_enblslpm_quirk;
  1768					snps,has-lpm-erratum;
  1769					snps,hird-threshold = /bits/ 8 <0x10>;
  1770					phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
  1771					phy-names = "usb2-phy", "usb3-phy";
  1772				};
  1773			};
  1774	
  1775			cci0: cci@ac4a000 {
  1776				compatible = "qcom,sm6350-cci", "qcom,msm8996-cci";
  1777				reg = <0 0x0ac4a000 0 0x1000>;
  1778				interrupts = <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>;
  1779				power-domains = <&camcc TITAN_TOP_GDSC>;
  1780	
  1781				clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
  1782					 <&camcc CAMCC_SOC_AHB_CLK>,
  1783					 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
  1784					 <&camcc CAMCC_CPAS_AHB_CLK>,
  1785					 <&camcc CAMCC_CCI_0_CLK>,
  1786					 <&camcc CAMCC_CCI_0_CLK_SRC>;
  1787				clock-names = "camnoc_axi",
  1788					      "soc_ahb",
  1789					      "slow_ahb_src",
  1790					      "cpas_ahb",
  1791					      "cci",
  1792					      "cci_src";
  1793	
  1794				assigned-clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
  1795						  <&camcc CAMCC_CCI_0_CLK>;
  1796				assigned-clock-rates = <80000000>, <37500000>;
  1797	
  1798				pinctrl-0 = <&cci0_default &cci1_default>;
  1799				pinctrl-1 = <&cci0_sleep &cci1_sleep>;
  1800				pinctrl-names = "default", "sleep";
  1801	
  1802				#address-cells = <1>;
  1803				#size-cells = <0>;
  1804	
  1805				status = "disabled";
  1806	
  1807				cci0_i2c0: i2c-bus@0 {
  1808					reg = <0>;
  1809					clock-frequency = <1000000>;
  1810					#address-cells = <1>;
  1811					#size-cells = <0>;
  1812				};
  1813	
  1814				cci0_i2c1: i2c-bus@1 {
  1815					reg = <1>;
  1816					clock-frequency = <1000000>;
  1817					#address-cells = <1>;
  1818					#size-cells = <0>;
  1819				};
  1820			};
  1821	
  1822			cci1: cci@ac4b000 {
  1823				compatible = "qcom,sm6350-cci", "qcom,msm8996-cci";
  1824				reg = <0 0x0ac4b000 0 0x1000>;
  1825				interrupts = <GIC_SPI 462 IRQ_TYPE_EDGE_RISING>;
  1826				power-domains = <&camcc TITAN_TOP_GDSC>;
  1827	
  1828				clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
  1829					 <&camcc CAMCC_SOC_AHB_CLK>,
  1830					 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
  1831					 <&camcc CAMCC_CPAS_AHB_CLK>,
  1832					 <&camcc CAMCC_CCI_1_CLK>,
  1833					 <&camcc CAMCC_CCI_1_CLK_SRC>;
  1834				clock-names = "camnoc_axi",
  1835					      "soc_ahb",
  1836					      "slow_ahb_src",
  1837					      "cpas_ahb",
  1838					      "cci",
  1839					      "cci_src";
  1840	
  1841				assigned-clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
  1842						  <&camcc CAMCC_CCI_1_CLK>;
  1843				assigned-clock-rates = <80000000>, <37500000>;
  1844	
  1845				pinctrl-0 = <&cci2_default>;
  1846				pinctrl-1 = <&cci2_sleep>;
  1847				pinctrl-names = "default", "sleep";
  1848	
  1849				#address-cells = <1>;
  1850				#size-cells = <0>;
  1851	
  1852				status = "disabled";
  1853	
  1854				cci1_i2c0: i2c-bus@0 {
  1855					reg = <0>;
  1856					clock-frequency = <1000000>;
  1857					#address-cells = <1>;
  1858					#size-cells = <0>;
  1859				};
  1860	
  1861				/* SM6350 seems to have cci1_i2c1 on gpio2 & gpio3 but unused downstream */
  1862			};
  1863	
  1864			camcc: clock-controller@ad00000 {
  1865				compatible = "qcom,sm6350-camcc";
  1866				reg = <0 0x0ad00000 0 0x16000>;
  1867				clocks = <&rpmhcc RPMH_CXO_CLK>;
  1868				#clock-cells = <1>;
  1869				#reset-cells = <1>;
  1870				#power-domain-cells = <1>;
  1871			};
  1872	
  1873			mdss: display-subsystem@ae00000 {
  1874				compatible = "qcom,sm6350-mdss";
  1875				reg = <0 0x0ae00000 0 0x1000>;
  1876				reg-names = "mdss";
  1877	
  1878				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
  1879				interrupt-controller;
  1880				#interrupt-cells = <1>;
  1881	
  1882				clocks = <&gcc GCC_DISP_AHB_CLK>,
  1883					 <&gcc GCC_DISP_AXI_CLK>,
  1884					 <&dispcc DISP_CC_MDSS_MDP_CLK>;
  1885				clock-names = "iface",
  1886					      "bus",
  1887					      "core";
  1888	
  1889				power-domains = <&dispcc MDSS_GDSC>;
  1890				iommus = <&apps_smmu 0x800 0x2>;
  1891	
  1892				#address-cells = <2>;
  1893				#size-cells = <2>;
  1894				ranges;
  1895	
  1896				status = "disabled";
  1897	
  1898				mdss_mdp: display-controller@ae01000 {
  1899					compatible = "qcom,sm6350-dpu";
  1900					reg = <0 0x0ae01000 0 0x8f000>,
  1901					      <0 0x0aeb0000 0 0x2008>;
  1902					reg-names = "mdp", "vbif";
  1903	
  1904					interrupt-parent = <&mdss>;
  1905					interrupts = <0>;
  1906	
  1907					clocks = <&gcc GCC_DISP_AXI_CLK>,
  1908						 <&dispcc DISP_CC_MDSS_AHB_CLK>,
  1909						 <&dispcc DISP_CC_MDSS_ROT_CLK>,
  1910						 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
  1911						 <&dispcc DISP_CC_MDSS_MDP_CLK>,
  1912						 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
  1913					clock-names = "bus",
  1914						      "iface",
  1915						      "rot",
  1916						      "lut",
  1917						      "core",
  1918						      "vsync";
  1919	
  1920					assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
  1921					assigned-clock-rates = <19200000>;
  1922	
  1923					operating-points-v2 = <&mdp_opp_table>;
  1924					power-domains = <&rpmhpd SM6350_CX>;
  1925	
  1926					ports {
  1927						#address-cells = <1>;
  1928						#size-cells = <0>;
  1929	
  1930						port@0 {
  1931							reg = <0>;
  1932	
  1933							dpu_intf1_out: endpoint {
  1934								remote-endpoint = <&mdss_dsi0_in>;
  1935							};
  1936						};
  1937					};
  1938	
  1939					mdp_opp_table: opp-table {
  1940						compatible = "operating-points-v2";
  1941	
  1942						opp-19200000 {
  1943							opp-hz = /bits/ 64 <19200000>;
  1944							required-opps = <&rpmhpd_opp_min_svs>;
  1945						};
  1946	
  1947						opp-200000000 {
  1948							opp-hz = /bits/ 64 <200000000>;
  1949							required-opps = <&rpmhpd_opp_low_svs>;
  1950						};
  1951	
  1952						opp-300000000 {
  1953							opp-hz = /bits/ 64 <300000000>;
  1954							required-opps = <&rpmhpd_opp_svs>;
  1955						};
  1956	
  1957						opp-373333333 {
  1958							opp-hz = /bits/ 64 <373333333>;
  1959							required-opps = <&rpmhpd_opp_svs_l1>;
  1960						};
  1961	
  1962						opp-448000000 {
  1963							opp-hz = /bits/ 64 <448000000>;
  1964							required-opps = <&rpmhpd_opp_nom>;
  1965						};
  1966	
  1967						opp-560000000 {
  1968							opp-hz = /bits/ 64 <560000000>;
  1969							required-opps = <&rpmhpd_opp_turbo>;
  1970						};
  1971					};
  1972				};
  1973	
> 1974				mdss_dsi0: dsi@ae94000 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

