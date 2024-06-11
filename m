Return-Path: <linux-kernel+bounces-209189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055F0902E81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EBD281DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080D15B0F1;
	Tue, 11 Jun 2024 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBzd78cU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9216F849
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073481; cv=none; b=sptRbA3wzR9c8lYdiOKcZ3n3mEKM1dfX7xrZ8kx91JhCPFKRlfpyPMrq2f6sQE/ffrI4GaPaCZSoP0E9n5j35gf3Nqe8sD1s/bZw/81SaN+pdoHplUduaQj8JfqP2eUrzMciZXQvRfy924ICJhu6gMRDB2mjfwIZhBSrboQelKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073481; c=relaxed/simple;
	bh=eVp/xa3UpkoBXz1GR7xBuSg7fs4DfxD2w1sGKh1YbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RwzO4oaCGqf0Zi/wa8Bcjk0FT7D9UaLICSVPilH6oeuEJGpwymbzCnBR9jAduTsFL39sVYXlXySDFmwrLoNs0p4ruAxQEf7Oed5k0YF5qyVWqNOZsB7B7Ssd8K20UeK4gPvRDZV6csB0yvIJXRLsvzZxfLg9MMsX0cVeK9MPRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBzd78cU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718073480; x=1749609480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVp/xa3UpkoBXz1GR7xBuSg7fs4DfxD2w1sGKh1YbSc=;
  b=FBzd78cUr76+qHO2dHIcNsTo0MkPCicVjmBtQBHobgVSqkgTa0ithX70
   yd3rscdYmHdN6NO4W9isESPp5kAhx4f3oFrrsy0pW/svQKC7yAGYFl7GL
   OtOLC/laUNTvAiAzInGdqDEJp1weZku5hX7+FKpYDI1TzhVljA1NR1QTT
   ovQxA2oWVtcek9D/xvy8VbdLuojtH65+EK3s5O9IB0+MvSB0ktKUZI3n4
   ZFdonqALULn4ucT6AyUJkYC938rLwPyJBYiLKlnIm9jjKHIHQ/HESjR2D
   tbgsnMRPEtymp9oc09sihryVJeQRwcXq+5nCl97DbJ+rom2eqgcECTJ6D
   Q==;
X-CSE-ConnectionGUID: hfc/VONuRHOaQXrXT1GreA==
X-CSE-MsgGUID: rGkDQKhTQoitrGCCian3yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14931784"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14931784"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 19:37:59 -0700
X-CSE-ConnectionGUID: QDI+IpijRhmHxGgiZTyJMg==
X-CSE-MsgGUID: bMaWB+aLSQi4vDNlOmoQNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39942938"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Jun 2024 19:37:57 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGrOU-0002hZ-1k;
	Tue, 11 Jun 2024 02:37:54 +0000
Date: Tue, 11 Jun 2024 10:36:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/pmi632.dtsi:155.19-163.5: Warning
 (avoid_unnecessary_addr_size): /soc@0/spmi@200f000/pmic@3/pwm: unnecessary
 #address-cells/#size-cells without "ranges" or child "reg" property
Message-ID: <202406111049.yZhTbJUJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   83a7eefedc9b56fe7bfeff13b6c7356688ffa670
commit: 0c4f10917d22e6f36080617bfe71de1ae854ee58 arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
date:   1 year, 1 month ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240611/202406111049.yZhTbJUJ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240611/202406111049.yZhTbJUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111049.yZhTbJUJ-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/msm8953.dtsi:175.9-179.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
   arch/arm64/boot/dts/qcom/msm8953.dtsi:865.22-915.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@1a00000/dsi@1a94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/pmi632.dtsi:149.9-164.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@200f000/pmic@3: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/pmi632.dtsi:155.19-163.5: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@200f000/pmic@3/pwm: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

vim +155 arch/arm64/boot/dts/qcom/pmi632.dtsi

a1f0f2ebb044c7 Luca Weiss 2023-05-23   40  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   41  &spmi_bus {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   42  	pmic@2 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   43  		compatible = "qcom,pmi632", "qcom,spmi-pmic";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   44  		reg = <0x2 SPMI_USID>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   45  		#address-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   46  		#size-cells = <0>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   47  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   48  		pmi632_temp: temp-alarm@2400 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   49  			compatible = "qcom,spmi-temp-alarm";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   50  			reg = <0x2400>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   51  			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   52  			#thermal-sensor-cells = <0>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   53  		};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   54  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   55  		pmi632_adc: adc@3100 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   56  			compatible = "qcom,spmi-adc5";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   57  			reg = <0x3100>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   58  			#address-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   59  			#size-cells = <0>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   60  			#io-channel-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   61  			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   62  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   63  			channel@0 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   64  				reg = <ADC5_REF_GND>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   65  				qcom,pre-scaling = <1 1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   66  				label = "ref_gnd";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   67  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   68  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   69  			channel@1 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   70  				reg = <ADC5_1P25VREF>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   71  				qcom,pre-scaling = <1 1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   72  				label = "vref_1p25";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   73  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   74  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   75  			channel@6 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   76  				reg = <ADC5_DIE_TEMP>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   77  				qcom,pre-scaling = <1 1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   78  				label = "die_temp";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   79  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   80  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   81  			channel@7 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   82  				reg = <ADC5_USB_IN_I>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   83  				qcom,pre-scaling = <1 1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   84  				label = "usb_in_i_uv";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   85  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   86  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   87  			channel@8 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   88  				reg = <ADC5_USB_IN_V_16>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   89  				qcom,pre-scaling = <1 16>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   90  				label = "usb_in_v_div_16";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   91  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   92  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   93  			channel@9 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23   94  				reg = <ADC5_CHG_TEMP>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   95  				qcom,pre-scaling = <1 1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23   96  				label = "chg_temp";
a1f0f2ebb044c7 Luca Weiss 2023-05-23   97  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23   98  
a1f0f2ebb044c7 Luca Weiss 2023-05-23   99  			channel@4b {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  100  				reg = <ADC5_BAT_ID_100K_PU>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  101  				qcom,hw-settle-time = <200>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  102  				qcom,pre-scaling = <1 1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  103  				qcom,ratiometric;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  104  				label = "bat_id";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  105  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  106  
a1f0f2ebb044c7 Luca Weiss 2023-05-23  107  			channel@83 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  108  				reg = <ADC5_VPH_PWR>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  109  				qcom,pre-scaling = <1 3>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  110  				label = "vph_pwr";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  111  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  112  
a1f0f2ebb044c7 Luca Weiss 2023-05-23  113  			channel@84 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  114  				reg = <ADC5_VBAT_SNS>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  115  				qcom,pre-scaling = <1 3>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  116  				label = "vbat_sns";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  117  			};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  118  		};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  119  
a1f0f2ebb044c7 Luca Weiss 2023-05-23  120  		pmi632_adc_tm: adc-tm@3500 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  121  			compatible = "qcom,spmi-adc-tm5";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  122  			reg = <0x3500>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  123  			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  124  			#thermal-sensor-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  125  			#address-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  126  			#size-cells = <0>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  127  			status = "disabled";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  128  		};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  129  
a1f0f2ebb044c7 Luca Weiss 2023-05-23  130  		pmi632_sdam_7: nvram@b600 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  131  			compatible = "qcom,spmi-sdam";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  132  			reg = <0xb600>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  133  			#address-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  134  			#size-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  135  			ranges = <0 0xb600 0x100>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  136  		};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  137  
a1f0f2ebb044c7 Luca Weiss 2023-05-23  138  		pmi632_gpios: gpio@c000 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  139  			compatible = "qcom,pmi632-gpio", "qcom,spmi-gpio";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  140  			reg = <0xc000>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  141  			gpio-controller;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  142  			gpio-ranges = <&pmi632_gpios 0 0 8>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  143  			#gpio-cells = <2>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  144  			interrupt-controller;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  145  			#interrupt-cells = <2>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  146  		};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  147  	};
a1f0f2ebb044c7 Luca Weiss 2023-05-23  148  
a1f0f2ebb044c7 Luca Weiss 2023-05-23 @149  	pmic@3 {
a1f0f2ebb044c7 Luca Weiss 2023-05-23  150  		compatible = "qcom,pmi632", "qcom,spmi-pmic";
a1f0f2ebb044c7 Luca Weiss 2023-05-23  151  		reg = <0x3 SPMI_USID>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  152  		#address-cells = <1>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  153  		#size-cells = <0>;
a1f0f2ebb044c7 Luca Weiss 2023-05-23  154  
a1f0f2ebb044c7 Luca Weiss 2023-05-23 @155  		pmi632_lpg: pwm {

:::::: The code at line 155 was first introduced by commit
:::::: a1f0f2ebb044c7248c3f30b98de0f151505bd4bd arm64: dts: qcom: Add PMI632 PMIC

:::::: TO: Luca Weiss <luca@z3ntu.xyz>
:::::: CC: Bjorn Andersson <andersson@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

