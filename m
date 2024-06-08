Return-Path: <linux-kernel+bounces-207048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A029011B9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA95B21B32
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378017994C;
	Sat,  8 Jun 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQXRtI0F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333D15A86A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717854047; cv=none; b=ZBMt8ebBkpgtwmtOlwvw1EfUoDi/VLV87dSpFAoc/Ey+KeuNKuWXSxnyZcOWjF8Xgvg8JYJShsHqoaiV4IfEqe8mrMKbBuQkuujZOG50o7Asq7/olRMJHQQ7uiCD7fsOyN+NC1ZN/MwRlEUwwwpx5ALOymA6rxd9ZeLQBE4WMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717854047; c=relaxed/simple;
	bh=nxlyu8p0CmGPfAk0LMwhtYf3/QdjlSKkf/Ec2s2SFc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rlUqh8vyJ9DEZleQK7bYGmFYaCR1LcfwWgRVEwaAQ+9A1ArirME6tDsWHSpO18V54y4HpnX8GFhvhLVgnkEQOPjCq9C+s1opSG7YgeVfxGzgIdTWyiEgnjLn7x3mxNhawpxQPabOQOjS2qGo5bzJx0RI8cKSmyXgu5yEocPMep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQXRtI0F; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717854043; x=1749390043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nxlyu8p0CmGPfAk0LMwhtYf3/QdjlSKkf/Ec2s2SFc0=;
  b=hQXRtI0FljlcUakKkNAZwJBKl2QJ+yx0Ysq3yR+9nmtk6GgDEYqhrvLO
   Q+fZVVq2si7JYwuTCBW8Yj8hcnCNkBEzAPAdRDGaFWEMc//HKlYRqP3GG
   mnphjZGNSDOTpSm3GspStgf41GeywgpmO9lV5xNwIpZEtXwWmgAL+SWJr
   kQdc9O+DykrAwls8y4W8VLtLh/YCeDJc1B3huah7bA5NSODT/3FUQn1vM
   v6SwDhb+oi3bItimuwU4nUcFTPxaZIX7M6M1vcVVX0O/Jumae2wYTq7I0
   hSnJjLrdcSl1esat2EftVngpDp+1v1G/8jlzG4KdDGu2RKLyTdS81E2Q8
   Q==;
X-CSE-ConnectionGUID: HLwrlq2+Rf6+HzQYGQIx2A==
X-CSE-MsgGUID: g7h0e2hzQDeHsSLlxbb3Aw==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="37098413"
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="37098413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 06:40:42 -0700
X-CSE-ConnectionGUID: Fd1YXlatTYidf8BU70XtuQ==
X-CSE-MsgGUID: 66N6BsC7S9miif6MtHCQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="38690193"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2024 06:40:41 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFwJD-0001e6-1C;
	Sat, 08 Jun 2024 13:40:39 +0000
Date: Sat, 8 Jun 2024 21:40:28 +0800
From: kernel test robot <lkp@intel.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>
Subject: arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:367.10-376.6: Warning
 (graph_child_address):
 /bus@f0000/i2c@20000000/usb-power-controller@3f/connector/ports: graph node
 has single child node 'port@0', #address-cells/#size-cells are not necessary
Message-ID: <202406082152.SN1xuMYL-lkp@intel.com>
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
commit: c1453d3c3e9baf538b5f978c9e7cc24e47cc877e arm64: dts: ti: k3-am62p: add the USB sub-system
date:   6 weeks ago
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406082152.SN1xuMYL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406082152.SN1xuMYL-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:367.10-376.6: Warning (graph_child_address): /bus@f0000/i2c@20000000/usb-power-controller@3f/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/ti/k3-am62p-main.dtsi:651.22-661.5: Warning (graph_child_address): /bus@f0000/usb@f900000/usb@31000000: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +367 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts

   350	
   351	&main_i2c0 {
   352		status = "okay";
   353		pinctrl-names = "default";
   354		pinctrl-0 = <&main_i2c0_pins_default>;
   355		clock-frequency = <400000>;
   356	
   357		typec_pd0: usb-power-controller@3f {
   358			compatible = "ti,tps6598x";
   359			reg = <0x3f>;
   360	
   361			connector {
   362				compatible = "usb-c-connector";
   363				label = "USB-C";
   364				self-powered;
   365				data-role = "dual";
   366				power-role = "sink";
 > 367				ports {
   368					#address-cells = <1>;
   369					#size-cells = <0>;
   370					port@0 {
   371						reg = <0>;
   372						usb_con_hs: endpoint {
   373							remote-endpoint = <&usb0_hs_ep>;
   374						};
   375					};
   376				};
   377			};
   378		};
   379	};
   380	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

