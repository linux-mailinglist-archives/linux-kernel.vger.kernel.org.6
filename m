Return-Path: <linux-kernel+bounces-209238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B4902F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444291F23485
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3393916FF39;
	Tue, 11 Jun 2024 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJfBtdjF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE816F915
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078829; cv=none; b=dbyTpj/gFmB0sFfyTbzgiNsGqhG8xqiWJCDwfrLdnyyhZdA/fIFhYAGseqroEYqBfbKxpK3/QKPm9reKLLdgE5Tsux6UgSAzLleA/2IccIE2EQnebawxVKUD3IBwSHXqXvkXfDh60NEPTRfqz5S0gu5nK7G7xh0RkGOEdwl48qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078829; c=relaxed/simple;
	bh=382c2n/oqBfIXSeCvbK2QkQWCsbMu1v407p5wGZs8i4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I3vEEt/oI93Rrtdl4/TDbMryGCCb28nuUWWG0WJ8fGrTaIqCVJaMZiO3BH9As5fAJAk5v++H7Ohva1OvQY2+dTUs9KzjYlABPjAmh3zOxvh/TcJffSP/MqBHsTezO73KmAjla36+YE8iO44+J2NNPyOrp/LWX306fFoDk8Fq1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJfBtdjF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718078827; x=1749614827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=382c2n/oqBfIXSeCvbK2QkQWCsbMu1v407p5wGZs8i4=;
  b=HJfBtdjFxWFLm4FyUXFCtHnhFhwKu6BOWrX35AsML2PksxnwQfFZ39XT
   CTHM8dobQyVBoXm5ExBUPD5ZlLlcwoOKZS3o75N8twsyHnAI3ewoSwr3/
   HZip8I9yPH7ykySgLa23vgWuYcymGIqJ0z5DgNUvb5dQFRQxebJ3hj3O7
   0kVMo3i2w1uD8pfc41b4adW100ltuQmbabq5pJroYnr0dQzWIun4uo/ok
   3OxnDcuRGWTQg4lIkVdsYE2FA/iGSaTHhfUHPd/DtIFwgPtxYLvqk5SP7
   f+RviPzvARC5YRDeoWDRxLAUpJGn+TMnIPlDIoNfq7PElkYmH8ju11dg5
   Q==;
X-CSE-ConnectionGUID: NMZwc2teTvu2yb4lo5A1Uw==
X-CSE-MsgGUID: eDokRuQGSNGihzIqalZWbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14894104"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14894104"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 21:07:06 -0700
X-CSE-ConnectionGUID: IkouQQR4Tz2q+m2ryFpH/g==
X-CSE-MsgGUID: nziitK3MQo68nLy6W/4PNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39853709"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2024 21:07:05 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGsmk-0002nI-37;
	Tue, 11 Jun 2024 04:07:02 +0000
Date: Tue, 11 Jun 2024 12:06:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bingbu Cao <bingbu.cao@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Andreas Helbech Kleist <andreaskleist@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: ERROR: modpost: "i2c_acpi_new_device_by_fwnode"
 [drivers/media/pci/intel/ipu-bridge.ko] undefined!
Message-ID: <202406111229.jRCzCI7H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   83a7eefedc9b56fe7bfeff13b6c7356688ffa670
commit: c70281cc83d666d8c064b4c82cc94b6dc9e9f310 media: intel/ipu6: add Kconfig and Makefile
date:   6 weeks ago
config: x86_64-randconfig-016-20240611 (https://download.01.org/0day-ci/archive/20240611/202406111229.jRCzCI7H-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111229.jRCzCI7H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111229.jRCzCI7H-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp1255.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-9.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-13.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-14.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-15.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-r.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-ru.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-croatian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-cyrillic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_ucs2_utils.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/bcachefs/mean_and_variance_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_misc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/cramfs/cramfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/isofs/isofs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/smb/common/cifs_arc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/smb/common/cifs_md4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ufs/ufs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/efs/efs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in block/t10-pi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-example-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libdes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_helpers_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hexdump.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/find_bit_benchmark.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dhry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cpumask_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sysctl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hash.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ida.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_list_sort.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_rhashtable.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sort.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bitmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_uuid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_xarray.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_maple_tree.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kprobes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ref_tracker.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_fpu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/atomic64_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/list-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/hashtable_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_linear_ranges.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bits.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cmdline_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/memcpy_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/is_signed_type_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/overflow_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/stackinit_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/fortify_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/strcat_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/strscpy_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/platform_profile.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-fractional-divider_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/ttynull.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/goldfish.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/tlclk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-raw-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/brd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/loop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/intel_soc_pmic_bxtwc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/dax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-altera-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/firewire-uapi-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/matrix-keymap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/tests/input_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-smartconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/wireless-hotkey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/libnvdimm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_pmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_e820.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
>> ERROR: modpost: "i2c_acpi_new_device_by_fwnode" [drivers/media/pci/intel/ipu-bridge.ko] undefined!
>> ERROR: modpost: "i2c_find_device_by_fwnode" [drivers/media/pci/intel/ipu-bridge.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IPU_BRIDGE
   Depends on [n]: MEDIA_SUPPORT [=m] && PCI [=y] && MEDIA_PCI_SUPPORT [=y] && I2C [=n] && ACPI [=y]
   Selected by [m]:
   - VIDEO_INTEL_IPU6 [=m] && MEDIA_SUPPORT [=m] && PCI [=y] && MEDIA_PCI_SUPPORT [=y] && (ACPI [=y] || COMPILE_TEST [=n]) && VIDEO_DEV [=m] && X86 [=y] && X86_64 [=y] && HAS_DMA [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

