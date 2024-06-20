Return-Path: <linux-kernel+bounces-222648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31791054C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BEC28867E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28D1AD496;
	Thu, 20 Jun 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHidHCTg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E021AD41A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888407; cv=none; b=bQaJ91Ebp178lZ/cw2I4W0rfPkPXmSA8s+M5yt7yvWbspZv6pZ+hRTmgIizdxBY1O0kYU/F484M6J4yxf5nNN6CxRhr2I/VcK9SjQDf6dvv1AYUUhIzSf1H/sGYkJBnwaM0S2+37HaGd0vSD4IVaw6uJJAHBPnnJ589q0CAZQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888407; c=relaxed/simple;
	bh=eT9OoCjtafoAV63wdFdEy0z8di6VruIccWBq/a3yETc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FJ6HptyDy20h3m9IXsr7CQumFQOR4BT0ZruT8z4FjSknlTaTtiI7MN3sumYVhMAINhO+OmuPGaK5bX7xe29pspL51SYRCc0uNTnUBeRJ9wKBxxKkzu8wim/cllniC9QavJQICPBCNv2XGwuxPFdq8qh2JjM7glzqTccXdEy7n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHidHCTg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718888403; x=1750424403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eT9OoCjtafoAV63wdFdEy0z8di6VruIccWBq/a3yETc=;
  b=oHidHCTgoAdKaYobbj4SHd1oudya6mN+cExcExBrChq96LZ8qD6MIduW
   irEvASmknaiUjwoZtgByMvm/+/D6nPnN9pwBxv1fH3TzkB/ghTEAsOkWP
   jYg+enxb/e7B9qB/oWV3c392/jXCpTGayO9AULVxayYLcmxpIMSgbJIlt
   1JktZ0J5xBkEQaCCcGnkuUNQfQlikrpjKdhqS8RvqtFNaeP7imaRWyhyr
   o5WtxCeb00tRQZQspGiq0gDmgN8ICeq6sWDsx2VxeCnqs1AJBItVSZSU5
   cfudOdwSYY6ihJGBTOA4r79oyt0Z2K89LfsRi2ifnEhIikKQyYAFqcBme
   g==;
X-CSE-ConnectionGUID: G6Y+qkn/RlmFphKu6nMhow==
X-CSE-MsgGUID: SkO8H9z4Rp2WtG418HZx6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26548994"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26548994"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:00:03 -0700
X-CSE-ConnectionGUID: s9lgRlOZQ8WIuwXyWkvlxg==
X-CSE-MsgGUID: NJCPel4HQieJWsWYSnNcug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42171617"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 06:00:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKHOQ-0007cG-0u;
	Thu, 20 Jun 2024 12:59:58 +0000
Date: Thu, 20 Jun 2024 20:59:12 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: arch/arm64/boot/dts/qcom/qcm2290.dtsi:1203.27-1276.6: Warning
 (avoid_unnecessary_addr_size): /soc@0/display-subsystem@5e00000/dsi@5e94000:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406202003.29jrD1AF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
commit: a2b32096709dbf4af02675d98356a9d3ad86ff05 arm64: dts: qcom: qcm2290: Add display nodes
date:   7 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240620/202406202003.29jrD1AF-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240620/202406202003.29jrD1AF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406202003.29jrD1AF-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/qcom/qcm2290.dtsi:1203.27-1276.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@5e00000/dsi@5e94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/qcm2290.dtsi:1161.11-1171.7: Warning (graph_child_address): /soc@0/display-subsystem@5e00000/display-controller@5e01000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +1203 arch/arm64/boot/dts/qcom/qcm2290.dtsi

    16	
    17	/ {
    18		interrupt-parent = <&intc>;
    19	
    20		#address-cells = <2>;
    21		#size-cells = <2>;
    22	
    23		chosen { };
    24	
    25		clocks {
    26			xo_board: xo-board {
    27				compatible = "fixed-clock";
    28				#clock-cells = <0>;
    29			};
    30	
    31			sleep_clk: sleep-clk {
    32				compatible = "fixed-clock";
    33				clock-frequency = <32764>;
    34				#clock-cells = <0>;
    35			};
    36		};
    37	
    38		cpus {
    39			#address-cells = <2>;
    40			#size-cells = <0>;
    41	
    42			CPU0: cpu@0 {
    43				device_type = "cpu";
    44				compatible = "arm,cortex-a53";
    45				reg = <0x0 0x0>;
    46				clocks = <&cpufreq_hw 0>;
    47				capacity-dmips-mhz = <1024>;
    48				dynamic-power-coefficient = <100>;
    49				enable-method = "psci";
    50				next-level-cache = <&L2_0>;
    51				qcom,freq-domain = <&cpufreq_hw 0>;
    52				power-domains = <&CPU_PD0>;
    53				power-domain-names = "psci";
    54				L2_0: l2-cache {
    55					compatible = "cache";
    56					cache-level = <2>;
    57					cache-unified;
    58				};
    59			};
    60	
    61			CPU1: cpu@1 {
    62				device_type = "cpu";
    63				compatible = "arm,cortex-a53";
    64				reg = <0x0 0x1>;
    65				clocks = <&cpufreq_hw 0>;
    66				capacity-dmips-mhz = <1024>;
    67				dynamic-power-coefficient = <100>;
    68				enable-method = "psci";
    69				next-level-cache = <&L2_0>;
    70				qcom,freq-domain = <&cpufreq_hw 0>;
    71				power-domains = <&CPU_PD1>;
    72				power-domain-names = "psci";
    73			};
    74	
    75			CPU2: cpu@2 {
    76				device_type = "cpu";
    77				compatible = "arm,cortex-a53";
    78				reg = <0x0 0x2>;
    79				clocks = <&cpufreq_hw 0>;
    80				capacity-dmips-mhz = <1024>;
    81				dynamic-power-coefficient = <100>;
    82				enable-method = "psci";
    83				next-level-cache = <&L2_0>;
    84				qcom,freq-domain = <&cpufreq_hw 0>;
    85				power-domains = <&CPU_PD2>;
    86				power-domain-names = "psci";
    87			};
    88	
    89			CPU3: cpu@3 {
    90				device_type = "cpu";
    91				compatible = "arm,cortex-a53";
    92				reg = <0x0 0x3>;
    93				clocks = <&cpufreq_hw 0>;
    94				capacity-dmips-mhz = <1024>;
    95				dynamic-power-coefficient = <100>;
    96				enable-method = "psci";
    97				next-level-cache = <&L2_0>;
    98				qcom,freq-domain = <&cpufreq_hw 0>;
    99				power-domains = <&CPU_PD3>;
   100				power-domain-names = "psci";
   101			};
   102	
   103			cpu-map {
   104				cluster0 {
   105					core0 {
   106						cpu = <&CPU0>;
   107					};
   108	
   109					core1 {
   110						cpu = <&CPU1>;
   111					};
   112	
   113					core2 {
   114						cpu = <&CPU2>;
   115					};
   116	
   117					core3 {
   118						cpu = <&CPU3>;
   119					};
   120				};
   121			};
   122	
   123			domain-idle-states {
   124				CLUSTER_SLEEP: cluster-sleep-0 {
   125					compatible = "domain-idle-state";
   126					arm,psci-suspend-param = <0x41000043>;
   127					entry-latency-us = <800>;
   128					exit-latency-us = <2118>;
   129					min-residency-us = <7376>;
   130				};
   131			};
   132	
   133			idle-states {
   134				entry-method = "psci";
   135	
   136				CPU_SLEEP: cpu-sleep-0 {
   137					compatible = "arm,idle-state";
   138					idle-state-name = "power-collapse";
   139					arm,psci-suspend-param = <0x40000003>;
   140					entry-latency-us = <290>;
   141					exit-latency-us = <376>;
   142					min-residency-us = <1182>;
   143					local-timer-stop;
   144				};
   145			};
   146		};
   147	
   148		firmware {
   149			scm: scm {
   150				compatible = "qcom,scm-qcm2290", "qcom,scm";
   151				clocks = <&rpmcc RPM_SMD_CE1_CLK>;
   152				clock-names = "core";
   153				#reset-cells = <1>;
   154			};
   155		};
   156	
   157		memory@40000000 {
   158			device_type = "memory";
   159			/* We expect the bootloader to fill in the size */
   160			reg = <0 0x40000000 0 0>;
   161		};
   162	
   163		pmu {
   164			compatible = "arm,armv8-pmuv3";
   165			interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
   166		};
   167	
   168		psci {
   169			compatible = "arm,psci-1.0";
   170			method = "smc";
   171	
   172			CPU_PD0: power-domain-cpu0 {
   173				#power-domain-cells = <0>;
   174				power-domains = <&CLUSTER_PD>;
   175				domain-idle-states = <&CPU_SLEEP>;
   176			};
   177	
   178			CPU_PD1: power-domain-cpu1 {
   179				#power-domain-cells = <0>;
   180				power-domains = <&CLUSTER_PD>;
   181				domain-idle-states = <&CPU_SLEEP>;
   182			};
   183	
   184			CPU_PD2: power-domain-cpu2 {
   185				#power-domain-cells = <0>;
   186				power-domains = <&CLUSTER_PD>;
   187				domain-idle-states = <&CPU_SLEEP>;
   188			};
   189	
   190			CPU_PD3: power-domain-cpu3 {
   191				#power-domain-cells = <0>;
   192				power-domains = <&CLUSTER_PD>;
   193				domain-idle-states = <&CPU_SLEEP>;
   194			};
   195	
   196			CLUSTER_PD: power-domain-cpu-cluster {
   197				#power-domain-cells = <0>;
   198				domain-idle-states = <&CLUSTER_SLEEP>;
   199			};
   200		};
   201	
   202		rpm: remoteproc {
   203			compatible = "qcom,qcm2290-rpm-proc", "qcom,rpm-proc";
   204	
   205			glink-edge {
   206				compatible = "qcom,glink-rpm";
   207				interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
   208				qcom,rpm-msg-ram = <&rpm_msg_ram>;
   209				mboxes = <&apcs_glb 0>;
   210	
   211				rpm_requests: rpm-requests {
   212					compatible = "qcom,rpm-qcm2290";
   213					qcom,glink-channels = "rpm_requests";
   214	
   215					rpmcc: clock-controller {
   216						compatible = "qcom,rpmcc-qcm2290", "qcom,rpmcc";
   217						clocks = <&xo_board>;
   218						clock-names = "xo";
   219						#clock-cells = <1>;
   220					};
   221	
   222					rpmpd: power-controller {
   223						compatible = "qcom,qcm2290-rpmpd";
   224						#power-domain-cells = <1>;
   225						operating-points-v2 = <&rpmpd_opp_table>;
   226	
   227						rpmpd_opp_table: opp-table {
   228							compatible = "operating-points-v2";
   229	
   230							rpmpd_opp_min_svs: opp1 {
   231								opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
   232							};
   233	
   234							rpmpd_opp_low_svs: opp2 {
   235								opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
   236							};
   237	
   238							rpmpd_opp_svs: opp3 {
   239								opp-level = <RPM_SMD_LEVEL_SVS>;
   240							};
   241	
   242							rpmpd_opp_svs_plus: opp4 {
   243								opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
   244							};
   245	
   246							rpmpd_opp_nom: opp5 {
   247								opp-level = <RPM_SMD_LEVEL_NOM>;
   248							};
   249	
   250							rpmpd_opp_nom_plus: opp6 {
   251								opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
   252							};
   253	
   254							rpmpd_opp_turbo: opp7 {
   255								opp-level = <RPM_SMD_LEVEL_TURBO>;
   256							};
   257	
   258							rpmpd_opp_turbo_plus: opp8 {
   259								opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
   260							};
   261						};
   262					};
   263				};
   264			};
   265		};
   266	
   267		reserved_memory: reserved-memory {
   268			#address-cells = <2>;
   269			#size-cells = <2>;
   270			ranges;
   271	
   272			hyp_mem: hyp@45700000 {
   273				reg = <0x0 0x45700000 0x0 0x600000>;
   274				no-map;
   275			};
   276	
   277			xbl_aop_mem: xbl-aop@45e00000 {
   278				reg = <0x0 0x45e00000 0x0 0x140000>;
   279				no-map;
   280			};
   281	
   282			sec_apps_mem: sec-apps@45fff000 {
   283				reg = <0x0 0x45fff000 0x0 0x1000>;
   284				no-map;
   285			};
   286	
   287			smem_mem: smem@46000000 {
   288				compatible = "qcom,smem";
   289				reg = <0x0 0x46000000 0x0 0x200000>;
   290				no-map;
   291	
   292				hwlocks = <&tcsr_mutex 3>;
   293				qcom,rpm-msg-ram = <&rpm_msg_ram>;
   294			};
   295	
   296			pil_modem_mem: modem@4ab00000 {
   297				reg = <0x0 0x4ab00000 0x0 0x6900000>;
   298				no-map;
   299			};
   300	
   301			pil_video_mem: video@51400000 {
   302				reg = <0x0 0x51400000 0x0 0x500000>;
   303				no-map;
   304			};
   305	
   306			wlan_msa_mem: wlan-msa@51900000 {
   307				reg = <0x0 0x51900000 0x0 0x100000>;
   308				no-map;
   309			};
   310	
   311			pil_adsp_mem: adsp@51a00000 {
   312				reg = <0x0 0x51a00000 0x0 0x1c00000>;
   313				no-map;
   314			};
   315	
   316			pil_ipa_fw_mem: ipa-fw@53600000 {
   317				reg = <0x0 0x53600000 0x0 0x10000>;
   318				no-map;
   319			};
   320	
   321			pil_ipa_gsi_mem: ipa-gsi@53610000 {
   322				reg = <0x0 0x53610000 0x0 0x5000>;
   323				no-map;
   324			};
   325	
   326			pil_gpu_mem: zap@53615000 {
   327				compatible = "shared-dma-pool";
   328				reg = <0x0 0x53615000 0x0 0x2000>;
   329				no-map;
   330			};
   331	
   332			cont_splash_memory: framebuffer@5c000000 {
   333				reg = <0x0 0x5c000000 0x0 0x00f00000>;
   334				no-map;
   335			};
   336	
   337			dfps_data_memory: dpfs-data@5cf00000 {
   338				reg = <0x0 0x5cf00000 0x0 0x0100000>;
   339				no-map;
   340			};
   341	
   342			removed_mem: reserved@60000000 {
   343				reg = <0x0 0x60000000 0x0 0x3900000>;
   344				no-map;
   345			};
   346	
   347			rmtfs_mem: memory@89b01000 {
   348				compatible = "qcom,rmtfs-mem";
   349				reg = <0x0 0x89b01000 0x0 0x200000>;
   350				no-map;
   351	
   352				qcom,client-id = <1>;
   353				qcom,vmid = <QCOM_SCM_VMID_MSS_MSA QCOM_SCM_VMID_NAV>;
   354			};
   355		};
   356	
   357		smp2p-adsp {
   358			compatible = "qcom,smp2p";
   359			qcom,smem = <443>, <429>;
   360	
   361			interrupts = <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>;
   362	
   363			mboxes = <&apcs_glb 10>;
   364	
   365			qcom,local-pid = <0>;
   366			qcom,remote-pid = <2>;
   367	
   368			adsp_smp2p_out: master-kernel {
   369				qcom,entry-name = "master-kernel";
   370				#qcom,smem-state-cells = <1>;
   371			};
   372	
   373			adsp_smp2p_in: slave-kernel {
   374				qcom,entry-name = "slave-kernel";
   375				interrupt-controller;
   376				#interrupt-cells = <2>;
   377			};
   378		};
   379	
   380		smp2p-mpss {
   381			compatible = "qcom,smp2p";
   382			qcom,smem = <435>, <428>;
   383	
   384			interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING>;
   385	
   386			mboxes = <&apcs_glb 14>;
   387	
   388			qcom,local-pid = <0>;
   389			qcom,remote-pid = <1>;
   390	
   391			modem_smp2p_out: master-kernel {
   392				qcom,entry-name = "master-kernel";
   393				#qcom,smem-state-cells = <1>;
   394			};
   395	
   396			modem_smp2p_in: slave-kernel {
   397				qcom,entry-name = "slave-kernel";
   398				interrupt-controller;
   399				#interrupt-cells = <2>;
   400			};
   401	
   402			wlan_smp2p_in: wlan-wpss-to-ap {
   403				qcom,entry-name = "wlan";
   404				interrupt-controller;
   405				#interrupt-cells = <2>;
   406			};
   407		};
   408	
   409		soc: soc@0 {
   410			compatible = "simple-bus";
   411			#address-cells = <2>;
   412			#size-cells = <2>;
   413			ranges = <0 0 0 0 0x10 0>;
   414			dma-ranges = <0 0 0 0 0x10 0>;
   415	
   416			tcsr_mutex: hwlock@340000 {
   417				compatible = "qcom,tcsr-mutex";
   418				reg = <0x0 0x00340000 0x0 0x20000>;
   419				#hwlock-cells = <1>;
   420			};
   421	
   422			tlmm: pinctrl@500000 {
   423				compatible = "qcom,qcm2290-tlmm";
   424				reg = <0x0 0x00500000 0x0 0x300000>;
   425				interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
   426				gpio-controller;
   427				gpio-ranges = <&tlmm 0 0 127>;
   428				#gpio-cells = <2>;
   429				interrupt-controller;
   430				#interrupt-cells = <2>;
   431	
   432				qup_i2c0_default: qup-i2c0-default-state {
   433					pins = "gpio0", "gpio1";
   434					function = "qup0";
   435					drive-strength = <2>;
   436					bias-pull-up;
   437				};
   438	
   439				qup_i2c1_default: qup-i2c1-default-state {
   440					pins = "gpio4", "gpio5";
   441					function = "qup1";
   442					drive-strength = <2>;
   443					bias-pull-up;
   444				};
   445	
   446				qup_i2c2_default: qup-i2c2-default-state {
   447					pins = "gpio6", "gpio7";
   448					function = "qup2";
   449					drive-strength = <2>;
   450					bias-pull-up;
   451				};
   452	
   453				qup_i2c3_default: qup-i2c3-default-state {
   454					pins = "gpio8", "gpio9";
   455					function = "qup3";
   456					drive-strength = <2>;
   457					bias-pull-up;
   458				};
   459	
   460				qup_i2c4_default: qup-i2c4-default-state {
   461					pins = "gpio12", "gpio13";
   462					function = "qup4";
   463					drive-strength = <2>;
   464					bias-pull-up;
   465				};
   466	
   467				qup_i2c5_default: qup-i2c5-default-state {
   468					pins = "gpio14", "gpio15";
   469					function = "qup5";
   470					drive-strength = <2>;
   471					bias-pull-up;
   472				};
   473	
   474				qup_spi0_default: qup-spi0-default-state {
   475					pins = "gpio0", "gpio1","gpio2", "gpio3";
   476					function = "qup0";
   477					drive-strength = <2>;
   478					bias-pull-up;
   479				};
   480	
   481				qup_spi1_default: qup-spi1-default-state {
   482					pins = "gpio4", "gpio5", "gpio69", "gpio70";
   483					function = "qup1";
   484					drive-strength = <2>;
   485					bias-pull-up;
   486				};
   487	
   488				qup_spi2_default: qup-spi2-default-state {
   489					pins = "gpio6", "gpio7", "gpio71", "gpio80";
   490					function = "qup2";
   491					drive-strength = <2>;
   492					bias-pull-up;
   493				};
   494	
   495				qup_spi3_default: qup-spi3-default-state {
   496					pins = "gpio8", "gpio9", "gpio10", "gpio11";
   497					function = "qup3";
   498					drive-strength = <2>;
   499					bias-pull-up;
   500				};
   501	
   502				qup_spi4_default: qup-spi4-default-state {
   503					pins = "gpio12", "gpio13", "gpio96", "gpio97";
   504					function = "qup4";
   505					drive-strength = <2>;
   506					bias-pull-up;
   507				};
   508	
   509				qup_spi5_default: qup-spi5-default-state {
   510					pins = "gpio14", "gpio15", "gpio16", "gpio17";
   511					function = "qup5";
   512					drive-strength = <2>;
   513					bias-pull-up;
   514				};
   515	
   516				qup_uart0_default: qup-uart0-default-state {
   517					pins = "gpio0", "gpio1", "gpio2", "gpio3";
   518					function = "qup0";
   519					drive-strength = <2>;
   520					bias-disable;
   521				};
   522	
   523				qup_uart4_default: qup-uart4-default-state {
   524					pins = "gpio12", "gpio13";
   525					function = "qup4";
   526					drive-strength = <2>;
   527					bias-disable;
   528				};
   529	
   530				sdc1_state_on: sdc1-on-state {
   531					clk-pins {
   532						pins = "sdc1_clk";
   533						drive-strength = <16>;
   534						bias-disable;
   535					};
   536	
   537					cmd-pins {
   538						pins = "sdc1_cmd";
   539						drive-strength = <10>;
   540						bias-pull-up;
   541					};
   542	
   543					data-pins {
   544						pins = "sdc1_data";
   545						drive-strength = <10>;
   546						bias-pull-up;
   547					};
   548	
   549					rclk-pins {
   550						pins = "sdc1_rclk";
   551						bias-pull-down;
   552					};
   553				};
   554	
   555				sdc1_state_off: sdc1-off-state {
   556					clk-pins {
   557						pins = "sdc1_clk";
   558						drive-strength = <2>;
   559						bias-disable;
   560					};
   561	
   562					cmd-pins {
   563						pins = "sdc1_cmd";
   564						drive-strength = <2>;
   565						bias-pull-up;
   566					};
   567	
   568					data-pins {
   569						pins = "sdc1_data";
   570						drive-strength = <2>;
   571						bias-pull-up;
   572					};
   573	
   574					rclk-pins {
   575						pins = "sdc1_rclk";
   576						bias-pull-down;
   577					};
   578				};
   579	
   580				sdc2_state_on: sdc2-on-state {
   581					clk-pins {
   582						pins = "sdc2_clk";
   583						drive-strength = <16>;
   584						bias-disable;
   585					};
   586	
   587					cmd-pins {
   588						pins = "sdc2_cmd";
   589						drive-strength = <10>;
   590						bias-pull-up;
   591					};
   592	
   593					data-pins {
   594						pins = "sdc2_data";
   595						drive-strength = <10>;
   596						bias-pull-up;
   597					};
   598				};
   599	
   600				sdc2_state_off: sdc2-off-state {
   601					clk-pins {
   602						pins = "sdc2_clk";
   603						drive-strength = <2>;
   604						bias-disable;
   605					};
   606	
   607					cmd-pins {
   608						pins = "sdc2_cmd";
   609						drive-strength = <2>;
   610						bias-pull-up;
   611					};
   612	
   613					data-pins {
   614						pins = "sdc2_data";
   615						drive-strength = <2>;
   616						bias-pull-up;
   617					};
   618				};
   619			};
   620	
   621			gcc: clock-controller@1400000 {
   622				compatible = "qcom,gcc-qcm2290";
   623				reg = <0x0 0x01400000 0x0 0x1f0000>;
   624				clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
   625				clock-names = "bi_tcxo", "sleep_clk";
   626				#clock-cells = <1>;
   627				#reset-cells = <1>;
   628				#power-domain-cells = <1>;
   629			};
   630	
   631			usb_hsphy: phy@1613000 {
   632				compatible = "qcom,qcm2290-qusb2-phy";
   633				reg = <0x0 0x01613000 0x0 0x180>;
   634	
   635				clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
   636					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
   637				clock-names = "cfg_ahb", "ref";
   638	
   639				resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
   640				nvmem-cells = <&qusb2_hstx_trim>;
   641				#phy-cells = <0>;
   642	
   643				status = "disabled";
   644			};
   645	
   646			usb_qmpphy: phy@1615000 {
   647				compatible = "qcom,qcm2290-qmp-usb3-phy";
   648				reg = <0x0 0x01615000 0x0 0x1000>;
   649	
   650				clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
   651					 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
   652					 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
   653					 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
   654				clock-names = "cfg_ahb",
   655					      "ref",
   656					      "com_aux",
   657					      "pipe";
   658	
   659				resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
   660					 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
   661				reset-names = "phy",
   662					      "phy_phy";
   663	
   664				#clock-cells = <0>;
   665				clock-output-names = "usb3_phy_pipe_clk_src";
   666	
   667				#phy-cells = <0>;
   668	
   669				status = "disabled";
   670			};
   671	
   672			qfprom@1b44000 {
   673				compatible = "qcom,qcm2290-qfprom", "qcom,qfprom";
   674				reg = <0x0 0x01b44000 0x0 0x3000>;
   675				#address-cells = <1>;
   676				#size-cells = <1>;
   677	
   678				qusb2_hstx_trim: hstx-trim@25b {
   679					reg = <0x25b 0x1>;
   680					bits = <1 4>;
   681				};
   682			};
   683	
   684			spmi_bus: spmi@1c40000 {
   685				compatible = "qcom,spmi-pmic-arb";
   686				reg = <0x0 0x01c40000 0x0 0x1100>,
   687				      <0x0 0x01e00000 0x0 0x2000000>,
   688				      <0x0 0x03e00000 0x0 0x100000>,
   689				      <0x0 0x03f00000 0x0 0xa0000>,
   690				      <0x0 0x01c0a000 0x0 0x26000>;
   691				reg-names = "core",
   692					    "chnls",
   693					    "obsrvr",
   694					    "intr",
   695					    "cnfg";
   696				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
   697				interrupt-names = "periph_irq";
   698				qcom,ee = <0>;
   699				qcom,channel = <0>;
   700				#address-cells = <2>;
   701				#size-cells = <0>;
   702				interrupt-controller;
   703				#interrupt-cells = <4>;
   704			};
   705	
   706			tsens0: thermal-sensor@4411000 {
   707				compatible = "qcom,qcm2290-tsens", "qcom,tsens-v2";
   708				reg = <0x0 0x04411000 0x0 0x1ff>,
   709				      <0x0 0x04410000 0x0 0x8>;
   710				#qcom,sensors = <10>;
   711				interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
   712					     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
   713				interrupt-names = "uplow", "critical";
   714				#thermal-sensor-cells = <1>;
   715			};
   716	
   717			rng: rng@4453000 {
   718				compatible = "qcom,prng-ee";
   719				reg = <0x0 0x04453000 0x0 0x1000>;
   720				clocks = <&rpmcc RPM_SMD_HWKM_CLK>;
   721				clock-names = "core";
   722			};
   723	
   724			rpm_msg_ram: sram@45f0000 {
   725				compatible = "qcom,rpm-msg-ram";
   726				reg = <0x0 0x045f0000 0x0 0x7000>;
   727			};
   728	
   729			sram@4690000 {
   730				compatible = "qcom,rpm-stats";
   731				reg = <0x0 0x04690000 0x0 0x10000>;
   732			};
   733	
   734			sdhc_1: mmc@4744000 {
   735				compatible = "qcom,qcm2290-sdhci", "qcom,sdhci-msm-v5";
   736				reg = <0x0 0x04744000 0x0 0x1000>,
   737				      <0x0 0x04745000 0x0 0x1000>,
   738				      <0x0 0x04748000 0x0 0x8000>;
   739				reg-names = "hc",
   740					    "cqhci",
   741					    "ice";
   742	
   743				interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
   744					     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
   745				interrupt-names = "hc_irq", "pwr_irq";
   746	
   747				clocks = <&gcc GCC_SDCC1_AHB_CLK>,
   748					 <&gcc GCC_SDCC1_APPS_CLK>,
   749					 <&rpmcc RPM_SMD_XO_CLK_SRC>,
   750					 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
   751				clock-names = "iface",
   752					      "core",
   753					      "xo",
   754					      "ice";
   755	
   756				resets = <&gcc GCC_SDCC1_BCR>;
   757	
   758				power-domains = <&rpmpd QCM2290_VDDCX>;
   759				iommus = <&apps_smmu 0xc0 0x0>;
   760	
   761				qcom,dll-config = <0x000f642c>;
   762				qcom,ddr-config = <0x80040868>;
   763				bus-width = <8>;
   764	
   765				status = "disabled";
   766			};
   767	
   768			sdhc_2: mmc@4784000 {
   769				compatible = "qcom,qcm2290-sdhci", "qcom,sdhci-msm-v5";
   770				reg = <0x0 0x04784000 0x0 0x1000>;
   771				reg-names = "hc";
   772	
   773				interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
   774					     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
   775				interrupt-names = "hc_irq", "pwr_irq";
   776	
   777				clocks = <&gcc GCC_SDCC2_AHB_CLK>,
   778					 <&gcc GCC_SDCC2_APPS_CLK>,
   779					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
   780				clock-names = "iface",
   781					      "core",
   782					      "xo";
   783	
   784				resets = <&gcc GCC_SDCC2_BCR>;
   785	
   786				power-domains = <&rpmpd QCM2290_VDDCX>;
   787				operating-points-v2 = <&sdhc2_opp_table>;
   788				iommus = <&apps_smmu 0xa0 0x0>;
   789	
   790				qcom,dll-config = <0x0007642c>;
   791				qcom,ddr-config = <0x80040868>;
   792				bus-width = <4>;
   793	
   794				status = "disabled";
   795	
   796				sdhc2_opp_table: opp-table {
   797					compatible = "operating-points-v2";
   798	
   799					opp-100000000 {
   800						opp-hz = /bits/ 64 <100000000>;
   801						required-opps = <&rpmpd_opp_low_svs>;
   802					};
   803	
   804					opp-202000000 {
   805						opp-hz = /bits/ 64 <202000000>;
   806						required-opps = <&rpmpd_opp_svs_plus>;
   807					};
   808				};
   809			};
   810	
   811			gpi_dma0: dma-controller@4a00000 {
   812				compatible = "qcom,qcm2290-gpi-dma", "qcom,sm6350-gpi-dma";
   813				reg = <0x0 0x04a00000 0x0 0x60000>;
   814				interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
   815					     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
   816					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
   817					     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
   818					     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
   819					     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
   820					     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
   821					     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
   822					     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
   823					     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
   824				dma-channels = <10>;
   825				dma-channel-mask = <0x1f>;
   826				iommus = <&apps_smmu 0xf6 0x0>;
   827				#dma-cells = <3>;
   828				status = "disabled";
   829			};
   830	
   831			qupv3_id_0: geniqup@4ac0000 {
   832				compatible = "qcom,geni-se-qup";
   833				reg = <0x0 0x04ac0000 0x0 0x2000>;
   834				clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
   835					 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
   836				clock-names = "m-ahb", "s-ahb";
   837				iommus = <&apps_smmu 0xe3 0x0>;
   838				#address-cells = <2>;
   839				#size-cells = <2>;
   840				ranges;
   841				status = "disabled";
   842	
   843				i2c0: i2c@4a80000 {
   844					compatible = "qcom,geni-i2c";
   845					reg = <0x0 0x04a80000 0x0 0x4000>;
   846					interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
   847					clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
   848					clock-names = "se";
   849					pinctrl-0 = <&qup_i2c0_default>;
   850					pinctrl-names = "default";
   851					dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
   852					       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
   853					dma-names = "tx", "rx";
   854					#address-cells = <1>;
   855					#size-cells = <0>;
   856					status = "disabled";
   857				};
   858	
   859				spi0: spi@4a80000 {
   860					compatible = "qcom,geni-spi";
   861					reg = <0x0 0x04a80000 0x0 0x4000>;
   862					interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
   863					clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
   864					clock-names = "se";
   865					pinctrl-0 = <&qup_spi0_default>;
   866					pinctrl-names = "default";
   867					dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
   868					       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
   869					dma-names = "tx", "rx";
   870					#address-cells = <1>;
   871					#size-cells = <0>;
   872					status = "disabled";
   873				};
   874	
   875				uart0: serial@4a80000 {
   876					compatible = "qcom,geni-uart";
   877					reg = <0x0 0x04a80000 0x0 0x4000>;
   878					interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
   879					clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
   880					clock-names = "se";
   881					pinctrl-0 = <&qup_uart0_default>;
   882					pinctrl-names = "default";
   883					status = "disabled";
   884				};
   885	
   886				i2c1: i2c@4a84000 {
   887					compatible = "qcom,geni-i2c";
   888					reg = <0x0 0x04a84000 0x0 0x4000>;
   889					interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
   890					clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
   891					clock-names = "se";
   892					pinctrl-0 = <&qup_i2c1_default>;
   893					pinctrl-names = "default";
   894					dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
   895					       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
   896					dma-names = "tx", "rx";
   897					#address-cells = <1>;
   898					#size-cells = <0>;
   899					status = "disabled";
   900				};
   901	
   902				spi1: spi@4a84000 {
   903					compatible = "qcom,geni-spi";
   904					reg = <0x0 0x04a84000 0x0 0x4000>;
   905					interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
   906					clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
   907					clock-names = "se";
   908					pinctrl-0 = <&qup_spi1_default>;
   909					pinctrl-names = "default";
   910					dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
   911					       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
   912					dma-names = "tx", "rx";
   913					#address-cells = <1>;
   914					#size-cells = <0>;
   915					status = "disabled";
   916				};
   917	
   918				i2c2: i2c@4a88000 {
   919					compatible = "qcom,geni-i2c";
   920					reg = <0x0 0x04a88000 0x0 0x4000>;
   921					interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
   922					clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
   923					clock-names = "se";
   924					pinctrl-0 = <&qup_i2c2_default>;
   925					pinctrl-names = "default";
   926					dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
   927					       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
   928					dma-names = "tx", "rx";
   929					#address-cells = <1>;
   930					#size-cells = <0>;
   931					status = "disabled";
   932				};
   933	
   934				spi2: spi@4a88000 {
   935					compatible = "qcom,geni-spi";
   936					reg = <0x0 0x04a88000 0x0 0x4000>;
   937					interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
   938					clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
   939					clock-names = "se";
   940					pinctrl-0 = <&qup_spi2_default>;
   941					pinctrl-names = "default";
   942					dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
   943					       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
   944					dma-names = "tx", "rx";
   945					#address-cells = <1>;
   946					#size-cells = <0>;
   947					status = "disabled";
   948				};
   949	
   950				i2c3: i2c@4a8c000 {
   951					compatible = "qcom,geni-i2c";
   952					reg = <0x0 0x04a8c000 0x0 0x4000>;
   953					interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
   954					clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
   955					clock-names = "se";
   956					pinctrl-0 = <&qup_i2c3_default>;
   957					pinctrl-names = "default";
   958					dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
   959					       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
   960					dma-names = "tx", "rx";
   961					#address-cells = <1>;
   962					#size-cells = <0>;
   963					status = "disabled";
   964				};
   965	
   966				spi3: spi@4a8c000 {
   967					compatible = "qcom,geni-spi";
   968					reg = <0x0 0x04a8c000 0x0 0x4000>;
   969					interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
   970					clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
   971					clock-names = "se";
   972					pinctrl-0 = <&qup_spi3_default>;
   973					pinctrl-names = "default";
   974					dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
   975					       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
   976					dma-names = "tx", "rx";
   977					#address-cells = <1>;
   978					#size-cells = <0>;
   979					status = "disabled";
   980				};
   981	
   982				i2c4: i2c@4a90000 {
   983					compatible = "qcom,geni-i2c";
   984					reg = <0x0 0x04a90000 0x0 0x4000>;
   985					interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
   986					clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
   987					clock-names = "se";
   988					pinctrl-0 = <&qup_i2c4_default>;
   989					pinctrl-names = "default";
   990					dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
   991					       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
   992					dma-names = "tx", "rx";
   993					#address-cells = <1>;
   994					#size-cells = <0>;
   995					status = "disabled";
   996				};
   997	
   998				spi4: spi@4a90000 {
   999					compatible = "qcom,geni-spi";
  1000					reg = <0x0 0x04a90000 0x0 0x4000>;
  1001					interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
  1002					clock-names = "se";
  1003					clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
  1004					pinctrl-names = "default";
  1005					pinctrl-0 = <&qup_spi4_default>;
  1006					dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
  1007					       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
  1008					dma-names = "tx", "rx";
  1009					#address-cells = <1>;
  1010					#size-cells = <0>;
  1011					status = "disabled";
  1012				};
  1013	
  1014				uart4: serial@4a90000 {
  1015					compatible = "qcom,geni-uart";
  1016					reg = <0x0 0x04a90000 0x0 0x4000>;
  1017					interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
  1018					clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
  1019					clock-names = "se";
  1020					pinctrl-0 = <&qup_uart4_default>;
  1021					pinctrl-names = "default";
  1022					status = "disabled";
  1023				};
  1024	
  1025				i2c5: i2c@4a94000 {
  1026					compatible = "qcom,geni-i2c";
  1027					reg = <0x0 0x04a94000 0x0 0x4000>;
  1028					interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
  1029					clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
  1030					clock-names = "se";
  1031					pinctrl-0 = <&qup_i2c5_default>;
  1032					pinctrl-names = "default";
  1033					dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
  1034					       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
  1035					dma-names = "tx", "rx";
  1036					#address-cells = <1>;
  1037					#size-cells = <0>;
  1038					status = "disabled";
  1039				};
  1040	
  1041				spi5: spi@4a94000 {
  1042					compatible = "qcom,geni-spi";
  1043					reg = <0x0 0x04a94000 0x0 0x4000>;
  1044					interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
  1045					clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
  1046					clock-names = "se";
  1047					pinctrl-0 = <&qup_spi5_default>;
  1048					pinctrl-names = "default";
  1049					dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
  1050					       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
  1051					dma-names = "tx", "rx";
  1052					#address-cells = <1>;
  1053					#size-cells = <0>;
  1054					status = "disabled";
  1055				};
  1056			};
  1057	
  1058			usb: usb@4ef8800 {
  1059				compatible = "qcom,qcm2290-dwc3", "qcom,dwc3";
  1060				reg = <0x0 0x04ef8800 0x0 0x400>;
  1061				interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
  1062					     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
  1063				interrupt-names = "hs_phy_irq", "ss_phy_irq";
  1064	
  1065				clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
  1066					 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
  1067					 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
  1068					 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
  1069					 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
  1070					 <&gcc GCC_USB3_PRIM_CLKREF_CLK>;
  1071				clock-names = "cfg_noc",
  1072					      "core",
  1073					      "iface",
  1074					      "sleep",
  1075					      "mock_utmi",
  1076					      "xo";
  1077	
  1078				assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
  1079						  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
  1080				assigned-clock-rates = <19200000>, <133333333>;
  1081	
  1082				resets = <&gcc GCC_USB30_PRIM_BCR>;
  1083				power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
  1084				wakeup-source;
  1085	
  1086				#address-cells = <2>;
  1087				#size-cells = <2>;
  1088				ranges;
  1089	
  1090				status = "disabled";
  1091	
  1092				usb_dwc3: usb@4e00000 {
  1093					compatible = "snps,dwc3";
  1094					reg = <0x0 0x04e00000 0x0 0xcd00>;
  1095					interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
  1096					phys = <&usb_hsphy>, <&usb_qmpphy>;
  1097					phy-names = "usb2-phy", "usb3-phy";
  1098					iommus = <&apps_smmu 0x120 0x0>;
  1099					snps,dis_u2_susphy_quirk;
  1100					snps,dis_enblslpm_quirk;
  1101					snps,has-lpm-erratum;
  1102					snps,hird-threshold = /bits/ 8 <0x10>;
  1103					snps,usb3_lpm_capable;
  1104					maximum-speed = "super-speed";
  1105					dr_mode = "otg";
  1106				};
  1107			};
  1108	
  1109			mdss: display-subsystem@5e00000 {
  1110				compatible = "qcom,qcm2290-mdss";
  1111				reg = <0x0 0x05e00000 0x0 0x1000>;
  1112				reg-names = "mdss";
  1113				interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
  1114				interrupt-controller;
  1115				#interrupt-cells = <1>;
  1116	
  1117				clocks = <&gcc GCC_DISP_AHB_CLK>,
  1118					 <&gcc GCC_DISP_HF_AXI_CLK>,
  1119					 <&dispcc DISP_CC_MDSS_MDP_CLK>;
  1120				clock-names = "iface",
  1121					      "bus",
  1122					      "core";
  1123	
  1124				resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
  1125	
  1126				power-domains = <&dispcc MDSS_GDSC>;
  1127	
  1128				iommus = <&apps_smmu 0x420 0x2>,
  1129					 <&apps_smmu 0x421 0x0>;
  1130	
  1131				#address-cells = <2>;
  1132				#size-cells = <2>;
  1133				ranges;
  1134	
  1135				status = "disabled";
  1136	
  1137				mdp: display-controller@5e01000 {
  1138					compatible = "qcom,qcm2290-dpu";
  1139					reg = <0x0 0x05e01000 0x0 0x8f000>,
  1140					      <0x0 0x05eb0000 0x0 0x2008>;
  1141					reg-names = "mdp",
  1142						    "vbif";
  1143	
  1144					interrupt-parent = <&mdss>;
  1145					interrupts = <0>;
  1146	
  1147					clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
  1148						 <&dispcc DISP_CC_MDSS_AHB_CLK>,
  1149						 <&dispcc DISP_CC_MDSS_MDP_CLK>,
  1150						 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
  1151						 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
  1152					clock-names = "bus",
  1153						      "iface",
  1154						      "core",
  1155						      "lut",
  1156						      "vsync";
  1157	
  1158					operating-points-v2 = <&mdp_opp_table>;
  1159					power-domains = <&rpmpd QCM2290_VDDCX>;
  1160	
> 1161					ports {
  1162						#address-cells = <1>;
  1163						#size-cells = <0>;
  1164	
  1165						port@0 {
  1166							reg = <0>;
  1167							dpu_intf1_out: endpoint {
  1168								remote-endpoint = <&mdss_dsi0_in>;
  1169							};
  1170						};
  1171					};
  1172	
  1173					mdp_opp_table: opp-table {
  1174						compatible = "operating-points-v2";
  1175	
  1176						opp-19200000 {
  1177							opp-hz = /bits/ 64 <19200000>;
  1178							required-opps = <&rpmpd_opp_min_svs>;
  1179						};
  1180	
  1181						opp-192000000 {
  1182							opp-hz = /bits/ 64 <192000000>;
  1183							required-opps = <&rpmpd_opp_low_svs>;
  1184						};
  1185	
  1186						opp-256000000 {
  1187							opp-hz = /bits/ 64 <256000000>;
  1188							required-opps = <&rpmpd_opp_svs>;
  1189						};
  1190	
  1191						opp-307200000 {
  1192							opp-hz = /bits/ 64 <307200000>;
  1193							required-opps = <&rpmpd_opp_svs_plus>;
  1194						};
  1195	
  1196						opp-384000000 {
  1197							opp-hz = /bits/ 64 <384000000>;
  1198							required-opps = <&rpmpd_opp_nom>;
  1199						};
  1200					};
  1201				};
  1202	
> 1203				mdss_dsi0: dsi@5e94000 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

