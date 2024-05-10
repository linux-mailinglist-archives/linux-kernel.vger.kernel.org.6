Return-Path: <linux-kernel+bounces-175210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17918C1C62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7731A282F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58C13BACD;
	Fri, 10 May 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diko5+C9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF433EE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307945; cv=none; b=VH10n+KOytTEfQR4/1/Yzl/d0p88uUxU29OTM2+RdlWcWuws4nKNrJu8jKTH/8hCjNg/1pExoc5IwQJKYysNV2Tm1zhqowAjyNDhG5R0PeQB5i2lxr3RimLB0gYuqviIM++BLNsbE3gVx3TZ4OtVPLlEjb8Y5qIEfZhePhDHoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307945; c=relaxed/simple;
	bh=dDEc+9JNFL+GDMtkUMUPp1i1PqkRdnKBLfi4QudkDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mItNyRqPdYOMeXucmo55wJdmpVYZIV6ykckUiuFyDRt7Sf7uRc+vQ+w/s5UtgzIVXh44C+Wyq6owfVlGqHbcQwCfB8CfDl8CMmrA/7QT8379LWrxp8r49AH5zmiegFkc3v8FdW9KIN5LC4hNi0GBgUxd7aw1REooddtd9qrqrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diko5+C9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715307943; x=1746843943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dDEc+9JNFL+GDMtkUMUPp1i1PqkRdnKBLfi4QudkDZk=;
  b=diko5+C9kZpmvfZ8J1KJl9wYeoswyyVJshdhNkcuKB4q4ISr7cACEytf
   nuvuDYoFI73XmVp+0+tDlRO3cub7JIcppsAfkiYqUHyn/rOLWMrIwcaax
   QSRwrV7eHt9bYVC5Ff2WxlVulidoqwTB+zoBU7040tWVP75PU3dpP155z
   kIL6M1AJV1CJnn6V5nLJ2RjaKgpD6j9SyoRaPAHjR58K9QZVRnjoB30/m
   g6I7pbI4C1HA7IyLyZnD5vlESHAIohL5uyU4Q2WAOgeGdnvGUkFo4MmbN
   tnFOrHgKFgE/YRrnFQd0LBU2gW+e0qdA7/a5TkUTs69EINTHP7H1Boc+n
   A==;
X-CSE-ConnectionGUID: z34owV+yQ/ihd94/GTY5dw==
X-CSE-MsgGUID: gQNWN01uRTu/ljZ1hMBCTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22419452"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="22419452"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 19:25:43 -0700
X-CSE-ConnectionGUID: CHFvP6ldTi6tTvwkocFQWA==
X-CSE-MsgGUID: fpig2/DWTOO7PAWS70Y6mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="30021087"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 May 2024 19:25:40 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5Fx4-0005dL-0y;
	Fri, 10 May 2024 02:25:38 +0000
Date: Fri, 10 May 2024 10:24:56 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: WARNING: modpost: "__udelay" [drivers/rtc/rtc-ma35d1.ko] has no CRC!
Message-ID: <202405101010.dqQ6WMNp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacky,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   448b3fe5a0eab5b625a7e15c67c7972169e47ff8
commit: dc0684adf3b6be6b20fec9295027980021d30353 rtc: Add driver for Nuvoton ma35d1 rtc controller
date:   5 months ago
config: sparc-randconfig-r051-20240309 (https://download.01.org/0day-ci/archive/20240510/202405101010.dqQ6WMNp-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101010.dqQ6WMNp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101010.dqQ6WMNp-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/xgene-rng.ko] has no CRC!
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
WARNING: modpost: "__udelay" [drivers/net/ethernet/altera/altera_tse.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/dnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/korina.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/arcnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com90xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com90io.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com20020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/fddi/defxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/firewire/firewire-ohci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/hd44780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-am335x-control.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns-usb-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/oxu210hp-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp1362-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-pci-renesas.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-fsl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ssb-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/c67x00/c67x00.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/misc/onboard_usb_hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_msm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/renesas_usb3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/renesas_usbf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/udc-xilinx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/aspeed-vhub/aspeed-vhub.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-imxdi.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/rtc/rtc-ma35d1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msc313.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-bit.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-altera.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-bcm-iproc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-davinci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-owl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pxa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-qup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-rk3x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-sh_mobile.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-stm32f7-drv.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-synquacer.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-synquacer.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/gpio-ir-tx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/rc/gpio-ir-tx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/ir-hix5hd2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/serial_ir.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/thermal/k3_j72xx_bandgap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-s3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/alcor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/mtk-sd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/davinci_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/renesas_sdhi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/dw_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sh_mmcif.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sunxi-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/toshsd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-esdhc-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-bcm-kona.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-xenon-driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/iio/impedance-analyzer/ad5933.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rtl8192e/rtl8192e/r8192e_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rtl8723bs/r8723bs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rts5208/rts5208.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mailbox/sprd-mailbox.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/memory/tegra/tegra30-emc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/memory/tegra/tegra210-emc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/bcm_iproc_adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/imx8qxp-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/mt6577_auxadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/meson_saradc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/rcar-gyroadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/sun4i-gpadc-iio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads7924.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem_meson_mx_efuse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem-mxs-ocotp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem-rockchip-otp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ingenic/ingenic_nand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/davinci_nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_slc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_mlc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/txx9ndfmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/qcom_nandc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/qcom_nandc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/stm32_fmc2_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pcmcia/pcmcia_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/olpc_apsp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/imx_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/matrix_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/pmic8xxx-keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/samsung-keypad.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

