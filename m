Return-Path: <linux-kernel+bounces-217478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568890B056
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE1F1F211F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03CA21019F;
	Mon, 17 Jun 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBOpU1Ar"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB3198827
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630695; cv=none; b=nPajjR58p7K9caCURWRFT6w0UD43fnonjYx5cAP22xCguWN4sc52lAgbe/GlcEc0qy+o1uCgAiVJu6i+G1uRWkxPPQewKNHQr2ckPPJ5OQTxAYDaLVnlV4bob9OvSNNIxujvh9orq+B/qzJ1H8t0Q2FFaaK8RSWNiGSwunB5Yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630695; c=relaxed/simple;
	bh=Bpf79UenVGClfcsRF8LHSUnx4t9dyd4nnEBIAPFaqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kqrTiMXyDtj5b+504DzLMW2c1G7mZxacf4qwi0qnop+3evpeAmHLqWaWgUwHzjLJwkS0oS1FelD31MpomOUW/bsK+ZMkwwrAgGVH4BYNWTHSdoj4S8i92gtc0zbufbXic5RRM1lpf0yhv5CSmxkxPZxODU6bL0F2dsj7EEkY474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBOpU1Ar; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718630692; x=1750166692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bpf79UenVGClfcsRF8LHSUnx4t9dyd4nnEBIAPFaqm0=;
  b=HBOpU1Ar+XXHY1E5NeCothlPMFi4OdnubXe1GWxx39Rhsn9VZ/iCMxpN
   eRRAA7zwdYUp1IrNlscV+AYT2k1f49zQyTXSkwBRHqLt6Fczr0hSHLiv+
   jzXKp8HjrcgCpQM9Lou458WfXL3soCNsvrpZjp3EAZFcJ5kxZDlp1MjL4
   wDkWu0HQ1uWoyhvuYU0SKRtO9Svy0tj/SLUYcvi+1n89dpIBBIKiu2VEu
   t3xjqHtkwPY/I2xpqrHwVbhsrwGzCMu3DiR1mSyxFbzvm6uxjlGh1evl2
   FPOAJyvTlu3uvUa/b5F1NB/9skJFlreRlKUdFAqBFStF+rllMPAsf5Lb6
   w==;
X-CSE-ConnectionGUID: BibIxNoWTfqCx0QGOkd2YQ==
X-CSE-MsgGUID: wc7UxStkQMODUUqclb4N4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26085678"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26085678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 06:24:51 -0700
X-CSE-ConnectionGUID: G7JyFSlMQZqpAoAWxXooYA==
X-CSE-MsgGUID: 3gWfj32FRgOv5LZ68eb4lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="46148878"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Jun 2024 06:24:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJCLm-0004K5-2o;
	Mon, 17 Jun 2024 13:24:46 +0000
Date: Mon, 17 Jun 2024 21:24:19 +0800
From: kernel test robot <lkp@intel.com>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: arch/arm64/boot/dts/qcom/sm6125.dtsi:1308.27-1374.6: Warning
 (avoid_unnecessary_addr_size): /soc@0/display-subsystem@5e00000/dsi@5e94000:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406172128.1N8EVs6I-lkp@intel.com>
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
commit: 0865d23a02260a76963bd18d9ae603e77cdd0eba arm64: dts: qcom: sm6125: Add display hardware nodes
date:   9 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240617/202406172128.1N8EVs6I-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240617/202406172128.1N8EVs6I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406172128.1N8EVs6I-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/qcom/sm6125.dtsi:1308.27-1374.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@5e00000/dsi@5e94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/sm6125.dtsi:1266.11-1276.7: Warning (graph_child_address): /soc@0/display-subsystem@5e00000/display-controller@5e01000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +1308 arch/arm64/boot/dts/qcom/sm6125.dtsi

    13	
    14	/ {
    15		interrupt-parent = <&intc>;
    16		#address-cells = <2>;
    17		#size-cells = <2>;
    18	
    19		chosen { };
    20	
    21		clocks {
    22			xo_board: xo-board {
    23				compatible = "fixed-clock";
    24				#clock-cells = <0>;
    25				clock-frequency = <19200000>;
    26			};
    27	
    28			sleep_clk: sleep-clk {
    29				compatible = "fixed-clock";
    30				#clock-cells = <0>;
    31				clock-frequency = <32000>;
    32				clock-output-names = "sleep_clk";
    33			};
    34		};
    35	
    36		cpus {
    37			#address-cells = <2>;
    38			#size-cells = <0>;
    39	
    40			CPU0: cpu@0 {
    41				device_type = "cpu";
    42				compatible = "qcom,kryo260";
    43				reg = <0x0 0x0>;
    44				enable-method = "psci";
    45				capacity-dmips-mhz = <1024>;
    46				next-level-cache = <&L2_0>;
    47				L2_0: l2-cache {
    48					compatible = "cache";
    49					cache-level = <2>;
    50					cache-unified;
    51				};
    52			};
    53	
    54			CPU1: cpu@1 {
    55				device_type = "cpu";
    56				compatible = "qcom,kryo260";
    57				reg = <0x0 0x1>;
    58				enable-method = "psci";
    59				capacity-dmips-mhz = <1024>;
    60				next-level-cache = <&L2_0>;
    61			};
    62	
    63			CPU2: cpu@2 {
    64				device_type = "cpu";
    65				compatible = "qcom,kryo260";
    66				reg = <0x0 0x2>;
    67				enable-method = "psci";
    68				capacity-dmips-mhz = <1024>;
    69				next-level-cache = <&L2_0>;
    70			};
    71	
    72			CPU3: cpu@3 {
    73				device_type = "cpu";
    74				compatible = "qcom,kryo260";
    75				reg = <0x0 0x3>;
    76				enable-method = "psci";
    77				capacity-dmips-mhz = <1024>;
    78				next-level-cache = <&L2_0>;
    79			};
    80	
    81			CPU4: cpu@100 {
    82				device_type = "cpu";
    83				compatible = "qcom,kryo260";
    84				reg = <0x0 0x100>;
    85				enable-method = "psci";
    86				capacity-dmips-mhz = <1638>;
    87				next-level-cache = <&L2_1>;
    88				L2_1: l2-cache {
    89					compatible = "cache";
    90					cache-level = <2>;
    91					cache-unified;
    92				};
    93			};
    94	
    95			CPU5: cpu@101 {
    96				device_type = "cpu";
    97				compatible = "qcom,kryo260";
    98				reg = <0x0 0x101>;
    99				enable-method = "psci";
   100				capacity-dmips-mhz = <1638>;
   101				next-level-cache = <&L2_1>;
   102			};
   103	
   104			CPU6: cpu@102 {
   105				device_type = "cpu";
   106				compatible = "qcom,kryo260";
   107				reg = <0x0 0x102>;
   108				enable-method = "psci";
   109				capacity-dmips-mhz = <1638>;
   110				next-level-cache = <&L2_1>;
   111			};
   112	
   113			CPU7: cpu@103 {
   114				device_type = "cpu";
   115				compatible = "qcom,kryo260";
   116				reg = <0x0 0x103>;
   117				enable-method = "psci";
   118				capacity-dmips-mhz = <1638>;
   119				next-level-cache = <&L2_1>;
   120			};
   121	
   122			cpu-map {
   123				cluster0 {
   124					core0 {
   125						cpu = <&CPU0>;
   126					};
   127	
   128					core1 {
   129						cpu = <&CPU1>;
   130					};
   131	
   132					core2 {
   133						cpu = <&CPU2>;
   134					};
   135	
   136					core3 {
   137						cpu = <&CPU3>;
   138					};
   139				};
   140	
   141				cluster1 {
   142					core0 {
   143						cpu = <&CPU4>;
   144					};
   145	
   146					core1 {
   147						cpu = <&CPU5>;
   148					};
   149	
   150					core2 {
   151						cpu = <&CPU6>;
   152					};
   153	
   154					core3 {
   155						cpu = <&CPU7>;
   156					};
   157				};
   158			};
   159		};
   160	
   161		firmware {
   162			scm: scm {
   163				compatible = "qcom,scm-sm6125", "qcom,scm";
   164				#reset-cells = <1>;
   165			};
   166		};
   167	
   168		memory@40000000 {
   169			/* We expect the bootloader to fill in the size */
   170			reg = <0x0 0x40000000 0x0 0x0>;
   171			device_type = "memory";
   172		};
   173	
   174		pmu {
   175			compatible = "arm,armv8-pmuv3";
   176			interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
   177		};
   178	
   179		psci {
   180			compatible = "arm,psci-1.0";
   181			method = "smc";
   182		};
   183	
   184		rpm: remoteproc {
   185			compatible = "qcom,sm6125-rpm-proc", "qcom,rpm-proc";
   186	
   187			glink-edge {
   188				compatible = "qcom,glink-rpm";
   189	
   190				interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
   191				qcom,rpm-msg-ram = <&rpm_msg_ram>;
   192				mboxes = <&apcs_glb 0>;
   193	
   194				rpm_requests: rpm-requests {
   195					compatible = "qcom,rpm-sm6125";
   196					qcom,glink-channels = "rpm_requests";
   197	
   198					rpmcc: clock-controller {
   199						compatible = "qcom,rpmcc-sm6125", "qcom,rpmcc";
   200						#clock-cells = <1>;
   201						clocks = <&xo_board>;
   202						clock-names = "xo";
   203					};
   204	
   205					rpmpd: power-controller {
   206						compatible = "qcom,sm6125-rpmpd";
   207						#power-domain-cells = <1>;
   208						operating-points-v2 = <&rpmpd_opp_table>;
   209	
   210						rpmpd_opp_table: opp-table {
   211							compatible = "operating-points-v2";
   212	
   213							rpmpd_opp_ret: opp1 {
   214								opp-level = <RPM_SMD_LEVEL_RETENTION>;
   215							};
   216	
   217							rpmpd_opp_ret_plus: opp2 {
   218								opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
   219							};
   220	
   221							rpmpd_opp_min_svs: opp3 {
   222								opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
   223							};
   224	
   225							rpmpd_opp_low_svs: opp4 {
   226								opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
   227							};
   228	
   229							rpmpd_opp_svs: opp5 {
   230								opp-level = <RPM_SMD_LEVEL_SVS>;
   231							};
   232	
   233							rpmpd_opp_svs_plus: opp6 {
   234								opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
   235							};
   236	
   237							rpmpd_opp_nom: opp7 {
   238								opp-level = <RPM_SMD_LEVEL_NOM>;
   239							};
   240	
   241							rpmpd_opp_nom_plus: opp8 {
   242								opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
   243							};
   244	
   245							rpmpd_opp_turbo: opp9 {
   246								opp-level = <RPM_SMD_LEVEL_TURBO>;
   247							};
   248	
   249							rpmpd_opp_turbo_no_cpr: opp10 {
   250								opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
   251							};
   252						};
   253					};
   254				};
   255			};
   256		};
   257	
   258		reserved_memory: reserved-memory {
   259			#address-cells = <2>;
   260			#size-cells = <2>;
   261			ranges;
   262	
   263			hyp_mem: memory@45700000 {
   264				reg = <0x0 0x45700000 0x0 0x600000>;
   265				no-map;
   266			};
   267	
   268			xbl_aop_mem: memory@45e00000 {
   269				reg = <0x0 0x45e00000 0x0 0x140000>;
   270				no-map;
   271			};
   272	
   273			sec_apps_mem: memory@45fff000 {
   274				reg = <0x0 0x45fff000 0x0 0x1000>;
   275				no-map;
   276			};
   277	
   278			smem_mem: memory@46000000 {
   279				reg = <0x0 0x46000000 0x0 0x200000>;
   280				no-map;
   281			};
   282	
   283			reserved_mem1: memory@46200000 {
   284				reg = <0x0 0x46200000 0x0 0x2d00000>;
   285				no-map;
   286			};
   287	
   288			camera_mem: memory@4ab00000 {
   289				reg = <0x0 0x4ab00000 0x0 0x500000>;
   290				no-map;
   291			};
   292	
   293			modem_mem: memory@4b000000 {
   294				reg = <0x0 0x4b000000 0x0 0x7e00000>;
   295				no-map;
   296			};
   297	
   298			venus_mem: memory@52e00000 {
   299				reg = <0x0 0x52e00000 0x0 0x500000>;
   300				no-map;
   301			};
   302	
   303			wlan_msa_mem: memory@53300000 {
   304				reg = <0x0 0x53300000 0x0 0x200000>;
   305				no-map;
   306			};
   307	
   308			cdsp_mem: memory@53500000 {
   309				reg = <0x0 0x53500000 0x0 0x1e00000>;
   310				no-map;
   311			};
   312	
   313			adsp_pil_mem: memory@55300000 {
   314				reg = <0x0 0x55300000 0x0 0x1e00000>;
   315				no-map;
   316			};
   317	
   318			ipa_fw_mem: memory@57100000 {
   319				reg = <0x0 0x57100000 0x0 0x10000>;
   320				no-map;
   321			};
   322	
   323			ipa_gsi_mem: memory@57110000 {
   324				reg = <0x0 0x57110000 0x0 0x5000>;
   325				no-map;
   326			};
   327	
   328			gpu_mem: memory@57115000 {
   329				reg = <0x0 0x57115000 0x0 0x2000>;
   330				no-map;
   331			};
   332	
   333			cont_splash_mem: memory@5c000000 {
   334				reg = <0x0 0x5c000000 0x0 0x00f00000>;
   335				no-map;
   336			};
   337	
   338			dfps_data_mem: memory@5cf00000 {
   339				reg = <0x0 0x5cf00000 0x0 0x0100000>;
   340				no-map;
   341			};
   342	
   343			cdsp_sec_mem: memory@5f800000 {
   344				reg = <0x0 0x5f800000 0x0 0x1e00000>;
   345				no-map;
   346			};
   347	
   348			qseecom_mem: memory@5e400000 {
   349				reg = <0x0 0x5e400000 0x0 0x1400000>;
   350				no-map;
   351			};
   352	
   353			sdsp_mem: memory@f3000000 {
   354				reg = <0x0 0xf3000000 0x0 0x400000>;
   355				no-map;
   356			};
   357	
   358			adsp_mem: memory@f3400000 {
   359				reg = <0x0 0xf3400000 0x0 0x800000>;
   360				no-map;
   361			};
   362	
   363			qseecom_ta_mem: memory@13fc00000 {
   364				reg = <0x1 0x3fc00000 0x0 0x400000>;
   365				no-map;
   366			};
   367		};
   368	
   369		smem: smem {
   370			compatible = "qcom,smem";
   371			memory-region = <&smem_mem>;
   372			hwlocks = <&tcsr_mutex 3>;
   373		};
   374	
   375		soc@0 {
   376			#address-cells = <1>;
   377			#size-cells = <1>;
   378			ranges = <0x00 0x00 0x00 0xffffffff>;
   379			compatible = "simple-bus";
   380	
   381			tcsr_mutex: hwlock@340000 {
   382				compatible = "qcom,tcsr-mutex";
   383				reg = <0x00340000 0x20000>;
   384				#hwlock-cells = <1>;
   385			};
   386	
   387			tlmm: pinctrl@500000 {
   388				compatible = "qcom,sm6125-tlmm";
   389				reg = <0x00500000 0x400000>,
   390				      <0x00900000 0x400000>,
   391				      <0x00d00000 0x400000>;
   392				reg-names = "west", "south", "east";
   393				interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
   394				gpio-controller;
   395				gpio-ranges = <&tlmm 0 0 134>;
   396				#gpio-cells = <2>;
   397				interrupt-controller;
   398				#interrupt-cells = <2>;
   399	
   400				sdc2_off_state: sdc2-off-state {
   401					clk-pins {
   402						pins = "sdc2_clk";
   403						drive-strength = <2>;
   404						bias-disable;
   405					};
   406	
   407					cmd-pins {
   408						pins = "sdc2_cmd";
   409						drive-strength = <2>;
   410						bias-pull-up;
   411					};
   412	
   413					data-pins {
   414						pins = "sdc2_data";
   415						drive-strength = <2>;
   416						bias-pull-up;
   417					};
   418				};
   419	
   420				sdc2_on_state: sdc2-on-state {
   421					clk-pins {
   422						pins = "sdc2_clk";
   423						drive-strength = <16>;
   424						bias-disable;
   425					};
   426	
   427					cmd-pins {
   428						pins = "sdc2_cmd";
   429						drive-strength = <10>;
   430						bias-pull-up;
   431					};
   432	
   433					data-pins {
   434						pins = "sdc2_data";
   435						drive-strength = <10>;
   436						bias-pull-up;
   437					};
   438				};
   439	
   440				qup_i2c0_default: qup-i2c0-default-state {
   441					pins = "gpio0", "gpio1";
   442					function = "qup00";
   443					drive-strength = <2>;
   444					bias-disable;
   445				};
   446	
   447				qup_i2c0_sleep: qup-i2c0-sleep-state {
   448					pins = "gpio0", "gpio1";
   449					function = "gpio";
   450					drive-strength = <2>;
   451					bias-pull-up;
   452				};
   453	
   454				qup_i2c1_default: qup-i2c1-default-state {
   455					pins = "gpio4", "gpio5";
   456					function = "qup01";
   457					drive-strength = <2>;
   458					bias-disable;
   459				};
   460	
   461				qup_i2c1_sleep: qup-i2c1-sleep-state {
   462					pins = "gpio4", "gpio5";
   463					function = "gpio";
   464					drive-strength = <2>;
   465					bias-pull-up;
   466				};
   467	
   468				qup_i2c2_default: qup-i2c2-default-state {
   469					pins = "gpio6", "gpio7";
   470					function = "qup02";
   471					drive-strength = <2>;
   472					bias-disable;
   473				};
   474	
   475				qup_i2c2_sleep: qup-i2c2-sleep-state {
   476					pins = "gpio6", "gpio7";
   477					function = "gpio";
   478					drive-strength = <2>;
   479					bias-pull-up;
   480				};
   481	
   482				qup_i2c3_default: qup-i2c3-default-state {
   483					pins = "gpio14", "gpio15";
   484					function = "qup03";
   485					drive-strength = <2>;
   486					bias-disable;
   487				};
   488	
   489				qup_i2c3_sleep: qup-i2c3-sleep-state {
   490					pins = "gpio14", "gpio15";
   491					function = "gpio";
   492					drive-strength = <2>;
   493					bias-pull-up;
   494				};
   495	
   496				qup_i2c4_default: qup-i2c4-default-state {
   497					pins = "gpio16", "gpio17";
   498					function = "qup04";
   499					drive-strength = <2>;
   500					bias-disable;
   501				};
   502	
   503				qup_i2c4_sleep: qup-i2c4-sleep-state {
   504					pins = "gpio16", "gpio17";
   505					function = "gpio";
   506					drive-strength = <2>;
   507					bias-pull-up;
   508				};
   509	
   510				qup_i2c5_default: qup-i2c5-default-state {
   511					pins = "gpio22", "gpio23";
   512					function = "qup10";
   513					drive-strength = <2>;
   514					bias-disable;
   515				};
   516	
   517				qup_i2c5_sleep: qup-i2c5-sleep-state {
   518					pins = "gpio22", "gpio23";
   519					function = "gpio";
   520					drive-strength = <2>;
   521					bias-pull-up;
   522				};
   523	
   524				qup_i2c6_default: qup-i2c6-default-state {
   525					pins = "gpio30", "gpio31";
   526					function = "qup11";
   527					drive-strength = <2>;
   528					bias-disable;
   529				};
   530	
   531				qup_i2c6_sleep: qup-i2c6-sleep-state {
   532					pins = "gpio30", "gpio31";
   533					function = "gpio";
   534					drive-strength = <2>;
   535					bias-pull-up;
   536				};
   537	
   538				qup_i2c7_default: qup-i2c7-default-state {
   539					pins = "gpio28", "gpio29";
   540					function = "qup12";
   541					drive-strength = <2>;
   542					bias-disable;
   543				};
   544	
   545				qup_i2c7_sleep: qup-i2c7-sleep-state {
   546					pins = "gpio28", "gpio29";
   547					function = "gpio";
   548					drive-strength = <2>;
   549					bias-pull-up;
   550				};
   551	
   552				qup_i2c8_default: qup-i2c8-default-state {
   553					pins = "gpio18", "gpio19";
   554					function = "qup13";
   555					drive-strength = <2>;
   556					bias-disable;
   557				};
   558	
   559				qup_i2c8_sleep: qup-i2c8-sleep-state {
   560					pins = "gpio18", "gpio19";
   561					function = "gpio";
   562					drive-strength = <2>;
   563					bias-pull-up;
   564				};
   565	
   566				qup_i2c9_default: qup-i2c9-default-state {
   567					pins = "gpio10", "gpio11";
   568					function = "qup14";
   569					drive-strength = <2>;
   570					bias-disable;
   571				};
   572	
   573				qup_i2c9_sleep: qup-i2c9-sleep-state {
   574					pins = "gpio10", "gpio11";
   575					function = "gpio";
   576					drive-strength = <2>;
   577					bias-pull-up;
   578				};
   579	
   580				qup_spi0_default: qup-spi0-default-state {
   581					pins = "gpio0", "gpio1", "gpio2", "gpio3";
   582					function = "qup00";
   583					drive-strength = <6>;
   584					bias-disable;
   585				};
   586	
   587				qup_spi0_sleep: qup-spi0-sleep-state {
   588					pins = "gpio0", "gpio1", "gpio2", "gpio3";
   589					function = "gpio";
   590					drive-strength = <6>;
   591					bias-disable;
   592				};
   593	
   594				qup_spi2_default: qup-spi2-default-state {
   595					pins = "gpio6", "gpio7", "gpio8", "gpio9";
   596					function = "qup02";
   597					drive-strength = <6>;
   598					bias-disable;
   599				};
   600	
   601				qup_spi2_sleep: qup-spi2-sleep-state {
   602					pins = "gpio6", "gpio7", "gpio8", "gpio9";
   603					function = "gpio";
   604					drive-strength = <6>;
   605					bias-disable;
   606				};
   607	
   608				qup_spi5_default: qup-spi5-default-state {
   609					pins = "gpio22", "gpio23", "gpio24", "gpio25";
   610					function = "qup10";
   611					drive-strength = <6>;
   612					bias-disable;
   613				};
   614	
   615				qup_spi5_sleep: qup-spi5-sleep-state {
   616					pins = "gpio22", "gpio23", "gpio24", "gpio25";
   617					function = "gpio";
   618					drive-strength = <6>;
   619					bias-disable;
   620				};
   621	
   622				qup_spi6_default: qup-spi6-default-state {
   623					pins = "gpio30", "gpio31", "gpio32", "gpio33";
   624					function = "qup11";
   625					drive-strength = <6>;
   626					bias-disable;
   627				};
   628	
   629				qup_spi6_sleep: qup-spi6-sleep-state {
   630					pins = "gpio30", "gpio31", "gpio32", "gpio33";
   631					function = "gpio";
   632					drive-strength = <6>;
   633					bias-disable;
   634				};
   635	
   636				qup_spi8_default: qup-spi8-default-state {
   637					pins = "gpio18", "gpio19", "gpio20", "gpio21";
   638					function = "qup13";
   639					drive-strength = <6>;
   640					bias-disable;
   641				};
   642	
   643				qup_spi8_sleep: qup-spi8-sleep-state {
   644					pins = "gpio18", "gpio19", "gpio20", "gpio21";
   645					function = "gpio";
   646					drive-strength = <6>;
   647					bias-disable;
   648				};
   649	
   650				qup_spi9_default: qup-spi9-default-state {
   651					pins = "gpio10", "gpio11", "gpio12", "gpio13";
   652					function = "qup14";
   653					drive-strength = <6>;
   654					bias-disable;
   655				};
   656	
   657				qup_spi9_sleep: qup-spi9-sleep-state {
   658					pins = "gpio10", "gpio11", "gpio12", "gpio13";
   659					function = "gpio";
   660					drive-strength = <6>;
   661					bias-disable;
   662				};
   663			};
   664	
   665			gcc: clock-controller@1400000 {
   666				compatible = "qcom,gcc-sm6125";
   667				reg = <0x01400000 0x1f0000>;
   668				#clock-cells = <1>;
   669				#reset-cells = <1>;
   670				#power-domain-cells = <1>;
   671				clock-names = "bi_tcxo", "sleep_clk";
   672				clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
   673			};
   674	
   675			hsusb_phy1: phy@1613000 {
   676				compatible = "qcom,msm8996-qusb2-phy";
   677				reg = <0x01613000 0x180>;
   678				#phy-cells = <0>;
   679	
   680				clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
   681					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
   682				clock-names = "cfg_ahb", "ref";
   683	
   684				resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
   685				status = "disabled";
   686			};
   687	
   688			spmi_bus: spmi@1c40000 {
   689				compatible = "qcom,spmi-pmic-arb";
   690				reg = <0x01c40000 0x1100>,
   691				      <0x01e00000 0x2000000>,
   692				      <0x03e00000 0x100000>,
   693				      <0x03f00000 0xa0000>,
   694				      <0x01c0a000 0x26000>;
   695				reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
   696				interrupt-names = "periph_irq";
   697				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
   698				qcom,ee = <0>;
   699				qcom,channel = <0>;
   700				#address-cells = <2>;
   701				#size-cells = <0>;
   702				interrupt-controller;
   703				#interrupt-cells = <4>;
   704			};
   705	
   706			rpm_msg_ram: sram@45f0000 {
   707				compatible = "qcom,rpm-msg-ram";
   708				reg = <0x045f0000 0x7000>;
   709			};
   710	
   711			sdhc_1: mmc@4744000 {
   712				compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
   713				reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
   714				reg-names = "hc", "cqhci";
   715	
   716				interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
   717					     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
   718				interrupt-names = "hc_irq", "pwr_irq";
   719	
   720				clocks = <&gcc GCC_SDCC1_AHB_CLK>,
   721					 <&gcc GCC_SDCC1_APPS_CLK>,
   722					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
   723				clock-names = "iface", "core", "xo";
   724				iommus = <&apps_smmu 0x160 0x0>;
   725	
   726				power-domains = <&rpmpd SM6125_VDDCX>;
   727	
   728				qcom,dll-config = <0x000f642c>;
   729				qcom,ddr-config = <0x80040873>;
   730	
   731				bus-width = <8>;
   732				non-removable;
   733				supports-cqe;
   734	
   735				status = "disabled";
   736			};
   737	
   738			sdhc_2: mmc@4784000 {
   739				compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
   740				reg = <0x04784000 0x1000>;
   741				reg-names = "hc";
   742	
   743				interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
   744					     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
   745				interrupt-names = "hc_irq", "pwr_irq";
   746	
   747				clocks = <&gcc GCC_SDCC2_AHB_CLK>,
   748					 <&gcc GCC_SDCC2_APPS_CLK>,
   749					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
   750				clock-names = "iface", "core", "xo";
   751				iommus = <&apps_smmu 0x180 0x0>;
   752	
   753				pinctrl-0 = <&sdc2_on_state>;
   754				pinctrl-1 = <&sdc2_off_state>;
   755				pinctrl-names = "default", "sleep";
   756	
   757				power-domains = <&rpmpd SM6125_VDDCX>;
   758	
   759				qcom,dll-config = <0x0007642c>;
   760				qcom,ddr-config = <0x80040873>;
   761	
   762				bus-width = <4>;
   763				status = "disabled";
   764			};
   765	
   766			ufs_mem_hc: ufs@4804000 {
   767				compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
   768				reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
   769				reg-names = "std", "ice";
   770				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
   771	
   772				clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
   773					 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
   774					 <&gcc GCC_UFS_PHY_AHB_CLK>,
   775					 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
   776					 <&rpmcc RPM_SMD_XO_CLK_SRC>,
   777					 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
   778					 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
   779					 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
   780				clock-names = "core_clk",
   781					      "bus_aggr_clk",
   782					      "iface_clk",
   783					      "core_clk_unipro",
   784					      "ref_clk",
   785					      "tx_lane0_sync_clk",
   786					      "rx_lane0_sync_clk",
   787					      "ice_core_clk";
   788				freq-table-hz = <50000000 240000000>,
   789						<0 0>,
   790						<0 0>,
   791						<37500000 150000000>,
   792						<0 0>,
   793						<0 0>,
   794						<0 0>,
   795						<75000000 300000000>;
   796	
   797				resets = <&gcc GCC_UFS_PHY_BCR>;
   798				reset-names = "rst";
   799				#reset-cells = <1>;
   800	
   801				phys = <&ufs_mem_phy>;
   802				phy-names = "ufsphy";
   803	
   804				lanes-per-direction = <1>;
   805	
   806				iommus = <&apps_smmu 0x200 0x0>;
   807	
   808				status = "disabled";
   809			};
   810	
   811			ufs_mem_phy: phy@4807000 {
   812				compatible = "qcom,sm6125-qmp-ufs-phy";
   813				reg = <0x04807000 0xdb8>;
   814	
   815				clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
   816					 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
   817				clock-names = "ref",
   818					      "ref_aux";
   819	
   820				resets = <&ufs_mem_hc 0>;
   821				reset-names = "ufsphy";
   822	
   823				power-domains = <&gcc UFS_PHY_GDSC>;
   824	
   825				#phy-cells = <0>;
   826	
   827				status = "disabled";
   828			};
   829	
   830			gpi_dma0: dma-controller@4a00000 {
   831				compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
   832				reg = <0x04a00000 0x60000>;
   833				interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
   834					     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
   835					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
   836					     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
   837					     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
   838					     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
   839					     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
   840					     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
   841				dma-channels = <8>;
   842				dma-channel-mask = <0x1f>;
   843				iommus = <&apps_smmu 0x136 0x0>;
   844				#dma-cells = <3>;
   845				status = "disabled";
   846			};
   847	
   848			qupv3_id_0: geniqup@4ac0000 {
   849				compatible = "qcom,geni-se-qup";
   850				reg = <0x04ac0000 0x2000>;
   851				clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
   852					 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
   853				clock-names = "m-ahb", "s-ahb";
   854				iommus = <&apps_smmu 0x123 0x0>;
   855				#address-cells = <1>;
   856				#size-cells = <1>;
   857				ranges;
   858				status = "disabled";
   859	
   860				i2c0: i2c@4a80000 {
   861					compatible = "qcom,geni-i2c";
   862					reg = <0x04a80000 0x4000>;
   863					clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
   864					clock-names = "se";
   865					interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
   866					pinctrl-0 = <&qup_i2c0_default>;
   867					pinctrl-1 = <&qup_i2c0_sleep>;
   868					pinctrl-names = "default", "sleep";
   869					dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
   870					       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
   871					dma-names = "tx", "rx";
   872					#address-cells = <1>;
   873					#size-cells = <0>;
   874					status = "disabled";
   875				};
   876	
   877				spi0: spi@4a80000 {
   878					compatible = "qcom,geni-spi";
   879					reg = <0x04a80000 0x4000>;
   880					clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
   881					clock-names = "se";
   882					interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
   883					pinctrl-0 = <&qup_spi0_default>;
   884					pinctrl-1 = <&qup_spi0_sleep>;
   885					pinctrl-names = "default", "sleep";
   886					dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
   887					       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
   888					dma-names = "tx", "rx";
   889					#address-cells = <1>;
   890					#size-cells = <0>;
   891					status = "disabled";
   892				};
   893	
   894				i2c1: i2c@4a84000 {
   895					compatible = "qcom,geni-i2c";
   896					reg = <0x04a84000 0x4000>;
   897					clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
   898					clock-names = "se";
   899					interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
   900					pinctrl-0 = <&qup_i2c1_default>;
   901					pinctrl-1 = <&qup_i2c1_sleep>;
   902					pinctrl-names = "default", "sleep";
   903					dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
   904					       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
   905					dma-names = "tx", "rx";
   906					#address-cells = <1>;
   907					#size-cells = <0>;
   908					status = "disabled";
   909				};
   910	
   911				i2c2: i2c@4a88000 {
   912					compatible = "qcom,geni-i2c";
   913					reg = <0x04a88000 0x4000>;
   914					clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
   915					clock-names = "se";
   916					interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
   917					pinctrl-0 = <&qup_i2c2_default>;
   918					pinctrl-1 = <&qup_i2c2_sleep>;
   919					pinctrl-names = "default", "sleep";
   920					dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
   921					       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
   922					dma-names = "tx", "rx";
   923					#address-cells = <1>;
   924					#size-cells = <0>;
   925					status = "disabled";
   926				};
   927	
   928				spi2: spi@4a88000 {
   929					compatible = "qcom,geni-spi";
   930					reg = <0x04a88000 0x4000>;
   931					clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
   932					clock-names = "se";
   933					interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
   934					pinctrl-0 = <&qup_spi2_default>;
   935					pinctrl-1 = <&qup_spi2_sleep>;
   936					pinctrl-names = "default", "sleep";
   937					dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
   938					       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
   939					dma-names = "tx", "rx";
   940					#address-cells = <1>;
   941					#size-cells = <0>;
   942					status = "disabled";
   943				};
   944	
   945				i2c3: i2c@4a8c000 {
   946					compatible = "qcom,geni-i2c";
   947					reg = <0x04a8c000 0x4000>;
   948					clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
   949					clock-names = "se";
   950					interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
   951					pinctrl-0 = <&qup_i2c3_default>;
   952					pinctrl-1 = <&qup_i2c3_sleep>;
   953					pinctrl-names = "default", "sleep";
   954					dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
   955					       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
   956					dma-names = "tx", "rx";
   957					#address-cells = <1>;
   958					#size-cells = <0>;
   959					status = "disabled";
   960				};
   961	
   962				i2c4: i2c@4a90000 {
   963					compatible = "qcom,geni-i2c";
   964					reg = <0x04a90000 0x4000>;
   965					clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
   966					clock-names = "se";
   967					interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
   968					pinctrl-0 = <&qup_i2c4_default>;
   969					pinctrl-1 = <&qup_i2c4_sleep>;
   970					pinctrl-names = "default", "sleep";
   971					dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
   972					       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
   973					dma-names = "tx", "rx";
   974					#address-cells = <1>;
   975					#size-cells = <0>;
   976					status = "disabled";
   977				};
   978			};
   979	
   980			gpi_dma1: dma-controller@4c00000 {
   981				compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
   982				reg = <0x04c00000 0x60000>;
   983				interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
   984					     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
   985					     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
   986					     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
   987					     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
   988					     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
   989					     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
   990					     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
   991				dma-channels = <8>;
   992				dma-channel-mask = <0x0f>;
   993				iommus = <&apps_smmu 0x156 0x0>;
   994				#dma-cells = <3>;
   995				status = "disabled";
   996			};
   997	
   998			qupv3_id_1: geniqup@4cc0000 {
   999				compatible = "qcom,geni-se-qup";
  1000				reg = <0x04cc0000 0x2000>;
  1001				clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
  1002					 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
  1003				clock-names = "m-ahb", "s-ahb";
  1004				iommus = <&apps_smmu 0x143 0x0>;
  1005				#address-cells = <1>;
  1006				#size-cells = <1>;
  1007				ranges;
  1008				status = "disabled";
  1009	
  1010				i2c5: i2c@4c80000 {
  1011					compatible = "qcom,geni-i2c";
  1012					reg = <0x04c80000 0x4000>;
  1013					clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
  1014					clock-names = "se";
  1015					interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
  1016					pinctrl-0 = <&qup_i2c5_default>;
  1017					pinctrl-1 = <&qup_i2c5_sleep>;
  1018					pinctrl-names = "default", "sleep";
  1019					dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
  1020					       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
  1021					dma-names = "tx", "rx";
  1022					#address-cells = <1>;
  1023					#size-cells = <0>;
  1024					status = "disabled";
  1025				};
  1026	
  1027				spi5: spi@4c80000 {
  1028					compatible = "qcom,geni-spi";
  1029					reg = <0x04c80000 0x4000>;
  1030					clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
  1031					clock-names = "se";
  1032					interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
  1033					pinctrl-0 = <&qup_spi5_default>;
  1034					pinctrl-1 = <&qup_spi5_sleep>;
  1035					pinctrl-names = "default", "sleep";
  1036					dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
  1037					       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
  1038					dma-names = "tx", "rx";
  1039					#address-cells = <1>;
  1040					#size-cells = <0>;
  1041					status = "disabled";
  1042				};
  1043	
  1044				i2c6: i2c@4c84000 {
  1045					compatible = "qcom,geni-i2c";
  1046					reg = <0x04c84000 0x4000>;
  1047					clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
  1048					clock-names = "se";
  1049					interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
  1050					pinctrl-0 = <&qup_i2c6_default>;
  1051					pinctrl-1 = <&qup_i2c6_sleep>;
  1052					pinctrl-names = "default", "sleep";
  1053					dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
  1054					       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
  1055					dma-names = "tx", "rx";
  1056					#address-cells = <1>;
  1057					#size-cells = <0>;
  1058					status = "disabled";
  1059				};
  1060	
  1061				spi6: spi@4c84000 {
  1062					compatible = "qcom,geni-spi";
  1063					reg = <0x04c84000 0x4000>;
  1064					clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
  1065					clock-names = "se";
  1066					interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
  1067					pinctrl-0 = <&qup_spi6_default>;
  1068					pinctrl-1 = <&qup_spi6_sleep>;
  1069					pinctrl-names = "default", "sleep";
  1070					dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
  1071					       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
  1072					dma-names = "tx", "rx";
  1073					#address-cells = <1>;
  1074					#size-cells = <0>;
  1075					status = "disabled";
  1076				};
  1077	
  1078				i2c7: i2c@4c88000 {
  1079					compatible = "qcom,geni-i2c";
  1080					reg = <0x04c88000 0x4000>;
  1081					clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
  1082					clock-names = "se";
  1083					interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
  1084					pinctrl-0 = <&qup_i2c7_default>;
  1085					pinctrl-1 = <&qup_i2c7_sleep>;
  1086					pinctrl-names = "default", "sleep";
  1087					dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
  1088					       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
  1089					dma-names = "tx", "rx";
  1090					#address-cells = <1>;
  1091					#size-cells = <0>;
  1092					status = "disabled";
  1093				};
  1094	
  1095				i2c8: i2c@4c8c000 {
  1096					compatible = "qcom,geni-i2c";
  1097					reg = <0x04c8c000 0x4000>;
  1098					clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
  1099					clock-names = "se";
  1100					interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
  1101					pinctrl-0 = <&qup_i2c8_default>;
  1102					pinctrl-1 = <&qup_i2c8_sleep>;
  1103					pinctrl-names = "default", "sleep";
  1104					dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
  1105					       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
  1106					dma-names = "tx", "rx";
  1107					#address-cells = <1>;
  1108					#size-cells = <0>;
  1109					status = "disabled";
  1110				};
  1111	
  1112				spi8: spi@4c8c000 {
  1113					compatible = "qcom,geni-spi";
  1114					reg = <0x04c8c000 0x4000>;
  1115					clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
  1116					clock-names = "se";
  1117					interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
  1118					pinctrl-0 = <&qup_spi8_default>;
  1119					pinctrl-1 = <&qup_spi8_sleep>;
  1120					pinctrl-names = "default", "sleep";
  1121					dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
  1122					       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
  1123					dma-names = "tx", "rx";
  1124					#address-cells = <1>;
  1125					#size-cells = <0>;
  1126					status = "disabled";
  1127				};
  1128	
  1129				i2c9: i2c@4c90000 {
  1130					compatible = "qcom,geni-i2c";
  1131					reg = <0x04c90000 0x4000>;
  1132					clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
  1133					clock-names = "se";
  1134					interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
  1135					pinctrl-0 = <&qup_i2c9_default>;
  1136					pinctrl-1 = <&qup_i2c9_sleep>;
  1137					pinctrl-names = "default", "sleep";
  1138					dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
  1139					       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
  1140					dma-names = "tx", "rx";
  1141					#address-cells = <1>;
  1142					#size-cells = <0>;
  1143					status = "disabled";
  1144				};
  1145	
  1146				spi9: spi@4c90000 {
  1147					compatible = "qcom,geni-spi";
  1148					reg = <0x04c90000 0x4000>;
  1149					clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
  1150					clock-names = "se";
  1151					interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
  1152					pinctrl-0 = <&qup_spi9_default>;
  1153					pinctrl-1 = <&qup_spi9_sleep>;
  1154					pinctrl-names = "default", "sleep";
  1155					dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
  1156					       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
  1157					dma-names = "tx", "rx";
  1158					#address-cells = <1>;
  1159					#size-cells = <0>;
  1160					status = "disabled";
  1161				};
  1162			};
  1163	
  1164			usb3: usb@4ef8800 {
  1165				compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
  1166				reg = <0x04ef8800 0x400>;
  1167				#address-cells = <1>;
  1168				#size-cells = <1>;
  1169				ranges;
  1170	
  1171				clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
  1172					 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
  1173					 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
  1174					 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
  1175					 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
  1176					 <&gcc GCC_USB3_PRIM_CLKREF_CLK>;
  1177				clock-names = "cfg_noc",
  1178					      "core",
  1179					      "iface",
  1180					      "sleep",
  1181					      "mock_utmi",
  1182					      "xo";
  1183	
  1184				assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
  1185						  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
  1186				assigned-clock-rates = <19200000>, <66666667>;
  1187	
  1188				power-domains = <&gcc USB30_PRIM_GDSC>;
  1189				qcom,select-utmi-as-pipe-clk;
  1190				status = "disabled";
  1191	
  1192				usb3_dwc3: usb@4e00000 {
  1193					compatible = "snps,dwc3";
  1194					reg = <0x04e00000 0xcd00>;
  1195					interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
  1196					iommus = <&apps_smmu 0x100 0x0>;
  1197					phys = <&hsusb_phy1>;
  1198					phy-names = "usb2-phy";
  1199					snps,dis_u2_susphy_quirk;
  1200					snps,dis_enblslpm_quirk;
  1201					maximum-speed = "high-speed";
  1202					dr_mode = "peripheral";
  1203				};
  1204			};
  1205	
  1206			sram@4690000 {
  1207				compatible = "qcom,rpm-stats";
  1208				reg = <0x04690000 0x10000>;
  1209			};
  1210	
  1211			mdss: display-subsystem@5e00000 {
  1212				compatible = "qcom,sm6125-mdss";
  1213				reg = <0x05e00000 0x1000>;
  1214				reg-names = "mdss";
  1215	
  1216				interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
  1217				interrupt-controller;
  1218				#interrupt-cells = <1>;
  1219	
  1220				clocks = <&gcc GCC_DISP_AHB_CLK>,
  1221					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
  1222					 <&dispcc DISP_CC_MDSS_MDP_CLK>;
  1223				clock-names = "iface",
  1224					      "ahb",
  1225					      "core";
  1226	
  1227				power-domains = <&dispcc MDSS_GDSC>;
  1228	
  1229				iommus = <&apps_smmu 0x400 0x0>;
  1230	
  1231				#address-cells = <1>;
  1232				#size-cells = <1>;
  1233				ranges;
  1234	
  1235				status = "disabled";
  1236	
  1237				mdss_mdp: display-controller@5e01000 {
  1238					compatible = "qcom,sm6125-dpu";
  1239					reg = <0x05e01000 0x83208>,
  1240					      <0x05eb0000 0x2008>;
  1241					reg-names = "mdp", "vbif";
  1242	
  1243					interrupt-parent = <&mdss>;
  1244					interrupts = <0>;
  1245	
  1246					clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
  1247						 <&dispcc DISP_CC_MDSS_AHB_CLK>,
  1248						 <&dispcc DISP_CC_MDSS_ROT_CLK>,
  1249						 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
  1250						 <&dispcc DISP_CC_MDSS_MDP_CLK>,
  1251						 <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
  1252						 <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
  1253					clock-names = "bus",
  1254						      "iface",
  1255						      "rot",
  1256						      "lut",
  1257						      "core",
  1258						      "vsync",
  1259						      "throttle";
  1260					assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
  1261					assigned-clock-rates = <19200000>;
  1262	
  1263					operating-points-v2 = <&mdp_opp_table>;
  1264					power-domains = <&rpmpd SM6125_VDDCX>;
  1265	
> 1266					ports {
  1267						#address-cells = <1>;
  1268						#size-cells = <0>;
  1269	
  1270						port@0 {
  1271							reg = <0>;
  1272							dpu_intf1_out: endpoint {
  1273								remote-endpoint = <&mdss_dsi0_in>;
  1274							};
  1275						};
  1276					};
  1277	
  1278					mdp_opp_table: opp-table {
  1279						compatible = "operating-points-v2";
  1280	
  1281						opp-192000000 {
  1282							opp-hz = /bits/ 64 <192000000>;
  1283							required-opps = <&rpmpd_opp_low_svs>;
  1284						};
  1285	
  1286						opp-256000000 {
  1287							opp-hz = /bits/ 64 <256000000>;
  1288							required-opps = <&rpmpd_opp_svs>;
  1289						};
  1290	
  1291						opp-307200000 {
  1292							opp-hz = /bits/ 64 <307200000>;
  1293							required-opps = <&rpmpd_opp_svs_plus>;
  1294						};
  1295	
  1296						opp-384000000 {
  1297							opp-hz = /bits/ 64 <384000000>;
  1298							required-opps = <&rpmpd_opp_nom>;
  1299						};
  1300	
  1301						opp-400000000 {
  1302							opp-hz = /bits/ 64 <400000000>;
  1303							required-opps = <&rpmpd_opp_turbo>;
  1304						};
  1305					};
  1306				};
  1307	
> 1308				mdss_dsi0: dsi@5e94000 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

