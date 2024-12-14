Return-Path: <linux-kernel+bounces-446198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD19F20F5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C431887429
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187F1AF0C6;
	Sat, 14 Dec 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCtJFiQM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8281A8F6A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734212008; cv=none; b=EZPwD8VXGY0ZAeB5Bwy+D4TMJR5ag0YqNFOp/cWFasNCFD/mkUDtOqY8JffPQqiPtGMwZ4Uz9XJzCjrpZSyyrI5VWMAM8KuxKcvOqqrNwejmL45IQH576tu5H5X1Qw+lJjDoKUtQZm7H3Z3ePcHphsZcnzd8cdCWL3oVAwv+FNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734212008; c=relaxed/simple;
	bh=SMplJydxt5CTlDxGt7lGtY/1bivuKkqrBUWQl9oPVGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rRHwUj8VD8j5Hg9b1oplNqMzdcF8PHRIT6as4h8Ey3+/S/jrE8cV+poiN+Ziw5IWmr/jkOzf9FMIJgq5uqFfSt5FkNwZqTS4PSKjpBKwFXGEyLipg2iB/OySJIAAmnsQPOZI8h65ofGjHeopFOx1poMh2DRdxl3GBCrxeMeidvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCtJFiQM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734212006; x=1765748006;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SMplJydxt5CTlDxGt7lGtY/1bivuKkqrBUWQl9oPVGk=;
  b=kCtJFiQMhpcKMn4Be+muoYjzBKxqNMYBQxO33ghiM4Ev1LZOrICc7i9t
   7wiAJQgFvo/ocAF0mOB28gOeqqD7CiZv8dh0mF6D1JgyHC7LxTT1gwuyZ
   DWrqssFDBme8E2JrLBEcALycvKKwCQcu+ZxlIQf31sVlNDT5gSFhlqrFo
   oiHRB6cYmxX9HBBm8FGD5W5aYvYtEPW1DbuqGUlUqgmuvposLtg93Terb
   +iXvPXaUbF9G2yOLwtMOCsCtN+q1LGYic7yH8eHyvYPMwXMSn/rswoDpV
   rh/UwQv2PkBfYGkIxIIprR4P3qx3GNaSfBIvHLXELFgHpKJ3C0u8nX2qG
   Q==;
X-CSE-ConnectionGUID: ST/CAKvjRBWKMOKyhzzJ8Q==
X-CSE-MsgGUID: Y4aGiqjeSM2BnvTXqpiyCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34369177"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="34369177"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 13:33:26 -0800
X-CSE-ConnectionGUID: CQkkYIA2QPG2M5hiFftyfA==
X-CSE-MsgGUID: DodEdgMwQ963hPNTYI8Fnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="96595197"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Dec 2024 13:33:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMZlK-000DFW-19;
	Sat, 14 Dec 2024 21:33:22 +0000
Date: Sun, 15 Dec 2024 05:33:12 +0800
From: kernel test robot <lkp@intel.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000:
 'clocks' is a required property
Message-ID: <202412150534.xaaO8dzc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a0e3919a2df29b373b19a8fbd6e4c4c38fc10d87
commit: 60dbdc6e08d6fe66380598ef8bb857a4474e30d9 dt-bindings: net: emaclite: Add clock support
date:   9 weeks ago
config: mips-randconfig-052-20241215 (https://download.01.org/0day-ci/archive/20241215/202412150534.xaaO8dzc-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 2dc22615fd46ab2566d0f26d5ba234ab12dc4bf8)
dtschema version: 2024.12.dev3+g93ee800
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412150534.xaaO8dzc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412150534.xaaO8dzc-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: /: failed to match any schema with compatible: ['digilent,nexys4ddr']
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: /interrupt-controller@10200000: failed to match any schema with compatible: ['xlnx,xps-intc-1.00.a']
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: gpio@10600000: #gpio-cells: 2 was expected
   	from schema $id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: gpio@10600000: Unevaluated properties are not allowed ('#gpio-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000: xlnx,tx-ping-pong: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000: xlnx,rx-ping-pong: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
>> arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000: 'clocks' is a required property
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: ethernet@10e00000: 'device_type', 'mdio', 'xlnx,duplex', 'xlnx,include-global-buffers', 'xlnx,include-internal-loopback', 'xlnx,include-mdio', 'xlnx,instance', 'xlnx,s-axi-id-width', 'xlnx,use-internal' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/xlnx,emaclite.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: i2c@10a00000: Unevaluated properties are not allowed ('xlnx,clk-freq', 'xlnx,family', 'xlnx,gpo-width', 'xlnx,iic-freq', 'xlnx,scl-inertial-delay', 'xlnx,sda-inertial-delay', 'xlnx,ten-bit-adr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/xlnx,xps-iic-2.00.a.yaml#
   arch/mips/boot/dts/xilfpga/nexys4ddr.dtb: /i2c@10a00000/ad7420@4b: failed to match any schema with compatible: ['adi,adt7420']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

