Return-Path: <linux-kernel+bounces-273945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4C946FFD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102E41F2137F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877313541B;
	Sun,  4 Aug 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5suyyH6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB698174E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791662; cv=none; b=Y0e+EndCJq3s0DpGukkSCfl2AhNZGiREmlEnYBmtzNvKKULMCbXposB6yei8XJXv34mx6sDR3vdyj1+hOm4ljJlPw28n4tKprXukedT3val4aVb1J+TjSYQAhueJa9XqacQKnRiJxmqkRuFZa7f/NgyQgdxgty0dm70pCeyQWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791662; c=relaxed/simple;
	bh=GMQApKlg/bFCKR7G6l3x8mkAa/Kt+X8b4GwqON/bj7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jF4yJYgomo2w8FRyHYrIh4YT6f9/UgJxtpz4lZZk8CwL2V8e0QyTsTlgMCSRU7+851xXVY5tOHjPxmIJeLiWFXdJVAu+Ucy7ey/v+G3vK+XCuZnLI2oPeXzln3oMQmhQ1caxzOgHKiKTp+3PPSa/VQPDBAT7XbDf1BHa+HM/8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5suyyH6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722791660; x=1754327660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GMQApKlg/bFCKR7G6l3x8mkAa/Kt+X8b4GwqON/bj7Y=;
  b=j5suyyH6PJI2NaICfTSLkOjua1JgkV3Pzh6GZtgr429KwBx4AoDP4+od
   5f5AP6nclYpRDeqLlb3LDDYA4qhEL3Zo2jWfK11Hzz9k959nRwJncFnZl
   8QYKAOXv8XI7Lc+XQWnHgb6lLMHjjvWsJ2P8d37GRhXmHm3eJb5tVqi6Q
   QThtYuLG9eJBxWKEm/SZAsDCdBVkdzR/qZcdbyOP0cN5Sd3WdBk0VzywL
   sqM3HQ726TKzIQ27EOCFwJcQGridhu6YGbY89e+GBfWgEV4NCmD368urA
   UJL543oT+66vqlaJpiAF2CR/8pWXetr9bX5rv20iVykhQtbKuidAoEjpQ
   g==;
X-CSE-ConnectionGUID: qL0E2jo/TQ2hndInT63E4A==
X-CSE-MsgGUID: zQHUZAeySO+85iR4B4SUlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="32124737"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="32124737"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 10:14:20 -0700
X-CSE-ConnectionGUID: 1JZYvvCgTzCWCJZmkR9Sxw==
X-CSE-MsgGUID: 0B34EsA/SwWHG9pR5X6LIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="79208047"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 04 Aug 2024 10:14:18 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saeoB-0001Ya-0a;
	Sun, 04 Aug 2024 17:14:15 +0000
Date: Mon, 5 Aug 2024 01:13:46 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: ERROR: modpost: "__popcountsi2"
 [drivers/comedi/drivers/usbduxsigma.ko] undefined!
Message-ID: <202408050106.nL2F1M8o-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17712b7ea0756799635ba159cc773082230ed028
commit: af2817229158cea7960b9132e0a8c4470ebbfef5 virtio_blk: Don't bother validating blocksize
date:   4 weeks ago
config: arm-randconfig-r113-20240803 (https://download.01.org/0day-ci/archive/20240805/202408050106.nL2F1M8o-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce: (https://download.01.org/0day-ci/archive/20240805/202408050106.nL2F1M8o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050106.nL2F1M8o-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-r.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_utf8.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-croatian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-gaelic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-greek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-iceland.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-inuit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_script.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ext4/ext4-inode-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/minix/minix.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/isofs/isofs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hfs/hfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/sysv/sysv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ufs/ufs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/encrypted-keys/encrypted-keys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/xor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libarc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libdes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/bus/vexpress-config.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/platform_lcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/vfb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/versatile/clk-vexpress-osc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_hdlc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/ttynull.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spmi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/loop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/vexpress-sysreg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x-control.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/isight_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/yurex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/vivaldi-fmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-belkin.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cherry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-emsff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-elecom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-evision.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ezkey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-vivaldi-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-keytouch.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kye.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lenovo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-magicmouse.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-mf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-monterey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-razer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-semitek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sjoy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gaff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tivo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-topseed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-xinmo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zpff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-viewsonic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-waltop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-log.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-loopback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
ERROR: modpost: "__popcountdi2" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/block/loop.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/hwtracing/intel_th/intel_th_pti.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/hsi/clients/hsi_char.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/vhost/vhost.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/comedi_test.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/usbduxfast.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/usbduxsigma.ko] undefined!
WARNING: modpost: suppressed 2 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

