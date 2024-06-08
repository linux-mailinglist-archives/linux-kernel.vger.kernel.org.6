Return-Path: <linux-kernel+bounces-206869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF290900F17
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 03:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894D62840DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B7D8480;
	Sat,  8 Jun 2024 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4nFrh/p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438534C66
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717810201; cv=none; b=QKUChDK7FC1tGV65fu/zZJe7I2nWZ7m+j4Y+ouBrpW1/lij66PpU/ZgBqGWbvLShOGXClhk2l8Vnb/TBbZMV8zISBjsud3dYacOYxT5YnTQOlXIRDdwO9ESKBB7uv8J6S0TJaZY505gonIzimHtbAwCyHLVxsXXnKTtkiORjMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717810201; c=relaxed/simple;
	bh=MwtHWlRVfwYVyKC5etWEIGPxXOT2a8aQXZeec8eJvhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YwbyGECKh2o2/MmfpCo6cMk8DyhCkf30T0Vn7dOpcMQaSJRvlOPkP03+sfn7dBi0Nkcrozh0QEI9+vNmjkQ84yXrmAXpnQH/Hv+rL0POD5ifKzHqjxPQHjsMMTaq3fYdS/gwkW1NvBGxDbIVjk86cc6puUv9s03Zef0/20fY/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4nFrh/p; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717810198; x=1749346198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MwtHWlRVfwYVyKC5etWEIGPxXOT2a8aQXZeec8eJvhQ=;
  b=G4nFrh/p6Nln5Nb0b0LjyzAwdNp2YbCZSTMjbE6DtdUaFeOzkHZLL96n
   jJmMYA5wkwIzb9fPnr2Zyc0E9UhRRt8Ry8a06mkv4Vd8zKrYoQGHdOPWb
   zjR9FlDtNCfMMwJxoZhmYh4f5HGENg4u343cHHlpIg4YKP8wYcXz15Yb6
   pvOqs1WtliJseO8+e24D6NzzOqIz1sqAcJzdINv5cEIMPAzL80u3zK90x
   W00sqUtoje+09AsJaqXYO8W9In6Gcr+uvBhUZ0DIuNAsZBYlZcQl5J4yr
   8VMXcCkbfTU/P1zk7iFiDdDLvUBJi7DqCU003owW3EAd9z5+rSx0uAqjg
   A==;
X-CSE-ConnectionGUID: +VX/Cu3SRU6H5er5EvKzDw==
X-CSE-MsgGUID: oPH+mVBLTgCn4AHXOjlC/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14705623"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="14705623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 18:29:57 -0700
X-CSE-ConnectionGUID: GpsQ06qwReqXsErMwBwIQQ==
X-CSE-MsgGUID: 6NQnWDHeTVy1iRdBY/LwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="38595389"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2024 18:29:56 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFku2-0000o2-1i;
	Sat, 08 Jun 2024 01:29:54 +0000
Date: Sat, 8 Jun 2024 09:29:25 +0800
From: kernel test robot <lkp@intel.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:255.10-265.6: Warning
 (graph_child_address): /bus@f0000/i2c@20000000/tps6598x@3f/connector/ports:
 graph node has single child node 'port@0', #address-cells/#size-cells are
 not necessary
Message-ID: <202406080936.ImME0HYU-lkp@intel.com>
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
commit: 2c213d19515caf880e6c8266fbeda4145894c10e arm64: dts: ti: k3-am625: Enable Type-C port for USB0
date:   12 months ago
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406080936.ImME0HYU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406080936.ImME0HYU-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:255.10-265.6: Warning (graph_child_address): /bus@f0000/i2c@20000000/tps6598x@3f/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/ti/k3-am62-main.dtsi:570.22-578.5: Warning (graph_child_address): /bus@f0000/dwc3-usb@f900000/usb@31000000: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>>   also defined at arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:346.7-357.3

vim +255 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi

   238	
   239	&main_i2c0 {
   240		status = "okay";
   241		pinctrl-names = "default";
   242		pinctrl-0 = <&main_i2c0_pins_default>;
   243		clock-frequency = <400000>;
   244	
   245		typec_pd0: tps6598x@3f {
   246			compatible = "ti,tps6598x";
   247			reg = <0x3f>;
   248	
   249			connector {
   250				compatible = "usb-c-connector";
   251				label = "USB-C";
   252				self-powered;
   253				data-role = "dual";
   254				power-role = "sink";
 > 255				ports {
   256					#address-cells = <1>;
   257					#size-cells = <0>;
   258	
   259					port@0 {
   260						reg = <0>;
   261						usb_con_hs: endpoint {
   262							remote-endpoint = <&usb0_hs_ep>;
   263						};
   264					};
   265				};
   266			};
   267		};
   268	};
   269	
   270	&main_i2c1 {
   271		status = "okay";
   272		pinctrl-names = "default";
   273		pinctrl-0 = <&main_i2c1_pins_default>;
   274		clock-frequency = <400000>;
   275	
   276		tlv320aic3106: audio-codec@1b {
   277			#sound-dai-cells = <0>;
   278			compatible = "ti,tlv320aic3106";
   279			reg = <0x1b>;
   280			ai3x-micbias-vg = <1>;	/* 2.0V */
   281	
   282			/* Regulators */
   283			AVDD-supply = <&vcc_3v3_sys>;
   284			IOVDD-supply = <&vcc_3v3_sys>;
   285			DRVDD-supply = <&vcc_3v3_sys>;
   286		};
   287	};
   288	
   289	&sdhci0 {
   290		status = "okay";
   291		pinctrl-names = "default";
   292		pinctrl-0 = <&main_mmc0_pins_default>;
   293		ti,driver-strength-ohm = <50>;
   294		disable-wp;
   295	};
   296	
   297	&sdhci1 {
   298		/* SD/MMC */
   299		status = "okay";
   300		pinctrl-names = "default";
   301		pinctrl-0 = <&main_mmc1_pins_default>;
   302		ti,driver-strength-ohm = <50>;
   303		disable-wp;
   304	};
   305	
   306	&cpsw3g {
   307		pinctrl-names = "default";
   308		pinctrl-0 = <&main_rgmii1_pins_default>;
   309	};
   310	
   311	&cpsw_port1 {
   312		phy-mode = "rgmii-rxid";
   313		phy-handle = <&cpsw3g_phy0>;
   314	};
   315	
   316	&cpsw3g_mdio {
   317		status = "okay";
   318		pinctrl-names = "default";
   319		pinctrl-0 = <&main_mdio1_pins_default>;
   320	
   321		cpsw3g_phy0: ethernet-phy@0 {
   322			reg = <0>;
   323			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
   324			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
   325			ti,min-output-impedance;
   326		};
   327	};
   328	
   329	&mailbox0_cluster0 {
   330		mbox_m4_0: mbox-m4-0 {
   331			ti,mbox-rx = <0 0 0>;
   332			ti,mbox-tx = <1 0 0>;
   333		};
   334	};
   335	
   336	&usbss0 {
   337		status = "okay";
   338		ti,vbus-divider;
   339	};
   340	
   341	&usbss1 {
   342		status = "okay";
   343		ti,vbus-divider;
   344	};
   345	
 > 346	&usb0 {
   347		#address-cells = <1>;
   348		#size-cells = <0>;
   349		usb-role-switch;
   350	
   351		port@0 {
   352			reg = <0>;
   353			usb0_hs_ep: endpoint {
   354			    remote-endpoint = <&usb_con_hs>;
   355		       };
   356		};
   357	};
   358	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

