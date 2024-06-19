Return-Path: <linux-kernel+bounces-221769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE190F856
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A981C24625
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37315AD9A;
	Wed, 19 Jun 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asXmr0/A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB415AAD5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831626; cv=none; b=c4lR7TiXIzfYzHbmbSkCuyKgHopqlAqttNwqBJU83EZPNAvntc/a7NkcBW/SOX9T25dBY4pSWGXtD+Hu9IdsCVBhY/vT37rTBEfrQKUy8aLBE3TY75X5Jkn5VpgETbNGpsJM4TNeN4VMNpikgKUYqJW8dQ7X9/ZjuFj898oUCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831626; c=relaxed/simple;
	bh=IgmpTFeB47Ft/oBLT/pU6bWANYtSsllcXWa2+aBIjTY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kuC/Nb32I0gQO5kpu2vq2ugMLoLHDlTcHM6D1aw2ugdE08uuCf/fDEBxXgWZJPuuB1NMW1d0qQEybr4F5QSYGZGVh1TBK0Q7yIczdq8PmR2eOA+H74qbqqFK49GeEoNcTGksVNBCkFIUGQr6PeF6BXohvkuo3HtjBttYmXzTh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asXmr0/A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718831625; x=1750367625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IgmpTFeB47Ft/oBLT/pU6bWANYtSsllcXWa2+aBIjTY=;
  b=asXmr0/Abnh/DXV8NdJS78hkATwLIrQ/7wQ7GMBH6RT9+la8JqOq3PlH
   Wv4/ndP+/cz+nxgkaJLPpjrf3QdpGzUI9e54a3h09sZazjQMDol9oqAsM
   +flSkERuPN3K8kcWPk0W0ZpG9n5qhJMAuPJYI9iFt+XQvHX3cGn046XJj
   +33ZYjX2EOMVytVXdG70fNB2PrAWvXsH/wPyoJE0w/GZ3xM1o1yAXQWmX
   O/ymAuTefpTuvl7Ak5vQxEreB3Q055HELnG8awRfuWJ23mzEIoTX7ueXe
   94qIsGxFgYmKrxL+96XaeEnzMvA6EhiYXfx/Fo9j7pnqdGpp7GfeE+Z1I
   A==;
X-CSE-ConnectionGUID: Q59adpEPT1CIFk1z84vJMg==
X-CSE-MsgGUID: dYvP+g+VRXyq8apH2r5Bmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15617220"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15617220"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 14:13:45 -0700
X-CSE-ConnectionGUID: tRySNNJCTwuWWfAB/z+WOQ==
X-CSE-MsgGUID: gT8rpP7gS5yjtuQPH46ppg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42693817"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Jun 2024 14:13:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK2cd-00070A-32;
	Wed, 19 Jun 2024 21:13:39 +0000
Date: Thu, 20 Jun 2024 05:12:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jianhua Lu <lujianhua000@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi:647.9-658.5:
 Warning (graph_child_address):
 /soc@0/spmi@c440000/pmic@2/typec@1500/connector/ports: graph node has single
 child node 'port@0', #address-cells/#size-cells are not necessary
Message-ID: <202406200530.bulGai7K-lkp@intel.com>
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
commit: 69652787279d64b0b0cc350fdfb34c503e40653c arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node and enable usb otg
date:   7 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240620/202406200530.bulGai7K-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240620/202406200530.bulGai7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200530.bulGai7K-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/sm8250.dtsi:3466.14-3474.6: Warning (avoid_unnecessary_addr_size): /soc@0/funnel@6c2d000/out-ports: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/sm8250.dtsi:4874.27-4926.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/pm8150b.dtsi:165.9-180.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@c440000/pmic@3: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/sm8250.dtsi:3118.14-3128.6: Warning (graph_child_address): /soc@0/tpda@6004000/out-ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/qcom/sm8250.dtsi:3165.13-3175.6: Warning (graph_child_address): /soc@0/funnel@6005000/in-ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/qcom/sm8250.dtsi:3378.13-3388.6: Warning (graph_child_address): /soc@0/etf@6b05000/in-ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/qcom/sm8250.dtsi:3733.13-3743.6: Warning (graph_child_address): /soc@0/funnel@7810000/in-ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi:647.9-658.5: Warning (graph_child_address): /soc@0/spmi@c440000/pmic@2/typec@1500/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +647 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi

   630	
   631	&pm8150b_typec {
   632		vdd-pdphy-supply = <&vreg_l2a_3p1>;
   633		status = "okay";
   634	
   635		connector {
   636			compatible = "usb-c-connector";
   637	
   638			power-role = "source";
   639			data-role = "dual";
   640			self-powered;
   641	
   642			source-pdos = <PDO_FIXED(5000, 3000,
   643						 PDO_FIXED_DUAL_ROLE |
   644						 PDO_FIXED_USB_COMM |
   645						 PDO_FIXED_DATA_SWAP)>;
   646	
 > 647			ports {
   648				#address-cells = <1>;
   649				#size-cells = <0>;
   650	
   651				port@0 {
   652					reg = <0>;
   653	
   654					pm8150b_role_switch_in: endpoint {
   655						remote-endpoint = <&usb_1_role_switch_out>;
   656					};
   657				};
   658			};
   659		};
   660	};
   661	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

