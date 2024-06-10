Return-Path: <linux-kernel+bounces-208167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A869021D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA65B20DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6780637;
	Mon, 10 Jun 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM1cbk17"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EB7FBC3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023482; cv=none; b=MwdoBn/SGej5DYoTPPaEEtIyailKp8jx/bXds/6Wps52X+bjRPMzb55hh5M7g5XqwPrfHGt02Dewt1gTiCiQ87XwaNtc66tSYm/QbpLO/mZJj5/NCQHAff050zMnZtgYH9uG45Tdow4OhExAR9K4zFNi7SffiiMTpGdu5uPkDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023482; c=relaxed/simple;
	bh=bhelKEHV0w6/qqBoDpnpekoc3zisUzpO/bppxreALhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lHllWA/G06CBo1yVxGlZ9cTSaWap1O+DJ25job6HKuF8Pn9zCZ2Kds/JRh4pN8ehKTYGjY674jKy1Iv9akEGdxbSXxJN0lr0plbuGAaP2jhUd9/xKUXy+IWEfzPKJuk+i8g40aLO+zYba6N9gPWdx/JOKZc/9OtCZiF17HXinow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM1cbk17; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718023481; x=1749559481;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bhelKEHV0w6/qqBoDpnpekoc3zisUzpO/bppxreALhQ=;
  b=aM1cbk17o/stGGXvCo6ANGLDvYBqAeqK4W3U6pnXgyVSfvnt8IWiAdtS
   pOwOGiImQxNGapXB2EAe9s887RsCstUYnV+9Qn9SLaAJNDZAFxys4LZYD
   dNh3c9BPUgjnKnlBjm5j0c3a8533EmLUfJQLGtjJuS5vrwAgHdpmkA6o4
   mWRP/0FKrdeLrJo8r/ppYjpZP6rdmEfkbBpApoY8Ta3/kgV0LTtVkVhzP
   TytaBC+GCIyiEz2lQMe1Z/Ik74ro5BRFmVFf5OtHMCIkZIvyEd6pLaUM8
   A/JlIOubukprawYWRhpZyJ4X7KQg7aY+RxF8hrOYQEISnEaYm3/tQr/ia
   Q==;
X-CSE-ConnectionGUID: k/oxXGp4TmqJJai2VgOvgg==
X-CSE-MsgGUID: DmSPKgJCTsW9btMVqI0f9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18504211"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18504211"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 05:44:41 -0700
X-CSE-ConnectionGUID: 13Gtb8g6Qj2MzjYFKrG2qA==
X-CSE-MsgGUID: 6h7UU/zZS7mPFPKKntcY3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="70211549"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jun 2024 05:44:37 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGeO4-00028p-1h;
	Mon, 10 Jun 2024 12:44:36 +0000
Date: Mon, 10 Jun 2024 20:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/pm8994.dtsi:132.9-151.4: Warning
 (avoid_unnecessary_addr_size): /soc/spmi@fc4cf000/pmic@1: unnecessary
 #address-cells/#size-cells without "ranges" or child "reg" property
Message-ID: <202406102038.tWmCucZI-lkp@intel.com>
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
commit: 24f0f6a8059c7108d4ee3476c95db1e7ff4feb79 arm64: dts: qcom: msm8994: correct SPMI unit address
date:   1 year, 1 month ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240610/202406102038.tWmCucZI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240610/202406102038.tWmCucZI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406102038.tWmCucZI-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/msm8994.dtsi:343.11-1090.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
   arch/arm64/boot/dts/qcom/msm8994.dtsi:628.28-644.5: Warning (avoid_unnecessary_addr_size): /soc/i2c@f9928000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/pm8994.dtsi:132.9-151.4: Warning (avoid_unnecessary_addr_size): /soc/spmi@fc4cf000/pmic@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
--
   arch/arm64/boot/dts/qcom/msm8994.dtsi:343.11-1090.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
>> arch/arm64/boot/dts/qcom/pm8994.dtsi:132.9-151.4: Warning (avoid_unnecessary_addr_size): /soc/spmi@fc4cf000/pmic@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
--
   arch/arm64/boot/dts/qcom/msm8994.dtsi:343.11-1090.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
>> arch/arm64/boot/dts/qcom/pm8994.dtsi:132.9-151.4: Warning (avoid_unnecessary_addr_size): /soc/spmi@fc4cf000/pmic@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/msm8994.dtsi:232.20-235.5: Warning (unique_unit_address_if_enabled): /reserved-memory/reserved@6c00000: duplicate unit-address (also used in node /reserved-memory/memory@6c00000)
--
   arch/arm64/boot/dts/qcom/msm8994.dtsi:343.11-1090.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
>> arch/arm64/boot/dts/qcom/pm8994.dtsi:132.9-151.4: Warning (avoid_unnecessary_addr_size): /soc/spmi@fc4cf000/pmic@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/msm8994.dtsi:232.20-235.5: Warning (unique_unit_address_if_enabled): /reserved-memory/reserved@6c00000: duplicate unit-address (also used in node /reserved-memory/hole2@6c00000)
   arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts:112.29-115.5: Warning (unique_unit_address_if_enabled): /reserved-memory/audio@cb400000: duplicate unit-address (also used in node /reserved-memory/qseecom@cb400000)

vim +132 arch/arm64/boot/dts/qcom/pm8994.dtsi

38757eb3ca3436 Stephen Boyd        2015-11-17   32  
38757eb3ca3436 Stephen Boyd        2015-11-17   33  	pmic@0 {
38757eb3ca3436 Stephen Boyd        2015-11-17   34  		compatible = "qcom,pm8994", "qcom,spmi-pmic";
38757eb3ca3436 Stephen Boyd        2015-11-17   35  		reg = <0x0 SPMI_USID>;
38757eb3ca3436 Stephen Boyd        2015-11-17   36  		#address-cells = <1>;
38757eb3ca3436 Stephen Boyd        2015-11-17   37  		#size-cells = <0>;
0804308fdd3cf5 Stephen Boyd        2015-11-17   38  
27414e41ba5f14 Bjorn Andersson     2017-02-17   39  		rtc@6000 {
27414e41ba5f14 Bjorn Andersson     2017-02-17   40  			compatible = "qcom,pm8941-rtc";
27414e41ba5f14 Bjorn Andersson     2017-02-17   41  			reg = <0x6000>, <0x6100>;
27414e41ba5f14 Bjorn Andersson     2017-02-17   42  			reg-names = "rtc", "alarm";
27414e41ba5f14 Bjorn Andersson     2017-02-17   43  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
27414e41ba5f14 Bjorn Andersson     2017-02-17   44  		};
27414e41ba5f14 Bjorn Andersson     2017-02-17   45  
da3a82e35e4b24 Gustave Monce       2021-01-31   46  		pm8994_pon: pon@800 {
2f74b3db92bef4 Vinod Koul          2018-09-10   47  			compatible = "qcom,pm8916-pon";
2f74b3db92bef4 Vinod Koul          2018-09-10   48  			reg = <0x800>;
2f74b3db92bef4 Vinod Koul          2018-09-10   49  			mode-bootloader = <0x2>;
2f74b3db92bef4 Vinod Koul          2018-09-10   50  			mode-recovery = <0x1>;
2f74b3db92bef4 Vinod Koul          2018-09-10   51  
2f74b3db92bef4 Vinod Koul          2018-09-10   52  			pwrkey {
2f74b3db92bef4 Vinod Koul          2018-09-10   53  				compatible = "qcom,pm8941-pwrkey";
2f74b3db92bef4 Vinod Koul          2018-09-10   54  				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
2f74b3db92bef4 Vinod Koul          2018-09-10   55  				debounce = <15625>;
2f74b3db92bef4 Vinod Koul          2018-09-10   56  				bias-pull-up;
2f74b3db92bef4 Vinod Koul          2018-09-10   57  				linux,code = <KEY_POWER>;
2f74b3db92bef4 Vinod Koul          2018-09-10   58  			};
2f74b3db92bef4 Vinod Koul          2018-09-10   59  
f7342c7d2902b7 Konrad Dybcio       2021-02-28   60  			pm8994_resin: resin {
f7342c7d2902b7 Konrad Dybcio       2021-02-28   61  				compatible = "qcom,pm8941-resin";
f7342c7d2902b7 Konrad Dybcio       2021-02-28   62  				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
f7342c7d2902b7 Konrad Dybcio       2021-02-28   63  				debounce = <15625>;
f7342c7d2902b7 Konrad Dybcio       2021-02-28   64  				bias-pull-up;
f7342c7d2902b7 Konrad Dybcio       2021-02-28   65  				status = "disabled";
f7342c7d2902b7 Konrad Dybcio       2021-02-28   66  			};
2f74b3db92bef4 Vinod Koul          2018-09-10   67  		};
2f74b3db92bef4 Vinod Koul          2018-09-10   68  
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   69  		pm8994_temp: temp-alarm@2400 {
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   70  			compatible = "qcom,spmi-temp-alarm";
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   71  			reg = <0x2400>;
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   72  			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   73  			io-channels = <&pm8994_vadc VADC_DIE_TEMP>;
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   74  			io-channel-names = "thermal";
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   75  			#thermal-sensor-cells = <0>;
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   76  		};
4778b2f1a3f0c9 Konrad Dybcio       2020-10-05   77  
183d4cafa711ac Konrad Dybcio       2020-10-05   78  		pm8994_vadc: adc@3100 {
183d4cafa711ac Konrad Dybcio       2020-10-05   79  			compatible = "qcom,spmi-vadc";
183d4cafa711ac Konrad Dybcio       2020-10-05   80  			reg = <0x3100>;
183d4cafa711ac Konrad Dybcio       2020-10-05   81  			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
183d4cafa711ac Konrad Dybcio       2020-10-05   82  			#address-cells = <1>;
183d4cafa711ac Konrad Dybcio       2020-10-05   83  			#size-cells = <0>;
183d4cafa711ac Konrad Dybcio       2020-10-05   84  			#io-channel-cells = <1>;
183d4cafa711ac Konrad Dybcio       2020-10-05   85  
183d4cafa711ac Konrad Dybcio       2020-10-05   86  			adc-chan@7 {
183d4cafa711ac Konrad Dybcio       2020-10-05   87  				reg = <VADC_VSYS>;
183d4cafa711ac Konrad Dybcio       2020-10-05   88  				qcom,pre-scaling = <1 3>;
183d4cafa711ac Konrad Dybcio       2020-10-05   89  				label = "vph_pwr";
183d4cafa711ac Konrad Dybcio       2020-10-05   90  			};
183d4cafa711ac Konrad Dybcio       2020-10-05   91  			adc-chan@8 {
183d4cafa711ac Konrad Dybcio       2020-10-05   92  				reg = <VADC_DIE_TEMP>;
183d4cafa711ac Konrad Dybcio       2020-10-05   93  				label = "die_temp";
183d4cafa711ac Konrad Dybcio       2020-10-05   94  			};
183d4cafa711ac Konrad Dybcio       2020-10-05   95  			adc-chan@9 {
183d4cafa711ac Konrad Dybcio       2020-10-05   96  				reg = <VADC_REF_625MV>;
183d4cafa711ac Konrad Dybcio       2020-10-05   97  				label = "ref_625mv";
183d4cafa711ac Konrad Dybcio       2020-10-05   98  			};
183d4cafa711ac Konrad Dybcio       2020-10-05   99  			adc-chan@a {
183d4cafa711ac Konrad Dybcio       2020-10-05  100  				reg = <VADC_REF_1250MV>;
183d4cafa711ac Konrad Dybcio       2020-10-05  101  				label = "ref_1250mv";
183d4cafa711ac Konrad Dybcio       2020-10-05  102  			};
183d4cafa711ac Konrad Dybcio       2020-10-05  103  			adc-chan@e {
183d4cafa711ac Konrad Dybcio       2020-10-05  104  				reg = <VADC_GND_REF>;
183d4cafa711ac Konrad Dybcio       2020-10-05  105  			};
183d4cafa711ac Konrad Dybcio       2020-10-05  106  			adc-chan@f {
183d4cafa711ac Konrad Dybcio       2020-10-05  107  				reg = <VADC_VDD_VADC>;
183d4cafa711ac Konrad Dybcio       2020-10-05  108  			};
183d4cafa711ac Konrad Dybcio       2020-10-05  109  		};
183d4cafa711ac Konrad Dybcio       2020-10-05  110  
c95243eeae587c Krzysztof Kozlowski 2022-09-08  111  		pm8994_gpios: gpio@c000 {
8939304880dee9 Konrad Dybcio       2020-10-05  112  			compatible = "qcom,pm8994-gpio", "qcom,spmi-gpio";
0804308fdd3cf5 Stephen Boyd        2015-11-17  113  			reg = <0xc000>;
0804308fdd3cf5 Stephen Boyd        2015-11-17  114  			gpio-controller;
8939304880dee9 Konrad Dybcio       2020-10-05  115  			gpio-ranges = <&pm8994_gpios 0 0 22>;
0804308fdd3cf5 Stephen Boyd        2015-11-17  116  			#gpio-cells = <2>;
8939304880dee9 Konrad Dybcio       2020-10-05  117  			interrupt-controller;
8939304880dee9 Konrad Dybcio       2020-10-05  118  			#interrupt-cells = <2>;
0804308fdd3cf5 Stephen Boyd        2015-11-17  119  		};
0804308fdd3cf5 Stephen Boyd        2015-11-17  120  
0804308fdd3cf5 Stephen Boyd        2015-11-17  121  		pm8994_mpps: mpps@a000 {
58d92e6e73250a Dmitry Baryshkov    2021-10-08  122  			compatible = "qcom,pm8994-mpp", "qcom,spmi-mpp";
0804308fdd3cf5 Stephen Boyd        2015-11-17  123  			reg = <0xa000>;
0804308fdd3cf5 Stephen Boyd        2015-11-17  124  			gpio-controller;
0804308fdd3cf5 Stephen Boyd        2015-11-17  125  			#gpio-cells = <2>;
58d92e6e73250a Dmitry Baryshkov    2021-10-08  126  			gpio-ranges = <&pm8994_mpps 0 0 8>;
8f48ceef5db929 Dmitry Baryshkov    2021-10-08  127  			interrupt-controller;
8f48ceef5db929 Dmitry Baryshkov    2021-10-08  128  			#interrupt-cells = <2>;
0804308fdd3cf5 Stephen Boyd        2015-11-17  129  		};
38757eb3ca3436 Stephen Boyd        2015-11-17  130  	};
38757eb3ca3436 Stephen Boyd        2015-11-17  131  
38757eb3ca3436 Stephen Boyd        2015-11-17 @132  	pmic@1 {

:::::: The code at line 132 was first introduced by commit
:::::: 38757eb3ca3436e503a1ab675aad4eb10a65ae0c arm64: dts: qcom: Add pm8994, pmi8994, pm8004 PMIC skeletons

:::::: TO: Stephen Boyd <sboyd@codeaurora.org>
:::::: CC: Andy Gross <andy.gross@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

