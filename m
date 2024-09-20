Return-Path: <linux-kernel+bounces-334029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9FA97D18F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F94D283D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5346444;
	Fri, 20 Sep 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYAaL2QK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E115558BA
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816410; cv=none; b=eKswhbNKTFOEyDQ04Fz1bL99XN5LepMxoFYXTn1rp9bJJ73wlkqbzRVySojYvdIERuLd94sIKL+OVToMti653tEztF16JlM+HPstpLZfrpbOZIT8/wnem5DS9Nvs/x2G0DtBeRhnJkQ5KTChNdgMr2MJ+hOF/e5knONA5E5x1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816410; c=relaxed/simple;
	bh=lERNyCMXaJXsZZN2g+DB+d8ZQHwgDu9aViBggTO4IGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aG8u52BwucUzjpcbjvqt8JBO0RS9O10K3vDWLKabnweVC2yL5mkMGmPlpKMEnVe74fPOrUPwwTi2M0vnY/QFGeXRHFLq9qyuRQ4oQ+3QoGk+2C9J0iCAMAEyumA8KEC36Zj3cRmvmtRuXVOyG62VGF/FLPF26ytvY0hvpwenfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYAaL2QK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726816408; x=1758352408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lERNyCMXaJXsZZN2g+DB+d8ZQHwgDu9aViBggTO4IGw=;
  b=kYAaL2QKyjIRNXBVz7E2YilgOsSE7IOVJ2xE30yupnOLYvvb+M4bpGE/
   573NRTEyVI6toP3LnQTVoQZ1jFGcihF/A9sF3UOxt5N6MAstuYzvT4BJB
   luNHQKYubPrYIgPsij7ulxR4lEdI88mIlsZDkKIzdb5l3PSNacBu5bNAH
   r56KCWeKVm4uzd5a8ROpiPlUW9VHY1Z0EZLVi0sjRLrCRyAFi4/OE/VfZ
   HtPkp4nOvvIknqy2iD+qYBidZUtovt2dFf5ioQu3gKAnylAiqLqy1RlKn
   m9iWx7L5WUB0ioS8mhpC4LHEKbiHN1U6zYiVraOI97UDsbT7Vb0RMXTd4
   g==;
X-CSE-ConnectionGUID: zwNkKb76SpWI+QvbeFMVwg==
X-CSE-MsgGUID: MgpRmyaIT0W0SE1YQ2lshg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13604558"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="13604558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 00:13:27 -0700
X-CSE-ConnectionGUID: w6ijxSsJQUW2w+nRBfCTqg==
X-CSE-MsgGUID: bAKKKZ64S9aL8Sx38v54sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70513843"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Sep 2024 00:13:25 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srXpS-000E4M-32;
	Fri, 20 Sep 2024 07:13:22 +0000
Date: Fri, 20 Sep 2024 15:13:10 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: arch/mips/boot/dts/ingenic/cu1000-neo.dtb: mac-phy-ctrl@e8:
 compatible: ['syscon'] is too short
Message-ID: <202409201550.YEpb0b6C-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   baeb9a7d8b60b021d907127509c44507539c15e5
commit: f97b0435c8572b16305d68cfc14ddc901878a9e7 dt-bindings: mfd: syscon: Split and enforce documenting MFD children
date:   3 months ago
config: mips-randconfig-051-20240920 (https://download.01.org/0day-ci/archive/20240920/202409201550.YEpb0b6C-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
dtschema version: 2024.10.dev4+g577c1ab
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201550.YEpb0b6C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201550.YEpb0b6C-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: x1000-cgu@10000000: mac-phy-ctrl@e8: 'mode-reg' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/ingenic,cgu.yaml#
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: x1000-cgu@10000000: mac-phy-ctrl@e8: 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/ingenic,cgu.yaml#
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: x1000-cgu@10000000: 'rng@d8' does not match any of the regexes: '^mac-phy-ctrl@[a-f0-9]+$', '^usb-phy@[a-f0-9]+$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/clock/ingenic,cgu.yaml#
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: usb-phy@3c: 'vcc-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/phy/ingenic,phy-usb.yaml#
>> arch/mips/boot/dts/ingenic/cu1000-neo.dtb: mac-phy-ctrl@e8: compatible: ['syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: timer@10002000: watchdog@0: Unevaluated properties are not allowed ('compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: timer@10002000: watchdog@0:compatible: 'oneOf' conditional failed, one must be fixed:
   	['ingenic,x1000-watchdog', 'ingenic,jz4780-watchdog'] is too long
   	'ingenic,x1000-watchdog' is not one of ['ingenic,jz4740-watchdog', 'ingenic,jz4780-watchdog']
   	'ingenic,x1000-watchdog' is not one of ['ingenic,jz4770-watchdog', 'ingenic,jz4760b-watchdog', 'ingenic,jz4760-watchdog', 'ingenic,jz4725b-watchdog']
   	'ingenic,jz4740-watchdog' was expected
   	from schema $id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
   arch/mips/boot/dts/ingenic/cu1000-neo.dtb: timer@10002000: pwm@40: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

