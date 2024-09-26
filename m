Return-Path: <linux-kernel+bounces-339896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4766986BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59054283A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18AA1531D5;
	Thu, 26 Sep 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+hfC4gM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FE17C69
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727326629; cv=none; b=irTpMTNoAEq8ZHCyEOBZUIXcAb7b2GHO1oQPlJkALjQ5U+sAhoYis1v57HW3YfHnvKRF7mjITKnIsWP695WTBQuLuBNQWRe9dHSp5uVKwBr31CNcQj+P+0cGT8ZMjokFy4p843tGli81UOTNeAR3fonkwsvOlxT23GltMafgI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727326629; c=relaxed/simple;
	bh=uHxyw1I72eZHyAijkJ2XmK992TAvmMhsQOyGlMXhcMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LIPTqvFAYSIBTQzLQ/mw3Z89Y37zVYlAkXw5RmRU4ILTGbrXDdX09OyRYMxlAjBiMMnStyhFSdzfAB37ggWinr7WuGH/pUPHc6r1bcfimvHSUwFOh5iLDKWWkOK5hO0Icgr3958evRsrQXvYSOTkXy7CfYBmkAgbU1IYXFAW8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+hfC4gM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727326627; x=1758862627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uHxyw1I72eZHyAijkJ2XmK992TAvmMhsQOyGlMXhcMs=;
  b=b+hfC4gMwgnvHAdkionyO2g0ovDYb8U2Wo4USkdCqPTTrNAOE2s5Fi/L
   m5nGh8//sE9ktSBmqoGN9OC+KuCAylA7H71JSSKl1CVS+Z7ypH+Qjzi5u
   prZ05al0JW58LSMWT0z80aJc/ER5o6vk8vhb1CRhtaczR+2jQgsS5Grk9
   SHcaerqnmUjo+FNmJgRxzBPRcX42yZ4FiiwmuyyYKCMrw86wYLkISb8rX
   2546jHYfZ6Ve7MnfRlIB5YyYwPEqytXkUmFHcVBXr23ukiyU0MtblMrkP
   RpPlC1QQx0KA/Fq0mvD3u5+5g1W4D7vp2PvvqGyjLHuqtkQ4KsIxP8iHF
   A==;
X-CSE-ConnectionGUID: zPLgHHPtRuGpFksYD6hVpw==
X-CSE-MsgGUID: mGfOeFNoTU60xRchBUZR8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26271167"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26271167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 21:56:55 -0700
X-CSE-ConnectionGUID: 1YPjhW/uTq6r3OVDPBN6Nw==
X-CSE-MsgGUID: NMS7b2NtRFu6O8Xsrc9W0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="76381071"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2024 21:56:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stgYd-000KH5-3A;
	Thu, 26 Sep 2024 04:56:51 +0000
Date: Thu, 26 Sep 2024 12:56:10 +0800
From: kernel test robot <lkp@intel.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: ERROR: modpost: "_restgpr1_16"
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
Message-ID: <202409261209.7fxaYjyS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aurabindo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11a299a7933e03c83818b431e6a1c53ad387423d
commit: 00c391102abc13763e2bfc90e05503109b19f074 drm/amd/display: Add misc DC changes for DCN401
date:   5 months ago
config: powerpc64-randconfig-001-20240926 (https://download.01.org/0day-ci/archive/20240926/202409261209.7fxaYjyS-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261209.7fxaYjyS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261209.7fxaYjyS-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-pcf857x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-pf-stub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt6779.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt6779-mm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt6779-cam.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt6779-vdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt6779-mfg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt6779-aud.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt2712-apmixedsys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt2712.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt2712-jpgdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt2712-mfg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt2712-vdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt7622-eth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt7988-apmixed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt7988-topckgen.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt7988-infracfg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8167-aud.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8167-vdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8186-img.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8186-ipe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8186-vdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8186-wpe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-apmixedsys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-topckgen.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-peri_ao.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-infra_ao.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-adsp_audio26m.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-vdo0.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8188-vdo1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-aud.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-mdp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-mfg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-mm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-msdc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8192-scp_adsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8365-apmixedsys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8365.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8365-apu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8365-mm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/mediatek/clk-mt8365-vdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/qcom/videocc-sdm845.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/suniv-f1c100s-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun20i-d1-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-a100-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-h6-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun6i-a31-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-v3s-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-qmgr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-npe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/mediatek/mtk-cmdq-helper.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_ring.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/reset/hisilicon/hi6220_reset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sil-sii8620.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sii9234.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/cirrus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_panel_orientation_quirks.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/brd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/null_blk/null_blk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/rtc-twl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ali1563.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-qup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_emmc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/blink/leds-bcm63138.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds-rt4505.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/framebuffer-coreboot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/cbmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mp-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hte/hte-tegra194-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/drivers/snd-pcmtest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/ac97_bus.o
>> ERROR: modpost: "_restgpr1_16" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_savegpr1_27" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_restfpr_16" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savefpr_29" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savefpr_21" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savefpr_25" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_restfpr_21" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savegpr1_15" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_restfpr_29" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savefpr_16" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
WARNING: modpost: suppressed 56 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

