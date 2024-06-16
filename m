Return-Path: <linux-kernel+bounces-216119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DB909BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055871C213A1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 05:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B316C861;
	Sun, 16 Jun 2024 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dluTYDHl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8A23BF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718515942; cv=none; b=GTr7nEsphZUC00KdXG6B9Y0wN7bLbT1lqx5oYXFBdYzzNrL9fikecO2SHlBxcdshXEiXopNjfySBRzlquuKM+L1NfiObs50bVMu1FFhoxZtvS45lJzrwWQ/qj79aJlqIg937B/u9lX+573xpSJpvHHl0z046pS8E08WrFUC/aX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718515942; c=relaxed/simple;
	bh=G0Y5swl864YFgyj2L1V1JdxPFcK6UhVAgPd4Ra0JXyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FkerxvkOGeRhbJc+0qEG9HbXM3Ygp2cqGXW3sMgQVwmUPAGfDd5XAtS944s0648nBI3ldoiAigYPlEvMGMJQGT2bBzDcc2pKnIDkF9ugEFSgFup1UZAZOLH+9B+CwuYVC7tIXuaiQzHWJecYSuSQCHs7CKIL46LmHXLJXtoW3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dluTYDHl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718515939; x=1750051939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G0Y5swl864YFgyj2L1V1JdxPFcK6UhVAgPd4Ra0JXyw=;
  b=dluTYDHlvXs4t3+MNyLaucYYkCIArxjdCMI0hqTq1Sn27uaJbHGBashk
   dWfCdmtJv/7K1i91PbwHIlTieWhJnGyo680Cu7NepAvWrz1DyJdPLV864
   Q/0jQezZ60Gr9CugV5abeV0JQUQ75UnwwVKUc3JG5Uq4OKkYs0TYf25d8
   jGmYskxKLGDdc0WwRN+y66niRvMBAb21nxstuYg+NxV6TvR6wTLcU8j8s
   gEjg3Sh1P8CVfT0pkrW+1MhEdPpyMqpiU/YpPW/KUSNOm4VckWoOf8nhw
   8sAG2isDUqiH3rlLdc98GasR1ds7wStM4ttqLlbV2BwvEzxZm/Ox7pB5U
   g==;
X-CSE-ConnectionGUID: 4FJvqmaURj2ipvAyZU7aWA==
X-CSE-MsgGUID: 9+bntkOtS+KKpfJ94ZOEeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15338838"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15338838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 22:32:19 -0700
X-CSE-ConnectionGUID: 3VJ2GD20T3G8jwStFEVPWw==
X-CSE-MsgGUID: Rk9SqLrXS4mRw5RtzRXL6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="78366162"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Jun 2024 22:32:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIiUw-0000uE-2y;
	Sun, 16 Jun 2024 05:32:14 +0000
Date: Sun, 16 Jun 2024 13:31:42 +0800
From: kernel test robot <lkp@intel.com>
To: Li Yang <leoyang.li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>, Frank Li <Frank.Li@nxp.com>
Subject: arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb:
 /memory-controller@ffe1e000/nand@1,0: failed to match any schema with
 compatible: ['fsl,ifc-nand']
Message-ID: <202406161358.doiL0s2D-lkp@intel.com>
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
head:   a3e18a540541325a8c8848171f71e0d45ad30b2c
commit: acb354fe97e5aa6d9534b601ce18ef7866f25c4d powerpc: dts: fsl: rename ifc node name to be memory-controller
date:   6 weeks ago
config: powerpc-randconfig-051-20240612 (https://download.01.org/0day-ci/archive/20240616/202406161358.doiL0s2D-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406161358.doiL0s2D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406161358.doiL0s2D-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/powerpc/boot/dts/fsl/p1010rdb.dtsi:212.24-216.4: Warning (simple_bus_reg): /soc@ffe00000/ethernet@b2000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /: failed to match any schema with compatible: ['fsl,P1010RDB']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
>> arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /memory-controller@ffe1e000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /memory-controller@ffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000: failed to match any schema with compatible: ['fsl,p1010-immr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: i2c@3000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: i2c@3000: Unevaluated properties are not allowed ('cell-index', 'compatible', 'dfsrr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: eeprom@50: compatible: ['st,24c256', 'atmel,24c256'] is too long
   	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
--
   arch/powerpc/boot/dts/fsl/p1010rdb.dtsi:212.24-216.4: Warning (simple_bus_reg): /soc@fffe00000/ethernet@b2000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /: failed to match any schema with compatible: ['fsl,P1010RDB']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
>> arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /memory-controller@fffe1e000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /memory-controller@fffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000: failed to match any schema with compatible: ['fsl,p1010-immr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: i2c@3000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: i2c@3000: Unevaluated properties are not allowed ('cell-index', 'compatible', 'dfsrr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: eeprom@50: compatible: ['st,24c256', 'atmel,24c256'] is too long
   	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
--
   arch/powerpc/boot/dts/fsl/p1010rdb.dtsi:212.24-216.4: Warning (simple_bus_reg): /soc@ffe00000/ethernet@b2000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /: failed to match any schema with compatible: ['fsl,P1010RDB-PB']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
>> arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /memory-controller@ffe1e000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /memory-controller@ffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000: failed to match any schema with compatible: ['fsl,p1010-immr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: i2c@3000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: i2c@3000: Unevaluated properties are not allowed ('cell-index', 'compatible', 'dfsrr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: eeprom@50: compatible: ['st,24c256', 'atmel,24c256'] is too long
   	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
--
   arch/powerpc/boot/dts/fsl/p1010rdb.dtsi:212.24-216.4: Warning (simple_bus_reg): /soc@fffe00000/ethernet@b2000: missing or empty reg/ranges property
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /: memory: 'reg' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /: memory: False schema does not allow {'device_type': ['memory']}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /: failed to match any schema with compatible: ['fsl,P1010RDB-PB']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
>> arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /memory-controller@fffe1e000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /memory-controller@fffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000: failed to match any schema with compatible: ['fsl,p1010-immr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: i2c@3000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['fsl-i2c'] is too short
   	'fsl-i2c' is not one of ['mpc5200-i2c', 'fsl,mpc5200-i2c', 'fsl,mpc5121-i2c', 'fsl,mpc8313-i2c', 'fsl,mpc8543-i2c', 'fsl,mpc8544-i2c']
   	'fsl,mpc5200b-i2c' was expected
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: i2c@3000: Unevaluated properties are not allowed ('cell-index', 'compatible', 'dfsrr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mpc.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: eeprom@50: compatible: ['st,24c256', 'atmel,24c256'] is too long
   	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

