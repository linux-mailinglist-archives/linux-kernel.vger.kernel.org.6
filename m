Return-Path: <linux-kernel+bounces-212517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D290629F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126671F22932
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2D1304A2;
	Thu, 13 Jun 2024 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5KN/1yK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB2748E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249072; cv=none; b=ul0HFclfNhzyhYgkF3Vp5d3dVLjaFJjxox8FFjHcpsKJmLKnDelB49lvwzBp7z7t3o5VNoamyEksxcue/Sb8MPNroy5lDkmQLKkXHIaLWjm+PyFT/INpIzeUeMZIToXngXc8VUfXZSfunUrzylagS8Vuv494glJ77sM8PJrxmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249072; c=relaxed/simple;
	bh=NWW5sDrZnJkimBdoY3EiJs+K2u46ec4VESQWZog/UVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=khDB724FjeAgx8S5T/c8i3ionFz88++M2mFcf8Cl2R1bsSCesSQysF1fNymUfWzbrNkpAQbdAuE7V5ObsjCVXNko1D/ifghVDUhBPfGhTB8AkIsOH3G/gX8nOZCTqH2Kpm1+mrYibFwEVzD4iSASpHgCKYQL9mCrnNdNNxf7WYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5KN/1yK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249071; x=1749785071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NWW5sDrZnJkimBdoY3EiJs+K2u46ec4VESQWZog/UVU=;
  b=C5KN/1yK6zD+DjK7JDz6/8piifa2sX4XhC9QK+q/ICV64gUwF0q6L19w
   PH8BCcOsuBZQE9/BfIqn75/grpgHdc1rie4kBr3WXSS2kAwctyA7pPGQg
   r/VRZcJaU7izGGpUaLTUwPiRpmjJxADSHMYKoan/7dw+EUSoK+K+eOwcN
   hQYbmH34EdJy3zd1ie+PtoY9y8VSkAObkZ5bXzH2gd/by7p3jIMlwSY0y
   gpn5+uWAQSwoagHzmMdgohEU5elywcAlXTFo9eUFwxyy6xzKIY1PTakB5
   ulcLgXyDXb8OB0osnh4RthPEETPDYGHjpNWTAGhDCuSMlKxKHrjXPhMdu
   A==;
X-CSE-ConnectionGUID: BvJgx72MTc2yPJ6UwY3gmA==
X-CSE-MsgGUID: 5Bqz+/zYSei8MASewG+YZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32587331"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32587331"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:24:31 -0700
X-CSE-ConnectionGUID: kOVFoffJSsyug0J2cjRd+Q==
X-CSE-MsgGUID: mTD2WE24QIOqjDECB3nZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39955325"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Jun 2024 20:24:28 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHb4c-0002Ak-2m;
	Thu, 13 Jun 2024 03:24:26 +0000
Date: Thu, 13 Jun 2024 11:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: Li Yang <leoyang.li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>, Frank Li <Frank.Li@nxp.com>
Subject: arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb:
 /memory-controller@ff71e000/nand@0,0: failed to match any schema with
 compatible: ['fsl,ifc-nand']
Message-ID: <202406131143.Ui6D1acK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Li,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ccbdf43d5e758f8493a95252073cf9078a5fea5
commit: acb354fe97e5aa6d9534b601ce18ef7866f25c4d powerpc: dts: fsl: rename ifc node name to be memory-controller
date:   5 weeks ago
config: powerpc-randconfig-051-20240612 (https://download.01.org/0day-ci/archive/20240613/202406131143.Ui6D1acK-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240613/202406131143.Ui6D1acK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406131143.Ui6D1acK-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi:92.23-94.5: Warning (simple_bus_reg): /soc@ff700000/gpio-controller@f000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi:47.13-54.3: Warning (simple_bus_reg): /soc@ff700000/timer@41100: simple-bus unit address format error, expected "41400"
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /: failed to match any schema with compatible: ['fsl,bsc9131rdb']
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /cpus/PowerPC,BSC9131@0: failed to match any schema with compatible: ['fsl,e500v2']
>> arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /memory-controller@ff71e000/nand@0,0: failed to match any schema with compatible: ['fsl,ifc-nand']
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /soc@ff700000: failed to match any schema with compatible: ['fsl,bsc9131-immr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: i2c@3100: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /soc@ff700000/spi@7000: failed to match any schema with compatible: ['fsl,mpc8536-espi']
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /soc@ff700000/usb@22000: failed to match any schema with compatible: ['fsl-usb2-dr', 'fsl-usb2-dr-v2.2']
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /soc@ff700000/usb@22000: failed to match any schema with compatible: ['fsl-usb2-dr', 'fsl-usb2-dr-v2.2']
   arch/powerpc/boot/dts/fsl/bsc9131rdb.dtb: /soc@ff700000/mdio@24000: failed to match any schema with compatible: ['fsl,etsec2-mdio']
--
   arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi:121.23-123.5: Warning (simple_bus_reg): /soc@ff700000/gpio-controller@f000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /: failed to match any schema with compatible: ['fsl,bsc9132qds']
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
>> arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /memory-controller@ff71e000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /soc@ff700000: failed to match any schema with compatible: ['fsl,bsc9132-immr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /soc@ff700000/spi@7000: failed to match any schema with compatible: ['fsl,mpc8536-espi']
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: i2c@3000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: i2c@3000: Unevaluated properties are not allowed ('cell-index', 'compatible', 'dfsrr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/bsc9132qds.dtb: /soc@ff700000/i2c@3000/fpga@66: failed to match any schema with compatible: ['fsl,bsc9132qds-fpga', 'fsl,fpga-qixis-i2c']
--
   arch/powerpc/boot/dts/fsl/c293pcie.dts:219.24-222.4: Warning (simple_bus_reg): /soc@fffe00000/ethernet@b1000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: /: failed to match any schema with compatible: ['fsl,C293PCIE']
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
>> arch/powerpc/boot/dts/fsl/c293pcie.dtb: /memory-controller@fffe1e000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/c293pcie.dtb: /memory-controller@fffe1e000/cpld@2,0: failed to match any schema with compatible: ['fsl,c293pcie-cpld']
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: i2c@3000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: i2c@3000: Unevaluated properties are not allowed ('cell-index', 'compatible', 'dfsrr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: /soc@fffe00000/spi@7000: failed to match any schema with compatible: ['fsl,mpc8536-espi']
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: /soc@fffe00000/mdio@24000: failed to match any schema with compatible: ['fsl,etsec2-mdio']
   arch/powerpc/boot/dts/fsl/c293pcie.dtb: /soc@fffe00000/ethernet@b0000: failed to match any schema with compatible: ['fsl,etsec2']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

