Return-Path: <linux-kernel+bounces-273096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CED946484
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0921C212A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4253E23;
	Fri,  2 Aug 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edNpT5Gu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116601ABEA7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631282; cv=none; b=NvqxrROF/qZFi1ImuqVCVtOaFlQYcF9dcQeEGy8Lh+FU0/kHCZKRN5pAMUkWaaguLLauvXT6z9bv28uxOcPIBZotysaYm1VALxjPQ3H1k+12ceT97jBwpXNlYTVINqcshZFiIvpf6yl0zdInNtFxN+QKY7h3jeqlIZ+dANDbA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631282; c=relaxed/simple;
	bh=Gp5rktZR+m6uPSLZdtruhrvehhm1yazS9i1LnLzK2Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fcr3ATKZhYmjVfIfk526dQMQimiKgIbJpnyj9m/ZIL6SB4LKbjCRwjaSeAStWOxQApsu7PY9YQ6tg1EE8o/V7LlEM7yisAoU0Ja/8eoRwh6J3NMPvGLJ2aMBdzgf6mnDiwVP1uiSrUultaZJw2KiGvYfPPbSFPyWY1XMCtEh6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edNpT5Gu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722631279; x=1754167279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gp5rktZR+m6uPSLZdtruhrvehhm1yazS9i1LnLzK2Nw=;
  b=edNpT5GujRshHN8EUa+SqUnyHK2oPmqdb4+DLjcItuu9j2jVaqPF5WR5
   3pSpyimyYuZbCOpl4LccU9g6W9AUxZiOt0CR5h1sWj61gPi8wgOCtRz/Q
   NGWwfu2S2EhiKTD9SLs/xGgypoE2SgQub6+YK+vtixDDG+oDRidvmVe/q
   ogUsyOEUgfPMEswE+HRxN/aEm4C5kwXSQqqZqEvLrDiyDTo6o7hnbJxs0
   gElwtMAn8eo0Rkdp0pMcwA7NI4ZP2x7v26Fnif7E8pbeHVgFhHt8okGVp
   aoe3P1Z5KRACfFIpP97+mbh7eZUJvWXPu9O95VPoGVq4IvAsvBSxfieCd
   w==;
X-CSE-ConnectionGUID: oK6TwHvqSpqpVNk12i2W+A==
X-CSE-MsgGUID: e0gQRTg0TC2CLOWe2vSHcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="43183366"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="43183366"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 13:41:18 -0700
X-CSE-ConnectionGUID: WAdV7lokR3+l1LvjnKR9SA==
X-CSE-MsgGUID: yImfAjxkTGaaFnyKhPVDMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55597097"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 13:41:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZz5O-000xPM-2A;
	Fri, 02 Aug 2024 20:41:14 +0000
Date: Sat, 3 Aug 2024 04:40:44 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /: 'model'
 is a required property
Message-ID: <202408030430.GamdKltW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c4246294c9841c50805cec0627030c083e019c6
commit: d89a415ff8d5e0aad4963f2d8ebb0f9e8110b7fa MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a
date:   7 weeks ago
config: mips-randconfig-051-20240803 (https://download.01.org/0day-ci/archive/20240803/202408030430.GamdKltW-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
dtschema version: 2024.6.dev8+gf13c181
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030430.GamdKltW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030430.GamdKltW-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /: memory@200000: 'compatible' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /: 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /: failed to match any schema with compatible: ['loongson,loongson64-2core-2k1000']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: cpu@0: '#clock-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mips/cpus.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /memory@200000: failed to match any schema with compatible: ['memory']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,0:interrupts:0: [12, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,0:interrupts: [[12, 8], [13, 8]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,1:interrupts:0: [14, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,1:interrupts: [[14, 8], [15, 8]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ehci@4,1:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ehci@4,1:interrupts:0: [18, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ohci@4,2:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ohci@4,2:interrupts:0: [19, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: sata@8,0:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: sata@8,0:interrupts:0: [19, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@9,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@9,0:interrupts:0: [0, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@a,0:interrupts:0: [1, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@b,0:interrupts:0: [2, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@c,0:interrupts:0: [3, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@d,0:interrupts:0: [4, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@e,0:interrupts:0:0: 5 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@e,0:interrupts:0: [5, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'device_type', 'ehci@4,1', 'gmac@3,0', 'gmac@3,1', 'ohci@4,2', 'pcie@9,0', 'pcie@a,0', 'pcie@b,0', 'pcie@c,0', 'pcie@d,0', 'pcie@e,0', 'sata@8,0' were unexpected)
   	from schema $id: http://devicetree.org/schemas/pci/loongson.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,0:interrupts:0:0: 12 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,0:interrupts:0: [12, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,0:interrupts: [[12, 8], [13, 8]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,1:interrupts:0:0: 14 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,1:interrupts:0: [14, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: gmac@3,1:interrupts: [[14, 8], [15, 8]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ehci@4,1:interrupts:0:0: 18 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ehci@4,1:interrupts:0: [18, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ohci@4,2:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: ohci@4,2:interrupts:0: [19, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: sata@8,0:interrupts:0:0: 19 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: sata@8,0:interrupts:0: [19, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@9,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@9,0:interrupts:0: [0, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@a,0:interrupts:0: [1, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@b,0:interrupts:0: [2, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@c,0:interrupts:0: [3, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@d,0:interrupts:0: [4, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@e,0:interrupts:0:0: 5 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: pci@1a000000: pcie@e,0:interrupts:0: [5, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,0: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: gmac@3,1: compatible:4: 'loongson, pci-gmac' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
   	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/gmac@3,1: failed to match any schema with compatible: ['pci0014,7a03.0', 'pci0014,7a03', 'pciclass0c0320', 'pciclass0c03', 'loongson, pci-gmac']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ehci@4,1: failed to match any schema with compatible: ['pci0014,7a14.0', 'pci0014,7a14', 'pciclass0c0320', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ohci@4,2: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ohci@4,2: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/ohci@4,2: failed to match any schema with compatible: ['pci0014,7a24.0', 'pci0014,7a24', 'pciclass0c0310', 'pciclass0c03']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/sata@8,0: failed to match any schema with compatible: ['pci0014,7a08.0', 'pci0014,7a08', 'pciclass010601', 'pciclass0106']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@9,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@a,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@b,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@c,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@d,0: failed to match any schema with compatible: ['pci0014,7a19.0', 'pci0014,7a19', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']
>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: /bus@10000000/pci@1a000000/pcie@e,0: failed to match any schema with compatible: ['pci0014,7a09.0', 'pci0014,7a09', 'pciclass060400', 'pciclass0604']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

