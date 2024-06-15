Return-Path: <linux-kernel+bounces-216004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A99099D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E921F2205F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ECE60DCF;
	Sat, 15 Jun 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrXcYo3D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98304964C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482726; cv=none; b=rAg9kgiTu4q5k+BnauvA0agwua4M2sQrmTzOKjlCaKls0WjFTSqkHNB6cHQsIuLMcyv5jizLyQ10doFMBqXS4GNXQ+BDPULKKO8n8uX13pthiKsBKiRVNS/tBdA2Cpu0CPtU8TSzmNetAzXXsqDWzco41SJ9XjFmYDRzcGkEGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482726; c=relaxed/simple;
	bh=FQ/XrVa3DPMQGFX8+ROoCCXG6yyQmCwUOVExN/RNseE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RCb7I3RajWSxiaarwmRkH2cEmVBUfQk0HxOR47LE5dZR8ohpJNIz2vY0FxRxn6sOTrnbnqJCLMGa5C8O0frU1RXY3g4zuJxHd0HqqaAvCq0m4nt7SXClXK0mcv5oA5qrHAyybriSAuweEUBFO5Q1gTi0jketNdbusS705wU+B40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrXcYo3D; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718482721; x=1750018721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FQ/XrVa3DPMQGFX8+ROoCCXG6yyQmCwUOVExN/RNseE=;
  b=MrXcYo3DCdr78b+5vMYJ5aSO+58Nd//pFri796OJICFqqa0W/3vwAOrV
   hp6h+i3A4x7VInY1l0F1sQK5YZ+kLsZFHLklZxpzm921TFRZnRp81Wfcm
   QyL0M5BCG8UTBV/takgps+eN9tMjaceo/JEI7heiLFT9qjDhR44rrXOGI
   /cugRlYCETZLnlfF4/vi01wJB7RfxMoP0GrxPLdHqDzqCqASQHlznpt0Y
   2SesfZtrVPzYBd64d75w9fp+K4MR1PNHc1jEgwObCN9BeY/UkpDOTHE8m
   qfKpixkdOg2REGk+VKFDzeAjp6fI/cCX+rEWCS1VntVJEVdjGyDZRNlHK
   w==;
X-CSE-ConnectionGUID: Zp5AaVNeQWuQN/bAxVeEcw==
X-CSE-MsgGUID: M8/oqdPmTxWn/z1lph3oMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15490230"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15490230"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 13:18:40 -0700
X-CSE-ConnectionGUID: t0ijd78rQ3miGIrz9M3dJQ==
X-CSE-MsgGUID: 4ylerj1eT4msX0jCgCgFyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="45360973"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Jun 2024 13:18:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIZr9-0000T8-28;
	Sat, 15 Jun 2024 20:18:35 +0000
Date: Sun, 16 Jun 2024 04:18:21 +0800
From: kernel test robot <lkp@intel.com>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Zhao Chenhui <chenhui.zhao@freescale.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/power@e0070:
 failed to match any schema with compatible: ['fsl,mpc8536-pmc',
 'fsl,mpc8548-pmc']
Message-ID: <202406160448.w4KvYUWv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44ef20baed8edcb1799bec1e7ad2debbc93eedd8
commit: b12ba096b89084d1e2d6ebdb71b852eeebef95d3 powerpc: dts: add power management nodes to FSL chips
date:   6 weeks ago
config: powerpc-randconfig-051-20240612 (https://download.01.org/0day-ci/archive/20240616/202406160448.w4KvYUWv-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406160448.w4KvYUWv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406160448.w4KvYUWv-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8536-guts']
>> arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /pci@ffe08000: failed to match any schema with compatible: ['fsl,mpc8540-pci']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 25 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: pcie@ffe09000: pcie@0:interrupts:0: [25, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 26 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8536ds.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [26, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8536-guts']
>> arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /pci@fffe08000: failed to match any schema with compatible: ['fsl,mpc8540-pci']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 25 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [25, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 26 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [26, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/mdio@24520: failed to match any schema with compatible: ['fsl,gianfar-mdio']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/ethernet@26000: failed to match any schema with compatible: ['gianfar']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/mdio@26520: failed to match any schema with compatible: ['fsl,gianfar-tbi']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/crypto@30000: failed to match any schema with compatible: ['fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/crypto@30000: failed to match any schema with compatible: ['fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8544-guts']
>> arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /soc8544@e0000000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /pci@e0008000: failed to match any schema with compatible: ['fsl,mpc8540-pci']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: pcie@e0009000: pcie@0:interrupts:0:0: 25 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: pcie@e0009000: pcie@0:interrupts:0: [25, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: /pcie@e0009000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: pcie@e000a000: pcie@0:interrupts:0:0: 26 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: pcie@e000a000: pcie@0:interrupts:0: [26, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8572-guts']
>> arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /soc8572@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: pcie@ffe08000: pcie@0:interrupts:0:0: 24 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: pcie@ffe08000: pcie@0:interrupts:0: [24, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /pcie@ffe08000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: isa@1e: Unevaluated properties are not allowed ('#interrupt-cells', 'interrupt-parent', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/isa/isa-bridge.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/interrupt-controller@20: failed to match any schema with compatible: ['chrp,iic']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/keyboard@0: failed to match any schema with compatible: ['pnpPNP,303']
   arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/mouse@1: failed to match any schema with compatible: ['pnpPNP,f03']
--
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8572-guts']
>> arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /soc8572@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: pcie@fffe08000: pcie@0:interrupts:0:0: 24 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: pcie@fffe08000: pcie@0:interrupts:0: [24, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /pcie@fffe08000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: isa@1e: Unevaluated properties are not allowed ('#interrupt-cells', 'interrupt-parent', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/isa/isa-bridge.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /pcie@fffe08000/pcie@0/uli1575@0/isa@1e/interrupt-controller@20: failed to match any schema with compatible: ['chrp,iic']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /pcie@fffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/keyboard@0: failed to match any schema with compatible: ['pnpPNP,303']
   arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: /pcie@fffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/mouse@1: failed to match any schema with compatible: ['pnpPNP,f03']
--
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8572-guts']
>> arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /soc8572@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: pcie@ffe08000: pcie@0:interrupts:0:0: 24 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: pcie@ffe08000: pcie@0:interrupts:0: [24, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /pcie@ffe08000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: isa@1e: Unevaluated properties are not allowed ('#interrupt-cells', 'interrupt-parent', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/isa/isa-bridge.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/interrupt-controller@20: failed to match any schema with compatible: ['chrp,iic']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/keyboard@0: failed to match any schema with compatible: ['pnpPNP,303']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/mouse@1: failed to match any schema with compatible: ['pnpPNP,f03']
--
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8572-guts']
>> arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /soc8572@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: pcie@ffe08000: pcie@0:interrupts:0:0: 24 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: pcie@ffe08000: pcie@0:interrupts:0: [24, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /pcie@ffe08000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/interrupt-controller@20: failed to match any schema with compatible: ['chrp,iic']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/keyboard@0: failed to match any schema with compatible: ['pnpPNP,303']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/i8042@60/mouse@1: failed to match any schema with compatible: ['pnpPNP,f03']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: /pcie@ffe08000/pcie@0/uli1575@0/isa@1e/rtc@70: failed to match any schema with compatible: ['pnpPNP,b00']
   arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 25 is not one of [1, 2, 3, 4]
--
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/crypto@30000/jr@1000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/crypto@30000/jr@2000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/crypto@30000/jr@3000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/crypto@30000/jr@4000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1010-guts']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: pcie@ffe09000: pcie@0:interrupts: [[16], [2], [0], [0]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/crypto@30000/jr@1000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/crypto@30000/jr@2000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/crypto@30000/jr@3000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/crypto@30000/jr@4000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1010-guts']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: pcie@fffe09000: pcie@0:interrupts: [[16], [2], [0], [0]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/crypto@30000/jr@1000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/crypto@30000/jr@2000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/crypto@30000/jr@3000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/crypto@30000/jr@4000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1010-guts']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: pcie@ffe09000: pcie@0:interrupts: [[16], [2], [0], [0]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/crypto@30000/jr@1000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/crypto@30000/jr@2000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/crypto@30000/jr@3000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/crypto@30000/jr@4000: failed to match any schema with compatible: ['fsl,sec-v4.4-job-ring', 'fsl,sec-v4.0-job-ring']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1010-guts']
>> arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: pcie@fffe09000: pcie@0:interrupts: [[16], [2], [0], [0]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,p1010-pcie', 'fsl,qoriq-pcie-v2.3']
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb-pd.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020rdb_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/mdio@26000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1021-guts']
>> arch/powerpc/boot/dts/fsl/p1021mds.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021mds.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1021-guts']
>> arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1021-guts']
>> arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/mdio@24000: failed to match any schema with compatible: ['fsl,etsec2-mdio']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/ethernet@b0000: failed to match any schema with compatible: ['fsl,etsec2']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/mdio@25000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/ethernet@b1000: failed to match any schema with compatible: ['fsl,etsec2']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1022-guts']
>> arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /soc@ffe00000/ptp_clock@b0e00: failed to match any schema with compatible: ['fsl,etsec-ptp']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022ds_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/mdio@24000: failed to match any schema with compatible: ['fsl,etsec2-mdio']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/ethernet@b0000: failed to match any schema with compatible: ['fsl,etsec2']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/mdio@25000: failed to match any schema with compatible: ['fsl,etsec2-tbi']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/ethernet@b1000: failed to match any schema with compatible: ['fsl,etsec2']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1022-guts']
>> arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /soc@fffe00000/ptp_clock@b0e00: failed to match any schema with compatible: ['fsl,etsec-ptp']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022ds_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
--
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1022-guts']
>> arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
>> arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,p1022-pmc', 'fsl,mpc8536-pmc', 'fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1022rdk.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_32b.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1020-guts']
>> arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1024rdb_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1021-guts']
>> arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_32b.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1021-guts']
>> arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /soc@fffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: pcie@fffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /pcie@fffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: pcie@fffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025rdb_36b.dtb: /pcie@fffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/crypto@30000: failed to match any schema with compatible: ['fsl,sec3.3', 'fsl,sec3.1', 'fsl,sec3.0', 'fsl,sec2.4', 'fsl,sec2.2', 'fsl,sec2.1', 'fsl,sec2.0']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/timer@42100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,p1021-guts']
>> arch/powerpc/boot/dts/fsl/p1025twr.dtb: /soc@ffe00000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: pcie@ffe09000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: pcie@ffe09000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /pcie@ffe09000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: pcie@ffe0a000: pcie@0:interrupts:0:0: 16 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: pcie@ffe0a000: pcie@0:interrupts:0: [16, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/p1025twr.dtb: /pcie@ffe0a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
--
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/pic@40000: failed to match any schema with compatible: ['fsl,mpic']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/timer@41100: failed to match any schema with compatible: ['fsl,mpic-global-timer']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/message@41400: failed to match any schema with compatible: ['fsl,mpic-v3.1-msgr']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/msi@41600: failed to match any schema with compatible: ['fsl,mpic-msi']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/rmu@d3000: failed to match any schema with compatible: ['fsl,srio-rmu']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/rmu@d3000/message-unit@0: failed to match any schema with compatible: ['fsl,srio-msg-unit']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/rmu@d3000/message-unit@100: failed to match any schema with compatible: ['fsl,srio-msg-unit']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/rmu@d3000/doorbell-unit@400: failed to match any schema with compatible: ['fsl,srio-dbell-unit']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/rmu@d3000/port-write-unit@4e0: failed to match any schema with compatible: ['fsl,srio-port-write-unit']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/global-utilities@e0000: failed to match any schema with compatible: ['fsl,mpc8548-guts']
>> arch/powerpc/boot/dts/fsl/ppa8548.dtb: /soc8548@fe0000000/power@e0070: failed to match any schema with compatible: ['fsl,mpc8548-pmc']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /pci@fe0008000: failed to match any schema with compatible: ['fsl,mpc8540-pcix', 'fsl,mpc8540-pci']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /pci@fe0008000: failed to match any schema with compatible: ['fsl,mpc8540-pcix', 'fsl,mpc8540-pci']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /pci@fe0009000: failed to match any schema with compatible: ['fsl,mpc8540-pci']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: pcie@fe000a000: pcie@0:interrupts:0:0: 26 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: pcie@fe000a000: pcie@0:interrupts:0: [26, 2, 0, 0] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /pcie@fe000a000: failed to match any schema with compatible: ['fsl,mpc8548-pcie']
   arch/powerpc/boot/dts/fsl/ppa8548.dtb: /rapidio@fe00c0000: failed to match any schema with compatible: ['fsl,srio']
--
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /reserved-memory/bman-fbpr: failed to match any schema with compatible: ['fsl,bman-fbpr']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /reserved-memory/qman-fqd: failed to match any schema with compatible: ['fsl,qman-fqd']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /reserved-memory/qman-pfdr: failed to match any schema with compatible: ['fsl,qman-pfdr']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: localbus@ffe124000: $nodename:0: 'localbus@ffe124000' does not match '^memory-controller@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: localbus@ffe124000: compatible: ['fsl,ifc', 'simple-bus'] is too long
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /localbus@ffe124000/nand@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /localbus@ffe124000/board-control@2,0: failed to match any schema with compatible: ['fsl,t1024-cpld', 'fsl,deepsleep-cpld']
>> arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /localbus@ffe124000/board-control@2,0: failed to match any schema with compatible: ['fsl,t1024-cpld', 'fsl,deepsleep-cpld']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000: failed to match any schema with compatible: ['fsl,dcsr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1023-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1023-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1023-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1023-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-nxc@2000: failed to match any schema with compatible: ['fsl,dcsr-nxc']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-corenet: failed to match any schema with compatible: ['fsl,dcsr-corenet']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-ocn@11000: failed to match any schema with compatible: ['fsl,t1023-dcsr-ocn', 'fsl,dcsr-ocn']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-ocn@11000: failed to match any schema with compatible: ['fsl,t1023-dcsr-ocn', 'fsl,dcsr-ocn']
   arch/powerpc/boot/dts/fsl/t1024rdb.dtb: /dcsr@f00000000/dcsr-ddr@12000: failed to match any schema with compatible: ['fsl,dcsr-ddr']
--
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /reserved-memory/bman-fbpr: failed to match any schema with compatible: ['fsl,bman-fbpr']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /reserved-memory/qman-fqd: failed to match any schema with compatible: ['fsl,qman-fqd']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /reserved-memory/qman-pfdr: failed to match any schema with compatible: ['fsl,qman-pfdr']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: localbus@ffe124000: $nodename:0: 'localbus@ffe124000' does not match '^memory-controller@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: localbus@ffe124000: compatible: ['fsl,ifc', 'simple-bus'] is too long
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /localbus@ffe124000/nand@2,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
>> arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000: failed to match any schema with compatible: ['fsl,dcsr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-nxc@2000: failed to match any schema with compatible: ['fsl,dcsr-nxc']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-corenet: failed to match any schema with compatible: ['fsl,dcsr-corenet']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: /dcsr@f00000000/dcsr-ocn@11000: failed to match any schema with compatible: ['fsl,t1040-dcsr-ocn', 'fsl,dcsr-ocn']
--
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /reserved-memory/bman-fbpr: failed to match any schema with compatible: ['fsl,bman-fbpr']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /reserved-memory/qman-fqd: failed to match any schema with compatible: ['fsl,qman-fqd']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /reserved-memory/qman-pfdr: failed to match any schema with compatible: ['fsl,qman-pfdr']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: localbus@ffe124000: $nodename:0: 'localbus@ffe124000' does not match '^memory-controller@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: localbus@ffe124000: compatible: ['fsl,ifc', 'simple-bus'] is too long
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /localbus@ffe124000/nand@2,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
>> arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000: failed to match any schema with compatible: ['fsl,dcsr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-nxc@2000: failed to match any schema with compatible: ['fsl,dcsr-nxc']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-corenet: failed to match any schema with compatible: ['fsl,dcsr-corenet']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1040rdb.dtb: /dcsr@f00000000/dcsr-ocn@11000: failed to match any schema with compatible: ['fsl,t1040-dcsr-ocn', 'fsl,dcsr-ocn']
--
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /reserved-memory/bman-fbpr: failed to match any schema with compatible: ['fsl,bman-fbpr']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /reserved-memory/qman-fqd: failed to match any schema with compatible: ['fsl,qman-fqd']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /reserved-memory/qman-pfdr: failed to match any schema with compatible: ['fsl,qman-pfdr']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: localbus@ffe124000: $nodename:0: 'localbus@ffe124000' does not match '^memory-controller@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: localbus@ffe124000: compatible: ['fsl,ifc', 'simple-bus'] is too long
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /localbus@ffe124000/nand@2,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
>> arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000: failed to match any schema with compatible: ['fsl,dcsr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-nxc@2000: failed to match any schema with compatible: ['fsl,dcsr-nxc']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-corenet: failed to match any schema with compatible: ['fsl,dcsr-corenet']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1042rdb.dtb: /dcsr@f00000000/dcsr-ocn@11000: failed to match any schema with compatible: ['fsl,t1040-dcsr-ocn', 'fsl,dcsr-ocn']
--
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /reserved-memory/bman-fbpr: failed to match any schema with compatible: ['fsl,bman-fbpr']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /reserved-memory/qman-fqd: failed to match any schema with compatible: ['fsl,qman-fqd']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /reserved-memory/qman-pfdr: failed to match any schema with compatible: ['fsl,qman-pfdr']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: localbus@ffe124000: $nodename:0: 'localbus@ffe124000' does not match '^memory-controller@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: localbus@ffe124000: compatible: ['fsl,ifc', 'simple-bus'] is too long
   	from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ifc.yaml#
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /localbus@ffe124000/nand@2,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
>> arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /localbus@ffe124000/cpld@3,0: failed to match any schema with compatible: ['fsl,t104xrdb-cpld', 'fsl,deepsleep-cpld']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000: failed to match any schema with compatible: ['fsl,dcsr', 'simple-bus']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-epu@0: failed to match any schema with compatible: ['fsl,t1040-dcsr-epu', 'fsl,dcsr-epu']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-npc: failed to match any schema with compatible: ['fsl,t1040-dcsr-cnpc', 'fsl,dcsr-cnpc']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-nxc@2000: failed to match any schema with compatible: ['fsl,dcsr-nxc']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-corenet: failed to match any schema with compatible: ['fsl,dcsr-corenet']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-dpaa@9000: failed to match any schema with compatible: ['fsl,t1040-dcsr-dpaa', 'fsl,dcsr-dpaa']
   arch/powerpc/boot/dts/fsl/t1042rdb_pi.dtb: /dcsr@f00000000/dcsr-ocn@11000: failed to match any schema with compatible: ['fsl,t1040-dcsr-ocn', 'fsl,dcsr-ocn']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

