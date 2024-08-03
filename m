Return-Path: <linux-kernel+bounces-273584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD073946AF4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 21:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C006281ECC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03C1CFB9;
	Sat,  3 Aug 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bstBDpqF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650131B94F
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722712339; cv=none; b=E4TxptEGvmiwk4BLpQ1jZmsMBD1e34AIDcJHUhYLxY/uuFc/EhNJ1VKcQVbwWdK0yoZURJ8/4gtYp9lEGykQzDovcgmjhbHDhr5BCWYiFc4ykBRFeE7JwaOTY41crwaJ1kZe1NSHJfAIWTYB1ewGJpZxBqFPHgO4M/ZIf8lZiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722712339; c=relaxed/simple;
	bh=j0XCYJUkQ27QOKqepw8d573zOaisTMn7DfqFCZinWTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=APvqRRsf2CRYRvCfIlbHJzs6tl7qLHy5v7/RaEVsrhO8vq99wmxh10iICEztEfJMd4PISbUX7rwK1yww193kxAWcXusitUxQYH3h0giq5bdJSpVAeDn1+Z3WRt+kH6e2t/5rcIOLU1C2Zi2/kYYFv6oXeJBKH1Pz+IuKEmqnsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bstBDpqF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722712337; x=1754248337;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j0XCYJUkQ27QOKqepw8d573zOaisTMn7DfqFCZinWTs=;
  b=bstBDpqFO8HzAmoei6DSRYB7IQ0ZVluqdLXvHWuIUvm1X+f0Aq6We2eQ
   0V7TwjZAaHkggI4KOKxnYrcSneTlQqt7JtjV7ImU7COY/WIkMyMAHXSag
   aXtk6Ie1aCqpjwtQ2AdHcK0//zDjq88Cztem9ZcqTQmdFimvGfdFYjbSk
   8ibyJJYc2udmX/kica3eIcm1b6bUXi8zdKz4M01Wa88+XXIo4hjgnwpqX
   kuzvGGo4AboYtsAIEBTx9Yj1YV6l31udQEA/eRuzdN+JljDFL07zqF7IM
   lOdtEcJCHqe8aOFQ2ckoZ2U2JAyyiPyFCsBpiH5I0hwtEuJSpmQvtLl45
   Q==;
X-CSE-ConnectionGUID: uGgdI6AzQq+hg7aiC+Q48A==
X-CSE-MsgGUID: yY0X3WbsSSWV1Cmpmss+vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="20557658"
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="20557658"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 12:12:16 -0700
X-CSE-ConnectionGUID: JjnVZuvrTOiQuMv57CPmdQ==
X-CSE-MsgGUID: +7KoKhdnSZ6VBerg4BzgKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="56511172"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Aug 2024 12:12:14 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saKAl-0000rE-32;
	Sat, 03 Aug 2024 19:12:11 +0000
Date: Sun, 4 Aug 2024 03:11:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__popcountsi2"
 [drivers/comedi/drivers/adl_pci9111.ko] undefined!
Message-ID: <202408040337.zq5qZ5bA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ian,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17712b7ea0756799635ba159cc773082230ed028
commit: 98a15816636044f25be4644db2a3e09fad68aaf7 Revert "comedi: add HAS_IOPORT dependencies"
date:   11 months ago
config: arm-randconfig-r054-20240802 (https://download.01.org/0day-ci/archive/20240804/202408040337.zq5qZ5bA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408040337.zq5qZ5bA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408040337.zq5qZ5bA-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-v3s-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-de2-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun9i-a80-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun9i-a80-de-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/imx/soc-imx8m.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/qcom/spm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xenbus/xenbus_probe_frontend.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-evtchn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-privcmd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/reset/hisilicon/hi6220_reset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/ttynull.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ppdev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/ssbi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/dax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/device_dax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-omap2-mcspi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/mdio/mdio-bitbang.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/ezchip/nps_enet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/dummy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arcnet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/rfc1201.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/rfc1051.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rawmode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/fddi/skfp/skfp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/plip/plip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/slip/slip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/vivaldi-fmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/pci/ttpci/budget-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/mb86a16.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcpci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/avmfritz.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNinfineon.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNipac.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/mISDN_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/mISDN_dsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_emmc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/of_mmc_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/coreboot_table.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/vpd-sysfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-log.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-loopback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-power-supply.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-vibrator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mm-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mp-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/qcom/interconnect_qcom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/qcom/icc-rpmh.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_cif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_aec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_netx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_mf624.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/p8022.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/psnap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/fddi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/stp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_ingress.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_tbf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_multiq.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_skbprio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_taprio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/cls_basic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/cls_cgroup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_meta.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netlink/netlink_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/bridge.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/chnl_net.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/vmw_vsock/vsock_diag.o
ERROR: modpost: "__popcountsi2" [drivers/input/keyboard/pmic8xxx-keypad.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/addi_apci_3120.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/adl_pci9111.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/adv_pci1710.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/amplc_pci224.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/amplc_pci230.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/cb_pcidas64.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/cb_pcidas.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/ni_pcimio.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/rtd520.ko] undefined!
WARNING: modpost: suppressed 6 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

