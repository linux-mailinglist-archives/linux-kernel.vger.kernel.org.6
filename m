Return-Path: <linux-kernel+bounces-174111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385388C0A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C051F230BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA8A147C9F;
	Thu,  9 May 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RROAWEFi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332E1474A4
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226900; cv=none; b=dz+P5aG2U31kfDxqZhd+Bo5+Gs/8yj3FplMI/1iITP34XcEPBP4BqzWm4ZlE1x/wMvVzuRKYx9Vof4a+8NDTLu7+/fHaJiTy+bVw7ZqIABV+Tfw6Nzo4uUGLEzE/5Z/o4aLHKQ5nRK1hbIUQyES5DBmY1SsZrduUgNnSJ0zicS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226900; c=relaxed/simple;
	bh=P+rAORxq7vvZlGp2lvbH9at+/ZXUdgm3RqR6S9CnS80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TyIwuU9buSJ7QWlKOrsa/c8a7ZsXLrbn1ghvY0qRbvUvHsLrFpT8hy8l7vLGlwWn1KDcqLAe2eNRvU200GlYPvUFWvp3/jAbrUjZwfPTvR7tl45tl7T5nXYX9UTkFlCp+NzlW1QHOv2QLuW3Ow3TtZsFErWUApICfhj85AV68P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RROAWEFi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715226898; x=1746762898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P+rAORxq7vvZlGp2lvbH9at+/ZXUdgm3RqR6S9CnS80=;
  b=RROAWEFid5YG3YGD3fp6CC1Egs4YSjzIt/1Wnk5HS2Xtkb/OYB7KiG1U
   /kd/v4s+Q+2gHnOT8fvn59Emi+HT6lrw8TQ2I85y6zs995Zzy/GzmotrC
   Ag1b8wrJr9Oaf7TQ10ahvq+7VFlnfNvs+uyr4QLXDeMoBuDmcnzU1x7xr
   xUlXV+VVS68zYfiPnoI+UDcleyuNCf6jbRVgOYjPu0K+kg9EeDC3t4JpX
   mcD7NOaqHYrhF9PSiMWicleLY7HaoA/2/FlDu/hjbxyHj46DzXvJsxyjo
   II1PCK1wWrWm+EGzsHWgsYCH/WdBl7ZVkvU0gofh4XxA8l+XIyZPj16kK
   A==;
X-CSE-ConnectionGUID: 5c46rDdbSFem7r9amjU73w==
X-CSE-MsgGUID: 77cM2EpiSSKeq/Zt5dX5TQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22517241"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="22517241"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 20:54:58 -0700
X-CSE-ConnectionGUID: XWUEZN39RNCqmR3IeOiYrA==
X-CSE-MsgGUID: Iz43qB41Qu6wX21rUr5YaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="29195380"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 May 2024 20:54:56 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4urt-0004QC-1V;
	Thu, 09 May 2024 03:54:53 +0000
Date: Thu, 9 May 2024 11:54:10 +0800
From: kernel test robot <lkp@intel.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: WARNING: modpost: "__udelay" [drivers/phy/qualcomm/phy-qcom-m31.ko]
 has no CRC!
Message-ID: <202405091140.aGz4I354-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Varadarajan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   45db3ab70092637967967bfd8e6144017638563c
commit: 08e49af507017521b90940493d0fc3a190f5f69b phy: qcom: Introduce M31 USB PHY driver
date:   9 months ago
config: sparc-randconfig-r051-20240309 (https://download.01.org/0day-ci/archive/20240509/202405091140.aGz4I354-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405091140.aGz4I354-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405091140.aGz4I354-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zpff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zydacron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-bootrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-loopback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-vibrator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gbphy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-sdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/wlan-ng/prism2_usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_ccmp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_tkip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_wep.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/ingenic-adc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mp-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/brcm_u-boot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/touchscreen/cyttsp_i2c_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/matrix-keymap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/vivaldi-fmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/tests/input_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/dev_addr_lists_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/p8022.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/psnap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/fddi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/stp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netlink/netlink_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ah4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/lec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/chnl_net.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/key/af_key.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/bridge.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/kcm/kcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/tipc/diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
Is "empty_zero_page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.
Is "__udelay" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ndelay" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ashldi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ashrdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.
Is "bzero_1page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.
Is "__copy_1page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__divdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_enter" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_exit" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_try" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_write_enter" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__lshrdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__muldi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_scanf.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-axg-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-sata.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/phy/cadence/phy-cadence-torrent.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/mediatek/phy-mtk-mipi-dsi-drv.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/phy/qualcomm/phy-qcom-m31.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-typec.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/sunplus/phy-sunplus-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pinctrl/bcm/pinctrl-bcm2835.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pinctrl/qcom/pinctrl-msm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-aggregator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/dwc/pci-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pci-aardvark.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-mediatek.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-brcmstb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/matrox/matroxfb_DAC1064.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/riva/rivafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/carminefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/da8xx-fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/sprd/clk-sprd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/sunxi-ng/sunxi-ccu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/clk-cs2000-cp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/mediatek/mtk-cqdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/altera-msgdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/idma64.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/tegra210-adma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/ti-abb-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-berlin.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-imx7.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/mtk-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/parport/parport_pc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/dw-xdata-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ene-kb3930.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ssbi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/acer-ec-a500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/arcmsr/arcmsr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aacraid/aacraid.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic94xx/aic94xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/fdomain.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla1280.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/dmx3191d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esp_scsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/am53c974.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/megaraid.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sun_esp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/myrb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/ppa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/imm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/stex.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mvumi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/bcm7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/icplus.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/microchip_t1s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-ipq4019.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-moxart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-g12a.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-gxl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can_platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/flexcan/flexcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/m_can/m_can.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/adaptec/starfire.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atlx/atl1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atlx/atl2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atl1c/atl1c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb3/cxgb3.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/cisco/enic/enic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/emulex/benet/be2net.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/freescale/gianfar_driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/hisilicon/hns/hns_dsaf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mv643xx_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mvneta.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/skge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/sky2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/smsc/smsc9420.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

